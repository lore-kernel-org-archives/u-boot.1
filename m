Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D749C28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 04:05:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43497801FB;
	Wed, 12 Mar 2025 05:05:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yjiGDVAC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F238807D7; Wed, 12 Mar 2025 05:05:10 +0100 (CET)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::62d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21511801BE
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 05:05:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K2ygiFXCV6cdppvQ4IXcQ21OmviMvfmz7BK9OrVNUwKpiDLYXkHklKGivAu7uYf6Eym5p3kA+nTiML2X5f+KNwUEPU6aeUL1o3jxjOG6DshzpvOUtXIWpuat667zOzGwTn6bvm2viTSuJTXhNb6kENiQ5+yK0YWsIvf5DElPAavRtF/XAg8Md0/JIQrDCHEM2IScHT6jWh2tPCU+vLOPsu+d4QGXpasjA/UdTXZDyGHd9gEdqRZ8f8UliC//U1yEZTtOJvU0y5FJAZkgGQh/uunvRRdAQUvF7RbRjJ2rxFNMjEWPRhWw3n3rmaFco1xTO9rqofgV/sasRDFq/YVpyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EILEg2RVIliMzmQAcLgp4CCnv1UcmRQb9NZ6txTeFYo=;
 b=Aj2t9FZpVgCjsBPuG90WMPjjWMAJy2BYUEF/PUMNdfVg0u62gcuoP/fZCCJ+Sr8QFh6HYh3hCwNT4/7/RuoT6ea/zvtv0+SuTjRV6w+UuM8hxamJWIm+u2HvLpugUmpeoBjE0gV5w8bUhYNr5dONJCW+pPGiFth1MqjZeoEHop2p4M29dtN3ICr0F3OfQuClO//EjV2+PSy4wt8lMjOlpkPsrtxPNesH3SyGQ9zVYT7O4tHjxYaZzdJW03sh4x2i3i1Wu6oiF4b8urIuItNH9xm5OUt9OeDJkEY75QcbEOSNb93J9jADz0Ru6lOdW/1R2f5xfDTt5h0ibg4VmVuKrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EILEg2RVIliMzmQAcLgp4CCnv1UcmRQb9NZ6txTeFYo=;
 b=yjiGDVACBUEE3kbfc7/das6qa4s6u82UWUsXQsCzTXz36z7mcpZlM7GlmB8HiUhuysKjFl4ahvt9nkx7kLPZDmwlLaBhRgcEvh/WdApbx+pLVGxnJPOznaRCo5kOBJOt2d7LjMFicWrIqLyssAQdM3FLh/lG6ICjVhsaYObjVY0=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by CH3PR12MB8512.namprd12.prod.outlook.com (2603:10b6:610:158::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 04:05:05 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 04:05:05 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: Mike Looijmans <mike.looijmans@topic.nl>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "Simek, Michal" <michal.simek@amd.com>
Subject: RE: Reading QSPI on zynq7 broken since commit 9bb02f7f4533
Thread-Topic: Reading QSPI on zynq7 broken since commit 9bb02f7f4533
Thread-Index: AQHbkmlRDZbFaYG7gUKI0vI11XX77bNu4oYg
Date: Wed, 12 Mar 2025 04:05:05 +0000
Message-ID: <SA1PR12MB8697648198657DFEE5130A1B98D02@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <282a304b-29e4-42aa-84de-485944377806@topic.nl>
In-Reply-To: <282a304b-29e4-42aa-84de-485944377806@topic.nl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=d7cb1097-37ba-4beb-88f1-212eeb984877;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-12T04:03:12Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|CH3PR12MB8512:EE_
x-ms-office365-filtering-correlation-id: 3d801f05-b72d-47d1-a867-08dd611b1216
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?K2dVZXRIRGxXRCtqK2lDejdudHZsRHlPS0Z2RExOYkg0Q3NTdjd1aVFaek1Z?=
 =?utf-8?B?K0ZsR1VBMXJOOE13UERoZ0V3NGo5akJrQ0ZjQVJEMXpvVFBWY05oTDhRdjl0?=
 =?utf-8?B?RW9nalpWVTN3Qm9INWRUWVgwYnA4TG9oN2ZPQ3VoclBZR2NuZHhucERCRWIz?=
 =?utf-8?B?c0tyK1NXbDdYcWFWRElUSXBFd0h2eW5ZTFlqYUs5Z0Y2WXQ1cjhEOU9pQm9I?=
 =?utf-8?B?V3ZveTZ3SDFiblIwWWdDNU1TNlNaMFYxR0VCek1RZVA2cnpKZmNNOTFGenZG?=
 =?utf-8?B?ajljMGY3c2FZeDB1aWpUUG5MZmFQVXF3SU5VNnd2dThuMTdCQ054aExSRjVD?=
 =?utf-8?B?QlhJbDlMMmR6Um8yQ3BjcTRiR1RIS0U3VDEra3hzSENxYnFjdWdDZWFGV0pa?=
 =?utf-8?B?NjlnN1JQTWF4M2xXelBjSmV1RUZ4NnlsNzl3bnFhRDhidktUdzI4VFhoSzZW?=
 =?utf-8?B?SklzVFl1eG9HL2s0S1plZllXSkxMV1VpU3MvTVNoNzJ3U2NwZXhtcytDaHhk?=
 =?utf-8?B?emYzNXU3Wk1ZWVVnNXNmV0loQkY5SEdOTmVOWmRIaUl0YmJyamtSak9LNXgw?=
 =?utf-8?B?TmpFMHNSRU0wSVJ0QzFTOFlHL09wazYxQTFRVmlISGtPamtpUEQ4RDB3a0Js?=
 =?utf-8?B?OUJNSERKb1p2NVo4RU9FMWxEM25qZVBlcDdpMUc5QnNZTVV0SVFTVXlEVGps?=
 =?utf-8?B?V3pkTmRHMDhXMDdNbUpaMC9UZTZCV21oY0hxWHZmc2dtaHBONkhxMkVMMDJF?=
 =?utf-8?B?SUdmZEhhVlBLTWpUOVl2NW5RMFl4RnRnbGxKT2xIdVpyaTUyaWJhcXlIbWNW?=
 =?utf-8?B?SDV1N3NiVVFTY3o5aFhodmRXS3RvZnlIczU5SmJ2K2MyZXo5cWJlbUM2MVFn?=
 =?utf-8?B?ZHJmcDdCdUdrY05kQzJjdDZYcmJWRm9PS3QwbFJMV0kydE9vRnJEM3Z6WFpq?=
 =?utf-8?B?c3IyMUtrdS9HTm1ybTNKaEhoeVN1SllnWUxJQ1IxTTUyNVl6TnNjUWdrMjZW?=
 =?utf-8?B?THFYaTRlQnRIbGo2T0N1VjFETTJIQkg1cTV1ajVhZnhSNjlLUWtGajFRdlM5?=
 =?utf-8?B?ZmpRVEp0UzczNHl0MTJUaERGeCtpMFFOR3lJbnVVSjl2SEVxSk85NFBqUnJK?=
 =?utf-8?B?amxXcTg3RmEvUWF2aVRYa2xUbEhVN1pIdzNoU3JaYnJXbVU0dUFPWm5wOGtH?=
 =?utf-8?B?Z2RMYWJIYkNacTlDTU5zRkhmaFpBUnRyMjBhRURzK2NvVWRHN2ovbHo0S25C?=
 =?utf-8?B?bkt6OHpiUEFmUGFHd0RBcnlCYU1wWWZqVVNpT25YUSswcmp3OU51eWZwZkZK?=
 =?utf-8?B?S2J4MUVqdklBM2x1aHp0ZnJJT0swQU83aWxzVzNob1VJNFBmYnlCeU51U3Zp?=
 =?utf-8?B?bHN0dnVuTGxxa2tOMFhnMDlVbEhrT2Q1ZmhLRWVGS0ZpV1ZCNTBNVmZHNkZx?=
 =?utf-8?B?aU1kcFUyLzA1MzBCdnhoNGJ2cFZzWVJ6M2pETkV0WFg1bWk3WGxYR1duM0c2?=
 =?utf-8?B?bzhWZW9XdXFYWkI4WEVtZU5CR2ZTUUdBSWtWVkp4OVBxN25YN3NhRjlDNEVP?=
 =?utf-8?B?TTlSRFBYVWE1Rkl3eU5SbDFtQlV0Vk1NM0pIcE8yYnpoTkhUNXZKK1Z5SUMz?=
 =?utf-8?B?VHBkNWtOR1pDc1VMZDljb3pzRkg2RXNRMGVCMjFESkN4KzJnRHFuaEliamRa?=
 =?utf-8?B?bndtb3BiaGtjVVBJREppMHRSMGljUGxmeWhLTmUxLys1cW82VGhha2lzVjVP?=
 =?utf-8?B?cTJ6ZFNRd0oyb2JXL3NVN01hcU9uUHFBRWxQWWhhNmZWbjZ4SHJRb0psQ0lR?=
 =?utf-8?B?WWJXaHR2OUphN1B2Q2N1cDVEcTBjTm1EWDhzN3VxREZBdlBKcXdlSTJ4M1A0?=
 =?utf-8?Q?jNJpvlt8s7qO0?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bTRmeitCenkwRDl4OVNjMG90ZTZqS29uOTIxTk1yamtYNnFieG14aENIaUhF?=
 =?utf-8?B?bkh1cmIrcFY5S2FHeks3Y0pCYXNVc3IycE9hQ2NGdnBtc0JiR3BPTnZuQnpJ?=
 =?utf-8?B?UTh1dGVFUG1weTJ6ejJXb2VmbUpTV3pjc2t4RDFFOTN2ZUtrWnBBNU5zNUlK?=
 =?utf-8?B?VGxiKy9tcmg5VzdHQzNNeVU4dUZqVmVGQmZjeGVValNBZWo2QmcrR2taTHBD?=
 =?utf-8?B?eE1LV1FybExGTUk2TlAxaCs0UXprYU9pdlRYaEU5V25rUHZSNWxlUEFMdUlG?=
 =?utf-8?B?NEtTQmN0aVFNNkc3OFdLLzN6ZWc0SzY1OC9tb3REeW50T0JhMXczM1N1aS84?=
 =?utf-8?B?TUdHODZVejJzNWxUelREWlMyYnhLcVBWYUVpMUxCUkhnRkx1YlRXemF5T056?=
 =?utf-8?B?U1M1ODFVcWIwM203a1RzUEM0WDRHMVYvc2kvOVlYWlo1V2tLalVSc2kwSTlp?=
 =?utf-8?B?TUh2c1VNM2dJTFg1M04wcm5WZ2ttUjlDS2Rvd3dnWFZPaTR1cVNqQ1BhUWx6?=
 =?utf-8?B?SkxRS0oxc0dYQkVTQm43clBRUDQ1TXRMcVlUNVFWU0tONE5rRXdhdUUvZDVz?=
 =?utf-8?B?ZHI4QjljMThjMmt3UzdKWVVQWjhGNHdXamE1NHJmY1poejJLbzVxcC90d28x?=
 =?utf-8?B?a0tJT3dsaGlBdzBjckVlQ1p4aS84aW1hUjB6SW9NZlcyVXI0dVhjcTZ4WXJy?=
 =?utf-8?B?WDNlYWdQWng3Vzh2U083OWE4RVlKNjVQQTdkNWtEV3E3cnZEQ0IwKzBZL1hY?=
 =?utf-8?B?MjNnOUQ2WVd6dnlhcy9TOU5ndGtDcU1Ya1VuaVM5WnQ0WG13RHNPeEF4VnJO?=
 =?utf-8?B?d0pqRGY1d3VEa3pESmg2cGtXY2JVRzFremRYd3IrRDB1ditWS0xOV1QxWTRu?=
 =?utf-8?B?c29lYk1WRVJRNDF0YW81TFh0aFpyT0I0cms1bHFkeDU4QmlFL255Z2RPMVMw?=
 =?utf-8?B?N2M1SVFBZDJDdmVhWS9XQzhaYnEzTmg0Szk4SlAvZHkwSXprSTgzMXlveENo?=
 =?utf-8?B?Y2s5NGtvakZjSlo1cDRLaVcrTEJkZUEzdlYrckpyRzdOQWVTS1ZlRWpXUUhE?=
 =?utf-8?B?NGxtN2JNR0lSdnRJSGdVbWpPcXVvUXd1QzBOa1BxQW9qTGxOZ21IQWxhSk81?=
 =?utf-8?B?cmlzRWFjdzJlMmNneW94ekRKZ1RIMmloY29kRjNrVzBYUmd4VVk5L3JuSUVw?=
 =?utf-8?B?WWtoUWpveExpaFg5ZGNMeGpvNTl3TDZnc013WTB3TkxRQUduaGtQMGlJNVdO?=
 =?utf-8?B?MmJ6Y1IvSzdVUXRoNGs2bXVRMGxzRi9mZXB3NWlmTFhJQ09jNVA3Q3JVcyts?=
 =?utf-8?B?NzV3MUxFakZHdGRQcVVzQTI4eWxOOG9qbFhYRDAzZll1MTZlMmlML1dwK0VJ?=
 =?utf-8?B?TFhmYXpSRTdhUjBXSDVBbmNyOWFQOURaN2ZjUmh3dEM2M09WVjVLcFNtMDJj?=
 =?utf-8?B?cXNYVy9pekQxQ2NXaEFLazVJK21LN1ptTU1ycnEzNVFwOGJJZjVPRHhCNk8r?=
 =?utf-8?B?Y2d6cVgvNnhGL1JyLzdmRWNrdEZNTEtoNEE2K2dTNGRxVEl1c3NoSkNMR3Zw?=
 =?utf-8?B?VzBtRlU3ZGZNSW9IZWtjb1lLM1kxeGx5SjdVKzZCOFRnQlZTUnNsc1FWTXZk?=
 =?utf-8?B?V1Nnam9uUm5lQnRML2kzbnV0ZzYvQ3hMZEFFOUpTb1N6SmcxTlI5V3V1WnBN?=
 =?utf-8?B?SUNsWWJ6S0xDU3JjekVGV01GQUtyWmVRalh3cTJERUZsYnR5aWF0Ry9xclRs?=
 =?utf-8?B?ZDM1RmNKSVdmVFFxeUg1Vk1HNlpXbWdmOGk1dnVKM1J3NmdhenoxSWszUUVN?=
 =?utf-8?B?WXJYRzFHSk1wcWhSNDVKVDlYZXFXYnNWSTRzdTh5SUIvVTZ3azIxMTI2bDdK?=
 =?utf-8?B?STJEN1c2bkRKWHZpc2JVSXR4a29jdUlqVUJqdUxZTkRQMVZVcXBjOWRocDNN?=
 =?utf-8?B?anBTc0RIbDdmWHZvbWFsbEt6a0JXZmFhUS8zdnBCQVh6K3hjenIzSXVER1Fo?=
 =?utf-8?B?S0x0cEl0Y3lQQVFyNE5sNEtnZzlqbnBRNHc3RWw3amxmNmEyQUlTTTcySkNZ?=
 =?utf-8?B?UTI5SVIzT2M0ZFhuWXgrRS9lU200cEFYY215RlRCTEFxSjBnbXBPVkVIY25l?=
 =?utf-8?Q?nAr8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d801f05-b72d-47d1-a867-08dd611b1216
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 04:05:05.1788 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8+jL3bsYzEBt+srwRDYu5tHSODyUk72z9VYsZIjdXBrJ/B47wplslwvKAw7VaJ8Wz01gbuE2mJMCLiRtTuSFkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8512
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgTWlrZSwNCkNhbiB5b3UgdHJ5IGRpc2FibGluZyB0aGUgY29uZmlnIFNQSV9TVEFDS0VE
X1BBUkFMTEVMLg0KSXMgcmVhZCBnZXR0aW5nIGZhaWxlZD8NCg0KVGhhbmtzDQpWZW5rYXRlc2gN
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaWtlIExvb2lqbWFucyA8
bWlrZS5sb29pam1hbnNAdG9waWMubmw+DQo+IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDExLCAyMDI1
IDM6MDggUE0NCj4gVG86IHUtYm9vdEBsaXN0cy5kZW54LmRlDQo+IENjOiBBYmJhcmFwdSwgVmVu
a2F0ZXNoIDx2ZW5rYXRlc2guYWJiYXJhcHVAYW1kLmNvbT47IFNpbWVrLCBNaWNoYWwNCj4gPG1p
Y2hhbC5zaW1la0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSZWFkaW5nIFFTUEkgb24genlucTcgYnJv
a2VuIHNpbmNlIGNvbW1pdCA5YmIwMmY3ZjQ1MzMNCj4NCj4gQWZ0ZXIgYSBiaXNlY3Qgc2Vzc2lv
biwgdHVybmVkIG91dCB0aGlzIGNhdXNlcyBteSB0b3BpYy1taWFtaSBib2FyZCB0byBmYWlsIHRv
IGJvb3QNCj4gZnJvbSBRU1BJOg0KPg0KPiBDb21taXQgOWJiMDJmN2Y0NTMzOiAibXRkOiBzcGkt
bm9yOiBGaXggdGhlIHNwaV9ub3JfcmVhZCgpIHdoZW4gY29uZmlnDQo+IFNQSV9TVEFDS0VEX1BB
UkFMTEVMIGlzIGVuYWJsZWQiDQo+DQo+IEkgaGF2ZW4ndCBkZXRlcm1pbmVkIHlldCB3aGF0IHRo
ZSBidWcgaXMgZXhhY3RseS4gVGhlIGJvYXJkIGhhcyBhIHNpbmdsZSBRU1BJIGNoaXANCj4gYXR0
YWNoZWQgdG8gYSA3LXNlcmllcyBaeW5xLiBTUEwgZmFpbHMgdG8gcmVhZCBmcm9tIGl0IHNpbmNl
IHRoaXMgY29tbWl0Lg0KPg0KPg0KPiAtLQ0KPiBNaWtlIExvb2lqbWFucw0KPiBTeXN0ZW0gRXhw
ZXJ0DQo+DQo+IFRPUElDIEVtYmVkZGVkIFByb2R1Y3RzIEIuVi4NCj4gTWF0ZXJpYWFsd2VnIDQs
IDU2ODEgUkogQmVzdA0KPiBUaGUgTmV0aGVybGFuZHMNCj4NCj4gVDogKzMxICgwKSA0OTkgMzMg
NjkgNjkNCj4gRTogbWlrZS5sb29pam1hbnNAdG9waWMubmwNCj4gVzogd3d3LnRvcGljLm5sDQo+
DQo+DQoNCg==
