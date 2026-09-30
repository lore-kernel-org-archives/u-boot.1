Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C757BCA5FB1
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 12:52:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 26E2660B4E;
	Wed, 30 Sep 2026 12:52:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eSQI7PBba5o1; Wed, 30 Sep 2026 12:52:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1E0C460B4B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790772741;
	b=ZeqGt9N6cUdTAPqAbEvF5D+h6KifejwQEi/AoHvVgu8cA4DxGEWkfCZVp06o68y2XbVX
	 m2yQI68dqpFVvf+GMOhf+e8m+WJR8NT4nd3yNdS0H8mYQbohLVoMKzXoC2z+cXMjO+R95
	 njWcqaMVkmGbZlKxLVGwbPOjMgyn4i/uWA7uIi3G1/BZePiVCpGAaQJEedVxsq2F9Qx0g
	 gfrKIqVclICf9TCCisK3NMgTSfdMY66lruiPtEic0Lg+zUwS5d4Mrrgdzd7g0+VKdPyPc
	 5fRad6SigBWT/M9+tF9aWxVYDX8QMNKqITqqz4pwWUn5/Aa9rDBBzIq/bf2B+eO9yLw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790772741;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Spc91dunMh7x3LyXOxDiEh9DBlR3h3PP+Ot3f6atoik=;
	b=jrrAVnoSQs20qiK1EGWU8ivwSZyTMOM3xWdgKYP45HkkhxcpRr0ayxRUAwFnb6r0/2F1
	 hgX7idxFQixYXJFiVydxCDJAH+L4Q81OlGfj0ipbHNCIHcKMO57fidhGn2TcqfH5dt/6v
	 jOnNpD4GUX3RqFGQOrhh+ZiEmeCmMcqFDyMJzdX6NNP12W9ruG8Lm5wHOR7kIQDhQHhBk
	 EdoKnKWR/EeczfhT6XAgx9sfEYDQ86axRt+y5WauJHrWvNnT0egtUhKckFyTSI1BDqdFJ
	 dPFhqsC2R3txZH6wjdhLYaz7I3yrKbv2GLxcJ494Gm8zSZa8axU3++oijH9FX1JxDGA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=US1uPrBx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790772741;
	bh=Spc91dunMh7x3LyXOxDiEh9DBlR3h3PP+Ot3f6atoik=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IMtvoVp+5FuuQVmGxhcVVLhtXQ77dZb4psyUsIh7KhazfTGC4Qm7XbLqHV7216hUK
	 LONejPJMHsx+1g4Tc2RKhoTl3o9cen4H7DN0UM0+CiUQrAwrAuEVsEh86XUOHKwEaO
	 1r3jCw+LmSWUQz5iaQKS2eJGDc8pn1kI5G7tmZn9yMDxyLC34WYAoQeTBVprJcU0FW
	 b++gVNqNZhzf6HNkf5k68Y/X5RaV3R06y3vnviWPKzybkh7I1Nb0o6yzXaYWw7BPSq
	 ksAKw+lF/FnI8FyWqLkCo9d5oe7XUAWYJ8Yu3zF+lcePE4ly4dYxKLjIxfQsPwRZG0
	 amDSuLL0K0w7Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1E0C460B4B;
	Wed, 30 Sep 2026 12:52:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E427724E
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 12:52:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D1CE560B22
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 12:52:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a9FOn9NhHzfQ for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 12:52:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3B269608A8
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790772734;
 b=TOgP1wVCZNKMFF28vRnnlHEzBsFdu0mbAw/8Twdal6QaXWGnp/+c9fBGJ8ttZoM3rJuA
 AtC4ZLBiIXN3FxOrA0V0MGhWburD/dRThCWDyTj9ydzbxPQIPOdXPxJlBRsgtBpxx7hGF
 QPiaul6DGbe7SZ+PC1ZJZjZSlKs15v2pVaBSq5VNhruoejpHm/LvcSYdDpM/bLv1I5Aps
 HqpaRG4bdboGPS6rU07pnANT948rkHLzfib83sK7whAlYyRhyiisvHnz0Otd3FcHAQ4Ng
 0g8ur3ZPIu6APyJTKEBmm3bYB0l5V4WFv/+TzwA9Q8jm241UknIG23Gwst0m/Q92sZA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790772734;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=Spc91dunMh7x3LyXOxDiEh9DBlR3h3PP+Ot3f6atoik=;
 b=EI+zDaH9AV48U6tUOvggeXVhtkEXcT9Z+F9axoOWVZ53akg6z0+UfWpjdhCzAh3gM6Fk
 UA+sbNVM77o/7+kt1SUNh1payfmPE6IX3KMvsSQyBAbVBOGMGtQs4D56Hs9UV5KiIlswV
 mYKOBlOaoPzsOU5OMu6s8toPjpCOqNGVJlp05XHq6uNmOBv5znq46DPIW7p+kBhVz76TX
 sZExMHks0TpEWJY1c6Z9Aerld3XaipbUaLHHHTU8k1hdvuPF5YMjN6O//e6i7QIOMvuPq
 6zC0Sr2phOViMjUhZ9hdfhHlKSxFeg7mUUg+7F93P5E74UI4FR7x21rRC32A/m8/riQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=US1uPrBx; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=US1uPrBx
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3B269608A8
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 12:52:13 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e79a408deso33269945e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 05:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790772732; x=1791377532;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Spc91dunMh7x3LyXOxDiEh9DBlR3h3PP+Ot3f6atoik=;
 b=US1uPrBxhKrwHX0+zOHAD0j6UJFAnMBeS0pTSkD7h+/mRI4uaHBU2VVgbw5G84waIi
 ZpFGv2k09q710PyW13+p/fGNFlHDZQTQci5jIZb5p6XBpFvfmYeA6MSqipCaj03dFELN
 ea9SsNJfY4jurqUKvkobenwUyB43+3TS9bKzTXaAzc7+hldjZ8facx4ZtMl/6TeOmC9a
 St7JQaLVM8qinedg76eAL5hXDTc+09e+Ahy75W5Dvslgwx0rgKp1oYXDImctvOxk89v1
 b7j+FF1C/7qhKcfKqtmLs+elC0/1Q0uZW5LTeoVVHycdNHMFCuXv9g78pzQPFqH09xyu
 Y2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790772732; x=1791377532;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Spc91dunMh7x3LyXOxDiEh9DBlR3h3PP+Ot3f6atoik=;
 b=UBhmDQ/1NB6UkR9DqGaWXioAnyb+FLpg5gR32hp+wwZUWYSUKk7PdAmilNwme3b0Ni
 MU+ueFpgcZdZi7edD5tJfmsP+enJbA/7PI0fsWTI8DWkF/kT+eJIjx7UeV6nEiEXJpGk
 jn9gPgLs7/hxNS5WfyP4YwEYs9BqnvV2GksdBCmQA8mklkhP724WiMTPWpR8r7sv00vo
 yhpKNTMIvjUw0kdRzObLX1I0pyBGhvigIdO4OsvUgZACsQUySRtayAka3vygSqeoOoxU
 ez3yf9Vnl26PB7LJ72F0lYdqnrujG57yz2jmdVWpsjh3SlCOU+CJgG2Dj+gKCEnqYbTM
 CZ4g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzQ/Z2CMtqukrlNWIveUXYSCDnZ6FTdNU9CXJbXApKwKZ9Gb+SLO4RpPXkHOylmgk8KBEOb1qc=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mEkuJ+SSSpRZ1QUILKCY10ZXn12x1i1jsV3A0kWyFiA1c22rSK
 Rr328k1L0fjL6FuLPHpWMbVw62kIJXz9PhFv9OnDNdeSVQCGLJAwiMCwcnz0l5DQL8STE9AY/mK
 x76tIXAM=
X-Gm-Gg: AYBFou2YKQqKzVNAQddR+M9t+RAbNXJodT5PbWJN69Gt5/2FvQUKJPJZs/6oOSy11ko
 YmWtGlKBfaotwxjf/KYxIwwuLhLTkZKBr6qr1Gzi+8BPP4I8ZcgTahLhABf9cVpKM8QVMPxoY0U
 JZz5WtxytwhkF/SxAtnsvbJzCt6yxdxFb6UhbVjcUTEygXPvTq7TAxVxB1U163C8P/fee22g7lM
 lAuEs9MHh+FaVOgjlehNbXfFaru5yxbeMcIX6fqwhYZPD4UVVYzcy/TUBaJKx1dtDL34J1hQRlr
 ZOiFfQzEgw0UjkJQbtwjtW2fEUuRJNTz1jM50u2g/tZcdgWb0jRCzJNz0Rm3uYjm9ssl7ykUEaM
 TPMYZd7iaSlBCBmM0s1y7WOst+b3qzKcX0UCUGc34mizuyx3TbBycVYeGvZDnBy2JfpIIAyR+QH
 Dcmz5w6uqixrlxHdDvV8EaYaysJupf6PUkOSG6cT7mNYMbwuvJKU8YoXOcEOxVaCPiA1LINnXmr
 etrJOt3bdoyzmHQjz2JMmqa+jabeR3tpTOrw+sLtgllyha+L+Hk2/SLVePkLm6mWPRIVv4sf2Ff
 Eldkfx0nXJ3VCg==
X-Received: by 2002:a05:600c:45d3:b0:4a0:e45:e8d6 with SMTP id
 5b1f17b1804b1-4a01aff0bb5mr18996935e9.13.1790772731087; 
 Wed, 30 Sep 2026 05:52:11 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-79-45-166-197.retail.telecomitalia.it. [79.45.166.197])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01ca32a44sm9928905e9.0.2026.09.30.05.52.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 05:52:10 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Wed, 30 Sep 2026 14:51:35 +0200
Subject: [PATCH v3 3/4] arm: mediatek: enable U-Boot fastboot DAs on Genio
 510 and 700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-ccaione-upstream-mt8390-da-v3-3-ae6091c7eda0@baylibre.com>
References: <20260930-ccaione-upstream-mt8390-da-v3-0-ae6091c7eda0@baylibre.com>
In-Reply-To: <20260930-ccaione-upstream-mt8390-da-v3-0-ae6091c7eda0@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Carlo Caione <ccaione@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Julien Masson <jmasson@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Alexey Charkov <alchark@gmail.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Prefer fastboot in U-Boot proper when the complete download agent fits
the BootROM SRAM limit. Its shell and boot commands support provisioning
and recovery beyond the SPL agent's flashing operations, without relying
on the installed firmware.

This variant requires BL31 and an external DDR loader.

Use the same eMMC boot preparation as the SPL agent so provisioning a
blank device does not depend on the chosen agent. Keep 16 MiB of heap for
sparse writes; the download buffer is reserved separately in DRAM.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi    |  2 +
 arch/arm/dts/mt8370-genio-da-u-boot.dtsi         |  3 ++
 arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi    |  2 +
 arch/arm/dts/mtk-genio-da-fit-binman-u-boot.dtsi | 62 ++++++++++++++++++++++++
 arch/arm/mach-mediatek/Kconfig                   | 31 ++++++++++++
 arch/arm/mach-mediatek/Makefile                  |  2 +
 arch/arm/mach-mediatek/download_agent.c          | 14 ++++++
 arch/arm/mach-mediatek/spl.c                     |  3 ++
 configs/mt8370-genio-da-uboot-fastboot.config    | 29 +++++++++++
 configs/mt8370_genio_510_evk_da_uboot_defconfig  |  2 +
 configs/mt8390_genio_700_evk_da_uboot_defconfig  |  2 +
 11 files changed, 152 insertions(+)

diff --git a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
index 2ee7fb1f40c..f81ae1c82e2 100644
--- a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
@@ -16,5 +16,7 @@
 #endif
 
 #ifdef CONFIG_MTK_BROM_DOWNLOAD_AGENT
+#define MTK_DA_DESCRIPTION "MediaTek Genio 510 download agent"
+#define MTK_DA_FIT_DESCRIPTION "MediaTek Genio 510 DA bootloaders"
 #include "mt8370-genio-da-u-boot.dtsi"
 #endif
diff --git a/arch/arm/dts/mt8370-genio-da-u-boot.dtsi b/arch/arm/dts/mt8370-genio-da-u-boot.dtsi
index 9d0d057cfc9..4ca46bbe2e2 100644
--- a/arch/arm/dts/mt8370-genio-da-u-boot.dtsi
+++ b/arch/arm/dts/mt8370-genio-da-u-boot.dtsi
@@ -12,6 +12,9 @@
 
 #include "mtk-genio-binman-u-boot.dtsi"
 #include "mtk-genio-da-binman-u-boot.dtsi"
+#ifdef CONFIG_MTK_BROM_DOWNLOAD_AGENT_UBOOT_FASTBOOT
+#include "mtk-genio-da-fit-binman-u-boot.dtsi"
+#endif
 
 &ssusb0 {
 	dr_mode = "peripheral";
diff --git a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
index 4fedbda9b3f..395241173a0 100644
--- a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
@@ -16,5 +16,7 @@
 #endif
 
 #ifdef CONFIG_MTK_BROM_DOWNLOAD_AGENT
+#define MTK_DA_DESCRIPTION "MediaTek Genio 700 download agent"
+#define MTK_DA_FIT_DESCRIPTION "MediaTek Genio 700 DA bootloaders"
 #include "mt8370-genio-da-u-boot.dtsi"
 #endif
diff --git a/arch/arm/dts/mtk-genio-da-fit-binman-u-boot.dtsi b/arch/arm/dts/mtk-genio-da-fit-binman-u-boot.dtsi
new file mode 100644
index 00000000000..a605ad2504a
--- /dev/null
+++ b/arch/arm/dts/mtk-genio-da-fit-binman-u-boot.dtsi
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
+/*
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Carlo Caione <ccaione@baylibre.com>
+ */
+
+&da {
+	fit {
+		description = MTK_DA_FIT_DESCRIPTION;
+		offset = <CONFIG_MTK_GENIO_DA_FIT_OFFSET>;
+		size = <CONFIG_MTK_GENIO_DA_FIT_MAX_SIZE>;
+		#address-cells = <1>;
+
+		images {
+			uboot {
+				description = "U-Boot fastboot download agent";
+				type = "firmware";
+				os = "u-boot";
+				arch = "arm64";
+				compression = "gzip";
+				compress = "gzip";
+				load = <CONFIG_TEXT_BASE>;
+				entry = <CONFIG_TEXT_BASE>;
+
+				u-boot {
+				};
+
+				hash {
+					algo = "sha256";
+				};
+			};
+
+			atf {
+				description = "ARM Trusted Firmware BL31";
+				type = "firmware";
+				os = "arm-trusted-firmware";
+				arch = "arm64";
+				compression = "gzip";
+				compress = "gzip";
+				load = <CONFIG_MTK_GENIO_BL31_LOAD_ADDR>;
+				entry = <CONFIG_MTK_GENIO_BL31_LOAD_ADDR>;
+
+				atf-bl31 {
+				};
+
+				hash {
+					algo = "sha256";
+				};
+			};
+		};
+
+		configurations {
+			default = "conf";
+
+			conf {
+				description = MTK_DA_DESCRIPTION;
+				firmware = "atf";
+				loadables = "uboot";
+			};
+		};
+	};
+};
diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index eece6456e43..4febd700bff 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -275,8 +275,39 @@ config MTK_BROM_DOWNLOAD_AGENT_SPL_FASTBOOT
 	  downloads it into RAM. The download agent also configures the eMMC
 	  boot partition so that a newly flashed board can boot normally.
 
+config MTK_BROM_DOWNLOAD_AGENT_UBOOT_FASTBOOT
+	bool "Run download-agent fastboot from U-Boot"
+	depends on SPL_RAM_DEVICE
+	depends on USB_FUNCTION_FASTBOOT
+	depends on FASTBOOT_FLASH_MMC
+	select BOARD_LATE_INIT
+	select MTK_BROM_DOWNLOAD_AGENT
+	help
+	  Build a small SPL which loads BL31 and U-Boot from a FIT already
+	  copied to DRAM by the external DDR loader. U-Boot proper then
+	  prepares the eMMC boot settings and provides USB fastboot.
+
 endchoice
 
+if MTK_BROM_DOWNLOAD_AGENT_UBOOT_FASTBOOT
+
+config MTK_GENIO_DA_FIT_OFFSET
+	hex "Download-agent FIT offset"
+	default 0x70000 if TARGET_MT8188
+	help
+	  Offset of the directly parseable FIT in the BootROM-loaded download
+	  agent. This must match the external loader's DA_FIT_OFFSET value.
+
+config MTK_GENIO_DA_FIT_MAX_SIZE
+	hex "Maximum download-agent FIT size"
+	default 0x8f000 if TARGET_MT8188
+	help
+	  Fixed region reserved for the download-agent FIT and the maximum FIT
+	  size accepted by this image layout. This must match the external
+	  loader's DA_FIT_SIZE value while the loader copies the complete region.
+
+endif
+
 config MTK_TZ_MOVABLE
 	select ARCH_MISC_INIT
 	select OF_SYSTEM_SETUP
diff --git a/arch/arm/mach-mediatek/Makefile b/arch/arm/mach-mediatek/Makefile
index 0f0bd8fda01..d784af8bc05 100644
--- a/arch/arm/mach-mediatek/Makefile
+++ b/arch/arm/mach-mediatek/Makefile
@@ -6,6 +6,8 @@ obj-$(CONFIG_MTK_TZ_MOVABLE)	+= tzcfg.o
 obj-$(CONFIG_XPL_BUILD)	+= spl.o
 ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_MTK_BROM_DOWNLOAD_AGENT_SPL_FASTBOOT)	+= download_agent.o
+else
+obj-$(CONFIG_MTK_BROM_DOWNLOAD_AGENT_UBOOT_FASTBOOT)	+= download_agent.o
 endif
 
 obj-$(CONFIG_TARGET_MT7622) += mt7622/
diff --git a/arch/arm/mach-mediatek/download_agent.c b/arch/arm/mach-mediatek/download_agent.c
index e73b6a6b161..d0269b7a574 100644
--- a/arch/arm/mach-mediatek/download_agent.c
+++ b/arch/arm/mach-mediatek/download_agent.c
@@ -54,6 +54,7 @@ static int mtk_mmc_boot_prepare(void)
 	return 0;
 }
 
+#ifdef CONFIG_XPL_BUILD
 void spl_board_init(void)
 {
 	int ret;
@@ -67,3 +68,16 @@ void spl_board_init(void)
 	if (ret)
 		printf("Fastboot failed: %d\n", ret);
 }
+#else
+int board_late_init(void)
+{
+	int ret;
+
+	ret = mtk_mmc_boot_prepare();
+	if (ret)
+		printf("MMC boot preparation failed: %d\n", ret);
+
+	/* Keep fastboot available even if storage preparation failed. */
+	return 0;
+}
+#endif
diff --git a/arch/arm/mach-mediatek/spl.c b/arch/arm/mach-mediatek/spl.c
index 125ebcd784f..120a94c6598 100644
--- a/arch/arm/mach-mediatek/spl.c
+++ b/arch/arm/mach-mediatek/spl.c
@@ -33,6 +33,9 @@ void board_init_f(ulong dummy)
 
 u32 spl_boot_device(void)
 {
+	if (IS_ENABLED(CONFIG_MTK_BROM_DOWNLOAD_AGENT_UBOOT_FASTBOOT))
+		return BOOT_DEVICE_RAM;
+
 	if (CONFIG_IS_ENABLED(SPI))
 		return BOOT_DEVICE_SPI;
 	if (CONFIG_IS_ENABLED(MMC))
diff --git a/configs/mt8370-genio-da-uboot-fastboot.config b/configs/mt8370-genio-da-uboot-fastboot.config
new file mode 100644
index 00000000000..e22ec881a97
--- /dev/null
+++ b/configs/mt8370-genio-da-uboot-fastboot.config
@@ -0,0 +1,29 @@
+#include <configs/mt8370-genio-da.config>
+
+CONFIG_MTK_BROM_DOWNLOAD_AGENT_UBOOT_FASTBOOT=y
+# Sparse writes need an 8 MiB DMA buffer in addition to the fastboot state.
+CONFIG_SYS_MALLOC_LEN=0x1000000
+CONFIG_CMD_FASTBOOT=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_FLASH_MMC=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_FASTBOOT_MMC_BOOT_SUPPORT=y
+CONFIG_FASTBOOT_MMC_USER_SUPPORT=y
+CONFIG_SPL_RAM_DEVICE=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x41000000
+CONFIG_SPL_MAX_SIZE=0x25000
+CONFIG_SPL_CRC32=y
+CONFIG_SPL_GZIP=y
+# CONFIG_SPL_MMC is not set
+# CONFIG_SPL_LIBDISK_SUPPORT is not set
+# CONFIG_SPL_EFI_PARTITION is not set
+# CONFIG_SPL_SYS_MMCSD_RAW_MODE is not set
+CONFIG_BOOTDELAY=0
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="fastboot usb 0"
+CONFIG_ENV_IS_NOWHERE=y
+# CONFIG_ENV_IS_IN_MMC is not set
+# CONFIG_BOOTSTD_FULL is not set
+# CONFIG_CMD_BOOTFLOW is not set
+# CONFIG_EFI_LOADER is not set
diff --git a/configs/mt8370_genio_510_evk_da_uboot_defconfig b/configs/mt8370_genio_510_evk_da_uboot_defconfig
new file mode 100644
index 00000000000..c696e89c892
--- /dev/null
+++ b/configs/mt8370_genio_510_evk_da_uboot_defconfig
@@ -0,0 +1,2 @@
+#include <configs/mt8370_genio_510_evk_defconfig>
+#include <configs/mt8370-genio-da-uboot-fastboot.config>
diff --git a/configs/mt8390_genio_700_evk_da_uboot_defconfig b/configs/mt8390_genio_700_evk_da_uboot_defconfig
new file mode 100644
index 00000000000..102f61a3afc
--- /dev/null
+++ b/configs/mt8390_genio_700_evk_da_uboot_defconfig
@@ -0,0 +1,2 @@
+#include <configs/mt8390_genio_700_evk_defconfig>
+#include <configs/mt8370-genio-da-uboot-fastboot.config>

-- 
2.56.0

