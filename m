Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C57C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 14:51:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2C27880F5;
	Tue, 18 Jun 2024 16:51:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kfbLDMc5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60B5188356; Tue, 18 Jun 2024 16:51:25 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5353A8838E
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 16:51:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6f9603730d5so3004432a34.1
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 07:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718722281; x=1719327081; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oVLuWWQLsaNEnsYNcaYHaAsOVICG5bzRBU5HveSaJ6E=;
 b=kfbLDMc5D5AsoV5bIwgp9GyZzVEcBifDxCtaRxbc0Y6RJnexz8JFgz3EocZYHRyBhC
 tg5cN5nxA2ToLYVHhUP/LuYEvhxPfhUGZhMUMkDK2VJlFvso77v6yKrbmFXik4OsE8Vw
 ER5OYR/4cM4L3hzznvdXHLmwZJdykuhn520SE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718722281; x=1719327081;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oVLuWWQLsaNEnsYNcaYHaAsOVICG5bzRBU5HveSaJ6E=;
 b=Naqfi9RU4gFjSoJXXSdyrW7yKAjU11NgaG7ok+QDL5O2OqaH0sSHhxjgfpJRLZLV2w
 x4ZlNrm685AMoTm5F08L2KYlvIYt+lyapHadjM/O7DvizRZwh/4l3uPgCQUCkeC1FYIx
 kNZFPq/EckEEYjwPPi3/CT0ZVPfnQq4K2NRPFe5EWZf+W/86wEF7ujZTTOoX50InTuG4
 fZaEQPFvtPkWmlIn4CPW9iceu87wR2IZiE6Hglxopi6xz6aFa5tQgk1JNAgrIlvs0HsB
 hK+HYB3OVw1vUSIhx1NJiddjzGntfBi3rgTK1dzkU+AvXm1N7NC1kiN1AUBI+c4SriCY
 i/gQ==
X-Gm-Message-State: AOJu0Yzeal7OotNs6c5dk9kZMaUdjrO+kqLT1xLHd6+IrcyvhUOE+8m0
 D7ITGfrMascOq7m6Cu0dhhfrvPGk00MBCEjchtSHmXdUIY2Vxl+bNbtGLB2BwHsiqKzSItoFSsN
 oUHTPVQ==
X-Google-Smtp-Source: AGHT+IHcL4sLkhM24g5kBu9Bmz391laX1+kRLtnm2ZhcaXtF60YVJrQTelN/YF+g22VRZU/AXx5hNA==
X-Received: by 2002:a05:6830:1342:b0:6f9:b580:e420 with SMTP id
 46e09a7af769-6fb93b373b5mr11765620a34.37.1718722280961; 
 Tue, 18 Jun 2024 07:51:20 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70065565838sm11211a34.43.2024.06.18.07.51.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 07:51:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240611210025.798978-1-jiaxun.yang@flygoat.com>
References: <20240611210025.798978-1-jiaxun.yang@flygoat.com>
Subject: Re: [u-boot-test-hooks PATCH 0/4] QEMU Updates
Message-Id: <171872228034.3306863.669778775197622668.b4-ty@konsulko.com>
Date: Tue, 18 Jun 2024 08:51:20 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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


On Tue, 11 Jun 2024 22:00:21 +0100, Jiaxun Yang wrote:
> This series updated u-boot-test-hooks to adopt QEMU 9.0.
> 
> It also introduced 3 new boards: qemu-arm64be, qemu-xtensa-dc233c and
> qemu-loongarch64.
> 
> This is required for CI changes.
> 
> [...]

Applied, thanks!

[1/4] qemu-vexpress*: Pass -audio none
      commit: 7eaa30aaa2dcdfd939db662ef517ba8c411301e7
[2/4] qemu-arm64be: New board
      commit: 7de06ed2d04ad9d771715139f26b45ee6b7cb29c
[3/4] qemu-xtensa-dc233c: New board
      commit: 47b1a21625e3ca75b43661efaabfceb40760587b
[4/4] qemu-loongarch64: New board
      commit: 0648b933e0ca0d7849ca01048a805d7e2aa1e7d1

Best regards,
-- 
Tom


