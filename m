Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CEA9CDD56E
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 03:01:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E736890A4;
	Thu, 19 Sep 2024 04:58:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="vJV5Sw1O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BDD8890A2; Thu, 19 Sep 2024 04:58:51 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::61e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F9FA89071
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 04:58:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OIzkZI2QO5Bc+Ic9qkzszvVmvkccFy3dYFxZOST05s11zArqX+Bs8aRbJtv1QIfe6cWa6fOEFfu2H5oEvKMaKoBPQpyDxj8+hyby9tcNsAbjbq5CTyMUJztfJOmthkcKHEeCI1TyInv1xXxP6razE/qUvby66nZet+mGDN49hvggTWzcy/IWX2lRXvx9WkyrSvv0wduO5RJQ/XBQouIKkcVGNuIKO/psJA4KotNTRDGMBN+R1kdCCYD3dDPKNgHWJ7BlNUltEg+zWx+A7I+8NvivteNZWiWlDDOQ6f8otqD/gZ7X5RPWLVFu1lPGqqQ4NPdc4ZP+I+CZkOH8hgj4Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6fnzm0rjhJpueGPrYN4e8wozfwyaiqaL9ngkNfeHds=;
 b=dmIjXb/s5VLseQts5bf1/vfPPYXCyyYKY3mjZ+cAGYaGGkSjq3rfSVcgTTaZ4PpRZKzAOmgVaoUoQ/zbWko/YZ9PwWG3Qu+/pNrSyYEM5WsMMotMsOQGJjWNqqpLIrsaXyA/4iTnHPIw8vgnM+SpRs9XOyiZfOmRDlk3+vszeqOSEFD8mZrKs6aqWVUxZR1wunfsL7ccFKc3mb13/NIUBiOTDJtMwB3IUIIVxxQXn/eV/J/rWI8PCdOryJfCZA4m9jMalVVYL7cMG3Mk4tJxcLgkfUTdd/1OoQoSShZz2DcP+Df0Js+npR7IKHG+pV6R4g+TInnT+S08Q/0eLOpLTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6fnzm0rjhJpueGPrYN4e8wozfwyaiqaL9ngkNfeHds=;
 b=vJV5Sw1OupgX3tLM8NfSCNzbLsJ312Klv1hnxK+FZQBnD/J9y7zzHZT+sIow2ltttulgAvgTXQS6L6Zick0EqeIJGJsBtNgp3en3iBytZJAZcPDhk75y9z/JINl18XNoejY0OdJ2DgyXIrgj5tmjRi0buFwAMF0gBB6oNPCOiqoDFod9AtfO42AWjA3Y4DDF+7cLtM1zkFAOyahPVuxHm7R1bTEIRcz0EB5ycg8NihZMBI5iOR/XoEC7lsn531AkeM+b/kZ74XkxWv9Gl5HmXFzcto12lloOqDFd4QASMJ8/+wTYWJXdshKj88NElwwz5d7K8gfS4CwkzP+xCMTiwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8867.eurprd04.prod.outlook.com (2603:10a6:20b:42e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 19 Sep
 2024 02:58:47 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 02:58:47 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 19 Sep 2024 12:01:35 +0800
Subject: [PATCH v3 17/21] imx9: trdc: cleanup code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-imx9-update-v3-17-80f9786cd1f0@nxp.com>
References: <20240919-imx9-update-v3-0-80f9786cd1f0@nxp.com>
In-Reply-To: <20240919-imx9-update-v3-0-80f9786cd1f0@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SI2P153CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB8867:EE_
X-MS-Office365-Filtering-Correlation-Id: 19ec5712-bb5c-498b-8759-08dcd856fb2d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YjFsaCs0RTlPdXZxZy9xR0l4bGw4c1A4NnhRL1o3bGZuclNGcCtNMURPdERm?=
 =?utf-8?B?SnBINHBkT3hVNG1CWXhjcldPblF1UGhpS2NHUUJ4c3lIMXhIS0UzeFhXVE4z?=
 =?utf-8?B?RTRVYUhwaHd2cHFoMnR0MHVoSmMwdGlzWEFoVmI5MjBFeEFIZE9JWU81L0V0?=
 =?utf-8?B?a3VYcnl3QjFsdkZDdFFLK2lNemJjbE5IWE5mdGRiV0tKdGhxZHlwd2NBUUlX?=
 =?utf-8?B?aVJuMGNpQnErc3RNanlwWXNvVDVWTkFuQ0tmcnpQczRPTjV0RTJTY0dxU0Jl?=
 =?utf-8?B?UnBGY1R3TWlEZ25VTXd2NHR4S2dhcGVmbGVScGlteHp6aFdlR3pySmk0Ukxv?=
 =?utf-8?B?eEdCcVdrOHZadis4aEl2UVdyTllXQkNSZUxoYXdtRitzUjlYR0hONng2MDF2?=
 =?utf-8?B?UkRlNCtEQWpWSXRDeENaQ1VOSldyT2VuQm9kNS9YazNrUFEzY2ZqUThiRGM1?=
 =?utf-8?B?VGVxaUpZSjFqRUxISGJCYUI5cHB3ZDg4L3c5YUpVM3NpVzZVSm94MFN1L2Zs?=
 =?utf-8?B?N1RhVFdLVTRsYmF0NWlhYmZtUzF3ZEFMNEdXOWdZeVhiaVpydGRscEV2NFU2?=
 =?utf-8?B?YmVDaWVpTXdMSFBVQXFlZnJqWTNrNWdvUWZxNFRrd2UvMVB4UmVsUDd0SzY0?=
 =?utf-8?B?bHJNVVpLaDVxQVFxRVNyRkVTOENyVjZTdjdBaGtzQ0ZBaktxTUpEQXVlSHFh?=
 =?utf-8?B?RSszcnBoNkdCVU94clN6bzVsQTZRRGQ5dGQ3N25ZUTR5bFFiM0hKWERoemQ5?=
 =?utf-8?B?M3dlNDRZc1AzVHg0Rk5tc2tnZkFRMlI5MThHbWhBcGQ3M3lIVVVWa1V5TXhn?=
 =?utf-8?B?QWNaOU1DOXpHVkVKTnJsY0JibmRnOFdRRHlrVmJqaktwZDFodThBZC8yeVVv?=
 =?utf-8?B?eVh3L2tSVDIxc09velg3VEpMZEhJclBEVGpJckp0SjZhc1lZWnVoZXlkbGl0?=
 =?utf-8?B?SG4yajg3RkgwZGlKRVdRYmF3c2xPSzJJK2ZjSWRWM09QUDRNbU1jUyt4SS8r?=
 =?utf-8?B?dFJsSzNKQ2w0OWEwVFUrK0YxNW5pb2NDY0E5M3ZNV0RpeWdFY1Z3WmlndWd3?=
 =?utf-8?B?TTF1SDVOanZaeUZ2VkttOVpUb2Z6NkV5enU3Uk9tOFFsVWFiQVhTdW1jeUlB?=
 =?utf-8?B?cEpvRlNuMWZNdkNTN3ZWaWNkZ0RJUFZ3MGxZSWFtSURJSVdma2c1ME5nRmNk?=
 =?utf-8?B?NzAxSmtIYlRsSjYzbXdNVm54WTBFcEJtaysreXdPaGFNWGJqMktOWTRjSUtv?=
 =?utf-8?B?VFNHVDVVTE1SaDY2VTdkKzd5NFF4aTdBR1FYMGptNFlRUmJoVWo0WTNsVWlw?=
 =?utf-8?B?Mk9qSzY4cEd5eVArbDlZaWg4elpwK1Zpd2t1WjUyMExkUlpuT1RrQ0NnNUpQ?=
 =?utf-8?B?bW9RbmFIQ2pxTm5CbzRsM1RscUdSRFd3UVFNSklNVWg1K2t1Tllaa1ZQTDRS?=
 =?utf-8?B?SGl6R0ZVMHBzSkZWVlZIZm9PanN3N0RiMURxYXhJa3k0cW92RWJhdEJ4d0dT?=
 =?utf-8?B?QTc2cTFMaVVxUHowUENscDIvZ0t4dWpyc28xTTlZMTRGWlh5U1VJWFJUWkRI?=
 =?utf-8?B?VWMyNytzL0x4ZTAxSHNQdmhYYUNVUHF6YUJRWm1LT0JBWHlyQWJNUUM4Nmp5?=
 =?utf-8?B?Y3lNVEdVc2M1bjQwNUVHUHd3MDdMVFdvaWZPMkFFNW01TTJSSVdJMDJGRlMz?=
 =?utf-8?B?REduM0twd1JGYVJCUE4xMlM2d085K1lNd0NDM1ByV2l1Y29FT0FLb1lTRU9o?=
 =?utf-8?B?ZjRjWUNRcXdKS1hwK3AxL0JnMUdpaWFDUTN0VWNTVHczWFBUcXplODJOcis4?=
 =?utf-8?B?L3BnUnpOeU9ESm9uZnhYQmpxb3RtaUF3RlVKajNjWGh5aHB5MDdaS21VY1ds?=
 =?utf-8?B?V2QxYXppdU1BYWZTNkJQa3lPR1RFdXNKVXhkdGNMRW9JTlE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDRhU29jeDdzaGpWV1c3UGdXV0IrZ2NQNExORTJpdUVPRTY5MDJRanF0T21h?=
 =?utf-8?B?S3R4SDNpaGRuVll5bmxmbS9pZnQwRFJEcmZuWEtQK05GV2FtSGxRd0diY1Js?=
 =?utf-8?B?Rmh2N0NRMEJzRVZuWkMzbVJRZUh5MzIwdkZXK28reS9uMUFoQnArc1lZY1Uz?=
 =?utf-8?B?NVhwZ2JxVmtEV3kvUlV4eW14Uzg0eTB4RlovMzdpSnRNbnF4S2JpTGtYZHJC?=
 =?utf-8?B?eE5QN2ZmSENvY1lDTllxVlNXMVFuc3hUc2JBVllHNUVJQmp6bmNZQU4yOXk0?=
 =?utf-8?B?NVZFd214VjY3SFVPQkFONlpEWTJTb0RTdmkrc2Rzc0krMVVVV04zSTlEOVNL?=
 =?utf-8?B?MFRmTm4vZ0dVcGxjNkE2NXFiYzA2eFI2RGJNb0lyK2F1Q3NORWtFTk8weUg1?=
 =?utf-8?B?RUtBZmFrYkNlSTNVbWxjaXFsK2NLbXB5Y2RYQWFjcjNYZFBBUFBEUXlUR0lP?=
 =?utf-8?B?T2ZNNi9salBJRXhMcEY1eTZubVFEZ012eXFjc2pIcWFPRk9uRzBPZzBZUUwy?=
 =?utf-8?B?cEt3c3hNKzRSYnFkeElEem4ra2JZS0dsUzFIMmc3bitlbjFFZERzTFRTVWlJ?=
 =?utf-8?B?RTlWdVFWNlVxZEVVTGE2cUcvODJkeXhkL0c1ZVc3c2VDMEJqUGRBUzZGOTA2?=
 =?utf-8?B?NW5OelRWb3JwV2FhTDZCWnZmMWpJVXdrYW1UWDA0aEJtK1VxWDFzTnZOdlpB?=
 =?utf-8?B?YzdYQTRKN282WC9yUFBlMlhzb0I3WWhRb0lMRnEwcmh5RnNHazk5WE5zMHNO?=
 =?utf-8?B?V293bUdVejhYNzNZMHBXNFIrOGgrQmRRVVY2NXJMQ1pGbDJ2cElqUGFBRnZ0?=
 =?utf-8?B?Rlg0b3VlcUhuN2czMDVPeHJsb0hsS1NhWU1sb1V5SDRrcFEwUGVEdWJDZCtV?=
 =?utf-8?B?dk1VL3oraHVUN1lNWUlWR041VmkwRG1UalV4cjhBcldzS09HQWk1OUVnSTBu?=
 =?utf-8?B?Wkpsd3BlL2dSWGNzRllCZFZLMVlLZmVMVlI1N1BiU0REaEpySjI5dHROMWZa?=
 =?utf-8?B?ZGoweDZXZ29aZ1d1U2sxRXpHNmxnVERQb0owVlNQb2Zmd2dPcE1rV2VDUWJo?=
 =?utf-8?B?Um1aT1JmQmJweEVEaDIxcHJTUVVhLzdwSFIzVGovN3BSMnBHVTJVTzJ4ckVM?=
 =?utf-8?B?eTh3aGxDRDVOLzkzNThVd0MyOEFEbm1ya3pUYzY0S3AvZnFqaUFYYWdRL3pz?=
 =?utf-8?B?cXUrQ1E1SUwydk11andLQmtwWTBkNlI0RTlvMGRhYWVMRERaa2tmS1lXSVBh?=
 =?utf-8?B?b1BlaWE3MEkwWXUwR1lxdjg1TkY0akxLQ2huN1ArSWo2QzhkYmxOZUZuU0ZQ?=
 =?utf-8?B?MEtJaDI0SXBlM0s4QkRwaFhPWkdROFBxYjhkdGlsRXRNWXhLaTk2dGxSdFVk?=
 =?utf-8?B?a2tmV2UyczR2NVV6d1dsbFRmWjBNQ3YvN1NJdDFKSG9yejkyenlNV3BGUFho?=
 =?utf-8?B?RnFZSnNndW4reGNpK2huZ3lkV1BEL3lIdW0zWHlvZXY0bXltUWJnVGN2WmdS?=
 =?utf-8?B?anlPOUxCWXptQ1U5bmhhcUJTRXh5SnF2dCs1WDcwdDZjWWVhaUZLZ1hLMWlm?=
 =?utf-8?B?NkU4VUtjbGVCZ2x0WFhFYjFHemhiMnFTUEtZdzFjL2VWaS82ekdGc1k0MnFm?=
 =?utf-8?B?TG90VzNjZUlJMlphUFZNSWJKeUJtQVpKc1F5TnQzS2NaQmJuc2xZcjh4RTFq?=
 =?utf-8?B?RjRrNkU4NHUyWG5mNk55NkVwNEsxZVMzamNka1lsdmVFNFhPa21rWjR1WXFo?=
 =?utf-8?B?R1ZEaUx2ZE1vUTZXbkRCZ0ZQTWRmcVlPMUIvTGNLdGg2L1NaaWdMckx2dWdT?=
 =?utf-8?B?cXNxL0tVQmdzYnNEWnFzSk9Qc0R2Z2c4THV1dkFhT0g2MzkwVWNsR2VFMG1m?=
 =?utf-8?B?RUNGYk9qRC9ZbHhnbGNRZGRtSTdDOFJWdEpqNEgvdFN2U2tDNFpDTGltUE1O?=
 =?utf-8?B?Wm12RDUzWXVEV2dRK0d2YlZjZ1I1WUlYR0g1Kzk0QXFUZHNlYlVWVU1kSEdI?=
 =?utf-8?B?b0N0ZVc2b2NCNkptQ1NndnIveHJWam1pTE9XZnhIYmU3RzRuak1ta1Q4UWl4?=
 =?utf-8?B?UE9qU2d5ZDFhUjB2dHBUSTlyTlNmL21vZlcxOFFPeTJVdWI3TUFyTElqekd0?=
 =?utf-8?Q?zJhasyuLx4bYPV1NY3WvAKTTu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ec5712-bb5c-498b-8759-08dcd856fb2d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 02:58:47.3601 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ek0zAm/UAP9yc2a6iVrf9AzSqAdRUiGgX0vFucXzedyalfHnr3swUQ+hmsBEPsNDeI4CrLLHNAN2Vz7NWMIRzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8867
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

Replace magic number with meaningful macros.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/include/asm/arch-imx9/imx-regs.h |   5 +
 arch/arm/mach-imx/imx9/trdc.c             | 156 ++++++++++++++++++------------
 2 files changed, 101 insertions(+), 60 deletions(-)

diff --git a/arch/arm/include/asm/arch-imx9/imx-regs.h b/arch/arm/include/asm/arch-imx9/imx-regs.h
index cb6b8a59cad..ef9538bd42e 100644
--- a/arch/arm/include/asm/arch-imx9/imx-regs.h
+++ b/arch/arm/include/asm/arch-imx9/imx-regs.h
@@ -50,6 +50,11 @@
 #define BCTRL_GPR_ENET_QOS_INTF_SEL_RGMII        (0x1 << 1)
 #define BCTRL_GPR_ENET_QOS_CLK_GEN_EN            (0x1 << 0)
 
+#define TRDC_AON_BASE		(0x44270000UL)
+#define TRDC_WAKEUP_BASE	(0x42460000UL)
+#define TRDC_MEGA_BASE		(0x42810000UL)
+#define TRDC_NIC_BASE		(0x49010000UL)
+
 #define MARKETING_GRADING_MASK	GENMASK(5, 4)
 #define SPEED_GRADING_MASK	GENMASK(11, 6)
 #define NUM_WORDS_PER_BANK	8
diff --git a/arch/arm/mach-imx/imx9/trdc.c b/arch/arm/mach-imx/imx9/trdc.c
index 8cdb28459a3..ae1a46d1331 100644
--- a/arch/arm/mach-imx/imx9/trdc.c
+++ b/arch/arm/mach-imx/imx9/trdc.c
@@ -4,12 +4,13 @@
  */
 
 #include <log.h>
+#include <div64.h>
+#include <hang.h>
 #include <linux/errno.h>
 #include <asm/io.h>
 #include <asm/types.h>
 #include <asm/arch/imx-regs.h>
 #include <asm/arch/sys_proto.h>
-#include <div64.h>
 #include <asm/mach-imx/ele_api.h>
 #include <asm/mach-imx/mu_hal.h>
 
@@ -19,6 +20,25 @@
 #define MBC_NUM(HWCFG) (((HWCFG) >> 16) & 0xF)
 #define MRC_NUM(HWCFG) (((HWCFG) >> 24) & 0x1F)
 
+enum {
+	/* Order following ELE API Spec, not change */
+	TRDC_A,
+	TRDC_W,
+	TRDC_M,
+	TRDC_N,
+};
+
+/* Just make it easier to know what the parameter is */
+#define MBC(X)			(X)
+#define MRC(X)			(X)
+#define GLOBAL_ID(X)		(X)
+#define MEM(X)			(X)
+#define DOM(X)			(X)
+/*
+ *0|SPR|SPW|SPX,0|SUR|SUW|SWX, 0|NPR|NPW|NPX, 0|NUR|NUW|NUX
+ */
+#define PERM(X)			(X)
+
 struct mbc_mem_dom {
 	u32 mem_glbcfg[4];
 	u32 nse_blk_index;
@@ -364,68 +384,84 @@ void trdc_early_init(void)
 {
 	int ret = 0, i;
 
-	ret |= release_rdc(0);
-	ret |= release_rdc(2);
-	ret |= release_rdc(1);
-	ret |= release_rdc(3);
+	ret |= release_rdc(TRDC_A);
+	ret |= release_rdc(TRDC_M);
+	ret |= release_rdc(TRDC_W);
+	ret |= release_rdc(TRDC_N);
 
-	if (!ret) {
-		/* Set OCRAM to RWX for secure, when OEM_CLOSE, the image is RX only */
-		trdc_mbc_set_control(0x49010000, 3, 0, 0x7700);
+	if (ret) {
+		hang();
+		return;
+	}
+
+	/* Set OCRAM to RWX for secure, when OEM_CLOSE, the image is RX only */
+	trdc_mbc_set_control(TRDC_NIC_BASE, MBC(3), GLOBAL_ID(0), PERM(0x7700));
 
-		for (i = 0; i < 40; i++)
-			trdc_mbc_blk_config(0x49010000, 3, 3, 0, i, true, 0);
+	for (i = 0; i < 40; i++) {
+		trdc_mbc_blk_config(TRDC_NIC_BASE, MBC(3), DOM(3), MEM(0), i,
+				    true, GLOBAL_ID(0));
 
-		for (i = 0; i < 40; i++)
-			trdc_mbc_blk_config(0x49010000, 3, 3, 1, i, true, 0);
+		trdc_mbc_blk_config(TRDC_NIC_BASE, MBC(3), DOM(3), MEM(1), i,
+				    true, GLOBAL_ID(0));
 
-		for (i = 0; i < 40; i++)
-			trdc_mbc_blk_config(0x49010000, 3, 0, 0, i, true, 0);
+		trdc_mbc_blk_config(TRDC_NIC_BASE, MBC(3), DOM(0), MEM(0), i,
+				    true, GLOBAL_ID(0));
 
-		for (i = 0; i < 40; i++)
-			trdc_mbc_blk_config(0x49010000, 3, 0, 1, i, true, 0);
+		trdc_mbc_blk_config(TRDC_NIC_BASE, MBC(3), DOM(0), MEM(1), i,
+				    true, GLOBAL_ID(0));
 	}
 }
 
 void trdc_init(void)
 {
 	/* TRDC mega */
-	if (trdc_mrc_enabled(0x49010000)) {
+	if (trdc_mrc_enabled(TRDC_NIC_BASE)) {
 		/* DDR */
-		trdc_mrc_set_control(0x49010000, 0, 0, 0x7777);
+		trdc_mrc_set_control(TRDC_NIC_BASE, MRC(0), GLOBAL_ID(0), PERM(0x7777));
 
 		/* ELE */
-		trdc_mrc_region_config(0x49010000, 0, 0, 0x80000000, 0xFFFFFFFF, false, 0);
+		trdc_mrc_region_config(TRDC_NIC_BASE, MRC(0), DOM(0), 0x80000000,
+				       0xFFFFFFFF, false, GLOBAL_ID(0));
 
 		/* MTR */
-		trdc_mrc_region_config(0x49010000, 0, 1, 0x80000000, 0xFFFFFFFF, false, 0);
+		trdc_mrc_region_config(TRDC_NIC_BASE, MRC(0), DOM(1), 0x80000000,
+				       0xFFFFFFFF, false, GLOBAL_ID(0));
 
 		/* M33 */
-		trdc_mrc_region_config(0x49010000, 0, 2, 0x80000000, 0xFFFFFFFF, false, 0);
+		trdc_mrc_region_config(TRDC_NIC_BASE, MRC(0), DOM(2), 0x80000000,
+				       0xFFFFFFFF, false, GLOBAL_ID(0));
 
 		/* A55*/
-		trdc_mrc_region_config(0x49010000, 0, 3, 0x80000000, 0xFFFFFFFF, false, 0);
+		trdc_mrc_region_config(TRDC_NIC_BASE, MRC(0), DOM(3), 0x80000000,
+				       0xFFFFFFFF, false, GLOBAL_ID(0));
 
 		/* For USDHC1 to DDR, USDHC1 is default force to non-secure */
-		trdc_mrc_region_config(0x49010000, 0, 5, 0x80000000, 0xFFFFFFFF, false, 0);
+		trdc_mrc_region_config(TRDC_NIC_BASE, MRC(0), DOM(5), 0x80000000,
+				       0xFFFFFFFF, false, GLOBAL_ID(0));
 
 		/* For USDHC2 to DDR, USDHC2 is default force to non-secure */
-		trdc_mrc_region_config(0x49010000, 0, 6, 0x80000000, 0xFFFFFFFF, false, 0);
+		trdc_mrc_region_config(TRDC_NIC_BASE, MRC(0), DOM(6), 0x80000000,
+				       0xFFFFFFFF, false, GLOBAL_ID(0));
 
 		/* eDMA */
-		trdc_mrc_region_config(0x49010000, 0, 7, 0x80000000, 0xFFFFFFFF, false, 0);
+		trdc_mrc_region_config(TRDC_NIC_BASE, MRC(0), DOM(7), 0x80000000,
+				       0xFFFFFFFF, false, GLOBAL_ID(0));
 
 		/*CoreSight, TestPort*/
-		trdc_mrc_region_config(0x49010000, 0, 8, 0x80000000, 0xFFFFFFFF, false, 0);
+		trdc_mrc_region_config(TRDC_NIC_BASE, MRC(0), DOM(8), 0x80000000,
+				       0xFFFFFFFF, false, GLOBAL_ID(0));
 
 		/* DAP */
-		trdc_mrc_region_config(0x49010000, 0, 9, 0x80000000, 0xFFFFFFFF, false, 0);
+		trdc_mrc_region_config(TRDC_NIC_BASE, MRC(0), DOM(9), 0x80000000,
+				       0xFFFFFFFF, false, GLOBAL_ID(0));
 
 		/*SoC masters */
-		trdc_mrc_region_config(0x49010000, 0, 10, 0x80000000, 0xFFFFFFFF, false, 0);
+		trdc_mrc_region_config(TRDC_NIC_BASE, MRC(0), DOM(10), 0x80000000,
+				       0xFFFFFFFF, false, GLOBAL_ID(0));
 
 		/*USB*/
-		trdc_mrc_region_config(0x49010000, 0, 11, 0x80000000, 0xFFFFFFFF, false, 0);
+		trdc_mrc_region_config(TRDC_NIC_BASE, MRC(0), DOM(11), 0x80000000,
+				       0xFFFFFFFF, false, GLOBAL_ID(0));
 	}
 }
 
@@ -504,78 +540,78 @@ void trdc_dump(void)
 
 	printf("TRDC AONMIX MBC\n");
 
-	trdc_mbc_control_dump(0x44270000, 0, 0);
-	trdc_mbc_control_dump(0x44270000, 1, 0);
+	trdc_mbc_control_dump(TRDC_AON_BASE, MBC(0), GLOBAL_ID(0));
+	trdc_mbc_control_dump(TRDC_AON_BASE, MBC(1), GLOBAL_ID(0));
 
 	for (i = 0; i < 11; i++)
-		trdc_mbc_mem_dump(0x44270000, 0, 3, 0, i);
+		trdc_mbc_mem_dump(TRDC_AON_BASE, MBC(0), DOM(3), MEM(0), i);
 	for (i = 0; i < 1; i++)
-		trdc_mbc_mem_dump(0x44270000, 0, 3, 1, i);
+		trdc_mbc_mem_dump(TRDC_AON_BASE, MBC(0), DOM(3), MEM(1), i);
 
 	for (i = 0; i < 4; i++)
-		trdc_mbc_mem_dump(0x44270000, 1, 3, 0, i);
+		trdc_mbc_mem_dump(TRDC_AON_BASE, MBC(1), DOM(3), MEM(0), i);
 	for (i = 0; i < 4; i++)
-		trdc_mbc_mem_dump(0x44270000, 1, 3, 1, i);
+		trdc_mbc_mem_dump(TRDC_AON_BASE, MBC(1), DOM(3), MEM(1), i);
 
 	printf("TRDC WAKEUP MBC\n");
 
-	trdc_mbc_control_dump(0x42460000, 0, 0);
-	trdc_mbc_control_dump(0x42460000, 1, 0);
+	trdc_mbc_control_dump(TRDC_WAKEUP_BASE, MBC(0), GLOBAL_ID(0));
+	trdc_mbc_control_dump(TRDC_WAKEUP_BASE, MBC(1), GLOBAL_ID(0));
 
 	for (i = 0; i < 15; i++)
-		trdc_mbc_mem_dump(0x42460000, 0, 3, 0, i);
+		trdc_mbc_mem_dump(TRDC_WAKEUP_BASE, MBC(0), DOM(3), MEM(0), i);
 
-	trdc_mbc_mem_dump(0x42460000, 0, 3, 1, 0);
-	trdc_mbc_mem_dump(0x42460000, 0, 3, 2, 0);
+	trdc_mbc_mem_dump(TRDC_WAKEUP_BASE, MBC(0), DOM(3), MEM(1), 0);
+	trdc_mbc_mem_dump(TRDC_WAKEUP_BASE, 0, 3, 2, 0);
 
 	for (i = 0; i < 2; i++)
-		trdc_mbc_mem_dump(0x42460000, 1, 3, 0, i);
+		trdc_mbc_mem_dump(TRDC_WAKEUP_BASE, MBC(1), DOM(3), MEM(0), i);
 
-	trdc_mbc_mem_dump(0x42460000, 1, 3, 1, 0);
-	trdc_mbc_mem_dump(0x42460000, 1, 3, 2, 0);
-	trdc_mbc_mem_dump(0x42460000, 1, 3, 3, 0);
+	trdc_mbc_mem_dump(TRDC_WAKEUP_BASE, MBC(1), DOM(3), MEM(1), 0);
+	trdc_mbc_mem_dump(TRDC_WAKEUP_BASE, 1, 3, 2, 0);
+	trdc_mbc_mem_dump(TRDC_WAKEUP_BASE, MBC(1), DOM(3), MEM(3), 0);
 
 	printf("TRDC NICMIX MBC\n");
 
-	trdc_mbc_control_dump(0x49010000, 0, 0);
-	trdc_mbc_control_dump(0x49010000, 1, 0);
-	trdc_mbc_control_dump(0x49010000, 2, 0);
-	trdc_mbc_control_dump(0x49010000, 3, 0);
+	trdc_mbc_control_dump(TRDC_NIC_BASE, MBC(0), GLOBAL_ID(0));
+	trdc_mbc_control_dump(TRDC_NIC_BASE, MBC(1), GLOBAL_ID(0));
+	trdc_mbc_control_dump(TRDC_NIC_BASE, MBC(2), GLOBAL_ID(0));
+	trdc_mbc_control_dump(TRDC_NIC_BASE, MBC(3), GLOBAL_ID(0));
 
 	for (i = 0; i < 7; i++)
-		trdc_mbc_mem_dump(0x49010000, 0, 3, 0, i);
+		trdc_mbc_mem_dump(TRDC_NIC_BASE, MBC(0), DOM(3), MEM(0), i);
 
 	for (i = 0; i < 2; i++)
-		trdc_mbc_mem_dump(0x49010000, 0, 3, 1, i);
+		trdc_mbc_mem_dump(TRDC_NIC_BASE, MBC(0), DOM(3), MEM(1), i);
 
 	for (i = 0; i < 5; i++)
-		trdc_mbc_mem_dump(0x49010000, 0, 3, 2, i);
+		trdc_mbc_mem_dump(TRDC_NIC_BASE, MBC(0), DOM(3), MEM(2), i);
 
 	for (i = 0; i < 6; i++)
-		trdc_mbc_mem_dump(0x49010000, 0, 3, 3, i);
+		trdc_mbc_mem_dump(TRDC_NIC_BASE, MBC(0), DOM(3), MEM(3), i);
 
 	for (i = 0; i < 1; i++)
-		trdc_mbc_mem_dump(0x49010000, 1, 3, 0, i);
+		trdc_mbc_mem_dump(TRDC_NIC_BASE, MBC(1), DOM(3), MEM(0), i);
 
 	for (i = 0; i < 1; i++)
-		trdc_mbc_mem_dump(0x49010000, 1, 3, 1, i);
+		trdc_mbc_mem_dump(TRDC_NIC_BASE, MBC(1), DOM(3), MEM(1), i);
 
 	for (i = 0; i < 3; i++)
-		trdc_mbc_mem_dump(0x49010000, 1, 3, 2, i);
+		trdc_mbc_mem_dump(TRDC_NIC_BASE, MBC(1), DOM(3), MEM(2), i);
 
 	for (i = 0; i < 3; i++)
-		trdc_mbc_mem_dump(0x49010000, 1, 3, 3, i);
+		trdc_mbc_mem_dump(TRDC_NIC_BASE, MBC(1), DOM(3), MEM(3), i);
 
 	for (i = 0; i < 2; i++)
-		trdc_mbc_mem_dump(0x49010000, 2, 3, 0, i);
+		trdc_mbc_mem_dump(TRDC_NIC_BASE, MBC(2), DOM(3), MEM(0), i);
 
 	for (i = 0; i < 2; i++)
-		trdc_mbc_mem_dump(0x49010000, 2, 3, 1, i);
+		trdc_mbc_mem_dump(TRDC_NIC_BASE, MBC(2), DOM(3), MEM(1), i);
 
 	for (i = 0; i < 5; i++)
-		trdc_mbc_mem_dump(0x49010000, 3, 3, 0, i);
+		trdc_mbc_mem_dump(TRDC_NIC_BASE, MBC(3), DOM(3), MEM(0), i);
 
 	for (i = 0; i < 5; i++)
-		trdc_mbc_mem_dump(0x49010000, 3, 3, 1, i);
+		trdc_mbc_mem_dump(TRDC_NIC_BASE, MBC(3), DOM(3), MEM(1), i);
 }
 #endif

-- 
2.35.3

