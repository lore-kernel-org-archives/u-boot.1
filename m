Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 763B1EA3F0F
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 06:58:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 236A683D0F;
	Tue, 10 Feb 2026 07:57:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mYwzbAUW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C124183D0B; Tue, 10 Feb 2026 07:57:42 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8575D8309A
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 07:57:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sWdWwOBKBLfQev8rKF7dlnWET2JceKqGk38LdameiAKuJYK43dZXnLj/jVobIjcAd1kQPk7jxfdIrqbUvN7wb48hwr8W7Zxh2Atmsqu1bfxhLt3qXMWmGMcGTZi+Y/aZqVrm7Wqg7PPDtSx1RR8cjoeRkWSwjpbU++1aMBn36w3y2SJpE++z230+JlHylUBjXnJ2sR8SFbPB03ItqcaR66xYuOawaqs9krPfyErZyv7kAKccX4ua/qRnULTITUQiSTa9baFqxQPf5eTlwXc2oiU+/lNNjY6YmkZoAGPXan3eQM8NZh1uW8SBR+bVqKUkJdbVq9JutPRi8Nz2i1DgVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOYCgu75W4eP8Y8hAGAEeCPiexItRaBNzjEn5SzU9GM=;
 b=u1NN7uVT566MqoKhnuUcgqW2GVrnwFg8oGRqhzgdFP+7AgbwhwhwaAeK8HooNrM2qO3vHsQQz6LeZbwXuYyXfP0rfbAQC33OvArKCsSnZ+SAT8tZexXoOv45IjPhypZlhMm2li1aKB29ryZgCuzZCxZsBuij0DDF6i8iwSZ6iIOpEcu4mO/xrpBUK73LykF+VppMMhGl/vU3gszUNFypxF+A6E/HjlNhmm+FdqCrdnheos5LIVKKGEAYMXMYZugoQ+DbLMfwgihNupe/GZm8Ye1pLLCw7kGFQjH9IsNuVf3fkSpMuYkQUWT08BXDQJ72LyQvVqjx3GOOqq6AhMaHrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOYCgu75W4eP8Y8hAGAEeCPiexItRaBNzjEn5SzU9GM=;
 b=mYwzbAUW8EgPcV+fl9alOuSXWQlPJAOB9LvmarDN8dtVL8laNGD2e5cZBQu0VRxJTHLJDTPdkMTLnZFtJzg+Svgypxzb17jv4kEFRqFNMKdnfi5ciLv/Ak2WRibsDIG3qGtKxp3cxsnsYZeVqYF+WEKmBkAKg6lQDRFaBmGr0vPaPC+PH/Ad1t46Pzt8kD4M/qHQfsuZwak3dAxRZpqjY4aZeggxVsyh8exd8ScmxqXmE9REP9kQgGlnVxkMpBo6/LvXvILcjHFHfV6FlyzL+v0Scp3LX7BuvZUsfdMfg4Tph8SgMQHLbbNd+TNGhfeR4jX6Rd8xmFZ+rLbZNb49pQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VE1PR04MB7455.eurprd04.prod.outlook.com (2603:10a6:800:1a1::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Tue, 10 Feb
 2026 06:57:38 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9587.013; Tue, 10 Feb 2026
 06:57:38 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 10 Feb 2026 16:12:16 +0800
Subject: [PATCH 3/3] iommu: Validate device tree node in dev_iommu_enable
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260210-scmi-fix-v1-3-0d75f57944de@nxp.com>
References: <20260210-scmi-fix-v1-0-0d75f57944de@nxp.com>
In-Reply-To: <20260210-scmi-fix-v1-0-0d75f57944de@nxp.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>
Cc: Jens Wiklander <jens.wiklander@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SG2PR04CA0159.apcprd04.prod.outlook.com (2603:1096:4::21)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VE1PR04MB7455:EE_
X-MS-Office365-Filtering-Correlation-Id: dbeaa313-0b1e-4256-b055-08de6871ad51
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QzNScEI2YzNqNlRtNWQ4NTVYK0VZaDJIWnZzelpFVWp2N1c3N1N0K2RmWWlh?=
 =?utf-8?B?N3JYYnY1ZEdENkFFcjQvckFMRHlnNDJ0b2Y4T3U0RE1NbkthUjhHRjNoN3ln?=
 =?utf-8?B?UHlGNjNsQVJyNUlrajRvcnlrZFdVek55cXhNMTdmV0xjaWUxR0RvZUp4T3d2?=
 =?utf-8?B?dXdteHhxRURxVTBSZXVLT2lqSWZORUNzRytsWjVENlRRREt3NnVnTlpxZHZn?=
 =?utf-8?B?UWFTYzd1akZIMER6TURGWVRGZUNBbXUyU2lKM2x4TC85OVBlRnJnbFIrYVhM?=
 =?utf-8?B?Zk95YWdhdDlkZllWWkdiLzNXT2x2Mzg3dG5tL25CZW5Fa0NNWkhrY0g0dW1o?=
 =?utf-8?B?Q3doaGRrUzBHQjBtMFRDbVQrNDd4WVZSVjB2bXRLUlRRaERvMkNhS3h0eEh4?=
 =?utf-8?B?N252YWFLdWJjTTQvY1dxdDBLR0Jtdlo4a1orNWVvbTNROFNTN2NENU84VkZm?=
 =?utf-8?B?MjBRNWNpTjBaOVk1Y1dSOUNZMzFqNUxUMzBSZDgxTnZqWVV2b3dTUDF5VFIv?=
 =?utf-8?B?SitRaTZ5Z1Z6NWMxS2lqZWVsZlRzNGtmeW5vQVpkNndWbllaSU5vUit4TE5L?=
 =?utf-8?B?L1JQZzZNUkJ2OXFnTDFURFlVMC9hdnk4YWc4ZVlpYkIxcVNUNlpSbGRHcW4z?=
 =?utf-8?B?ZlB5bnI0eGRkRGRtdDVaR3g5bW5PM3hWRzdDRGN6VzhncHZrWDB4aUkwL3My?=
 =?utf-8?B?YkRIdGM5TnMzYTdxWWE4TVN4WlN2c3lIUTVVd3BwcHZ4QnVWc0xTWGhacjBH?=
 =?utf-8?B?by9tZmVYNGZza1gweXZUNGxnYmwzeGpkQ0JvakdjQ0dyVnZOcERrNVBBeFR0?=
 =?utf-8?B?UjdQa21Od0J4a3M4MXByV1RwZU9RMlJ5bUpOd2ovL2N0TFhPVEFjTWRKYmtz?=
 =?utf-8?B?Z044eklaWk9XbTBCWFM2VUUwSGkvd2I2d3g4UlNwVCtGaktyRVk0VmRzL1oz?=
 =?utf-8?B?RnFpTVUvSm1uZWoyeGxVcGV4S09UUDhhMUhMRjlFSitFSEVHcjYrd1B6OWFF?=
 =?utf-8?B?K1dIVVJaWVdiaGlxalFkUElhVWJFOVBtSTUrTFI5OUV2QkJpNWg3aDF5VGxV?=
 =?utf-8?B?TnZDL2xnWjhEemwwOTFMb0hNUWpmUURZMk1Dc0drUGNodTRIMEE5SGI5Z0dX?=
 =?utf-8?B?V0FYN3JJMjR4d25OQWVqbEUzUC9SNk92WDYrMlcwaVNyYnFxRkxSU0lLU3Zr?=
 =?utf-8?B?LzBkazFRNE9NUk5SRlgzaFBBV1RxengycmFKOUQ5R0Q3VkZ1VVE2SjI0d1NK?=
 =?utf-8?B?T3ZTMnBleGxHTHdOZUtEenNSWEh2SjU0WGVuUXRaTFZRQm8zeDBQcnNsZVo5?=
 =?utf-8?B?b1NJMVYrVVNGN3ZUakFvenVpTU9HWFdIR0Uydk9oaFI2UWlMR2w4OTBuU1Nh?=
 =?utf-8?B?eWxycmZEOXlaSkhBZmFtVkxyUnlpbHZsOWd4VSs3bVVtZFBHTVdWK0wxME9q?=
 =?utf-8?B?ZnhtaEtoTHFrOHhlZXNUdFN5clVLbkZrRWVvQVVUYXNqUWRlTmlQd0lxUExS?=
 =?utf-8?B?QzJSWmtyZ0lrdzJQc1ZxK2Z6Y0RiQnBhckY1eGkxRGRpWUJwZFdOaklOVm44?=
 =?utf-8?B?ZCs5WWhGNFdHSmFwc2VXb05VNDhzc0pYekFSaHZlWjBlcGxRY3RhMDRaT3FG?=
 =?utf-8?B?WkgzQk1JNjMrcVFHV0FxWW5sSmVnSjdFN2FFK2NVNUtlN0p4Yk9PazNieUNG?=
 =?utf-8?B?ZEpDL095bWtyVm42Nm9SQ29KbjFpWVl2Ry9jOWdXMXRrTGV1NWM2NG9INXpI?=
 =?utf-8?B?S1ZBRk1ZZCsvdEZxdlpPdUlrZkF5ZXVkcG0wOW81eitZS0J6cjdTRjZYU3dH?=
 =?utf-8?B?Mk1GTGRHclU4d0Jzc3hwSEJkKzBHcmJLTGQzUzhLM1M4RTZxREhqK0JXQ1dY?=
 =?utf-8?B?dk9oa2dCTVVpYm9vcFFzOE5XUHNqQzNEdkpKR3IvaXB2TlhzUUtWTkU2dHox?=
 =?utf-8?B?VEt1TU04Wk13cFM5TFNTSkVuT1dmb1A0VElSU1Z6ZEdOWVhBMHU0cW9jMzBP?=
 =?utf-8?B?LzY0Q0MzZXpkT3dZdU5uaXVDQUZWMUxxbmdKWHZjRzRpbDZ0M2crTWFhYWpx?=
 =?utf-8?B?SjB5M1hiRDRHZ2svOEFkSVQvZWhBcUx4MXZTbDNUNERKaStxZzhCcVBENUVp?=
 =?utf-8?B?YkFEdXo5WHAyVTV1RVBWRFU2MFhaclhrdmQ0a01KTjU0dUZKaUpldElwbHFq?=
 =?utf-8?Q?XFVXHhyZgEKZbY0Fr6w1BRU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVBOTGRFMm9zYm13OGk2RTJCY0dwR3pKcTAvRW0wZ2cwdTFyU054enlHbkgz?=
 =?utf-8?B?U0dqMzhqVWZSTDFMM2YyVjFTYk0wc3dyRE15U2dRY2gxTGw1aXF5ZkVqVVIx?=
 =?utf-8?B?cXBpL0NVdHJqR21zNXJZTmZsVGtGMkJ4ZW1BVEJmS0ZRVWJqb2ZWYmZqbDF2?=
 =?utf-8?B?N1ZteW1sVURRUHNzU0prTDBBUy9nOTluTERKUmtqRkZhaGNNYWNzSkI1eTla?=
 =?utf-8?B?VllEZGlZTFltbVJCTVk4NzV0K1BObkg0VFJ0bUNnb3ArVDhwR3E0L2lxWXpG?=
 =?utf-8?B?WjIwSDI3a2N2ZmZGQ1VGL3VDYlg2dEdUcE14clAxaW9WTUdER01ML0UybVdh?=
 =?utf-8?B?eU9mWkVpOEMrSGVqS2dTeGI0WGNGNEZVWEFoS2VaNVp2a1l6emJtcStnSGVH?=
 =?utf-8?B?ZTFQL2dJUWdjUHRPcjRTZWtYNWFsdWVLZTk3RE82bGRCSVBhUU5zTG1YU3M5?=
 =?utf-8?B?aXF6aWJDa0RRRitDclFCL0MvZEo1SE9GQi9VSGZwTXdDM0RMdFhFNkE2SXJw?=
 =?utf-8?B?VGZkMTREN0dVT1Rxa3hOb3hJbWFSNG00YW5LbktUNHhBSTI4TGM2Rk15NnlS?=
 =?utf-8?B?TkVRTTRwU1JlYUd2L3RHcng4amZzS3Y1UzViNGY5c09yU3puanA3bUU4QkNs?=
 =?utf-8?B?L1VBajNrdUpyc0JucXBlR3M0aHN4bTFMVXowcDBQanM1S2ltZWRZM3NGd1hY?=
 =?utf-8?B?eDBlNTZJaVliWnVtNlVyOUk2dmZjUWkwRFAxVFpqM3F0Nm5JdUoxNzhiM2Ji?=
 =?utf-8?B?QTJtekxEdzd0SW1FWm5abTdNR1RwNE83WGNWN3owQjZHeVBuTGV5U1RUcmNS?=
 =?utf-8?B?WVN1ZnpCdExzTitYT2o2Z2xNQmRCTmtFSGUwaU01SGMyQ2FTNDhiYjNPZEE5?=
 =?utf-8?B?M0dCanh0WHo3bXJHcWl4TUZOMGxlZkhOTXhrR29uTlYyTUcyM0FTOWNjWjBk?=
 =?utf-8?B?T2Y0Zk45cXhUWHQrQXlaOWs3eU1JY0hzdUxIY1cxL2FRcDNRSnlQQVJxTFU1?=
 =?utf-8?B?VGZMWEVFb09iTEZGQjdiN01zcndoU1drK1N4UWhBQ05TblJtNVROQ0VyRDcx?=
 =?utf-8?B?K01jSC9QWVIzUXcxMlBCQmZNYm5LQjFWblZCTXlQaW12eUE1RjhIa0N6R24v?=
 =?utf-8?B?QkZJTGVuSG5PR1VXS21IYWxYaU5CYkF3eSt3NklCOE5TZVNSL0R0YW1NeW0r?=
 =?utf-8?B?UVh5UkwvcnRORHlxN2JnWDZvQmpTckFTQjV5UC9oTzJROVF5cVFuOUVEOStP?=
 =?utf-8?B?YjR4T0x5bllpL2UwQkxHVW9TRjhqZU1YUXQ1MjV4bHhIZ1d3WFVSL29kaC9M?=
 =?utf-8?B?NmM2R1JHNnBhSHZYdENCbGtwclJJMm1kdTF3SHhoWkluU3owZWF3QlF4dkhq?=
 =?utf-8?B?RGUwV1B5NGNTMWQvS2dtRW9udzNNV1kwbUtMSys0R25PUnZYNlR6VGlmdTlF?=
 =?utf-8?B?NGpjR2lENno1cGV0M2c5Tk5lREZEV0Jad1g5RzhaOUZINW9YTHdPOWtaRW5U?=
 =?utf-8?B?enJRcmNLdzliSkptQ1Q4YkxiWmNrbE9zQjUwY290WVQrd1hzTW1KS1IvMDNZ?=
 =?utf-8?B?a0FWSTN6RGdyKzdIODhyanQ2SlV6VzF6YnBaS2dlYThtOERuc2E0MEJVQVNo?=
 =?utf-8?B?My9sRTBteFVnY0Q4SWFMQm9wZTZHQjk1Q1hja3g5QWJnU0tvZmJHRHRUVEx3?=
 =?utf-8?B?ZmlqZlU4TDFCRE1oZW0yTGlKYTgvZU13YUpGNzBzVVhmQk9SSjcyNXl1ZERj?=
 =?utf-8?B?R0lyeUZJOXRlNE9QS2VLVGcyWUFCeGVXNnN0TEFyNjlqaDFVTHo2bVpaeGcv?=
 =?utf-8?B?OEVjUWc5dGVOaXVoS3N0bkJmTitmMy9pMDVxZFo5OXpHYlFnTElzTXY0cENa?=
 =?utf-8?B?Q203Sk9mWC9lY21GRDNxemkyRWZBU05GZ1hlSmsyR3dwVTlnVksrbXBkMTVj?=
 =?utf-8?B?d2lQc3Y5a3hVbk4vYVdrOWpDZWhwaVBRSVpOTUw2cjUxZXpRdUxzS2Z3Z0cz?=
 =?utf-8?B?enRFYTd4Vmk1Z1NNWEIvRW43RUkwR3NiaTRzNTZkT29mNXNZc2hyMEI3YWdh?=
 =?utf-8?B?ejRiMURKTC96cVRydEVsSEgvUzlQem5SNDdzZTFnTk1vdlR5b1h2T1N0OUl6?=
 =?utf-8?B?MFo3K1c2WDhqcXpJQlpyLzJYZ2tkUmxRR256d1ppNThBQTk4c2h1d0tDaG52?=
 =?utf-8?B?bjMxaHBSenRuT0tIN1BHVHBhZFNPNGpCdUxHS1NvKzkwVS93OGFBUGkvSEh4?=
 =?utf-8?B?bkkzQklPS1pGNElUUnJZeG1xUTcyYjhmaEJXbTFLeWZwNmpud05ySXN1VlFN?=
 =?utf-8?B?NmJReXN2LzZ2R05vRXJOTWsxTkFPd2Jzd0pWVlU0VDRHNTY1QkxsZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbeaa313-0b1e-4256-b055-08de6871ad51
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 06:57:38.3075 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eCfcmsB/ppfIHps1uRHG4wolikHsqq/sdFpaFsDsMA2s42R8rtP98gGYE+vmvDSrG7C/92RnoPIBymk9ddSA8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7455
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

From: Peng Fan <peng.fan@nxp.com>

Similar to pinctrl_select_state(), add dev_has_ofnode() check before doing the
real work. Device(scmi_base.0) does not have a real device node, ofnode_null()
is assigned as the device tree node for scmi base protocol device:
'commit 7eb4eb541c14 ("firmware: scmi: install base protocol to SCMI agent")'

However with recent update in
'commit 0535e46d55d7 ("scripts/dtc: Update to upstream version v1.7.2-35-g52f07dcca47c")',
SPL panic in fdt_check_node_offset_()->fdt_next_tag(), because offset is -1
and SPL_OF_LIBFDT_ASSUME_MASK is 0xFF.

So need to validate device tree node.

Reported-by: Ye Li <ye.li@nxp.com>
Closes: https://lore.kernel.org/u-boot/939a9696-27fa-45a1-b428-feffe21ac6d5@oss.nxp.com/
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/iommu/iommu-uclass.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/iommu-uclass.c b/drivers/iommu/iommu-uclass.c
index bb31cd519d2..31b40e5713a 100644
--- a/drivers/iommu/iommu-uclass.c
+++ b/drivers/iommu/iommu-uclass.c
@@ -79,6 +79,9 @@ int dev_iommu_enable(struct udevice *dev)
 	const struct iommu_ops *ops;
 	int i, count, ret = 0;
 
+	if (!dev_has_ofnode(dev))
+		return 0;
+
 	count = dev_count_phandle_with_args(dev, "iommus",
 					    "#iommu-cells", 0);
 	for (i = 0; i < count; i++) {

-- 
2.51.0

