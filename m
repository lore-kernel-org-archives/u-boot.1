Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D79AD58CDC
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 07:43:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C9E983DB6;
	Mon, 23 Mar 2026 08:43:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="WQZFJLSs";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WQZFJLSs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BB6E83FEC; Mon, 23 Mar 2026 08:43:12 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BC1183BE1
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 08:43:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Iu/cyoZ/UzyfDouO49YZGV1RdSZH7k1yXn0MmZKfg8jlGAY0CQQ5DZGRUWR5O4ndLqC0qhIIlT1yAloLb4P0zVQCQIrUuZdK8SSPFCE7reeeZ8oCtwBqmZQcEaextZpWTTr/FURfO+eN3gnbzDqD5c14A6CLZJTLOkt04aBr0VxgAUuJhCd6M26vWbM3cmuS8R69cc1lfVIQOGbPYZpyX11JfStvWQDT2ettbfSGaNe9tpbpRVjdSdVlVybwagwaOQKeR5xxtS1U813DhewTRdl6rOmuJ/4O9QAu/Zw8Zlfyq63ru6VygFZpDTP6pfYKNksyt5qVcRv4e0drXsVV5g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABBAwaUEc9RMYn53QmiYw/lPV5YIdMliFcdaUJH7fFg=;
 b=LLfwjZRmwJJ2/DxaEibK8B6BI7FtUuZ06zcqewLO+HeylNFDa5ixZUrG8F7pXsTljrR+U+7FdsjMupPxl/otKD2p8dsrwou2KW8rYcXvtAADhAHRI2I/ukn2VkGCMdiJDzmctpqnfH4CKpNWZ7BDHwcRtfFiSkINQ4tOz4exdryKwzo4mbB1DN7xbsd1IKuTgYgDfOAVaXyffH9WytTHRRua17IKxOAmIWMOBLz2DeZGtPQN1d6694fNgaEtbfeEBj9EvyyF8QQjF89XtzQUN3if08UP6NKDQFfWf5iesJZia8sfyccpkiQt9caGw+An6F/3YXJo0kboyS4TsZSVJw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=amd.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABBAwaUEc9RMYn53QmiYw/lPV5YIdMliFcdaUJH7fFg=;
 b=WQZFJLSsuW+GFkWS6UENe+ysRUyLhGcn9GNL4uvjo1mw2en+LdugfcqKs2Ocy29yLnH5dNRWF4JlAkjvPrBlj2C87wCA0js1ffM/tLSUIufie5dYnpMCVMjTmoebuFmioIpcxqwngW3PzG4xdhgJvFz3hBR8NPA9hdgMT2yyHnk=
Received: from AS4P190CA0024.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d0::15)
 by DU5PR08MB10773.eurprd08.prod.outlook.com (2603:10a6:10:527::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.23; Mon, 23 Mar
 2026 07:43:06 +0000
Received: from AMS0EPF00000194.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d0:cafe::b1) by AS4P190CA0024.outlook.office365.com
 (2603:10a6:20b:5d0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.29 via Frontend Transport; Mon,
 23 Mar 2026 07:43:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF00000194.mail.protection.outlook.com (10.167.16.214) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19
 via Frontend Transport; Mon, 23 Mar 2026 07:43:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lkrx28L8kl9cQdHPpkwmP3xQto1sYU2qy/MJfmmykNp279E1g9qVEqJzBp9msM5ikq/JrELVKCqOvwhXk3SAI5S+TOwyRyTkTIhauiziEJ8g4R1IE1eqX0K5cUiu4uHKAnw7xidzfr9LVQ3XxNDYN2vYm8rEOdF4jpRbwfWxVMM+xfRNi074khaOZfMToNF8VCn4rKvFbWZgv4dfjd7cL2wNFjIkKPXV2fslfQQEIuICJ+dVC8+8o9FjK61uM/Spnb4N4xS4YDrQj3hZww8f7qnZIPlVokKzTQVy3DzKBsftDoXOMoi7qMToOk5y6gPeupAP4uayT51vI73Sc/DfBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABBAwaUEc9RMYn53QmiYw/lPV5YIdMliFcdaUJH7fFg=;
 b=zMdoeNbkzltMhOmrJuVvNrzS14fSGAOnQBIXqBx6gqaHmMVAlH/O+2Blbj4/r7sFl4K/+AV6Bk2F5lrOBIeyIuJTWI316M7x/CZRXPc4Xig0kZVxbe/akKKJQFqqsfRucJ40W1680qAE6kob2/iSPkxMQHu21ZhnYeaon1jhq+L67lRi6FaXUeJeWgyJqElQzdkhJEJS4c9YniMy4lSVoj+L4yPD/fixXXmqC5W2vtRV2k5cEZltHwTYJ0UyGBtvP5fjA0NIwjS/zSOCwMr/LNFpB0TnVOtluyVPxqoBnUOLCX8fdZzBAhh6+g4WCoDV5rLh5x+LFMtnmvcLqYAXtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABBAwaUEc9RMYn53QmiYw/lPV5YIdMliFcdaUJH7fFg=;
 b=WQZFJLSsuW+GFkWS6UENe+ysRUyLhGcn9GNL4uvjo1mw2en+LdugfcqKs2Ocy29yLnH5dNRWF4JlAkjvPrBlj2C87wCA0js1ffM/tLSUIufie5dYnpMCVMjTmoebuFmioIpcxqwngW3PzG4xdhgJvFz3hBR8NPA9hdgMT2yyHnk=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AS8PR08MB7741.eurprd08.prod.outlook.com
 (2603:10a6:20b:525::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 07:42:02 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 07:42:02 +0000
Message-ID: <2ba82ed0-619a-432e-9d15-9fd7dc813fea@arm.com>
Date: Mon, 23 Mar 2026 08:42:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: lwip: nfs: fix buffer overflow when using symlinks
To: Pranav Tilak <pranav.vinaytilak@amd.com>, u-boot@lists.denx.de,
 michal.simek@amd.com
Cc: git@amd.com, padmarao.begari@amd.com, Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, nd@arm.com
References: <20260318114124.3749184-1-pranav.vinaytilak@amd.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260318114124.3749184-1-pranav.vinaytilak@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0493.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:3da::18) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AS8PR08MB7741:EE_|AMS0EPF00000194:EE_|DU5PR08MB10773:EE_
X-MS-Office365-Filtering-Correlation-Id: dd6990af-9e24-4036-5a45-08de88afd1db
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: IaScBi3TbNoQ2R+23XrS7WazpZuf2eYwbmu21gh3mnPs3vxFnBcFyShaAvi1Fqi+0D0O4lH30vbqY3QAMVtp6Cl979ilfbP3pVfK/18V9oNzJTEFNjE5pPAnRtTgk7x6eiBIJpZFGlzdFeXBS8zAifm+5/s5TFm4HY/kRFqR4nIMOfn9RRrAF3UJEGVyqGlnMKCfES95f95C34Vn0m0/RNg6fpYd5P+9VYMHLKn3JT1DscLkLazt5wd9yKE5UCBA4HYFfg3G4qjZrHX+xfKjM+eZKWNdJWL7ydz7VqrT/6+Bj1opOOVc8EyKv8/mpdJ5dJD46W/ezS7hug4aQko2Ugg+yEU/e+JCw5yfK4N8DXX7ea3lQbuTolS7RG64q4IBY+EzTbrXkKLHuZ9+9HLYIS7mi7I/PFN3Xl9DvzZm1UoE6N0W+N3kQUcdaoPlscUU/9WXLCzzR/6qIqChvhrnW0O+2Inr2ieoxughMVmm8QlRHu3FJPMjAf/7REHJNx2VyQQgkf2/fLKNRDBeDAcysmw6ymTDndlL/pT9mVsPeG1jm5tKtbr04M+nR94eXoKwWxJ4G11wYKh94wdupqhBsPOOpgXeiyiykHiy7wiu6pnQHpZEJLEnDVUC6T9fQpuXNi5oVrn81/9EiMMNMvht8NQ2QH/dWmPoQwXmwixR2yhpNxpCbjgtbPsm8Gfgi6CT4h/eMjEDMVgDMps7ond7EEz0SKUVHUiMSn1lBDfD0kw=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: C025yOfoh+Gz9f3SomlHolzJrtqmUOEOUIt6V/p1HcOJ37O8Deujm1djYw5llUQ3YqGasMXm68/wUF4MY3FsDYVaGaX4/Gl2FIcoEOET/o4q4uU0HnBwuhj6lki1tglPdB3ZjG61tHKjMUbpl2zZm0ED4leFRoRXDPRNCv1KUYWl7o5KpscIG1BNBRUCffyMH274LYzooQN1iHyaprXeo3Nfb8mlrXS2nY3S9r83GXcnEpCf0LpYZwUez4vMr1LGr5JGeCUaN9xuPLVRNUjWKD5sj93HqFRwYwBEFI14QWH0u2KnMFoXW0+N4zhjHbx733KLcifsNGcjrQsy7s904g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7741
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF00000194.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: c260df23-a5b2-47d0-3337-08de88afac00
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|35042699022|14060799003|7053199007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: iHdMs3YAzEs1jMtqlSY8MsFN2EgOTZ1yWJr/Ed+x8pBW52rS8rxMIqvz7YNxdwq3tXUKudRjYo2oEBu3+coORpcmakrfzbJqfR4PEMS3c/qAZy6ecVkXMqa/VRfxSw+s3IpCHfoGZ6OkB9EXilTavzlG60NoG0BslYdBqhsLLhajONSc4bzLlgexY3GP0p/LVz9AhQ3tPiUtVMr84LhDt0ShPnmi/j/83LWo4nsSAt+aiY+PhtuHMyPSmd2IJnqrnCzRgYvTXYgS/6vQfH2x9sJOoE1xRJrsRWJybVpymGH0TEAbh1fYz6eDAuQj2pNNnqVDTDLWUTIC0c03tbawKZ9mwhxVmIW5Nkp86Cj500c2PZttYoHhrctI4k/4ty9FWLBCqD5uTIVZsw/tSMzGHsH884lQGcWWhn0dsPg1iE+2KCNqL7jlR9aIMDDg9AQG4lRdoREQxyetmQb0jMakX4eLsXDMcGLgb0BGfpUuAbSrw0Zgt86uu7lXQBfCkvO6GegMEE3SxqL9Lzu7Y/ZyD//GlRqZ/HqnYuEVbZcvXSAu4MxwPZsXzLlu8SKxT8xU4hd/H2C1dAgxP/I27pOTH2tYdARLufPtN8yss+dk9T46W51YF2rhAT3rkskskrPPYtAI3kA3ePyA1svGPobEOb9NgjhGvHzZ0mkse7HftypfN+7e7otLHkIlUHigDC6tO5sT/wfGpLNNoeJHMErYiC53kcJynjZrVpiHoka5qeRuDtnkBSvyn+portDoxPjWp5N4J1WUu84c2tmkAfAd+g==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(35042699022)(14060799003)(7053199007)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IP556jZY0f89FCPTkAZlQt/4xcDWlctYGZ0X/2nQMu7sYKgv1oUiC9nFnWcxO6RqJfC7JPp7Zg1rj67V3/lfKi0txNPeokHJvqaF36l3C8XQ9/9/2fyOU4XAoVsJQpdenar6JzEXPGOVnTSviW2IZeW0LObjrpcUFlNQrfX9eJrXbmpZ8ooZU1PIrpAjBHK5LVvXPNFfjbBahL7RfUbxVs2ub1yuzzWsJ3OatLH7tZc90F4Ur0NHihnL5mdHvOvzeNS+BK7tP1KfS7o9UcUzPO6Y5koCP7XnO4k5F7iIuaUieklgwEGp+B5nwnoI/HP8XV7qpJSz3ULVcclC2dZZW6QiY1BoZM8AB9v6IuVE4mkwYrtqjPdWInCcMTE7qPK05CAw7/4mXGaD5g5udIEluMYwkgjGPN2/CatorYCfZlQnSLAZg4hDN+IV3aJz82Ce
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 07:43:05.3706 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6990af-9e24-4036-5a45-08de88afd1db
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000194.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10773
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



On 18/03/2026 12:39, Pranav Tilak wrote:
> When resolving a symlink, nfs_path points into a heap allocated buffer
> which is just large enough to hold the original path with no extra
> space. If the symlink target name is longer than the original
> filename, the write goes beyond the end of the buffer corrupting
> heap memory.
> 
> Fix this by ensuring nfs_path always points to a buffer large enough
> to accommodate the resolved symlink path.
> 
> Fixes: 230cf3bc2776 ("net: lwip: nfs: Port the NFS code to work with lwIP")
> Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
> ---
>  net/lwip/nfs.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/net/lwip/nfs.c b/net/lwip/nfs.c
> index c3b819a091e..b2e8fb3382d 100644
> --- a/net/lwip/nfs.c
> +++ b/net/lwip/nfs.c
> @@ -114,8 +114,11 @@ static int nfs_loop(struct udevice *udev, ulong addr, char *fname,
>  	if (!netif)
>  		return -1;
>  
> -	nfs_filename = nfs_basename(fname);
> -	nfs_path     = nfs_dirname(fname);
> +	nfs_path = nfs_path_buff;

This assignment is not needed.

> +	strlcpy(nfs_path_buff, fname, sizeof(nfs_path_buff));
> +
> +	nfs_filename = nfs_basename(nfs_path_buff);
> +	nfs_path     = nfs_dirname(nfs_path_buff);
>  
>  	printf("Using %s device\n", udev->name);
>  

Other than that LGTM.

Acked-by: Jerome Forissier <jerome.forissier@arm.com>

Thanks,
-- 
Jerome
