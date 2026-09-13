Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19953C88E56
	for <u-boot@archiver.kernel.org>; Sun, 13 Sep 2026 07:29:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CFC0840699;
	Sun, 13 Sep 2026 07:29:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f7mtMh6mwnab; Sun, 13 Sep 2026 07:29:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org EA35F4069F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789284550;
	b=kmBYrK4p2qxUKBDZGRh+3CwyDRF7/AauADgVLIpc1yN0kMgEWc72L1w0rUgSxbW00Ev6
	 VfoAjGYvlyL86EaNai4yj56zTQ7669chokIz6KZqvzfj3Lz4/zMNC4h8Tr9BlkkkqnwHq
	 gkugWXtnS/e+WD3IhKoWG0PIhQ1A6l3E2FdQklKQHM1y6SJKdVARgnJOK19vRHAGLJ5cQ
	 odcbDTdSL0+DXeVMuqFHCGRtr3KQO0QXdFqo5qg2iLEDeFHJX9rJ04NqFzDlqSiKXeEY+
	 FyuLeVey5OLAMkIabGHd8VcnRmsqrJSNV7Qmv5bJ6sFEJRIGU8Xn4v2m4BOhjyjRzng==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789284550;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=avvaW1LrbYyD+QlETHjYRU2+J2UAcot1Vkb6VIryOVY=;
	b=YMmK/dsvLhqF0az7PH0EvM+F4ANDdtRBIDLmf7KtjQ97q3hnch4iAW4cqkX6J+jEjZLc
	 aPvYxhpkt8q228FlqNOnpIKh1PexNOI8OndyXbTOEuaLEhxmCpdpjsxArvMriUNBCzEwo
	 cgrv/VbaoweNwavTytPZxfaoIt4o4N+fHmQliTog4UWP+rsbNROXs4ce+Iu8wKAfW6cvb
	 V/0g0yMEWAq2VhCnzAaJ34Vi0Bn5uHq2jDYtU2M0d31P4GXoNCchWZIUPoP59EqXeIWlP
	 Ntt+9RIBehG3mBlu3xhLZ0mq9gu3mwCnQU+HyS3LagcrFBtjd5786Cos28zwieV+ArQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Hx7pMHpe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789284550;
	bh=avvaW1LrbYyD+QlETHjYRU2+J2UAcot1Vkb6VIryOVY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XpbddzynkLCh9cmv2u6uwDAOROV9Cr8YjJZEQuiZ5dikwfQStHSxDhtfp14gMz3C3
	 mi3wP3ZrYKdgF8FalaMlyqKWOANLSZJVMVsv/9udHcWvAllA4cnLdDRoinq8GWXp/n
	 wP+xfGe3NjnpFFeMk26jKAKtcrtyGFBlU860w/G+sqNzVynv2PM5ggZMUi8HbNEzcb
	 3UiknEZjNzaUd4MNDPTvlI6A0a77cvqYLA/QOSHnj3CpfcyMqDIzNK7QOiOlUXBZC0
	 YRXqDYwJtWADI97PjWgvqc6cQ6BcKk06S8puM0fs77QnzFiKd0/j+YL1tmn3cA1Iho
	 THvpU1fvj3GgA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EA35F4069F;
	Sun, 13 Sep 2026 07:29:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 165132E3
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 07:29:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 07510406E3
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 07:29:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8ztNtzsIzhJC for <u-boot@lists.u-boot-project.org>;
 Sun, 13 Sep 2026 07:29:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org EE9CE4069F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789284548;
 b=i+7dUpWyi6WarjnWGuPXsiUclAaoUqlw8jzY0UE4jdGHwst8oE+DEER/UGNOMPdED892
 tSrNV9GPp+gbJm1VuBuvkGEbDcfonQexUZSzXRjGfhYcLCQMLwJqSxR0AFWfa9u9jKz/R
 xNGa9spRKtdEmPfYIEBx4Z/PGZ3ga3buXEE5WBGFXjIyFu7iwVNVI2OVJxuDB0UV62KDB
 3n1tpPctvTKnltQzMkmUEhoKUnnSseUoI0Vl5Ul/GPNOUU9Twxrc3weUxVi9QWdzSKs5k
 aIzIQ4v5RYTWWW7EhOLovx/kA5c5Z6dl5tHrFUOQgtxZzfr9Wxh4uEkAx1Sp2TkmLbw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789284548;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=avvaW1LrbYyD+QlETHjYRU2+J2UAcot1Vkb6VIryOVY=;
 b=V0VxrmLCOOIpq6FBfoCcQ8MF/fZHlfT6NJ91b3AvX3kUsMEICR8DSfnsYBXpqoLpG729
 yh/gMuHID16EEq6AEx1PweB2oWKgB1p+yl61Q7KCZMD9GQlF3ur1y1gVt3gDR2yCVO7Qw
 le30X+ZNkyXf5oVwomjK6+4AZYdNm57nDGDqpOUfTPfrQ7Eokb8wnO5T3s45wOAii0vMs
 O7PkVtVpwyxp+ZQ4jdFI2Tu8PFH3zw7Fr19YxW2p4n7wFNfEwB1TRTlEzhTWp2lqwj4Em
 LfCMaOdBr5yM/WJdKp1zk5VQlz1uLNhaXlYcaLnw9SfysWYES69iPLHC+KqhzH2UtfQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Hx7pMHpe; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Hx7pMHpe
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EE9CE4069F
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 07:29:07 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ccff31419so7910575e9.3
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 00:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789284546; x=1789889346;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=avvaW1LrbYyD+QlETHjYRU2+J2UAcot1Vkb6VIryOVY=;
 b=Hx7pMHpeiW7yhS/cuBo0VSLD4Lrtla4uzGRtf0lJNBb9xrANy8vLKSK4htpGOpzLsf
 S1qeYTz9gVENI/4lZfAWDB1b75h0Fb+0/Zyw03XfxPTNZ5pTsiRNlCi1dc1kCBdZ+HgF
 QqeqJEZZeE1YWR7L4q0oPBEhMSuTQA6sACDryxmvJvQVqkRurdY7WonXIl1lMJXpKs97
 fVCI6EJii/w1ncZ70MAxqjAEq8wZujIuma8pD9mdEja8M3eLPGuae31ib1Gjv9DhiNYR
 1DosKwKcY9L9ICgJwiCj19InGn81c06fyWZNhKhRLj78BtgzEiAHFYPZ4FbTk3iq7JuC
 uPhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789284546; x=1789889346;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=avvaW1LrbYyD+QlETHjYRU2+J2UAcot1Vkb6VIryOVY=;
 b=FWIr1K3PrKfkUFy+YxtMmoNG7pOij/ixZWifQ04uBzFBN2S18P2VKnaAcfCQZ17M9q
 F7CjDKfuqNXB9yvPo3cMM9jJO4aZ2lOmJJFqWnKDwBzq5vV2AjD4nSU1qWIwgIT3Z0Jm
 zKPm3nB3H1EUnakPPtzXBbNpEWIEZtR/c0InBLvGBzSSEvgt/eeZmJ83qOGZ7tSzF0Jc
 +q5YBGq/PtT4MMMsjtllr31IPeaAT8ZWmhmC4BOAIFK5F+6Yq6hOhIPuQ53vfiegC8ve
 wCywt47ErWLYL5uWxiFjI7A9SoAcAuPah+/rFTbw8IZRFC9SZvOQgv0vD1iQwg+AFv75
 gmOg==
X-Gm-Message-State: AFuF++lvWdrgyno+/hXf5i1pwnOei+tlTk8vgOWtu/8YpJoWb7xVEudL
 v7qny4FPgQqoON7ttovR4fkWhzmprijHT/3KxY4X+GzOK3X9zlzXueH/lRzALm7hJ4g=
X-Gm-Gg: AYBFou2g1Uv+i1FPwDeFO/Es4W9IWm5tOXewXbTwJk6K5YEd725EQ2a2A0VyH0gnMNi
 mAhNvsYbwfdR8Bf2I62pjQ4/Zvm8xfCx33PJuBWGWHO1qCczpxOdHQJdvpjJrW6HEH4pDnWCQKq
 UUXY00MDz9OEGRnaUBKmAvH86MgdH6DCC63A123Hc2s6nqTc1TEePukABZsU4TpksiIsB7SVGwB
 Ugpp1eA8NP8NJzhgvJX+6j0+27yoAE7jKCokSaKB/oi1orwbsLxshKmUktEt9Eq6/Ym870H0lkI
 JxfxrZ0PRen45WIVEm6+TPFrHIRx6GpXhJczQK+0Q9EjZiDMqf6DvNSXh2IrcLph8fgmt3AKwMi
 LJJLGkaD8aMPeIRvQKl3/rei+6SYkbW+UYxarwx6x51djYMS7IX7traMXhgt4qPzGGTQw73QmWi
 xHJNEA9VpgQc/qQRKlufl7MbwyZ+9uVjy5zgVKtvTlhAdjp+Oe9EwW1R06DStv5V6qcFtenGLrz
 R0VLn1tGy2hvKiVuhhaXXDRmlp2pX9gSIVxwInqvsQCn3eS+ch1nou4QeTSJrrpctEbJJC6Mseo
 j8Wv9p9e/I3LyOo=
X-Received: by 2002:a05:600c:8b6a:b0:49d:827:e5b6 with SMTP id
 5b1f17b1804b1-49e6cbfbbcemr49602425e9.20.1789284545677; 
 Sun, 13 Sep 2026 00:29:05 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-232-147-181.retail.telecomitalia.it. [95.232.147.181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e71e300f3sm100788875e9.7.2026.09.13.00.29.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 00:29:05 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Sun, 13 Sep 2026 09:28:46 +0200
Subject: [PATCH v6 4/5] image: sparse: add phase-aware SPL support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-ccaione-upstream-spl-fastboot-v6-4-dd3ba81a7ed2@baylibre.com>
References: <20260913-ccaione-upstream-spl-fastboot-v6-0-dd3ba81a7ed2@baylibre.com>
In-Reply-To: <20260913-ccaione-upstream-spl-fastboot-v6-0-dd3ba81a7ed2@baylibre.com>
To: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 =?utf-8?q?Macpaul_Lin_=28=E6=9E=97=E6=99=BA=E6=96=8C=29?=
 <Macpaul.Lin@mediatek.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Sam Day <me@samcday.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Carlo Caione <ccaione@baylibre.com>, David Lechner <dlechner@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Julien Masson <jmasson@baylibre.com>, Alexey Charkov <alchark@gmail.com>, 
 Adrian Freihofer <adrian.freihofer@siemens.com>, 
 Francois Berder <fberder@outlook.fr>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>
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

The Android sparse-image writer is selected and configured only through
U-Boot-proper symbols. An SPL storage service therefore cannot reuse
it without either pulling it into every SPL build or interpreting the
U-Boot-proper fill-buffer setting.

Add opt-in SPL symbols, build the writer through the phase-aware object
rule and read the matching phase value with CONFIG_VAL(). Existing
U-Boot-proper builds continue to use IMAGE_SPARSE and retain the same
fill-buffer default.

Require the reclaiming SPL allocator because the sparse writer frees its
temporary buffer after each image. Use a 64 KiB SPL fill buffer by default
instead of carrying the 512 KiB U-Boot-proper default into SPL.

Signed-off-by: Julien Masson <jmasson@baylibre.com>
Signed-off-by: Vitor Sato Eschholz <vsatoes@baylibre.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 lib/Kconfig        | 13 +++++++++++++
 lib/Makefile       |  3 ++-
 lib/image-sparse.c |  2 +-
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 24e55ade4d3..fc8ba70c7cd 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -205,6 +205,10 @@ config VPL_STRTO
 config IMAGE_SPARSE
 	bool
 
+config SPL_IMAGE_SPARSE
+	bool
+	depends on SPL_SYS_MALLOC && !SPL_SYS_MALLOC_SIMPLE
+
 config IMAGE_SPARSE_FILLBUF_SIZE
 	hex "Android sparse image CHUNK_TYPE_FILL buffer size"
 	default 0x80000
@@ -213,6 +217,15 @@ config IMAGE_SPARSE_FILLBUF_SIZE
 	  Set the size of the fill buffer used when processing CHUNK_TYPE_FILL
 	  chunks.
 
+config SPL_IMAGE_SPARSE_FILLBUF_SIZE
+	hex "Android sparse image fill buffer size in SPL"
+	default 0x10000
+	depends on SPL_IMAGE_SPARSE
+	help
+	  Set the size of the fill buffer used when processing CHUNK_TYPE_FILL
+	  chunks in SPL. A smaller default limits transient heap use in the
+	  size-constrained SPL phase.
+
 config USE_PRIVATE_LIBGCC
 	bool "Use private libgcc"
 	depends on HAVE_PRIVATE_LIBGCC
diff --git a/lib/Makefile b/lib/Makefile
index 222378a8531..014fda82860 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -44,7 +44,6 @@ obj-$(CONFIG_GENERATE_SMBIOS_TABLE) += smbios.o
 endif
 
 obj-$(CONFIG_SMBIOS_PARSER) += smbios-parser.o
-obj-$(CONFIG_IMAGE_SPARSE) += image-sparse.o
 obj-y += ldiv.o
 obj-$(CONFIG_XXHASH) += xxhash.o
 obj-y += net_utils.o
@@ -56,6 +55,8 @@ obj-y += list_sort.o
 obj-$(CONFIG_PMBUS) += pmbus.o
 endif
 
+obj-$(CONFIG_$(PHASE_)IMAGE_SPARSE) += image-sparse.o
+
 obj-$(CONFIG_$(PHASE_)TPM) += tpm-common.o
 ifeq ($(CONFIG_$(PHASE_)TPM),y)
 obj-$(CONFIG_TPM) += tpm_api.o
diff --git a/lib/image-sparse.c b/lib/image-sparse.c
index 09225692e9b..48e5d8ee869 100644
--- a/lib/image-sparse.c
+++ b/lib/image-sparse.c
@@ -125,7 +125,7 @@ int write_sparse_image(struct sparse_storage *info,
 	int i;
 	int j;
 
-	fill_buf_num_blks = CONFIG_IMAGE_SPARSE_FILLBUF_SIZE / info->blksz;
+	fill_buf_num_blks = CONFIG_VAL(IMAGE_SPARSE_FILLBUF_SIZE) / info->blksz;
 
 	/* Read and skip over sparse image header */
 	sparse_header = (sparse_header_t *)data;

-- 
2.55.0

