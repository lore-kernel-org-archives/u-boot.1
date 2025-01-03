Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64769E77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 06:47:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D61D780196;
	Fri,  3 Jan 2025 07:46:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="b6KNnoJ9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FE86800D7; Fri,  3 Jan 2025 07:46:42 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::61f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1253780196
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 07:46:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T9I2ujvVzgZaOAI6YIMD7mZr15XyDGB1yG+H4aW44Qk/1KYmmety30fuu7byXlwuLLjkoLvRGvjeW4Zdf3ohC0oCBpxEiW6F6gtUBWXOOIIzx1sG/baC/9U8KSk3pm31QZ/tQLXChiZ6riNgT212sKpN9iApVOUbvoeIO/1J07fI69lR9SPNYLl+qCPEeuedXFLsVCQIuxbOt6MgdNN58DDJPyS0gzUAeQiPXl9ckDm4isT5OCqPb9R9I1R6zdqEPLOmXuHgPBeyz3B05qZURN1XS11oZ0KJzKaHealzHJ/ggXpeutyPUaCZ1lpqFMyALGq8o+0FSPKb3m5x/+VRqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Jr4pHDW9M5e9cS5+pWXSYZ1W5lOsbLbCkFDqpiEvGA=;
 b=cN+dN1FEFfmLXrPyFjmTxJcKDhQc9btGKAtXn9ZCWNreOn19HT4cWtKgge90v+zl8nKcpVUS4LMPfvv3qNEsNL4ZadfJJaLfWcUnBvIxcSKnSNTuG7CueSE+wCjvhwHokCi8hzc/DNJ6IiaFE/xjRVLYplxkvIyzyZNBfaWXlL2ijJsp/CmcWqn1biCUxi9xbWgcFEnJg48yn7IXfA+yJfQD0rpzI2vFF7XbPVn5mxHLYft6bWhvpULHxHzvP2fHc8/Sn/OEF5BzR+FqYcJQksW7FpAgIq23UwStdHXIlV1JP6Mb8qrSd6Im/jFnhMN/Rfl+zYQfyzvDeIo0aHicvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Jr4pHDW9M5e9cS5+pWXSYZ1W5lOsbLbCkFDqpiEvGA=;
 b=b6KNnoJ9tfF9eAHyP394Njb5YKUh7zDiNhWJ7KKCVFjCNgoI0gXGJYryDENSzdLGKH2b+yS8t/OZqxE1cvBsm+mMfKo+yvvy5m/N53RT3IqAb4XBmf63tZxPK0Rfd4+4Ybdsd6qJGQz3yaHghxav4q57jlzW3fzZ1i1GYMYYovrVI41/DQpfndUm6ZOmFWgV+bMyaKHL5746JuOitFyOqPF+9hNw0a1x6OjFTl7q03QGSYnYuadwYvPpcPyRToFm1+pepD80C5p5Iqv+XjIx7sKZMacwErM8jcEnD3wYXq/Ll8VWAQkF27N0Gaemul5TiWyaE7Rx0nF+SjaL00H/mA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI0PR04MB10903.eurprd04.prod.outlook.com (2603:10a6:800:265::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Fri, 3 Jan
 2025 06:46:34 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8314.012; Fri, 3 Jan 2025
 06:46:34 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Fri, 03 Jan 2025 14:45:46 +0800
Subject: [PATCH v3 11/17] imx9: scmi: soc: Override h_spl_load_read with
 trampoline buffer
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-imx95-v1-11-6744df5dc020@oss.nxp.com>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
In-Reply-To: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, marex@denx.de, tharvey@gateworks.com, 
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735886747; l=2986;
 i=alice.guo@oss.nxp.com; s=20250103; h=from:subject:message-id;
 bh=Vp9C1ZbiLDCQK+OswjUtbpSxXVakBvtmGgWWXJ1OIxQ=;
 b=yPL2JxhSKXAeKhocux6udSOBhSa9r8Wp/cx9AxZoCM6p0ajRFGvRkWxHIF56asocLiBsxJJkF
 t53otvKJ+isAAvz49iSWnNH/wQnYUVbEjCg+mmfww3oOHntXZKkBtar
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=6RXhk/KbIrPIkIaZWptZot1vwQyfwwp597Dp3Ydq+kA=
X-ClientProxiedBy: SI2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:194::19) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI0PR04MB10903:EE_
X-MS-Office365-Filtering-Correlation-Id: ed086120-5425-4a78-d848-08dd2bc25d3e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|1800799024|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RVJxeEEwWUFjcVN6SE9tUFVBelRVVHhHcTR4TmFoT1FyM1l3RHJZQys2aXhL?=
 =?utf-8?B?eGs4MUhpK3BtWEJXQzBtY2VhY1NmVHpyd0dlVkthdDd4end3TjlBZG5QSVA0?=
 =?utf-8?B?MWIrWUlUUnREMTN2WlVsMnU4S1FsVE1CMmFoVkVnclR3UDdHa3YxMWlndDNz?=
 =?utf-8?B?L1o3cll0eDlYTnVJQWlOTkhTZFZlOUJ5MnFnSTBsNEFtY1kzcXQvWmFVczBi?=
 =?utf-8?B?eG41M01IWGduQUFRQlNNbkYwaUE5RlZENXZ3dU9STWxwelE0ZnJDbGZIeVZW?=
 =?utf-8?B?MlJ6U3lzdDRyZ1JxRlVCejNMOFVELzUvRi9Bb0RYZUh0V3VaSmt1ZjF1THlm?=
 =?utf-8?B?amIrK0o3c215TitGMk1Oc09UTyt2cjN4WmdjbEhTNUZBWTliU0tvcXQ1VU1a?=
 =?utf-8?B?UW5kN2VhLzZqbG5NbFc4S2V2aXhnVVVFWUFrOXdLUVVMdTQrL0NjS2M2V25x?=
 =?utf-8?B?NWhrQ05Rd1BjT01QcFJ3QUk2bU5udDFIMkJOSmxVQVMxajh3UnlQaUZGQmF1?=
 =?utf-8?B?UUJMRjU2SzN6a0ZzZ2VLNHUxeklBYU9yQnpFZFpVbmc0RU5veHJwWHlmRkNp?=
 =?utf-8?B?R2hVMWszUFZZdmlaeDFLcmZSckNHSFpMSU5oYlpUb2JiZS9ZRlZXb3N5a0Ju?=
 =?utf-8?B?b3RnWEl6WTNWWTVPeDk4b2JvbTVuUG1hOU1kc3Fwek1EQi9DVTNOK2E4T3FG?=
 =?utf-8?B?VXpDWkYzL0YyMEpoWStOS21QTnJvZ1RDMGpsTDJnZzRvbWZ4RnFBMG5zLzFv?=
 =?utf-8?B?UUVqOTVHOE5Bajh6Skk5MVE4WFpmUUtnbU9PN1NWdFd3YVBoaTZDOTY4KytB?=
 =?utf-8?B?MkNORkVCSkYyRlFNUWlCYnlWYTZERTg3TThXNno2UGhqUk9EWmpHRFNpUXVq?=
 =?utf-8?B?R2gwamVEdmlpT2FNNEVXblo2ZURvRkRqK3BIekNrblRGZGV0NU10L0RBejdV?=
 =?utf-8?B?eHdPRXpQQ0Z3QUk1S1U4TjcwaFgrZjI5R0ltN1c5cHpsOWFTY2JQRXFvT1V0?=
 =?utf-8?B?Y1dDTlFDTW5wbGdpNWhsT2FjUUF1TCswOWo0OTlCMW4xZ2p0SFpTODUzZmFl?=
 =?utf-8?B?ekxEVUtMZGwrRTVXb1oyaDdEdEI5TkJ4WXhtS2ZQNzd2emdDbG1NVm9lQkNW?=
 =?utf-8?B?aUhTRE5NN0dWbis2NUZLUE44UVUyU2o0VlZYTWw5ZnZtZlI2ai80UjhJdnhp?=
 =?utf-8?B?S0NaSzNobWxucC84b1NnRWNKa0NxeGpIMm1IbGRpTjFwZFJDSzRvSW1ZS2lN?=
 =?utf-8?B?VVhCQWRRMTFBNDJXMVZHY09JOE4wVkdkTEF2QkgxT3FVT242TFE0QlJqOUcr?=
 =?utf-8?B?NjN1bTNsUjl4aWE1K2RjNHZBK210WVhHSXVRVUp6R2JXR3R0ajA1YkY0Z3pY?=
 =?utf-8?B?WDZUVTBlR0RpK0F0S3ByZ3czbU40ZkN2ME1EK3pDYkJ6aUduYmRoKzQ3cS93?=
 =?utf-8?B?ZTJmT3IzQmNBYnlkVWprOCtOczY0Z1NvWE1pb1M3MHZIalAvNXArUVd2L1Vr?=
 =?utf-8?B?Mi9UenphTVlFWXhnZUF0d3Vta1o0WDZPUDlLUThYSjlkYXZCb2pnbUdhRGJE?=
 =?utf-8?B?aHNwSkFzS2JEblNlUmFEeVZZWTQrN0JSa1RwK3FQOVhUdFFnb2p4Uzg2MmF1?=
 =?utf-8?B?RzFnN0hVV3hTQjFDeCtyU2VrcDNwS3Q4dGM0T3ZnYmdueEZCMlFqNkF2b2lJ?=
 =?utf-8?B?K3ZRSElYeVdicG1sL0pwSHJhVUhSc2FMYkwwNys2K1d4cmtCbEkxVXJ6elZj?=
 =?utf-8?B?VkRwRFFwUnp6QjI2KzFCaVhFcVZNcVZjVHp1QVJCTHhwbVNUbXJ1YXRqYXdh?=
 =?utf-8?B?eU42VGV6Wk1lN1ZuQmlPbEw3Ti9jdTZ4SHJ1bUE2Q1k0VXoyTE1jS0MzbEVr?=
 =?utf-8?B?K3FMRWRnZmc3R1FFWmEzUDYyYURYb3huMFYyZ1kxOHRpWUg4amJickprSU56?=
 =?utf-8?Q?7V1BJBQaKSp9oCpubPrGfJcwGuYiFI0W?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(1800799024)(376014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUhXcEJOeXJFNGIvdEVuYmV6UVpaT1FSbFVYT0drcm1BVmtjeXIwWjVoT1Rq?=
 =?utf-8?B?Q0t2eS9zaU1LODMrcDFKc1RLdE5ldXJhMUIwRExteHZLa3FFUkRrSXNzeWtH?=
 =?utf-8?B?bXRqeG0vdW9id2NoSi8weDZNQkt1Z2IreGJDeDJlRG9UMWZwcnc5Yi9aejd3?=
 =?utf-8?B?bUZuRmlyTTJ0Ri9nRkR4c0txNVdqbzlmajNCbDBBTmV1TWsvVURnUnhVZk5I?=
 =?utf-8?B?MXQvOFIzaW90M2xiMGlpLzc0dFJkWDJqSXFMYWM0cHBCdHluS2NGZ2d2cHE5?=
 =?utf-8?B?QkZKemlZTjZMT1pkSFlFOTVwdkduUmRnMVBMelVBWDRZNVEyeHRqYXcvdXdj?=
 =?utf-8?B?bERIbXYvRGJRUno0bnkwTjFVVE5BdFEwSkRHVEpuUHJ2NnFwbGx1c21vb1Jz?=
 =?utf-8?B?Rks2ZnUrL3Z6UytoejlxNzJJL2I4ZnlpczlaazUrMTdDUllOWG9ReCswT1ZF?=
 =?utf-8?B?ajlEdkpQOFlXK3dBdytXWFlCWGROY3dmUzBrRk9pNXBVS0xPSm9tc0VLQ2gr?=
 =?utf-8?B?UWZGT2R6QUF4bTk0ZVV4ZHo0WnNuS3VyNmdPRkpOVDBQQ1JDa2V5eG8xUXRW?=
 =?utf-8?B?S2dXQ2h4WHFQenA0UDBzaWppcm5ESVF4Q1BrSEd4Nzg1U3pOMm1pcUVRUWxE?=
 =?utf-8?B?dXpGWFdXRlVhcjNNWkRYbFg2YnFPTDc0MzNZejM0dXhkUlUwMDFxazlPQnMz?=
 =?utf-8?B?Z0xIZ2owZFdsZ3NMZkdtSTZFTTc2dkYrS3ppdTVsODcySmdteFNTM2p1VTdj?=
 =?utf-8?B?em9KYWRhMTJ0R2VNd3FEdktNUTNSZXFET1lmcVhvcTlSODFlYUtLQVJ4NTFJ?=
 =?utf-8?B?aDhFV1JmZ2wrbklvV2htUnhiMWtXMTVacE1aMnlIKzAzenZuSllmZStqQ25o?=
 =?utf-8?B?Y0FrMjNDNkxZTFFUS0pWRjVnZUQ5ZUpBZklaWElXYlNlSGlEcjZuUXd5ODZT?=
 =?utf-8?B?UmdJTVQxbXd2bW1zOFdrcjFPWHJscFJneUdENlZwU0hpRE1iRThucHhrenNU?=
 =?utf-8?B?Nkh1anV0Q05qck9kUEtvODh6TlhOZnBZdUFCcWgwMWkwVmhLeWhlTEpXT1Fs?=
 =?utf-8?B?YXhPQkF2bzk5ZHdYelpkRm93QkJJeHFIakxyODlGY0dPdm9kOVZxQWFHUU1I?=
 =?utf-8?B?MXN4Zi9ORXROWVB0YzNobnlaaW1uczFBTTNjWVhkZ1hsSHJWTmx2aU5TTGJM?=
 =?utf-8?B?bTN0aXlhcVZNdVBrTUt1ZzJaOTg2dkdhb2hvV3NLblhNbXVvR2ZwSTJqcHVD?=
 =?utf-8?B?RjV1WndOKy80eFAyTDVIUXV0SGhrSXRSbStPWmFGM0tnWTZsaVdiNzdJYlJP?=
 =?utf-8?B?Tjh4M0FSK0xFUzFBelZRSDlDLzJCUmdXQnd4ZHJJUXh2UE5ZV0V2bFFrUXJp?=
 =?utf-8?B?bEhkNnZSMkhHL0M2dEJ6YkVCR2hlellEcEtsUzFDYzF1blBuYWxaNE82MEMy?=
 =?utf-8?B?TVpKd2JKL2pzNlpGYndSQWQ1MFNFcTFldGd3d0VLM1JBbVJCb1lndGRZL0Va?=
 =?utf-8?B?d2ZMeDBSTkt5UlpzRUlweElwS2ZLQkFTZUVxTkRseWd1WE8rTXMxQTBGNHU0?=
 =?utf-8?B?Sy9BbUl3ZDd1L214aGY3TG9UaStOTHNnZGtNN3htSlA1M2ljSHZONllLOGly?=
 =?utf-8?B?SWpjdElGL09hUkRNb2d6cFc0Qy9tMWswbTlUT1RJNktuUDFyeGNZcjNpTFAy?=
 =?utf-8?B?RVcydE5tdXkzVnhNWEJGa2FIWE5yNTU1bHhMNzk1dDhncEV5T2YzOUh1S2pI?=
 =?utf-8?B?QkdxNlZBR2R6bHowVS9kSVZ0TkdkZTAra1R4SGRvR2xiRUY0SWQ5V2NYQWFv?=
 =?utf-8?B?WjhhLzliWHZ3QklyNnF3UW9ETkh1RkJ2VlNQcjhmNzZ2QzdVSTNWWkxLNGJJ?=
 =?utf-8?B?L1paQ1Juc2k5UEl3VHFKV3JzdWtGQkx5K0RpRk4xVG5TQ2xxd3F5cnlWWnhw?=
 =?utf-8?B?VmUxWUJ0NUd5N1hPY2tNV2Jjc0s4NnRqU3RZOEdtRy9VNlRsVzZQUmpoOFVi?=
 =?utf-8?B?SFRoQVZ6VWFTUVZ1VU5KaGFSZDg5dmxIeFBseDJSQy9ITTl3WXE5VE9GK2Fv?=
 =?utf-8?B?TnY2TW8zOWk2OFM5T3cvMzc0S1dTN2gxSUZXb0Q3dzFWVzR4ZGFYZEpXMGF0?=
 =?utf-8?Q?H7UdPn3gad9s0jUfuiVN99Hun?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed086120-5425-4a78-d848-08dd2bc25d3e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 06:46:34.5326 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JyF5prylTktnwJ+d4IQLTV4AZ3AmoJyGaqgEIB2vGoopoXqE9illRIu7ebJdhB34zqt3VCMhJ5ex3yEOnY2A/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10903
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

From: Ye Li <ye.li@nxp.com>

When SPL loading image to secure region, for example, ATF and tee to
DDR secure region. Because the USDHC controller is non-secure master,
it can't access this region and will cause loading issue.

So override h_spl_load_read to use a trampoline buffer in nonsecure
region, then use CPU to copy the image from trampoline buffer to
destination secure region.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/scmi/soc.c | 40 +++++++++++++++++++++++++++++++++++++++
 common/spl/spl_mmc.c              |  2 +-
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index fefb1a6f4ca58722a5d93c39e4f6a7aaf85aa177..8a7df24afecc1d6d77b7162be639b56af95fd975 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -41,6 +41,8 @@
 #include <scmi_agent.h>
 #include <scmi_protocols.h>
 #endif
+#include <spl.h>
+#include <mmc.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -830,3 +832,41 @@ enum boot_device get_boot_device(void)
 	return boot_dev;
 }
 #endif
+
+ulong h_spl_load_read(struct spl_load_info *load, ulong off,
+		      ulong size, void *buf)
+{
+	struct blk_desc *bd = load->priv;
+	lbaint_t sector = off >> bd->log2blksz;
+	lbaint_t count = size >> bd->log2blksz;
+	ulong trampoline_sz = SZ_16M;
+	void *trampoline = (void *)((ulong)CFG_SYS_SDRAM_BASE + PHYS_SDRAM_SIZE - trampoline_sz);
+	ulong ns_ddr_end = CFG_SYS_SDRAM_BASE + PHYS_SDRAM_SIZE;
+	ulong read_count, trampoline_cnt = trampoline_sz >> bd->log2blksz, actual, total;
+
+#ifdef PHYS_SDRAM_2_SIZE
+	ns_ddr_end += PHYS_SDRAM_2_SIZE;
+#endif
+
+	/* Check if the buf is in non-secure world, otherwise copy from trampoline */
+	if ((ulong)buf < CFG_SYS_SDRAM_BASE || (ulong)buf + (count * sector) > ns_ddr_end) {
+		total = 0;
+		while (count) {
+			read_count = trampoline_cnt > count ? count : trampoline_cnt;
+			actual = blk_dread(bd, sector, read_count, trampoline);
+			if (actual != read_count) {
+				printf("Error in blk_dread, %lu, %lu\n", read_count, actual);
+				return 0;
+			}
+			memcpy(buf, trampoline, actual * 512);
+			buf += actual * 512;
+			sector += actual;
+			total += actual;
+			count -= actual;
+		}
+
+		return total << bd->log2blksz;
+	}
+
+	return blk_dread(bd, sector, count, buf) << bd->log2blksz;
+}
diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
index fe4230170a039c0ca18b7230105997ed824f9f54..9b3de231bf4b94278e4ec376325ae5b51fa6e645 100644
--- a/common/spl/spl_mmc.c
+++ b/common/spl/spl_mmc.c
@@ -17,7 +17,7 @@
 #include <image.h>
 #include <imx_container.h>
 
-static ulong h_spl_load_read(struct spl_load_info *load, ulong off,
+ulong __weak h_spl_load_read(struct spl_load_info *load, ulong off,
 			     ulong size, void *buf)
 {
 	struct blk_desc *bd = load->priv;

-- 
2.34.1

