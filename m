Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9EA4CA0EC6
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 10:12:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3343C831C2;
	Mon, 18 Aug 2025 12:12:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Eb6fDMWe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77C0C803DF; Mon, 18 Aug 2025 12:12:11 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::617])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0B2C803DF
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 12:12:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pAYPvxmkYc+SDRSIhK9rWfOQRoWWFOcbobAwmwOfAd+LzC5vJUaYSPkrMlvWDlzrUO+uyr7QfQcKNXyBgTb2FxII+aXffG8+/Avsp3K+UJc2r5sxO13ldyk3IfqZGyhv8TmE6VokLpy0QHYzx7uo2K9zi9FCc26rPWq9mnPBbST41UsSwrDPkuP2JYBbaT3Ib4irBsh4OQe7gDA5ZEG8+1mWvCcWDBijrYo3v+ZpXqTJ1xVRh0Ep6t8OG49dqZqUCEDqWFCDjvlsS/tVmvHEa5R5arpsMvS2Ljb47AR9wVqKsa0+pgPayn3tri8TIEbavKphU4QZWqVPrsWJFXxhsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LdC4+0EKjA1GH3SKteHuT2bD8Z0Yot1/NR6+8LJo0KU=;
 b=quvJvv5Ga4Wdl8a9C7lKFGqRq3Tj1bLycjTjCgx3fsm/cb64yiBJncpNk+Q/7mU0N5VJpkrRwp7FNDJAlZTt0SZhMRezy1jQ9RugC2ZjxSV3VvvfaX5UF4fxa9eGIedcM34TBuhgEU13UBKM9MWJPGeAhRSYdrihG/rlCC2z1JiQwtPseuSTryWS4FkFTAfb9cBjfs0m1JEmU3a34ePR1GkzAdOWBtojaqxLYGoiFmdQ1ZA8AgMtKJ+MUaV0aTfRxnHVhZ8SkR5mXB6g1al2V3Vi7kElBOFG2pYlsojtzKU/8Pyq4cGmWQ/HD7qnLP30/pstFLVQbKSoUwCDYr47fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdC4+0EKjA1GH3SKteHuT2bD8Z0Yot1/NR6+8LJo0KU=;
 b=Eb6fDMWeaF4+X03FeouOjenFo8t5qwRNmu07L8ZzrUTcrDsWS74mlGwIsSZrq4Jbl7xoDiCGQQrqk9Uva1z9E46JIcABsJy0jjrLmVB51WYcLuXt6QsDUVPoZ8ap7fp1YBSVGsz+ycrQ7L4YkpAH+XpnqM6IUPSO33w05haVR5s=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by PH0PR12MB7929.namprd12.prod.outlook.com (2603:10b6:510:284::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 10:12:03 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%4]) with mapi id 15.20.9031.021; Mon, 18 Aug 2025
 10:12:03 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: Marek Vasut <marek.vasut@mailbox.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "Simek, Michal" <michal.simek@amd.com>, "fabrice.gasnier@foss.st.com"
 <fabrice.gasnier@foss.st.com>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH] usb: dwc3: Add versal2 compatibility string to dwc3 glue
 ids
Thread-Topic: [PATCH] usb: dwc3: Add versal2 compatibility string to dwc3 glue
 ids
Thread-Index: AQHcD/teSktGP8n/gkaWaU5AVhHqFLRn45wAgABNEcA=
Date: Mon, 18 Aug 2025 10:12:02 +0000
Message-ID: <SA1PR12MB8697CEAAF6A574CA5CD31F139831A@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20250818044815.4052070-1-venkatesh.abbarapu@amd.com>
 <45fc506b-2464-460b-ac72-aeecc3ed56dc@mailbox.org>
In-Reply-To: <45fc506b-2464-460b-ac72-aeecc3ed56dc@mailbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-18T10:10:27.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|PH0PR12MB7929:EE_
x-ms-office365-filtering-correlation-id: 44e4c342-d8b0-472d-b2ce-08ddde3fad65
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?T3k2NmdvSDdNRjlmL3kybTVialhGRGZ5QjR6cWIyQ2xEanJueWNMWmpBdGVD?=
 =?utf-8?B?MXhYSnVIYStmNHVodTJTazJuT0NBb2J0ZkNpTk82UGpKQzRUUi9MSkxHTlNo?=
 =?utf-8?B?c1FyUzR3MTlXZGxmUzdRM2dWS2NQSUxvbCt6bDgvLzZCV3lERUd3S2dlMkpE?=
 =?utf-8?B?enU0Q2RIeVlESHJEcWtRNktrbmhMZ1FEVmNkNGYwTGtEUmdVc09DZnh2VXZo?=
 =?utf-8?B?ZjlRQU91cW1STUo1SE5xdENmTVVjNDRoRVVrOVZaRjBsb2R5YUJuMDE5dUdB?=
 =?utf-8?B?SjBUa1NSa2FNRU5LUWVMY2VXRHdsam0wS1lpYXdjSDljMWNzTW95aWIzZ1RN?=
 =?utf-8?B?UkpuTktGbW1tZjFyTXBwalcwcjFPaFVXL1hKaC9Tc0R1QzJ2WUdOVEVYQ3Fp?=
 =?utf-8?B?K2dzWDZUSkdtNXNReGV2SkJUd1VzdmNpU1ZLUjdWZ0xFMitiQjl0Sk5PM0Qy?=
 =?utf-8?B?NUFBNHA1bnJNYS91SVloKzRSMTJ0Z01VRmVENC90ZWZ0VmxvdEZSVkVtV3lX?=
 =?utf-8?B?Y0ZBTWpUb0FDVTErc2l0UjkxM3RnTEVDYUpBU1BWTTgvN01HWnFzdFpZd1NB?=
 =?utf-8?B?WWJvYU0vS0t5OVd3bU1lVTV1UXN5LzkyQkhGOUMycVpITllycWZacFI3TjJx?=
 =?utf-8?B?R0lLNXN5bGVoc2NKeGlVWHZPcGN4a3lqbXpZZHdZVy9uWmhZMUJQaEtjTlJC?=
 =?utf-8?B?MFpJUUNWR0krUDc5RCtBVmJKVjNzcXdEWmc0d2Y2L2dhb2VCcm5SOGg3aWg1?=
 =?utf-8?B?a0VoTUZvNE5BUjF4b2szUUtXVjRpVGhOT3BLQzhzMnF5ZSs5cVdWYWtTOXhx?=
 =?utf-8?B?eUFiVDYwWStOaFh0RjZ4bk1FL1ZjWkY5Y1F0eHB4MTJlVkEwVFlkb25Bc05T?=
 =?utf-8?B?MkxwWTNHRHlnOTF2OU5TK2s5RHdSU0tWdFBBeFhWTzI3SUIyU0t1elBwQVhp?=
 =?utf-8?B?NGtQaFJsUVBtRmpSeldWd0djazh6RGJTNVZESE1wem5Lc3pHK3dFMDFxOHNC?=
 =?utf-8?B?YUg2T1hpMXp5QWN0Wm9EWkw5emtTVlpHNkpjb3RzTXFaNjZnWEpjaEN3YXNK?=
 =?utf-8?B?bzlocUdrR0lnSUpmc3N0ei9sQXpUdFpILzA4U0E0MjlEczYzNktIbW5vQllz?=
 =?utf-8?B?YTN4VFY4TXhTR2lkTjM3WitBUkRWV1Zod3hnN2hJTjFVZGdyYkZyT04zbE1Z?=
 =?utf-8?B?ZGlwNGF3VjZnTGlXR1o4RGRiQUU5cURodlJKS0FSZDZSSUN2WXFRMUFTKy9n?=
 =?utf-8?B?QUU0T01SWXRhUnBCZ1FMbGRMblM3eFQwQUpNTlJxL0VBN1pyZWl3eWYyaHJq?=
 =?utf-8?B?UUtLNGNzR1ludFNzMlR0dk5LbndtcHA1cVBIcDJZaHppU21Vdm1kV3ExN1ZO?=
 =?utf-8?B?TzFMeUdUSVBNQkhOTUk5MXkzbk1BK1VxWnFzR1ZyaGZPK0pGSE9SQnlTNzRT?=
 =?utf-8?B?VHZBQURTQVhLeE13RFRueUdxTXNuMFN6bG5ySXRiaThuZk9jQXQzMDhRdlhs?=
 =?utf-8?B?d0p5Mm80eVBxODdNcHVLbG1yZ01GUUUvYmJ1VktZZm5Oa2N5TWJ2bm1XZm1Z?=
 =?utf-8?B?YWpLemdiZGYzelM5SVVScXVwVnRNQVE3UWFDZjRIZ25KdjcwVVA5QjFuOEpX?=
 =?utf-8?B?dnNQcG1WUzBkNkwra1hFS3BvUlJKN3ZiMmFvaUc3SGpYMkNpemhkd2hlOXpj?=
 =?utf-8?B?ZWRuQ014NE5WNGpsWFkwU051djljVXFxZWpWMHI4ODlKVERpQVlvQnh3MW5P?=
 =?utf-8?B?MzBvNDZMMVJ1TGlJUU1hak5WM3FXL3JwYjZHQ0pQM3locnBFdVNmT0RNV1E3?=
 =?utf-8?B?Wkg0SVgxYzlxL283eTMzNFliOVNRMCs4Q2trTithaUkxNlQ2Ty9oWkczbHR5?=
 =?utf-8?B?Y2RMOGJwMUJzUm9RZHdaS3ZOV1BoTkJpVjNQNFV5dTJsRXZlZXB2NmxTWjFj?=
 =?utf-8?B?SGVJcGxkTVdCWThzNFgvS3k1bVpob2lueEhjUDJpSFZNZ085VmVhOHlrd3Jj?=
 =?utf-8?Q?PFi5OJeArcyNNlLZSyAs8RBA2OYd4I=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWN2cEl2RSs4eTRwdEk0TlBudGxzUFd3UHljRnRqU1RNNm1vdzlpVVQ5MTlh?=
 =?utf-8?B?aVRDSldvTXZRdlRLU2xNSHByK21kTURmQjlLYjRieGV1WnRRZlJadTJFbXBM?=
 =?utf-8?B?TnpQTXIrYXFvQ3dLbEdOUUVaY1BXWFdkOTJRMFNPNnBTY3lBREduRERENm1M?=
 =?utf-8?B?emcyS3hRZVVtWmFqZVJITmo5N2xIZGdMUHUyeEZLeUpTSTJ2eG8zbkxleHpu?=
 =?utf-8?B?My9icmt5bk1KKzFLUUdScFBvZWZySWNYdjlmdlRWcFBLS2FlTEExWElzejJl?=
 =?utf-8?B?YmRxTDV3RVRtd1VKYlR0ekIyOW5RZ3hLOEh5VjBuaU5jeU5kWmc4VG9YQnZr?=
 =?utf-8?B?Rm5hV2l1MlYyaTRrRFhIdmpSbGs1aWVlcEI4Z1dxV1paeDBXVlQybm9EYzVK?=
 =?utf-8?B?anJJTzVzb1ZBNzNsbDZEKzh1a2QyWE82UGlVQkQ2R0czS3kyNEhBQTZWV045?=
 =?utf-8?B?MFpwSU8xNE9VMzdScm9qQ3A4VndWNEtCRGdHaUJhTmRzYnh2YUJPMnhpQTI3?=
 =?utf-8?B?YmRsZTdaQy9pV2xBQkExRU0vOGl4d2ZualNxTTBXODF1T0pWSFNZelk4Z0Rp?=
 =?utf-8?B?RTBEc2p6SERRM085TWN1TE9jbUhlN3R1SXYzTGdkUmxzcmsyaFVBV2hoZ1Z4?=
 =?utf-8?B?OXpsOVp5S2x6cEZyNE95clZpdXQrdzVvaXNpUDlhOHppV085cHBBdjUrNTZX?=
 =?utf-8?B?TTJxdjRnSTNiNXZndWduRllFL0tMNnlmZjNqREZSRngzSFpad0tLbVUyZXJQ?=
 =?utf-8?B?UlAycS8rTWVZN1pCM0I4UTF3VWFYM1g0NDRxRFNsSHByZWd0Ky9sbjVaV2kv?=
 =?utf-8?B?UFo5WTdvQkJkQ2dCZ1poamVTQXAvZDAwOWJNY0ZlUDl1ZkswTGEvaWZmZDdk?=
 =?utf-8?B?amhKaml4MnNlSTkvUVJGSVhTazY3N2s1ZmtjcWZISTliVHlaRzNsYVkzTHJr?=
 =?utf-8?B?RFUyaGgzMlVDYk9DZS9oU2NyZ2RpVVhOR0hHb3BuZ3kyUzZ6N0tscG1SVUxZ?=
 =?utf-8?B?ZXdUNDFvb3NzS2FTY3BLYXhwaC8xR0tnOWw4c2tFMjQ0QWY0SWNEb2d1eXlm?=
 =?utf-8?B?OHE0RG1yOXJCVUk5ak1RWDROMGVmdVJKSDV2UUFyWllpT1djWHFhUEVMYkMx?=
 =?utf-8?B?SE5DWE40ZVVxdlVOMWIrUlBhOXdPU1FDY1RiRm5xMHc3OEc0NUlnVDZtWEI4?=
 =?utf-8?B?K1NYYVJBMlkzVUw1OGI1d2N2NU1lY000NUpXVE1sWFN5QzJJZ0psdEh3SWEv?=
 =?utf-8?B?b1lzbWNyRjZNREhwZ0VhUityclJ4U2JVY3ZOUE5NNXpMbGZnWnQydXM1Z0xD?=
 =?utf-8?B?RUNNb3BGVkErWnFWSlY5UGFYd1ZZc2RvamJKdC9vWWlhREY5Qkx6L3F5NEUv?=
 =?utf-8?B?ZFVyckdrNitRTnE0TDdsclZWS3AxWitlM2RiRUlNek5lTG95dXMwREZ1QStY?=
 =?utf-8?B?RGt2eGR3eGdRM3RCRzhzVmpta1N3MnUyTVFnZVpPc0FySDl6c2l4QjdKTS9X?=
 =?utf-8?B?d3hMb2hOT2pyeElEZXFLRytOaVlubnJVaXdiQ3FIZUNmdTRlcVhtN3pPLzFy?=
 =?utf-8?B?bXBGdy93VVYvMDVzaW9FbnlJSXVRUmdiN3d1ckduK0crWVJlUFRaUjd6cnBo?=
 =?utf-8?B?L05FS3dTN1g3aHl2bTRucmVyVXBOUkduamZVcGZKSDcwOTJUb01UTWJSL2dM?=
 =?utf-8?B?OU0wbTNlRERJSHE1MEFBZCt3YzRlSWgrSFVDc2swUzFRNElEeEh5WTI3MnFF?=
 =?utf-8?B?aEpsa1JQcU9QcTZmajM0Yk1qRDN0bTlHVzV3MUthb0xkLzR0MG1WcUd4MzNZ?=
 =?utf-8?B?Y0w3YWIxT28vUWVMMXRkZTkxSkY2eTVkM0RZeFA1MXlOY2pZUitQU2kzM216?=
 =?utf-8?B?Zk9NeFd5WlQyb01NeHRsM0hhMUlab05reDJIYzVrUm9GdTNhWnlFcDFLMnBK?=
 =?utf-8?B?WWUvUDUvaEMwWXJweTB1MmlKc3hTMWVlQ0pJclo5Mkw3eDhyWlNGUEFnVThB?=
 =?utf-8?B?cFFrR0xoVVFPUHRnTy9RbVJkWTFWYTFlY1drUkR2NjJMZ0RDc0JDK2tPWWNU?=
 =?utf-8?B?V1lHWVFMV2NwWDU0RndXeXBiaEMyUkdZWWIwbDk2UzZqZTI1VEdmUGVOeUcy?=
 =?utf-8?Q?VnbI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e4c342-d8b0-472d-b2ce-08ddde3fad65
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2025 10:12:02.9354 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5ySafbHaWRdfD2Tuz91rDJjuAORpLB5cmWwlsS+G80TPKdig9dm2YEZ/1jTAVbxbKOLleE459dDwn1FwzOv8/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7929
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
Cg0KSGkgTWFyZWssDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFy
ZWsgVmFzdXQgPG1hcmVrLnZhc3V0QG1haWxib3gub3JnPg0KPiBTZW50OiBNb25kYXksIEF1Z3Vz
dCAxOCwgMjAyNSAxMTowNSBBTQ0KPiBUbzogQWJiYXJhcHUsIFZlbmthdGVzaCA8dmVua2F0ZXNo
LmFiYmFyYXB1QGFtZC5jb20+OyB1LWJvb3RAbGlzdHMuZGVueC5kZQ0KPiBDYzogU2ltZWssIE1p
Y2hhbCA8bWljaGFsLnNpbWVrQGFtZC5jb20+OyBmYWJyaWNlLmdhc25pZXJAZm9zcy5zdC5jb207
IGdpdA0KPiAoQU1ELVhpbGlueCkgPGdpdEBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENI
XSB1c2I6IGR3YzM6IEFkZCB2ZXJzYWwyIGNvbXBhdGliaWxpdHkgc3RyaW5nIHRvIGR3YzMgZ2x1
ZSBpZHMNCj4NCj4gT24gOC8xOC8yNSA2OjQ4IEFNLCBWZW5rYXRlc2ggWWFkYXYgQWJiYXJhcHUg
d3JvdGU6DQo+ID4gQWRkIG1taSB1c2IgY29udHJvbGxlciBzdXBwb3J0IHdoaWNoIHVzZXMgZHdj
MyBhbmQgaGVuY2UgaXRzDQo+ID4gY29tcGF0aWJsZSBzdHJpbmcgbmVlZHMgdG8gYmUgYWRkZWQg
dG8gZHdjMyBnbHVlIGlkcy4NCj4gPiBVU0IzIERSRCBJUCBpcyB1c2IzLjEgZ2VuMiBjb250cm9s
bGVyIHdoaWNoIHN1cHBvcnQgZm9sbG93aW5nIHNwZWVkDQo+ID4gU1NQICgxMC1HYnBzKSwgU3Vw
ZXJTcGVlZCg1LUdicHMpLCBoaWdoLXNwZWVkKDQ4MC1NYnBzKSwNCj4gPiBmdWxsLXNwZWVkKDEy
LU1icHMpIGFuZCBsb3ctc3BlZWQoMS41LU1icHMpIG9wZXJhdGlvbiBtb2Rlcy4NCj4gPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IFZlbmthdGVzaCBZYWRhdiBBYmJhcmFwdSA8dmVua2F0ZXNoLmFiYmFy
YXB1QGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL3VzYi9kd2MzL2R3YzMtZ2VuZXJp
Yy5jIHwgMSArDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtZ2VuZXJpYy5jDQo+ID4gYi9kcml2
ZXJzL3VzYi9kd2MzL2R3YzMtZ2VuZXJpYy5jIGluZGV4IDNjZGEyYjc0YjdlLi41MzhiNmVmZTVj
Nw0KPiA+IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1nZW5lcmljLmMN
Cj4gPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtZ2VuZXJpYy5jDQo+ID4gQEAgLTY5Miw2
ICs2OTIsNyBAQCBpbnQgZHdjM19nbHVlX3JlbW92ZShzdHJ1Y3QgdWRldmljZSAqZGV2KQ0KPiA+
ICAgc3RhdGljIGNvbnN0IHN0cnVjdCB1ZGV2aWNlX2lkIGR3YzNfZ2x1ZV9pZHNbXSA9IHsNCj4g
PiAgICAgeyAuY29tcGF0aWJsZSA9ICJ4bG54LHp5bnFtcC1kd2MzIiB9LA0KPiA+ICAgICB7IC5j
b21wYXRpYmxlID0gInhsbngsdmVyc2FsLWR3YzMiIH0sDQo+ID4gKyAgIHsgLmNvbXBhdGlibGUg
PSAieGxueCx2ZXJzYWwyLW1taS1kd2MzIiB9LA0KPiBJIGRvbid0IHNlZSB0aGlzIGNvbXBhdGli
bGUgc3RyaW5nIGV2ZW4gaW4gY3VycmVudCBsaW51eC1uZXh0LCBpcyB0aGVyZSBhbiB1cHN0cmVh
bQ0KPiBMaW51eCBrZXJuZWwgcGF0Y2gsIERUIHBhdGNoLCBEVCBiaW5kaW5nIGRvY3VtZW50IHBh
dGNoID8NCg0KV2lsbCBjaGVjayBpZiB0aGUgRFQgYmluZGluZ3MgcGF0Y2ggaGFzIHNlbnQgdG8g
dXBzdHJlYW0gb3Igbm90Lg0KDQpUaGFua3MNClZlbmthdGVzaA0KPg0KPiBXaHkgZG9lcyB0aGUg
U29DIERUIG5vdCB1c2UgInhsbngsenlucW1wLWR3YzMiIGFzIGZhbGxiYWNrIGNvbXBhdGlibGUg
aW5zdGVhZA0KPiBvZiBncm93aW5nIHRoaXMgdGFibGUgPw0K
