Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD1DAC624DB
	for <u-boot@archiver.kernel.org>; Sat,  5 Sep 2026 09:15:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 763BD60BFC;
	Sat,  5 Sep 2026 09:15:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WBBrZ80O_b27; Sat,  5 Sep 2026 09:15:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5407C60626
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788599726;
	b=eUrZUEn/+RH4PcSgN5ee12yAlxTjDg8K021HLbs8YLeTB/XQqm7Pw9B2HLp5WUBrk6By
	 dgfKWwx7RkPYF+FmTp3/UmjmPpMOlrfFWynvNy8Zl8R+FpUSJ1eGT6XevsKQ0gkg8KKWX
	 tp6u/EGv50bXZluUeSvRUn9eI/yS6Y9nSR05+h+ScHP+zo0oYDnMSAHDBiA4+3Iq40NI/
	 +JBJXxT6kgabV6gvIynPYuDLtLq78yXF8O0YXbSNvQlyQt9DUzC9zUUk6/iQEWRnt4xnv
	 fJEA+CXRuDUYr7TWgclWBOwrvWAB3wxPpkj9HcmlYb7obGt54a+pC8O17ujWhOpSJkg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788599726;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=pb92asXeCbFivAkLJIRniCitbaHzqNimmCDsG5aalCE=;
	b=MDBEJHx/nsmcptyLfUM2xeilHa5IEPww0POqkREJfScWeNv60XuzFiIvu0Luxdc7DIDv
	 g15YIz95LWbi5bctuZw/G39tiAGZsr/85hA2b37Tose4XdJtjZZxkCDMbBtkczp4X2ttb
	 7MiUUdD5pYUyV3xQiZWKH6ErPsX3LB1ZtADMVHJ2aCsSCjF9/rxnT7TjFUEl7iuRWRVWj
	 4yzh/YpENaDvvbn4c5OZ/spR4uDlDgrhoLweQ4MJ7+V9Qsa6uZG4O9sCwoz6bE4QWny3K
	 ioQjxTJ2wtVmUF0UZbkvli8u7WTbQzVgilw8UhNdFYUxT4YgO0Id79z0FPaygaQIf4Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788599726;
	bh=pb92asXeCbFivAkLJIRniCitbaHzqNimmCDsG5aalCE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CEPtGI/cWJ/vM8QJBevJ76pdRLEENei1RgwV9NQ8IvBQREO8dI19cxn0Nftigvlud
	 Pqwp9cNfPtLDThqEeA+gwxxsUZJVn6vEVZmO4Su9+swBVi2l0Qv07Ip1MPwvqiMddH
	 OQH8EIr/Ul5fYEDXpjlRdSnj9iLAQHlIuNGkUg8rGVG1x+SvptoL93rT8AUhMheB4x
	 rxaKx1Y4kX8JmfV1FfKh/D8iq3km/+mbL9lhIouOtQk7MYeEyrL1G9G0CLoJhidu9V
	 uGAxnRNJ9M1C/fe+0mBaY52/05rboCAgTR/cYQSV70gUwrdJpyYS4aN4xzR/U0Uj32
	 MBRqB27Wyt/DQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5407C60626;
	Sat,  5 Sep 2026 09:15:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3FD84B88
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 09:15:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 30FC58112F
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 09:15:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RxIdNw_TKRIV for <u-boot@lists.u-boot-project.org>;
 Sat,  5 Sep 2026 09:15:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 135F781110
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::636"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788599722;
 b=bnMo+vL7vBs/5WOA4kb6VFWaHMQubnJ/9u4AhddS7wwyhSm9yTcocjHGxNc+6dUSdoyM
 cMh1CbQYhTxiob4rE0uvtjp3e//mM8aMQPKF6+ahs0IXi7lTHoS21e4EIzBl5dqywda6/
 WnzETG0Pe4HBhvSqbpEGW0ZwM3NuiEhvH4qeIPm3RW//y6TZ6brx2koElKyY3X9eY0xr8
 1ep8Qoo2aX/9nvMUfDSAE3Ml0DRw2On5+uwKZZdt/HZzgHFEVGANKtoSdRq5C7lfhhvNp
 wB4XHeSCyCHU1I4IsbriyMzzb0rqv6zRS8WUxEAQmnv0mzgizmEv1POfAIsxW2WsBEw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788599722;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=pb92asXeCbFivAkLJIRniCitbaHzqNimmCDsG5aalCE=;
 b=L3b/hfnvMk19JLp6msLH6CXAkqhyObxSaCibMl5abMqXXTb+/JJLkM/lpcIsQ45Ym5JL
 72cZzXt9TKqpu6xUVcKEd3x+LWrU+KKQ5TOdgXmN1dG9z9lktQHwVoqlDWiyqDiZPfbvx
 evmH1EDEx0/fcFNx956CJHM7oIHV/nOnyGAt2jZjCj6avQBhqRSduUlodIKhCwjMjrWl0
 8kjL7kDBexhI8D9e0/cmGVlJpa1NkqZ8jUTmRnIm8XKbMy4CjJJ/UszFR27WWEcJFHb/y
 QhpbaCrzrBXsxQQap8TRLLn068Hhj5ekMCk5mrbtjh4ywOUKyASxZx994q6aC0q1qGQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=riscstar.com; 
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=G6PVmfpN; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::636"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=G6PVmfpN
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 135F781110
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 09:15:20 +0000 (UTC)
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2d942c7cc2fso14368785ad.3
 for <u-boot@lists.u-boot-project.org>; Sat, 05 Sep 2026 02:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788599720; x=1789204520;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pb92asXeCbFivAkLJIRniCitbaHzqNimmCDsG5aalCE=;
 b=G6PVmfpNd2chd2WWQrCXQ1i5wk35Zpny+70vEwt1zHFfJ/FA+HWq+cE8Nk/8loOSNs
 nb97g0+3u2ycVc9zl2Z42fAyY+53RrrgO5Ph3WKWkGxrzy/JL/WXkxx0WK3+HBeAtf0x
 8Co34wYRc3x8PLBq0Nw1m4BzmjKjrhfLgXSIJGImDEEdjQFeOiTsZ4MfxeEOQLMtWfZf
 fsjT3Z9hNxLXMeKWpYGsU+A5xqUZITEjBm86/hM5vg235npKHNr5K8QgK5aDInzwLTi2
 Ai67jpvRO4Bb8y1LbsxqxK1t2VXBEEIMOmBajSR/kKYYLfOGYWz0jlV1rueHftGdy+Kf
 73zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788599720; x=1789204520;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pb92asXeCbFivAkLJIRniCitbaHzqNimmCDsG5aalCE=;
 b=M/FNWZ769ISWAW9aAgEwbwuGNBv4479An934T/Jm6FwEE7V2D931d8+r6XdxhJRhYd
 a4AOZlh7NxhZ0tE8TAKawvfU2xCM7+qE4r1lW3BPLFnkW68N5ygISvtznNvcyVIwGEYv
 TQY2GuT5DAF5WWrUbuyIEwsjDZ4AmWX5me0xrCXr0fLqrPM62wBupv5taMBDe4wGCUTa
 YBdPysGzSdREgyKrSXUQROa3G8U9xX5Z7kAJNmj67Lk3LzWljWWgBciIrscqVjevSIXE
 oRVCPakoSz5BznS5gCpmUd9XKeqpBDmFOapCpRKeCRdqCQ9SCHBIZ6w5tBPY6sENrYmT
 G07A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzPsq9mvGsb6g+SuimDMBYb8efNG+cLiRtOaSRH7gfuZZPY/DIr+m1uIO3qSaKgFdpmnxjAEhY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++k3Ko7IC3FMnwYPhECh/bPU6bjGlSBTLEb0E/NzThnl0HMQlawm
 MxY8Tn3jk9fwy0gnwVBSt+PnYmDYnKuejzyOi+MPxVJDPqhY0vsS9mnCjx9CYk2lmlA=
X-Gm-Gg: AYBFou2+5FF4ypFLE/GqDJceFITTl5JhQI05h/rJ7Onuo0SqV+ltX37n+SoVFk/jrul
 1G6yWAmAl2c7oJsXsCNhVAiPaq8ZCiEsJa1IjyQtfihwLwd1293A+4j2NpXsLFgtjFkodmdtXCR
 wasrUFn2By3eNNS1qRhSrWkSvB2pI7W0acsl2Ayh6iXTsnkUTAZ33ZsKpf2ACgAzRxM6P4LX61x
 hpZn8bjGXcZnWkD4zGc/JmgADykH8vAOfNdSEsrAyXzSRMLi+AJoTtJzwf5Fd5JwUMgVkU/TyIz
 bPQbtrw2ruAmyLhA7jyw2NApKbe/cb/KC5iuC/5mBv3DGdNpnVOjtZuhMgNLW53zT4L2+IzzQP5
 nr+tcoSPTybNSJqz9X2yYRw31QwQhJK4EGDrp3IUX70cZ3yL4B4/N7JaRbdUz72qijFFodt5IXS
 ButIg335t9vtjbvu1xY59k2MvKuBjA05UcTILMK1ujSrN+2zdeJD8ldQNXRrujg+Ws0WOIld9pN
 nclDGIIY4BBnvkxMR2IvW2ypEyc0kDsOgax5XTlZnq9r669A4iLCduC3yqXDclQCB1NoqZO1eZD
 f1jgx04jhPviwvocz2kEWpl5+Q==
X-Received: by 2002:a17:902:cf08:b0:2da:f8a5:afd8 with SMTP id
 d9443c01a7336-2db1220e898mr164434475ad.0.1788599720108; 
 Sat, 05 Sep 2026 02:15:20 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339aa37dbdsm10991553eec.11.2026.09.05.02.15.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 02:15:19 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sat, 05 Sep 2026 17:13:29 +0800
Subject: [PATCH v11 16/17] doc: spacemit: flash on K1 SoC based boards
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260905-m4-v11-16-235eacd94fe0@riscstar.com>
References: <20260905-m4-v11-0-235eacd94fe0@riscstar.com>
In-Reply-To: <20260905-m4-v11-0-235eacd94fe0@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>, 
 Wei Fu <wefu@redhat.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Yixun Lan <dlan@kernel.org>, Iker Pedrosa <ikerpedrosam@gmail.com>, 
 Alex Elder <elder@riscstar.com>, Andre Heider <a.heider@gmail.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>, 
 Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
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

Add document on how to flash images into eMMC of K1 SoC based boards.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>

---
v9:
- Add to generate the partition table of SD card.
v3:
- Add document on how to flash images into SD card.
---
 board/spacemit/k1/MAINTAINERS |   2 +-
 doc/board/spacemit/index.rst  |   1 +
 doc/board/spacemit/k1-mmc.rst | 271 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 273 insertions(+), 1 deletion(-)

diff --git a/board/spacemit/k1/MAINTAINERS b/board/spacemit/k1/MAINTAINERS
index 4b2bc4ecfc10..e12288a206e0 100644
--- a/board/spacemit/k1/MAINTAINERS
+++ b/board/spacemit/k1/MAINTAINERS
@@ -6,7 +6,7 @@ S:	Maintained
 F:	arch/riscv/dts/k1-*-u-boot.dtsi
 F:	board/spacemit/k1/
 F:	configs/spacemit_k1_defconfig
-F:	doc/board/spacemit/bananapi-f3.rst
+F:	doc/board/spacemit/
 F:	drivers/gpio/spacemit_gpio.c
 F:	drivers/i2c/k1_i2c.c
 F:	drivers/mmc/spacemit_sdhci.c
diff --git a/doc/board/spacemit/index.rst b/doc/board/spacemit/index.rst
index a5e35ee12ab6..71854e5735bd 100644
--- a/doc/board/spacemit/index.rst
+++ b/doc/board/spacemit/index.rst
@@ -6,5 +6,6 @@ SpacemiT
    :maxdepth: 1
 
    bananapi-f3
+   k1-mmc
    k1-spl
 
diff --git a/doc/board/spacemit/k1-mmc.rst b/doc/board/spacemit/k1-mmc.rst
new file mode 100644
index 000000000000..0be5d5fa1c39
--- /dev/null
+++ b/doc/board/spacemit/k1-mmc.rst
@@ -0,0 +1,271 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+SpacemiT K1 eMMC and SD Card Boot Guide
+=======================================
+
+This guide covers two separate methods for booting and flashing U-Boot on
+SpacemiT K1 based boards:
+
+1. **eMMC Flash**: Flashing U-Boot and SPL images to eMMC via USB fastboot.
+2. **SD Card Boot**: Creating a bootable Bianbu SD card and optionally
+   replacing U-Boot on the card.
+
+Tested boards: Banana Pi BPI-F3, MusePi Pro.
+
+
+Chapter 1: eMMC Flash (U-Boot via USB Fastboot)
+===============================================
+
+SpacemiT K1 U-Boot Flash Guide
+==============================
+
+This guide explains how to flash U-Boot on SpacemiT K1 based boards. It covers
+flashing images via USB fastboot.
+
+.. note::
+
+   This procedure flashes images to eMMC over USB fastboot. The fastboot
+   function is not enabled in our SPL yet, so the download stage runs the
+   SpacemiT released SPL; our built FSBL.bin and fit.itb are the images
+   written to eMMC and used on the next normal boot.
+
+Prerequisites
+~~~~~~~~~~~~~
+
+- A SpacemiT K1 board with USB Type-C and UART access
+- USB-to-UART adapter (3.3V TTL)
+- ``minicom`` or equivalent serial terminal, configured at 115200 8N1
+- ``fastboot`` and ``flashserver`` tool on the host
+
+Hardware Setup
+~~~~~~~~~~~~~~
+
+Refer to k1-spl.rst.
+
+Flash images on eMMC
+~~~~~~~~~~~~~~~~~~~~
+
+**1. Obtain the release images**
+
+Get the release package from Spacemit website. It contains SPL image, and so on.
+
+https://archive.spacemit.com/image/k1/version/bianbu/v2.3.3/Bianbu-Minimal-K1-V2.3.3-20260128183217.zip
+
+Unzip images and store them into a directory.
+
+**2. Obtain flashserver tool**
+
+Get ``flashserver`` from Spacemit website.
+
+.. code-block:: bash
+
+    $wget https://cdn-resource.spacemit.com/file/flash/flashserver
+    $chmod +x flashserver
+    $mv flashserver {flash image path}/
+
+**3. Copy built SPL and U-Boot images**
+
+Build U-Boot as mentioned in k1-spl.rst. Create a new directory to save.
+The official u-boot.itb is used to download images. So the built U-Boot should
+not replace the official one.
+
+.. code-block:: bash
+
+    $mkdir {flash image path}/build
+    $cd {flash image path}
+    $ln -sf {path to FSBL.bin} ./build/
+    $ln -sf {path to u-boot.itb} ./build/fit.itb
+
+``{path to FSBL.bin}`` is the signed FSBL produced by ``fsbl.sh`` in
+k1-spl.rst, e.g. ``~/uboot-2022.10/spl_bin/FSBL.bin``.
+``{path to u-boot.itb}`` is the U-Boot build output, e.g.
+``~/u-boot/u-boot.itb``.
+
+**4. Update configuration files**
+
+The ``partition_2M.json`` and ``partition_universal.json`` files come from
+the release package. Patch the ``fsbl`` and ``uboot`` entries to point at
+the images staged under ``build/`` (pick the layout that matches your eMMC):
+
+.. code-block:: diff
+
+   diff -puNr bianbu-25/partition_2M.json clean/partition_2M.json
+   --- bianbu-25/partition_2M.json	2026-03-02 11:55:58.631116807 +0800
+   +++ clean/partition_2M.json	2026-05-20 11:25:21.683801401 +0800
+   @@ -13,7 +13,7 @@
+          "name": "fsbl",
+          "offset": "128K",
+          "size": "256K",
+   -      "image": "factory/FSBL.bin"
+   +      "image": "build/FSBL.bin"
+        },
+        {
+          "name": "env",
+   @@ -31,7 +31,7 @@
+          "name": "uboot",
+          "offset": "640K",
+          "size": "-",
+   -      "image": "u-boot.itb"
+   +      "image": "build/fit.itb"
+        }
+      ]
+    }
+   diff -puNr bianbu-25/partition_universal.json clean/partition_universal.json
+   --- bianbu-25/partition_universal.json	2026-03-02 11:55:58.642116862 +0800
+   +++ clean/partition_universal.json	2026-05-20 11:26:23.932581853 +0800
+   @@ -14,7 +14,7 @@
+               "name": "fsbl",
+               "offset": "128K",
+               "size": "256K",
+   -            "image": "factory/FSBL.bin"
+   +            "image": "build/FSBL.bin"
+           },
+           {
+               "name": "env",
+   @@ -32,7 +32,7 @@
+               "name": "uboot",
+               "offset": "2M",
+               "size": "2M",
+   -            "image": "u-boot.itb"
+   +            "image": "build/fit.itb"
+           },
+           {
+               "name": "bootfs",
+
+Deploying via USB Fastboot
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+To enter BootROM fastboot mode:
+
+1. Power off the board by unplugging its power supply.
+2. **Press and hold** the FDL button (called "Boot Key" on some boards;
+   see the board layout above for the BPI-F3).
+3. While holding the button, use a USB cable to connect the OTG port to
+   your host. This cable is also used by fastboot to upload the firmware.
+4. Release the button.
+
+On the host, ``fastboot devices`` should list the board::
+
+    dfu-device     DFU download
+
+The serial console shows the BootROM's USB download handler trace,
+including a line like::
+
+    usb2d_initialize : enter
+
+This indicates the board is ready to accept an image via USB.
+
+.. tip::
+
+   If you are worried about insufficient USB power, you can first plug
+   in the power, then release the button, and then plug in the USB
+   cable.
+
+On the host:
+
+.. code-block:: console
+
+    $sudo ./flashserver
+
+When ``flashserver`` is running, it lists the detected fastboot devices.
+Enter the corresponding number to select one.
+
+
+Chapter 2: SD Card Boot
+=======================
+
+
+SpacemiT K1 Bianbu SD Card Image Flashing and U-Boot Update Guide
+==================================================================
+
+This guide explains how to prepare a bootable SD card with Bianbu OS for
+SpacemiT K1 based boards and how to replace the U-Boot binary on the SD
+card with a custom build.
+
+Prerequisites
+~~~~~~~~~~~~~
+
+- A SpacemiT K1 based development board
+- A microSD card (at least 4GB capacity recommended)
+- A card reader for your host computer
+- A Linux host system (for ``dd``, ``sgdisk``, ``lsblk`` commands)
+- The Bianbu release package from
+  <https://archive.spacemit.com/image/k1/version/bianbu/v2.3.3/Bianbu-Minimal-K1-V2.3.3-20260128183217.zip>
+- A custom ``FSBL.bin`` and ``u-boot.itb`` file to be written to the U-Boot
+  partition
+
+Prepare the SD Card & the image
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+**1. Obtain the release images**
+
+Unpack the release package to get the image files. Replace the ``FSBL.bin``
+and ``u-boot.itb`` with your custom builds.
+
+**2. Identify the SD card device**
+
+Insert the microSD card into your card reader, then run:
+
+.. code-block:: console
+
+   $ lsblk
+
+Compare the output before and after inserting the card to identify
+the new device. It will typically appear as ``/dev/sdb``, ``/dev/sdc``,
+or ``/dev/mmcblk0``.
+
+**3. Write the image to the SD card**
+
+Run ``sgdisk`` to generate the partition table, then use ``dd`` to write
+the images to the corresponding partitions.
+
+.. code-block:: console
+
+    $sudo sgdisk -o /dev/sdb
+    $sudo sgdisk -a 128 \
+        -n 1:256:767 -t 1:8300 \
+        -n 2:768:895 -t 2:8300 \
+        -n 3:2048:4095 -t 3:8300 \
+        -n 4:4096:8191 -t 4:8300 \
+        -n 5:8192:532479 -t 5:8300 \
+        -n 6:532480:4726783 -t 6:8300 \
+        /dev/sdb
+    $sudo dd if=FSBL.bin of=/dev/sdb1 bs=512 seek=0 status=progress
+    $sudo dd if=env.bin of=/dev/sdb2 bs=512 seek=0 status=progress
+    $sudo dd if=fw_dynamic.itb of=/dev/sdb3 bs=512 seek=0 status=progress
+    $sudo dd if=u-boot.itb of=/dev/sdb4 bs=512 seek=0 status=progress
+    $sudo dd if=bootfs.img of=/dev/sdb5 bs=1M status=progress
+    $sudo dd if=rootfs.ext4 of=/dev/sdb6 bs=1M status=progress
+
+The SD card is now ready as a bootable system disk.
+
+Understanding the SD Card Partition Layout
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The role of each partition:
+
++----------+----------+------------------------------------+
+| Partition| Size     | Purpose                            |
++==========+==========+====================================+
+| ``sdb1`` | 256 KB   | FSBL (First Stage Bootloader)      |
++----------+----------+------------------------------------+
+| ``sdb2`` | 64 KB    | ENV                                |
++----------+----------+------------------------------------+
+| ``sdb3`` | 1 MB     | OpenSBI                            |
++----------+----------+------------------------------------+
+| ``sdb4`` | 2 MB     | U-Boot binary (``u-boot.itb``)     |
++----------+----------+------------------------------------+
+| ``sdb5`` | 256 MB   | Boot partition (kernel)            |
++----------+----------+------------------------------------+
+| ``sdb6`` | 2 GB     | Root filesystem (ext4)             |
++----------+----------+------------------------------------+
+
+
+Booting and Testing
+~~~~~~~~~~~~~~~~~~~
+
+Insert the SD card into the development board, connect the serial
+console (115200 8N1), and power on the board.
+
+- If the board boots successfully, the new device tree or U-Boot image
+  is compatible with your hardware.

-- 
2.51.0

