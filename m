Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 551B6C7EE2A
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 19:10:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA17C82E35;
	Fri, 27 Jun 2025 21:10:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="COAslDmw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2219C806D8; Fri, 27 Jun 2025 21:10:24 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58B3D82E08
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 21:10:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-735a6d7c5b1so1300538a34.2
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 12:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751051418; x=1751656218; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z6z1hpxk7m7p9fA1If7leBaSR7QSk7ai5FpTl4dKyVY=;
 b=COAslDmwnWTvmxfBLRjb0HRgVaDjxyclxPfGajq1mUwmvkzNNbeuaoaE5SXwYBLb5e
 dWp1iMd7si/MKxLy9lsSymJW4pf4+hAU6Mg7exvm4IqgdxxgiVWVbBD90wrCh8gQq+ov
 LKJYG/83j0FaL/qhGCgl6XtxrPLB7e6B1YC+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751051418; x=1751656218;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z6z1hpxk7m7p9fA1If7leBaSR7QSk7ai5FpTl4dKyVY=;
 b=bon7uuxnkNRiebMoOtBg9kQ06Sjd1Nxd9KxxXUIBS3hRLai9tlzMhsKE883gxXpaJC
 eI6k+nvNlBwFoYYhNKAHQOcucdsGpyhYyaza74acDbAxENEKgKUvbAVrW7Gbb9Du7Mvf
 bswomJ7kqk6ea5+tJFVCNwwvZHamv3wjjHJ9J7Anjf4WS2USNKrh4H63WvEuTuH1MvsE
 YuSq7SZulT4JzW6EuNS5Y43KDwVlek8Fv4cp4/DF6GmtSBmBpmQkkDUDwQXHWozAcW4C
 RCadhqe+g+FIU65aGnk84quKEC/KSsSv8XmwQwsMkZ62Uhs4XE9sFGHK42oe0fZ84P9a
 8zyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9EVSPtXGI3IhdQZ9ZbqWksuh+463FD2iXBWQanzDUupAu8BtOOl606iHXa/HF+jolVWajS0g=@lists.denx.de
X-Gm-Message-State: AOJu0Yzx/uRgo5Q7qgzhISKc9P2TYYGkSOSuKyOlxjYp/jT9DeujUkk/
 RBiBnrJTzZHcQZBysR1lIqZ8ctiwpgi1VkiI6vImfqy9oxl8StX7ux4CN/efrDegHws=
X-Gm-Gg: ASbGnctimjyoE0JZO2OTfMIL1s9AZf8gH9AauZ9ZpIFmbsmAWI/yG7hP+J2VWir3tG/
 mMs8Y0b/b2V0aQIR7yncRZdi23I6IZCzLq2inUSFYDIcLq1F2eNh2b5AFd5N5Zpgdo+2IykwCwM
 cKWHKUwXpolB8YA1XBEdrkpRYRqEqViI1BEpFeIFsbNaKL9BJp2h0Cu4Rmbmr6JupLQgcqguH2E
 7klGQmEdpbjjqE+7h2w/GR7aTkCR6+sX0y1z1tLZeWPvG52rN8XfvX8kNwa3U1Fw060J5vBaL+o
 nfjQKfOaAFItk4+44LKNwrCRQ30NLstT9SrET3wPHbDcgSook3/+K8HGdFHCcuXZl2dXsVBWNfi
 gBM3jRmFGkzqd626U+8IwGg==
X-Google-Smtp-Source: AGHT+IGEFAotRzTVTlXRsPadfTeXja0mT6ns5OUNNoRdq51yOYfCqNkFLeSdpN++tiIyFIW5kYFpGA==
X-Received: by 2002:a05:6830:2d87:b0:72a:1a9f:7dc7 with SMTP id
 46e09a7af769-73afc568049mr2348929a34.7.1751051417871; 
 Fri, 27 Jun 2025 12:10:17 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb0e329bsm465759a34.33.2025.06.27.12.10.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 12:10:17 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: jerome.forissier@linaro.org, mikko.rapeli@linaro.org, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Liya Huang <1425075683@qq.com>, Boyan Karatotev <boyan.karatotev@arm.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Raymond Mao <raymond.mao@linaro.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
In-Reply-To: <20250618065828.1312146-1-ilias.apalodimas@linaro.org>
References: <20250618065828.1312146-1-ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2 0/3] Fix io accessors for KVM
Message-Id: <175105141636.3887848.14189588840437689009.b4-ty@konsulko.com>
Date: Fri, 27 Jun 2025 13:10:16 -0600
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

On Wed, 18 Jun 2025 09:58:11 +0300, Ilias Apalodimas wrote:

> Instructions that lead ito an exception in the hypervisor can't modify two
> CPU registers at once for the ARM ISA.
> 
> These instructions cannot be emulated by KVM as they do not produce
> syndrome information data that KVM can use to infer the destination
> register, the faulting address, whether it was a load or store, or
> if it's a 32 or 64 bit general-purpose register.
> As a result an external abort is injected from QEMU, via ext_dabt_pending.
> 
> [...]

Applied to u-boot/next, thanks!

[1/3] nxp: Prepare macros for KVM changes
      commit: b56c0632ad62415a40216d6f4de850e870163a6f
[2/3] arm: io.h: Fix io accessors for KVM
      commit: dc512700ad46c16531ac57dbe5bba78d7153961d
[3/3] qemu: arm: Enable virtualizable IO accessors
      commit: fcc60481ae755cf289bb96ccef81294b0b443654
-- 
Tom


