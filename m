Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D00CAC593
	for <u-boot@archiver.kernel.org>; Sat, 13 Sep 2025 20:44:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87E1883043;
	Sat, 13 Sep 2025 22:44:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="wPfF2TVR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F1BF8307F; Sat, 13 Sep 2025 22:44:20 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35AD0809A5
 for <u-boot@lists.denx.de>; Sat, 13 Sep 2025 22:44:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cPNZ82czjz9tFr;
 Sat, 13 Sep 2025 22:44:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1757796256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WEtYCxC06oxezxzpUOGZGyxEjWN5eHW+HPqzVGaMU/4=;
 b=wPfF2TVRDdM6FehIOFnpjF0UGS3GYzyY3rLkIYbCnxmvz7CafI+G/haEKbEZbYC4FXsvZ8
 kXP7BafRUML5bBIXukeEe9scq8YbvXAja6Tx9sh9E0Lro5z6G68QxkqgAMD19nVHkmiEut
 D/WQjG1g/RwtsOESreoXV+Hc/dZj8OsYPLEziK/QFNSdJlmSTCEEflj76HeGpvOtUoMfsV
 OhONpq16OkQ1ULig/R1PKOh5eqHIijkrinvHAOQA1S1tpSbaFQycjY4sPo1+cj4yE7ANGd
 KQFDNOHF55HlKyQYQnGPq/mqJc/8DAKtWIRmCvkDNhsBY1ZvBirLakZFZgCp4A==
Message-ID: <a700543a-42c6-43c1-9411-4f33a3d240d0@mailbox.org>
Date: Sat, 13 Sep 2025 22:44:15 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 4/6] usb: gadget: max3420_udc: Remove unused driver
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250911215404.3955132-1-trini@konsulko.com>
 <20250911215404.3955132-5-trini@konsulko.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250911215404.3955132-5-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: f964b8f97a399d8b4fe
X-MBO-RS-META: 8f1cna9841xjd4u5s8zukdxuacgis5i5
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

On 9/11/25 11:50 PM, Tom Rini wrote:
> This driver was never enabled by any platforms after being added to the
> tree over 5 years ago. Remove it.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>
