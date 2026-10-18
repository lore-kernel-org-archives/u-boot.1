Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 109A8CCA490
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 04:24:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5BDA380D18;
	Sun, 18 Oct 2026 04:24:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EfD371wiZkQR; Sun, 18 Oct 2026 04:24:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 68D5A80C33
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792297448;
	b=hXATIsiloCbvxD7kOTtKUbXgPMspGDXYcIyVocruyAfpAwWHDj54lj1ntyhdXPzgWBbl
	 9+wWgp59a9fUvVvWp2lVEHZTw4gDnEO1RFsZOEuuL7KIuKF1zdr1N2nsx6/VZNB57fEvA
	 dG42MCz97GV1U62M0UZC6v+O0XUmUVbCDGbbBiQxrCoqo9qJakyo0URxo7fQ2L0lez/7R
	 K9YMoqYUMNH2cvZYqQ2aDZ2ZQ3F3l0wY2lI9vYJ6jO6afGb8RGXvKJ2XqjbHvFgv6geLn
	 I5rn+a9tTMt5SgwOcFk9biqVU1cckaApDvnvhqB1ab7IuWG+metxhMYWM7EhHfaAX+w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792297448;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=XAKeBFd1ED1/No4mfls9iCxl1K6TuM7J0pa8TR23iaU=;
	b=rE53VKjW8wC80kN805B8zweWNRoLxGm9UBitY+cq9lxzvMijiOW7ErL+GslXBYOC0qYV
	 r1D2q1rD4sGnk71Ax6dBgo+f1on6ITWkekidAufOedT+3Ue19j1mwyqG576KTctx9PP2S
	 WomGT/DOtTlscwkUcXh1Qi6tRihOYE2wDKeYf+YTy5QhLopYK0L/f1wQGZ400v4HFd7c+
	 bvWKaUWHWgQtd80BANyrXF8FdWQfaamVn8aweZtUa/bhS+gBoV4poDhBybwd5Gv1er6Jz
	 M8Eccl/MwjqXTROuvAcugvBtBviNY+Ogl231/in17XVktmVs1YRx2goDmosGaAXKijw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792297448;
	bh=XAKeBFd1ED1/No4mfls9iCxl1K6TuM7J0pa8TR23iaU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NMY8pntbHToZXj4yXv9QIyDqMwYDKch05E3BJlu0KzX7b/kaO/2PFAe6Wb/elLfCb
	 U23YCkcrwgAwC5UtOMgriwguNF+e2aJ9Euhj3utnoRS7LbViKAqzlQ4V0OAMjOYh1a
	 rerBEOmjiMptUNAPVlayNn/brxHdGygDydXTvoI12ssmRrPZQBQxu7OlytNmvpuiBB
	 g0G3G/5t4NAAuzgDiyJQmVc2z5+F6LOQ8xx84+tkRW7tuJbc5TjQ0X0IgTlxOHkJyF
	 5XA34rBcmWWjbN7svtATILD4NjpWrroBU9adliJWra1uapuXh2In5kYv4j399l4ZkC
	 /DLxXUbhYnnoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 68D5A80C33;
	Sun, 18 Oct 2026 04:24:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 882A1356
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 04:24:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7A09A40081
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 04:24:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PWGQP8R24Seu for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 04:24:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6A8434004A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::b130"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792297443;
 b=GV8S84YllPjPWCpl9Aqq/Pi8l0oq19v09hpKybbr/fUuJJsGRc3vXc3nGRfgnP85NzkP
 RBT7bAYnJ78+83lr55TIa1loXDi0qjtjTgztZvu25mnqlUM0V7mBO9CSWhl63yqRu997A
 yBj4OCWRpyLz7zLzisJWgvPsbL4+YJJFN3zYXQlbNBOCz1FbMAR6Q23GZWPl/7oFD5FlF
 9Ak+SsPO3YAXLjffwkYY5iVQpaErjSKDaF/jlyjn19APrdELyhl6rLzDuS1D2eDY68VjF
 bQ926FVZO6JSbULzDAW+NZNu7B0LC4x0I6u8uNViUm7gHVyOxGQ+nHVkoWqXYKeu/hA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792297443;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=XAKeBFd1ED1/No4mfls9iCxl1K6TuM7J0pa8TR23iaU=;
 b=DkOZDoqFNXXNvU9wo3RMJdVC1g3s2oXWMBMZCbHpgEg/A30p3ZIrNBYHkcXpIgBLtUFa
 oYqsSXnJgfi+4xz6wz6bMpkaGzMhUppqQ20RuZgNawuzhJQ3n6EtzkwYvUTWsHCOWhaUv
 Dlkc7v6CSj1/YDJJujOsVd9qHkIzbEctTmYk2eSj1QfEkGyjiPtJBwZCA+wlmqAA8lwSK
 OOhrNLycqIFAzD8PKJEt/GrL0jxvv8/5LNy0hnlYOYpYxyeBdgi2B6FEFyObHgzSpCQEG
 duCIZflnN+Yojqgdtc7784lIyhJxzdMDQYt3srPlvQc3KBctD/wyT+9Oqk6VKjWUDqw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.tenstorrent.com;
 dkim=pass header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=ZTKiJGM5; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::b130"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b130; helo=mail-yx1-xb130.google.com;
 envelope-from=asrinivasan@tenstorrent.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.tenstorrent.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=ZTKiJGM5
Received: from mail-yx1-xb130.google.com (mail-yx1-xb130.google.com
 [IPv6:2607:f8b0:4864:20::b130])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6A8434004A
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 04:24:03 +0000 (UTC)
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-6798c4b882eso827624d50.0
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 21:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1792297442; x=1792902242;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XAKeBFd1ED1/No4mfls9iCxl1K6TuM7J0pa8TR23iaU=;
 b=ZTKiJGM5sXwP1fZYDYjCz0pzsDf7B38zGjsN7HofHZayDThBIdbka9x/F8WucTsIvr
 CWnOY/R7PUo0E0S/xODyU5oNItvDIEF9m2kI1QK5mFjuHo1jGZYaUQBKrUEDoaPJoWh8
 PlfFCb3JcsWC18tCy/MrKY4DWhVBWLeKJ26EEoVMEKfznGyEhAYRaAttpY88nmI/+Oc9
 qXNGMnJR8hJdNdxbK9uCSas0FmFCmUZV5Nys6ej06o5Ud3eb+Ug0Qm8CvfaP9sccVKMY
 umAOeC0XWyp0qptevK86PDBuK09x3+vCCY196b/VmW5wjtbcKMxWkguuCa7fCMhwD2G+
 mhbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792297442; x=1792902242;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XAKeBFd1ED1/No4mfls9iCxl1K6TuM7J0pa8TR23iaU=;
 b=h529vZm9ZXQaLRc7Ia4fRnw82CzrcOYgM08ssRXS8eNExhwfLLZCurNhZTgakEzWAu
 zoSxU2pSZFbx/5XSQ4NihQEijs6JUzp0boiIa9763EBOAbzmBj5i1icKfHDDdVaDs/1W
 YVJV1s5EiYv/cO3euxeHvDFEbobky+QLjkDQ/9U7I8BPMiHiSd7M275KhPf+MnD8KqGf
 nL8vnnaYlVYQTYOXxx91psYLjhZXL1uC5oBVTkD8smQjxxyFt6FxzEpeS6HmHAqsv8XY
 LFz2LFxBofCDXjmD/M72MnLc0ZaF6hb8NsfgZbtOuD6O6vVBd7rmIQqFon6EXgO5Bjul
 L+TQ==
X-Gm-Message-State: AFq9FYJiF3UvVVP9MGB7z9sIzQ2RRU/LvFPgfBIjYLbYw8QxA0xN1xek
 FIWLoNMMG57J4F5ODSujUDFbZM/SmruF4lTrZ8ZTCHshmYrHWBsG6ONreqnsJb1v54w=
X-Gm-Gg: AYBFou3vuoE1FWsMsr6boSAJ7QEkjkDo3puzSz8DwAP81m7OY+FUUb9g+U38x8DEkEt
 +bIKykNdRkw3ZBv/16oZitm4uTypp01YQ16p5lfzS1+GdZii1n2rwibhzJE95VK0DaT0jatN+5L
 +eMHAwqWEy7e2oIc7wkiKZoDFwAceI3TfVa12T/YcSBz421MZFKbbUGNvpK2Hk5K5RJOJONbMOs
 k2TGeb/Pd2I0b1yiSFFM9PnZSd0e0vqUTZanJVMLBPfm1sYWd00a5Jw0/4IA0TM9Gz6CziUgLU3
 mAUqckypixmiSQklC3DKtpbpuQJcTSb3UscGfy44ZTLxH1f0lUUh21rFcfri4pvtx/M2zmWSueY
 Bmke63PYwUdVm9hP/drrqmN2biG6zXhR8HO+oQOc+anZnW9T7r1gry+8gmvdv5udVrnF8ny5f03
 hk08S/CqN1AEpgGaCQoxvVlmdFSO8NO6LK1jquysv7fQQJJPsKh/BFWHpvvMAghz6hTzm6kExO4
 2CSgy/iNMgda5pwxGWPDIFjLUw71wzTVffpOgUEktVHKyOSJb1LMKEIZ8TATj4j
X-Received: by 2002:a53:a101:0:b0:677:ad90:7002 with SMTP id
 956f58d0204a3-679ca8cd5c7mr963681d50.96.1792297441687; 
 Sat, 17 Oct 2026 21:24:01 -0700 (PDT)
Received: from [192.168.2.129] ([2600:1700:220:59e0:4b47:590f:51dd:a46d])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-679b1f0e01fsm2838791d50.20.2026.10.17.21.24.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 21:24:01 -0700 (PDT)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Sat, 17 Oct 2026 23:23:46 -0500
Subject: [PATCH v3 1/5] bios_emulator: select X86EMU_RAW_IO only on x86
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-aspeed_vbios_fixes-v3-1-961124989594@oss.tenstorrent.com>
References: <20261017-aspeed_vbios_fixes-v3-0-961124989594@oss.tenstorrent.com>
In-Reply-To: <20261017-aspeed_vbios_fixes-v3-0-961124989594@oss.tenstorrent.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
X-Mailer: b4 0.15.1
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

X86EMU_RAW_IO mode can only be used on architectures that support port
I/O like x86, so don't select this for other architectures.

This was also suggested by Tom Rini [1], but was never added in.

[1] https://lore.kernel.org/u-boot/20241117025353.GA3151182@bill-the-cat/

Suggested-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
 drivers/bios_emulator/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bios_emulator/Kconfig b/drivers/bios_emulator/Kconfig
index 3660576772d..5afea87a2e4 100644
--- a/drivers/bios_emulator/Kconfig
+++ b/drivers/bios_emulator/Kconfig
@@ -1,10 +1,10 @@
 config BIOSEMU
 	bool
-	select X86EMU_RAW_IO
+	select X86EMU_RAW_IO if X86
 
 config SPL_BIOSEMU
 	bool
-	select X86EMU_RAW_IO
+	select X86EMU_RAW_IO if X86
 
 config X86EMU_RAW_IO
 	bool

-- 
2.43.0

