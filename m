Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2579CD98F2
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 17:55:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF544849EE;
	Tue, 23 Jun 2026 19:55:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CirdAfIA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FEEF847C8; Tue, 23 Jun 2026 19:55:23 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0661E849E5
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 19:55:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-6a11ee16af6so79569eaf.3
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 10:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782237320; x=1782842120; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H101tL63aPUicCasnOErpZlgYHiss98zGu94qXsPaTs=;
 b=CirdAfIAnhYe/O71xfWJKQe53NSVIHanfdEw3VECB4YkwFsKVoU5I30YFG4Ckd1U7Y
 W4LXUg9aDeyFJuZvXPjRoqZNDVvwHTfG6hg7Wake8dOKUK2cJC5Q7IjQ7TMUiWe9GSso
 qn4N6qCl3qp2gSbHPxLV+0YrUJh7TiY9t0+EY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782237320; x=1782842120;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H101tL63aPUicCasnOErpZlgYHiss98zGu94qXsPaTs=;
 b=tNAvzHBcAnbqHFvA+HXcT7Sh2+2wVKv6qSxb+m8JULpu3KpDgX3chK+WMqaBE56loe
 4YqAJ0Iu3w5TVUK3jcEeU2F88R9exTqEW0ukW2zDmRUrqHdzAhvrEGGd6TcA2f2Ltva1
 8OLmuwlr3wSyqHBE84+tVe2HRsxOlZndq4VP71as/z+M/t0P/MDK+AHPTEK5WNLLB5I7
 CKMG92hKGixvBgSn+WNPp5C5dkMWB1TphbzcbegIkK/MYQSWrlVjTQRr49cTNLF8mIlO
 60ljCfmW5w+YrnUoDIeumYtyhksXIlAi2UzXej9v7LEQ8ikT3W+FVGULoqo7jwaaLY4K
 jw5Q==
X-Gm-Message-State: AOJu0YxEbY9yLDwo2KFcgpMvvP1oli+tdmOtQw+rZlHQD71ud50L6B0R
 PEt+W7rGyt34Wh4UuvyFIwO8CThgMyJJVYOtW74HAqMMUfI7N1XufvcKWYdSzk6wlCI=
X-Gm-Gg: AfdE7cnXl7Fpr06D7HoQF0cOd8cwO+os2DRuCenMyhyVSW0gxSanCxyNXQ9lXVqbdf0
 5CQmuF9yWSn9IXmUgMdgpz5F50PB+zw11WU5ZG8dXKfgnUueMNfxCcbBijyKA7b6cTXI7GkaKA8
 a9410eptxVGjVAODxe5dfPoOMU71+qqv7Xmdsl9bpVwUx0PruiFAtHR/4qLyDG3pm/S4I6KH7pv
 u7v/yUoGGdf9vxHXEd90yStQwdyUcXBmaR5pwOFuTzrlkF5XLkEKlYP05Hj+OFJ6fJ+jcuoF6ch
 MUekN2yPzz6SJ3tFumK5xLTCFQV7pICM1aRrESojeRz4Sz3WH/TpQ1uhZb4IawQVDQPfuBhPsA4
 HKIO8h95h2YkElg5rIablc+IgXNXfHCrIWTjnz+LD5KoZYq60i3/EAMQFtbUZc8G2aYu/qVgWsg
 6m1WgKLhKzADpU5kWrs9H15dfvnHbv37i1wG42O6vG+AYJ/Zm+VJlNMinQC0yIXSGDwM+XuVH2H
 kv5+j/lgQQH+0lAGir0kkh6v6iXgbfHfw==
X-Received: by 2002:a05:6820:4c12:b0:6a0:c3ed:be5a with SMTP id
 006d021491bc7-6a114c1d4b9mr2530377eaf.33.1782237319740; 
 Tue, 23 Jun 2026 10:55:19 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-245.totalplay.net. [187.191.8.245])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a0ea0f9dc3sm7709245eaf.12.2026.06.23.10.55.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 10:55:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Quentin Strydom <qstrydom0@gmail.com>
Cc: ilias.apalodimas@linaro.org, sjg@chromium.org, 
 james.hilliard1@gmail.com, malysagreg@gmail.com, tien.fong.chee@altera.com, 
 sughosh.ganu@arm.com, philip.molloy@analog.com
In-Reply-To: <20260620150724.126315-1-qstrydom0@gmail.com>
References: <20260619200419.GW382693@bill-the-cat>
 <20260620150724.126315-1-qstrydom0@gmail.com>
Subject: Re: [PATCH v2] arm: aspeed: Fix AST2600 SPL external DTB alignment
Message-Id: <178223731881.3376589.1967036936626947932.b4-ty@konsulko.com>
Date: Tue, 23 Jun 2026 11:55:18 -0600
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

On Sat, 20 Jun 2026 16:07:24 +0100, Quentin Strydom wrote:

> For AST2600 SPL with CONFIG_SPL_SEPARATE_BSS=y and
> CONFIG_OF_SEPARATE=y, fdt_find_separate() expects the appended control
> DTB at _image_binary_end.
> 
> The AST2600 SPL linker script aligned _image_binary_end via the
> .binman_sym_table section. In builds where that section has no emitted
> contents, objcopy -O binary does not include the alignment bytes in
> spl/u-boot-spl-nodtb.bin. This causes the nodtb binary to end before
> _image_binary_end, so the appended DTB is placed too early.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] arm: aspeed: Fix AST2600 SPL external DTB alignment
      commit: fcda974e36033ad5331a9b4a4a551af4e141ad7d
-- 
Tom


