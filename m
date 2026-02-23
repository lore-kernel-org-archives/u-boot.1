Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F81EC113D
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 21:07:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6898083C39;
	Mon, 23 Feb 2026 22:07:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=issi.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=issi.com header.i=@issi.com header.b="NPw/VEXS";
	dkim=pass (1024-bit key; unprotected) header.d=issi.com header.i=@issi.com header.b="ExvQw6dk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF72883C6E; Mon, 23 Feb 2026 21:59:40 +0100 (CET)
Received: from mx0a-009ae801.pphosted.com (mx0a-009ae801.pphosted.com
 [208.56.8.34])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CCB883935
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 21:59:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=issi.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jeyu@issi.com
Received: from pps.filterd (m0495959.ppops.net [127.0.0.1])
 by mx0a-009ae801.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61NKtV8A4184328; Tue, 24 Feb 2026 04:59:32 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=issi.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=11242025; bh=CSpnscd7z3rAWAF/yk3Gcfy
 v54v8dllYxhqCk9liDyY=; b=NPw/VEXSKRtECKcOxGkwT6TZc0ohoecOVJO/y/f
 DOI4CDJptLr/RO9KBDsw2tgCTsvfJIneDoKFfIGjjb77468fgWeP9XDIoyvrQ4T5
 5/1Cxbbsj489raZi7fcOhk1JEI8aqGpWgaYrweHgERN4hA2L61ABgEm1KRbMiqpt
 YVJdkSOHgxcftTXHMlMhn1hdROyf745YbiUDItw+sOSDlxS5mNmY6fOjslJhotPH
 8jkGTqL+uZcNVZ8w/LgBwSYptHabG7OE+IodzETV0mxvrUvxEho0Y+FZV7o5mXWA
 OPPbHr7Qduo90isiXrmOf7s23h07gP2ZlTbqvOlVbLazsMQ==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021088.outbound.protection.outlook.com
 [40.93.194.88])
 by mx0a-009ae801.pphosted.com (PPS) with ESMTPS id 4cfksp0xj7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 24 Feb 2026 04:59:31 +0800 (WST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pe3yxDPxtzfnETJR+/8ysy+pFlquZSj+/kFg79XyFFEsFqgGho0eT6ls9qWYbyDvJe0532ST1IuoTUZSOnM6cZ86b6GCHg/J5D5l9a+PT/zyc3XyUcLX3sSiv6PBmyfTK+71Clzf5DyfMv2sc5KikwywLDwwlJLMnSO4RvQJhP0S5URw9Y9vf8ItEAUJntGPYaVAGyrgXixdU3dTF95dRqHAw0ZlIin0sOgND1eCxGc9aiKCCWvXkUKU7/PkN5jnZaq3aeMAQfX9RaNJ0ZrFgD8eywbY/SnztTc4+KrwW4yPkYe5hFVGjiCIGT0Ff7RgYLVTXANvbOkDwQJJaoWLXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSpnscd7z3rAWAF/yk3Gcfyv54v8dllYxhqCk9liDyY=;
 b=fYuVXZ79rab5x30uuwD/KgKrfLrtMTJfjqs7H0d/kGb3i0lDBLMzDyBEztESNXbaiUeFl4ko0s60UIZoAcz2d903fQxcinpt5YzYWZm56bX67lck5rOPFRpjE/V03v642pekPEnYkJk8C1F1Usv+AS5zPRTUM0rHxUYtWE+cAsbGCPpoHNQZogZrylo05DnIzG839iFaEgiAoigNPRR73CaBgnGCMpjg9eVeQfeaMlfbTHuZ3uZf3fkkhwt9vBpGSCcpLS7hpTAo5mDGBv3L6m9EPabsP6iRwhceu55+uqS+rFDaPaIba+zsMz6Ld5A7gRlegsyDh4sRE1NzrFTl/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=issi.com; dmarc=pass action=none header.from=issi.com;
 dkim=pass header.d=issi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=issi.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSpnscd7z3rAWAF/yk3Gcfyv54v8dllYxhqCk9liDyY=;
 b=ExvQw6dkndvN1ZamrkuWE22bodcBLuHMJtnNZrYfz4ZjEVy7MbIyG83tTyAh92FRah30J8Ap7mYK3oLsH3tIroiNbILQ3Y2aSFHsSujhIHLgAEKXw29viqbwnltdxwhy5UxqGQsdhhCmib4TwVGOQM3JSldsxJP8yT/58msA4PE=
Received: from PH7PR19MB7361.namprd19.prod.outlook.com (2603:10b6:510:270::22)
 by PH0PR19MB4806.namprd19.prod.outlook.com (2603:10b6:510:20::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 20:59:25 +0000
Received: from PH7PR19MB7361.namprd19.prod.outlook.com
 ([fe80::d3bd:9741:975b:fc3e]) by PH7PR19MB7361.namprd19.prod.outlook.com
 ([fe80::d3bd:9741:975b:fc3e%4]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 20:59:24 +0000
From: Jeffrey Yu <jeyu@issi.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "trini@konsulko.com" <trini@konsulko.com>, "Mutya, Havish"
 <havish.mutya@amd.com>, Ron Kalakuntla <rkalakun@issi.com>, Ji-Ho Kim
 <jhkim@issi.com>, Johnny Chien <jchien@issi.com>, Anand Bagchi
 <abagchi@issi.com>
Subject: [PATCH] mtd: spi-nor: ids: add ISSI IS25LP*J/*MJ/*E and IS25WP*J/*MJ
 device IDs
Thread-Topic: [PATCH] mtd: spi-nor: ids: add ISSI IS25LP*J/*MJ/*E and
 IS25WP*J/*MJ device IDs
Thread-Index: AQHcpQZA2PF20LsWbkGNC6Vl7sMGvA==
Date: Mon, 23 Feb 2026 20:59:24 +0000
Message-ID: <PH7PR19MB7361D02E5CEC8F26BF50ECECB677A@PH7PR19MB7361.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR19MB7361:EE_|PH0PR19MB4806:EE_
x-ms-office365-filtering-correlation-id: f25d4a0b-40e7-4e8a-b989-08de731e6cf8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|13003099007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?fa2JP+GE4DpCyzDzgH7w4V1lzBTbmgO3HO6Blvv0cdZBoYsYtxRqi1ZdbJ?=
 =?iso-8859-1?Q?c4ggmGy095t5M5Yor13KcMjEZhs0cRR2T+bR6nOAGGFy6VrcrUnturH4Nx?=
 =?iso-8859-1?Q?gcf4/rE10FK5lQJLbxiuEeZ/Cdue62eCh4/3LngRkpYkZBXCgni1Ne17B4?=
 =?iso-8859-1?Q?5I8XULfibhgSX4Bp1O/hdv3X4VbRjeZbVSkl3fzV0ttWu1TcrEJIo+mano?=
 =?iso-8859-1?Q?jcZ9fABpscuxFVAawnOLeYXqqtmCxfOKpdgIqqDVg/abxW1HCG5w3VAld5?=
 =?iso-8859-1?Q?0xcYhavvcWrh1ZFsOBRrMG9VilqkNZF46vQt241kPjuohV4PQtbAhWP6yV?=
 =?iso-8859-1?Q?16tk8ToIYTGgCMRCIEGOzWygnBX8pfKRuVfEVA47u17eHRuh2JxAYB/mG3?=
 =?iso-8859-1?Q?LyvUh+tV1k7HCleGdXgeX3kE5HzaKt01/+oLUDkrcTuuquSeoTyUNyaaHQ?=
 =?iso-8859-1?Q?eiklECFUPDrVKMhwnCVm52dPAIJS6fzx6D8/VYilBk1uFgxlEBvOhR7jti?=
 =?iso-8859-1?Q?nkMbt9VNcoclNEy/gX6qEEPSpSx4y4NUq4S+dqynSp95OM+1KM2i8EamFb?=
 =?iso-8859-1?Q?o5lCsUZfw3dWpJNd4RShEYNTq65ZkthOsbDWhFRRfipyAI+8G+FG3JkNwx?=
 =?iso-8859-1?Q?vThS2HJY+eBKpXC7KgIce2nRWwKsgTGS3akd4NexsUltlaiMp0Gm2ZgcSA?=
 =?iso-8859-1?Q?vSuQ13rohoLlhUp3gQTXKWg0tOvmjNy5loZEbEv5c59omCPvm1ZxZhj/6H?=
 =?iso-8859-1?Q?ASZTJwS/eFwzIX0RR64BdAD/TLk7CnxUi/1pViNWGovkR3NWI9hebAXrue?=
 =?iso-8859-1?Q?QWlWCwhp5JnBzuiR1D0wmyTeBiZx5aqovQqPgyj6yphGeJUkQ3b9P7LkJn?=
 =?iso-8859-1?Q?N87pEaNvCVshjxFjJcf8HONC5RWpWVRIKBbmvZM9iFbPj5gccuEEaBoXyt?=
 =?iso-8859-1?Q?q4pwTRjneozxlUT7uPrf6wEd8D83RPkdmocrT8F3IxYaMwDIuVzySska+P?=
 =?iso-8859-1?Q?kv7LrsRHmCrqikY6GAbziqiIqVewoMOrP1Yv3QBLizGEq9UkV/+BN95Bvd?=
 =?iso-8859-1?Q?1KpLkOMyfDqkesN8dz8fplMt8T6qY6au2W3Cy5TJKXtTuSowqTVbgmUuzi?=
 =?iso-8859-1?Q?Lz2zn5a9gQAGlYQ4QGJV9a4cnO2mKqjh7YH9pTv9ZLzHvff4OUlfyhSHZn?=
 =?iso-8859-1?Q?qUTyoegCnsrA+1Wru3/Ty8tkIHI9+B4gAv1HsMcwXd2ISTNkAzfU39NyJ0?=
 =?iso-8859-1?Q?y3PqgqTXEoUcjMSutkAMH5HODCdsXNbrDZ5Zr/TPK02vUXuOJPDeYTu9PL?=
 =?iso-8859-1?Q?IarKcEVNr3F+FtrkUzGt4+X2CAO112m9q+Rou9gvtOhyEmpPGh0dxBs985?=
 =?iso-8859-1?Q?x74/3ZQoWFuaV4CFxhATaIWErJflFhyPBKoF3Z2wJK/2FqnbaShLFJPFyD?=
 =?iso-8859-1?Q?TkivmLPpKyTi6Jlf7JiOI6O7jZOqLUxE3/C/rpFm4PLIYd1QUg0v2vhEFt?=
 =?iso-8859-1?Q?T2B0LtTnTfggyEWUeKG/XSEs7Sj0AQ2H9h2z7AnC2b8YptSUWiJw2uXUgJ?=
 =?iso-8859-1?Q?35fosJHIu9tAHyw+iVqjDY4AOpf4/GnpROODcYo1xpet3vHSJNQakJJ+1M?=
 =?iso-8859-1?Q?YL3Y0Bow9OPmCVzPEQr5LYyWdLjBE+/BAJ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR19MB7361.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(13003099007); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?76j5DzBw2Nx5hEVwAtQ1Oo75ZbxUccHmF5NSrzS2PKF5bV/NTjE+m+VbUz?=
 =?iso-8859-1?Q?8+WP3fGpBTpnvdJik+ZyvSvkeOEOXu+rexVbBHB/7zuDdOruW90+xxQ82M?=
 =?iso-8859-1?Q?5cB3wzo0aWi4w6eIdeYEWo1+z/ISaIFsCuxxdOSfjK1ZbFJ7iq4rfOWzwY?=
 =?iso-8859-1?Q?eVakQWl4bIGVidC/wJ3+M3+DKwYaeVR2/g+Y56zajrs0OBVis9xMZFeY0j?=
 =?iso-8859-1?Q?+LYwy7Sc1DJZEZzj+BRVmkKgRbge7ASxFxsCpP1EAowiRxb074hus3j6KY?=
 =?iso-8859-1?Q?66AwU3KgrZKSmeH5F5ZYs79JlmLJcLKdix3paftSuy4jDtL52pvn+7h08o?=
 =?iso-8859-1?Q?813kIwQIFKWq7pVV+n2KXf8h6d9okWR7SVAYLWu3Uk/iMMOLOb9ab7cEto?=
 =?iso-8859-1?Q?mGul7GjrEpl73EHI6BuVAD9peAcCvV/oY8gwvP3IHtyL12OMXp/7trXbPi?=
 =?iso-8859-1?Q?bWZor1+gBqXocCOCNTgzxI0eH43O5NvKYJecIU9FFmfjEhkS3AX2SenTV2?=
 =?iso-8859-1?Q?c07QEj1A0X7zxSU6o+oFiJKG+aoURjP3ciNsyuLliHUL1890BduARmBzSY?=
 =?iso-8859-1?Q?+KvM0mchyqpcJS+0V5IbSf/tVkcyHOgQAi32mUTodpjcQFRY6rJgEtCU3Q?=
 =?iso-8859-1?Q?S3LpDHnwwHtZldM/DzY9zg2qjOE6dP9AGyR6jaDOZYWi9JR5CnQDAN+2OT?=
 =?iso-8859-1?Q?dv8tAbneXeQGapH/v0vzIahwa+3J//Pmyv3+duYBepIeg9Roy3MYCB2eZQ?=
 =?iso-8859-1?Q?tFUCSlTLCqdMWpRhIJli8X0kCxIebuyhvFIwFwevLj6IrIreQTPZMgQqZZ?=
 =?iso-8859-1?Q?j3AyPjtVqWujrDCh0Mv9zg+qN+DG4Kf8DFDwb9XVYaxpjWiD2T40SGrcU2?=
 =?iso-8859-1?Q?vrXyF1j5Lnk5flt9C7H90QeT+0LDTBzQU7WyJ7ByQDvMGq+ww20h2XFj6v?=
 =?iso-8859-1?Q?ilDBTdfAsmK5LvpAH/HoAmH1I8R7dNUSQhJDybNv94mrTcbioCOepkhLKU?=
 =?iso-8859-1?Q?iSkRmlQAPlvCkmAym16bm3154wkoNj5Sqz9/RKzdz3T6Xxi4CYz62rB3Rg?=
 =?iso-8859-1?Q?mkkMM0qUN5hi2hk95mCnfUSPEanExiJvnBjEWFHEPqG/9wSKl9MBNUVRNz?=
 =?iso-8859-1?Q?da3w89XRJzxRNfTlaH5QHbK3rG8eZrX3L6lRQoFJVrYmfsLI79P96+zuT1?=
 =?iso-8859-1?Q?q0t7WHxU3s+eUpO6zzu9t3Oe9PRRACO9oAVMlTwm9QF7yeScPhWEwP702q?=
 =?iso-8859-1?Q?Lpk4rBV68t2qyQx5uMAnTx4qC+399OfQIdPkBDY7limv4LH50qjhZdPD51?=
 =?iso-8859-1?Q?jwe6rVmBvy+t+Koh2eoF29B1KjxAFrKuEXLEuMtLYvI58qbID+FFD2MiA4?=
 =?iso-8859-1?Q?T/upSeuLl//7No9NBrXFBRIOdw+YFo+bZ4Fxgtg3nUnE2I9HcumOR13Hp5?=
 =?iso-8859-1?Q?rP8xubWCoUZ+uOG86JJ3A+cyck/R+DY6TLueCzhXuEiIs16POlLmHyQyEp?=
 =?iso-8859-1?Q?C0tRg2sD3oieJqfwLn+LuWe513PwoIUw2NUsWFac+dPIYyRSm/ycmM5EL/?=
 =?iso-8859-1?Q?ofcbR4BRFAYlMyxMJPXSEYcNiufTWnW0/8Y3BkXCEBGZ0mprEYHGWUnWfw?=
 =?iso-8859-1?Q?OaB68m9Fl+c27N45p+e304bVDwuGhwrpyhFnkYCPq4N7HvUKDgHtuHNWc6?=
 =?iso-8859-1?Q?kBJR9BjkDduL4UjLhO+KXVk0ColonTfqNvfMFdWaZEC5dm9fDZzLYSOHZn?=
 =?iso-8859-1?Q?alm2/yGogJKp8/9NQagTwUQJo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5sP0+TDxaQ8k07UN863OyZ09s4LoLnNNAtM6WgF1jJ096SJ/5Me/r2Afp9ZpWgh3DLuOy1qYTWkR47ltzWO1XKoPaP57SOvlS84M5+v/95jcd+fdoVvNYLXPAmtb16zauCyPBV9DU1JMgMYPbb3ZI+EeVTAQuL0aiLDwm1e+YfMniJ2wOzCmf7KA5zrQ9IeW8IUw5/VV2JVrPbk9DtjnpPCTLOLQdISbmjoisCMRx57dZ1AioIsCIRJlxVVfi+saaWYA5Hu+Lo1hxaPSs1psS7/W7pAZqR904FH92z+aSdENLrRx29C1+7PYa9LwUXShJ035wQg19eMycAvAFqHSJrwwTG9LH0QrJE9+OhBbvDFZIOOltqTTm+dgPkLm+fzoLLBt6pGBaY2EGw5ME3KpjmBdfodJwQLNQ5rHzamq9t+k7h+ITctOBMnNfIv82X4IAGv2RPYTx2y0cHRdmPJPsH1VPWIdO+yaKM5j5x90wwOT0VdW9g6an8Ji73WxQklFF97hardL7gYjKvsHIWzIHz3oUrxc0wb1MWKykrRuHBLvws1cNauMA1fpdtvIX+Wgi3JzZvRiSx0EeEuoUFzTJALrqqf4htrBLBsJ9/62YuOc3RB92M1rlt80kjEMQaFu
X-OriginatorOrg: issi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR19MB7361.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f25d4a0b-40e7-4e8a-b989-08de731e6cf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2026 20:59:24.7395 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6af618fc-4f7d-45f1-a2f2-8c59a26d2c10
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 82kwZiKQVfozToVhozh22ff426xZeHL/SwUkPVs3xj1/VLIWpPgqMAcJGzQxb8/c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB4806
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE4MyBTYWx0ZWRfX8ye4YfS9Mtj8
 lfz2gZtWmA3l5RCeo+M5TMLPPiy183gxANJoCyYGTFKADvibyzYkCFqmWlIzV4VnN1OMij7209Q
 sDWEsQ3VelhaS1CVK87Q7MV839KI0nwyHEEkN73X4erfXXmgC0puDOoyB4EljBM1PKC8uSBRFmd
 pMs9179pZah8VSRvnTcDvRPwnmBm6Wxjb32es6GwXHijkVbfro5pJFUuZ7+gY3LHBRrgLUbV1Ea
 UG9lZFIqd3w2yoFNtKPH7ZNKNxuKIvt1IiG8DkRA7Qw2Uu6g4PjVPQ2W41jrpPm0O6f8BnNhfgY
 QIajZjGCzxF/E3iLwLC5DdQirVXJLiPJ56ol2Xb24mU0u6ByGrLpgVJaKNt7r+xu7gN60BJZStn
 iYyw2xPPlTkm/KMRdbcVqyyuB6F3U/7nd/fxDZVZ3KvW7KAggD5YAO2CMb0FgRYNwIrSUPRLYOn
 D9I9IjA5RVK1OGvd1iQ==
X-Proofpoint-GUID: ko3qj899DB87grCWRAqyctQZioYO6ihO
X-Authority-Analysis: v=2.4 cv=eNAeTXp1 c=1 sm=1 tr=0 ts=699cbfb3 cx=c_pps
 a=msPUCbsZKHGyBhhyaqynTw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=HzLeVaNsDn8A:10 a=ozMtBe7fU4EA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yOHNzV93IasTtWdH6Nhn:22 a=vXxuYqdcOO96AszD6dbd:22 a=DUnRZS7UAAAA:8
 a=rocalyBAGqUn3fZcKR0A:9 a=wPNLvfGTeEIA:10 a=cDzw7mrAGmWHSR5u0tpu:22
X-Proofpoint-ORIG-GUID: ko3qj899DB87grCWRAqyctQZioYO6ihO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_05,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 clxscore=1011 suspectscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230183
X-Mailman-Approved-At: Mon, 23 Feb 2026 22:07:02 +0100
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

Add JEDEC ID table entries for additional ISSI SPI-NOR devices.=0A=
=0A=
These parts previously not yet supported. =0A=
With these entries, U-Boot can match the device by JEDEC ID =0A=
and use the existing ISSI SPI-NOR device handling.=0A=
=0A=
Newly added devices include:=0A=
  - IS25LP512MJ  (JEDEC 0x9d6020)=0A=
    https://www.issi.com/WW/pdf/25LP-WP512MJ.pdf=0A=
  - IS25WP512MJ  (JEDEC 0x9d7020)=0A=
    https://www.issi.com/WW/pdf/25LP-WP512MJ.pdf=0A=
  - IS25LP010E   (JEDEC 0x9d4011)=0A=
    https://www.issi.com/WW/pdf/25LP-WP040E-020E-010E-512E-025E.pdf=0A=
  - IS25LP020E   (JEDEC 0x9d4012)=0A=
    https://www.issi.com/WW/pdf/25LP-WP040E-020E-010E-512E-025E.pdf=0A=
  - IS25LP040E   (JEDEC 0x9d4013)=0A=
    https://www.issi.com/WW/pdf/25LP-WP040E-020E-010E-512E-025E.pdf=0A=
  - IS25LP01GJ   (JEDEC 0x9d6021)=0A=
    https://www.issi.com/WW/pdf/25LP-WP01GJ.pdf=0A=
  - IS25LP02GG   (JEDEC 0x9d6022)=0A=
    https://www.issi.com/WW/pdf/25LP-WP02GG.pdf=0A=
  - IS25LP02GJ   (JEDEC 0x9d6022)=0A=
    https://www.issi.com/WW/pdf/25LP-WP02GJ.pdf=0A=
  - IS25WP01GG   (JEDEC 0x9d7021)=0A=
    https://www.issi.com/WW/pdf/25LP-WP01GG.pdf=0A=
  - IS25WP01GJ   (JEDEC 0x9d7021)=0A=
    https://www.issi.com/WW/pdf/25LP-WP01GJ.pdf=0A=
  - IS25WJ128F   (JEDEC 0x9d7118)=0A=
    https://www.issi.com/WW/pdf/25WJ128F.pdf=0A=
  - IS25WP02GG   (JEDEC 0x9d7022)=0A=
    https://www.issi.com/WW/pdf/25LP-WP02GG.pdf=0A=
  - IS25WP02GJ   (JEDEC 0x9d7022)=0A=
    https://www.issi.com/WW/pdf/25LP-WP02GJ.pdf=0A=
=0A=
Signed-off-by: jeffrey yu <jeyu@issi.com>=0A=
---=0A=
 drivers/mtd/spi/spi-nor-ids.c | 26 ++++++++++++++++++++++++++=0A=
 1 file changed, 26 insertions(+)=0A=
=0A=
diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c=
=0A=
index b4221a82e01..c6d65196ebc 100644=0A=
--- a/drivers/mtd/spi/spi-nor-ids.c=0A=
+++ b/drivers/mtd/spi/spi-nor-ids.c=0A=
@@ -222,6 +222,8 @@ const struct flash_info spi_nor_ids[] =3D {=0A=
                         SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_HAS_TB) },=
=0A=
         { INFO("is25lp512",  0x9d601a, 0, 64 * 1024, 1024,=0A=
                         SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | =
SPI_NOR_HAS_TB) },=0A=
+       { INFO("is25lp512mj", 0x9d6020, 0, 64 * 1024, 1024,=0A=
+                       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },=
=0A=
         { INFO("is25lp01g",  0x9d601b, 0, 64 * 1024, 2048,=0A=
                         SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | =
SPI_NOR_HAS_TB) },=0A=
         { INFO("is25lp02g",  0x9d6022, 0, 64 * 1024, 4096,=0A=
@@ -239,6 +241,8 @@ const struct flash_info spi_nor_ids[] =3D {=0A=
                         SPI_NOR_4B_OPCODES) },=0A=
         { INFO("is25wp512",  0x9d701a, 0, 64 * 1024, 1024,=0A=
                         SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) }=
,=0A=
+       { INFO("is25wp512mj", 0x9d7020, 0, 64 * 1024, 1024,=0A=
+                       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },=
=0A=
         { INFO("is25wp01g",  0x9d701b, 0, 64 * 1024, 2048,=0A=
                         SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) }=
,=0A=
         { INFO("is25wx256",  0x9d5b19, 0, 128 * 1024, 256,=0A=
@@ -249,6 +253,22 @@ const struct flash_info spi_nor_ids[] =3D {=0A=
                         SPI_NOR_OCTAL_DTR_READ | SPI_NOR_OCTAL_DTR_PP) },=
=0A=
         { INFO("is25lp01gg",  0x9d6021, 0, 64 * 1024, 2048,=0A=
                         SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | =
SPI_NOR_HAS_TB) },=0A=
+       { INFO("is25lp010e",  0x9d4011, 0, 64 * 1024, 2,=0A=
+           SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },=0A=
+       { INFO("is25lp020e",  0x9d4012, 0, 64 * 1024, 4,=0A=
+           SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },=0A=
+       { INFO("is25lp040e",  0x9d4013, 0, 64 * 1024, 8,=0A=
+           SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },=0A=
+       { INFO("is25lp01gj",  0x9d6021, 0, 64 * 1024, 2048,=0A=
+                       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | S=
PI_NOR_HAS_TB) },=0A=
+       { INFO("is25lp02gg",  0x9d6022, 0, 64 * 1024, 4096,=0A=
+                       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | S=
PI_NOR_HAS_TB) },=0A=
+       { INFO("is25lp02gj",  0x9d6022, 0, 64 * 1024, 4096,=0A=
+                       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | S=
PI_NOR_HAS_TB) },=0A=
+       { INFO("is25wp01gg",  0x9d7021, 0, 64 * 1024, 2048,=0A=
+                       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | S=
PI_NOR_HAS_TB) },=0A=
+       { INFO("is25wp01gj",  0x9d7021, 0, 64 * 1024, 2048,=0A=
+                       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | S=
PI_NOR_HAS_TB) },=0A=
+       { INFO("is25wj128f",  0x9d7118, 0, 64 * 1024, 256,=0A=
+                       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | S=
PI_NOR_HAS_TB) },=0A=
+       { INFO("is25wp02gg",  0x9d7022, 0, 64 * 1024, 4096,=0A=
+                       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | S=
PI_NOR_HAS_TB) },=0A=
+       { INFO("is25wp02gj",  0x9d7022, 0, 64 * 1024, 4096,=0A=
+                       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | S=
PI_NOR_HAS_TB) },=0A=
 #endif=0A=
 #ifdef CONFIG_SPI_FLASH_MACRONIX        /* MACRONIX */=0A=
         /* Macronix */=0A=
--=0A=
2.43.0=
