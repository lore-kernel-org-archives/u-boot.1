Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F64C3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 12:35:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95B0F88A99;
	Fri, 16 Aug 2024 14:35:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="GG+OzpZj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F987889F8; Fri, 16 Aug 2024 14:35:18 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1BEF88AFF
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 14:35:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KzYrmgXQ+GOwkSeGW8Zyxs6R94W7JEfO8oNQXMU4mGr9OLPYNAfl8tJ+DEuVbMcL47GSOBgDVhLKNO4nqfaZsOtBPjPjUFaiKYuZOPHSxvMd5U90POahIrO5sH26n2/NdQPObg9QR8lS19wousMveiPUJa79gcFTes9iCgtETWBujZGjg2YXLshSido+sJu+MvtflElhA0TRtWCeWF4AXdD8JviLt62BtPT4wncrU9VVZEmb4fgG1nLgtq/YwFReLCJDdJHkNdNZw4F3Gv3AIgbtybUcYyI/7RyNQrMxC/7+7B0xTwDFLQHg3VRG9cLAxcJ1h+NjnAI2U0Vs2MIamA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8w7SptdhckyswnuNoOMXdYaVGwLR5tcGr9NBEX/QAY=;
 b=b76hV+o+cN3S0rPZ5IAz5t8sjOZZ6kakLT/f/65u3Sxz2bOMXsSkcEjhwr6UpsQVOTbMosd3S25px818Wi3wwj+36kpy3C0U8EUydy3QOoJWSglTJpeWiOrEA5cKk1b74cLk9+h0p/kyXNvmTeKHZ8hU1R0o2+Mg6FYn9lwvfwMRt7jRVAXymsD/kvWSFgggtA3np03v/3Ru6FOMzdZmMPuJcH52plfHfgevxRo45m8zgNYNCJbNKHff0LhNuduiFzdJh4Fe86E1RphXsK576VPx0ndVqligZUEwXOv927xjdpnUEDZseNy+Oi55SjI4jJvmuEl5jRSRc/uDGpRMOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8w7SptdhckyswnuNoOMXdYaVGwLR5tcGr9NBEX/QAY=;
 b=GG+OzpZjC3SCXZC04ZDOSBIFTGArGjxJM8gmqO/KAibz43emmtk2jkSOAQVLWz9dvIpMaEHCpObar3ql4BUAFKaZxGwWKRSD3+h2XzOhCipJckqNGb0s8L32iUmxsBUKLD4B/3ksjzndFX9yv+7BJRROJmVkiPaA3QsJKQoxbzCfRlKUcJsV5eE+Y1Nyz1eI2FVS10462++ohwfvSjZ9Hf8ZFnRDfPnwu9pM+1sFe4k4B5qkvBc0BScOPt1h5w0Q+Lfgcu25ZQTqMiMZAy2r3me7+GKKfXzwy+4wtExpEEMzJn9TrXCVeo8+f58n6XVLBj6F8WNyf1F/JJteM18NMQ==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by PAXPR10MB7630.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:283::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.25; Fri, 16 Aug
 2024 12:35:05 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%3]) with mapi id 15.20.7849.021; Fri, 16 Aug 2024
 12:35:05 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "bb@ti.com" <bb@ti.com>, "joao.goncalves@toradex.com"
 <joao.goncalves@toradex.com>, "c-vankar@ti.com" <c-vankar@ti.com>,
 "rogerq@kernel.org" <rogerq@kernel.org>, "nm@ti.com" <nm@ti.com>,
 "dannenberg@ti.com" <dannenberg@ti.com>, "n-jain1@ti.com" <n-jain1@ti.com>,
 "n-francis@ti.com" <n-francis@ti.com>, "mripard@kernel.org"
 <mripard@kernel.org>, "afd@ti.com" <afd@ti.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "seanga2@gmail.com" <seanga2@gmail.com>,
 "s-vadapalli@ti.com" <s-vadapalli@ti.com>, "michal.simek@amd.com"
 <michal.simek@amd.com>, "d-gole@ti.com" <d-gole@ti.com>, "danishanwar@ti.com"
 <danishanwar@ti.com>, "devarsht@ti.com" <devarsht@ti.com>,
 "w.egorov@phytec.de" <w.egorov@phytec.de>, "mkorpershoek@baylibre.com"
 <mkorpershoek@baylibre.com>, "jonas@kwiboo.se" <jonas@kwiboo.se>,
 "kishon@ti.com" <kishon@ti.com>, "sjoerd@collabora.com"
 <sjoerd@collabora.com>, "sjg@chromium.org" <sjg@chromium.org>,
 "u-kumar1@ti.com" <u-kumar1@ti.com>, "matthias.schiffer@ew.tq-group.com"
 <matthias.schiffer@ew.tq-group.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "kabel@kernel.org" <kabel@kernel.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "srk@ti.com" <srk@ti.com>
Subject: Re: [PATCH v3 05/10] dma: ti: k3-udma: Add support for native
 configuration of chan/flow
Thread-Topic: [PATCH v3 05/10] dma: ti: k3-udma: Add support for native
 configuration of chan/flow
Thread-Index: AQHazpbyUaMFHdfvdkGZR/olelbJKbIqFEIA
Date: Fri, 16 Aug 2024 12:35:05 +0000
Message-ID: <b8c2ad8d76c7c59133b3e9dba38d732de96791a3.camel@siemens.com>
References: <20240705045030.1141934-1-c-vankar@ti.com>
 <20240705045030.1141934-6-c-vankar@ti.com>
In-Reply-To: <20240705045030.1141934-6-c-vankar@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|PAXPR10MB7630:EE_
x-ms-office365-filtering-correlation-id: e9b06796-7784-481b-1c61-08dcbdefdb8a
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?TWkvcDZxdkdJK3ZlOE1XR0NPendKV3ZmbVkwVlEvRGQvN0FReFNUcmlEOFlj?=
 =?utf-8?B?QlJnRlNnRlpuZ25SR3BlVmoxN2NpMHdLdGtJWk83dEZtZENnbVg4dXZLYlY0?=
 =?utf-8?B?ZzVyOFVvUXNVWGw1Qjk2QzhSbUljK3dGSHp2OVFKelp0Vm1QZnBweW5lNzJl?=
 =?utf-8?B?NmJIVW9OU3NQbjFYVTJSamtqZ01qUlcyZjkzNnUxcHdhUXRWdWhyc3FXcCty?=
 =?utf-8?B?WjhHSy8xSEt6c1l3UEtBWHdUVEM1Y0M3K0FjNlJrRDhlbWMxdldPbmdRcHVp?=
 =?utf-8?B?WGU4Z05rWVFDMG8xQlBDM2p0a3lrYXBrT2Z6aFdkVGZGT3JDL1N0ZWlielJC?=
 =?utf-8?B?VUNSeDVVSEhtU3k3NnF3MlpyV0FHWjZSc3pkbk0wZHhvWU96UjZCSkNBWGhP?=
 =?utf-8?B?dEJhWm9RWkR1Z21kSFhCMmloM1lCZ2VuU24vM1pSNTFEVlJxRWFTRVB5UmJD?=
 =?utf-8?B?L0pDUnFQV0FCL2lFNGFYaERibEJReG9vK3ZqaDVWaDlxYjVOcGk1SHZkMUkv?=
 =?utf-8?B?VElPdFFiclZ2S3NoRHV0S2ZDQytydFRDRXdScC9CQUZpbHZYV0p5bDBTUDgy?=
 =?utf-8?B?UWZrUlppTXVyL1pobW84UVZsbGtvOEViUHhqa3I3MjJScTFuNk9KZHpsaWU5?=
 =?utf-8?B?cG1KTFdWYmhHWWlMVnJQazJHQUhtTGpRcitpSUlzYnJSbC9TdVlxOFVlM0Fz?=
 =?utf-8?B?WFU4U1Z2RU0wQ3FWb2RtaUpiTmR5T3Z0anpCMmV6QWNJaXNtNXM0SzFpc0hu?=
 =?utf-8?B?cHJoZTFiaU45SkYveW1YMVpiZnR1VzF3MDdYWXl5eVdiRStrcC93U2hrREVl?=
 =?utf-8?B?Z1RmMjVJbEFCNG9YS1A2OEdTYUN2TExXQjVKNTYwY3BXWlBacmZOajZxWUdv?=
 =?utf-8?B?TldnOFBlWm0xUzFWOGtpaHRab3dpMnJQK01rRjZGT1lMQ1pmRWZPcDVYYThE?=
 =?utf-8?B?MXRjVTMxdnRlRTA2MW1LRTBWdWdoM0pFRXArdDRUaTF0T0FlZ1NhMG1qVWwr?=
 =?utf-8?B?UUkvWnAvQTNIb3cxaHExZkRHUTY0bUtCWGU0SytjdVNUTTIyYlpLT29vL3ox?=
 =?utf-8?B?b1o2aWJkSkNoRzdXUnhzMUUwdCtPeUpQeTZ1d2NGN1VPejZUeCtaR0ZxRkll?=
 =?utf-8?B?SlJUYXJpdkcrb0h6Y2NQTVBpbWNvai8yYTBMQ2h1aVkyVkNMc21oZlRTc0pB?=
 =?utf-8?B?SzBvK3RyREVIMGVLRy9KUjRBY2lCc09EL0ZRd045NWNwaVBFamNva3FzdWpR?=
 =?utf-8?B?bzNDdHpIOUNLZHRuTW1vNE9tQzI2c2hIcUM4MGJHYVEzTU5JblgxN3kvcVQx?=
 =?utf-8?B?bjZWV3d1UmZjcWtiZVZCRDl1RTNPQmRaZ1h5eVZVL1lCNGt1aHV2N3hHdklT?=
 =?utf-8?B?U1dDQzdwZUUvNnRXOG1FanNYUFlSOFZ5Q29IK3g5K21tM3JNT1h5YVV4Z0ha?=
 =?utf-8?B?cHRBZUpYVGFwNy81V2tRcCt0Qk9XRnFFZ0lDbHNOd29ob1l3TTN4UVlmUEpD?=
 =?utf-8?B?VWJ1U212VldCc2gyV2F5aEJQb2JQTmkyeXhIM2pqQ3c1cDhrbUkwSzVLaFJD?=
 =?utf-8?B?cnlzRE1XdklEcGh0K2FieHJGbm5WelZ3YVBZdTR2cTduZWZ4REtKWFYrL3Br?=
 =?utf-8?B?VmU3UjE4Q2laNDBEbUhPaTUxNjRnQVpQMnB5d1NTTWVjMDhCMTBKQlRoWHdJ?=
 =?utf-8?B?cHNYUjdZNlJmdzdwSzNHVUpmU1p4UzN3TE9pYjBIZzJHQXg3dFhDbVQ5bmpo?=
 =?utf-8?B?N1Q0aVdRMU93RjJLSUFqREZ6M0lkRVFyemZjUm9wZSt3clIxMkhxc0xLci91?=
 =?utf-8?Q?OzncrAV1ogFdqkQyk726vvnQb02lWdP/2w7BQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZlRTeGRkY3dVSlVwaThBcStFbHhOc0FtcmFNZnJLeUxJcW04RHRYMTA0WXdC?=
 =?utf-8?B?YzB2Wlk4bHZMWCs4OFN2SDh5Q2xrVFJqeUExdW1mZnM0czA0TDg4VFRTcE5y?=
 =?utf-8?B?Vk9ldDJ5R2ZJeFZ5Q1l0SThzVVdZTzZ3QXNPUjdzaGF6YTFEaDZpSXdEbEdQ?=
 =?utf-8?B?OEhJaW5DVFA4c05pVTlLeWZPTUd3WWNuLzZqeGN1dmdEUGkvRmZKT1NxSnoy?=
 =?utf-8?B?SHFYYS8rRzhHWGhhZXNFamNhOUNpK2FJNWo1SWw0TVhEQUo4aEZ1VHl0bitT?=
 =?utf-8?B?U2p2SmNNYnNmOWhuVGlEdXBLR09qc3VLWE1aTzZwWmJWUmZrUWFSYUE3QzJY?=
 =?utf-8?B?YWd5bFJzVVZEZWYwL0JiK0hXUnlhaHRsenZZVGE3b212LzlrZnQ1bHNDQU9T?=
 =?utf-8?B?SjBSQkl3QjVkZUk5K3pXSTJwZjV5bWN4YUplK1lPL0k2dkxvNFhlelIrb292?=
 =?utf-8?B?b3NhcE9xSUlzZDgvbyttaU1Eei85UzdNVHdyaURvUVdJaGQ5dnh4dEQrUlBQ?=
 =?utf-8?B?VmFnaWVUT0pwVk1FdmMrNG9uT3F4cFlrWmh4eUV3L2E3dW1DeDlRalkwTVdz?=
 =?utf-8?B?VXE1T0l2UG1EeG53akY1OC90UHl2Ly9GUTVaN0t5YjZvdStVVGc2TXV6MW9M?=
 =?utf-8?B?T3p4ZER1aGhndGVYaCtXdnpMTjdweWFsai9SSTZHQVphQ3A1ZmpyOUtkWG9o?=
 =?utf-8?B?VThBR3lrc2hxMGplK05JRFMxR2grWll6VklNaWQ0cUxQdTFaZ3BGZk5pdmFG?=
 =?utf-8?B?eEtnWVA3T3psVEpPc1lLbVZlVHRvTTFBRUhJd3dLb2t6cDlJSE5RczZ5TWVU?=
 =?utf-8?B?UXl1NTFQeFo4ZWk5QnhzSVhzdjhXdy9nMHhGcGpnaHJkSGNtUVl2ZjZZcm56?=
 =?utf-8?B?MW8yV09yc0ppcTJoOWdrdXFHejRma0FFN2hpS2hsZ2h0K0pKNUM5dG1uRldD?=
 =?utf-8?B?dDIwWVRqbFJJV2taSE1tMmdGOUxDdVpHcmdWL3dTbzIwQXN5TmhYeUdsMnoz?=
 =?utf-8?B?L1VVYWlmYWVhQjFIcFJ4bGdKNHBubGN4L1QyM0FMWVYvYUd2c0I2OEpOT0Jt?=
 =?utf-8?B?T1h1bWZUdm9JNi85YUYrdzhYdElMS285S3NZTHFHWHMzdEJaUklOeGFnemw3?=
 =?utf-8?B?N0Y0Q0VlVjNwLy9WZk1CRjJES0pQa3o2N2ZpdHd0bm52WkRsTVpDNVk4REZR?=
 =?utf-8?B?NkEwSWtoQnNaNE1aZFpWTVdJNlJia1NCYk1DTGg4ZTZRbVVEMjVrTTlXeFQz?=
 =?utf-8?B?S1B0SnVxbCtWMHRxdXROU2Rheld6MkJNU2d0cWNzdUQ2RWRsNW5BRG9saHpQ?=
 =?utf-8?B?amZZN1VOZjc5VkY2K1Rpd2MxM0hyWVRDK2hBWnROd0VicmE3bVF1YS8wYmo1?=
 =?utf-8?B?bzF0anlENzJuVU85Z3pYdnhJaWZQTDdJR3hZWDRsY0F6UHRRVGJ4Q2xkNUlu?=
 =?utf-8?B?MFdmNTQrUGhnNE9uQzh2VHh5OEtKWS9FeDdjdW5ORkEyNDBVTExGajhDeVd4?=
 =?utf-8?B?MnRMWGlVOExNcjlKZVRCR05GbHJPZlRkQ3ZIdUxDQ3VxQXh0UnhIWVJSeHF5?=
 =?utf-8?B?ZWt4ZUxjRTlDWlVBTTVtNHFjdXg2TjBWZ1VyMnVEYUtrUHBodTA2M0xaUmxG?=
 =?utf-8?B?TitLdTlZTWRiVnFCeGxlSTd3STlxZ0ZlRjlIMTIrWk9wMUJLRkNmWjdhbnRD?=
 =?utf-8?B?R3pOb3M1VzdRcXBMUUFTWmhobU5jRHptUkdNaitmRXpmM2RQNU9GZmc1ZHNi?=
 =?utf-8?B?NnFIZlJvelZUQ3FMcXNTUHExWEcrYTQ5a08weU9lbThoTUlLa1VaaEFYTTVl?=
 =?utf-8?B?cnFPaEFnaS9lVFB0Qmt3L2xDVk9laStqbG8wVG5ZeURSRGt5Z3dHa3dpWnds?=
 =?utf-8?B?NnRQMHdHN3FEeE1ySVFBbjhsZTZSRGVGcVdMUGZLclRRdUtRcFoyMFFsTTJM?=
 =?utf-8?B?S1NNMkQ3d1ZvQmt2VzJ6MElHOUdXVHpLRElxZmhOSWgyTGNINTNQRS96K0pW?=
 =?utf-8?B?RWtoZ3F0aFZpbHd2dzRyWGNic1ZFaFJXdGxyS0VHRlgzZ2dvcEozdDVrYnIv?=
 =?utf-8?B?TExhY2huSWpNU1FZV1BZYkRBRHpKMWhMV2dmci9MS2NEOWVLRkV2Q0Jyd08y?=
 =?utf-8?B?NkJ2WVhaQ0NuN2JhREVhQ2RTSkNLeUl3akw4ZGlsQ2ljVkxmeW5DUWEwV0dJ?=
 =?utf-8?B?Vnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7351519471BEB746983FC33CBF2743F9@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b06796-7784-481b-1c61-08dcbdefdb8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 12:35:05.7602 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pcb9/5ByV7UN9HiI6kokefBq+e+PmX7RoB18ZjGxBnieG189nvrohMYvNIYrC1fStbXP1m7yE9Gzv7cUOOxUPQF3Yf72ueykz10Adn3eNtE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB7630
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

SGkgQ2hpbnRhbiwNCg0KT24gRnJpLCAyMDI0LTA3LTA1IGF0IDEwOjIwICswNTMwLCBDaGludGFu
IFZhbmthciB3cm90ZToNCj4gRnJvbTogS2lzaG9uIFZpamF5IEFicmFoYW0gSSA8a2lzaG9uQHRp
LmNvbT4NCj4gDQo+IEluIGFic2VuY2Ugb2YgRGV2aWNlIE1hbmFnZXIgKERNKSBzZXJ2aWNlcyBz
dWNoIGFzIGF0IFI1IFNQTCBzdGFnZSwNCj4gZHJpdmVyIHdpbGwgaGF2ZSB0byBuYXRpdmVseSBz
ZXR1cCBUQ0hBTi9SQ0hBTi9SRkxPVyBjZmcgcmVnaXN0ZXJzLg0KPiBFeGlzdGluZyBVRE1BIGRy
aXZlciBwZXJmb3JtZWQgdGhlIGFib3ZlIG1lbnRpb25lZCBjb25maWd1cmF0aW9uDQo+IGZvciBV
RE1BLiBBZGQgc2ltaWxhciBjb25maWd1cmF0aW9uIGZvciBQS1RETUEgaGVyZS4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IEtpc2hvbiBWaWpheSBBYnJhaGFtIEkgPGtpc2hvbkB0aS5jb20+DQo+IFNp
Z25lZC1vZmYtYnk6IFNpZGRoYXJ0aCBWYWRhcGFsbGkgPHMtdmFkYXBhbGxpQHRpLmNvbT4NCj4g
U2lnbmVkLW9mZi1ieTogQ2hpbnRhbiBWYW5rYXIgPGMtdmFua2FyQHRpLmNvbT4NCg0KUmV2aWV3
ZWQtYnk6IEFsZXhhbmRlciBTdmVyZGxpbiA8YWxleGFuZGVyLnN2ZXJkbGluQHNpZW1lbnMuY29t
Pg0KDQo+IC0tLQ0KPiANCj4gTGluayB0byB2MjoNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
ci8yMDI0MDQyNTEyMDgyMi4yMDQ4MDEyLTYtYy12YW5rYXJAdGkuY29tLw0KPiANCj4gQ2hhbmdl
cyBmcm9tIHYyIHRvIHYzOg0KPiAtIE5vIGNoYW5nZXMuDQo+IA0KPiDCoGRyaXZlcnMvZG1hL3Rp
L2szLXVkbWEuYyB8IDYgKysrKysrDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygr
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hL3RpL2szLXVkbWEuYyBiL2RyaXZlcnMv
ZG1hL3RpL2szLXVkbWEuYw0KPiBpbmRleCBkYTM0MWEyNDc3Li4xNGMzOTk5MDM1IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2RtYS90aS9rMy11ZG1hLmMNCj4gKysrIGIvZHJpdmVycy9kbWEvdGkv
azMtdWRtYS5jDQo+IEBAIC0yMTE5LDYgKzIxMTksOSBAQCBzdGF0aWMgaW50IGJjZG1hX3Rpc2Np
X3R4X2NoYW5uZWxfY29uZmlnKHN0cnVjdCB1ZG1hX2NoYW4gKnVjKQ0KPiDCoAlpZiAocmV0KQ0K
PiDCoAkJZGV2X2Vycih1ZC0+ZGV2LCAidGNoYW4lZCBjZmcgZmFpbGVkICVkXG4iLCB0Y2hhbi0+
aWQsIHJldCk7DQo+IMKgDQo+ICsJaWYgKElTX0VOQUJMRUQoQ09ORklHX0szX0RNX0ZXKSkNCj4g
KwkJdWRtYV9hbGxvY190Y2hhbl9yYXcodWMpOw0KPiArDQo+IMKgCXJldHVybiByZXQ7DQo+IMKg
fQ0KPiDCoA0KPiBAQCAtMjE2Nyw2ICsyMTcwLDkgQEAgc3RhdGljIGludCBwa3RkbWFfdGlzY2lf
cnhfY2hhbm5lbF9jb25maWcoc3RydWN0IHVkbWFfY2hhbiAqdWMpDQo+IMKgCQlkZXZfZXJyKHVk
LT5kZXYsICJmbG93JWQgY29uZmlnIGZhaWxlZDogJWRcbiIsIHVjLT5yZmxvdy0+aWQsDQo+IMKg
CQkJcmV0KTsNCj4gwqANCj4gKwlpZiAoSVNfRU5BQkxFRChDT05GSUdfSzNfRE1fRlcpKQ0KPiAr
CQl1ZG1hX2FsbG9jX3JjaGFuX3Jhdyh1Yyk7DQo+ICsNCj4gwqAJcmV0dXJuIHJldDsNCj4gwqB9
DQo+IMKgDQoNCi0tIA0KQWxleGFuZGVyIFN2ZXJkbGluDQpTaWVtZW5zIEFHDQp3d3cuc2llbWVu
cy5jb20NCg==
