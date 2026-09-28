Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC524CA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 13:42:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ACAF680E04;
	Mon, 28 Sep 2026 13:42:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rCuINszdsBL4; Mon, 28 Sep 2026 13:42:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1768780EED
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790602945;
	b=Sp9oYzr7D2x/S+TXZfnRfcrBitdNXsxWPKhxn/o2T83MmRx5JRzqm1Q0IL2WVbHu4pIk
	 TWqK5KXOjl35787sRS4z5SGGesCOr+/dmOmy5th/XntRrXzNP9OZUi7sHWy2kED0/XmBI
	 ShvA4eXT86bZlwgkaLuVKMMnTTmoBeFkzP7QjDhvDUWpl3Zv8Ikcb0T5m/6fQjXn6auJn
	 4cuiVkzmIIdGOero9NvpUOqGJW/1/EPaYbk+CFvOeOQsvmVvk+ZaKgVHzoD3bNz1auFd0
	 Uwu1STsRR9gLj+bpaS2fysMTYIFVfkYbJWH/jscOdxuxcI/R5DKUlT6rVys7zO+DKBA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790602945;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=J+X0Rn5OZzD7zXYXxltsKGKT1hmLCl8eYgttWLnBtcE=;
	b=iyGHJnK32cprGQEHdUMBlJq69k1YySyXs9BbbuX80dmBFtI5PHjyjYseE8Te08XkYeXi
	 uhpWDZw+0dZlo8AIrsYoRWDMQpUDXJ3XObMN+iyIuIPzDBe9j1uiJYhkVtiYoWh2xqoQf
	 tLrrGM2vwEQ3SgatkTSxKcXkVPHxf3KXPgFtiNWr154X0ht2i1SvwzH67t7/pJ1hWaKy1
	 ywe1Ipsr1BDBfWm1W8h5xCo9QEMW9kWjmtsmJ57iKJxHtdX/DTyztM15Tewt6xQSca9t6
	 GWWja4TUyj4Oe/AoXAw3SCD48YyIgPiRGOo4lUmTk+heZSj5zWDu715usbNtKxtmFUg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790602945;
	bh=J+X0Rn5OZzD7zXYXxltsKGKT1hmLCl8eYgttWLnBtcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X+n/hWivu49OIy0nMqYj5I6WvaiYnLxUU6kwfgV7kdjinEVUMyMK//KP/s6MvTfdi
	 UhMIR9myzfWDK5cmA0lFyOnmLoaY4JhmOuv0Cd5nDmpoIMNASjheKjrW67PQHHDljL
	 UaixIiIgNBB2aAwmKJhNcvGi8XRYVwmQMH4nLswVSExxmnnnBSHs+/kli/m8qR6GTw
	 ksz2ShH0kzRv62cyRs6J53NUzdWnMHJQ7HaGTS5hUYAyLEZrxVoROOmVHSdOBfACRK
	 oo0QSqNBFjBomuRA38Qh6NEdLLa50+Hoo5a3I7G3tCItIQuQUhGNkdHFbmW65wJKL2
	 uC/boPhpa2R0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1768780EED;
	Mon, 28 Sep 2026 13:42:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BAAE0194
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:05:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AC0964019A
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:05:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JVwogYTUmGCa for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 11:05:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org D0DC640063
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790593506;
 b=eWHPvklUC2Z/SjHjWfFt/DMY1Qhy1byGqpaMDT1TmC6swdTvEcSOCDRX5XWF/zNmawRM
 vh8rKFoMksFrzrYmDXdk6+NHk/IprRA8eHRcT1zI/ObY3lU28bS3hn4LEk1vKN7NYaIXX
 ZymVXRVudsxo8AR86C5gzodSYf8r3Uo2mYXJJREqdzYwvHjEA4V+i17Mkmdht6fS/JwnQ
 QB6nKa/xDwKR2O9FLLRLQknsdEzC7aj13+PXVrDTjYXpLEF9uBMNMW89Ec7Ymi0anp5a5
 Ruh0MqklDo2UBTNGACypA0OLD2HvjeMNsikFPRpqCsfVLtDq+kCDKgtxA8tHtUyqdEQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790593506;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=J+X0Rn5OZzD7zXYXxltsKGKT1hmLCl8eYgttWLnBtcE=;
 b=LHlM5EJ/OGkgKG8o8Zf7uhYW8J0z43fqCoPJwtFIyceRhyVT+Nf6sXDbWXZYtlmog4nS
 jvclNkXnYMFt6Ycb8+Xe8RpjiykLKWfZUQ5Ltidj5wzRoFX7LJkWVNnnFVQhz44OEeO4T
 uDXIsau3wU7AriQaTdQww0KoPaZjpkrdON1YRJ0rCWeJejAXNpQ6obNQPjRS/Qol3BJZu
 KCAemNNy5GHvJ0J2Yupt4N2Ko9yGAV8dhbZPWVRlEawhSAxj04e3/Q5RR97kB4qeNtON/
 804wvziCrIQHsgJg0L4oDNzfXuEOU2uQc9DDBmfu/gce9abh3J9daZEI7rGQnYSt0tw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=nUVPRdwt; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=nUVPRdwt
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D0DC640063
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:05:05 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ff23af865so22429285e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 04:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790593503; x=1791198303;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=J+X0Rn5OZzD7zXYXxltsKGKT1hmLCl8eYgttWLnBtcE=;
 b=nUVPRdwt5zSRQ4VPfWiv+U749WZFrG6VlAdzIj6JQH2KiX0fE0ZHecnL+o4bUW2YEa
 oTDaSZlqUiDMTMw8DQRd4hCh1i7zf3Fx5jSH5Oy7hUdBDUsnUpjuoDWUyKODU/s0GnxV
 5+bzJMIPVYqFIg9l34em0kXG2lk4U9exNMt+OpmIF6XxCvc4dlCBeothcFOBHBfri7Rz
 Ii7hnKcGtZfx9H/YXfWDDKSzMf41rOgMdwkGK8i7Y57DhZHeOiaMVsFc2ECdOUWtpaFG
 VZsInArH+dR9PJl1DF4Qw41gNpOlGpXufLI1FzDIvawEYYngbvWjcJKIB+a14gtV/oku
 eMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790593503; x=1791198303;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J+X0Rn5OZzD7zXYXxltsKGKT1hmLCl8eYgttWLnBtcE=;
 b=dExTcZeGENzf+YfgQOCKB6vsOYTg6ooovrf8IkHeMh8j2DY5FSEP6a5m46PKi9qREN
 fz3tgrmoNyhXMXrNyd6JeaElPFrPyVqxKfHhHTgURE2UZdamn55R+TdhyJHpSW/q1DNk
 ChaXvSjAV+PKsKvS79vpfupBPWNRxYwBZfGeDb6PaYHJsb4jBZ+d3WznuhGWUxXvxwxi
 UKHW2zp2PFdboh8ZHRHwyy3po0aUgAJZxedSTTO0j75HJ4KIH4h/euRJRMVVVgbu840m
 u+anORIYUsb9RNIdaInTkMU6SL6E3yqBHYnxvLEgxInMAL4rU3PLClVbudI0a0nxuJfQ
 7EQQ==
X-Gm-Message-State: AFuF++nF7lyUkkk7QF4oo+EtxNQCZukoEQWJXB4dAPAnyy3Ghsm3UhR5
 X5QvY+DvkPoKcecMAS7dmaw0Fol+jARvGVqpvN9Y+GFyN0/9CQDJNbO41Bt3220BUc4=
X-Gm-Gg: AYBFou25C0IrDtxLDfQJwjJaaiKHFntBG1MjYB3DpyXaPKncfPCdQwz1n93+PclxbMH
 ms5AtYtHUs+/zByK5bdrEC9Rqfl/R44CYzm7UTheMSNWFUw11u1NZVzq4z56fiZUqSe1+nnJty/
 ZUWfrHymaItuX4Y10Eh5xSlLD3wtPRgVXYArZS2TlndyeH9rclvmmRYlVNu3J46Q+a3hiOPmciP
 G6MUVkSMSu9yMa3LsG2Yq12owoD2AYhtrdapCz4NKcuykSOoJstOyFuQha9LSLp4LbP40kcyhqF
 /HJCP582QcXPJLrTaORHTSkSyH269F2uql8M5An4JrXz/o9C5PFN8qN72gIXxHef2CQZHL7GSBq
 TYkyEjtB//jG1Z9JGI6h4v9b5BaGi9367nSNavKof9njFNbdsbhwRQ94NnHbqMrLWj6QA+xndkl
 giWC2CaYLMsGmkwVfW6zeQCLwqw/6BrIhO/QxVPFikcJq/HzyrXUB12DtkRD1C8Q7DHhl3XMMas
 ZPOINef7hc1S7giB0HDWee9PLruHKELVKD9PEwnyR0B7oPh1JTfMD8bRj10iqofzX66U6fgbdJj
 74A4HCAY4eA0E4HigFpJOw8oZNrNLd8ppVRspBth
X-Received: by 2002:a05:600c:6092:b0:49e:7c4b:1753 with SMTP id
 5b1f17b1804b1-49fe66c6365mr215222405e9.12.1790593503440; 
 Mon, 28 Sep 2026 04:05:03 -0700 (PDT)
Received: from localhost.localdomain (37-188-186-98.red.o2.cz. [37.188.186.98])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0017816efsm131458075e9.9.2026.09.28.04.05.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 28 Sep 2026 04:05:02 -0700 (PDT)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Peng Fan <peng.fan@nxp.com>,
 =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
 Priyanka Jain <priyanka.jain@nxp.com>, Qiang Zhao <qiang.zhao@nxp.com>,
 Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Christophe Leroy <chleroy@kernel.org>, Mario Six <mario.six@gdsys.cc>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Subject: [PATCH next 05/13] powerpc: Make the global data pointer LTO safe
Date: Mon, 28 Sep 2026 13:04:26 +0200
Message-ID: <20260928110434.70686-6-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260928110434.70686-1-pepe.schlehofer@gmail.com>
References: <20260928110434.70686-1-pepe.schlehofer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The register variable form of gd cannot be used with LTO (GCC bug
68384); the LTO link fails with "multiple definition of `r2'". In LTO
builds define gd through inline assembly accessors that read and write
r2, following ARM and RISC-V. Other builds keep the register variable,
and set_gd() assigns it.

Every assignment to gd has to go through set_gd() for that to work, so
convert all PowerPC ones, including those in common code, and give
PowerPC its own arch_setup_gd() in the new arch/powerpc/lib/gd.c
instead of the weak one, which assigns gd. Rename the gd parameter of
the SPL board_init_r() functions, which the gd macro would otherwise
replace.

Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: Marek Behún <kabel@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Mario Six <mario.six@gdsys.cc>
Cc: Priyanka Jain <priyanka.jain@nxp.com>
Cc: Qiang Zhao <qiang.zhao@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Shengzhou Liu <Shengzhou.Liu@nxp.com>
Cc: Marek Mojík <marek.mojik@nic.cz>
---
The mpc83xx and common/spl/spl.c hunks change no build: mpc83xx cannot
enable LTO and no PowerPC board builds common/spl/spl.c. They are
converted so that no PowerPC code assigns gd directly.

checkpatch asks for IS_ENABLED() on the #if lines in common/board_r.c,
common/init/board_init.c and common/spl/spl.c. They choose how gd is
set per architecture: set_gd() exists only on ARM, RISC-V and PowerPC,
so IS_ENABLED() cannot replace them. The new arch/powerpc/lib/gd.c is
covered by the POWERPC entry in MAINTAINERS.
---
 arch/powerpc/cpu/mpc83xx/cpu_init.c       |  3 +--
 arch/powerpc/cpu/mpc83xx/spl_minimal.c    |  3 +--
 arch/powerpc/cpu/mpc85xx/cpu_init_early.c |  3 +--
 arch/powerpc/include/asm/global_data.h    | 30 +++++++++++++++++++++++
 arch/powerpc/lib/Makefile                 |  1 +
 arch/powerpc/lib/gd.c                     | 14 +++++++++++
 board/nxp/p1010rdb/spl_minimal.c          |  2 +-
 board/nxp/p1_p2_rdb_pc/spl_minimal.c      |  2 +-
 board/nxp/t102xrdb/spl.c                  |  4 +--
 board/nxp/t104xrdb/spl.c                  |  4 +--
 board/nxp/t208xqds/spl.c                  |  4 +--
 board/nxp/t208xrdb/spl.c                  |  4 +--
 board/nxp/t4rdb/spl.c                     |  4 +--
 common/board_r.c                          |  2 +-
 common/init/board_init.c                  |  9 ++++---
 common/spl/spl.c                          |  4 ++-
 16 files changed, 69 insertions(+), 24 deletions(-)
 create mode 100644 arch/powerpc/lib/gd.c

diff --git a/arch/powerpc/cpu/mpc83xx/cpu_init.c b/arch/powerpc/cpu/mpc83xx/cpu_init.c
index 340f9a0da56..5618b79a78b 100644
--- a/arch/powerpc/cpu/mpc83xx/cpu_init.c
+++ b/arch/powerpc/cpu/mpc83xx/cpu_init.c
@@ -139,8 +139,7 @@ void cpu_init_f (volatile immap_t * im)
 #endif
 		0;
 
-	/* Pointer is writable since we allocated a register for it */
-	gd = (gd_t *)SYS_INIT_SP_ADDR;
+	set_gd((gd_t *)SYS_INIT_SP_ADDR);
 
 	/* global data region was cleared in start.S */
 
diff --git a/arch/powerpc/cpu/mpc83xx/spl_minimal.c b/arch/powerpc/cpu/mpc83xx/spl_minimal.c
index 7036e3fae0c..1d48428573d 100644
--- a/arch/powerpc/cpu/mpc83xx/spl_minimal.c
+++ b/arch/powerpc/cpu/mpc83xx/spl_minimal.c
@@ -25,8 +25,7 @@ DECLARE_GLOBAL_DATA_PTR;
  */
 void cpu_init_f (volatile immap_t * im)
 {
-	/* Pointer is writable since we allocated a register for it */
-	gd = (gd_t *)SYS_INIT_SP_ADDR;
+	set_gd((gd_t *)SYS_INIT_SP_ADDR);
 
 	/* global data region was cleared in start.S */
 
diff --git a/arch/powerpc/cpu/mpc85xx/cpu_init_early.c b/arch/powerpc/cpu/mpc85xx/cpu_init_early.c
index 75bfc07fe97..fb3d662c9d3 100644
--- a/arch/powerpc/cpu/mpc85xx/cpu_init_early.c
+++ b/arch/powerpc/cpu/mpc85xx/cpu_init_early.c
@@ -95,8 +95,7 @@ void cpu_init_early_f(void *fdt)
 	int i;
 #endif
 
-	/* Pointer is writable since we allocated a register for it */
-	gd = (gd_t *)SYS_INIT_SP_ADDR;
+	set_gd((gd_t *)SYS_INIT_SP_ADDR);
 
 	/* gd area was zeroed during startup */
 
diff --git a/arch/powerpc/include/asm/global_data.h b/arch/powerpc/include/asm/global_data.h
index 26cbc7854d9..d8aefd2ca0a 100644
--- a/arch/powerpc/include/asm/global_data.h
+++ b/arch/powerpc/include/asm/global_data.h
@@ -93,8 +93,38 @@ struct arch_global_data {
 
 #include <asm-generic/global_data.h>
 
+#ifdef LTO_ENABLE
+
+#define DECLARE_GLOBAL_DATA_PTR
+#define gd	get_gd()
+
+static inline gd_t *get_gd(void)
+{
+	gd_t *gd_ptr;
+
+	__asm__ volatile("mr %0, 2\n" : "=r" (gd_ptr));
+
+	return gd_ptr;
+}
+
+static inline void set_gd(gd_t *gd_ptr)
+{
+	__asm__ volatile("mr 2, %0\n" : : "r" (gd_ptr));
+}
+
+#else
+
 #define DECLARE_GLOBAL_DATA_PTR     register gd_t *gd asm ("r2")
 
+/*
+ * GCC does not see an asm statement write r2 and assumes that the
+ * register variable is unchanged, so it may move gd accesses across the
+ * write. Assign the variable itself.
+ */
+#define set_gd(gd_ptr)	(gd = (gd_ptr))
+
+#endif
+
 #include <asm/u-boot.h>
 
 #endif /* __ASM_GBL_DATA_H */
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index c0caa703caa..a3048975ae7 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -18,6 +18,7 @@ endif
 endif
 
 obj-y	+= bdinfo.o
+obj-y	+= gd.o
 
 ifdef MINIMAL
 obj-y += cache.o time.o
diff --git a/arch/powerpc/lib/gd.c b/arch/powerpc/lib/gd.c
new file mode 100644
index 00000000000..d36f784fbf7
--- /dev/null
+++ b/arch/powerpc/lib/gd.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Josef Schlehofer <pepe.schlehofer@gmail.com>
+ */
+
+#include <init.h>
+#include <asm/global_data.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+void arch_setup_gd(gd_t *new_gd)
+{
+	set_gd(new_gd);
+}
diff --git a/board/nxp/p1010rdb/spl_minimal.c b/board/nxp/p1010rdb/spl_minimal.c
index 8cd79c6fb5f..33930fef8d9 100644
--- a/board/nxp/p1010rdb/spl_minimal.c
+++ b/board/nxp/p1010rdb/spl_minimal.c
@@ -45,7 +45,7 @@ void board_init_f(ulong bootflag)
 	relocate_code(CONFIG_SPL_RELOC_STACK, 0, CONFIG_SPL_RELOC_TEXT_BASE);
 }
 
-void board_init_r(gd_t *gd, ulong dest_addr)
+void board_init_r(gd_t *dummy, ulong dest_addr)
 {
 	puts("\nSecond program loader running in sram...");
 	nand_boot();
diff --git a/board/nxp/p1_p2_rdb_pc/spl_minimal.c b/board/nxp/p1_p2_rdb_pc/spl_minimal.c
index 511bcf5506b..960b2c41457 100644
--- a/board/nxp/p1_p2_rdb_pc/spl_minimal.c
+++ b/board/nxp/p1_p2_rdb_pc/spl_minimal.c
@@ -43,7 +43,7 @@ void board_init_f(ulong bootflag)
 	relocate_code(CONFIG_SPL_RELOC_STACK, 0, CONFIG_SPL_RELOC_TEXT_BASE);
 }
 
-void board_init_r(gd_t *gd, ulong dest_addr)
+void board_init_r(gd_t *dummy, ulong dest_addr)
 {
 	puts("\nSecond program loader running in sram...");
 	nand_boot();
diff --git a/board/nxp/t102xrdb/spl.c b/board/nxp/t102xrdb/spl.c
index de6cdda194e..f527f62a5dd 100644
--- a/board/nxp/t102xrdb/spl.c
+++ b/board/nxp/t102xrdb/spl.c
@@ -58,7 +58,7 @@ void board_init_f(ulong bootflag)
 	memcpy((void *)CONFIG_SPL_GD_ADDR, (void *)gd, sizeof(gd_t));
 
 	/* Update GD pointer */
-	gd = (gd_t *)(CONFIG_SPL_GD_ADDR);
+	set_gd((gd_t *)(CONFIG_SPL_GD_ADDR));
 
 	console_init_f();
 
@@ -87,7 +87,7 @@ void board_init_f(ulong bootflag)
 	relocate_code(CONFIG_SPL_RELOC_STACK, (gd_t *)CONFIG_SPL_GD_ADDR, 0x0);
 }
 
-void board_init_r(gd_t *gd, ulong dest_addr)
+void board_init_r(gd_t *dummy, ulong dest_addr)
 {
 	struct bd_info *bd;
 
diff --git a/board/nxp/t104xrdb/spl.c b/board/nxp/t104xrdb/spl.c
index e02a1f95d4c..0310baa381c 100644
--- a/board/nxp/t104xrdb/spl.c
+++ b/board/nxp/t104xrdb/spl.c
@@ -55,7 +55,7 @@ void board_init_f(ulong bootflag)
 	memcpy((void *)CONFIG_SPL_GD_ADDR, (void *)gd, sizeof(gd_t));
 
 	/* Update GD pointer */
-	gd = (gd_t *)(CONFIG_SPL_GD_ADDR);
+	set_gd((gd_t *)(CONFIG_SPL_GD_ADDR));
 
 #ifdef CONFIG_DEEP_SLEEP
 	/* disable the console if boot from deep sleep */
@@ -78,7 +78,7 @@ void board_init_f(ulong bootflag)
 	relocate_code(CONFIG_SPL_RELOC_STACK, (gd_t *)CONFIG_SPL_GD_ADDR, 0x0);
 }
 
-void board_init_r(gd_t *gd, ulong dest_addr)
+void board_init_r(gd_t *dummy, ulong dest_addr)
 {
 	struct bd_info *bd;
 
diff --git a/board/nxp/t208xqds/spl.c b/board/nxp/t208xqds/spl.c
index 44ad4e68d9f..f8c641a9c64 100644
--- a/board/nxp/t208xqds/spl.c
+++ b/board/nxp/t208xqds/spl.c
@@ -73,7 +73,7 @@ void board_init_f(ulong bootflag)
 	memcpy((void *)CONFIG_SPL_GD_ADDR, (void *)gd, sizeof(gd_t));
 
 	/* Update GD pointer */
-	gd = (gd_t *)(CONFIG_SPL_GD_ADDR);
+	set_gd((gd_t *)(CONFIG_SPL_GD_ADDR));
 
 	console_init_f();
 
@@ -96,7 +96,7 @@ void board_init_f(ulong bootflag)
 	relocate_code(CONFIG_SPL_RELOC_STACK, (gd_t *)CONFIG_SPL_GD_ADDR, 0x0);
 }
 
-void board_init_r(gd_t *gd, ulong dest_addr)
+void board_init_r(gd_t *dummy, ulong dest_addr)
 {
 	struct bd_info *bd;
 
diff --git a/board/nxp/t208xrdb/spl.c b/board/nxp/t208xrdb/spl.c
index df3b9c6fe40..4b1ab3618c3 100644
--- a/board/nxp/t208xrdb/spl.c
+++ b/board/nxp/t208xrdb/spl.c
@@ -33,7 +33,7 @@ void board_init_f(ulong bootflag)
 	memcpy((void *)CONFIG_SPL_GD_ADDR, (void *)gd, sizeof(gd_t));
 
 	/* Update GD pointer */
-	gd = (gd_t *)(CONFIG_SPL_GD_ADDR);
+	set_gd((gd_t *)(CONFIG_SPL_GD_ADDR));
 
 	console_init_f();
 
@@ -56,7 +56,7 @@ void board_init_f(ulong bootflag)
 	relocate_code(CONFIG_SPL_RELOC_STACK, (gd_t *)CONFIG_SPL_GD_ADDR, 0x0);
 }
 
-void board_init_r(gd_t *gd, ulong dest_addr)
+void board_init_r(gd_t *dummy, ulong dest_addr)
 {
 	struct bd_info *bd;
 
diff --git a/board/nxp/t4rdb/spl.c b/board/nxp/t4rdb/spl.c
index 9d2472dec25..441015bf5a4 100644
--- a/board/nxp/t4rdb/spl.c
+++ b/board/nxp/t4rdb/spl.c
@@ -39,7 +39,7 @@ void board_init_f(ulong bootflag)
 	memcpy((void *)CONFIG_SPL_GD_ADDR, (void *)gd, sizeof(gd_t));
 
 	/* Update GD pointer */
-	gd = (gd_t *)(CONFIG_SPL_GD_ADDR);
+	set_gd((gd_t *)(CONFIG_SPL_GD_ADDR));
 
 	/* compiler optimization barrier needed for GCC >= 3.4 */
 	__asm__ __volatile__("" : : : "memory");
@@ -59,7 +59,7 @@ void board_init_f(ulong bootflag)
 	relocate_code(CONFIG_SPL_RELOC_STACK, (gd_t *)CONFIG_SPL_GD_ADDR, 0x0);
 }
 
-void board_init_r(gd_t *gd, ulong dest_addr)
+void board_init_r(gd_t *dummy, ulong dest_addr)
 {
 	struct bd_info *bd;
 
diff --git a/common/board_r.c b/common/board_r.c
index a397e20959d..7a9de6ba5f3 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -796,7 +796,7 @@ void board_init_r(gd_t *new_gd, ulong dest_addr)
 	if (CONFIG_IS_ENABLED(X86_64) && !IS_ENABLED(CONFIG_EFI_APP))
 		arch_setup_gd(new_gd);
 
-#if defined(CONFIG_RISCV)
+#if defined(CONFIG_RISCV) || defined(CONFIG_PPC)
 	set_gd(new_gd);
 #elif !defined(CONFIG_X86) && !defined(CONFIG_ARM) && !defined(CONFIG_ARM64)
 	gd = new_gd;
diff --git a/common/init/board_init.c b/common/init/board_init.c
index 2a6f39f51ad..2faea5432c0 100644
--- a/common/init/board_init.c
+++ b/common/init/board_init.c
@@ -14,15 +14,16 @@
 DECLARE_GLOBAL_DATA_PTR;
 
 /*
- * Unfortunately x86, ARM and RISC-V can't compile this code as gd is defined
- * as macro and cannot be assigned.
+ * x86, RISC-V and PowerPC provide their own arch_setup_gd(), and ARM does
+ * not call it.
  */
-#if !defined(CONFIG_X86) && !defined(CONFIG_ARM) && !defined(CONFIG_RISCV)
+#if !defined(CONFIG_X86) && !defined(CONFIG_ARM) && !defined(CONFIG_RISCV) && \
+	!defined(CONFIG_PPC)
 __weak void arch_setup_gd(struct global_data *gd_ptr)
 {
 	gd = gd_ptr;
 }
-#endif /* !CONFIG_X86 && !CONFIG_ARM */
+#endif /* !CONFIG_X86 && !CONFIG_ARM && !CONFIG_RISCV && !CONFIG_PPC */
 
 /**
  * This function is called from board_init_f_init_reserve to set up
diff --git a/common/spl/spl.c b/common/spl/spl.c
index 6c9a1a1cbcc..81aec2b1108 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -956,7 +956,9 @@ ulong spl_relocate_stack_gd(void)
 #if CONFIG_IS_ENABLED(LOG)
 	log_fixup_for_gd_move(new_gd);
 #endif
-#if !defined(CONFIG_ARM) && !defined(CONFIG_RISCV)
+#if defined(CONFIG_PPC)
+	set_gd(new_gd);
+#elif !defined(CONFIG_ARM) && !defined(CONFIG_RISCV)
 	gd = new_gd;
 #endif
 	return ptr;
-- 
2.54.0 (Apple Git-157)

