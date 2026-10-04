Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C03CA5FCE
	for <u-boot@archiver.kernel.org>; Sun,  4 Oct 2026 09:29:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 27345605C7;
	Sun,  4 Oct 2026 09:29:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9VggtHUdhjED; Sun,  4 Oct 2026 09:29:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 758156060D
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791106150;
	b=Xu/q2kTGN5hWxULoHoEBSlbGw3UzadBgrjylsobsUZVGKaUYIDv8laZD8l0pGeN7jOoc
	 d5gqSPK8nGoMz9+LqkhdkIoHYBvG0mQ+3sH8cjtah4GrCvkA6YRsL+h5RswjN4O/IjZk9
	 iEAwx55aGC2eMXPjr8ggS985elTAb+8DVHL4vGFl9ezmoTgzmBVD+qGBq4AJCHVZdbYOT
	 ugEYJ6Frb12Vuw8liJ4xHjzH5dawb9vKzjXt2C2A5oSPDe42PNu84ZOziENNQS3OYMg/d
	 4TLCGi66X2i58Qhuv5oBM7+dbRPOGbfdj8KrrDlc3A3wPzD2zmDLmL/Pp/8IjeFJxHA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791106150;
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
	bh=b0VQrCh0KYzZ3Ef3gQlGqFrm/J8xQK9PZerajkDQLmE=;
	b=o5vYZJwjO4Hj6xj8ary7x1Hxqx01owJUa+7p976CqoVrw1Yw/DJeca4SmvsAcrCX4veG
	 qdw7j8eFbRJZjhM8C8/6JNHl9K325Vi/+uB7a2OZSrBPZ3bCmnXzr1/t44lwmzyWQmFwF
	 SKkDiahD5IcsoCbHJDIhnZ/vmsbriu9ZShqbygLviTx5nOMNvAL9VGpMXRZXaAb9we1jM
	 iJmkBacwWXCMzC/Gy+nS2y0q/yXOxbfeCx3eQDwHNpN44Xm/T5wLOkjV4hY8Llg2hadzO
	 PnYThhVdSM+7L+johQ0FE542KqY7bsu06MbmB0RshvyRoes7mmY/deJUL7twl3M3FaQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791106150;
	bh=b0VQrCh0KYzZ3Ef3gQlGqFrm/J8xQK9PZerajkDQLmE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RT1oP3UGzGXWTfnOcRtGjm+Xm2KlOE4aM797h1CYwdTC3JXQTkhTUjv6iYYJ3z1G/
	 oxE0JhlfoSAkA7aqsAtDh2wUUficGu6Ewdm1Mz3QDo/iUIGtZ3Ui5cUwW0coQAHD+g
	 xuKif3Hfta4g8H8pgtJtSESdwqkWAgpxnTr02KUEiBnr5bfrr/C8zVFpefT3rNeQI0
	 nuz4vILeDs/DVdoduEI6dOs5Zs7xjQBibmKAcFG286Sje/wQlAUmnEKJitXZSLUs5w
	 TK1L+25/3y9v9CBHGE9Hnj2mb0sToRE/PBzdUVUj6PkShB2932lPEyM1LlRclHCKnD
	 QLkmBOo+8UEqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 758156060D;
	Sun,  4 Oct 2026 09:29:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5CF811A6
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 09:29:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4EED64007E
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 09:29:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RMfDecoBXiYT for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 09:29:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 5DD984006B
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c107::9"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791106148;
 b=Gcuvp5JamZGxPFEJAF/1F2gmlN75o2Re1aLgUUjliy3F442W2VkmoaZv2m9WsLkmOTxP
 Pvapc5MiILa55sj7rrWwyMA9XIax7t5uSXGaJq56eLGDrBuMVdAlYC39SKTJu0nLRWCFl
 QApaUECnxt/MeFdoARRCTIytx7RkV4tSUtZgIVpirI85NwIPjqYTg/410zsydzStgdpkb
 THlud/Su3sTuFTAYTOZT31GxgAUwLkAUniZlbciZ/3tTn+w0SKkZyuDg4UgimYJ2Qv+Fy
 IICPdktMHOLm+b1QqUmFv7aORHIf5UdU8mHt+5XKYXcXq3ENA3ON2gdq9bNwUHAlm4Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791106148;
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
 bh=b0VQrCh0KYzZ3Ef3gQlGqFrm/J8xQK9PZerajkDQLmE=;
 b=BGZA7/ORcn1VgxFji4mfgFzRJ2Ds+ZeMsAUkHbnbX3hT7Xz2LDev14DpjKd0XompeSZn
 Eqidc7mC/tnvCPHKWNIA3Mu5hp55tHgKuQiXlLR/Z0xVjy25hX5m8gUVObcHl2vfsjDNE
 KRUv/WbsOtFaqQ1ZwO3g07ALexP7xlH0ZRq9w59AK3sWtq5fz8/2CHUcAPe1mc0lyAlkz
 fkHRIrAFGctU/WnRjkTqkN0f+Kp6kZhGdqk+xLVnp4Q0g940taUDCerO7ZGz7AYrf1kB4
 Zmh1ah+yiQOZHxRFFgFDOBbG/gK3S+vXUpujtisb6dwPQvn5aWslWk41VwoAP0BINQg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=altera.com; 
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=awlthwc1; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c107::9"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::9;
 helo=ph7pr06cu001.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=awlthwc1
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5DD984006B
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 09:29:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k86c33jFamFVOokYol8nMrZpubPY4XWFJVxnpiAyuZVUMTqrFE56Zv2sYjXLUVPsNlGKFNPzubXBR6J9We9t5dJS3ndZkNeefXo/h1SKBbQgfCRtz+pqRjbRKg6SJxXqOeXVY2no9GTE1ggioiAuo1b8JROtr9clu9kdw0V3HzuFy9AnWDTnygz6kd7DZrEjfY71tMmfkYiXZU5a9JRm3MDkz+Kbu0qViC7mYowh5XDi/FKTV1TB+5EDWblnnzTWMZDd0VBdoWpVJy/TdhHMNeKiblN6Rziq74kCnK9fRgyZPG9AI0+zXDMSJHSYhRdIf7z214NA9OVxmSq9w67MYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0VQrCh0KYzZ3Ef3gQlGqFrm/J8xQK9PZerajkDQLmE=;
 b=seiX4+N+hWTC04XvENPPFJhGn21vsq+gXn9f/Vmr8XM//Jr1kX+/xlCZ5quMv9XFAMbxW3qPQjG41cIvIw4FzklwaxotyNTJeHaUCtfF8b/j0K9EFI0NktIT4PcLjOccdITeyshyvL6hvhCeAgzBbWZQtn1k8HjpZCDYq1UuCnKYKG+MhHp6+kITJHF231aAplEc45z61YtAeNT2wY341XqVzUD2tQ+F7X2pCa60zyygvQPr6ll++xiIWmmUfNJl9dajUUNf6Flwn3e+dIuV/oUjuURKjXXvIQwvAiN6S8/MRkJ4mwNG6yIshFGTa1MT81tVGZzmuCQW+mcbUEqVmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0VQrCh0KYzZ3Ef3gQlGqFrm/J8xQK9PZerajkDQLmE=;
 b=awlthwc1u2R7m+DH2mJ4ib/FUvZdG442n3wigsOWBa3CsFYfr/5Q1sVY8eiBby3d2LTeM1wXF3Vxl0hBRVdVoql29uh+1ciqEj5H3HcBuWcYpcoh14XS9/C12xMlDd2Hd81IlJLiajfvTHVv80VTblBwnzw+7Ten5vHE3MGmAWq16pJBkBzaas2swS9GTF0qzhCjNLBv2oqQc+KWhQ8n/llL1/ulfQ7K307LFJ6VRhPa45vMzFfmu5DJRtOcNJVE5EUqzS1OEiUrEdNCjYkpqM0PtE0tSFwGBQ5rfSwJNG+WtIM/+XviUUJ8KdlIWhoKz/u8pww60ojRThsvfnHQHQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN9PR03MB6204.namprd03.prod.outlook.com (2603:10b6:408:101::21)
 by SA1PR03MB6513.namprd03.prod.outlook.com (2603:10b6:806:1c4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 09:29:05 +0000
Received: from BN9PR03MB6204.namprd03.prod.outlook.com
 ([fe80::47fd:71fd:88fe:6fe4]) by BN9PR03MB6204.namprd03.prod.outlook.com
 ([fe80::47fd:71fd:88fe:6fe4%4]) with mapi id 15.21.0472.015; Sun, 4 Oct 2026
 09:29:05 +0000
Message-ID: <3ef8777e-300c-471b-aa6a-3661eb953b43@altera.com>
Date: Sun, 4 Oct 2026 14:58:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] mmc: k1: do not release the shared AXI clock and
 reset on probe failure
To: Dave Klotz <DaveWK225@protonmail.com>, u-boot@lists.u-boot-project.org
Cc: Huan Zhou <pericycle.cc@gmail.com>, Eric Chung <eric.chung@riscstar.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Yixun Lan <dlan@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot-spacemit@groups.io
References: <cover.1790975596.git.DaveWK225@protonmail.com>
 <a00ed2e7d78b57722496ffb58f1e2965142f456a.1790975596.git.DaveWK225@protonmail.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <a00ed2e7d78b57722496ffb58f1e2965142f456a.1790975596.git.DaveWK225@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ac::9) To BL1PR03MB6199.namprd03.prod.outlook.com
 (2603:10b6:208:315::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR03MB6204:EE_|SA1PR03MB6513:EE_
X-MS-Office365-Filtering-Correlation-Id: 826c4918-99c0-497b-7196-08df21f9ef3a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|18002099003|22082099003|55112099003|4143699003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: McoebUycTmbdE3/dBQHcUBIHKMcWEDdWi0yN0FUEiEtRuY41tm7jExpq4lFFLW8/+RZ3po84tNTokD4eJSCf+KeZeoRNuePVdZjfEnxWBXiZ71HFMFAOZKULFF4kHfZ0ncFrDBFBzTqF7XbjDlU/uUrQ69wPc7IqfmaKKRzjnIKCIZhTS5LAQB9g6i0dflTk+p2zMDyK1y3dNwQwCfRVzM4UEEtg0ls+kPl+hTrRgV8N4Y9VeB0FRI+UnUt77+ncpqRu0n+bjxmcMTBurGWnS2faZeWu2coqB8/ooate6PfLNC43EkHKN+X2L8uOCxgWBSjbk1q3EvjUCsYbBF7ViZEeEhwmqmhTLFQYjCYuOwla45XUld/CHwV1QsIw4R12+f3YCNZXWpZ9/ypUPXW/1sB2G3g28wSaNVA/3dX6/aZaNIKKWPFT36FKJbQOK/QQ2Wd/7QH/4Ayc4DNBu0ikfAIA8MPSbFq1ZTBdPQFqLLNyl1TRbsYJ0oRwpEXtythS0rNotDHTJQfKOp4PKt+PW61sHUydwTntPNaWeNQoMDravJwEs86/J6/kxfTo+irKZP2V0lrupyI5Fh0sfSSrAj8F1A9M1kE5PwYL1FC+49xMV6WOxnVrdEI2g7PrNb+0AMIoZhV1NzGStWG0blho3B8S0N77agqcLhBY+5im2h0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR03MB6204.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(55112099003)(4143699003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXRPR2R1WVVxSFVIRHpYV09EcTlySmoydmFpQk5Bb0VEWFJFY0pZbm1NajZt?=
 =?utf-8?B?NXprTk1vckpTUEhJbDZsemF2L2I1K2k0MzRCZmVubzJmWkFLUU8xTTdRc0dS?=
 =?utf-8?B?MURjV0NFK2I1d0JvcjJXeWMyNmpXZDJuMUlwaFAzR1Y0K3lPZmhpV1RrWFJn?=
 =?utf-8?B?dTk1WUZ0ak0wdHhhZklQbHVyRUF4Tk1JUTFKUWIrOU9jWUtvM1pIRU03WmZV?=
 =?utf-8?B?UHRLU04zS0FZYjRsNnUxYnRYSVZ6dmxCZE1PdXpaeFFyb0VJQ2xCLzM3YjVR?=
 =?utf-8?B?eDhsWnFLMFBCN0NTL0RCRW8wMnBGM2krR2lQN2ZaRGVDVmJNZUo5eDcza2Jr?=
 =?utf-8?B?RkIwTHA0d21XajY5NGc3YVJnMVppT0FlQ1RHUVlpUzNlUkNwS0JtU2c1Uklw?=
 =?utf-8?B?NWVnQ3FJVWFTMDBBZ2xZMmVKaE1IY1I1VnpWSFEzWElNUlJDYWZmNUpYRlY2?=
 =?utf-8?B?RzlTT0VZUjVCUFhMeGcwWEoydG11QjVXdUFsVWdKTVkxZmh1NkU0NEJzMVI4?=
 =?utf-8?B?ZzZlZzIvRGtKYWJETEtXaHFRY1FvM1dnQUZCTHAxZjdvdFJ2dGVGUTlPT09C?=
 =?utf-8?B?OXNuRTR1TDljME1ETWxjNjVXS1NlaDRBbVlNUG8rNk9PUzZrKzVUVytUNVZZ?=
 =?utf-8?B?QjJlUGtnRyttcXB1cTh5d3V2dHFRZ2tKQ1h4TWY4YlJxb254N0s2d0w0cm1v?=
 =?utf-8?B?M3N6TSt1di9sZ2M4MlRQVVJGR3hObDI2ZkoyTUVYenphVDR1ZGZzMzZYMlVD?=
 =?utf-8?B?aWpycFpEUGNlOWNHZ2kvQXpQU2F0alVyd1U3eW5ZcDBLR3pwYW5MKzFjUzhT?=
 =?utf-8?B?RW1nd2pJbU4yTHMvc3BNVmFQZC9Sb2pYYngwSjBoRUJPeGFjVlhWN1pYeGJL?=
 =?utf-8?B?dHFPWjBuUTFVbk84bGJEM2MzRFhJNGRGSzhIMHNaS002VHp5TEFEQ0tKWEJx?=
 =?utf-8?B?SFZFbmxtbzdEa0dGcnRKbnRsNFRrQTk1YzJ6RjB0T21FRHo1TFlraE1SL2Ez?=
 =?utf-8?B?S3RENjhhOHVOd3p1N2JFUE5kYmQyOFpLYXRSbVhDYVV3VU5VOXhkbks3NU5U?=
 =?utf-8?B?SkNFbEwxR0RaVm9YNExKcHRsY2VaOThsYnozZDh3cXNTRkVYZ1hOWTVad0tH?=
 =?utf-8?B?SHJnK2tseG8xTzhxNUlNcXFNcmlDRzliVWZUWFRMMFRuczF1Qlk0cFpHTCtH?=
 =?utf-8?B?eldkSHZrVkpaQWlwaVUxTXVmaXA3TVkrNU5uVXh6Snd0S3VTVlZjK2tPR1dh?=
 =?utf-8?B?T1pFNEVTeGNmSEZEbzB2V3h6RklPQ09pNm1xT2FoUThDK3h5aEF1QkdQYnJ5?=
 =?utf-8?B?RGE5OE9vQVhQY1FqcDk0WHduRThFU3h3cmJiMWNGMEVmelpMZC9YMWh4YkI1?=
 =?utf-8?B?OGhzenlkaFdPN0gxY0QzdU5tTFV1b1hmUTFsaXRsRzNEMm9Lb3ZOYWhtWFdB?=
 =?utf-8?B?b3NpdEZLYTJlVlJPUkUySkt6Ukh1alNKU3BMd0ZDN2djdm44bk9nZ1R0cjRT?=
 =?utf-8?B?NXFNaTk2TVoyVG1Td2JNcCtMSmloSUZkQndnU0x3UWhxMUJqSW1iK2VzamlL?=
 =?utf-8?B?dk5qN0ZXUWlUUDA3bktYL2NCR0pRaDdlWkpnRHI1UXgxNjBSNEorODJRK2Rw?=
 =?utf-8?B?ay9XaXhGZ2pCaUNsMnRQclJpVXp6c29CcEl4a0VrekZrNy9PVy9DY2k0S3Q3?=
 =?utf-8?B?TGVnODJ6ejMybVJsZFNaRlN5ZVQ3blhhSDN0a050Rk5OWU1kblF5TjJGbUth?=
 =?utf-8?B?Qzc3UXFIMjdNREJVNHQ0dTErRVFxU0t2OFlMYVdUVFNLakY3QmsxWUIwTitD?=
 =?utf-8?B?dlpwUjQ1bnF6MGx1RkpyKytkZjFFSkpIdGc5Q2I4aE9IK1JJOWVNU29pekYr?=
 =?utf-8?B?ZlQxWlpINWhTNGQ5c09uZ1YwSkkvNEZWRS83SkpOWHVIVGk3OXRGeEJsWGJq?=
 =?utf-8?B?emtxdjZreW45TFRvcTNmTGZMQkhyVEtzVVpiU0FEa3BsOFd4RHhod1o2aTN6?=
 =?utf-8?B?NmREQ2tJM1c3KzFRMlUxanlvNE96QURrOTl1NzhLZEdyeHB4dUp4d1h2NjNN?=
 =?utf-8?B?dHJaRVc4Z1d5M1JTVmZjdWwzTFh5NUtjMmFhaTJ6eW9OdE9sWG9sb2pmSlFs?=
 =?utf-8?B?SjhYY09Sb21vS0VoaGxXS1RNQSttcU1qaWNmNVoxSGVoN2F5S1hqMUQ2L3hL?=
 =?utf-8?B?V3kvQWJ2d1ptUEFtbUtXVXRiT05LaEFDb0ZhT3AzM2lMUzMrWlZXYXU1QnZp?=
 =?utf-8?B?R0RtQytKSlEvWXBmU3NLS1ZIU2oycmdXVmtSS3FXb1dDWVBpVXE3ZTgyRXcr?=
 =?utf-8?B?dGlEREU3UGlPaEttNzF4VEszR3dYNEV0WjZFYjNYckxiQkh3WjFScEd1YVJQ?=
 =?utf-8?Q?6xRh7XREE5nR/unk=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 826c4918-99c0-497b-7196-08df21f9ef3a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6199.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 09:29:05.7593 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QFmafXuoE+8u2W0wS3NSAH098FQwiXr5lKnTApE+mHGoxwePIezZ7iKhRBma7bqguIe1eOuiSHcmfVTgk2LFbJnukCvTLojV1Fch7QqVK8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6513
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


On 03-10-2026 02:59, Dave Klotz wrote:
> When the probe fails, the driver releases its clock and reset bulks.
> clk_release_bulk() disables every clock and reset_release_bulk()
> asserts every reset, and the first entry of each is the SDH AXI bus
> clock and reset, which all three SDHCI controllers of the K1 share.
>
> One controller failing to probe therefore stops the bus of the others,
> and the next register access to any of them hangs the hart. On an
> OrangePi RV2, whose device tree enables the eMMC controller without a
> max-frequency, the eMMC probe failed in sdhci_setup_cfg() and U-Boot
> then hung at "MMC:" probing the microSD controller.
>
> Keep the clocks running and the resets deasserted on failure.
>
> Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>

Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>

