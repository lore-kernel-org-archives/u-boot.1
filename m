Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78FA9C44501
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 06:49:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC79284D25;
	Thu, 16 Jul 2026 08:49:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="Q6XV1ccH";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Q6XV1ccH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A44784D5E; Thu, 16 Jul 2026 08:49:43 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9679284B48
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 08:49:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=n8k7zbp0eybhLuhp0saX1x7a+DZ2gofXRg3YZfeYNFLnVQtLXj2F4ueLWxY4CiFtGRlyid6HqZidJx5PcRrYxeiStzG9PePEKwVvZEGcBGlKmFUpBY1/iYpZUXau5CKc/UtpgBWkIlwGuNIAyooOY1EF2bPsrSQ0xhmzFzJxbjRpwMT0Ah9RvrH+W/jbOf1AEwf7R0oJ86GHhTaLt1PwK+g9LyN5suXbur7AsHAHVofZG9egQdVvB+6xyF6kpmqP1ECzYzUngEucTZ9s23lh4DJKtUiMxkpJINKp3vUeA3d5ieZE5V4ow/bkev5IOAjPCy6mYwCHVXs//RpW2LheHQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vc9TembJFt02o6BZZJzSKgfcNtpc8slBQkhYs4xtZQM=;
 b=R9q+9Xpyq6uQK0ZwC1x5S7I14nyvO1S8G14phejoHYEEj114SmMoEeYUfeALqHFn0mFkv3xzgFkLkGMKfLGjclUQt2/YfTQg08sZo8vFgzosEaSr0ILMvUHsdHqoxR/kbVe0rE3AdN8y65uirfXmK4lVXFlMYYbTc9SHB8TQ99BdYnftciJQoLkQs+9PfMpYIVdhLQqoCTdOSvS+5TcH+3C/3a1qasEuZG+gwzRYtTiLD20emYC2XP4chIG1jTsXFWVna0ERUgFS3IDaGoO7IV+cPcm7+dOb/l9RJTXF/s9Dn6sUH0ZFpJZ2T+JxtKRvAkLJLaQau6Iiis7aXTNyVQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=rasmusvillemoes.dk smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vc9TembJFt02o6BZZJzSKgfcNtpc8slBQkhYs4xtZQM=;
 b=Q6XV1ccHodqq5B3oyz95cgrkrlwxgPMIaO1gH1JmzUO172t8kn/mZ99nC7sOcD5Ey2JlaoQZ7/y3ueK/h61ou+WrT1fQ7cXcIqngM2ksN/cy+aiESKQxrYV+2lactY68/3Wje9Ae9SJAu6OWR6/37Vc/LkxNiw3l6Lkg2KXR+n8=
Received: from DUZPR01CA0154.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::24) by VI1PR08MB5342.eurprd08.prod.outlook.com
 (2603:10a6:803:132::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Thu, 16 Jul
 2026 06:49:33 +0000
Received: from DB5PEPF00014B8A.eurprd02.prod.outlook.com
 (2603:10a6:10:4bd:cafe::38) by DUZPR01CA0154.outlook.office365.com
 (2603:10a6:10:4bd::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 06:49:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B8A.mail.protection.outlook.com (10.167.8.198) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.5
 via Frontend Transport; Thu, 16 Jul 2026 06:49:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w6tN+iYNN2ycHQpCKeK41fXvfsK3S0NFiNQqVst5lHYHYLurK+FNNMF/XVPvb+pnSl+wx+eyD6OW+YriMZBKvXwSRYQPPvSB227UyUJ0DqXdz3eTooQe5AYoALiLeUXibCAuho/mzHeatotbDQmLB3uOp5qRo1fB5PUsoUXDKno9ckX65WpiaRVz9TgyZkfOa4pXeowagHM7dsbeIFC5j/Hh+hw1+bmP4LC2vRxQVYBfnPCppDPIyyKfIgKLAuVGYogo+Y+fAJ2YIgDu+SOkhcA5KCMgXRGrUGMUw4veXtNGPVoJCVVxKrJiBSxNt21MXWeA/vLmHsdoWq0T8rqq/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vc9TembJFt02o6BZZJzSKgfcNtpc8slBQkhYs4xtZQM=;
 b=pE5LEi9hFG676s+ljVM6RtGa5AW9uAw+2CZJkheYVhJB0SyQ8zH/8UeX4aVD4fBWNbya5YwlwWceNSj8GTURi0CoAVDTZbtSCyhif3B3iIywtNU1ta/w67fupX6GNdF7OQaNsW0n6jBq0ZExNT1BpiNq5QRCUhD9DXxM+rKpXzdM04dFXJMwYxOEOaYO+VVgKFSvrHfzPuY4JtesGDPiCNFxjdGCldZLInG0j/IYCl9qWtl+AKZ3HCVokQtfRfHLP0Vkp4Rv2dgI0hezDZJceVVoe3p77tsyl1ko2atldGOoPsWIErUZIs4tOdqHvY4UXzYSBgca9pQ+srs2Dkj0Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vc9TembJFt02o6BZZJzSKgfcNtpc8slBQkhYs4xtZQM=;
 b=Q6XV1ccHodqq5B3oyz95cgrkrlwxgPMIaO1gH1JmzUO172t8kn/mZ99nC7sOcD5Ey2JlaoQZ7/y3ueK/h61ou+WrT1fQ7cXcIqngM2ksN/cy+aiESKQxrYV+2lactY68/3Wje9Ae9SJAu6OWR6/37Vc/LkxNiw3l6Lkg2KXR+n8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by GVXPR08MB11787.eurprd08.prod.outlook.com
 (2603:10a6:150:316::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Thu, 16 Jul
 2026 06:48:27 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0181.016; Thu, 16 Jul 2026
 06:48:27 +0000
Message-ID: <f0f08cc9-393c-4fc7-8883-6015f436c0ed@arm.com>
Date: Thu, 16 Jul 2026 08:48:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: drop pointless .bind methods
To: Rasmus Villemoes <rv@rasmusvillemoes.dk>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, nd@arm.com
References: <20260713193043.2851418-1-rv@rasmusvillemoes.dk>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260713193043.2851418-1-rv@rasmusvillemoes.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0019.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::15) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|GVXPR08MB11787:EE_|DB5PEPF00014B8A:EE_|VI1PR08MB5342:EE_
X-MS-Office365-Filtering-Correlation-Id: 1476af40-cea1-4723-a67a-08dee306643e
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|11063799006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info-Original: r7lgDFDkF0g7CidaMEUVju15cHP+asfrTa2PqQpwVMNHtwYczvTGdKEo3eIpHq7B9BUJQj5PwvGCYpIEb+yMA595PQnq/+ukoja2nBQFJs3Z2IN2ZvTVzH436PV/Lo9qGOiBAHssuqzZoCcEV8IZ3AESBX9Q/oJE77gx7GQNxYQW4N0WteR1U4aOQ2SFOiQSz/gejQjcYEDLp1N6HUfaO2HEfgHTAz67WnIUQy6R9iojcXHbhbut4GNX+Ll6wW3Ubb8iJOkAodnmFLls1UL/zvpEQHchhnp2MJg2I5q7k5Y5ffnMK1l61aGT8SfhN44qaVeGgHFbcKuZD3sI0kahHZn+V9FTTklnI9MAjSKdubPgaDYtytKMx4v7rJ2zzOVIRup8Z8WjJT1e+/TWLhmf8K0eI4AoyJ9UFn3R1SUHtKEb00z6lidwLVEqABndttiIgrDSQYPwY5ESQM2+oBdc6sY0KzYs1orwZBNaJuTdjKkNyGn4x38fagOG4GqIvCUJCHDIddtOIqCLTzR4gdcBZUR5xxvymbdyC5RATnY+ZycsbGsusTqNyMrDkQFp84eL1EaIVs7Y8381KSJY2uZrow0Vq7VjdXuKvOIS2MdCNHwV574uO5TmVS3cGgod+8vj
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(11063799006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: arxiHHEe1+GNMp8eR1IrcNY1mohdllshF8mLO6Q9OGqmK5mSuCUsCHzetGS3N+7G2YX9+gb86vbiyCWPLa21ojxGdRZQ8nByflpKsV/Q6U3IiaOBLb/NCwK6sL+hMUvHwnxUCJ9l5+gVSdEeUtU+6VMUXEoIalioGjKmKJuL+i7RR6Me9WBASxhhJCJUmXTVkL3EzyYVHrbIkv4TSEU9ioxi9VfFMhR33Tbv/OleeucSD8uUmb7wOUuNlynQg3WDkd9duJ3+zgpPuztOC4y+CpkOZJOE9fR+yPvqcDqNr43oj2VRJZ//QsTDz4FxhxrEB406MGKpsv8mjvOp76f70A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB11787
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5PEPF00014B8A.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 311f0051-b199-46b8-a5d7-08dee3063d2a
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|14060799003|1800799024|36860700016|35042699022|11063799006|56012099006|10067099003|13003099007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: gwA2hhHQpxgfOQbKqa+LzSj/71LMtPMxTnLG5aAVyZuFbSwyVOSZqLxk8vGO61Z3Hr1TpXo2JwxsR8I8PrslcTXaXJB2OdmNHDW4rCwLi15+32mtR0jwqrExfVZ4xAzIS6fPmivTuQZCTZ11SfUAqfckMucRM2sR6CL8/6UST1BARVlPlYMFthLJCxinElHWjphmZVXWo05sW4wrQY+vE7Nbyt4aYaWr3OdBoTrb6r+WCAqVqU5X7ODluTMqejQDjjCcA2MyOtdbv3lxw5RzblB9gv2FGfUk7/vY+KSVWl2OioNVbSeBOorxSfPiPONGjT0ZQpU/GqUSWjgYlpSLiHTl2ApUozr6vHAmpdjXHltcA2Z//XS/Gl8kpMgAPrq50gQdS/hjopWdDems2rh9dHm5CgfQ/KQaGw7q6cwzI/ere1ZMWrI52GdzODjw9cfQdKuDwINZAnIuoss+vgcMeyunAyZ0EwDLXq/Dmepxbt/akEAq0dTYxoid6T6F+nppE5V25Dakli2ObE2pfj1PEzQkoUiW/L91pBfoN0/owis+oaQIVyT+cg0npVIr/ZGL37AhA4AAYc0mzi/M0uZ1tHKp01sG080uy9utqb50XanbF0MnEgrBYdGfunWEZhgfOX+7v5pWMpE2zV2lf6uc3W5jR2auPc05x3Z444AG9OU=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(14060799003)(1800799024)(36860700016)(35042699022)(11063799006)(56012099006)(10067099003)(13003099007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 42m4Abv1lTKr8GBsK6F6suOxdyDVV2lFxIVdJ2Gq956GqBVs094hw2IkiAQKfjyeq568QPs/7xPnBpIfyj7vgAwdblqpFL76sxVyDoNqNqxfKmVOlVSCJKmsqQvr2XC320KriN0GCkAPTh+qdW11Q2Rh3ylDXQFcNUlQwMyYNrYI/ryIC4e6T5QUB/dUEFF07RcCuRKWVO2xF8vIKS0Xj4+NyDuPBcvGE/w+PXj/c9PnSB1Cx9bTgdLWTmzbI3m97DizJD8WPjm9Y0MRAFJFVodJ8h9gWizQ8fxq+e7qSzwrQ/cwU7IywKEv6s0SKM+me/LoBBX1qeVdZXdWSxT9Hd+Bb/thfJunpYNAnAyKPsgmn0V4/xWDsDq2mj3OF3dCkJOWdeCJ1x8D9UWHmsQTmRFDy39Vs0eknd0KP3bci7O5t2dI5DyzQhoUmV6i2zYM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 06:49:32.3357 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1476af40-cea1-4723-a67a-08dee306643e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B8A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5342
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

On 13/07/2026 21:30, Rasmus Villemoes wrote:
> Considering that device_set_name() does
> 
>   int device_set_name(struct udevice *dev, const char *name)
>   {
> 	name = strdup(name);
> 	if (!name)
> 		return -ENOMEM;
> 	dev->name = name;
> 	device_set_name_alloced(dev);
> 
> 	return 0;
>   }
> 
> it should be pretty clear that these .bind methods are at best
> pointless (there's a fixup for device_set_name() en route that will
> make this not a memory leak).
> 
> I presume one of them got added by mistake and the remaining are
> cargo-culted, but regardless, just remove them to prevent yet more
> copies of this anti-pattern to appear.
> 
> Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
> ---
>  drivers/net/dm9000x.c    | 6 ------
>  drivers/net/ftmac100.c   | 6 ------
>  drivers/net/ks8851_mll.c | 6 ------
>  drivers/net/smc911x.c    | 6 ------
>  4 files changed, 24 deletions(-)

This is a duplicate of [1] which is already in for-master [2].

[1] https://patchwork.ozlabs.org/project/uboot/patch/20260703-net-v1-1-3c2c7d6323c1@nxp.com/mbox/
[2] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/commits/for-master

Thanks,
-- 
Jerome

> diff --git a/drivers/net/dm9000x.c b/drivers/net/dm9000x.c
> index 9e17f0b9c28..53225979b66 100644
> --- a/drivers/net/dm9000x.c
> +++ b/drivers/net/dm9000x.c
> @@ -638,11 +638,6 @@ static int dm9000_read_rom_hwaddr(struct udevice *dev)
>  	return !is_valid_ethaddr(pdata->enetaddr);
>  }
>  
> -static int dm9000_bind(struct udevice *dev)
> -{
> -	return device_set_name(dev, dev->name);
> -}
> -
>  static int dm9000_of_to_plat(struct udevice *dev)
>  {
>  	struct dm9000_priv *db = dev_get_priv(dev);
> @@ -673,7 +668,6 @@ U_BOOT_DRIVER(dm9000) = {
>  	.name		= "eth_dm9000",
>  	.id		= UCLASS_ETH,
>  	.of_match	= dm9000_ids,
> -	.bind		= dm9000_bind,
>  	.of_to_plat = dm9000_of_to_plat,
>  	.ops		= &dm9000_ops,
>  	.priv_auto	= sizeof(struct dm9000_priv),
> diff --git a/drivers/net/ftmac100.c b/drivers/net/ftmac100.c
> index fa0b3dbb6d1..d9826178e82 100644
> --- a/drivers/net/ftmac100.c
> +++ b/drivers/net/ftmac100.c
> @@ -429,11 +429,6 @@ static int ftmac100_remove(struct udevice *dev)
>  	return 0;
>  }
>  
> -static int ftmac100_bind(struct udevice *dev)
> -{
> -	return device_set_name(dev, dev->name);
> -}
> -
>  static const struct eth_ops ftmac100_ops = {
>  	.start	= ftmac100_start,
>  	.send	= ftmac100_send,
> @@ -451,7 +446,6 @@ U_BOOT_DRIVER(ftmac100) = {
>  	.name	= "ftmac100",
>  	.id	= UCLASS_ETH,
>  	.of_match = ftmac100_ids,
> -	.bind	= ftmac100_bind,
>  	.of_to_plat = ftmac100_of_to_plat,
>  	.probe	= ftmac100_probe,
>  	.remove = ftmac100_remove,
> diff --git a/drivers/net/ks8851_mll.c b/drivers/net/ks8851_mll.c
> index 2c956154d09..c2f87d4222b 100644
> --- a/drivers/net/ks8851_mll.c
> +++ b/drivers/net/ks8851_mll.c
> @@ -571,11 +571,6 @@ static int ks8851_read_rom_hwaddr(struct udevice *dev)
>  	return !is_valid_ethaddr(pdata->enetaddr);
>  }
>  
> -static int ks8851_bind(struct udevice *dev)
> -{
> -	return device_set_name(dev, dev->name);
> -}
> -
>  static int ks8851_probe(struct udevice *dev)
>  {
>  	struct ks_net *ks = dev_get_priv(dev);
> @@ -615,7 +610,6 @@ U_BOOT_DRIVER(ks8851) = {
>  	.name		= "eth_ks8851",
>  	.id		= UCLASS_ETH,
>  	.of_match	= ks8851_ids,
> -	.bind		= ks8851_bind,
>  	.of_to_plat = ks8851_of_to_plat,
>  	.probe		= ks8851_probe,
>  	.ops		= &ks8851_ops,
> diff --git a/drivers/net/smc911x.c b/drivers/net/smc911x.c
> index f39ba40944f..2835eb45856 100644
> --- a/drivers/net/smc911x.c
> +++ b/drivers/net/smc911x.c
> @@ -431,11 +431,6 @@ static int smc911x_read_rom_hwaddr(struct udevice *dev)
>  	return 0;
>  }
>  
> -static int smc911x_bind(struct udevice *dev)
> -{
> -	return device_set_name(dev, dev->name);
> -}
> -
>  static int smc911x_probe(struct udevice *dev)
>  {
>  	struct smc911x_priv *priv = dev_get_priv(dev);
> @@ -487,7 +482,6 @@ U_BOOT_DRIVER(smc911x) = {
>  	.name		= "eth_smc911x",
>  	.id		= UCLASS_ETH,
>  	.of_match	= smc911x_ids,
> -	.bind		= smc911x_bind,
>  	.of_to_plat = smc911x_of_to_plat,
>  	.probe		= smc911x_probe,
>  	.ops		= &smc911x_ops,

