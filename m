Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8123CF3191
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 04:42:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D3A6891CB;
	Thu,  3 Oct 2024 06:41:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3ZOi2pGi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 802D0891C3; Thu,  3 Oct 2024 06:41:03 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::617])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 576D788FC5
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 06:41:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WVPz5qXiQAaocqgRzIbESIb2auJ9rzcEfLYSbt1as2+J9qC4pU9IZ7HFME0jcIrh3qoCyaDvonIL1eIePuxQNfEudkys8U714f0hw37t2WciG23NnQ7JGA0DX9Y/flb7f7c1ADBErMWNEyfAGmW9aCKaTdOs39NE69qTjiZlSptyiLHNeKeP+t0Y2cZQrWvqBKj6gD9lW98XBpieUzcN/cTb0TMM4Fw+GpeKX6avu8L0RPn8znNKtUiHsIBTwjCAqtufVgAkl3JCRcphXH0X+1JdJgw+kYzFuUSZ6mIv+9PU7QPA5oXNIozPrjXWmss+whl9KBkr0O9q298QCwtQlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yULg5hWu4NQ/zaL6XCC8ZclQDSG8h+2+aXFFjJLlUQg=;
 b=RgsSe5pjBQREmERr5g1co0mE6rHdXZHohnO5kvN2sbYjK/ocmaNROaMSwzmW93muScd9vSPka4/Gxp2WdROrPEmNshSoq9A/utdMk8Xv+WBW7jXS7JiJFnrTi97R75X5VtvsJjKyI9Vsdes2RcXYB+jbgpBWWC58KvL5hvDUVeRGytmYv35yYNP7ZqJJdpF5khh8qXHyqAzWXGxTMZRAgEw+l6lHmktnypcFP0EmU8DavUB7DzFbrJwritIgiTAYzv+YRSC7y1bLEqu+8el2X/z+T6MkueFQ2Y4F0cOmaLWcEx/dQ6P2Z/6QLJVXQpORl5UP+CUGwoHExSKzVkOb4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yULg5hWu4NQ/zaL6XCC8ZclQDSG8h+2+aXFFjJLlUQg=;
 b=3ZOi2pGizEz7fUCxKBGYKAhzq23+5dkr3f7CXkJYvkRbdfhlI9uHVhs1JTUidS0jrASIhRGvqpuNL+1X0XFUaLF7O4GUQu/KNr05832QChrD1jIJvbFUWfJ7yu6k0o/cncmrTLF0Gy2LdltqsUDd/+lW/idKGZGn1bJ83OJj6F4=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by SA1PR12MB7365.namprd12.prod.outlook.com (2603:10b6:806:2ba::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 04:40:56 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%6]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 04:40:56 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "Simek, Michal" <michal.simek@amd.com>, "fabrice.gasnier@foss.st.com"
 <fabrice.gasnier@foss.st.com>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH v3 1/7] usb: onboard-hub: Add reset-gpio support
Thread-Topic: [PATCH v3 1/7] usb: onboard-hub: Add reset-gpio support
Thread-Index: AQHbE8Cw1wwSjzBcqEOkNkd+RtrWkrJxyouAgAKoQHA=
Date: Thu, 3 Oct 2024 04:40:56 +0000
Message-ID: <SA1PR12MB8697873F2C2EF86E6E9DAF9B98712@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20241001050529.17922-1-venkatesh.abbarapu@amd.com>
 <20241001050529.17922-2-venkatesh.abbarapu@amd.com>
 <6056a273-2699-4e94-93e8-ddc96084bbba@denx.de>
In-Reply-To: <6056a273-2699-4e94-93e8-ddc96084bbba@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|SA1PR12MB7365:EE_
x-ms-office365-filtering-correlation-id: b7c3e862-7535-441e-950d-08dce3659215
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NkxEV2hHbHI4a25WNHRLUjJQSnYvMzF6N3JtbDVLUXdLZFNud3gzZkJvY1I2?=
 =?utf-8?B?c2pVdytqVGRtK3VTaDN1NEhDRElLQU0vVlRNMTlQeVlWNXhIa3NLNVNTVW1D?=
 =?utf-8?B?K3VuRjU4VFdhVDEyd1hvUGk3Q2lndGVIdGVaUlA3RExPUHFzbm9uSjZVTlF2?=
 =?utf-8?B?T0hUaTVDMlUwc0lhMEdkeEI5eDgycWcvZmhYNG9QVkJUSlF5UFBtdXA1TkFR?=
 =?utf-8?B?NWFtK0x1TURvNjBFTTRoNkhTV3pPRmhJbjNTVGs1T1hzSStseTNES0hkbWNX?=
 =?utf-8?B?b0Z1MFBrdkxxR0o1RzFGU2p5S1M4S1FCd05rSE1xeFVHMDIveEVKUWtraUc4?=
 =?utf-8?B?ZnAzOUhNditHdFNkbGFyMmZZaVZBR0RWbzFYU3VpR2dXb2tvOExlTHhIT1k0?=
 =?utf-8?B?aC9rR2Z6T2FkTHQ0S3F5REVqYmlCVm5OTFlMTWtvRVhsZUYwOTF0SlVHdVVE?=
 =?utf-8?B?YVFmckR4MW5wTHVNM0JIWTB4cmZvRitZZkFaNStuSWgyTlFBME0zMkw1K05V?=
 =?utf-8?B?Mnc3bHgxaldwb2RUcjhWUCt4amRxczBtRlE1YkQvQTB1V0xyN2tydUI3N1Zk?=
 =?utf-8?B?NWljc1h0eTFLb1hPSm5QWTVaMWpOdFpLYUs2R0l6T1VPQk9udVlNWDRUVmhM?=
 =?utf-8?B?WUhZeHRNK0NjMGlpQ253RnFhU1pMZ3NKOXdTR01xRjIzZlcvMmlGZ1lGeUJU?=
 =?utf-8?B?eXVUUUtvdnc3TmJaNUFUYWV4dFNMVDFmR3RrSkQ3OFNNSkRlUmdWQys5Mlh2?=
 =?utf-8?B?dUg0NDVnSGdVSldaWm5zWG1Eb3lCUEZXb0VQUzEveitHNmdwL3NPOWtBWCtL?=
 =?utf-8?B?VExQTkhJQmVnTEIzeUIwRE1kaHhUbWlkZnRTY3EraEw5K01oODhYVFR1ZE9O?=
 =?utf-8?B?UCtRa3Q3U1pjVDNUK0Q1VWtxR2twVXVSY1FLN0k1aDc3KzBLYUxXMGphU1E1?=
 =?utf-8?B?ZnNNZFRhUEJRVEx3VHBKVXlvcVdOTVpaTkZsVHZScEVubUlVY1BNMlFhUHMx?=
 =?utf-8?B?eXJpUlpYSDlkOUNEZ2ZGRjQxLzRVTmlSY0gvSTdMdEZodmRwUW5sZlR6ZGdR?=
 =?utf-8?B?OWF3WFFUTDg2YkxJcGk1WDNGSHdIejV2dUMzYm53M0VlajlMaExIb2xSQ1g4?=
 =?utf-8?B?cEY0blVvMUtJYmpUUk10cTZ3VldFVEdKSzl1bFBTMHpodjB3bUw5eE1PV1Bu?=
 =?utf-8?B?QTZ6dlhORzR0elpYYThJbndaa2FRaGhTMG5GWVVHSU0yU1MxaStuSEVWWVRD?=
 =?utf-8?B?bHNEV2NXVFc3VkNiMk5QaDBiTlFVY09ndWhmNkdFcWFwSWsvUnc0cGVvbk4x?=
 =?utf-8?B?QXZGRGJ3bHBrdEVKVE5ES2UycUszODkwWkI4cDNWVkFjbDFGYm56QzRCYldH?=
 =?utf-8?B?TkpXRlg1NysvcHFBMlpOSjZHRGhKdG5YZ1Fsa1BXeVlwN1pNZWd1d1dRTUYz?=
 =?utf-8?B?VU1sNDI1WGdLcGRKQWpUckFEQ3pPY0JGMFlabWxJQnhxbFF2dzAraWxtbFdn?=
 =?utf-8?B?ZTFoVTNkMUd0amFaZFZaNmVUYUpGZG5KUnE3bXRvT05hLzBCTVB0N2Z2ZGtu?=
 =?utf-8?B?YjJZUlltSzFERUdVVkJqTTBqcGNic1MwWkV6Y0U4SExNc1JSM1dQSlNoOEpv?=
 =?utf-8?B?OFFCbm95bmFWajRrMVFJUGJhTHhudmRNNi9TSlFlYU1xck9OVXAxMk9XK3NV?=
 =?utf-8?B?QXFFU0NrVlE0QUJRS3NvajR6TC85OWV5NzNWTkhMTlk1WWtyeHpHcGRjK1Rv?=
 =?utf-8?B?UVBvVFBlSGtKQ2NUWmxaL1h3R1d5eXExY2QrcFpoNmdUS29vdTN2TTNYejJz?=
 =?utf-8?B?S1FyK2dFVFNabUdXbktpQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?blpSeE1YWHRnME5QaWNNNmpJS2crVUE2UE5mUloxcUFBVTZmSUN0dHk0VVBk?=
 =?utf-8?B?Ynphb1p6TzFhMmREcUJHYUtDUUo1THhzbnVEdTJXdDlHSG5MYWtBVWZqeDR3?=
 =?utf-8?B?YTFYOUJZcVRDU1VBWU9vOFdSSlFrK0VGelZrVWI0czNmR3FDeUZ4RjVhd2wy?=
 =?utf-8?B?WVc4TnUxMFhWaHZlYUlqWWpsY2ppdDNCVWFaeE40dXB5S2g3bHdUR1dFd1BJ?=
 =?utf-8?B?SzdKT3hHYmVaSzNCSVNuYmcvV1d1N1A0WnRuK3RTcnZ3TGg4alhjZ0p3MVNj?=
 =?utf-8?B?ZUpvN241aGtzU3ppeG02SFQyT0Z0bkkrZ05BRVh6alNVMExGdEUyRm9PVGxH?=
 =?utf-8?B?YWlMaDc2ZUFHUlNReCs1REovb3VDQmRlK2p0MElqNncvSWZoRUd4TVFQKzBO?=
 =?utf-8?B?TGZJSHdVaTB1MWFpN0ZUTXp4QWdOTUNVZzBVeE84Y3ovSnA0Y3I3Wk53bXFq?=
 =?utf-8?B?cEc3VGM0aUpEVjMrUTFrUWdZMWhlSG56L3V0R2FyVC9GdU4razJOeUljNTdu?=
 =?utf-8?B?b2t1a1lJWjV3aXd0ekJiS1RrQzl2WUN3VFBCaFdqWHZPY2NpYjRXQzVWeHI5?=
 =?utf-8?B?ZzByb3lSV2FiUElEMk50TnQ1b3NqTEZrc2JnUmtSUmV1R0FzblhzRHJkRG94?=
 =?utf-8?B?SmlXYjJCbTZ3YWdvZnhLeUZ3bUdQK1ZlQTcxUFc1blFMVHpUWlZUUWF2VmFz?=
 =?utf-8?B?MW9nc0hWOStDekVRNzlyQXNTUWgzTVZ6dkdZenM0TUtGWTJ6MFpIcDVYbmEx?=
 =?utf-8?B?TU9TMk5xR1p1aS90cnB3eksxTWNzNVVMWHlETTFjWGpKZjBCT2gxdldOckg5?=
 =?utf-8?B?b0xJcVVnMmdoVVlZdVFJVUI2MXk0MUVQc2RJNkpQYzFBbXg3QndHaGdOTVY4?=
 =?utf-8?B?MFdqMGFhemYyYWJzMkJDMFBGcVl3Rkkxb2JBSVViNGZOUmNNMUVyZmhra3Ez?=
 =?utf-8?B?UEJFUkp0YWZHKy90UCtwMWRWQldOWEpEczhRdUhKY3FWSFlNY05hM1ZZemkv?=
 =?utf-8?B?czFMY2NFVjVpa2JxZk5mMnRybUZvVDQwaGN3Zys3dHJvczdaR3lKbmYvaUVN?=
 =?utf-8?B?empKbytSY0t6ZVQ3ekN3d2lNcnZLN0R2OCtVUUVEczc0bzBmNzYyMUo3Q3E0?=
 =?utf-8?B?cVpkMGZobTBZSUdYNzN3SDVFL2E0b2FIVXVtUXpLdkdETms3N1ppR1puNUdF?=
 =?utf-8?B?WTh6dVM0ci9mZGFHSkNJVEFkZHlBa3Z4a2hwdXZPYWdwYlEyRC84cERZQUQ2?=
 =?utf-8?B?Nk5FNVBDbmZIK0tVZGJRa2NtMXc3M1lRSnVKYXJUT2c3bFpYZEF6YmF0Vyti?=
 =?utf-8?B?blpQb2psbnJTV1FRdXh6ektpdG5mb2hCVnlOeGkyTWV0bFNOUmNheEFCc1RZ?=
 =?utf-8?B?RENhdGRFOHVudnZEQWk0TmZxbHhFcUU4clRXSkg5VThCM3pJdXc3UzU2ZE8x?=
 =?utf-8?B?T1MwVWp4UDFwMzJPNTdTSWhYZEZ3THFEMzc0NXluNUZaZjRNZXE2S0lCbjhz?=
 =?utf-8?B?RmgvYm1JWndmNGpsd2YzTFFaM0s4NWttdWNQQ1NISHNSVkRMZFBUWXJ6NGtC?=
 =?utf-8?B?bW14T3I0c2RqWmE0S2h4blZ3TEY2SVdnbHFwbXJOamI0ZmgwbSs2TmNQZDNQ?=
 =?utf-8?B?WG5YenFIMjJDczZFWUVDdm5sQjJvRURKV3lRdnR4eEx1MGg1NEQ3b1ZZT0dh?=
 =?utf-8?B?RHNkVWhWN0VxQ2dyOE12aUFOUERZdmUybHkyVloxTzVFZlliRVFWbEdycWNu?=
 =?utf-8?B?TTZTd09SbElVWFE5S0NwZ0FINFNtL3lleTd2a2JBTWt5ZU4xVUEvZlRIcjVY?=
 =?utf-8?B?MGRzL1Z0MkN1VWFMUFpMWlREYjhzQ3VDMlNobkFmc29pWHpqcUl5R1VqdlEy?=
 =?utf-8?B?UmZpYXlvdnYzS3ZjZDNXODNwaTlWZ1VmUFBCeEpKekRTVW52SEZKSDZUMnU0?=
 =?utf-8?B?OWF5RzZkdCtHNHlMWGFUOXdhVG55N09wNVovWTdOUTFTNFp6c0dJUW5iYnVZ?=
 =?utf-8?B?M01ZUjV6aDl6bGk0cVMrN2NoS1FJdEpZRWpINWNFbFBUa01SUjczdnpZaFpo?=
 =?utf-8?B?YlFCenpoUTVmZzhscEpNY24xOUZHVTVOZC9ndnpoUWQ5L2puMW1VS25DNENG?=
 =?utf-8?Q?Mqvs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c3e862-7535-441e-950d-08dce3659215
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2024 04:40:56.1735 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hib3EEbwQG6t7LcgV7pTjnM4xhjb8lw8vsrcdi8qGoQr0iCOMM1Im3EEQx4TtSzrhqPRgTP0H9cdINYrP1NO/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7365
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

SGkgTWFyZWssDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyZWsg
VmFzdXQgPG1hcmV4QGRlbnguZGU+DQo+IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMSwgMjAyNCA1
OjI3IFBNDQo+IFRvOiBBYmJhcmFwdSwgVmVua2F0ZXNoIDx2ZW5rYXRlc2guYWJiYXJhcHVAYW1k
LmNvbT47IHUtYm9vdEBsaXN0cy5kZW54LmRlDQo+IENjOiBTaW1laywgTWljaGFsIDxtaWNoYWwu
c2ltZWtAYW1kLmNvbT47IGZhYnJpY2UuZ2FzbmllckBmb3NzLnN0LmNvbTsgZ2l0DQo+IChBTUQt
WGlsaW54KSA8Z2l0QGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMS83XSB1c2I6
IG9uYm9hcmQtaHViOiBBZGQgcmVzZXQtZ3BpbyBzdXBwb3J0DQo+IA0KPiBPbiAxMC8xLzI0IDc6
MDUgQU0sIFZlbmthdGVzaCBZYWRhdiBBYmJhcmFwdSB3cm90ZToNCj4gDQo+IFsuLi5dDQo+IA0K
PiA+IEBAIC0zMCw3ICs0MCwyNCBAQCBzdGF0aWMgaW50IHVzYl9vbmJvYXJkX2h1Yl9wcm9iZShz
dHJ1Y3QgdWRldmljZSAqZGV2KQ0KPiA+ICAgCWlmIChyZXQpDQo+ID4gICAJCWRldl9lcnIoZGV2
LCAiY2FuJ3QgZW5hYmxlIHZkZC1zdXBwbHk6ICVkXG4iLCByZXQpOw0KPiA+DQo+ID4gLQlyZXR1
cm4gcmV0Ow0KPiA+ICsJaHViLT5yZXNldF9ncGlvID0gZGV2bV9ncGlvZF9nZXRfb3B0aW9uYWwo
ZGV2LCAicmVzZXQiLA0KPiA+ICsJCQkJCQkgIEdQSU9EX0lTX09VVCB8DQo+IEdQSU9EX0FDVElW
RV9MT1cpOw0KPiA+ICsJLyogcHJvcGVydHkgaXMgb3B0aW9uYWwsIGRvbid0IHJldHVybiBlcnJv
ciEgKi8NCj4gPiArCWlmIChodWItPnJlc2V0X2dwaW8pIHsNCj4gDQo+IGlmICghaHViLT5yZXNl
dF9ncGlvKQ0KPiAgICByZXR1cm4gMDsNCjxWZW5rYXRlc2g+IEFzIHJlc2V0X2dwaW8gaXMgb3B0
aW9uYWwgcHJvcGVydHksICBieSByZXR1cm5pbmcgMCB0aGUgaTJjIHNlcXVlbmNlIHdvbnQgYmUg
ZXhlY3V0ZWQuDQoNClRoYW5rcw0KVmVua2F0ZXNoDQo+IHRvIHJlZHVjZSBpbmRlbnQgLg0KPiAN
Cj4gPiArCQlyZXQgPSBkbV9ncGlvX3NldF92YWx1ZShodWItPnJlc2V0X2dwaW8sIDEpOw0KPiA+
ICsJCWlmIChyZXQpDQo+ID4gKwkJCXJldHVybiByZXQ7DQo+ID4gKw0KPiA+ICsJCXVkZWxheShk
YXRhLT5yZXNldF91cyk7DQo+ID4gKw0KPiA+ICsJCXJldCA9IGRtX2dwaW9fc2V0X3ZhbHVlKGh1
Yi0+cmVzZXRfZ3BpbywgMCk7DQo+ID4gKwkJaWYgKHJldCkNCj4gPiArCQkJcmV0dXJuIHJldDsN
Cj4gPiArDQo+ID4gKwkJdWRlbGF5KGRhdGEtPnBvd2VyX29uX2RlbGF5X3VzKTsNCj4gPiArCX0N
Cj4gPiArDQo+ID4gKwlyZXR1cm4gMDsNCj4gPiAgIH0NCj4gWy4uLl0NCg==
