Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02432CDE03D
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:09:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B81E788F57;
	Fri, 27 Sep 2024 00:07:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cU0HwMGk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 514D688F68; Fri, 27 Sep 2024 00:07:38 +0200 (CEST)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7A3088F66
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:07:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2e06fade5eeso1245342a91.2
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727388451; x=1727993251; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CcDzl+6ojpO6SL8Z/eJdj2Sn/Q0KmvsDEADAzWuQdg0=;
 b=cU0HwMGkRl5vgAe01FB9a/6mQHV6AaZWXR/XV+Hqg0YWrjEi2M/khnloHVZ3p9byUM
 TbAl5Ym0aep9Ux/GZ72Kr+b2utg5hQcB/balsRuH2DDo6NmvEEFqA0HZUPgH9i9V2Qql
 ZUy8l0UDDn1/l27hTylHw5yE8eqR4kVPimAwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727388451; x=1727993251;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CcDzl+6ojpO6SL8Z/eJdj2Sn/Q0KmvsDEADAzWuQdg0=;
 b=AZNPLBSBKGCr3i2xjIDKyVQIvEf9C3isaH6vE2iAnJfbXxcgCyM3/LQ9Fk8MAkRTzV
 L6+fkJEjL/Ws5/Fd2unx/OsIy5pcvs+WdddU5LW+mu98m/VjC4mEJWpnhwUzdg7S7kBe
 WnXXnEYwcRp++Uhj06ivWXkQ+n1wnv5VAFCLN+DfhMnQA/aBuEx8VNdpSGdvEbz7lrKM
 U0viY91iNsHQ1EjAVJbG6EbsXt2pZIYnCX/3FQQQDNELe4BASgGKWw1HrfZNjHOt0vp/
 fn9pVKHpbcvO+kl4w0DPKnAAq5jPbpGok3vF8ijVadmra/XsQ4HTEZIicgdGb1mSPRwV
 VyZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBk5VMAx3FUU9t2jZqFhzmIRr9gXKW/6f5y+g72diEoVek2g9hIxEKsd493rwdDQBgrcNw4rI=@lists.denx.de
X-Gm-Message-State: AOJu0YyrQQxWB6TXKECXARe9kYxTICrQD/MtpzHjGYPfWLyU0Mf3oQyb
 8UJjbi0Z1bDD5PMRS9yJbepWXJ5GlJE4Y43rc0HpxYdVGACRaGHR15RYpQF6UjFoNpsMubJ1Rax
 6Tzp4n/zsKwpzHQfX1EyGdyJZe4mq66ylJ4S4
X-Google-Smtp-Source: AGHT+IHWWLMlbcGntvI0m5HMVJqVBZt5/HgPmCp6/oVpSR0Rm+K2eZM9C3wXB6MQ0QtIlZZAFfDxXEkpDuYpEZmGpDE=
X-Received: by 2002:a17:90a:de92:b0:2e0:9fe3:346e with SMTP id
 98e67ed59e1d1-2e0b89ad30emr1281632a91.2.1727388451281; Thu, 26 Sep 2024
 15:07:31 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 Sep 2024 15:07:30 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240826191143.426387-6-sjg@chromium.org>
References: <20240826191143.426387-6-sjg@chromium.org>
 <20240826191143.426387-1-sjg@chromium.org>
Date: Thu, 26 Sep 2024 15:07:30 -0700
X-Google-Sender-Auth: KZcc0uXzQ9thGBGRYucHoyePYXU
Message-ID: <CAFLszTjEFdjwWF=Ka_e54k-H5ffAeXLWirQp4SXhmcwnRSXWBg@mail.gmail.com>
Subject: Re: [PATCH 05/15] binman: Avoid setting the image_pos attribute
 directly
To: Simon Glass <sjg@chromium.org>
Cc: Lukasz Majewski <lukma@denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Two places set this attribute directly. Update them to use the function
provided.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/etype/atf_fip.py | 2 +-
 tools/binman/etype/cbfs.py    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Applied to u-boot-dm/next, thanks!
