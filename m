Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66CBFC4725D
	for <u-boot@archiver.kernel.org>; Sat, 20 Jan 2024 00:15:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57F7C879D7;
	Sat, 20 Jan 2024 01:15:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eK/cVBkf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 453AF879E6; Sat, 20 Jan 2024 01:14:19 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EFA087842
 for <u-boot@lists.denx.de>; Sat, 20 Jan 2024 01:14:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malu.bertsch@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40e80046246so8056625e9.1
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 16:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705709655; x=1706314455; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CqrKcU/ymLitfkzad1QNq4ndmYH4qSsFbHreBa6ZPEE=;
 b=eK/cVBkf7LoZrUelKJ1N0pdJ5WOvlDe6+dnUKUl6Mmqny0ic32EwNS91XTEeGvBiIz
 cG6oc5IFsodYsnArWmp1RjmkUU1HyUy92t24XoteiBUAmrDPzw3rMLgXOa8P1vW0ne+R
 49zuvy5BZiaDf/w0u5LNqvOwG7FEe9t1l3o2YuWGgjq5CBgFdljIY1v1dZlfflPlotzI
 mgihh7aPQrK18C7O01nRtWwleicGdhw8Z25E39a9eWbC/3mBkLokHyXA6K1jotBXaheJ
 zVKDcdv1P7u1ozMieOSsF2P+yLRP15YC44dBxP35mcvfVhisDz0FJayNRnmfBNO+EIz/
 NPzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705709655; x=1706314455;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CqrKcU/ymLitfkzad1QNq4ndmYH4qSsFbHreBa6ZPEE=;
 b=BEtdSVGzSlTIlsm/dsBTdb5kyzFAZkG1IIgDFe5Mxy0h8ECEtF+v/G/tont5EHeoFy
 k7PLgMQLgWCC2P5aUwh9DTjfvsNShDn9CShumQqqVQwq+VUqz5QPabySSxGzRvgvhSep
 dRrRix2yXB/gWADqZi8xqIQbu0tl41dprYjXgDppgj2jfsGRpGDyZw75L2q0QmzVt06/
 U6AZKaH8pid2R83JvTO4fWBR+Q87jQ5iOFm24NmCFGfnmuMGaG3i3Vn1C3aFKFf6FXhX
 V/lebQsqNUbgEBoeQsl73Z9B3rgSaN2cZav1n0aMtiSnBk3btlRQK7XLeiB+Z80NNmIA
 YkxQ==
X-Gm-Message-State: AOJu0YyuEFnn8EyHKBwVuqJV96Tt1UZBgHmBegUC1miiS/Hpx5dKA55m
 EGpAiqMrxDoGdpLp6SCXPlA8y+Ly5JEJDViZ2dd9fVndfx5fKdPSwou4s6XPG0U=
X-Google-Smtp-Source: AGHT+IHsPwo0NOIGZGKBY7vJfHBoRBm2KMAVUuIrlHWT7Vw6UGmVmurs8Ig073Wcxb2oJ6HExF1iIA==
X-Received: by 2002:a05:600c:4c19:b0:40e:557d:a5a7 with SMTP id
 d25-20020a05600c4c1900b0040e557da5a7mr327796wmp.160.1705709655257; 
 Fri, 19 Jan 2024 16:14:15 -0800 (PST)
Received: from localhost.localdomain (pd9fafaa6.dip0.t-ipconnect.de.
 [217.250.250.166]) by smtp.gmail.com with ESMTPSA id
 w4-20020a05600c474400b0040d5ae2906esm34705140wmo.30.2024.01.19.16.14.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 16:14:14 -0800 (PST)
From: "=?UTF-8?q?kleines=20Filmr=C3=B6llchen?=" <malu.bertsch@gmail.com>
X-Google-Original-From: =?UTF-8?q?kleines=20Filmr=C3=B6llchen?=
 <filmroellchen@serenityos.org>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?kleines=20Filmr=C3=B6llchen?= <filmroellchen@serenityos.org>,
 Bin Meng <bmeng@tinylab.org>, Leo <ycliang@andestech.com>,
 Rick Chen <rick@andestech.com>, Samuel Holland <samuel@sholland.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/1] riscv: Support building with Clang
Date: Sat, 20 Jan 2024 01:14:03 +0100
Message-Id: <20240120001405.29294-1-filmroellchen@serenityos.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 20 Jan 2024 01:15:27 +0100
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


Hello everyone!

This is a minimal patchset for making U-Boot build with Clang on RISC-V,
something I stumbled upon while writing U-Boot build scripts for
SerenityOS's RISC-V port. The only change is a (for unclear reasons...)
differently-named flag for fixing the global pointer.

Notably, this patch does not make U-Boot actually functional under
Clang. Booting this on QEMU (`-M virt -kernel path/to/u-boot -serial
stdio`) hangs after the image is loaded. I do not have the motivation to
debug this, but it may be helpful for further work on getting a working
build out of Clang on this architecture.

Greetings,
kleines Filmröllchen

PS: I am new to a mail patch contribution workflow and may have messed
this up despite reading through plenty relevant documentation. Please
kindly point out any improvements I could make on my side.


kleines Filmröllchen (1):
  riscv: Support building with Clang

 arch/riscv/config.mk | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

-- 
2.39.2
