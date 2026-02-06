Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD4A9EB28F8
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 09:13:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22A8C8382A;
	Fri,  6 Feb 2026 10:12:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ciyc6lF3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F6C983AA7; Fri,  6 Feb 2026 10:12:57 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE0DF836D3
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 10:12:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lw/rzpA/Dsoyy6AZEtk4t5Nq4vjFOfVmY5hmIxn2W8XwGbXmHyKEpgc99PUUHJ66j7GQ4WkY5oylVFkkByGmF0K+bPZpdwwthFzEW/aTCRiugpGjtmy2PpncS5oLIHMsHpf4iAvft1Mpx/m/5AM8bbQripCwNgBmgb0rZWg9B+oUw+VIrYRsmNJi6VgqtGsWQqGxsxgqaPQghbSuT8X2dL14bBrOnuBBu+M/mg8VYkdnNP8cwlWi2Wff/TsEsjE7wC7xF1ZNsvSWruf6uoCnbJZ4Fohtz23LL7B3UGoSruWc80rluIh3+Pw0ls6HKsTj94dK54BDzkDxZD2Pbso5YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=055nSA473VJ4laOWXhZqLbuYu0WfLczWHFOj9SaQH7M=;
 b=DxoYJu0IAMtKxU/aKgWUSuyeeLt8ub3kJ997VIu59Bes5h16uY34fguji/xKPgsSzQy7lqCbdYM10yCRDEjPsW4AUhq2qrnAP5nhbX/RwQLosoK0gq02S2iM1DoN8ASRsAwUZiln1WEw0iA9yrLcwDCkaeLBSO/LmAoUROn1su+YyGCWF2eXwexaWnKR4pG5QoMtCpazNheBaJUloeMFzgRqRGVW9F4Gqjls2ir3oxc0Xk7cSBN2U0nv24et7Tgos1ukIhkNVCZALJxpG1WPpYgVVcjY+HnM+QjIaO3iuXE/BMHcV5R620zXWi47URO5vYLEwcna/BXDsXsqKOAXDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=055nSA473VJ4laOWXhZqLbuYu0WfLczWHFOj9SaQH7M=;
 b=ciyc6lF3b2FFHe3gGVLi/4ZXGQLCRhZ67P0D0n4eMrZIWmgIXsR/q3XEiB4lKDlAwic64NLz1xGmemDL+Cdu1ttPdl6ejlDhIQHd0MAoBJclMjvkji+CYjUIVcvICUG2Ki1rG/isVmeEPgz5SVDgEVBXNoSjyyp2nbFODhoCUGP+b1MNm+Q/8tXuMaUaEYYIK6j2msNQC0ce3OcQymNt4plmWdgUkmhfwU22Hkz3GQtezkTGl9A0fU7o+XyRkV4oqZH3DLsphV8oYATf1m7uTBrr7QG4BzTxd5AcNaQenWFZwEJYwj23RhYTIqE7HqwOItMz+ezOQD+g1sBtAdJTrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by DB9PR04MB8409.eurprd04.prod.outlook.com (2603:10a6:10:244::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Fri, 6 Feb
 2026 09:11:25 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%6]) with mapi id 15.20.9564.016; Fri, 6 Feb 2026
 09:11:25 +0000
Message-ID: <939a9696-27fa-45a1-b428-feffe21ac6d5@oss.nxp.com>
Date: Fri, 6 Feb 2026 17:11:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] scripts/dtc: Update to upstream version
 v1.7.2-35-g52f07dcca47c
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Adriano Cordova <adrianox@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sam Edwards <cfsworks@gmail.com>, Simon Glass <sjg@chromium.org>,
 vigneshr@ti.com, b-padhi@ti.com, n-francis@ti.com, nm@ti.com, afd@ti.com,
 u-kumar1@ti.com, i-sihag@ti.com, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>
References: <20251202193310.149861-1-marek.vasut+renesas@mailbox.org>
 <DFJ950O0QM0D.380U0N16ZO19E@ti.com> <DFJ9947VLHEL.PCDIJCRU24BS@ti.com>
 <20260108141233.GQ3416603@bill-the-cat>
Content-Language: en-US
From: Ye Li <ye.li@oss.nxp.com>
In-Reply-To: <20260108141233.GQ3416603@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::15) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|DB9PR04MB8409:EE_
X-MS-Office365-Filtering-Correlation-Id: b7e07524-ab9f-47ed-330a-08de655fb438
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|1800799024|7416014|376014|19092799006|366016; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MkJXS1krMUhVWFpnSWFZL29jYm9vY3hTMHFEN2NOMVNpMk1NM1lyUWU4eHVY?=
 =?utf-8?B?V0xlWHRvdHFmYnNwamJhSnAyUktTUSsxOWN0dzN6QSsyRGJPRXhRQ1JsVG1k?=
 =?utf-8?B?UHhvMDQ3ZTFiYktncE1LWFhwYlo0N2hBcGgvbnpubllCN0NwVkhnNURXaFJR?=
 =?utf-8?B?VmxtdmQ1RXdhM3E1bHJaK0Y2QXVQRXNJN24yZkZacVBJZzFJVkxUbkFRTzZ0?=
 =?utf-8?B?LzVjY0Y4ZTkvbDU0cWRLWlV2RGt4TzcyTlMyRVNpQTFla1lsemtvK0MwTFJv?=
 =?utf-8?B?N2xRTkxyRTNRdFM3T2U3TENVTVJqdlc5cDNqQlZJNXA4RVgrN1J5NW9UaVlt?=
 =?utf-8?B?L2tVa1RMbVkrakF1bE9ETzlzM1FGanpDWWZqdjZ3aStEeWY1dnFZV2tndTNu?=
 =?utf-8?B?Q25vVnlSbU9lMmdCUEVHalJ4V2N2NklzWk9rbHI3ZGNLNEZQaHpmK1l1K3d1?=
 =?utf-8?B?Z25LSDl5VW1ySFdWQzM4UThSQWF6VmZVS0k0VER1NnYzazFubkFqdjJHdGtl?=
 =?utf-8?B?NmZVYWNCbDRPcXdmT0JNOEtpYVcwVHJXUnF6cjJUSFBTTGhyRjdNUzR2NGFt?=
 =?utf-8?B?MlIzWG5MT2dreTAxNCtONGtGZXM0dU1IdmZZOE1DV3hPMjRhTWtmUlFrTjZi?=
 =?utf-8?B?WUZOQ00xM3IydDZxNG1GT0xIL2FqVHpVeXFSQ3FVa0Q5VStpclJmWmIwbHVr?=
 =?utf-8?B?eXlLOWhXb05mQVBmT2FLQXVVUnF1Qzl4VzdYQVpWMmNUM0V2NkhYcGlXcHNK?=
 =?utf-8?B?L1JLVDB2bCtsMmQ1S3JycnBFQXZRUXBOY294Q09FaEJWVlZUOEp0NHQ1Zy9h?=
 =?utf-8?B?RmV6bnU5RlQyZXJYam51QkdORWxrOEFVYVpSSVpEYmVrWHNhazBJbElzT0dq?=
 =?utf-8?B?ajdzMkR2T2JPZk90SHYxemxRVEJpYU5iOHpFMGxnZHdxTUViVHV4YkRUQXMv?=
 =?utf-8?B?ZlNTbjVHeW5CeGZDeVJ4T0NLWGhNWTJLR3IxemNMV2U5MitBNkJaU1VXV2lK?=
 =?utf-8?B?RWZ3eWtObEFaSGthUGVwOCtiTmZJL3lIUFp3ckpkNDFudzZ6SzZzWXd6aSt3?=
 =?utf-8?B?bTNpcjhFQ3gvdG1kUGxxdXJQNEVCWFExZ00yNWZqdThtN3YxNjV1a2IwZHdF?=
 =?utf-8?B?eTRxcnk1MjduTFRxbWhGY0xBNmtDTWpsRGoxTkQ2d0Nkdi9ucEU4dzEwcDJh?=
 =?utf-8?B?eFdBYlV2OFBvNWkrOHRCSlBaOExaY291N0ExZzVKancrZlBIY0ZzYkp2ZU5m?=
 =?utf-8?B?ZzRXMjVPOGJxbzZQWGJnUC92OVZ2WnpHdlg2OU1RaHd1RlBzcUgrSXVBTVk4?=
 =?utf-8?B?dXZzYnB3WlVjNXhYbXFaemJqMFVGRmZZU2VGaHBsVTNYVmYraGFOWG44M0x3?=
 =?utf-8?B?MGEvZWJMcGtFNURkRG16U3lyMGVwMkkzN200NHBERW5MVi8vZnpNRExsbUxS?=
 =?utf-8?B?YTc5a3UzanY1U2l4N1JlZU4vQmtEVVI4YWVYVlZXR1FISE9WSkZIdzJKbDhO?=
 =?utf-8?B?V21GS1ZNZFgyTUxYYnN6Z1FMcmJvV0k1TkYxbFdyMm1pd3Y5cnFROUpReklP?=
 =?utf-8?B?eXFDVVBIc2JzcW42RXVJVzZrcWZSd3lSU3kweDlkSStuU0NzTEVnK2FKdFB1?=
 =?utf-8?B?NHU4bnc0UCtXdUVrZlNnTzkyaU43Rm9FVXBybXpGMjBsZHE2dUQ0ZGFTc0Fk?=
 =?utf-8?B?TElKS3NvdmhBdHIrN29XQXRnWFNCWXl2OXdRNUwxUk9wYzg0ZXYxM2pIOC8r?=
 =?utf-8?B?U2F3b1dheUV6Rmh2ZTVGNzRTOVBTdFl6QllqUW4ySXNFSEsyRndtQVEwSzFP?=
 =?utf-8?B?WlUyamJmZm5HV0FLWXVyblhJOEg2TmE1T3dYMDd6WGVUaHJtbU05UDBENnF5?=
 =?utf-8?B?YmRqcFlxTys2d3p5d01PRjV0MEJKMXc2YVdHNEdQWXRVTkl3SGdGOEJ2UlNy?=
 =?utf-8?B?NzZsQm1KcHJTeXRrd2xrVm12Z0hMSG9QT1Evek0rdm1TM3dDbzJDWm55M2M5?=
 =?utf-8?B?ajN6bU1CZzg1TWNSNFZJU3RjWWNUaXBkVldmL0tpSjBvTnFRSEFIUDQ4N2pM?=
 =?utf-8?B?QStXTzRCL1VzQWNseVNXK1FETHJ3Z2g1azNsQzQ2a1FiOEZQajc4djFoSGpG?=
 =?utf-8?Q?3r6g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(1800799024)(7416014)(376014)(19092799006)(366016);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OE1BcWMvV3dxWFJJT0h0dlhTOUdJTDNwN2luWWswUWZwTk9NUHBhREllOVBH?=
 =?utf-8?B?VHlZQWVHRDl3TnlmYW40aUtNSzE3Z0JjSWhQQXNJNmJhUEFrK1pwVVJOV2ZN?=
 =?utf-8?B?aE51SkNEbXNSZ2lPZkZFSFh2N0pteE5TV0lmNGwyOENpWjRIbGNKYzR1KzBl?=
 =?utf-8?B?VHNaT3NYQlF0WTloakRONUhLYzNjUUY1YWFuN1F6Rkt1M05YZUtkYzFoa3hy?=
 =?utf-8?B?R0xwcWJIdURNOEp6NHR4Vy83VXhmTVpvcHltWW9iU01VZmp1aXpYSStEQnVu?=
 =?utf-8?B?R2I1YmpPY0FJeHZXYzBsMjlCLzI2NTJqaG9iMGp3clZ6QUhleW0rMFJHT2Vs?=
 =?utf-8?B?ZmhOZDNpblh3dlh5Z1pLQWxKOFhWQkZDMTArU0h3THE5d095VUI1MlUzN0tl?=
 =?utf-8?B?RkUydkM3Znk5cGFkaVpnTnZPMDAyVjllY2Rmek0reDl2MUg0NVBWREkwNEpq?=
 =?utf-8?B?b1lnKzJiQ1liRDdsMy95ZUhOYXB6VENXNVJ2SENnR0NlVThzRSsrRytTbTZt?=
 =?utf-8?B?dnNhaENqZWtBWGxTaEJTb3dDTm5VSmZMbE9HTGtXallHVkpsdHc0UmhxaGJV?=
 =?utf-8?B?Mk1PbzRadlVMRmNkbnA1VGdwZVhMN0ZUblV5MDdtd2ZjT05PWkdUYldSRFdN?=
 =?utf-8?B?UE9rbVlLUFdEWjBPU1JxVjZqN2kxWWFZazByQ0MzWloxMmRNWXhkZGo5VkhF?=
 =?utf-8?B?enNWWGlSOFk0RkxIVGk0cFR2Z0p3dUNFTWh2N2x4aml6eFZ5cFVqUXJWL1Js?=
 =?utf-8?B?VnRKYUJ5bEZjNHV3WG5aYUxLSTFld01VWHpLb2xwRUtjTk5iVUdqc21oTnU1?=
 =?utf-8?B?N09KRVdKbmU2STlSVVFVNlJzbWhOSHNIK0JXNEkzK0lhRHRmb2lNeWt4TkNu?=
 =?utf-8?B?M0Ywc0ttME9pRGw4SVR2UDZsM1dXb0NPNll0MUFUVUlBUS90NUVTRmxVQkFl?=
 =?utf-8?B?M0JVanJ2a3hiMjFOaXM2cUtpUDF5RnRsRVVZdVVDaFRqbU0vSG5SMjZUWmNC?=
 =?utf-8?B?KytWd3J0RTNiWkY3ZUtYSTVQMlloWncvRC83eHR5clk1OE5qMlR6VHU2ZGRX?=
 =?utf-8?B?aWxsbFV1cWQwa2pzWHNZU0hCUC9rM3BtdkVSWFVxeGlvZ2diQ216bUFUZzR0?=
 =?utf-8?B?VDVZR3hYQzZiQUdjaVVuSXR6K1J5OStWeFdGMjlHMGxjeHpJdGtsays5Uk5Z?=
 =?utf-8?B?VXpvQXJpTFUveXBOZW5OWmNPRlVrRlhUZFE3blduV20wUytyNW9JZVRxRkU3?=
 =?utf-8?B?dXJNL3Uzb3p4a2xMM1l6NXY1WXpkZzhMM085a3Y2OFR2S1U1TWVpQTJFVFFK?=
 =?utf-8?B?aU5QcmIwdFloUjRBWGZvMExJOVdWYW5JSzRDRmgwRWs4ejBJRkJVRE9jb2Zl?=
 =?utf-8?B?RTVKMDlLMFRUcmdpbEZvV2wramtiUTNJaVZnbEwzWXNrMkVRNEJIMFdWRDE1?=
 =?utf-8?B?ZldFNmZ4bFp2RVVEenhPYS9xYytRc3YzWXRzakRxN256SEpibDZHWi9FaVFJ?=
 =?utf-8?B?cnBNdmRWc1owNW5nTDhqQ3FMQ2tiVTk1NlZ5RksxajlhK3hNQmEvU3JDR1Zi?=
 =?utf-8?B?eE82WENqc0lQL0pzcWFSQmJiRVZYalBaTklNcjVnbTBUNXg1QWpzR0IzQ0Yz?=
 =?utf-8?B?a2hYRTd6K0QwMGxMalVERm1xTitNVjlhbWV6OFg4ZWpUOEIydFNIU3FGWWlU?=
 =?utf-8?B?MGQ2anJGSFdvSjZyVUliTG5KSkY4elpRMm1tWUUweGhXaG9ORWV1QXdQc1Zt?=
 =?utf-8?B?RWF5WXhicUdTb1lZS3IwNkUxYWRCa2FEK0s0K3JIbTdlT3AyTFhPenFhQXJH?=
 =?utf-8?B?WE9WSVpzOFRMRnA1U2p2TGEzMk5JSjVpMTlyTTF6REl1UXpFMGRiU0hzVjBH?=
 =?utf-8?B?NHZFd2FnYTMwQytNOUl3MXBqeWlxQTNlVkdrbGQxL1JvdXE5UTlneVduak5C?=
 =?utf-8?B?Z0dRTVVvZnpONFRkQnl1KzVhc2hBVlM0bUhQL1ZKWEdJMi9iZC9Uc3F4aVcx?=
 =?utf-8?B?bnVUanFRN0txQ0xWWHlVYTZ3NXdnU05pazhBa1VGQzNqUnlZaVVrQ0VDYnpF?=
 =?utf-8?B?SGp3Z0dVcCtYSjhHd0hLTmRJaGtOUWNBM2RRUm1HOWFRRUtPS1ljSWZMM0xy?=
 =?utf-8?B?UlJrbzlrTERKdkxIZEdQZllhVlRtOGFYWk4yYmJoYjVwajd4bi9UckZzU0JH?=
 =?utf-8?B?SHFZOXYvWTJaQUQyc1hNQ3BOY3NmZis5dmlvR002ZHRpU1daV1dZSGI4K3Fj?=
 =?utf-8?B?N0h6MVZiRmZpbzNKdTFicU9Na1pWbTRoL0ltS2JWWjFQSUhjVGgzY3BvcDNB?=
 =?utf-8?B?V2IyampJNVJpR0NDZW96UC9GQ203d3B4UlBUWXFsNjAzL0xic2piZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e07524-ab9f-47ed-330a-08de655fb438
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 09:11:25.6866 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1NX0Gv5MhZbnt9GnpTcyNVqVFye07v7edvue5rJ2YaZbLXNag3ZTgHqTPS9YTK/O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8409
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

Hi Tom, Marek,

On 1/8/2026 10:12 PM, Tom Rini wrote:
> On Thu, Jan 08, 2026 at 07:21:10PM +0530, Anshul Dalal wrote:
>> CC+: TI folks
>>
>> On Thu Jan 8, 2026 at 7:15 PM IST, Anshul Dalal wrote:
>>> Hi all,
>>>
>>> On Wed Dec 3, 2025 at 1:02 AM IST, Marek Vasut wrote:
>>>> Synchronize local copy of DTC with Linux 6.17 . This includes the
>>>> following picked and squashed commits from Linux kernel. The squash
>>>> was necessary, since the DTC here contains changes which were also
>>>> part of DTC in Linux alraedy, and the squash helped resolve those
>>>> without going back and forth with the changes.
>>>>
>>>> The following commits from Linux are picked:
>>>>
>>>> 8f324cd712df7 # scripts/dtc: consolidate include path options in Makefile
>>>> b5b3d9b63b0ee # scripts/dtc: Add yamltree.c to dtc sources
>>>> 7d97a76f226d6 # scripts/dtc: Update to upstream version v1.4.7-14-gc86da84d30e4
>>>> ea6f243be74e5 # scripts/dtc: Update to upstream version v1.4.7-57-gf267e674d145
>>>> 02d435d4eccd8 # scripts/dtc: Update to upstream version v1.5.0-23-g87963ee20693
>>>> 6e321b7637396 # scripts/dtc: Update to upstream version v1.5.0-30-g702c1b6c0e73
>>>> 9f19ec91a7a35 # scripts/dtc: dtx_diff - add color output support
>>>> 8287d642f38d1 # scripts/dtc: Update to upstream version v1.5.1-22-gc40aeb60b47a
>>>> 4c52deef9225d # scripts/dtc: Revert "yamltree: Ensure consistent bracketing of properties with phandles"
>>>> 5d3827e1452ed # scripts/dtc: Remove unused makefile fragments
>>>> 40dd266887654 # scripts/dtc: Update to upstream version v1.6.0-2-g87a656ae5ff9
>>>> 8d4cf6b6acb59 # scripts/dtc: use pkg-config to include <yaml.h> in non-standard path
>>>> b9bf9ace5ae90 # scripts/dtc: Update to upstream version v1.6.0-11-g9d7888cbf19c
>>>> 69a883b6f5ac0 # scripts/dtc: dtx_diff - make help text formatting consistent
>>>> 8f829108b8aed # scripts/dtc: only append to HOST_EXTRACFLAGS instead of overwriting
>>>> b39b4342ac495 # scripts/dtc: Update to upstream version v1.6.0-31-gcbca977ea121
>>>> 93c6424c486b3 # scripts: dtc: Fetch fdtoverlay.c from external DTC project
>>>> 0dd574a1d75c3 # scripts/dtc: Update to upstream version v1.6.0-51-g183df9e9c2b9
>>>> ec38b5df8a231 # scripts: dtc: Build fdtoverlay tool
>>>> a0c8c431411f5 # scripts: dtc: Remove the unused fdtdump.c file
>>>> e7dc653d4e890 # scripts/dtc: Add missing fdtoverlay to gitignore
>>>> d2bf5d2e3f09c # scripts/dtc: Update to upstream version v1.6.1-19-g0a3a9d3449c8
>>>> a60878f5532d0 # scripts/dtc: dtx_diff: remove broken example from help text
>>>> 8b739d8658a9b # scripts/dtc: Call pkg-config POSIXly correct
>>>> b6eeafa67df00 # scripts/dtc: Update to upstream version v1.6.1-63-g55778a03df61
>>>> f96cc4c787588 # scripts/dtc: Update to upstream version v1.6.1-66-gabbd523bae6e
>>>> 09ab9c092ef2b # scripts/dtc: Update to upstream version v1.7.0-93-g1df7b047fe43
>>>> ded8a5a498f2d # scripts/dtc: Update to upstream version v1.7.0-95-gbcd02b523429
>>>> ee6ff6fca7e71 # scripts/dtc: Update to upstream version v1.7.2-35-g52f07dcca47c
>>>>
>>>> This also includes forward port of U-Boot commit
>>>> e8c2d25845c7 ("libfdt: Revert 6dcb8ba4 from upstream libfdt")
>>>> to avoid binary size growth.
>>>>
>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>>> ---
>>>> Cc: Adriano Cordova <adrianox@gmail.com>
>>>> Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
>>>> Cc: Christian Marangi <ansuelsmth@gmail.com>
>>>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
>>>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>>>> Cc: Sam Edwards <cfsworks@gmail.com>
>>>> Cc: Simon Glass <sjg@chromium.org>
>>>> Cc: Tom Rini <trini@konsulko.com>
>>>> Cc: u-boot@lists.denx.de
>>>
>>> We observed several boot failures on K3 platforms since the addition of
>>> this patch at the R5 SPL stage, the issue seems to be the newly added
>>> check for alignment in fdt_check_header in scripts/dtc/libfdt/fdt.c:95
>>> but the binaries generated don't have 8-byte aligned FDTs.
>>>
>>> I have been able to reproduce the issue on AM62p EVM with a clean
>>> working directory (this is important since any minor change to the
>>> SPL binary size such as by the added "-dirty" tag could make the address
>>> aligned) and GCC 13.3[1].
>>>
>>> Are we ensuring the fdt present in the SPL binary is properly aligned?
> 
> Yes, the device tree must be 8-byte aligned, this is a requirement of
> the device tree spec itself that we had been lax over until now.
We found iMX95/iMX94 EVK boards are broken after this fdt lib update. 
The root cause is default value of CONFIG_SPL_OF_LIBFDT_ASSUME_MASK is 
0xff. In this update, fdt_check_node_offset_ is changed as below to 
check the CONFIG_SPL_OF_LIBFDT_ASSUME_MASK. When it is 0xff, 
fdt_check_node_offset_ will skip offset check.


  int fdt_check_node_offset_(const void *fdt, int offset)
  {
-	if ((offset < 0) || (offset % FDT_TAGSIZE)
-	    || (fdt_next_tag(fdt, offset, &offset) != FDT_BEGIN_NODE))
+	if (!can_assume(VALID_INPUT)
+	    && ((offset < 0) || (offset % FDT_TAGSIZE)))
+		return -FDT_ERR_BADOFFSET;
+
+	if (fdt_next_tag(fdt, offset, &offset) != FDT_BEGIN_NODE)
  		return -FDT_ERR_BADOFFSET;

This cause a problem to SCMI agent uclass driver. In scmi_bind_protocols 
function, a ofnode_null() is used when creating scmi-base.0 device to 
bind with driver. This null node which has offset value -1 can 
successfully pass the fdt_check_node_offset_, so causes crash in 
device_probe()->dev_power_domain_on() when finding power-domains phandle.

I notice the default value of CONFIG_OF_LIBFDT_ASSUME_MASK used by 
u-boot is 0. So why does SPL have different default value? Should we 
change the SPL default value to 0 to align with u-boot? Otherwise, any 
idea for fix.

Best regards,
Ye Li

> 



