Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ACE8C35274
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 13:15:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A664487BBB;
	Fri, 15 Dec 2023 14:15:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=longervision.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=longervision.com header.i=@longervision.com header.b="kJW6ojaj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0FF1878FE; Fri, 15 Dec 2023 09:28:57 +0100 (CET)
Received: from mail.longervision.com (longervision.com [159.65.68.90])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28B0E87853
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 09:28:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=longervision.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiapei@longervision.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8AAE08732E3
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 00:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=longervision.com;
 s=dkim; t=1702628932;
 h=from:reply-to:subject:date:message-id:to:mime-version:content-type:
 content-language; bh=g+PfVPxha5LVxznObN7eSUVr2+X1o2c5TxqPMFzSM+A=;
 b=kJW6ojajORP8eg7ReIqTDmFxJUl7aDpAS7LrFZqS9zSS+77I4ZP5j3Mkk7lN4tkhANTGgn
 06NKXc+a4NNE1/Qxf8B/X/O/nWGYYeNXFyua19gISo8i9SXNzoxpZHcXPG8foHlsdk8QBv
 RmijwMZPvL6X0bAfNecYQ/u/X02kZr+cznTbJNv1Drgs0HUoziRRyIvJBzJ0Fg1bbnC/2S
 dVIzeUV4m0AQ80zB2V4Phh03OYjzbr+vSW76csCY3YQ/GepvCkq8tXOr2iCi3Coov5VlsB
 U4O68hClcp6B0mck6nL1PmOHBbNGMkCoxg7eH/aNg9o65N8ZA3LSrPCbjyuRKQ==
Message-ID: <c3c391b1-a7ec-48e5-a193-1c63a6c696bb@longervision.com>
Date: Fri, 15 Dec 2023 00:28:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: u-boot@lists.denx.de
From: Pei Jia <jiapei@longervision.com>
Subject: Where to find those definition for particular boards?
 CFG_SYS_INIT_RAM_ADDR, CFG_SYS_INIT_RAM_SIZE, GENERATED_GBL_DATA_SIZE? etc.
Organization: Longer Vision Technology (Canada) Ltd.
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Fri, 15 Dec 2023 14:15:15 +0100
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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
Reply-To: jiapei@longervision.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean


Hi, all:

I'm using a *BeagleV-Fire*, However, I failed to build *u-boot*, and now 
traced to this step. Where to find those *macro values* specifically for 
this board *BeagleV-Fire*?


#ifdef CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR
#define SYS_INIT_SP_ADDR    CONFIG_CUSTOM_SYS_INIT_SP_ADDR
#else
#ifdef CONFIG_MIPS
#define SYS_INIT_SP_ADDR    (CFG_SYS_SDRAM_BASE + CFG_SYS_INIT_SP_OFFSET)
#else
#define SYS_INIT_SP_ADDR    \
     (CFG_SYS_INIT_RAM_ADDR + CFG_SYS_INIT_RAM_SIZE - 
GENERATED_GBL_DATA_SIZE)
#endif
#endif


Cheers


-- 
Dr. Pei Jia
Email: jiapei@longervision.com
Cell: +1 778-863-5816 <tel:+17788635816>
Website: https://www.longervision.ca
