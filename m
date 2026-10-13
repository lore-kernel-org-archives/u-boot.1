Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0EF8CA9ED0
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 05:47:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 72DD060762;
	Tue, 13 Oct 2026 05:47:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mPtiNVIcqN_2; Tue, 13 Oct 2026 05:47:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9B6086073B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791870466;
	b=S8O0gXUYoZb4A5FfdtEeEArg4rUYxpZaq0z0ej3V+gYSqDp2M04k9M8OTMChhviDJIdT
	 RX90VM1lbARxoJxpP6M3jJ1HGRtEwrou6o6Jej00Ob4yT2FPqPRzYGmwJZvdUUOq5Z7sB
	 cPHKiooGvZGz9OFYmD639pmvrYzRAe5cLtkjT+7b4kBm0TXwX/B0Ss3M0aO4x+tKUDZu0
	 rTMbZXPV4xJKLQDy9a4jDR5MqgUM2mamM5eZge0soxKrSY2Hi084RdJQiStUZG5uWzu4+
	 +SaLmw71MmhUlZayUw6O/LlxT3wW1nohjbJFv9sVrFgontvn73Iti2HvdRvCjvbikmQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791870466;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=OB7iNUwRXKqi5kTkVbYUHcRHqQS6istz5zx/PQ9+yb8=;
	b=gIMKL3Uvodr6MdAD/DYY3BPZmabWcIEOIoelYF3swYmCM0x7ICKPvFvb7ms5JP4qtx5H
	 RtD9yM2Fp6vfZTYJ5y1Py3xBryfsmRfXnU825qKDV8PMi+yKJMIZDuvTJnoZVMGx1P3rE
	 wsXXb73WP9B6kSs4QeRl/aXRvj2MSkBlwJyw/258cOygRbXxzYSHvKwsLF9V2me0qrjiw
	 duOkA66l91PDrkJH1A3X+fVJpVexH4cfo62nEep/DqDCvh6cSLK7ikXazEjUTsujNy6js
	 WFqQauCIqLR/B4ju7O3Y4+IVcNbjCZBi5OU/h411i1aUHsid9bgrGiHT6bfsPeqr5Sw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=TJuOpc2N;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791870466;
	bh=OB7iNUwRXKqi5kTkVbYUHcRHqQS6istz5zx/PQ9+yb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Fd5GQJzT8KJbyTK8LNwwUi49DjuvRjccnG7xHij74Ge5yuKgtOjkleDPnXMbbkXzT
	 hG2kDganoz6PEwyeMwIE45QpPQa6KLozTrhOUT5oMo3cQMa44s0x+yPRdA4UMQL56z
	 gtGSgCyrG1yukRr6bYkk9ajetQ41XSva8VUJQUvak07p7ZDZ9MDc7FCXpI1v88oeT5
	 V2BJlZNTrNSqTD6+OFnJAJAXB/z85DJXtUdB7j7RxB1hqgSi8vQuGkecncKDXe3K8d
	 90mLVeM+210vGPKP7joHSsZzVajQDTHl8DUl6MWKNh8cei6Upq9w0rOZfimaPYfehB
	 wrp7hkoVj+XPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9B6086073B;
	Tue, 13 Oct 2026 05:47:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id EEF35788
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 04:31:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D4BDF606A7
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 04:31:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YQlx-BFq8-1O for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 04:31:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 776FF6066F
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791865879;
 b=tYD53B//i+s4Pfqgfmj6zW7vtXWARJZyVMoeYoP09rWapwYhsflXszfY4RIT2JrypOSp
 PwUxrMYWzpkbUTe3wNH5SYlZYpsWY27tchi1pw53N+ypxp7sVzl9WyuwA1gGocdLPTkuC
 brLE34//PCTp/qsdw5ps44I+xfeX1nWiBg+5xXaDD6YD93kXHUfySn/7iHaL/9ndkzoDm
 65JLW7H4VJl2NJe52Cm4vY279c/Zd/aTRomC3OOS8Z+3OH9S+bW/OxUmgCYfa35zJZy77
 WeSrgzt3XOCUOYGez0+DmFi8GGG/MH1wzjdBCBm0a7s61/qA/o88ke7RRPuEomn+0mA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791865879;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=OB7iNUwRXKqi5kTkVbYUHcRHqQS6istz5zx/PQ9+yb8=;
 b=BFEAJ9BFTsy6pXJnH/vwatm545wg3bejPlBLR2EPO8ijzDsDhwiVjHtWBcoxyTn02Bcs
 WLBsVg4h75jSKtbNuZXXKwyvNWqF30pE77kGws3LPAfO/UaPKJ2keL6wBVqr/vtYsKvkv
 qUTYMeOtldBXErj3uApdc/FYkpXe0z8tbeszNDgp94RlsmhTxawQS73mq02LqOdr7ArBn
 uR/misjqm1UJNH/S4WAxDgjlNTBjBghvknmT60tXCq8FmETsVcZOG3+gatAiDwh5jEGAR
 Wimb2P9WqN5Z94eqNDYtY8mE5qz5qjqv4idHTnJQUtHQ/8v2E+w0RgPGzEakP7A3EqQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=TJuOpc2N; 
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=TJuOpc2N
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 776FF6066F
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 04:31:17 +0000 (UTC)
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E330A3F13F
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 04:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1791865875;
 bh=OB7iNUwRXKqi5kTkVbYUHcRHqQS6istz5zx/PQ9+yb8=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=TJuOpc2NrIvQrMfDCgMwrwsWsbnM5DU2dw8edt7fc6raJc6JF/wcLcbPyYkQdbH3P
 PA7ERnSyetWSpi8GtrBC1xAAmfMolitE+FcuDoDJ5D4VmWj7CNKOFw0II09yVDYKS7
 GNZqhEHv/NS2fJIMQrm5EZu8+GCuyovKnUQyHfk5NRqzQ1Lghqxde9WWozDr+M2BKI
 L0yUS6jYhqlEvkUcUmlfK+nE7MCdg30G2V4wQ7UfA/ZW0HXS2jFOiGRzdNUX0+guBt
 oKG1dFzlpAJUkrh66O+UTohGrZ5GXd6EInlZyu0MMv1JlL32vOxCY9k/6rZMlplUFH
 w1AJqFM3sU/0CzlwRv1igePaPOAjnULxxkuar6bzxyX0p1sl2UVa3llTerIOEN/ffS
 oH1+5uTvzL7GBgptBvO1jthduYzqoUibcyJog4DQXo0c/QGWByM5BMafqRxz9Y+QmY
 JueMELCLUeUdyJFmsddm6JzWwTdMPdWyhbgheLFaOFfq7ek3HKYGSMv8mCZSufGc1J
 UZG/HJJb1PDnDSXXTh3EnAQ9voq759e6okkE84HiQFuayhpQYvlKiqxydyJq2S9Y1G
 7MWcBc7CyT+/UfYayeim8/LyoviLt+xbZ75d7g8RfxIbaC7Bp6nMqFmgjoWLHJ2omD
 vtGiRnVpLy1gV9t2LGtTulPc=
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8886059d3faso4946010b3a.2
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 21:31:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791865874; x=1792470674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OB7iNUwRXKqi5kTkVbYUHcRHqQS6istz5zx/PQ9+yb8=;
 b=Lp8oeU63+2zvWgsD2XOrLcQk6RoIloY4lDZk3Qjg72ESxLrOWZD5h+OIMb26MoJQQB
 en2Ua4I5x9HUT6IBvIAm103coTi4GdK9O/1Um7AdpFuZTRcp7a0qIQYnBzHgDRI9huvk
 io4VO+whrfqcWwwEifsbokEt/w6piqyiw5X2T+AOSBMiolkTF4ipwcK4s+H6HAZBQNuk
 uTZuVFg83w51Zli0IxgSK9GoTsaunezv3xpBtYApXsPavynTyeepssxH9Xsh5IasiG9s
 RpgmI7BIt6rMHueEVKdgZ2vsL5IcSF5dYjz/vB3bYUO2wxag9KZD1CRxNitQA0J0ORVD
 nmBA==
X-Gm-Message-State: AFq9FYKBEft7duWeJMINMFJNMT1PcplXN+QAf7vfNDxFFovV9WeqPdSz
 tKagufxpJop8dIlkWaIb44o7+nH+GZAhbLNAND87oxV1b/I8HY0nECrKmvxB03kz18jUHTnsD/X
 KejYmE3taC9zl86EhINF+O7R9rldhF5qREySR/YYPjclRQ09U7+bqM21FtqxEj8kNFHUhJQSGhp
 /kR18dLNkbxTVC6h3Cig==
X-Gm-Gg: AYBFou3kM2j0h69+SLjUSZdYPy5Sbc7StjmkutMu/a9JJBKQHegqEOr0nnNszESk/Ki
 kZCe5Oaa48q6oy5l4d9sQBISnaCYLs6NlUzyaKV70GUYiuquKKatOml87CYlVYhIw5znPUpaxL9
 mbGmBK7n+l2TG8U1sLEYXQiCKiyOX2r+JnHXirhQyz5SeifhF814KneMCaJeOhLYlnfkTjAo+ay
 1l2oCzrtocf8QGFMYlBPhYWDN+02VVMirzT3oWZwL48GWD7I6UQvawSkfjxYGRJsA1XdHLGvkho
 sTq1fyCqvz+bPq8DBu4d516pJEskFccqXb3+QBomuKmxv4A4IMX6WcyguF0pIxrLpwKcn/D9I+P
 bicmO6O61AqiB5wrn1MBmSVewDyyIDY0tFQVvWeGFex32u5k=
X-Received: by 2002:a05:6a00:f8a:b0:880:740c:927c with SMTP id
 d2e1a72fcca58-897c41e8cf0mr9018327b3a.8.1791865874374; 
 Mon, 12 Oct 2026 21:31:14 -0700 (PDT)
X-Received: by 2002:a05:6a00:f8a:b0:880:740c:927c with SMTP id
 d2e1a72fcca58-897c41e8cf0mr9018303b3a.8.1791865873976; 
 Mon, 12 Oct 2026 21:31:13 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-899b738d03bsm2419931b3a.41.2026.10.12.21.31.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 21:31:13 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Stefano Babic <sbabic@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 1/2] imx8mm_evk: Drop duplicate prepare_mcore
Date: Tue, 13 Oct 2026 04:29:41 +0000
Message-ID: <20261013043050.386025-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013043050.386025-1-aristo.chen@canonical.com>
References: <20261013043050.386025-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 13 Oct 2026 05:47:40 +0000
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

imx8mm_evk.env defines prepare_mcore twice. The second definition sets
mcore_clk to clk-imx8mn.mcore_booted, the i.MX8MN clock driver
parameter. env2string.awk keeps only the last definition of a variable,
so it replaces the intended clk-imx8mm.mcore_booted in the default
environment.

Drop the second definition.

Fixes: 364ba68ed1a1 ("imx: imx8mm_evk: Switch to BOOTSTD")
Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 board/nxp/imx8mm_evk/imx8mm_evk.env | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/nxp/imx8mm_evk/imx8mm_evk.env b/board/nxp/imx8mm_evk/imx8mm_evk.env
index 88eefaa35e5..33d93bbf334 100644
--- a/board/nxp/imx8mm_evk/imx8mm_evk.env
+++ b/board/nxp/imx8mm_evk/imx8mm_evk.env
@@ -25,7 +25,6 @@ ramdisk_addr_r=0x48080000
 scriptaddr=0x40000000
 
 mmcargs=setenv bootargs ${jh_clk} ${mcore_clk} console=${console} root=${mmcroot}
-prepare_mcore=setenv mcore_clk clk-imx8mn.mcore_booted
 loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
 loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
 mmcboot=echo Booting from mmc ...;
-- 
2.43.0

