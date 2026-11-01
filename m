Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D256606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 09:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=scEQS3Ha;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=Vek4mStv
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1E9B94055A;
	Sun,  1 Nov 2026 09:17:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vXT9lzjxzRPb; Sun,  1 Nov 2026 09:17:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5E0B140587
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793524664;
	b=eVAOPEpyTJr8RIUkqWdhZoGu4Hymbp2AichPoHgbMF+UNOsmuYioOTExaWSCilw3hxxP
	 ayNsAeJ8o1k5Ikgv9D0lPgbg7rNrRXHtwAxZQpZ7H2eGdpF0pZdbkN7eOARuHLEolhx2f
	 TyubeH6YTQ+ZVQOfYzws05WzYahxhA53hQqRWGF3NoVQ7EGo3LDQyn07w2EvETh2AjZ5S
	 2oD1V8reCM2Luw3H1W/xFusx2OXHfxD0PfI9jTS/BO/lIKvOnoK/vhwnC4/FuFMfy3Mo6
	 sevj4RGxuhEdmWtpv8BCxo926QAogXjitkX5Eedocon42tjT7BOPtpoB4RVvFpldYAA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793524664;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=nI/goIBlsOBDRY8z5fhBfIH6FKY+mAghvwkC6nJj5g8=;
	b=N5sjADSn8aUsSPjB87tm4YedMUP6Fa/mHtqSu2LbPnTkGIrOzRkida/9dLcH82fhvCJL
	 MHBW90gXeRCFb7tGdCfgIc1o8E3XmwKH6Jq/2kNBSHlguTTi5WA+S8Q5dG7tFJBqSEEzL
	 5cJPL+GFQH6bVsyMT0xOC/ZJuwOox2NpKc8Ri9/csyb6o954bCOsrJXElurFCI9wEpfZh
	 mVL2PoNPwuVg+Yzq/H2fdt9B425CWPdJ/sYqvLXpo/APh5KHgnbMrkMON7uCWbecVl3U1
	 HtoIBrPnekw7an+vfLITL+kw1rtdRcShQN+lN82eenpq3+59GQSzRhq/CSwOcqgxLQw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793524664;
	bh=nI/goIBlsOBDRY8z5fhBfIH6FKY+mAghvwkC6nJj5g8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=scEQS3HaVJwrj8Cx2VxjGD04ysRWd9p4xkCWXPGffOLQPcRbDx2HBl7UVJWyps0eC
	 wtihXFoQjx7TWs0JtFpTI09H9wG5XpNvC9p+2cLiicuL9NpYyWFPXyYg3JndlPVs1W
	 YUfyx+1nATPtM/b4HxjIOUPXexnECox4zMlX3LAGAeo3UaSwLQhaBlWPQtnmqITzCD
	 E8zX8q2AoXIPiuBpNc8tCARSLvBoCJgaZzTNbDxYsn9bSPCBKca+fzMxQIySMDCgEp
	 8UigO3SYS9bIKSMV6pDFie+tLelnIhe7REP5Y9ZNmfikqSxJ5Lh9JiE9wliGtWmaat
	 xrsFM+N5v+U9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5E0B140587;
	Sun,  1 Nov 2026 09:17:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 88899156
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 09:17:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6EC3C400C8
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 09:17:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id smn9ZxNJkuOh for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 09:17:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 954764004D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c101::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793524661;
 b=SmXAi3rV4maf473jenHVAjVkKyU8SEvNshnNiInJMHS4dR9UtydS4cD54KO9poABThyt
 BgWu/MsiWAu5FOA32y/WR8ib0b1/XCU2N1KNOK2z2oKqE9m+6nWrzmMbl33pxZblDaWh9
 J6Msm6BWPjR3uhr7lOhKEi+wNjezhMe5wV5basMlLfAFP8QHRuktNIw56cvJz4LZvJUfX
 gyr31lbN8SaMR2kwhUHcAGbQp/3Tod266DGWTVSsYHNd/tNaM6BHUIBR+G8vZ24CV2m5v
 jfA7UKxtkBDzPNcznmA+Ik6wKKxzw6mYpYP7OEeBiYOxlMkvzZFMbqjWOj37rA4tdkQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793524661;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=nI/goIBlsOBDRY8z5fhBfIH6FKY+mAghvwkC6nJj5g8=;
 b=allaSdos8QHhvaGnBXb9FNQ2K0Tbfhcszl2PUz08/+Kuw2w+bdl3pZGNbk5vsY55V4ZI
 b8yn7u5/EOK1kNONcyynMfD3FoQVSdau0gPuf/FU/92wU7CoZIQipHqoVUc5EDF75Ndt6
 2D1cbJ1lNYov1srcBud1e7/lrHFd7Ytt/oEr/y9kUlPUoMNy66aYLkXE78T1z9lQaMNdJ
 rRvLKNGsdea7uvKP5l4IHB9ZlvzOB/p71KqmCX4Z1+RmekDMSxS6ltyJqNDCN7g7+y0cG
 ciyB+CW3SOtDSVhJ0/s9FGLrHXEpi9ZJ0zIw7L0HDKOGKfr+6S9MQ/ROLmosfjciPUg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=altera.com;
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=Vek4mStv; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c101::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c101::7;
 helo=bl0pr03cu003.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=Vek4mStv
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 954764004D
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 09:17:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y3PVemm0g0pMzih1TlpQbiHaFGEDwItgOk2zDzfojonhu1gR4XlBooSqSRRapPhCrcymhh6Y2xl0jdSVaWEbXRPoNNFi0XyKX97jgnNlwoot4PnIEmOBt4qTQvtDHG+ZaJjUT70gYIVVaJHGf0eq3Eh6kw7hKsgrI/dBQiWQZOFmq6UC0pkG8Xnj9Vf8/o+VgE2kMAfEzVBPNjO5OSDWVK2vafEQ37HEMkIzCvrKtWbTADSQjtHw+T4gQbdS/lip7unv7rGRoWVMObUgcQQki7YcuYqn+XSHgB+5P45EpryIFTdyo9mK9S+hvyl26d8HlJImTjG1LLHx+EpMJOAc1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nI/goIBlsOBDRY8z5fhBfIH6FKY+mAghvwkC6nJj5g8=;
 b=GAjq4TOSIXtjQkRUMoBlK3E0ye16h8G1+K4m9i5cehH1jejjNTD7I8EwHutBlV+059Bzzxes4dlgZNrFDGZGJVgfXFeNZezyxW3VIFcAsxZg+1OiIRS2DecbdJ4cU0gr7B/YDfl594eP3EVoXuAZnHcnr8KB5ZGtZenOtFP0vapHQwajNLY05FTTsJxdfwLx4vpf5b05UKFl3zvE4Tw+mp7HrK0L+rfis5gXaYHKOu2dOTMBHRB8KoKoTNgPc7Py+BU/a25C1HXpuPxLcriaO2mBsttMcHOT2ldzl5kehOgIEq+yZmSEAPpD8k7mb5Vtr6D+jGB021rrb8LyzQdQqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nI/goIBlsOBDRY8z5fhBfIH6FKY+mAghvwkC6nJj5g8=;
 b=Vek4mStvREoCCqZdgAhWcv0UFNUfvYXAM3BfPN6Ab8ylNg2gBN/9ZX996XmrMtzG2XCHdkJljzk35WTdopXD83mCouGM0GQOT2+8CnsvlIs5D51fbyDeeveNSIqpwQN8t3lShz9+jBpAePlKLoijzX0tYdPLmK4fxcButTIYHLx1at3aDDp0omTV6vGsAHo3poXlQpzfj16hzeFAM/mT5nhu7CJU4IcB1/bYFjxXOQqTomri6K6jXoY5tKqNC/el6SwWfxT3P0d/p8Qq61NqW5Hmplfn4n/Q1F5ckBHS1Qgo0dNf83SLPhtKKlu/dym8+LKwOvf9jEzLMDbDQxnAnA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by DS2PR03MB166725.namprd03.prod.outlook.com (2603:10b6:8:3c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Sun, 1 Nov
 2026 09:17:34 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0569.010; Sun, 1 Nov 2026
 09:17:34 +0000
Message-ID: <00e66a4e-4afc-42c7-8afd-ca59df81ce81@altera.com>
Date: Sun, 1 Nov 2026 14:47:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: msm_sdhci: drop SDHCI_QUIRK_WAIT_SEND_CMD
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
References: <20261030-msm-sdhci-wait-send-cmd-v1-1-6ef678db1585@oss.qualcomm.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <20261030-msm-sdhci-wait-send-cmd-v1-1-6ef678db1585@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0154.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::7) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|DS2PR03MB166725:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c31fe5a-6b32-4a67-3517-08df37f8f6ed
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|7416014|11063799006|56012099006|261009223027099003|261028144727099003|261021121427099003|261021123027099003|261026121527099003|261022075727099003|261022105027099003|261026140227099003|10067099003|55112099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: YfPE9VoTZB5h0EpZpVOpfp/40ZZy18TAnLrCD9vqLDu7PeqcI+kzNbDJlwnHKmO0ijD8UaH7MCnLxQapTQYMzOk6ACXWMiCTMFtF1JO6zos85/gC0Ce5igoeiu2WHarUgrAoG6UvWJlQE+ly0J3Yhip1MEKV7rGeZUPXHLS5J9aanWxouKx8JSyjHpKcHgBAxyYq/uURStMTV6I3SLpx22X4c9lZqgElNLagx+W554tSqoTk2s4YPRW0/Rc5KGtY855lKUcjHc1XAfvCWedT977mZRQMZLYJET5P/ADKSBSUaWs/BDBpEF/vFl9x5Sh4op6MVXr9blVfIjVSKtqZC32UyOd3VQKkoy7zMtj6ZJL+ck7DomIFYMi7SHKke60r5cC4hCu7gPOW3mzQuVBiVAyDRSvyHEtG/IE/YC0CTYHtRiEfEVTN7ve/xVTUPcIS9OGSId8xOWOImjUcx0BTu8lDbfaLuaX2Fv0m5HWXPh1wKMD90J8KcngMAkIRmf1cUk5m5iUxVYbeCLsoWqaYEY1IsD7AdMoR0VXKq0m15DyL0wlAd1wvsiYgrb3jiu7Bt+73aMvZWHvYagp3LfceatDgBquIhP/bi4Xklgbf1vkqiIo+9O5ywQ14rjhmLfzd/utTBa1zA8+IFvUk0pWDh2x+U2aqTaPDcevuVOgK5nc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261021121427099003)(261021123027099003)(261026121527099003)(261022075727099003)(261022105027099003)(261026140227099003)(10067099003)(55112099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGtRQ1BtM1I3eWxIV2IyNitTT0IzMW9yR0o5NTdIVGRqalBVbDM3b3IwWFhO?=
 =?utf-8?B?bmh0L0JEMmZNdENTYmVCdXVkREE1S1NidTFiU20vdVdGN3FHRHpiN3cyVElD?=
 =?utf-8?B?Mlh3ODJ1REFTaDVHNkpieE55dVViMGZGZ2toL0xnRk5vcEo3L3drUGdkZEo1?=
 =?utf-8?B?NXA0VERvVkEySFk3b0xrenV0ejBpZzB1djc0UFlWM1NNb3Exbk9QSVc3UnhZ?=
 =?utf-8?B?Q2VjTjJJdElnckZwbURhWkhYWk0wbmRDa3RhOFF6eWNWa3NuK0JoOVhoK01x?=
 =?utf-8?B?T3NTa1RBOTcvRGFCclp1eFNDYlBIa2pJRXRqanJ2cG8za1F3bEdqbk5kc1h3?=
 =?utf-8?B?dlQxV3RLdkpTd010ZWdac1hRdXJZbWwrVWdYWFJjTUVDRnZLeHFhTDRxaGFZ?=
 =?utf-8?B?SFZOZDVPL01hQ3B3K2ZxYU9hYkZOeHI0Qk5VWk83dlNXWGdBTUFucEhMREh1?=
 =?utf-8?B?YWNUM2xkakx4TjFWUndTMEFjdXppdHkvUjVaaTNKaXNoV0VFMFV2NjhFOFBX?=
 =?utf-8?B?azF0bElzUks5aERucVRsTUxNYmpNQmJUSXMzWFNjQ0tFVVVKb1BvTzZjSVBQ?=
 =?utf-8?B?UkdOR1VyVHRFdUdVcHA5dXhrZGZ3WTcxSEdKQnM1WFZrZVVWL3k0ZG5rbE1q?=
 =?utf-8?B?TXJkaU8wNStrUWs3dS90RGkvd3hoNnU0Q2JvdW90Rllzc0x6OTJkNUkrVDhx?=
 =?utf-8?B?ekNZT01GeXFSYkNaUFJSaFdSNHJUUUhJZ1NtNjZGck1qOHRVUk1BVjNGcjVK?=
 =?utf-8?B?MmZIWG5OOG9ZWnA2S2g0ajdvL1NxdFdJN2h3bjFEVXpBV0pITThLaFNqaHNF?=
 =?utf-8?B?RjZLYjkzSW0vMVVvN1JNd2tjaENNSis2bjB2anVvNktzRDRpc1piSG9IUGlO?=
 =?utf-8?B?ZlZqN0NMT2w3WUMxcEpiUWJ5aEErM1FOa1N0UGphNTh4R1R5VVBDcWl0eVRK?=
 =?utf-8?B?NndxM29paU0zbm13eGlMalgzYzlxWTRvbXJTVVVYQUw3NjBGNG5FL2NITDdm?=
 =?utf-8?B?akdHUnp5eVBnT3A3VnRpZERZcFMwU0FDWlVRZ0NsNitoSDg2R0ZCam8ySEZ0?=
 =?utf-8?B?WmNTK1ZiZGNQTkZWMnJWbXUxYklQUWYrWVRGMnI4c2x6b0FjOFJlNkdPdS9p?=
 =?utf-8?B?eTFpYVg2TTJkS3ZDNWlia1BCdkhaKzhXTWxsVGYvY3Fpa2d1QmxsZndoR0du?=
 =?utf-8?B?UTF5SEU5K3hsWFFiYUs1U1JxcStiNkRDRkpZK1RaaWE2c3JILzQ4WGJkNGtl?=
 =?utf-8?B?QlhZbzNMM2JPMG1YeHZ5Y2kxdDBTV2YyK3BJc3BZeXhWUzVhYXFZejl1NmxN?=
 =?utf-8?B?cUluRC9XTHFIbDZWMEhlakZYUVhMKzltbHF5aVgzSG1JR1FQbEhaMGNJSEhD?=
 =?utf-8?B?WlFRVnNNK1g2ZTRRVXhnYW11ZmV4dDhVTmlScklQRmNjK1J3SWxINzR5TU01?=
 =?utf-8?B?am5XUjdNMjRHc3BLdkxrZDE4dWhETVNlS3czZllGWGFyY05CWWNMbVFTWld2?=
 =?utf-8?B?c3g0TmVrZExMbFpmZTRQWjBTTVFDNjVKMkFqNGlDRlU1ZVduUUlOUTY1a2hO?=
 =?utf-8?B?bFdLMkptRlJvOU5tNytVbFduTldab3RtNkZlOWNhVFc2R1cwTTFTcE8xTVBP?=
 =?utf-8?B?Z0hqNjVhV2VlSHJYUEZySzNzK0FPY3FUanlPeklCOXpGN0xQRzZ2TmxZcEVE?=
 =?utf-8?B?MXg5eWxleEU3cTFWYWNVTmRkU3ByZlVrZkJaWXNucmUzZjJaNlllNW5yblkz?=
 =?utf-8?B?V2FTczh3dHVPZ1QxMXY4WTZoK2xxV3V5MmFwMm94bUV1UHp3UjczdGpCaENN?=
 =?utf-8?B?NkxqM05vV0kxTnYveGhIWDdVOVo5NU9EdHdCQ0ZHN2l6b0dEVXZ6VkR3RDVH?=
 =?utf-8?B?d1NFUS90dHlGMUlNcUl6aTBPMHR1UnpOOFZVUGRIZUIrN3ZsWlc2OWhiTlEz?=
 =?utf-8?B?Q0JzV1NIdVBBQkZjM0JZZWVMK3NQSnpnYVNLcDFXYi8wUmtDaXRkZ2J3VDRL?=
 =?utf-8?B?WnNvVk43TmljQ0d0TSttUWtPVjY1SythTnRpaDZHMEovNHgvcmtMS1pSczlp?=
 =?utf-8?B?OEFSMks2ckZEazFOZHJ4TFl0WnBDUnZhZ21rbjhtQmwzUTFac2orVVZOZFVl?=
 =?utf-8?B?SjlZUTZaZDd4MUlmd2lFclhSakIxN1ladk9jUjU3dGtVa3UyeUxrL2FzM2M4?=
 =?utf-8?B?aElWNGhBdnlIWUh2bGN0cFdMOGxrVTFKdGtiY0g5R3R2TDVuUlJIUkM3TERR?=
 =?utf-8?B?Vzk0T3dvbTc4UmMxN0toSkJjNlg4WUdhQ1hISmkwS0JPK1ZzSUkxOENoRXJD?=
 =?utf-8?B?WVI5WU4yNGFuTGtKMGY1QWs2TVU2TjArY3hsNGFqaElSVnd2RnROZThFWjJL?=
 =?utf-8?Q?RhXuViTmrzlPdaVo=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c31fe5a-6b32-4a67-3517-08df37f8f6ed
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2026 09:17:34.5482 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oqU+YyiSNkhsrtFiiFWUQ478etIrcgDXB9mTzoyEQJocsmdiw/nw+USGPu/nfwKRyHEqySLNWBVXrMKIHBM4cJayglX5HHmT1+TPX2TAHqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR03MB166725
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 30-10-2026 19:27, Igor Opaniuk wrote:
> SDHCI_QUIRK_WAIT_SEND_CMD makes sdhci_send_command() sleep for 1 ms
> after every command.

Nit: "after every command" is slightly broad - with
SDHCI_QUIRK_BROKEN_R1B also set (as msm_sdhci does), busy-response
commands without data already return early in sdhci_send_command()
before reaching this udelay(), so they never paid it. Might be worth
rephrasing to "after most commands" or similar.

Not a blocker, a commit-message polish.

> msm_sdhci has set it since the driver was added
> for APQ8016, back when it only did PIO; the commit gives no reason for
> it, and the Linux sdhci-msm driver has no such delay.
>
> The delay is invisible for large reads but dominates small ones. A
> multi-block read is CMD18 followed by CMD12, so every read pays 2 ms
> on top of the transfer. With the eMMC in HS400 a 128 KiB read takes
> about 0.4 ms, so USB mass storage, which reads in 128 KiB (FSG_BUFLEN)
> chunks, spent most of its time in udelay(). On the Arduino UNO Q,
> reading 1 GiB from "ums 0 mmc 0" on a USB 3 host
> (dd if=/dev/sdX of=/dev/null bs=4M count=256):
>
>                       host throughput   time in eMMC reads (10.6k reads)
>    with the quirk     46 MB/s           26.8 s (~2.5 ms per read)
>    without            201 MB/s           4.5 s (~0.4 ms per read)
>
> A single 128 MiB "mmc read" runs at 255.6 MiB/s either way.
>
> Drop the quirk and keep SDHCI_QUIRK_BROKEN_R1B.
>
> Tested on the Arduino UNO Q (QRB2210, qcom,sdhci-msm-v5, ADMA):
> - on main (eMMC in DDR52): 128 MiB "mmc read" at 75 MiB/s as before,
>    the CRC32 of the first 128 MiB read in U-Boot matches the one Linux
>    computes from the same blocks, and Linux boots from the eMMC;
> - with the "qcom: Enable HS200/HS400 eMMC modes" series and the
>    mass_storage SuperSpeed descriptor patch applied (eMMC in HS400):
>    the ums numbers above, same CRC32 check and Linux boot.
> Not tested on v4 controllers or on the boards that use the driver in
> PIO mode (qcom_dragonboard410c, qcom_dragonboard820c, hmibsc).
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>

Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>

