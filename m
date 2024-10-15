Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B01B3D1F9C6
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 19:44:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 090FE88B6D;
	Tue, 15 Oct 2024 21:44:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KAlyFUIi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CC878888F; Tue, 15 Oct 2024 21:44:07 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EF2B88B5D
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 21:43:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7b12a02596aso153849785a.2
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 12:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729021437; x=1729626237; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aBp1BLL+KMQuzqNyXpZFc0eMhbHE1AJgI+X4RBWquPM=;
 b=KAlyFUIioArrjsbbn8owGrd4eTev5/7L+Iow7w8cyQkEd6jJdMt7eBnL90IzmYjiVA
 Q4Qf2WcS+fJLWPWl7q9DWNj1omsNEU8oSDF84kzigpgQwfU9QGSNS8x8Gqlf75tyIfup
 rWVb5l9aKCrvxDJDiME6s3xSE88HHO5/9HFHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729021437; x=1729626237;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aBp1BLL+KMQuzqNyXpZFc0eMhbHE1AJgI+X4RBWquPM=;
 b=YWbeaLLHWahFtHs+6UNzi26yjfXx1S1RVEW519aS0jxZD02BGz5l/TnW7RAA44GGyH
 VuyZVQTlbIWFx9ExvXFVhIN8gpwrfDTYQgrRkj0nsYYXVVfA1zFfDrt9e0Lg2E/X6tg7
 nXuEKD91mzilnjS/vSbQO26xCHwzYu/z3coIm/9J2jmHPAmQv2bSSoUJ8NNyfyEeA7cO
 M3P6p63r84gg4fFacqtQl8o9DA7NlBRS4wKvQXn78SF3qYiUnxM9m35fiKEQqt7dL86x
 ay0XQ8/HtIc0569TkNi5ZmOIwJcjKCn9awuWWAeKWEr+ev9gcuznYfVpiZMh5Miwvz08
 lROQ==
X-Gm-Message-State: AOJu0YyV0+WQ18h8EDOFK+OSxxVP447I0Mapwi+Tr+7a7ZPZDvG+iioQ
 DzM8E9a++Ukb1uGJaCIY/sQVvavCXPgrafdzoDIs+GMbwkG6oDxyc76BTIFzusUzBeYozqP9gua
 /hh4=
X-Google-Smtp-Source: AGHT+IHmL9p+8tWGkB4peLIFKL6ADH24QLnn3jJfv94qbKLH+dxDMzX9R8ooJQoqu5jsQdd2jLyVQA==
X-Received: by 2002:a05:620a:1910:b0:7ac:b213:36f3 with SMTP id
 af79cd13be357-7b1417d7124mr215267585a.14.1729021437411; 
 Tue, 15 Oct 2024 12:43:57 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b13899c31esm94873385a.99.2024.10.15.12.43.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 12:43:56 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Love Kumar <love.kumar@amd.com>
In-Reply-To: <20241008120813.622408-1-andrew.goodbody@linaro.org>
References: <20241008120813.622408-1-andrew.goodbody@linaro.org>
Subject: Re: [PATCH] test: Fix skip check for sleep command test
Message-Id: <172902143603.5381.12884875348892238836.b4-ty@konsulko.com>
Date: Tue, 15 Oct 2024 13:43:56 -0600
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

On Tue, 08 Oct 2024 13:08:13 +0100, Andrew Goodbody wrote:

> When the config option CMD_MISC was renamed to CMD_SLEEP the check
> in the test for the sleep command was not updated. Do that now.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


