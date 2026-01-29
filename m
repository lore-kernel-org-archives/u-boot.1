Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C36D358EC
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 09:41:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F38283D17;
	Thu, 29 Jan 2026 10:39:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MH+ddZax";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EC8083F2E; Thu, 29 Jan 2026 10:39:56 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9998783E52
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 10:39:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lEwrHMFkMarMSUDAaHSrAxUDFomzW0a+5PS+asKdfP2+s0bo9Ev2d5s5WOROLmy+uKtwXV3dlQ4VQQHh+gdzTO1whsqjC6WaUOyzY2JAYh72KGDHkshUCWNt/U9W2zJZyWArpeOSjRPu9Y8McXaaqzcp39BQLQumZC4/rt7aLdNldAxhE2EiArwsinFyDf6FQQcpCa+U6ncXUIk7zflqE4bhQ+u1uyJXvcU+jdwyymVZ9Rvw9c2i7qYRVtVv6m4VMJpwoANMb7+FnTXWgXjFLkgD7w4lueKnvO0qhW9nDvxxzHnk0f/D2hKz/yFriquqBOfWNT67h95u1n8reVPebw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zG3tzYgwXRQ43NS5eLtBLL+20PdqcltJQY8Lg1tjBso=;
 b=dvbr2eyXRgf6uoi+MtSI1F78oUf7KQkL4tdPmyBxxathIQ8o25QHnZJ+1wuhT2GE2smF6+mbrIWnG5qEJrvI1RIVj0LjuHKPN76jVrnJf+29puf+FOia0u3JhL6hzbXHzFq37rDRPJaw+nPEMfU55Ikgh5iDBY/egNYfzyYfFoEgUpsydWqRBbxvSr+o1VM9IBPQZAxD8Ucdtx+MzgO1MyPUgNGFi1urlS8TXrD4sw71DtVGEARbmyEzOhG71z3luC4Au5RuGxcjxl6p3kaKFrxSPepu9Cwb4sideJ/Zjtaj9EMUdtsshfcOAdl+JROTgEpDg+Y+v7q3H+C3drHcTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zG3tzYgwXRQ43NS5eLtBLL+20PdqcltJQY8Lg1tjBso=;
 b=MH+ddZax6n5eoevyOE87Vk9wVBThlZ0c3BrWm6InrHzO4UjdX6gVk8yL6123T+8Vwydnl4Rsoe2ZgiBdVN42QIErcaubbtd31wEy0l9cC/OWqfnNERwud3sDDg1vOV7tO2gV7Y9TXXBCRcvl8QXZLWOT3f7yKIdZjpuXQyc1JrlICY0TlDGWaChHNH98PG62A6U19ofTBcf+b7zyR/nlwEn6t+gGdX9o5XL0ClwFKnyqxxXMx82lF6NtgwRfa2rOAYcOFRbjAKijqzS/qui125ZgLPIKFHeksgdn0GjpFkOXJxUIoSuHmcExkYxuHnusdc6txwvcI+N3wSemfRMzKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10384.eurprd04.prod.outlook.com (2603:10a6:150:1dc::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.10; Thu, 29 Jan
 2026 09:39:52 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 09:39:52 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 29 Jan 2026 18:54:12 +0800
Subject: [PATCH v2 10/12] imx8mq_evk: spl: Drop DECLARE_GLOBAL_DATA_PTR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260129-imx-clean-v2-v2-10-1245ad2c3a01@nxp.com>
References: <20260129-imx-clean-v2-v2-0-1245ad2c3a01@nxp.com>
In-Reply-To: <20260129-imx-clean-v2-v2-0-1245ad2c3a01@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SG2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::10)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB10384:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ee200c1-d73f-4f06-6cec-08de5f1a5a36
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y09kb1pYMndCRkZITXp5OXNTcFI3UUpYYU9TSUJlS3VqNWlFQzU1K2taa0ts?=
 =?utf-8?B?b1pRQ1VXQWFHOXNHcUg2UDNjODloZEZEN29CRnJpeVVQazBpb2wyZEd1bTZW?=
 =?utf-8?B?ZFZrK1RwZDdSZXhDUlpyVk5lWm83WjA1emdZRmVzNStqdlVmY2wzd3diODdy?=
 =?utf-8?B?cDkwemZMZ3Z5Qy9rRVJpdnExdGM3NUsvVEF1MDBORlkvbTVKZ2VBa2tFQUZz?=
 =?utf-8?B?QUZ6NUhvVjhQZUtoZ1gySzRpaEpmb096amd6Z2hwSjNiaGNwK0pHKzZtZHlx?=
 =?utf-8?B?VjdMMEdRQmFZWGxTWGVkZGlzbGM4cW5WbVBna1dEVkFNQkwydzNCKzU2Lzd1?=
 =?utf-8?B?MzhMK0dsc2doZ0RpNjNxcXYzcTNabzlkM3pXNXRsVXdDT0g4UXpmOCtMeTNo?=
 =?utf-8?B?UzRFY0RLdC9tNk1DWTlsNHY1dnNMazFUNU5uTnZlT09zUlZaMkEwWjlyV3dZ?=
 =?utf-8?B?aXMyaWlwb1hBckNxWUt5eklaQXpZbi9FQ2pJZUxQNWZUSHdQYXZNYjFMSmZo?=
 =?utf-8?B?UG1uL1RWd2M2V2lDbHFYeU9xZklIOXRUdWhKNWhTMmxUQ3FFQTkwZThqRDV4?=
 =?utf-8?B?YTZvSHRROTVIcmtFbFh5dkJKaThuQnFxMDgyUFFrTkxWU210Zk1adXhCT1R5?=
 =?utf-8?B?V2hTM21IYlVqTW9nVUVYbkZtY05OL1BzbHkzc0Z0cFd5clBiRmFmUFhyaGNi?=
 =?utf-8?B?djg1VUhIa1FMSkc4TVJqeWR0RFVNMlRJTlEyck9pbzlySTdTc0MyeWNqak5P?=
 =?utf-8?B?Z3pmMExnVkR0NG1QTXJ3cFdiVExCM3RNbktBalF3USttZm1xcXdsNldIa3dW?=
 =?utf-8?B?TVZTMFJoSmZ4Q0U5NngyZFhNYkcwY0ZpaDhSQk9DazBlQWxOTnRzbFBqUHNy?=
 =?utf-8?B?RXpZeEc1RGpkZm5IZlRNS0E2cGFBTlByUCt6L05ScEZudkJOZmlmcjA2Q3Z6?=
 =?utf-8?B?cW1mOFc5aEFwMVg1NWsyZHFSNnZDMGx5RllrRTVSendyZEV0dEFCU01MOWVL?=
 =?utf-8?B?WnQxMSthUGZkU1FZQU8zL21sRTZNcEZqaVZoZnd3VEFobmpJQ2N2TXhiRUdO?=
 =?utf-8?B?T1FIOXFPNHhNdUdnTFNxWVBwU3pwVGRyc3NjbFlHeGNncis0YjJZRFJwNm9p?=
 =?utf-8?B?WFhMMW44WHAxaXM1Y3BCckRySzhCN3ZZcTdBT1FOanZGOXN1WEV6YWhkWVJC?=
 =?utf-8?B?cjZ3ZHZaT0tSU3dHZVlxejZsZ2lzdkxDdzFCcjFSME5pZ21pS0lHTzNNOHFD?=
 =?utf-8?B?MDdPR2UzS0FYVHZXekMwbUI3SzB3ZVhSa2w2SW12MXlUckhOMTQ4MHJhdUJS?=
 =?utf-8?B?WFVVZXNqV1I2Wkw4Ulhhd2RranlBN2dxR2ZDRzZuOTNyWnhWQng1cW1FYzE5?=
 =?utf-8?B?cThrYUYrWHNhVG1FZVFRMUEzOUFKRHJvb1RzK2JIWkcwU2tkcFFkSklxWFBK?=
 =?utf-8?B?dkZsRVlXTEs2d1Izak81eER2TE5ZVnhQcTEwMm5SREI0b3Y3Ym9WYXFuN2hD?=
 =?utf-8?B?eVUvOEswYUdNWXNVRlNBUEx3RWJHMlBaMGx1M0w1d0J6M2U1L3V6OGRMWDM4?=
 =?utf-8?B?VzFDRUpkTS9PVmwwUkxERE5IbnJhM3hOc1VaaExsOWZhQ1ZNNjVNdmZrbFNz?=
 =?utf-8?B?WlVoa2l0Z1RuSUo0Mjc1MCtJNld1cktoYmtCRVV6a2gvTXFibVlJeEZ4ZnM5?=
 =?utf-8?B?VllRdi9ZVzVzLzVwSklVZG9DUDNiOGZvaXJJbndQck91VVo4YjZuMU5kZjk4?=
 =?utf-8?B?SEhiZWZQOGZFTS9mbnp0Qy84YkZGdHg3bERXUjVZMkdRbG45RkxXUVZnSlhM?=
 =?utf-8?B?UjR6ZHRqeTNnNXpmeTVKam5oSXJNOWNhMnRob2t6dVR5TTVEUUFNMkdSRDRm?=
 =?utf-8?B?dDVCZFY5NCs0RndXTksvZzl5RmlvcTVjNE5rQUJZOCtQWXpvQk9lQWhGclBU?=
 =?utf-8?B?TzgvS2c0VGdlQVphVThNczdrVVhOSWszY3QwbXpaSmphdFhGeWxKVjB2RHNS?=
 =?utf-8?B?ejJHZWFUWXRXZ25YdUdmVnljbzBIY3BlY3I5NFQ2eXVhbTE1VjM3ZER2dnFC?=
 =?utf-8?B?UktxZzNtRE9jNWhDZUQ4SmdYaXU2c3AxVG9MQ1M5OCs5THhmSXp2OE9OVHR2?=
 =?utf-8?B?dHo1WXRTUk5nZjZnYm9Xek9LWG8zekk3dUxQenAza3o4TzdBTTRuYlpQQnI0?=
 =?utf-8?Q?nMfoIEPRYaJsXi7RnF9EsCk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUJKM1dReU0wRGY5UHZMbFNYKzlZQWFRS2x3OHBDSEtXYzl6VXhHS1B0MFFi?=
 =?utf-8?B?SGZqWEVOZFlaTjZBTXhsTUora3dxa3g2dVBUaThHZ1d0VVlhWlhrYmVzeEVM?=
 =?utf-8?B?OXJ4MW0vOWhKSSswQ2dKMGEvenprSEFYK2R0RHJJMFpxS2R5SkJOOXVhNzZT?=
 =?utf-8?B?TDFQRFhTcGxjWDNuakN1dFhtcnZVa0JMK1Q2ZVFITjhWWHNtVUF1Z1dONys2?=
 =?utf-8?B?UXBIVWRJQnF1YXhwT0t5Y3VRZE5QaENMci9qS2d0dlpPMVk5QThYZW1ISUk2?=
 =?utf-8?B?SzkyRi9KM2xQK0dzY2RzeThDWnY5QUNNcG1PMzFLMXdlbm10S3B3U3l1RlVT?=
 =?utf-8?B?UVVBVTE0Q0hvWXBCQktpU3pvT2VRSmFTOS96TDdjRjNoUGxrcWluLzlaenV6?=
 =?utf-8?B?azROT0VIbG5MM2VmK2pkMWhRSlNlMTFIdkYrZUxnUE9uTkpYV2FDWkZaSHBL?=
 =?utf-8?B?MVlvbDBMYlh2MUF6RWN1Q2g2NXlNanFpdWdKRXdTZ1RTakhycmZBTHFjYktk?=
 =?utf-8?B?dlAwalVReUZYaVR3cDJlTTc1UFdpcDd1RS9sTjJLWmI4NHJPQmVhM0p1aW8y?=
 =?utf-8?B?WEx4cDRxTEtPTUt3SUkrWHJyVnpnelFSZ015eFVmUU42ZGdyZGRXMGtzb1lv?=
 =?utf-8?B?dTdYdmI5U0J3eElWSVE3V01XRHAyRE1KMi91WklaT2J4ZTNoSHVHOVdPcnRk?=
 =?utf-8?B?a2xtQ3cvT0w1N1hDUERoeHBCN1J1YURnM0VNdTNONmZYalpOSGljd3FnVW1v?=
 =?utf-8?B?dWxJQ1JOSnpRRU85R0RZU3E4OWh2T2RpNmtTYURJT3B6c1diTzBSNEkzb21x?=
 =?utf-8?B?MjhLcERHRVk5WXp3TmhUeGdRblExMTFwc2pQSVpCdSs3K2poNE5QOXFGajZ2?=
 =?utf-8?B?L3ZDYkEydFFFYitKM2RyclF5MjgrRmZGQTAzNEZCMkVZZHptOEdvaWk1d2ty?=
 =?utf-8?B?T3d4Nm9Wa0VyVHM2TUduV2w3ckoyVDVnR1Vod2RYS3FVSDJRME5WVzUzYnA4?=
 =?utf-8?B?SGRLQUZuS0UzcEQxZmhVaUZEREIzcmZ6bUR0ajVTdmc5SFZMd1BCZnBQbW1w?=
 =?utf-8?B?Tk9GR3A2bUZKbDVBRExOSGM3Z2RwM1NUbE40a1JnSEhCRnJlcXhsM3lDZ0xB?=
 =?utf-8?B?QndHNkkzMktSZk00ZmxENW1HUHlFVmE4aEhNMmZPRjc0dTIveXc2cmkxakZv?=
 =?utf-8?B?RHhJOG9LOS9xR3VPY1FzOVROSUFjcEN6cTJycmZpVnNtV2Jub2xTUEZhWnlk?=
 =?utf-8?B?cFhDeG5CWmt5NTlYUmM0b2VzRlRPMG5RWjNCTTQ0MnBKbExwSXorYVRiWG4y?=
 =?utf-8?B?VmtSa204OFBUdmN6TlJRdGJKL1FmRDI0SjFLU0JSdTlTRHFBVUpoTHNzWm0z?=
 =?utf-8?B?UFdEeXFoMHVaWElOU1pGOURxeklrM2lIdHBmeGZOK2x3VlprT3pXZkhqQ3Fq?=
 =?utf-8?B?UUY2VzhMd09IbEN1Q1JLamFvQjJ3WWpzMFhiMHI1MlBTcVhDUzhHbmh2anM0?=
 =?utf-8?B?WnlkeEc4aDZJUFdDdEx0Vm12b1F0Q25UakJ3c2NsL2tlOFJ0Q1lCVGMwSzJX?=
 =?utf-8?B?U3FuUjVMZXkyQWYzWC9udERsVkoxN3Z3RHN6N0lWNS9KTDlzaXZZcndDQXNo?=
 =?utf-8?B?UWNEZXdiUWptKzVPa0ZtMjJLQWJQcXErRDJVWS9BR0VjajlsVGhtdVUrMWY3?=
 =?utf-8?B?ZEpJWEhPaVl1ZkgzUmlUVW1VSnFud0szdjV4NFU3YlhBNWNOSmNYbXd0QjYw?=
 =?utf-8?B?Q3h3cjJWaUlydnh4bUpycXJoRDM1bllweXhFQzkwY0tLWS9PS0ZXN0cwK05y?=
 =?utf-8?B?dEFHVllxQWF1LzZxQTdSNnFBblpOTk5abldocWRKaElsdmlDNlMyVjRpYk1N?=
 =?utf-8?B?SGlseEM4YzQ1Tktuck5WQUtrVFhGYVJXTGM4R0JJSUpOV2kwdHZCWEI1UDRM?=
 =?utf-8?B?TGdzVXNRRXpqZ0psM3Nna0hmZnlKdU80OWRNbjhzdUhVZDc4bElhTlYxWVl5?=
 =?utf-8?B?bjBDT0M4a3gvbEhZWEMzZTNGeTVydDJ3UjVRa2R2QytXamIyOGhQbzdPcU9Y?=
 =?utf-8?B?OURUZmV6ZzJtM01mVWEvd1ViaERpaE1PdEVwZWJFSllsVjFTM3pPOVJ5NFB5?=
 =?utf-8?B?OXA5L093ZS92bzF4Q3ptRnBvTk5ZUDQxU1J0UGttaFJZazQyUEFZWE5nRzEr?=
 =?utf-8?B?T1cxRVhZaURjbVhaR09GYlFzMU9Ha20wTXlzNWFIQmxjU2VpdHlvUG9lWmZD?=
 =?utf-8?B?L1c5UkY4QkVpNFhTSDVieHZ3TGJxcVZJRENObm8xOUFsVWxLVkp3Y2RBMEt1?=
 =?utf-8?B?ZjFKT2ZyVXFOelRpajZ6QnlLVG8zWjlmd1ZqbnIzQXZQMnd0V3FTZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee200c1-d73f-4f06-6cec-08de5f1a5a36
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 09:39:52.2401 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lLwZR3uostCyICkgzYpzVcRb1J2tlwHRNyDRh0UgsOWgT0OmFfB0dNIlzjLIaqeR+beq50G9qm4SKSHtSsA32g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10384
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

There is no user of "gd", so drop DECLARE_GLOBAL_DATA_PTR.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/nxp/imx8mq_evk/spl.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/board/nxp/imx8mq_evk/spl.c b/board/nxp/imx8mq_evk/spl.c
index a346305c863..5116d806bb6 100644
--- a/board/nxp/imx8mq_evk/spl.c
+++ b/board/nxp/imx8mq_evk/spl.c
@@ -9,7 +9,6 @@
 #include <image.h>
 #include <init.h>
 #include <log.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <errno.h>
 #include <asm/io.h>
@@ -30,8 +29,6 @@
 #include <spl.h>
 #include "../common/pfuze.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 extern struct dram_timing_info dram_timing_b0;
 
 static void spl_dram_init(void)

-- 
2.51.0

