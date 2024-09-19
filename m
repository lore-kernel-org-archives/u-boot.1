Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D86B5CDD563
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 00:17:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E132489081;
	Thu, 19 Sep 2024 02:15:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DHWVG9fs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B802689079; Thu, 19 Sep 2024 02:15:17 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE80B89068
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 02:15:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gnEqhU+Aw5RWX8QCAOHjZJjBZdwCGfOp0LTytU8cGjZmxIPAj0xDSHZo8TGSIAcOwAQDmvD+5a3t6WJiUcDd6J94l37WmSGm0Bt/lLbt5iZMgAv7y3FyqdlMgICw7hdfEh9qa4g2nSPMykfR+lB90f11rwUJuDxqy3mj+l7fsAEY+txm536aA08x5xh1rYyBPGxMdBPGLDiQEwtSyZ6Eh06HBmqApCu+yD0V7GmD8yHIMoZzFFCZOQqiIss3wauvxmYBZSMLeXesEztNvSvzH5MoCyhNLPzu8HYXT1d0pWCOT59Nvw3UovW+DKO70vlnyuw/cLvcBQzutw5Yy/pKyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tp2Ra7qczva92I3bSwHQd0Wgcr9w6/nAO+rmjAiLTkg=;
 b=C0tp522gtPYBfVveHGjW0Ts2j+UHHutPiVWUAOGhiSphF7MD1eGxGiBxrNVPEKYbO8yX0Ft91q7mLiryVMbZewEudyWK0aIg9gsquw6+GI0IYnpKEV76QTTtVJBE+ziJaczy0JQQO5l+0nGSiQYUJLT8I7Xmw1Icjk5DvRhtx6GnPJfrXmXPl/0qlUn/Ys+2SQWiR/BkLCuA8aFL2ouCv29qSGXQihJkz2kMgTGNBFo6Hxy5CeAPw/nYSuGBYxKTiAJkrpT9GXtZkUZCZDdlAzTGTcfO7mkuxudrj10P/H7tFDWmuJr/nBypuvl5ntv17Z1IKoNqjkph+eNjqhkWog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tp2Ra7qczva92I3bSwHQd0Wgcr9w6/nAO+rmjAiLTkg=;
 b=DHWVG9fsSXVa1/u4Egg7op+VMOC8wIs7K/o5PwdCSZWrC5D3ln6HjERPob1RzwErpfDaeV1cJxZbjWmllG7oGm8A/W70ZVLXRABYKrRXkw7GlLe/iWVHIP4FHkAn7k1icV7pg5N/ntJvJeBYnQdunTsPg+Iqb76EtPT+MyK4e3n1Ox28l5fvgkGe8l6rpI0GK/ouc91gss3xIzeYkd86DJQ2J/FumgqcRypntKkg3XrRjWedUyo2eeXpBCvJGzfNebV7jDmYPmfi5RSvp4TzRB9Z7b6WRv1i9yTTILtXYaWI6uqwkvRXPCuBzxJfukjFlhwMi2bVy/KJ2wZVGYYS5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB7872.eurprd04.prod.outlook.com (2603:10a6:102:ce::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 00:15:12 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 00:15:12 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 19 Sep 2024 09:18:13 +0800
Subject: [PATCH v2 14/21] imx9: soc: Disable cpu1 for variants that only
 has one A55 core
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-imx9-update-v2-14-0d798d9e08ad@nxp.com>
References: <20240919-imx9-update-v2-0-0d798d9e08ad@nxp.com>
In-Reply-To: <20240919-imx9-update-v2-0-0d798d9e08ad@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SG2PR03CA0130.apcprd03.prod.outlook.com
 (2603:1096:4:91::34) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB7872:EE_
X-MS-Office365-Filtering-Correlation-Id: 515522e1-cd0e-46d7-c2c0-08dcd8402102
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K3FZM28xbDljZEd0Q24rYjlaWWg0V3NZcWY5L2o0UzhNL1d4b1UxYk40aVZG?=
 =?utf-8?B?a1JLT3R5VTRrMFhEOUNCVmRwam0xRUZSQUFsZVFoc1hKalJNV1ZNRFYwejJL?=
 =?utf-8?B?YWE4WUpiUDJKZCtSOHpPT2RjMmZyQlR4ejcxVVRBN2NvMXNlZTNJVDBkWjZ3?=
 =?utf-8?B?MGtKcnNmT1dTVGhMallzNU5RSmlpT0ZkMUtLU1dJTitWNVp1RDNyelRPK2pN?=
 =?utf-8?B?Y2htcFRFSnhiQkR2cC9MV3ZuNmY3Z0ZTUithbXBOcjZUaFFJbmZLK21lN1FR?=
 =?utf-8?B?cXEzTjBEb210MmhGMDhiNUNvZ2VEUlRtN0NuY0ZLMFYyemVidnBERFUyOHFC?=
 =?utf-8?B?WWhLSkFoZCtGUW0xa0I0cVhRZGsxakdudjBCeDVLZWhEREVWRnlOdEJJM0gy?=
 =?utf-8?B?dG9UakRuQ0JNV0UzcjVmK0kxU3BTSS9YYUpNVE9lbXlPcWtVWHRZQVd0ZTUw?=
 =?utf-8?B?M1hLS1VIUHR3bDBnOEZqdDE1dTFPVHpNRHdsWGh1cmRCdTJrVTdjQ0dZRVg4?=
 =?utf-8?B?aXdwSVRScjZKbXdtYkxPRmZNenV0azE4dFZkeUxaRnJXWWV2cVo2WWczZXBv?=
 =?utf-8?B?NVBsRGJYbHBzOWg4UWpQelRYS2x0bHhaejgxN2RacnI0WFpHT1d4U2hFM1dW?=
 =?utf-8?B?T1ZtRzR6clFDMllGV2ZVci9TM1BNWlppM0VhVUlReEhIMVlwZ3RPamQvN1I1?=
 =?utf-8?B?U2xWcXNQRDg4MDhQRzczYzBVKzRsYlluWGsxTXd1dGxYUlErSnhBeEZmTDF2?=
 =?utf-8?B?UHJqS3E3YzZLM1V0RVp2TmJ4c3FZK25BUHJPangvZllpR253TVNEbXBnQyts?=
 =?utf-8?B?SkVtbXA0aGRnRTY3RjUzWC9oVktOckdGSUFDUHIvVTdVbHkvdHJlU04zZTdD?=
 =?utf-8?B?d2QxQ3BwWEQ4M0hXRHZodUluUEVsYUE2eUZUYU1obGdEeXJMdzJBcHFKTnBF?=
 =?utf-8?B?aFJaRU94aGtoOS9CVGRDV2R3U2h4MzVzZ2thVHJOVWVXdEdUU2k1N3F3dDcw?=
 =?utf-8?B?S2c4K0pGOW0wWFhNTlgyT3A2bW1YR1lrbjhJQ2ZYRmJqcEhnVUUrKzhUMThy?=
 =?utf-8?B?a0poMGc4TXJpSWcwTHlEMTc3NkZzRGIxSnRZNjBzUU4vakJqYW4xTFlpUXZy?=
 =?utf-8?B?REwzcUtlNU9jMEtLQlI0Qk5NcnhHdldERTIrVkhjSDJEclpJelZFKy90ZFpr?=
 =?utf-8?B?a3dnNk5sQW5BNDlEU2hhV05BN1k0WnN5di9qUkJLQzZpeXF4V0owbUpMTnV5?=
 =?utf-8?B?WlNnTFdoWW0yd3pSYk1OYW1HM3d4Z3hlbnk4Y1ZhTjl0alFxTVhUZG04WDI1?=
 =?utf-8?B?TEJqeDl2L094b1BsK20wVmhjK05JZ2dBVlB6Qk4vbHNPblU5c0RJd2NQU2dm?=
 =?utf-8?B?UXlqNHkzVXN2M3E0NVo0RGhRc0ZaRHpDb3hBdFA5Rm4xb2d1MUpVZ2d2R0I5?=
 =?utf-8?B?M2tuOWhjbWFaejFGUHV1QVRaczVudkpLTFNMc1VYc0dnZDdwL1dMdkR4VEdp?=
 =?utf-8?B?K1FDMFozZEsycmsxUlBCdUI1RWlSZE14RUFVNW40VWJHdWlSeFQ2MFpFcGN2?=
 =?utf-8?B?Z3lyTzluNXNRUWVhYkFDdVY2dzYrVFRsdnY4cDZ2T01DUUcwMk5KYnd4Nis0?=
 =?utf-8?B?bFYyZlh2S1hCcXJNY1o0c2FyRG9haXVUd1dnMWZmRjBnMzBBOHRKZi94d2lh?=
 =?utf-8?B?aXkyZ1lUTEtDUWJVdC85K21MZ2FZTldEN0hsN0hma1hITTU0Kzh6ZDQ1MGt2?=
 =?utf-8?B?S2hBTVJXMzZxcktwOCtlL0x0eHlDUlRCc1RRR1JzY0liSVQ5cXNwVFAvWDVO?=
 =?utf-8?B?TjRnaU4yRmx4cmladlQ0eUdYRE9CUWRubGNqRlREY0pkZENlZkJYdGtHVFdD?=
 =?utf-8?B?M0NjRGhqTk1NWDNNMzMzTHU4NG5UcXlROXIxK1hiZzU5QWc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlF2cVQvWExyUXgzcHJqSHZ3UURCd1c2QVVHQmlENVhyYXFNdzRyWFJ6bWU0?=
 =?utf-8?B?bzFPYXA3SEh2Q0pwMU51Q2pnWHZycElsN0lTcXVaQzNUc0czaWU3TnlJQzkv?=
 =?utf-8?B?V04zOE1xZERTa0hSYTcxVFE4R0dONEJITklSSzlqSVV5bHlkVmpQazh6bnVI?=
 =?utf-8?B?QS9HS1AzUlVuakFQNzV3a1o4M1g2SmdwcEJwQ3RFYkttRXRtNkRkVWFXMlAy?=
 =?utf-8?B?UG1lSVdqcW93MjJkWUc2eWMrOTFxcjVzL1I5OHhvSGVITEhMZk03VGNyQ0Q2?=
 =?utf-8?B?cHRqWCtEUVpnZ3poeXNoN3lzTmlBekIvZjlxbnA3ckF5T1BVWTZ4VzNycWY3?=
 =?utf-8?B?U0R5T3ptd2RRYTJUajZCRGxheTRNN3Izb3FrcnFnTDA4WlI1QTlKVFFWbVky?=
 =?utf-8?B?bjBFV0VGZGU3L01BSEtDUHhyaDFHUHNwU0xsaUpIRTRyUjFiaVhWdkh0Nito?=
 =?utf-8?B?UnJ2bU5oMGVvbWJOZWovcmVwSktiL25HaURZaWU3NVNlVzBHWlAwU1dtNHBF?=
 =?utf-8?B?bzJVRWlqNWtUL2t5dWtLSFNUdjl5QndpMWJvcXZIdFl5NTBNaVI4ZG9lUC8v?=
 =?utf-8?B?R3lHa1BmclFxRjhJVVlOMFltQ3VyNWpCZU1kQi9UbEU4blluOFh6OUt5aW5C?=
 =?utf-8?B?U1dwa2lNdm8xS2Q3M3ppdzcwZE9jcUhUYVpZRllYb1REQi83RUVhL0llM3gy?=
 =?utf-8?B?ZHluS1JkZTVpdm50L0tkYnEvZ2gydk1lSkttZnVwakJ5NkZEdUVjLzlQWDYr?=
 =?utf-8?B?THFwL3kxRGNrbkI2R25saTRQSG4yYzNudzJZcWhqemdFQWI3V1ZQaVA2OGt0?=
 =?utf-8?B?Y1I5TUxXb0w2TTdLbStXVEdiRUFuN05DYTF0UmpxVm92ZmZKakRiVFJ0V1dN?=
 =?utf-8?B?Q0JnSmNRSGZDTlJOMkdJSXJtNXJJOEM2Qi9Hb0s0UTQ5SWtjK3ZQR2RqNk5R?=
 =?utf-8?B?YVd6YVhNMVpndjJnMy9XRFdBMi9qemxYaGFsWGVxbHltcUdZbXN5cEYwRDBU?=
 =?utf-8?B?VEp6bGE3Znhob0ZWaHkzVk9XSlRMbFFmNUczeG4reitmMXUraThseEZIMWhu?=
 =?utf-8?B?QW1XbDFvaFRiR1RRdFloaVZhTmJPWE1WN1pNR1BydmM0bVA3U0hHa2JWTFpa?=
 =?utf-8?B?b2JlMytSeTdIb01BRVpTWE1uYS9CVjdneVlTSG0vUFluZEFVOWtPUTZWSDJy?=
 =?utf-8?B?UDFrSmdmcVhxaHppV3NTL2xuOGN6Qk1wQzN4bVQxMFc2bThHanFZcHdiOGM0?=
 =?utf-8?B?Rzgzd09JUVNUWHYydm1BYWpBS3laaDVzUVlQOVBMOXZqWE1lQk1oTlNYSyt4?=
 =?utf-8?B?Y0FVSVlic0ZxNjkraEZ6MGhuU3hmTEpCeG1EMFZoU3pzMkdHdmdyYzRnVEpW?=
 =?utf-8?B?eDdPRURNMHoxMVNVYk5iLzIvZ2p2bUZQMmtiVy9FUEdGSDJtQWNvTWJQZmNr?=
 =?utf-8?B?VU0wR0Y1V1krR2hYNlBtRFJwYmJrL3hHWDFDUml0a09haEVRRCt2aENCRlpk?=
 =?utf-8?B?Nm1ETkRsMm1qSzNsZ1l6REdvbk5XbFlWU1oySEZYM2lUOUFqZjdFRU85YVFZ?=
 =?utf-8?B?VWtwS2pxWFkwMFNnRWdnL3RFTGwwMmVMajlwTFJidVVlL215My9rSnV0N1lE?=
 =?utf-8?B?TGFsV0lJVkxxcWYwRjVXbzBMS2lSSVA5c1hpcDlUTFV5d3JDSk9Zam5JZzhs?=
 =?utf-8?B?ZWQ4MkNSRnhWWTNwcjRONjJsZUJ6c0x5Y1ZDYzFuV3NQTG1rdzRtQVRZZkpS?=
 =?utf-8?B?ZG5RZmNzU3ltNTFBcmxvRUN5UmpGOVdqb2diOHp2Qi9FSFlFZjY3Z21QRlA4?=
 =?utf-8?B?OHVtT3BKT1psejZQUkpiNzBXRFBTWDk2MExJaUM5TForNWlPNXhWWmM5OUR5?=
 =?utf-8?B?ZEdtanRQUU56UkNsbWFVSWtwMU1HN3czMUFKVVloK0RPMHQ3VjBwTS9uTzdU?=
 =?utf-8?B?TDYrY1VDb1ovdU5aUEJYTWJYMWQ3UFJhYURoT2plcnAvY2dUYjFwUmZISTdw?=
 =?utf-8?B?NUx0eVJyUkVKdkpSWXlucSs5Wi92Q01memYxaVVyWWVsaE1rVUJzU0dPeXRQ?=
 =?utf-8?B?TU05R01SSTBCSGx3S0ZTTGh4KzJzMnMzRFE2Znl0Y1pKdUo2Z29tVTJTZTNI?=
 =?utf-8?Q?aonFu/j8nWc4xPqgsIf4ABjDY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 515522e1-cd0e-46d7-c2c0-08dcd8402102
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 00:15:12.3922 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qLinI9ZetzSHVtFQbYPp3oOz1Sp40BSPqUd8ZBM9IG2WMN442fzVC5rmDgudju1NvpAHlzFthBswUhYmtQgTsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7872
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

Disale CPU1 for i.MX93 variants that only has one A55 core and update
cooling maps.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/Makefile   | 7 ++++++-
 arch/arm/mach-imx/imx9/soc.c | 8 ++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 47e2cb8d943..f8903afc92e 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -12,7 +12,6 @@ endif
 ifeq ($(SOC),$(filter $(SOC),imx8m))
 ifneq ($(CONFIG_SPL_BUILD),y)
 obj-$(CONFIG_IMX_BOOTAUX) += imx_bootaux.o
-obj-y += fdt.o
 endif
 obj-$(CONFIG_ENV_IS_IN_MMC) += mmc_env.o
 obj-$(CONFIG_FEC_MXC) += mac.o
@@ -22,6 +21,12 @@ obj-$(CONFIG_IMX_HAB) += hab.o
 obj-y += cpu.o
 endif
 
+ifeq ($(SOC),$(filter $(SOC),imx8m imx9))
+ifneq ($(CONFIG_SPL_BUILD),y)
+obj-y += fdt.o
+endif
+endif
+
 ifeq ($(SOC),$(filter $(SOC),mx5 mx6))
 obj-y	+= cpu.o speed.o
 ifneq ($(CONFIG_MX51),y)
diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index df259c26ad8..4ee40c2da32 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -696,9 +696,17 @@ int board_fix_fdt(void *fdt)
 
 int ft_system_setup(void *blob, struct bd_info *bd)
 {
+	static const char * const nodes_path[] = {
+		"/cpus/cpu@0",
+		"/cpus/cpu@100",
+	};
+
 	if (fixup_thermal_trips(blob, "cpu-thermal"))
 		printf("Failed to update cpu-thermal trip(s)");
 
+	if (is_imx9351() || is_imx9331() || is_imx9321() || is_imx9311())
+		disable_cpu_nodes(blob, nodes_path, 1, 2);
+
 	if (is_voltage_mode(VOLT_LOW_DRIVE))
 		low_drive_freq_update(blob);
 

-- 
2.35.3

