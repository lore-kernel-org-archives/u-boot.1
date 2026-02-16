Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E89EE83827
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 19:40:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5270980325;
	Mon, 16 Feb 2026 20:39:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AwZQqt3/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BA6883D07; Mon, 16 Feb 2026 20:39:12 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4E0D83C6C
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 20:39:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7d4c85307b2so1691912a34.0
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 11:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771270744; x=1771875544; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=frP5vgquSfW0adneZOw7oGXtB3OSulpnAckxVjhMqRA=;
 b=AwZQqt3/spJeqZCggEiWdxzu3p4xFIDBV+rTyE/gxhTRo+qy5TeDguPl99PXmIgI+m
 lx/gf67wayiORTGulrFbTWmblOlgip2qT8XH6znv/5tXVnkBrZwaOFk5oEkiW19VjTUW
 TmoEMib9Tt45meX85ZGT0IfPL7L+GFeYNRkq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771270744; x=1771875544;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=frP5vgquSfW0adneZOw7oGXtB3OSulpnAckxVjhMqRA=;
 b=eQ4SKQdqGBgEBCKvhQDGR6PCDjusCozQs4zTJvaGPi+RYz0vRNErbyNQ1C/2NxS4V+
 o1W4Bv/09pfUggkFZB+RE4mXz14eX9+u8qb0y2MAqTcp12VM7ZOeP0iStV8/6X1sSVgk
 ZYLqd+Z0dqr2eZggOkQ8OODyx5NV+y/i2DpHJhz73ELcIsMHfDl0+SKmss0S2GkB9gUA
 4a9BAJGY6Z+C4KxC5RvKfTxVj27lKAGV+mhI/LswWpvK4okRVNiMV+PpNz9/wLalEcmF
 nieTzu1WB0IRM7nz0PbLLKd4kJQVxEgNUyU9bWagW+i5FyO2tgXX6h40BcPTisc23ofW
 ux1Q==
X-Gm-Message-State: AOJu0YyDa1PpL1A5gvdJnenDmylHNuHvxF6Wv7X9q9r034U2NSblyOxx
 36KfI9xbotWrI67giMK+JRLxo1XxEK2L5t4G6Pyw+Mj1B5OKR7eJshVypZI34UNiMik=
X-Gm-Gg: AZuq6aKcvBH6P8hUmN3H6+0ENzce/DD1Mk+coBzN98TrPcsQ/+iDzevwWTMErg1P7zH
 D0mB6kundqZxe2DVsZCzzii8rMIOUZY/NEpLNIWY48+x1mNkHV0i6cysbdp7bnv4/OeGGubMMc7
 8OXIGLmiPnhEEiTYwFUcknngP9muIOfNut30l/+iWn4qD2Ht5YcdR9jKKYnwkbgDfMiyhyLs08K
 trlD4tgl8lj8yvCXBcdjU0WgS3vdWUZ4303eVaL6TW5yxGUZCw1tcl3jCSZV/Cp5ZfmqrDgUwyJ
 hflVyxHEms/LqZLsFF6Xi1qdQg8XMT3IY/nCQa/r1QyZnMTP0fAl7fXl7+/RTLx+O7b7l9pakDl
 fWVzXMlFJUGj/2PTsyJCsgNL0eNYOn/g2/mYbOF4vDi0zfWk6KWPkRrCb7A2BNi/NixlXPIgVBc
 Lwl72ij0p+i0OlpsNsvf5fsVpy7zj1VqIC9j8pQRXKxOL7UDzgZgwML2WIGtHekg0d5UWfg2cmu
 9HM2dCYffdDb7QZTcGRiNxW8e6YPD0NYzU+Kidu8IwbIsb6/Q==
X-Received: by 2002:a05:6830:7086:20b0:7cf:d1b7:c319 with SMTP id
 46e09a7af769-7d4ebb862b1mr1248864a34.2.1771270744500; 
 Mon, 16 Feb 2026 11:39:04 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4a76f9483sm14142543a34.20.2026.02.16.11.39.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 11:39:04 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Jeremy Compostella <jeremy.compostella@intel.com>
Cc: Simon Glass <sjg@chromium.org>
In-Reply-To: <87qzr1z0tf.fsf@jcompost-mobl.amr.corp.intel.com>
References: <87qzr1z0tf.fsf@jcompost-mobl.amr.corp.intel.com>
Subject: Re: [PATCH] x86/coreboot: Exclude memory regions starting above
 4GB
Message-Id: <177127074392.2634449.16645339876724577955.b4-ty@konsulko.com>
Date: Mon, 16 Feb 2026 13:39:03 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Tue, 03 Feb 2026 19:42:36 -0700, Jeremy Compostella wrote:

> This commit updates the RAM region filtering logic in
> board_get_usable_ram_top() to skip any memory regions whose start address
> is above 4GB. Previously, only the end address was capped at 4GB, but
> regions entirely above this threshold were still considered.
> 
> Typically, the following memory map entries would cause
> board_get_usable_ram_top() to return 0x100000000, which is incorrect.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] x86/coreboot: Exclude memory regions starting above 4GB
      commit: 8666b16015d4212facacc514e2eb626f3630dcf0
-- 
Tom


