Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DDF6F531F1
	for <u-boot@archiver.kernel.org>; Tue, 14 Apr 2026 07:33:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87CF184119;
	Tue, 14 Apr 2026 09:32:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="ov400RQ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0644F84132; Tue, 14 Apr 2026 09:32:59 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB2FE838BB
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 09:32:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oWT+Y/4nJu6a5RIbnYTp4a9/ruEWvIyKPFjEacz3PkKl2aVhFkbIxD5d2gXhUIEwaK44917PXm3KgwVUpBH+47umr6YhntIO4bpPAMZGtCg/ivbLZWoqE1/tZ88GgKin55DgJakuMeQNYgmw8mi/0ihwoQarw1vEi9Gu/HVNNJJYY1cdIrqP10IWgoiWXeZ6OX+Gphs1kDpfm/DwDBahEoNQrGAKULjHsqyc0MrxdyP4DhzDJI0YuMNhQ2RWyF1LSfrlUyBbf/nEQ6KfzRFQDLW+smPTvslq0+Y+Plr+ZOXeaiJO2UKoXR/jCAz0btU//iBM3tBPwNdZcccmp64sgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tt29KDLypbFBb15p4ScjFMak33krEx7NuFO1oo2pew4=;
 b=kr4lq3k8pwtoUWBPGfZn6am12TEauYBndnpbC7ABAbc+r+E4o3hi8zepRMjsZvB1Lh/2jOwz+6MAUGe1LROA64Hai2GCt+KCfR13h01Y+6hxp6WHxjZ6zJh1JfbRHVe95Z58N8SaLFBZ32bHB52PW1SSedMTejs6J8Mdv/s994uw7HgNsl5I8zNQ4DGxVcKL1IM1F3q2Jfz8bbK4h/9iB+S3pU4qayASFg7abBEcbLvgpdlKPK39IJSMONzQ+gOHMcFZUihi5VZt1p7lH31bEs+tj1jgPszupxLevc7pzG642xwG/16zDPkqDLvFrkgnJaSL/Qo5Vklrc+bDYx1JXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tt29KDLypbFBb15p4ScjFMak33krEx7NuFO1oo2pew4=;
 b=ov400RQ4xaaADIys4X37MsSm2kBFNfdRzs1FQBdKA0j9TrwYpnwDpjf45cSt6PzehiC8dAliWABSuwccrXfDFEmfiwUdNJHoLc4pebRmLrlD3BgjQdXFTCSKAkBIwH9QwswkiU+sPD6C9zfS9kazlGpdBtYRS9eIPwSvbmJavGvQebKSPD4hmahBU9QBL2JhObhDzBlmuWGaqa+lNYevDOu+kWcKfhYKELakWIbE+VhmxObT6m6e1c/C9g7DZk8X4AUF6Q/0YmRrZAEADsf8/EKwf+GO0t82hENZHPBi9zoBtF7sUDMHj/hHmPS9tbomEoqMXQA4kuI0fWQMcLKI2A==
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by LV3PR03MB7635.namprd03.prod.outlook.com (2603:10b6:408:284::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 07:32:53 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0%6]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 07:32:52 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "NG, BOON KHAI" <boon.khai.ng@altera.com>, U-boot Openlist
 <u-boot@lists.denx.de>
CC: "YUSLAIMI, ALIF ZAKUAN" <alif.zakuan.yuslaimi@altera.com>, "MANIYAM,
 DINESH" <dinesh.maniyam@altera.com>, Lukasz Majewski <lukma@denx.de>, Naresh
 Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>, Tom Rini
 <trini@konsulko.com>, "LOK, CHEN HUEI" <chen.huei.lok@altera.com>, "Hea, Kok
 Kiang" <kok.kiang.hea@altera.com>
Subject: Re: [PATCH v1] clk: altera: agilex: Update sync to async mode config
 in clk pll
Thread-Topic: [PATCH v1] clk: altera: agilex: Update sync to async mode config
 in clk pll
Thread-Index: AQHcpjtukGLC4H/GK0qXRnwpVZrn3LXedS8D
Date: Tue, 14 Apr 2026 07:32:52 +0000
Message-ID: <CY1PR03MB8121AB143DE8EB7384783FC2A7252@CY1PR03MB8121.namprd03.prod.outlook.com>
References: <20260225094453.33673-1-boon.khai.ng@altera.com>
In-Reply-To: <20260225094453.33673-1-boon.khai.ng@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY1PR03MB8121:EE_|LV3PR03MB7635:EE_
x-ms-office365-filtering-correlation-id: 704ed0fd-c183-427e-4cbf-08de99f809bc
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|22082099003|18002099003|55112099003|38070700021;
x-microsoft-antispam-message-info: gK17RMNPD5IPd7eiKLV3ulirQteNnG9sqXyOXuEaHCM90V3cq199OIv4OyKKY/MwraH8NYYgOP7ULxYN2+MEZrT7s/5cgQ4/fi+na0xuVnob29UW/+BGMkwm/w7vX1anjkibK7ZciwzBWeYmzlBgTrMVuFr9+tT0NIycmmDDq6GNuubZc4MvXCsAbDEU8m6Jy75/2Bdkl0/Cxf64YLYrtaCv01o5BBOFoHmW92P4AqGqgqdW0mLHwjCMxCU9v4ahuyMM4lza9e1ToY9cQVJmA1Ren2fWBWg8yKaKkWmUbNuitQhUkzvDGjl7h9kb/fAzcRnojkSnPCZtqorTHIKGFh+htQ1dvEGsLY26sgK+ap4uXBoGlc0c2l4vbvoXMnAOX791GNDLxCoTlL9ohh8vzpo4HCKNYcCZUf2T2MZCTROdXBciMH7chJfCGZnS6BnW0MgmB7othofri3xtTfx7ahlf7cSaqal+IRz5HYXoyrDuTx3pA3i3RNHyjcfpVOKfgUnd/AIW+k7Gw5iNskq2nD1/E8rUa8aZYvbhX+6ICP0vVcDUHS8Wu0eY5IKzkqVLuH5rVyhh4t909CC3NFDNXdQzf18mZRPTffth/XSWKtLayKZ4UBbYxLoZ0YmfmsXL1CkWVByzIAJxjv+kV9VWm6zkcm2ghXEz7bfVhw7qsoCb+xgQjXiZoFT9ok8P7rnYXsG2HbQH0ktMKF4DnIz4PQdBKeVKltVVA0A0Z7/C9s1ECWl+rTeO/G1zDE59Vv3G2oYsYRzCzQof+at8P3p9XDu3l0FPiefWjUNkRTkRUG8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(55112099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?d/NiQQ/sprsxMXRI+TFnZ2HBRZHQBJPkM4DfclPKToRyHwcMd1VYamCbKt?=
 =?iso-8859-1?Q?nilPCM99zhKPUYHLI/04u7eYjtQQFkLTkneKFaWrJad3SqPLT5oRxEibsQ?=
 =?iso-8859-1?Q?25f3UpbjvDB188pqB/bWLloadocO9BxlM5S6SrJhqkRAIxy5ihA/sqPST9?=
 =?iso-8859-1?Q?HL59c/Ysq61NFraohLjw2ULcSdNucnyA74yISQtRYYoaDMAz8y4XgqtQSS?=
 =?iso-8859-1?Q?XlB8YZhoenDDaJjnkeWFE3SD5X9O/kKxSZ2BCTON2PjnypLsS95V8wY2ps?=
 =?iso-8859-1?Q?UvB6BmSH1qXIGQdBXGukebJQI0O1CHOStv4vwDybHwmmXWjh/0gLXflEeO?=
 =?iso-8859-1?Q?RFtGlaDGNdEqCPZ4BoxMzNd7TpQ5lvRUb4dPSNnHBD9889oJy084u1r0qO?=
 =?iso-8859-1?Q?WUFODC8Aj+EDqpU8S1zTl51EpaHCpEnw4XUFVYGlcemgYmxdZgNzHulVSG?=
 =?iso-8859-1?Q?kJ8V1XOXkm6ITEUE0gU+ZWDZJvOr0NLR8d/CMMtqXITwAJRcLafMM/sTD3?=
 =?iso-8859-1?Q?QJ/QDF/CnvYZ7HmPmfEiVJLb38lMWqjyoqZjMnJxkHeh+MXvh4cfVpsl4f?=
 =?iso-8859-1?Q?3OkArzM2ptqFezqEOByzqOO7qelMrQ8FTRBBp12AUxh5B0km1OLHn3lpiv?=
 =?iso-8859-1?Q?hImVqb8P/VQJtAi1BJdUX4LsBT7byEQHzZRs6Nb6hSE+IV594bBPIru9D6?=
 =?iso-8859-1?Q?xwqL96t10Qh/HmOIywMNNdjUExUptW7ZcNWXgO8VCXnpbso8QWcvYMMfdu?=
 =?iso-8859-1?Q?T3+3SZL05WK2+vDz8JGzbDUEoz6QUSG4OAtDwIGSWfFxK7Wdxupv74QUEh?=
 =?iso-8859-1?Q?qsuMbjw/0kpqeqG0f9eqruRdjC7sATfZHMJL+OErQ3YEfZAx7kjqWjo7b8?=
 =?iso-8859-1?Q?DRJzzJctFYy/6LXHsqYO1I7sZxpG2bi6Z6pqMJ/rXluEX/QBxU7SVInFEf?=
 =?iso-8859-1?Q?b4I0ReLtnl2xQqJX0uNdVmhJWHYwxa3WMIciSbDgqTfPXfV42gYHO4Bl71?=
 =?iso-8859-1?Q?lJK2uNxHUIZfPF6HACxcmTrH42Mtlt6qyTJiThZUCWHXu1E66PCWFm5OkB?=
 =?iso-8859-1?Q?il5NvoTQNeslbdio6pgdR9zhJt9p7y2f/3Z8xxIy7vUMQ0YesWvm3gfJYD?=
 =?iso-8859-1?Q?HIrGWIKsWZs+9l0eSQkLsY9XX0zbRwDUOzHUl0e1g4ElPxYtgE4jGcjOhW?=
 =?iso-8859-1?Q?B4SRg9iBZWG8ziz4qkEdif2tYkYkr05wZBE1xWOYDtGkwV2t2GkwJR8aBP?=
 =?iso-8859-1?Q?6dLYOh18H8S/aWs+4PL1UCwYxmwwM0+T/2A/pCB7zJQOv+s+lWZ0JEOvOq?=
 =?iso-8859-1?Q?CKwTHzp4/d1ELxzFGS8grTmncH25x0Fv+ppTX1dv2Lk5I/uh5INfjibgNm?=
 =?iso-8859-1?Q?uHlDkN4ZnryYFf1mxGa4YKXJaj0Ub74JduAUW0ny+oVIUj0c+68l5evmX3?=
 =?iso-8859-1?Q?UE7Ke/SijwY42m45tdEzFass5lbFlPToIypFPO3Vxjss83C3xlqfP+Uxw8?=
 =?iso-8859-1?Q?d+K6/mZiQx3qHtty5HqJMwT8oKuY3+iZhOLomIqp0FcgLQ8KWySNEYM0hk?=
 =?iso-8859-1?Q?OWsJT64b8rAvosK8XJD7fzVkWVxe6X7tL6nFJGXmlE7zJWfY57BiFSjyf5?=
 =?iso-8859-1?Q?/AzWgS5V+oWn6LCKeKBDW9ZjAfzVLNi428iIICqZ+nTVx7wbSwmiHfQbxM?=
 =?iso-8859-1?Q?6AGCr+TLuSDgHivE3PQswdSja0heR2x8dT6qoiA9/DqeLWs2DNl+hb8cvA?=
 =?iso-8859-1?Q?AZZgDYaOtsYFvyZib4mPk7jdtC2lBVdaSQTc8Vi9m+RPFKzkozAYJeh4FO?=
 =?iso-8859-1?Q?wM7ZxbVaCA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 704ed0fd-c183-427e-4cbf-08de99f809bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 07:32:52.5076 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: viB2xs67i2QF2pioKtmyJmVaWsD7x1XwvBosnXvZQljVz9FV4HUT7YXcinTmfCArymQVXvCjdJtgfJSKckFEDlB9uIjd7WezVaP/5+v14uc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR03MB7635
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

> From:=A0Ng, Boon Khai <boon.khai.ng@altera.com>=0A=
> Sent:=A0Wednesday, February 25, 2026 5:44 PM=0A=
> To:=A0U-boot Openlist <u-boot@lists.denx.de>=0A=
> Cc:=A0Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>; Maniyam, D=
inesh=0A=
> <dinesh.maniyam@altera.com>; Lukasz Majewski <lukma@denx.de>; Naresh Kuma=
r=0A=
> Ravulapalli <nareshkumar.ravulapalli@altera.com>; Patrice Chotard=0A=
> <patrice.chotard@foss.st.com>; Peng Fan <peng.fan@nxp.com>; Chee, Tien Fo=
ng=0A=
> <tien.fong.chee@altera.com>; Tom Rini <trini@konsulko.com>; Ng, Boon Khai=
=0A=
> <boon.khai.ng@altera.com>; Lok, Chen Huei <chen.huei.lok@altera.com>; Hea=
, Kok=0A=
> Kiang <kok.kiang.hea@altera.com>=0A=
> Subject:=A0[PATCH v1] clk: altera: agilex: Update sync to async mode conf=
ig in=0A=
> clk pll=0A=
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>=0A=
> Remove MEMBUS_CLKSLICE_REG source synchronous mode configuration to run=
=0A=
> as source asynchronous mode.=0A=
> Switching the HPS PLL to async mode improves resistance to clock=0A=
> marginality issues such as F2S clk to HPS PLL=0A=
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>=0A=
> Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>=0A=
> ---=0A=
> =A0drivers/clk/altera/clk-agilex.c | 9 ---------=0A=
> =A01 file changed, 9 deletions(-)=0A=
> diff --git a/drivers/clk/altera/clk-agilex.c b/drivers/clk/altera/clk-agi=
lex.c=0A=
> index b793dbf6a42..426f400159c 100644=0A=
> --- a/drivers/clk/altera/clk-agilex.c=0A=
> +++ b/drivers/clk/altera/clk-agilex.c=0A=
> @@ -74,15 +74,6 @@ static const struct {=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 u32 val;=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 u32 mask;=0A=
> =A0} membus_pll[] =3D {=0A=
> -=A0=A0=A0=A0=A0=A0 {=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MEMBUS_CLKSLICE_REG,=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * BIT[7:7]=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * Enable source synchronou=
s mode=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 BIT(7),=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 BIT(7)=0A=
> -=A0=A0=A0=A0=A0=A0 },=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 {=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MEMBUS_SYNTHCALFOSC_INIT=
_CENTERFREQ_REG,=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*=0A=
> --=0A=
> 2.43.7=0A=
=0A=
Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>=0A=
=0A=
Best regards,=0A=
Tien Fong=
