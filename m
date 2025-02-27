Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E995C021BE
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 05:08:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69AEC80FE1;
	Thu, 27 Feb 2025 06:08:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="ZbxvZ+m5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 882D280FE2; Thu, 27 Feb 2025 06:08:18 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20717.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::717])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18222807FB
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 06:08:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jQMq5Z1lqRyqp60ou3iy5fDBEbsPPMSI/9UfWFMcR3QpgPdveUcJIjXpIf/ZBGuwJUMAgXqgR+8bWv+Nxx+KNTriklu1zzhcFtU7dXEDEzBJstZdj09cuYM5mM5z4HtMu0dMXEAtMQW6PXIRxcaYPbr0xEeQ7KJ/71hqVYyhLSsQRaCINaFHZsX/+d9Diyw1VHkHKq2H3Zc9yNvoyj/O+SgxEfRE3vKaCNnriHteTCpjE23CkPWYosc/PTdHv/VY2PNgTmGnx+GBB0jj72199Ohqt7Sy0EC7Zf/1+rVpptLE5z9lajkP8BAoFTwshsDH5bOWH2r64f90TQIjcuNUFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EU1/5PE8v7m8cLOZxgcfA1Xb8ZOE5EwYxMdttWnszi4=;
 b=qNB4g93Svaluly5fBlv+qPsPXhuHUxKDNGqPj3Q7zvSP9sNo+qax5aofs2LoIFBTYe6ZiBNfxsUbj90stE2LMJWPDdh0iQWUCkOBMUbwoRhXgkO22Ge4Eux1IWvtGihfnKtRiOii1q4n2iuAKy/gFqD2lPWem8xnhNRunnaIXT4UvGzjKMqnuveR8e3zeCxfOgzukvejHz1o0HH42ZYjSCWpcvm/c3T1tfMkYXJ9LycekgE/ASRkT79165ya3S+Elz1t4VbF09TtB6pj1n7b/kQ+w+rAVt7kVAr9dbNiFA/SFYBaw9dZk5eaYdlSbFOrIwtlRk5qP52K/aWHnvYnYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EU1/5PE8v7m8cLOZxgcfA1Xb8ZOE5EwYxMdttWnszi4=;
 b=ZbxvZ+m5MQJxSHwctKKYXIsLiLV/Gj9lFBeTU+HmjWeqifxb7o6NStIp0aAzodFPt4VaRzBU/poZDpD+OceJTKRQXn7qJAbNaEzWZaVFy4roOe/5WxD6Tn1uXzk+KlZfkPq/QXhaFL4xfmKqKZ/VWnIwLy+XQprDeQd0rG1oG2Av2OKeI9px+EiJl2Fzwh/Tb2nw3cuFHgZD7gPW+5pRdFTkT8b9jLvT/uR/jJl0vUindOwAG6lN7q1AcTvACmlO0RBGLzgmSu5+Vsa/D9l4k719D+pVZ0lViIsGSy7LRB7UlH2Jd1QC01rLYfsdOjw4891kAalVsKNrDVvV1m2Iuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by DU2P195MB2345.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:498::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 27 Feb
 2025 05:08:12 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%7]) with mapi id 15.20.8466.020; Thu, 27 Feb 2025
 05:08:12 +0000
Message-ID: <08b7d14c-1535-46ea-9970-26ad2688e2f2@phytec.de>
Date: Thu, 27 Feb 2025 12:07:58 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] board: remove capsule update support in
 set_dfu_alt_info()
To: Jonathan Humphreys <j-humphreys@ti.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Udit Kumar <u-kumar1@ti.com>, Simon Glass <sjg@chromium.org>,
 Devarsh Thakkar <devarsht@ti.com>, Hari Nagalla <hnagalla@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Santhosh Kumar K <s-k6@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Daniel Schultz
 <d.schultz@phytec.de>, Neil Armstrong <neil.armstrong@linaro.org>,
 Aashvij Shenai <a-shenai@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>,
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Lukasz Majewski <lukma@denx.de>, s-vadapalli@ti.com
Cc: u-boot@lists.denx.de
References: <20250226223547.393611-1-j-humphreys@ti.com>
 <20250226223547.393611-4-j-humphreys@ti.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20250226223547.393611-4-j-humphreys@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1P15301CA0062.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:3d::13) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|DU2P195MB2345:EE_
X-MS-Office365-Filtering-Correlation-Id: ab701777-7994-4500-2798-08dd56ecbc0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|7053199007|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NFo2YTQ5TGJGTkVXcnplaGgyOVAxSHAzUm9BeDZ2WDVMQmt6NG4yKzNCUEdo?=
 =?utf-8?B?aHpISkowRnZoc1lEMmZoWkcwU21iOWZyM0tOZnRiSE9uSVBQY29aMHhKajFl?=
 =?utf-8?B?Y2tNUGRrRUtzTE9MZGJKcldlUk1hVUFWdVV1N08vSTNWcGJiRGdWT0ZBRitu?=
 =?utf-8?B?cDFIOVVZWWNVaFEzTmlGcGJsNVhEU3RnbHpsQVNqN3dueEVVNi8xRW14bEZE?=
 =?utf-8?B?Z3ZFeWFNZGFGVGlkaktmRGljQ3pXdllWVFkrc3Z3QkRZQUw4Y2UwSmVENXRL?=
 =?utf-8?B?WmFLaXhpaE5jeHR2cEkzRzZhOVR4SllCMlpTdFN2OC9ydDh6VWFHR2h4UGhk?=
 =?utf-8?B?M1B6QzlyVlVhK2w0LzNKdEJ5SVFkWnFVVTZYZmt3cVBrandoeFlXamYzQjB5?=
 =?utf-8?B?SHo3Q0hZVFhaQXlEZXpQQ29aaWhlY2EyWmpQcnp2KzlpUURaTS9GL0NnQU4r?=
 =?utf-8?B?Nk9Td3lYb1o2Ym1sSTJtR2VJcUhRdUkwdHU4V3FCSnRxZTZ5RkJLbW5zd1R2?=
 =?utf-8?B?UVhEeEF6MlNJQnpoVnRVYVhJWjNsRGo4ZDZaK1UvdVMzWkhCYldDcEEvK091?=
 =?utf-8?B?dCtpSlVWbG1zemdjUXR5ZURFM2d5cGd2QWE3UXNrbzhDZVJ6UGNqTlEwUkp6?=
 =?utf-8?B?ZElpbzZuQUlIT0p1c0ZaRlE5NUNIZEpUMGkrRDMyeExmbEg0SjZ4TzBHbk9O?=
 =?utf-8?B?K09BTC9XZ21MV2lnUjBuOVVqUWx1MlJlWjBoOEhFdm9vdmJoN3dPK2pFcEpp?=
 =?utf-8?B?SlJOdUtraFF4VFFaZ0swajZuQkZZVnRVQ0Q5Q1hMUGc3SU82aXdJWHptdzlK?=
 =?utf-8?B?QjJTdXVEOUkwdTBkVTZOTkc3YlNUUmxjSlVkTE40VXd2SHZEMkgrUkg2Y293?=
 =?utf-8?B?UFJvVnVMRWt2djQ2NFgxSTcrR0gyNFhST2haeDVmU3RjOVNIUFhBODVXQW54?=
 =?utf-8?B?SDhTSnpRTytzTXI3MzNkaC8zSVJGWEZSYkpjNXdGd1kvUEJuWVhqTzVMVC82?=
 =?utf-8?B?UWlzSTVmYXcxejdYY1ZnUTc0S3Nyd2lsVnpub2VrWnB4SURoaTY5TFZDQkIv?=
 =?utf-8?B?b2JiNE55NC85UTdmYllRajlkS1JxL2szNENCOWRlYXNudFMrd01PYVkwSUxG?=
 =?utf-8?B?d2VoOUhqL3FMUm5Dcy9lK0hmRFdMbWNUY2NYOG5wNzNldVhpaFg2YXdUeSsx?=
 =?utf-8?B?YmVpY1dBMExTWC9td0M3b25mZ21KbDF6dW14S0JVSE9neTB6YjRkeDM4c3Ri?=
 =?utf-8?B?VzJ0NHJ2NytubnhuL2xVTnpoekxQd3dwcXVaRXBwK1lBc1dvVURxczczYjB6?=
 =?utf-8?B?SHZWQUMwNi9kcnNCS05pZHdBSWg5WFgvdjVDSjgyZE5SNFNHODV3VzVsYjZy?=
 =?utf-8?B?YmRaTmZFeXc0VnFjZkE4K2xnc0luOTh4SGdIVHRjajEwM0RkOEM1OFF0ZWhO?=
 =?utf-8?B?QUxmTDVyaFQ1c3VVT1Zhd1NxMXYrY05Wcm1MaVlleVQrR3YxNG40Y2p4a1Fz?=
 =?utf-8?B?RStJWk5OY3RmT29XYWRJc2c2NmgzUldlQ1pxL0szU2ptdXI0SGFqQU5mWnc4?=
 =?utf-8?B?SVpHbWlLSmhtc1hHamwyaXEyTUkyajVPdFBxZ01zQzNXNTZnWnlmWFJqZHc2?=
 =?utf-8?B?U3dTNEJQL0ROUXVCYWNUQkU0RUhYQ0E2SjJ5Z1VteFBxYUVCZFRDYVd5eDk4?=
 =?utf-8?B?cUdVWlJaYWw2NTcwb3RJR3FKdDEvek1vWlN1cDJ6NDk3Zy91TU1Rd3lZeHVY?=
 =?utf-8?B?dzBuNkNCc0xmckdQczBSeDBYeDU5WHNPaDI5NW5pYTlDdTdlUDZUWllmbGlN?=
 =?utf-8?B?dHV6cWFTK1NMUlJKTmUxckk2eE5SZkQwdEpHWlBsL0ZDVEhEcldXbkhIOUVp?=
 =?utf-8?B?bURaMmprSGZVRzlucFlicmp6eXluRzl0Y3gyazFFMDNNYmlmbll3NlFucklT?=
 =?utf-8?Q?9o8DDC1teQA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(7053199007)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q29zSzhjSTBVazZmRzhobk1qL3VQcEI3aGF4RGw3SUxXa042eGhZcnI0aG42?=
 =?utf-8?B?WTZqbnBKOVpzbk5SMTlvcUZydnc5SHZtaEpNNDFwcnNhVCtxdHlObjlkci9G?=
 =?utf-8?B?Wlh0UlI1VXh1b1RZZXZ4aVljMVY2M1YvWGhLY0hhQzN5a3dMdWhyM3FKSTlU?=
 =?utf-8?B?WlZZSzB1OHlkampEVnh4Y2U4UmI4TFQrZGJTZVA1bGNXNlArVnliVjlHK29N?=
 =?utf-8?B?V216bXNsTjVUNHlQMEkxaU1RMGRVUlNCblpESXl5dmxLZW9UTGlSYVRwc0h3?=
 =?utf-8?B?UW1Rd2p2dVRuNnpORWc4UE5KNUwwR1VTcUwwalAyZVZSNjQ5cHJOMlpjQzBR?=
 =?utf-8?B?bVVOTDQ0NnJ6c0RCWThOcGhUVDF5NEw2VW8yd3ZlcllSZStzbVBueFMvdjJz?=
 =?utf-8?B?ZDd6THR6cFI5anI1RmNMc0h5WG5QUmg5SktZMUxOdFJ1NG0vbUVFUWpqWmpy?=
 =?utf-8?B?SEFYd3ZoZjN2SVA4dGNQcUpuZ3Jac1c1ZFpFcnZBSGU4NG4wYzJUT05pa1V3?=
 =?utf-8?B?TTg1TURBcmhtdm9QaE0wOU1ONEYvTzNHK2k2WEIrSUc1ZEFPYTU0MU1iUklF?=
 =?utf-8?B?TW16clVwNi9pSHFsUXArWWtVbVh1QUQ4cW10WFBocXVubWRZYlVDdE1rMENl?=
 =?utf-8?B?ZmJMZzhIVzc0QjhFUllGd1I5VGRrTThET25LVnkrVFR3eTYzUE9UK1hCdmw5?=
 =?utf-8?B?Ukt2a1VlSDJkelpJZ0ZzMTh1TitSYWhkNmhoWForQUQ0MjJONkZpNTZmbHor?=
 =?utf-8?B?WVNiWFZwaldpbE44dngxT0w2U0ZMTzh6M3hISjRIRi81c3VBZFNRbUZacWNO?=
 =?utf-8?B?M2pyLzNLa3htYWxBMU04c1Q2Z0laZzJ3S2ZRa1VFeXQ3aDlqSEhjNFR5Y1d5?=
 =?utf-8?B?ckpENDRUNEZaZ0lZMWFLN1c1bEJUSVRqd3dJQjlYK1E0SGxDcEx0aTVJcWRY?=
 =?utf-8?B?SWVSeGcrdHc0SHUvQUNTR2NIdUJZNVRiMDUyWEFpSkNZSW9xNjd5d3o5VjVE?=
 =?utf-8?B?eGVTblRXTTE0Y3FzY2tWYnFOc3BKVGYvM05FdWQ1QU9URTF3eXllY1kyc0FN?=
 =?utf-8?B?K09QaXBacjdWcmVna0ZpSi9yamt1R2VZVjFUY0YyZzY4cFJteHFqY3N5a2Vx?=
 =?utf-8?B?UTlhb1FWS3JkZGllOFErcTlGSFRpMlJRU3d0bkNoM0dqdmI2MW80Z05pM2NG?=
 =?utf-8?B?RWVHcFJMRGZiVDVMRmRJdjkwdzErMUtXZUFVMzdzK1I2WkxHem4wTkNCNEp5?=
 =?utf-8?B?cFd3aDZ1QU55SXhQU1hWbmNUNnBQZVBxKysyZVU2KzVCQTFKQ3lYOGlkVUhR?=
 =?utf-8?B?eUJCZnFtaTdWNTA5bnB1aWZrci9kTHBmRFp5VG1yRFZIUnd6QVBkQWxrbnJK?=
 =?utf-8?B?dWtjWFRZTzNERmdOODBqS0E5dncxbEpjSU1uZ3htOFMwT09rYXFPcFprWnd5?=
 =?utf-8?B?R2VPMjFzYTV1aHdoVmcxQWhiQ1Z6Z3hPOUFNQlZ0SnVSRGNQT0ZhelgvWElD?=
 =?utf-8?B?dDlVd0JURlJxTG9XdTB0aGZiYmdMSVh6b2Fwbkh0ZXFmVjhSUnFod0UzK3Ba?=
 =?utf-8?B?RjVXTnJVYkFaTnFrQUVtR2FETEw4WktrNlZwTWVhaEJqYVA3N1J6SlNaL2tF?=
 =?utf-8?B?ZFVDS2ZjME9KSlZseXZUSWhtWDZNMVlhT1RUcW9BQTFKc1M0N2srUkpsNm1m?=
 =?utf-8?B?R3N1S0lUemNLKzFPK2xBOVpTMG1Ma3FZTHlCeXZ6MjNMM2FmRFZqaTQvTlZ4?=
 =?utf-8?B?TVh2K1N4djBoTlc4VUJQM3M5VVlib3ByeFdMckZWckpPY2xFMm90YnkzcEd2?=
 =?utf-8?B?Uzk4VThDSStOclUxc01uSFphLzhTNkswWmN2SXdlaiswT1lDNzVKU3owcWRw?=
 =?utf-8?B?cDhoTWxGdElFY3BYdW9XTGErb0pWT0docUJwVUlMaWYvYmZtRUNHTVduMElG?=
 =?utf-8?B?WWRrMk1lT09MV05PUHZRejBKU1dNSzdCS00reHFiVk1yeS8zZmUwNW5aUDFo?=
 =?utf-8?B?cno1S2h5WDFWcWs0czdJUThLczVBeThMczJGTmdtM2xDMWdnNHA0cUl0L1FH?=
 =?utf-8?B?UjJ4ZXdvMEhmcjBEaGE2ZzNKSlZYeWhqb2JjMGVDQmNxK1lKeTlpUXlCbTYr?=
 =?utf-8?Q?gqdS2jM2B2KE5JpYXqF/c/kcE?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ab701777-7994-4500-2798-08dd56ecbc0e
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 05:08:12.4974 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0gRpTC2cazAJvcliCpSLvoCAK+abikDyo8stn0eazqC6zzpqqij95DGx98akPebBJ4f5jP6/Q3BXd64dCo4FGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P195MB2345
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

Am 27.02.25 um 05:35 schrieb Jonathan Humphreys:
> Now that capsule update sets the dfu_alt_info environment variable
> explicitly, there is no need to support it in the set_dfu_alt_info()
> function. Decouple SET_DFU_ALT_INFO from EFI_CAPSULE_FIRMWARE_FIT and
> EFI_CAPSULE_FIRMWARE_RAW. For many boards, this was the only use of
> set_dfu_alt_info() so remove the function entirely.
> 
> Fixes: a9e6f01a941f ("efi: Define set_dfu_alt_info() for boards with UEFI capsule update enabled")
> 
> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org> # for board/libre-computer/*
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>   board/beagle/beagleboneai64/beagleboneai64.c       |  8 --------
>   board/beagle/beagleplay/beagleplay.c               |  8 --------
>   board/libre-computer/aml-a311d-cc/aml-a311d-cc.c   |  2 --
>   board/libre-computer/aml-s805x-ac/aml-s805x-ac.c   |  2 --
>   board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c |  2 --
>   board/phytec/common/k3/board.c                     |  8 --------
>   board/ti/am62px/evm.c                              |  8 --------
>   board/ti/am62x/evm.c                               |  8 --------
>   board/ti/am64x/evm.c                               |  8 --------
>   board/ti/j721e/evm.c                               |  8 --------
>   board/ti/j784s4/evm.c                              |  8 --------
>   board/xilinx/common/board.h                        |  3 +++
>   board/xilinx/versal/board.c                        | 13 ++++---------
>   board/xilinx/zynq/board.c                          | 13 ++++---------
>   board/xilinx/zynqmp/zynqmp.c                       | 13 ++++---------
>   lib/efi_loader/Kconfig                             |  2 --
>   lib/efi_loader/efi_firmware.c                      |  5 -----
>   17 files changed, 15 insertions(+), 104 deletions(-)
> 
> diff --git a/board/beagle/beagleboneai64/beagleboneai64.c b/board/beagle/beagleboneai64/beagleboneai64.c
> index e8d07f1f95f..99eb8972cf3 100644
> --- a/board/beagle/beagleboneai64/beagleboneai64.c
> +++ b/board/beagle/beagleboneai64/beagleboneai64.c
> @@ -45,14 +45,6 @@ struct efi_capsule_update_info update_info = {
>   	.images = fw_images,
>   };
>   
> -#if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
> -void set_dfu_alt_info(char *interface, char *devstr)
> -{
> -	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
> -		env_set("dfu_alt_info", update_info.dfu_string);
> -}
> -#endif
> -
>   int board_init(void)
>   {
>   	return 0;
> diff --git a/board/beagle/beagleplay/beagleplay.c b/board/beagle/beagleplay/beagleplay.c
> index fae69b37585..78635810585 100644
> --- a/board/beagle/beagleplay/beagleplay.c
> +++ b/board/beagle/beagleplay/beagleplay.c
> @@ -41,14 +41,6 @@ struct efi_capsule_update_info update_info = {
>   	.images = fw_images,
>   };
>   
> -#if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
> -void set_dfu_alt_info(char *interface, char *devstr)
> -{
> -	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
> -		env_set("dfu_alt_info", update_info.dfu_string);
> -}
> -#endif
> -
>   int board_init(void)
>   {
>   	return 0;
> diff --git a/board/libre-computer/aml-a311d-cc/aml-a311d-cc.c b/board/libre-computer/aml-a311d-cc/aml-a311d-cc.c
> index e45cfd5d8a3..24363d21ab0 100644
> --- a/board/libre-computer/aml-a311d-cc/aml-a311d-cc.c
> +++ b/board/libre-computer/aml-a311d-cc/aml-a311d-cc.c
> @@ -31,8 +31,6 @@ void set_dfu_alt_info(char *interface, char *devstr)
>   {
>   	if (strcmp(interface, "ram") == 0)
>   		env_set("dfu_alt_info", "fitimage ram 0x08080000 0x4000000");
> -	else if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
> -		env_set("dfu_alt_info", update_info.dfu_string);
>   }
>   #endif
>   
> diff --git a/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c b/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c
> index 94cf5b4361f..42442f26acc 100644
> --- a/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c
> +++ b/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c
> @@ -38,8 +38,6 @@ void set_dfu_alt_info(char *interface, char *devstr)
>   {
>   	if (strcmp(interface, "ram") == 0)
>   		env_set("dfu_alt_info", "fitimage ram 0x08080000 0x4000000");
> -	else if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
> -		env_set("dfu_alt_info", update_info.dfu_string);
>   }
>   #endif
>   
> diff --git a/board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c b/board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c
> index f641db5a494..5223f1c8ab8 100644
> --- a/board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c
> +++ b/board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c
> @@ -31,8 +31,6 @@ void set_dfu_alt_info(char *interface, char *devstr)
>   {
>   	if (strcmp(interface, "ram") == 0)
>   		env_set("dfu_alt_info", "fitimage ram 0x08080000 0x4000000");
> -	else if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
> -		env_set("dfu_alt_info", update_info.dfu_string);
>   }
>   #endif
>   
> diff --git a/board/phytec/common/k3/board.c b/board/phytec/common/k3/board.c
> index 9d833456810..58859f279f1 100644
> --- a/board/phytec/common/k3/board.c
> +++ b/board/phytec/common/k3/board.c
> @@ -82,14 +82,6 @@ void configure_capsule_updates(void)
>   }
>   #endif
>   
> -#if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
> -void set_dfu_alt_info(char *interface, char *devstr)
> -{
> -	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
> -		env_set("dfu_alt_info", update_info.dfu_string);
> -}
> -#endif
> -
>   #if IS_ENABLED(CONFIG_ENV_IS_IN_FAT) || IS_ENABLED(CONFIG_ENV_IS_IN_MMC)
>   int mmc_get_env_dev(void)
>   {

Reviewed-by: Wadim Egorov <w.egorov@phytec.de> # for 
board/phytec/common/k3/board.c

