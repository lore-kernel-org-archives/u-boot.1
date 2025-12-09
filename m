Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4776CD3B7E2
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 02:20:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 572648398D;
	Tue,  9 Dec 2025 03:20:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="SzIYzMmn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 612D683AEE; Tue,  9 Dec 2025 03:20:23 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FE00838CE
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 03:20:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MG3u1lvafTXB1ly46EvbgqH9bsrPWliVzDlQvaDK9OpCUl6EXqLWqCbScBNgDVEVtFYKZpSbNvh0UymFfzTJvH/+XsUMDzC+hpwOdsoPRDRzZUug7Erme0QbkTk09zGQqLX034v1P0GJ3K3Et4hfwTA7u4H9MP/ODktKy250ZxIhOt6nhpfNa8IwZgjnBYt5uujvxNsnm3zEk0Tead6PpFYXmCdxmeuotxCvsQ1eGMPrjdQ91ItNVuYFoqy4xPVi/NaFzMkDGSCLKrr6P645m/H/S+1cauuVohyHoqGGXsn5WA9cRJ7UY/lwZ0XapmtsWR45e/m/b7LrTBIatad7mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6sbvEwzbVY/KOyXQ+U9Hxuccv4QKBFHTxP9Zf+6rOeE=;
 b=aPI8v/B8gXBuqLCU102pqDIVgVSTJ9W6nl8iXPgTDrL+MMJJHzwJdomwmuvP8egqtXGq3jfKKF5+RTAb67a60u3dV8M4hPQaF2mlyhVPIuduJmkEmKtv852gdUWyF/jorl/FbqCSyfiH8+/1zyKNvORbl2hIqP9+tAv/p5tj1G7TdKTwjc+ZQoOuQo7wu7hCxdvgvnjJQ13UBdIFHhABLuQpPLkVuHaXIQs3uRCEbKxGfhkmEErVUlvgUGMVTjiKlQrzi3I+FRxYWb9YPs6We5lj3GinHIZ3pN+hVLK5X6jZLqoVWi0NScHMg06viz0AJo5bG9tlJxgmbJc+5N670Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6sbvEwzbVY/KOyXQ+U9Hxuccv4QKBFHTxP9Zf+6rOeE=;
 b=SzIYzMmnVEoY3Sn4pXKV1Dt6TWIHdB45zOOK2rUGD5QpuBOj0GlJ0p/s8HuQgWu/Lm4fMzyDub9BjBGSZBNgheYv2e3tBm9C+l6TG1MLdK2QBMXymtrOuaAqSC1brk+24TrprgPVRiyOeafJQSgSrhl9a+Ho1OYAl/ewsvdt8ZwActLqGyTajuXgkQhWTN2HuKfveUHlD2ynJpSsdea77dPQufqnKTVvZGNwtX2iqF2rbUkCFruva1vNfs6KoqL4ygwxfca+BJpn3fCs8O5rDeGGQSWpRzJvdAvJMsN4mFz1bFXg8VjtlbQFfO0cBug/wV8etN9i3SU61xVa3TmYdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DB9PR04MB8331.eurprd04.prod.outlook.com (2603:10a6:10:244::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 02:20:19 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 02:20:18 +0000
From: alice.guo@oss.nxp.com
Subject: [PATCH v3 0/3] Updates the i.MX8ULP EVK board support
Date: Tue, 09 Dec 2025 10:19:16 +0800
Message-Id: <20251209-imx8ulp-v1-0-c58c22834737@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACSHN2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDIwNL3czcCovSnALdVENLCwsTS8M0Q8NkJaDqgqLUtMwKsEnRSmXGSrG
 1tQA9A8TJXQAAAA==
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, David Zang <davidzangcs@gmail.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Bernhard Messerklinger <bernhard.messerklinger@at.abb.com>, 
 Hai Pham <hai.pham.ud@renesas.com>, Garrett Giordano <ggiordano@phytec.com>, 
 Parth Pancholi <parth.pancholi@toradex.com>, 
 Johan Jonker <jbx6244@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::15) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DB9PR04MB8331:EE_
X-MS-Office365-Filtering-Correlation-Id: e5ddd5ff-7238-4c8f-0201-08de36c97f5d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|7416014|376014|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YldWYklXQnRiN3dXd2lNcDlOaW03TGdxT3JuS3dvVEMwR2Iya0VuOG1zNDBq?=
 =?utf-8?B?RDQ2S3JPTjBDN2xmVDNEZTV2aDRmU1hnYzluVHQyZ3lDVisxSndlRU1qajRV?=
 =?utf-8?B?RU41U0JDK3NKMEF6TG5mTUdCNm1KeE5UeWx0NVV1NzJsVFBtWndKeVlGM0tu?=
 =?utf-8?B?ZjR3ZU0ydit3dDB4Z2JGTFZKT0wrc3NvbDVpbDFhZzlPSXlDL0swcWE5VGcy?=
 =?utf-8?B?TFpRS3lxTW9JSW1lMXZRaitWZHBaQ1FrelJBQTJJKzd1Zk9qUUNLekVXSUR6?=
 =?utf-8?B?dVJISzZEMXNtRHVaYkdYT2FVaCtob3VwL3NnOTVmc1VYdnFXZnVPdFQ4QmVG?=
 =?utf-8?B?ZkhNTWN2ZVp6WUlyM1cwd25LZStKbDBaSVFUeEN4WGcwQy8xeit6NHQzZG9j?=
 =?utf-8?B?dEl6a2ZCK2J0UDRPZnlBbXRwSWkvS2tFSHE5ZE1OcHF1L0U2OE5GZlVMOVFY?=
 =?utf-8?B?Y1lIUThwUngwWnhMQmRSanRUeFpTYTZQeEtreEQ2dGI5Zk5HT3pqOXlqRHht?=
 =?utf-8?B?R3BTbm00K0N5WlNXWFJ6ekdCM295c2NNUzhZek01VFljNmtacnhkREF0Z1pQ?=
 =?utf-8?B?L0RpYTEyVkFUY2pzK01IeCs3SXZJU3o4Vzh6R3BhODN0d1NIa05pa0xRekly?=
 =?utf-8?B?eTh0SEhBMm9yTEFBYnZjcVBtbm9CVVgzNlgwQ2V6L1QveDdyVjVBeHJveE5Y?=
 =?utf-8?B?clhDNnA4U01QMHFYWlZSeDN0NDNQRFFhL290M3FIZ0J0WGlpbUE3NjAzT2tR?=
 =?utf-8?B?WDBHcDF2Z0c3dnMzVUN1Z0dVcDlTeFE4VFIwSitPVUxRMXdGRzh0QjhhTUkx?=
 =?utf-8?B?dFhqNlpzck1iSXdYTms0emtsNWJuZ1BLQUhtaFBsa2N4bXRUMHNnbjV3Kzkw?=
 =?utf-8?B?dVgyeUVKZlppLzc1YzB5THRqSy95emQxb2w3TTZlbzFueGJhczBFU2NjdDZT?=
 =?utf-8?B?MllOQ3Bmai94Z1czNVpFd2dJWTNVN1VGZnhXRXpRUUcrWm5IQkVHMjFOMUJE?=
 =?utf-8?B?c1Q1WXgyNWZ2SVBFWmp1V1lqZEpQM25NUjk3SmZvbE44elBnQUZyTld1Q1pH?=
 =?utf-8?B?bERUb3AzNGZiRkFGdVVjY0ZwSGpGRy94V0h2TXkyVkxyQlFUcDZkZmcycjlx?=
 =?utf-8?B?ZzZocEJHU3UvUnhYRUJkYnZlOGJNdlJERXc5NjRudHE5dU0vZWQvbTRLOU5B?=
 =?utf-8?B?Q0FIMjVSRkZtZ05IOGtBQWRPNHcveFl6MjlsQWIyYm04dnFDV2FVYmZEdGxh?=
 =?utf-8?B?NkdDb1J6N1Z2K1A0RGNHQ3lKbmhwbk1odFpBZUZwaU1jdlBoeU9IcjdyMU9z?=
 =?utf-8?B?MFM2VWNXSitrc1VGeE9SVUFLdENCTFpZUWtManBGalVBWlBmRHY0UWE4SExO?=
 =?utf-8?B?aGdDTDJuVStJNjY0cUczbmw2RWZyOVVseW9qeFNBaHQ3Z05CL3BKSmtsQWN6?=
 =?utf-8?B?YkQ4dCtPd3h0Qmg1VWozSUdyd2l5czI5Ujd6REo4anFpeVA1Ynd6MTVhdWto?=
 =?utf-8?B?dWx5Nk1peFEzdlJaczdXWFg0c0wyMThoRDlvWlZFbVJtaUphNUk2eW1aU003?=
 =?utf-8?B?T2FCWGpySHZWbk9DbGNBVVFzTjB3TDFuRlFlM2d6dDlDcGJyRmg1bUJjaURa?=
 =?utf-8?B?blFwRVZxMktOT29sQXhHZURvNUc5YjBQekE1cWh0bC82SldIcmd6MmxyUGww?=
 =?utf-8?B?NVBJcFkxdVVOQW42NENSRHV0djBSZ3JPRjcxbUozYkNsRWV2dmhqOXdja0tZ?=
 =?utf-8?B?TXp3MzRQV2VMR0NGcVFERWNPUTNjaVF3TWpsbStlSHVEeVI1MElvLy9XTFp6?=
 =?utf-8?B?MEFseVBneVFHZDJ3YXFiUGxuQ1RlcmhmRkxFdHhVd25OaWZqNWg4T1Z1TTBP?=
 =?utf-8?B?Q245MVRORTB5bmNyazBFQkFid2cwRTFxWi9ydHYxZFErVlRLVDBVNmVTbnFa?=
 =?utf-8?B?dHZZdnR4WEhGa2tzMDhHZmxDbmpCcnpOUk9xTnFYakE4SGJHS2IyU3REbEUr?=
 =?utf-8?B?eG81bHBFalVRY0VoOE1vbU1yQ08wM3JZNnd1VlUxTFJDbSthaW1nV1Y0M3Zm?=
 =?utf-8?Q?Z2PsE+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(19092799006)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkRkZ1lXVHdSWHNycGpmcit4SHROT1g1dzFQRklQWWlFM3lqMzNLWWkvY3FD?=
 =?utf-8?B?dFJDSis0Z2xNRURKbG1xS1VSbHIydnpLMHB6c0VrQmdDdXJKbEJQam1GVi9o?=
 =?utf-8?B?RWY4amdjdWdzbEtCWXQ2Ymc4eGVoWFNlelJvNzVZK0dFN1BGSi9nVHpNQ1NK?=
 =?utf-8?B?V1NLbWRKN1pVbHh3VEtjaEN2aGh6ako1Wm0xWHJWQWlHdkorT0VwUTYyM1VU?=
 =?utf-8?B?a29wTUNldlNPSUwzbzJBRGdnWmdVK2Z0cW53UXI3Q3ZOVnNJa2NWd1A0MkNr?=
 =?utf-8?B?RWtqTGFvVGJPSUhWWHM4Vm5PdHUvMlhWTzVWOWlKZm1YRHdJQTBtNmFMTW8x?=
 =?utf-8?B?cXEyMjlqUlRpODZkYXQzQ2pDM2RsN3pxWmswWURPZU1IL290ekt3RTFkNFRi?=
 =?utf-8?B?R0FoRk1aejlhcmYrZzhsY1ZWWVNEMHJDMjJFLytSblB0QUZuRE9XUHdDek9a?=
 =?utf-8?B?NFRXbCtyNjBncWZGR0d3dG9XMTg5V2p3dWNWZmYwMVJkZ1VMSGkyNWZma0lu?=
 =?utf-8?B?dTEyc3YwRWxwOUwxbU1pRWtHb2liYk56ODRjQzJMUDJXeFhsQldkc1dJc0k0?=
 =?utf-8?B?MzJ3bnhhTExKcWpmMGd2cWxkSmRmNThCTDRBeHRWaHpObFJhNy9YdnA0MkxW?=
 =?utf-8?B?RHBSZkU0M0VJUzZWUzlWUW5CeGVJLytUam8rODUrWTZnVXZ0Vk5NQnNaR2xi?=
 =?utf-8?B?bTEvUWVmZ3IzYjJkL1JEc0h5L0tqVmljK0RxMk5jSVZLeGxSV215T3R5K1o4?=
 =?utf-8?B?MUFFZGMzeUMvakRjZ283cmZ5VzZJNVhZRkgvNnVGVno2MTN0ekJ0VXFhbEo5?=
 =?utf-8?B?djc2d2dqeUpsQ2ZXYThLSWs2eENXMlVFYmluSjdqTitMMmg1SW91bkd5bldO?=
 =?utf-8?B?TEpQRHpiNXo1N1FBYTdsc25iaTUyK3dGVVFXZEovNVRTWWo3QVNFVWc0Z0tJ?=
 =?utf-8?B?RG5zY3NqdldHbXNQWUU2cFdaSGdNKzhQMXJjdDU1dUNrZ1FYV1hpZzdrL1ly?=
 =?utf-8?B?Q1dlVlNVTEFRbVJFTCt5ZWZUNE9UckZvMFM4QmxrMmdmOG4xUFpBNkxtMDgr?=
 =?utf-8?B?WjBXanFlVFRweHRTS2Jhb09KUjFjYVFRK3EvSUJkMzBmaW9xd1QydFdWeWVH?=
 =?utf-8?B?US9yOVhvK2V3TGNxYWRpRFFCRG5iRFh4Q2ZDd09jejJ3clp2QTFacmlVRUpC?=
 =?utf-8?B?bXhCZTBZVmsrZkJiV3dQZE1qbnd2c2lsZzBMMnhZMXpiNHZaSlVGVm5HNnhI?=
 =?utf-8?B?TXlkMGQ4Q3RYNlN2OGdWQ1M1dEZYMmVYNTNGY1Y1UFhUaS8zcElLdXZFRnQ2?=
 =?utf-8?B?clJ4UlV0bC9nUHV1OW5WNFE3bDJ6MUFCOWI4Z2FkZXl1SmJZYUp5WXVveklh?=
 =?utf-8?B?bG1VcUtmWm5IYmphekx1Nk8xZHNBb1AySC9xaS9QSEtuL1htY0QyVnhjRzVM?=
 =?utf-8?B?RW1LVU5xWDRPMzhFSEhRUlhETmIrejhUY2dieWZnb2NRUzNKTy9PaHVTYTNh?=
 =?utf-8?B?TXZvUXltUWNMRUJkNEVnaDFXTkVjSjNocHpBYWZ2cG43dDJZOVg2WnNWU25R?=
 =?utf-8?B?Y0szaXlERXl3NkI2WUxrSmNJVWxVNHlCNE5ZeEd2QnFEM1dEU0JUejJCdVdm?=
 =?utf-8?B?aTErRWhQUVhxY3dWUmtrTkhHZG9IZDM5ODZUUEZScTJTY1lSYi9RMFY1MnFV?=
 =?utf-8?B?aGEzejhCSGtXaDBLditQSGJUbU83ZFFxT2pOSmlWbDY1a0xQZTVuMUF4ZVFp?=
 =?utf-8?B?Q2lSTCt6d0RHaWdZQTYwS3hscDhUM1JRcDNiT2t3Vkg3WjZheFVseGIzL3F3?=
 =?utf-8?B?ZUpVZFFsL0xvK1lCeDUxWnVPL1o0ZGZqQWx5SnkzTDlqdnlOSWRLV244S3RC?=
 =?utf-8?B?MnduYmlCU1NpRFNHNnFKdnJFaEY2TnVSUTd1Z2xSWTZmYXpDcmpRMUlGZDFW?=
 =?utf-8?B?Mllpa3B6VVk4M3VDRXBHcW1IRTh2L05GeGdnd0NNRVptVm5mVkJKSGlnNjh5?=
 =?utf-8?B?VmxHVUJuUFUzR0JCYktpWEhzUzJaRzZ4THI4dkx4d1Q2bThub21rSmJqeitn?=
 =?utf-8?B?VEpHb0lyTzhhbjM4bnUxdnFnQlJLTHlhSzJNbWUwUmFVZWtqYVl3QXdvc2d3?=
 =?utf-8?Q?MrICkf8HEtpbcwybTa//MaGQM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ddd5ff-7238-4c8f-0201-08de36c97f5d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 02:20:18.9137 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DS/dEC/KXXMdLWKODeOu48mUDDmZqi04b4SVu5VdFON2wwVJaV1MZQgbF9ng4QFkXijTx3nNMEDVg4/sxINLVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8331
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

Changes for v2:
 - Delete fdt_high and initrd_high from imx8ulp_evk.env.
 - Remove arch/arm/dts/imx8ulp.dtsi and arch/arm/dts/imx8ulp-evk.dts.

Changes for v3:
 - Split v2 patch 1/2 into two separate patches: one for bootstd
   enablement and one for env.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Alice Guo (3):
      imx8ulp_evk: Convert to standard boot
      imx8ulp_evk: Move environment variables to .env file
      imx8ulp_evk: Switch to use devicetree imported from Linux kernel release

 arch/arm/dts/Makefile                       |   3 -
 arch/arm/dts/imx8ulp-evk-u-boot.dtsi        |   8 +
 arch/arm/dts/imx8ulp-evk.dts                | 125 --------
 arch/arm/dts/imx8ulp.dtsi                   | 476 ----------------------------
 arch/arm/mach-imx/imx8ulp/Kconfig           |   1 +
 board/freescale/imx8ulp_evk/imx8ulp_evk.env |  97 ++++++
 configs/imx8ulp_evk_defconfig               |   8 +-
 include/configs/imx8ulp_evk.h               |  24 --
 8 files changed, 110 insertions(+), 632 deletions(-)
---
base-commit: 0e0a198a68be71148f5ec27ef86796174f91436f
change-id: 20251209-imx8ulp-e1988491f11c

Best regards,
-- 
Alice Guo <alice.guo@nxp.com>

