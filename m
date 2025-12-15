Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0301BD5B84D
	for <u-boot@archiver.kernel.org>; Mon, 15 Dec 2025 17:20:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA5E3836CE;
	Mon, 15 Dec 2025 18:19:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AVYrKPcX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD62F830A0; Mon, 15 Dec 2025 18:19:55 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DCCF807B1
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 18:19:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7c77fc7c11bso3771227a34.1
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 09:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765819192; x=1766423992; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kIyfs1wmqT9VcVQG6yESPWQx1Pb2eKIxwBjKfPjjGko=;
 b=AVYrKPcXXBkTsKvDvjE2tHXYUnrJ8Ea7w674X4aiF9EA/68d5wMfZYwECIpLRIXb6h
 SuFYBYTTKkFaqeyIG9bkXIyDKE7Zl7FcxZpvmUaFO+dNAAQiZse1jXc1DvIZlpaKXLZw
 fFVAqC+t/PS/aCIXfuGosZ2HQgP12EKaACrfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765819192; x=1766423992;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kIyfs1wmqT9VcVQG6yESPWQx1Pb2eKIxwBjKfPjjGko=;
 b=DIFCeupkwuwpXko1YbOSRQoxTUztobhX5b8qiL8MRSrzTZsC/XATbv4JUHLVLKe3O7
 h9fBnNJ08CFJBWs6GAqPpPDXp/ahLUErtSvD9ZffujOvk/8O0cIlV91E1J16AXpfOsP3
 vEbLofcfFBJtnGzvI4gLZ3+RHUFmiNL4ZD87vHuM669jSepmaYq3i8VBpQq+rAneG6sw
 gkfYtHbF00yZu5U3j0Qf6W2f88ubiTaqnDnC2Z7rOJMCmu16jYQzojjfYhSQzYlOr0Qm
 GMkHbkTBpR9DbjfmUry3ilEFRDMS4BSv+MY/G15yigo4bs1Ts7sSVuf1rQsjyeZv7rYn
 6Q1Q==
X-Gm-Message-State: AOJu0YzDyKz45h98ge2q8y55jfoSZI+Nn7vr2ZhtC6gYovrpZY1dmstX
 ZGrkdppli/AB390J8itfsf5Lga/iseB2pN8iHlOV/+GGHcbFFhi3ooUaCO58TTilh20=
X-Gm-Gg: AY/fxX6tIK2oiDn+JxTJA3g4rFHQ/NlbU1LEYZmtyYFyofQjjOVSXbi4xUMNMQxLZ8z
 bulhoqgSFVp+oSmiQZjcqB1KOjUVgoFwjsIfc3ISjNTRVBnMPiCdNyFonJyJOns8ykpI7ed8pBS
 YawBHTJ/kvQZlJo0nQ6TBonV6Znh07bVGKxLAmoVNqayfvvuVi7sDIpt/gdbQnkxs9GY3iqE7li
 ZLqlrFSbU37/HlvhZYKfV5BBsOXcsubfM7NwaN55oUyBYee78PVfYwCBk94Xki4arpP2FyhzKkw
 EMC80h1nGwc04Zr5jv83si/WFw2xXONNmZzMKzTcezndobf9XNkqAg5E+WyG1U3yCE7q28nCf5T
 WVLYwddyKW0VqRjPVs5H9CtlPlyXiMrmFHh0J5LDRETaRhQhAQ9FFiq2iQNyYY19l+jVnoZBX3N
 dA4mYwYNWaWkX3jPz89fbPnpub8Ews7YTM8OrhI6EM53IENAhw
X-Google-Smtp-Source: AGHT+IE8sdZjy7D7sVS+vgK27/PZGLjEC7/i62+25lSQLgBDzney56qS3+WfwpicdhB72YeN+lcbbQ==
X-Received: by 2002:a05:6830:82f1:b0:7c7:48b7:640a with SMTP id
 46e09a7af769-7cadcb9f620mr8824079a34.7.1765819192280; 
 Mon, 15 Dec 2025 09:19:52 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cadb345977sm9710691a34.29.2025.12.15.09.19.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 09:19:51 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251128-topic-am33-clk-regmap-dep-v2026-01-v2-0-451b4f4e7e85@baylibre.com>
References: <20251128-topic-am33-clk-regmap-dep-v2026-01-v2-0-451b4f4e7e85@baylibre.com>
Subject: Re: [PATCH v2 0/2] clk: ti: Cleanup common functions and omap-cm
Message-Id: <176581919153.1844985.13797463833905270401.b4-ty@konsulko.com>
Date: Mon, 15 Dec 2025 11:19:51 -0600
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

On Fri, 28 Nov 2025 21:22:17 +0100, Markus Schneider-Pargmann (TI.com) wrote:

> this series cleans up the direct dependency of ARCH_OMAP2PLUS to compile
> ti/clk.c which holds common functions for other clock drivers. It
> creates its own config symbols for these common functions and for the
> omap-cm driver as well.
> 
> The omap-cm driver config symbol is added as default enabled.
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] clk: ti: Split common omap2plus functions into new symbol
      commit: 6f2d0090f9842c5ff2e5f4344fe6cb1f5f515595
[2/2] clk: ti: omap4-cm: Add Kconfig symbol
      commit: f75f8397e813c3aacb147e5177ab969071d759b2
-- 
Tom


