Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 828EAEF06FB
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 01:31:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E396183C23;
	Mon,  9 Feb 2026 02:29:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MnvD3f6Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E6F883DC9; Mon,  9 Feb 2026 02:29:29 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5BF783DAE
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 02:29:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lp5BySwB//R91lqMp5DyJcRAJunj2bDNkZW77XRaRBG9kXrU/pZJ+DuJcIsYTfwI3YNAqzMVF06tuc0PkTGWhBN9idT2VQkbngy/OtNv2HYXtUsHiKS+R1pzzfrrb+0n96+vykF2poQT7yT27/6henj3x6GWgvu5oKNuhhBj0KzdAC3JbqSmny2BIQwID+l6z/50TDAbqkjoruwN6EcEnV2TFRmkKjXU9y4xgViUckmG6c3A5HEiya6e9wjqGAJK2Wj6WiduP0SeIviyTlGLqE5fkbzn0pJCZqVGY8ua+soYipLj/GEd09Iyuhcpm4N/UiP6hxm3sY0F4A1+77V5FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cOkbImrUBqKSAs1TsSPYDtUTWeuDlZpIs/PdjZTEjPw=;
 b=yRrn2WX4uLmOe/nRQ4rNzxVa++dJ8i2aylYmfJY/tfR0ylY/dFF1GgtZ0i4rz6Qqau+xP9F5ePddiU/B99YZ04qhxGNUTCaUD0KritaVgDdo5iI4Ln5QZVPsdNLlSUyyc9KeIJrsMHSPnoRDAv7VBDsyGoFyLuQZ+YX65RHfVI93GzLg6rPYyCxxuG7nO/uJI/CUQQJgscbZmiAwBC7vvvT/3eNdZFtXiEmSt/8TxUZg2LUxAMcFwjk1ykud9sU/halXO80vY16JY2kMQz7QPSJfOgv7bgwWDltdGT40ySUhJXPSl6p97IHh575rB0pyQquo6k72bC1bUJwzc1PyQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOkbImrUBqKSAs1TsSPYDtUTWeuDlZpIs/PdjZTEjPw=;
 b=MnvD3f6QEF7eMqaiU60QJln2XEciZKLYXMXxP3aBnzP/fmy4ZOHGzPkSlpbm7QPVwxfvA2cs+IZ/2aDSr+9ljscmGp/d/rThDcT9yKFkidxlIssL/iKmjrfxGD7lFzgve9bGkRlv0qj1wcWgOmPBEgjUOpEAkygq8Ywa10kFDgy3yWa4S6JliAxpXUEEpL6m5dHnR7t5M6v2kVbqErW24py9yJ0GtsUoJTyhMIG2t6jyIbj/ZPPsJ8EJR8QSP2+9+kJW6U604oLHaINBiCaLx+NABxPpjyuFiEePySjb5xrKhnPvgt4h2iQ+dTFm2sC9+4eFXhZQRVIVYA6f2W5EIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8491.eurprd04.prod.outlook.com (2603:10a6:102:1df::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Mon, 9 Feb
 2026 01:29:19 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9587.013; Mon, 9 Feb 2026
 01:29:19 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 09 Feb 2026 09:30:18 +0800
Subject: [PATCH v2 14/14] treewide: Clean up DECLARE_GLOBAL_DATA_PTR usage
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-cleanup-v2-14-73a3a84ddbdb@nxp.com>
References: <20260209-cleanup-v2-0-73a3a84ddbdb@nxp.com>
In-Reply-To: <20260209-cleanup-v2-0-73a3a84ddbdb@nxp.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Peng Fan <peng.fan@nxp.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Anshul Dalal <anshuld@ti.com>, Yao Zi <me@ziyao.cc>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2PR06CA0207.apcprd06.prod.outlook.com
 (2603:1096:4:68::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB8491:EE_
X-MS-Office365-Filtering-Correlation-Id: 75aea70d-a648-45e3-f28e-08de677aa4d8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|19092799006|7053199007|13003099007|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXJha2I0WWFNOWZxb1pzcjdDd0NnRVBxNEVoNzFvVjhGMDNxSUI2Q3hJUjMy?=
 =?utf-8?B?WU85TXJoUUY4ZnI4VmV5cVN4ZmlUWDlWMFVpZUJXb09EOEErS0k0Ukt3Vzdi?=
 =?utf-8?B?VzZEQUN3REZmdU1QenJXR2hIUXRWUTJJS0d4YzFXbmpVYmRFYXFWUUU5MXkz?=
 =?utf-8?B?bHlYcGxFMk9uSFFVVWw0dW9RTVlNdUM1ZDZjRndNTWJzZjZOOEppMGs5SVVE?=
 =?utf-8?B?R2M1RjlLaVB5TkluZEVMRnlDMjRRYkhJdTBmL0t1Yzkxekdiak1pdUNLOFJm?=
 =?utf-8?B?K1BwU1FjTzEwSXQwNEtKK3hmLzZzSDB3ZTdrOXA0WG1xcnZHa0JtdWN6Z1hi?=
 =?utf-8?B?dGdCeHRMQzRReXZxTGh0QkYyMExXa3dVMnZFZlFwWm1VVVpibmxiRlZ1WGVB?=
 =?utf-8?B?K2JHaDNBZXliR2VzT2syNWoyOWFLRDRTVG5ESDdmaWZpV01yRGxNOEE0ZU9h?=
 =?utf-8?B?d21UVUlET3lhQ05MaHg3N28vTlkwMk5rT0JSZ2l1Uzk1azdDYlBhWkNHWlp2?=
 =?utf-8?B?QkRGYXl6aVpuT09ZOExJc2NEdkFDK3VNUU4wd09qeHYrYTdYQVRWdCtCaCtj?=
 =?utf-8?B?TnZMVzRQMFlHcjNuNkVDMm96OXJJekJQSFdzQm1NbzlJb1d0djZOQUQ5a2Ir?=
 =?utf-8?B?ejQ3aUxEZllWQmpHNVVwUEZaUkJJL2tGck9QcmIzTFZ2S1lUQ0tLTVdwOXMy?=
 =?utf-8?B?aGlSRXM4MVNoWE5USWE0bSs0cmI4WUVRRFdtc3FrenNvMTBiQmN3cUc5bHI3?=
 =?utf-8?B?UDBpQ3JZRVVmQlRFbXRMd05QOUd5S0wralhWWkhiZUp6Ums0VFlCWTJXNDZP?=
 =?utf-8?B?QVdORlZ0cGlhR25IWCt3bzRRbmhwTC9wV21zV2luT1NDTGdKSW1MVDI5M21J?=
 =?utf-8?B?SVB6cFFSS21FWmpvS2lobHNFS0dOaUY3K0xpSWxTWmw0a1hZVGV0T1RnQUhO?=
 =?utf-8?B?WUxvQmY0UHo0cWIzNjVPWkJZQnZwdkNDSXRyWldXdGRYdXAzVTlCSE1BMmw4?=
 =?utf-8?B?K0t6d2lxTUhPa29RN1dLT3NBNlZFTTBST2pGNkk2aVZmbEpONDV6MDJ0OStM?=
 =?utf-8?B?TWxFYndZNFgrNGlDS2poTnBCYUpnenRBUnV4cGN0OVJNZzlhUGwySk5kY2Jl?=
 =?utf-8?B?eC9PeTdIM1pUTDhla0xETlJRRS9sRkZmRGJPbGtoS09QK0NYU2ZXM3JlR0RI?=
 =?utf-8?B?TjhwZFduSitJaThRVGJpeGh3WXd5SGorVll6ZkVCVnBiR2pvRzhER1NTTlZq?=
 =?utf-8?B?YUNlTUFKYU1GeWpNWUQvN01PUkF3L3ZBZDZ4bnQ4WUtSSi9mc0gwV1pSVzhr?=
 =?utf-8?B?ZFRwZlRPOHI5ai9vaTJMNXlKRW9vdEkrQ0l4bStheUFiamZsZzBLU0hvSHc4?=
 =?utf-8?B?T0FUVlV0NUZTUDVDS0dlVUVIKy90Snd0dy9vWVVTKzVrRXQrTXZaMktGRHJ4?=
 =?utf-8?B?Y05lMXplSndabHphOTJKam1hYWt1djRZN3pQZVBiL1Q1bE0wdW9FdWVFNExN?=
 =?utf-8?B?ZG9hc3BIaEpTVFl2c1ZGQ1hpNVdvZjFESnNTajNuREl6RmJzVXM1OGcyVFIy?=
 =?utf-8?B?aC9CZ05jRVlrTmRyY01ONDdFM2xGWkNBamxsaWZWbHJrR1ptMEQ2emNoR0cy?=
 =?utf-8?B?YlpzVHJkZ1dQM2dNNkFoMTJZd3F0U2xmNkJpSFB5My94RGFTWS91RFY1bDVU?=
 =?utf-8?B?ODRBZ0ZZbXhDTnVmSUF3Y3FXeTN6S1dPM3VtZjk5b0FFRGxSSnJ4c0ZaTXFW?=
 =?utf-8?B?OUxqR2UzemIwa25UY1l2OUEzSmRYVFBQTXhBUUJuK2FGTmxnSFFhL1VQRnk2?=
 =?utf-8?B?UmVjYW5UWkJuaFljVVQzUGFUVDZvUW9kRDhnUWJHamxZQzQxVDdwRkxKNjc3?=
 =?utf-8?B?elZIOE5FN0g3eGpVT3BtaTdJbm9oMVNIYVhucUZFNFVSYlliREFaNWJkcVZ5?=
 =?utf-8?B?eTgyWU93YXVZNk9wa1Z1QXpxbC9ra3VFNXJmLzNvWDYrMDU0eElNSG9vN2JG?=
 =?utf-8?B?U3J0eU9lTE9sQndQSElmelY0VGNWMnA1dVNEL2ZMK3R4UEhEVVFxaHZac2hs?=
 =?utf-8?B?eWt3VDdoRnNQaWUzMzZ3alUyL1liaWJUSlZVYWFReTQ0SUFTWEV6MkJvUVV2?=
 =?utf-8?B?WHFCVEZULzRMTll0Q0JMUzdXdGpoeWxheDRxVEhhdUVCbTVJZTBmMjhsMEJR?=
 =?utf-8?Q?IZRgYTpSJG5GgO4/CENDZJw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(19092799006)(7053199007)(13003099007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHRTYXduZWZjY0QrR3BvRm9oK3o5TjAyQ0VBdFd1Zjh6aFFrZE1WbVRFekli?=
 =?utf-8?B?cFVSRVFBYmV1UThPY0hGMjZwTEZaandEdDlVUk0xVk5nMnR2YzVHYzNOa2lL?=
 =?utf-8?B?WGpMWW9KU0FYWnFOOFpQTE5mL0N2dmVRWjlma3R4em05TnpjZG9kcXEwNk5t?=
 =?utf-8?B?NjNlSDcrOTg0MWwrOFFDVWxDckE5RUorSlg1OFVDOFN3bzBNMGFadFVsZ0FZ?=
 =?utf-8?B?emplcFpXbHVrUWRxN1hOOW0xa1JLdjR4eVRjQmFuQW45WmhMLzJ6alg0dG1N?=
 =?utf-8?B?UWxCa0ZQcTE5dEJVTUtueVJmRzVTZTcvd0VCYmxjbkJaSTNSdUpOZ0JFNjhp?=
 =?utf-8?B?eVh6V09Eei9BYjBiK3VObk9zTnY5M3pud3dUaFNwK2k3V0VZTGh1UWNRK1hG?=
 =?utf-8?B?UHFRQWNpY2pmYmpnc3lBTHFGdWpVeCtaUGFzMWsxQ1p1b2pEZHdmbEFMczla?=
 =?utf-8?B?VGt4NzNSWHBwTnowTDlrRW1VUHoxUmtROG5NWFNQc0ErQXM0UkkyNUROV2h3?=
 =?utf-8?B?d1dSZ1E5N01tei9pMk94amo1SjhiNUtIZDlmWkFYWW1RNWY1eURqcmFmamlK?=
 =?utf-8?B?RHlmTkxnaXp4b2FyLy9tOVpQTS9YRWl4cGVZMm9UaDg2b1dqeEo3TWx0MW9Q?=
 =?utf-8?B?RWF5SzBsM0xDN1FtT1JYWGE0VzBWNytOa3hWU0YycEluQ01rbzFjeEVvLy9G?=
 =?utf-8?B?V2w4ajJRWlJ1c1JRRVllTjhCbEVIYnlyTk4xaG9rV1FHcXUvUkZqc0g2dVFM?=
 =?utf-8?B?RytwMUVZRitvNll4cDh4Y09RdG1zL3NMWkM2WTAzcU5GS0ZuNHpEZC8vZGhI?=
 =?utf-8?B?ZHRxRUQxM1pzTG42Skp6bXAxaGtyenZmbkg1MStUVGhyaGxYcDBPeXFtb0tu?=
 =?utf-8?B?VzFodGk5V3JTOEJYM3IwSFNXb1V1YXNYbE4zRkw5K1JNNGRzazROZ3NLaWI2?=
 =?utf-8?B?SDhBTzN4b2FBNDR4ZTNUNlVseGtHMHRUck1VdjFmN0JKdzIzUGI5cllFeTZS?=
 =?utf-8?B?Q0dNaElUUytsNExTdk5QRVovcHFTY0RwaWdSNER2bFdGd2pHcFdOblY3bWlH?=
 =?utf-8?B?WTZGaHRXUTVQUk1UUGlMNmkvNlZBczJiQVQxOU5xckdObkRXMThpOHQvN29q?=
 =?utf-8?B?bUwzVUxwb2pmdDRsSU1CendYV1JKWWNNcjRpbTV0Um1LeHlDMHQvVlJ5YTY0?=
 =?utf-8?B?aTFCZS9WalJXVGlTNWptRlM0SWMveWNQU3RIRnRXeXlHeWFjY2JCbEkrNUlx?=
 =?utf-8?B?dW41UnJiQmVQQ2pXUldtRkJ2MnQ1YjAzK2lQUWpucStEZEc2TWhlS0Ryb3ky?=
 =?utf-8?B?cFpOenNhcjRZU21HNVNpZFc0UFJGK0xHUkhWNWJhRzVhMmh0VkVhZCtBQnMy?=
 =?utf-8?B?K1JUN1UvTURRWDVFMGVmdW1sbklEcEFqR0pONXh5cGFDRHhGbnovRjd1cnhz?=
 =?utf-8?B?bzF3T0Vhb3hWNk1vZG4zZXY5d0tDQnQwdkpKNUlxRTV1VmwzVHhNYTZpdEc0?=
 =?utf-8?B?cXpISkZJbGp0TkViZEtoR0tGUllrSHNMVElnNlgyanFxL0l4Um5jQkd3eG04?=
 =?utf-8?B?RE1QMWNIdHMxczU1aGpvVXNUWmpBd2NSWU5LSnBvbVQvaDQ4N1NxcGI0UU9F?=
 =?utf-8?B?VmVvZzhIblBRVjVQVnBLVFkzcWYrenVVTDlteUtrd2M2VS9tTG5MNFZmUjlG?=
 =?utf-8?B?aHhLUllIZjMxem9zT0Y1cnVHbWhwTjUrbnZiWFBiNFhZNVA3eC9FQm55ZEpl?=
 =?utf-8?B?TDYySE5kUDVGcVErMTh1dEZOTVI0SklnTGtFZVd0ZlBWZndtbmFFTXhKa0p5?=
 =?utf-8?B?Q1RzU0M4UEJWL1lrSVNTeTZmVk9kazFuOFNOUVhGRnQ1NUFtVDRkaHZ6QXky?=
 =?utf-8?B?d3BLRDJMSXVuTEE1VEN1NDVjTi9ZZ250OSt5aXlESGZIbEIvWGxnYmZHWHJK?=
 =?utf-8?B?bE1QUU1GWC96ekVtek90SlNYUmtrOXVFaWRWK0Rmak16R3R5K1IzVlZMWWlj?=
 =?utf-8?B?eHYxOXlrMlFIRFo3UXhoQXd1ZmhSc2ZGTlIwc241VVRnYmpOQkRRdjFkK0JN?=
 =?utf-8?B?NzE2U285aFFzU2RBV1ZIUkJObkJnUThLOElOR0VNbnUzR1JGZEVWVzFoMDVO?=
 =?utf-8?B?cEhaRWF5WUF1U1h4YmFjMCtQemRHNGtCWHBKc3Q4Ky9MdmU4T3F1RisvSnJ5?=
 =?utf-8?B?TngzTDJWUGN1QW1jNXBIT015K1d6NG5MbllvZUhYOWdqZWtVeFVublZnZWwv?=
 =?utf-8?B?ZEVNM282OGk2TENzTTJnRmtiSVNlcmhVWjBkMGxCdkNBUldra253akI3Zlo3?=
 =?utf-8?B?bmdBdnNLU1JzK1hiWHoxUW9WaU8xZ3FVMEZoTGJNenNMT2dWWll3Zz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75aea70d-a648-45e3-f28e-08de677aa4d8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 01:29:19.4792 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T+tCOfhcOSx3050vFub8gXOHIK25wYzCumZsfcWs7PT61CSlVN3bMxgCznpgOGGiwTr3ymSyqHODAymnQ6Tz9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8491
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

Remove DECLARE_GLOBAL_DATA_PTR from files where gd is not used, and
drop the unnecessary inclusion of asm/global_data.h.

Headers should be included directly by the files that need them,
rather than indirectly via global_data.h.

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com> #STMicroelectronics boards and STM32MP1 ram test driver
Tested-by: Anshul Dalal <anshuld@ti.com> #TI boards
Acked-by: Yao Zi <me@ziyao.cc> #TH1520
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arc/lib/bootm.c                                        | 3 ---
 arch/arm/cpu/armv7/s5p4418/cpu.c                            | 3 ---
 arch/arm/mach-aspeed/ast2600/spl.c                          | 3 ---
 arch/arm/mach-imx/imx8/clock.c                              | 3 ---
 arch/arm/mach-imx/imx8/fdt.c                                | 3 ---
 arch/arm/mach-imx/imx8/iomux.c                              | 3 ---
 arch/arm/mach-imx/imx8m/clock_imx8mm.c                      | 3 ---
 arch/arm/mach-imx/imx8ulp/cgc.c                             | 3 ---
 arch/arm/mach-imx/imx8ulp/clock.c                           | 3 ---
 arch/arm/mach-imx/imx9/clock.c                              | 3 ---
 arch/arm/mach-imx/imx9/clock_root.c                         | 3 ---
 arch/arm/mach-imx/misc.c                                    | 3 ---
 arch/arm/mach-imx/spl_imx_romapi.c                          | 3 ---
 arch/arm/mach-meson/board-axg.c                             | 3 ---
 arch/arm/mach-meson/board-g12a.c                            | 3 ---
 arch/arm/mach-meson/board-gx.c                              | 3 ---
 arch/arm/mach-socfpga/clock_manager_agilex.c                | 3 ---
 arch/arm/mach-socfpga/clock_manager_agilex5.c               | 3 ---
 arch/arm/mach-socfpga/clock_manager_n5x.c                   | 3 ---
 arch/arm/mach-socfpga/clock_manager_s10.c                   | 3 ---
 arch/arm/mach-socfpga/mailbox_s10.c                         | 3 ---
 arch/arm/mach-socfpga/misc_gen5.c                           | 3 ---
 arch/arm/mach-socfpga/misc_soc64.c                          | 3 ---
 arch/arm/mach-socfpga/mmu-arm64_s10.c                       | 3 ---
 arch/arm/mach-socfpga/reset_manager_s10.c                   | 3 ---
 arch/arm/mach-socfpga/spl_agilex.c                          | 3 ---
 arch/arm/mach-socfpga/spl_agilex5.c                         | 3 ---
 arch/arm/mach-socfpga/spl_agilex7m.c                        | 3 ---
 arch/arm/mach-socfpga/spl_gen5.c                            | 3 ---
 arch/arm/mach-socfpga/spl_n5x.c                             | 3 ---
 arch/arm/mach-socfpga/spl_s10.c                             | 3 ---
 arch/arm/mach-socfpga/system_manager_soc64.c                | 3 ---
 arch/microblaze/lib/bootm.c                                 | 3 ---
 arch/mips/mach-ath79/qca956x/ddr.c                          | 3 ---
 arch/mips/mach-mscc/cpu.c                                   | 3 ---
 arch/mips/mach-mtmips/ddr_cal.c                             | 3 ---
 arch/mips/mach-octeon/cvmx-pko.c                            | 2 --
 arch/nios2/lib/bootm.c                                      | 3 ---
 arch/riscv/cpu/andes/spl.c                                  | 3 ---
 arch/riscv/cpu/cv1800b/dram.c                               | 3 ---
 arch/riscv/cpu/generic/dram.c                               | 3 ---
 arch/riscv/cpu/k230/dram.c                                  | 3 ---
 arch/riscv/cpu/th1520/spl.c                                 | 2 --
 arch/sh/lib/bootm.c                                         | 3 ---
 arch/x86/cpu/ivybridge/model_206ax.c                        | 3 ---
 arch/x86/lib/init_helpers.c                                 | 3 ---
 arch/x86/lib/zimage.c                                       | 3 ---
 arch/xtensa/lib/time.c                                      | 3 ---
 board/BuR/brsmarc1/board.c                                  | 3 ---
 board/BuR/common/common.c                                   | 3 ---
 board/Marvell/octeontx/smc.c                                | 3 ---
 board/Marvell/octeontx2/smc.c                               | 3 ---
 board/advantech/imx8mp_rsb3720a1/imx8mp_rsb3720a1.c         | 2 --
 board/advantech/imx8mp_rsb3720a1/spl.c                      | 2 --
 board/advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c       | 2 --
 board/advantech/imx8qm_rom7720_a1/imx8qm_rom7720_a1.c       | 3 ---
 board/andestech/voyager/voyager.c                           | 3 ---
 board/armltd/vexpress64/vexpress64.c                        | 3 ---
 board/beacon/imx8mm/spl.c                                   | 3 ---
 board/beacon/imx8mn/spl.c                                   | 3 ---
 board/beacon/imx8mp/spl.c                                   | 3 ---
 board/beagle/beagleboneai64/beagleboneai64.c                | 2 --
 board/beagle/beagleplay/beagleplay.c                        | 2 --
 board/broadcom/bcmns/ns.c                                   | 3 ---
 board/cloos/imx8mm_phg/imx8mm_phg.c                         | 3 ---
 board/cloos/imx8mm_phg/spl.c                                | 3 ---
 board/compulab/imx8mm-cl-iot-gate/spl.c                     | 2 --
 board/coreboot/coreboot/coreboot.c                          | 3 ---
 board/cssi/cmpc885/cmpc885.c                                | 2 --
 board/data_modul/imx8mm_edm_sbc/imx8mm_data_modul_edm_sbc.c | 2 --
 board/data_modul/imx8mm_edm_sbc/spl.c                       | 2 --
 board/data_modul/imx8mp_edm_sbc/imx8mp_data_modul_edm_sbc.c | 2 --
 board/data_modul/imx8mp_edm_sbc/spl.c                       | 2 --
 board/dhelectronics/dh_imx8mp/common.c                      | 2 --
 board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c           | 2 --
 board/dhelectronics/dh_imx8mp/spl.c                         | 2 --
 board/emcraft/imx8mp_navqp/spl.c                            | 3 ---
 board/emulation/qemu-riscv/qemu-riscv.c                     | 2 --
 board/engicam/imx8mm/icore_mx8mm.c                          | 2 --
 board/engicam/imx8mm/spl.c                                  | 2 --
 board/engicam/imx8mp/icore_mx8mp.c                          | 3 ---
 board/engicam/imx8mp/spl.c                                  | 3 ---
 board/gdsys/mpc8308/gazerbeam.c                             | 3 ---
 board/google/imx8mq_phanbell/imx8mq_phanbell.c              | 3 ---
 board/highbank/highbank.c                                   | 3 ---
 board/kontron/osm-s-mx8mp/osm-s-mx8mp.c                     | 3 ---
 board/kontron/osm-s-mx93/osm-s-mx93.c                       | 3 ---
 board/kontron/pitx_imx8m/pitx_imx8m.c                       | 2 --
 board/mntre/imx8mq_reform2/imx8mq_reform2.c                 | 3 ---
 board/msc/sm2s_imx8mp/sm2s_imx8mp.c                         | 2 --
 board/msc/sm2s_imx8mp/spl.c                                 | 3 ---
 board/nxp/imx8mm_evk/spl.c                                  | 3 ---
 board/nxp/imx8qm_mek/imx8qm_mek.c                           | 3 ---
 board/nxp/imx8qxp_mek/imx8qxp_mek.c                         | 3 ---
 board/phytec/imx8mp-libra-fpsc/spl.c                        | 3 ---
 board/phytec/phycore_imx8mm/phycore-imx8mm.c                | 3 ---
 board/phytec/phycore_imx8mm/spl.c                           | 3 ---
 board/phytec/phycore_imx8mp/phycore-imx8mp.c                | 3 ---
 board/phytec/phycore_imx8mp/spl.c                           | 3 ---
 board/phytec/phycore_imx93/phycore-imx93.c                  | 3 ---
 board/polyhex/imx8mp_debix_model_a/imx8mp_debix_model_a.c   | 3 ---
 board/polyhex/imx8mp_debix_model_a/spl.c                    | 3 ---
 board/purism/librem5/librem5.c                              | 2 --
 board/purism/librem5/spl.c                                  | 2 --
 board/qualcomm/dragonboard410c/dragonboard410c.c            | 3 ---
 board/qualcomm/dragonboard820c/dragonboard820c.c            | 3 ---
 board/renesas/common/gen3-common.c                          | 3 ---
 board/renesas/common/gen4-common.c                          | 3 ---
 board/renesas/common/gen5-common.c                          | 3 ---
 board/ronetix/imx8mq-cm/imx8mq_cm.c                         | 2 --
 board/samsung/common/exynos5-dt.c                           | 3 ---
 board/samsung/common/misc.c                                 | 3 ---
 board/st/stm32f429-discovery/stm32f429-discovery.c          | 3 ---
 board/st/stm32f429-evaluation/stm32f429-evaluation.c        | 3 ---
 board/st/stm32f469-discovery/stm32f469-discovery.c          | 3 ---
 board/st/stm32f746-disco/stm32f746-disco.c                  | 3 ---
 board/st/stm32h743-disco/stm32h743-disco.c                  | 3 ---
 board/st/stm32h743-eval/stm32h743-eval.c                    | 3 ---
 board/st/stm32h747-disco/stm32h747-disco.c                  | 3 ---
 board/st/stm32h750-art-pi/stm32h750-art-pi.c                | 3 ---
 board/technexion/pico-imx8mq/pico-imx8mq.c                  | 3 ---
 board/ti/am62x/evm.c                                        | 2 --
 board/ti/am64x/evm.c                                        | 2 --
 board/ti/j784s4/evm.c                                       | 2 --
 board/toradex/apalis-imx8/apalis-imx8.c                     | 3 ---
 board/toradex/apalis_t30/apalis_t30.c                       | 3 ---
 board/toradex/colibri-imx8x/colibri-imx8x.c                 | 3 ---
 board/toradex/colibri_t20/colibri_t20.c                     | 3 ---
 board/toradex/common/tdx-cfg-block.c                        | 3 ---
 board/toradex/smarc-imx8mp/smarc-imx8mp.c                   | 3 ---
 board/toradex/smarc-imx8mp/spl.c                            | 3 ---
 board/toradex/verdin-imx8mm/spl.c                           | 3 ---
 board/toradex/verdin-imx8mm/verdin-imx8mm.c                 | 3 ---
 board/toradex/verdin-imx8mp/spl.c                           | 3 ---
 board/toradex/verdin-imx8mp/verdin-imx8mp.c                 | 3 ---
 board/xilinx/zynq/bootimg.c                                 | 3 ---
 boot/bootmeth-uclass.c                                      | 2 --
 boot/fdt_simplefb.c                                         | 3 ---
 boot/image-sig.c                                            | 2 --
 boot/image.c                                                | 3 ---
 cmd/bloblist.c                                              | 3 ---
 cmd/bootefi.c                                               | 3 ---
 cmd/bootm.c                                                 | 3 ---
 cmd/date.c                                                  | 3 ---
 cmd/mem.c                                                   | 3 ---
 cmd/sound.c                                                 | 3 ---
 cmd/spl.c                                                   | 3 ---
 common/cli_hush.c                                           | 3 ---
 common/stdio.c                                              | 3 ---
 drivers/block/sandbox.c                                     | 3 ---
 drivers/bootcount/pmic_pfuze100.c                           | 2 --
 drivers/cache/sandbox_cache.c                               | 3 ---
 drivers/clk/altera/clk-agilex.c                             | 3 ---
 drivers/clk/altera/clk-agilex5.c                            | 3 ---
 drivers/clk/altera/clk-mem-n5x.c                            | 3 ---
 drivers/clk/altera/clk-n5x.c                                | 3 ---
 drivers/clk/rockchip/clk_px30.c                             | 3 ---
 drivers/clk/rockchip/clk_rk3308.c                           | 3 ---
 drivers/clk/rockchip/clk_rk3528.c                           | 2 --
 drivers/clk/rockchip/clk_rk3568.c                           | 2 --
 drivers/clk/rockchip/clk_rk3576.c                           | 2 --
 drivers/clk/rockchip/clk_rk3588.c                           | 2 --
 drivers/clk/rockchip/clk_rv1108.c                           | 3 ---
 drivers/clk/rockchip/clk_rv1126.c                           | 2 --
 drivers/cpu/bcm283x_cpu.c                                   | 3 ---
 drivers/cpu/cpu-uclass.c                                    | 2 --
 drivers/cpu/imx8_cpu.c                                      | 3 ---
 drivers/cpu/mtk_cpu.c                                       | 3 ---
 drivers/firmware/arm-ffa/arm-ffa-uclass.c                   | 3 ---
 drivers/firmware/arm-ffa/arm-ffa.c                          | 3 ---
 drivers/firmware/arm-ffa/ffa-emul-uclass.c                  | 3 ---
 drivers/firmware/arm-ffa/sandbox_ffa.c                      | 3 ---
 drivers/gpio/gpio-uclass.c                                  | 3 ---
 drivers/gpio/nx_gpio.c                                      | 3 ---
 drivers/i2c/mxc_i2c.c                                       | 3 ---
 drivers/i2c/nx_i2c.c                                        | 3 ---
 drivers/i2c/ocores_i2c.c                                    | 3 ---
 drivers/i2c/soft_i2c.c                                      | 3 ---
 drivers/i2c/synquacer_i2c.c                                 | 2 --
 drivers/mailbox/imx-mailbox.c                               | 2 --
 drivers/misc/atsha204a-i2c.c                                | 3 ---
 drivers/misc/fs_loader.c                                    | 3 ---
 drivers/misc/imx8/fuse.c                                    | 3 ---
 drivers/mmc/ca_dw_mmc.c                                     | 3 ---
 drivers/mmc/f_sdh30.c                                       | 2 --
 drivers/mmc/jz_mmc.c                                        | 3 ---
 drivers/mmc/msm_sdhci.c                                     | 3 ---
 drivers/mmc/mv_sdhci.c                                      | 3 ---
 drivers/mtd/nand/raw/pxa3xx_nand.c                          | 3 ---
 drivers/mtd/nand/raw/tegra_nand.c                           | 3 ---
 drivers/mtd/nvmxip/nvmxip_qspi.c                            | 3 ---
 drivers/mtd/spi/sf-uclass.c                                 | 3 ---
 drivers/net/dwmac_s700.c                                    | 3 ---
 drivers/net/fec_mxc.c                                       | 3 ---
 drivers/net/gmac_rockchip.c                                 | 2 --
 drivers/net/mvneta.c                                        | 3 ---
 drivers/net/octeontx/smi.c                                  | 3 ---
 drivers/net/phy/fixed.c                                     | 3 ---
 drivers/net/phy/phy.c                                       | 3 ---
 drivers/net/phy/xilinx_gmii2rgmii.c                         | 3 ---
 drivers/net/sandbox-raw.c                                   | 3 ---
 drivers/net/sandbox.c                                       | 3 ---
 drivers/net/ti/keystone_net.c                               | 3 ---
 drivers/net/xilinx_axi_emac.c                               | 3 ---
 drivers/pci/pci_octeontx.c                                  | 3 ---
 drivers/pci/pcie_dw_meson.c                                 | 3 ---
 drivers/pci/pcie_dw_qcom.c                                  | 3 ---
 drivers/pci/pcie_dw_rockchip.c                              | 3 ---
 drivers/pci/pcie_dw_ti.c                                    | 3 ---
 drivers/pci/pcie_layerscape.c                               | 3 ---
 drivers/pci/pcie_starfive_jh7110.c                          | 3 ---
 drivers/pci_endpoint/pci_ep-uclass.c                        | 3 ---
 drivers/phy/marvell/comphy_core.c                           | 3 ---
 drivers/phy/omap-usb2-phy.c                                 | 3 ---
 drivers/phy/rockchip/phy-rockchip-pcie.c                    | 3 ---
 drivers/phy/rockchip/phy-rockchip-typec.c                   | 3 ---
 drivers/pinctrl/mtmips/pinctrl-mt7628.c                     | 3 ---
 drivers/pinctrl/nexell/pinctrl-nexell.c                     | 3 ---
 drivers/pinctrl/nexell/pinctrl-s5pxx18.c                    | 3 ---
 drivers/pinctrl/nxp/pinctrl-imx-mmio.c                      | 3 ---
 drivers/pinctrl/nxp/pinctrl-imx.c                           | 3 ---
 drivers/pinctrl/nxp/pinctrl-imx8.c                          | 3 ---
 drivers/pinctrl/nxp/pinctrl-mxs.c                           | 3 ---
 drivers/power/domain/imx8m-power-domain.c                   | 3 ---
 drivers/power/pmic/bd71837.c                                | 3 ---
 drivers/power/pmic/mc34708.c                                | 3 ---
 drivers/power/pmic/mp5416.c                                 | 3 ---
 drivers/power/pmic/pca9450.c                                | 3 ---
 drivers/power/regulator/pwm_regulator.c                     | 3 ---
 drivers/pwm/pwm-sifive.c                                    | 3 ---
 drivers/pwm/rk_pwm.c                                        | 3 ---
 drivers/pwm/sunxi_pwm.c                                     | 3 ---
 drivers/ram/stm32mp1/stm32mp1_tests.c                       | 3 ---
 drivers/reboot-mode/reboot-mode-gpio.c                      | 2 --
 drivers/reboot-mode/reboot-mode-rtc.c                       | 2 --
 drivers/remoteproc/rproc-uclass.c                           | 2 --
 drivers/serial/ns16550.c                                    | 3 ---
 drivers/serial/sandbox.c                                    | 3 ---
 drivers/serial/serial_adi_uart4.c                           | 2 --
 drivers/serial/serial_htif.c                                | 3 ---
 drivers/serial/serial_xen.c                                 | 3 ---
 drivers/smem/msm_smem.c                                     | 3 ---
 drivers/spi/ca_sflash.c                                     | 3 ---
 drivers/spi/microchip_coreqspi.c                            | 2 --
 drivers/spi/mvebu_a3700_spi.c                               | 3 ---
 drivers/spi/omap3_spi.c                                     | 3 ---
 drivers/spi/spi-sunxi.c                                     | 3 ---
 drivers/spi/spi-synquacer.c                                 | 2 --
 drivers/spi/spi-uclass.c                                    | 3 ---
 drivers/spi/tegra210_qspi.c                                 | 3 ---
 drivers/spmi/spmi-msm.c                                     | 3 ---
 drivers/thermal/imx_tmu.c                                   | 3 ---
 drivers/timer/ostm_timer.c                                  | 3 ---
 drivers/timer/sp804_timer.c                                 | 3 ---
 drivers/usb/common/common.c                                 | 3 ---
 drivers/usb/phy/rockchip_usb2_phy.c                         | 3 ---
 drivers/usb/tcpm/tcpm.c                                     | 2 --
 drivers/video/hx8238d.c                                     | 2 --
 drivers/video/imx/mxc_ipuv3_fb.c                            | 3 ---
 drivers/video/nexell_display.c                              | 3 ---
 drivers/video/rockchip/rk_lvds.c                            | 3 ---
 drivers/video/rockchip/rk_mipi.c                            | 3 ---
 drivers/video/sandbox_sdl.c                                 | 3 ---
 drivers/video/tidss/tidss_drv.c                             | 2 --
 drivers/video/zynqmp/zynqmp_dpsub.c                         | 3 ---
 drivers/watchdog/armada-37xx-wdt.c                          | 3 ---
 drivers/watchdog/at91sam9_wdt.c                             | 3 ---
 drivers/watchdog/mt7621_wdt.c                               | 3 ---
 drivers/watchdog/orion_wdt.c                                | 3 ---
 drivers/watchdog/sbsa_gwdt.c                                | 3 ---
 drivers/watchdog/wdt-uclass.c                               | 3 ---
 fs/fs.c                                                     | 3 ---
 fs/ubifs/ubifs.c                                            | 3 ---
 include/relocate.h                                          | 2 --
 lib/efi_loader/efi_capsule.c                                | 3 ---
 lib/efi_loader/efi_gop.c                                    | 3 ---
 lib/efi_loader/efi_rng.c                                    | 3 ---
 net/eth-uclass.c                                            | 3 ---
 net/tftp.c                                                  | 3 ---
 net/wget.c                                                  | 3 ---
 test/cmd/exit.c                                             | 3 ---
 test/cmd/test_echo.c                                        | 3 ---
 test/cmd/test_pause.c                                       | 3 ---
 test/dm/blk.c                                               | 3 ---
 test/dm/i3c.c                                               | 2 --
 test/lib/test_print.c                                       | 3 ---
 test/log/log_filter.c                                       | 3 ---
 287 files changed, 810 deletions(-)

diff --git a/arch/arc/lib/bootm.c b/arch/arc/lib/bootm.c
index b143392ee6c2c16a4da87dc375c45bcf969474c6..91bce5235a554ef9d48a256fb3e67ba51304e236 100644
--- a/arch/arc/lib/bootm.c
+++ b/arch/arc/lib/bootm.c
@@ -10,9 +10,6 @@
 #include <irq_func.h>
 #include <log.h>
 #include <asm/cache.h>
-#include <asm/global_data.h>
-
-DECLARE_GLOBAL_DATA_PTR;
 
 static int cleanup_before_linux(void)
 {
diff --git a/arch/arm/cpu/armv7/s5p4418/cpu.c b/arch/arm/cpu/armv7/s5p4418/cpu.c
index 27ffb450378f5b3edf9d66ad8e4ef093551fe188..2c5504395594f7079bd08b50d788669efb357501 100644
--- a/arch/arm/cpu/armv7/s5p4418/cpu.c
+++ b/arch/arm/cpu/armv7/s5p4418/cpu.c
@@ -7,7 +7,6 @@
 #include <command.h>
 #include <asm/system.h>
 #include <asm/cache.h>
-#include <asm/global_data.h>
 #include <asm/sections.h>
 #include <asm/io.h>
 #include <asm/arch/nexell.h>
@@ -15,8 +14,6 @@
 #include <asm/arch/tieoff.h>
 #include <cpu_func.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #ifndef	CONFIG_ARCH_CPU_INIT
 #error must be define the macro "CONFIG_ARCH_CPU_INIT"
 #endif
diff --git a/arch/arm/mach-aspeed/ast2600/spl.c b/arch/arm/mach-aspeed/ast2600/spl.c
index 0c5a82ed0947bcbbd8376cf73c1f685186f654bb..60f2c5d291e3fe8adb7c1b6513b993ec291fd9ac 100644
--- a/arch/arm/mach-aspeed/ast2600/spl.c
+++ b/arch/arm/mach-aspeed/ast2600/spl.c
@@ -9,9 +9,6 @@
 #include <linux/err.h>
 #include <asm/io.h>
 #include <asm/arch/scu_ast2600.h>
-#include <asm/global_data.h>
-
-DECLARE_GLOBAL_DATA_PTR;
 
 void board_init_f(ulong dummy)
 {
diff --git a/arch/arm/mach-imx/imx8/clock.c b/arch/arm/mach-imx/imx8/clock.c
index 4e49b5bf3755a91ec89eeb7416c857c4a87393c2..e37d3bf31e450841e8c19f8dc4e08dd4edca4005 100644
--- a/arch/arm/mach-imx/imx8/clock.c
+++ b/arch/arm/mach-imx/imx8/clock.c
@@ -3,12 +3,9 @@
  * Copyright 2018 NXP
  */
 
-#include <asm/global_data.h>
 #include <linux/errno.h>
 #include <asm/arch/clock.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 u32 mxc_get_clock(enum mxc_clock clk)
 {
 	switch (clk) {
diff --git a/arch/arm/mach-imx/imx8/fdt.c b/arch/arm/mach-imx/imx8/fdt.c
index ce78c8ce919a1c7e3e792c1b13316f8cf3454dbf..8337edc2f62b8a02418efa706f95ca1612e214a9 100644
--- a/arch/arm/mach-imx/imx8/fdt.c
+++ b/arch/arm/mach-imx/imx8/fdt.c
@@ -6,7 +6,6 @@
 #include <log.h>
 #include <firmware/imx/sci/sci.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
 #include <dm/ofnode.h>
 #include <fdt_support.h>
 #include <linux/libfdt.h>
@@ -14,8 +13,6 @@
 #include <cpu.h>
 #include <dm.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static bool check_owned_resource(sc_rsrc_t rsrc_id)
 {
 	bool owned;
diff --git a/arch/arm/mach-imx/imx8/iomux.c b/arch/arm/mach-imx/imx8/iomux.c
index 3e27d75827a5f4469275d3ffc6906afb538fd3c5..b6175a50226ccc941260807badb38cdfce04f44c 100644
--- a/arch/arm/mach-imx/imx8/iomux.c
+++ b/arch/arm/mach-imx/imx8/iomux.c
@@ -4,13 +4,10 @@
  */
 
 #include <log.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/arch/iomux.h>
 #include <firmware/imx/sci/sci.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 /*
  * configures a single pad in the iomuxer
  */
diff --git a/arch/arm/mach-imx/imx8m/clock_imx8mm.c b/arch/arm/mach-imx/imx8m/clock_imx8mm.c
index 77c8efc7899cc33c0c0be94a20925434e10249cc..b7b3702041ee418a6f3c517cc99cd37aa9597ba9 100644
--- a/arch/arm/mach-imx/imx8m/clock_imx8mm.c
+++ b/arch/arm/mach-imx/imx8m/clock_imx8mm.c
@@ -8,7 +8,6 @@
 #include <asm/arch/clock.h>
 #include <asm/arch/imx-regs.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <div64.h>
 #include <errno.h>
@@ -16,8 +15,6 @@
 #include <linux/delay.h>
 #include <phy.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static struct anamix_pll *ana_pll = (struct anamix_pll *)ANATOP_BASE_ADDR;
 
 static u32 get_root_clk(enum clk_root_index clock_id);
diff --git a/arch/arm/mach-imx/imx8ulp/cgc.c b/arch/arm/mach-imx/imx8ulp/cgc.c
index f9d8ed5b048b616cac1b1398f906444beed09ae2..69585a3605b6be75b44b092752dc138b82287496 100644
--- a/arch/arm/mach-imx/imx8ulp/cgc.c
+++ b/arch/arm/mach-imx/imx8ulp/cgc.c
@@ -10,12 +10,9 @@
 #include <asm/arch/cgc.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
 #include <linux/delay.h>
 #include <hang.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static struct cgc1_regs *cgc1_regs = (struct cgc1_regs *)0x292C0000UL;
 static struct cgc2_regs *cgc2_regs = (struct cgc2_regs *)0x2da60000UL;
 
diff --git a/arch/arm/mach-imx/imx8ulp/clock.c b/arch/arm/mach-imx/imx8ulp/clock.c
index c390f20d7694660f039ada2a595f3df5facfe8a6..1b5cbd56f50ba4df08f18154c8a7eeadfef28346 100644
--- a/arch/arm/mach-imx/imx8ulp/clock.c
+++ b/arch/arm/mach-imx/imx8ulp/clock.c
@@ -12,11 +12,8 @@
 #include <asm/arch/pcc.h>
 #include <asm/arch/cgc.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
 #include <linux/delay.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define PLL_USB_EN_USB_CLKS_MASK	(0x01 << 6)
 #define PLL_USB_PWR_MASK		(0x01 << 12)
 #define PLL_USB_ENABLE_MASK		(0x01 << 13)
diff --git a/arch/arm/mach-imx/imx9/clock.c b/arch/arm/mach-imx/imx9/clock.c
index e65cabef2c96a3e707112ba07a646fd5babbbe6a..14a2bdf5762fab557c4a0e9c7733e4224ec7111f 100644
--- a/arch/arm/mach-imx/imx9/clock.c
+++ b/arch/arm/mach-imx/imx9/clock.c
@@ -10,7 +10,6 @@
 #include <asm/arch/imx-regs.h>
 #include <asm/arch/ccm_regs.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <div64.h>
 #include <errno.h>
@@ -19,8 +18,6 @@
 #include <log.h>
 #include <phy.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static struct anatop_reg *ana_regs = (struct anatop_reg *)ANATOP_BASE_ADDR;
 
 static struct imx_intpll_rate_table imx9_intpll_tbl[] = {
diff --git a/arch/arm/mach-imx/imx9/clock_root.c b/arch/arm/mach-imx/imx9/clock_root.c
index 5dbc398e97f8b79e367eef9079b7cb6ad066360a..acf79a40584ee8ea90c586847ca95816ad73c087 100644
--- a/arch/arm/mach-imx/imx9/clock_root.c
+++ b/arch/arm/mach-imx/imx9/clock_root.c
@@ -11,11 +11,8 @@
 #include <asm/arch/clock.h>
 #include <asm/arch/imx-regs.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
 #include <linux/iopoll.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static struct ccm_reg *ccm_reg = (struct ccm_reg *)CCM_BASE_ADDR;
 
 static enum ccm_clk_src clk_root_mux[][4] = {
diff --git a/arch/arm/mach-imx/misc.c b/arch/arm/mach-imx/misc.c
index 7452b82f110557726d66c458f4cd69589118b525..90d91b2300ad1273463451f7757abf92f14c7efb 100644
--- a/arch/arm/mach-imx/misc.c
+++ b/arch/arm/mach-imx/misc.c
@@ -6,14 +6,11 @@
 #include <lmb.h>
 #include <log.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
 #include <asm/io.h>
 #include <asm/mach-imx/regs-common.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 /* 1 second delay should be plenty of time for block reset. */
 #define	RESET_MAX_TIMEOUT	1000000
 
diff --git a/arch/arm/mach-imx/spl_imx_romapi.c b/arch/arm/mach-imx/spl_imx_romapi.c
index b7008df8e35ad381ea6e75d02e372c74b65a5817..d36536e600e50ec930f70b5684e658d005cb25d2 100644
--- a/arch/arm/mach-imx/spl_imx_romapi.c
+++ b/arch/arm/mach-imx/spl_imx_romapi.c
@@ -7,13 +7,10 @@
 #include <image.h>
 #include <imx_container.h>
 #include <log.h>
-#include <asm/global_data.h>
 #include <linux/libfdt.h>
 #include <spl.h>
 #include <asm/arch/sys_proto.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 /* Caller need ensure the offset and size to align with page size */
 ulong spl_romapi_raw_seekable_read(u32 offset, u32 size, void *buf)
 {
diff --git a/arch/arm/mach-meson/board-axg.c b/arch/arm/mach-meson/board-axg.c
index 6535539184ccfbb4cb891f5510a8c63ad274d602..542792cad1b47423a95f6788be404cb9c14722b5 100644
--- a/arch/arm/mach-meson/board-axg.c
+++ b/arch/arm/mach-meson/board-axg.c
@@ -10,13 +10,10 @@
 #include <asm/arch/eth.h>
 #include <asm/arch/axg.h>
 #include <asm/arch/mem.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/armv8/mmu.h>
 #include <linux/sizes.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 int meson_get_boot_device(void)
 {
 	return readl(AXG_AO_SEC_GP_CFG0) & AXG_AO_BOOT_DEVICE;
diff --git a/arch/arm/mach-meson/board-g12a.c b/arch/arm/mach-meson/board-g12a.c
index dc4abe1e107469c8cdd3917fcecbcbb774632449..17722cb897d312e83fed6bca944fcb9ce4f23d53 100644
--- a/arch/arm/mach-meson/board-g12a.c
+++ b/arch/arm/mach-meson/board-g12a.c
@@ -12,13 +12,10 @@
 #include <asm/arch/g12a.h>
 #include <asm/arch/mem.h>
 #include <asm/arch/meson-vpu.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/armv8/mmu.h>
 #include <linux/sizes.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 int meson_get_boot_device(void)
 {
 	return readl(G12A_AO_SEC_GP_CFG0) & G12A_AO_BOOT_DEVICE;
diff --git a/arch/arm/mach-meson/board-gx.c b/arch/arm/mach-meson/board-gx.c
index 0370ed57e205073f431175eea9911e0d31861dab..d5c506df22b30177c1d02845124e0d0d544a5ce6 100644
--- a/arch/arm/mach-meson/board-gx.c
+++ b/arch/arm/mach-meson/board-gx.c
@@ -11,14 +11,11 @@
 #include <asm/arch/gx.h>
 #include <asm/arch/mem.h>
 #include <asm/arch/meson-vpu.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/armv8/mmu.h>
 #include <linux/printk.h>
 #include <linux/sizes.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 int meson_get_boot_device(void)
 {
 	return readl(GX_AO_SEC_GP_CFG0) & GX_AO_BOOT_DEVICE;
diff --git a/arch/arm/mach-socfpga/clock_manager_agilex.c b/arch/arm/mach-socfpga/clock_manager_agilex.c
index 9987d5bcee6fab4f4ce102c8e748dbcfbb032278..95c7f044952b05d7e935893bf4631e00ff209243 100644
--- a/arch/arm/mach-socfpga/clock_manager_agilex.c
+++ b/arch/arm/mach-socfpga/clock_manager_agilex.c
@@ -10,12 +10,9 @@
 #include <malloc.h>
 #include <asm/arch/clock_manager.h>
 #include <asm/arch/system_manager.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <dt-bindings/clock/agilex-clock.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static ulong cm_get_rate_dm(u32 id)
 {
 	struct udevice *dev;
diff --git a/arch/arm/mach-socfpga/clock_manager_agilex5.c b/arch/arm/mach-socfpga/clock_manager_agilex5.c
index 7ec28d91ef326222e880ea8920575c09cbe96ab4..fa068a9eeb16a67f41d3c2cabf65e04bb8f0d9d6 100644
--- a/arch/arm/mach-socfpga/clock_manager_agilex5.c
+++ b/arch/arm/mach-socfpga/clock_manager_agilex5.c
@@ -14,7 +14,6 @@
 #include <stdio.h>
 #include <time.h>
 #include <vsprintf.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
@@ -23,8 +22,6 @@
 #include <asm/arch/system_manager.h>
 #include <dt-bindings/clock/agilex5-clock.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static ulong cm_get_rate_dm(u32 id)
 {
 	struct udevice *dev;
diff --git a/arch/arm/mach-socfpga/clock_manager_n5x.c b/arch/arm/mach-socfpga/clock_manager_n5x.c
index c4c071330fc34857396b91aa1bd4d29895be1047..8e47b4b8f5bda1b6e1e71a91e16b2e4a427c48c1 100644
--- a/arch/arm/mach-socfpga/clock_manager_n5x.c
+++ b/arch/arm/mach-socfpga/clock_manager_n5x.c
@@ -6,15 +6,12 @@
 
 #include <asm/arch/clock_manager.h>
 #include <asm/arch/system_manager.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <clk.h>
 #include <dm.h>
 #include <dt-bindings/clock/n5x-clock.h>
 #include <malloc.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static ulong cm_get_rate_dm(u32 id)
 {
 	struct udevice *dev;
diff --git a/arch/arm/mach-socfpga/clock_manager_s10.c b/arch/arm/mach-socfpga/clock_manager_s10.c
index d6c64e9801076824a32c096b9260a58fd25b01f5..fd27470f967f87ab2f32bad53d405bdf47c88fff 100644
--- a/arch/arm/mach-socfpga/clock_manager_s10.c
+++ b/arch/arm/mach-socfpga/clock_manager_s10.c
@@ -7,14 +7,11 @@
 #include <compiler.h>
 #include <dm/device.h>
 #include <linux/errno.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/arch/clock_manager.h>
 #include <asm/arch/handoff_soc64.h>
 #include <asm/arch/system_manager.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 /*
  * function to write the bypass register which requires a poll of the
  * busy bit
diff --git a/arch/arm/mach-socfpga/mailbox_s10.c b/arch/arm/mach-socfpga/mailbox_s10.c
index f9c34e857117bd5c5e2ef62630fc12e85fd325d7..5e8768168d3f14da8bfe67d138f0a7919ca428e7 100644
--- a/arch/arm/mach-socfpga/mailbox_s10.c
+++ b/arch/arm/mach-socfpga/mailbox_s10.c
@@ -8,15 +8,12 @@
 #include <asm/arch/mailbox_s10.h>
 #include <asm/arch/smc_api.h>
 #include <asm/arch/system_manager.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/secure.h>
 #include <asm/system.h>
 #include <hang.h>
 #include <wait_bit.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define MBOX_READL(reg)			\
 	 readl(SOCFPGA_MAILBOX_ADDRESS + (reg))
 
diff --git a/arch/arm/mach-socfpga/misc_gen5.c b/arch/arm/mach-socfpga/misc_gen5.c
index 5259ef54d734aa0575a05c05e26da7280fba7c59..ae33051c00f23d26ecdd1a010de1f3eff4d60e71 100644
--- a/arch/arm/mach-socfpga/misc_gen5.c
+++ b/arch/arm/mach-socfpga/misc_gen5.c
@@ -6,7 +6,6 @@
 #include <config.h>
 #include <cpu_func.h>
 #include <init.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <env.h>
 #include <errno.h>
@@ -28,8 +27,6 @@
 
 #include <dt-bindings/reset/altr,rst-mgr.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static struct pl310_regs *const pl310 =
 	(struct pl310_regs *)CFG_SYS_PL310_BASE;
 static struct nic301_registers *nic301_regs =
diff --git a/arch/arm/mach-socfpga/misc_soc64.c b/arch/arm/mach-socfpga/misc_soc64.c
index 5222b384434aa29bba13dc4e62059f91cc3d7cd8..356240a647e85c903b59ec7e6f5d4188c4eadd79 100644
--- a/arch/arm/mach-socfpga/misc_soc64.c
+++ b/arch/arm/mach-socfpga/misc_soc64.c
@@ -17,11 +17,8 @@
 #include <asm/arch/system_manager.h>
 #include <asm/io.h>
 #include <asm/system.h>
-#include <asm/global_data.h>
 #include <mach/clock_manager.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 /* Agilex5 Sub Device Jtag ID List */
 #define A3690_JTAG_ID	0x036090DD
 #define A3694_JTAG_ID	0x436090DD
diff --git a/arch/arm/mach-socfpga/mmu-arm64_s10.c b/arch/arm/mach-socfpga/mmu-arm64_s10.c
index 1dc44ab47972bac02215514e8e5a8478c9272e05..1a7f8d42415984c5edb4199c0b355c2dbfe7d666 100644
--- a/arch/arm/mach-socfpga/mmu-arm64_s10.c
+++ b/arch/arm/mach-socfpga/mmu-arm64_s10.c
@@ -5,9 +5,6 @@
  */
 
 #include <asm/armv8/mmu.h>
-#include <asm/global_data.h>
-
-DECLARE_GLOBAL_DATA_PTR;
 
 #if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
 static struct mm_region socfpga_agilex5_mem_map[] = {
diff --git a/arch/arm/mach-socfpga/reset_manager_s10.c b/arch/arm/mach-socfpga/reset_manager_s10.c
index abb62a9b49ff339b06e914e917a82f92df1be039..7e1ecc1cd1d935f743ba357deb7ef48fd9bd4fae 100644
--- a/arch/arm/mach-socfpga/reset_manager_s10.c
+++ b/arch/arm/mach-socfpga/reset_manager_s10.c
@@ -7,7 +7,6 @@
 
 #include <errno.h>
 #include <hang.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/secure.h>
 #include <asm/arch/reset_manager.h>
@@ -20,8 +19,6 @@
 #include <linux/intel-smc.h>
 #include <wait_bit.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define TIMEOUT_300MS     300
 
 /* F2S manager registers */
diff --git a/arch/arm/mach-socfpga/spl_agilex.c b/arch/arm/mach-socfpga/spl_agilex.c
index 48f258a37b4b61f854bdd0b9a41430a2b0dde4f5..53a9aa55f804b24b96f548adb6c17ee976551ac7 100644
--- a/arch/arm/mach-socfpga/spl_agilex.c
+++ b/arch/arm/mach-socfpga/spl_agilex.c
@@ -7,7 +7,6 @@
 
 #include <init.h>
 #include <log.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/utils.h>
 #include <hang.h>
@@ -22,8 +21,6 @@
 #include <wdt.h>
 #include <dm/uclass.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 u32 reset_flag(u32 flag)
 {
 	/* Check rstmgr.stat for warm reset status */
diff --git a/arch/arm/mach-socfpga/spl_agilex5.c b/arch/arm/mach-socfpga/spl_agilex5.c
index 1be347360f50dfc44ed92af56c7cc7e6992fb8a2..2c3e40b664abd28497f554a6501ead21b331ca76 100644
--- a/arch/arm/mach-socfpga/spl_agilex5.c
+++ b/arch/arm/mach-socfpga/spl_agilex5.c
@@ -6,7 +6,6 @@
  */
 
 #include <init.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <hang.h>
 #include <spl.h>
@@ -19,8 +18,6 @@
 #include <wdt.h>
 #include <dm/uclass.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 u32 reset_flag(u32 flag)
 {
 	/* Check rstmgr.stat for warm reset status */
diff --git a/arch/arm/mach-socfpga/spl_agilex7m.c b/arch/arm/mach-socfpga/spl_agilex7m.c
index 90065ccee6f00880862c27862b20ca292531eafb..7371202a7124a37073bdf58959e3ff41d5a85a25 100644
--- a/arch/arm/mach-socfpga/spl_agilex7m.c
+++ b/arch/arm/mach-socfpga/spl_agilex7m.c
@@ -15,14 +15,11 @@
 #include <asm/arch/misc.h>
 #include <asm/arch/reset_manager.h>
 #include <asm/arch/system_manager.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/u-boot.h>
 #include <asm/utils.h>
 #include <dm/uclass.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 void board_init_f(ulong dummy)
 {
 	int ret;
diff --git a/arch/arm/mach-socfpga/spl_gen5.c b/arch/arm/mach-socfpga/spl_gen5.c
index df79cfe0f7fafd4e84f27a23a6b66054fcf8afc3..08b756db2cae13c687f6c593c6afa823eb93b7e9 100644
--- a/arch/arm/mach-socfpga/spl_gen5.c
+++ b/arch/arm/mach-socfpga/spl_gen5.c
@@ -6,7 +6,6 @@
 #include <hang.h>
 #include <init.h>
 #include <log.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/utils.h>
 #include <image.h>
@@ -25,8 +24,6 @@
 #include <dm/uclass.h>
 #include <linux/bitops.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 u32 spl_boot_device(void)
 {
 	const u32 bsel = readl(socfpga_get_sysmgr_addr() +
diff --git a/arch/arm/mach-socfpga/spl_n5x.c b/arch/arm/mach-socfpga/spl_n5x.c
index 81283ef71620034ca173048c27cefed6a62c32d2..a49be8379210c6641904b8491404e6bdc888f704 100644
--- a/arch/arm/mach-socfpga/spl_n5x.c
+++ b/arch/arm/mach-socfpga/spl_n5x.c
@@ -10,7 +10,6 @@
 #include <asm/arch/misc.h>
 #include <asm/arch/reset_manager.h>
 #include <asm/arch/system_manager.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/utils.h>
 #include <dm/uclass.h>
@@ -20,8 +19,6 @@
 #include <spl.h>
 #include <watchdog.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 void board_init_f(ulong dummy)
 {
 	int ret;
diff --git a/arch/arm/mach-socfpga/spl_s10.c b/arch/arm/mach-socfpga/spl_s10.c
index fa83ff96adc862afb2209ba91c031ce89517e97b..a0d3c96d4562892ff795258c1f609f33a3562911 100644
--- a/arch/arm/mach-socfpga/spl_s10.c
+++ b/arch/arm/mach-socfpga/spl_s10.c
@@ -7,7 +7,6 @@
 #include <hang.h>
 #include <init.h>
 #include <log.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/utils.h>
 #include <debug_uart.h>
@@ -22,8 +21,6 @@
 #include <watchdog.h>
 #include <dm/uclass.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 void board_init_f(ulong dummy)
 {
 	const struct cm_config *cm_default_cfg = cm_get_default_config();
diff --git a/arch/arm/mach-socfpga/system_manager_soc64.c b/arch/arm/mach-socfpga/system_manager_soc64.c
index 913f93c8f94d8eed319f52161a9e63bedab05eea..a5c0387190b26a87eec1292816e25467c9818d59 100644
--- a/arch/arm/mach-socfpga/system_manager_soc64.c
+++ b/arch/arm/mach-socfpga/system_manager_soc64.c
@@ -6,12 +6,9 @@
 
 #include <asm/arch/handoff_soc64.h>
 #include <asm/arch/system_manager.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/bitfield.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
 /*
  * Setting RESET_PULSE_OVERRIDE bit for successful reset staggering pulse
diff --git a/arch/microblaze/lib/bootm.c b/arch/microblaze/lib/bootm.c
index 4879a41aab3bb141a6e6b5d532484c1fb7221b80..2410515f4ac504ab6e64bd0e70922f854d3e15e9 100644
--- a/arch/microblaze/lib/bootm.c
+++ b/arch/microblaze/lib/bootm.c
@@ -17,12 +17,9 @@
 #include <image.h>
 #include <log.h>
 #include <asm/cache.h>
-#include <asm/global_data.h>
 #include <u-boot/zlib.h>
 #include <asm/byteorder.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static void boot_jump_linux(struct bootm_headers *images, int flag)
 {
 	void (*thekernel)(char *cmdline, ulong rd, ulong dt);
diff --git a/arch/mips/mach-ath79/qca956x/ddr.c b/arch/mips/mach-ath79/qca956x/ddr.c
index 2e46e24f48309871e44b1ca2c59b1106228c6bcc..754e2573e37d7b2e722dff4259abe087cf788e9d 100644
--- a/arch/mips/mach-ath79/qca956x/ddr.c
+++ b/arch/mips/mach-ath79/qca956x/ddr.c
@@ -5,7 +5,6 @@
  * Based on QSDK
  */
 
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/addrspace.h>
 #include <asm/types.h>
@@ -182,8 +181,6 @@
 	DDR_CTL_CONFIG_MISC_SRC1_SRAM_SYNC_SET(0x1) | \
 	DDR_CTL_CONFIG_MISC_SRC2_SRAM_SYNC_SET(0x1)
 
-DECLARE_GLOBAL_DATA_PTR;
-
 void qca956x_ddr_init(void)
 {
 	u32 ddr_config, ddr_config2, ddr_config3, mod_val, \
diff --git a/arch/mips/mach-mscc/cpu.c b/arch/mips/mach-mscc/cpu.c
index 22b1b98e0ef4e545b7bbcd0100c6b0c6b5403c66..8ae6fb9437ae407b27fe75bdcdfefb5137092c1d 100644
--- a/arch/mips/mach-mscc/cpu.c
+++ b/arch/mips/mach-mscc/cpu.c
@@ -4,7 +4,6 @@
  */
 
 #include <init.h>
-#include <asm/global_data.h>
 #include <linux/bitops.h>
 
 #include <asm/io.h>
@@ -14,8 +13,6 @@
 #include <mach/tlb.h>
 #include <mach/ddr.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #if CFG_SYS_SDRAM_SIZE <= SZ_64M
 #define MSCC_RAM_TLB_SIZE   SZ_64M
 #define MSCC_ATTRIB2   MMU_REGIO_INVAL
diff --git a/arch/mips/mach-mtmips/ddr_cal.c b/arch/mips/mach-mtmips/ddr_cal.c
index e2e1760a64681a07c26158de0c4e036d993c564f..5fc4e0c49e86528a280cc158cd27680409ba9e32 100644
--- a/arch/mips/mach-mtmips/ddr_cal.c
+++ b/arch/mips/mach-mtmips/ddr_cal.c
@@ -7,13 +7,10 @@
 
 #include <asm/addrspace.h>
 #include <asm/cacheops.h>
-#include <asm/global_data.h>
 #include <linux/bitops.h>
 #include <linux/io.h>
 #include <mach/mc.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define COARSE_MIN_START	6
 #define FINE_MIN_START		15
 #define COARSE_MAX_START	7
diff --git a/arch/mips/mach-octeon/cvmx-pko.c b/arch/mips/mach-octeon/cvmx-pko.c
index 8a9181362bda894922f2adab59c51bcef6492563..432488f7815bc95ea0c20f60844c4699071381fd 100644
--- a/arch/mips/mach-octeon/cvmx-pko.c
+++ b/arch/mips/mach-octeon/cvmx-pko.c
@@ -52,8 +52,6 @@
 #include <mach/cvmx-helper-pki.h>
 #include <mach/cvmx-helper-pko.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define CVMX_PKO_NQ_PER_PORT_MAX 32
 
 static cvmx_pko_return_value_t cvmx_pko2_config_port(short ipd_port,
diff --git a/arch/nios2/lib/bootm.c b/arch/nios2/lib/bootm.c
index 71319839ba21b68b714ffa59e044ea486b58847d..294ebfb508ba786d98df179ac4230549cedac5a7 100644
--- a/arch/nios2/lib/bootm.c
+++ b/arch/nios2/lib/bootm.c
@@ -10,9 +10,6 @@
 #include <image.h>
 #include <irq_func.h>
 #include <log.h>
-#include <asm/global_data.h>
-
-DECLARE_GLOBAL_DATA_PTR;
 
 #define NIOS_MAGIC 0x534f494e /* enable command line and initrd passing */
 
diff --git a/arch/riscv/cpu/andes/spl.c b/arch/riscv/cpu/andes/spl.c
index a13dc4095a457372cbc1e64f1b11170a95c92d3d..1e19fad92884617368300dac881ea73435383dbb 100644
--- a/arch/riscv/cpu/andes/spl.c
+++ b/arch/riscv/cpu/andes/spl.c
@@ -8,11 +8,8 @@
 #include <init.h>
 #include <log.h>
 #include <spl.h>
-#include <asm/global_data.h>
 #include <asm/system.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #if CONFIG_IS_ENABLED(RAM_SUPPORT)
 struct legacy_img_hdr *spl_get_load_buffer(ssize_t offset, size_t size)
 {
diff --git a/arch/riscv/cpu/cv1800b/dram.c b/arch/riscv/cpu/cv1800b/dram.c
index 91007c0a3d341bfd7927e73525ec6c6c5983b17d..5d7659887b9a41ea1e6f87681e0e07c6400ab55d 100644
--- a/arch/riscv/cpu/cv1800b/dram.c
+++ b/arch/riscv/cpu/cv1800b/dram.c
@@ -5,11 +5,8 @@
 
 #include <fdtdec.h>
 #include <init.h>
-#include <asm/global_data.h>
 #include <linux/sizes.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 int dram_init(void)
 {
 	return fdtdec_setup_mem_size_base();
diff --git a/arch/riscv/cpu/generic/dram.c b/arch/riscv/cpu/generic/dram.c
index 91007c0a3d341bfd7927e73525ec6c6c5983b17d..5d7659887b9a41ea1e6f87681e0e07c6400ab55d 100644
--- a/arch/riscv/cpu/generic/dram.c
+++ b/arch/riscv/cpu/generic/dram.c
@@ -5,11 +5,8 @@
 
 #include <fdtdec.h>
 #include <init.h>
-#include <asm/global_data.h>
 #include <linux/sizes.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 int dram_init(void)
 {
 	return fdtdec_setup_mem_size_base();
diff --git a/arch/riscv/cpu/k230/dram.c b/arch/riscv/cpu/k230/dram.c
index b2d3e4fd6a96d7fc6ca8b8507f4eba85f7e9c9b5..5d7659887b9a41ea1e6f87681e0e07c6400ab55d 100644
--- a/arch/riscv/cpu/k230/dram.c
+++ b/arch/riscv/cpu/k230/dram.c
@@ -3,13 +3,10 @@
  * Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <asm/global_data.h>
 #include <fdtdec.h>
 #include <init.h>
 #include <linux/sizes.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 int dram_init(void)
 {
 	return fdtdec_setup_mem_size_base();
diff --git a/arch/riscv/cpu/th1520/spl.c b/arch/riscv/cpu/th1520/spl.c
index b95470485f6d5cf6125f285145c291ef9102e02c..ceb934021d9f0102e1258a4dcead80b76f91ca82 100644
--- a/arch/riscv/cpu/th1520/spl.c
+++ b/arch/riscv/cpu/th1520/spl.c
@@ -10,8 +10,6 @@
 #include <log.h>
 #include <init.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define TH1520_SUBSYS_CLK		(void __iomem *)(0xffff011000 + 0x220)
 #define  TH1520_SUBSYS_CLK_VO_EN	BIT(2)
 #define  TH1520_SUBSYS_CLK_VI_EN	BIT(1)
diff --git a/arch/sh/lib/bootm.c b/arch/sh/lib/bootm.c
index bb0f59e0aa23d1172244c51d55df310c63be6816..1c118870dad684b457325a823e8f08bca28be94a 100644
--- a/arch/sh/lib/bootm.c
+++ b/arch/sh/lib/bootm.c
@@ -13,11 +13,8 @@
 #include <env.h>
 #include <image.h>
 #include <asm/byteorder.h>
-#include <asm/global_data.h>
 #include <asm/zimage.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #ifdef CONFIG_SH_SDRAM_OFFSET
 #define GET_INITRD_START(initrd, linux) (initrd - linux + CONFIG_SH_SDRAM_OFFSET)
 #else
diff --git a/arch/x86/cpu/ivybridge/model_206ax.c b/arch/x86/cpu/ivybridge/model_206ax.c
index b72de96a277eb0fe8c7bd0a899f5b264303aca87..ed0ad686b3faf946deab19c9e78a21959e477ceb 100644
--- a/arch/x86/cpu/ivybridge/model_206ax.c
+++ b/arch/x86/cpu/ivybridge/model_206ax.c
@@ -14,7 +14,6 @@
 #include <asm/cpu.h>
 #include <asm/cpu_common.h>
 #include <asm/cpu_x86.h>
-#include <asm/global_data.h>
 #include <asm/msr.h>
 #include <asm/msr-index.h>
 #include <asm/mtrr.h>
@@ -23,8 +22,6 @@
 #include <asm/turbo.h>
 #include <asm/arch/model_206ax.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static void enable_vmx(void)
 {
 	struct cpuid_result regs;
diff --git a/arch/x86/lib/init_helpers.c b/arch/x86/lib/init_helpers.c
index bd0efde00c1090d47c7cbc9ed7227f328ec06ff7..96943cb8c462d82127a98289accca7c0eff8187c 100644
--- a/arch/x86/lib/init_helpers.c
+++ b/arch/x86/lib/init_helpers.c
@@ -5,13 +5,10 @@
  */
 
 #include <init.h>
-#include <asm/global_data.h>
 #include <linux/errno.h>
 #include <asm/mtrr.h>
 #include <asm/u-boot-x86.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 int init_cache_f_r(void)
 {
 	bool do_mtrr = CONFIG_IS_ENABLED(X86_32BIT_INIT) ||
diff --git a/arch/x86/lib/zimage.c b/arch/x86/lib/zimage.c
index 2ea9bcf59c2796bad6fb5682866a5ab4fd05a9ba..a5f2231aa523356de93368338b5fd249b8abad6e 100644
--- a/arch/x86/lib/zimage.c
+++ b/arch/x86/lib/zimage.c
@@ -30,7 +30,6 @@
 #include <asm/bootm.h>
 #include <asm/bootparam.h>
 #include <asm/efi.h>
-#include <asm/global_data.h>
 #ifdef CONFIG_SYS_COREBOOT
 #include <asm/arch/timestamp.h>
 #endif
@@ -38,8 +37,6 @@
 #include <linux/ctype.h>
 #include <linux/libfdt.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 /*
  * Memory lay-out:
  *
diff --git a/arch/xtensa/lib/time.c b/arch/xtensa/lib/time.c
index 319635c6b0936515f2cd219f122bc62858817830..1fe33a4c62b948cf5b3c85b5a7cb67e7ec5c323a 100644
--- a/arch/xtensa/lib/time.c
+++ b/arch/xtensa/lib/time.c
@@ -5,12 +5,9 @@
 
 #include <clock_legacy.h>
 #include <time.h>
-#include <asm/global_data.h>
 #include <linux/delay.h>
 #include <linux/stringify.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #if XCHAL_HAVE_CCOUNT
 static ulong get_ccount(void)
 {
diff --git a/board/BuR/brsmarc1/board.c b/board/BuR/brsmarc1/board.c
index c05eec6b35ed1d5e871e80efd24641e130595f80..01d7a8c39e23f087ea539d722084234caa8b5efd 100644
--- a/board/BuR/brsmarc1/board.c
+++ b/board/BuR/brsmarc1/board.c
@@ -18,7 +18,6 @@
 #include <asm/arch/clock.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/arch/mem.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/gpio.h>
 #include <asm/emif.h>
@@ -30,8 +29,6 @@
 /* -- defines for used GPIO Hardware -- */
 #define PER_RESET		(2 * 32 + 0)
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #if defined(CONFIG_XPL_BUILD)
 static const struct ddr_data ddr3_data = {
 	.datardsratio0 = MT41K256M16HA125E_RD_DQS,
diff --git a/board/BuR/common/common.c b/board/BuR/common/common.c
index 3513f43a9f560d28d0da68d229ecf3a1b7cf6c19..bbafecd79097070e3eb9462bccc05626f8bbc76a 100644
--- a/board/BuR/common/common.c
+++ b/board/BuR/common/common.c
@@ -13,12 +13,9 @@
 #include <env.h>
 #include <fdtdec.h>
 #include <i2c.h>
-#include <asm/global_data.h>
 #include <linux/delay.h>
 #include "bur_common.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 /* --------------------------------------------------------------------------*/
 
 int ft_board_setup(void *blob, struct bd_info *bd)
diff --git a/board/Marvell/octeontx/smc.c b/board/Marvell/octeontx/smc.c
index 8df32049bda69e99cf28c0dd78e372cc94790d4d..ab6284a732cfa2c3057149bff5df69f9f25f3a95 100644
--- a/board/Marvell/octeontx/smc.c
+++ b/board/Marvell/octeontx/smc.c
@@ -5,13 +5,10 @@
  * https://spdx.org/licenses
  */
 
-#include <asm/global_data.h>
 #include <asm/ptrace.h>
 #include <asm/system.h>
 #include <asm/arch/smc.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 ssize_t smc_dram_size(unsigned int node)
 {
 	struct pt_regs regs;
diff --git a/board/Marvell/octeontx2/smc.c b/board/Marvell/octeontx2/smc.c
index 9e3169576c65ec052001ce43d57f1143d68a46d6..10645a74f6990555afbd81a48fe7561d1621658b 100644
--- a/board/Marvell/octeontx2/smc.c
+++ b/board/Marvell/octeontx2/smc.c
@@ -5,15 +5,12 @@
  * https://spdx.org/licenses
  */
 
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/psci.h>
 #include <asm/ptrace.h>
 #include <asm/system.h>
 #include <asm/arch/smc.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 ssize_t smc_dram_size(unsigned int node)
 {
 	struct pt_regs regs;
diff --git a/board/advantech/imx8mp_rsb3720a1/imx8mp_rsb3720a1.c b/board/advantech/imx8mp_rsb3720a1/imx8mp_rsb3720a1.c
index 8c9e98308765c0b3d70d22337fbf6a654c408d03..a9a12a4f659139d60adfe157c5398339ecda9469 100644
--- a/board/advantech/imx8mp_rsb3720a1/imx8mp_rsb3720a1.c
+++ b/board/advantech/imx8mp_rsb3720a1/imx8mp_rsb3720a1.c
@@ -26,8 +26,6 @@
 #include <linux/kernel.h>
 #include <power/pmic.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #ifdef CONFIG_NAND_MXS
 static void setup_gpmi_nand(void)
 {
diff --git a/board/advantech/imx8mp_rsb3720a1/spl.c b/board/advantech/imx8mp_rsb3720a1/spl.c
index 1f7c1f25adcf969d6a980a5795e89e9295b2a692..fb8e84377598cfde5bd8e274ef0fd23c759c7504 100644
--- a/board/advantech/imx8mp_rsb3720a1/spl.c
+++ b/board/advantech/imx8mp_rsb3720a1/spl.c
@@ -29,8 +29,6 @@
 #include <power/pmic.h>
 #include <power/pca9450.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 int spl_board_boot_device(enum boot_device boot_dev_spl)
 {
 #ifdef CONFIG_SPL_BOOTROM_SUPPORT
diff --git a/board/advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c b/board/advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c
index accd300df04d658eb1ca39b4649966feb08129e4..fbe8b247e696d2a043c396145963676a08149236 100644
--- a/board/advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c
+++ b/board/advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c
@@ -16,8 +16,6 @@
 #include <asm/arch/sys_proto.h>
 /* #include <power-domain.h> */
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define UART_PAD_CTRL	((SC_PAD_CONFIG_OUT_IN << PADRING_CONFIG_SHIFT) | \
 			(SC_PAD_ISO_OFF << PADRING_LPCONFIG_SHIFT) | \
 			(SC_PAD_28FDSOI_DSE_DV_HIGH << PADRING_DSE_SHIFT) | \
diff --git a/board/advantech/imx8qm_rom7720_a1/imx8qm_rom7720_a1.c b/board/advantech/imx8qm_rom7720_a1/imx8qm_rom7720_a1.c
index 3def182f2967e24fb2b444632866877da9725d3d..8214e62776882d7730d37e36203c0ae4b44f59ac 100644
--- a/board/advantech/imx8qm_rom7720_a1/imx8qm_rom7720_a1.c
+++ b/board/advantech/imx8qm_rom7720_a1/imx8qm_rom7720_a1.c
@@ -8,7 +8,6 @@
 #include <env.h>
 #include <errno.h>
 #include <init.h>
-#include <asm/global_data.h>
 #include <linux/delay.h>
 #include <linux/libfdt.h>
 #include <asm/io.h>
@@ -19,8 +18,6 @@
 #include <asm/arch/iomux.h>
 #include <asm/arch/sys_proto.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define UART_PAD_CTRL	((SC_PAD_CONFIG_OUT_IN << PADRING_CONFIG_SHIFT) | \
 			 (SC_PAD_ISO_OFF << PADRING_LPCONFIG_SHIFT) | \
 			 (SC_PAD_28FDSOI_DSE_DV_HIGH << PADRING_DSE_SHIFT) | \
diff --git a/board/andestech/voyager/voyager.c b/board/andestech/voyager/voyager.c
index dc8f13477754eb5410b041129a9601a6177f41c3..23fd0910ef82c39b2d38db5110ef4d2da7eac73b 100644
--- a/board/andestech/voyager/voyager.c
+++ b/board/andestech/voyager/voyager.c
@@ -5,7 +5,6 @@
  */
 
 #include <asm/csr.h>
-#include <asm/global_data.h>
 #include <asm/sbi.h>
 #include <config.h>
 #include <cpu_func.h>
@@ -19,8 +18,6 @@
 #include <net.h>
 #include <spl.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 int dram_init(void)
 {
 	return fdtdec_setup_mem_size_base();
diff --git a/board/armltd/vexpress64/vexpress64.c b/board/armltd/vexpress64/vexpress64.c
index e8f1c2fe9fe26e7007d73b64cdd2155c6e742743..d68da0e3d650923d924949eb67dff498279702a5 100644
--- a/board/armltd/vexpress64/vexpress64.c
+++ b/board/armltd/vexpress64/vexpress64.c
@@ -12,7 +12,6 @@
 #include <errno.h>
 #include <net.h>
 #include <netdev.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/compiler.h>
 #include <linux/sizes.h>
@@ -24,8 +23,6 @@
 #include <virtio.h>
 #endif
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static const struct pl01x_serial_plat serial_plat = {
 	.base = V2M_UART0,
 	.type = TYPE_PL011,
diff --git a/board/beacon/imx8mm/spl.c b/board/beacon/imx8mm/spl.c
index 93ee5b7ee0cdf8a6b227b4731c4f48b06e2d7ffc..1e5935788ff6bcf9617de0ba13fd725243304047 100644
--- a/board/beacon/imx8mm/spl.c
+++ b/board/beacon/imx8mm/spl.c
@@ -5,7 +5,6 @@
 #include <init.h>
 #include <log.h>
 #include <spl.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/mach-imx/iomux-v3.h>
 #include <asm/arch/clock.h>
@@ -23,8 +22,6 @@
 #include <power/pmic.h>
 #include <power/bd71837.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 int spl_board_boot_device(enum boot_device boot_dev_spl)
 {
 	switch (boot_dev_spl) {
diff --git a/board/beacon/imx8mn/spl.c b/board/beacon/imx8mn/spl.c
index e91d3fdcf5edc978e92a6a4f349a08501d9c6085..46db42ec92111fcaff1a0d3c36d45dc44f3e044b 100644
--- a/board/beacon/imx8mn/spl.c
+++ b/board/beacon/imx8mn/spl.c
@@ -9,7 +9,6 @@
 #include <log.h>
 #include <asm/io.h>
 #include <errno.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/arch/ddr.h>
 #include <asm/arch/imx8mn_pins.h>
@@ -32,8 +31,6 @@
 #include <dm/uclass-internal.h>
 #include <dm/device-internal.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 int spl_board_boot_device(enum boot_device boot_dev_spl)
 {
 	return BOOT_DEVICE_BOOTROM;
diff --git a/board/beacon/imx8mp/spl.c b/board/beacon/imx8mp/spl.c
index 027fae38278638e9a238c86637153ed12353cc4f..e82e385b774bba3853753d24f7448938bb5c12a1 100644
--- a/board/beacon/imx8mp/spl.c
+++ b/board/beacon/imx8mp/spl.c
@@ -8,7 +8,6 @@
 #include <init.h>
 #include <log.h>
 #include <spl.h>
-#include <asm/global_data.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/imx8mp_pins.h>
 #include <asm/arch/sys_proto.h>
@@ -22,8 +21,6 @@
 #include <dm/uclass.h>
 #include <dm/device.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 int spl_board_boot_device(enum boot_device boot_dev_spl)
 {
 	return BOOT_DEVICE_BOOTROM;
diff --git a/board/beagle/beagleboneai64/beagleboneai64.c b/board/beagle/beagleboneai64/beagleboneai64.c
index 500fcc58ed81a6a91c882938c304c616ddc4b393..27b1f22562c48c1bc242a77cd8fbc66398bd55c8 100644
--- a/board/beagle/beagleboneai64/beagleboneai64.c
+++ b/board/beagle/beagleboneai64/beagleboneai64.c
@@ -13,8 +13,6 @@
 #include <fdt_support.h>
 #include <spl.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 struct efi_fw_image fw_images[] = {
 	{
 		.image_type_id = BEAGLEBONEAI64_TIBOOT3_IMAGE_GUID,
diff --git a/board/beagle/beagleplay/beagleplay.c b/board/beagle/beagleplay/beagleplay.c
index 9bc9ca30e952671838722d0f5aaccc036bb3f35f..70d296de9f863445854ec670730beecacedde092 100644
--- a/board/beagle/beagleplay/beagleplay.c
+++ b/board/beagle/beagleplay/beagleplay.c
@@ -14,8 +14,6 @@
 
 #include <asm/arch/hardware.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 struct efi_fw_image fw_images[] = {
 	{
 		.image_type_id = BEAGLEPLAY_TIBOOT3_IMAGE_GUID,
diff --git a/board/broadcom/bcmns/ns.c b/board/broadcom/bcmns/ns.c
index 47a01227a353d75314b0641a47facf4f565585b9..cb53ec68cf8c5e105ef1c198e81f0ab5cbde5c1a 100644
--- a/board/broadcom/bcmns/ns.c
+++ b/board/broadcom/bcmns/ns.c
@@ -9,12 +9,9 @@
 #include <log.h>
 #include <ram.h>
 #include <serial.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/armv7m.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 int dram_init(void)
 {
 	return fdtdec_setup_mem_size_base();
diff --git a/board/cloos/imx8mm_phg/imx8mm_phg.c b/board/cloos/imx8mm_phg/imx8mm_phg.c
index 091c9a59a52b66bbe63b044cc34b20fcd52c187f..1ca1c07e08ed82f5b3f183cf1f3d7b07ee881408 100644
--- a/board/cloos/imx8mm_phg/imx8mm_phg.c
+++ b/board/cloos/imx8mm_phg/imx8mm_phg.c
@@ -7,14 +7,11 @@
 #include <init.h>
 #include <miiphy.h>
 #include <netdev.h>
-#include <asm/global_data.h>
 
 #include <asm/arch/clock.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/io.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static int setup_fec(void)
 {
 	struct iomuxc_gpr_base_regs *gpr =
diff --git a/board/cloos/imx8mm_phg/spl.c b/board/cloos/imx8mm_phg/spl.c
index b8892ed2fccd80bf483db833b62a8bf55817d67e..b2340a0ded3dc152d64ca0e8ebfd4800ce382bc1 100644
--- a/board/cloos/imx8mm_phg/spl.c
+++ b/board/cloos/imx8mm_phg/spl.c
@@ -10,7 +10,6 @@
 #include <init.h>
 #include <log.h>
 #include <spl.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/mach-imx/iomux-v3.h>
 #include <asm/arch/clock.h>
@@ -28,8 +27,6 @@
 #include <power/pmic.h>
 #include <power/pca9450.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 int spl_board_boot_device(enum boot_device boot_dev_spl)
 {
 	switch (boot_dev_spl) {
diff --git a/board/compulab/imx8mm-cl-iot-gate/spl.c b/board/compulab/imx8mm-cl-iot-gate/spl.c
index 6d9af2538b630a0939d557ab35368b803dfe2fb9..daac6dca4ce81ded7b3136e647f102a4a27e5cb2 100644
--- a/board/compulab/imx8mm-cl-iot-gate/spl.c
+++ b/board/compulab/imx8mm-cl-iot-gate/spl.c
@@ -32,8 +32,6 @@
 
 #include "ddr/ddr.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 int spl_board_boot_device(enum boot_device boot_dev_spl)
 {
 	switch (boot_dev_spl) {
diff --git a/board/coreboot/coreboot/coreboot.c b/board/coreboot/coreboot/coreboot.c
index f2ca10767681d83ecc5e10868d8586421b2c7901..d0e8db6cdfe5c382c5857092921dad93b150bc50 100644
--- a/board/coreboot/coreboot/coreboot.c
+++ b/board/coreboot/coreboot/coreboot.c
@@ -7,9 +7,6 @@
 #include <init.h>
 #include <smbios.h>
 #include <asm/cb_sysinfo.h>
-#include <asm/global_data.h>
-
-DECLARE_GLOBAL_DATA_PTR;
 
 int board_early_init_r(void)
 {
diff --git a/board/cssi/cmpc885/cmpc885.c b/board/cssi/cmpc885/cmpc885.c
index 49c13056edcb35af47508e5c6cbfbe097dabfd97..552349d104aa4657743e30705331de903798351b 100644
--- a/board/cssi/cmpc885/cmpc885.c
+++ b/board/cssi/cmpc885/cmpc885.c
@@ -26,8 +26,6 @@
 
 #include "../common/common.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define ADDR_CPLD_R_RESET		((unsigned short __iomem *)CONFIG_CPLD_BASE)
 #define ADDR_CPLD_R_ETAT		((unsigned short __iomem *)(CONFIG_CPLD_BASE + 2))
 #define ADDR_CPLD_R_TYPE		((unsigned char  __iomem *)(CONFIG_CPLD_BASE + 3))
diff --git a/board/data_modul/imx8mm_edm_sbc/imx8mm_data_modul_edm_sbc.c b/board/data_modul/imx8mm_edm_sbc/imx8mm_data_modul_edm_sbc.c
index e271d060efa6b8b36dc5f81d0eba5c2e80e5b10c..ab4a484d393f9510cb492111f27dc0ef7832b2c9 100644
--- a/board/data_modul/imx8mm_edm_sbc/imx8mm_data_modul_edm_sbc.c
+++ b/board/data_modul/imx8mm_edm_sbc/imx8mm_data_modul_edm_sbc.c
@@ -14,8 +14,6 @@
 
 #include "../common/common.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 int board_late_init(void)
 {
 	struct udevice *dev;
diff --git a/board/data_modul/imx8mm_edm_sbc/spl.c b/board/data_modul/imx8mm_edm_sbc/spl.c
index a9ef049652ac0f8a5c1937a5e5f5f743780631d4..c6a5740c7a7050164dbe480407f7434e8a36ad01 100644
--- a/board/data_modul/imx8mm_edm_sbc/spl.c
+++ b/board/data_modul/imx8mm_edm_sbc/spl.c
@@ -27,8 +27,6 @@
 
 #include "../common/common.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 int data_modul_imx_edm_sbc_board_power_init(void)
 {
 	struct udevice *dev;
diff --git a/board/data_modul/imx8mp_edm_sbc/imx8mp_data_modul_edm_sbc.c b/board/data_modul/imx8mp_edm_sbc/imx8mp_data_modul_edm_sbc.c
index d6f0a917023db26980f3d83f1f7e639a31c846e0..5c319df1cdee84a6f2f4de10921fd27f9d999256 100644
--- a/board/data_modul/imx8mp_edm_sbc/imx8mp_data_modul_edm_sbc.c
+++ b/board/data_modul/imx8mp_edm_sbc/imx8mp_data_modul_edm_sbc.c
@@ -17,8 +17,6 @@
 
 #include "../common/common.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static void dmo_setup_second_mac_address(void)
 {
 	u8 enetaddr[6];
diff --git a/board/data_modul/imx8mp_edm_sbc/spl.c b/board/data_modul/imx8mp_edm_sbc/spl.c
index f81b7274556f634b114f7c853fa2f529cd846c22..314f7e87a9d3d06175399d6c80431bd5a704bb14 100644
--- a/board/data_modul/imx8mp_edm_sbc/spl.c
+++ b/board/data_modul/imx8mp_edm_sbc/spl.c
@@ -28,8 +28,6 @@
 
 #include "../common/common.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 int data_modul_imx_edm_sbc_board_power_init(void)
 {
 	struct udevice *dev;
diff --git a/board/dhelectronics/dh_imx8mp/common.c b/board/dhelectronics/dh_imx8mp/common.c
index f6db9f678042f100f2401ae077f5a426736a297b..5d89c94970dbd281cff9b46e69a8a88b0bd102d5 100644
--- a/board/dhelectronics/dh_imx8mp/common.c
+++ b/board/dhelectronics/dh_imx8mp/common.c
@@ -8,8 +8,6 @@
 
 #include "lpddr4_timing.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 u8 dh_get_memcfg(void)
 {
 	struct gpio_desc gpio[4];
diff --git a/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c b/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
index 5c35a5bf447665768f9d154e9dfc16a7129ec3b2..3fe98d36f5b2b8b75fa29fc92deec90f5bfca1fe 100644
--- a/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
+++ b/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
@@ -20,8 +20,6 @@
 #include "../common/dh_common.h"
 #include "../common/dh_imx.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 int mach_cpu_init(void)
 {
 	icache_enable();
diff --git a/board/dhelectronics/dh_imx8mp/spl.c b/board/dhelectronics/dh_imx8mp/spl.c
index 714f846521e0b9308c9fbacc039df36f773c3409..727e1ff3774d7e1e5789e0acd61114bf9ce66c7f 100644
--- a/board/dhelectronics/dh_imx8mp/spl.c
+++ b/board/dhelectronics/dh_imx8mp/spl.c
@@ -29,8 +29,6 @@
 
 #include "lpddr4_timing.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define UART_PAD_CTRL	(PAD_CTL_DSE6 | PAD_CTL_FSEL1)
 #define WDOG_PAD_CTRL	(PAD_CTL_DSE6 | PAD_CTL_ODE | PAD_CTL_PUE | PAD_CTL_PE)
 
diff --git a/board/emcraft/imx8mp_navqp/spl.c b/board/emcraft/imx8mp_navqp/spl.c
index 7f30f3af74220a6548abd051c17dea061c532cdb..5ee94d078f8f163bf23acb3e8da1807c3b09c13c 100644
--- a/board/emcraft/imx8mp_navqp/spl.c
+++ b/board/emcraft/imx8mp_navqp/spl.c
@@ -8,7 +8,6 @@
 #include <asm/arch/ddr.h>
 #include <asm/arch/imx8mp_pins.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
 #include <asm/mach-imx/boot_mode.h>
 #include <asm/sections.h>
 #include <dm/device.h>
@@ -20,8 +19,6 @@
 #include <power/pmic.h>
 #include <spl.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 int spl_board_boot_device(enum boot_device boot_dev_spl)
 {
 	return BOOT_DEVICE_BOOTROM;
diff --git a/board/emulation/qemu-riscv/qemu-riscv.c b/board/emulation/qemu-riscv/qemu-riscv.c
index 97c8211c1008fd265e63b62b266c8a983cae9042..ce5bc34ca71e5f6eddf340b842d03b17371c7ef6 100644
--- a/board/emulation/qemu-riscv/qemu-riscv.c
+++ b/board/emulation/qemu-riscv/qemu-riscv.c
@@ -15,8 +15,6 @@
 #include <virtio_types.h>
 #include <virtio.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #if IS_ENABLED(CONFIG_MTD_NOR_FLASH)
 int is_flash_available(void)
 {
diff --git a/board/engicam/imx8mm/icore_mx8mm.c b/board/engicam/imx8mm/icore_mx8mm.c
index 236337546aeea42bf14006dbc32f9ba8ecc4a6b7..bb70e7d4ff802cd26a98df3a6ca8f8ca52853d86 100644
--- a/board/engicam/imx8mm/icore_mx8mm.c
+++ b/board/engicam/imx8mm/icore_mx8mm.c
@@ -19,8 +19,6 @@
 #include <asm/mach-imx/gpio.h>
 #include <asm/mach-imx/iomux-v3.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #if IS_ENABLED(CONFIG_FEC_MXC)
 
 #define FEC_RST_PAD IMX_GPIO_NR(3, 7)
diff --git a/board/engicam/imx8mm/spl.c b/board/engicam/imx8mm/spl.c
index d51ae241e85cd5fd0646dba2f2a5a6ab607eab57..5a6bcb1747a012c4aa9c6f7ab9bfa97a4c9603b1 100644
--- a/board/engicam/imx8mm/spl.c
+++ b/board/engicam/imx8mm/spl.c
@@ -17,8 +17,6 @@
 #include <asm/arch/ddr.h>
 #include <asm/sections.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 int spl_board_boot_device(enum boot_device boot_dev_spl)
 {
 	switch (boot_dev_spl) {
diff --git a/board/engicam/imx8mp/icore_mx8mp.c b/board/engicam/imx8mp/icore_mx8mp.c
index bfdc447c4784f7a8e73900a284b83fc9b301e503..864afa92aee0afbd994b35ec01e9f13598a4b572 100644
--- a/board/engicam/imx8mp/icore_mx8mp.c
+++ b/board/engicam/imx8mp/icore_mx8mp.c
@@ -14,7 +14,6 @@
 #include <miiphy.h>
 #include <netdev.h>
 #include <linux/delay.h>
-#include <asm/global_data.h>
 #include <asm/mach-imx/iomux-v3.h>
 #include <asm-generic/gpio.h>
 #include <asm/arch/imx8mp_pins.h>
@@ -22,8 +21,6 @@
 #include <asm/arch/sys_proto.h>
 #include <asm/mach-imx/gpio.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static void setup_fec(void)
 {
 	struct iomuxc_gpr_base_regs *gpr =
diff --git a/board/engicam/imx8mp/spl.c b/board/engicam/imx8mp/spl.c
index cd31aa6041d1397fb5b465d174f0c2c52f5596d3..c1aa28a17bc26797cb387818a885c0a9adf81836 100644
--- a/board/engicam/imx8mp/spl.c
+++ b/board/engicam/imx8mp/spl.c
@@ -12,7 +12,6 @@
 #include <init.h>
 #include <log.h>
 #include <spl.h>
-#include <asm/global_data.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/imx8mp_pins.h>
 #include <asm/arch/sys_proto.h>
@@ -24,8 +23,6 @@
 #include <power/pmic.h>
 #include <power/pca9450.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 int spl_board_boot_device(enum boot_device boot_dev_spl)
 {
 	return BOOT_DEVICE_BOOTROM;
diff --git a/board/gdsys/mpc8308/gazerbeam.c b/board/gdsys/mpc8308/gazerbeam.c
index 05e4d84460ae1e163721b80c7b33020129fcab89..123dda21423b1ff7701adc4a718bb83613a8fc03 100644
--- a/board/gdsys/mpc8308/gazerbeam.c
+++ b/board/gdsys/mpc8308/gazerbeam.c
@@ -17,13 +17,10 @@
 #include <sysinfo.h>
 #include <tpm-v1.h>
 #include <video_osd.h>
-#include <asm/global_data.h>
 
 #include "../common/ihs_mdio.h"
 #include "../../../drivers/sysinfo/gazerbeam.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 struct ihs_mdio_info ihs_mdio_info[] = {
 	{ .fpga = NULL, .name = "ihs0", .base = 0x58 },
 	{ .fpga = NULL, .name = "ihs1", .base = 0x58 },
diff --git a/board/google/imx8mq_phanbell/imx8mq_phanbell.c b/board/google/imx8mq_phanbell/imx8mq_phanbell.c
index 9544d6dd19a800cfb265a9fc3351962b99fceb2b..2f16f1da26ca2a583ce27df732f791ef60052fdd 100644
--- a/board/google/imx8mq_phanbell/imx8mq_phanbell.c
+++ b/board/google/imx8mq_phanbell/imx8mq_phanbell.c
@@ -7,7 +7,6 @@
 #include <init.h>
 #include <malloc.h>
 #include <errno.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <miiphy.h>
 #include <netdev.h>
@@ -21,8 +20,6 @@
 #include <asm/arch/clock.h>
 #include <spl.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define UART_PAD_CTRL	(PAD_CTL_DSE6 | PAD_CTL_FSEL1)
 
 #define WDOG_PAD_CTRL	(PAD_CTL_DSE6 | PAD_CTL_HYS | PAD_CTL_PUE)
diff --git a/board/highbank/highbank.c b/board/highbank/highbank.c
index 0ec88447384a7814a081f9978d3603050eb02803..62a7b5b0420ff59e36344b12040d449eac7df22f 100644
--- a/board/highbank/highbank.c
+++ b/board/highbank/highbank.c
@@ -11,7 +11,6 @@
 #include <init.h>
 #include <net.h>
 #include <scsi.h>
-#include <asm/global_data.h>
 
 #include <linux/sizes.h>
 #include <asm/io.h>
@@ -37,8 +36,6 @@
 #define HB_SCU_A9_PWR_DORMANT		2
 #define HB_SCU_A9_PWR_OFF		3
 
-DECLARE_GLOBAL_DATA_PTR;
-
 void cphy_disable_overrides(void);
 
 /*
diff --git a/board/kontron/osm-s-mx8mp/osm-s-mx8mp.c b/board/kontron/osm-s-mx8mp/osm-s-mx8mp.c
index 3db7176f723714e5717a5024bd669609b6045159..739a78d2c8b43ab5dc1d7e641743c394d511f9a2 100644
--- a/board/kontron/osm-s-mx8mp/osm-s-mx8mp.c
+++ b/board/kontron/osm-s-mx8mp/osm-s-mx8mp.c
@@ -5,7 +5,6 @@
 
 #include <asm/arch/imx-regs.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/mach-imx/boot_mode.h>
 #include <dm/uclass.h>
@@ -22,8 +21,6 @@
 
 #include "../common/hw-uid.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #if IS_ENABLED(CONFIG_KONTRON_HW_UID)
 struct uid_otp_loc uid_otp_locations[] = {
 	{
diff --git a/board/kontron/osm-s-mx93/osm-s-mx93.c b/board/kontron/osm-s-mx93/osm-s-mx93.c
index d4645285771c658857199f7a74cee45f1159db1e..b6feef549d163905a9a30120cefa4be4a2c05ef1 100644
--- a/board/kontron/osm-s-mx93/osm-s-mx93.c
+++ b/board/kontron/osm-s-mx93/osm-s-mx93.c
@@ -6,7 +6,6 @@
 #include <asm/arch/clock.h>
 #include <asm/arch/imx-regs.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/mach-imx/boot_mode.h>
 #include <dm/uclass.h>
@@ -23,8 +22,6 @@
 
 #include "../common/hw-uid.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 int board_early_init_f(void)
 {
 	return 0;
diff --git a/board/kontron/pitx_imx8m/pitx_imx8m.c b/board/kontron/pitx_imx8m/pitx_imx8m.c
index 2ee97169c6f5b125f52efa5d72163430582f3eef..f71fa57b808b6c765949c7042bf4cec18a4b475f 100644
--- a/board/kontron/pitx_imx8m/pitx_imx8m.c
+++ b/board/kontron/pitx_imx8m/pitx_imx8m.c
@@ -15,8 +15,6 @@
 #include <linux/delay.h>
 #include <linux/kernel.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define UART_PAD_CTRL	(PAD_CTL_DSE6 | PAD_CTL_FSEL1)
 #define WDOG_PAD_CTRL	(PAD_CTL_DSE6 | PAD_CTL_HYS | PAD_CTL_PUE)
 
diff --git a/board/mntre/imx8mq_reform2/imx8mq_reform2.c b/board/mntre/imx8mq_reform2/imx8mq_reform2.c
index 6ee1c5c52a19a7f724095f831c62e27c20c871f1..bcb31564a73680d1d99b13f7d426108f78e9d66f 100644
--- a/board/mntre/imx8mq_reform2/imx8mq_reform2.c
+++ b/board/mntre/imx8mq_reform2/imx8mq_reform2.c
@@ -8,7 +8,6 @@
 #include <init.h>
 #include <malloc.h>
 #include <errno.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <miiphy.h>
 #include <netdev.h>
@@ -26,8 +25,6 @@
 #include <linux/delay.h>
 #include <power/pmic.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define WDOG_PAD_CTRL	(PAD_CTL_DSE6 | PAD_CTL_HYS | PAD_CTL_PUE)
 
 static iomux_v3_cfg_t const wdog_pads[] = {
diff --git a/board/msc/sm2s_imx8mp/sm2s_imx8mp.c b/board/msc/sm2s_imx8mp/sm2s_imx8mp.c
index b1ce014bd55d1bee6f26c0dd53445d57f4511309..b2f763dcc02144c03a7272235193ac0bc25d8983 100644
--- a/board/msc/sm2s_imx8mp/sm2s_imx8mp.c
+++ b/board/msc/sm2s_imx8mp/sm2s_imx8mp.c
@@ -18,8 +18,6 @@
 #include <asm-generic/gpio.h>
 #include <linux/delay.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static void setup_fec(void)
 {
 	struct iomuxc_gpr_base_regs *gpr =
diff --git a/board/msc/sm2s_imx8mp/spl.c b/board/msc/sm2s_imx8mp/spl.c
index b1b5561838dc55a8569177679d678865a10987db..902179aad29e3981965b470673877641b690e691 100644
--- a/board/msc/sm2s_imx8mp/spl.c
+++ b/board/msc/sm2s_imx8mp/spl.c
@@ -17,7 +17,6 @@
 #include <log.h>
 #include <mmc.h>
 #include <spl.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/ddr.h>
@@ -33,8 +32,6 @@
 #include <power/pmic.h>
 #include <power/rn5t567_pmic.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 int spl_board_boot_device(enum boot_device boot_dev_spl)
 {
 	return BOOT_DEVICE_BOOTROM;
diff --git a/board/nxp/imx8mm_evk/spl.c b/board/nxp/imx8mm_evk/spl.c
index cd251d274ff68a4e70f0449b4e72f8ec479dace2..5c588046ff4b596bab261e660a93367114f34994 100644
--- a/board/nxp/imx8mm_evk/spl.c
+++ b/board/nxp/imx8mm_evk/spl.c
@@ -10,7 +10,6 @@
 #include <init.h>
 #include <log.h>
 #include <spl.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/mach-imx/iomux-v3.h>
 #include <asm/arch/clock.h>
@@ -28,8 +27,6 @@
 #include <power/pmic.h>
 #include <power/pca9450.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 int spl_board_boot_device(enum boot_device boot_dev_spl)
 {
 	switch (boot_dev_spl) {
diff --git a/board/nxp/imx8qm_mek/imx8qm_mek.c b/board/nxp/imx8qm_mek/imx8qm_mek.c
index 72527f774ca93edc6cd62c9c9e3d265d7dd586e4..56f577714e70dd76c185c1f2021bf7b874866025 100644
--- a/board/nxp/imx8qm_mek/imx8qm_mek.c
+++ b/board/nxp/imx8qm_mek/imx8qm_mek.c
@@ -7,7 +7,6 @@
 #include <env.h>
 #include <errno.h>
 #include <init.h>
-#include <asm/global_data.h>
 #include <linux/libfdt.h>
 #include <fdt_support.h>
 #include <asm/io.h>
@@ -18,8 +17,6 @@
 #include <asm/arch/iomux.h>
 #include <asm/arch/sys_proto.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define UART_PAD_CTRL	((SC_PAD_CONFIG_OUT_IN << PADRING_CONFIG_SHIFT) | \
 			 (SC_PAD_ISO_OFF << PADRING_LPCONFIG_SHIFT) | \
 			 (SC_PAD_28FDSOI_DSE_DV_HIGH << PADRING_DSE_SHIFT) | \
diff --git a/board/nxp/imx8qxp_mek/imx8qxp_mek.c b/board/nxp/imx8qxp_mek/imx8qxp_mek.c
index adb9556a021c89b9c37d081c6b6909e32338ee00..4bf6645b893fd1bf5ad35b97166dcaa3d926c4d1 100644
--- a/board/nxp/imx8qxp_mek/imx8qxp_mek.c
+++ b/board/nxp/imx8qxp_mek/imx8qxp_mek.c
@@ -7,7 +7,6 @@
 #include <env.h>
 #include <errno.h>
 #include <init.h>
-#include <asm/global_data.h>
 #include <linux/delay.h>
 #include <linux/libfdt.h>
 #include <fsl_esdhc_imx.h>
@@ -21,8 +20,6 @@
 #include <asm/arch/iomux.h>
 #include <asm/arch/sys_proto.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define GPIO_PAD_CTRL	((SC_PAD_CONFIG_NORMAL << PADRING_CONFIG_SHIFT) | \
 			 (SC_PAD_ISO_OFF << PADRING_LPCONFIG_SHIFT) | \
 			 (SC_PAD_28FDSOI_DSE_DV_HIGH << PADRING_DSE_SHIFT) | \
diff --git a/board/phytec/imx8mp-libra-fpsc/spl.c b/board/phytec/imx8mp-libra-fpsc/spl.c
index d704d588579ecbc90ddf7a4070a13b3807ff064a..08111641aa6796470d81d991c6ac804e310b24b1 100644
--- a/board/phytec/imx8mp-libra-fpsc/spl.c
+++ b/board/phytec/imx8mp-libra-fpsc/spl.c
@@ -8,7 +8,6 @@
 #include <asm/arch/ddr.h>
 #include <asm/arch/imx8mp_pins.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
 #include <asm/mach-imx/boot_mode.h>
 #include <asm/mach-imx/gpio.h>
 #include <asm/mach-imx/mxc_i2c.h>
@@ -24,8 +23,6 @@
 #include "../common/imx8m_som_detection.h"
 #endif
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define EEPROM_ADDR		0x51
 
 int spl_board_boot_device(enum boot_device boot_dev_spl)
diff --git a/board/phytec/phycore_imx8mm/phycore-imx8mm.c b/board/phytec/phycore_imx8mm/phycore-imx8mm.c
index f6ae0bf03087064ad58bafd3facb587a84d96ef6..9f6a4ec704da89d79d37fa1e669824488353dfe1 100644
--- a/board/phytec/phycore_imx8mm/phycore-imx8mm.c
+++ b/board/phytec/phycore_imx8mm/phycore-imx8mm.c
@@ -5,14 +5,11 @@
  */
 
 #include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/mach-imx/boot_mode.h>
 #include <env.h>
 #include <miiphy.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static int setup_fec(void)
 {
 	struct iomuxc_gpr_base_regs *gpr =
diff --git a/board/phytec/phycore_imx8mm/spl.c b/board/phytec/phycore_imx8mm/spl.c
index faff064779c19a3eeace4bf14c74c5278f4087cd..e688793bc7451b4f8f8e37d1c8058b864cc3503e 100644
--- a/board/phytec/phycore_imx8mm/spl.c
+++ b/board/phytec/phycore_imx8mm/spl.c
@@ -8,7 +8,6 @@
 #include <asm/arch/ddr.h>
 #include <asm/arch/imx8mm_pins.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
 #include <asm/mach-imx/boot_mode.h>
 #include <asm/mach-imx/iomux-v3.h>
 #include <asm/sections.h>
@@ -19,8 +18,6 @@
 
 #include "../common/imx8m_som_detection.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define EEPROM_ADDR		0x51
 #define EEPROM_ADDR_FALLBACK	0x59
 
diff --git a/board/phytec/phycore_imx8mp/phycore-imx8mp.c b/board/phytec/phycore_imx8mp/phycore-imx8mp.c
index b345dc7c9856fd1fb149a1a7d6718a910c57be22..5f0a7ee6a94493b93a9c9419aaf4fb82d251cb40 100644
--- a/board/phytec/phycore_imx8mp/phycore-imx8mp.c
+++ b/board/phytec/phycore_imx8mp/phycore-imx8mp.c
@@ -5,7 +5,6 @@
  */
 
 #include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/mach-imx/boot_mode.h>
 #include <env.h>
@@ -17,8 +16,6 @@
 
 #include "../common/imx8m_som_detection.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define EEPROM_ADDR		0x51
 #define EEPROM_ADDR_FALLBACK	0x59
 
diff --git a/board/phytec/phycore_imx8mp/spl.c b/board/phytec/phycore_imx8mp/spl.c
index cb8e450b995669b0259d9d31055f992be576d30a..fc7aefd0073475298ab3ff58920b38d3883b3e81 100644
--- a/board/phytec/phycore_imx8mp/spl.c
+++ b/board/phytec/phycore_imx8mp/spl.c
@@ -8,7 +8,6 @@
 #include <asm/arch/ddr.h>
 #include <asm/arch/imx8mp_pins.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
 #include <asm/mach-imx/boot_mode.h>
 #include <asm/mach-imx/gpio.h>
 #include <asm/mach-imx/mxc_i2c.h>
@@ -23,8 +22,6 @@
 #include "lpddr4_timing.h"
 #include "../common/imx8m_som_detection.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define EEPROM_ADDR		0x51
 #define EEPROM_ADDR_FALLBACK	0x59
 
diff --git a/board/phytec/phycore_imx93/phycore-imx93.c b/board/phytec/phycore_imx93/phycore-imx93.c
index cfc6d91f20f2dad1e9ce517ce0e750f6226ed4f8..cdaedd52c141002b9ebafe4555a3f3877bff4d8c 100644
--- a/board/phytec/phycore_imx93/phycore-imx93.c
+++ b/board/phytec/phycore_imx93/phycore-imx93.c
@@ -7,15 +7,12 @@
  */
 
 #include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
 #include <asm/mach-imx/boot_mode.h>
 #include <env.h>
 #include <fdt_support.h>
 
 #include "../common/imx93_som_detection.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define EEPROM_ADDR            0x50
 
 int board_init(void)
diff --git a/board/polyhex/imx8mp_debix_model_a/imx8mp_debix_model_a.c b/board/polyhex/imx8mp_debix_model_a/imx8mp_debix_model_a.c
index c709d01748315a0f45712574f773df274caa2a4f..7f0925074fabfdbe5ac0bf8f58cd93707fd31a12 100644
--- a/board/polyhex/imx8mp_debix_model_a/imx8mp_debix_model_a.c
+++ b/board/polyhex/imx8mp_debix_model_a/imx8mp_debix_model_a.c
@@ -8,7 +8,6 @@
 #include <asm/arch/clock.h>
 #include <asm/arch/imx8mp_pins.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
 #include <asm/mach-imx/gpio.h>
 #include <asm/mach-imx/iomux-v3.h>
 #include <env.h>
@@ -18,8 +17,6 @@
 #include <miiphy.h>
 #include <netdev.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static void setup_fec(void)
 {
 	struct iomuxc_gpr_base_regs *gpr =
diff --git a/board/polyhex/imx8mp_debix_model_a/spl.c b/board/polyhex/imx8mp_debix_model_a/spl.c
index 6cbd1815cad5815c556cbec2456bc2997ee64945..c154ad7a1cefdd80682dc850d74803e57890617f 100644
--- a/board/polyhex/imx8mp_debix_model_a/spl.c
+++ b/board/polyhex/imx8mp_debix_model_a/spl.c
@@ -8,7 +8,6 @@
 #include <asm/arch/ddr.h>
 #include <asm/arch/imx8mp_pins.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
 #include <asm/mach-imx/boot_mode.h>
 #include <asm/sections.h>
 #include <dm/device.h>
@@ -20,8 +19,6 @@
 #include <power/pmic.h>
 #include <spl.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 int spl_board_boot_device(enum boot_device boot_dev_spl)
 {
 	return BOOT_DEVICE_BOOTROM;
diff --git a/board/purism/librem5/librem5.c b/board/purism/librem5/librem5.c
index 5178ee6929d8f7c278c8c9a8beb0541982c4ae0f..a2bc0c08f0b50fe681d717cc236c6f6185623b76 100644
--- a/board/purism/librem5/librem5.c
+++ b/board/purism/librem5/librem5.c
@@ -31,8 +31,6 @@
 #include <usb/xhci.h>
 #include "librem5.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 int board_early_init_f(void)
 {
 	return 0;
diff --git a/board/purism/librem5/spl.c b/board/purism/librem5/spl.c
index ed57554a2bc314a42c4be7c0e18e78d6c1d45199..568224f973244117672de4f2536a5de72e822702 100644
--- a/board/purism/librem5/spl.c
+++ b/board/purism/librem5/spl.c
@@ -29,8 +29,6 @@
 #include <linux/usb/gadget.h>
 #include "librem5.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 void spl_dram_init(void)
 {
 	/* ddr init */
diff --git a/board/qualcomm/dragonboard410c/dragonboard410c.c b/board/qualcomm/dragonboard410c/dragonboard410c.c
index 4698b9d5e3e47a9b0389d9f6bafab9dd6db56a41..36e4d49046e39a35e8a8fcdf605576366608ff2b 100644
--- a/board/qualcomm/dragonboard410c/dragonboard410c.c
+++ b/board/qualcomm/dragonboard410c/dragonboard410c.c
@@ -15,13 +15,10 @@
 #include <net.h>
 #include <usb.h>
 #include <asm/cache.h>
-#include <asm/global_data.h>
 #include <asm/gpio.h>
 #include <fdt_support.h>
 #include <linux/delay.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static u32 msm_board_serial(void)
 {
 	struct mmc *mmc_dev;
diff --git a/board/qualcomm/dragonboard820c/dragonboard820c.c b/board/qualcomm/dragonboard820c/dragonboard820c.c
index 12a9273ec4b9d240bc2eaed2834d5265290153ec..236022a99f12ff4aef182f6e6fece03e39f0dd84 100644
--- a/board/qualcomm/dragonboard820c/dragonboard820c.c
+++ b/board/qualcomm/dragonboard820c/dragonboard820c.c
@@ -10,7 +10,6 @@
 #include <init.h>
 #include <env.h>
 #include <asm/cache.h>
-#include <asm/global_data.h>
 #include <linux/arm-smccc.h>
 #include <linux/psci.h>
 #include <dm.h>
@@ -24,8 +23,6 @@
 /* Strength (sdc1) */
 #define SDC1_HDRV_PULL_CTL_REG          (TLMM_BASE_ADDR + 0x0012D000)
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static void sdhci_power_init(void)
 {
 	const u32 TLMM_PULL_MASK = 0x3;
diff --git a/board/renesas/common/gen3-common.c b/board/renesas/common/gen3-common.c
index f89ae81e95ec551b8b254fd0fee0b9839f798b85..5c543807b64b6cc495703060db22b451baaeb046 100644
--- a/board/renesas/common/gen3-common.c
+++ b/board/renesas/common/gen3-common.c
@@ -12,15 +12,12 @@
 #include <fdt_support.h>
 #include <hang.h>
 #include <init.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <dm/uclass-internal.h>
 #include <asm/arch/renesas.h>
 #include <asm-generic/u-boot.h>
 #include <linux/libfdt.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 /* If the firmware passed a device tree use it for e.g. U-Boot DRAM setup. */
 extern u64 rcar_atf_boot_args[];
 
diff --git a/board/renesas/common/gen4-common.c b/board/renesas/common/gen4-common.c
index 81c6f6f4c6ddbf78f50657bef9a31a4f3e8e6099..ac87f2f08e3a42d7920cb0fcb54eb7dd6b08b14e 100644
--- a/board/renesas/common/gen4-common.c
+++ b/board/renesas/common/gen4-common.c
@@ -8,7 +8,6 @@
 #include <asm/arch/renesas.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/armv8/mmu.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/mach-types.h>
 #include <asm/processor.h>
@@ -17,8 +16,6 @@
 #include <image.h>
 #include <linux/errno.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static void init_generic_timer(void)
 {
 	const u32 freq = CONFIG_SYS_CLK_FREQ;
diff --git a/board/renesas/common/gen5-common.c b/board/renesas/common/gen5-common.c
index 3b724e59049c0b451b6e346a6ecb9846c3226e97..c60a76c50382d1d6cb1ca81b5beabbf03ded3962 100644
--- a/board/renesas/common/gen5-common.c
+++ b/board/renesas/common/gen5-common.c
@@ -5,7 +5,6 @@
 
 #include <asm/arch/renesas.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/mach-types.h>
 #include <asm/processor.h>
@@ -13,8 +12,6 @@
 #include <asm-generic/u-boot.h>
 #include <linux/errno.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static void init_generic_timer(void)
 {
 	const u32 freq = CONFIG_SYS_CLK_FREQ;
diff --git a/board/ronetix/imx8mq-cm/imx8mq_cm.c b/board/ronetix/imx8mq-cm/imx8mq_cm.c
index 602216854ba475eab72035e3bf1182fda5434a7d..e41cfefe37587dad774a5a432be98cac0be97363 100644
--- a/board/ronetix/imx8mq-cm/imx8mq_cm.c
+++ b/board/ronetix/imx8mq-cm/imx8mq_cm.c
@@ -10,8 +10,6 @@
 #include <asm/arch/sys_proto.h>
 #include <asm/arch/clock.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define UART_PAD_CTRL	(PAD_CTL_DSE6 | PAD_CTL_FSEL1)
 
 #define WDOG_PAD_CTRL	(PAD_CTL_DSE6 | PAD_CTL_HYS | PAD_CTL_PUE)
diff --git a/board/samsung/common/exynos5-dt.c b/board/samsung/common/exynos5-dt.c
index 68edd1ec2826841c74702fd8f16f8e98b7519a18..2ba2d6330fd0c7b8d50fe9d23bc855e372e81b7a 100644
--- a/board/samsung/common/exynos5-dt.c
+++ b/board/samsung/common/exynos5-dt.c
@@ -9,7 +9,6 @@
 #include <env.h>
 #include <fdtdec.h>
 #include <log.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <errno.h>
 #include <i2c.h>
@@ -36,8 +35,6 @@
 #include <samsung/misc.h>
 #include <tmu.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static int exynos_set_regulator(const char *name, uint uv)
 {
 	struct udevice *dev;
diff --git a/board/samsung/common/misc.c b/board/samsung/common/misc.c
index c134a9d70e249328cc774c1dbd0fdfa3d4fdb744..85e564f27ee5c79a0e4d2a36fe2069c2cb06f258 100644
--- a/board/samsung/common/misc.c
+++ b/board/samsung/common/misc.c
@@ -8,7 +8,6 @@
 #include <command.h>
 #include <env.h>
 #include <libtizen.h>
-#include <asm/global_data.h>
 #include <linux/delay.h>
 #include <linux/printk.h>
 #include <samsung/misc.h>
@@ -37,8 +36,6 @@
 #include <power/pmic.h>
 #include <mmc.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #ifdef CONFIG_SET_DFU_ALT_INFO
 void set_dfu_alt_info(char *interface, char *devstr)
 {
diff --git a/board/st/stm32f429-discovery/stm32f429-discovery.c b/board/st/stm32f429-discovery/stm32f429-discovery.c
index 4b0defda1ecb148f283f22ce7ad505386aea4309..333b78c27f348b288eadb39bcf63db541c6b236a 100644
--- a/board/st/stm32f429-discovery/stm32f429-discovery.c
+++ b/board/st/stm32f429-discovery/stm32f429-discovery.c
@@ -14,13 +14,10 @@
 #include <env.h>
 #include <init.h>
 #include <log.h>
-#include <asm/global_data.h>
 
 #include <asm/io.h>
 #include <asm/arch/stm32.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 int dram_init(void)
 {
 	int rv;
diff --git a/board/st/stm32f429-evaluation/stm32f429-evaluation.c b/board/st/stm32f429-evaluation/stm32f429-evaluation.c
index 88c825334a8d06321d51b541388fc7f2d0e8395f..feba46d38e4a53e8b9187f6813e49c4b5ec6c868 100644
--- a/board/st/stm32f429-evaluation/stm32f429-evaluation.c
+++ b/board/st/stm32f429-evaluation/stm32f429-evaluation.c
@@ -8,13 +8,10 @@
 #include <env.h>
 #include <init.h>
 #include <log.h>
-#include <asm/global_data.h>
 
 #include <asm/io.h>
 #include <asm/arch/stm32.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 int dram_init(void)
 {
 	int rv;
diff --git a/board/st/stm32f469-discovery/stm32f469-discovery.c b/board/st/stm32f469-discovery/stm32f469-discovery.c
index 7aab7f71d0cf91756bf35553f5afc8cba82a4da6..d153efdc2b4b07cf8af8548e8e61a205f9e98ec2 100644
--- a/board/st/stm32f469-discovery/stm32f469-discovery.c
+++ b/board/st/stm32f469-discovery/stm32f469-discovery.c
@@ -8,13 +8,10 @@
 #include <env.h>
 #include <init.h>
 #include <log.h>
-#include <asm/global_data.h>
 
 #include <asm/io.h>
 #include <asm/arch/stm32.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 int dram_init(void)
 {
 	int rv;
diff --git a/board/st/stm32f746-disco/stm32f746-disco.c b/board/st/stm32f746-disco/stm32f746-disco.c
index 07bc8a5f0a27eabf8e36396034bc94156c6caca5..4b1e443100d1b0448cba8654fb723e0872f678aa 100644
--- a/board/st/stm32f746-disco/stm32f746-disco.c
+++ b/board/st/stm32f746-disco/stm32f746-disco.c
@@ -15,7 +15,6 @@
 #include <spl.h>
 #include <splash.h>
 #include <video.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/armv7m.h>
 #include <asm/arch/stm32.h>
@@ -23,8 +22,6 @@
 #include <asm/gpio.h>
 #include <linux/delay.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 int dram_init(void)
 {
 #ifndef CONFIG_XPL_BUILD
diff --git a/board/st/stm32h743-disco/stm32h743-disco.c b/board/st/stm32h743-disco/stm32h743-disco.c
index d00f55379c5ce9c0f685191e9623ad3c7983fc48..6c5c6710926fa507df0cafcd8cb977b56ad597e1 100644
--- a/board/st/stm32h743-disco/stm32h743-disco.c
+++ b/board/st/stm32h743-disco/stm32h743-disco.c
@@ -7,9 +7,6 @@
 #include <dm.h>
 #include <init.h>
 #include <log.h>
-#include <asm/global_data.h>
-
-DECLARE_GLOBAL_DATA_PTR;
 
 int dram_init(void)
 {
diff --git a/board/st/stm32h743-eval/stm32h743-eval.c b/board/st/stm32h743-eval/stm32h743-eval.c
index d00f55379c5ce9c0f685191e9623ad3c7983fc48..6c5c6710926fa507df0cafcd8cb977b56ad597e1 100644
--- a/board/st/stm32h743-eval/stm32h743-eval.c
+++ b/board/st/stm32h743-eval/stm32h743-eval.c
@@ -7,9 +7,6 @@
 #include <dm.h>
 #include <init.h>
 #include <log.h>
-#include <asm/global_data.h>
-
-DECLARE_GLOBAL_DATA_PTR;
 
 int dram_init(void)
 {
diff --git a/board/st/stm32h747-disco/stm32h747-disco.c b/board/st/stm32h747-disco/stm32h747-disco.c
index 645685a64f19c66e5e81d29eb319f4869863a509..24a229bf0a29906bb3c2197e36ec6ef2f6e8a85f 100644
--- a/board/st/stm32h747-disco/stm32h747-disco.c
+++ b/board/st/stm32h747-disco/stm32h747-disco.c
@@ -8,9 +8,6 @@
 #include <dm.h>
 #include <init.h>
 #include <log.h>
-#include <asm/global_data.h>
-
-DECLARE_GLOBAL_DATA_PTR;
 
 int dram_init(void)
 {
diff --git a/board/st/stm32h750-art-pi/stm32h750-art-pi.c b/board/st/stm32h750-art-pi/stm32h750-art-pi.c
index 31c85c6816e98c4567b399f301829c168333b388..244bb5eefb3a3bb2b253e91a03664497d6808b56 100644
--- a/board/st/stm32h750-art-pi/stm32h750-art-pi.c
+++ b/board/st/stm32h750-art-pi/stm32h750-art-pi.c
@@ -7,9 +7,6 @@
 #include <dm.h>
 #include <init.h>
 #include <log.h>
-#include <asm/global_data.h>
-
-DECLARE_GLOBAL_DATA_PTR;
 
 int dram_init(void)
 {
diff --git a/board/technexion/pico-imx8mq/pico-imx8mq.c b/board/technexion/pico-imx8mq/pico-imx8mq.c
index 1659db112fa150a24dc35e1bbba7ef852bfd0328..5515fc09f996ff08cfbcbc6b0abe009db2915085 100644
--- a/board/technexion/pico-imx8mq/pico-imx8mq.c
+++ b/board/technexion/pico-imx8mq/pico-imx8mq.c
@@ -7,7 +7,6 @@
 #include <init.h>
 #include <malloc.h>
 #include <errno.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <miiphy.h>
 #include <netdev.h>
@@ -24,8 +23,6 @@
 #include <spl.h>
 #include <power/pmic.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define UART_PAD_CTRL	(PAD_CTL_DSE6 | PAD_CTL_FSEL1)
 
 #define WDOG_PAD_CTRL	(PAD_CTL_DSE6 | PAD_CTL_HYS | PAD_CTL_PUE)
diff --git a/board/ti/am62x/evm.c b/board/ti/am62x/evm.c
index 2e8336900d1ca8dee9502868d026b290524ffbcb..49e58ad6d6c88d1e4cd41c3a273be6f7441ab609 100644
--- a/board/ti/am62x/evm.c
+++ b/board/ti/am62x/evm.c
@@ -32,8 +32,6 @@
 #define board_is_am62x_lp_skevm()  board_ti_k3_is("AM62-LP-SKEVM")
 #define board_is_am62x_sip_skevm()  board_ti_k3_is("AM62SIP-SKEVM")
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #if CONFIG_IS_ENABLED(SPLASH_SCREEN)
 static struct splash_location default_splash_locations[] = {
 	{
diff --git a/board/ti/am64x/evm.c b/board/ti/am64x/evm.c
index 25076a8a5886e2161ef6572aab7e84fc58ff1f06..764e3011bac35910081713985c0f4564237f91a1 100644
--- a/board/ti/am64x/evm.c
+++ b/board/ti/am64x/evm.c
@@ -27,8 +27,6 @@
 #define board_is_am64x_skevm() (board_ti_k3_is("AM64-SKEVM") || \
 				board_ti_k3_is("AM64B-SKEVM"))
 
-DECLARE_GLOBAL_DATA_PTR;
-
 struct efi_fw_image fw_images[] = {
 	{
 		.image_type_id = AM64X_SK_TIBOOT3_IMAGE_GUID,
diff --git a/board/ti/j784s4/evm.c b/board/ti/j784s4/evm.c
index cabb3017ee142d8bf572c75b24813c9080d982cd..8a4d40a5a95986279ddf61496c1d0cf394eb95e9 100644
--- a/board/ti/j784s4/evm.c
+++ b/board/ti/j784s4/evm.c
@@ -14,8 +14,6 @@
 #include <asm/arch/k3-ddr.h>
 #include "../common/fdt_ops.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 struct efi_fw_image fw_images[] = {
 	{
 		.image_type_id = AM69_SK_TIBOOT3_IMAGE_GUID,
diff --git a/board/toradex/apalis-imx8/apalis-imx8.c b/board/toradex/apalis-imx8/apalis-imx8.c
index a8c3820869331632b101c50f9d6a19e9c96dd446..b915673d9e37e3e784af8cac9b024207f8638ad7 100644
--- a/board/toradex/apalis-imx8/apalis-imx8.c
+++ b/board/toradex/apalis-imx8/apalis-imx8.c
@@ -5,7 +5,6 @@
 
 #include <cpu_func.h>
 #include <init.h>
-#include <asm/global_data.h>
 
 #include <asm/arch/clock.h>
 #include <asm/arch/imx8-pins.h>
@@ -24,8 +23,6 @@
 
 #include "../common/tdx-cfg-block.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define UART_PAD_CTRL	((SC_PAD_CONFIG_OUT_IN << PADRING_CONFIG_SHIFT) | \
 			 (SC_PAD_ISO_OFF << PADRING_LPCONFIG_SHIFT) | \
 			 (SC_PAD_28FDSOI_DSE_DV_HIGH << PADRING_DSE_SHIFT) | \
diff --git a/board/toradex/apalis_t30/apalis_t30.c b/board/toradex/apalis_t30/apalis_t30.c
index 2c785da41eaa411f00e83723cde4593ee10486d6..8dad41f4122f106c4b54db89685840fca9131543 100644
--- a/board/toradex/apalis_t30/apalis_t30.c
+++ b/board/toradex/apalis_t30/apalis_t30.c
@@ -11,7 +11,6 @@
 #include <asm/arch/pinmux.h>
 #include <asm/arch-tegra/ap.h>
 #include <asm/arch-tegra/tegra.h>
-#include <asm/global_data.h>
 #include <asm/gpio.h>
 #include <asm/io.h>
 #include <dm.h>
@@ -23,8 +22,6 @@
 
 #include "pinmux-config-apalis_t30.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define PMU_I2C_ADDRESS		0x2D
 #define MAX_I2C_RETRY		3
 
diff --git a/board/toradex/colibri-imx8x/colibri-imx8x.c b/board/toradex/colibri-imx8x/colibri-imx8x.c
index 2a71e7b92de425b4759f07b29d833049d38e008b..0a86420700dd054b1e08ccb11b60da2df7cc9e62 100644
--- a/board/toradex/colibri-imx8x/colibri-imx8x.c
+++ b/board/toradex/colibri-imx8x/colibri-imx8x.c
@@ -5,7 +5,6 @@
 
 #include <cpu_func.h>
 #include <init.h>
-#include <asm/global_data.h>
 
 #include <asm/arch/clock.h>
 #include <asm/arch/imx8-pins.h>
@@ -21,8 +20,6 @@
 
 #include "../common/tdx-cfg-block.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define UART_PAD_CTRL	((SC_PAD_CONFIG_OUT_IN << PADRING_CONFIG_SHIFT) | \
 			 (SC_PAD_ISO_OFF << PADRING_LPCONFIG_SHIFT) | \
 			 (SC_PAD_28FDSOI_DSE_DV_HIGH << PADRING_DSE_SHIFT) | \
diff --git a/board/toradex/colibri_t20/colibri_t20.c b/board/toradex/colibri_t20/colibri_t20.c
index 05c3377a60bc0d43de4e49355c46dc1f87010782..ccfe2c4933c5f163c7148ffae05d55f67f9c9cc1 100644
--- a/board/toradex/colibri_t20/colibri_t20.c
+++ b/board/toradex/colibri_t20/colibri_t20.c
@@ -13,7 +13,6 @@
 #include <asm/arch-tegra/ap.h>
 #include <asm/arch-tegra/board.h>
 #include <asm/arch-tegra/tegra.h>
-#include <asm/global_data.h>
 #include <asm/gpio.h>
 #include <asm/io.h>
 #include <i2c.h>
@@ -21,8 +20,6 @@
 #include <linux/delay.h>
 #include "../common/tdx-common.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define PMU_I2C_ADDRESS		0x34
 #define MAX_I2C_RETRY		3
 #define PMU_SUPPLYENE		0x14
diff --git a/board/toradex/common/tdx-cfg-block.c b/board/toradex/common/tdx-cfg-block.c
index 0fc3759695fc1043d566b28082b0a5196173f15e..e53530175aeef26e6afd0525578c1b7078877e1c 100644
--- a/board/toradex/common/tdx-cfg-block.c
+++ b/board/toradex/common/tdx-cfg-block.c
@@ -4,7 +4,6 @@
  */
 
 #include <config.h>
-#include <asm/global_data.h>
 #include "tdx-cfg-block.h"
 #include "tdx-eeprom.h"
 
@@ -22,8 +21,6 @@
 #include <nand.h>
 #include <asm/mach-types.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define TAG_VALID	0xcf01
 #define TAG_MAC		0x0000
 #define TAG_CAR_SERIAL	0x0021
diff --git a/board/toradex/smarc-imx8mp/smarc-imx8mp.c b/board/toradex/smarc-imx8mp/smarc-imx8mp.c
index 915b413b15e9aa94bf59df5b9c0c4deb18f0cb10..38fb3d61f5bf08678eb1c58ce158e1178ccf8166 100644
--- a/board/toradex/smarc-imx8mp/smarc-imx8mp.c
+++ b/board/toradex/smarc-imx8mp/smarc-imx8mp.c
@@ -2,14 +2,11 @@
 /* Copyright (C) 2024 Toradex */
 
 #include <init.h>
-#include <asm/global_data.h>
 #include <asm-generic/gpio.h>
 #include <linux/errno.h>
 
 #include "../common/tdx-cfg-block.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 int board_phys_sdram_size(phys_size_t *size)
 {
 	if (!size)
diff --git a/board/toradex/smarc-imx8mp/spl.c b/board/toradex/smarc-imx8mp/spl.c
index 32233c0e1ab9c4afc0051791ffec863a6bfddcd0..511f62e871b3f030dbc618bdf1ebb91862334f38 100644
--- a/board/toradex/smarc-imx8mp/spl.c
+++ b/board/toradex/smarc-imx8mp/spl.c
@@ -8,7 +8,6 @@
 #include <asm/arch/clock.h>
 #include <asm/arch/ddr.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
 #include <asm/mach-imx/boot_mode.h>
 #include <dm/device.h>
 #include <power/pmic.h>
@@ -16,8 +15,6 @@
 
 #include "lpddr4_timing.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 int spl_board_boot_device(enum boot_device boot_dev_spl)
 {
 	return BOOT_DEVICE_BOOTROM;
diff --git a/board/toradex/verdin-imx8mm/spl.c b/board/toradex/verdin-imx8mm/spl.c
index 3c2d0ba1dd463236a990eb397ee8bb16b73d878a..10b9991e3bf92c81568f96caca32f61481211b4d 100644
--- a/board/toradex/verdin-imx8mm/spl.c
+++ b/board/toradex/verdin-imx8mm/spl.c
@@ -11,7 +11,6 @@
 #include <asm/arch/ddr.h>
 #include <asm/arch/imx8mm_pins.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/mach-imx/boot_mode.h>
 #include <asm/mach-imx/iomux-v3.h>
@@ -27,8 +26,6 @@
 #include <power/pmic.h>
 #include <spl.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define I2C_PMIC_BUS_ID        1
 
 int spl_board_boot_device(enum boot_device boot_dev_spl)
diff --git a/board/toradex/verdin-imx8mm/verdin-imx8mm.c b/board/toradex/verdin-imx8mm/verdin-imx8mm.c
index b44024158453c48611a872eaacdbe0ba612d4580..b56f5bf30a836b84057c601f79059c48aa758e7b 100644
--- a/board/toradex/verdin-imx8mm/verdin-imx8mm.c
+++ b/board/toradex/verdin-imx8mm/verdin-imx8mm.c
@@ -7,7 +7,6 @@
 #include <init.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <hang.h>
 #include <i2c.h>
@@ -17,8 +16,6 @@
 
 #include "../common/tdx-cfg-block.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define I2C_PMIC	0
 
 enum pcb_rev_t {
diff --git a/board/toradex/verdin-imx8mp/spl.c b/board/toradex/verdin-imx8mp/spl.c
index 8628112a78258cdbb935761467522033fe6b7593..b39058b1b5d9223a6abade2a8993cffaddec4b96 100644
--- a/board/toradex/verdin-imx8mp/spl.c
+++ b/board/toradex/verdin-imx8mp/spl.c
@@ -7,7 +7,6 @@
 #include <init.h>
 #include <log.h>
 #include <spl.h>
-#include <asm/global_data.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/imx8mp_pins.h>
 #include <asm/arch/sys_proto.h>
@@ -22,8 +21,6 @@
 #include <power/pca9450.h>
 #include "lpddr4_timing.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 int spl_board_boot_device(enum boot_device boot_dev_spl)
 {
 	return BOOT_DEVICE_BOOTROM;
diff --git a/board/toradex/verdin-imx8mp/verdin-imx8mp.c b/board/toradex/verdin-imx8mp/verdin-imx8mp.c
index 34ce25512e8b54d30ef57553255b04e5f822c10c..59b4607f065142d22aae963457e85419380eb378 100644
--- a/board/toradex/verdin-imx8mp/verdin-imx8mp.c
+++ b/board/toradex/verdin-imx8mp/verdin-imx8mp.c
@@ -8,7 +8,6 @@
 #include <asm/arch/imx8mp_pins.h>
 #include <asm/arch/sys_proto.h>
 #include <asm-generic/gpio.h>
-#include <asm/global_data.h>
 #include <asm/mach-imx/gpio.h>
 #include <asm/mach-imx/iomux-v3.h>
 #include <errno.h>
@@ -21,8 +20,6 @@
 
 #include "../common/tdx-cfg-block.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define UART_PAD_CTRL	(PAD_CTL_DSE6 | PAD_CTL_FSEL1)
 
 /* Verdin UART_3, Console/Debug UART */
diff --git a/board/xilinx/zynq/bootimg.c b/board/xilinx/zynq/bootimg.c
index 9eb0735f55d3ca9e5f22ac895aff3b2f856b1b5b..52400672799440260e288d0119b99e1123977d5b 100644
--- a/board/xilinx/zynq/bootimg.c
+++ b/board/xilinx/zynq/bootimg.c
@@ -5,15 +5,12 @@
 
 #include <log.h>
 #include <part.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/sys_proto.h>
 #include <u-boot/md5.h>
 #include <zynq_bootimg.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define ZYNQ_IMAGE_PHDR_OFFSET		0x09C
 #define ZYNQ_IMAGE_FSBL_LEN_OFFSET	0x040
 #define ZYNQ_PART_HDR_CHKSUM_WORD_COUNT	0x0F
diff --git a/boot/bootmeth-uclass.c b/boot/bootmeth-uclass.c
index a9709465f6e75690cc06510de38bac3eba8f04bf..c841dd0d6d4435751c152175b622314ea7ca3dd5 100644
--- a/boot/bootmeth-uclass.c
+++ b/boot/bootmeth-uclass.c
@@ -19,8 +19,6 @@
 #include <mapmem.h>
 #include <dm/uclass-internal.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 int bootmeth_get_state_desc(struct udevice *dev, char *buf, int maxsize)
 {
 	const struct bootmeth_ops *ops = bootmeth_get_ops(dev);
diff --git a/boot/fdt_simplefb.c b/boot/fdt_simplefb.c
index 5822131767d19991a921c8d1eeb5da058a065f76..69c7c2e24c03ce3850bf35a3b49e1512ff363855 100644
--- a/boot/fdt_simplefb.c
+++ b/boot/fdt_simplefb.c
@@ -8,14 +8,11 @@
 
 #include <dm.h>
 #include <fdt_support.h>
-#include <asm/global_data.h>
 #include <linux/libfdt.h>
 #include <video.h>
 #include <spl.h>
 #include <bloblist.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static int fdt_simplefb_configure_node(void *blob, int off)
 {
 	int xsize, ysize;
diff --git a/boot/image-sig.c b/boot/image-sig.c
index 6bc74866eaedca3f17e78136ebad2c7c74178928..4eab017bc2db26ecac04f221e6d24b752aa24765 100644
--- a/boot/image-sig.c
+++ b/boot/image-sig.c
@@ -5,8 +5,6 @@
 
 #include <log.h>
 #include <malloc.h>
-#include <asm/global_data.h>
-DECLARE_GLOBAL_DATA_PTR;
 #include <image.h>
 #include <relocate.h>
 #include <u-boot/ecdsa.h>
diff --git a/boot/image.c b/boot/image.c
index dd96f712b6fbe6ba9f0de8739b37b6868bc14a25..3f7452547636ef5dd99dc9baac6e2cacdbe203a3 100644
--- a/boot/image.c
+++ b/boot/image.c
@@ -24,12 +24,9 @@
 #include <fdt_support.h>
 #endif
 
-#include <asm/global_data.h>
 #include <linux/errno.h>
 #include <asm/io.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 /* Set this if we have less than 4 MB of malloc() space */
 #if CONFIG_SYS_MALLOC_LEN < (4096 * 1024)
 #define CONSERVE_MEMORY		true
diff --git a/cmd/bloblist.c b/cmd/bloblist.c
index 333ae558142c9efe9003e7ee89a91384fc4b727e..318a1af0220db92effe96dfc20a0210c5b6aa18b 100644
--- a/cmd/bloblist.c
+++ b/cmd/bloblist.c
@@ -8,9 +8,6 @@
 
 #include <bloblist.h>
 #include <command.h>
-#include <asm/global_data.h>
-
-DECLARE_GLOBAL_DATA_PTR;
 
 static int do_bloblist_info(struct cmd_tbl *cmdtp, int flag, int argc,
 			    char *const argv[])
diff --git a/cmd/bootefi.c b/cmd/bootefi.c
index b8f5bb3595044b7130994637e4123f6e3c1272aa..85f41c3b0a06483d1dc414a9fa7e8688ae86ff6f 100644
--- a/cmd/bootefi.c
+++ b/cmd/bootefi.c
@@ -17,11 +17,8 @@
 #include <mapmem.h>
 #include <vsprintf.h>
 #include <asm-generic/sections.h>
-#include <asm/global_data.h>
 #include <linux/string.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static struct efi_device_path *test_image_path;
 static struct efi_device_path *test_device_path;
 
diff --git a/cmd/bootm.c b/cmd/bootm.c
index 2c5aea26d98e518c0306e73390f83549e7fb1ca5..ca7cec91fadc5fec5f8fde68160e64ba55507e9f 100644
--- a/cmd/bootm.c
+++ b/cmd/bootm.c
@@ -15,14 +15,11 @@
 #include <malloc.h>
 #include <nand.h>
 #include <asm/byteorder.h>
-#include <asm/global_data.h>
 #include <linux/ctype.h>
 #include <linux/err.h>
 #include <u-boot/zlib.h>
 #include <mapmem.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #if defined(CONFIG_CMD_IMI)
 static int image_info(unsigned long addr);
 #endif
diff --git a/cmd/date.c b/cmd/date.c
index 8614f0227614c2ae602271e2d8235c6403b3b41e..d047872289c316d6f6ef3bc288ec06691f10cd9e 100644
--- a/cmd/date.c
+++ b/cmd/date.c
@@ -11,9 +11,6 @@
 #include <dm.h>
 #include <rtc.h>
 #include <i2c.h>
-#include <asm/global_data.h>
-
-DECLARE_GLOBAL_DATA_PTR;
 
 static const char * const weekdays[] = {
 	"Sun", "Mon", "Tues", "Wednes", "Thurs", "Fri", "Satur",
diff --git a/cmd/mem.c b/cmd/mem.c
index 8690fc1e4e6b93d78b48cf4c080c7f52bf2504c8..68eb6989b945b6a3eebd3eba69f74bf79da519bc 100644
--- a/cmd/mem.c
+++ b/cmd/mem.c
@@ -28,15 +28,12 @@
 #include <time.h>
 #include <vsprintf.h>
 #include <watchdog.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
 #include <linux/compiler.h>
 #include <linux/ctype.h>
 #include <linux/delay.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 /* Create a compile-time value */
 #if MEM_SUPPORT_64BIT_DATA
 #define HELP_Q ", .q"
diff --git a/cmd/sound.c b/cmd/sound.c
index 8f67cbd96e17a90249b6a36ca898c7076445e19c..7546059022f930d18687964cacf455e3deab1a2d 100644
--- a/cmd/sound.c
+++ b/cmd/sound.c
@@ -8,9 +8,6 @@
 #include <dm.h>
 #include <fdtdec.h>
 #include <sound.h>
-#include <asm/global_data.h>
-
-DECLARE_GLOBAL_DATA_PTR;
 
 /* Initilaise sound subsystem */
 static int do_init(struct cmd_tbl *cmdtp, int flag, int argc,
diff --git a/cmd/spl.c b/cmd/spl.c
index f591dc07fb66c4689aadcc27f9f245dbc5a49e7b..ddbbd4a817283ede766e24c46212a7db6b8cf709 100644
--- a/cmd/spl.c
+++ b/cmd/spl.c
@@ -9,11 +9,8 @@
 #include <env.h>
 #include <image.h>
 #include <log.h>
-#include <asm/global_data.h>
 #include <linux/libfdt.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static const char **subcmd_list[] = {
 
 	[SPL_EXPORT_FDT] = (const char * []) {
diff --git a/common/cli_hush.c b/common/cli_hush.c
index fb087960c9206b1e7fe4454bae53f6bc1cec1bdf..fe8fe93bd5466c7494d4bb08a8b652364644fe9d 100644
--- a/common/cli_hush.c
+++ b/common/cli_hush.c
@@ -84,7 +84,6 @@
 #include <cli_hush.h>
 #include <command.h>        /* find_cmd */
 #include <vsprintf.h>
-#include <asm/global_data.h>
 #endif
 #ifndef __U_BOOT__
 #include <ctype.h>     /* isalpha, isdigit */
@@ -125,8 +124,6 @@
 #endif
 
 #ifdef __U_BOOT__
-DECLARE_GLOBAL_DATA_PTR;
-
 #define EXIT_SUCCESS 0
 #define EOF -1
 #define syntax() syntax_err()
diff --git a/common/stdio.c b/common/stdio.c
index 3eeb289dd8bff201327de4af73f313e9c5128c5d..fc9659442098165981ed7a4bb0cfbae00e7d1a2d 100644
--- a/common/stdio.c
+++ b/common/stdio.c
@@ -18,11 +18,8 @@
 #include <serial.h>
 #include <splash.h>
 #include <i2c.h>
-#include <asm/global_data.h>
 #include <dm/device-internal.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static struct stdio_dev devs;
 struct stdio_dev *stdio_devices[] = { NULL, NULL, NULL };
 char *stdio_names[MAX_FILES] = { "stdin", "stdout", "stderr" };
diff --git a/drivers/block/sandbox.c b/drivers/block/sandbox.c
index 9cb27561a97f450a0c9abf5647bd5c23fad1a50d..4b3de0529ce4ea7890ed436d4f64e061ec86ed48 100644
--- a/drivers/block/sandbox.c
+++ b/drivers/block/sandbox.c
@@ -10,13 +10,10 @@
 #include <os.h>
 #include <malloc.h>
 #include <sandbox_host.h>
-#include <asm/global_data.h>
 #include <dm/device_compat.h>
 #include <dm/device-internal.h>
 #include <linux/errno.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static unsigned long host_block_read(struct udevice *dev,
 				     lbaint_t start, lbaint_t blkcnt,
 				     void *buffer)
diff --git a/drivers/bootcount/pmic_pfuze100.c b/drivers/bootcount/pmic_pfuze100.c
index 8c529f5592b43e19a41ed48234cf92f2b797cb68..dd11344322b3c3f3ad282875273d5d436628e29e 100644
--- a/drivers/bootcount/pmic_pfuze100.c
+++ b/drivers/bootcount/pmic_pfuze100.c
@@ -13,8 +13,6 @@
 #include <power/pmic.h>
 #include <power/pfuze100_pmic.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define PFUZE_BC_MAGIC 0xdead
 
 struct bootcount_pmic_priv {
diff --git a/drivers/cache/sandbox_cache.c b/drivers/cache/sandbox_cache.c
index 375892fafb02e9e0ea391a53f9bbc6c90cc37994..b27960f1bfa936b172365911a15105b22816e671 100644
--- a/drivers/cache/sandbox_cache.c
+++ b/drivers/cache/sandbox_cache.c
@@ -6,9 +6,6 @@
 #include <cache.h>
 #include <dm.h>
 #include <errno.h>
-#include <asm/global_data.h>
-
-DECLARE_GLOBAL_DATA_PTR;
 
 static int sandbox_get_info(struct udevice *dev, struct cache_info *info)
 {
diff --git a/drivers/clk/altera/clk-agilex.c b/drivers/clk/altera/clk-agilex.c
index fdbf834bb2f6ae85025a2d11f25f8b1de025871d..9d49561512bf1cea549d6a49bbbb7c00526871f6 100644
--- a/drivers/clk/altera/clk-agilex.c
+++ b/drivers/clk/altera/clk-agilex.c
@@ -6,7 +6,6 @@
 
 #include <log.h>
 #include <wait_bit.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/system.h>
 #include <clk-uclass.h>
@@ -19,8 +18,6 @@
 
 #include <asm/arch/clock_manager.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 struct socfpga_clk_plat {
 	void __iomem *regs;
 	int pllgrp;
diff --git a/drivers/clk/altera/clk-agilex5.c b/drivers/clk/altera/clk-agilex5.c
index fb1e72ffc5cdef4d641982daf2b57f185ec327c8..92b91a9dfc8d8207283b2c5bbbcae77e0f2df30c 100644
--- a/drivers/clk/altera/clk-agilex5.c
+++ b/drivers/clk/altera/clk-agilex5.c
@@ -12,7 +12,6 @@
 #include <stdio.h>
 #include <time.h>
 #include <vsprintf.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/system.h>
 #include <dm/lists.h>
@@ -26,8 +25,6 @@
 #include <wait_bit.h>
 #include <clk-uclass.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define CLKMGR_CTRL_SWCTRLBTCLKEN_MASK		BIT(8)
 #define CLKMGR_CTRL_SWCTRLBTCLKSEL_MASK		BIT(9)
 
diff --git a/drivers/clk/altera/clk-mem-n5x.c b/drivers/clk/altera/clk-mem-n5x.c
index b75f52d203b23b600b53ddbdf0fe5d2ef38c01a6..ac59571a8532af966e80a7f31af18c5c7bda9902 100644
--- a/drivers/clk/altera/clk-mem-n5x.c
+++ b/drivers/clk/altera/clk-mem-n5x.c
@@ -4,7 +4,6 @@
  */
 
 #include <asm/arch/clock_manager.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include "clk-mem-n5x.h"
 #include <clk-uclass.h>
@@ -13,8 +12,6 @@
 #include <dm/util.h>
 #include <dt-bindings/clock/n5x-clock.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 struct socfpga_mem_clk_plat {
 	void __iomem *regs;
 };
diff --git a/drivers/clk/altera/clk-n5x.c b/drivers/clk/altera/clk-n5x.c
index 9e4e7a1d90879bf89cb07212b9d3c894bb203fc7..185c9028a78dce18c290274f3d415877629950b3 100644
--- a/drivers/clk/altera/clk-n5x.c
+++ b/drivers/clk/altera/clk-n5x.c
@@ -4,7 +4,6 @@
  */
 
 #include <asm/arch/clock_manager.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <clk-uclass.h>
 #include <dm.h>
@@ -12,8 +11,6 @@
 #include <dm/util.h>
 #include <dt-bindings/clock/n5x-clock.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 struct socfpga_clk_plat {
 	void __iomem *regs;
 };
diff --git a/drivers/clk/rockchip/clk_px30.c b/drivers/clk/rockchip/clk_px30.c
index b5054e84c3269d40f70d01a6d755264d85f32a3a..d143a6b85ee6a2be57778abdab162f5ca3d4df80 100644
--- a/drivers/clk/rockchip/clk_px30.c
+++ b/drivers/clk/rockchip/clk_px30.c
@@ -13,15 +13,12 @@
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/cru_px30.h>
 #include <asm/arch-rockchip/hardware.h>
-#include <asm/global_data.h>
 #include <dm/device-internal.h>
 #include <dm/lists.h>
 #include <dt-bindings/clock/px30-cru.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 enum {
 	VCO_MAX_HZ	= 3200U * 1000000,
 	VCO_MIN_HZ	= 800 * 1000000,
diff --git a/drivers/clk/rockchip/clk_rk3308.c b/drivers/clk/rockchip/clk_rk3308.c
index e73bb6790af262c81a2ae11d94d700ec307d8861..97043b8693c03de423b4d724f1db153fcb6c3ff6 100644
--- a/drivers/clk/rockchip/clk_rk3308.c
+++ b/drivers/clk/rockchip/clk_rk3308.c
@@ -10,7 +10,6 @@
 #include <log.h>
 #include <malloc.h>
 #include <syscon.h>
-#include <asm/global_data.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/cru_rk3308.h>
 #include <asm/arch-rockchip/hardware.h>
@@ -19,8 +18,6 @@
 #include <dt-bindings/clock/rk3308-cru.h>
 #include <linux/bitops.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 enum {
 	VCO_MAX_HZ	= 3200U * 1000000,
 	VCO_MIN_HZ	= 800 * 1000000,
diff --git a/drivers/clk/rockchip/clk_rk3528.c b/drivers/clk/rockchip/clk_rk3528.c
index d58557ff56de1b5e69cf0f51aa6ac9ab99bafd5f..bcdc0f930d25e3716673a40b304011b4a9bb6eae 100644
--- a/drivers/clk/rockchip/clk_rk3528.c
+++ b/drivers/clk/rockchip/clk_rk3528.c
@@ -17,8 +17,6 @@
 #include <dt-bindings/clock/rockchip,rk3528-cru.h>
 #include <linux/delay.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define DIV_TO_RATE(input_rate, div)	((input_rate) / ((div) + 1))
 
 /*
diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
index 533031caead6818fe41774c9efee969fdd428dbc..bb49af358e6056d21c873ef739dd2ba8c889e2c1 100644
--- a/drivers/clk/rockchip/clk_rk3568.c
+++ b/drivers/clk/rockchip/clk_rk3568.c
@@ -16,8 +16,6 @@
 #include <dm/lists.h>
 #include <dt-bindings/clock/rk3568-cru.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #if CONFIG_IS_ENABLED(OF_PLATDATA)
 struct rk3568_clk_plat {
 	struct dtd_rockchip_rk3568_cru dtd;
diff --git a/drivers/clk/rockchip/clk_rk3576.c b/drivers/clk/rockchip/clk_rk3576.c
index 125b08ee8322e26ae91b3e8ef8c1fc398db2eab8..1026af27ca133e15a93a15445da5998481b742a6 100644
--- a/drivers/clk/rockchip/clk_rk3576.c
+++ b/drivers/clk/rockchip/clk_rk3576.c
@@ -17,8 +17,6 @@
 #include <dt-bindings/clock/rockchip,rk3576-cru.h>
 #include <linux/delay.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define DIV_TO_RATE(input_rate, div)	((input_rate) / ((div) + 1))
 
 static struct rockchip_pll_rate_table rk3576_24m_pll_rates[] = {
diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
index 8c3a113526f902ef25bd0f661b28a021b18744f2..be401a9faeec90b69fcd8c918c7ca1dc0dee29d8 100644
--- a/drivers/clk/rockchip/clk_rk3588.c
+++ b/drivers/clk/rockchip/clk_rk3588.c
@@ -17,8 +17,6 @@
 #include <dm/lists.h>
 #include <dt-bindings/clock/rockchip,rk3588-cru.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define DIV_TO_RATE(input_rate, div)	((input_rate) / ((div) + 1))
 
 static struct rockchip_pll_rate_table rk3588_pll_rates[] = {
diff --git a/drivers/clk/rockchip/clk_rv1108.c b/drivers/clk/rockchip/clk_rv1108.c
index 75202a66aa68c1a4f820bab29b317ea484f95632..e1b9ccf1236ae6c82f9ce0103e6a228ebd1b511e 100644
--- a/drivers/clk/rockchip/clk_rv1108.c
+++ b/drivers/clk/rockchip/clk_rv1108.c
@@ -11,7 +11,6 @@
 #include <log.h>
 #include <malloc.h>
 #include <syscon.h>
-#include <asm/global_data.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/cru_rv1108.h>
 #include <asm/arch-rockchip/hardware.h>
@@ -21,8 +20,6 @@
 #include <linux/delay.h>
 #include <linux/stringify.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 enum {
 	VCO_MAX_HZ	= 2400U * 1000000,
 	VCO_MIN_HZ	= 600 * 1000000,
diff --git a/drivers/clk/rockchip/clk_rv1126.c b/drivers/clk/rockchip/clk_rv1126.c
index aeeea95691479e8a6a450fb25b27f1b86d9494cb..39920d34b75a338838a2235aa72cb9d3ac302864 100644
--- a/drivers/clk/rockchip/clk_rv1126.c
+++ b/drivers/clk/rockchip/clk_rv1126.c
@@ -18,8 +18,6 @@
 #include <dm/lists.h>
 #include <dt-bindings/clock/rockchip,rv1126-cru.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define RV1126_CPUCLK_RATE(_rate, _aclk_div, _pclk_div)		\
 {								\
 	.rate	= _rate##U,					\
diff --git a/drivers/cpu/bcm283x_cpu.c b/drivers/cpu/bcm283x_cpu.c
index 59a7b142c95210aced2604dae20b020e29acb76c..ad638cd8fff91a6ed5e77cac6a1147eaeca610ee 100644
--- a/drivers/cpu/bcm283x_cpu.c
+++ b/drivers/cpu/bcm283x_cpu.c
@@ -11,7 +11,6 @@
 #include <asm/armv8/cpu.h>
 #include <asm/cache.h>
 #include <asm/io.h>
-#include <asm/global_data.h>
 #include <asm/system.h>
 #include <asm-generic/sections.h>
 #include <linux/bitops.h>
@@ -19,8 +18,6 @@
 #include <linux/delay.h>
 #include "armv8_cpu.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 struct bcm_plat {
 	u64 release_addr;
 };
diff --git a/drivers/cpu/cpu-uclass.c b/drivers/cpu/cpu-uclass.c
index 2c8e46c05e39259e2d0a3e018f2ca26e3f8e1479..b73768de918647f7aa2749ea6b0def0af5d69bdc 100644
--- a/drivers/cpu/cpu-uclass.c
+++ b/drivers/cpu/cpu-uclass.c
@@ -15,8 +15,6 @@
 #include <linux/err.h>
 #include <relocate.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 int cpu_probe_all(void)
 {
 	int ret = uclass_probe_all(UCLASS_CPU);
diff --git a/drivers/cpu/imx8_cpu.c b/drivers/cpu/imx8_cpu.c
index 5f17122c36c5c87a27f24c66da1858fd6422a1a8..3cd00199548e0a772a8ffe636c1d16f2f4fd7148 100644
--- a/drivers/cpu/imx8_cpu.c
+++ b/drivers/cpu/imx8_cpu.c
@@ -6,7 +6,6 @@
 #include <cpu.h>
 #include <dm.h>
 #include <thermal.h>
-#include <asm/global_data.h>
 #include <asm/ptrace.h>
 #include <asm/system.h>
 #include <firmware/imx/sci/sci.h>
@@ -18,8 +17,6 @@
 #include <linux/clk-provider.h>
 #include <linux/psci.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define IMX_REV_LEN	4
 struct cpu_imx_plat {
 	const char *name;
diff --git a/drivers/cpu/mtk_cpu.c b/drivers/cpu/mtk_cpu.c
index 2a08be9b6d181c64e147bfd32f919e0a63289e98..4f4e5480eac56f53a0d80efa0e0b106d9b224da4 100644
--- a/drivers/cpu/mtk_cpu.c
+++ b/drivers/cpu/mtk_cpu.c
@@ -10,12 +10,9 @@
 #include <dm.h>
 #include <regmap.h>
 #include <syscon.h>
-#include <asm/global_data.h>
 #include <linux/err.h>
 #include <linux/io.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 struct mtk_cpu_plat {
 	struct regmap *hwver;
 };
diff --git a/drivers/firmware/arm-ffa/arm-ffa-uclass.c b/drivers/firmware/arm-ffa/arm-ffa-uclass.c
index 96c64964bb73b05e094f7ab71a5e68c3195f3edf..76a8775e911c8497fd43ca76dbbfcb0dfc865d42 100644
--- a/drivers/firmware/arm-ffa/arm-ffa-uclass.c
+++ b/drivers/firmware/arm-ffa/arm-ffa-uclass.c
@@ -12,15 +12,12 @@
 #include <malloc.h>
 #include <string.h>
 #include <u-boot/uuid.h>
-#include <asm/global_data.h>
 #include <dm/device-internal.h>
 #include <dm/devres.h>
 #include <dm/root.h>
 #include <linux/errno.h>
 #include <linux/sizes.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 /* Error mapping declarations */
 
 int ffa_to_std_errmap[MAX_NUMBER_FFA_ERR] = {
diff --git a/drivers/firmware/arm-ffa/arm-ffa.c b/drivers/firmware/arm-ffa/arm-ffa.c
index 94e6105cb38ebcadff3d248870a5a0bce5cb9384..9e6b5dcc542fd54abe58180887d7888a1c429f4a 100644
--- a/drivers/firmware/arm-ffa/arm-ffa.c
+++ b/drivers/firmware/arm-ffa/arm-ffa.c
@@ -10,12 +10,9 @@
 #include <arm_ffa_priv.h>
 #include <dm.h>
 #include <log.h>
-#include <asm/global_data.h>
 #include <dm/device-internal.h>
 #include <linux/errno.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 /**
  * invoke_ffa_fn() - SMC wrapper
  * @args: FF-A ABI arguments to be copied to Xn registers
diff --git a/drivers/firmware/arm-ffa/ffa-emul-uclass.c b/drivers/firmware/arm-ffa/ffa-emul-uclass.c
index 1521d9b66ac3e97cc25975c10b305105760e8d3e..6198d6873541c16d02c079a47579236cec68c5fa 100644
--- a/drivers/firmware/arm-ffa/ffa-emul-uclass.c
+++ b/drivers/firmware/arm-ffa/ffa-emul-uclass.c
@@ -8,7 +8,6 @@
 #include <dm.h>
 #include <mapmem.h>
 #include <string.h>
-#include <asm/global_data.h>
 #include <asm/sandbox_arm_ffa.h>
 #include <asm/sandbox_arm_ffa_priv.h>
 #include <dm/device-internal.h>
@@ -17,8 +16,6 @@
 #include <linux/errno.h>
 #include <linux/sizes.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 /* The partitions (SPs) table */
 static struct ffa_partition_desc sandbox_partitions[SANDBOX_PARTITIONS_CNT] = {
 	{
diff --git a/drivers/firmware/arm-ffa/sandbox_ffa.c b/drivers/firmware/arm-ffa/sandbox_ffa.c
index 44b32a829ddfe9a94084c05b0135a1ffe8a343e8..f1e8de4bf0df04c2e76e03fba13339e152fd4975 100644
--- a/drivers/firmware/arm-ffa/sandbox_ffa.c
+++ b/drivers/firmware/arm-ffa/sandbox_ffa.c
@@ -8,13 +8,10 @@
 #include <arm_ffa.h>
 #include <dm.h>
 #include <log.h>
-#include <asm/global_data.h>
 #include <asm/sandbox_arm_ffa_priv.h>
 #include <dm/device-internal.h>
 #include <linux/errno.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 /**
  * sandbox_ffa_discover() - perform sandbox FF-A discovery
  * @dev: The sandbox FF-A bus device
diff --git a/drivers/gpio/gpio-uclass.c b/drivers/gpio/gpio-uclass.c
index 38151ef1bee7d5ef0c4b26fcafb98a7260611abb..7651d5360d688ec1a7962ca651120ca299ce3478 100644
--- a/drivers/gpio/gpio-uclass.c
+++ b/drivers/gpio/gpio-uclass.c
@@ -18,15 +18,12 @@
 #include <fdtdec.h>
 #include <malloc.h>
 #include <acpi/acpi_device.h>
-#include <asm/global_data.h>
 #include <asm/gpio.h>
 #include <dm/device_compat.h>
 #include <linux/bug.h>
 #include <linux/ctype.h>
 #include <linux/delay.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define GPIO_ALLOC_BITS	32
 
 /**
diff --git a/drivers/gpio/nx_gpio.c b/drivers/gpio/nx_gpio.c
index 741b2ff7f177919efd1ce34ea13c2993aa2890d2..5abbb34daea7e5db0c4aabe54a4e1b56c58087b9 100644
--- a/drivers/gpio/nx_gpio.c
+++ b/drivers/gpio/nx_gpio.c
@@ -7,12 +7,9 @@
 #include <dm.h>
 #include <errno.h>
 #include <malloc.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/gpio.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 struct nx_gpio_regs {
 	u32	data;		/* Data register */
 	u32	outputenb;	/* Output Enable register */
diff --git a/drivers/i2c/mxc_i2c.c b/drivers/i2c/mxc_i2c.c
index 2dfc1c4eab5d83e617407f49a8c783ef61778b3a..268bb39f009fbd2dc06159807cc8e9dac531ea4c 100644
--- a/drivers/i2c/mxc_i2c.c
+++ b/drivers/i2c/mxc_i2c.c
@@ -18,7 +18,6 @@
 #include <log.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/imx-regs.h>
-#include <asm/global_data.h>
 #include <dm/device_compat.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
@@ -30,8 +29,6 @@
 #include <dm.h>
 #include <dm/pinctrl.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define I2C_QUIRK_FLAG		(1 << 0)
 
 #define IMX_I2C_REGSHIFT	2
diff --git a/drivers/i2c/nx_i2c.c b/drivers/i2c/nx_i2c.c
index 8562dd82bd630f7872f5f3f22f34f1f65e567ded..706b7adefe8ac1b28e2afb6f8fe1c1a9b2276c94 100644
--- a/drivers/i2c/nx_i2c.c
+++ b/drivers/i2c/nx_i2c.c
@@ -7,7 +7,6 @@
 #include <asm/arch/reset.h>
 #include <asm/arch/clk.h>
 #include <asm/arch/nx_gpio.h>
-#include <asm/global_data.h>
 #include <linux/delay.h>
 
 #define I2C_WRITE       0
@@ -45,8 +44,6 @@
 
 #define DEFAULT_SPEED   100000  /* default I2C speed [Hz] */
 
-DECLARE_GLOBAL_DATA_PTR;
-
 struct nx_i2c_regs {
 	uint     iiccon;
 	uint     iicstat;
diff --git a/drivers/i2c/ocores_i2c.c b/drivers/i2c/ocores_i2c.c
index cf714d22ee4634a4b19c905cec9443f2da6c8a38..32704ee885454d695dcb6ede129fd8934c1d19b9 100644
--- a/drivers/i2c/ocores_i2c.c
+++ b/drivers/i2c/ocores_i2c.c
@@ -12,7 +12,6 @@
  * Andreas Larsson <andreas@gaisler.com>
  */
 
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <clk.h>
 #include <dm.h>
@@ -75,8 +74,6 @@ struct ocores_i2c_bus {
 	u8 (*getreg)(struct ocores_i2c_bus *i2c, int reg);
 };
 
-DECLARE_GLOBAL_DATA_PTR;
-
 /* Boolean attribute values */
 enum {
 	FALSE = 0,
diff --git a/drivers/i2c/soft_i2c.c b/drivers/i2c/soft_i2c.c
index 79f7a3205022afebfe736c1995af4386371d99a4..4102375e5b7390b5cfc96d46d3920880f6c0f797 100644
--- a/drivers/i2c/soft_i2c.c
+++ b/drivers/i2c/soft_i2c.c
@@ -25,7 +25,6 @@
 #endif
 #endif
 #include <i2c.h>
-#include <asm/global_data.h>
 #include <linux/delay.h>
 
 #if defined(CONFIG_SOFT_I2C_GPIO_SCL)
@@ -82,8 +81,6 @@
 
 /* #define	DEBUG_I2C	*/
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #ifndef	I2C_SOFT_DECLARATIONS
 #  define I2C_SOFT_DECLARATIONS
 #endif
diff --git a/drivers/i2c/synquacer_i2c.c b/drivers/i2c/synquacer_i2c.c
index 6672d9435e330cbf32b23677f94815185be6b92d..6e5722327c5f749ad2203629e2e362977db61414 100644
--- a/drivers/i2c/synquacer_i2c.c
+++ b/drivers/i2c/synquacer_i2c.c
@@ -112,8 +112,6 @@
 #define SPEED_FM		400	// Fast Mode
 #define SPEED_SM		100	// Standard Mode
 
-DECLARE_GLOBAL_DATA_PTR;
-
 struct synquacer_i2c {
 	void __iomem *base;
 	unsigned long pclkrate;
diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index b1e0465e7a8bfa204664e487825f4221784a760c..c7eaa3de96f4a4b96b11fd331323e4f2c2a45e27 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -15,8 +15,6 @@
 /* This driver only exposes the status bits to keep with the
  * polling methodology of u-boot.
  */
-DECLARE_GLOBAL_DATA_PTR;
-
 #define IMX_MU_CHANS		24
 
 #define IMX_MU_V2_PAR_OFF	0x4
diff --git a/drivers/misc/atsha204a-i2c.c b/drivers/misc/atsha204a-i2c.c
index 3b9046da880c106859978d36a5a10a1e6ce2259b..aa3094fcc016a53eaf7c54b87c61fb1e7d7c12aa 100644
--- a/drivers/misc/atsha204a-i2c.c
+++ b/drivers/misc/atsha204a-i2c.c
@@ -15,7 +15,6 @@
 #include <errno.h>
 #include <atsha204a-i2c.h>
 #include <log.h>
-#include <asm/global_data.h>
 #include <linux/delay.h>
 #include <linux/bitrev.h>
 #include <u-boot/crc.h>
@@ -25,8 +24,6 @@
 #define ATSHA204A_TRANSACTION_RETRY	5
 #define ATSHA204A_EXECTIME		5000
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static inline u16 atsha204a_crc16(const u8 *buffer, size_t len)
 {
 	return bitrev16(crc16(0, buffer, len));
diff --git a/drivers/misc/fs_loader.c b/drivers/misc/fs_loader.c
index 2928cf75f89e7b7829a2dd0595499900850334cc..6af4c7f15e7b910b03922131ddb0db0d21be6590 100644
--- a/drivers/misc/fs_loader.c
+++ b/drivers/misc/fs_loader.c
@@ -13,7 +13,6 @@
 #include <fs.h>
 #include <fs_loader.h>
 #include <log.h>
-#include <asm/global_data.h>
 #include <dm/device-internal.h>
 #include <dm/root.h>
 #include <linux/string.h>
@@ -25,8 +24,6 @@
 #include <ubi_uboot.h>
 #endif
 
-DECLARE_GLOBAL_DATA_PTR;
-
 /**
  * struct firmware - A place for storing firmware and its attribute data.
  *
diff --git a/drivers/misc/imx8/fuse.c b/drivers/misc/imx8/fuse.c
index 90d251a440589ca07e545ae1303121a74f888188..872713e30b6c15fee6f79f9e4b86a4ee81237bd5 100644
--- a/drivers/misc/imx8/fuse.c
+++ b/drivers/misc/imx8/fuse.c
@@ -8,11 +8,8 @@
 #include <fuse.h>
 #include <firmware/imx/sci/sci.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
 #include <linux/arm-smccc.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define FSL_ECC_WORD_START_1	 0x10
 #define FSL_ECC_WORD_END_1	 0x10F
 
diff --git a/drivers/mmc/ca_dw_mmc.c b/drivers/mmc/ca_dw_mmc.c
index 1af5ec0532ea0933981e2663d97e6474eadccbba..d5a4453a62e0a79b1bf0964359defbaf4c19f546 100644
--- a/drivers/mmc/ca_dw_mmc.c
+++ b/drivers/mmc/ca_dw_mmc.c
@@ -6,7 +6,6 @@
 
 #include <dwmmc.h>
 #include <fdtdec.h>
-#include <asm/global_data.h>
 #include <linux/libfdt.h>
 #include <malloc.h>
 #include <errno.h>
@@ -26,8 +25,6 @@
 
 #define MIN_FREQ (400000)
 
-DECLARE_GLOBAL_DATA_PTR;
-
 struct ca_mmc_plat {
 	struct mmc_config cfg;
 	struct mmc mmc;
diff --git a/drivers/mmc/f_sdh30.c b/drivers/mmc/f_sdh30.c
index f47cf8485216e60bb5d9ff2b2becca0749116c94..f0356e1e9609bb5fcfcf3cf9e0c4974988fde260 100644
--- a/drivers/mmc/f_sdh30.c
+++ b/drivers/mmc/f_sdh30.c
@@ -29,8 +29,6 @@ struct f_sdh30_plat {
 	const struct f_sdh30_data *data;
 };
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static void f_sdh30_e51_init(struct udevice *dev)
 {
 	struct f_sdh30_plat *plat = dev_get_plat(dev);
diff --git a/drivers/mmc/jz_mmc.c b/drivers/mmc/jz_mmc.c
index fc10bb256a4df53107d54fe89f060e8f37dd72f1..651d98683055329f17428a7b3d4ae685982a2861 100644
--- a/drivers/mmc/jz_mmc.c
+++ b/drivers/mmc/jz_mmc.c
@@ -8,7 +8,6 @@
 
 #include <malloc.h>
 #include <mmc.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/unaligned.h>
 #include <errno.h>
@@ -419,8 +418,6 @@ int jz_mmc_init(void __iomem *base)
 #else /* CONFIG_DM_MMC */
 
 #include <dm.h>
-DECLARE_GLOBAL_DATA_PTR;
-
 static int jz_mmc_dm_send_cmd(struct udevice *dev, struct mmc_cmd *cmd,
 			      struct mmc_data *data)
 {
diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
index 38dc36a21940efc070028deade3e3eebaf862222..66f3cf2de4f0d71aa34df03447ee37e1ced043d3 100644
--- a/drivers/mmc/msm_sdhci.c
+++ b/drivers/mmc/msm_sdhci.c
@@ -13,7 +13,6 @@
 #include <reset.h>
 #include <sdhci.h>
 #include <wait_bit.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
 #include <power/regulator.h>
@@ -61,8 +60,6 @@ struct msm_sdhc_variant_info {
 	u32 core_vendor_spec_capabilities0;
 };
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static int msm_sdc_clk_init(struct udevice *dev)
 {
 	struct msm_sdhc *prv = dev_get_priv(dev);
diff --git a/drivers/mmc/mv_sdhci.c b/drivers/mmc/mv_sdhci.c
index 2da5334c21f13c1ad93b4154c6dd4c637868cbf0..a8b63a203870caffcd60a42f411c511f6690841e 100644
--- a/drivers/mmc/mv_sdhci.c
+++ b/drivers/mmc/mv_sdhci.c
@@ -6,7 +6,6 @@
 #include <dm.h>
 #include <malloc.h>
 #include <sdhci.h>
-#include <asm/global_data.h>
 #include <linux/mbus.h>
 
 #define MVSDH_NAME "mv_sdh"
@@ -14,8 +13,6 @@
 #define SDHCI_WINDOW_CTRL(win)		(0x4080 + ((win) << 4))
 #define SDHCI_WINDOW_BASE(win)		(0x4084 + ((win) << 4))
 
-DECLARE_GLOBAL_DATA_PTR;
-
 struct mv_sdhci_plat {
 	struct mmc_config cfg;
 	struct mmc mmc;
diff --git a/drivers/mtd/nand/raw/pxa3xx_nand.c b/drivers/mtd/nand/raw/pxa3xx_nand.c
index 7bf54fa46540b95df9c53843046d9fbc7bb8b2b2..7324dc72e0a61023c30068ab5a5c0ce1c2fd4a30 100644
--- a/drivers/mtd/nand/raw/pxa3xx_nand.c
+++ b/drivers/mtd/nand/raw/pxa3xx_nand.c
@@ -9,7 +9,6 @@
 #include <malloc.h>
 #include <fdtdec.h>
 #include <nand.h>
-#include <asm/global_data.h>
 #include <dm/device_compat.h>
 #include <dm/devres.h>
 #include <linux/bitops.h>
@@ -30,8 +29,6 @@
 
 #include "pxa3xx_nand.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define TIMEOUT_DRAIN_FIFO	5	/* in ms */
 #define	CHIP_DELAY_TIMEOUT	200
 #define NAND_STOP_DELAY		40
diff --git a/drivers/mtd/nand/raw/tegra_nand.c b/drivers/mtd/nand/raw/tegra_nand.c
index ef43dcad079b23db418ee305ad90aecc1be89881..0bee7eace908806da450fcf9c8d88419036f0be4 100644
--- a/drivers/mtd/nand/raw/tegra_nand.c
+++ b/drivers/mtd/nand/raw/tegra_nand.c
@@ -7,7 +7,6 @@
  */
 
 #include <log.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <memalign.h>
 #include <nand.h>
@@ -26,8 +25,6 @@
 #include <linux/printk.h>
 #include "tegra_nand.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define NAND_CMD_TIMEOUT_MS		10
 
 #define SKIPPED_SPARE_BYTES		4
diff --git a/drivers/mtd/nvmxip/nvmxip_qspi.c b/drivers/mtd/nvmxip/nvmxip_qspi.c
index 1a109bee557a58d65b08a7bf108442029c0ffd42..383971bea6659072982e28bea108a95402e4952a 100644
--- a/drivers/mtd/nvmxip/nvmxip_qspi.c
+++ b/drivers/mtd/nvmxip/nvmxip_qspi.c
@@ -11,9 +11,6 @@
 #include <nvmxip.h>
 #include <linux/errno.h>
 
-#include <asm/global_data.h>
-DECLARE_GLOBAL_DATA_PTR;
-
 #define NVMXIP_QSPI_DRV_NAME "nvmxip_qspi"
 
 /**
diff --git a/drivers/mtd/spi/sf-uclass.c b/drivers/mtd/spi/sf-uclass.c
index 102a92368267b28a6602aa7edb025794ed212aad..a9db5296b2da1a32bc3eda58692841dddbab603a 100644
--- a/drivers/mtd/spi/sf-uclass.c
+++ b/drivers/mtd/spi/sf-uclass.c
@@ -11,13 +11,10 @@
 #include <malloc.h>
 #include <spi.h>
 #include <spi_flash.h>
-#include <asm/global_data.h>
 #include <dm/device-internal.h>
 #include <test/test.h>
 #include "sf_internal.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 int spi_flash_read_dm(struct udevice *dev, u32 offset, size_t len, void *buf)
 {
 	return log_ret(sf_get_ops(dev)->read(dev, offset, len, buf));
diff --git a/drivers/net/dwmac_s700.c b/drivers/net/dwmac_s700.c
index 969d247b4f3ae2e8b3e683f281208db44aee259f..76daab961c017da86cf50635c5f9cc163e5b54a3 100644
--- a/drivers/net/dwmac_s700.c
+++ b/drivers/net/dwmac_s700.c
@@ -5,7 +5,6 @@
  * Actions DWMAC specific glue layer
  */
 
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <dm.h>
 #include <clk.h>
@@ -24,8 +23,6 @@
 #define RMII_REF_CLK_MFP_CTL0		(0x0 << 6)
 #define CLKO_25M_EN_MFP_CTL3		BIT(30)
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static void dwmac_board_setup(void)
 {
 	clrbits_le32(MFP_CTL0, (RMII_TXD01_MFP_CTL0 | RMII_RXD01_MFP_CTL0 |
diff --git a/drivers/net/fec_mxc.c b/drivers/net/fec_mxc.c
index 1c51e936b5be96f8ef4a9d76c39d797287edf384..3d32bad083183ea467ad73d69d7c3c6da64b7215 100644
--- a/drivers/net/fec_mxc.c
+++ b/drivers/net/fec_mxc.c
@@ -18,7 +18,6 @@
 #include <net.h>
 #include <netdev.h>
 #include <asm/cache.h>
-#include <asm/global_data.h>
 #include <linux/delay.h>
 #include <power/regulator.h>
 
@@ -36,8 +35,6 @@
 #include "fec_mxc.h"
 #include <eth_phy.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 /*
  * Timeout the transfer after 5 mS. This is usually a bit more, since
  * the code in the tightloops this timeout is used in adds some overhead.
diff --git a/drivers/net/gmac_rockchip.c b/drivers/net/gmac_rockchip.c
index c8cfe7448d4daa7e793b3fba8380de6545dd55d0..2b6080dd9ee014ee432ff6596d5a82fbd96a72a0 100644
--- a/drivers/net/gmac_rockchip.c
+++ b/drivers/net/gmac_rockchip.c
@@ -11,7 +11,6 @@
 #include <net.h>
 #include <phy.h>
 #include <syscon.h>
-#include <asm/global_data.h>
 #include <asm/arch-rockchip/periph.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/hardware.h>
@@ -28,7 +27,6 @@
 #include <linux/bitops.h>
 #include "designware.h"
 
-DECLARE_GLOBAL_DATA_PTR;
 #define DELAY_ENABLE(soc, tx, rx) \
 	(((tx) ? soc##_TXCLK_DLY_ENA_GMAC_ENABLE : soc##_TXCLK_DLY_ENA_GMAC_DISABLE) | \
 	((rx) ? soc##_RXCLK_DLY_ENA_GMAC_ENABLE : soc##_RXCLK_DLY_ENA_GMAC_DISABLE))
diff --git a/drivers/net/mvneta.c b/drivers/net/mvneta.c
index 1640868c24af0628306ed570d4d8f413fdb064ba..baa18202d6e23097de6e08394fb586929637b800 100644
--- a/drivers/net/mvneta.c
+++ b/drivers/net/mvneta.c
@@ -20,7 +20,6 @@
 #include <config.h>
 #include <malloc.h>
 #include <asm/cache.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <dm/device_compat.h>
 #include <dm/devres.h>
@@ -37,8 +36,6 @@
 #include <linux/mbus.h>
 #include <asm-generic/gpio.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define MVNETA_NR_CPUS		1
 #define ETH_HLEN		14	/* Total octets in header */
 
diff --git a/drivers/net/octeontx/smi.c b/drivers/net/octeontx/smi.c
index 217bcac2ce290cf4ec72a3ace1dda77b22fefcf4..5a822b64427be716bcb23e2fa08a99784015622f 100644
--- a/drivers/net/octeontx/smi.c
+++ b/drivers/net/octeontx/smi.c
@@ -10,15 +10,12 @@
 #include <pci.h>
 #include <pci_ids.h>
 #include <phy.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/ctype.h>
 #include <linux/delay.h>
 
 #define PCI_DEVICE_ID_OCTEONTX_SMI 0xA02B
 
-DECLARE_GLOBAL_DATA_PTR;
-
 enum octeontx_smi_mode {
 	CLAUSE22 = 0,
 	CLAUSE45 = 1,
diff --git a/drivers/net/phy/fixed.c b/drivers/net/phy/fixed.c
index 11d3616497697b7003bba4b2e3006d6d1b6d6d15..4ab709a14d5f4d1f59bd600edd5a20f0f9032690 100644
--- a/drivers/net/phy/fixed.c
+++ b/drivers/net/phy/fixed.c
@@ -10,9 +10,6 @@
 #include <phy.h>
 #include <dm.h>
 #include <fdt_support.h>
-#include <asm/global_data.h>
-
-DECLARE_GLOBAL_DATA_PTR;
 
 static int fixedphy_probe(struct phy_device *phydev)
 {
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index b58283fe3d5f2f8c6dd22283677d68e2fa5cb1e5..d7e0c4fe02dd8b45d7a99bc7bf3eba7a64ca8c49 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -17,7 +17,6 @@
 #include <miiphy.h>
 #include <phy.h>
 #include <errno.h>
-#include <asm/global_data.h>
 #include <asm-generic/gpio.h>
 #include <dm/device_compat.h>
 #include <dm/of_extra.h>
@@ -26,8 +25,6 @@
 #include <linux/err.h>
 #include <linux/compiler.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 /* Generic PHY support and helper functions */
 
 /**
diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c b/drivers/net/phy/xilinx_gmii2rgmii.c
index e44b7b75bd585c13364dd2f6f6495dc941b855e7..f5a7dd349c91dc5fa858cd913a57ddd3c249d719 100644
--- a/drivers/net/phy/xilinx_gmii2rgmii.c
+++ b/drivers/net/phy/xilinx_gmii2rgmii.c
@@ -8,9 +8,6 @@
 #include <dm.h>
 #include <log.h>
 #include <phy.h>
-#include <asm/global_data.h>
-
-DECLARE_GLOBAL_DATA_PTR;
 
 #define ZYNQ_GMII2RGMII_REG		0x10
 #define ZYNQ_GMII2RGMII_SPEED_MASK	(BMCR_SPEED1000 | BMCR_SPEED100)
diff --git a/drivers/net/sandbox-raw.c b/drivers/net/sandbox-raw.c
index 1d716716778cbf372e89fad71ec7b62ad5ebbbf2..c3d40f0b59ed7e2e9eb7bbbdda385a744e2d77c7 100644
--- a/drivers/net/sandbox-raw.c
+++ b/drivers/net/sandbox-raw.c
@@ -12,9 +12,6 @@
 #include <env.h>
 #include <malloc.h>
 #include <net.h>
-#include <asm/global_data.h>
-
-DECLARE_GLOBAL_DATA_PTR;
 
 static int reply_arp;
 static struct in_addr arp_ip;
diff --git a/drivers/net/sandbox.c b/drivers/net/sandbox.c
index 2011fd31f41aa8b5a7c2ba7f08fb56acf8fcee50..0ea50c484c05967aac335a9d321da68dd67328bf 100644
--- a/drivers/net/sandbox.c
+++ b/drivers/net/sandbox.c
@@ -10,7 +10,6 @@
 #include <log.h>
 #include <malloc.h>
 #include <asm/eth.h>
-#include <asm/global_data.h>
 #include <asm/test.h>
 #include <asm/types.h>
 
@@ -84,8 +83,6 @@ struct icmphdr {
 #define ICMP_ECHO_REPLY		0
 #define IPPROTO_ICMP		1
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static const u8 null_ethaddr[6];
 static bool skip_timeout;
 
diff --git a/drivers/net/ti/keystone_net.c b/drivers/net/ti/keystone_net.c
index d4abc9a041102c584bdcec57280112e9c4acf079..40c98e72e4d3e4a5d77afd73d177d82a24e89dc2 100644
--- a/drivers/net/ti/keystone_net.c
+++ b/drivers/net/ti/keystone_net.c
@@ -7,7 +7,6 @@
  */
 #include <command.h>
 #include <console.h>
-#include <asm/global_data.h>
 #include <linux/delay.h>
 #include <linux/printk.h>
 
@@ -26,8 +25,6 @@
 
 #include "cpsw_mdio.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #ifdef KEYSTONE2_EMAC_GIG_ENABLE
 #define emac_gigabit_enable(x)	keystone2_eth_gigabit_enable(x)
 #else
diff --git a/drivers/net/xilinx_axi_emac.c b/drivers/net/xilinx_axi_emac.c
index fb48feb4469a06356ddfd9da188fb639f538edfe..e9cc5db52d25c60739bbfc73335a556a3093953e 100644
--- a/drivers/net/xilinx_axi_emac.c
+++ b/drivers/net/xilinx_axi_emac.c
@@ -15,7 +15,6 @@
 #include <log.h>
 #include <net.h>
 #include <malloc.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <phy.h>
 #include <miiphy.h>
@@ -23,8 +22,6 @@
 #include <linux/delay.h>
 #include <eth_phy.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 /* Link setup */
 #define XAE_EMMC_LINKSPEED_MASK	0xC0000000 /* Link speed */
 #define XAE_EMMC_LINKSPD_10	0x00000000 /* Link Speed mask for 10 Mbit */
diff --git a/drivers/pci/pci_octeontx.c b/drivers/pci/pci_octeontx.c
index 875cf7f7115d5a1a3ae5cd1a292e7fff518091bb..6752112a878284746384d1c82b846ec1a29101f5 100644
--- a/drivers/pci/pci_octeontx.c
+++ b/drivers/pci/pci_octeontx.c
@@ -11,14 +11,11 @@
 #include <log.h>
 #include <malloc.h>
 #include <pci.h>
-#include <asm/global_data.h>
 
 #include <asm/io.h>
 
 #include <linux/ioport.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 /*
  * This driver supports multiple types of operations / host bridges / busses:
  *
diff --git a/drivers/pci/pcie_dw_meson.c b/drivers/pci/pcie_dw_meson.c
index 483b07ce078d751f6d33e22e4a633c915e4cf929..1eff6d1b0edcef3da058a97dfa9248b97114ae3a 100644
--- a/drivers/pci/pcie_dw_meson.c
+++ b/drivers/pci/pcie_dw_meson.c
@@ -16,7 +16,6 @@
 #include <power-domain.h>
 #include <reset.h>
 #include <syscon.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm-generic/gpio.h>
 #include <dm/device_compat.h>
@@ -27,8 +26,6 @@
 
 #include "pcie_dw_common.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 /**
  * struct meson_pcie - Amlogic Meson DW PCIe controller state
  *
diff --git a/drivers/pci/pcie_dw_qcom.c b/drivers/pci/pcie_dw_qcom.c
index 978754e847231f13f740f8e48f645dba44c0a7b0..10c45aaba2068c2666a6a13f8908170a15d2fa6d 100644
--- a/drivers/pci/pcie_dw_qcom.c
+++ b/drivers/pci/pcie_dw_qcom.c
@@ -10,7 +10,6 @@
 #include <syscon.h>
 #include <malloc.h>
 #include <power/regulator.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm-generic/gpio.h>
 #include <dm/device_compat.h>
@@ -21,8 +20,6 @@
 
 #include "pcie_dw_common.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 struct qcom_pcie;
 
 struct qcom_pcie_ops {
diff --git a/drivers/pci/pcie_dw_rockchip.c b/drivers/pci/pcie_dw_rockchip.c
index 208aa30463af6a73f1dffaa89bf1c28273d548eb..61117fa95e6fba20f36bf812fa8a5e6ca1e6ef5e 100644
--- a/drivers/pci/pcie_dw_rockchip.c
+++ b/drivers/pci/pcie_dw_rockchip.c
@@ -13,7 +13,6 @@
 #include <reset.h>
 #include <syscon.h>
 #include <asm/arch-rockchip/clock.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm-generic/gpio.h>
 #include <dm/device_compat.h>
@@ -24,8 +23,6 @@
 
 #include "pcie_dw_common.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 /**
  * struct rk_pcie - RK DW PCIe controller state
  *
diff --git a/drivers/pci/pcie_dw_ti.c b/drivers/pci/pcie_dw_ti.c
index dc6e65273b798c5be03f8b2878df8fcb8a8e38c1..37c295fdd385c95d9a0d3e553197d2ce5f2519bf 100644
--- a/drivers/pci/pcie_dw_ti.c
+++ b/drivers/pci/pcie_dw_ti.c
@@ -10,7 +10,6 @@
 #include <power-domain.h>
 #include <regmap.h>
 #include <syscon.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm-generic/gpio.h>
 #include <dm/device_compat.h>
@@ -20,8 +19,6 @@
 
 #include "pcie_dw_common.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define PCIE_VENDORID_MASK	GENMASK(15, 0)
 #define PCIE_DEVICEID_SHIFT	16
 
diff --git a/drivers/pci/pcie_layerscape.c b/drivers/pci/pcie_layerscape.c
index 1be33095b9cee07e563f841ecafa8c1b5ef0bfe5..db7c4f47916a41acced471d731b551d8fa895f5b 100644
--- a/drivers/pci/pcie_layerscape.c
+++ b/drivers/pci/pcie_layerscape.c
@@ -6,7 +6,6 @@
  */
 
 #include <log.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <errno.h>
 #include <malloc.h>
@@ -16,8 +15,6 @@
 #endif
 #include "pcie_layerscape.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 LIST_HEAD(ls_pcie_list);
 
 unsigned int dbi_readl(struct ls_pcie *pcie, unsigned int offset)
diff --git a/drivers/pci/pcie_starfive_jh7110.c b/drivers/pci/pcie_starfive_jh7110.c
index 0908ae16b67335e2c81762f48219a43941713ec5..761e64be58a590c4ec6433c1b44db19ae7fa7bd3 100644
--- a/drivers/pci/pcie_starfive_jh7110.c
+++ b/drivers/pci/pcie_starfive_jh7110.c
@@ -15,7 +15,6 @@
 #include <regmap.h>
 #include <reset.h>
 #include <syscon.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm-generic/gpio.h>
 #include <dm/device_compat.h>
@@ -39,8 +38,6 @@
 #define STG_SYSCON_RP_NEP_OFFSET               0xe8
 #define STG_SYSCON_K_RP_NEP_MASK               BIT(8)
 
-DECLARE_GLOBAL_DATA_PTR;
-
 struct starfive_pcie {
 	struct pcie_plda plda;
 	struct clk_bulk	clks;
diff --git a/drivers/pci_endpoint/pci_ep-uclass.c b/drivers/pci_endpoint/pci_ep-uclass.c
index 902d1a51eaa3e819883e0c63f001cfb5a1399a56..b71defe4019f6c234f37070aeb7af5e1b5ffec8d 100644
--- a/drivers/pci_endpoint/pci_ep-uclass.c
+++ b/drivers/pci_endpoint/pci_ep-uclass.c
@@ -13,12 +13,9 @@
 
 #include <dm.h>
 #include <errno.h>
-#include <asm/global_data.h>
 #include <linux/log2.h>
 #include <pci_ep.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 int pci_ep_write_header(struct udevice *dev, uint fn, struct pci_ep_header *hdr)
 {
 	struct pci_ep_ops *ops = pci_ep_get_ops(dev);
diff --git a/drivers/phy/marvell/comphy_core.c b/drivers/phy/marvell/comphy_core.c
index a4121423873ba457fde69744af20e951329c16f9..b074d58f9f6a4017b5e7ce4b692ac73342f2cad6 100644
--- a/drivers/phy/marvell/comphy_core.c
+++ b/drivers/phy/marvell/comphy_core.c
@@ -7,7 +7,6 @@
 
 #include <dm.h>
 #include <fdtdec.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <dm/device_compat.h>
 #include <linux/err.h>
@@ -18,8 +17,6 @@
 
 #define COMPHY_MAX_CHIP 4
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static const char *get_speed_string(u32 speed)
 {
 	static const char * const speed_strings[] = {
diff --git a/drivers/phy/omap-usb2-phy.c b/drivers/phy/omap-usb2-phy.c
index 2be0178882a417e7ce1587849179952e41323fd8..6df4ff4eb056b06a4bfbdd135cbdf231eb29b4ec 100644
--- a/drivers/phy/omap-usb2-phy.c
+++ b/drivers/phy/omap-usb2-phy.c
@@ -6,7 +6,6 @@
  * Written by Jean-Jacques Hiblot <jjhiblot@ti.com>
  */
 
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <dm.h>
 #include <errno.h>
@@ -39,8 +38,6 @@
 #define USB2PHY_USE_CHG_DET_REG		BIT(29)
 #define USB2PHY_DIS_CHG_DET		BIT(28)
 
-DECLARE_GLOBAL_DATA_PTR;
-
 struct omap_usb2_phy {
 	struct regmap *pwr_regmap;
 	ulong flags;
diff --git a/drivers/phy/rockchip/phy-rockchip-pcie.c b/drivers/phy/rockchip/phy-rockchip-pcie.c
index 660037034ec0368f991ab01e8015fb812eb696f6..5775101c4cb56fa57a331089d593b23b948af6ae 100644
--- a/drivers/phy/rockchip/phy-rockchip-pcie.c
+++ b/drivers/phy/rockchip/phy-rockchip-pcie.c
@@ -9,7 +9,6 @@
 
 #include <clk.h>
 #include <dm.h>
-#include <asm/global_data.h>
 #include <dm/device_compat.h>
 #include <generic-phy.h>
 #include <reset.h>
@@ -19,8 +18,6 @@
 #include <linux/iopoll.h>
 #include <asm/arch-rockchip/clock.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 /*
  * The higher 16-bit of this register is used for write protection
  * only if BIT(x + 16) set to 1 the BIT(x) can be written.
diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rockchip/phy-rockchip-typec.c
index 66d1d32d25cbb74df1df26ea6ce3fb9638e13910..305d5b0dd48ddc05a8fde6090296b62b05bf74b3 100644
--- a/drivers/phy/rockchip/phy-rockchip-typec.c
+++ b/drivers/phy/rockchip/phy-rockchip-typec.c
@@ -10,7 +10,6 @@
 
 #include <clk.h>
 #include <dm.h>
-#include <asm/global_data.h>
 #include <dm/device_compat.h>
 #include <dm/lists.h>
 #include <generic-phy.h>
@@ -21,8 +20,6 @@
 #include <linux/iopoll.h>
 #include <asm/arch-rockchip/clock.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define usleep_range(a, b) udelay((b))
 
 #define CMN_SSM_BANDGAP			(0x21 << 2)
diff --git a/drivers/pinctrl/mtmips/pinctrl-mt7628.c b/drivers/pinctrl/mtmips/pinctrl-mt7628.c
index dc7acec4a77f6a767f339b4672e49ecb44de0ef1..be3a28eb94d0fc9e0d7fc98e50673dad937d2935 100644
--- a/drivers/pinctrl/mtmips/pinctrl-mt7628.c
+++ b/drivers/pinctrl/mtmips/pinctrl-mt7628.c
@@ -6,15 +6,12 @@
  */
 
 #include <dm.h>
-#include <asm/global_data.h>
 #include <dm/pinctrl.h>
 #include <linux/bitops.h>
 #include <linux/io.h>
 
 #include "pinctrl-mtmips-common.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define AGPIO_OFS			0
 #define GPIOMODE1_OFS			0x24
 #define GPIOMODE2_OFS			0x28
diff --git a/drivers/pinctrl/nexell/pinctrl-nexell.c b/drivers/pinctrl/nexell/pinctrl-nexell.c
index d5be7baf50ddc06b5817870d593699af238fd19e..af1acd91649fbe886be059ba8a2371d65900a83b 100644
--- a/drivers/pinctrl/nexell/pinctrl-nexell.c
+++ b/drivers/pinctrl/nexell/pinctrl-nexell.c
@@ -7,13 +7,10 @@
 
 #include <dm.h>
 #include <errno.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include "pinctrl-nexell.h"
 #include "pinctrl-s5pxx18.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 /* given a pin-name, return the address of pin config registers */
 unsigned long pin_to_bank_base(struct udevice *dev, const char *pin_name,
 			       u32 *pin)
diff --git a/drivers/pinctrl/nexell/pinctrl-s5pxx18.c b/drivers/pinctrl/nexell/pinctrl-s5pxx18.c
index a6ae5764fbc1c31e258622ef15ed08aeefeaf90f..aeed3f1e1e1e2d21274b6f985ad3feacf580d66d 100644
--- a/drivers/pinctrl/nexell/pinctrl-s5pxx18.c
+++ b/drivers/pinctrl/nexell/pinctrl-s5pxx18.c
@@ -9,15 +9,12 @@
 
 #include <dm.h>
 #include <errno.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <dm/pinctrl.h>
 #include <dm/root.h>
 #include "pinctrl-nexell.h"
 #include "pinctrl-s5pxx18.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static void nx_gpio_set_bit(u32 *value, u32 bit, int enable)
 {
 	register u32 newvalue;
diff --git a/drivers/pinctrl/nxp/pinctrl-imx-mmio.c b/drivers/pinctrl/nxp/pinctrl-imx-mmio.c
index 2f4228a9fc5f960da4b461d01ac49ddbeec0b92d..7cdbbbba747ba29c41897fa1cf9e27450be11ce1 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx-mmio.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx-mmio.c
@@ -5,7 +5,6 @@
 
 #include <malloc.h>
 #include <mapmem.h>
-#include <asm/global_data.h>
 #include <dm/device_compat.h>
 #include <dm/devres.h>
 #include <linux/bitops.h>
@@ -16,8 +15,6 @@
 
 #include "pinctrl-imx.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 int imx_pinctrl_set_state_mmio(struct udevice *dev, struct udevice *config)
 {
 	struct imx_pinctrl_priv *priv = dev_get_priv(dev);
diff --git a/drivers/pinctrl/nxp/pinctrl-imx.c b/drivers/pinctrl/nxp/pinctrl-imx.c
index 7d91ccfb26f1c7764deb59aa75663b4e5ed56393..d801176858190f3d41b3fdd2c3dd4dfc388daaa0 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx.c
@@ -5,7 +5,6 @@
 
 #include <malloc.h>
 #include <mapmem.h>
-#include <asm/global_data.h>
 #include <dm/device_compat.h>
 #include <dm/devres.h>
 #include <linux/bitops.h>
@@ -16,8 +15,6 @@
 
 #include "pinctrl-imx.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 int imx_pinctrl_set_state_common(struct udevice *dev, struct udevice *config,
 				 int pin_size, u32 **pin_data, int *npins)
 {
diff --git a/drivers/pinctrl/nxp/pinctrl-imx8.c b/drivers/pinctrl/nxp/pinctrl-imx8.c
index 9b3b5aec07adce51e6220db6edb822f460fbc39c..23865ee6428c36952f21e8d8c4f26017797985d4 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx8.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx8.c
@@ -9,14 +9,11 @@
 #include <asm/io.h>
 #include <firmware/imx/sci/sci.h>
 #include <misc.h>
-#include <asm/global_data.h>
 #include <dm/device.h>
 #include <dm/pinctrl.h>
 
 #include "pinctrl-imx.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define PADRING_IFMUX_EN_SHIFT		31
 #define PADRING_IFMUX_EN_MASK		BIT(31)
 #define PADRING_GP_EN_SHIFT		30
diff --git a/drivers/pinctrl/nxp/pinctrl-mxs.c b/drivers/pinctrl/nxp/pinctrl-mxs.c
index 85ab5fdf6404c97364370f7d8b74dbe1e44be2eb..8b7647380143d7265330438c96920a2ad0d4d6c1 100644
--- a/drivers/pinctrl/nxp/pinctrl-mxs.c
+++ b/drivers/pinctrl/nxp/pinctrl-mxs.c
@@ -5,7 +5,6 @@
  */
 
 #include <log.h>
-#include <asm/global_data.h>
 #include <dm/device_compat.h>
 #include <dm/devres.h>
 #include <linux/io.h>
@@ -15,8 +14,6 @@
 #include <dm/read.h>
 #include "pinctrl-mxs.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 struct mxs_pinctrl_priv {
 	void __iomem *base;
 	const struct mxs_regs *regs;
diff --git a/drivers/power/domain/imx8m-power-domain.c b/drivers/power/domain/imx8m-power-domain.c
index a7e64971a2abc211e275094bacdc705a2be625e8..1c731b897cc4c99c30d8aeee95a597e93601c227 100644
--- a/drivers/power/domain/imx8m-power-domain.c
+++ b/drivers/power/domain/imx8m-power-domain.c
@@ -7,7 +7,6 @@
 #include <dm.h>
 #include <malloc.h>
 #include <power-domain-uclass.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/mach-imx/sys_proto.h>
 #include <dm/device-internal.h>
@@ -22,8 +21,6 @@
 #include <dt-bindings/power/imx8mp-power.h>
 #include <dt-bindings/power/imx8mq-power.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define GPC_PGC_CPU_MAPPING			0x0ec
 #define IMX8MP_GPC_PGC_CPU_MAPPING		0x1cc
 
diff --git a/drivers/power/pmic/bd71837.c b/drivers/power/pmic/bd71837.c
index a5df2570fc3e6a2dcaa4f1277c1a4fd341d66f63..136427947653b88d2e7d0961d78594c3b65f2246 100644
--- a/drivers/power/pmic/bd71837.c
+++ b/drivers/power/pmic/bd71837.c
@@ -7,14 +7,11 @@
 #include <dm.h>
 #include <i2c.h>
 #include <log.h>
-#include <asm/global_data.h>
 #include <linux/printk.h>
 #include <power/pmic.h>
 #include <power/regulator.h>
 #include <power/bd71837.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static const struct pmic_child_info pmic_children_info[] = {
 	/* buck */
 	{ .prefix = "b", .driver = BD718XX_REGULATOR_DRIVER},
diff --git a/drivers/power/pmic/mc34708.c b/drivers/power/pmic/mc34708.c
index 43badb5767a589c74e70529da159406905b6f66d..0ec52e25a9e8813e0cf5c9f3dbd39d75feaa3b8a 100644
--- a/drivers/power/pmic/mc34708.c
+++ b/drivers/power/pmic/mc34708.c
@@ -9,11 +9,8 @@
 #include <errno.h>
 #include <fsl_pmic.h>
 #include <i2c.h>
-#include <asm/global_data.h>
 #include <power/pmic.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static int mc34708_reg_count(struct udevice *dev)
 {
 	return PMIC_NUM_OF_REGS;
diff --git a/drivers/power/pmic/mp5416.c b/drivers/power/pmic/mp5416.c
index 9d44f0ae655e843682d1286c9a795f402519fbcf..899c2beeb37c87c34ed06bd9589f08d2cb604c29 100644
--- a/drivers/power/pmic/mp5416.c
+++ b/drivers/power/pmic/mp5416.c
@@ -9,9 +9,6 @@
 #include <power/pmic.h>
 #include <power/regulator.h>
 #include <power/mp5416.h>
-#include <asm/global_data.h>
-
-DECLARE_GLOBAL_DATA_PTR;
 
 static const struct pmic_child_info pmic_children_info[] = {
 	/* buck */
diff --git a/drivers/power/pmic/pca9450.c b/drivers/power/pmic/pca9450.c
index e5c1f037b613400e2b0f465983bbaa70471d97b1..c95e6357ee84b1039eef9bf00854d4b7954b62a9 100644
--- a/drivers/power/pmic/pca9450.c
+++ b/drivers/power/pmic/pca9450.c
@@ -10,7 +10,6 @@
 #include <dm/lists.h>
 #include <i2c.h>
 #include <log.h>
-#include <asm/global_data.h>
 #include <linux/delay.h>
 #include <linux/printk.h>
 #include <power/pmic.h>
@@ -18,8 +17,6 @@
 #include <power/pca9450.h>
 #include <sysreset.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static const struct pmic_child_info pmic_children_info[] = {
 	/* buck */
 	{ .prefix = "b", .driver = PCA9450_REGULATOR_DRIVER},
diff --git a/drivers/power/regulator/pwm_regulator.c b/drivers/power/regulator/pwm_regulator.c
index ff738faadc52d0e7847d3e3f8b6e9167b25d82a8..adde5156c7647064bd366bd4b75bf6d6378e9830 100644
--- a/drivers/power/regulator/pwm_regulator.c
+++ b/drivers/power/regulator/pwm_regulator.c
@@ -11,12 +11,9 @@
 #include <errno.h>
 #include <log.h>
 #include <pwm.h>
-#include <asm/global_data.h>
 #include <dm/device_compat.h>
 #include <power/regulator.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 struct pwm_regulator_info {
 	/* pwm id corresponding to the PWM driver */
 	int pwm_id;
diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index e9777c71f5e0b845bbaebdaf71185b5509059cf9..dea7bc574952c43055039d6a5aefdab54f17db2a 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -17,7 +17,6 @@
 #include <dm.h>
 #include <pwm.h>
 #include <regmap.h>
-#include <asm/global_data.h>
 #include <linux/io.h>
 #include <linux/log2.h>
 #include <linux/bitfield.h>
@@ -40,8 +39,6 @@
 #define PWM_SIFIVE_CHANNEL_ENABLE_VAL   0
 #define PWM_SIFIVE_CHANNEL_DISABLE_VAL  0xffff
 
-DECLARE_GLOBAL_DATA_PTR;
-
 struct pwm_sifive_regs {
 	unsigned long cfg;
 	unsigned long cnt;
diff --git a/drivers/pwm/rk_pwm.c b/drivers/pwm/rk_pwm.c
index 0a64eb01dc2bad5e1e7a9a4a65f929270564f764..b51dee31a9873b3d4769aca3034927d2f2d79162 100644
--- a/drivers/pwm/rk_pwm.c
+++ b/drivers/pwm/rk_pwm.c
@@ -11,14 +11,11 @@
 #include <pwm.h>
 #include <regmap.h>
 #include <syscon.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/arch-rockchip/pwm.h>
 #include <linux/bitops.h>
 #include <power/regulator.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 struct rockchip_pwm_data {
 	struct rockchip_pwm_regs regs;
 	unsigned int prescaler;
diff --git a/drivers/pwm/sunxi_pwm.c b/drivers/pwm/sunxi_pwm.c
index 2140a05b6796bbcf1c99b5a5024103aa1102a48c..1dd2428da771999445c123f4730f4142a41019cd 100644
--- a/drivers/pwm/sunxi_pwm.c
+++ b/drivers/pwm/sunxi_pwm.c
@@ -9,13 +9,10 @@
 #include <pwm.h>
 #include <regmap.h>
 #include <syscon.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/arch/pwm.h>
 #include <power/regulator.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define OSC_24MHZ 24000000
 
 struct sunxi_pwm_priv {
diff --git a/drivers/ram/stm32mp1/stm32mp1_tests.c b/drivers/ram/stm32mp1/stm32mp1_tests.c
index 6108faa70730cea425568a331503c38fe7baad40..3b41d6045ada32d471d8d5933961f7938ba8afd4 100644
--- a/drivers/ram/stm32mp1/stm32mp1_tests.c
+++ b/drivers/ram/stm32mp1/stm32mp1_tests.c
@@ -10,7 +10,6 @@
 #include <log.h>
 #include <rand.h>
 #include <watchdog.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/log2.h>
 #include "stm32mp1_tests.h"
@@ -19,8 +18,6 @@
 
 #define PATTERN_DEFAULT	"-"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static int get_bufsize(char *string, int argc, char *argv[], int arg_nb,
 		       size_t *bufsize, size_t default_size, size_t min_size)
 {
diff --git a/drivers/reboot-mode/reboot-mode-gpio.c b/drivers/reboot-mode/reboot-mode-gpio.c
index 22ee40c343338022a3c2921a779b32930748a653..8d3e53d50ee69a7bbad009c8f1cc590a4fc5872b 100644
--- a/drivers/reboot-mode/reboot-mode-gpio.c
+++ b/drivers/reboot-mode/reboot-mode-gpio.c
@@ -10,8 +10,6 @@
 #include <reboot-mode/reboot-mode-gpio.h>
 #include <reboot-mode/reboot-mode.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static int reboot_mode_get(struct udevice *dev, u32 *buf)
 {
 	int ret;
diff --git a/drivers/reboot-mode/reboot-mode-rtc.c b/drivers/reboot-mode/reboot-mode-rtc.c
index 4f4ad63febc106acd7f40de8757fe0db95bf6bee..adca584d622d8b65691fc12012548af4357a1ea8 100644
--- a/drivers/reboot-mode/reboot-mode-rtc.c
+++ b/drivers/reboot-mode/reboot-mode-rtc.c
@@ -9,8 +9,6 @@
 #include <reboot-mode/reboot-mode.h>
 #include <rtc.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static int reboot_mode_get(struct udevice *dev, u32 *buf)
 {
 	if (!buf)
diff --git a/drivers/remoteproc/rproc-uclass.c b/drivers/remoteproc/rproc-uclass.c
index 2dbd3a21cea6382a7ec02e52b2c0eb757197d434..47cb64fec777b28ecd435d645c5ca2879e0e4bc6 100644
--- a/drivers/remoteproc/rproc-uclass.c
+++ b/drivers/remoteproc/rproc-uclass.c
@@ -22,8 +22,6 @@
 #include <linux/compat.h>
 #include <linux/printk.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 struct resource_table {
 	u32 ver;
 	u32 num;
diff --git a/drivers/serial/ns16550.c b/drivers/serial/ns16550.c
index 4f7de3ea2152193a3916ca7b5bd052eda4a48bac..c885b46cf56fcaec955fc5c5fbcdb1c09470a29a 100644
--- a/drivers/serial/ns16550.c
+++ b/drivers/serial/ns16550.c
@@ -14,13 +14,10 @@
 #include <reset.h>
 #include <spl.h>
 #include <watchdog.h>
-#include <asm/global_data.h>
 #include <linux/err.h>
 #include <linux/types.h>
 #include <asm/io.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define UART_LCRVAL UART_LCR_8N1		/* 8 data, 1 stop, no parity */
 #define UART_MCRVAL (UART_MCR_DTR | \
 		     UART_MCR_RTS)		/* RTS/DTR */
diff --git a/drivers/serial/sandbox.c b/drivers/serial/sandbox.c
index cc0491bc3c8753e7488f01f3f31cf0dd4bdca834..658cbd2bbc90930ab7af1a6ce2c9a3b025074500 100644
--- a/drivers/serial/sandbox.c
+++ b/drivers/serial/sandbox.c
@@ -14,13 +14,10 @@
 #include <os.h>
 #include <serial.h>
 #include <video.h>
-#include <asm/global_data.h>
 #include <linux/compiler.h>
 #include <asm/serial.h>
 #include <asm/state.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static size_t _sandbox_serial_written = 1;
 static bool sandbox_serial_enabled = true;
 
diff --git a/drivers/serial/serial_adi_uart4.c b/drivers/serial/serial_adi_uart4.c
index 45f8315d0a07d90312ff6965f4e736cf217a27c3..784310ba2311f87cdd2034acbadac9ea899a7d1a 100644
--- a/drivers/serial/serial_adi_uart4.c
+++ b/drivers/serial/serial_adi_uart4.c
@@ -80,8 +80,6 @@
 #define ERXS			BIT(8)
 #define ETXS			BIT(9)
 
-DECLARE_GLOBAL_DATA_PTR;
-
 struct uart4_reg {
 	u32 revid;
 	u32 control;
diff --git a/drivers/serial/serial_htif.c b/drivers/serial/serial_htif.c
index 2a93bbbcc9f8d534be5937180b9709e9f517f4ab..690de3fc0854a989655c67ae2eefd83741750233 100644
--- a/drivers/serial/serial_htif.c
+++ b/drivers/serial/serial_htif.c
@@ -8,14 +8,11 @@
 #include <fdtdec.h>
 #include <log.h>
 #include <watchdog.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/compiler.h>
 #include <serial.h>
 #include <linux/err.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define HTIF_DATA_BITS		48
 #define HTIF_DATA_MASK		((1ULL << HTIF_DATA_BITS) - 1)
 #define HTIF_DATA_SHIFT		0
diff --git a/drivers/serial/serial_xen.c b/drivers/serial/serial_xen.c
index e05805f63726a399cfd030546939bc039627dd8c..4ba8d3ee641d0db10b86b3711c77ad8666b37c9a 100644
--- a/drivers/serial/serial_xen.c
+++ b/drivers/serial/serial_xen.c
@@ -7,7 +7,6 @@
 #include <dm.h>
 #include <serial.h>
 #include <watchdog.h>
-#include <asm/global_data.h>
 
 #include <linux/bug.h>
 
@@ -20,8 +19,6 @@
 #include <xen/interface/io/console.h>
 #include <xen/interface/io/ring.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 u32 console_evtchn;
 
 /*
diff --git a/drivers/smem/msm_smem.c b/drivers/smem/msm_smem.c
index b6b92d3530d26bd55910324757b3055ecfae115c..7a50d5a5792c1ceaf74c7433f01fc3428d9c967a 100644
--- a/drivers/smem/msm_smem.c
+++ b/drivers/smem/msm_smem.c
@@ -7,7 +7,6 @@
 
 #include <errno.h>
 #include <dm.h>
-#include <asm/global_data.h>
 #include <dm/device_compat.h>
 #include <dm/devres.h>
 #include <dm/of_access.h>
@@ -20,8 +19,6 @@
 #include <linux/sizes.h>
 #include <smem.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 /*
  * The Qualcomm shared memory system is an allocate-only heap structure that
  * consists of one of more memory areas that can be accessed by the processors
diff --git a/drivers/spi/ca_sflash.c b/drivers/spi/ca_sflash.c
index db32e39add2f5e9ca973c628fc4359862644d86d..f00df93a5f58a94f463c8ccc3da2b9c0fa1efb24 100644
--- a/drivers/spi/ca_sflash.c
+++ b/drivers/spi/ca_sflash.c
@@ -21,9 +21,6 @@
 #include <spi.h>
 #include <spi-mem.h>
 #include <reset.h>
-#include <asm/global_data.h>
-
-DECLARE_GLOBAL_DATA_PTR;
 
 struct ca_sflash_regs {
 	u32 idr;		/* 0x00:Flash word ID Register */
diff --git a/drivers/spi/microchip_coreqspi.c b/drivers/spi/microchip_coreqspi.c
index a84b257fb1ab5232a9b651f1a66a53561da60e32..b3ff611e8f7e6fa6dd879e0e3736fd18afdcd105 100644
--- a/drivers/spi/microchip_coreqspi.c
+++ b/drivers/spi/microchip_coreqspi.c
@@ -18,8 +18,6 @@
 #include <linux/sizes.h>
 #include <asm/gpio.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 /*
  * QSPI Control register mask defines
  */
diff --git a/drivers/spi/mvebu_a3700_spi.c b/drivers/spi/mvebu_a3700_spi.c
index fde9b142fb89957d22e2a90e1c09cf1e00c323f1..79836d7e271502a349f7c15c8d7f8fcce148cbfe 100644
--- a/drivers/spi/mvebu_a3700_spi.c
+++ b/drivers/spi/mvebu_a3700_spi.c
@@ -11,14 +11,11 @@
 #include <spi.h>
 #include <clk.h>
 #include <wait_bit.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <dm/device_compat.h>
 #include <linux/bitops.h>
 #include <asm/gpio.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define MVEBU_SPI_A3700_XFER_RDY		BIT(1)
 #define MVEBU_SPI_A3700_FIFO_FLUSH		BIT(9)
 #define MVEBU_SPI_A3700_BYTE_LEN		BIT(5)
diff --git a/drivers/spi/omap3_spi.c b/drivers/spi/omap3_spi.c
index 35bd87660978abdf6bf84ec9add0cb6225856245..b2d115aded470b7d9d21371b13c4c1aa384f2859 100644
--- a/drivers/spi/omap3_spi.c
+++ b/drivers/spi/omap3_spi.c
@@ -20,13 +20,10 @@
 #include <spi.h>
 #include <time.h>
 #include <malloc.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
 #include <omap3_spi.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 struct omap2_mcspi_platform_config {
 	unsigned int regs_offset;
 };
diff --git a/drivers/spi/spi-sunxi.c b/drivers/spi/spi-sunxi.c
index e00532a371b420d0fe88b337b0fd68ac71ef5bba..0bdc112d249f6f800ced064e5ebbfdeb0b12bbc0 100644
--- a/drivers/spi/spi-sunxi.c
+++ b/drivers/spi/spi-sunxi.c
@@ -26,7 +26,6 @@
 #include <fdt_support.h>
 #include <reset.h>
 #include <wait_bit.h>
-#include <asm/global_data.h>
 #include <dm/device_compat.h>
 #include <linux/bitops.h>
 
@@ -35,8 +34,6 @@
 
 #include <linux/iopoll.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 /* sun4i spi registers */
 #define SUN4I_RXDATA_REG		0x00
 #define SUN4I_TXDATA_REG		0x04
diff --git a/drivers/spi/spi-synquacer.c b/drivers/spi/spi-synquacer.c
index a3c0ad17121cdbaa7998acd973bd8be8eb46032a..66c97da610b90bdfcadc4b15a5a913c88afdceb3 100644
--- a/drivers/spi/spi-synquacer.c
+++ b/drivers/spi/spi-synquacer.c
@@ -99,8 +99,6 @@
 #define TXBIT	1
 #define RXBIT	2
 
-DECLARE_GLOBAL_DATA_PTR;
-
 struct synquacer_spi_plat {
 	void __iomem *base;
 	bool aces, rtm;
diff --git a/drivers/spi/spi-uclass.c b/drivers/spi/spi-uclass.c
index 49b584c648d6ffb273f9d5c3f3b773799d26a1fe..60401633341af191f0d70fc3b599cf5652ec4973 100644
--- a/drivers/spi/spi-uclass.c
+++ b/drivers/spi/spi-uclass.c
@@ -12,14 +12,11 @@
 #include <spi.h>
 #include <spi-mem.h>
 #include <dm/device_compat.h>
-#include <asm/global_data.h>
 #include <dm/device-internal.h>
 #include <dm/uclass-internal.h>
 #include <dm/lists.h>
 #include <dm/util.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define SPI_DEFAULT_SPEED_HZ 100000
 
 static int spi_set_speed_mode(struct udevice *bus, int speed, int mode)
diff --git a/drivers/spi/tegra210_qspi.c b/drivers/spi/tegra210_qspi.c
index b969a7993d40551cac96c64a18e74db716c35e3c..0f77fbc8d41815425d467b66939bae669c744ad6 100644
--- a/drivers/spi/tegra210_qspi.c
+++ b/drivers/spi/tegra210_qspi.c
@@ -9,7 +9,6 @@
 #include <dm.h>
 #include <log.h>
 #include <time.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/arch/clock.h>
 #include <asm/arch-tegra/clk_rst.h>
@@ -19,8 +18,6 @@
 #include <linux/delay.h>
 #include "tegra_spi.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 /* COMMAND1 */
 #define QSPI_CMD1_GO			BIT(31)
 #define QSPI_CMD1_M_S			BIT(30)
diff --git a/drivers/spmi/spmi-msm.c b/drivers/spmi/spmi-msm.c
index f3cd98c3db83d23f5d5bc9199c8ca5c9084f44a6..b89dd0b406baaa9413c1c45996d26d2452a3bed1 100644
--- a/drivers/spmi/spmi-msm.c
+++ b/drivers/spmi/spmi-msm.c
@@ -10,13 +10,10 @@
 #include <dm.h>
 #include <errno.h>
 #include <fdtdec.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <dm/device_compat.h>
 #include <spmi/spmi.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 /* PMIC Arbiter configuration registers */
 #define PMIC_ARB_VERSION 0x0000
 #define PMIC_ARB_VERSION_V2_MIN 0x20010000
diff --git a/drivers/thermal/imx_tmu.c b/drivers/thermal/imx_tmu.c
index c8389d507ee31a39467ea393dd5a18ff9385e3c2..1bde4d07f52efec6b5d0b8abe7add50df60f4597 100644
--- a/drivers/thermal/imx_tmu.c
+++ b/drivers/thermal/imx_tmu.c
@@ -5,7 +5,6 @@
  */
 
 #include <config.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/sys_proto.h>
@@ -19,8 +18,6 @@
 #include <malloc.h>
 #include <thermal.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define SITES_MAX	16
 #define FLAGS_VER2	0x1
 #define FLAGS_VER3	0x2
diff --git a/drivers/timer/ostm_timer.c b/drivers/timer/ostm_timer.c
index 314f956cdfb7a62dd103af4bc6b1f787127d2b68..3841d3c90d089491bbe0e5746de31f4f10584d05 100644
--- a/drivers/timer/ostm_timer.c
+++ b/drivers/timer/ostm_timer.c
@@ -7,7 +7,6 @@
 
 #include <clock_legacy.h>
 #include <malloc.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <dm.h>
 #include <clk.h>
@@ -22,8 +21,6 @@
 #define OSTM_CTL	0x20
 #define OSTM_CTL_D	BIT(1)
 
-DECLARE_GLOBAL_DATA_PTR;
-
 struct ostm_priv {
 	fdt_addr_t	regs;
 };
diff --git a/drivers/timer/sp804_timer.c b/drivers/timer/sp804_timer.c
index 3e57f4b98bab98d5ea92f9f67de1a8f7a606351b..05532e3330cae52d5874b1b6a117e48ad59f05be 100644
--- a/drivers/timer/sp804_timer.c
+++ b/drivers/timer/sp804_timer.c
@@ -8,15 +8,12 @@
 #include <dm.h>
 #include <init.h>
 #include <log.h>
-#include <asm/global_data.h>
 #include <dm/ofnode.h>
 #include <mapmem.h>
 #include <dt-structs.h>
 #include <timer.h>
 #include <asm/io.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define SP804_TIMERX_LOAD		0x00
 #define SP804_TIMERX_VALUE		0x04
 #define SP804_TIMERX_CONTROL		0x08
diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
index 13e9a61072a973acc9a2a7096867bb6d26fe6123..22aa6525c96d4c169685ebca103e247625ceddd8 100644
--- a/drivers/usb/common/common.c
+++ b/drivers/usb/common/common.c
@@ -7,14 +7,11 @@
  */
 
 #include <dm.h>
-#include <asm/global_data.h>
 #include <linux/printk.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/phy.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static const char *const usb_dr_modes[] = {
 	[USB_DR_MODE_UNKNOWN]		= "",
 	[USB_DR_MODE_HOST]		= "host",
diff --git a/drivers/usb/phy/rockchip_usb2_phy.c b/drivers/usb/phy/rockchip_usb2_phy.c
index ce9a7b5b81952a942525fdd504b552cfa93de9f2..bdbd0d44813aea53c3bbfe9365b045199d134b3c 100644
--- a/drivers/usb/phy/rockchip_usb2_phy.c
+++ b/drivers/usb/phy/rockchip_usb2_phy.c
@@ -5,15 +5,12 @@
 
 #include <hang.h>
 #include <log.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
 
 #include "../gadget/dwc2_udc_otg_priv.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define BIT_WRITEABLE_SHIFT	16
 
 struct usb2phy_reg {
diff --git a/drivers/usb/tcpm/tcpm.c b/drivers/usb/tcpm/tcpm.c
index 0aee57cb2f4a44af7b483e0e609e39ba584a06c0..3061b466d7c7e3736469018f25e8b7906ebf3cf3 100644
--- a/drivers/usb/tcpm/tcpm.c
+++ b/drivers/usb/tcpm/tcpm.c
@@ -19,8 +19,6 @@
 #include <usb/tcpm.h>
 #include "tcpm-internal.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 const char * const tcpm_states[] = {
 	FOREACH_TCPM_STATE(GENERATE_TCPM_STRING)
 };
diff --git a/drivers/video/hx8238d.c b/drivers/video/hx8238d.c
index f0220e4cc07946907c393f57cf634c944a03f411..b6980b1aec1cdb48ae763298d890ba9aa6814b99 100644
--- a/drivers/video/hx8238d.c
+++ b/drivers/video/hx8238d.c
@@ -16,8 +16,6 @@
 #include <panel.h>
 #include <spi.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 /* Register Address */
 #define HX8238D_OUTPUT_CTRL_ADDR        0x01
 #define HX8238D_LCD_AC_CTRL_ADDR        0x02
diff --git a/drivers/video/imx/mxc_ipuv3_fb.c b/drivers/video/imx/mxc_ipuv3_fb.c
index ab416fdd33c1842582acf051318f08ae0adb0ecc..ef5d4faf3b38e0540d5d7f67d4c9c2227cb486f9 100644
--- a/drivers/video/imx/mxc_ipuv3_fb.c
+++ b/drivers/video/imx/mxc_ipuv3_fb.c
@@ -21,7 +21,6 @@
 #include "ipu_regs.h"
 #include "mxcfb.h"
 #include <asm/cache.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/mach-imx/video.h>
 #include <linux/err.h>
@@ -37,8 +36,6 @@
 #include <dm/devres.h>
 #include <video.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static int mxcfb_map_video_memory(struct fb_info *fbi);
 static int mxcfb_unmap_video_memory(struct fb_info *fbi);
 
diff --git a/drivers/video/nexell_display.c b/drivers/video/nexell_display.c
index ea3776258a005a9262583e6e860c19d73a5cc3da..e0416b70ec0f99f5762e01f0a409d6b50f272145 100644
--- a/drivers/video/nexell_display.c
+++ b/drivers/video/nexell_display.c
@@ -16,14 +16,11 @@
 #include <linux/compat.h>
 #include <linux/err.h>
 #include <video.h>		/* For struct video_uc_plat */
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/arch/display.h>
 #include <asm/arch/display_dev.h>
 #include "videomodes.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #if !defined(CONFIG_DM) && !defined(CONFIG_OF_CONTROL)
 static struct nx_display_dev *dp_dev;
 #endif
diff --git a/drivers/video/rockchip/rk_lvds.c b/drivers/video/rockchip/rk_lvds.c
index c969dae30b6912b122a1a8ae0c2a4789c7015312..97c8619a6d8f0cecdba4f70928eff600d2eeaf79 100644
--- a/drivers/video/rockchip/rk_lvds.c
+++ b/drivers/video/rockchip/rk_lvds.c
@@ -10,7 +10,6 @@
 #include <panel.h>
 #include <regmap.h>
 #include <syscon.h>
-#include <asm/global_data.h>
 #include <asm/gpio.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/grf_rk3288.h>
@@ -19,8 +18,6 @@
 #include <dt-bindings/clock/rk3288-cru.h>
 #include <dt-bindings/video/rk3288.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 /**
  * struct rk_lvds_priv - private rockchip lvds display driver info
  *
diff --git a/drivers/video/rockchip/rk_mipi.c b/drivers/video/rockchip/rk_mipi.c
index 0a603083ba9a561501ab2d8f37e00ea98b734aa0..e7b5973ca589681ad0abee39022057b4a3ad4750 100644
--- a/drivers/video/rockchip/rk_mipi.c
+++ b/drivers/video/rockchip/rk_mipi.c
@@ -10,7 +10,6 @@
 #include <log.h>
 #include <panel.h>
 #include <regmap.h>
-#include <asm/global_data.h>
 #include "rk_mipi.h"
 #include <syscon.h>
 #include <asm/gpio.h>
@@ -22,8 +21,6 @@
 #include <asm/arch-rockchip/grf_rk3399.h>
 #include <asm/arch-rockchip/rockchip_mipi_dsi.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 int rk_mipi_read_timing(struct udevice *dev,
 			struct display_timing *timing)
 {
diff --git a/drivers/video/sandbox_sdl.c b/drivers/video/sandbox_sdl.c
index 69dfa9302735b0f23bf3c4065516135ccb89d7f0..48da350080a72986a99c5dd619a9810f8781e8b7 100644
--- a/drivers/video/sandbox_sdl.c
+++ b/drivers/video/sandbox_sdl.c
@@ -7,15 +7,12 @@
 #include <fdtdec.h>
 #include <log.h>
 #include <video.h>
-#include <asm/global_data.h>
 #include <asm/sdl.h>
 #include <asm/state.h>
 #include <asm/u-boot-sandbox.h>
 #include <dm/device-internal.h>
 #include <dm/test.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 enum {
 	/* Default LCD size we support */
 	LCD_MAX_WIDTH		= 1366,
diff --git a/drivers/video/tidss/tidss_drv.c b/drivers/video/tidss/tidss_drv.c
index 790ff6e591c00c33ee073cbb20c5dbe778a3d481..c231fd0341ebe08344276a74937a75ddba4576f3 100644
--- a/drivers/video/tidss/tidss_drv.c
+++ b/drivers/video/tidss/tidss_drv.c
@@ -42,8 +42,6 @@
 #include "tidss_regs.h"
 #include "tidss_oldi.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 /* Panel parameters */
 enum {
 	LCD_MAX_WIDTH		= 1920,
diff --git a/drivers/video/zynqmp/zynqmp_dpsub.c b/drivers/video/zynqmp/zynqmp_dpsub.c
index a0efd3393f5fe2c3a468caec4ad81deef18dbdbf..fba65bb3d5bb77f6a9518b90e570fdc102950760 100644
--- a/drivers/video/zynqmp/zynqmp_dpsub.c
+++ b/drivers/video/zynqmp/zynqmp_dpsub.c
@@ -20,12 +20,9 @@
 #include <linux/delay.h>
 #include <linux/ioport.h>
 #include <dm/device_compat.h>
-#include <asm/global_data.h>
 
 #include "zynqmp_dpsub.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 /* Maximum supported resolution */
 #define WIDTH				1024
 #define HEIGHT				768
diff --git a/drivers/watchdog/armada-37xx-wdt.c b/drivers/watchdog/armada-37xx-wdt.c
index 4b51178e1b8c8e6cb92287ad9ac9c27f4c839271..d7a6b8de492ddc8bf698eaeeef74f996dc8a3b29 100644
--- a/drivers/watchdog/armada-37xx-wdt.c
+++ b/drivers/watchdog/armada-37xx-wdt.c
@@ -7,14 +7,11 @@
 
 #include <dm.h>
 #include <wdt.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/arch/cpu.h>
 #include <asm/arch/soc.h>
 #include <dm/device_compat.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 struct a37xx_wdt {
 	void __iomem *sel_reg;
 	void __iomem *reg;
diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
index 72e13787448e366036dce4a451cc2294e5b60a0d..2fb25126b8cbb22e819c376dba5da720dbe3f30f 100644
--- a/drivers/watchdog/at91sam9_wdt.c
+++ b/drivers/watchdog/at91sam9_wdt.c
@@ -15,7 +15,6 @@
  */
 
 #include <log.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/arch/at91_wdt.h>
 #include <div64.h>
@@ -23,8 +22,6 @@
 #include <errno.h>
 #include <wdt.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 /*
  * AT91SAM9 watchdog runs a 12bit counter @ 256Hz,
  * use this to convert a watchdog
diff --git a/drivers/watchdog/mt7621_wdt.c b/drivers/watchdog/mt7621_wdt.c
index 6308d9632a8115f83daf765ca860133c2fd340fa..08ef3d84e26d3f9bc1a3f8d0e22d7945da0a3f9a 100644
--- a/drivers/watchdog/mt7621_wdt.c
+++ b/drivers/watchdog/mt7621_wdt.c
@@ -11,12 +11,9 @@
 
 #include <dm.h>
 #include <wdt.h>
-#include <asm/global_data.h>
 #include <linux/bitops.h>
 #include <linux/io.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 struct mt762x_wdt {
 	void __iomem *regs;
 };
diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 4562b2a37e3478da2f5b117f52a89051491653ff..a2000b968c9b90114e157006862f324bfb6c00a5 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -16,15 +16,12 @@
 #include <clk.h>
 #include <log.h>
 #include <wdt.h>
-#include <asm/global_data.h>
 #include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <asm/io.h>
 #include <asm/arch/cpu.h>
 #include <asm/arch/soc.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 struct orion_wdt_priv {
 	void __iomem *reg;
 	int wdt_counter_offset;
diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
index 03585529bb636a763fcbd536646bbd453735d1bc..807884c5bc73d20409a8cfd5dfa2f94fab3e5692 100644
--- a/drivers/watchdog/sbsa_gwdt.c
+++ b/drivers/watchdog/sbsa_gwdt.c
@@ -5,7 +5,6 @@
  * Copyright 2020 NXP
  */
 
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <dm/device.h>
 #include <dm/fdtaddr.h>
@@ -15,8 +14,6 @@
 #include <watchdog.h>
 #include <wdt.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 /* SBSA Generic Watchdog register definitions */
 /* refresh frame */
 #define SBSA_GWDT_WRR		0x000
diff --git a/drivers/watchdog/wdt-uclass.c b/drivers/watchdog/wdt-uclass.c
index b32590069d97651f02468c70a85dfb6a4442fce6..438833b2245eaf2af62dfb80c754e146fd43441c 100644
--- a/drivers/watchdog/wdt-uclass.c
+++ b/drivers/watchdog/wdt-uclass.c
@@ -14,13 +14,10 @@
 #include <sysreset.h>
 #include <time.h>
 #include <wdt.h>
-#include <asm/global_data.h>
 #include <dm/device-internal.h>
 #include <dm/lists.h>
 #include <linux/kernel.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define WATCHDOG_TIMEOUT_SECS	(CONFIG_WATCHDOG_TIMEOUT_MSECS / 1000)
 
 struct wdt_priv {
diff --git a/fs/fs.c b/fs/fs.c
index 319c55c440aaffb8e59975fa6ea0c06e98cc894f..8ea50a6c13c403106ccc639c7c4e7fa2c4445a48 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -24,7 +24,6 @@
 #include <ubifs_uboot.h>
 #include <btrfs.h>
 #include <asm/cache.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <div64.h>
 #include <linux/math64.h>
@@ -34,8 +33,6 @@
 #include <erofs.h>
 #include <exfat.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static struct blk_desc *fs_dev_desc;
 static int fs_dev_part;
 static struct disk_partition fs_partition;
diff --git a/fs/ubifs/ubifs.c b/fs/ubifs/ubifs.c
index 40bad0e7da7afe76a37cbec7d4fc64ad944f198e..b0cc0d2e1b2279669382149a02962c79950dd14e 100644
--- a/fs/ubifs/ubifs.c
+++ b/fs/ubifs/ubifs.c
@@ -16,7 +16,6 @@
 #include <log.h>
 #include <malloc.h>
 #include <memalign.h>
-#include <asm/global_data.h>
 #include "ubifs.h"
 #include <part.h>
 #include <dm/devres.h>
@@ -31,8 +30,6 @@
 #include <abuf.h>
 #endif
 
-DECLARE_GLOBAL_DATA_PTR;
-
 /* compress.c */
 
 /*
diff --git a/include/relocate.h b/include/relocate.h
index 8ca25e1105e6b9536d4df82c1e413e8bea232b6b..331be1387288e5597ce6dbc6baf842c2f0831d62 100644
--- a/include/relocate.h
+++ b/include/relocate.h
@@ -8,9 +8,7 @@
 #define _RELOCATE_H_
 
 #ifndef USE_HOSTCC
-#include <asm/global_data.h>
 
-DECLARE_GLOBAL_DATA_PTR;
 #endif
 
 /**
diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
index 89e63ed8dd5cd43f9800f83784e3e72c37b59f54..d66ddd1bbf860bc536430f8684777894ab08142a 100644
--- a/lib/efi_loader/efi_capsule.c
+++ b/lib/efi_loader/efi_capsule.c
@@ -21,7 +21,6 @@
 #include <mapmem.h>
 #include <sort.h>
 #include <sysreset.h>
-#include <asm/global_data.h>
 #include <u-boot/uuid.h>
 
 #include <asm/sections.h>
@@ -29,8 +28,6 @@
 #include <crypto/pkcs7_parser.h>
 #include <linux/err.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 const efi_guid_t efi_guid_capsule_report = EFI_CAPSULE_REPORT_GUID;
 static const efi_guid_t efi_guid_firmware_management_capsule_id =
 		EFI_FIRMWARE_MANAGEMENT_CAPSULE_ID_GUID;
diff --git a/lib/efi_loader/efi_gop.c b/lib/efi_loader/efi_gop.c
index 3abb47d610e658b67ba15ed3dcc0317fb3f96c0a..9403e09691e1a6e93dd35df5be1f9fede6dfea1f 100644
--- a/lib/efi_loader/efi_gop.c
+++ b/lib/efi_loader/efi_gop.c
@@ -13,9 +13,6 @@
 #include <malloc.h>
 #include <mapmem.h>
 #include <video.h>
-#include <asm/global_data.h>
-
-DECLARE_GLOBAL_DATA_PTR;
 
 static const efi_guid_t efi_gop_guid = EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID;
 
diff --git a/lib/efi_loader/efi_rng.c b/lib/efi_loader/efi_rng.c
index 4734f95eee1df3ebaa53be958b04acc8e2d0332e..7810b4e47ead4f2605d9688bffb4c75881dc7fe8 100644
--- a/lib/efi_loader/efi_rng.c
+++ b/lib/efi_loader/efi_rng.c
@@ -10,9 +10,6 @@
 #include <efi_rng.h>
 #include <log.h>
 #include <rng.h>
-#include <asm/global_data.h>
-
-DECLARE_GLOBAL_DATA_PTR;
 
 const efi_guid_t efi_guid_rng_protocol = EFI_RNG_PROTOCOL_GUID;
 
diff --git a/net/eth-uclass.c b/net/eth-uclass.c
index a233912fd8e8e6a18e2bb982c834abfd3ab41c2f..5c437143a3075e4bc3654b34e9afba500c10bf65 100644
--- a/net/eth-uclass.c
+++ b/net/eth-uclass.c
@@ -14,15 +14,12 @@
 #include <log.h>
 #include <net.h>
 #include <nvmem.h>
-#include <asm/global_data.h>
 #include <dm/device-internal.h>
 #include <dm/uclass-internal.h>
 #include <net/pcap.h>
 #include "eth_internal.h"
 #include <eth_phy.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 /**
  * struct eth_device_priv - private structure for each Ethernet device
  *
diff --git a/net/tftp.c b/net/tftp.c
index 78ec44159c1be7ac40bd57f54c62d965932d8c87..73d6a6a3c1bd984d9eb26763dd4e31708fec55ed 100644
--- a/net/tftp.c
+++ b/net/tftp.c
@@ -16,12 +16,9 @@
 #include <mapmem.h>
 #include <net.h>
 #include <net6.h>
-#include <asm/global_data.h>
 #include <net/tftp.h>
 #include "bootp.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 /*
  * We cannot use the 'tftpput' command in xPL phases. Given how the
  * support is integrated in the code, this is how we disable that support
diff --git a/net/wget.c b/net/wget.c
index d3642958bf0ede476411369545c65231dff14089..49bfb9fcb96dfb5684ab10bd247fb21169e83851 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -4,7 +4,6 @@
  * Copyright Duncan Hare <dh@synoia.com> 2017
  */
 
-#include <asm/global_data.h>
 #include <command.h>
 #include <display_options.h>
 #include <env.h>
@@ -17,8 +16,6 @@
 #include <net/wget.h>
 #include <stdlib.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 /* The default, change with environment variable 'httpdstp' */
 #define SERVER_PORT		80
 
diff --git a/test/cmd/exit.c b/test/cmd/exit.c
index fdde054b92898884f61821e8a6a8ac779667fc89..e20bc5f7b98cda77b0a458231df72fb3dc7e3312 100644
--- a/test/cmd/exit.c
+++ b/test/cmd/exit.c
@@ -7,11 +7,8 @@
 
 #include <console.h>
 #include <mapmem.h>
-#include <asm/global_data.h>
 #include <test/ut.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 /* Declare a new exit test */
 #define EXIT_TEST(_name, _flags)	UNIT_TEST(_name, _flags, exit)
 
diff --git a/test/cmd/test_echo.c b/test/cmd/test_echo.c
index 8b306cc907fbce7eb900caefdfa72ca1fc0d49ac..7ed534742f77a3d21775a9e5c49b19ca36e5ef9e 100644
--- a/test/cmd/test_echo.c
+++ b/test/cmd/test_echo.c
@@ -6,14 +6,11 @@
  */
 
 #include <command.h>
-#include <asm/global_data.h>
 #include <display_options.h>
 #include <test/lib.h>
 #include <test/test.h>
 #include <test/ut.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 struct test_data {
 	char *cmd;
 	char *expected;
diff --git a/test/cmd/test_pause.c b/test/cmd/test_pause.c
index 174c31a3852eaf731d287d023e88a6af476a2371..b2cf60d3e74ed84fa844ce7b1401cf2be7a691e1 100644
--- a/test/cmd/test_pause.c
+++ b/test/cmd/test_pause.c
@@ -5,12 +5,9 @@
  * Copyright 2022, Samuel Dionne-Riel <samuel@dionne-riel.com>
  */
 
-#include <asm/global_data.h>
 #include <test/lib.h>
 #include <test/ut.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static int lib_test_hush_pause(struct unit_test_state *uts)
 {
 	/* Test default message */
diff --git a/test/dm/blk.c b/test/dm/blk.c
index 1b928b27d9cdbd0299d8081f0e3795ab88432219..f67869107da1cda6a5b8dabaec27b64b538c70be 100644
--- a/test/dm/blk.c
+++ b/test/dm/blk.c
@@ -8,14 +8,11 @@
 #include <part.h>
 #include <sandbox_host.h>
 #include <usb.h>
-#include <asm/global_data.h>
 #include <asm/state.h>
 #include <dm/test.h>
 #include <test/test.h>
 #include <test/ut.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 /* Test that block devices can be created */
 static int dm_test_blk_base(struct unit_test_state *uts)
 {
diff --git a/test/dm/i3c.c b/test/dm/i3c.c
index 81336e67555d148142574b7d2a4c2bf80c080302..816ecabd7228648ee32f64a7f68fefcc2c04653c 100644
--- a/test/dm/i3c.c
+++ b/test/dm/i3c.c
@@ -8,8 +8,6 @@
 #include <dm/test.h>
 #include <test/ut.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 /* Basic test of the i3c uclass */
 static int dm_test_i3c_base(struct unit_test_state *uts)
 {
diff --git a/test/lib/test_print.c b/test/lib/test_print.c
index cd7f3f85769682fe8da73570d2f47adaab25055d..2aeb034b12112d070bb708e70e925ade8f8ad297 100644
--- a/test/lib/test_print.c
+++ b/test/lib/test_print.c
@@ -7,13 +7,10 @@
 
 #include <command.h>
 #include <display_options.h>
-#include <asm/global_data.h>
 #include <test/lib.h>
 #include <test/test.h>
 #include <test/ut.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static int test_print_freq(struct unit_test_state *uts,
 			   uint64_t freq, char *expected)
 {
diff --git a/test/log/log_filter.c b/test/log/log_filter.c
index 680c60164b623bb30bf0a5457c190bab8d97468a..147b83980cffd26d0bf20c5ff1641cf3545f8e3c 100644
--- a/test/log/log_filter.c
+++ b/test/log/log_filter.c
@@ -6,12 +6,9 @@
 #include <console.h>
 #include <log.h>
 #include <vsprintf.h>
-#include <asm/global_data.h>
 #include <test/log.h>
 #include <test/ut.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 /* Test invalid options */
 static int log_test_filter_invalid(struct unit_test_state *uts)
 {

-- 
2.37.1

