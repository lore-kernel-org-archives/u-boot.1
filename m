Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D3A1ECD9BE
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 03:11:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C37B83AA9;
	Fri,  6 Feb 2026 04:11:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="w+dOL/FT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA97F83015; Fri,  6 Feb 2026 04:11:10 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 047EB836D3
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 04:11:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IUTvFUIy6phJ6+xwlhISdPJZhkCr4rc8mwSxYZr3r4Tihjjx1et8ff40TMQYUQ52QxwYdtiLhmu2WSPxWZsN3EWYgoUfN/kE/IIh3Xi3z0bE6t5LSo95ky05LooGAEIYECSeeUnwbMsFEayaJhUQd68Dvx7pRnphoBz9kaSv1rmGPEvjBiaWmxQ0Gj7GxkHDz6y1FVs4HSOIsD2fHQhb9piR1HJf0tu4W5MhH81C2AaTjEmTPdoN/qBY3M0GI8lE8qz9LalIrdTC/5vs7H32wtWNe3bjCN8sMl+p8pXoqV6wQN9Fy4MEyQnwakMZxzOnPFZ+/TaXBI+QnGOcJoIpnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ep3qOc9oqi8K0Z622iPnF+ihFegVFL3PbC3OhHMyLmo=;
 b=jYPw1dhrp6RgwcYRfiLu/3zkgtLtt+yfI6YMCes7GDRe9ecluK8c7CA+naPhdsHWrGhtdmSbqgpjYmY1tZmLMES0sU68/+EbZsJojPqEVItNYkOK5FPG2LWD34KseWe+GS/8NTtseRhfNTR7LXm9m5GRsCNYx7+6rt9cy/rhwDhaHG4bRZa1mfGIXnuRlFHXqmRjoCuxL5NSkk+5jIDikYQqmJhCQdrv+b3UAWi8z/XEFuuDqjofe8KHx21xzgWzDRHCXJXiDCnqvU7SVAKikIbsVOh98mj6A1usO87PZ6twvKxThuZeCGo2hEGDduTg3/unRcHQkTPlark8i3zRMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ep3qOc9oqi8K0Z622iPnF+ihFegVFL3PbC3OhHMyLmo=;
 b=w+dOL/FTCnVGxrXTKBol+gN1CvI2x2aq8mB69C5jwIaH45BTS3gYjCfaGAFwxKjKHP0EL13SIO1XFKhSf6omaFA9+ymYgcIV+XvVrs55TP9NckWMQv7lA/SlG2rH9VqksJJ4N7/QezXGnpV++YzoYZ5T5rMFWk5SA/+4aquHjSGAR74Zbp+GaWIhYNsyxmiyHYipnBRUaVZA7aSFe8GWsYm24wq683dVTa8NUZRiu+/XHe4yw9ce6PyM7GVmWgSHlYuD5hTLp1p44t5D+jYSTplA8Q5ElvZHathoCKDrgvHAUUJR/puocWUbDZVEps9D3Y8/T+unwK6m1ZaYPsURVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS5PR04MB11419.eurprd04.prod.outlook.com (2603:10a6:20b:6c4::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Fri, 6 Feb
 2026 03:11:03 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 03:11:02 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 0/2] imx9[4,5]_evk: Drop init_uart_clk from board code
Date: Fri, 06 Feb 2026 12:25:41 +0800
Message-Id: <20260206-imx9-board-clean-uart-v1-0-3965b4e7f79d@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEVthWkC/x3MMQqAMAxA0atIZgNtB0WvIg6xjRrQKqmKIN7d4
 viG/x9IrMIJ2uIB5UuSbDHDlgX4meLEKCEbnHGVcaZCWe8Gh400oF+YIp6kB9YcyPp65GA95HZ
 XHuX+v13/vh9g9zQfZwAAAA==
X-Change-ID: 20260206-imx9-board-clean-uart-7eda1c7fed1c
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Alice Guo <alice.guo@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI1PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS5PR04MB11419:EE_
X-MS-Office365-Filtering-Correlation-Id: fc31aeca-0ee9-4f28-5338-08de652d5c22
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|19092799006|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UzMyajlJY20vb29NdjU0aWRxQ2o3SWNqc2llbmNyVWx6T1NOOEZLVWNIbThP?=
 =?utf-8?B?OUZEMTZiUEpmbGVFallaOXBHU21rdlVYKzZjNHZwcCtyLzU2OHV2dkQrVGp3?=
 =?utf-8?B?TGRlZlJwNmlKVmZDcmxOT0c3N3p2ajdlczVWSFIrUE9ibGRFWFVPR1o5WFVJ?=
 =?utf-8?B?cmFqZnN0cGJNTjBFRHU0U3htTytvU3o3Qks3NDUxa3NxR000K1RWMUJiWmZk?=
 =?utf-8?B?ZG1odlRHMTUyM21ERlhRdGZ0cDlnNW5BVXVNZGJuTEhYVUhxelpJL2xyMEpn?=
 =?utf-8?B?TDRkOVdKY1BpY2NVelhUL21ta2lKVmo1TE1QZys0TE5wb0Q3K1Q4UlNraExT?=
 =?utf-8?B?Y0cvamxqVUhNeTJjUGF5VFdrL2dCNXFNNXUwa285VTd0T29EMFduOFN2R0JP?=
 =?utf-8?B?b00xajFVZXZndjN3eTd1VitiK3AwYmJRbTZLSnlYZmgwOTJWVE96UExDeE0w?=
 =?utf-8?B?azJQQTBnUHZGNlZLc3I1amlrQVhvNEZqUXM3SE5VNWpkeWlnQlJBKy8wNnJM?=
 =?utf-8?B?ZnZPUEVPOVZtWEd2Z3NzbjM1eXRaVFlsdThrc3BFaUhWbnEwcWNWWU1SVit6?=
 =?utf-8?B?M2Z1R3B6MUxrU3lRSkthUlQzeDIzTlRHaERhYWFrYlN6WTJURDRWOCtRWWV6?=
 =?utf-8?B?MnpGV3hnR09ZM0lTMmJVYUVNS2JwTXBSSkJqWHRpTXNEQVNRSWlSdW9VUXgw?=
 =?utf-8?B?V0xzT1lNSjJpZENhNDNIMmNHMWkva0pHT3V2STNIdG9CRnZZRXBFZFYvUGpB?=
 =?utf-8?B?TDFXeVVhWldNMzNmT2oxVmZvVW1QeGNRNEczb0hWOUF0Mmx5dFpvbWxTRkFR?=
 =?utf-8?B?L0RkY0pBQnY2YTFTZUtKM2MyUDBJTFdOSHpVNnQ4WHF4M3NWUnNSanpTRDB3?=
 =?utf-8?B?dkR5ZmU0d3lJdVhGRjkreGNCL0ZibEF5elJIdXhZV1kwYlhXek9HbTFJKzFj?=
 =?utf-8?B?OEZZUEZwN0NLNjFJRFVGRGxzYmtIWGtCVHVpUHMzdTRXVUxQcVFhWWNtZ00x?=
 =?utf-8?B?ZmF5cGkvemlUQ0diUkJyQnVxZG9rQlA4ek16RUVodG9ySzFPcFFRYmhSMW8r?=
 =?utf-8?B?SzBmL1JsSkt5cmNtWktUa01FVkMybitoNmF0NDg3ZXQ2dllhOE0vSzVCQy9z?=
 =?utf-8?B?dy9zWGFLSEdqcjZ6K1k4blBjU1E4bkR2dnhXeUJtRW5HVzF6Q21wWTRZQ1lv?=
 =?utf-8?B?dzBVQU8rSEtId2trTmlPaTlEQ2twS0ErUy9tb3JOa3JxVXdocHNZcmgwSGRv?=
 =?utf-8?B?dUpzQ3RIRE1sOHdIOFdKRmhvY2cwY0pMMDJVNHhPcDU0YnRybzRCNUErTUl5?=
 =?utf-8?B?amNLNmhvOGtScCtOMVdJdXVmVnArdHJrL29Hc3RYUEF4Q2JxK0NZa2NoNHA4?=
 =?utf-8?B?eEdrdFUxWDZHNXBYeVRBSGdHSkgzdWNwS2F2ZFR5V1l3WVhkUHVCNTFQQWZo?=
 =?utf-8?B?OWpFMkRjTjlhR2hiWmVIVCt3bXplQlJtNCtmZTIyS0JCK1p4UGNmSFJIQVFO?=
 =?utf-8?B?eHJVckh5NnhNcy80V2xvNUpSUWExZWNlTXZyMjM4eUhZcU5aZDNRUENNUHpC?=
 =?utf-8?B?RGIrdktVZk1XdVZJVDBRd0xNb3EyL0cyM1VXcjRiZ3orMUVuQkpsVlB6ZGRZ?=
 =?utf-8?B?eEw4Qy96NFk5VkJZT3FmWlpIcGxEQjZYVi93dVVmUWN4UVBnemZTNHFDWk9r?=
 =?utf-8?B?eEQvMm0xSThVZHpXYnloSXJIMVRXUmp5OTdnN24xc1FQUEpRUFZNNWZHRnZT?=
 =?utf-8?B?dWlmbzNNUEFucUkwZmxzbkhRVWVBWTFMdXRjUk9mS01GQmw5QUhMSG9hTHRm?=
 =?utf-8?B?Q2FvOEx6RmdlZjlwT1l6aXFCZmVDZzk2aWVvWXJoNWMvS2E3aDZRcTg3QXE1?=
 =?utf-8?B?ZzMwcXlWb0lYNTJJZWlQY0tTOS9rcDhENVBIOC9pUjZlQkJ2Q0FMSEliN1pB?=
 =?utf-8?B?Tno2YTFzWGJmVjEwU3pISDFnT1ExL1FnRS9ZS1J2czNxOXdpZTJLWHdTVnF2?=
 =?utf-8?B?dmR0MEZqR3p0NkdYelFLUDVJVytnYjErd2tFaEpWVkd3ZzJqak95Z3dZZGp6?=
 =?utf-8?B?V3YvN0t6bkp4eVRSbWlZNmJ4ZnQvUGs0cEUydEcvMWRta1QxczdaWnlSZy9F?=
 =?utf-8?B?UFJDTVpMN3lUTm1nMWJzSmo0L0dJUUZyZTZPNmJ0dy94QmdHMEh4WjQyV1VB?=
 =?utf-8?Q?D61X6+jQryDbQjfpTPRBo8w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(19092799006)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEdQbUdhQmJvNE14TnVoMWF6N0xlVDdkaU4zK052d1pzQTJTYVFNc0FXVktJ?=
 =?utf-8?B?QjUrV3BacjAvSHQyYzVDcldEalpqTE05TGhsYURnK3B4RCtNcFFQbllMV050?=
 =?utf-8?B?KzROUXFES0lBWlI3VjVmSlFocnNtcHpPMmhmelBMUVQrWHB0N0QvdzVydmFp?=
 =?utf-8?B?aU9iN0p4SmdLdWRGMm84SmdtVUM4VTJtODZWZWJMYmRLQXYwdVd3K3JGOGl3?=
 =?utf-8?B?SkxsNzdYeWMwMTFRWmlRdEZ3cmRrbVdTdnRWdDJSZXVLQTFZWGRaOHhhelFk?=
 =?utf-8?B?Y2MzZ2RFQ1BWMVo1U0VqR3lEb2NSNm1HRXpjbGZpeTg0UWN1OGRVbjJtOXZR?=
 =?utf-8?B?QUIwMjIvcVFOcG91K1VvYkNJWW9MZHJwMTlRTFR2aXdxcXd0Y3MvYmFHVGtJ?=
 =?utf-8?B?RFFxWnZHZURmQmRwdzFJSmM5N00vTVFEV2VkeGtQRk92MFhIQy9vWDdDOStn?=
 =?utf-8?B?c1ExZmNoa2lNeFNhbXVMTDEvb1BFOFAwZVFXRDZiK1U2d2J3T3p4T25rUFlD?=
 =?utf-8?B?TGNJU25BY3N4L3NOOUovR1MvU0lrMDA0R2RmcHRwbjIrNkRvUC9zY01manE4?=
 =?utf-8?B?elR4d0ZZdnBvZDIrK2RlcE5wUVJXaXBZODdrOFpKbTRPNERScjlkVDVET3RE?=
 =?utf-8?B?SlhNT0ZOajZFSHBHa2RZUlBPNXhoSXJLaEhEVEpxQkZOMVl0bmFVeDdFUi84?=
 =?utf-8?B?MnJscmRpa3l0THpHYzJ5NWpOMjVBUXZVRUcrRG5pYlFNaEdUYzFoSUwxSGt5?=
 =?utf-8?B?M2ZIYmE2bU8wVDRIaXZHSTNtclR6ZUNtVHRhekk1MWR2eEJjMW9SdjRSalQ1?=
 =?utf-8?B?dEt6ZFBaaWJBM3FRZXlRMlB6RWdHMFpQTUhJWE40R2YraVFLc2JEVURKT3Aw?=
 =?utf-8?B?Z2NFTzN0dXFHeG1QZ0tJTityTFVPcFc3SjhQOHNDRFFobUFGQTRHOWU5WDky?=
 =?utf-8?B?VHFDK3dtUHk5WEVTS25lL01vWisvOGM1V0RQL3JIVUVxMDg4WXJxMElkN21w?=
 =?utf-8?B?T2hJVTd1S2xuTEk3MVlQN1IzMUJkMVI0K2xKVmd3TDNwZHNtWHJHang5ZTlF?=
 =?utf-8?B?N2JnNGJaTnJCSURTYTdFOU5vNjdGTnNGcG9uSENreVlHSnRQTmVjWXF1MGtn?=
 =?utf-8?B?eTYyV3hxR1JjQUVHY1A3QVZETnlnZ1A2L0RYUFBFcDlHR0FBd2xkakVSdjJT?=
 =?utf-8?B?ZU1CdFd3SG1ZL0NvK0VUVUZyMlZyeWJ3K3ZCMWR0RFErNm83ZFlaMTRkcHNy?=
 =?utf-8?B?OHZhRWYrLzdXQnRzaVVDN1dJOVdJei9sb2YyODQ1L25GZExEdTVBWmlaWGJT?=
 =?utf-8?B?Lzl5ZGRUdHNTcnA0N0tmYUtjV3pkNE5iTXJ3YTZ5emJETWc1eE1vdmNqdjAw?=
 =?utf-8?B?V1BtYi8zdXpmTUMrdjNQb1FucDNKOFdQY09tRlRBeFNGY2QxZnY0M0EvcUg4?=
 =?utf-8?B?Mlg1Y2JGTGtJeWhQYVM5SnNhSlJxL3lrSVlsR0IxRHVoV3lwcFVTcmNweU4x?=
 =?utf-8?B?aVJqYlZhekJvMFkyT09ZYkpFMWp4S0JXY3ptNG5IZ0tucURWVmtWd1ZzeGNz?=
 =?utf-8?B?ZG93ckJpNmV2UmdHMlY0N3YwRlVaNm5FUTFjMzRzYmNhek1SRGFjcVdCQ1Fx?=
 =?utf-8?B?Y0xPalBVY0wzbll4bVNtaXBheTBhNjV6Q0EzYW5ZNzBXR0tINkpaMWdUYWRh?=
 =?utf-8?B?czRveGFmQU9MV2Y2M1pZU0srbHY2MkthQm1jay8zbmtsU3lWem83ZURRZHFD?=
 =?utf-8?B?ZlMrOFkyNjRSbEZLMVdZL041WFQxY01UbTZJOWV1bUozV2lyYWdLNWFEV3Vr?=
 =?utf-8?B?S3hBYklEMHRxQTBWK3RqbmFHaUZEalA0TDJkVjJNNU9EbjJUWlRkYjdvTmFR?=
 =?utf-8?B?Q2hjNFlGYjBkLzIyazNkQjRtMzF4Z3k3WW5BQTBDSjlOU05vQUNaNTFVYm1j?=
 =?utf-8?B?TUZtSUcxL1RVTDZqalpxdWNqaHArTnhneHplSk5YYVR6WmdPdnltOFVJMmsx?=
 =?utf-8?B?RVNGa29IWnNNUEt6ODViZEhKNnI5ejJyNEZYNjNkUkZCUnZhTTNQNlJkaSts?=
 =?utf-8?B?bFJWbE9HalJFQ0dhZTNjUHBCVC8vQVoyUmR0c2RuampESHI4dnp1dkRWeVhy?=
 =?utf-8?B?aCtDNjllNWhnRWxnZTJhcVRSbVVoVVV0cDV1dk5rZEpyd1U5SGxVRW9SM1NY?=
 =?utf-8?B?R24zU3cvMjMrVTR6VUtSSTFIYmRqRVBUNVNPYUFnaCt5ODAyNm1NbWVVVUVw?=
 =?utf-8?B?MU0yM3lIbFJvc1NudEJ4cUNlc1dLdUViOG41dkNOdUJoK3Y0NUdZVzlBdW5Y?=
 =?utf-8?B?OFJjdTg2b0JOaE5CODBKM1J1MzQzU3VQVDB1MTJWVzl0WGlsKytrZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc31aeca-0ee9-4f28-5338-08de652d5c22
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 03:11:02.8468 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gJ0ikwWm7a1NqEzu44gUQcgwRnA1OvQV7NnsMncCHekxRDlX0UeCrKIv+iiLFkIZq4tvyj60+4K/aEcJPbgK8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB11419
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

The serial driver could enable the uart clk using clk_enable, there
is no need to call init_uart_clk in board_early_init_f.

The init_uart_clk() function is still kept, in case it is needed for
debug purpose.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (2):
      nxp: imx95_evk: Drop init_uart_clk
      nxp: imx94_evk: Drop init_uart_clk

 board/nxp/imx94_evk/imx94_evk.c | 1 -
 board/nxp/imx95_evk/imx95_evk.c | 3 ---
 2 files changed, 4 deletions(-)
---
base-commit: b5213bbfdcb1812be510427857827ee8becb9f8f
change-id: 20260206-imx9-board-clean-uart-7eda1c7fed1c

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

