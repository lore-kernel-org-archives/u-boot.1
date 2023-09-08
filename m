Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6070EE800B
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 14:19:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00CE886A61;
	Fri,  8 Sep 2023 16:19:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=st.com header.i=@st.com header.b="kldEyqA9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82D3A86A77; Fri,  8 Sep 2023 16:19:34 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC4AF86A5D
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 16:19:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7615c7331c=etienne.carriere@st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3889l1BY012502; Fri, 8 Sep 2023 16:19:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from
 :to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 STMicroelectronics; bh=dLH8BGTWYrDwEDs/4VVfjlRIu2J8KnOOJmRsIQB6f
 fo=; b=kldEyqA9tbiNyC/TXtw0yV4L/Gx6IZ5vIW7uZj20hBCRxqVpiS213ze+9
 2wek/Ylv1pFh/knU/D5iHab58yB4bdKYhkdCAFjOyW9hBlYb0jsnbu0O/YD/m8+1
 YdHgHEzmDGs+YlXJEy2DsovbCZSKZM58wvfgNS53+lC/PLbivo4v85HXNmk9JOpG
 kr0CWaU7f6j6mQaVPNE3YlQJjuijxxVucFeaMCWovGI+DFieFmJWpPbe5JSRY5+j
 kq9ZMpJ2B5mQ1MtExXn+p5wkZxibFbe/TUtNYCquuzV5OPSLRZ9CpQw5k2GHwfLV
 6dDom1vPPyorI0EsQgdAzZF7zqP9g==
Received: from eur05-db8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2109.outbound.protection.outlook.com [104.47.17.109])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3suuxcmrnp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Sep 2023 16:19:27 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DF2+/yrk5a/rqqTzDm4qsxvvuaMj10Sb8hKYQq1Fv0HZzU37b1Nv0XwjFB1yzM93L+EDH/aQ5C9848+ZJCIf5o1pt6xQWzwMbtBoleRnmI/rFbdnmDB5TdvGEW+L/CANqTEWrajgO8edPbzaoPalrvi3aevDMyuNX+GeeADZomyH9bNbvNCApOYQ/KbyYXD1ebWmMaveWZree3Xk6RKdx8dULrF1UVutmGCwjcszF46p+5YW2W2Wuy6yqS7rBk26Zx8zD7L29/Xzcqex0eOEH4i3/2tuQA+ynS5pOnyjSSXJy2ea5iO3oTRz69wBCtfElOD50Jtuh7f0ZNROOJDq6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLH8BGTWYrDwEDs/4VVfjlRIu2J8KnOOJmRsIQB6ffo=;
 b=AiVbd4W7QNh3NksNEqj6DylgSoSqfZELCEJHXyFZv83hEckxGx53wdTucvAa86knueJNLe/dlRjJe4RSQowJ891huEdivRl0R9FW7ZhXMjF+1HzaYDFG3fbXo1kO7W1zWeaQcFLMdEJOa8hmx4/vqviqTr7vP93S0+ixDnejyPG7N6FATFmq/trj0nhXbEh61SwEy/CQS606r40ihpJnaLKK70MbKG0pz21SNeOjHB2vMMGuZ4ZEbLW2qsXKunj0+sEH3Hab+8Mlb6r3QilUkWMOzcUNCWgjXQDl+QGevR1O99qGLcE+c92l4wncVHdkMGD2m334mCYiwLpJT9He2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=st.com; dmarc=pass action=none header.from=st.com; dkim=pass
 header.d=st.com; arc=none
Received: from PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:157::13)
 by DB8PR10MB3781.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:167::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 14:19:22 +0000
Received: from PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::16e5:8821:2b8b:6d5f]) by PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::16e5:8821:2b8b:6d5f%3]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 14:19:22 +0000
From: Etienne CARRIERE <etienne.carriere@st.com>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, "trini@konsulko.com"
 <trini@konsulko.com>, "sjg@chromium.org" <sjg@chromium.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Etienne CARRIERE - foss
 <etienne.carriere@foss.st.com>
Subject: Re: [PATCH v3 05/13] firmware: scmi: install base protocol to SCMI
 agent
Thread-Topic: [PATCH v3 05/13] firmware: scmi: install base protocol to SCMI
 agent
Thread-Index: AQHZ4f+DYoGAuQbczU+RUr3gLvvllrAQ+DyZ
Date: Fri, 8 Sep 2023 14:19:22 +0000
Message-ID: <PAXPR10MB4687DFB8262CD8214D40677EFDEDA@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>
References: <20230908025138.44405-1-takahiro.akashi@linaro.org>
 <20230908025138.44405-6-takahiro.akashi@linaro.org>
In-Reply-To: <20230908025138.44405-6-takahiro.akashi@linaro.org>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_Enabled=True;
 MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_SiteId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;
 MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_SetDate=2023-09-08T14:19:22.028Z;
 MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_Name=None
 (Unclassified); MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_ContentBits=0;
 MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_Method=Privileged; 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR10MB4687:EE_|DB8PR10MB3781:EE_
x-ms-office365-filtering-correlation-id: ed5f526d-f36a-45e2-9a50-08dbb076993d
x-ld-processed: 75e027c9-20d5-47d5-b82f-77d7cd041e8f,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8bXOcisyhu/Ume8tKR7xo3GXW00AWWi3B9pPzDYEfELAxR1f3jhYdzPl3ZtDLCkriZwYH++Uc5K37ndQz9bOjaNoW3wOAZCLbgKYDuCdVGcIicBQbZeM1Ly9QBMuojZEZA/3DwJM1v8W/CJaIuiEvEaRje8qArSddMSlrJXGx7IZFbz5KLdezQd9BBEF+coX9H7unyoOtkTNemNhk2OZXqndxm/MapK1XODDaIsXYi5tsBqHcIm+HtHtkyzRxsS5g4G99d/IIFJe76o8k4SXfwYpBoQNZrozG4fXI9KIeCpCE1ghgG9Lw5poVhpItq1gM4VxOj/ywj5ZlauqjFVqvCMOWqa7qo+kicv4RuSTYjqsu7Tv5CoVWhDT0tylTG3b0y/0/+zrkmVbAoz10xjYayEbXozkBW3KufgKDhBNOSF/G4CvT0P9de/w0vb0JaaCARPFPTeDbOzphEO4pwPIVIXnbeAzHu3MLCKd/5lq2gMcgAslLkAnjvHhexM1jHMhwHdxPGbuV9MD2AazuedNk+aATkvzLQ3NdrMslWFyOmHBhpVjnUCRVpuysFuKShYhHBhch08RoVtYTRXmjhEjxwa+GuBZNyPE32CVoB7GChA20dfU3BEXuhhfkOXMwHVX
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(39860400002)(376002)(396003)(366004)(451199024)(1800799009)(186009)(5660300002)(52536014)(4326008)(7696005)(6506007)(8936002)(8676002)(66556008)(76116006)(316002)(66946007)(54906003)(66476007)(66446008)(64756008)(41300700001)(2906002)(110136005)(478600001)(71200400001)(9686003)(26005)(55016003)(38070700005)(122000001)(38100700002)(33656002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?d7i5r6f3W8jVuAy13OKXDCL/6Jv4PucleIMHQV7GVBCrxbXDdJdE+11D8z?=
 =?iso-8859-1?Q?FCD+DUiMerVBpK2OGk6pNJDWV/ry0OoQ90u41t3iqVl7xyUMcCnlhQJ+MU?=
 =?iso-8859-1?Q?N3cQHIKjRO/SvZzT9+m7l8C7zIhJVYTdUViGaOCG/RLxK+LtQgiEvVSHs5?=
 =?iso-8859-1?Q?txi4Nz8WbYXNAyYiVoohzJCP3o/Ypy9V2hZMpnGH9v9X2jVyNMKV3n9t+D?=
 =?iso-8859-1?Q?9aewiBvZXRT1fuViv2wYM4Sd6UcyVaxqs3+AhuHTlANdZh/oLV9a/cOmN1?=
 =?iso-8859-1?Q?GGhnI0dSyt1QsYNHPs376EVMOYcRHJCdWDMkXoa26eKEdbzGdLO8lv6GJa?=
 =?iso-8859-1?Q?zMn1jTh1DVEE0PG9C2urcJIUPmBfbX3pHk5yIbN200Nc8lfYAzKhvHLxYB?=
 =?iso-8859-1?Q?jf9E/bH/GOoCLkch2qngtZDO1HePQ5FG0A39c33m9q0plnebFO+/Ht50Qq?=
 =?iso-8859-1?Q?dfN/2WANtHIfCUMW2vYhD7by8VAkIScL4csrSAa7H8N3ewsVK0eZJBADdW?=
 =?iso-8859-1?Q?BLgD9sa4eZnIMNzpIR8waqMEUtV5eC1bzVM+/1eBMeX7nHHvyoBAWJ8ipr?=
 =?iso-8859-1?Q?v6BGfi29o2EnH/JGyByfecgcKa0QSOLuU1NujKRpBpmergoVzd09GpvK1b?=
 =?iso-8859-1?Q?wLYSjF1FpI+I4/UPxqogWD6tZ9XxI3PPUlLxmqyB8orYEE95Ndm/HCp3Ep?=
 =?iso-8859-1?Q?eWzz8Tgwd83mv5mtIKFxklMkjdI4yo1PWm4jkzIuCyAsXWCmjuQ7ipNsYE?=
 =?iso-8859-1?Q?uPaymuTOUdf7TovV+fAyZOE9v0EF/hktFvzyyRCa0W5H9mLIrTrqFg7/iJ?=
 =?iso-8859-1?Q?OE8F+QFKAJceynKiB74Xqorju8lDufEphEt/sfwHisX3+bTXxmnwvLnZEQ?=
 =?iso-8859-1?Q?WZhXrWI+Zz4O92hH7A57Z1sPhEXyLDo4rgjhbvoVXv6HHDJh/FAKBY/bF6?=
 =?iso-8859-1?Q?JrjxtJuy2Zgg+HeFLp2WWNPlRi9PC6eVYVxsuuQ/tpssQcv7giJokjLim2?=
 =?iso-8859-1?Q?iWG9gdNgAmqyYtx+2+tNGpieq208IHbJHjHmQ0ZKtZV7mHpXFXqTOJI7Ld?=
 =?iso-8859-1?Q?YJoRQMSSRp4TeBRmRbx5aQjLYuDPolZy3uMioAvKUt/o8DwuSq8yNQcHEO?=
 =?iso-8859-1?Q?AqVK7ikCmL1qgr4m9nfOclYQqHfz2Y3i3tm+mi1oNT1iwnkci2Oh4r4ux+?=
 =?iso-8859-1?Q?teTO5Lwz4IrLOKq68JHHk/JHYMQ62P8Gamg2k1+1YNdFiPtIUbVhU108TU?=
 =?iso-8859-1?Q?YJ/aN/UbNwBpsABH1L1V96sCMvY0tg9Mf6waX8dQblmhpUXeGt4iD1fvw0?=
 =?iso-8859-1?Q?z8Ni2u0AfnG8qsxLDpbvLQTS0nD32omlBpX8+qODlQJEC561ksGwU/pIpU?=
 =?iso-8859-1?Q?TzFSUP8rkLF5yS7UtX07Dpte7eqTptBEmFw2VDsPQ7pxZLYl80JJlvAYtJ?=
 =?iso-8859-1?Q?rWU3BZ6re4XI/1a5PMVb5RsO5wEUuwUWpbEfvFLvX1X2fzIjQriCYjpmkF?=
 =?iso-8859-1?Q?wzhctqBkDGzzWnoRgDz0EkAIZ4/BT6crz6OHmHhHcC4d3oE7QYjtXVUD14?=
 =?iso-8859-1?Q?wBeuqdcp8Xe3fV29ER792womUWyffkSlJehKA52l6l/KYYsC0rLeHXcvAZ?=
 =?iso-8859-1?Q?y3GCAy0ObssaGctQcNWFZaqOv4X84Z7ez2?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ST.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ed5f526d-f36a-45e2-9a50-08dbb076993d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2023 14:19:22.6502 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t0WtNvyHsme4g2WomEeAzJxNe6Ev+IedkGFCo8bDnKrSN9esMUEh/3DPHtOykzR+uLHvXk6f43EdVxgjhtT3bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3781
X-Proofpoint-GUID: hO3COn2hDI-ruFhOz2-DIWowJbEd7anz
X-Proofpoint-ORIG-GUID: hO3COn2hDI-ruFhOz2-DIWowJbEd7anz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_10,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0
 mlxlogscore=917 suspectscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0
 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2309080132
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

> From: AKASHI Takahiro <takahiro.akashi@linaro.org>=0A=
> Sent: Friday, September 8, 2023 04:51=0A=
> =A0=0A=
> SCMI base protocol is mandatory, and once SCMI node is found in a device=
=0A=
> tree, the protocol handle (udevice) is unconditionally installed to=0A=
> the agent. Then basic information will be retrieved from SCMI server via=
=0A=
> the protocol and saved into the agent instance's local storage.=0A=
> =0A=
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>=0A=
> Reviewed-by: Simon Glass <sjg@chromium.org>=0A=
> Reviewed-by: Etienne Carriere <etienne.carriere@foss.st.com>=0A=
> ---=0A=
> v3=0A=
> * typo fix: add '@' for argument name in function description=0A=
> * eliminate dev_get_uclass_plat()'s repeated in inline=0A=
> * modify the code for dynamically allocated sub-vendor/agent names=0A=
> v2=0A=
> * use helper functions, removing direct uses of ops=0A=
> ---=0A=
=0A=
For info, I see that this patch, as placed in this PATCH v3 series, breaks =
pytest.=0A=
Patch v3 08/13 ("firmware: scmi: fake base protocol commands on sandbox")=
=0A=
and patch v3 09/13 ("test: dm: simplify SCMI unit test on sandbox") should =
be=0A=
picked before to have scmi DM pytest running.=0A=
=0A=
BR,=0A=
etienne=0A=
