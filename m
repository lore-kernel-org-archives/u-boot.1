Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F117CC6B1D
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 12:24:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 30DAC406B3;
	Wed, 14 Oct 2026 12:24:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ftCWo7DD8dke; Wed, 14 Oct 2026 12:24:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 700AB4069C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791980695;
	b=P3plNYuTg7nP//vp5WYsE0EVJRHoxSD5aD0qScPBXq3e4Ep8a9zbRRbcLxzwFWQ2+Er8
	 jiTET5mE2IDYGlc1cLBEAkDtWERzda4REsBe8I5OYYy90e1brBZ0kOBxq+T8O1PyIzND8
	 HrpxxO5G6X+qt+kH6pTibaxJx85oK5F0qYctZRbVWrKD6UD5/heGxEbWwVqYXRYxEXnu0
	 gOjpY7OFaD3s9u2zl6JH5gBjakBFRlCrWUYH9xezaWuZ1s/JS/tRm0AXkLTA1disC3SiC
	 LqjfIAOHL3QMYivm2ie0Meb/k3AINI87WOSb9QQLuqd+9ENH1ncHtKkYxA61E+ptpkg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791980695;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=cKlTk4sh0V7lUu9Wc8JMhykGRPCmRbWQ2/MvSbGv4+g=;
	b=qgJmArYyI8Q0aITlC6euo+KyiwQ3STlHtB0HtgivWZhRlMEbFbkAcsHr73Nm7BNegIUH
	 nMiE5QuisiKI4jFOyUIc2/+bEELJVFFUla7tbVLQM41n1L5c9IXSsbK0TWciduscJ0le7
	 TqmIMBcfcPM7vnglboe35T7nJOz+g4emOUbCKgaLRRAU8KM25kAIG9EamOAir/OgmqOGU
	 x2q6Ggc0f7FChYemb1vvU+2iH1zVgiwN9gfKHa2VgAt/yoKWE7phGwzSmZ95qmzP0Hh3i
	 tleukx/JSGc5vnGEYDNeSmOBZjsioX5fVLHKeAoy+zop4lvVAUSBf19OjD6s8L3E7xA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791980695;
	bh=cKlTk4sh0V7lUu9Wc8JMhykGRPCmRbWQ2/MvSbGv4+g=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=t6mEWG55sr7unXAjtE5EWlXlUW4AUQLmNz/zKJFhEyBBsHSpQ5eYkxCVAAJwmIH/r
	 yvg52KtASCkI4h2ZX/Cvk8i9cap43pp2AS2MNs16r6tix6omGPwTM1HXWGGZxlWLJo
	 Da1rr42KpKnurQTEx4o+igAzTsiNvV16JUakFSl0YgklMnoc7wgCd/rRvg0xa3b2tW
	 TuS3lwTxptdp6r9q+3/VFIIX7Nm8Z1D9P3L3UBbRiN9ZIgOKhmq97ESeVFj0D1ZQgn
	 eDPAAlKUlnLdSNi934DbmeCr+kD40CgfGAYXbCq32VgmZaOn6KJvkPjg5dXEymcLUZ
	 rpJuKY829Vmuw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 700AB4069C;
	Wed, 14 Oct 2026 12:24:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D123D2A8
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:24:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B7CE44014E
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:24:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vzN45u1SrQ6X for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 12:24:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 14C52400D2
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791980693;
 b=EvOSAtWA1nB+Qj53OsSPauO88Ny+N2T7jnCthO/guHYgSl7Dzlm9ZVbUr3ZuCuqgb68m
 P1IFVyT3ch8zga4E+9LyN7+MYjB50GGpbEQKPeEppIXD/xyKnSBLoPbE7/j4oHXgRvVyL
 wZFNzqit8sNEFBnuOA2VLYVmEfIF964NWxCxuDMTYSzmlVznWoWnYtK2nx/UEbykpWcHG
 Q1F32vkb/gpHXU/wOuZeU5165v+OHqMnBg++Duxd4eIlcfv/KzTmfI1WebNBImqeC7M7E
 5eq2TFikL3YN5ghSNmO/ZdLFYDMCiHhONDqYo4Vgt8Oo8JZalF3nYdOeNlcR4X1qS8g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791980693;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=cKlTk4sh0V7lUu9Wc8JMhykGRPCmRbWQ2/MvSbGv4+g=;
 b=NQYdj4Mt4eo6qBCGjCp8yggT350eNNwx8B51vxzaPbFCCysXpzmxxUMg72X6r8ItZQKc
 jFiZF0DVwZonRFVEpmWH+xn1nwRBwblBzSTcAZqT8n2RzFNPyo5rknhAziAdIlCWb5q8T
 ueUQAEAmCrE7s5v2EoOK0BdTX3gH1Tqn9pCLxflPWqadcfiZnc7Co070i0YgQ2WHyIyIo
 hN5iVKbrXAhD90dKL5FNnH02RWLIhw2qDYSfcCHBRKSiJ8y6R2KgQEgwDRypnBXtYVZYF
 xLe/ABWGssB19l2BNT1napOoBLvBR8LDIj/GJcyJ6kTBOCAAV/VpFTQ9+QG+jHoBHLg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=MdHBmY+a; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=MdHBmY+a
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 14C52400D2
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:24:50 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a16c399641so39960035e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 05:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791980689; x=1792585489;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cKlTk4sh0V7lUu9Wc8JMhykGRPCmRbWQ2/MvSbGv4+g=;
 b=MdHBmY+aUM9e2ugyIeeb81Rw5aO4zrDm1IAB/965jXpwle8W/C0bTzemUfkjvzwXJD
 DlYc7c9/SGwxQY4CH5ssXKhau62503ubuQfsCjt/IuoEV7JdKjrp0WyhTWqYTIsamCkL
 lGRbLOZ4Wg4wHqYadrCz/9/TV+Q6lP3aXB/Z3XfNG49xufzEU/PaLsGH0nc/LJdWMoh7
 Rpp7KebhKHGVAYJu9mKzu6WRPAaTUzhmzw2T6kjWnMf+aRK29szMoGn4LNMNyXwts/t6
 HLuj4p6xEJarhEK6DJvBG0qQWRCNYVKWvElldVK75Il5A1INDieBjxEb2qsr1OL8DCiY
 kLiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791980689; x=1792585489;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cKlTk4sh0V7lUu9Wc8JMhykGRPCmRbWQ2/MvSbGv4+g=;
 b=kHTOMhsb9UqkRXdXpl6cS0e/LZPezFPtdDl3wjwn2TLo97UD1WE/ecP7Cfg2N+5yT9
 jI9YwP9ftlkZSrhEA7yAfiuL8iCrFoaH66rOuXBNDrlRbYUp30xA6wtX0VX6On2+8Lgf
 SlJsJJ9UiozULeOWOh1K9DB6D/rZHKGWoruQrZhK2LgElsqIFKVv0pXkb0cic4GbZCxi
 YI3B5L52+uNwZm56LET3+5oLMRZuQejJVB+O7YCaP/5wW9VSCAZYK3RZUdGvl2QnXDbX
 qo12ZrYMDLg/m+XXm2g80NGELtxKXC6kYL8Ok1T4CD9/KkykoSt9YzoHjq89AfNnX1Rc
 Dwsw==
X-Gm-Message-State: AFq9FYJIshSNMZqeZm5HxEmd8YqgqKTTJZsc2NGi5QPcmi89BYhDb7iO
 0M+uniJsMvBLqg6igOHNqkW/bhFctDx4NkxOpMrGRyQqtLLl+BCU6Pc8gw1C903sirA=
X-Gm-Gg: AYBFou3cihx3v8xpYtZMjoes2ZKuS1PFkUdAP/hOw+M40T7SR/ljGzCJuikmZq/ZOj/
 QcCa1P05uM5a/u6AGWm9Nt2BicU5L9PQdswFm8I2TUrNMVb3nUnlt1pzMBAkBhQelHGVSJ72L8R
 FjCAeT1AklwCLWKWUrvOTfzBo5TMIcjgdiaPwvdLPJKa2z6GM8QZX45VenZeh0YfC2CCRy1m4o+
 4tAuI+iEn9MFtTTN2qbaGPz3ng80idhWJKLX4YgsjdfSuwETUa0dkA4ycXEsoLW3nhII8sOSPkV
 LWxqLYWUcnTUqa7yaZpE+c6mdN2dR99w1419FCb72VBbX1wFxQmV2eoW/j9G6uWSZe7qdrcWy1E
 XZPyhW60yvpZO/pfudFEfEmV8HX8ZNVd7BoKriUknM9o4yclQ/YDSdgTuGKYz3TRCdVH1AfUJrG
 YGnjcP41tk7F/YZckDf+YxTTxesBwk87dsD+k5Mh2mc24zf64EcRx9DEwshnAzpPa2DLvTw8GmF
 DWOdlBoT5mc5hPDaSmluFULonoJibme+VYMGMu0VYvhXH/YZ/LpR3pl0RLfxkNtfE5Mpi/+IflA
 AFV7i47QiIH52Q8bGbyWFKRQsg==
X-Received: by 2002:a05:600c:c3cc:10b0:4a1:a7f8:c12b with SMTP id
 5b1f17b1804b1-4a1a7f8c219mr91911305e9.19.1791980688868; 
 Wed, 14 Oct 2026 05:24:48 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-82-63-151-127.business.telecomitalia.it. [82.63.151.127])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1b2fc4724sm50351815e9.2.2026.10.14.05.24.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 05:24:47 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Subject: [PATCH 0/6] Support fastboot boot in SPL
Date: Wed, 14 Oct 2026 14:24:28 +0200
Message-Id: <20261014-ccaione-upstream-spl-fastboot-boot-v1-0-d29df15fb9b8@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2Nyw7CIBQFf6VhLQlgefkrpgseF8XYUoEak6b/L
 rZuTjLJZM6KCuQIBV26FWV4xxLT1ICeOuTuZroBjr4xYoQJSmiPnTNNAbzMpWYwIy7zEwdTqk2
 p4n24V8CUkYQYj1pozhDiZz+5DgeXxT7A1V/5b2R4Le29HhqypgB2aRxjvXQBvGa8F1oQoxmV0
 gvpiFVeWsbOigdOmsI0GrbtC09Ue9rSAAAA
X-Change-ID: 20261014-ccaione-upstream-spl-fastboot-boot-5d8e28a700ad
To: u-boot@lists.u-boot-project.org, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, York Sun <york.sun@nxp.com>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sam Day <me@samcday.com>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>, Alexey Charkov <alchark@flipper.net>, 
 Kevin Hilman <khilman@baylibre.com>, Carlo Caione <ccaione@baylibre.com>
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

Test farms need to run successive U-Boot builds without rewriting boot
storage. Add optional fastboot boot support to SPL so an already-running
SPL can receive U-Boot over USB and hand off to it in RAM. U-Boot proper can
then load the operating system using its usual boot methods.

The standard host command, fastboot boot u-boot.itb, accepts a FIT built
for the target, including any firmware required by its SPL handoff.
Uncompressed legacy U-Boot images and raw binaries are also supported
when enabled by the board. Raw binaries use the board's configured load
and entry addresses. Legacy and raw downloads are rejected when SPL FIT
signature verification is enabled.

The series reuses the SPL RAM loader and normal SPL handoff. It also fixes
ignored errors when loading an explicitly requested FIT device tree and
invalidates stale or incomplete fastboot downloads, so neither can be
used to boot an unintended image.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
Carlo Caione (6):
      spl: fit: reject failures loading an explicitly requested FDT
      fastboot: invalidate stale and incomplete downloads
      spl: ram: allow loading FIT images from a supplied buffer
      spl: support booting FIT images downloaded with fastboot
      spl: fastboot: support legacy U-Boot images
      spl: fastboot: support raw U-Boot images

 MAINTAINERS                     |   3 +
 common/spl/Makefile             |   1 +
 common/spl/spl_fastboot_boot.c  |  76 +++++++++++++
 common/spl/spl_fit.c            |  14 ++-
 common/spl/spl_ram.c            | 101 ++++++++++++++----
 configs/sandbox_spl_defconfig   |   1 +
 doc/android/fastboot.rst        |  56 +++++++++-
 drivers/fastboot/Kconfig        |  16 +++
 drivers/fastboot/fb_command.c   |  43 +++++++-
 drivers/fastboot/fb_common.c    |   3 +-
 drivers/usb/gadget/f_fastboot.c |   9 +-
 include/fastboot-internal.h     |   3 +
 include/fastboot.h              |   8 ++
 include/spl.h                   |  25 +++++
 include/spl_load.h              |   2 +
 test/image/Kconfig              |   9 ++
 test/image/Makefile             |   2 +
 test/image/spl_fastboot.c       | 230 ++++++++++++++++++++++++++++++++++++++++
 test/image/spl_load.c           |  46 +++++++-
 test/image/spl_ram.c            |  48 +++++++++
 20 files changed, 666 insertions(+), 30 deletions(-)
---
base-commit: fed92546960a92177d67c0b8d7b22385f50fed29
change-id: 20261014-ccaione-upstream-spl-fastboot-boot-5d8e28a700ad

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>

