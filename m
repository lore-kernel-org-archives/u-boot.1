Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D18ACFB43F
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 11:23:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 598D5888B2;
	Mon,  7 Oct 2024 13:23:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="nGCFSjmi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93D03888EB; Mon,  7 Oct 2024 13:23:36 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DD858870D
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 13:23:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yG/tfqcNUQAeZlETe6RrRe5FDmMMW/9LQFacnOGbUqLwhsUvreq8ZoHKnB6s6iKoZzAjh1s6K+G3UiSp5f9qrZD75R5+uv/77Ci0ZPw9UC//9+mHju/nE8YfxLRsiPf2iTFyvJsYmp12rjsuOsELOlvh1vuJRLUwCGqj/s2Uz7cVJc8ry3bD7ccz+KbRC66zE59fPCCgH5t0Y4LzbuZe0Yl5HtxoLrP/QPzciceT/diObepUg0VWJVqsk/EPlNMD+Z5FFS/Q34WksmKlii8BAEd7pnVmvoHwkpixlsIXs5ZIq9qX8pxA1ET9gv1RsGnf6HhKy3ol4Ds4fs0dF4duSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MB3eAHMAnG+IyQn/4EDlxlFUG2CsvO1alvUe8APiyLU=;
 b=ZlnFVkghgZvnG/o1Dckx/sAhwfgQMRIMZg93x4vcuSga2vt5gYVIBykoaXYo0gSnoHHmv8n59E0XMprqlT+3CbfLbpyh+n0teIsxIgijsXIstjF9K13HirZQNInwmkPGgtNLNzpCX4VmnhmteCuMN+Gd/tjib13+SoUSU6sPf71aTzNVQZHmV2Q34umzNqgQNPcEcpM+coJtyOgLxeHBr6C/qoS6svrwzuYeRwas8kRS6CQ9hY+sRyn+cOBIIL8GjjtwF/xSQVsxadntral5BmzxgZOWUO+f/+boFXo7Td7XPo+bKIh1mUDNoBWpYUGwNAyjGtPF+gFA2OeOxtf0iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MB3eAHMAnG+IyQn/4EDlxlFUG2CsvO1alvUe8APiyLU=;
 b=nGCFSjmihS4k/rG+HO+nw8AsiEoMzIH7R1L0MardpOaOmshklwpnlWug8+l8k5JV0f4Oh3WXU46/SeEmA77cvIR/jOhswwIOkRQponXvYEk6jCyL/zHpgbJuBzRebjPkWa1DllZOozbDGXtqSQBx6ODeHZXqmw68ijsEaqQf5a3Ly2UUXalwwpLWWrd5x43hEDwOjU5blnnwTxxUrIfZOvNNRGn85DmDHf+/QPf1JpCTURptjPc7o9BZZZcYuPy+9flsRKcav/YjbRnFPHIMbx9Cny0QOT7T5daLN8vU2OxOpnpL/mpqN1ng/cYegEYkoUeXU+xTF/9qDf0mbDKIuA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8893.eurprd04.prod.outlook.com (2603:10a6:102:20c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 11:23:32 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 11:23:32 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, "Alice Guo
 (OSS)" <alice.guo@oss.nxp.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "sbabic@denx.de"
 <sbabic@denx.de>, "festevam@gmail.com" <festevam@gmail.com>, dl-uboot-imx
 <uboot-imx@nxp.com>, "Ross, Fedor" <fedor.ross@ifm.com>, Ye Li
 <ye.li@nxp.com>, "seanga2@gmail.com" <seanga2@gmail.com>, Alice Guo
 <alice.guo@nxp.com>
Subject: RE: [PATCH v1] imx: Kconfig: make IMX8_ROMAPI configurable
Thread-Topic: [PATCH v1] imx: Kconfig: make IMX8_ROMAPI configurable
Thread-Index: AQHbF37kzuMw1Gz0EUuu/Vr5DDF+e7J6PP8AgAASNwCAANfScA==
Date: Mon, 7 Oct 2024 11:23:32 +0000
Message-ID: <PAXPR04MB84599FA214B38FBB3AFF1E4F887D2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241005233116.2781053-1-alice.guo@oss.nxp.com>
 <20241006212332.GQ4737@bill-the-cat>
 <f2f2ff63-e186-4065-8e75-7e0064d16037@denx.de>
In-Reply-To: <f2f2ff63-e186-4065-8e75-7e0064d16037@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PAXPR04MB8893:EE_
x-ms-office365-filtering-correlation-id: ba7b2f6e-dcec-4662-5f01-08dce6c279fb
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?b3ZZNTVQNU03dnhLUlNmU3JOdHNPQTRPc2lsSHZSYU0rRlNpemUwa3RFSkI2?=
 =?utf-8?B?SWcrRkRIZXpiZWU1TGJoak1hVmIzYzV6OXEyOXY1Um5TU05Xb2FKMDE2STMr?=
 =?utf-8?B?UVpid01LV2xLd2h1RENNUDFTdER3YnVONk1RV2NIUHJ4NXF2V1NMZHYxcnRC?=
 =?utf-8?B?cUJqZ1pXMGIycnc2dHFKMlJSbHI4RWw3S1Qyam9pNHdJbFZ4T3pMTEl2ZFJK?=
 =?utf-8?B?cmFuZldFUUFWb0s0UGZIVkQrbmEydTNWSThpQ1d2WU50SEZaaXB4dlA5RFE0?=
 =?utf-8?B?RmlCem9WeElicGx1V0dzZ2N3eVZxZ3ZMY3RwSlVkc1RISitXUS9wRURYdDRG?=
 =?utf-8?B?SDJaUFA0c1pwUStweVlDY2JQTjZKME1aQktIZE0ydzJteHhLdzNpckhJUGRi?=
 =?utf-8?B?RDJNeTJ1MnBjVkNVQnlRbnZNcURhQ1pRZWVteDVzYjA2VG5oM3dUc1RheGc1?=
 =?utf-8?B?V1hXTVc1VmV5Um1FSnBheGxTdU5VQU1IRU9FOUNTVVVFS3JBOEtxOWhYQW1r?=
 =?utf-8?B?a3lrWGFEbzR2bUpxcjNUZzliOGZzdGI0YWpYaVRDa0toRVJhbG9yZnZ1T2RV?=
 =?utf-8?B?NnRseHQ5V2xYckVhTkRxMEZKMDlFd3RuUVBZdk5ScmNHWWhISWpTZU9WdTVF?=
 =?utf-8?B?cHlEZFdzQlJxS2YwaDlsQU5rckZacEowS1c3Wmd4VjFlV1Y4MEhRNVowNlV5?=
 =?utf-8?B?elRReFlhd29mU25JTW95WWE4UnZIc3B3aHJkUVF4NGJjaVJvZVBUVEVqUll2?=
 =?utf-8?B?MS9Qcmo1aG80REt6WXphYVluU0lUeGI3RXVlMjFFRjU1Z3BsMU0zSEdYWlRo?=
 =?utf-8?B?enBzaENtQ2dWWVVXcVJCb0FGUXROdnFzWVh3aEloWUlCdG4vWXRDNjh5ajFm?=
 =?utf-8?B?ZEQra1gzWC9tZHgycXkyc1d6TytOVXYwRUJOUTZCRStmSWxVeHRZMlFrWWtM?=
 =?utf-8?B?eS9UdCtJNWdhaVh2bEpVUWd5aVlieU9LL2FiWlpRa0hYQzJTYjZ2c2I5byta?=
 =?utf-8?B?NEtqSHV6eDREdldZSnVUOThJL3JWUlJ0Nm9wcDg4aHJQS3ovdkhyZlBtYjZ2?=
 =?utf-8?B?c050NkFJTkFwOUd4M0FKYVRucndjMnBmZlY1cGU5SGVaYTFlaG13K2xpRmJs?=
 =?utf-8?B?ZFlhdk9TdDlublBYV3hERFJpM2N5NW85aU01Y3hiOG9IdnFlVnliTEZVYitE?=
 =?utf-8?B?dXNmTDRlTmhCT2Frb3NCZ0lEelIxVEFzNGtXL1RNTFdMVmlUUkFEODlqSlhy?=
 =?utf-8?B?OXFBZENmZXlMeWNmaC9tV2Q3Yy8xK3dpeEp3UEpyWVlnQlFpUmJNY1R2UnFB?=
 =?utf-8?B?Zk5RYnoxa3NhL3hWVTR3ekFMMWMxWndFWHNIcmVhYUZRSFFnQkM5UTA4VDJz?=
 =?utf-8?B?aE1ybWt3OUZkTER2aStNYVk4Qmp4RVE0Rlh5c3drYXRRdWpwekZjck9RUDBI?=
 =?utf-8?B?VEk1eC91emMzL3pPZkQ0QmF0TTd0eG9IckQyWmY3MklsWEdnaGFJVEUxUnRE?=
 =?utf-8?B?ZGJsU0lxcnZxTXI2RmJ3d2JURGdGRk1DSmhtU0NJRzYvblpPRnVkRjhOeEd1?=
 =?utf-8?B?cjdPRG5RNzlWSEVvbGJwdVI4RDdSYzJmdHFUd0RnK0Vka0lJQnZMMEovTHRu?=
 =?utf-8?B?dnFQN3FVSXB0QkNOaldXUWUwOTlTZlVGRWRTUHc4Z0dqMllZQXJWNGlkeEhm?=
 =?utf-8?B?ZkM3dXdRZnJ4YTQ0aVl1bG80T2QzQVEyVkdQRmdQRTA4RUNDK1RSRjZtMThz?=
 =?utf-8?B?RnR6MnNuN3g4WjRLQ21Id2J2S21iNkJ5N0lwck5SN05TRExXUEJUTmVvbXVx?=
 =?utf-8?B?cGQ3VmZQKzJlYllodkFXUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXlITDh0MEJsb2o5Y3RLMTQ3QzNoNE1hMm1NeWdjSCtTZmd4U1VZTmI4YjZZ?=
 =?utf-8?B?elNacFA5UEoxRHFhSEVoNnU3NW8wYktTUHFpN2g0Ulk3dTVhanZaSm5vUUx0?=
 =?utf-8?B?SElMNzdkaFBWYlROcmtYV3RQc3JTRkhoV1pDQjZuSHZIdWZTZytDc0EwbVQ4?=
 =?utf-8?B?SjkxMmY3ZEU4cWdKK1p6WkU3M0hkTSsvMGd3VG0rY2hlU0d6Z2dFckN3YWw0?=
 =?utf-8?B?VDV6Y1laaysrTzBPQjlJRVVwMnB4cTZXSmNvZ282blpvY3JwMWJQNGxWWUZn?=
 =?utf-8?B?UzB4ek1IVGVwVVd4am0rL0dtSXVUQng5ZUJCdDZUZVlDak5KcTZKQkwwQ3RJ?=
 =?utf-8?B?WnZmMUtKYzFoQldqYmk4Qy9NNDk2K2EvWjBVV0NrUDU0aldqNVZkZjJDYWYw?=
 =?utf-8?B?RWlCenFrNEdKb0lHQVpTZVVUWnhwQzhtZ08wUnFnTGxpYVlEZXhUck1WekRM?=
 =?utf-8?B?YXFZQzV1ZEMxNWZSTzMyelRVaE9iQ1NBMDFReEt0ZmRSZVZLY3lvZkd4cG9Q?=
 =?utf-8?B?WGs1MUxnWElNblZnYjRJeGFlbE9QMGJGWk1kMzNYZVFrdStGOHJ0cGpqTE0x?=
 =?utf-8?B?SnhUS2Yxdjc1aUM5UU16dFNaS3dSRkpMa21GTnQzV0w1WmRqRDE4TjEwSEVv?=
 =?utf-8?B?dlpYdEQwRG1GdEhja0dNY2krTjdYZzNlSmZIdVN4WE4yVWZ5SjhTa0lYZ3Fl?=
 =?utf-8?B?RW5pRm1KSGVsR0w2RXZDcGF5YVRQYlZRWTQrZFZ0UElxc2hqWlpncXEwTkpm?=
 =?utf-8?B?eCtnUXB3MU4wV1U4QVNFRzJKekFQakJ1MG1qbTZ1RlZRbU43VVA3Z3JOdXVv?=
 =?utf-8?B?RHpTWG1mTXd0b1Vaajd5b0hFWW8xVXcyTkR5NU9zSkY1YjBXSWM1Mkl3eGZ5?=
 =?utf-8?B?bS9hbUVRa2NOd0tIWU9oWTZYRFF5bFJxVXNtZVN1YXQ0dDFRTWU3WkUvWHZr?=
 =?utf-8?B?MUp5cnV6TjJ6V1RwNU5KQkpMRERVa0NQSndwSG9VcUxxMTJNcWxva0R1U3pV?=
 =?utf-8?B?dWxmWjNUcHNGanBra1JlZnJpcTduK3RyMTc4MGNiY1o5ZnpYaHNxdUxUSWxm?=
 =?utf-8?B?UEJnbGs0WmFYRTIwYzFLWjhRVDNzZVFBcUdUZUJiWHZKM09PU0U1a3M5My9k?=
 =?utf-8?B?emwyU0hJWjRxRmZJNnN1aXJZencvc0gzWE5wRXJwZUZUYzkwSmxLaFhQYysv?=
 =?utf-8?B?b3BpcU0va0dOSDF0eStBc0VGY2hObU55TS9ZdjlOczlwSEdHb200aHRUSm5u?=
 =?utf-8?B?ZDBpUnNNQUxXeG8ySExpSUlQWWZuMFN3eUFVVE9BVGF3cmxKNUFyajcyaVB6?=
 =?utf-8?B?djd1YnJhWUl6b1paajhVeXJyR0lNREZnZHdnc01vYkova1M4TUlLNlZ0QUlV?=
 =?utf-8?B?RWFYVXRRRURycHpCOGc3djZPK2FNYXdESmhLeXQwT1JYbkgySERSYWVjMWI1?=
 =?utf-8?B?VGtoZ0tGMncxWVp4cTlYVGZCVFBaVzdVdmtvU1V2OHUzZEhiM2JsQVEyV0Iz?=
 =?utf-8?B?d09ySUZselNEMkF6WWxKdS93M2Z6WTRsWmxHZHIyaUJJc1ZjYVJlZFpOa1Np?=
 =?utf-8?B?am0wR3BRaUlycCt1bkNsUUc1anJjQmRkVGJWVlRWTWhHMXFhZWNFdEVsNDVh?=
 =?utf-8?B?WGQ5dlRyVllyL0t4bnZpQW9rSnIvdEVTZnVZdjhMVnp5V09RYVVLL2FpRGxj?=
 =?utf-8?B?a2dVYjhDUnNOQ1JvQ0dFaGZZMjdOQnBWQjV3ZXpjb2ZQTldXUzFsbHhPbWc4?=
 =?utf-8?B?Rm1UQ0lpeG5oSGo5N2JxWHJFODVxT0pDZmxoVnpFYllUYUVhWmZNcXlaazZq?=
 =?utf-8?B?R2tpT3MzR1hXcW1jRHZvMHRhdFNzZU9CYlVsK2hTa05ZdlhuUWtpVlpFNm92?=
 =?utf-8?B?OFlzVll3SmdKWks3S25vcHVVS0MxUDJNT0ltbnZaTFZQRjFud3ZZTHFMTFhz?=
 =?utf-8?B?bEZuOXpzdVRJT2JtV3hGaDZPNGdISzNYT0plOEJTQ3BYaXk1eFQrY21VUml3?=
 =?utf-8?B?SDJpVkxZY0d2TTFuSDF2bUtHZ0hDMVZqUG9QVWc5WFpxUUljT25IeVFaZW9j?=
 =?utf-8?B?dUx2UUhEeGpjSDZWR294SmcvU2FKQ2Jxbmp4cFlDMWttLzFCWTZuRzZMWld2?=
 =?utf-8?Q?lq1U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba7b2f6e-dcec-4662-5f01-08dce6c279fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2024 11:23:32.4087 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9lMXQbQnKDbdq9q0s7T9GtSkNk8wJpEIGUOHNa/EgxCycwHTSGnRvR1RaNGsileSVi/y7mzunEOUqQUpAYomBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8893
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

SGkgTWFyZWssDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MV0gaW14OiBLY29uZmlnOiBtYWtl
IElNWDhfUk9NQVBJDQo+IGNvbmZpZ3VyYWJsZQ0KPiANCj4gT24gMTAvNi8yNCAxMToyMyBQTSwg
VG9tIFJpbmkgd3JvdGU6DQo+ID4gT24gU3VuLCBPY3QgMDYsIDIwMjQgYXQgMDc6MzE6MTZBTSAr
MDgwMCwgYWxpY2UuZ3VvQG9zcy5ueHAuY29tDQo+IHdyb3RlOg0KPiA+DQo+ID4+IEZyb206IFBl
bmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+Pg0KPiA+PiBNYWtlIENPTkZJR19JTVg4X1JP
TUFQSSBjb3VsZCBiZSBjb25maWd1cmVkIGluIGRlZmNvbmZpZy4NCj4gPj4NCj4gPj4gU2lnbmVk
LW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4+IFNpZ25lZC1vZmYtYnk6
IEFsaWNlIEd1byA8YWxpY2UuZ3VvQG54cC5jb20+DQo+ID4+IFJldmlld2VkLWJ5OiBZZSBMaSA8
eWUubGlAbnhwLmNvbT4NCj4gPj4gLS0tDQo+ID4+ICAgYXJjaC9hcm0vbWFjaC1pbXgvS2NvbmZp
ZyB8IDMgKystDQo+ID4+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1pbXgvS2NvbmZp
ZyBiL2FyY2gvYXJtL21hY2gtDQo+IGlteC9LY29uZmlnDQo+ID4+IGluZGV4IDEzNGU0MjAyOGMu
LjlkM2FhZmQyZjggMTAwNjQ0DQo+ID4+IC0tLSBhL2FyY2gvYXJtL21hY2gtaW14L0tjb25maWcN
Cj4gPj4gKysrIGIvYXJjaC9hcm0vbWFjaC1pbXgvS2NvbmZpZw0KPiA+PiBAQCAtMTc5LDcgKzE3
OSw4IEBAIGNvbmZpZyBERFJNQ19WRjYxMF9DQUxJQlJBVElPTg0KPiA+PiAgIAkgIHRoZSBkZHJt
Y19jcl9zZXR0aW5nIG9uIHJlbGV2YW50IGJvYXJkIGZpbGUuDQo+ID4+DQo+ID4+ICAgY29uZmln
IElNWDhfUk9NQVBJDQo+ID4+IC0JZGVmX2Jvb2wgeQ0KPiA+PiArCWJvb2wgIkVuYWJsZSBpLk1Y
IFJPTUFQSSINCj4gPj4gKwlkZWZhdWx0IHkNCj4gPj4gICAJZGVwZW5kcyBvbiBJTVg4TU4gfHwg
SU1YOE1QIHx8IElNWDhVTFAgfHwgSU1YOQ0KPiA+DQo+ID4gU2luY2UgdGhlcmUncyBubyBoZWxw
IGhlcmUsIGlzIHRoaXMgdHJ1bHkgY29uZmlndXJhYmxlLCBvciBpcyB0aGlzDQo+ID4gc29tZXRo
aW5nIHRoYXQgc2hvdWxkIGJlIHNlbGVjdCdkIGJhc2VkIG9uIHRoZSBTb0MgYW5kIHByZXN1bWFi
bHkNCj4gc29tZQ0KPiA+IG9mIHRoZSBuZXdlciBJTVg5IHBhcnRzIGNhbm5vdCB1c2UgdGhpcz8N
Cj4gSSBjYW4gaW1hZ2luZSB0aGUgTVg5NSBjYWxscyBpbnRvIHRoaXMgY3VzdG9tIEVMRSBmaXJt
d2FyZSBzdHVmZg0KPiBpbnN0ZWFkIG9mIFJPTUFQSSA/DQoNClRydWUuIGkuTVg5NSBBNTUgY29k
ZSBubyBuZWVkIFJPTUFQSS4NCg0KQnV0IGl0IGlzIHN0aWxsIGdvb2QgdG8gbWFrZSB0aGlzIG9w
dGlvbiBjb25maWd1cmFibGUsIGJlY2F1c2UgdGhlcmUNCmlzIGNhc2UgdGhhdCBwZW9wbGUgbm8g
bmVlZCByb21hcGkuDQoNClJlZ2FyZHMsDQpQZW5nLg0K
