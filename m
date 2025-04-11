Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 887FAC36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 03:56:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9030A83D71;
	Fri, 11 Apr 2025 05:56:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vhw68IQ5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4266583D92; Fri, 11 Apr 2025 05:56:52 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::616])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3972083A3A
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 05:56:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bg3YnGMcpzNv5ddE7MlDappKaifGFXPxk+u4ijhIIw3gtoJk7NFtoaeQgBanNKiO+yxq7kWMWgsEV8b+56XdvnqEiZzhZwivN5cA3zdzaediwzwff8doHgioHpRK9qivx9vuqdrHsrgdjKgwryOqwfoFORKLdCsbpG1Bo843csJyu9S9Ou4CCDZ1sv1JJjB+q8l9kWaKllsb4X4rqEoFdf3oIw3EymM9I9wqCnzn5PGNqBjeyi7UzRHSvp/xEdmzYpYbbosSQomc3DUZ+QiYkfFImYXgIuNFndYjGoalXcaiTKSHm9DJiq/1YyFzRZE3q1u4J6AxI/ijZRa1l/udDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UpbHsIybGlGnHxatRednX4rNwORT9MoYSRhP0Nui3sE=;
 b=X2nm5x7ipT0PnEly8GkGTvFknmT5MTMfCKPSdTXWsyDX02NZZmoscOkCtPfkpqI3HyKkk/8c3i3dk2V67gmV03LOZACVzoHIQa8C+nrQEiXePkJYG3ZrYnqApJwHyPI4D2xRfCXkbJF2rFN7xVKggU8gGJ8WEwOajSsUk6ER6B3Lk1AEiijMRisOmyW7Beag+qriNY5BbLaLN5saXzUovqgF/YHMF80A4oa9iJiY/WP/G3rVv4jRnzhgUthWp33c45QeiyCOUTuBKegP7Azo16U8y1HaYujesWLjmXuW4V2BnkKz45h3HNUE0mYa/FcLN74ajQExcMzTokpPAIjfFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpbHsIybGlGnHxatRednX4rNwORT9MoYSRhP0Nui3sE=;
 b=vhw68IQ5dsfnCG0sesgEeZZzC5EKugaz8JPo7pIiud1oQgtM0jIFsWLEp1JWN3Dx0mPNGSxrRc1ibuqmv+uQBGRWLuPDGcEQQBBn26BWI+4isHUcxYud/jYsyWbtSZB9fMnVVpejl0yIoh2OfRHplRZYBAkH6KQHFUBz2SQ1OdA=
Received: from CH0PR12MB5266.namprd12.prod.outlook.com (2603:10b6:610:d1::10)
 by DM4PR12MB7671.namprd12.prod.outlook.com (2603:10b6:8:104::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Fri, 11 Apr
 2025 03:56:44 +0000
Received: from CH0PR12MB5266.namprd12.prod.outlook.com
 ([fe80::2539:1bab:b456:33c8]) by CH0PR12MB5266.namprd12.prod.outlook.com
 ([fe80::2539:1bab:b456:33c8%6]) with mapi id 15.20.8632.024; Fri, 11 Apr 2025
 03:56:43 +0000
From: "Begari, Padmarao" <Padmarao.Begari@amd.com>
To: =?utf-8?B?VmluY2VudCBTdGVobMOp?= <vincent.stehle@arm.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Jassi Brar <jaswinder.singh@linaro.org>, Marek Vasut <marex@denx.de>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, "Simek, Michal"
 <michal.simek@amd.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Tom Rini
 <trini@konsulko.com>
Subject: RE: [PATCH 3/5] arm64: versal: fix dfu alt buffer clearing
Thread-Topic: [PATCH 3/5] arm64: versal: fix dfu alt buffer clearing
Thread-Index: AQHbp99jb+9qxNwMA0Kt9ndkQIMEN7Od23VA
Date: Fri, 11 Apr 2025 03:56:43 +0000
Message-ID: <CH0PR12MB5266E7DB0278F5B219797636ECB62@CH0PR12MB5266.namprd12.prod.outlook.com>
References: <20250407170529.893307-1-vincent.stehle@arm.com>
 <20250407170529.893307-4-vincent.stehle@arm.com>
In-Reply-To: <20250407170529.893307-4-vincent.stehle@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=2076aef9-9479-4480-92c4-8757faeb1104;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-11T03:55:45Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5266:EE_|DM4PR12MB7671:EE_
x-ms-office365-filtering-correlation-id: a7332f6d-148c-4db1-6b67-08dd78acdf77
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZHZCbThLNTI4aVZzekV1bDFSbDlNZ3Fva0llNDNyV09mRVJTNHNuS2t0Z2w4?=
 =?utf-8?B?b2VPSkNyUjhiYzE3cTVzSnhqQmJyTDhKNi9YWU8wUVBUMnZwamozYks3Y2VW?=
 =?utf-8?B?aVhCUWRlY3hlQnZIWUF5V3djVHVnbU5sc1gyQzkwMjBXWTNDUnpUbXNGYlFB?=
 =?utf-8?B?SnhKT1ppWEFxY0kzUStZUGwraTRiVnY3OHdZL2dISHNGNlloRlk2UGNGdzNR?=
 =?utf-8?B?ZGd3THBoNmpvQkR3UDBXVFo2OEV3UXNlUVVZd0FGQzBPamVobDZVWlhaRmZJ?=
 =?utf-8?B?ZjUvUEV4TjdUYTVmYlZRUUV0cFVpM3lHQk5MdnZKck13bFBnYlM2dUZXc0lP?=
 =?utf-8?B?MTlCZEdtb2N0SXNQaytVRDBBMGJna0I2cHkyK3RSdWpZVmtKUXZ5dUNoeWVS?=
 =?utf-8?B?NENxZ1dkYkRXclR5ZCtSb3hzQ2ViUllKWEtTbzhBZGYrN2Via2J1SGY5bTZ1?=
 =?utf-8?B?WTlOeTNDY0lKYlVDTUpWckhFMXFtaWRsaWdWbGJ1Q24wK1kyUE1GOTRKUnA2?=
 =?utf-8?B?dkpMYVFKM2xxRTNXSU5DMUZlVFNvTFljTFhwRVVBb3RKUU5UeHB2MHhkTUEw?=
 =?utf-8?B?YW1wWXRWMDZjZzUzMUEwMGd1ZEl2c3ZsWnhQd2tIR0JsdXJ4NFJiZTZSVEhx?=
 =?utf-8?B?Vnl6N05rMHNDVW1TbHBJdTY5alpFSzJxeG14Ulh2bm5TcnNBMHdUY3E5VWRp?=
 =?utf-8?B?dDBHM25MYjErOVYyU21KaXhETFEwVGlJcEQzcjQrdVFuaEhkUFN0ZzlhcUN1?=
 =?utf-8?B?WEREbEJ2Q3dSNzNFeUdGd0ViZWxMaldSNjNsZ3I3QVROQ1RwUDdMVFFQR2pp?=
 =?utf-8?B?aWxkQVZwTy9hSHgzY1lYVmFGRTRQTVBkQkxBNmROWGg3MDNrMnZhSmxkM2l0?=
 =?utf-8?B?WmVyZFRMYXNuSmM1R1BQMmFNeVRCRmhVbHRZS25hSlVNcXlBaHdBaWwwRkt2?=
 =?utf-8?B?UGdJYjV0dmFxZHlZZUpnNVM5bHBXc1dXOUg0Y1ZlS2t2eFF2aGcxRGtyT2pq?=
 =?utf-8?B?UWZDVVZXWHQ3VnhzbE9LenlIV3RSY1BEM3laMThTblVITjRrS2htSVlFZXBr?=
 =?utf-8?B?cGR6Z0FwR2dEck5HUUNsakFKUVBGbDhZMmlLbkg4bmN3TWhEWk1KQ0xic3Ja?=
 =?utf-8?B?MkZ3dFJqQXNqYVlBVDY4QnVORE5lOXllQ3JZZlYybEY5QTI4YndEZzlNdnZs?=
 =?utf-8?B?NnRLbWlsb3VBY1ZpTUZodUU4dlo0eW9abHZ3NHMrcUVKbzZ6NWNoQkFieisr?=
 =?utf-8?B?SXArckYvRmt0bkUzTFR6Nllrd2lMVm5VaXZQc0hvZkxlaG9EbDN4bzBMdzFi?=
 =?utf-8?B?Sk10NnBrVVBZZjJoNExWWFdiLzg3QWxQOFVhLzY5Q1kvU2VvSUY4c0lpKzJp?=
 =?utf-8?B?Y1IwVm90N2dtY3M3YmRRMFhTcWozM3RoK3liemhURkJIb0xndnprb2Y0bWw5?=
 =?utf-8?B?VHRRU1Jab0cvWmMvb2drUWxLb3EwZ29YMEhrOWJuSmR1SjdwYU5Mb1EvRjhX?=
 =?utf-8?B?VjdKUm42TTM4ZHdadldYZkFGWlZXY0VJY0VpZTVNbDFrVHlHZXRURnhMWHdr?=
 =?utf-8?B?bzRLd0Jud1ZoeVljeDNEbnZ5SlhwaG5SSkpRMnMwRzc1S3c0N0VzVlZ2dHl2?=
 =?utf-8?B?aVIvZlZTb3U1TmQzWExUMVlFUFZ6WW1pTzFEY1RDWHZBc2Y0Y2UzNjh1VEQ2?=
 =?utf-8?B?SmlUbHhUWnVld0EvYmVsdDVjY3QxLzFCZzNWT1RuTExIZkxidnBoTU0vSXRJ?=
 =?utf-8?B?SE5vTlZaeGdpeW5rUkxZUy9hUjdvMm9XVzA0RW9ON3pGM2hZdVJFYWNFWFVy?=
 =?utf-8?B?VVc4R0tOWDhrMjM3UmRncmtKY3p5MG1yRWgzQVBpUTk1eENzcGZhc1dPeTZC?=
 =?utf-8?B?ekJ6Z0I3YlBkUE5EcWxIUERqeGRRcHlFMzRyQWtHaGFBbm9zdzFiNXlIN1JO?=
 =?utf-8?B?aU83akEzMVZuMGdSR3BOTTNvbG12Qzg2THd1QTZ0WnFpSmxoMG5Kakd4SzVz?=
 =?utf-8?B?N0IxMDhubGhRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5266.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RC9heGNpb1FLV1RodUNPSkZrNHhPV0phdFNXVHdYUmNIT3o5VzY4OEQxbVU1?=
 =?utf-8?B?UlliNDNXcmxJeXIrRjM5UFpibEJaWFJFUlFjellHNFBXZnRBc3lCTzBBdzZj?=
 =?utf-8?B?S0dmV25XNGt3elVYSEc0ZnVub0RGUmlxNWtTaEQwRlU5ZFNYazRVSENwdGh2?=
 =?utf-8?B?aHNlRTNGVXFPVnVXQVhXa0cvK09WR1FVUGZPaTJHQzR4L2puejJXZEQwelQ3?=
 =?utf-8?B?cDlRb01qeFNqeHk0dnFyQzNId1F1ams2Tm52V0lETlA1MXhHYmJLbkJoRk5M?=
 =?utf-8?B?aVA2VWN5eDVUMXc1R1FzTTZZOEtNZ1p4YVM2aEx1aDJyKzBGTzA0bkUxblNx?=
 =?utf-8?B?d1hLSUR0SmFwc3VVdDRMeTRCM2svS2FVcS9Gb3NhbStWS1lTWXlkbUE2UG5y?=
 =?utf-8?B?YWREbk84QUhVZWp5ZEMzdVdNZEVkNlh5YzBRNExubVZrK1pycGQvOGtZWHRn?=
 =?utf-8?B?NDNQZERPcFVJUGVGRlhkQ1crSm1MMDRLT3FhRk1uMjY2U29sZ2VrTmlOb0Vh?=
 =?utf-8?B?S0I2U1R6RlFvK1lxTUFLbVRiMGdQOGRBMWl2QXhNWlgxMWllNSsvZk02bkpm?=
 =?utf-8?B?K2RTQXlBUk9EbkRYTitJemZDQ3pTNG0wczN5NVJYUVhzWG90K2NJTFpUZ2oz?=
 =?utf-8?B?c29qSXpyZ0xiclpBN29HSGwvc002K09NeTU5WHJWUzhVY2FZY2tjR24rWWZr?=
 =?utf-8?B?UWpSS29mQnFuaDc4UlZITnd4T0c1bDRjUTFqWmtmV3F5Q2xxd1RVTWVnS2ZE?=
 =?utf-8?B?d2I2OEY2aDZyZGxvNU5zZ0IveW1DN1JpamZCNlpWZ0dKMUhVN1UvcUg3dUpX?=
 =?utf-8?B?aWkrTGdoQUpGMVhQaEtneExlQVRZVCs1QXFKek5GbUZwNmpYTkNaKzlOa2Rm?=
 =?utf-8?B?YXZ3VWxRMUY4anN2NzFCa21TNXZhRitTcVVORGwxOFhIUDh1R3hKVkpDMWx6?=
 =?utf-8?B?WVZHcXBzcnd6RUxEUWxLUW5ja0ZXUTM4aElWL3J2SzhNU0NPNExmTHZURzU3?=
 =?utf-8?B?a1JQN05tNDJLRXR2Wkl4TG43SkV4bEE4cUsrSE9zSXQyY3Q5U0ozM3YwUktv?=
 =?utf-8?B?eC8yKzhIbHJZYVF2ZnJhSWh5TXNISXp6ejdGNHJZNGRUYjIxd1lReEtEZEl5?=
 =?utf-8?B?NTVYVzVxMDNoV2s0cGpFZDhlbFNTT0FsMjJQMnhlSXc4VDA0RmN0QjhYWFBj?=
 =?utf-8?B?SWxrL1BuSXBIQWxZMDdITkZFZ29YK3lZZmZubkp1cjhEbE1COGVsVDM2M3Mx?=
 =?utf-8?B?ZjN4Tk05N01oMzE1c21DTWx3TGt0TWZ0LzduOEtyUi8yV1N1cUFOWWoxWG1T?=
 =?utf-8?B?WjQxWVc3VzBuMyttTVZoMlIza3Y1VE1yOUpkdkFsTkhUVVFVZ2dyYkRuNUd0?=
 =?utf-8?B?VHNQcHNzeWp0Q1cza0RzSnh4bTA4ZGoxY21xUU1WZXhxSnI4QWw3UDFWSmZr?=
 =?utf-8?B?RHFCMy9QZTgrZll1U1ZiZHluVHVtd2VyQ0dUdTRXbjFRK0YyQnRwM0JyODlj?=
 =?utf-8?B?VERseTNEZWZuYS8rQjlma093UXp5UTdKMCtnSjcyT1NDNWFzekVBQjl0NWY4?=
 =?utf-8?B?ZHcybncxVVhscEJMZUEzeGVBN2Q4NWZFaHZBL28wR2RzdkQxdjRmU2VTZEtO?=
 =?utf-8?B?cERZM2tVQjVMSnpSV0RmY2VaTHJ3bE9xTjhiQUpKUi9SZTcvOGlFYXU1VnNF?=
 =?utf-8?B?bEVwbXZwNWp2NTlxcXFyMWxYTGFFaUFVWTl5TDRJT3M0Qi9ZRUxweXQ2aXox?=
 =?utf-8?B?K0VQSHZQSURCMldoc2o4M05TSGw5YW5vaG01Q3RNWHQxVzR6cFhYbkdhSVhv?=
 =?utf-8?B?bFBOb2FGVXZmYWJVVWNrcGc1cjdjcFpJQWJrVXRrNThNVVpRK3lUdHE5OUxT?=
 =?utf-8?B?emVNVnNQcS81UEFFa2tGMGtHWDBzUDh4SjJsRnZMZm5VZkh2bXc1YzVveEhS?=
 =?utf-8?B?L0RWR0FzZTZ0REJ4WmNaaHdzOVlaZnI1cEd2bG1GaUR2Syt4Y0h5Snc1ZDhx?=
 =?utf-8?B?aU1ESEptcDBoRWR3NkZ3YUozMzZPWmhKeDhaRmEyNVB3T0xFSGg4cEdydFRC?=
 =?utf-8?B?ck4vTFlmNkphOWpmVFVNRFEvYmhlTWFJRS9FbVBFcCtqUFNDdzFLUno2MGxH?=
 =?utf-8?Q?V4hs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5266.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7332f6d-148c-4db1-6b67-08dd78acdf77
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2025 03:56:43.4824 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GiSSkJ5F4IvGJiZlzz3vGErckRoqVydz2Lx8xp7Y3728Of00hUxmluP0gXzwVm76771+T0I6Abov1iCmd8yGpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7671
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
Cg0KPiBGcm9tOiBVLUJvb3QgPHUtYm9vdC1ib3VuY2VzQGxpc3RzLmRlbnguZGU+IE9uIEJlaGFs
ZiBPZiBWaW5jZW50IFN0ZWhsw6kNCj4gU2VudDogTW9uZGF5LCBBcHJpbCA3LCAyMDI1IDEwOjM1
IFBNDQo+IFRvOiB1LWJvb3RAbGlzdHMuZGVueC5kZQ0KPiBDYzogVmluY2VudCBTdGVobMOpIDx2
aW5jZW50LnN0ZWhsZUBhcm0uY29tPjsgSmFzc2kgQnJhcg0KPiA8amFzd2luZGVyLnNpbmdoQGxp
bmFyby5vcmc+OyBNYXJlayBWYXN1dCA8bWFyZXhAZGVueC5kZT47IE1hc2FoaXNhIEtvamltYQ0K
PiA8a29qaW1hLm1hc2FoaXNhQHNvY2lvbmV4dC5jb20+OyBTaW1laywgTWljaGFsIDxtaWNoYWwu
c2ltZWtAYW1kLmNvbT47DQo+IFBhdHJpY2UgQ2hvdGFyZCA8cGF0cmljZS5jaG90YXJkQGZvc3Mu
c3QuY29tPjsgUGF0cmljayBEZWxhdW5heQ0KPiA8cGF0cmljay5kZWxhdW5heUBmb3NzLnN0LmNv
bT47IFRvbSBSaW5pIDx0cmluaUBrb25zdWxrby5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCAzLzVd
IGFybTY0OiB2ZXJzYWw6IGZpeCBkZnUgYWx0IGJ1ZmZlciBjbGVhcmluZw0KPg0KPiBDYXV0aW9u
OiBUaGlzIG1lc3NhZ2Ugb3JpZ2luYXRlZCBmcm9tIGFuIEV4dGVybmFsIFNvdXJjZS4gVXNlIHBy
b3BlciBjYXV0aW9uDQo+IHdoZW4gb3BlbmluZyBhdHRhY2htZW50cywgY2xpY2tpbmcgbGlua3Ms
IG9yIHJlc3BvbmRpbmcuDQo+DQo+DQo+IFRoZSBzZXRfZGZ1X2FsdF9pbmZvKCkgZnVuY3Rpb24g
Y2FsbHMgdGhlIEFMTE9DX0NBQ0hFX0FMSUdOX0JVRkZFUigpIG1hY3JvDQo+IHRvIGRlY2xhcmUg
YSBgYnVmJyB2YXJpYWJsZSBwb2ludGVyIGludG8gYW4gYXJyYXkgYWxsb2NhdGVkIG9uIHRoZSBz
dGFjay4gSXQgdGhlbiBjYWxscw0KPiB0aGUgbWVtc2V0KCkgZnVuY3Rpb24gdG8gY2xlYXIgdGhl
IHVzZWFibGUgcG9ydGlvbiBvZiB0aGUgYXJyYXkgdXNpbmcgdGhlIGlkaW9tYXRpYw0KPiBleHBy
ZXNzaW9uIGBzaXplb2YoYnVmKScuDQo+DQo+IFdoaWxlIHRoaXMgd291bGQgaW5kZWVkIHdvcmsg
ZmluZSBmb3IgYW4gYXJyYXksIGluIHRoZSBwcmVzZW50IGNhc2Ugd2UgZW5kIHVwDQo+IGNsZWFy
aW5nIG9ubHkgdGhlIHNpemUgb2YgYSBwb2ludGVyLg0KPiBGaXggdGhpcyBieSBzcGVjaWZ5aW5n
IHRoZSBleHBsaWNpdCBzaXplIGBERlVfQUxUX0JVRl9MRU4nIGluc3RlYWQuDQo+DQo+IEZpeGVz
OiAwNjRjODk3OGI0NGYgKCJhcm02NDogdmVyc2FsOiBFbmFibGUgY2Fwc3VsZSB1cGRhdGUgKFNE
KSIpDQo+IFNpZ25lZC1vZmYtYnk6IFZpbmNlbnQgU3RlaGzDqSA8dmluY2VudC5zdGVobGVAYXJt
LmNvbT4NCj4gQ2M6IE1pY2hhbCBTaW1layA8bWljaGFsLnNpbWVrQGFtZC5jb20+DQo+IENjOiBU
b20gUmluaSA8dHJpbmlAa29uc3Vsa28uY29tPg0KDQpBY2tlZC1ieTogUGFkbWFyYW8gQmVnYXJp
IDxwYWRtYXJhby5iZWdhcmlAYW1kLmNvbT4NCg0KPiAtLS0NCj4gIGJvYXJkL3hpbGlueC92ZXJz
YWwvYm9hcmQuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvYm9hcmQveGlsaW54L3ZlcnNhbC9ib2FyZC5j
IGIvYm9hcmQveGlsaW54L3ZlcnNhbC9ib2FyZC5jIGluZGV4DQo+IGI0NDgzZDAwYWQxLi4zZWRj
Y2M5NzlkOCAxMDA2NDQNCj4gLS0tIGEvYm9hcmQveGlsaW54L3ZlcnNhbC9ib2FyZC5jDQo+ICsr
KyBiL2JvYXJkL3hpbGlueC92ZXJzYWwvYm9hcmQuYw0KPiBAQCAtMzk2LDcgKzM5Niw3IEBAIHZv
aWQgc2V0X2RmdV9hbHRfaW5mbyhjaGFyICppbnRlcmZhY2UsIGNoYXIgKmRldnN0cikNCj4gICAg
ICAgICBpZiAoZW52X2dldCgiZGZ1X2FsdF9pbmZvIikpDQo+ICAgICAgICAgICAgICAgICByZXR1
cm47DQo+DQo+IC0gICAgICAgbWVtc2V0KGJ1ZiwgMCwgc2l6ZW9mKGJ1ZikpOw0KPiArICAgICAg
IG1lbXNldChidWYsIDAsIERGVV9BTFRfQlVGX0xFTik7DQo+DQo+ICAgICAgICAgbXVsdGlib290
ID0gZW52X2dldF9oZXgoIm11bHRpYm9vdCIsIG11bHRpYm9vdCk7DQo+DQo+IC0tDQo+IDIuNDcu
Mg0KDQo=
