Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F68EC982D6
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 14:03:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D491E60B01;
	Thu, 17 Sep 2026 14:03:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id izEgqMT4Yk0s; Thu, 17 Sep 2026 14:03:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1FA6560B0F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789653785;
	b=NEw05FBiLHia9f+DMy+EHRYTXhsatyYwfkXVlcLahkG7+Xd+/v1oH6Pma2+sAOXaJi0o
	 CTDCZT9NjPbpfWOCKnGpsWgiWqcw6FYOgoaYJ9xXz5xTw1s3R7rq9RZ6e+AexYcYHSgRe
	 uP1qn2dIRgN5r40a1KeMJkqQIu6P1xIsp5H8R6IvfCGrAnm/BwNaSCf8TewSevWAJi7v0
	 Zczc5c9Igf3N6meQWoBbSy2wPkKxFYi4P7cOtwK269b01/pNqKgPm7zqeb4bI1g/RhN1W
	 Iqkr2cyqmW6LgUc2ht5UFFXy+yg57Q/gXraWRtfq1rOx5NdaqjaljJk3CwctnQhrnow==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789653785;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=uyXk6Bzx8mmvNagOnwvZ8Ys/wyp3FjK39Q/PVZFKmdg=;
	b=eJ3ZxT9KexjL8OniA7ctNboG5Do7ectvyCmQOMbuhQvuVr6GNP5yHWNV/6hohJrPDHW6
	 fttwWPfBF++8/SAQ3CRu9kg6nJ8cvCOqnUxwzdnDHwkvT1MXR8cRHf0ZnlXdTlMBjf/gx
	 5xPdzkLyE6FnquEHQGZwO+tzuGeAUcd3ycZiMRx8tZj69hiNx/4CvLqxbfwg6tOHK7+A3
	 cLlBd16zKLLp78IjL7+xp0YUwoNkftCrC7NlMGHQ7WpcmJhl6B+p3Vgo8iyGWw1NB7X1o
	 eu9vJPoMHesoyGvOmJwrk+s0OXD0MtbRNtmVxL+gWoIc/a3pPnNfv55GovH4BtnidBQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789653785;
	bh=uyXk6Bzx8mmvNagOnwvZ8Ys/wyp3FjK39Q/PVZFKmdg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kE3YmhjCRtsHVhExzpNG2vE3k7+DNzQqMAHkFqGTTymDyW1KRnR+InLHhBdXCwED+
	 ssTqi9eVVan4f34H/kF+3A+/BIuBoS8jFq3Wj9lM2adhAYbmKG91nXyOube2STmhmS
	 FYNyAmPRAJmbjuhCW4kwVsCtmZjz06AJBPMeD2XYMt35GEgBBNvJAKSvgZrgDJK8Sz
	 ph0PeN4zPA0AZ2xqrSXS7HcQFgVVCDkmlzTUTlLI+cZ9v4o1w8PjWAh2wzcmG6XY4f
	 kZhMRyj/s2Re0zwIe8hJpqTAiBcbNpqAu+N6EYks44RSwezsJ7nmTrIYm5rlMyJ8YC
	 cY9wmbAUA9asw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1FA6560B0F;
	Thu, 17 Sep 2026 14:03:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 15FA3362
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 14:03:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F0B394009E
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 14:03:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7gmkjXL-HrgV for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 14:03:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org E574B4007D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789653783;
 b=hizc0zV7CFq9Hr6zqmXh0UzAe9YHqu0D7Yt26AogT2CLAyemIhKPnVWtjz7dOAzTWnzB
 4YTNqALVIuwoZBEXyx113Gkc799NfEi7xPk1Oa+48HFkiOoYqNPjjDEHY3UjJ0r7fJGPG
 rEF2HuzTHnmQMHZgwS0/hz6M3OqRDVO6Ui0mnBfZ1/wj6A83sjNevoU9YGU7H39A6duzf
 0VsGNRKssoaHtbkBI33ok0JjXRZd3CMDf/vwtAncTBxCDjw8GPMnSXTmfm34LXI0S5hq5
 59DFXfQoZsMFHp1hLllowcNhG0I44J5pFCtbTBkOGUcB+iGEG73RFskeL+icXh9YLXw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789653783;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=uyXk6Bzx8mmvNagOnwvZ8Ys/wyp3FjK39Q/PVZFKmdg=;
 b=qpem6nTfzEFcdKIe0bBjcDlg6+KYN8ZJMrJRqPjgVPFBZZuXnKdniZ1sRoStKWvJNYvq
 LA0wjsRpKo4ywgi1JITEYaACprkR7HCtyCXql2tcLstB2LlbYSt6PZ4A8ZymwUbjUTYfu
 iqZBIOgKbl8vxivNlRlJCNu6PGKGKlimR5OWW7vvSd9+pJR8o0t76kZGa/4Q+mHtYKVDQ
 Tnl9FqNyIAfTPAImmash32lWsJsEpeUBsFfO5qUY07+RWBTjGbDOgCEbDZmMnTTxGYW8I
 nJ8Gt7m/zSk1nPckoCuU7wilgbFGYBxf06wXnXZd0q/tWl+xxm9omtdR2t7CImx+W4g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=2eXGnkOW; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=2eXGnkOW
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E574B4007D
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 14:03:02 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f633cd78so489509f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1789653780; x=1790258580;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uyXk6Bzx8mmvNagOnwvZ8Ys/wyp3FjK39Q/PVZFKmdg=;
 b=2eXGnkOW1lawqxcZoVx/ecArl+V6GSyyjMvN6+T4Hr4G5xawexbW4ZkHpb99FM0PbW
 lwgx668vr9COM6SMPGd5fhzU5bqk9lU4R8Umu+ewy3aImi8YWZrJ0LRfNe10BJcGfw3q
 r/Rh1JBabSMhYQsP4AfQ9BaMKJYP+ghZXIZfhRvWMRuWouQlXUAUgdobFpSfc1Us8ocl
 INYPU24D7dPN/zPijgKDgiFmg0LpOczxgiz+mOtO23To49VmfKKs9SQzLHdPO+E0p89C
 gdqJMxvOAxGqtehe80OnpQpl8+0aODNwqqVoNP657lQ4P25eULzkcVhumlo2r9ijDWnn
 PfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789653780; x=1790258580;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uyXk6Bzx8mmvNagOnwvZ8Ys/wyp3FjK39Q/PVZFKmdg=;
 b=ROjvr/WaVeQsLkJLOe5ISpVptaNkvQiSIMBKaI7bK5NzTxJOZzKu046PgpCWQjHxo8
 iJuv4ZsSPKySzUyoTWQAV0gfIrs8guLw/e4kNw0OSgNNliJDV1U54jtdK2FXIYbpx3PC
 NKyqiMe1393yZwxu20ocufSa820KsNSiYp8B9hOJT56ZD6R7VZmjGcduf+4V7YFdQG8y
 W27Xa6jCWIEX99qKmsRkbVzDxnlGOUy8dNPZAtxtX177utFlGXQkXPWu9fg3yv7MKMRP
 XNfvkgrgKUYcrgKrS22iQjHsAWpgES2oqg5eEw6V+FF4ojrFExGadaM1ZI9bPdclK800
 ppMw==
X-Gm-Message-State: AFuF++l16EbRnUD5A96lm/pZwTbwUMkvMYKZ1zkYLVRzYe2XvPjTkwOu
 PZm2H4Ja8NkhtXOkJ7GTuogFuM4Ohn6il13yynHo0E+plrvSxdrNGVtiev1h1J88yZA=
X-Gm-Gg: AYBFou1Xmk6omqyI8KT2VOWcfEq/ynYXTHRJpuV2tHPiaOmLWz0r9btl44viVRXJ3N0
 7U3/f32BRfaJSw2rZWQbnALyWWgqJQx6h5GgTVdIg+wLjOYstbocOyBgTOkqwj+tTbjg1brLDyh
 H1YRYO+r1iVaD9SbWMwj4hOj4SLe4tS/fR3m9zkkaEsmalEUnfI42afH9Ah16IIpVbYz6tdlmRu
 cBq4GMkqu/DqagMvGBDF/Zr8p3LQ1VqB9uZmQtpRFaQSH97zrfQ707qCvPDICWqCxNm8/l7+nA4
 6yrhSdqIDJGFtEVnitLCQ5Xk2nS/F4U/BX9oXJ8BYjfiQeTZ3b8aLUotMirEV4ToZXQ1l6DAy3l
 h2mtgcZJ0s/uPDHr0KRYgJBGxhypi3o5OMdGUHy5cq1ieP2SkTFMnHVtmtjfO/FaYBhs96cjrTz
 7haOtaaIPAb87vBMxV5epfPchPJU4NhRQPcZGrBSiOreafKgflf/pi6pJhaKEbBhoxMCme7mGJo
 btI1EHsEi50xC3kS9DTvruNxkAWCz9FcwuxPsz4D+SU2K5Dtv1M
X-Received: by 2002:a05:6000:26c7:b0:482:fd9c:3740 with SMTP id
 ffacd0b85a97d-4870cef826fmr8926896f8f.22.1789653780326; 
 Thu, 17 Sep 2026 07:03:00 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf344fcsm16893905f8f.26.2026.09.17.07.02.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 07:03:00 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 17 Sep 2026 18:02:26 +0400
Subject: [PATCH 05/11] spl: fit: Decompress any supported algorithm
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-spl-fit-compression-v1-5-7985ac56ee9e@flipper.net>
References: <20260917-spl-fit-compression-v1-0-7985ac56ee9e@flipper.net>
In-Reply-To: <20260917-spl-fit-compression-v1-0-7985ac56ee9e@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Johan Jonker <jbx6244@gmail.com>, Aristo Chen <aristo.chen@canonical.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2907; i=alchark@flipper.net;
 h=from:subject:message-id; bh=ovqjIpUAj+3O51w1W0ewI5znwmsBQ+gYNaJclWL0WIQ=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSt/vRbfbeCnddHrhdyqydmV7d93RJZEhWitHi59ul3+
 TIhHzff75jIwiDGxWAppsgy99sS26lGfLN2eXh8hZnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DI10jHWMGLg4BWCq5xcz/DN2ieu6F7D17uWztlJPUzekvilbvtCp5a7K6XPfrj97fC2EkeFnyrU
 1H7fctxYz2TXjG7f+J5ZZ3ev2LFm4M/fDhKxHMW/4AQ==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

load_simple_fit() open-codes gzip and lzma in two places, so a FIT built
with any of the other five algorithms image_decomp() implements is
silently copied to its load address without decompression and jumped into,
causing a hang with nothing on the console to aid debugging.

Call image_decomp() instead, which can handle all compression algorigthms
enabled in the config, and will abort on an unknown one instead of trying
to silently jump into it.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 common/spl/spl_fit.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 1a0066c92a05..40cbfc76b698 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -6,7 +6,6 @@
 
 #include <errno.h>
 #include <fpga.h>
-#include <gzip.h>
 #include <image.h>
 #include <log.h>
 #include <memalign.h>
@@ -260,7 +259,7 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 	ulong load_addr;
 	void *load_ptr;
 	void *src;
-	uint8_t image_comp = -1, type = -1;
+	u8 image_comp = IH_COMP_NONE, type = IH_TYPE_INVALID;
 	const void *data;
 	const void *fit = ctx->fit;
 	bool external_data = false;
@@ -364,8 +363,7 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 		}
 		read_offset = fit_offset + aligned_offset;
 
-		if (spl_decompression_enabled() &&
-		    (image_comp == IH_COMP_GZIP || image_comp == IH_COMP_LZMA))
+		if (image_comp != IH_COMP_NONE)
 			src_ptr = map_sysmem(ALIGN(CONFIG_SYS_LOAD_ADDR, ARCH_DMA_MINALIGN), len);
 		else
 			src_ptr = map_sysmem(ALIGN(load_addr, ARCH_DMA_MINALIGN), len);
@@ -429,25 +427,18 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 	if (CONFIG_IS_ENABLED(FIT_IMAGE_POST_PROCESS))
 		board_fit_image_post_process(fit, node, &src, &length);
 
-	load_ptr = map_sysmem(load_addr, length);
-	if (IS_ENABLED(CONFIG_SPL_GZIP) && image_comp == IH_COMP_GZIP) {
-		size = length;
-		if (gunzip(load_ptr, CONFIG_SYS_BOOTM_LEN, src, &size)) {
-			puts("Uncompressing error\n");
-			return -EIO;
-		}
-		length = size;
-	} else if (IS_ENABLED(CONFIG_SPL_LZMA) && image_comp == IH_COMP_LZMA) {
-		size = CONFIG_SYS_BOOTM_LEN;
-		ulong loadEnd;
+	if (image_comp != IH_COMP_NONE) {
+		ulong load_end;
 
-		if (image_decomp(IH_COMP_LZMA, CONFIG_SYS_LOAD_ADDR, 0, 0,
-				 load_ptr, src, length, size, &loadEnd)) {
+		load_ptr = map_sysmem(load_addr, max_size);
+		if (image_decomp(image_comp, load_addr, (ulong)src, type,
+				 load_ptr, src, length, max_size, &load_end)) {
 			puts("Uncompressing error\n");
 			return -EIO;
 		}
-		length = loadEnd - CONFIG_SYS_LOAD_ADDR;
+		length = load_end - load_addr;
 	} else {
+		load_ptr = map_sysmem(load_addr, length);
 		memmove(load_ptr, src, length);
 	}
 

-- 
2.55.0

