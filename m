Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1351F531FA
	for <u-boot@archiver.kernel.org>; Tue, 14 Apr 2026 07:43:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4209F84132;
	Tue, 14 Apr 2026 09:43:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="e1ij2Mc/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B510C838BB; Tue, 14 Apr 2026 09:43:14 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3E09838BB
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 09:43:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UcGlgl4s0suZWGiWxhMpcp4vcJSXMOjCQ2mdBcR8SePNEYxXRJe5hZMD0f/VRdJy4uZmLEadtwVkELZDAFzaMmE09n4QeMNiuxcX+9DehThBBZ5a7sEXK0qje10iYeI2h7SF18HetN59KgYNBYu1IFEPBSvqAE78aX0xubimgui1ScMfYCxpi3NRRbpLCNppSkucbmZClDaMNikaEMcZmQ5N7d1JUjr/wymzjlcxQFPwbNks91CFyK2iJpmJV1iTUCjelt7UtH0GxJBSaj/xYwuJKVvQZfJfdEmcKtx8cHYTKBW+X6SR8FdXrguu2iJHKSC38C1cUeC/fUAfKuKPxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idvdatVu6IqfFHp5OYvdHX5LOHyiqEMd4X2gWSlE/zM=;
 b=hjnlZYvsFMncgQNWKtV+WQxZp3tDX6pG2L81AthfHmofj7VqSpRF6jk2qpt8R6Z3HcAZsXeB7CX2XizrFuP4eiKftRwNYPQT0zz5+2Yqkcu/3V3ssqDhVb6RREJZATm4hX8nYrvn0nujRFpmAJw9XmpM4zuWIVWBYoYIAXVA9M4kOSXKLyKZdMAHc1sqQDBJHq4WXBJIKcpUDYgtiyC5v0fbLn4VsVVIVnOxJi59UwwvdUy5bjS51AIA7o/r/xfChYbS/Pe5XIS/fL1UVDP0vWDVBXoSM12qBPZSK44g8a3lxe/+WnQLpbXO86mCf7ssK3LSWIKQPKfB5vehoStmTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idvdatVu6IqfFHp5OYvdHX5LOHyiqEMd4X2gWSlE/zM=;
 b=e1ij2Mc/KSf8/A5aVLH2v+oiPRSyaewnpzPgGhDrTXWuIxSnt4mzOifIrZY1qTt8IjpdTckoA7CJthRfXgOe6pamJi1y1gglIAoDKq8dNR6uRE9yXFq4o0HFoiJoNwoaXWXNos51zNslGoDbSD5UyzmIj26KzC58oo4Vwa7fTVVex1L1++N2Ui2egxuK+5uNMFwtfSIFtkzNNpD5L3tEuHDU47T74TXnW0H7hS3Km9JpNz7ORLkWaD18rRAimuZCzeevo7sxCQQK9mwIcwwnNybU5wgPOIkw5bJMIJaO21doiCj1Ax5cpGDE2IhqoZ3YP71H9Wm0AT/jo+XJbTa8MA==
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by SJ0PR03MB5951.namprd03.prod.outlook.com (2603:10b6:a03:2de::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 07:43:09 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53%7]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 07:43:09 +0000
From: "NG, BOON KHAI" <boon.khai.ng@altera.com>
To: U-boot Openlist <u-boot@lists.denx.de>, "Chee, Tien Fong"
 <tien.fong.chee@altera.com>
CC: Alice Guo <alice.guo@nxp.com>, "YUSLAIMI, ALIF ZAKUAN"
 <alif.zakuan.yuslaimi@altera.com>, Anshul Dalal <anshuld@ti.com>, Casey
 Connolly <casey.connolly@linaro.org>, Christian Marangi
 <ansuelsmth@gmail.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Neil
 Armstrong <neil.armstrong@linaro.org>, Quentin Schulz
 <quentin.schulz@cherry.de>, Rayagonda Kokatanur
 <rayagonda.kokatanur@broadcom.com>, Tien Fong Chee
 <tien.fong.chee@intel.com>, Tingting Meng <tingting.meng@altera.com>, Tom
 Rini <trini@konsulko.com>
Subject: Re: [PATCH v1] drivers: clk: agilex5: Setting correct counter
 frequency in boot mode
Thread-Topic: [PATCH v1] drivers: clk: agilex5: Setting correct counter
 frequency in boot mode
Thread-Index: AQHcpW2LtDCy5TjkN0WZCDXEq0KpRLXeeX/N
Date: Tue, 14 Apr 2026 07:43:09 +0000
Message-ID: <SA3PR03MB718727B42ADF86B94EA4D3EAB4252@SA3PR03MB7187.namprd03.prod.outlook.com>
References: <20260224091109.8181-1-boon.khai.ng@altera.com>
In-Reply-To: <20260224091109.8181-1-boon.khai.ng@altera.com>
Accept-Language: en-MY, en-US
Content-Language: en-MY
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR03MB7187:EE_|SJ0PR03MB5951:EE_
x-ms-office365-filtering-correlation-id: f76667cd-f61f-4ef5-4967-08de99f9797b
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700021|18002099003|18092099006|22082099003|56012099003|55112099003;
x-microsoft-antispam-message-info: DsOOQzQQb78qL3AAC0JaudXhtrVEiwfdblJ0oQN/UNyPoZGoWbm7E2KZah7WAhLn9kt5neY+DPtRoM5WZCJ9hyy0Wub4rVQaup5UhrV2TyWm9Vm3y2cZlNINZQFcr/Fa/QmeJteMFJn2TXyRqdCuN0RgaCoNg8kfyVMdvh42fFJgz7mBElUoQ19C7wZ2BPAhOmDHDQWVogM7NdrNkMAcW0PEnqhF/xVeFYCpdOYLlPqnhI3aGb32g4gfrSn4yZUB+ZnfzRh4XH8ekRvHTMc4E2rKvVhmrEjpFjfvu623pazw0ueJNkVoO/ryrGGAm8AEuM/IzdFhQ94iZ2PFm+7xgK3DTC6Fu/7qKvQ7y+UjkRELGm+A1S1ICaOscQG2OmPqp3/xe8z+JLxIn/Ephsc0CH6kgSRZFDcF9ZRYji3fP3dZfGW+AMcLxDpixPG0tJeKiNiTkYn9xDcxaIRmab65gKdBR93++7VTItPuQUA7p7npt888eIreIwmXSyFimcLTtJ0IrhhhAOKZdokM6QCa1HuEksbWTo16cAdaClyKnDkCNRSF3PXPB867Bvpzfp9e00XCSwiFHPXe+7n5dxSymRYPvZvjh5YGFKnaC8+ohXh1lKE4z2GDFU28uA/k1a6Lknvvx/BpS1ugC1+0o7qofpTkiEo0sNEYjuDLOLXPRw7yKD7dhCpkazleX8CWsQlOKM5cGRIbDhsSYvqkBSuJafcGsbZEOp5n/vgsS1z2/aJ9FFHY5I4AJzJ7TxqruRSXz0oycc0heU/Gi+GZmRs/Owy0iODCjZTwpHYfu2TxADs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(18002099003)(18092099006)(22082099003)(56012099003)(55112099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?z33QuVJ17XYbQ6Ass9e3hH0CHCiRC0Ia9dBYCaLEExZmcBvoqoFegF7JO4?=
 =?iso-8859-1?Q?0yQ2y97V+qshSOXSUgNoWG0I13cXZp3gnjC7oEkkdOBRuiONa1a9dH7FTK?=
 =?iso-8859-1?Q?EglzGoscA0IfgmONBd4Ru1M80BeAg1dRMcSRQYEYMH2CoeTLhPl/9+tiZ2?=
 =?iso-8859-1?Q?FoKGaOhypOyvAzwGXx82v8KNIK0gu9sPq0e9kYgP/hHDIMPCkwz/ykKPsD?=
 =?iso-8859-1?Q?Izh85/1IfIdbemZuukoK2XCQ4yoiIxfiCO1eesN/YS1Uv0/Zb2qwBE0qNa?=
 =?iso-8859-1?Q?XHJIvTn7GiOEM7LF+b+1eOdeim29b+Jah1RQC6QhrD5wKVPiQVuw6iVZUZ?=
 =?iso-8859-1?Q?4KwGqOiA4p+u/H4tMLeeOiDeVtk86IOwaTrRQKHmFF7Qn2oPh63V2470mO?=
 =?iso-8859-1?Q?bsSYONQlq3GPlwNXhMqX67HSjayEYLouKIyedF2/6mSN09pRaQjR4Sxale?=
 =?iso-8859-1?Q?cBwr/CGPX4F+AwvUcz9hKVre6PDmbIsAcZcEKXCjtyNK45Yh9RqMLWZgCn?=
 =?iso-8859-1?Q?P7iRtiFf/SruAj+SBn3scoyzAgTsNZWiKBjhwVAQAnU1y+IotciVSanp28?=
 =?iso-8859-1?Q?ztEsXSAah1UFooR7ZTnBv8799l0KL22XbhhDLZO9H2VP/O8dYhDcoLSOab?=
 =?iso-8859-1?Q?l8f2IlYd93twm0n2RZI+ivfj2AmzkwUZSjBz0I6lJwlaYkjj1O0jQ1cZvK?=
 =?iso-8859-1?Q?wWJRTeIpxzSD3aUigTnJIGSCyzXXBlZB+be7Q8QqWLdYmUmExr3DO6tZIB?=
 =?iso-8859-1?Q?vgJRJPj/d0KR/UfzxUCCk5eFxTLNH5jaPU8jobh4IeuOJ4WL7Xk7a69EfT?=
 =?iso-8859-1?Q?xJXu9wctls1F3siM6RE8dRdNoGohNnUSJJaiGp6ZwPnhGqj03yJIAg5+li?=
 =?iso-8859-1?Q?f8jB/QNeQvOI5mO4ywcKvXKbuPMTVYBMGSCo/CIGt8VsdeALQc8ZpKtWRr?=
 =?iso-8859-1?Q?/TByJYX6fiCiuxSf8JBPZPjCg9OT4ghVzPMlgxr7/yIStj84vDUrKyUmbp?=
 =?iso-8859-1?Q?TLtn2Rj9xmKbqB6aE7ZzPEIjfxpeR/7Yk84pXiTqGzKu6KlOevDtOmAPoF?=
 =?iso-8859-1?Q?J11lw7o+0LcwvDH1gPBHiOUvKzNb8rEabhQfY3mNNogKaw9+ET9hhtbZ5K?=
 =?iso-8859-1?Q?TPHBE09cPwHdEkF4ceOpdAyjSUjLGaxmAGHzGIe84guuXTnOdiaqmfHk3U?=
 =?iso-8859-1?Q?x22pLcD7fHH0xTLCTRSLcgcY/J7nzAooaBzddvQbvkKCp8G1qUGDZ4hcJO?=
 =?iso-8859-1?Q?VaTdeX2rptRYsCt3VGqdwRkkz8MPWpfuFScI4sEjbvdOrj4mqRjYV05OM+?=
 =?iso-8859-1?Q?TY8DfRH+R5z25CTqL38AKZxQtTI/WI/qxtb5YtEYZRW70SfOd0qqulaBao?=
 =?iso-8859-1?Q?INrJX4HFHa99Y8kmeFw3aCiQaME8+1pk7o68qKWtfoegMce/tYhFWC1pOo?=
 =?iso-8859-1?Q?D8lPN38e3NuiOH5WgQIJt26j/eAOTOytzy8s/0o5BUpJxYIsUcpsDRF1y5?=
 =?iso-8859-1?Q?DM+Jl5ZexvRFOWKiylVBu8dFUFRtAoabU+aCVtRaAQZeqijduTG4iAq4Ox?=
 =?iso-8859-1?Q?4IWzZbDbhGXZ3ex0j1juEsbVuIKJGKCoMcr8oFHsf0K07LJobwsct20V31?=
 =?iso-8859-1?Q?rVKmkgH/CAPxeVWaL2Y6F+hLMZTkIHTeLEjriq9gaf1D/ikyv6Nytd2mon?=
 =?iso-8859-1?Q?KFLAAgoKJv00kTSM8eNqgWz29TWr/9qxVAd81BMzbJCDcT8hNnnCZGJ2ao?=
 =?iso-8859-1?Q?iLCXXwX64YjWSnRoiN6/ymnk7x64bh/b4/LTzW1jhINF5OSh1lcks3UhZK?=
 =?iso-8859-1?Q?e44sKQgTHA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f76667cd-f61f-4ef5-4967-08de99f9797b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 07:43:09.6842 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: siJbikntztud2QNZLLXoYfjslVaQdWYpN3gVat/TcCFhYIS+/Ddmaabikas8DC2luVY9nu1uJpt3I7nRnA2RJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5951
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

Re-add Tien Fong's Altera Email, with the patch's content.=0A=
=0A=
> =0A=
> =A0=0A=
> From: Tien Fong Chee <tien.fong.chee@intel.com>=0A=
> =0A=
> Counter frequency need to be set in 200Mhz when system in boot mode.=0A=
> 400Mhz need to be set when system exit the boot mode with the PLL=0A=
> generating the high frequency clock set by user.=0A=
> =0A=
> Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>=0A=
> Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>=0A=
> ---=0A=
> =A0arch/arm/Kconfig | 1 +=0A=
> =A01 file changed, 1 insertion(+)=0A=
> =0A=
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig=0A=
> index 5508fce796a..4cc42ca393b 100644=0A=
> --- a/arch/arm/Kconfig=0A=
> +++ b/arch/arm/Kconfig=0A=
> @@ -30,6 +30,7 @@ config COUNTER_FREQUENCY=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
ROCKCHIP_RK3288 || ROCKCHIP_RK322X || ROCKCHIP_RK3036=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 default 25000000 if ARCH_LX2160A || ARCH_LX2162A=
 || ARCH_LS1088A=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 default 100000000 if ARCH_ZYNQMP=0A=
> +=A0=A0=A0=A0=A0=A0 default 400000000 if ARCH_SOCFPGA && ARM64 && !TARGET=
_SOCFPGA_AGILEX5=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 default 200000000 if ARCH_SOCFPGA_AGILEX5 || ARC=
H_SOCFPGA_AGILEX7M=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 default 0=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 help=0A=
> --=0A=
> 2.43.7=0A=
> =
