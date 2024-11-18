Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A1AD49225
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 14:19:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 415CC89468;
	Mon, 18 Nov 2024 15:19:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uVvBeJtw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D30A89456; Mon, 18 Nov 2024 15:19:39 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A8A6890D0
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 15:19:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-460da5a39fdso30206471cf.1
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 06:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731939576; x=1732544376; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rha3lZF/HXK2MDPAWEJdr4TW3MfVS6+eDnjWg9dVQX4=;
 b=uVvBeJtw5sXQdSU/lYHHXz9CQpNBgUb0hihPBtlHSLnkFeXZh9owBrBnA/997gXdI3
 qVLBa55pL4TrG9JCrKMylKLB3Ec6CEt0kQzLJFBRJBWqLM5GN3rv9nZPk/xT0RdTaEsy
 P5H9RNdKjHONLrze0+SK7Q91pVvSO09rwHIn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731939576; x=1732544376;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rha3lZF/HXK2MDPAWEJdr4TW3MfVS6+eDnjWg9dVQX4=;
 b=bzcY5CxHc++DDTIWXaSOIwLxz2FPlw5kzbjCg7YuFLZiqEXNty57c1JsswNGwnMQbT
 RStoV2dC2yor6VfKJV6+9ugPnAcHsSAMf+69mwCdDdos8BVjWoIal8cvdgqgvLPTfJsB
 q3UryN3YoIn0nAHdzbtYyYEg5eVGtBwwPGmu02Ow3VcMt9nGlSfXNcZD4LQ9ra+56ehn
 e4RS6UNmjWkQEmeXEy3lS+bplCIREG25pkN1p47+gOVN0znvlb8gdxy2G2BB6ivTT/yQ
 kuHpwNuth5L6eUl+BgeLYA0NG1QI1peRdwl0VhbgpY1KB8kI88umxfAFPEbOdko14Lj8
 kLYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIfL/0XFocllx+7dGBJCN4kB7t4lZ0OyceTzIW5LQ0vg+RsLF9BnBRvSZQius3XUukD8Wm9Co=@lists.denx.de
X-Gm-Message-State: AOJu0YyCLC0v1fyZ/pFAWqs/c0Rp3SjtGWVAjfvuVdxnLA+HjrIuOC1V
 QkQrr9RGL/pMPYQWrODpg4FLiEx5RUvBAHwDQ84uZez91OlDQYHQMmgvmx9Sk9Sedxt46aWlbhg
 X
X-Google-Smtp-Source: AGHT+IH9MwqL9dPBqfyNnW8FwEDSbaT9lLa4pFWTMCIr9sbKNw0wTUrEKHz2ij7WqH8GkLbRhYmNiA==
X-Received: by 2002:a05:622a:6113:b0:461:6f0a:3826 with SMTP id
 d75a77b69052e-46363ee1e15mr225908421cf.55.1731939576110; 
 Mon, 18 Nov 2024 06:19:36 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4635ab24e44sm59075981cf.59.2024.11.18.06.19.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 06:19:35 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Sam Protsenko <semen.protsenko@linaro.org>
Cc: David Feng <fenghua@phytium.com.cn>, u-boot@lists.denx.de
In-Reply-To: <20241107025831.5459-1-semen.protsenko@linaro.org>
References: <20241107025831.5459-1-semen.protsenko@linaro.org>
Subject: Re: [PATCH v2 1/2] armv8: Fix get_sctlr() return type
Message-Id: <173193957473.3366111.643319489457952982.b4-ty@konsulko.com>
Date: Mon, 18 Nov 2024 08:19:34 -0600
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

On Wed, 06 Nov 2024 20:58:30 -0600, Sam Protsenko wrote:

> SCTLR_EL2 is a 64-bit register [1]. Return its value as long (64 bit)
> instead of int (32 bit) in get_sctlr() to make sure it's not trimmed.
> 
> [1] https://developer.arm.com/documentation/ddi0595/2021-06/AArch64-Registers/SCTLR-EL2--System-Control-Register--EL2-?lang=en
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


