Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABCEBD358EE
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 09:41:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FF8F83EF9;
	Thu, 29 Jan 2026 10:39:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VZogZmTP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9231283EF9; Thu, 29 Jan 2026 10:39:53 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9D9683E52
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 10:39:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zl89F3u6HxnsNALHpsIESCQ+vRYjuukHCgnz9qgoRblpUHxtIIKsIaJfxouqlcUiOkDbIShYhVjHlHvp1QHpmVV330Wn3fEGo0Whdj5ZZVpjxp4dbcvyn8AUPXZVP/PQbw5fwN0aPOUtns5l2lE8I5HdoQrm8oszCYEYsdccZPayrY51dchOwjpNIo/opKB6oKTeVWFX4acJCVezTHegFJY+ZWqiqq1Lm57SJY02KomDBwC4p949AYTz4xSCOE3ueotC4xJbQ0Ood/nb4dhSefhjn0X+ogXZgybQGeGaa0EOuZiLQM78YkXaJTqiiC02l7j2eRbJ9sM5tNphbV3o9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVfo9CARaVVdQsbH9PWRby9JN77ZmzEP3IDIsO6PVd0=;
 b=h/4WA4pV86PguZ6iMWrCJ3gUxPE+WqUSk/aHW0D11e+qrO5DWPSklij5bxl1h3w8YS0zE9DiZAhiGjchJRiCgvoRvABorDTk4yLz/SLIkomVKu/ez2pLHKbr6A2BafSBnHiwRapyK/MYWNMUIVj9QQUCB4jSxHnJ2Q7rQfyPJO6TzmlWYa7Z+vdOErQrTP4DHHEzyDjj2VUiG31ZEkcSUBVVbdjXelphf6N4KZ5ml/4S+2Xvp1BrXLSaLRjPHVAIxPDyJ1b6g0bbMCDCVI+greCrH05v+NBo6vWa2zZUbuJCCdKEzCs6edhCb7Ia0GhnxuaBFtr3r/nkZL0F9kPzEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVfo9CARaVVdQsbH9PWRby9JN77ZmzEP3IDIsO6PVd0=;
 b=VZogZmTPGCC/uLv3bveWaJSmVOZ43faAtqvOO+GJ8orBsP55KFrhlALIH7LXKFKkICO/NGr/X0R3uxvmBDdXoyvM+nTVPxZ8aTpAOFQD//T2o/rrcKCeSLihVwnqeohDN42B+cfQEgM7ozVyn8eRKXhq7pjSVmmTBUdPjInMNcd6LawZU7VR9Z0F8Jo+5l80hB0sS7KNphZWUh/fir/yhNBg4cM5rpKXAnShVq6qulEycs60jwnFI4WyzCA6w2NTMqhbUKFYX7uuOIYxQRM9xGTMhg+zrW8gG6Mapc4Akr3HZicFkW+LG/xexnwsOfqFT1J6PFRHXk5p4cHPqzcscg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10384.eurprd04.prod.outlook.com (2603:10a6:150:1dc::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.10; Thu, 29 Jan
 2026 09:39:49 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 09:39:49 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 29 Jan 2026 18:54:11 +0800
Subject: [PATCH v2 09/12] imx8ulp_evk: Cleanup headers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260129-imx-clean-v2-v2-9-1245ad2c3a01@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 44da70ae-3add-42b4-51c0-08de5f1a58b2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OTJobkdIVjBFYWV1LzRzTFM0bENBMURSc3BCNkM0bitZWjZ6cDVsN01SY2Rv?=
 =?utf-8?B?c1R0WElySEF2VnlKRjJ4VTRzRUJvOU1Ta0pReTdXSDE0L2crY3QvSVhMQTho?=
 =?utf-8?B?WnlrM3Y5SjhnbXpVWnZVSmRtQ2g1UVl4TXZWOHFEYTdyTE42TGhvVWFPRnFv?=
 =?utf-8?B?OENMNkg2eDU0RkY0RkZoeEtEYXp6K1FObGJNUDVyUkM0eEJRVXRweDBwa1Mx?=
 =?utf-8?B?TzBqMUJLSkpXQ3RGQ1dLemZ5V3c1ejVyZHIwbEw5bEtQYi9seEhmN1NIREdn?=
 =?utf-8?B?R3FOZ3BZNXBlUEU1YUJMbU9ZaTNWNWlaOEhiOWVEemtRSUFRME1idWFzelgv?=
 =?utf-8?B?bUZxUjQ3V0ZocjhVU2FNWmV3bjM1dE5aNGFlRGdCK2hxeU1BakNXeUhURGJq?=
 =?utf-8?B?UEMzQ2NzVzdocUxVZjhVenRQci9rdWsrejVueVhvemsxazA1blB6d3dwRTB1?=
 =?utf-8?B?RjFRY1djNmV1UGZ6eFYyRHdxZUROR3hBQVg2cVdCTFV3bGxzUFVkZVRLdUZw?=
 =?utf-8?B?SktyS0pnVGZhMmhVN2pOVXp6ejkwcFp1UGExaTF6NzF6RWFhdkwxOXNaWFVS?=
 =?utf-8?B?K1Z3cm9vbWZVQWoyeFVVVndNSm1XaU9mY1JIWE1IbWN4aDdJVCtaa0xnZ1lt?=
 =?utf-8?B?eFNpdzdLd05odUZpbWdkTHVRSjBOalY3WnpDaDJWbWVEVUVHSEZBc0lCVW9B?=
 =?utf-8?B?OVRQbkhLZjBXQ1JrT01BZUlYRUJhTkNGK256bXE1SldOazVOK09nekdLTENw?=
 =?utf-8?B?QkREcGtXTHNrVEg3c2oyRDI2a2RGS1N3S3I3ZWthY2NuVEcrbDFVVEQwRGdX?=
 =?utf-8?B?TEhBWHFXYkx4Rm5IUzFpR2wrYUhCa01VY0w5TFQ2T3hleWo0ZTN1cHpqTjE4?=
 =?utf-8?B?cUFjN1p4dU84Y3dtdVRvaXhLa1hPbHloUEUydndndXZMVmFBc3JoalpsRFFO?=
 =?utf-8?B?YmlxbUxGTVluWGttNnNkK0IvMVB6Z1hkZW5qdmJLeVRiR0NiVXZ5dHlIT05I?=
 =?utf-8?B?RWNER2tTQ3hxLzlZSmF2VW1wWlBFeXg0THE5TDRNNUNncCtucGNGc0d1dmhQ?=
 =?utf-8?B?SXRyanBiLzdkcXB2dWhGUTFzc094N3dueVBBSGdaMEVSay9kcFhFWm45cHBJ?=
 =?utf-8?B?aHArTW1IWXdJOVIyRWVYVHQzenpGT1h6OE9VZ3JaTTFNVEZpWk5uQ2hxbGl1?=
 =?utf-8?B?a211WWxqS1NVbjAwa3daZ1JXTENXdWo1REpTZWJoT28yeGJlWEJ5RkM0YnE5?=
 =?utf-8?B?clBSSDdPelBOaTlMOWlEK0NtdXFyYjV6Qm9EWGpuaktPR1NZblNwem5SbVlr?=
 =?utf-8?B?bWo1ZHpRdkJiYi91K3VqeG9wWDUzQVlDOU9XNkJ1allLcUxmSWRINVBHNWo3?=
 =?utf-8?B?dVN1ZGNzaEd0QUc4SkZkbHJJU1gydE83MzFqdEVTQmFlZ3ZnajE1WU4rNGh4?=
 =?utf-8?B?aFJJNHc2ZXNUZ2FOVzdhL2ZkbVpGbW5aWDBSRVdJMGtDaGpzNDdWWDMvdDEr?=
 =?utf-8?B?amR3V1Y1bUpIeHZNOEJvNkVsTWlGdzY4NnNWMUNKSWVMbk5TWWpBQjV3dkJo?=
 =?utf-8?B?M0xTQW5wamgxclp6TGtEWFhXRm53Snl4UGJaV0NLVGxER3RkekNUdXE5MGc1?=
 =?utf-8?B?MmlCMUxNd0ZEM3BpR05YUFNyRHQ4YzVaaGJhUnZCL01ZS0d1Nm9YSnFsYm1a?=
 =?utf-8?B?Q28xRGRHaWFQMDFrWmZ5WWhmRGdrT2VlaFVhczlqWGg3ekNwWWZFRGFyTXJh?=
 =?utf-8?B?QlVsMG9xbXFxNEVzRmN5bWl6T1ZrTmMvWU9HV2Q3d2NWOEVKRkc1cDhKSXdS?=
 =?utf-8?B?dlUrbU56bWx2SEdLQkRsRjNsV2FiKzlKdHN6dVlkRGZ6SzhLaEU3alNKa0dD?=
 =?utf-8?B?cTNDUlVjTTRYMHRTeDQrSFpINHJJclFQVm5HeTNvN1J1V0JUV09XbDVUYTdG?=
 =?utf-8?B?ejR1QlVLSTY1Tkp2eVdPZzJ2cGp1czViUzRRRUx5amhOTTEvdUF4emdaQUdm?=
 =?utf-8?B?QUpJdzhtZVJlUCtVUTVUNnhnVE0zS0dOMDlMMjJHMEJ4RnIyYTFidEROYzRO?=
 =?utf-8?B?NVUrOGorcjc3MXEwSVVBaHhqc3ZrcUdaZ05KaUgwb3pvaDhMWG51a3ZBTUc2?=
 =?utf-8?B?OU9vQ2tIQXZtanJiQk5WQ2x5cmV3OE5YKzlWVXZvTmtqc25ndnM0Yzl5d2Q4?=
 =?utf-8?Q?nu1hCF19luVUpOdYadXtKGc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UitFbDVmTjhvdkxmN3NybDRuVTJZbzFCTXBXNi9FZjJoQ0dQRmJjb25BbWpM?=
 =?utf-8?B?N0tKdXF1UEYwR2RQNUFOUTJ6akxUVjJWVmUyNWQ3QmRUK1R1clB0Z1R1Zzhh?=
 =?utf-8?B?cFMyK01EaVFNM3FUVW1iWkJyRk12TXJXOWRIYlhVWWpKSUpDTWJVSzJUYWFw?=
 =?utf-8?B?RFJHbkRmWEpySE1Kcjh2T3VBYWlvM1ltb1NJaUJ2NTllNHRXVUYwVmJRZ1lt?=
 =?utf-8?B?M2JOK0ZWaGlXaUVreHYxbkVvTU1zaCt0Z3ZPRmFsd0UyWGdacHdhWWw4V2hz?=
 =?utf-8?B?UmdMUTFpMGUxdmp4SDVRdDk4ZHhmcWs1M2kxbXpzd3hJMUZQamZBTXBuZ090?=
 =?utf-8?B?ZXk0VDBXbWczcUthOVE0a2JBdHFvcXRSbExSNUVHanMrbXdENHJPZndMeW9I?=
 =?utf-8?B?VXpmbXhraUROWFhJQnpFQnNzZmJIT1Jqdmd2eTdMUWFQR2JOWHhWeUR4VGhW?=
 =?utf-8?B?V0tQOWZyaVFRWE1mQzQyRTNzYjg0ZzREMHAyM0dhQXRldXE0MjEyUnkzQ0VI?=
 =?utf-8?B?QjZyVUpQNU9Sbk9UN1UwdXU2QmFuT0xLTEFPTy9sK3E1ZW1IMU14TWNYVXYw?=
 =?utf-8?B?eHViZFBZVTlrWVg4OUd0eEtraDZGd1JtYlZmT0crOCtleFA2aFk3WmR1c3pY?=
 =?utf-8?B?NzVwVzcxejREbVpPdUJrU3phVDVLdklZVFBXZTI4UjltMlZvSFV3SUs0WXNM?=
 =?utf-8?B?YUM0dGY1WjA1R0pIT1pvSkp3QjZrdE03Y1hvbzEySjRwdkVNRkRnN3RGSG5B?=
 =?utf-8?B?WDY0b2g0QW9RdmQxV1owTjlVTXJHeDVyQVh6dGc5UGRyUU9VVEFLVGtNaTBQ?=
 =?utf-8?B?SEhFa3hWMHhueUNzQlVUZjhrUTY0cjFuQ1dYQnFuRTVnMVpKQkhGd1EvakxP?=
 =?utf-8?B?TnNjVmJPVjF3QlJLQmFucUFXR09ONEYrWmgxdTRJMmdZdXVsUUJ5NVN1SFFy?=
 =?utf-8?B?SVRhbjdMMzhQZ3NJNDltdWVKd1c4YjJUYXgvL0ovOFBjUS9weXlvdWlqaUlz?=
 =?utf-8?B?WFlOVWpZV2t3UXBhWElnT0dSMHRJNEFRN0ZKdFhQbTBaOGZYYUNuTmVnWGFl?=
 =?utf-8?B?RnFzN0ppU0I1ZkUzY3pyZDIva1UzMHc3Z0NhNE13b2tTQ25iM3YvTmRpRVIx?=
 =?utf-8?B?WUkzeS96NkN6OXZGQk9uc0ZPZVp5Vy91cTBsK3ZJNUp4KzU4b1ZXdWF0ejla?=
 =?utf-8?B?NS83R2gwbG5TaG5mOTVmZkZyWFE2bFNnWFdUN04xZC9yZjY3a0ViaG9ETHR2?=
 =?utf-8?B?azE4SVZSN0Z0U1JYUVhyeGYrektUUEZIWFU3UEUrNFlQb1c2NWlKSnVzK0Z4?=
 =?utf-8?B?QXhsR2RDR0MvMEtWUmZadTN6ZWZMRklSWllza0Z2dytUdHcvRFBOVmloUVlN?=
 =?utf-8?B?TzFraTBITXBRZFB0SjFRMFRFSXRtdFVYSnU2bzgvdkpSSjJ3WWlnTVhoalZi?=
 =?utf-8?B?Lzc4ZXZLYUFhMW5OTGFtdzNGakttWWNwQWFvQlkxMm96bFN6NWNrSUdzUTJw?=
 =?utf-8?B?OFExVFphVXZBRUNRN3MveVA5M3Y3YkZnWHlyS0N0SktQMjhHMWQ3dzduQnA5?=
 =?utf-8?B?cHFGQ1FyUE9qZkRlWlVQdmZmWmJ3WVZBUkpxcjJ4c1JYOGJ5bFJ5alEvOVdi?=
 =?utf-8?B?VzRPWW5yZjcwcWJ6V05IM09iVHBibytIbG9XNUc2NWxUVFdCbmdjVEJhWXBN?=
 =?utf-8?B?bTY3UFEwaGpybTNBaUxnODBGUllUekJlMEF5dmtLZmQrTDNqKzBDeHNDUnRF?=
 =?utf-8?B?V1Z0T0o5NEtwYS9VQnJqYWtON0VqNlhWM1FsNDZlRGhXOXVtbnV5WWVMMWhk?=
 =?utf-8?B?eXV5bEhjOTlVcUlDWllGRncyTnZHYlpKaE81ZUNjZWlOR1ZLaHBGbW1qb3g1?=
 =?utf-8?B?TW9XWThmSGorNFlhU1VpSXl0U0xKN25qMEVUYkUzVmdxNjJUejFLSFBBVmts?=
 =?utf-8?B?WSsvOGRjUUs5a2FRWXFxVVhxMEVDeUpPSW5ST0wrRGFlZ3ZhT2phaXJRQnM3?=
 =?utf-8?B?c2Z0dFZHQzFaV3Yrc0RyeFJUbjdWK3FTc2RQYmxUV2d2QStvTkIydkJmWjQx?=
 =?utf-8?B?R0JrMHE4WmtCU0NsU3padFcxbkdMWE9xVzhvOFBYbHViU1dVVXEyWTRwNXo1?=
 =?utf-8?B?VHBMUXpMbjJ5cTh3czVXVERNUXpwTWFKSXpidkFTRzBEVGZGWHZ6MDhNdU9t?=
 =?utf-8?B?alFqcThFS0RLaVlscUcydHZwbFVYY0tOQkVwNUhncWx1K1pqV0gvYnRaL251?=
 =?utf-8?B?ZHkrY2RFeUtaQ0ZIZjlIcEM0ajJ4WGJ2NGJvRWcwN3ptWTh2YllWZmRaMmtp?=
 =?utf-8?B?L1BYQzlJcExSeEIvRkUxQWxSQVBIZ2NFVHR6d0lObUlUMklSTFFmZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44da70ae-3add-42b4-51c0-08de5f1a58b2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 09:39:49.6959 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ROkMGqW+Uks3uE2ZeS7TATWke8wTpHJUUAblGWUwPOi5P2XTDgYvqqvVO/neH3p+rSG6N2uovkD+mTXBryIkXA==
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

Drop unused headers and sort them.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/nxp/imx8ulp_evk/imx8ulp_evk.c |  4 ++--
 board/nxp/imx8ulp_evk/spl.c         | 10 +---------
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/board/nxp/imx8ulp_evk/imx8ulp_evk.c b/board/nxp/imx8ulp_evk/imx8ulp_evk.c
index dc4054b92be..cc34ecdec20 100644
--- a/board/nxp/imx8ulp_evk/imx8ulp_evk.c
+++ b/board/nxp/imx8ulp_evk/imx8ulp_evk.c
@@ -4,11 +4,11 @@
  */
 
 #include <env.h>
-#include <asm/arch/imx8ulp-pins.h>
+#include <asm/gpio.h>
 #include <asm/arch/clock.h>
+#include <asm/arch/imx8ulp-pins.h>
 #include <asm/arch/pcc.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/gpio.h>
 
 #if IS_ENABLED(CONFIG_FEC_MXC)
 #define ENET_CLK_PAD_CTRL	(PAD_CTL_PUS_UP | PAD_CTL_DSE | PAD_CTL_IBE_ENABLE)
diff --git a/board/nxp/imx8ulp_evk/spl.c b/board/nxp/imx8ulp_evk/spl.c
index 656c2723494..162b3a1a2e0 100644
--- a/board/nxp/imx8ulp_evk/spl.c
+++ b/board/nxp/imx8ulp_evk/spl.c
@@ -5,21 +5,13 @@
 
 #include <init.h>
 #include <spl.h>
-#include <asm/io.h>
-#include <errno.h>
+#include <asm/sections.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/arch/clock.h>
-#include <asm/arch/imx8ulp-pins.h>
-#include <dm/uclass.h>
-#include <dm/device.h>
-#include <dm/uclass-internal.h>
-#include <dm/device-internal.h>
-#include <dm/lists.h>
 #include <asm/arch/ddr.h>
 #include <asm/arch/rdc.h>
 #include <asm/arch/upower.h>
 #include <asm/mach-imx/ele_api.h>
-#include <asm/sections.h>
 
 void spl_dram_init(void)
 {

-- 
2.51.0

