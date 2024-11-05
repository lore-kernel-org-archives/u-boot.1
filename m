Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1928D1CA0E
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 01:07:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7C2E88F4E;
	Tue,  5 Nov 2024 02:07:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OY9Tt/PM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B805688CF1; Tue,  5 Nov 2024 02:07:06 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF43488CF1
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 02:07:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6d36f7cf765so20025576d6.0
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 17:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730768822; x=1731373622; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PkWh4/3cjxdUk+6ecpAXIH5EcAh+iZSAU4Wj1Kxvov8=;
 b=OY9Tt/PMGkwSxqz0UViDH9pL8v+Zy2ad5nV6KenAfZGUIfzyDh6N8LYXGOJIMQ248S
 eY6vxl0sP1yUucEc7g+ioRa8FgbX/gmZ+0F39I8i2eQ1tyMAwIPOmFgxl4khTSKpEmAs
 lr+Ujvx3ZT00Bwq0TbnAaZk9PMky6UNgbW9rU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730768822; x=1731373622;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PkWh4/3cjxdUk+6ecpAXIH5EcAh+iZSAU4Wj1Kxvov8=;
 b=mNWHBdbPCiVLOjzwLGITBtaQWDXBTTXZ7gWIBgDL0gwWxlxhasocuqvIG5Cm4HGh1W
 jLBZWqDTacjIeBs3BNSQ18Fq6EbeFzR8D6MyBkenWKbbUoYqlgq2hdzDfMvrDYfq5gh8
 Gm2a8ROom8KJQw9HfMbqKp88c+XWHUPf3TYDD7eBlLmcDsngPEH66A81dXO1klEp5fhK
 TjSn+lbIBpPZZ36i4eYCnmUet14GTG/ojDIGFk4gUz85bhG3y5WR/SGrXiuHHW4NLaUA
 dTagX5ksLK7kGpYgnLPiKLkGTo/ZN+0k9FFiDdbVr0elGBoLdKEDUrEqN8sOHVzCXqX0
 mJhw==
X-Gm-Message-State: AOJu0YxwrXmCYorsRBxjTInsCfDsEEFgJXey2zQWMLJ6mI9rCel5X+mm
 0FNGxk+1FL5gA/LwqlNpFLD6jq7mzSe87+Ao+KsvSkzJSRxXqCLOkBj14Ch4B0Q=
X-Google-Smtp-Source: AGHT+IGt5jwME+tR4GGokBesaLN89j8/kwQgWMKZgZoc7X86Q2fktarCXM8qeHqpeSPyWE0GMHNRIg==
X-Received: by 2002:a05:6214:458f:b0:6cb:7104:f115 with SMTP id
 6a1803df08f44-6d35c088599mr230742686d6.11.1730768821794; 
 Mon, 04 Nov 2024 17:07:01 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d353fcc777sm54436686d6.56.2024.11.04.17.07.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 17:07:01 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Love Kumar <love.kumar@amd.com>, Marek Vasut <marex@denx.de>
In-Reply-To: <20241015121916.1155120-1-andrew.goodbody@linaro.org>
References: <20241015121916.1155120-1-andrew.goodbody@linaro.org>
Subject: Re: [PATCH] usb: Fix test failure with multiple partitions
Message-Id: <173076882046.3917422.11680751214718510415.b4-ty@konsulko.com>
Date: Mon, 04 Nov 2024 19:07:00 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Tue, 15 Oct 2024 13:19:16 +0100, Andrew Goodbody wrote:

> When test_usb_load finds multiple partitions of the same type then
> it will cause a test failure. The call to write the test file will
> write a different test file to each partition but only return the
> name and size of the last one written. So the test then fails to
> load the test file from the first partition as it uses the name of
> a file on a different partition.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


