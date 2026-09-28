Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC0ECA5FA6
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 13:42:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6DFD980EC0;
	Mon, 28 Sep 2026 13:42:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UA-N4TUFwgi4; Mon, 28 Sep 2026 13:42:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8B47B80E5E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790602929;
	b=djA/f7j/0jS2W1lI9EoMivmbjVr3Xz6FaHMhpo1DBD8naWi4TpCIuSVtkvFQHgjhNWK0
	 g8IXUOJuDBFjyCxFuOxjHq7Js0DbXaDrJso6jppgILtVH0W2VXmopfA654VggnNlNy+Y9
	 yeCQU3p2sjKY5qEOuXqDRj5NkLLMgUWlwvdOp4A4kC3gnP9CNx4lvHq8XLSemuA23ILft
	 F9sKX1AsXhbWWRneLBKHfF/bX/8G8JNsWylzfzkdoSVUv4zarBRIReyALG9QOQ/R6KBbr
	 fOOGOlYc2mF1mKFrdKXskQUdi/WuQUewOrSsYVG3aBaPametaJl3Hc+riXiYw59MWlg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790602929;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=PqAAHuyi5NfDzjucP/fCjlNX34MT77+69ujZytCZFVs=;
	b=tQ0plD56dOHclX0LKSsw3BGxakOOcPAR+9EfcMLa1pQeo4ZFW8zb6h8/dIEy1O6BiMm/
	 VyGkvpDKbfsxgpOsLK0CVzocVQ+L75aw82TuetuK+hMgcn0VJ7+8PcfeTQXRjvN5hDDkb
	 81WMJmUGwEJjBK88192FILyRJ7tuxUQqgDXnOJCGoPye9Na3b9rS/3lEMlTBwrk1ZCSPu
	 DvtxYh5SP8+TJj6VVjxrbv9g4rLoRWnQW0Zis53Zp3B8j2uPEc3GDObBpboDm29FBJaz/
	 lz086ci1bxGFD+cXKSD1NffLahGVI8MgZGnzVS/JhKTkc/blSYEtgPvQo5y6x0fRjUw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790602929;
	bh=PqAAHuyi5NfDzjucP/fCjlNX34MT77+69ujZytCZFVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eJU1t1/f5jr5TpnYgxQ6um4xV1j41prLd39uLW2TAwQAqxGtabY7QHtPfEdjZJtOd
	 VmjfP9WpDME/B3TaTn3bn0pR2WoGgceRbE/t0xYaqWHY8Xw63Ngd9zH5Yw5SbXTEY7
	 jqPZ07GHJQ2svDSlsJcnKaJ+S/iK5imIlJS+lgsRAsOznaKsA2+JCdLzWKBlWPd7iy
	 /ERxcOkzLwDkvvl5PtSKHvSMWPQKDhTwxqRCCqfnOMhITjqSrrdVAmNB/GEM8XZIQb
	 wv8VlXlaCitqQ/p8m01P9DI5S71KWseneJbj9e0uEU5k8cFGmoVkyll2F2UYpuKyQp
	 W+1Sl2+50ZN0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8B47B80E5E;
	Mon, 28 Sep 2026 13:42:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 63F68335
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 08:38:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 55BA440649
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 08:38:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sKzGVUzBdune for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 08:38:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5601F4061D
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790584713;
 b=pcSPOOyfX2vFUIRG+ndHrg+wvJmOmYNY6b6qEK4UZtwYfurnDfIB8QdMtHg7eL/C7GN6
 WPTnJY3WexbnqA/BZoEFofySGkq9cqIZP/Mc7/rIiP28rNWGP6hgzwhn744oPNHp1bqv/
 wKzdQ0xwRdrzWHVs1RRhN8MKFfnal8hII1TemkvWX2px+wG7/51LUpYXIb4XBuBSoKfwa
 t+dmY8E/Ex8Ml4FIJk/G1p+gxvbXggsknBxUrhxuYNzLgcH3LBEUglKQ0Uo7uC85a7hLE
 YWNCy4pJ7U62PgEzMVvypVDE8BxEz+2u8/zVO7Tdf6z78G901O9Oiz1gpb3cHtO841g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790584713;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=PqAAHuyi5NfDzjucP/fCjlNX34MT77+69ujZytCZFVs=;
 b=gWaIhaj5DTKe9ygbCQnx43S9beMYdHh4dFgaRFjIG6RMSfkEQ+ExZUCizByTJb1P02G/
 9dzRUD4d7O86nPfS4An8IgYA1JCtG/dDdW7LIJnVPLrte3i6ZbV3h2yCLEkpQcOsY5eVb
 WY5fxgFaYh8CMoaO7RVWiNrzC4tcmPbUYw2Zaz969wSl2ik5Q2GF+el2luqVwSE6xRl/G
 ITehNbAmFIvWzaXFs9fxBoKFPaihGv8yKNIfrNh8VHl+j2MThSGMf16uZ9aH2HMzALRU2
 AS3+nkvJ+sZ9kbGyU2e7vdViLC6mB/Yqg1ODs+gex/xI2SD34CtiVgjvxK/XupbfWWQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Z2benpO7; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Z2benpO7
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5601F4061D
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 08:38:32 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49fff72474fso6807365e9.3
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 01:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790584711; x=1791189511;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PqAAHuyi5NfDzjucP/fCjlNX34MT77+69ujZytCZFVs=;
 b=Z2benpO7/TbFYHAfs1hgjnrqMaCFR9FnzJgKmAr+hSkEhy6qjp1ctKnrU3TfKKQR8x
 yLynkj6N65829waSSEKWbB/jk+/jNcKsNvm8O+YbeBsDYlC7+c5yW5XEOID51xr9ARIF
 8Oj6JT/D+zdtsRRa2fBXmpMevREzDl7klbWdw3zC49uNzRfmxr1T7z43BAR3kIUcUtZ4
 S2Igporc1xvQ+sb15YCxnFZeinrhu+kzsNLxcM3wuzj33G3YW/r/dAjGTOjjz5VT0OgP
 y5OmwEdL29GN6J9DstG9JyGwtjCFGD95c1fu7cwU0SRiMmvBN298oP4V0mzFtIHFpGBX
 ukyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790584711; x=1791189511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PqAAHuyi5NfDzjucP/fCjlNX34MT77+69ujZytCZFVs=;
 b=NSb7o9Ah+qpaI6DMCD+TGDTPNK3NqRA7SHUZGQncsdlSHW4WpRwIxP7gbr5p77jlUZ
 K0sxogqL0Ud7i4n8NlmQBdrkDppgb5z32Ae2ZMJkUv5wFLFcjOLrc0MiVdd3jmma/xdL
 g+njYYlTROxZP7pMykExdFyYeLLz4erNk7ZqWuD+G3fF0mPbaBRylaUJMHy3+Ft/La7d
 Wd3Z+Gm9d1SWuFjcg8cfJ9OjEgmFpdY7BWGMgQyJdB7cHlE1CEzEu6k0aqRQAuZ9huJh
 L9Gc9gHFGfoJdF1wQD0VtMcVf+K7tvRscy0v6mPVvQI8epEYUYyV8cNKlhAUdEAUca1O
 55FQ==
X-Gm-Message-State: AFuF++laHkeLzmpoM0rTcGjX41+4bQkY6aAL2ClahYxCGiCUdd4LccOP
 uDP/e1sdjGmb8YULFmydPD/JZZf8X4BRk7rMLdrSWefeFQ1QZ4OQgsCvqfqRbAd1zQL1fg==
X-Gm-Gg: AYBFou3M+JS3clu8w7dUqIxwxhUhRMTmViR5oTGdni1nJWtj18oGIsDRR9W+xxfeIlZ
 NjP/oYUEKMi7cENWgIDEZWsd8KVNF3HWr31AmJVhBB+RNuYYtzuK2a/JoPLL77jBbREMHayXg8j
 0W4Y3C0s7jT6gpvOf6+3ugUGtpi2mtmA57PKkY2MeV5X9njmE6DX+W03D8G+8c2hiwQ4pdPpboD
 N2s6VxAxEu1zlpFJPGBpzsC8YRiVftyeVsgVJ+vgjjiP6whv2q9ZNNkZGwdYEGE12miXie331VJ
 SluEUMMKsaIGY4A83XgxKjdxSIpck/SDvxsiz+j6/6oLg33NL5p+JcnnmV+GgJ5SedayKpYbSwB
 CI/SlfYxF1/7Vsn8aOyX0gD7KegsaxuzrL/cjoZcato9fsESZCpxJShkJ5lMG47tLrC9uueOP26
 rDA40TEd4zVAqpi/EbjKHSXEyL1SFvxeX4D4BgOYrysMZea/7BnQeLvzLuo1j8GY1o7zd3KlwHO
 lxnPM3igTM3guq88jI1s4s4PT+9XOGFWJ1fCelnCLzB7BFG/gl4Qsyr7rcwZ0jOSP4/x+qD47aV
 c2tkPGiDI/5pQcu7Jms2pXPRndr8UAS3u4yTgUs6rWG7CEJ728TL4bqdmN2QpNWDGas17Sl5Tdp
 isVnocUwoyfzahclbvEbehg==
X-Received: by 2002:a05:600c:3b85:b0:49f:ffc7:2099 with SMTP id
 5b1f17b1804b1-4a00071552fmr80183745e9.26.1790584710829; 
 Mon, 28 Sep 2026 01:38:30 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a00-1028-c000-0ddf-e9a2-82c8-47dc-7bbb.ipv6.o2.cz.
 [2a00:1028:c000:ddf:e9a2:82c8:47dc:7bbb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00179c729sm191700405e9.15.2026.09.28.01.38.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 28 Sep 2026 01:38:30 -0700 (PDT)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Peng Fan <peng.fan@nxp.com>,
 =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
 Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?J=2E=20Neusch=C3=A4fer?= <j.ne@posteo.net>,
 Priyanka Jain <priyanka.jain@nxp.com>, Heiko Schocher <hs@nabladev.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Christophe Leroy <chleroy@kernel.org>
Subject: [PATCH 3/3] board: cssi: Move alignment padding into __u_boot_list
 section
Date: Mon, 28 Sep 2026 10:38:20 +0200
Message-ID: <20260928083820.62352-4-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260928083820.62352-1-pepe.schlehofer@gmail.com>
References: <20260928083820.62352-1-pepe.schlehofer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Sep 2026 13:41:44 +0000
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

The MCR3000 and CMPC885 linker scripts align _end outside the last
output section, so the appended device tree can start 4 bytes before
_end, where fdtdec_setup() does not find it.

Move the alignment into __u_boot_list, the last output section with
content.

Build tested.

Fixes: 87d3780ebc24 ("powerpc: Update linker scripts to ensure appended device tree is aligned")
Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 board/cssi/cmpc885/u-boot.lds | 2 +-
 board/cssi/mcr3000/u-boot.lds | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/cssi/cmpc885/u-boot.lds b/board/cssi/cmpc885/u-boot.lds
index da9cff64d46..2c0d9eb0594 100644
--- a/board/cssi/cmpc885/u-boot.lds
+++ b/board/cssi/cmpc885/u-boot.lds
@@ -61,6 +61,7 @@ SECTIONS
 	. = ALIGN(4);
 	__u_boot_list : {
 		KEEP(*(SORT(__u_boot_list*)));
+		. = ALIGN(8);
 	}
 
 	. = .;
@@ -72,7 +73,6 @@ SECTIONS
 	 * _end - This is end of u-boot.bin image.
 	 * dtb will be appended here to make u-boot-dtb.bin
 	 */
-	. = ALIGN(8);
 	_end = .;
 
 	. = ALIGN(4096);
diff --git a/board/cssi/mcr3000/u-boot.lds b/board/cssi/mcr3000/u-boot.lds
index 1fd98726b2a..acf34ecadfd 100644
--- a/board/cssi/mcr3000/u-boot.lds
+++ b/board/cssi/mcr3000/u-boot.lds
@@ -61,6 +61,7 @@ SECTIONS
 	. = ALIGN(4);
 	__u_boot_list : {
 		KEEP(*(SORT(__u_boot_list*)));
+		. = ALIGN(8);
 	}
 
 	. = .;
@@ -72,7 +73,6 @@ SECTIONS
 	 * _end - This is end of u-boot.bin image.
 	 * dtb will be appended here to make u-boot-dtb.bin
 	 */
-	. = ALIGN(8);
 	_end = .;
 
 	. = ALIGN(4096);
-- 
2.54.0 (Apple Git-157)

