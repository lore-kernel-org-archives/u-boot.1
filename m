Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22AD5C36010
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 21:07:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82D8E830B5;
	Tue,  8 Apr 2025 23:07:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tThRgrz1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 873C482F7C; Tue,  8 Apr 2025 23:07:33 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E51D82160
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 23:07:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-72bd828f18dso1810193a34.2
 for <u-boot@lists.denx.de>; Tue, 08 Apr 2025 14:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744146450; x=1744751250; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=URi4tejHJ0X6abBaYmApu7s6XRGwP8Ji+BRl86xkKME=;
 b=tThRgrz1KHln6GB1lonua8MKE13pdklcrXcbwQD+ZG2IK/TY2cVQyiZ38asvPisc7l
 GC2chTVMRGTJ+SC85xGjr34b2HHXcW/G071pcyCXk3ED8TngUUFFVt0W3jJAC48QXlMG
 IMZPqjqrMlBoG2WpOOk1sgIthttCawnExQ3Nk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744146450; x=1744751250;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=URi4tejHJ0X6abBaYmApu7s6XRGwP8Ji+BRl86xkKME=;
 b=C1bUNAgixI4r61STBY/FyhNK031VkjepxRtconVsQk+H6IJWXUQ60EF8KXEbDmaqqT
 uq3lCju64ddjh52Jzv9JqWDxiwhPSTOLaanaamovB9Fb6plfj0A1akZjRH0wIa7b+Amw
 am4OVOwPF8d+mucZGKshMzIwRwX8hFAotsZvn1SCGuDY5bk6945yCFnlny7hoF6qB1kJ
 pWUzK3B3b/gDrCOhGu7cSCisp448TqT2sEEO2zs8bv8gXgzVfPhnuiKsJ9qhfLkxDDVW
 70PqA6iJ1gN/UnXsTnVdI+JrhHC+VVcSQCOD/Y121FuMIFIvfRSYswPCfxZhTxJ8SyJd
 15Dg==
X-Gm-Message-State: AOJu0YxsgUxEKqpY7dSTg5OTM9jSUo3QVCiJEGqlt8nXVFkx8n3vx2Ub
 yELDwzLoQHIW6pAhHoNSUNVQ3ezZM6t6I0PCufPQA7tJ4XPS4r4qor1Zx/4GlJ0/MgJfhZ9n3ZT
 t
X-Gm-Gg: ASbGncvppA3NBXx17CJZGXaoZQ56tSBsW8cP6U3/YKXrqlomId4q/r+Jx4u/A2wtYIU
 iulLtZPob1pOfhECKq7HMoifnaSBLjtHrqO77iE7948eNReeia2JBr25nq9Xf4rDaAsNb7EvrCg
 thacpwfsGdFwHAXWsiBamADyOHy734SzTaeGI4c8jaxzWh71wsl9ePYq0a7zesfNOp3L+anv7if
 fKDWTYwGVAHyN+loflFZrerwHD7Wd4H1Sngu0ktay0eUgXsFWYqmyhZhg6ZWPrGztkGeXdcIsJ7
 XZqS1dwB/hpOSQx8juYgGKU33NEmB10XeqsVrvwfFRXBwcDrtq62aAyP9ve66PTaFEcrALFr9i5
 92xCf
X-Google-Smtp-Source: AGHT+IFCZWupxmaJcuoXLr7pKvkO0QNrIiWELK6LMJkm+h0cdJK+P6ovLHU/LBjiNIUjPyA5nWH6JA==
X-Received: by 2002:a05:6830:631b:b0:72b:7e3c:7284 with SMTP id
 46e09a7af769-72e71b8c25bmr68793a34.18.1744146450095; 
 Tue, 08 Apr 2025 14:07:30 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2cc845ca326sm2736321fac.15.2025.04.08.14.07.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 14:07:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@denx.de>
Cc: u-boot@lists.denx.de, Oskar Nilsson <onilsson@rums.se>
In-Reply-To: <dc23a9c4-b2f6-8ba4-48ec-326b00e1e85f@denx.de>
References: <dc23a9c4-b2f6-8ba4-48ec-326b00e1e85f@denx.de>
Subject: Re: Please pull u-boot-ubi master
Message-Id: <174414644926.1438641.15532149789816070202.b4-ty@konsulko.com>
Date: Tue, 08 Apr 2025 15:07:29 -0600
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

On Tue, 08 Apr 2025 10:53:15 +0200, Heiko Schocher wrote:

> please pull from u-boot-ubi master
> 
> The following changes since commit 34820924edbc4ec7803eb89d9852f4b870fa760a:
> 
>    Prepare v2025.04 (2025-04-07 15:57:55 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


