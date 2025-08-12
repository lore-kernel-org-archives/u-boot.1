Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45915CA0EC4
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 08:53:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 952DF80FA8;
	Tue, 12 Aug 2025 10:53:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Vj9THled";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E71B8129F; Tue, 12 Aug 2025 10:53:24 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2072f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::72f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F4A8801DD
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 10:53:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LJnW21oDnMvMnvYuCxJN9XJPvVEF/tlnnYhiyV+XTipTqxsCVwJdPdVCmcgbkAlSo+NRyAWtBP0R13uZX51pAUq9URzp4ezZDP8VDDo0ibd2849Zr4K9Yy1A6n3tsD1wXV+c/LCXmRFuRrQIKERnHfMPtjkt3xhDs436BaY/ZImeE+YV89MVjmYgsWo1jeMOXkHGj85R/VklarE5bNaLxh7c5YPyQfgocRUNBRTi7tpUp/JR7HjJ7Hs8JtdKGhrSbyKQwKbpQHeW/+Z8De2d5STiYKxauGmktfrROb970BElifep0seRvcN9rHCcjN7Vsjb8p0+cYyv9gS/KnXKVyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0LDPqqOotQ/w5h2o/lurUTyBpRbgX5W9I5we5uug1ig=;
 b=ZhMzStib7oaOVU70gtyreFbkM5OUstnDlRa2yn6czERF8UtwHrc7nORJI1sSyV/10KXKAo/tmtOxZfMPrQ0UmMUYM4ujCu0sxmNusE1U6fmS7Q2s1NfGiD4PmgZHfXXuH2Ei0cpTcyJS7dn1TuJNjpt/3RNbwvr1gTtdgdVvrqgy1O4wiEoKhrizUX5dDoOEQMIRnxhoGECLh4M1iuCI4dQkjGEOaygSaNct8wEECOT9hxphwg8hTTpJtFMhJPneJKGO+pKnZMY7QSImQWNGY+T1gWXGdgPE/btqlvoE389xr1G72FprjXNkZHi+tEM8HxwxPlh1EU2slcNN01syEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LDPqqOotQ/w5h2o/lurUTyBpRbgX5W9I5we5uug1ig=;
 b=Vj9THledayq5KTV3q0OLb0RHMwg+QUbY2x29+rDtrC/jBG4tyVyfMTUBJLjlP9/ImCvO+TviWyAh/D1OzDJ06roxzPDBJAMI/eYxFGuLUM2Ns/B5eApGPojNbs1+HDAhCCSDxMwJq/JIRV5OOHgp7uV/erzuVZoJpwJPMv+YPiuS0D5ctoNfcdn5PN56/btITtbdoTddeHbB9zJogsCEwiLen198Q70hlSudKVQ7y8Bt0aE16wyJVMMFi/HjP41V2p+8ZeQxvbHMJFiM/4/3qv1dJdTbh4fgbtVy/C2vPxX+PGRuZ30SOjqT6LcpJDMMO2+bF61AWWzQDDoPN2X5RQ==
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::14)
 by VI1P195MB0573.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:156::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 08:53:19 +0000
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414]) by VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414%5]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 08:53:19 +0000
From: Yannic Moog <Y.Moog@phytec.de>
To: Aristo Chen <jj251510319013@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "trini@konsulko.com"
 <trini@konsulko.com>, "sjg@chromium.org" <sjg@chromium.org>,
 "alpernebiyasak@gmail.com" <alpernebiyasak@gmail.com>, "al.kochet@gmail.com"
 <al.kochet@gmail.com>, "paul.henrys_ext@softathome.com"
 <paul.henrys_ext@softathome.com>, "bb@ti.com" <bb@ti.com>, Wadim Egorov
 <W.Egorov@phytec.de>, "francesco.dolcini@toradex.com"
 <francesco.dolcini@toradex.com>, Garrett Giordano <ggiordano@phytec.com>,
 "n-francis@ti.com" <n-francis@ti.com>, "afd@ti.com" <afd@ti.com>, Daniel
 Schultz <D.Schultz@phytec.de>, "d-gole@ti.com" <d-gole@ti.com>,
 "ravi@prevas.dk" <ravi@prevas.dk>, "carlos.lopezr4096@gmail.com"
 <carlos.lopezr4096@gmail.com>, Aristo Chen <aristo.chen@canonical.com>
Subject: Re: [PATCH v1 5/5] test: Add test case for FIT image load address
 overlap detection
Thread-Topic: [PATCH v1 5/5] test: Add test case for FIT image load address
 overlap detection
Thread-Index: AQHcAIeDbVAhrF+3P0i+89D+OmUvFLRMIQAAgA2B6ACABSkhAA==
Date: Tue, 12 Aug 2025 08:53:18 +0000
Message-ID: <ad596e409203160749cd0573828ffc7d5f338509.camel@phytec.de>
References: <20250729125022.4220-1-aristo.chen@canonical.com>
 <20250729125022.4220-6-aristo.chen@canonical.com>
 <a082bc0a8667f918a1ba80b677f9285527f479bf.camel@phytec.de>
 <CAJwFiGLv8UzSHy9bgfcx=OXKPuveKXGmCkD6Hin_9OfUc_h9iQ@mail.gmail.com>
In-Reply-To: <CAJwFiGLv8UzSHy9bgfcx=OXKPuveKXGmCkD6Hin_9OfUc_h9iQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2491:EE_|VI1P195MB0573:EE_
x-ms-office365-filtering-correlation-id: 6a9d0421-d872-4f7f-9dca-08ddd97daf2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?eHYxVGk2MTJYZ3QwRVBqTmF0NTNLT3hpcHAwaGJZNG9wSENwZW5TSWZsdXIx?=
 =?utf-8?B?SGM3MHF5LzNTcUh4TG5iQU5FcE5wMzU5dXg0Z0E4bGpmOEZmVXZHRUNmWFox?=
 =?utf-8?B?VEpJeDIwMVNMVU14UWp4dmN3WVZ0NEIxSTdiODlsZVNqQnd0dVpDMUVPY3o4?=
 =?utf-8?B?SkhKN1VtN3NBelV2cVlyeG9tQ04waEs0OVRNWDRLT2dBd3Fjbnc1bDhGaVV4?=
 =?utf-8?B?b1J0M1JrWHFuc1F5UEd5ZWt2Z1pnbGU3ZG9BNFpjV1BFS1hHbFMrZVFpVlNk?=
 =?utf-8?B?VTk5TGlUMFhkeGZ5cWRBMHMwKzlPdk1jT0c3MXc5MFlKanFRcmhuUXd2aXZH?=
 =?utf-8?B?QlFPQ1VLeWhWcHJZZ1VtV1l0RVVpYlFzSnhTWlhZWjZRVkNWU3EwNDlNVFlJ?=
 =?utf-8?B?bk5yOVloZXBJM0xVbVBhNlNTRGVzdTZHNGNGUk1GOURoUy80SVcxRzdXQXRR?=
 =?utf-8?B?alFGODcybmZMZHBGZWZXbXZ5ejZUeFhUZ3ltNFRRclNvbXZmVlU0blk1SExa?=
 =?utf-8?B?QnVrQjVFNmJEdHM4bHVkb0M2ZTNudUNKTk5jK2NpZk9rWXI5WkFlTitWZi9I?=
 =?utf-8?B?UWZUcnAvM2VURVQwT21Nd2F6Z0M5NXcvYTlsckRmQkRyRUlMRDRzVEtTamFZ?=
 =?utf-8?B?V1NKZXBBVk9xclpNeUJKZkhadjdKc3pLM2pNM281ZmhjUEVkU1ZCbEg4N2o2?=
 =?utf-8?B?eWVMNW52MUVsZmdJMUhIUkJ6YlNSK0l5WHpIUnpYSlEvcWlmQzd1Rk5lOWgw?=
 =?utf-8?B?aFY3NXpsa2FGK1N3elB4ZVN3LzFSaHFRaXlBRWhoMzlNOWdKMHlyOGJybllT?=
 =?utf-8?B?UTJ2SmNWbkV2UVpXbG5jVk5ZOW8zaWtyVlEraHFBbndQaGdrM2JBZWVlZkpB?=
 =?utf-8?B?OGxLTTM3aGJRK3dna2J4UEZ3VGJJTDQxQXJaNEJ4bEdGbUFicmxKY3NTc1Jx?=
 =?utf-8?B?aFcreWE3aGpWaVlDMkVBL0xHbEZyZGJEYmJoTWlzYzVVWlVWaHp1TzErMU1t?=
 =?utf-8?B?SCtUbXBjaUZlcTBZb1pqSU82WTdRLzFTcHBGaTNTZVNwMWVJcHJJS2dMSnRh?=
 =?utf-8?B?bkdkL2lUa3AxdElsS1RyRk1uVit6SXphdFg1cjhvM0tha0FrdURNSzR4VHNw?=
 =?utf-8?B?cHBBVm1HYTZFWWFVN3ZCUExpUW9OSHB6SzlnSXR0Q1I3akpTTVpRM2lyVTdR?=
 =?utf-8?B?MkZOeGxvMWVvM1dqM3J4Mk5KK3I0SW1wV21Sbkt4amNrSSsyQkdJWWNnekFv?=
 =?utf-8?B?aFZkZ2VTTjBaaG1sWlV3NmJUUWdEY2hKV0locWdIeEtpZDN3SVRCY3BtbFNN?=
 =?utf-8?B?RW5HRzBMNUg2c1hXTEdZS3F2UmhEV1dWTDc1amkzZTMxaWFaSVBhN2MzWnRM?=
 =?utf-8?B?NVQvQ3lTSVBCYmcwMlJLNy9YUHJNU0ZWOVpDMFRNcjlqN09ZTG5Sb3NXVFI1?=
 =?utf-8?B?cVFhOHlzOHlhVHh5STNnWmNxamVsaEw2aE55TGo3Q29DV3hhaUVTRlFhMmYw?=
 =?utf-8?B?dm5vNUZQWStoUnNrVk52UjN4WG1yWlVEWDI1QlJFWmVQZjR6ZjMxcmFMWHVI?=
 =?utf-8?B?NEZaZDJ6MU1mMjRHbkhBaU1sakdMN012cVNicGNWbFMwS1B5b08xK1M5cTJR?=
 =?utf-8?B?NEpDVlQyWVQvZlJKKzloSG4vWmpnS21GMitTYjc1ZDVTS1JERzJJakZNYjcr?=
 =?utf-8?B?RXlvdWlnME10OHc1VFM2MWdYMzFmMk4rY0t4aXhFdjQ5djRvck1WTWhBa213?=
 =?utf-8?B?T1I0TVJDYlQ1UnVQMmN0UEQzQU5qNmlnV1Z1RVJWaDNMQnJIVXlGZUxZd3Np?=
 =?utf-8?B?ZFFES25VcFE4ZWVOODNNdmFEMXFxcnhMN3hmTGh4S3RVNXRDU0orNm5mRHVZ?=
 =?utf-8?B?eXk2MDg0aFdTYklPUERqNmtOM01yRjZRT1kxSFR2SWxDakFITmdrT0IyMm5P?=
 =?utf-8?B?dVMxQkt3TkFTYU42UFJBcTV4WFMydjl4RnA5NmpmMUFndThZTjAvTFkwaExn?=
 =?utf-8?B?V29LNnMzQnd3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2491.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVRJZkx4UUJiZ3NNZi9HT05uY3JqMm9LLzJCaEpidzhIMlU1MWNBemVLdnB5?=
 =?utf-8?B?ZTBGZ052MFA2cjhtbFBSOWltbGZUcUZTRHFMQ3p1V1N2dkpMNWtIcHQxNStQ?=
 =?utf-8?B?cGNsZnkyQ1cwbWJEQkl5eFM0ZlV2aUk2TmNVeENLSHZjZER3aDZIcFkyMldL?=
 =?utf-8?B?T2JoeWtOOE41d20xL0R3ME9JV0dFQmZwazZ6UTM5WHMvU3doeWdyZXJ2c1BB?=
 =?utf-8?B?aXpINWtpeUF1YlRWeVFrRVcwblBIQmtTc3AyWGpTN0YwL3VHWmxKdjBCZVYv?=
 =?utf-8?B?cy9oUWJpVzJTbVZVb0JtVHJzK0NhVkJUNHZaMlZsdHRTckJzbXJySkliM0dV?=
 =?utf-8?B?MUV3a292RUNWSXJVVzNqSzMvNUQvdGcvRlEvaTNGSFhud2x0ZnIvcUlkSEhr?=
 =?utf-8?B?ZXRYMXgvRTNZbUw2L3MzbnJmK1VzcnRNUXN5WTlqMDZZUEI0Q25TMGtoaXQ1?=
 =?utf-8?B?TGdBRlpieW94YzJEOGZ6cSt4ZjMxTW5WOVpNTlhIRTBnV0c2cERvL3ZJOWw2?=
 =?utf-8?B?TVRIMDEvbE9DNHoyWVI5TEdSaGZpYTB0TkYvcHRZbXNMS0tLSUpJd1IwVWVH?=
 =?utf-8?B?cmRjMnFQVlpmYzQ3QTc3b1E3L0p2RlFoUlZBd0xWamlmd2pUWjVrWEE3azZ0?=
 =?utf-8?B?TldZZ3FsZXIwcE9pRFBWMmZnd2Yvb09YblJoM2JJbVc0R3VMQXNHNm8rMGRY?=
 =?utf-8?B?RmMyYW10UHZoc0IrbHVyRE50TFVtZjJ4QndJVnFuSVZUWkFWTDRYWldyZTNI?=
 =?utf-8?B?Z3UvSk5rQlFUZUd5S1RwaHRNdkhhRmFhT1RIS2VCazBzd0sySHFKVmFOcEdV?=
 =?utf-8?B?WW1NemVodFA4cCttQ2pRYzRoOE9ZU2dPN1RQTzV2L0VDbnl1SW80dWRFalZm?=
 =?utf-8?B?aEhwZlBjdUxDZGhtRDJ4RWNCOTF2cXVsNUQxbVA1SFZzWkpjRFpBY1BJRXBr?=
 =?utf-8?B?a1RBb3pRaHFXeFFOMHhIdjRmaUllNm1BVVFrYnVEU1VuK1p3aktDRzlGYU1H?=
 =?utf-8?B?eDVoVHFnTVdYQ2lpRUFGQ1pjajUvRTZWTzhaSGN6d3N0c2tDNFd5U3haR1FH?=
 =?utf-8?B?blFVZkZqdjdnU1FyZ1JZQXVMR2pzd0xod3YvL3Yya3hjUFBSZDFhOE44RTVa?=
 =?utf-8?B?WFJ4OWR1YjVzVG9VQjd3U2hIUng4MTY2d3VpcnUyUVpXZDVTWHNmcm42eHh6?=
 =?utf-8?B?UXU2R29IVUJITVVPajRUclYwWUZSVGZSTUtaTEc4VkozeHoyVEtkeUg0cThK?=
 =?utf-8?B?V0FIRWJXSnRmbEUvaldCMUloSmdIcUk4M0ZhMFk0cmdOdDRRempHRW5QaE1K?=
 =?utf-8?B?Mmg0K2QyYS8yZ0hOcUpuVTFGazZXNVk5Z1BHUGlvZE1uVWpyd3BpZjQvVHBh?=
 =?utf-8?B?eWNqQm12RnRJMnR5R2ptL0I0TmgrOWFOMnBUN3BHdC9qQ1VENDIyTUVlV1Ez?=
 =?utf-8?B?UXMyZFlEVSs3blRXbjQ3eWtVVW1mTVZSWm5JbG40VW4xSko5U2xFVDNFU3d5?=
 =?utf-8?B?WmdHZzdjQkh5Nzl1aGdFcUNiaEJibVlFbHVjMHJyd1RKN1hLQ3I1N0lrRk1E?=
 =?utf-8?B?VEl4VTB6eGp3STc1bGRpRGJjRGMyTjhqMGhyQnA3SUFBemVCREE1cDVSeVZH?=
 =?utf-8?B?RkdQRVRPVUZuSFFvd2FUOEJNUWtlYTFYcmU5LytvNWNPRUFpcHB2WVFuamFz?=
 =?utf-8?B?MzNXalNqNFFLZjlmV2VHYUduT2d5VkpuQWJXakZRUlBrVk5DR2VMMHh2TUJ3?=
 =?utf-8?B?dUhtZk5Xc3RWeTErT3RSbWcrOWtpbTdNOVYrNFZLZ3oweWZnTm1rN3dYQmN5?=
 =?utf-8?B?c0k3c1BGemRJai9FNjhPdms4VFlNRWovWHN1VTBrWHJ0RjU5MXIrQ2dqSlBS?=
 =?utf-8?B?TFpjOGJmM2JYcHR1aDk2Q1c5L1AzMWFnTCttcGwvemhNZlI2dzNLVDhSbW5W?=
 =?utf-8?B?cU4wOXZUN01BbkR4QjRpOWRmWDVPSG9qVUQ3ZzBNNmZVMzF4STIxR0gxKzN3?=
 =?utf-8?B?K0pPYzExWmVDcFkwSEpXazBPWTdFRG0xTHdpVzdlbXI2VDJDRVJvbUo0NzNC?=
 =?utf-8?B?RllnNFlrL0V1Y2dBOHZlMFR0Zi94SEVqamxDbC9wSjdpajdLNzRXa2JnZUp3?=
 =?utf-8?Q?Y+JM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE5D71E8652D984DB4972707C3A0E4AB@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a9d0421-d872-4f7f-9dca-08ddd97daf2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2025 08:53:18.9576 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +9M8GQMLS6AwwYt7pjz/hcWFvL3HyHxDSSrhxOax3/5Kj0zPYRbXADrHlgu/Gx14jZFiAzvjnT6oxOmsrnZOiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P195MB0573
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

QW0gU2Ftc3RhZywgZGVtIDA5LjA4LjIwMjUgdW0gMTA6MDQgKzA4MDAgc2NocmllYiBBcmlzdG8g
Q2hlbjoKPiBZYW5uaWMgTW9vZyA8WS5Nb29nQHBoeXRlYy5kZT4g5pa8IDIwMjXlubQ35pyIMzHm
l6Ug6YCx5ZubIOS4i+WNiDc6NDjlr6vpgZPvvJoKPiA+IAo+ID4gQW0gRGllbnN0YWcsIGRlbSAy
OS4wNy4yMDI1IHVtIDEyOjQ4ICswMDAwIHNjaHJpZWIgQXJpc3RvIENoZW46Cj4gPiA+IEFkZCBh
IG5ldyB0ZXN0IGNhc2UgdG8gdmVyaWZ5IHRoYXQgbWtpbWFnZSBwcm9wZXJseSBkZXRlY3RzIGFu
ZCByZXBvcnRzCj4gPiA+IG1lbW9yeSByZWdpb24gb3ZlcmxhcHMgaW4gRklUIGltYWdlIGNvbmZp
Z3VyYXRpb25zLgo+ID4gPiAKPiA+ID4gVGhlIHRlc3QgY3JlYXRlcyBhIEZJVCBpbWFnZSB3aXRo
IGtlcm5lbCBhbmQgRkRUIGNvbXBvbmVudHMgdGhhdCBoYXZlCj4gPiA+IHRoZSBzYW1lIGxvYWQg
YWRkcmVzcyAoMHg0MDAwMCksIHdoaWNoIHNob3VsZCB0cmlnZ2VyIHRoZSBvdmVybGFwCj4gPiA+
IGRldGVjdGlvbiBsb2dpYyBhbmQgY2F1c2UgbWtpbWFnZSB0byBmYWlsIHdpdGggYW4gYXBwcm9w
cmlhdGUgZXJyb3IKPiA+ID4gbWVzc2FnZS4KPiA+ID4gCj4gPiA+IFRlc3QgdmVyaWZpZXM6Cj4g
PiA+IC0gbWtpbWFnZSByZXR1cm5zIG5vbi16ZXJvIGV4aXQgY29kZSB3aGVuIG92ZXJsYXAgaXMg
ZGV0ZWN0ZWQKPiA+ID4gLSBFcnJvciBtZXNzYWdlIGNvbnRhaW5zICJFcnJvcjogT3ZlcmxhcCBk
ZXRlY3RlZDoiCj4gPiA+IC0gRXJyb3IgbWVzc2FnZSBpZGVudGlmaWVzIHRoZSBzcGVjaWZpYyBv
dmVybGFwcGluZyBjb21wb25lbnRzCj4gPiA+IMKgIChrZXJuZWxAMSBhbmQgZmR0QDEpCj4gPiA+
IAo+ID4gPiBUaGlzIHRlc3QgZW5zdXJlcyB0aGUgb3ZlcmxhcCBkZXRlY3Rpb24gZmVhdHVyZSB3
b3JrcyBjb3JyZWN0bHkgYW5kCj4gPiA+IHByZXZlbnRzIGRlcGxveW1lbnQgb2YgRklUIGltYWdl
cyB3aXRoIGNvbmZsaWN0aW5nIG1lbW9yeSBsYXlvdXRzCj4gPiA+IHRoYXQgY291bGQgY2F1c2Ug
cnVudGltZSBmYWlsdXJlcy4KPiA+ID4gCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEFyaXN0byBDaGVu
IDxhcmlzdG8uY2hlbkBjYW5vbmljYWwuY29tPgo+ID4gPiAtLS0KPiA+ID4gwqB0ZXN0L3B5L3Rl
c3RzL3Rlc3RfZml0X21raW1hZ2VfdmFsaWRhdGUucHkgfCA2NSArKysrKysrKysrKysrKysrKysr
KysrCj4gPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDY1IGluc2VydGlvbnMoKykKPiA+ID4gCj4gPiA+
IGRpZmYgLS1naXQgYS90ZXN0L3B5L3Rlc3RzL3Rlc3RfZml0X21raW1hZ2VfdmFsaWRhdGUucHkK
PiA+ID4gYi90ZXN0L3B5L3Rlc3RzL3Rlc3RfZml0X21raW1hZ2VfdmFsaWRhdGUucHkKPiA+ID4g
aW5kZXggZWY5NzRjOGM3NjIuLjUxZjdmNjRiMjU3IDEwMDY0NAo+ID4gPiAtLS0gYS90ZXN0L3B5
L3Rlc3RzL3Rlc3RfZml0X21raW1hZ2VfdmFsaWRhdGUucHkKPiA+ID4gKysrIGIvdGVzdC9weS90
ZXN0cy90ZXN0X2ZpdF9ta2ltYWdlX3ZhbGlkYXRlLnB5Cj4gPiA+IEBAIC0xMDEsMyArMTAxLDY4
IEBAIGRlZiB0ZXN0X2ZpdF9pbnZhbGlkX2RlZmF1bHRfY29uZmlnKHVibWFuKToKPiA+ID4gCj4g
PiA+IMKgwqDCoMKgIGFzc2VydCByZXN1bHQucmV0dXJuY29kZSAhPSAwLCAibWtpbWFnZSBzaG91
bGQgZmFpbCBkdWUgdG8gbWlzc2luZwo+ID4gPiBkZWZhdWx0IGNvbmZpZyIKPiA+ID4gwqDCoMKg
wqAgYXNzZXJ0IHJlLnNlYXJjaChyIkRlZmF1bHQgY29uZmlndXJhdGlvbiAnLionIG5vdCBmb3Vu
ZCB1bmRlcgo+ID4gPiAvY29uZmlndXJhdGlvbnMiLCByZXN1bHQuc3RkZXJyKQo+ID4gPiArCj4g
PiA+ICtkZWYgdGVzdF9maXRfbG9hZF9hZGRyX292ZXJsYXAodWJtYW4pOgo+ID4gPiArwqDCoMKg
ICIiIlRlc3QgdGhhdCBta2ltYWdlIGZhaWxzIHdoZW4gbG9hZCBhZGRyZXNzIG92ZXJsYXAiIiIK
PiA+ID4gKwo+ID4gPiArwqDCoMKgIGl0c19mbmFtZSA9IGZpdF91dGlsLm1ha2VfZm5hbWUodWJt
YW4sICJpbnZhbGlkLml0cyIpCj4gPiA+ICvCoMKgwqAgaXRiX2ZuYW1lID0gZml0X3V0aWwubWFr
ZV9mbmFtZSh1Ym1hbiwgImludmFsaWQuaXRiIikKPiA+ID4gK8KgwqDCoCBrZXJuZWwgPSBmaXRf
dXRpbC5tYWtlX2tlcm5lbCh1Ym1hbiwgJ2tlcm5lbC5iaW4nLCAna2VybmVsJykKPiA+ID4gK8Kg
wqDCoCBmZHQgPSBmaXRfdXRpbC5tYWtlX2R0Yih1Ym1hbiwgJycnCj4gPiA+ICsvZHRzLXYxLzsK
PiA+ID4gKy8gewo+ID4gPiArwqDCoMKgIG1vZGVsID0gIlRlc3QgRkRUIjsKPiA+ID4gK8KgwqDC
oCBjb21wYXRpYmxlID0gInRlc3QiOwo+ID4gPiArfTsKPiA+ID4gKycnJywgJ3Rlc3QnKQo+ID4g
PiArCj4gPiA+ICvCoMKgwqAgIyBXcml0ZSBJVFMgd2l0aCBhbiBpbnZhbGlkIHJlZmVyZW5jZSB0
byBhIG5vbmV4aXN0ZW50IGRlZmF1bHQgY29uZmlnCj4gPiA+ICvCoMKgwqAgaXRzX3RleHQgPSAn
JycKPiA+ID4gKy9kdHMtdjEvOwo+ID4gPiArCj4gPiA+ICsvIHsKPiA+ID4gK8KgwqDCoCBpbWFn
ZXMgewo+ID4gPiArwqDCoMKgwqDCoMKgwqAga2VybmVsQDEgewo+ID4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBkZXNjcmlwdGlvbiA9ICJUZXN0IEtlcm5lbCI7Cj4gPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGRhdGEgPSAvaW5jYmluLygia2VybmVsLmJpbiIpOwo+ID4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB0eXBlID0gImtlcm5lbCI7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGFyY2ggPSAic2FuZGJveCI7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG9z
ID0gImxpbnV4IjsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29tcHJlc3Npb24gPSAi
bm9uZSI7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGxvYWQgPSA8MHg0MDAwMD47Cj4g
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVudHJ5ID0gPDB4NDAwMDA+Owo+ID4gPiArwqDC
oMKgwqDCoMKgwqAgfTsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgIGZkdEAxIHsKPiA+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgZGVzY3JpcHRpb24gPSAiVGVzdCBGRFQiOwo+ID4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBkYXRhID0gL2luY2Jpbi8oInRlc3QuZHRiIik7Cj4gPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHR5cGUgPSAiZmxhdF9kdCI7Cj4gPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGFyY2ggPSAic2FuZGJveCI7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IG9zID0gImxpbnV4IjsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29tcHJlc3Npb24g
PSAibm9uZSI7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGxvYWQgPSA8MHg0MDAwMD47
Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVudHJ5ID0gPDB4NDAwMDA+Owo+ID4gPiAr
wqDCoMKgwqDCoMKgwqAgfTsKPiA+ID4gK8KgwqDCoCB9Owo+ID4gPiArCj4gPiA+ICvCoMKgwqAg
Y29uZmlndXJhdGlvbnMgewo+ID4gPiArwqDCoMKgwqDCoMKgwqAgZGVmYXVsdCA9ICJjb25mQDEi
Owo+ID4gPiArwqDCoMKgwqDCoMKgwqAgY29uZkAxIHsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAga2VybmVsID0gImtlcm5lbEAxIjsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
ZmR0ID0gImZkdEAxIjsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgIH07Cj4gPiA+ICvCoMKgwqAgfTsK
PiA+ID4gK307Cj4gPiA+ICsnJycKPiA+IAo+ID4gV2h5IGRvIHlvdSBjcmVhdGUgdGhlIGR0cyBo
ZXJlPwo+ID4gSSB0aGluayBpdCBpcyBiZXN0IHRvIHN0YXkgY29uc2lzdGVudDogY3JlYXRlIGEg
ZHRzIGZpbGUgYW5kIHVzZSBleGlzdGluZwo+ID4gX0RvUmVhZEZpbGVEdGIgYW5kIHRoZSBsaWtl
IGZvciB0aGUgdGVzdC4KPiBJZiBJIHVuZGVyc3RhbmQgY29ycmVjdGx5LCBfRG9SZWFkRmlsZUR0
YiBpcyBkZWZpbmVkIGluCj4gdG9vbHMvYmlubWFuL2Z0ZXN0LnB5LCBhbmQgaXMgb25seSBmb3Ig
YmlubWFuIHJlbGF0ZWQgdGVzdC4KClRoYXQgaXMgY29ycmVjdC4gSSBtaXNyZWFkIHRoZSBwYXRj
aCBhbmQgdGhvdWdodCB0aGlzIHdhcyBhIGJpbm1hbiB0ZXN0LCBzb3JyeS4KCj4gQWxzbyBJIGZv
dW5kIHRoYXQgaW4gdGVzdC9weS90ZXN0cy90ZXN0X2ZpdC5weSwgaXQgYWxzbyBkZWZpbmVkIGEg
ZHRzCj4gZmlsZSBpbiBpdHNlbGYsIHdoYXQgaXMgdGhlIGJlc3QgcHJhY3RpY2UgdG8gY3JlYXRl
IGR0cyBmaWxlPwoKSSBhbSBub3Qgc3VyZSBpZiB0aGVyZSBpcyBhIGJlc3QgcHJhY3RpY2UuIEkg
dGhpbmsgZm9yIHRoZSBta2ltYWdlIGFuZCB0ZXN0X2ZpdApmaWxlcywgdGhlIGZpbGUgc2l6ZSBp
cyBub3QgbGFyZ2UgZW5vdWdoIHNvIHRoYXQgYW55b25lIGJvdGhlcmVkIHRvIG91dHNvdXJjZQp0
aGUgZHRzIGRlZmluaXRpb24uCgpXaXRoIHRoYXQgaW4gbWluZCwgbWF5YmUgdGhlIGxvbmctdGVy
bSBzb2x1dGlvbiBpcyB0byB1c2UgdGhlIHNhbWUgbWVjaGFuaXNtCnRoYXQgYmlubWFuIHRlc3Rz
IHVzZSB0byBhdm9pZCBmaWxlcyBncm93aW5nIHRvIGxhcmdlLiBBZmFpayB5b3Ugd291bGQgYmUg
YWJsZQp0byByZXVzZSB0aGUgZnVuY3Rpb24gZXZlbiB0aG91Z2ggeW91IG9ubHkgbmVlZCBta2lt
YWdlIGFuZCBub3QgYmlubWFuLgoKRm9yIHlvdXIgcGF0Y2ggaG93ZXZlciwgSSB0aGluayBpdCBp
cyBmaW5lIHRoZXkgd2F5IHlvdSBpbXBsZW1lbnRlZCBpdC4KCj4gPiAK
