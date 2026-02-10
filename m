Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B90F9EA3F30
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 10:03:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 046B88341A;
	Tue, 10 Feb 2026 11:03:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="s6ehaSyS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E56448341A; Tue, 10 Feb 2026 11:03:30 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69B528309A
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 11:03:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=phqs2Kl9gpjxl6C/+jwkQjittchWIrsVFcIW71mq2JYUwcO5KSuNC82uZHqWOUatvu6IxJ9Z6uL4T1k4vNUWSCjR+S9wSDouKO8AqeJAj2JQLpOlEasYcvTapNCjS6o9UYvDBCUFgnDKUO0XZWCTGB4Xnk/4pNgjAQPgL/WgrXkXmW9ZhNiA0GSf/v/ETUkrGzyEmX0TM6MghXSVDNYsaYKqoAd4v3OpX+xrdkH+E8QBSgEotFBhJh+xDGaX4kieZTy/fkHeG+l3JtgnppwsxwNyrCCeFKTHsx4yShgT6SYTrnJFjgRMCOhvY2gcU71SWpJloxwqsE4v+LPAJrHx+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9O9+cmgyCg0+pkJmuaPYktoN83iK9sw8uavEZp12ygs=;
 b=xp9Q0/uGiqNgtGMyZ3hxdmZrZBzPKThHcnPtf2S9ZaDxFKF9pLa2wQLrsCul/M7xMnqGdDxfXFrIbIlJwkeQ5+lW57IwLoBnpF2dq7yU9REeM9Z4t17tScITpkHty6Y69BOiL+Nmn0K5VUskncGrAzWYgU22bZu2sE5tNfV7B97/m3GLELrlB3n24Y8HL0bY+0RXHWt6HQZ+qQRBncV4+U23fZgecnMRmzQ5If8W6WOA6fuxvaqVJjxI9zsXAsmrEfLNB7ZcT86nvOREXGfGZaUphZbsehUA2o/G4MqLAPBQJ1K7W+ggsmU9fJ1zmq0+U9OWDDNzA94N9fAlyLwFBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9O9+cmgyCg0+pkJmuaPYktoN83iK9sw8uavEZp12ygs=;
 b=s6ehaSySr/tb9mD8VPB8mC2qJVU1M31vjeRekjS84N/EEaLNo2YU5+/NkiOWDSBkje1evdA/vKYzFV/Cpy9QIlRSyYnZ6i87KWUuqauGPFoB8wMH8ukTXtUz5A3N5yTZ5vjPvyzIoytDhYMcY0ESiWuGmFlYvMyUqMSyUJgS9BYK164tmTzml+GTNoU5gH1vcQrjfqlAqsRdeK15kz9TCsrBKDnGS5iHFDypO6eglBV0zZj35G18NOu5ZdKeRm93YEfTALa7sg5GutEv/NzwAiMu1f0fv22DN5fVw7obSGUr1cdG0DqG5DXOxyYtre9QJbaUhduRP9PbTunIe8inXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by AS8P195MB1287.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:3d1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 10:03:24 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::295f:9a59:b66a:621a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::295f:9a59:b66a:621a%6]) with mapi id 15.20.9587.016; Tue, 10 Feb 2026
 10:03:24 +0000
Message-ID: <4803a086-700b-462f-ae36-2fd55e9dcac2@phytec.de>
Date: Tue, 10 Feb 2026 17:02:28 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Verdin AM62/62P not booting with 42b3ee7fa524
To: Suhaas Joshi <s-joshi@ti.com>, Tom Rini <trini@konsulko.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, Anshul Dalal <anshuld@ti.com>,
 Bryan Brattlof <bb@ti.com>, u-boot@lists.denx.de, vigneshr@ti.com,
 n-francis@ti.com, s-tripathi1@ti.com, k-malarvizhi@ti.com, kamlesh@ti.com,
 vishalm@ti.com, d.schultz@phytec.de, ggiordano@phytec.com
References: <20260209083855.GA9367@francesco-nb>
 <20260209084529.GA12200@francesco-nb>
 <20260209100851.abaf46pr77uq46zi@ula0507357>
 <20260209101635.GA28492@francesco-nb> <20260209172546.GA281089@francesco-nb>
 <20260209174308.GG2603314@bill-the-cat>
 <20260209180726.GB281089@francesco-nb>
 <20260209181307.GH2603314@bill-the-cat>
 <20260210092646.w5bugrscifmsh5px@ula0507357>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20260210092646.w5bugrscifmsh5px@ula0507357>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0124.apcprd01.prod.exchangelabs.com
 (2603:1096:820:4::16) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|AS8P195MB1287:EE_
X-MS-Office365-Filtering-Correlation-Id: b38574db-4eb7-424b-54af-08de688ba12b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|1800799024|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c0hZWUdHeFVFWlcvSlhrR3lYVTNRYW5qL0ZXdnNMSFZXbW5aM05yMTE0cXUw?=
 =?utf-8?B?eEtTWUZ5dGJGZnRDVlNDRnczc00zOGoycWVOdlp3TFRVV3lrdmZnSjBycHFR?=
 =?utf-8?B?ajRWV3cvQjMzL0xUeStwR2kzMVBUODc2U05sRVVNWS9RSXBkWUZqUXBtZGQv?=
 =?utf-8?B?SFgwWkJrajQrWWhJa3NCdkxTVU9Qck15VVNNWnZrYS9wdk5qTFdORUtSNnBF?=
 =?utf-8?B?Ry9yY1hqb1o2eTZ6UU5RQXYxYVBvZVkwSEhQSTU5SmJsbkp6TjB4dC9JTS9F?=
 =?utf-8?B?TTBRcGthdTJCSlR6bFJNNXlCRTJYdG1XN05QU2xuRER6Z2I2ZEN0aWZRQlcy?=
 =?utf-8?B?UDRNMU4weGdhZ3JkUCt5VGtobDNTcjNhOGorYjVoS01nMEZzTU0rYVJTUkw1?=
 =?utf-8?B?eElic0JJeWw4YUM5RjZSdDlpZmlEVlRSRlp1VWRiUEpQMmJpUVFTdGVFSHR6?=
 =?utf-8?B?OWFOclVoNm0wYUlKTlhISW80VFMxNnMraUhOeTFadExUd2ZvZElRVDlGczJn?=
 =?utf-8?B?SzM0NWtNTXFTT1RzV0pGK3NmV05FL0JsYm13Y1Q2a0ZYV3V6Y05KdUFiVGJ4?=
 =?utf-8?B?Ly9MWm15amg3QjdwcjQ2dkVsbFkrRHNpMCtraWk0UUxiSFEvQlBxRy9oNm9r?=
 =?utf-8?B?UVEyb2hoZkJlUW5EcDNmSTgvRWQwNldFQmJKYUZOcWMyNzM1a0FHaGVUOFNo?=
 =?utf-8?B?Z2hGR0NvZnRndWxlcDdzSkNsV0YvaVB0VG82S1VLMmRsODR4OGZVRG5qamx0?=
 =?utf-8?B?RDFNT0RQNjZkbmRLbllneVcyYnFxZ1NRNEJnMi83ZzAxRWRzUTVRWnM4bWVC?=
 =?utf-8?B?SDR3YUZZL2NKUitpQlhoMk5XWENEVW93STBQRTExeWlNWG5NbEJtZW50OXpk?=
 =?utf-8?B?Vjg4S29lQWNMNFFUeURFeGxNRDAxaHpib24zb2xyMzlkSGRQQUxWOUZlU0Y4?=
 =?utf-8?B?Y0pZVUZ3SmtmaUV4OFFjSEZnMVRzbUZRajhqTGs0dzJoL1ZDQUE3VHhIUlZP?=
 =?utf-8?B?SWozYnBRVEt1Qkk1RkFiRExMUVV3WWZ4WEFtQ2MyUVltSmNNcXJxUjNkWE5s?=
 =?utf-8?B?b05xaGRCK1lrbmp3L1ZZeW8rS0V0OEFtTEN4eHYrRWFteWFUTmNoSXNpTVlD?=
 =?utf-8?B?blppZHJIcEtQM1I0QmZMS1JEM1R5WjczWkNsR0dyVEdFUStiR0kxVWpoS3k2?=
 =?utf-8?B?QTJmeW0xTHR5OGJ3ZkdlQXFWU0RaWll4dndxd1R4MEZvc0FWOGJSV215ZW05?=
 =?utf-8?B?VzJCMXhUdDZ5OGdNM3RFRzAvcE03RHV6dVRMa1BpbnY0WUFRbWg3N3VlSUE0?=
 =?utf-8?B?bi8zWmIrNUlCMnZpMUJXeUhtakRGOEUxbmxPMmxWRnkvY29XdmFqU3JXUUlL?=
 =?utf-8?B?ME5CVW1QaXd2QUx4TlJLbnNkbFFvZk9xSTFHT29rVStuZFQwTnpablk4Z0Yw?=
 =?utf-8?B?RStqekdycUk5OGlianAzc3pzL1lzLy9hdkdSU2xCMko0SkhEU0YxdzgvMDNt?=
 =?utf-8?B?MWEyRTI5Mm5VbDZnaVJEcjZndTYvd3ZSc3U5djFtcTlZdmxlZW0wV0E5STBC?=
 =?utf-8?B?OHpac1g4OUVOY2t1NTNZQlJwYldHazJzZmxWZ293MG9Renova1MyeW94QVJV?=
 =?utf-8?B?Y2NMblBMaU5ISkN4eXk1SStHZEtiUytKOUQ1L3N2OWVCRGVxQVdLZkdTSFVJ?=
 =?utf-8?B?OEFudU1sQmRoSy9XU05Od3FSM2VIaVl5L1ZscXZJcjhkSmVyTzBsUTdoaFpn?=
 =?utf-8?B?aU9aSG9PTmsyc2hPUHJZcmprU2Z6V1czWFQwT29PNkg4MnJEblVWaGRTR0Vm?=
 =?utf-8?B?aDQ0cnJXNi8zcTluWFFrU0lDbC9HRjJySmN5d0UxT1ozK2l6SHROUlhjejRm?=
 =?utf-8?B?SmI5RTZMdTBVKzhINzRVN1cxT1owOHR6bzdBcnhGTmVzdUhDdWZjWWFkVFc5?=
 =?utf-8?B?NEE2SW5MTjJNV1RaYmVtVmRyM0tXU0ozWGhmSVZONmM4eHd3SVZ2aTA1Q2NY?=
 =?utf-8?B?TTVMejRCc1dLazZiWjdvQWE4ZDhlQ0VQNzBsaUZHUEE1dk9kTzExemdsamN6?=
 =?utf-8?Q?xgxlo4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(1800799024)(376014)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnloalF0NGdidWRtRzFZRlB5akxqTDBtRFFHVXUya3Y2UDIrbHNrbEJveENM?=
 =?utf-8?B?YkxNbm1zU0ZaUXpBWGgxWE5QaGtVQW9XRjJZaEE0Y0lXQ1FlNFQrTWwyVTJy?=
 =?utf-8?B?MlhkcU5YL1NXbWU4U0orMjdrV0V2bTJxWlNvOFlQV1hUc1hJSzV6M2cxUWZv?=
 =?utf-8?B?RFN6aUtQaU14OFk1V0FCQ3B3dlFRR3Q1NHFVSS9tcTN0Z29WcmxJdVRKUkF0?=
 =?utf-8?B?MExMMUFWYmZjd0pXU2tQR1Y0RGJlVWo0bWtJNHNvdENnYUwvN0VWaU1JTTkx?=
 =?utf-8?B?SkM0THNpbDlnQUNRZDhzSWpsVTNjRVpQTnNsQ3g4TzB6ckRmSktlZlo5SlR5?=
 =?utf-8?B?aVloUWRKeFVxblliY2cvcGkyb3ViMkpRTlBWc2RZYWNtcW5Dd1ZvS2FzVUI1?=
 =?utf-8?B?OUIvTW4yUjA4SXo5THZxcUNhTzJ5VEZDVnVUZ2FBMzFkc0ZaMXlpTmhkUmhQ?=
 =?utf-8?B?K2dnRWM3Ti9JWkVYOTBNS1VZUXVTUXhWK0N0L1dhNHJFdmZRbmYzR0haZ1Er?=
 =?utf-8?B?V0Q3WlV5ZU1LUU9oWk8vc2NLdmNrUjM3VGozZ0NlaS9FL2lTVUk3VTFBZkxT?=
 =?utf-8?B?c2h3SWZJdmdLekFXaHVyaG9yNnpMUjNnZ3hZYWs1eGc1QWQyU2lqeTM3RDlD?=
 =?utf-8?B?elJDNnlzaU0rUXoxcFExeVl3bWhZbG1ocEZCY0xMNFg2eUt3R0doQjlIUE1Z?=
 =?utf-8?B?Z0VteHd0OUNyT3JPd0t6UFR4RGVXaHZ1bHhCOHd0S2YxVFFvYmplaWlKZVdv?=
 =?utf-8?B?NXN1TUdsenZZN21tcjg0aGpRQ25iN1hzNnlMYW9KSUhqL2RKaHJZUU9aaG94?=
 =?utf-8?B?dFNQdm1SSkwvK1lKTVdvdHBHai80YklXUjFlaWxabkJ1LzhwUXcvQ0lkNTFG?=
 =?utf-8?B?Y2thNjh5dWl3eXZpUmJNOWdTSzZ4RmE0WDk4enhLRDZMKzlDYlFUSmR6djls?=
 =?utf-8?B?by9hOHFyZTUzNHdqcFFUdkhlekFrK1JsVFhYMzhFTG90V3pRQk96YXBLZC93?=
 =?utf-8?B?L2hmbWZoZ2ZCM09YUVliL3pUZ2tsZXp3TnVuR09HY1hIeWgvSWE0N1pXMWpu?=
 =?utf-8?B?czB5QzZ6VEg1YmdTUDFZTDM3Tkc0QmZPVkNkSWdWRVlnY2M5dWVXcVZVUXYx?=
 =?utf-8?B?dFdyZ1dib0pXdUlobFR2SE5YT2FqMmR1TS9CNU5rRjc2aWJUa0FTaXU2VnlL?=
 =?utf-8?B?MTIyNEtqZUgwR3VPMzR4ZGVyMTBwRDg3VzBFTVpaZWdmcitwLzVmWWhuSVRM?=
 =?utf-8?B?VDU1L0MxdTVsalZTZFI1SjFXK0NrZ0pmdFRKMzFvNFBFMy9CdE94MkxZWkxn?=
 =?utf-8?B?NVdBMFg2R3U2WlRuc1ZjSXoyWmZHWm1nL0hjVWx1UEFIK0c5azYxM1dEdnNW?=
 =?utf-8?B?eXdxQnduUXNpbDlPdGlKUjU1NDBXYWMvblMzRWpwSm1yVi9ESjB4TmtqYXNG?=
 =?utf-8?B?amZLUmZGblF1ODVINmY3TGREMmMwQlE5UFFXZDFFY3N5YWtISkEvYXJkRWpj?=
 =?utf-8?B?d0pqbGdvZTFFV29XVWllcTI5c0hWdmZIditIRm5tNzZmaHdzamo2V01sVXl1?=
 =?utf-8?B?U21YcEhRZ1YwcEQ4c3JtdVE3a0dqQWNYQ1dCQjZDcUU5Q0tkN3dGZnkwQUVk?=
 =?utf-8?B?YkFqdTkyZjJwYTRqY2pHd2dtMDREU05VaW5qYmlyZElwd1hDekx2bVExc3kz?=
 =?utf-8?B?VVgwODlGbzFYdG4wYzhpQ3c1cHcrTlhlemhRbyttUE9maldFb1RoQnVYaFVt?=
 =?utf-8?B?a3J2Q3ZIUzMvMk5Da0R6eUo4QnVMaUJkWFB5bHdoMVBYT0tCbjZ0Sk10czJK?=
 =?utf-8?B?SnorZ0dpaXgzbSs5aFBSTWd6aDgvNDcreHR2R1Nmb00rbDBHeHJ3VHR3N1E4?=
 =?utf-8?B?bU81UmVtNWtKVWNPVHZHS0Npck0zdkFTSUR0U1JVejZtbm5KTExrOHlTc0pP?=
 =?utf-8?B?UUtYcjhqNjNNLytjZE9jZTF1Q2srZEZSMk8yZnVLdFJEdkluSVNaa3lBYmVG?=
 =?utf-8?B?cWV6aW1INW9oQmpROTdkWHkxR3c5NWZiZWFMajVoR3VsOGpYcHpZcWV6bjh6?=
 =?utf-8?B?WHphdEZJRms4UGFSUkoxOCtCNWE5RjByYnRaVGZUOGRIR2R1QTk4N3RycnV4?=
 =?utf-8?B?MmM0VnAzKy9tS1JoL0FCOTlzZW13VkptbUJ0TVVJN0krMVFrbUJVMjNGRjRi?=
 =?utf-8?B?WlZwbTNuZmVjellja011WGI0aGJ1aWlzZjRqS2hqNnJSSE5vb2IyUzlvMEx5?=
 =?utf-8?B?eGRUczk4eEJVMFJKOElFenhQK1FWQ1FIRVM2WDZvR0hnZFlrdnZCc2R1SEwy?=
 =?utf-8?B?NS9JeE9rbHVDeG8rcEtMNnVsaDBZd2ltalFxQ3ppK2pzYkdBa3c4Zz09?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b38574db-4eb7-424b-54af-08de688ba12b
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 10:03:24.7971 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2fbSkl+6uCQV8vsuXogABBsNwcpymR4qNhjB1274DChd3klQEA/FORPHOk+zwQJ925H7hI5QP1+ZkFBKlgkXdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB1287
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean



On 2/10/26 4:26 PM, Suhaas Joshi wrote:
> On 12:13-20260209, Tom Rini wrote:
>> On Mon, Feb 09, 2026 at 07:07:26PM +0100, Francesco Dolcini wrote:
>>> On Mon, Feb 09, 2026 at 11:43:08AM -0600, Tom Rini wrote:
>>>> On Mon, Feb 09, 2026 at 06:25:46PM +0100, Francesco Dolcini wrote:
>>>>> On Mon, Feb 09, 2026 at 11:16:35AM +0100, Francesco Dolcini wrote:
>>>>>> On Mon, Feb 09, 2026 at 03:38:51PM +0530, Suhaas Joshi wrote:
>>>>>>> On 09:45-20260209, Francesco Dolcini wrote:
>>>>>>>> + Bryan, Anshul
>>>>>>>>
>>>>>>>> On Mon, Feb 09, 2026 at 09:38:55AM +0100, Francesco Dolcini wrote:
>>>>>>>>> Verdin AM62 and AM62P are not booting anymore with U-Boot 42b3ee7fa524,
>>>>>>>>> everything was fine with b5213bbfdcb1.
>>>>>>>>>
>>>>>>>>> Looking at the commits between the two revision, I would say that the
>>>>>>>>> issue is with this series https://lore.kernel.org/all/20260127081652.506357-1-s-joshi@ti.com/
>>>>>>>>
>>>>>>>> We have also commit 3382d75f7a6c ("arch: arm: dts: k3: refactor common
>>>>>>>> nodes to k3-*-r5.dtsi") that might be the root cause for this issue.
>>>>>>>>
>>>>>>>
>>>>>>> Hi Francesco. Unfortunately, I don't have Verdin line of boards with me,
>>>>>>> so I cannot reproduce this issue. This is also why I wasn't able to test
>>>>>>> my series on my end and had requested board-specific maintainers do the
>>>>>>> same.
>>>>>>>
>>>>>>> Since I don't have the boards, could you run the following test to help
>>>>>>> us ascertain which of the 2 suspected commits actually broke the boot?
>>>>>>>
>>>>>>> * First drop my AM625 Verdin patch, and compile and copy the binaries,
>>>>>>>    and boot.
>>>>>>> * Then let my patch remain in the tree, and remove Anshul's refactor
>>>>>>>    patch, and try the same thing again.
>>>>>>>
>>>>>>> This could help us ascertain which commit broke boot, and we can try
>>>>>>> fixing from that commit.
>>>>>>
>>>>>> Sure, I can bisect it.
>>>>>>
>>>>>> Do this difference in the logs
>>>>>>
>>>>>> Failed to set clock rates for '/a53@0': -22
>>>>>>
>>>>>>    vs
>>>>>>
>>>>>> Failed to set clock rates for '/a53@0': -61
>>>>>>
>>>>>> ring any bell?
>>>>>
>>>>> The boot failure start with commit 2ffab9da9142 ("Merge patch series
>>>>> "Firewall ATF and OP-TEE memory regions in Sitara"").
>>>>>
>>>>> With commit 24338c81ec2f ("arm: dts: k3-binman: Use configs for
>>>>> ATF/OPTEE addresses") the board still boots fine.
>>>>> I have some concern that this commit is changing something, however
>>>>> CONFIG_K3_ATF_LOAD_ADDR is 0x80000000, while before in the dtsi file it
>>>>> was 0x70000000. I tried changing it back without any positive result,
>>>>> I just got an EL3 exception.
>>>>>
>>>>> Any more test I should do?
>>>>
>>>> Should I revert that firewall series, at this point?
>>>
>>> I did one more test.
>>>
>>> It seems that the issue is some interaction between the firewall series
>>> and commit 24338c81ec2f ("arm: dts: k3-binman: Use configs for ATF/OPTEE
>>> addresses").
>>
>> That's the first part of the series, and to be clear I'd revert the
>> whole series.
> 
> This series is confirmed to be working on TI boards. I just tested it
> (again) on AM62 SK. See [0] for logs.
> Verdin boards are the only ones that are reporting this issue. Is it
> alright if we revert only the two Verdin-specific commits, and let the
> rest (TI and PhyCore ones) stay as they are? The patches are pretty
> un-connected to each other.

I have not tested the patches on the phycore-soms yet.

> 
> We are working on figuring out why Verdin is seeing these issues, in the
> meantime.
> 
> [0] https://gist.github.com/jsuhaas22/b4d153eedf25e2269ddefc992c6020be
> 
> Thanks
> Suhaas
> 
>>
>>> If I keep the firewall series in, and revert 24338c81ec2f, it boots.
>>>
>>> IMO, unless we understand what is going on exactly, we should revert
>>> both.
>>>
>>> Suhaas: is current master working for you on the am62 SK or beagle play?
>>
>> These changes boot and some pytests run on am64x_evm_a53, am62x_evm_a53
>> and am62x_beagleplay_a53
>>
>> -- 
>> Tom
> 
> 

