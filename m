Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF09D2F7F6
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 07:08:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1334C88D5B;
	Thu, 17 Oct 2024 09:08:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wVC/gLMl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8D9B88C05; Thu, 17 Oct 2024 09:08:52 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::60e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B599988D5B
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 09:08:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxlGuyGGm1Chex6wpQNhVN4hhIClVeBQw8u4oxt0bB6+kXrXuEuJxo4WAWPcVRJKn0phAaVEYs+VUC0zF55yrwfzfsQMS69bVGxbqBKruGAFN16LirirAk6EF8cGUdraLch8zsR276eP7qxCbLr1Xr2VUM9vDe0VNCmVnz6/qiWWyw4EBYnaYnDmt7mKX6uNIsa4m4+STxIAWuJyn2EK5IBgTtDsloDcsaEdjbCOdwvihxOGl+AJH6KEr09Ihnq1GJWPZ8A72idyBY0kQ/Y7vyZSlCUSgDgf64UQwStsGOzeMvC4a1Wf9SZY/0HCoNwyAZ6Zn8ZAnOS9hFE07HdR4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UuN6kdbPc5Z29Ndrj/jMqD8G4LHQpY0AiuJe1lds0+o=;
 b=cXQmDieWlUEQS1zRfJa197dfY4NaQstuzalUuyVDz5r6kE7QtrevxmavwtRE5YZAr6O/AZr9pmjadTALd1SSdtxew6Od6rBxbXvnP05d+lyZ1JoasZ3U5r3CEgFsmGhtjBT0+G5lSaCzKk+qjI5npgtzAN1/3aj5Ju7Nznzp/adUQiZCaVP+S472F7sBJkmVpleaANA0weHZq9V2JofOaNunBre5iZ4DiaAwdal1HNBt1fgkIf2gqS1FT+rwkaVMsRSAeNoaYZOX42CmpX1kZ3r1lN5WmhEUse9DVsCS1quflpLbJKUcAr5EjwoSpPdZ8OhxzFleP2tuPBmMuKrB7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuN6kdbPc5Z29Ndrj/jMqD8G4LHQpY0AiuJe1lds0+o=;
 b=wVC/gLMlYbwpdi1UYpIX3Ng3vSHeVzS2nKyZHtMdtMXgMWmi2AsRlqv68IUZQwfsyo7rR2bjTkLwqoQF+uZQ0FFb7CFzYZwVrLht5Gxa7T++9w7QM2qsskKj57Wpc/824X5gn4t3CPWGJGEy4PBicY+pFRPK+Q8HWzEqasQX9Jnk3e7QPBW63HTc3ueQ630flssrYCgLrpoCzNFxMsQ2RBtgxrmuEapgm4R+RUvE2THUzMYe4zpLMLjbe7tSx10k16TNsWTmwaa5DkSeOZmAiuiy8dW2Wbyg1R14MJ8jdtW3ussWGiSdZyA3dJN1wZWjvlRaJPeP7+yV670VxstEjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM8PR04MB7812.eurprd04.prod.outlook.com (2603:10a6:20b:245::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 07:08:44 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 07:08:44 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: festevam@gmail.com, sbabic@denx.de, u-boot@lists.denx.de,
 trini@konsulko.com
Cc: uboot-imx@nxp.com,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2] cpu: imx8_cpu: Avoid revision to corrupt device tree
Date: Thu, 17 Oct 2024 16:12:36 +0800
Message-Id: <20241017081236.26742-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM8PR04MB7812:EE_
X-MS-Office365-Filtering-Correlation-Id: 267fc8ce-5c87-4183-efb7-08dcee7a8984
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGRYalJsSXNDMW91VHFVTzNoWWhFRHFUOHRLRVJrOHNtMzJVeFIxck1WWVU1?=
 =?utf-8?B?S0dVY0RDU1lLZVlEWnk4MUpmN2ZpYjNJUy9zRGEwUTVaTVhRbElWdXFqZjR3?=
 =?utf-8?B?ZGl2em5LV1ZNamtRbFQvc2FONXQ3MnMzbGhRL0ZYaXZSTFRuV09RMkx1bGZN?=
 =?utf-8?B?U0xGWXU0UFY1RGtNcjEwMklFTzhIYkFtUy9BeGpxd0tMNXdrckVTdzlobzda?=
 =?utf-8?B?dGY0WFIxbnV5djhUZm1oTDhNMTlXRFhiZTJrUFovaUJGZnJ3S3ZBamN2ZXVE?=
 =?utf-8?B?bXE4dEtOVE1qeVJ0cXRzRmhjNm5XM1ExQm1RenNLeXNTTTZ0V09Wc05NMmJs?=
 =?utf-8?B?c2R3Sm9WNkE4d3I3K2tBVTVIU0NMd0NocjJkOVAwTTcyZnVBT2VzWWVuR1hn?=
 =?utf-8?B?cFJTUVVrd09MUzg5WXorTEFjdGptVE90RlRrRFpYQUJESjVhYXVlbjF6YU5r?=
 =?utf-8?B?VEtKSi9Kd1h3VzQwV0EwSVpzODI5LzRwNklMOStlaXM3aXZVaVZBRk9xK2k2?=
 =?utf-8?B?VmEzc2ZlSVRZRDVvOFF4bDNmOVdpY3Q3Vm9VL0xLdVVXQkEwdTdMbTM4MENk?=
 =?utf-8?B?ZjlXSzVoVDFtRzV2OEc1SVQ1UlBqUklpcVcwS01lbkxzS3lzMGJzVlBuNmUy?=
 =?utf-8?B?ekRMVnljNWN0ampHTVdmaGxKNUxFTWtCZFZNV216RnNNWlZjZDB1UzRSZlkw?=
 =?utf-8?B?anVRQ1dtelBZcFdWUVJQTUo3RTNwTTcxMFZLeVl2SXZZWHVlNFg5VFNrL2pX?=
 =?utf-8?B?QkRXMWVYTUdvVlY3M2xrbFA4S3lPQTNJYmk2cmpIcittWStDak9XcVBlS1Y5?=
 =?utf-8?B?MEhJbkN2YUVPREh4VnRNQlI3RHhhM245MU5NR3JhTTRVVStYRC9IODZycHo1?=
 =?utf-8?B?bnVZK1RqQlQ2dThZbHJXNjllVEVVL21wWTJEOXBCWWhBb3FUNVZmSTk1bEhx?=
 =?utf-8?B?VG1SZHdYZWI5ZEFQSVdyL1pBTTJmRHBKbUs4ckQ3djA0aDVHRGVyNkpiSE1a?=
 =?utf-8?B?WVYxV3NuZWEwaDhWSTR6WTRnditKdXBsUGNoc08zaFpIM29acHgrYXFnMEtx?=
 =?utf-8?B?UTVpOGhNZCtTbnhzQWV0Zk1UN0tnZnQzL1BGSGdxS3pEZnBkSkttclczd3ll?=
 =?utf-8?B?eVp3dzFMM0J2SU5YclJmcE1sN2hwRSt3U3lHS2FuSTNXZ3FTUWRSelc3a1Rr?=
 =?utf-8?B?ek9RTUJFU3hBSllKQm40QzR0WjB1R1VObkZlMFkxcjFuOWQzbktteEtBUHJ1?=
 =?utf-8?B?Q3NRQU9sS3ExMythZHRHWGkvaUVabWpPYmo4dXhzR1BBZkJuazZvTHZrN2da?=
 =?utf-8?B?UStadmRnNWZ5emM3OW9vdWJoWDRxVHkyS3NHd2FpcTFrM2RIU3JwZG40MEx4?=
 =?utf-8?B?aDc0UG1ZdDlXeFo5UWVHTVVBVjdockpLSHZTZVoyUVk1aXdVVFg1WHZUUStE?=
 =?utf-8?B?bHFwTVVzYjFXZ09jZVI4OE5wMmNTU2ZFM210MHcwbllVU01LbE5mb1dpRnQz?=
 =?utf-8?B?Z00zY25nTWRXNXFCVVZqTC91SldEZ0RwZ0RrU2Vrc3RUcE1MV1YrMXB3bjJp?=
 =?utf-8?B?ZWNhclNlNVNyQ0liY1Q3V1FNcDVlaDhwL21XanFYSStmSjREczhmNjFidTFi?=
 =?utf-8?B?NVJ0TCtGTXJhVXQwa2E1NHY4cEdsZy9kdFhOVmQ4MHF4NVBSQTEvMmNHWmh3?=
 =?utf-8?B?ZTlSMzVLSThKTzJ0M29XTlZiYTFSQmR1Qko1RkNQWEJtUEFxaWRQd3dLTy9J?=
 =?utf-8?B?UzhERUNvNDZvcmpLMTBITndwSEU3QUlDTTFWRzhPOVNxSG9sa01ZRHpiMkNa?=
 =?utf-8?Q?n+x0DOQj3LPgU8NBbNFsXjaNogHzBouUK15sY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REFFMTFHeHdtbDBjUFQyRWVpTTZGenhLVnVsZ05uK3VIdG9KeGlwVlRDby9u?=
 =?utf-8?B?NlV1ZGc1SjRSTmJsdlE1S3N5U2lNT3V3NWtHZ2FJek5CU3VOMEJ6cFRmRXMy?=
 =?utf-8?B?L3B5by9lQk90ODhLbnJ6UHgrUVVwS2V1UGtabXRlOWJIcEtOYXhVdkNCL1Ur?=
 =?utf-8?B?MFVGKzFUNHpPTFExcFlmTkEzMXpEaWt5a2E1N1lhZVkxRzEzTVI3WUdoNEhJ?=
 =?utf-8?B?eUJQbkVrOTQ3blF6UG96aGZyM3A0TDE4WTE0SG1SNlMyK0hvSUd5YVlXZEVj?=
 =?utf-8?B?Um43T0R2eFd0c3lxTG5mYjllZUd3NGMvRzZmb3dEMXNWUnFxcXM0QjU1b09T?=
 =?utf-8?B?aVpyUm51bTFzRlVUN0h3ZVQxbmE3Q0Y5VHY3VWd1Z28xRDdZbHhpblZIQ1VK?=
 =?utf-8?B?T3dqdG1KTk1XNVdOVTVhZWNLdTR3NUxaWjR6ZkxpM0tkcHgyUi9jUlpLV1k4?=
 =?utf-8?B?VzAvVDB2d0xFUloxSUtna2Y1anIza2JEVVAycXEvUk5FV2VLTDUwbzVRNnJF?=
 =?utf-8?B?bkFzYnBCQ3RPdURaT2NLVk45bEdzS0kveFlDNndiNVJneUhKYXJnNW9TMEVG?=
 =?utf-8?B?cDRab25QRzFlZTNXUkVZcjUxNkYyaC9RalhTRFpDSUdFU1QrR0F0N2JZR1Ri?=
 =?utf-8?B?dGJ2a2NWVzNVRXY4SGNPRnhXMm5LRWR6OU9yakswU1A1VjBPYUFoOFdqVk1i?=
 =?utf-8?B?N2ZqMXkyVC9KcVpsdHRwK3hicWdmc04wSWtOY2R0TnFGQVl5MTFSZm1ySFF0?=
 =?utf-8?B?cUdSRldLbENTTUlURDM3YkxNLytOK250M2VQQnEwaUZSYXYwbzVSTGVKSzN3?=
 =?utf-8?B?dEsxdWJNUjZYNlNCbVp6TUhBdXBybk5sMEVKRnJLV0dzRVhsamh0WW0yV0tO?=
 =?utf-8?B?WWdEK0lzSmI2Vm5pOFZTeWp4RzdOZ284dzVZVStndEV2amxRckRhNXF1Wndt?=
 =?utf-8?B?QU9nU3lEWjRtQW01ZldaLzVKeHQwb2MvR2xEVzRXZEVKeHkzTEk1OGo0OURQ?=
 =?utf-8?B?OHZuVHkzR3A0TVlSV3IwSjBHNDhGQWJKL2wyZHpPQzUwYi8zZ3pNcWhEZXdM?=
 =?utf-8?B?cmUrVEkwaEMrNzFBczhHTFovZjBaZ2hBNEFJWEsrR3Q1aFROWkNkd2kzTm1Y?=
 =?utf-8?B?Y3pXZXZGYzV3RnNhVmt2TW5kbU9VbGlObUpUQTVORVlRYnlDYVk0a2IxaWRZ?=
 =?utf-8?B?bHp3MlFHanp6UEwzU0xMTHdIekw0TE82MjZaK0Rpd3ZGRUlkVVRsNVM2VWpZ?=
 =?utf-8?B?SmU3ckZvRFZzbUhwc0dRNldwN0YremYySENOMCs5Nkl2S24zM0JqVDVBWjlq?=
 =?utf-8?B?YkY3eGNMRTBydmFvbEZXaGsyUjArMEhDVXFzdGgzWnIweVdaOXlyVUVQSTly?=
 =?utf-8?B?bDdMNUZFTVZMOXhBa3gyM202bzNVSnBXb1Z4b0JPdzN6NWlIS0I2ay9lVDBH?=
 =?utf-8?B?V3VibnBQMUdlZ2dRMHVkazBxYzRZWHZKbXFVNkp6TjdlUkwvd0J2V2pmWHpt?=
 =?utf-8?B?dFBaRkVib0NDSS9WeW0zWXVpWmgwUUNGWGxBeEFHVEYwaDVnNGFON0VSWld2?=
 =?utf-8?B?QUZ0b3Nxb28yTnArUldUYzNtaTFCQzl3YXg1QVpWVE5YL1pDb0xsdVk5bDla?=
 =?utf-8?B?K0NTb1ZBTTh1aXE5Yjl6cURXbE1zN0dOcm1DYmllbTNsVWtFNVMzK2FydlZV?=
 =?utf-8?B?alRLcFVuWGg1RU41OVhMNjZic2lORWI4dlVxbFEvTCt5akdxaWRLaXd4NkZE?=
 =?utf-8?B?T0pUSmMwTENzMFppUmNSbFVIa2FSVjNrR2liRDFrb2dkbFZ6MW5xdzkvbHhZ?=
 =?utf-8?B?Q0VMUkd0dytTcHRxWTlsVVVmMjI5WkliWHhVb1pMTHpSQTdxcFhvRW1LYkJJ?=
 =?utf-8?B?SUhadXczbzBla2cwVHZ5bHRpVGUzY1M2cWlkZXhWSllKR0JiWWNYVHhVVkV1?=
 =?utf-8?B?MWQzYjVIRXErYzB1UUhVd1RmV2h5MWFleTZSRjFnaTdIZ1gvVm1nc0NJSzdo?=
 =?utf-8?B?QWJoY1VGeTZPU2JodmgxSmFEbW9ZcDRTdlkvT3R6eFRqNHRyUWx4TVdUTjgy?=
 =?utf-8?B?ZXZHTkNqVEdPdVlXZ0F5UmZsLzZSMHRJTGdFcjdmLzhIdE9Oa3JVRDNkRGZa?=
 =?utf-8?Q?oU3gp9Af/MFnq4IbQvvfIEhLJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 267fc8ce-5c87-4183-efb7-08dcee7a8984
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 07:08:44.4395 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8/Cik2Bnl4lSW253re8cXpK+gqTTlloK+kmP4sO6DRzN8+MiALCFD2rvgIyHqDAipUzlrfsqbHPEbsHT0K5r4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7812
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

U-Boot device tree is padded just after U-Boot proper.
After the whole stuff loaded to DRAM space, the device tree
area is conflict with BSS region before U-Boot relocation.

So any write to BSS area before reloc_fdt will corrupt the
device tree. Without the fix, there is issue that “binman_init
failed:-2” on i.MX8MP-EVK board.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 move the rev to malloc area in cpu_imx_plat
 tested on i.MX8MP EVK

 drivers/cpu/imx8_cpu.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/cpu/imx8_cpu.c b/drivers/cpu/imx8_cpu.c
index 6c0a8c0cbe4..b11f8dc0c91 100644
--- a/drivers/cpu/imx8_cpu.c
+++ b/drivers/cpu/imx8_cpu.c
@@ -20,10 +20,11 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+#define IMX_REV_LEN	4
 struct cpu_imx_plat {
 	const char *name;
-	const char *rev;
 	const char *type;
+	char rev[IMX_REV_LEN];
 	u32 cpu_rsrc;
 	u32 cpurev;
 	u32 freq_mhz;
@@ -69,28 +70,32 @@ static const char *get_imx_type_str(u32 imxtype)
 	}
 }
 
-static const char *get_imx_rev_str(u32 rev)
+static void get_imx_rev_str(struct cpu_imx_plat *plat, u32 rev)
 {
-	static char revision[4];
-
 	if (IS_ENABLED(CONFIG_IMX8)) {
+		char rev;
+
 		switch (rev) {
 		case CHIP_REV_A:
-			return "A";
+			rev = 'A';
+			break;
 		case CHIP_REV_B:
-			return "B";
+			rev = 'B';
+			break;
 		case CHIP_REV_C:
-			return "C";
+			rev = 'C';
+			break;
 		default:
-			return "?";
+			rev = '?';
+			break;
 		}
+		plat->rev[0] = rev;
+		plat->rev[1] = '\0';
 	} else {
-		revision[0] = '1' + (((rev & 0xf0) - CHIP_REV_1_0) >> 4);
-		revision[1] = '.';
-		revision[2] = '0' + (rev & 0xf);
-		revision[3] = '\0';
-
-		return revision;
+		plat->rev[0] = '1' + (((rev & 0xf0) - CHIP_REV_1_0) >> 4);
+		plat->rev[1] = '.';
+		plat->rev[2] = '0' + (rev & 0xf);
+		plat->rev[3] = '\0';
 	}
 }
 
@@ -318,7 +323,7 @@ static int imx_cpu_probe(struct udevice *dev)
 	set_core_data(dev);
 	cpurev = get_cpu_rev();
 	plat->cpurev = cpurev;
-	plat->rev = get_imx_rev_str(cpurev & 0xFFF);
+	get_imx_rev_str(plat, cpurev & 0xFFF);
 	plat->type = get_imx_type_str((cpurev & 0x1FF000) >> 12);
 	plat->freq_mhz = imx_get_cpu_rate(dev) / 1000000;
 	plat->mpidr = dev_read_addr(dev);
-- 
2.35.3

