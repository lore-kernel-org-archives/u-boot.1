Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B9FCCFA771
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 12:03:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96CCA88B86;
	Fri,  4 Oct 2024 14:03:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tVQJAU84";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4950488B63; Fri,  4 Oct 2024 14:03:43 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::60c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E75F688C98
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 14:03:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=notYXZksiKwFSvuFKC2WyQlDT3MSVhHewRF0Q0jrxBOxksNzh8+Ys6ACQjNpAGy+pQwgEQs8N+r4DvOZsVod4+vhN1duh5+aWDzSGeQvfKMk/2hc5ZH5HfkyHvvmH4njvzAwlWP1rjuW2WF2ntZpe9IkAk1OQKoY3SNYp3nHsPTY2eTkmFb1ubWAof2H8p52fSQFB2j2MBAOtHRCOxNTGMOMfd877bT3kVYm27/rTnKp7lt0pbEHGZeEBjKJiys0zEhStpv/rv8Rmfh1pEwnURizkkZWzGI3ozcxch4s8J8zPSROdKcjzbVesD50PtTWx4jTpNek36AEryYTSoSwfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61rdq7D3Q/zPV5eeyBS2KKeFFWsFoPqYp7jbhUU2CDY=;
 b=XfwZ1/1y+kTnBDj9G69CVzEixwLXYVpvxIGXfTugmUoZV9GNJgAJbHWsPJBtimUlH9PQxEqPW12cMG00M3GAZJ1TvqTuM6RmYVl9CAMq/xs+q1imlH2docyNaXJc0W6rDYtibMGAK0QTAn/KtcGw3eqMWSMpgon91gMKP2jM/123nicMdJVyzqPQo7z3pp+4u54cr2EtxQuDc+R62t4ln3fgm9m99pPFUjxVtToEMseMcbK+BP1mv1mDn5VUvWbBfj/hKt6Zk9A/oe1NkKc1A90hFowD2tNnbbiAhQigzMak5ekK8HNI/Vr+e7OHpcVEMqq8DaukMs98skkdXArBdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61rdq7D3Q/zPV5eeyBS2KKeFFWsFoPqYp7jbhUU2CDY=;
 b=tVQJAU84eHq+05k1zbM+8fXQpMYf0VN4MTGCOFEfLk2bBHgmHSxA/AP/q2OTR8xLZlfrJM0OZZCHBn/Z6K/0oMHJ2IrKsrod/hTHPj6pVxYb/Lmzl9exMYVGyQV/SEldYeEwIo03B3ufYc7ZETsLHuL1cU2NLONt63ONVu9uNr0=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by IA1PR12MB6091.namprd12.prod.outlook.com (2603:10b6:208:3ed::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 12:03:33 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%6]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 12:03:32 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "Simek, Michal" <michal.simek@amd.com>, "fabrice.gasnier@foss.st.com"
 <fabrice.gasnier@foss.st.com>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH v3 1/7] usb: onboard-hub: Add reset-gpio support
Thread-Topic: [PATCH v3 1/7] usb: onboard-hub: Add reset-gpio support
Thread-Index: AQHbE8Cw1wwSjzBcqEOkNkd+RtrWkrJxyouAgAKoQHCAAH+OAIAALk6wgAAknwCAAKXiUIAAjJWAgAAKrLA=
Date: Fri, 4 Oct 2024 12:03:32 +0000
Message-ID: <SA1PR12MB86972BBB9F22E0C98AA541A198722@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20241001050529.17922-1-venkatesh.abbarapu@amd.com>
 <20241001050529.17922-2-venkatesh.abbarapu@amd.com>
 <6056a273-2699-4e94-93e8-ddc96084bbba@denx.de>
 <SA1PR12MB8697873F2C2EF86E6E9DAF9B98712@SA1PR12MB8697.namprd12.prod.outlook.com>
 <2e0928c8-e03a-44ae-aa36-3d664ed5bc6a@denx.de>
 <SA1PR12MB8697682FEEE48B015EE82E0398712@SA1PR12MB8697.namprd12.prod.outlook.com>
 <c40f47cb-7245-43b7-9b01-6b8d1cdff04c@denx.de>
 <SA1PR12MB869735B41B6F7A86520E2D3D98722@SA1PR12MB8697.namprd12.prod.outlook.com>
 <02fe6fab-7e8c-4408-950f-e6df2a258b16@denx.de>
In-Reply-To: <02fe6fab-7e8c-4408-950f-e6df2a258b16@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|IA1PR12MB6091:EE_
x-ms-office365-filtering-correlation-id: d73a1ef6-1ad6-40cf-628e-08dce46c9186
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cm1SNHA5OG1JenRhNFprZm5BSTYvTXpLVk9tZVZ5RHpjL2hZeFZJeFBmMURP?=
 =?utf-8?B?Wno4Vnh4czVNaGVJMWwzM1ZWd3ZlQWpMMGFkRUdQU09qWVdWeUtkckVrSVJ6?=
 =?utf-8?B?YkszMHBySDBtTXJyRTJreHNIZmF4b2dQNXBVTHhjRFdxWnd3Sk1CdUJwd0l3?=
 =?utf-8?B?NjJpRkVGeGpVSmZtVW53Zkc4ZlUxT01tOHJQeVh0NXF4NHN5U2NOVnJFTkMz?=
 =?utf-8?B?dE5ic1RkbUZiUnI3LzR3ejk2R1NYMDhwNDNXSk84aDZLZFBkMmc3NGdtZldi?=
 =?utf-8?B?N3RhQ291eDZMNHJjSUhTZHpmUUV2Ui9TaUtLd2Z1NHpBU2lwN01YdjVVVHc4?=
 =?utf-8?B?QU40TXlLV1VqVTYrTzRjVit6aTBwQ29YNHZiYTFsK1R1K0hKcHNWVmtNOWt4?=
 =?utf-8?B?SWhXVGJhWkpIcEt1U0pSZEZHRVVYdjM2THhKelZ1eTM3WFBDZHEyc0dPSHAw?=
 =?utf-8?B?TmJXN0NCMDVSUUlJTDBRZjhkU0Zmb3A4czI2SmMvVThhaloyNzdYdXpDWFFn?=
 =?utf-8?B?allxZEwrUFdodEdYSDFubnlwSHFFTm1GZ2d1dXBQeVk4dmkxKzh3SDI1RDEr?=
 =?utf-8?B?YXdHY0RHallQd0x1WU1KRXhGR2E1dkVrdGU2ODBXTDR1a3BRT1NDcG5uVTFI?=
 =?utf-8?B?Y3VXajNia2hxZmI0U0ZIT01XeE5uK0xXWHRLdFk5bGdDdU9oTlVGa0RKWGF2?=
 =?utf-8?B?YlBZdlZDME9YTkdBZkIvTTkzUFcwcXdOUElNamdFSDJDYzdQQkZtUUZvOW40?=
 =?utf-8?B?TW9HU2wzeGFtb1Z2QzM0MXRqSHQ4WjQxUlR2MURxK1UyaHdWQWVMOURCeFdJ?=
 =?utf-8?B?NE9kNENzTU8rNXZBelVFRjRML0NIMFBocFBlOWR3ZHhlT01rUDdtSkUyQm5o?=
 =?utf-8?B?ZGFqbXZCWE90Q3RMaFJjdXVOMmdLN3JjbDBPUG43RXFFdy84emhyVnB2a1pL?=
 =?utf-8?B?Q1RRWnpwdXJuRFVSOFhYZXgrS0gvY2xacVZHajJXZTlKbmJ6U0p5NG9GS243?=
 =?utf-8?B?YU1abmlMbDYzeFBMb2JPRnJhS2trQWNLNG1ZK0kyeG4rLzlRc09xNnV5ZER4?=
 =?utf-8?B?UC82YVA5WlVNaUQzOS94L0JqVmZWS1kweXorclZlb1BaYVRCZkJGWHpPNExN?=
 =?utf-8?B?S29XTlhOTlZIUHc3V0dtYk9JZTJaUCtuTVFTTUhXSE0wV0M3WFlOWnlTUTlt?=
 =?utf-8?B?Q0Q4VDMzNElFZ0JuaENUMit1dHNwckpvZVhFc3lCZTBUOVhDeDFDY0VvcG9F?=
 =?utf-8?B?OExxejZqNUZGRXJDNWwzYnJDWklTSW1GTUNLbVFFVU9GUExZcGNOVStPcEJ4?=
 =?utf-8?B?OUF0cTFQUjBBbDBuSEdtUjhrdUlidElxWTRrbUY2ZEc3c08yeHJ2akVXU2lK?=
 =?utf-8?B?ejJwMENwemR6bXBIYmd5aWEvVmxwS3dONDJTU21oVWNzaXF5Yjc5M1FSeTNI?=
 =?utf-8?B?V3Z2YnkxRHZLYi9TNkxyUjVxVmJyQURHSlJSWG53S0JYaVdkMVFNd3Q2cXFo?=
 =?utf-8?B?dWVkd1ZZTTJ6cElxU0grSzdYaFBzZlYxaGlVc2JmYWc3MlNnWDZ0R1R2eUM3?=
 =?utf-8?B?cnUwU2IrdzJtNHJKd3hoa2NocnlKdEU0Nmg4TWFWVE9SOE85V1B4L2NXK0wr?=
 =?utf-8?B?bk4zc0w2UitldWlWQTJKb25Za2lpWk9DYk9tYWpETktvU2lWUmdCdzJ2cjd4?=
 =?utf-8?B?MmZwNGZBTDkvQnloMmQ2MlNiZ0c5UDI3dFd2OUZFYWY0bDhRa3N6T08vS05W?=
 =?utf-8?B?ZktwQkcxNXE2UG9yenV2b0d4WGFRZCs0SXA3THdWTzRjeFhyTWZ4TEpYc0dN?=
 =?utf-8?B?OGxVbE5lK3ZERWNteURmQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N25FNnp3REl4ZGp1YzdvUEUyMk0vSFk5YWlUQklFMFFTMlVDc1VwL2xrUWJv?=
 =?utf-8?B?NVNVdUx1NXFhcFhWOFJhQlFlM1NRTFVHTjFFM0tReFRTajBSeFZxOG1HOTFT?=
 =?utf-8?B?V3hjZXAwaUtJQmNMUXBsWi9IbCtNQWFOZW5qbFA2c3lVM2w4WmVtcFQ2RmhB?=
 =?utf-8?B?Q1VndHJQQlBUWTFXVVovelVXcDZGN2FKQ0lrQWNQRUNEYmRtQUdTclBLbDBn?=
 =?utf-8?B?TGRTVlNuZXJWNUE3ek9IWFhWaE5tVEIzWFc0dzViNytRTkxyMC9yZXdWV1A0?=
 =?utf-8?B?R2gwY3ROajdMUlBkOFlScFMrNmpLRHpmdHRnRlVod0ZPVXFITW5XOTZ6dURl?=
 =?utf-8?B?bkNWWXlVMEx2SmdGUGxmbU5wSEZORGcySnVhbmF3VXFRUkh5WGxKcCtxM3Fa?=
 =?utf-8?B?Ty8zQVNwdUM3RnRRL2t3T0xrZjNKbXVIZG9MVnJNa1BoMEFpL216QmpoL2dx?=
 =?utf-8?B?QkdCamhST0FzQkttQlZXY29IanJIYjdnN2NQZVcvd2lyTXdzaFV5RkpFQUNp?=
 =?utf-8?B?R3o1R2ZHU0tqWkc4WFppcmxsTTM5djhudUdpekdETXNldWJOSmRnWVB1Nkxy?=
 =?utf-8?B?VWdGYW5GZ2Jxd0x2WFdzUzB6eGRsSmppNmEvNUw1Wkd2VmJ0RXVQZTJ4SEx1?=
 =?utf-8?B?cjRiekx2VkVNQzh5eXVhRldxN3hiaUVkTkVXM0ZQRGgrUW5EM2dSUXhQS295?=
 =?utf-8?B?Z3dsQXBYNmNaZERYOWwxT2Y5MjA1RE1PdXBvSmdtUWowMlgydGJTOFVPWHVZ?=
 =?utf-8?B?NTYxTlBIYm5kNUd6dVQ3cXBjRHlCamVSNjk2bU9VTmw5cStjQkhsK2Z3V0NE?=
 =?utf-8?B?RWFROFFJYXRWNzBialFYUnhuYkI5bFpaSC91STBlNkpWQ2xQeHFodmxMZURH?=
 =?utf-8?B?WElqQm9nYko5MFRJdzV5TFVYYlRYclc2U2xoNUR4Qmk2QUhrWFZmaGY5VGlD?=
 =?utf-8?B?VzFTSk1sTXB4aStnUVdwTEpUSmxaR1dJQUVkcjhBUGw0VjI4M1VyVWZnSUdS?=
 =?utf-8?B?UDZqVERjTFl2TFA0eURQQnlFdW5ocXpCQnJGbHQrK3BFMmNpdnFIYWdtREcz?=
 =?utf-8?B?WWVENENDV2hDdHlqY3crU2xVeWtoR09UZVhZbUV1QitVN2FRMEd6TmhlRUtO?=
 =?utf-8?B?N2dBK3RLY3lpZHZtSjJPY2hUVFNIY0VyMWg0WVViRnp6d0ovNEJMU25hN0Qy?=
 =?utf-8?B?U2VUd2lwU1drUzNjZStJZGJJbXJWeGY1ckd3bUZ2SzFRbFRteWJPT25SaFoy?=
 =?utf-8?B?V2V1aFRIeVIrZ1JRYnFFQzkyUitwQlc3VWRZNWJlTW4xYktlam1NMEdUcE5m?=
 =?utf-8?B?bXVidk1KRXVlM1hPSFFpam5tdlQ0Y3pxcjNwUW1Ia1I0Qm5SL0hGbkRIOElh?=
 =?utf-8?B?WkJkV1NzMUVyakV3US9ZbUpITExQQnhFRytWRkdCM0ZLVGs1TGIySWJkd29F?=
 =?utf-8?B?L1Q2YzVmOE92cnhTNzE4cldiSGFMM1Zhb282U0I3RFVSeldNYVc3TWxmREw5?=
 =?utf-8?B?RWZVWmo4TmlKYUFwSUNHZ2xKbGsvMlNka3ZidTFwOTl0VFdFQm1WbXlQb3Ev?=
 =?utf-8?B?VmJ5Y3ZhRXZCU2dqUmp2K1BDZlN3YjhCc0FKc1VmckthcHhEVVlzejNXRUI4?=
 =?utf-8?B?a0hlWFp0b0FjeXArVFYzNkhpSFF3OGh0Rm5scFhwc2p1bVJDUmF3M3VwTDR4?=
 =?utf-8?B?ZXlQRHp2RFBWVzJDRVNYY0tHZFpvYThHYTJ0ZTEyVHp5UGkvUlVPMGg4NFZk?=
 =?utf-8?B?K1QwWHBOalVMOGNYK3ZvOExuaFJ6TzFKUTBHVEYrUCtWUEZ1WDZWc2xnTjhE?=
 =?utf-8?B?MksyamRqUk5SWTMzVzJxU3c0K0djOVprZE8za2tuWEw3SVl3OFZJM28wMHl3?=
 =?utf-8?B?amJYWkE0VGppRlhYUXcyenJSY2dLY09Db3pjaytwVFZDdFY5SXVHYmxlNU9l?=
 =?utf-8?B?QUsrbjJQWTBObjdVWTg4alZWcm0yU0IwcFgxdmlhb0l1ekFrTWNtRzVHdmpJ?=
 =?utf-8?B?enFoTmNKSGhnOW1zS3BhUG5HNW5iQkcwbkdYVUs3M2xMdkJPVW1KcXpJV0s5?=
 =?utf-8?B?SDcvVjhWdGI5cUEySUNwSm5rU1NORHdXckdnSDJlSXBEUncrd2hmU2kySVMz?=
 =?utf-8?Q?qQ0g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d73a1ef6-1ad6-40cf-628e-08dce46c9186
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2024 12:03:32.8260 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5UdO4Aov4NJkWifcg5/1xYhSx+a0JYMnpnOFOIw6GfO4b6M9hZfFlFaxXemUV7xmU0CNx8eeUQkrhpNxO6l37A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6091
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

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyZWsgVmFzdXQg
PG1hcmV4QGRlbnguZGU+DQo+IFNlbnQ6IEZyaWRheSwgT2N0b2JlciA0LCAyMDI0IDQ6NTIgUE0N
Cj4gVG86IEFiYmFyYXB1LCBWZW5rYXRlc2ggPHZlbmthdGVzaC5hYmJhcmFwdUBhbWQuY29tPjsg
dS1ib290QGxpc3RzLmRlbnguZGUNCj4gQ2M6IFNpbWVrLCBNaWNoYWwgPG1pY2hhbC5zaW1la0Bh
bWQuY29tPjsgZmFicmljZS5nYXNuaWVyQGZvc3Muc3QuY29tOyBnaXQNCj4gKEFNRC1YaWxpbngp
IDxnaXRAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAxLzddIHVzYjogb25ib2Fy
ZC1odWI6IEFkZCByZXNldC1ncGlvIHN1cHBvcnQNCj4gDQo+IE9uIDEwLzQvMjQgNTowMiBBTSwg
QWJiYXJhcHUsIFZlbmthdGVzaCB3cm90ZToNCj4gPiBIaSBNYXJlaywNCj4gPg0KPiA+PiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBNYXJlayBWYXN1dCA8bWFyZXhAZGVu
eC5kZT4NCj4gPj4gU2VudDogVGh1cnNkYXksIE9jdG9iZXIgMywgMjAyNCAxMDozNSBQTQ0KPiA+
PiBUbzogQWJiYXJhcHUsIFZlbmthdGVzaCA8dmVua2F0ZXNoLmFiYmFyYXB1QGFtZC5jb20+Ow0K
PiA+PiB1LWJvb3RAbGlzdHMuZGVueC5kZQ0KPiA+PiBDYzogU2ltZWssIE1pY2hhbCA8bWljaGFs
LnNpbWVrQGFtZC5jb20+Ow0KPiA+PiBmYWJyaWNlLmdhc25pZXJAZm9zcy5zdC5jb207IGdpdA0K
PiA+PiAoQU1ELVhpbGlueCkgPGdpdEBhbWQuY29tPg0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENI
IHYzIDEvN10gdXNiOiBvbmJvYXJkLWh1YjogQWRkIHJlc2V0LWdwaW8gc3VwcG9ydA0KPiA+Pg0K
PiA+PiBPbiAxMC8zLzI0IDQ6NTQgUE0sIEFiYmFyYXB1LCBWZW5rYXRlc2ggd3JvdGU6DQo+ID4+
PiBIaSBNYXJlaywNCj4gPj4+DQo+ID4+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
Pj4+PiBGcm9tOiBNYXJlayBWYXN1dCA8bWFyZXhAZGVueC5kZT4NCj4gPj4+PiBTZW50OiBUaHVy
c2RheSwgT2N0b2JlciAzLCAyMDI0IDU6MzggUE0NCj4gPj4+PiBUbzogQWJiYXJhcHUsIFZlbmth
dGVzaCA8dmVua2F0ZXNoLmFiYmFyYXB1QGFtZC5jb20+Ow0KPiA+Pj4+IHUtYm9vdEBsaXN0cy5k
ZW54LmRlDQo+ID4+Pj4gQ2M6IFNpbWVrLCBNaWNoYWwgPG1pY2hhbC5zaW1la0BhbWQuY29tPjsN
Cj4gPj4+PiBmYWJyaWNlLmdhc25pZXJAZm9zcy5zdC5jb207IGdpdA0KPiA+Pj4+IChBTUQtWGls
aW54KSA8Z2l0QGFtZC5jb20+DQo+ID4+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAxLzddIHVz
Yjogb25ib2FyZC1odWI6IEFkZCByZXNldC1ncGlvDQo+ID4+Pj4gc3VwcG9ydA0KPiA+Pj4+DQo+
ID4+Pj4gT24gMTAvMy8yNCA2OjQwIEFNLCBBYmJhcmFwdSwgVmVua2F0ZXNoIHdyb3RlOg0KPiA+
Pj4+PiBIaSBNYXJlaywNCj4gPj4+Pg0KPiA+Pj4+IEhpLA0KPiA+Pj4+DQo+ID4+Pj4+Pj4gQEAg
LTMwLDcgKzQwLDI0IEBAIHN0YXRpYyBpbnQgdXNiX29uYm9hcmRfaHViX3Byb2JlKHN0cnVjdA0K
PiA+Pj4+Pj4+IHVkZXZpY2UNCj4gPj4gKmRldikNCj4gPj4+Pj4+PiAgICAgIAlpZiAocmV0KQ0K
PiA+Pj4+Pj4+ICAgICAgCQlkZXZfZXJyKGRldiwgImNhbid0IGVuYWJsZSB2ZGQtc3VwcGx5OiAl
ZFxuIiwgcmV0KTsNCj4gPj4+Pj4+Pg0KPiA+Pj4+Pj4+IC0JcmV0dXJuIHJldDsNCj4gPj4+Pj4+
PiArCWh1Yi0+cmVzZXRfZ3BpbyA9IGRldm1fZ3Bpb2RfZ2V0X29wdGlvbmFsKGRldiwgInJlc2V0
IiwNCj4gPj4+Pj4+PiArCQkJCQkJICBHUElPRF9JU19PVVQgfA0KPiA+Pj4+Pj4gR1BJT0RfQUNU
SVZFX0xPVyk7DQo+ID4+Pj4+Pj4gKwkvKiBwcm9wZXJ0eSBpcyBvcHRpb25hbCwgZG9uJ3QgcmV0
dXJuIGVycm9yISAqLw0KPiA+Pj4+Pj4+ICsJaWYgKGh1Yi0+cmVzZXRfZ3Bpbykgew0KPiA+Pj4+
Pj4NCj4gPj4+Pj4+IGlmICghaHViLT5yZXNldF9ncGlvKQ0KPiA+Pj4+Pj4gICAgICAgcmV0dXJu
IDA7DQo+ID4+Pj4+IDxWZW5rYXRlc2g+IEFzIHJlc2V0X2dwaW8gaXMgb3B0aW9uYWwgcHJvcGVy
dHksICBieSByZXR1cm5pbmcgMA0KPiA+Pj4+PiB0aGUgaTJjIHNlcXVlbmNlDQo+ID4+Pj4gd29u
dCBiZSBleGVjdXRlZC4NCj4gPj4+PiBUaGUgY29kZSBpbiBpZiAoaHViLT5yZXNldF9ncGlvKSB7
IC4uLiB9IG9ubHkgdG9nZ2xlcyB0aGUgR1BJTyByZXNldCA/DQo+ID4+PiA8VmVua2F0ZXNoPiBZ
ZXMuLi5pZihodWItPnJlc2V0X2dwaW8pIG9ubHkgdG9nZ2xlcyB0aGUgR1BJTyByZXNldC4NCj4g
Pj4gU28geW91IGNhbiByZXR1cm4gMCBpZiByZXNldF9ncGlvIGlzIE5VTEwgYW5kIGV4aXQgZWFy
bHkgLiBXaGF0J3MgdGhlIHByb2JsZW0gPw0KPiA+IDxWZW5rYXRlc2g+IGlmIHJlc2V0X2dwaW8g
aXMgTlVMTCBieSByZXR1cm5pbmcgMCB3ZSBtaXNzIHRoZSBiZWxvdyBjb2RlIHdoaWNoDQo+IGRv
ZXMgaTJjIGluaXRpYWxpemF0aW9uIHNlcXVlbmNlLg0KPiA+IE5lZWQgdG8gdG9nZ2xlIHRoZSBn
cGlvIGFuZCB0aGVuIGRvZXMgdGhlIGkyYyBzZXF1ZW5jZSBpZiB0aGUgcmVzZXRfZ3BpbyBpcw0K
PiBwcmVzZW50LCBlbHNlIHdlIGRvIHRoZSBpMmMgaW5pdGlhbGl6YXRpb24gc2VxdWVuY2UuDQo+
IA0KPiBQbGVhc2Ugc2hvdyBtZSB0aGUgaTJjIHNlcXVlbmNlIHRoYXQgaXMgbWlzc2VkIGluIHRo
aXMgcGF0Y2ggaHVuazoNCj4gDQo+ICsJaWYgKGh1Yi0+cmVzZXRfZ3Bpbykgew0KPiArCQlyZXQg
PSBkbV9ncGlvX3NldF92YWx1ZShodWItPnJlc2V0X2dwaW8sIDEpOw0KPiArCQlpZiAocmV0KQ0K
PiArCQkJcmV0dXJuIHJldDsNCj4gKw0KPiArCQl1ZGVsYXkoZGF0YS0+cmVzZXRfdXMpOw0KPiAr
DQo+ICsJCXJldCA9IGRtX2dwaW9fc2V0X3ZhbHVlKGh1Yi0+cmVzZXRfZ3BpbywgMCk7DQo+ICsJ
CWlmIChyZXQpDQo+ICsJCQlyZXR1cm4gcmV0Ow0KPiArDQo+ICsJCXVkZWxheShkYXRhLT5wb3dl
cl9vbl9kZWxheV91cyk7DQo+ICsJfQ0KPiArDQo+ICsJcmV0dXJuIDA7DQoNClRoZSBpMmMgc2Vx
dWVuY2UgY2hhbmdlIGlzIHBhcnQgb2YgICBbUEFUQ0ggdjQgNC83XSB1c2I6IG9uYm9hcmQtaHVi
OiBBZGQgaTJjIGluaXRpYWxpemF0aW9uIGZvciB1c2I1NzQ0IGh1YiBvZiB0aGUgc2VyaWVzDQoN
CisJaWYgKGRhdGEtPmluaXQpIHsNCisJCXJldCA9IGRhdGEtPmluaXQoZGV2KTsNCisJCWlmIChy
ZXQpIHsNCisJCQlkZXZfZXJyKGRldiwgIm9uYm9hcmQgaTJjIGluaXQgZmFpbGVkOiAlZFxuIiwg
cmV0KTsNCisJCQlnb3RvIGVycjsNCisJCX0NCisJfQ0KKw0KIAlyZXR1cm4gMDsNCitlcnI6DQor
CWRtX2dwaW9fc2V0X3ZhbHVlKGh1Yi0+cmVzZXRfZ3BpbywgMCk7DQorCXJldHVybiByZXQ7DQog
fQ0KDQpUaGFua3MNClZlbmthdGVzaA0K
