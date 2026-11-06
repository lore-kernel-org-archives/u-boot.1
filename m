Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08831606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 18:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mzZ4JrYI;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=hu9LXzID
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B7B22409AB;
	Fri,  6 Nov 2026 18:29:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RCzZb60hVuuM; Fri,  6 Nov 2026 18:29:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1479C408EE
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793989789;
	b=lvp2XpDvzEOIKpWR0ZDt3KrHHB6WGJv8HxRV05bSgMSqCECdP9xPb4GEkQOcctqdqjFV
	 APrj4mW6NVBiTwAaHhcGy1aEFpd6kVU+j9Q87/zA585DotdmAfIGVJmXKCJGngI3Fm/0m
	 0EtppF0jxC4xrRKZVaBxBsDjuuHg+4Tuwf0N491MCTXC1sNA25sLZEPhyss0zq2MwTK9w
	 o+O3Mdtvm3qo2vatPuVNVpSJMFYpbSfu2RqzXLnZPEopcHmSAObgk7V/wfc0SzBM0RF3X
	 fjU+6SxFs4VBORQh6v1F2HQ2Ew5HhoFHGC74AQXZpfZQpgnZU3H2G1vdQkiyp2pENzQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793989789;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+MNB/4ZJVIQlJjCOkvaOgu2pmP1wdNPasiEP4BDnq+w=;
	b=nybXWTzsntckjoPJwpz1O5QXC8rzRx8ZKfYyo90deHIq4mE7T1yEyIxCWYDAof9Xog9Q
	 k5bACh6NKOfm08tF2Q6i7jsvZ1vi5tc+HPXctqrd4pSPT4uSC4hkyd6sDhIuTG5lpi4Be
	 py+krIIgmC5CH0vGukgdZpjBDgJ+SFETuuKkaOyliN7UOWRZFutl68wERox1NVDdJ1L6o
	 bPmyuGwP1B3kp4CYh/ej/i6PDihhY9WbjBt7tQW9/oP5kXTeUIgG2WTOghAYmZHloRV7g
	 LFi8mlEQ/ciVlRVNsCb6ieawpHrU67V8PzmtZ8mP1bGSDNEvByNnZT/cU5AJZL84Dyw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793989789;
	bh=+MNB/4ZJVIQlJjCOkvaOgu2pmP1wdNPasiEP4BDnq+w=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mzZ4JrYIO9ViZtyYXvdqESU6n71A6eWgogtMnJhHHASinOCLbxDiSaT6xhs7y8O4b
	 BFiTnrDV0QD1Ikax4BNghDbvrjlg8WHhynp5BPfyzR3k7A+72sILTugwU+0EQv5/8r
	 HOy0+Qp9Pw1ZNqJbhlWoY+vkq9bDbjAKsNu7GV7H1DZLmNNl3qtfUN+2VHmVpQZ9ec
	 WwX3Lvge5LBL4Vbjy6DhOojCg15bFgxmuD1Ev+9egQ0Pw7cU3hWq7pb3oR7UTCY8D6
	 8w36G8NIqVhF9QqEEjwzfiPOKpJ5p6BsLARcHUwjAkdhWNLDJvyGNKh1JNIZZoePd7
	 LCCIK6QII8D3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1479C408EE;
	Fri,  6 Nov 2026 18:29:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E88A42AC
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:29:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D9B24811F8
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:29:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2GD187Nme_QC for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 18:29:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E6BE881188
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=patrick.delaunay@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=hu9LXzID
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E6BE881188
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MNB/4ZJVIQlJjCOkvaOgu2pmP1wdNPasiEP4BDnq+w=;
 b=hu9LXzIDJweKpkdj2SKpmR5UgZ2STXVxd80SCsUdVX2xfBtZ8RDm/YuTUr6MwkCBnDpGJ30Z3aJbvXBidzUrjUPZxlkaGX/yNeoRPyOe4dDI4yxy7xAT+P9R7FDC2xfU0BnXhasZAnwrlfG9/uCoLMhtVcQ2Ruo5aD8c0l7CQ7jAcid4UfwD1eaZxskKUf3JYnErABTtowhicveuurhRsrWjnbgfIJb4EEuL5dTFF7cYYKtlNbCWg9fPNFI1e0/1HqRflfOZd/YSygaO1m/OGEm7kR9Jdc/vXhXvQLPkqQypq7jM7zRDnbs/j6tn7PgppdSwHcmz5XLZ4uOq7gk2cg==
Received: from VI1PR0502CA0029.eurprd05.prod.outlook.com (2603:10a6:803:1::42)
 by DB9PR10MB8287.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ca::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.4; Fri, 6 Nov 2026
 18:29:41 +0000
Received: from MI3PEPF00008499.eurprd03.prod.outlook.com
 (2603:10a6:803:1:cafe::3b) by VI1PR0502CA0029.outlook.office365.com
 (2603:10a6:803:1::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 18:29:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 MI3PEPF00008499.mail.protection.outlook.com (10.167.240.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 18:29:40 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 19:30:10 +0100
Received: from [10.48.87.100] (10.48.87.100) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 19:29:39 +0100
Message-ID: <67b90dca-e244-461c-9d1e-3dbd093c83da@foss.st.com>
Date: Fri, 6 Nov 2026 19:29:40 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] gpio: stm32_gpio: support RIF semaphore handling
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.u-boot-project.org>
CC: Tom Rini <trini@konsulko.com>, Antonio Borneo
 <antonio.borneo@foss.st.com>, Fabien Dessenne <fabien.dessenne@foss.st.com>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>, Vincent Jardin
 <vjardin@free.fr>, Pranav Sanwal <pranav.sanwal@amd.com>, Simon Glass
 <sjg@chromium.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20261106-upstream_pinctrl_update-v1-0-4f3d4f6e97fc@foss.st.com>
 <20261106-upstream_pinctrl_update-v1-4-4f3d4f6e97fc@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20261106-upstream_pinctrl_update-v1-4-4f3d4f6e97fc@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF00008499:EE_|DB9PR10MB8287:EE_
X-MS-Office365-Filtering-Correlation-Id: c31aba6c-fad7-4536-356f-08df3c33ebd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|11063799006|4143699003|56012099006|261022075727099003|261021121427099003|261021123027099003|261009223027099003|261102123227099003|10067099003|6133799003|22082099003|18002099003|41080700001;
X-Microsoft-Antispam-Message-Info: H96u873ZUQqO7kLwMaTuImBReO1zxi0IcnpqSvGFQrAgGuYHTT1Mn+nU1KOwZN6arEvCoAm0/mhaOkkrYVFaMbqQZjAzxuPbZ6RM/OL9nMWZZ967EtLrYwlMVhcUDmqaspV5vR/TF2zpzDK9MFlT4LewAx+34qpWwdJS2RoRjtx/w2fb5sfsC+6pG1Piyuw5BhHLHRcdkFY2cuhX1AH/3khY1Kvs+2lzpPz3OF7nM1riYKGzqT3D/kfaraNMjQJ/STRHx3v6PO0alohHuA49jByu2C8XvWYLntEPyRLOiBBk6/k3CYmejZFt9F/Arh+FdjtZ3seTP5uEKDkHeZJoankj9lQRmXA5sA1JVqfOZGK91aivZeu6xCBa+dEMwilXVSt9ULj8DVDMdSijjIR60KTyo2RslSXakEdhlFYrqwO0ZzJFdQuFtiwXeJHWKb9cKq/jZj4fFe9p/VF9H5buOf6g+W/QDZgdLtCPho/BGM4TY0P0Nar3nvDcV8I9Sl1OZ00i97DCBEAkkjQ4bYVei2uIU+Qs+0EYk+bpCX1SaKvE1Kh4GAHEizAxICy2HCiGS5HM4u7RL8654iA4ncEWWeHANq60nJkU3t/NsFBvZQGtc3tW1DSQFvQMNsFeSWfS6IMc9Dw+lEwuXEWdkG1GQeVAI6W4JgA6hIp8IzzC3bjIAg+7STgUUnhhk1Wxb2b9brhP8v5ZctZnfXQ3FohbXc3sAv45byQK6MftXuVTscBhVYpdh2fDo56cpBf1M00NPizofak17xj3aaZ4kg9czw==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(11063799006)(4143699003)(56012099006)(261022075727099003)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003)(10067099003)(6133799003)(22082099003)(18002099003)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RdEAK8jCxVGoggX+vRV0VBhs3dbPEEc483Tgq4wyFXPYJecnfShAALOVZoG0Pt+TbY3TG06N/ujIGzleLDXtdJtd4eRP/8OiYNn04Ddu9oihs13SrgdOB2T6/DfT+xw5wBqRnzPO/jQmJluwXuDCUy97uBnxiKP/TpJglWTHwYNfVfwG2hjn2ewon3oGvrd9Sjf+N/tord8QPs8FDAD30EQgIhFXlR+Fs619SFuamUBajr4v2V0MAaSGj3FR38DYu44nL0bK3rjHbLJ9gKp4gF+if6NwPVYhWqKZCbquPkev+RGoNapmU9ruQqA58awUsKICiANbjpPNFL20Ml8h6BtyNPoVS4oOIqyw4qaV8G/ffm+DLA0tNx4wN4fMCJRPfDCeyDwISI4lLcfDrSVpiFp/umdIhpaUCHlhN3oMzdV8Zim/RvcQmaFWEeqsI+cn
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 18:29:40.7151 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c31aba6c-fad7-4536-356f-08df3c33ebd9
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008499.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8287
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 11/6/26 12:18, Patrice Chotard wrote:
> From: Antonio Borneo <antonio.borneo@foss.st.com>
>
> GPIO is a RIF-aware IP, meaning it has to handle its RIF configuration
> by its own. This patch adds RIF semaphore handling when initializing
> GPIO valid mask in stm32_gpio_rif_valid().
>
> Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>   drivers/gpio/stm32_gpio.c       | 61 +++++++++++++++++++++++++++++++++++++++++
>   drivers/gpio/stm32_gpio_priv.h  |  7 +++++
>   drivers/pinctrl/pinctrl_stm32.c | 11 ++++++++
>   3 files changed, 79 insertions(+)
>


Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick

