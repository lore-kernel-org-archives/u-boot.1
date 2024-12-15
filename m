Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89FA2E7716A
	for <u-boot@archiver.kernel.org>; Sun, 15 Dec 2024 14:03:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7DE58005D;
	Sun, 15 Dec 2024 15:03:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ug5F7CMD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BB7080050; Sun, 15 Dec 2024 15:03:53 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D62180040
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 15:03:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7b6ff72ba5aso159326585a.1
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 06:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734271430; x=1734876230; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vo6V1fHD0D02rGD2DMJ4JlWwNw6IUycFI48VGdByRHs=;
 b=ug5F7CMDCiCjGE4LhL7e9mDgowNGS0GXdgbHDH2PIAntuiCQWHA6+AM8302TbKEmR9
 UOQ/Y9sEoSmMjdR44fydEaHxfHxzdx0LeGC2tTNLpeHCGI+dREXKmq+84VMoeJF/lwak
 4gI0grjtPqSlr1t++3S/g67ZJLT9ACjJ1zTfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734271430; x=1734876230;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vo6V1fHD0D02rGD2DMJ4JlWwNw6IUycFI48VGdByRHs=;
 b=sUEhgMrPgww/ILi4Zhkuq+zR9UXxPUXe6bM5uQWA72QS9JlNwf0V37+KkW5GBBzEwc
 aP6CwXiHlMpsbnKKYrSGUZYauSOsaqc93a3onVbWJ9cnzUnGT4GNZPuV4xfEhy0pl017
 HWkS67gL+h1369sy/6Nx3gL//BOBxj0Wn86uiCqbQwz4dl9W6JPq1TlxuByUauTTb88F
 7k+IYZUjpnoOz79Y+7nSkWTprf0yWYFtjTpenIY9QRPmWxbnfPmD4QQUZm7MkOtifj1v
 obIFz/GPtWRr9F/69ZisGINRzw7iBz99H8fiww2OLW3BU/gXDbZvgNCtgh862Z3d4Avx
 oJFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrJ5KsVGE9NoMU6edl0QiyGi2obi5VmKaQBDIiGqIyzHlsxceziQbnAmFpXkMGGqWDA3otX80=@lists.denx.de
X-Gm-Message-State: AOJu0YzVnl/rAIcMXgtgHsYYS6wRTuRIfozITJIytDh4+0Cl0yk1+A4I
 HNN7RSiBPWt8fuvrkue5RrsSU7NiB0D/CwduYrU0TYhqssFA35cKkZ7jAxI5/ck=
X-Gm-Gg: ASbGnctrGKcOZfEXBxA/SZM10z0FltmtLLeC3/G7oTdUILg57yXnNPsmu2Y0PYNF9Uy
 L0fsIuURXB3kscImPpnPzU4G/lrACPBf5BlKfshClbOVa2dvNFbifzhSdiU2AHVlmKit2KWWeiK
 LIozJ3ghd2mDwYtkq96abLo9abnOn+vetsSYpOnHj3gv5GRUQiPDwz7yT6bf26NGL+bXHPbmgRx
 36TvLhRIeOomxpkD5M+NGG3yu8cXly3DAz1CpCMjB8yEMrw5x9axO8=
X-Google-Smtp-Source: AGHT+IFBmCwytkwUa/6gyjtdhquzM+ZdMO6XIby7Lhe1CHa7/fbPIS5d9bUapscdPXrRKKgapb/a/g==
X-Received: by 2002:a05:620a:2690:b0:7b6:e931:460a with SMTP id
 af79cd13be357-7b6fbee660emr1716777485a.21.1734271429823; 
 Sun, 15 Dec 2024 06:03:49 -0800 (PST)
Received: from [127.0.1.1] ([187.144.29.192]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b7048bd82asm139942785a.82.2024.12.15.06.03.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 06:03:49 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Gokul Praveen <g-praveen@ti.com>
Cc: sjg@chromium.org, rasmus.villemoes@prevas.dk, sr@denx.de, 
 pbrobinson@gmail.com, jonas@kwiboo.se, u-boot@lists.denx.de
In-Reply-To: <20241126105131.43359-1-g-praveen@ti.com>
References: <20241126105131.43359-1-g-praveen@ti.com>
Subject: Re: [PATCH 0/2] UART support for higher baudrate
Message-Id: <173427142791.1931614.16747957994473568570.b4-ty@konsulko.com>
Date: Sun, 15 Dec 2024 08:03:47 -0600
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

On Tue, 26 Nov 2024 16:21:29 +0530, Gokul Praveen wrote:

> The OMAP specific UART driver is changed from a generic implementation of
> certain ops functions to an OMAP specific implementation of it to add
> support for higher baudrates for OMAP devices.
> 
> Hence to support the above change, static functionality of ops functions
> in generic ns16550 UART U-Boot driver is removed and also migrated certain
> macros to its header file for usage in device-specific drivers.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


