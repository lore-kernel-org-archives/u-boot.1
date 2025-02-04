Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2770EC02193
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 19:44:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C347801FD;
	Tue,  4 Feb 2025 20:44:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TTMKilGu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58181806DC; Tue,  4 Feb 2025 20:44:19 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BA8B807E0
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 20:44:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3eba50d6da7so1702878b6e.2
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 11:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738698254; x=1739303054; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tOrFC95HfhhE6p1WSZQ0LsEUTu8e8yUNH8lW80DwMJc=;
 b=TTMKilGu9LlY59XyGbwFpuOWsDEggVzp4ETWC4i/uneYici5eC9tgC5YZOalYX0kRz
 6cBbn1foyuJ+zIqO0Ug4UvQplqGNmxfYOGIWrT0GuiRFqafFi38Z4r3ETdw4u2DrElea
 e+DG7nSBZd2GAJWwD/8XYxJF/CC+jNlB8s8Hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738698254; x=1739303054;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tOrFC95HfhhE6p1WSZQ0LsEUTu8e8yUNH8lW80DwMJc=;
 b=MN9UDuRttKDwIkw29WeAGFOkcfOkkJfVCKLVaDIokic9w7O3Sz382Z7IywjAvTKqlQ
 Oi7g62kPmx3zHylF48vzr5tjjeeQCSSk7ShUJFn9fBFXIpOouAa8vLqucyGJpP5emwcD
 Xc3l2RbQtgrAqz8OXvGmZ+uQzgvPfm8Z+4MQpXrzBPnIPK/UnFypLl+cC+N1qVz5gzS/
 Sb/ju1ioh9WoxbvVJWRd/rm92+KctnLFLAD0SFei567h1EhSBaxD+PmP5/X6kge74e/i
 bozhDKHRBOX3rc7Mee0cDSbl7GPaevGBnf3oKMwmVCgFcCT9AFVPe1uGDPB1vlf7+Xrf
 CElA==
X-Gm-Message-State: AOJu0YzI8CdtEKIyM5NjBJIEVCEIpXTHgdryHZgA4IusJGZC7Yen836M
 NEXwr4+vfD1QWaZ/m2EMHfO1OrKEM9q5hPjakCU0ln5dpRc1iwsmJRUHyGW61Asr1tiZv1Pt+Dm
 Yin0=
X-Gm-Gg: ASbGncvg6BOoRqKtsHNYGNzwa34LNzBrTTWvCIotFIjXETLNc7AruvNc6FjW5m8OSGe
 7rf8+2jAv/vcMvRRP7Mqc46ewTRgfnHHoNI6+XQ2EwMMXwknLjOXWpA/3PFEtVzgPOrSixXJstD
 IfRDv7TEKIlENjsvB7B+4myqrBF1XhCYXR8w8ecbdAbKFZzXZxJAVT6JYmAUBrDkqqW5EV9dSyW
 3W1wkIURssqh+16hPnA8wg+ZV5EHeVVF7XydLL23Tb7Er6yzXHWc7WBtFJ4yuBjUkeCU5J5n9PA
 UssOPTyHDIHs/g==
X-Google-Smtp-Source: AGHT+IFfMRLFAyVEnePxK38iZ90Mguqyb8EJQXdRmWJaBHZ9D/ywFc4fO/sOgBdYj2tgc+VDPRDRFw==
X-Received: by 2002:a05:6808:2f0d:b0:3eb:643b:df15 with SMTP id
 5614622812f47-3f323a44aa8mr16803718b6e.12.1738698254274; 
 Tue, 04 Feb 2025 11:44:14 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f33355947esm3250039b6e.25.2025.02.04.11.44.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 11:44:13 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250131220420.3059801-1-trini@konsulko.com>
References: <20250131220420.3059801-1-trini@konsulko.com>
Subject: Re: [PATCH] sifive_unleashed: Rename "spi-nor_qemu" variant to
 "spi_nor_qemu"
Message-Id: <173869825309.637310.832058185238462605.b4-ty@konsulko.com>
Date: Tue, 04 Feb 2025 13:44:13 -0600
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

On Fri, 31 Jan 2025 16:04:20 -0600, Tom Rini wrote:

> Given how files are searched and parsed,
> py/travis-ci/u_boot_boardenv_sifive_unleashed_spi-nor_qemu.py was not
> being used due to the dash in the name. Use an underbar for consistency.
> 
> 

Applied to u-boot/u-boot-test-hooks.git/master, thanks!

-- 
Tom


