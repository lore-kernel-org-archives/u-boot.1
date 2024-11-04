Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C52FCD132B5
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 12:20:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17DEB88009;
	Mon,  4 Nov 2024 13:20:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="F1rvTBsw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABEE488CBA; Mon,  4 Nov 2024 13:20:43 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A50AF88009
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 13:20:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RP+uRA8goRESxt9pNKcYrttK6pwLz9PmIrp0eLEtirmNnAL8+urTBjj4FhLTy/iyQH6cHk2xy9YidqBEt3+4bCMu1Zec3fjdNGCnLCbw4HZhWt0AplIQ0j81OdA6KptE0r1waeyXlAtA00hHlRjqjZlDKRIjiyjZCH3ekI+p3QNstVaVnbfkmMzSMt7kmxtsfBTagKcQDiXoKarjnnvt1yeUt/n3ZDtwmjMOOfx7Uau01LoNlYtpluUSFIq1ufVKZMgzowWf0WQ7iemFdJ2GAJC0ztxG6og3o5llwwmhV047AaCVOcRWCg9ybsfkHtKS5oqYXfD8xwM50w42sUOELw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OVgJN/XUg9GqALrgSTQ1lATPED+G7sPupOtJYt4+88=;
 b=nJnV6zN9m2hqxHeaWEVFsmGwgzvurJYOBOMgx1hwFGWhzgsE8ffscV0I0+xd8d3U0TeoRTlH/ewirb1FBt+0BPh/mHSgawmvpwkQzroBYROZURr57i1OsBKjbgI9FPb3utH9sSsshNxsUBzd6uJx8UGY5ypNAjPlN8NuCvlR5wBBVshe3BuxiTEAS04gSV2/eDypshEq5qpdfc2pLmgg5cTcN0OjgD2wRtsopb5x6kSH28z7Wuf5SVt3TWRU6jFKk2P/5q6qkd4p54z7ox+Rt5su4DQOMuvpqilj1JR9m0pQtV5Lv6VfdSPT4pnVLV90lqKaZ7rUFlxfGQ9XhDBt8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1OVgJN/XUg9GqALrgSTQ1lATPED+G7sPupOtJYt4+88=;
 b=F1rvTBswnBGvHUhTDJN0ArIE7fjDwitL5XnBkqwsnCr2omN7+AdYqPlVS3t5rqnPZusneIZqMiLWEmbUn/BL0kUrObp7ZfM6zXwSLDVCUvqr/0WzgNH/3ePd+8+1+bkmtMgUzIzsvxoc29kshuTv4Y/D3rDH1n17lLz/P9w5O7S9WB6he4BHDfV9hszf50a+/JeqLrMIhl90VjJd09bxBzcLu2mIJ+9fVhcADywiwsPKX84JZS4hoUaPkvJTbNa+RELQN2pChFkd7dKhcvp43PhTdHDQoBDAwbavd0MJCDb1ntsAMtMIQfhPgyQP62iEOy940Wsq5cyaHtwNLhgI4A==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8894.eurprd04.prod.outlook.com (2603:10a6:102:20d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 12:20:39 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 12:20:39 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Marek Vasut <marex@denx.de>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, Sean Anderson
 <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>, Fabio Estevam
 <festevam@gmail.com>
CC: dl-uboot-imx <uboot-imx@nxp.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Viorel Suman <viorel.suman@nxp.com>, Alice Guo
 <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, Ranjani Vaidyanathan
 <ranjani.vaidyanathan@nxp.com>, Teo Hall <teo.hall@nxp.com>
Subject: RE: [PATCH 00/17] (no cover subject)
Thread-Topic: [PATCH 00/17] (no cover subject)
Thread-Index: AQHbH5urN4RhovOdqEOIzMmfBLzS7rKnFviAgAARKxA=
Date: Mon, 4 Nov 2024 12:20:39 +0000
Message-ID: <PAXPR04MB8459B83D68F7365C5C0B5C2A88512@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241016-imx95-v1-0-f640c8f3bc1b@oss.nxp.com>
 <ee6519d5-30cc-485c-b87e-89665066a827@denx.de>
In-Reply-To: <ee6519d5-30cc-485c-b87e-89665066a827@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PAXPR04MB8894:EE_
x-ms-office365-filtering-correlation-id: 320ad157-e15e-4652-31ac-08dcfccb1828
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VFVSYVcrRHNHSkp3VmVRZzIvUllkOVFXTEhNRHhQWStUS3ZlaTZOK2lmcHh4?=
 =?utf-8?B?cDZQR2JBcm8yUDQ4U0d3MUtjaEoxMHkwZ3p4cVB1Z3QrYnJWSXFUZ0QwY2lE?=
 =?utf-8?B?L1JCR0Q5R1ZoUXIyN1RiN1EzVldmaFFQV2tITHV0TVFSWk1NR21FSUYyVjBT?=
 =?utf-8?B?dDlrUmI0c0NtejNwZHgvcGFoQ0FLbG1Tb1BWOVpQNk9BTnpvazVpQ01QM3BW?=
 =?utf-8?B?U2xMaVorUmc0YmdDWEowS3BTY2Vjd1NOR0tCc3FTaXJHMXdLdjVHeTdaWXdD?=
 =?utf-8?B?ZlVRTWU2REx1cTVtbThCZTRSNHQ5dStuNlpiN3UrSnJJNmYzWlhxYlBrQ1E0?=
 =?utf-8?B?UFJSZ2craDBhbkdMSDhDWXRuMDFJR0MrRmtNOTBVeGtoNS9sVzA5YXBMMnFw?=
 =?utf-8?B?RUlOV3U2ZjAvZ0JhSm1kbXdZcWF4UzBySXJmcEpNZ1NJZ0tqU1R5Rm42TDJW?=
 =?utf-8?B?MElWbHBSWlh0dTM2bUdZM2lPVkxPZjZwdE41WnRIcUlMbmpLYjhObDBZN2hB?=
 =?utf-8?B?NVZ1MnR2eXFNekdDNG1XT0RKVTdYYmhkWUNDdDl2Z2o5S1dzSjQvVmhzU2Vx?=
 =?utf-8?B?dyswSm5EaEgwekVrRjZpbXdzN0d4bHRLSWRPZmJWMy9FVFd0SzA2eC9vZWVI?=
 =?utf-8?B?YmdUSkZBU0hrUjdkQVZtZ0tRTTVEZmFGMDdPV1JNdjRZM0RUaDV5R3Z6YlZK?=
 =?utf-8?B?Zy92d21yNEdQMkxjUkRZb1ZlcmNwdTY1bGI3eS9QYllDUWd6WUxZaU42dElw?=
 =?utf-8?B?M0tRZldJRm10T3BPcjk3T2xEWnROaldjbFhPcmVZRUpoNkxuOW13TTBSa2w4?=
 =?utf-8?B?T2Z5SzhUL2g4UG41cEVSY0xVSUFmbkt1R0NhWFh0ODVHWFB2QkVVL2hpbCtB?=
 =?utf-8?B?SEt1MWtFcTJzZlEwV25Vai9EbS9BaDRBaHFoWXB2UHYxVVpzbnNkOERQei9y?=
 =?utf-8?B?TW9YbitObndCNEpmcWRYYlpjTHZuMFlqTDhlRWcvNFdCakFYdWxYMjRLQkxq?=
 =?utf-8?B?UjZ6VHlaWUxNOUxDL25OWHVlTVJZczRyMkJQQURjNEV3aU5IT0VESk1ZR0kr?=
 =?utf-8?B?MWlITE9OZlMraWRtelFKRkVBUlNNZFhmSUZYLytXdWR3Mmt6cnlpZ0Ewbisw?=
 =?utf-8?B?QnIyN2hHbXpSbHBGQ1NGLzlvWlF6KyswSDR3blBTZWl2dDNmWGk0VHJaOWlQ?=
 =?utf-8?B?NFdVdjdNazBzbnRrVWlhajExZmF2RFhrRkY1OE5rMFVsWVRuaFRpZnhUNEIw?=
 =?utf-8?B?ZW5jMUxkYjlaTVB2d1dVekRnVUE0Z2ZFRXVpaytibUtNc1hyMDg4TUw1R3dI?=
 =?utf-8?B?VjhsamRTZ1k1dVhsanZUaXU1dHhnN1U4VXlYQ3VwKysyWHkzSmZCaDU2RFNT?=
 =?utf-8?B?ZGI1Vnh3dkM5K2FsQzRMKzlUZy80cjlkZkxtS091VlRVMVlHTkhzTHRmN0M0?=
 =?utf-8?B?OUF6bXUvcngzbFROMzZJM09odWtUWVY1bkFMNWdEbjJTWlkyZXNHK2xTOWxv?=
 =?utf-8?B?SVppOW03Umtza2RJczgxbCswQkFqVUZNeTV3Vm9OMjVXeE9KK284MFVaZDlV?=
 =?utf-8?B?T3JSSG1xeUNvRzd3WkZFOTZlYjFPMG1Ed0lIeW4rSmdsVy91TzRDUXJlYWhk?=
 =?utf-8?B?QzgzWDNGNEdNS2pmcWc3bTJrS3lPcnhYdGMwZ0d0ZDlHTGU2dzhaZXQyK0sz?=
 =?utf-8?B?RjI2dUNYWjBlUURzZjZ0Nkc1cmdJakhTeFYvUHJGdGEwY2pHaHY5WXgwU0py?=
 =?utf-8?B?NXNYR2JtbkpFRTB1NTlKenJTS0kwTkdpL2pIQjVVUWRYVXhKSXdXVUIyQ2do?=
 =?utf-8?Q?jLdNr43+GcFWx5rhOlq+CVFOkT1pZsp1Fg9bo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2VmY2psbnpTdncxZndGVDVyZzI0bTBUR21sdklGRVFpMXFESUwvQzZ6c3pi?=
 =?utf-8?B?OVZYN1VZSSttZjhWOXEzWGFwVFJYa2pITm1LYko4Y3RmS3VpOFhlSDdlQ3Ir?=
 =?utf-8?B?cXRwSDZOcU1HR3REK0xUaDVhVFpxenBLMFlocElrdUorbTZNR2dHMUJDamJD?=
 =?utf-8?B?VVpVU0dPT200S1I3TVdtSSszWFkvbjBvbFByVVc4SC8yOFQycVR3a3JxejlD?=
 =?utf-8?B?eTlRTitscE5KcmppQnhKaWk4NHVxcjdLM29QeUNLTnYwL0l6UnVSYVFPemZk?=
 =?utf-8?B?VVdjRXFxTklkU0lVODVwekVvR0pGWEdFV2Z2QWQ3bkJnMVlaalR0cC9LdDJh?=
 =?utf-8?B?aWIvYzA3OUVmZkFnTHUvMGNySjhBZDNIRzlPS09tYmVlSzF5L1ZhQ1g2YVdl?=
 =?utf-8?B?K0MvVS9kY1ZTbWFTNy80ekVyN3o2RVNCMFkwQmFNaDczcTdQZU84MExuOGkr?=
 =?utf-8?B?eC9SUlh4Z2YycnF2Z0lGSGh3eExYLytUVWNxTldqcHgvWnBZbEdRelRyeUZt?=
 =?utf-8?B?cnRzQUZ2TVl5a1RGaGVYc04vdWdIRkl3WFBZb3duRUhGbENyQWkyUWtCMVBX?=
 =?utf-8?B?MVIyMGJHTlV4WUZ4QjNIdUU1M1QvSHVnUWtyTnlzWWNZSE9NMGkwNW9GY3li?=
 =?utf-8?B?QXdEbjFvbXg1YU05b2pRTTZBOUlOT2szSEdLQ01mTFNhenB1ekI3dldZeHRV?=
 =?utf-8?B?RlZjUlo2U0RVQ3lFbkZjVkR0WEpERld2N21xelZqbnNHNzQ0RXdXWTlKWHJK?=
 =?utf-8?B?aytvd0pVRjRITHpXN2MvZmhpNk91RldVZHpDQWdPUWNiMW5WeGZzUGx5RzFQ?=
 =?utf-8?B?ZVdsV2gzbWwvVjFBOFliUDRDaGJ1V2RPLzB0QlQrU2pXYmI3V0ExOTZGcTJX?=
 =?utf-8?B?dHFBY3dwb0I1V2tYczMzMTUxV0xoaVR4NlhCeDdQdW5BaDROTDlkeWVQbStB?=
 =?utf-8?B?NXpyNzg2L3dpa3BoVC9ZMHQ1d2llL1dSVEdINkNUODFReW1pRlY0aVBla29t?=
 =?utf-8?B?OUxXeWlpbTY3SkJSVGZVbjBPcGNoSVkvS3g2N2ZPNHo0c1c3TUNtNWYzZXJ5?=
 =?utf-8?B?NTYwcnBDbkdzTGdEZUw3NmNYQ0JDNjcxaU4zaTVoVzNwby95NFhpZ3BjNjZr?=
 =?utf-8?B?bzlZR3lFR1lkaGhyeXlEa1ZPTWFWbkJ4VmFoTDAySDJKNzdQdG1XWkIzVDJa?=
 =?utf-8?B?Z1JOUVdNdjMxSzVUenNJTTlpNUFlNVhLaGxrUVRIL01Wa01neXI3Y28zRVJy?=
 =?utf-8?B?UkttZzQ5Rm9ObFpEN1QxT1dDMmdKc1AvUHVZV04xczJpQUNrRUNSdVNka0Ja?=
 =?utf-8?B?Vkk3VzdSTmxVbXpWcmJ5dHF2SzFmUi9yV29oN2hrSGxkVHhsc0lxNmVIUGtJ?=
 =?utf-8?B?V2czalUvYVEvaVdreUNlUHV3OHFqdmlQM01zTDEyRFFXUWFNWEMvSlZMNlcx?=
 =?utf-8?B?Q1BtSUF1ZGVHM0lJNEFUaG84TE83eWZHWE9aM0Qva2U1NTR5VlVIWTdXdm83?=
 =?utf-8?B?WHkySlJUYThlbkVUSlJ0NzJGRzlxYzR5UGpqWW5oTmIzc0tYOTVvMElmUUpo?=
 =?utf-8?B?NlUrU2poUFJBMWx4bHluUFhVNnM2L0RNSnJPUkxQOVAvaFNkY2tLRC8xM2dm?=
 =?utf-8?B?aTk1WUw5cjJ6UE5UT0VsUG9qVHY1V0VXYWplcU12emYzcUI5YTZZdm82L1Zh?=
 =?utf-8?B?K1p6L2RUYm12bWRkWjdySTJCN3EyaWFQd3BaZ2VrdGpYV2VhTUR5TkJ4UGJh?=
 =?utf-8?B?NnZPRHhsbTNWUHQ5KzRJYXhYWjJvQmhPK29RU1lLa0pSakk4cUM0Q3RrRDZa?=
 =?utf-8?B?RXVkM1NpdWJwUlIwajJyc1NmVHBtRkVwOGhuTU1IVXdGTlJLQXFKL045VmVY?=
 =?utf-8?B?Zk90bmxxNFhjT3luZzBaeGNBd1YwZmt3N0svanBBa1FSYmpVMndCRTErZjFT?=
 =?utf-8?B?ZmI5TzNEVVhkUkNwNEtjR0lEWmVIdmJNT0JCdVcvaVZKcWgyUllwMXBKMUpB?=
 =?utf-8?B?dmFWU2N1YTl3a2V0aGxjclBsOFhHV1NqdU9rRXZWMUR5aXZ4Q3kwWU5VbVVu?=
 =?utf-8?B?UVM5ZjR5SUcyWFg2T3V0MWpkaGp1SlAxTlY1dHoyYmNncUNFU0RZVHRYMFpD?=
 =?utf-8?Q?Kzes=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 320ad157-e15e-4652-31ac-08dcfccb1828
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 12:20:39.3550 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EzrhvRXUUMTA82+IpeTP2Bx3Y6OE+VOh7UVF07PV89RJEUjRfiwPr0QfP1C49HvKIP9Gvw2g+tKtb6oqxbxn1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8894
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIDAwLzE3XSAobm8gY292ZXIgc3ViamVjdCkNCj4gDQo+IE9u
IDEwLzE2LzI0IDk6MTcgQU0sIEFsaWNlIEd1byB3cm90ZToNCj4gPiBUaGlzIHBhdGNoIHNldCBh
ZGRzIHRoZSBiYXNpYyBzdXBwb3J0IG9mIGkuTVg5NSBhbmQgaGFzIGJlZW4gdGVzdGVkDQo+IG9u
DQo+ID4gaS5NWDk1IDE5eDE5IEVWSy4NCj4gSSBoYXZlIGEgc29tZXdoYXQgbW9yZSBnZW5lcmlj
IHF1ZXN0aW9uIC0tIGNhbiB3ZSBzdGFydCBVLUJvb3QgU1BMDQo+IGFuZCBVLUJvb3QgZmlyc3Qs
IGFuZCBzdGFydCB0aGUgRUxFL09wVGVlLy4uLiB3aGF0ZXZlciBmaXJtd2FyZXMgQUZURVINCj4g
VS1Cb290IGhhcyBzdGFydGVkLCBzbyB0aGV5IGNhbiBiZSB1cGRhdGVkIGp1c3QgbGlrZSB0aGUg
a2VybmVsIGNhbiBiZQ0KPiB1cGRhdGVkID8NCg0KRUxFIEZpcm13YXJlIHBhY2tlZCBpbiBmbGFz
aC5iaW4gaXMgdXNlZCBieSBST00sIG91dCBvZiBjb250cm9sIG9mDQpTUEwvVS1Cb290Lg0KDQpP
UC1UZWUgaXMgb3B0aW9uYWwsIGJ1dCBpZiBpdCBpcyB0aGVyZSwgaXQgY291bGQgb25seSBiZSBs
b2FkZWQgYnkgU1BMIGFuZA0Ka2lja2VkIGJ5IEFURg0KDQpSZWdhcmRzLA0KUGVuZy4NCg==
