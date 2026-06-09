Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F6F4CD8CAA
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 14:46:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FBD084704;
	Tue,  9 Jun 2026 16:46:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BcHv03Uz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1E2784704; Tue,  9 Jun 2026 16:46:27 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 159E684664
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 16:46:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1KKDU+QhKmD51+/bjfGEq6xrMOEfw0jXg64YPu5FhbZMxETRFtEGst6Qmavfov7I79AIn+jBb+RhwaiZiwQqaPr59XDc863EuyXlKao8Ocd6H9YfQO9dB/h9slC0uinYAXFYhblpLQ1tqKS3GTQYIOY8sHShwGAJ8NDRFPifJRRTSL3dRXx/ptUxFSiFQ+iElx48AnzUoUZju3ySSxo4hDQBdsNqaWHUnn5+Pv/mcZ3ULq3hGkUBcNIP8hR/tl2hn8IYboeMMLhpu0Z5QqvBg8nRO3Thwf1sFNwT5kciKQpuXNbSwO325URPzqvhk8zRQfPvdHFcrlUl09whuS5mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tNwLzWtgfaxlMAPFmeBJgs5AJhsYThwU/aUzUClEezM=;
 b=gCc2VDHjG08wEUDfaJGFLJaHdMmcNsBtxmQCh4oB02PictpoawS0MOKONNhP4d7EKRNtyyrKXsZfS15GCkXcIAyS0E5ByhzSBZMWfi2QxY3dxQGqM82T6GaTy6g1DwLzLryDtBAmionAI3dIaGVrEoHO/MLINsKr5SENxZxTIFhiDC2vLY46gCmY+ytRdrzmmh8sePEAOf35iPfHDyzimCR7GWzOw6sWxhgDh/w1L1CYp4yk4sMiu890F6pc5gPiLjDilX5ajjhEG3e9hyjqRjLcZ/tX5XCKOpsbuYsT4ohVU3QS2OYo6f/xTeKRu+QlKzkazWEBHcDrQK6J4Ge/UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNwLzWtgfaxlMAPFmeBJgs5AJhsYThwU/aUzUClEezM=;
 b=BcHv03UzF2m3Bo4wGDkDRTCyHs33onvSFpXy0S4Uxg7qFgz23LMlCUGN4jQca7ado31Q5tqHVmvtG9ghhVwMo2YXXmJkUEgKgzPCfQZTTCA05MQiiSFkvxRMoFeeld7Tp/aZpVHDsT+a2pwlNagy5RX70Wc+BMXQEFPk72s1nJuXDPfeMv73EIhpiif6F8VvG9Y/1KbCU4hIRcfver/Ldu9Atq5yGkGryVqeOFp4o1xUFHMRm/M0A3zq1DEvC2boR+XxOkl4snPx21GYWaMsVEPRhtgovqBhpqRAmSwyTepzO73VpyU30Gk9f22epxn5eq6II40WpZnilyn0i+92QA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PA1PR04MB11456.eurprd04.prod.outlook.com (2603:10a6:102:4f7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 14:46:23 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0092.010; Tue, 9 Jun 2026
 14:46:23 +0000
Date: Wed, 10 Jun 2026 00:03:27 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.denx.de,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@riscstar.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH v1] thermal: jc42: add JEDEC JC-42.4/TSE2004av SPD
Message-ID: <aig5MbLiHmg7tAA_@nxa18884-linux>
References: <20260527140523.544762-1-vjardin@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527140523.544762-1-vjardin@free.fr>
X-ClientProxiedBy: SI2PR01CA0028.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::21) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PA1PR04MB11456:EE_
X-MS-Office365-Filtering-Correlation-Id: 6972728f-38e1-4e53-8792-08dec635e067
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|52116014|376014|7416014|38350700014|11063799006|3023799007|56012099006|22082099003|18002099003|15866825006|41080700001;
X-Microsoft-Antispam-Message-Info: 1+TEklxV4bYXaZbGNIm0vfzU2kfyqOtqui3P/oRUNKek9lvh/qOJbqJIJnemTkqJrRcsONcCwnGYVlsKxCG2f6k6qH/oZbHoT1ipknlFjkvs3s+vYsDQ3tnaJPcHq8Jvr015HHsFM27C7xYB2QK8uFQ+jrugZG8o62LBPcHUwMrtqguH4Mw+zV/OAj/eJ2A7lhYrbtq7x1VU+lj9CO5eBmBw4T7IE+ePo/lqRCHAiyTsousZh32frgIlBx7tA4lo7mLJxO6GwEqrWI1pfm/UX8IlTYBzUIiF/3ACQ+1s8onjdjRI2+K/Kn18oKFV4w+u9FXhpuRXPIAmBv8Zz+rhc+3MfzqJIfCZMcdQ4fY0nowJy+n9256uQoQF2ckfMzBVyuJYA93ecIYDZUSvOiWjTiuE86lN+rq0AgXMe//VAqtVwStnzGKULvCJARjJC6yv6uvnytPJ6+ug2g8rncrQslaEGxPMpKyPlzO3lkwnNEnPlO0RTZKR4hvF4F5qIb2nKgxG6B5l4ljDeaYX/dBDoLFxj99s6Y2x8fdt89mVFZOAt6ovVap4gJnD7Vp0tZHqSttaX81dZ/uuGXm6M3nQzilqwdB8eO8kPXja2pin7/Odx0wbiRWObAf/MMOiVoGZJyEhhH8nhd8xzU7DIunrlGiDqGCgzHWVksXBHW/+6fijxnyY1bQiDIy3ULWdOQzlaPZoZFhGwOcZgpDe1J54VNfljVt1stqWIcFzuqETjLJ+CBrWQOILqlcBG/L6RmeM0FrZazJu1z5om/JMWGydquPjNCxPiPbqXGBN49UMp31UaJtX6HSXYzPnttVnz63U
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(376014)(7416014)(38350700014)(11063799006)(3023799007)(56012099006)(22082099003)(18002099003)(15866825006)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WfP+T2OkZBxbzC4y4b4VeZS8Td5PAfrXK8M7K6Kq3+6oH1mgbJDv4iyY0Zg/?=
 =?us-ascii?Q?ajOQUpoiwjpIKHeB+T21ilJpZnkVwQkP2fbe6z7dZvJ38O9ZTW7JK4msauCR?=
 =?us-ascii?Q?BRrppPvzoxF6nr6dbLK+USTjh1bE/HgCMOiiD/5DI+kQHg+dk1dS2wLEC5sq?=
 =?us-ascii?Q?flgdmq1OyQyPAWTKUdOhIYLG6AEouIsXZBVtzgNpj7TpKWyHSgaxmUd8GGfj?=
 =?us-ascii?Q?AzrLkBgPcA1iuuc3ZmBDagsXQLbR1jkfEOpB4M8qm7Fnj8FIciyvWLW8FSAa?=
 =?us-ascii?Q?gWO+Jhk3Fc+a3jJu4EozwmQdlNDHyNdRYb+7UxIN02mTN6unALXWuPLpZMmx?=
 =?us-ascii?Q?u1wqZzcnP5PTmQ5+r9cun36lmzJcbfmoDXpfxTDJSuvPHNCMFftYDM32RKFI?=
 =?us-ascii?Q?xnMoBH9ptwBCkQXYFiEk3MyIpZVz2GwIchvpXRpeO2c4Vg2QsmvHPpSdOrIB?=
 =?us-ascii?Q?mlBqupMuGEOKzlzna8g2PnLGF42S1ZHZMHhtRJKJtzEOxjzWnUJ8sP/n1DbK?=
 =?us-ascii?Q?aByH2bLkO6Yq+5HvIhlhshsr//joW2O9wVFcBGHYPsFIaZZckXb7vXuy0SJH?=
 =?us-ascii?Q?XCmturs4QiwZm2SYEdIZF4cABdaAk1J6jyuYcgNElD03clpIbWpHjnRLHea6?=
 =?us-ascii?Q?C19vOsNkUZhTSiJe9/v3dE5CVsmXQinwHHrOVoswavJXwb5tcsQTFNmQcp8A?=
 =?us-ascii?Q?z2+asnyTJxSSVisAPECuDHw3zalbdd6onuurr5fH3RBWUZas3tBiPakZVObL?=
 =?us-ascii?Q?r33MwkzsBsU8I6gkYj+04UjQG6AK9l7FnheNxBn59KnMoXPIayDKjsMI9NUL?=
 =?us-ascii?Q?IqUTH7bF0QWDlXKQyZAurzX86NiGCADVY6+eA6+opOmu6Rx516OE4Co2zjHB?=
 =?us-ascii?Q?MY+QiCBfB5RUBYEoHik1OjHoEXnRJH5gwQy2U1Jd9L9bQiqVQ/8mb9HXTLFo?=
 =?us-ascii?Q?qyhC+nyEZLR52EPu8QQkjh9xaPH4JMyAEK0ex1cRXOiWMSYWa7j4PB5fFNXM?=
 =?us-ascii?Q?KGhQxerm5167OOasz3Q3qjKeYYDjMFXyGlqJLKYuKj6B6VwewUGaJ5GTvneU?=
 =?us-ascii?Q?BdpCBDtaJ0KGXameenrXvSWqww5OQGKsD1G3G8BeH9W2LW/TUgQKIYiivsi4?=
 =?us-ascii?Q?usnhb3cPp0N6eiu+bJCwQ2e2RjhZNgvOD15C3VtU1dEwPjmUgbU6H8m9KWGE?=
 =?us-ascii?Q?ImDAVkaD1eFD3ILo6iHxNIW6yf5/E9+9jVUu8rbi7wxFGF3Slnnr5XDTnaIv?=
 =?us-ascii?Q?Pn2l9tTOSjUi14q6CssXHWapdhaxuTe/HXOQK2rqlqoDyMfKBQw61FGiTFIQ?=
 =?us-ascii?Q?lYs081pK7HDzl+tXIsE7JELkt5yNSFtvhxK5WvdlEEemgFjSUMWbynbyoObX?=
 =?us-ascii?Q?J1kGBZ2rxi9djGou2oOhjkqRbR1vD3zwxmHklZ13XdvXG0OHhtf+w6Oz08C2?=
 =?us-ascii?Q?ly8mJJboF8xcXcUkodPY2RXcCzjR9nMmpCraComcnaS0J1Z5XG98GF8b4IOL?=
 =?us-ascii?Q?VvjBqE2ixNLJa90ROd5AI1pauXJBoCLdkZY6+I0u10V8xAZ5xVY4PvD4eq3w?=
 =?us-ascii?Q?ZA4Cl/gLjrtmtQYPKUvM9hBdKHOx72EqgCcefc49rooxUuRW+8C1ZEDSx7/y?=
 =?us-ascii?Q?zjN49ETfONSJ1imO7ticBMmfFkY1MWgNdqa8zjb15ZH+ARGGrH8pnizqvqZN?=
 =?us-ascii?Q?YgZ4HFK9hElMND8Nm14e7gGOE9bowrHrq71ORCIwLEosNV/QIc44TVG9kZir?=
 =?us-ascii?Q?WEh7F9tpxQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6972728f-38e1-4e53-8792-08dec635e067
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 14:46:23.5100 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZinPDQoHsXFcFwhh21lwY8EVMjn83KLS8Mt+gkXlrspJLxjssAaO6H6EhYljrZQifGoQTvK7SjHNHRQal6rqlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11456
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

On Wed, May 27, 2026 at 04:05:19PM +0200, Vincent Jardin wrote:
>It is designed as a generic UCLASS_THERMAL driver for any JEDEC
>JC-42.4 family of on-DIMM temperature sensors (TSE2004av and
>compatible parts).
>
>The driver reads the temperature register over DM I2C.
>
>The "jedec,jc-42.4-temp" compatible is Linux-aligned (see
>Documentation/devicetree/bindings/hwmon/jedec,jc-42.4-temp.yaml in
>the Linux tree).
>
>When CMD_TEMPERATURE is enabled, the sensor becomes available with
>the standard commands "temperature list" / "temperature get".
>
>Signed-off-by: Vincent Jardin <vjardin@free.fr>
>

Applied to fsl-qoriq/next

Thanks
Peng
