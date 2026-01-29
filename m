Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F67ED358EC
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 09:39:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15EB683B5E;
	Thu, 29 Jan 2026 10:39:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MigU2wyq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94D2883C61; Thu, 29 Jan 2026 10:39:32 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 010A683C61
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 10:39:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=je/EN2mQKex4XVR13KIHQ/FJDtdiUL7K/mePByU9NJfJLV07uV6egvkiUwP7QoUg6X3plJaMpgFIsm5zUuB8lbr8y52lWwffyOh4h2ELlXna2MmSTf118bFFVVJQNUcxSj/SM52k4a3yk72Qj2ULLJeGxxMo3iAmqW19kieFO3Ecaj8GroJI8J5axTYkbKOFkWcPTDIPIxX7mZK9ZCYLs9ZoLm6iSxegXXXviFOMF9tTi6O/VeOKwK0MUmd9Uo5WjOXAJwPX3fUVnFzRjRncRyPBqQnFd+swYmYluX+GuWiDmN09l2cIdWvcdEaVB2S2vZABvOlSD8KlFqUS3Q/wpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJxGhXVEA6Xt018ndzrhtjWt2sBD7tPa17Tt3omic6g=;
 b=RQaP0aJYeuHFh7qj0Z3SxFxXOFRxPt5QwIh6ij0i1hDTcUpqaN5zpPW35eO4sDXlZPVWb5k6RsORNfTWSRT/iC67mMmKvZXoaVs3A16tYFKgz5pm89LgqqsBxB3xUE0qngkQaHKJZp7J/UPj7rqLpNSnPQIEQ1l8K7l+S8mASolgPZ/wti/SJZ8ziGo8YWCLNgdqFubeaqazjCc7tSBSjZkyPXA+vbStXeN56eyGIaIItjk497fjbUfsQrjn+0J5tYiQA2uih5qoxbeMO8rhAYsU5P3442IWmVECYDg03h04toaiyEglTyT6kQ/c990VQr/iTZ6ioYnZqo639wpLmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJxGhXVEA6Xt018ndzrhtjWt2sBD7tPa17Tt3omic6g=;
 b=MigU2wyqyrtaQk1XAKlrkCwtuDpXlM0Raby3wkfbDlDQirM0v1IAi2Dv9uRlAk9quF6aCwM/mmAWT5RZzjQ9Q2JdAEl5d92NC4MbSlGPHX0PRLcStYYlT41GTCV41Yr5kXod4zfS3R0VzEoh0WL/dwL5nzuJaSNRPAVVJ7biqUS/azaQPe+edVFEB0/CN6x+rs+biR7Ls4/snGQ/XWOtpBm+pALwWSpSRuGK2E6qTfWZHW3SERdQTTBp+hIpGvzTtiafeU7AFC2njVsRJzBZ58xZVbfobGRz5wmpAir8VLxA6s7u1+q8Gdl6wNvKwm8jcW03MG9QEoW/ce7Pczu58g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10384.eurprd04.prod.outlook.com (2603:10a6:150:1dc::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.10; Thu, 29 Jan
 2026 09:39:28 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 09:39:28 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 29 Jan 2026 18:54:03 +0800
Subject: [PATCH v2 01/12] imx8mm_evk: Drop DECLARE_GLOBAL_DATA_PTR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260129-imx-clean-v2-v2-1-1245ad2c3a01@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5fc9a742-dce1-4908-048b-08de5f1a4b6f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?alp0bUlwcElwNEJiYmE5OU53TS9Cb0xDejBrbnhDR1k2OFJ1YjdHckdEdmw3?=
 =?utf-8?B?YTdBdVZzVnp0WWJIYVdpbUMzUU9zVWM5ajVnVUxPT05qTDNrQUpWc2dLM0xi?=
 =?utf-8?B?d21vbFBldXpUdFBpOER2Y0JhNmJWRXpvM0VDS2RVSDI4TmUzUHJHeEJqdElB?=
 =?utf-8?B?MDVZMS9lV283NEN6dGovZEgzajUvZDZhdWdDK0ZodWk4Qk5MQUFrT1o0UGhD?=
 =?utf-8?B?eUJmaEJoU3hNc0I4RFpTTDhFbjdTMUp5MWx0UDlLVndaYTk0NE1KQUdwRGVw?=
 =?utf-8?B?YzhRY0hRK2NFTUlYV3d4R3kzWHNVVzZjT29ZTDJrcURhUlhDcTloaGlYRS84?=
 =?utf-8?B?U0RGbXhPdW1LUHYvL2VJRmpjZ1hkb1RSZHU2cnlEODc4NGlhVkozeXh1d1B3?=
 =?utf-8?B?ZExrcEJXbExFOTRZVmZtU1dJVTFXTStSeUNReUZzZVIrc0tWTE5wTU1hNFRq?=
 =?utf-8?B?T24yNlFvcXdwM2xZVkV4K1RZa2M0ZVhuVmFJWWRndGhvT1UySHowcnphMUhR?=
 =?utf-8?B?RHNRK2lpb3NValNBOVFCdDdiQzR6d012WCtSSGNza3pUWFliZnZSZGRGSGFU?=
 =?utf-8?B?N1dSTmlZdHlIZ3p4TjYwUThUdmZyUCtDRXR4SFRHdXhNQlJiUUNyRnQ2OXl4?=
 =?utf-8?B?VkdjWjFTZnR0OWVDSzZ2UEcyK0lQUXRJdElYcE1ERUtQZ0E4ditJNG1VU3Mz?=
 =?utf-8?B?bStXRHN3YTRpeXVhWG44Qmd0bnFSMFdkTDV1WDBKWmFXcllCNzJ5NUg4cG45?=
 =?utf-8?B?Rmk2bElmdXYxdXdoVTJ1ZWJGNFYwKzhKMWM2T0EwOTdNMVV4c1ZJWFBNMzZ1?=
 =?utf-8?B?cVAvMnUwT1hQQSs1RDAyTFQ1aFFYYU5LWGVyRlAyTnZiOWo3Vi9yOWkrM2do?=
 =?utf-8?B?OEpVZGV3ajdnckY1NTd0MThPOUt0K3drVlFyZ0pBeW9vYXp2T2p2S2JvWjFR?=
 =?utf-8?B?VmtOc1QwbmNBMFdXYll3MHlnZmNMNnY4end2YVFaRSsyZ08rQ0xRL3czVmpS?=
 =?utf-8?B?NlhxTCsvdnZURTZ1TWJGZHhpWThOV2FiWG16cHZGcE9iREkzTGVFNXhnUmNz?=
 =?utf-8?B?emkxbzAxWXFTbjIvTkFMdHdSRnVkUXhFeGQ2TjQ1Slk4RkxEWFcrUU9INHlk?=
 =?utf-8?B?QnMzZzQvMm5iK3lWczlXSXU2SmluRkNhcFNRTkZtYUdsbU93RUJiSnpvNXFz?=
 =?utf-8?B?WCtzSDlFV3o0Zy9YT1M0MEE3ajFtTjhQemF5aHB0YWV5ZUQ2aWwvMnc3ejJ2?=
 =?utf-8?B?WUpWUE85UHNnbFlPSUhzVzJHdWdQSHA4QkYzTEw0Mm85N1RqNmZ4SWVBTHg4?=
 =?utf-8?B?RE1BVFpiRUdNVmJNRTVIZENYS2hEWWJpWDEzNG5rM0hITjFxS1c3STJpZmhF?=
 =?utf-8?B?VHJEa2hpUzlMcTIrNXdGdHQwSEtmTGthUTlhWUxpdzNXTDVQemhaaUVwdjk5?=
 =?utf-8?B?NVlBYS9NMkN1WWJvUm9oY1NjQXhlR213OGczN2p5WnhNejE3dUZzM1I3WnhS?=
 =?utf-8?B?bDdocWJqUWE1T0J6UVlFTFVhMlU0TW9sbEhpRkZ6WDlJeElmcVFKbVhCUjZ2?=
 =?utf-8?B?S0tmdVdocWlNVG9oaWd1YVROMEZaV0xjcVVxbjIrQnVvWmF4dWR6SjVzdlJn?=
 =?utf-8?B?czJUWVJsNmNCQUVzWWhQY2tiVFNkN0o3UHdBQUx5UGswZ3FVOUhlZ1lLNU10?=
 =?utf-8?B?SEFESHIrVkVSTm8xeGMzaysybExNR2ZzdTBQWEkyNjdhU2FFM2RUbHNvTGln?=
 =?utf-8?B?eWlvMWdxNjQxQWgwNG1Zd05aU1pxTHZVMmd2V3oreGhuZi81dCtUMVh0TDE3?=
 =?utf-8?B?Ymh6ZW00QUtpc3NqMnBzTXRya2FDeUxFU25zQ1dYUHcrbWlwZmlLcTZJUHMr?=
 =?utf-8?B?NnY3WlF3dkdROEZvc0F2Sm9uT0xaUlJ4ZndlSGZvVlhzQWxLTTE5UHByYVdQ?=
 =?utf-8?B?dzJvREFQMEpYTTFpZWdlYUtwU0NtUmoyb25IaTB4cTFzSmlNQ0VKbExEUjlY?=
 =?utf-8?B?cnBGVDBFSnZjY0pXejQ2Y1JIR3pXY0piOEhpQTZOcFpyaXZncFpRdWZYMkRU?=
 =?utf-8?B?ekx0dDB6bG1tMjFVcUpqTklDeXRNR2hQWlJrWWtmZFdyTkpOSGhSeE9TTkJ6?=
 =?utf-8?B?WWppWWxjcnUrUEVMdWZQaittVWZFV3lRWUp2Q3N6SDNIREZwS0NBQjJHbEZz?=
 =?utf-8?Q?X0JbojXvJT3ePsi9LAb7SCM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGFSK255emxCeGRreUhKNHYyUEg0dFFZaEtLTUROT0VIY2xmTlgzaU0wL3Vl?=
 =?utf-8?B?UURHaTdNdC9GOTdDUWQ3UHR2V1FtaHlYTEZ2M0hDODB4QUlkRS85bm1hMkwv?=
 =?utf-8?B?UE5BVkY1WXRzYktqL1pwcmNkdU52K2NZUjVxMzRMdWl5WGpEeGtGbTRHYWtF?=
 =?utf-8?B?OTJUZVJzNUFkckozZzdMd0JBbHVuQ1k3UmFnaS9ESXJGOHJTWWoyeEZkbXBu?=
 =?utf-8?B?UjJ2VFQxU01XVTY2SERRbTk1R2hmOHNiYVhsTzBOMS9JWHdUbXU2amt4cGhz?=
 =?utf-8?B?S2Z2anlrNGF1bVM4ZjJiNmVIclJOMXFEWTZEemplMmQ2TjVVR3Fub2NhYzE2?=
 =?utf-8?B?VDdaOWFlUm9reFhPODZJVnVsY25qKy93V0lNNDNCZnJEdVoydlBFRDR0RDdn?=
 =?utf-8?B?WUxKMC96N1BucXE1eHIwT1pVSDJCeUJpT0lWei8rOW5wTGQxMWMzSERCYSti?=
 =?utf-8?B?TnlSUFhuZzBLWVpUZkh6NGU5K0RjcElKUys2UEhYdXo5TitUWVhkaFAzS1FT?=
 =?utf-8?B?OHZCakxEWG5wTjMzSnkzR3JSZVJ5VE1GTldYZzZrZ1lLaFFFa1hXa3lxSVBZ?=
 =?utf-8?B?a01kRnJpZndaSHJvYjRQQlA0c0JsQUttSmJsZmh2eTdsbzlTTTAyKzQ0bmxs?=
 =?utf-8?B?Q1Z3MFM2cjJWWUprQjlUUmlhTlZuNWUxL1FzaU9ZdjJreENyM0ZzVzRsdjg2?=
 =?utf-8?B?dnQwSWpiNEUrV1JHQzRLWFZkSjNyeUI5TlQ5VmN1cUlTWGVBcEU1YkF5a1Yr?=
 =?utf-8?B?NkxrVWlDUEN0aXQ0cjA0K3diNysyK0tKNlZKdEZNbERRSUczQVBWSHpKdUg2?=
 =?utf-8?B?N2E4UHdSSG9EVTVhZnMxR1JkaTZVYmRFdWkvZENxUjV4Nldwc3RwcktBSExC?=
 =?utf-8?B?Qk9jSjRFMkF2V205YktFa0xKU3JkbHVUY3FtSDhpYlR2VFlmWDdpQy9UWDZa?=
 =?utf-8?B?S1VDVmlBbEhNcm4yMEpZcWtrMWZqZ0hYdHFPUmpIYVZ5THZxNjIxdTROUmlw?=
 =?utf-8?B?bmljZlNtSSs5UXlneTdpTENtTTM4a0h6dGgzT1YrTmkycTlnR0htM0toSyt6?=
 =?utf-8?B?dXlDeDBJd2NXOFZSQUNtRWozbHg2Wm9tTGttVWEwLy9DK1k0RkkxUVdna2tk?=
 =?utf-8?B?emtzcGJGekhTTGN2T0tZMVZHY1Jya3ZkSEdqekhhbHgzVU9WK2ZqenZZQ29H?=
 =?utf-8?B?V2Y2TlRnTHNiN09OTml4c2I3aFk0OEZxd0I1UjJyaVdMUkdQd2J6NUsxbmtq?=
 =?utf-8?B?WDFkaW1JRXdpNEZaRU9QYUg2dnE4TzhQUzR5eXR1OHlkTC9QVFltZTVFZFNP?=
 =?utf-8?B?VUlXWlI2T3k4TUcxbERxOTBqL3RYUWVWa2NFN2ZSSFdiUTZpR1B1ZzJTc2lI?=
 =?utf-8?B?YUgrVnVMcDFrZWlTTkVvR0xkQ0ZCdjBEY3lkNHd0WTR4TU9hTFFxdFQwRk1s?=
 =?utf-8?B?L1NvOW5xWUl1a0lLSG9EbkJLOXNnUkFyU2pLVGR2RHh2ZXdpbUNuaE42azNW?=
 =?utf-8?B?WmRXS1V6VVVmSnpSUDg2eUpsU25pVkpPUXNrVC9waVdzZnZwOGg2dkpUaStC?=
 =?utf-8?B?UThBVG9Ka1FNT3V3L0J6clhQRXNHeE9MNGtQMm9TbTFqR1RmTnFkT2VYY3pn?=
 =?utf-8?B?aVhBSTVUbVJDN0pEblorTDdXeTBlNVh4WlNjSWdQM1I5TFpXTVA4a0R0ZWd0?=
 =?utf-8?B?VEN2NzNEcWJRcG1hVE51VktEbnhlcUpHblU3VHZiMmZha2F1bnErbWJLSHhv?=
 =?utf-8?B?NFhJb1l5RWZiV0ZsQnNnQk82MEk5REdpVHAvSm9DMm1RdExIeXlMWnBMZkRF?=
 =?utf-8?B?QW9yTmVkOFdLSFM1U3NEK21rVnpybTFQbDl4QU82SnpQTXhFWjh6RjB6TUc0?=
 =?utf-8?B?SzR2WG84K1VCREVxS2ZOUzBZdjJ5Y08zV2tOTWFoRXBwL05haDV0UWkvejdD?=
 =?utf-8?B?Rkh6MmhWaXYrZUtVd0I5M2JLaUJ4OGg0Z21HTVROR0pqVnpmSkJhU0llV2pJ?=
 =?utf-8?B?OEN5T1ZOTGxNTDI3dDBNOGpjUllHc1c5QlljbWp5cC9UbzN2QTR3UkJkRmpp?=
 =?utf-8?B?eXFOSFdmRFFDYlMyTHdURHNvZkVjdmVxU1Y0cmxDcDAzTXdGNDRwZ2ZZdHYr?=
 =?utf-8?B?SWhCZEFzMms0T1pvOUNWTnhVd3FxL3Vhb0hPN3lpZk1acHhIZU80U1RURFJM?=
 =?utf-8?B?ZFBOUy9Tb3hXTTRCb1BDeXRQL1RxeXc2Z2FQOStSRDRmdEhaMUszWTAybkZM?=
 =?utf-8?B?cUZNWW5jM0VlL0h3NHVNblFZUEovVW80NXlZZjV4djNkT0VGaUtEN0hGQWhO?=
 =?utf-8?B?NFhtalJiMHlBMVBLRHNYZnZnc1I5TW8yZVV3cUl2T003ajVqa2t2Zz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc9a742-dce1-4908-048b-08de5f1a4b6f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 09:39:27.9099 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GKuL+C5f/ct2xD/DeP4IRh/Sn9GMLLq5snrcVHiIFFN2gk7E/qWJA14vCjsgMSWWZ3B3Yx8Mq6sdJ/CmznYYtg==
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
 board/nxp/imx8mm_evk/imx8mm_evk.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/board/nxp/imx8mm_evk/imx8mm_evk.c b/board/nxp/imx8mm_evk/imx8mm_evk.c
index ecc20768cb5..a8c1ef287e5 100644
--- a/board/nxp/imx8mm_evk/imx8mm_evk.c
+++ b/board/nxp/imx8mm_evk/imx8mm_evk.c
@@ -9,14 +9,11 @@
 #include <init.h>
 #include <miiphy.h>
 #include <netdev.h>
-#include <asm/global_data.h>
 
 #include <asm/arch/clock.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/io.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #if CONFIG_IS_ENABLED(EFI_HAVE_CAPSULE_SUPPORT)
 #define IMX_BOOT_IMAGE_GUID \
 	EFI_GUID(0xead2005e, 0x7780, 0x400b, 0x93, 0x48, \

-- 
2.51.0

