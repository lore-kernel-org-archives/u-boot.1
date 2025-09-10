Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B9B5CA101F
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 13:01:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B79808318E;
	Wed, 10 Sep 2025 15:01:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="VGsKddhe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F8028319C; Wed, 10 Sep 2025 15:01:18 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63B36830B4
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 15:01:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oSyhxEafPM+F8ETlbmFpQRyRsOEqomOXRBrFMhtgXpR2vu16QNn2n+M91n+J9hTu3NuVrWrKgj3vLHirtZbNJP8wSiyKun5oQejovtO4xW7KvbLNnUkM9pPuV9VTQePYRTQdq+nd+VhtZq1tNZPiVQ8IT1AevR0SsexXdGYStFiZZal1V/5TzkxL7y8lBoPNr2cCdkiNrBdpQHhL6UDmhL6ELI30GUUNI1yg7D6ZSTOMNF+0ppI4/lZFIYU1KDhaEqs9MCm0AsBY+V8UPvbXRkfv+xsAocl2zCMFI76KLgPdyPwq5a7LYUfQ22VoQbR6jFw9PtnOHMA2m6vmNubcww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXdCI2EV27jeyHKlkvXNk2WTLMRLafIuEUDraO7FoAM=;
 b=SkBnW0nxjj3oYwaWX02jJyo1Krrvc+TegbzW7WNN8CPyZLOYQXSJBAAoc+vIu71BH17K4Zx3ScffHb+w7yXycqaCx8L3Bh82hLIpM/JejvZV4z/symUnIqeYAeUVQRHBWT861IfyjRcTcUsNWOEUunWSbdQ7Fy3oHFMu3uK6e/AMUj4QP+3Ojxy/UqLC+o22hl0WQSy8g7wjGFt4UdQ6dBsqBZ1rQ1KPK+uvnPfKvi+eFSepVX1dgDpOBEfIIS95skt/QahcwdktvWFWknRd3RZ4GpH9SYLJAtHlFZADpuNZCd2ZWhn4f2LhbAz6dUYaiEK5KFM5/Fy4zJ+TPB6QRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXdCI2EV27jeyHKlkvXNk2WTLMRLafIuEUDraO7FoAM=;
 b=VGsKddheBLB7jaOnJQpGjjGmGTEqOerPYrCq/vfRBs+AZu7E2I0oxzX9x1JPmTLSPtuvbQtWZ/XVk0N7VLYOKDeM6eGT6LfbS6pplMsABY/QtO9yDf7VPmkkW5Ygghj0zzPXAdsO43RpJZ4cT5RRo6gLAJeN0RiSQopXhs75K/QxEulF5VFa51HxWgU98dEXrK+8zYv3mKsYj4RB/aGI7etZf/Axxb2dyl4E6/0EbHWSeMf9ipA3SsrXDVVH52hTwESm0cFHFKhxmxr0JVm2NRrRMqOqIqK/bQUHUV5IGpADHbB0bxlFamu0HcEDDEQ9e5S9YZZBA++r7lOfHAl3oQ==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DBAPR10MB4073.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1ca::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 13:01:12 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%3]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 13:01:12 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "bb@ti.com" <bb@ti.com>
CC: "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 "trini@konsulko.com" <trini@konsulko.com>, "d.schultz@phytec.de"
 <d.schultz@phytec.de>, "s-vadapalli@ti.com" <s-vadapalli@ti.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "c-vankar@ti.com"
 <c-vankar@ti.com>, "kishon@ti.com" <kishon@ti.com>
Subject: Re: [PATCH] arm: mach-k3: am625: Unlock MMR registers again
Thread-Topic: [PATCH] arm: mach-k3: am625: Unlock MMR registers again
Thread-Index: AQHcDf4Tk1i6NjlF406dY4By04l0srRtU3IAgB8i2wCAAATjgIAABV4AgAAHTICAAAIggA==
Date: Wed, 10 Sep 2025 13:01:12 +0000
Message-ID: <ae14d825d76df8b65cf82ac78a43aa0c47689b52.camel@siemens.com>
References: <20250815160240.3575140-1-d.schultz@phytec.de>
 <63e0078fbf5cb045b79a441dca0f2f71fd3962e5.camel@siemens.com>
 <d47cb78e-e3e4-4a65-a0d0-b7dbf22e7339@phytec.de>
 <20250910120815.ifbg5fndnaodopvt@bryanbrattlof.com>
 <64f1a6561417bf7ff9d8e92ea69e1ef842bd2055.camel@siemens.com>
 <20250910125335.orpc2lrm2amncbwg@bryanbrattlof.com>
In-Reply-To: <20250910125335.orpc2lrm2amncbwg@bryanbrattlof.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.54.3 (3.54.3-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DBAPR10MB4073:EE_
x-ms-office365-filtering-correlation-id: cd40f78b-531f-4db8-8b49-08ddf06a1ea1
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?SE42WDB1WHVDWU9TYVYzVTM1S2RIT2UydkV5c1pXRHgwczJZS1J2NjhTSHov?=
 =?utf-8?B?clYweFl0b2VCZzd2YmpGNFU5SDRha2ZkREVqckRYZ1paeVRNT2FrTSs1QXY5?=
 =?utf-8?B?cHQreDNwWWtOZ2t0d2YzVXZ0NE5iRXdXeGZ1emJvV09tWXl6VHdMQ2VwVUdV?=
 =?utf-8?B?RVo3Q0JISEoxM1Z0c2svd3creStYejRqS0tkTDNiK0Z4YldpWW4rS3o2Rmcz?=
 =?utf-8?B?c21aN0V2b2p2V1hVS0Z1SFJ6UmdjL1Vwa21mZDhyWERLRVZIMGtnbkxTUXZa?=
 =?utf-8?B?RURnT1gyYmFwdTUwYm1zaDU3QnF1b1piamVBYlpXblV6NnVtODB1QTI0YUZp?=
 =?utf-8?B?ZU5rbVpWMk1KUW9HSWF4c0tGYkl6L0dSL3ZxRjFlajduTkI1QjJaa3Q0RFVY?=
 =?utf-8?B?SmV0SUZSamFtMzl4aCtMOHRHbGtOZExQNW9VdDgxMVlERDQwVnZPQjdhY0JQ?=
 =?utf-8?B?amN6K3hGbmNpNWVSdU1LTWx3K2tzTSsvdEQrM01kSEN0aWZleFR6WEtOamIx?=
 =?utf-8?B?VzJERGNSNEM2cTczbUJYUTBlT0dweUYyZWxGcWxvbEkrNzBxdzd3YWRVQzhl?=
 =?utf-8?B?emUvbHE5WHBFL2ZyVll3R29JZzJWc2F1OUIwdkdVSDlJbVdoTzZQMEVweG4v?=
 =?utf-8?B?T0VkR0FlMlJycVhWQUhIeWVncnRwbmNWdm14TWJiTm03UjM4Q0NUS09nVExo?=
 =?utf-8?B?bDNwWUI2S0VxY094NVNHK3dxRXI4TVZzR01pbWhIUVJzSGwwUWRRL281Rmtw?=
 =?utf-8?B?dXRzUVR5UVlhU0trbU43SUs1cmhUZmVod2wyRGIrMFJ1Y043NGdFUXRLNEh6?=
 =?utf-8?B?bEFlUTRyeW9KNlludzkyUHNudUkwUzh6Zm9QTnJuRUJFZW1yVEdZTHlEeDFi?=
 =?utf-8?B?VDJqdHh6WXRuaHZEVWtJSUxDL2tNdUFZdk1oTXFCTlBMa2h1N0F5b2dIUEta?=
 =?utf-8?B?RFNnVzV1MWlhd1NOcWRCcG90TWZNbDBoTzI4Z29kaTUzS3gwY3VLSUZ4ZWtT?=
 =?utf-8?B?akw1bXBPRGc0dFFtQTBHbElYU1IvcHZ2VW81SG9BaGE2VDJRS1pZbXN0dWxK?=
 =?utf-8?B?dTk5VThpckxGVWZsWm1yeG5tMmJ1ZTQ5d3Z2eW5DRW41R2RXVVYyL0NHVTI3?=
 =?utf-8?B?NFJMQmxudGwvWXAyc0dLUHJwS2xxdkx2YU5NeWNKNVVIWXJtMENxcG1ueEVE?=
 =?utf-8?B?K29wenBtTXZhRXd0MU5KWlVDbHRwZDlaeHlZMU9VVGlzSDhyMXNEamZWVmo3?=
 =?utf-8?B?OUNCZXp0QW5tdG5Yb1lMdG9xY0xPYkNPL0l2aEd4aG52L1ZIQ2ZTQWk0QXJY?=
 =?utf-8?B?UzFaaDJDT3FBc21jZUJGV3JkeHNyV0k2cWZZbEZIdmREdmc0UkdxS2t6NC9l?=
 =?utf-8?B?MDJmMlY0THVOc0hWeklvTkF6SFg0bi9DbWttM04zMEtxdlI2TmlqTUdNQUVx?=
 =?utf-8?B?cllYNkdDcVNTT3NGQXcvZXhEU0hUSDMwTWt3ZHpSSVorU0huenFvcEZmYlhr?=
 =?utf-8?B?OTlRSUN4empJeklUZDRZa1BTMHZvWUxka1oxWjdkUjBzcVB4M2xIMlh2WW5L?=
 =?utf-8?B?bUhiZnlhbTRoWFdHSktvUHVUMGc0NGZJaFB6WnhGTko5UE1xemRTRTVTU0Jr?=
 =?utf-8?B?NWxQMjlFYTV0MWIvOXl4ak5Vblp4d3hXcCtIZ2lidThuejh0Y3RRcWVqUysr?=
 =?utf-8?B?T3lNcDVRNmRaNlFWK3RmUGZUb2tROTFldGxzQndjelhRdjNQTEZSV2tMRER1?=
 =?utf-8?B?akx6WXdGRElaVUxtV0VyckxIL0RHNUI3Rk1TRUgwUzIzcWp3bzBKV2lNbmNQ?=
 =?utf-8?B?bnZObFdVMmlIMXhSRUtwcGErbERrejV1ai9DeGI1RUJmRGVaQ0pVYkJ0N09t?=
 =?utf-8?B?R1dBckxkaXhreExZMTRPM2RJU2NjYk85cHlTcnBtdFl4MWhQcHBzY3V5ekU1?=
 =?utf-8?Q?na3B9tPM6L4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWx5TFdsRjJOM1J3VHowMEloK1FyWnRJTEg0MjY5Mnh4VXhXM2l4WGhDMlI0?=
 =?utf-8?B?MmEwVDVEVnhzZU1McG43ZGl2dWQyNStVMUxHNG9scE5od1NNQ2FWMnNTNERZ?=
 =?utf-8?B?UDhkdGRZeTBJdWN3N0d2NVU1dmtYTGdzc1VtSGszelBLNnhzc2VoMUJKV0Ny?=
 =?utf-8?B?K2ZhMysxV1B1TW1HUU5hTFQvVkNGODVzWGlDNnBsMnlyQUFlTTN4eE5FdDNn?=
 =?utf-8?B?cG5md0p5Sy9pODRGU0xJdXBWYmdCZmFnTDE0S2pTMFIrZ25WeXB6c3U4RUhp?=
 =?utf-8?B?RzR3U3k0eElHUzZTNVFKcWF5cGlBTjltaE1NMUtPdFJhb1hWblFTV3B0c2pm?=
 =?utf-8?B?TGFLR01IZUdRdkU3SWpZc1FqenlpZmRLa21lL3ZOOERicFhCV0pMYmV5cThu?=
 =?utf-8?B?ZkZtdGZFZHl1THdVaHo3RzhvNkx6aVFKSlZzUTdtWEZKTXRVRE5jNFZCeFM5?=
 =?utf-8?B?Y1FUeUUyckZSZ2Jnd1AvWVV2RnhZQUpMbWZDMGJEcnFZTWtWWHNQd1BpcXF2?=
 =?utf-8?B?VUxULytPTEtQaFNYbU1SOU1TdUxVWW0xL2g3eWNhSmR1UTRzMVFoQk1BQTEy?=
 =?utf-8?B?ME5yejhZeTNlOUtwWVFITWhPWnRsYlg3Z2dmOXYrZlFEZDdOOWhGLzNLTDdl?=
 =?utf-8?B?cnhGQy9VR29ZcENNY1cvT0hJVU9WUGQ3TDY2RVBrNVBjRGxBS3dCTFpsdDhY?=
 =?utf-8?B?L2RnelNEUjVFdC9JZXJ5RHA3SnFRZ1liVnEzaTZIQitRVGR3QXZ6Wk8zZ2po?=
 =?utf-8?B?STdjcU9NR3lwUE05b2dDelJPY0VGSXZydVVkUUppTE5GcnM3UzFzK2RiZDAw?=
 =?utf-8?B?N21mOWxzTG4xb3JrM0dKRzV3YitKbUlpamZEaFR4RllabkYvSGVwREFycUEv?=
 =?utf-8?B?WmJLWW54Um8zWVVxb3ZMcm94SUpvdGlTQnpRVTc3N3BxZ0tpQWVyVFJ3Ui9I?=
 =?utf-8?B?amhJSHNMVHJEYUlrZW5iQWpSVVQyMURvUFRYTUtaVWw4d0JvYVhZWTVzcEgw?=
 =?utf-8?B?TTlMZVJaUTNVSXhqYytEZkU3ZUlTM0dOcTloeDgyc0NsM0FsMUxMNXEzcUZj?=
 =?utf-8?B?clNEamVFMGRTb2c5bE0rU1NBd2pId0cxSlpGNDZtK21Ha0ZkVUtUbnZoOThF?=
 =?utf-8?B?dzhYdGxQaG5sVmFIZkRWUkxtRTQySmVGVUpKNDJMc3pwMG9XeVhVNitQMDdu?=
 =?utf-8?B?ekxYY1BxZkFDVzdiYTFtZ1gyZUVpZWtIekNzcHYzcWtZaEdRSE9EZ3J6RnZh?=
 =?utf-8?B?QytnU21VOWNDU0doek50cGdXZVRiSm5KY0U4TWcyNGFTcDR2eVZEUDJZTWNv?=
 =?utf-8?B?YUxwZnpTRlF3eTY1SkdtNTROVnFscGIzOC80eHN3b3lSVFc3WXR2ZUdzSUZj?=
 =?utf-8?B?TWtDemovVGtCVHN5aG83NW5NMHNHcXhERlI2SkpYOW1hQUVNQitib25sWm5t?=
 =?utf-8?B?LzlsU01qYUo2VVNUR2VNWHBBT2MvVWw5RWV5YWdSdTV1dm5Hdm4vLzFWWm1q?=
 =?utf-8?B?S1g0SXJwdmpWYTlJL3hhY2xyaTNtaEprNTlBMVJnMW1VRmJjZ0pjeUs5RTFK?=
 =?utf-8?B?SGNRei94UDQzTmhGNlpCQkU2V2hER1Z4N1NFbGEzZzRoM2ZEM0Q3YUpPUCs0?=
 =?utf-8?B?TVFnbllham9DV0lUYUszR2J0ZE5MSjBWZWp5QUFubUZNMUp4cXBQTk1TcE9t?=
 =?utf-8?B?aGhkaC9ZbXRtZ1RuQUFDSkQxNkI1dUhtajdJdG9BOG4zOUcrOFg3THZBaVl5?=
 =?utf-8?B?TXV0eHB4Q1ZGeFV1OFNoUXV2ckVRSzhvRjJ1N0c1SktEcjBob25TU2xHRVZa?=
 =?utf-8?B?RVdZZUUySWxhUjNJRmNMQlRReVZRdmQrZlRJWWtqWFg4S0tMWTBmOThPOGJO?=
 =?utf-8?B?bjM4c3BMNVdGRlpRdUtzdnJJdzFYZDlOQmErS2VYMmpHZG9mM2FsOEdLMzQ3?=
 =?utf-8?B?QU8vM3AzRm15TUFsZFk0TCtGbjkzRjR5L3NKQkFiQ2hkcXNoMHFDU1ZyVHBz?=
 =?utf-8?B?dU10YkJiVCthUFZLTGFsUFZJQWs4a3I4Y2xEbjNSTHZ5VEpFK0ZVQmVoYVZl?=
 =?utf-8?B?cXhNTmFwSUVla083SDhWOUM0QjNzOTQ1VFZwZlhDL1NjZHM2enk4WGUzbHJj?=
 =?utf-8?B?bHEzdHJCWlpXQXZFV0NVWmhvalRjN3Jmb1dILzYvSVA3K1Q5Z0EzemFkRFNq?=
 =?utf-8?Q?o5cTRiD/hGz/41DHEVuZnI4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4BA8C06164B37A458D8F0111C24AE963@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: cd40f78b-531f-4db8-8b49-08ddf06a1ea1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2025 13:01:12.7308 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DdAddQMrDKkz8SXQCUF41wuk/q5K9p9LBjKEsqV/6FtFlQbbm3TxilZ5jkcEdUgkDfqtMDmy1hYvvJw+TqlI5L/++Off0ZMh64s9e6+5SCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4073
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

SGkgQnJ5YW4hDQoNCk9uIFdlZCwgMjAyNS0wOS0xMCBhdCAwNzo1MyAtMDUwMCwgYmJAdGkuY29t
IHdyb3RlOg0KPiA+ID4gPiA+ID4gVGhlIHdhdGNoZG9nIHJlcXVpcmVzIHRvIGhhdmUgdGhlIE1D
VSBFU00gZXJyb3Igc291cmNlIGVuYWJsZWQgdG8NCj4gPiA+ID4gPiA+IHRyaWdnZXIgYSBzeXN0
ZW0gcmVib290LiBXaGVuIGJvb3RpbmcgSFMtU0UgKHNlY3VyaXR5IGVuZm9yY2VkKQ0KPiA+ID4g
PiA+ID4gZGV2aWNlcywgdGhlIE1NUiByZWdpc3RlcnMgYXJlIGxvY2tlZCBhZ2FpbiBhbmQgYWxs
IHdyaXRlIGNvbW1hbmRzDQo+ID4gPiA+ID4gPiBhcmUgc2ltcGx5IGlnbm9yZWQuDQo+ID4gPiA+
ID4gPiANCj4gPiA+ID4gPiA+IFVubG9jayB0aGUgTU1SIHJlZ2lzdGVycyBhZ2FpbiB0byBzdWNj
ZXNzZnVsbHkgZW5hYmxlIHRoZSBNQ1UgRVNNDQo+ID4gPiA+ID4gPiBzb3VyY2UuDQo+ID4gPiA+
ID4gSSdtIGp1c3QgY3VyaW91cywgY291bGQgeW91IHBsZWFzZSBlbGFib3JhdGUgYSBiaXQsIHdo
ZXJlIHRoZSByZWdpc3RlcnMNCj4gPiA+ID4gPiBhcmUgYmVpbmcgbG9ja2VkIGFnYWluIGlmIHRo
ZXkgYXJlIGJlaW5nIHVubG9ja2VkIGJ5IGN0cmxfbW1yX3VubG9jaygpDQo+ID4gPiA+ID4gaW4g
Ym9hcmRfaW5pdF9mKCkgYmVmb3JlIGVuYWJsZV9tY3VfZXNtX3Jlc2V0KCk/DQo+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gSXMgaXQgVElGUyBmaXJtd2FyZT8NCj4gPiA+ID4gPiBXaGF0IGVsc2UgY291
bGQgYmUgYWZmZWN0ZWQ/DQo+ID4gPiA+ID4gRG8gd2UgZXhwZWN0IHRvIGxlYXZlIEdlbmVyYWwg
UHVycG9zZSBDb250cm9sIFJlZ2lzdGVycyB1bmxvY2tlZA0KPiA+ID4gPiA+IHdoZW4gd2UgcmV0
dXJuIGZyb20gYm9hcmRfaW5pdF9mKCk/DQo+ID4gPiA+ID4gRG9lcyBpdCBtZWFuIHRoYXQgdGhl
IHdob2xlIGN0cmxfbW1yX3VubG9jaygpIGhhcyB0byBiZSByZS1kb25lDQo+ID4gPiA+ID4gYWZ0
ZXIgazNfc3lzZndfbG9hZGVyKCkgY2FsbD8NCj4gPiA+ID4gDQo+ID4gPiA+IEkgcmVhbGx5IGNh
bid0IHRlbGwgd2h5IHRob3NlIHJlZ2lzdGVycyBhcmUgbG9ja2VkIGFnYWluLiBJIGZpZ3VyZWQg
b3V0DQo+ID4gPiA+IHRoZXkncmUgb25seSBsb2NrZWQgYWdhaW4gYWZ0ZXIgbG9hZGluZyB0aGUg
VElGUyBmaXJtd2FyZSBvbiBIUy1TRSBkZXZpY2VzLg0KPiA+ID4gPiBTbywgSSBhbHNvIGFzc3Vt
ZSB0aGUgZmlybXdhcmUgaXRzZWxmIGxvY2tzIHRob3NlIHJlZ2lzdGVycyBhZ2FpbiBhcyBwYXJ0
IG9mDQo+ID4gPiA+IGEgc2VjdXJlL3NlY3VyaXR5IGZlYXR1cmUuDQo+ID4gPiANCj4gPiA+IEht
bSB5ZWFoIHRoaXMgaXMgbGlrZWx5IGEgYnVnIG9yIGEgY29uZmlnIGlzc3VlLiBJZGVhbGx5IHdl
IA0KPiA+ID4gKFUtQm9vdC9MaW51eCkgc2hvdWxkIGJlIGluIGNvbXBsZXRlIGNvbnRyb2wgb2Yg
d2hlbiB0aGVzZSBhcmUgbG9ja2VkIG9yIA0KPiA+ID4gdW5sb2NrZWQuIFRJRlMgb3IgRE0gc2hv
dWxkbid0IGJlIGFueXdoZXJlIG5lYXIgdGhlc2UgTU1Scy4NCj4gPiA+IA0KPiA+ID4gPiANCj4g
PiA+ID4gVGhlIEE1MyBTUEwgd2lsbCB1bmxvY2sgdGhvc2UgcmVnaXN0ZXJzIGFnYWluLCB3aGlj
aCB3aWxsIGJlIHBlcm1hbmVudC4gT25seQ0KPiA+ID4gPiB0aGUgd2F0Y2hkb2cgaXMgcHJvYmxl
bWF0aWMgYmVjYXVzZSBlbmFibGVfbWN1X2VzbV9yZXNldCBpcyBjdXJyZW50bHkgb25seQ0KPiA+
ID4gPiBjYWxsZWQgaW4gdGhlIFI1IFNQTCAoY29uZmlnIG9ubHkgZW5hYmxlZCBpbiB0aGUgUjUg
U1BMIGRlZmNvbmZpZykuDQo+ID4gPiA+IA0KPiA+ID4gPiBCVFc6IFdlIGhhdmUgc2VlbiB0aGUg
c2FtZSBiZWhhdmlvciB3aXRoIHRoZSBBTTY4QS9KNzIxUzIuDQo+ID4gPiANCj4gPiA+IEhtbSB0
aGlzIGlzIHN0cmFuZ2UuDQo+ID4gDQo+ID4gVGhhbmtzIGZvciB5b3VyIGFzc2Vzc21lbnQhDQo+
ID4gRG8geW91IGtub3cgd2hvIGNhbiBiZSBjb250YWN0ZWQgYXQgVEkgcmVnYXJkaW5nIHRoaXMg
cG9zc2libGUgcHJvYmxlbSBpbg0KPiA+IFRJRlMgZmlybXdhcmU/IE1heWJlIHRoaXMgaGFzIHRv
IGJlIGZpeGVkIGluIFRJRlMgZmlybXdhcmUgaW5kZWVkPw0KPiANCj4gSSd2ZSBzdGFydGVkIGNy
ZWF0aW5nIHNvbWUgbm9pc2UgaW50ZXJuYWxseSB0byBzZWUgaWYgd2UgY2FuIGRlYnVnIHRoaXMg
DQo+IGZhc3Rlci4gTW9zdCBvZiB0aGVzZSB0ZWFtcyBhcmUgZmFpcmx5IGluc3VsYXRlZCBmcm9t
IHRoZSBvdXRzaWRlIHdvcmxkIA0KPiBhbmQgY2FuIG9ubHkgYmUgcmVhY2hlZCB2aWEgZTJlIHRp
Y2tldHMuDQoNClRoYW5rcyBmb3IgbG9va2luZyBpbnRvIHRoaXMhDQpJIHJlYWQgaXQgYXMgaWYg
d2Ugd291bGQgbm90IG5lZWQgdG8gY3JlYXRlIGFuIGUyZSB0aWNrZXQgZm9yIG5vdz8NCg0KLS0g
DQpBbGV4YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K
