Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E65CA0EC0
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 10:27:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B9C282F14;
	Mon, 18 Aug 2025 12:27:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="DVv+Sw0S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0279483093; Mon, 18 Aug 2025 12:27:48 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76714803DF
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 12:27:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jmjzIEvufRzy8jFPPlvpz8e6kLlRP25uYYwGtf3SGxUJ11P1isDcYaQQM2wif1tkU1bNiYbgX07gXBcKIF8I2rBBFzX2qG7/yagGO63PgrAH8JyaCjSPxTT1Wi1HX9btZ1rE5MPuiYVulzp7USfjulEJVbycrwE4+gm+u18VJkkj1dzirb6t/JRCJygyHxYTaB7v5QKjU81Tm/rgYRtAxqH+g9GV6aPjL1u9e4+3YbOk1sePNrf5ICsY95vlVPlCWtoaE5YRTOhagcfkEBF+lGshAH8hmZrRAsmJg7dJgMEItiuvpYgUjAcUhr2PO1ggJe+RHSfXTCCPnLMh/1BxXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejA76+bvLn0L7LXXdh2IIjKfIUKZSJXtJ96b6A6TNNE=;
 b=dQbMsCMHmhsMS4K0ZiEeZm4OwSMd/mAFcUfBaa090tLuWUGra5N08HH5Pv5W1ro+HvmAvxr77rbySe/UWMGA4BVxjgUYiHvwlKWRos6Fvr+7Z1RLDhbNQaYKnFFnReGN+Cx0l9sfl5VkgL+E58rgOrpk61SIieYZku0kQPetgqpimiAxgNDs8argqVcOCPJt94qxZmPqPCa5KpPYTnFQ+CtN9JCWCrcgm75h1S0MCah3moIxRK3uO7miJpN1KwsXn8aFa8JxFKCGNxvz+hjcnsZyAeiCjBo1zRknOrO03Z+YEV0GwCnthhS6jQUR7oOVLxpXZmCz6E/rLvlJiLK4Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejA76+bvLn0L7LXXdh2IIjKfIUKZSJXtJ96b6A6TNNE=;
 b=DVv+Sw0SvJZkKpcV6D9aiCiQweqk+V7w2Umoq1q0Jwa/cGIFMFVRWILV67MyPFLBtmU3P0TKBqMMgDJetv8LS1X9u7AoNIX/YBCj0xuOEuhxOHMVXBt+YnVtkwXuBVsXWrNL+WEYfpMH4q36+sve1/+b2srhDB+rDVxAPK9nfx1o8zDROjo1Lwl0SxtyHWZ+EJNiyHQFhHoB8KLXjMQkDVCujsAsUyEtsH+5T9QmWHhY93CyMmrpAnsCRzjwACh6y80AMeoqsAeeySX1R2wM+3d/0LTYjibGlIeBlayrH/jk+2RO2aWN1iz3tcN7NZ5uzZMmX/PM7NsgmgNMmCkoQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by VI0PR10MB8667.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:213::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 10:27:42 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9031.018; Mon, 18 Aug 2025
 10:27:42 +0000
Message-ID: <79890571-dad5-49c0-b797-01cb97004ab0@kontron.de>
Date: Mon, 18 Aug 2025 12:27:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] mtd: spinand: winbond: add Winbond W25N04KV flash
 support
From: Frieder Schrempf <frieder.schrempf@kontron.de>
To: Christian Marangi <ansuelsmth@gmail.com>,
 Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250606072140.18824-1-ansuelsmth@gmail.com>
 <20250606072140.18824-6-ansuelsmth@gmail.com>
 <221fbb2b-1999-4696-a416-27dd9220da81@kontron.de>
Content-Language: en-US, de-DE
In-Reply-To: <221fbb2b-1999-4696-a416-27dd9220da81@kontron.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0135.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::7) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|VI0PR10MB8667:EE_
X-MS-Office365-Filtering-Correlation-Id: cba37c69-6be4-4106-1ce8-08ddde41dd76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|7053199007|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WmZkTitIUG80eGhlY0pNQmtkRzBSa1kySG5EVVU3TnB0VjdOa3QxSFBoWXpC?=
 =?utf-8?B?bE41OVFIa1ZtVktqdkF2aktjcU1lZVBLVTBCMmlkcnFvdU1NNndGdnNPeW9Q?=
 =?utf-8?B?V2czUnpwRnF5ZFo4Y0RxUEtnOVRZdTkwLzcxVlVCV3RibXJtY2NmUVdRR2Y0?=
 =?utf-8?B?RUhQU0pwVHQraDFrM3V0SGdtQjk3TVRTTk5lZWNZTm1LcXVxa0U4d2xJUU1r?=
 =?utf-8?B?b01BQkNsK281Rmg2Ym9aclB4WjRwMEJudm1WWHRVU1dxcnUyVlEvdmFjaUNH?=
 =?utf-8?B?S3FmL1FMcVVWS01vYmpBdGdkaUdUb210dU5ZeERpTDEza09NdWhMTXpDVVp2?=
 =?utf-8?B?R0ZwaDNOeUtTbEMvNWZRVnRldWpUMEpzZVRlRFI2OCtGVWdMRzNyQVZqMEx3?=
 =?utf-8?B?UE9xSmpaNkUzK1ltQWFCV0NDdXUydlQyWit0NlJxS1RnTmFhelh4VzVzOGpR?=
 =?utf-8?B?cDBSTXdIYVI2NzNBVkk0Sng1TFI1QmJWSGFPM1pTSzk2YTlkMnJxS3ZIVzYw?=
 =?utf-8?B?Y25lZDN2V2NYVnJoa0w3RUplWDVKblNuanVDdS9CUkhnRXZ4NURIWUhiRXI4?=
 =?utf-8?B?MlRqSURGQVRGTnJaYkV6Z3ZwRC84eVdJMS9SWmxwcVpKeEtQSldpZXZwRmw0?=
 =?utf-8?B?N1JwNFdwSXN3S0FnZklDZEJMbUJPVjhucVhiMDI5Q3VMZG1TcXhNYkg2YkVo?=
 =?utf-8?B?NUNpQ1IyOExuUHQ2MDVYSTBTQVFxRzBWeWdiZTIxNDNzcDdQb0c5MkNreHl5?=
 =?utf-8?B?djVKWVUyZ09wTjNZOVlCQ3BRaWs1WVBxYkpFMWpNSGtMUkYvdm5oc01vNERl?=
 =?utf-8?B?RmN2VllKRWZheHQ4akxxRW1zamdOUVBjZHJ0eTdHMy9oWjNZTDNHZktubzA3?=
 =?utf-8?B?L2ZrazJnb3pIV2tIeldmaEJzSS9xMnduZ2h0VEdraFJBWndlNzFjeG9SaXZs?=
 =?utf-8?B?Z0RlS2xZU3Y5TlRBcUZUWXFUVTJRZmZzUnFKLzRiaVpydWZHeXY4M1g1bHRU?=
 =?utf-8?B?ZUFPQjVGUDRUOUx4YkpWTjI3bmFzamhVc1JTWDArejdFMVBBNXpYbDN0cHA4?=
 =?utf-8?B?U1pTVUEwUTdHdGZsa2h4Rmhsc3B1NjEwRE5QUU9MZlVCWXBQOUNLZC9kT1gy?=
 =?utf-8?B?VDd2N3RzY2M3cTE4Z0xhUGVSajNCbUswUnZaRjNIZkNlODFxMjU1b25EZFZu?=
 =?utf-8?B?dXkrKzEwM2FYQUtsWHhKZ0tPK2xQTUc4dmQyVFk5dDJsUWxNbHNyb01keXBO?=
 =?utf-8?B?K0MwcUhLalVyUFpkQ1ovYm1lTFFzUzVxR1ZZVWVTNWN6Qk1wdDkySTREVklK?=
 =?utf-8?B?WHFsaFdMZmJsNTZpR21BNEtBQkkzUHJ5Z1ZFZzhndHQreWEyMXNpZjBSaW5h?=
 =?utf-8?B?T3RyTGtVeGJ1OWJYRlgzSzIwbVJvRVlsNDJxRU81aVBjak93ZFkyWWlpblZG?=
 =?utf-8?B?RERFUG1ZVjlCZ3Y0R2V4MUtMUUw4NTRzMFVVeStoUHZLbEs1bXBDVXJSVC9I?=
 =?utf-8?B?N3ZtWW9Da0NZQ0NxU1hVVnRrQ08zdDFva09VZ2wxa0xkdk0yS0Rha3RGOUlE?=
 =?utf-8?B?MEZuUkZTZkt3SklXeHM5TGNRWnFpZkVpOHh5MWRUNUZmVWhPMXhqUFR5YnB5?=
 =?utf-8?B?aTl3Q1lYWkU4RHcyN2xvejI3cmErNUxaY3FpKytTRGxuSnZrMjd6VTRJK0Q5?=
 =?utf-8?B?YnZ1NW5nc3R6OTVOYVRDRTRqeHcyNkRLY0JkVlEwb3pjSVVRR0tvNEZ3R2dh?=
 =?utf-8?B?WlBtTTdSU1B0WHJ1Z3hkajlEZDl3cEttNCtSNUoza29RTWVlSnZnY0V5Zzhl?=
 =?utf-8?B?UW5JTklxV2RyQWNPMjFja0hPRWl2bnNSY3hETVpWUU1xMXh5dGVOT3BMYmla?=
 =?utf-8?B?bS85eWNSbk9FSDEwdkxGV3Y5bVl2TDdIZTNJT3YweldURjdUck51QkZ3a2hK?=
 =?utf-8?B?M0xTNFVSQVdoTVo4QmMreW1naDc1RVE3UmtlYUFJNDFjbVhGRDl3aFJlWDFT?=
 =?utf-8?B?YTZYNmViZmpnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3lwKzg3YUl3Z1NSRHFqYzZsL2Y3R3UxNC96R1ZpaXpTMmlTQTNQUkp6enNU?=
 =?utf-8?B?d1A3VllzK3JYcEhUVGl2K2x6cks2OWU3cjBUZGJWTEg4VWRKdEpZemR6V2JY?=
 =?utf-8?B?VjBPbXd5aFZxYkxzd3dLVDRHWDI0ZGh5bUU0Q3VuSC81M1VCM1Q0dmtTcG9J?=
 =?utf-8?B?bG9sSUIvRHliTUtMTUVSMklpS2J2NVoxV1JFRGExektNQXo3SHFpWUluczJZ?=
 =?utf-8?B?Vjl6TjcwblpSU1NXZmNJaVcyWXhPMzMraVZRTWo5TEdTWG9zUVNWdWVwdlNp?=
 =?utf-8?B?M25HVWJ4Q1A0VzN0b2NHUUJLTjBOL3haWTV6alJFVHZvSGlJRE9ZV0hpZkth?=
 =?utf-8?B?ZW5FVitnODNzaERWL3dTdEZXc2k4djhuQ2Zid0dqZW9RQ2VmK200aUlFb0w1?=
 =?utf-8?B?SWtMeXVkRi8yWUFZT092YXpDQlJKalBFaDlmUENZMVJDWmRrSCtPWlBVcUtu?=
 =?utf-8?B?eWxJMXY2dmxFdUpDL0tIdFF4cFk3b3ViWFBlTGtkYmtqbndrMWtFbEpNUk9K?=
 =?utf-8?B?bHJUTTluZzlROUpNWEp3RHM3VTZndlI4aTM2QXRVaC9qQXFGUTNLVGtpVFcv?=
 =?utf-8?B?UjdIOVh5cVQwbjdVbFBNMWIyRkFSa3Q3VTJURlZpOVBwZWM4bnNDRWZEZVFU?=
 =?utf-8?B?R1RHeEJVaFBRaHZucTZJQWtPVUE4SmFuUnI4VGowb2t4cGMvUWllMGVXeFhJ?=
 =?utf-8?B?cmwrTmY2ejF6czRhZzVEQXJiRWFXSGZBa1BVa1lVOTAvdEhrdENaaSt6Z2V1?=
 =?utf-8?B?ZURKNzR4bS90a0s4OUFIRW5hTCtuTkpZN2JObkFpM1h4dWtUNUxRMjhpcktm?=
 =?utf-8?B?T0wwY0wzN2RaTmFWSDFoVC82YTRDL1lMZWVWbHBiUmQ5ajNRRit4ejYyTWpD?=
 =?utf-8?B?a1Bqdk1YK3UxeTdoWlVPbVFGak1CSGNieVBCQUZJVncwLzJpRk9BTXJUK0t4?=
 =?utf-8?B?bTZGSkdOUU43TUs2cFVBamhJam8xaWxjejhpczFxbEhEUTNJM3J6WkJxTGx2?=
 =?utf-8?B?emErQmNLaTloT3VjbCs2cEt6S0dXUFlzaTFYRVBMNURrRkRBcXk2VDVNcnNr?=
 =?utf-8?B?WHlmVG9aSTFEb1lJN2tLMHpKMm5DR0g3dTRpaDN4VU9VSUlGWHV4b2xmTmNS?=
 =?utf-8?B?UGJBNXZsL0QrOHJyVktDbEpMdm9kTkdVeTZSSW11K2hlSndQSnZLNks5dU9h?=
 =?utf-8?B?T0RONVloVEgzZllSa3pxYUlhOEt1UzJmZWsxa3N5ZDZUbTB4cWhOUXVLUnMr?=
 =?utf-8?B?TkNPeUlydjVVd2lnU0VjRmFSRnZqSlpLTkRzM01tNkg5ZlliVSs5amhDdUFp?=
 =?utf-8?B?Snl0STN6WUljQ1FURkdYM0NEUDVwdmJGa2IrcEt3K2VzemRzdlhZRzBLQTc2?=
 =?utf-8?B?R2MxclpIMFZ2bEpub0VOaEVWOXltb09ocHFvdzViRCthM2w1bkY0QW04TEFI?=
 =?utf-8?B?b0JmL2t0ek5FbWw0ajhuNERpUFVqV3hoQzhyeVUrTXF5eTZEYnJYcVdiNWMz?=
 =?utf-8?B?V09wUVpKbEk5OVA1S0xyQjRocDJQeC9YMTRjSVkvQ2ljMkF5Z3ZuVWFXM0xN?=
 =?utf-8?B?akpVWS93S0doRjd5SG1QUDd1TGtSKyt4VWxVUUNuUkJLRWZDSFJPWEs1UDNY?=
 =?utf-8?B?ZDllUWR4L2FhZE01QmZKVjhPakpQd0N4OG5KeVZhbnM5L1g4U215Q0U3ZlFI?=
 =?utf-8?B?QmJWdEZLV2l1Tk9kei9ZY0llZ0I2ZEFhS0NXcnpDSXlJVmRlVWZtWkQ0SDFw?=
 =?utf-8?B?bmU4MzMyN3JuQlNmR0JkbzMzcWVVVGdmcUpCSzNId3VOdHh2WGtCZkRVcitU?=
 =?utf-8?B?MWtRTjVkMGhaRk1KMnVuMk81Q3dIVFJwd3FoaHV3cXdDNzJxa01SbEd2ejJW?=
 =?utf-8?B?TnNYMjE1em1TWFJ5ejVvQkNXK0RubGhLaEZnRGlQQTF3eFVubGowRjgzSDRs?=
 =?utf-8?B?a3p6Q3BMTk10UXF3bDhVTGdwd1hYL3VDYW9xcmNYRmFTVEVldkd3VTRiVlJS?=
 =?utf-8?B?RkRkcVAwSmEvbHVVVmdvTk92eVM2UDZJZGppeUpCbDVsOFJYQUtiWURKTVd0?=
 =?utf-8?B?SlU3ZVdXRzYrNk9nOW5aTDRmR2tHcjJCU2Urc3pnS3F3aXNNMWFldS8vZEs1?=
 =?utf-8?B?T2hnRmRsRDEvVDFDQ1BBU3JnVHc0RDg5SU00OTU2cUxuS25Fb2NYdWNvT3p6?=
 =?utf-8?B?N1E9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: cba37c69-6be4-4106-1ce8-08ddde41dd76
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 10:27:42.7773 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WTd7MynUdY8zvnoX4kJHN15elfD1X4M1BiGUwm8XAvYJZM0cdc01pnA6NS/Tu9pofpmHOcFg0tcFkWF8/7w5S+17n6UQl480e7Kh7jFmL2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8667
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

Am 18.08.25 um 12:21 schrieb Frieder Schrempf:
> Am 06.06.25 um 09:21 schrieb Christian Marangi:
>> Add Winbond W25N04KV flash support that use a different value to detect
>> ECC bitflip.
>>
>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> 
> For information: this will be covered by Mikhail's patchset here:
> 
> https://patchwork.ozlabs.org/project/uboot/cover/20250818100614.432931-1-mikhail.kshevetskiy@iopsys.eu/
> 
> And for the future, please provide a changelog when you send mulitple
> versions of the same patch. Thanks!

Sorry, I missed the rest of the series and the changelog in the cover
letter. And I missed the fact that this has already been merged. So
forget about my message and sorry for the noise.
