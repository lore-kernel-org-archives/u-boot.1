Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B92D9C0219D
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 20:40:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7759F80EBD;
	Mon, 10 Feb 2025 21:39:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="U5bqQUPz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F293580EAF; Mon, 10 Feb 2025 21:38:56 +0100 (CET)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0449803CC
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 21:38:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e587cca1e47so4407183276.0
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 12:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739219934; x=1739824734; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=43Fi3yz0oBbkf1gQ4S8Vi6z39zvrAr44pPeJUhUk4ZQ=;
 b=U5bqQUPzYkJ0giBvCqa8U6iNTe8MkDpYY1jxIRh4pASqYEdNJg8hGVzUiKC2qluxh7
 Q1WXESoYLNSBQhnxGPFMIhdkxB1UbeLhIs5FmYbUDVLPit38vZDhyKI3giqOEN2P5sU6
 nbsVQdfHsMXiQZEjI3kNkt8ebOIFOmX7cZ4f8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739219934; x=1739824734;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=43Fi3yz0oBbkf1gQ4S8Vi6z39zvrAr44pPeJUhUk4ZQ=;
 b=qlgEYyUhmX4FTsJZvVDPhCAV5WIS4MeT2UXq0dk0xxo2Cd2TXP5IZpjQKzCc1+mTx1
 0LDCzvziB5qQt1zHikn+8lRHMwuRTL2EUgfzWUFzAZv+XaVnSoqAJX/Acr67al17tv4I
 fWdJ00U0Y68IH6+9jdVr32PmGbRp/wwVhcwPMdyvaM1pI4M2puk3R9WxxqRyqhTkQLk0
 7xTQRMtltxTUbrW24ouemzMZ8icGepCH+1uIAJt3Q618c/xfPPzPDyiHRkVxywie9ziu
 /6C3iRur6L0OpNec1oFTrhx2oyP1mSqqz4aBxRzdATidXrgJuLu6w1aCpoIUyGrEVKJw
 7uaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnnk29LWjeNyYko+v9xp4wyG7q6KMhMzF37a58RlW4p4hcf3DBXVChh4Hj3OqZ2afyXtxJhQg=@lists.denx.de
X-Gm-Message-State: AOJu0Yy5UMqfoVpE+czyPqhsQUTCIhiOhxR4z+8WsVZ8i0BR5cH+aMON
 GLIPKt/OBGzL8mdLCkV4oS1SmUnOrANx4xXj67TXGXNjjvvIMbexl8St1NCkPMs=
X-Gm-Gg: ASbGncuNJF23J0q7ZJmT13bFGLqKzCyXHIff+1Ws9SLXTkFzvaEIFQezE63RB0vDfKq
 9ZmMta1Cist8pPWO2ARBOp1PwEHynzHrXsaSs+IjUbdsjBPnYBXYBEE0G+t6JFh1WzgWpfxf8Al
 lVJxZe7bxJOECTHF8XtOnsoB+hXKzGraz+VNZTPtV5FyjgAP9smZI5+qFnrC08JhDBXG4RyecIB
 dYqFCFBR8BociOvoEmyM0cQ2+5KiOr7DPZuVzr1gCiQSAfVjGfoLud7jUZPk7MK1AhO+auAjPbo
 utoCTAweHZvFkg==
X-Google-Smtp-Source: AGHT+IG5hVXJsSacwys/krjSF53jZ7cpnK8pe+qrteiT+1ivAZynChC8JUPPCIZWUxcqN5VllBDSSA==
X-Received: by 2002:a05:690c:48c9:b0:6ef:7370:96ee with SMTP id
 00721157ae682-6fb0b48f42fmr16529477b3.12.1739219933195; 
 Mon, 10 Feb 2025 12:38:53 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6f99ff6a8d8sm18233207b3.79.2025.02.10.12.38.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 12:38:52 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Andre Przywara <andre.przywara@arm.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <20250130133646.2177194-1-andre.przywara@arm.com>
References: <20250130133646.2177194-1-andre.przywara@arm.com>
Subject: Re: [PATCH] env: fat: Avoid writing to read-only location
Message-Id: <173921993224.2921783.7276745720716554502.b4-ty@konsulko.com>
Date: Mon, 10 Feb 2025 14:38:52 -0600
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

On Thu, 30 Jan 2025 13:36:46 +0000, Andre Przywara wrote:

> The env_fat_get_dev_part() function mostly returns a fixed string, set
> via some Kconfig variable. However when the first character is a colon,
> that means that the boot device number is determined at runtime, and
> patched in. This requires altering the string.
> 
> So far this was done via some ugly and actually illegal direct write to
> the .rodata string storage. We got away with this because U-Boot maps
> everything as read/write/execute so far.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


