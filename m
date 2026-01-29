Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87090D358E4
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 09:10:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1415A83B85;
	Thu, 29 Jan 2026 10:10:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bAdXgXxj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D46D083C29; Thu, 29 Jan 2026 10:10:27 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEAC883B03
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 10:10:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BhWq5l3f0RfuIng6TqXk32fX4uae3Fn9+bXUxQDwORV9Y1WjvYvNaRCEVJ1EvRFgxfXiFUZuXpbcYiz4M70Q7CB4Vz5UITRdOZWkDWWYaSDdqQd2nfiJECgJpFtkKQOZ2sTAIsDIoUbDBMHjFR+GfYxqcI452geod1m+uxx9sLSe6FGWjdl2Al8/XuJkIZo6jlgsTsLZ9pdqufUF0CacBTUAjTnRr2NwEdg7UwaQubYqDIhhrzUYhudX7bE6Yt9h/7wh1d4fmwetFTsPnbL92ZjY0StRmnNcIDZb0bBzrfdh0tlEKqfU1ZQAlqootelqJpwZyoroUW2BXQ3L6OPUng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6+jXbowlb/hA39wdUau/vpfq36FS8RVqgUvW+OrYPk=;
 b=FF5szeFcQaxWXIVKUOOCPREkG0aeXAqt1xtxDj8eIWsereH2pKElVlvifyBsSNBcAp7oMEj9ChFD/6Ye6XWDMoQtObq+x6l4eotE1TzNoAYLkmksWpygUmksVll6b8Nv7T81zPy7ehfSbnY3LiSxPIPhzHHTpylS+Mu+WcmDsuGzPoeZsVudvGPDY/iKVT2A+bFK6JbNiinarm828I+8ZOInh/Du/QBh2K7GYQbNtxfW8vRLbQ2vS6aVdBI6vaJTU3ScZI39UswpSGadVAvd8aSK45szeTGQcy984EtTju/X2H6a82X6UCgqnnZSEJFUENGACgSg4xoQKFw66kgDJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6+jXbowlb/hA39wdUau/vpfq36FS8RVqgUvW+OrYPk=;
 b=bAdXgXxjlXhmkYs/U42Q1VSMPolYCtUYwMSbPS1Ce4yRLe/ftzVw+FFrZIHJb4AUay7SPruqtN/I4e3yp+Wh4YbZNjeT0LQrPRiVZr2o925Da8loNBTzgmGOwH3AMg5zmUWuPw1V1Qpeo7BCtZT+/QN9vpFljMxNVDEnRz9vDt2MtXFhHcMn/0uRPUrTtj7sfoqjxpc/RvTMADdBCAvTbvUFgzMccDr3K1s2xH8izZCxkwvEw6ci4eYkRF1QZfm0lX723IZk1DHA/8GbRfeb6qQ0e2wkOXeMx6GPqbzyIC8WySB2cYsvx8xV8BIgsjZTFtvCxbIM3mTHGXILljCR/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PR3PR04MB7484.eurprd04.prod.outlook.com (2603:10a6:102:8d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 29 Jan
 2026 09:10:24 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 09:10:24 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 0/4] remoteproc: support i.MX95
Date: Thu, 29 Jan 2026 18:24:56 +0800
Message-Id: <20260129-imx95-rproc-v1-0-035b2dbf3e57@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHg1e2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQyNL3czcCktT3aKCovxk3STDJDPTZIskU5PkJCWgjoKi1LTMCrBp0bG
 1tQDwk6R3XQAAAA==
X-Change-ID: 20260129-imx95-rproc-b1b65c8b54cb
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PR3PR04MB7484:EE_
X-MS-Office365-Filtering-Correlation-Id: 78b72b2c-f9c3-455c-f00c-08de5f163c47
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bFc5N1BJaGJsQ2FXamFhTHV6Q21YQ3YwNWptOHVZVjczcDh5YUVPUTZsTkZU?=
 =?utf-8?B?TXJ0NW1CRk02anFNWHJiK3gxOExGV3pBWDBCTWtaY1dWVEF0UnVtc1JDcW92?=
 =?utf-8?B?TWNrYkVUenUyRm9SZkR6SVJyUWMzcXlsTmZ6NDhFK2V2bGQ0WFZESlJWVytI?=
 =?utf-8?B?VDRkaDZGWmhlSlJIZ1Z5V1ZUVDliT2ZDNnR3REx5RlRndGxTWnNQZ2JGM2ZD?=
 =?utf-8?B?N0w0NXhBNVNqUTY4aVlVTzJwdlNyaGo4ZnAydVpRMUZQVWdnUU94TlJWRExI?=
 =?utf-8?B?STV6OVgrb0NYbGR6NzE1a0E0bTJpZDBuNkt0bmNRS1ZFdVZvdjJGNTJNTWtM?=
 =?utf-8?B?UVZmelR5OUZVR1N1MDlRdW5uNDlLWlM3d1FMRHhId1RYdFUzYjZMZW1KdDVO?=
 =?utf-8?B?K082VWtLR2hxeDZPOHVieWNVeWNpcnd3dWh5bmlCN000ektOTW5SQXlSRWxF?=
 =?utf-8?B?NmV5OFZacXlRb1BxL0JrMEtBSVlwV2NPVHdaVUl1eFhEcXNlcnBZcjdIeUVp?=
 =?utf-8?B?cTQyRkxkOWNSYkRuYzdSbFRnWG1IQ0k3N2duMm5OMUI0dDVhUlBHcWhvb3Mw?=
 =?utf-8?B?azhvOHlWUU0wcXlmNnRPWG94ZVVKMVNaRnBLazJ5cWMzaE00K3B3WFpkcXU1?=
 =?utf-8?B?Uy9UVE93YkkzVnFibzdPRlV4c2xGNXBXV0ZJMXFDdXhINUt5M2VtMC96MlFZ?=
 =?utf-8?B?ak0yZXMraXJHcm9PL2RhM0JFZ1RDSU9kMzcrQy9PZHIvMkRxVHNDMkR5N2Jo?=
 =?utf-8?B?RnQvd2M5a1hsSW0xc2JlOXBySTVna2pBWVdWRWtEUk9ySzdQUmhJb1RJdUtJ?=
 =?utf-8?B?bWVWSG9MT3hKMVMreWxSZURGaUlxWWkwZXdFODZEZzIzVC9DL0RqcjZyWjZP?=
 =?utf-8?B?QXU5ZmJPS09oNUtaK0lZYzBPOHJEWkJtZTlKQnJUOVdyNGRyZTQ1TDZCamVE?=
 =?utf-8?B?Wk9sREJVYWZYd3VYTUN0VWtjU0ZUVEhNMUc1bkYxR3ZxRE1nUWZ2TXR2aUxE?=
 =?utf-8?B?YU80bFdjb2VwS0o0NlVCaHFORWNkckJmSUJ5SXZUMU91SDhITnhjU0FWeG0y?=
 =?utf-8?B?QkZzKzdySS9vN0xkdjZqTTkrOFprczV4NzJWb3hEUmNaM09NVVZTa1pXTnFB?=
 =?utf-8?B?QngxbXJLaUZ1U0poNzg5TjcrRm9GQVc1NGs2Ri8rL01ZTzZBUWhXL1VySlhF?=
 =?utf-8?B?dXJtMzNyMEU4N3dOcEVwL3V5WWhGSTA0ek5JTmg4aGRtck5TYkFPZkxJSFNC?=
 =?utf-8?B?dXZFeVFOb2JsdFBWcHBIOGNBVi84QlhpeVllVk82NEdhek00MERMWFRmVCtY?=
 =?utf-8?B?WXVUNzZ1cUFyaHF1YWZVVjdIL0RzVGkrT1pHRHdUblRIbmtGMDJkZk1TV1FW?=
 =?utf-8?B?YXBPSCt5VWkyQmloZWt2b3JKdmVMbG9Gb1AzS1dyT05BK0N0byt6K2ZaMU1B?=
 =?utf-8?B?ZDgrdDE3SXdXN2ppV3lpTjFmTkRXdGpCN1FuOEVDM0xWNmM2bUZxWkV2b2Vm?=
 =?utf-8?B?K3pQcW05dStnQjlHZWNkeW5RTUpRNlMzSXdBVXRpUjlzSWJMQU1QRjRLMklq?=
 =?utf-8?B?UjZxdERhMzg4eHorZmgwMzNJbnliVDZxalNJUVRYdkx6ZW81c1dNQmltTDNT?=
 =?utf-8?B?RExtL3dEYmxZTTEyRG0veUdyamdEc3djZGJuME5saFFIYUxxeThsZUw0a2I5?=
 =?utf-8?B?clZOYnoyL1ZXNmxjRWdEQ3lPY1FRa04wVjBFRXNiSWlQTENvQ2FZN2xzM0FW?=
 =?utf-8?B?NWRTVXVXZEtHWUxyMmVoQ2ovN1VaeFlNT01pNzBtbFBUSmplZk4vRVdmVmN3?=
 =?utf-8?B?UjhKM0RwKy9xaXBrSXJoSWM5L0FlRTN1WUNpWm03aWNGQUxIbG8rTkw3S0RV?=
 =?utf-8?B?L0tnN3FjZ2FlM3ZjcEVMY2RCYUVoNHZGKzFHZ2x6Z0dPY0RQcytlUmFmVFgr?=
 =?utf-8?B?QURvNGxRQUx5ZEFDYkVFcGF3Y3FKaW5rZzVoWkZNZklPM3BQWDFQQUQ0L0py?=
 =?utf-8?B?anNPT3BtbWhDaTRtYmppdHo5c1NOT0RZNnJpOHl5aG4weVdHMkdEMHErOGRJ?=
 =?utf-8?B?QVppQXJDK3NxdU14UnNoclNUUW05MVo3MU5LN2tJUzgxS3VWY3dhOXdra0tn?=
 =?utf-8?B?UUxEcUZocVdpd3ZuUEpwL2RuZS91WUoycGlJd3p4V0pTbFE4L08xZEMrcStI?=
 =?utf-8?Q?32wBH185Ju4lh5eqkC1mAGM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnFIYWhaZnVBRitSbDQ3TlBDcHNwbHlmbUFTd2VnV1dsOGZTajY0QXFBYVNC?=
 =?utf-8?B?dkNqMytadkdwTVM2YW1OTWF6Qm8xaEdoNzRIOC9vcGU3Mm9aVDFoU01aU245?=
 =?utf-8?B?WkRFTzlZRGIvS3pqVFgrRDAyQ3Ridkg1Qy9aaVN5ZDIyS2dXeFQ5eXM3RVZH?=
 =?utf-8?B?SkxuZTRBcmRlcUVHM3dGOWtKbzQ2ZVFLVm5jUjFHRzBiVkY2MGZtSW5uYVlM?=
 =?utf-8?B?TDBGZjlzMkhxaWJFRER1My9kV0tqd3VqOXh1RFl3VUdJWTdGMVJJQnltTTAv?=
 =?utf-8?B?TjNYS2lIZ08vb0NFYXJwWGdXaE04ejg4eDh4aUc5WlhHV2hNNmg3U2k5c2kz?=
 =?utf-8?B?Tkh6YlFkcjNtcTQ2aEFRNmFKLzFObk9CQ240bk9XYk1zTzhuQnRXNU1zckI3?=
 =?utf-8?B?alVFS1BaRlE4WVFEOGFSSXo4cnJqb1NxOFZrZnRwQjJiK3Y5Z1JORTlPRjVh?=
 =?utf-8?B?TW5Eek9vZ0IyNHRGdFVLTlluWXpvSGdoUlFQKzQrRytpcU5pdHdJVTY3VGdN?=
 =?utf-8?B?NkVPT3hiMm4xbWVhTjlTZ0NwcUxzTUI5MlJHbThBcGNteDhXWkNreTFrZFp1?=
 =?utf-8?B?QnBrWWQvRUJqZWRIeEt4STZQa0J0b3YyZnNSRDRDVGtVMGNWcDZidHc0MVNK?=
 =?utf-8?B?dnFWbzk4R1dtTG1QNlpGOVVHWGkrNEw4NXpiOFNRT3JXR3MvanRwZURsZ3NZ?=
 =?utf-8?B?M1NTTlRjcFFVaTdSL3BQYlZka2FLNllUMjViTW5IcWFvSFQrSnRqcGFBRFEw?=
 =?utf-8?B?R0ZLTjV2Q0dXSENualJRZVNQc1hmVnVwcE15TFNuUzZ1SHNETjl2RCtqMmRr?=
 =?utf-8?B?SHBFMHVFY3ZKTExNSVM5T2hWOUlvU2lwRkVJNGRuRHdJVGhKdFl1ZVAxQlVG?=
 =?utf-8?B?bmFuTkR1UHpkNW41cDhnVGJML1ZGSXdGV21vNUlScWYyaXhvaXJselFTa3lZ?=
 =?utf-8?B?WHJXT2kwamFPRXFiQW5YUTFja2pIa1lWMldrWENVbHZTclRSeXhKNi9Kb2Jq?=
 =?utf-8?B?bURWZy96cVR4Y1ZmQzdVSXg4L281L1JmdzRSWmR2OGY1TW5DYUVBOEFyZGRT?=
 =?utf-8?B?QnBSTm9MVis0N3hDRnVGbEdseUZjb2hrUzdxck9ibnZTeG01alNtdjNGNm9u?=
 =?utf-8?B?U05EZ05MMFh6Q1RBN2FBQnBBT1J3dWVnVXNyaC90NG9udDBsZzZnR2Z5R2kw?=
 =?utf-8?B?UExCVElJcmhNbWxpOTlVa2xReFBiSXlYb2dCYWg3U1dRVzJ3bmlBalhFc0hT?=
 =?utf-8?B?UFVXaG1abUd6ZnBFeFB6UFVJelR4cFYxTEhkcEFSRURIYlhzeE16OUFyRUli?=
 =?utf-8?B?dmVFRnJoTFkxRDd5NkFtOUJzcWpkcHRhdlBKZCtDNzg2b1FNcDVzYnRjVWVK?=
 =?utf-8?B?M0sralBtVjRvWCtidEZnejNHNWpub2RLV2s2YVZpc25vSUJIVXZidThKdXFs?=
 =?utf-8?B?RHZSR0FuQ29BNlliNFRVQ2FVWkJmbmVlT1ZzNnNCUXNvM0EzUmtzNTBZWHhM?=
 =?utf-8?B?UVlYVWZDME9FME1KL0JSOHVYL04xNXJKQ2kycWtFRFIwVkQ0K1BIWTJQTUU1?=
 =?utf-8?B?WTJiK0VTRVlmSHBxSkp4RGhXbmM2OUU3dFR5Nm5QWGFMZmoxSVZqZnJYS0cy?=
 =?utf-8?B?WDQ2VGJOQm9iOU5KZEpMMUliNmVEekZya0tKVExXc3JpMmQxT0RISEpuaWF6?=
 =?utf-8?B?elpKWEt3cnEwYWdMeFp2YWJPYnlRbmdCVk9kTjQ4azBsZVFVaFFCU3E0bnhH?=
 =?utf-8?B?N0xqcGZlYW1mLzVnS3N2Und5aExYbHdMM0tyMTErbVg1by8vc3A3Mk1DZmwx?=
 =?utf-8?B?QTcybzJPb3RtRnJONHZhYkRWMUJtcGQ2OU1lZ2lRb2R5MFBZRHc4bDRMVWpN?=
 =?utf-8?B?dFA2QmNsd0kydHRCNUlqZGR6Zlpoek1lTjFsRlB5UjNubi9PSXpYZjdYaDFT?=
 =?utf-8?B?c1ZXYkZFdFNVMUprTktYcllWb2xBcExDMldRZGQxMmZiZHQ2WGNSUzBaQnpE?=
 =?utf-8?B?Mlg1Qlphck9kK1FHREY2WUN1eGI4OTlKdHJweTdwN3poUyt0bFVHVWYzMkVX?=
 =?utf-8?B?UHBadU41Q2RLU3VXTWYvVUhPQkc2ZVRkUG1LRHFKSmR5dWpGOXBZUjhTcHM2?=
 =?utf-8?B?SjJDei9YMW5XUVplalA1SkYxdkpKOHRybXZJSFAremFPSTZJOHpPTjZMZmRO?=
 =?utf-8?B?WlVlNXBkM1JSUW9JdE8wVXBCMGlJZUVuME9kVUpZam0wdm5mU1ZncmdtRmFq?=
 =?utf-8?B?NmNOMjdBWmxwRWNQOWVKTFV6b1Bnc0U5Wi84NUtGRExMeUlScDQ3N3BLU1pT?=
 =?utf-8?B?ZDAwZXhWbTdCRnFJOU9hcXFOaFBtNWFTdW0xRkdUaVRNZ2lxMFJsdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b72b2c-f9c3-455c-f00c-08de5f163c47
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 09:10:23.9911 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 00SRl7u9PE5yDyW3zTgv19LqnATjM63N368VWVnV2RjpAQ3Exu1GZlqwfoV30JwjDoxNhG4LzcHDD/X5+I29Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7484
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

Support i.MX95 remoteproc. i.MX95 use SCMI Vendor protocol to manage
remote cores.

There are three cases for M7:
(1) M7 in a separate Logical Machine(LM) that Linux couldn't control it.
(2) M7 in a separate Logical Machine that Linux could control it using
    LMM protocol
(3) M7 runs in same Logical Machine as A55, so Linux could control it
    using CPU protocol

And because needs to do ECC initialization, patch 1 introduces a new
flag ATT_ECC to indicate whether the area needs to be cleared for ECC
initialization

In patch 2:
The current setup only targets for (2) and (3) to let U-Boot start
CM7. Need to extend the driver to using LMM and CPU protocol to manage the M7
core.
 - Compare linux LM ID(got using scmi_imx_lmm_info) and M7 LM ID(the ID
   is fixed as 1 in SM firmware if M7 is in a separate LM),
   if Linux LM ID is not same as M7 LM ID(linux and M7 in same LM), use
   LMM protocol to start/stop. Whether using CPU or LMM protocol to start/stop,
   the M7 status detection could use CPU protocol to detect started or not. So
   in imx_rproc_is_running, use scmi_imx_cpu_started to check the
   status of M7.
 - For above case (2), Use scmi_imx_lmm_power_boot to detect whether
   the M7 LM is under control of A55 LM.
 - For above case , after using SCMI_IMX_LMM_POWER_ON to check
   permission, scmi_imx_lmm_shutdown API should be called to shutdown
   the M7 LM.

patch 3 and 4 is for enabling remoteproc for i.MX95 EVK. The compatible
string is in linux-next tree, after it was added to linux upstream
imx95.dtsi, we could remove the changes in patch 3 in future.

CI build pass.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (4):
      remoteproc: imx: Support ECC initialization
      remoteproc: imx: Add i.MX95 support
      arm: dts: imx95: Add cm7 node
      imx9: Kconfig: Enable remoteproc for i.MX95 EVK

 arch/arm/dts/imx95-u-boot.dtsi |   4 +
 arch/arm/mach-imx/imx9/Kconfig |  12 +++
 drivers/remoteproc/imx_rproc.c | 189 +++++++++++++++++++++++++++++++++++++++--
 drivers/remoteproc/imx_rproc.h |   3 +
 4 files changed, 203 insertions(+), 5 deletions(-)
---
base-commit: 6a1bdb7e952d5841f42742fefa907cae5dc8d50a
change-id: 20260129-imx95-rproc-b1b65c8b54cb

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

