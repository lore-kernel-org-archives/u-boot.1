Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F0CC83F1B
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 20:01:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0835683055;
	Fri, 11 Jul 2025 22:00:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="X+XOaxOl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4926483018; Fri, 11 Jul 2025 22:00:55 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1520A800D7
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 22:00:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-40a6692b75cso1595545b6e.1
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 13:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752264052; x=1752868852; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6EB2NR6zOp1WM7AdW5fdJwnPbd+dfaB3yAe4W9m28Lg=;
 b=X+XOaxOl8SV0cYHcUPu6BasDYhSTVb4NajslLT5cXG4JvMb15xnGu3AblrsO/vgG4U
 lhMp5QY2ttnp4vMaL/b21LI5XTROQdjoqhYTfkbmTHIsKvCv+0tIX+AddxvE1hcqVPy9
 Rv9EWXhKhNUDQRqVeZUTICAeul9ILuNi4Z+h8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752264052; x=1752868852;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6EB2NR6zOp1WM7AdW5fdJwnPbd+dfaB3yAe4W9m28Lg=;
 b=O7qfvN+ivAA49bK7z4ZgpdptNI1/oPwgZITGUaRNS3VX4il3bASHig5qKz6lhdvvTc
 t4PZsLJnxzbbOCRuOOH35v2E+r07IuUMtZaj9h3Ejx7SdLoC5eLDGMtYre7AfmmvXQXi
 Dcy+y+KhnznHlOegtzaMZOw/EdoS5xW0l34rj/q63VFTA+jsIhhcAn2ul5yeeSZJJAli
 kMlBRQudRA2aO02O/J0eKwJX6+eEO4l/O8GClxtwyTc6qbOdWWSIP6Ykk9oYBkR0pIgl
 ZhG2M5eTnFZnNP3Jjjuue1fIg1lpZkmoIjXCUTdr/xvi0pjlCQoxktdYJRK8QzyWl+F5
 l7Lg==
X-Gm-Message-State: AOJu0Yx2+Qssr2D1bD26dakuDwVaS+JA7bVo4ILUJaKIcLQ+vD1/duzv
 12OqDaf2yl2d8IKm4ZyaIcQB3nNnaH2GPITtWZzVcP3uuaP1j34NBLelFWBk75UvE1AaVDRxx3b
 uUNlRzdY=
X-Gm-Gg: ASbGnctH6/XYkYylxeP9+lK/6ZhLrxntgNj4X6yD/C/yfiCLJNGZclGbAaZAZ0WUPnE
 EqgeRh0nT44XOyuRpjsNxzqoP2QiU6WubhZsoc1wOsG2f23VEmTefOig2j7498XHYomqJ4KCka9
 R6iCTgn/SpB1bIrzwQwj0HiDZDw9kCR1AodUmsaPhbIiH+wXAOPqQJsww6HARFjeg6MNqxPAQK+
 m24agAX3Pwdwbwon0vR2iyfE8k4iIGiecuFoDQLi/YUpTCPekn7VUAsNq4Rd3xskeCHStbNnFmP
 O0iA5zC2IuP/2sKi4V1up2jGkbNAaSiannQ5jvcm9nfn9tNJqUX8eDtvB3AII8nQ6niI2EpeB2/
 PjgKBkmE38G3CcUCdlgeD/MQa8a/aw2K/g1Qs1hOtMcWUhmVyEmoFuvQ=
X-Google-Smtp-Source: AGHT+IFpb/fOTod0sHclntwtlEEYElSvKGTm0s0Oos1CS3JaE+f7pkMOnDHYOI4Q7zO1azVAXE/Z2A==
X-Received: by 2002:a05:6808:4f68:b0:408:e5f8:9e2b with SMTP id
 5614622812f47-4153795af35mr3140025b6e.10.1752264051510; 
 Fri, 11 Jul 2025 13:00:51 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-414161e2b74sm666516b6e.0.2025.07.11.13.00.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 13:00:50 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250704214606.3418898-1-trini@konsulko.com>
References: <20250704214606.3418898-1-trini@konsulko.com>
Subject: Re: [PATCH 1/2] Kconfig: Add COMPILE_TEST option
Message-Id: <175226405040.2365211.9120754440868533349.b4-ty@konsulko.com>
Date: Fri, 11 Jul 2025 14:00:50 -0600
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

On Fri, 04 Jul 2025 15:46:05 -0600, Tom Rini wrote:

> Take the COMPILE_TEST option from the Linux Kernel v6.15 and since the
> wording there is OK for us too, use it verbatim. Also update the default
> for WERROR to be COMPILE_TEST which again matches the Linux Kernel.
> 
> This is the first big step needed to allow for "allyesconfig" to be
> possible as it then lets us then disable things that aren't valid for a
> compile only test.
> 
> [...]

Applied to u-boot/master, thanks!

[1/2] Kconfig: Add COMPILE_TEST option
      commit: 011079c375d029f47e91d57f84927f392ffd2d61
[2/2] Kconfig: Test for !COMPILE_TEST in some locations
      commit: 7adb9b03a6447a80925c6eb02fedb6b022ef6e14
-- 
Tom


