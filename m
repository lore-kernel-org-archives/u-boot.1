Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D540C4345F
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 11:02:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 158F088B9B;
	Wed, 24 Apr 2024 13:02:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cHkw94yX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FBB888BDB; Wed, 24 Apr 2024 13:02:32 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A162887E2
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 13:02:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2TSgHdawtgeE/qHqoaANZCUE2ZhwIs+UMKgncCjSw/3rgnZfnEwiQqmUnQvPLk9HRyNVzA6mv2414snAdFI8OQURTCcwmF6XBsoRpJ8U9jqKkPWB+FxG/VNWVRHS7luAOaLzwp2N7m5ojOT9G1Vx7W+J+0PeCmYdT3+nRxhM2akGJgvk12Tmaxk1K1xcU1AduxYU421I6w0+rvhk0jUdcBAAOk5WxARU3hRS87aP0FOBRd1Z2UkcYEe09g7ZZd9USXjM3VxeXGz0NEUcOvVjzC8qhrwabXzttzrQV97Q7lCQEmWTVWr8B0WAKpVkUqZuyPQyJDL8thlB2LVCU4gLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=penFVtPqXEsxtOaoaEvnZeWMzSFvNR6yK+4QV1S/nzE=;
 b=YjA7JLIHJGj/GYtR9Ol9HxOb5LkAsTVGA41Z1LumcOSEngmem3aYQHD6pZAV8zvYXq0U7D5wFZxzwEy4FKuOoLRk1QuZDijrYOGMPxpHlLilSl/vrno5f02H55uRt7YCycxTjSHC54WTxNTWHfysjCs+972662sIDuWy/McmrWyrfNKScNX8OSgn7Cv36oOB2BddIULOjSqYBuM5hHyVSplQ/Zrywe7FEts2D29t/IR8hTIzs+JcgssRShZBxJjSWfNAS42v8umBAGJapNxwmhsIhUdP/LDHZUCkvF51dRibuJBZ57QvmRRj7Muktpj8cEsr9Yjw8bt4HHmWA6pq7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=penFVtPqXEsxtOaoaEvnZeWMzSFvNR6yK+4QV1S/nzE=;
 b=cHkw94yXmJPODr6RAne7FJexOUdJX/KCt4e3eJ1zaLsmRy9kdm3kHX4vaMB1WsoITPc0aDGuVT53sjxHE0LP2IaShtzOInFT4O6LBlJdw6GUAWmoDiel3WtnFcHxDohYxvTZKUmJAiKbWwQ7am6kxNfB4v9aaDSfVjv9++YlNlQ=
Received: from BL3PR12MB6450.namprd12.prod.outlook.com (2603:10b6:208:3b9::22)
 by SJ2PR12MB8064.namprd12.prod.outlook.com (2603:10b6:a03:4cc::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23; Wed, 24 Apr
 2024 11:02:20 +0000
Received: from BL3PR12MB6450.namprd12.prod.outlook.com
 ([fe80::e214:81fd:a03f:84fc]) by BL3PR12MB6450.namprd12.prod.outlook.com
 ([fe80::e214:81fd:a03f:84fc%6]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 11:02:19 +0000
From: "Bhumkar, Tejas Arvind" <tejas.arvind.bhumkar@amd.com>
To: Greg Malysa <greg.malysa@timesys.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>, "vigneshr@ti.com"
 <vigneshr@ti.com>, "Simek, Michal" <michal.simek@amd.com>, "Abbarapu,
 Venkatesh" <venkatesh.abbarapu@amd.com>, "git (AMD-Xilinx)" <git@amd.com>,
 Ian Roberts <ian.roberts@timesys.com>
Subject: RE: [PATCH] mtd: spi-nor: Add support to exit 4-byte mode
Thread-Topic: [PATCH] mtd: spi-nor: Add support to exit 4-byte mode
Thread-Index: AQHagSXon0c1FVYpXUSC4vc5KdAkxbFN4kGAgClrzUA=
Date: Wed, 24 Apr 2024 11:02:19 +0000
Message-ID: <BL3PR12MB645070FBBD8D35DBB251CE76D8102@BL3PR12MB6450.namprd12.prod.outlook.com>
References: <20240328153727.2939697-1-tejas.arvind.bhumkar@amd.com>
 <CAAjXUapPXFRhz0sbrMm_mrF-iaSbXa9ihv0xZ45W2AcA_3eziA@mail.gmail.com>
In-Reply-To: <CAAjXUapPXFRhz0sbrMm_mrF-iaSbXa9ihv0xZ45W2AcA_3eziA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=64f29e9c-6eee-4b37-975d-8e2b47db562c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-24T09:17:06Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6450:EE_|SJ2PR12MB8064:EE_
x-ms-office365-filtering-correlation-id: 71aba6c7-226a-47bb-8c4b-08dc644e02cd
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?Q1kvdEVJKytkbEFmVGtrNk5VMWR6TFpKcFh1V2pTUjFaNWRacHl1Q1A1VGZM?=
 =?utf-8?B?dDY4eHV0OE9YK3lzY1BpdGhIdTBsZVZvN3F4MnVVNXMyWVFETmhXZDF1UFdP?=
 =?utf-8?B?d2FXMi9GTWo5MDk1bkh6bHJ2Uzh0OEZRSTBoakYzUzNBSHNsM04zejRZOHNz?=
 =?utf-8?B?VnpuSWE4NFh5QWFId2xxNTdST3FqMUo2clZnWmxvR1FtcXhOVVdjajRvamg3?=
 =?utf-8?B?dCtmVVFrVWdaeVhva05oTmZpSGtaK0pZbUpsakdxVjFYc3J2MEtkNmJUS3lL?=
 =?utf-8?B?VGJPMFVVNlZLMEZUWHgzKzZXS1ZkTGVweTJWcXU5UENYdnJDQzMvampFa2xY?=
 =?utf-8?B?SHRydTdndDJKQ3BEN2l0QUtObVk0d0pOdVg0YkszcW1yNGVZdkN6L2oxWGJy?=
 =?utf-8?B?MFpNR0N5bStHWHRPMFNFTWxiNWxjUlNwcjdyQy9CakEyd3hYN25ZQ2gzV0FX?=
 =?utf-8?B?YlF4b3pvMEczZ1MwbzJZeElubDI3ZG5VbkpwbnJkY2cvTUV1ZlhlU2JvL241?=
 =?utf-8?B?aHJJUGNpSVZGZG9VRm9qNUtGQUZIeWtTUEdIaENRSmpJSkRvRGJuQjBoN0xk?=
 =?utf-8?B?U0pTZ2RVSUxsMjZhdVI3QkJYdXJPQXRsU0hkaWRaZ0N0cTZLKzlWODJRTTIz?=
 =?utf-8?B?bC8vbWN4ejRXOStRUmJFZEppRW4xVFpBb0JuaytrYUJha2tRUXd5cVVxRjIr?=
 =?utf-8?B?OVNqcE1EUFgxSzNsQXNlaG9EaEJ6c1FsOER4ejlLd2l4aXVzK0kyZ2JpWDNo?=
 =?utf-8?B?M05OeER3QW16MXZuWHA0NTNoQ0VrdVFqK3ZWVlc4djNuSXhXSTlQRjY4Ulo0?=
 =?utf-8?B?bjlhZGN2QnZlN3E4d28rUkFHYnowNHZRcmVNbUhucmQ5U3JmcUZHWk9lMVBh?=
 =?utf-8?B?anBvaFh6bVo4N3B4U25iUW9majVDeHYzZmp5NHplTWJqMThrelYvQUJucTUx?=
 =?utf-8?B?QUtDbVRINVQ2eEZnTjdxMzN1OXA1NUtWY1J3dGNIejRXMWVHVHNNV3lGaTc2?=
 =?utf-8?B?RHJsVGVJQTlZWHhWOG1wVnl3UURUc1IxZGtoWUpQYmF6allqRVhNVnJkWW1K?=
 =?utf-8?B?U25iUjVMRXplSnMzVzZkSHh0bWZmWFZUVGd6blQvTnBURlZBb2tjMUxlWXpD?=
 =?utf-8?B?M3Q2bDNSZE44UWxFNHE4bTV3djFxMXZnSlR3Q3h6dCtHckordXpvWVRWTmtM?=
 =?utf-8?B?dEJoL2lrOXJWemsrc3NUa00yK0lFNlFsM1JUOEFrd3JpNmVMa051QWZ2M3h3?=
 =?utf-8?B?ZjJ2eFFSTVp6NCsxZWM0bEdDa3duVXBIQlJUeUZwZVpNeUd6c2Z4cTRJc1NO?=
 =?utf-8?B?aVNBeDZIOUQ0R3gzdEFDU0lxR0FCYURzL05kWDZKY0EwaVBsUmZZV2tUOS9F?=
 =?utf-8?B?YTJFT3ExeHMycnhmZTltcndUb3lKaW5lNUQ1bTlUMGo2Slc5Mi9ueXYvVVpp?=
 =?utf-8?B?eU9uRUhpMnZWLzBFME5OMTFaSDVlbDE0VVZlRXBscFJpVjBmZXlNaDlNQU1i?=
 =?utf-8?B?NkxmYTMvOHJVVER5Tkx3eDFZVHNwcFRlZXMva2NmN3k4VlNSdXV5SDU5Snc0?=
 =?utf-8?B?UzFSSWRmVytHTnJrSGFDdXRkM0JnS2x5dmE1UFhuZHU0ZTc0V1RSSVQvRTIx?=
 =?utf-8?B?aXh1WmovVjREcVlSUVZLK2tuOFVTWTdsWUhrczBiM0VBaUVKU3E2RzFDb3I0?=
 =?utf-8?B?NHNGQ1pORHlUVlhvdCtRQzIzVVFiKzFJcG5ZNEMrMkJybVUrTVlrK0dVa29y?=
 =?utf-8?B?MDRSUG1MY3ordlZKTDQwMWVSZ0FwYWR2azJRWWF0Z3VOaDZSZzFoQXJ4Q21C?=
 =?utf-8?B?TkZURlUxME43SG5VOG1Cdz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6450.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkdsTXBxQlE1MCtwMHlYczRWb0ZQanJWWnF2bUZLVlA2cDZpVTNFT3NWMG5Q?=
 =?utf-8?B?cG1SSjdZb1JqM3hiLzVnOU5PajNqRXIvV2tLTnJQbUVDdmE0a1JaM1B0ZEl1?=
 =?utf-8?B?UjJNS0p4NEJNZ1kvcU5hNks0VGVKR0N0SVhkSXdKdVJOelZxWEd5Q0poZlkw?=
 =?utf-8?B?NjFBMHVnQWFTaFdCLzR4WTBJOXdoUUlmdXhzR2QzT0lEa3V5b0xRbk9icWFC?=
 =?utf-8?B?STNDSk12QVJBMHhBZmVBc2l4MU1sNXd3cmZ3NERaSmhZK1JJSDl3ajhUdjFz?=
 =?utf-8?B?a2xFczlSUFFZSkptUW5NVmR3Ty9wRFRKSHRtZnpRQTdWVlpIWk5vNHpMMVhE?=
 =?utf-8?B?dWdabGdBdEpsQk5mb3ovWm9RR3IwemNiZEwreXIya2dicW9XTjRxQThENXVt?=
 =?utf-8?B?WmMxYVI5ZlV2S2JKSVhmZXR0YVhqY2NoMEhzNlBZT1NjSGFIczBCdWwwQ3lm?=
 =?utf-8?B?RDJ4OWpuUkNhQ1hOUFhpV0xZYkZmN3ZiVnpaWGhHcWNCazZEWnJ1Q1RiNjZm?=
 =?utf-8?B?YW5USjd2WTQ4QXJqSlk5OVBTVElCKzEzb3NHRTN3THNxOWJwYXFxa1NwRlJH?=
 =?utf-8?B?ZmFqbUhXMk5hakRVdGhjcDZJQ2s1VW1xc29pQ2t5aktTbEhiOU9SMXFiVmRV?=
 =?utf-8?B?dHBWZHBIM045cXowNktPL21IZnErQ0hpelh2RWJ3eS9id3lCZm1zdTllWFVS?=
 =?utf-8?B?TTh1WCtEZFRUTzdNemsvNy9UYkdldjRQMk50QzBsemNlL3BHUXNLRGhRWHV6?=
 =?utf-8?B?V1VjRWY2eUxLb1hGVXpxZUUvbVhpS3BYWWxYS2diVTJZSURVdDNSYXYzY1ZV?=
 =?utf-8?B?N2IvQ3BRVGV5NDFBR0YwVVpGSVdNWUVOellHamNMQUlGd0phR1o2cWFPVnRZ?=
 =?utf-8?B?dmF3V3o5STZuczh6b0lnRktMNER5R3U3TDB6UXNzYUtrdnM0dkwyN0xLNHc2?=
 =?utf-8?B?dVIwcGZvZmV6ejJwQnZGVlM3L3BWc0hwMEgyNmFoMGl0NXlZdU5WZUUzZ2pv?=
 =?utf-8?B?ckpseCtCcHgveGNKOWJMVEJqWEZDQzgweVp0UWZIWnlrR3AxZ3pFc3dVSWdV?=
 =?utf-8?B?RTZrS003MzB4dzFMUlFkNlNOdDg1UEczSWdkRmJsY2MwUGRXdU9sbHdWclps?=
 =?utf-8?B?MkhXMzNLc3NXYjQ0eFphKzBtQWtCbmVrOXNFdldJT0FmODBSNlBEMEVtR0lC?=
 =?utf-8?B?Zm14Zk8vaFlaTGxER0VUM3dXNlFTSHh2d3B3U0ExaHlWNkJGbWRNVmE4RGh0?=
 =?utf-8?B?OGJ4UXJ1RXZOd1V0VVdXVURBMVJDWlpQbEJ3ekh2Tll4Z3M1ekNxYmtCR1FZ?=
 =?utf-8?B?NUlYS0IzeThhcEw5cWZmWnZEWFp1YW50dVFOYnJIMGZITGhLd1h5aVlQZjNq?=
 =?utf-8?B?UUdraFRaMWVPNTlBRUdKU0oyaEMvN0VRZms5Si9hR1VDTWFmQnFlVktnWHVo?=
 =?utf-8?B?S0ZyZ2hpNzVITmJzeEl1Umd5KysrM3FBTVhVcGUyVXJiUkxrVTFiV1hGWU1Y?=
 =?utf-8?B?WmZTcE9vSzJjMExIOFEwSmhyZCtGa1BhYlg1N1p4dUR1NmdQK3c1dGQ4cDlT?=
 =?utf-8?B?TmJBZ2NxcUNWMkhzM0VycTFlWjh3Vys4aUU2V0RsL3JXVmFxUWU2bExYQUMx?=
 =?utf-8?B?L21zVVpOVVMvaUFaanJOV3dBRUl2bzhwVXltN0d5NDZobTM1aklsaHdOaXEr?=
 =?utf-8?B?bENkb3dRMmYzTlJVOHFQb0wyK0p2end2RHB2eFh6c0dxN1hYYjYwc3FlQWVs?=
 =?utf-8?B?a056MDhPRlR2MEQyL3JYOG5HM01vV1p5R2pLYkhtK3YxM3hqczdsMnBpd3Ji?=
 =?utf-8?B?T2V2ZlFvZHVCYjViaytZd2NMYTBaVTY4WXQxOXpBeldEUThsRWVqdHZNZjcy?=
 =?utf-8?B?aUN3b05NSmxCWExqT0hFWE1pRFA0MGppSHBxWXUzeTZvaTVCMmlETGcxS2dq?=
 =?utf-8?B?eWVWV0hXdlhack8vd3VFV1kwdVRDVjlpdHJMakZ0ZG81NVdRMldScmtxYjg3?=
 =?utf-8?B?K1k5ZG9LcTBMaGZIbm5iUlVreDNZUzhOWTNnNzBiVk0rTlNjdW95eWRsOFJZ?=
 =?utf-8?B?c3NHcEJ0UWFsTGUrRHpibUFLOWt3czlVaTRaaFBMRUZqcUNIb0N5TFFUcE5q?=
 =?utf-8?Q?UmRE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6450.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71aba6c7-226a-47bb-8c4b-08dc644e02cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 11:02:19.6836 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lvSg+UvRD9YqTNHA3tigRusHBG2MKVSCI5ZX7CmtPBULlCtfwCFW55EKUMoaG8tYgV2bVHDTMGFv+4q3qdUEeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8064
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIEdyZWcsDQoNCj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3JlZyBNYWx5c2EgPGdyZWcubWFseXNhQHRp
bWVzeXMuY29tPg0KPiBTZW50OiBGcmlkYXksIE1hcmNoIDI5LCAyMDI0IDY6MTUgQU0NCj4gVG86
IEJodW1rYXIsIFRlamFzIEFydmluZCA8dGVqYXMuYXJ2aW5kLmJodW1rYXJAYW1kLmNvbT4NCj4g
Q2M6IHUtYm9vdEBsaXN0cy5kZW54LmRlOyBqYWdhbkBhbWFydWxhc29sdXRpb25zLmNvbTsgdmln
bmVzaHJAdGkuY29tOw0KPiBTaW1laywgTWljaGFsIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47IEFi
YmFyYXB1LCBWZW5rYXRlc2gNCj4gPHZlbmthdGVzaC5hYmJhcmFwdUBhbWQuY29tPjsgZ2l0IChB
TUQtWGlsaW54KSA8Z2l0QGFtZC5jb20+OyBJYW4gUm9iZXJ0cw0KPiA8aWFuLnJvYmVydHNAdGlt
ZXN5cy5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIG10ZDogc3BpLW5vcjogQWRkIHN1cHBv
cnQgdG8gZXhpdCA0LWJ5dGUgbW9kZQ0KPg0KPiBDYXV0aW9uOiBUaGlzIG1lc3NhZ2Ugb3JpZ2lu
YXRlZCBmcm9tIGFuIEV4dGVybmFsIFNvdXJjZS4gVXNlIHByb3BlciBjYXV0aW9uDQo+IHdoZW4g
b3BlbmluZyBhdHRhY2htZW50cywgY2xpY2tpbmcgbGlua3MsIG9yIHJlc3BvbmRpbmcuDQo+DQo+
DQo+IEhpIFRlamFzLA0KPg0KPiArIElhbiBSb2JlcnRzLCBteSBjb3dvcmtlciBoYXMgdGhlIGZv
bGxvd2luZyBjb21tZW50czoNCj4NCj4gSSBkbyBub3QgdGhpbmsgaXQgaXMgYXBwcm9wcmlhdGUg
dG8gcHV0IHdoYXQgYXBwZWFycyB0byBiZSB1c2UtY2FzZSBzcGVjaWZpYyBsb2dpYw0KPiBpbnRv
IHRoZSBjb3JlIGZ1bmN0aW9uYWxpdHkuDQo+DQo+IFlvdXIgcHJvYmxlbSBzdGF0ZW1lbnQgc291
bmRzIGxpa2UgdGhlIGNoaXAgaXMgc3R1Y2sgaW4gYSBzdGF0ZWZ1bCBtb2RlIGFmdGVyIGENCj4g
cmVzZXQuIEFzIGFsdGVybmF0aXZlcywgSSB3b3VsZCBzdWdnZXN0Og0KPiAxKSBUb2dnbGUgdGhl
IGhhcmR3YXJlIHJlc2V0IGxpbmUgZm9yIHRoZSBjaGlwLg0KDQpbVGVqYXMgXSA6IEFwb2xvZ2ll
cyBmb3IgdGhlIGRlbGF5ZWQgcmVzcG9uc2UuDQogICAgICAgICBUaGVyZSBhcmUgbm8gSFcgcmVz
ZXQgbGluZXMuDQoNCj4gMikgSWYgb25lIGRvZXMgbm90IGV4aXN0LCB1c2UgU1BJX0ZMQVNIX1NP
RlRfUkVTRVRfT05fQk9PVA0KDQpbVGVqYXNdIDogRm9yIEtyaWEgYm9hcmRzLCB3ZSB1c2UgUVNQ
SSBmbGFzaCBhbmQgaW4gTk9SIGZyYW1ld29yaywgdGhlIHNvZnQgcmVzZXQgaW52b2x2ZXMgYW4g
OF84XzggcHJvdG9jb2wgaW4gbWVtLW9wcy4NCg0KPiAzKSBBbHRlciB5b3VyIHJlY292ZXJ5IGFw
cGxpY2F0aW9uIHNldCB0aGUgY2hpcCBiYWNrIHRvIDNCIG1vZGUgb24gZXhpdC4NCg0KW1RlamFz
XSA6DQpUaGlzIHdvdWxkIGJlIGdvb2QsIGJ1dCBhcyBwZXIgZGF0YXNoZWV0IDoNClRhYmxlIDM1
OiBFTlRFUiBhbmQgRVhJVCA0LUJZVEUgQUREUkVTUyBNT0RFIE9wZXJhdGlvbnMNClRoZSBlZmZl
Y3Qgb2YgdGhlIGNvbW1hbmQgaXMgaW1tZWRpYXRlLiBUaGUgZGVmYXVsdCBhZGRyZXNzIG1vZGUg
aXMgdGhyZWUgYnl0ZXMsDQphbmQgdGhlIGRldmljZSByZXR1cm5zIHRvIHRoZSBkZWZhdWx0IHVw
b24gZXhpdGluZyB0aGUgNC1ieXRlIGFkZHJlc3MgbW9kZS4NClNpbmNlIHdlJ3JlIGluIHRoZSBk
ZWZhdWx0IDNCIG1vZGUsIHdlIG5lZWQgdG8gdHJhbnNpdGlvbiBvdXQgb2YgdGhlIDRCIG1vZGUu
DQoNCj4NCj4gQXMgaXMsIEkgYWxzbyB0aGluayB0aGlzIHdvdWxkIGNhdXNlIHByb2JsZW1zIGZv
ciBjaGlwcyB3aXRoIGV4aXN0aW5nIHN1cHBvcnQuDQo+IHNldF80Ynl0ZSgpIHNlbmRzIGNvbW1h
bmRzIHRvIHRoZSBjaGlwLCB3aGljaCBtYXkgYmUgdW5yZWNvZ25pemVkIG9yIG92ZXJsYXANCj4g
d2l0aCBhIG1hbnVmYWN0dXJlcidzIGN1c3RvbSBjb21tYW5kIGFuZCBjYXVzZSB1bmludGVuZGVk
IHNpZGUgZWZmZWN0cy4NCg0KW1RlamFzXSA6IElmIHdlIGV4YW1pbmUgdGhlICJzZXRfNGJ5dGUi
IGZ1bmN0aW9uLCB3ZSdsbCBmaW5kIHRoYXQgaXQgb2ZmZXJzIG5lYXJseSB1bml2ZXJzYWwgc3Vw
cG9ydCBhY3Jvc3MgYWxsIGNoaXBzIGZvciBlbmFibGluZyBvciBkaXNhYmxpbmcgNEIgbW9kZS4g
Q291bGQgeW91IHByb3ZpZGUgbW9yZSBkZXRhaWxzIGFib3V0IHlvdXIgY3VzdG9tIGNvbW1hbmQg
cG9pbnQ/IEknZCBsaWtlIHRvIHVuZGVyc3RhbmQgaXQgYmV0dGVyLg0KDQo+DQo+IE9uIFRodSwg
TWFyIDI4LCAyMDI0IGF0IDExOjM34oCvQU0gVGVqYXMgQmh1bWthcg0KPiA8dGVqYXMuYXJ2aW5k
LmJodW1rYXJAYW1kLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBUaGUgS3JpYSBib2FyZCBmZWF0dXJl
cyBhIHJlY292ZXJ5IGFwcGxpY2F0aW9uIHRoYXQgYWN0aXZhdGVzIHdoZW4gdGhlDQo+ID4gRldf
RU4gYnV0dG9uIGlzIHByZXNzZWQuDQo+ID4gVXBvbiBwb3dlci11cCBmbGFzaCBvcGVyYXRlcyBp
biAzQiBtb2RlLCBIb3dldmVyLCB0aGUgcmVjb3ZlcnkNCj4gPiBhcHBsaWNhdGlvbiBjaGFuZ2Vz
IGl0IGJhY2sgdG8gNEIgbW9kZS4NCj4gPiBGb2xsb3dpbmcgYSByZXNldCwgdS1ib290IGFjdGl2
YXRlcyB0aGUgQ09ORklHX1NQSV9GTEFTSF9CQVIgYW5kDQo+ID4gZXhwZWN0cyB0aGUgZmxhc2gg
dG8gYmUgaW4gM0IgbW9kZS4gSG93ZXZlciwgdGhlcmUncyBubyBjb2RlIHRvIGhhbmRsZQ0KPiA+
IHRoaXMgY29uZmlndXJhdGlvbi4gdG8gYWRkcmVzcyB0aGlzIGlzc3VlLCBjaGFuZ2VzIHdlcmUg
bWFkZSB0bw0KPiA+IGRpc2FibGUgdGhlIDRCIG1vZGUgd2hlbiB0aGUgQ09ORklHX1NQSV9GTEFT
SF9CQVIgaXMgZW5hYmxlZC4NCj4gPg0KPiA+IEFkZGl0aW9uYWxseSwgc3BpX25vcl93YWl0X3Rp
bGxfcmVhZHkoKSB3YXMgaW5jbHVkZWQgYmVjYXVzZSB0aGVyZSBpcw0KPiA+IG9wZXJhdGlvbiB0
aGF0IHBsYWNlcyB0aGUgZGV2aWNlIGluIGEgYnVzeSBzdGF0ZSBiZWZvcmUgcGVyZm9ybWluZyBh
DQo+ID4gbm9yIHJlYWQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBUZWphcyBCaHVta2FyIDx0
ZWphcy5hcnZpbmQuYmh1bWthckBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL210ZC9z
cGkvc3BpLW5vci1jb3JlLmMgfCA0ICsrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0
aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS9zcGktbm9yLWNv
cmUuYw0KPiA+IGIvZHJpdmVycy9tdGQvc3BpL3NwaS1ub3ItY29yZS5jIGluZGV4IGY4NjAwM2Nh
OGMuLjQ3ZjY1YTRmNWUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tdGQvc3BpL3NwaS1ub3It
Y29yZS5jDQo+ID4gKysrIGIvZHJpdmVycy9tdGQvc3BpL3NwaS1ub3ItY29yZS5jDQo+ID4gQEAg
LTE0NjQsNiArMTQ2NCw5IEBAIHN0YXRpYyBpbnQgc3BpX25vcl9yZWFkKHN0cnVjdCBtdGRfaW5m
byAqbXRkLCBsb2ZmX3QNCj4gZnJvbSwgc2l6ZV90IGxlbiwNCj4gPiAgICAgICAgICAgICAgICAg
ZWxzZQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHJlYWRfbGVuID0gcmVtYWluX2xlbjsg
ICNlbmRpZg0KPiA+ICsgICAgICAgICAgICAgICByZXQgPSBzcGlfbm9yX3dhaXRfdGlsbF9yZWFk
eShub3IpOw0KPiA+ICsgICAgICAgICAgICAgICBpZiAocmV0KQ0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgIGdvdG8gcmVhZF9lcnI7DQo+DQo+IENhbiB5b3UgZWxhYm9yYXRlIG9uIHRoZSBw
dXJwb3NlIG9mIHRoaXMgd2FpdF90aWxsX3JlYWR5Pw0KDQpbVGVqYXNdIDogVGhpcyBzdGVwIHNl
cnZlcyB0byBlbnN1cmUgdGhhdCB0aGUgZmxhc2ggaXMgcmVhZHkgYmVmb3JlIHByb2NlZWRpbmcg
d2l0aCB0aGUgcmVhZCBvcGVyYXRpb24uDQoNClRoYW5rIFlvdSwNClRlamFzLg0KPg0KPiA+DQo+
ID4gICAgICAgICAgICAgICAgIHJldCA9IG5vci0+cmVhZChub3IsIGFkZHIsIHJlYWRfbGVuLCBi
dWYpOw0KPiA+ICAgICAgICAgICAgICAgICBpZiAocmV0ID09IDApIHsNCj4gPiBAQCAtNDE2MSw2
ICs0MTY0LDcgQEAgaW50IHNwaV9ub3Jfc2NhbihzdHJ1Y3Qgc3BpX25vciAqbm9yKSAgI2Vsc2UN
Cj4gPiAgICAgICAgIC8qIENvbmZpZ3VyZSB0aGUgQkFSIC0gZGlzY292ZXIgYmFuayBjbWRzIGFu
ZCByZWFkIGN1cnJlbnQgYmFuayAqLw0KPiA+ICAgICAgICAgbm9yLT5hZGRyX3dpZHRoID0gMzsN
Cj4gPiArICAgICAgIHNldF80Ynl0ZShub3IsIGluZm8sIDApOw0KPiA+ICAgICAgICAgcmV0ID0g
cmVhZF9iYXIobm9yLCBpbmZvKTsNCj4gPiAgICAgICAgIGlmIChyZXQgPCAwKQ0KPiA+ICAgICAg
ICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+IC0tDQo+ID4gMi4zNy42DQo+ID4NCj4NCj4gVGhh
bmtzLA0KPiBHcmVnDQo+DQo+IC0tDQo+IEdyZWcgTWFseXNhDQo+IFRpbWVzeXMgQ29ycG9yYXRp
b24NCg==
