Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD508CCD1AB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 00:50:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 958E983693;
	Wed, 22 Oct 2025 02:49:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Mwr+d5XK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C6A083692; Wed, 22 Oct 2025 02:49:32 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6C0183692
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 02:49:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H3Hlv1lcH6JQ2JUcvH0/5GcaIekFmjaW428wA2oJY+UtHOj24UwVbJEDa3VWmezRv/xqH16QrtTGkPj9bJuxdv9VldD+HWo4mtmSCvz0/GkZ5m8NC8XsFTAqgRbYmp/QZp825RZWzxcSHebQQE5S5nOB0pvEI/zpH2bbN70Czb8ukensucPNPmE3UXZmHLVi3LXSc3XdB4jwo2gQ/0alt810xTVoBd3BkrpTs+nwNXNo31My6CfvIP1ojCaLqVqsLqSd04uoDzXrGdsXxcS+wzbqSrFJf91Q0q6xW/8gbr7EtjNSwpMSGwLzmFd848ZIuU8iMefcrewJMkEATpCFQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/SQRPc3Hc4UH88lNum2VCgf0D1vjsWPiEjef8utrWY=;
 b=E6hQzkC/ANO44uk89USDaNrV8srzs//J30sNUmh/uk/cSGcESH4oaNjoHOKuHlLrCJA6O3PnxBvIaTp8Bo3P9y48JpVMYZLFvP/HnXk6fvIyejLw/TgBayursnVnntULf2Cz0FycxFYbFrJWYfv/N+ejEJg7/ixQmUfuMSEuK9VfmPEevjen3i9KWhWrb8rRP1SwI2qD5KgwcdGtmBVPZjKnyA27IunDLxTWtJvvBLwrIogZX4+pzVg1sLI3KusMl626DdV1JnXs+xol+/1JZsRpKqh+z/929QJOCIELKwQXqxFAe2YEFZj2DcJEOkQLOsX0NLwICjcEoUVBOHowyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/SQRPc3Hc4UH88lNum2VCgf0D1vjsWPiEjef8utrWY=;
 b=Mwr+d5XKDRTBJevAYqpxCzgonNqpLelMcma8VQ23ckPG7c0rvfenAJ1xQn+2y1aakOCsplosJOdr+YaER/2HINEmPtLo2t5GX53ogfCzCsPNAcCdil7K8dBku3sVLR2q7BVQPd/IaIVeTR7KEfqMAs88uJy+20BzvMWR0GIZkOx3WC2xr7LEksAtvXzwa57nLikbT6UdB6EJyiWmtFpJrqY0TevXTLTJd+Myrstolzs3DSs5397YnWi2OL1oLcIAmo9dX2vGaCIh5X13zA99I1uLXUebSaC9fyhQjS40OgyxNfoNY2GU8GowD1U5BL5cqEZzEGapCffw7tiD6QwC7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Wed, 22 Oct
 2025 00:49:29 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9228.016; Wed, 22 Oct 2025
 00:49:29 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Wed, 22 Oct 2025 08:48:33 +0800
Subject: [PATCH v3 07/12] imx8mm: Enable remoteproc for i.MX8MM EVK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-imx-rproc-v3-v3-7-92273a82c5da@nxp.com>
References: <20251022-imx-rproc-v3-v3-0-92273a82c5da@nxp.com>
In-Reply-To: <20251022-imx-rproc-v3-v3-0-92273a82c5da@nxp.com>
To: u-boot@lists.denx.de, uboot-stm32@st-md-mailman.stormreply.com, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Ye Li <ye.li@nxp.com>, 
 Beleswar Padhi <b-padhi@ti.com>, Udit Kumar <u-kumar1@ti.com>, 
 Hari Nagalla <hnagalla@ti.com>, Andrew Davis <afd@ti.com>, 
 Judith Mendez <jm@ti.com>, Ryan Eatmon <reatmon@ti.com>, 
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761094123; l=762;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=WhxJlOYJm1QpEscetQ7zX35mTqxp6KgHeoG//w+lIkk=;
 b=imEMbsrPPt+2McgjDPiz8y3fWtQXqRJZOUZo3jNIvvrH1KOr7PwTQ2JNRN6zjuDlceijDfxHP
 veKLliKNPqKAmfk5q9gopES/r8DCeFLHCysO32HHZaTn9VvP/d+es5m
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0075.apcprd02.prod.outlook.com
 (2603:1096:4:90::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM0PR04MB6900:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b7e521f-00d9-435f-48e3-08de1104db2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SzhHb0c5YjIxWW9rS2huUjJ4eEdqSDRRbnUxVTI1THlVKytXVlEzVVB5MWNY?=
 =?utf-8?B?dmdJTytHWXlMcTlxZklwU0xZY25JZjRhQS92dVp1RGlFVmg3bE0ySGxuSm9V?=
 =?utf-8?B?c1FmZlRwaXgrZE55Ym85eXBub1l0SzBsa0U1eFEzNzRiVWJmNTEyWVlJa0pE?=
 =?utf-8?B?QVdUSFc2eEFXNlY4Q2dsRzZLLzN6NFdtUis1Q2lOMnQ4c3BsalQrREdkWnQx?=
 =?utf-8?B?dG1uQXFpZWJqVmkreEs2eVVLWG5Ddm13ck9PeVZaalgrWUs1UlhMVXZXenZ1?=
 =?utf-8?B?OE5PdjlSRHVBQkxHS0tJVHppUnlBMVVDZTh0NHV2Nm9Na2ZPdGtOeGo0VjF2?=
 =?utf-8?B?VTZ4NHVuZm80V056RHJHK2NGWEhlV0dDUExWSjAvanpSQzdrVlh1QWNQYjFx?=
 =?utf-8?B?YnFGRDZsS1lSY011VTdWQndhN1ExTWlmcWdNOUJlcXBrT0V5UGt4SVZmSzRi?=
 =?utf-8?B?blFremlmT29kbndvSGFwR1Z5bW4wYzQ3WFpIVHpjMFpCVzI0Nmh3K0hwSSt1?=
 =?utf-8?B?WWFoOC9sSDBkc0dBYWJwdWJub0ZqV2kyUHhEWjE2YjkvRXM2K0VwTUM3c0Zl?=
 =?utf-8?B?ZDFJMUJpQkZkN2dJN3NhTCtnaTVQZ3RNNnFOR29wWnNsT1JzRlVZL0dMaEFC?=
 =?utf-8?B?M1RUWkdCZTN1a3RMb1FheWNNeGVIUVliOXYwMUdhVSt0VnBhWmE1cmJ1eUUy?=
 =?utf-8?B?aUtoM0UwZjVMMGZKd2RTTnkxVklGeXR2cTN6bHcxQlY4cHJBMDJDbmx6RUhY?=
 =?utf-8?B?aDFINUJkS2JZUHM1K01TNWh3RzNIMmZTcm5Rek5LYS9aZnlGZ1p5TEdROEgy?=
 =?utf-8?B?TVJhS2lSbXI4NEdtWjhVTWpJdTY4MTY5Uk9SUDVNNzlmdDFBQTV1K0NkWlFl?=
 =?utf-8?B?S0RCWTBRYlByaE9QR0NhdVA4SERrekhCcmhxNjRHREtGU3RjYmtlZkJYTmJC?=
 =?utf-8?B?cFNLanAxS3lPVXpIZU92VkE2OUVzMkNiTkg2ODZVbHpsSElNZGgxUDhhUFFB?=
 =?utf-8?B?V21MNWIxb3liTzZYTk9USDBUZ2JOZGpXakdSYVZ0L2V5NXJYQ2xYVGdpUkdK?=
 =?utf-8?B?ZGV5SmdOa1drb2pzNzV2dEVhZC9OVjFBT2sxNlZ0L2hDWkRsV1JhOFBhSEZj?=
 =?utf-8?B?YWo2RUlTUHkrOXkvZzFNdENWZzViWlhwWkxOaTRVcVA4TXhwNEtVa3pFVllC?=
 =?utf-8?B?TzJJa3NYZTcwM3JzaEFHdG4rWllCRVlKSjdsUVJ5c0QzZktWdWpvQnVVZkdt?=
 =?utf-8?B?Mzd5VGJxcVdYWUxiTFFvd29oQWZraXUwV25UbEh2b2ZlMFlBMUZSNjl1SXNo?=
 =?utf-8?B?M3lYT2VPUHJsSU4yVUY4V3NscnNIbW8rUmNmY3VoVzVXbWJNTTFOdmFKby81?=
 =?utf-8?B?STk3dnl3VXQwa3FKWmN6RGcybjlwZXJQSjgzMzJBb2F6QTAyd3EyR1BHTEkv?=
 =?utf-8?B?Q0I1b2dkbDRBT3ZpZWYwSm1lWGUxNTFoMlZRdFYrekpFcUlEK2p1cXFrM2JV?=
 =?utf-8?B?d1FaTlR5c1RRZ1NjY0VVdmNRd3JUNVJiRUUzSTRpa0ZWZWtKdE9QbzVRYnB0?=
 =?utf-8?B?QUVJOWt3VnE2Sm5oZUVTYWx3QnBNTmlxVEV1d0xnTnplZHRxVDF6V3ZNZDdF?=
 =?utf-8?B?aGhBMUJveVh6M0d3clRLNE5Ma05YQzlwRkV1dGNJVlQ5OTNCek5xTXZpK2tk?=
 =?utf-8?B?MUNaQnV5TDNmVE1lakd6ZDRBMUY2dS91RkpHY2x6bTVGajVLY1NtQ01TQ09r?=
 =?utf-8?B?S2kxS3lMYnpyTVhncFlGaGNVZVN3dDRrQktkSGZmeHV0YjZMa0tiVTF1YlNz?=
 =?utf-8?B?MzJuT3k5V294T3E4anRCSmdiQmdwUzNyQW5mSFVheURLbmo1Q05TKzFzWXl4?=
 =?utf-8?B?TmkyS3R2b2h5YlFtdzdTejNBeGQxUldWRnVNRjJYMmdGOExPeDZFd1hDMFBE?=
 =?utf-8?B?N1JGTGl4Y0F0ZWR3UDdFYnN1YzdZcHNZcUM3RXkzdUxFYndwb2doRHRHdzY0?=
 =?utf-8?B?eFo2V1RMQStwcjFFS0FRR2krZG53WVJzL29Qbll5SngxYWduMlRpbmltQk1I?=
 =?utf-8?Q?vH1OBF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(7416014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGIrZVNBTkYyeEtVdlMzK3dMSTA3bmh4MUUrTEluWDQ3bDNaVk1LcGY3bTAr?=
 =?utf-8?B?WFZVT09oQk1RSHVWYmMwekJUNGN5V3NjM1AzMFhTYXcreEo3R2F0OHlFcXZx?=
 =?utf-8?B?UHptRFVhczNzTER4VTdNWkZhenRQVnFlYXpISkVjWnVSRkdod2t0NVdHNzVQ?=
 =?utf-8?B?TkhMSE4ySzhLTXQyend1cHJMLzE4bFZZUEVXU1NMNXNrL21Ndy9oZW43UVZZ?=
 =?utf-8?B?Mi9rbWlIL3o0a2hWZEE4NUVwMWt0N1A1TWdhOGtXUTY5aGVBcmF4T25TQXJ5?=
 =?utf-8?B?b1Y1SjJLZHc0M2M5cS9jQmo4c3dmZzRMODE2VHJ2SmpzMFhRU3VTejM1dDNO?=
 =?utf-8?B?ak85Vjk0RFozMXlYUXdVR21Bc0V1Z3Y5M3E4NWZNSjBON0I5L3BxN2tIS3p5?=
 =?utf-8?B?Y0dWaFBHaThCZ0ovd3hSVUpLQVVvRGNzWjhaWUxsWjJIN1cvVjdQSm5rZFNP?=
 =?utf-8?B?M3lQaTB2aFZ0cGhFU09UMUl3RUJFRnh5VXRqTGgxZjdiRlpVNXdBWGFIdHBz?=
 =?utf-8?B?Q1VnN0tNVmZpOHFYL2pRYlc5U3hSemdMS3FrNm82cHNsRERzZ1NSYk4zMllv?=
 =?utf-8?B?cktsSkRDZDhDVDhRTk1peG5ickxFSEJWc0tQSGhhaWN6Y0xDdXFiV0N6aDY4?=
 =?utf-8?B?S0ZwdzN5VnRGZmtUNnBNRnhBSVphQXoyeUFxYUdYVXBYZ3FRSGNBYXNYQjU2?=
 =?utf-8?B?Z2VlelFxWmxYYUJMdzhWRUYweWVyYm5OWnNlTFVxcEFSNXNiajJlMVZkMlpk?=
 =?utf-8?B?dU8ySS9ESFNpMVg0aUJyVGJvYTZXQmVIRHVqYVlGRGlrbmNiZk4vWkFhS2gy?=
 =?utf-8?B?ancyd281Q0xPUjZFaC9KYzFQd0I0SjRacTFzVGdQanM3WGJkNzFMRW5sSnVj?=
 =?utf-8?B?cENEaGFuQkhDSlpnaU10TVBhekthQnRkNDlhS25HbWFHbnJmY2VrVy9ROFN0?=
 =?utf-8?B?MnRQVTJ5TjdkdHBiakx1aGtsM09xZFY3MUhXZ0ltTzI3NlRmWFFPYTdEYmd0?=
 =?utf-8?B?bVUvUTEyUzd2RUw0cDJKSW1seUs5R0xmQnBDVENTUkxDT2xmK2hvZm9Ob3Bn?=
 =?utf-8?B?VjJ3d3Q0TEpWMzNpQVk5VlBDMEk3ZDNjN2FZL0loQWxMbWErL0tjYmhBUVZs?=
 =?utf-8?B?V09UY0xVUDlZNjdYU1pFZ2xLblJ4Qmd4ei96VThxVThLREMvdHFXMVlscVpn?=
 =?utf-8?B?NFVHRVBhUCttSnczS1ZzRFJHSUU1VE1zVDh4ZTZHMG1WN1l4QWhXeEhvajd6?=
 =?utf-8?B?RklBdXo4elB2WTNMYWx5QjBuU28vVHVYUlJxOW1nVmRBSE03dlZLSEpCUUh2?=
 =?utf-8?B?Z3BIQXBjS2dJWWJXUE1IeFZSMkJ6ZlpycTFETkNoaFVwZG8vU21Pb21IRVN5?=
 =?utf-8?B?elFUbFRRaVI2UU1wYUdsN1l5cFVKbGhSZDZZQXBiTTB0emRXWXVNUzhDaDRi?=
 =?utf-8?B?YVhzaEVhK1FnR1NoV013eFZ2enljRlVPRHBtMnBGR25nV0RENVpOdkNJRm5u?=
 =?utf-8?B?RjFubFJSdzBDYlcwcGNwV0ovVmhwczBub3dSeUNGNEJlWWsxVkg2M0sxN3R0?=
 =?utf-8?B?SkczdXlmUTVCTlR4L3FObEloaGovVkgxMkxMM2d2dU4xVXlvSE9kU2RlWFVt?=
 =?utf-8?B?R0t3Q0FWbTU5NHAyenFoRUpkdjZjWTNza3BWVU1JVGxPTUxRNjYyZ2NaMkE1?=
 =?utf-8?B?amxpZmVOb3JHd2dFWERDVlQ5VVY4YkZJYmw3UUhZNGd6TzB2RUZoYW8yS3Jp?=
 =?utf-8?B?a3Y4djhBUU5iUEZETU90dktMZWRiRlJuWU1reHBVVWJxVjFVT2ZMYlBvYTNW?=
 =?utf-8?B?dzNxUjZVU0p2SWlNN0FXUXVFTnJMS3JZak9VT1B5VVFaT3pRdnZVUWhLN21w?=
 =?utf-8?B?WllrS2pLSC9qZmFldjA4YlFyR3pNUTVXQXFkM0d5UGRDaFhYc3pBcE8yMzh0?=
 =?utf-8?B?NXF2MGpXM1dCTWdyQVFBMEJJUXByZUNqbjljNXVXMkJaeFN6bXhYM3N3NjFu?=
 =?utf-8?B?YTA4dy9mTlZxT085alNjZXlzZzJMbDNtUUUzU0M1MG9la29YbUdpdkFaQ05X?=
 =?utf-8?B?REQ5czRRRTVJR1VVblhXR05NZ0ZMWnZwYWFtazZXc082OW11RFl5eW9PM2k3?=
 =?utf-8?Q?MFDLrGsPjQ+P2q4jEaHo3nRMK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b7e521f-00d9-435f-48e3-08de1104db2e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 00:49:29.3120 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yql9eMOQOywx+GhtGmWqJsIDosl6POE+mffCfuMPLXsIV6BKyL8TkeXFpTpG1BbdxEUNFyyqFNN8S7Cfn0nAgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6900
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

Select configs for remoteproc on i.MX8MM EVK boards

Reviewed-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx8m/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index 75d2772617d23f8145e7627723218c0c3944a1b6..35da05e93f5300ccbc77eeb3ad07050768900b94 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -95,6 +95,10 @@ config TARGET_IMX8MM_EVK
 	select FSL_CAAM
 	select ARCH_MISC_INIT
 	select SPL_CRYPTO if SPL
+	select CMD_REMOTEPROC
+	select REMOTEPROC_IMX
+	select REGMAP
+	select SYSCON
 	imply BOOTSTD_FULL
 	imply BOOTSTD_BOOTCOMMAND
 	imply OF_UPSTREAM

-- 
2.37.1

