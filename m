Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A5EC88E77
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 13:08:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 72822607EB;
	Wed, 16 Sep 2026 13:08:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2DiXAHdYyFxi; Wed, 16 Sep 2026 13:08:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BA37C6080F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789564117;
	b=g2zaPdi9yD2obaI4+KeqLaRCSnqBTTzXk4OAmAwfXVhTvXPexKsX9KeUcwELrO18w0vZ
	 Fis5niWl0mHVivtiesMJ1eW+hZlFmefBurgoeNvTRa336n3nS1y1kQzjBnhZKAoBxgjK/
	 2M6l2lwmGQkepNF7UxxHpleY2Plh7b6apwwQFUFLTaCi9AIJencEjiEOfdfZ+viChSeP8
	 LivhLVacp6Gh8Q6frcVXX3+iK5Y1JCo2aNRR0P1wJi05hPSOsCWjpcR7RW8e9Dn1ZwOud
	 xWk10Esi5LCbENhIWHzexcfF8iGxLXXIGiyUtkyVnWg/smUefaBJQWO/0fe/9sxwgEQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789564117;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=WP5pwwX8W0g0LY/Lq+YQ38anw+6i/EXfaaBvCMvlsx0=;
	b=pjiI9PSQRXsc/IJovT9ZnoI/usXHrOTPFp8AeB1EnMShkiEe/37+QWXyCyLFgb96Dra0
	 DjWNlIoBvz7fo41yE+vtKO86zswV5QfBnpWST2a5Fx99IuBG6ANV5BqiVy/tPInuU8NHT
	 I6nIDa9qCXKUBGL6CWpDqJpQJOiTa0ilHwuS9SasYV3NqPgMNapEl50NJwhbf/E9SDvxt
	 cHN6FVB9m3adVrnf8E6mycI4UtFqK9YZVNwaYaseJaDCaU229iH8gwq5j3gdRIdTUMkHH
	 UyQnxd+iV+g7WKaYEzdXob+Qrp/me3EymseXFgDhKRZGG7WTza7CbdeBwYTOLRjq4Eg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789564117;
	bh=WP5pwwX8W0g0LY/Lq+YQ38anw+6i/EXfaaBvCMvlsx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sFTtUVVHw+xXlRdCV0Pmi1Ty3bL22j1P+SVRV2HtZqcFcYMCpT7JDPAHrvWoXIJkt
	 xjHLMqLXlGH3E/GKk+ifjsW9XhABX6UC23E4n5WiJFH4oshREwpfuL45ezADNcO2U4
	 Ger6qRBFn3hs5Yqey+RmPB0qbg1HzNUzDVEty5joTmxm/ZDfxlhq1zV/Ji0JbQLvMs
	 IgZMVbk/ChVkEy8gryERn0EmvVgZ/FLyQJvlh9K7X+p+IhczZKxZhIdEnn7MABjB92
	 3TLm/uIcTTE9Xq5usBKwhHskAK0BceJpMGqBWyTQHBM6BQXFftJvI+sN9A4NjjMOG2
	 S+8MMjiZjwPCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA37C6080F;
	Wed, 16 Sep 2026 13:08:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1A7A7388
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:39:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0C5D3406EB
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:39:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RIgVdlVkkcyQ for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 12:39:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2F155406F7
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:34::22"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789562355;
 b=HaRH1q+46cja6Y0erbuniEojNfGYaMh5xfEOGfTBnMbzU5Qsk6PfU6+09FY7qPF5vSpQ
 GMapxjuxSqysptW/bJMFEYNC6YJeq3plXijrJ1T9XHjJwmyG2GKG1iMn+CIfOh74NBVHb
 zEtF2i5L57yEd8MEk2dfeb80BQZ7fX29xCSU4Be2rs+Ybbra1sU7N5DedQxtwRpk31VjJ
 hc6XbcKSqHypHMt1Dsg9zxMd/HEXaStaYmBl9XEBkf2nUdF9b5oxukjEWWdGr2MrxnkFs
 E5JP0O3USgTKzUlsb/pnb8yqFvyf7MrLLh1hT6xJ/1DcvlvV4kcTnALZNNK0uslunyg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789562355;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=WP5pwwX8W0g0LY/Lq+YQ38anw+6i/EXfaaBvCMvlsx0=;
 b=S5cwxKBjCtz39xoOFnwAoQJmRf1ZKMKIiUVyQYB+4kkbLzYEMezsKBObOcBXjRW3+Lld
 m1qrOR0IsTt2qMgSD5KaXQ8EPtHMLRllBSuzqau3XqK+wKV68bAoKm9RfSB7cvGJO8jFK
 PZTAFTtLJgT9ndHwWtR05qLdGI+zdZfYTp2hPTo0DV+v1xRHJ0OSp+nyOtJ2zqGoJyONR
 LuSPkW5300FwMFYXlHFy5itDwzWb5tmK/olgkr+9UN24VmhEt5YUwEAb80TxrXUXRKHvO
 5ZkyuMjxHOT++37vsG466kUwSROFvbw/Ggl+BQ79Og4k9N9e7Z1xyj00RjKIXTeuZDQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=OHrH0l0F; 
 arc=none smtp.remote-ip="2a00:1450:4864:34::22"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::22; helo=mail-ej2-x22.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=OHrH0l0F
Received: from mail-ej2-x22.google.com (mail-ej2-x22.google.com
 [IPv6:2a00:1450:4864:34::22])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2F155406F7
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:39:14 +0000 (UTC)
Received: by mail-ej2-x22.google.com with SMTP id
 a640c23a62f3a-c250848d11cso12132766b.2
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 05:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789562353; x=1790167153;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WP5pwwX8W0g0LY/Lq+YQ38anw+6i/EXfaaBvCMvlsx0=;
 b=OHrH0l0Fw6pvOUi/fJ2KP1pOCK5hZYk+szvog2HOnjh+gbBs21A3XScohLtLDMpC3E
 aDjTAwFFZMb7QnaEP9LYvuWQ9iJy/x2si3qyY+bAVR77IfqXH96qzkaR2r0N0lqjOPyc
 2HUKNnkHQO3y46T2ZLo8iodm/n+FqyJhJO2TQtU7jEJFnaoBl5nyARr/LDs+121cwvv4
 s1qqUH9LCh0gW8O5/6ZLg+PV6eP7soY4NSwtKnLTigJVZogtQu1VCykcvYD+l4aYx+30
 5/S+PHHn+jlciXDIerrLXm8D5B2WAQWYi/LSpfAqpmdci13Ym8pEIjcd/HLbnyNwP4nV
 YWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789562353; x=1790167153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WP5pwwX8W0g0LY/Lq+YQ38anw+6i/EXfaaBvCMvlsx0=;
 b=EUlOxM/KeMBul43W7usEfm49Ay/erzVNDC1sACVM+y97Z0bbsG+UHqWtJU9JXILpFT
 A2PmiV6aRD8OsyzNgiX+1VEPK/+SMi0aXWO5rJLldE2Ousx1Ksu/Bb7Lzar3Uh/R+q3Z
 YxQtlhRnxI0qPBdlqvBgaERW/w9CJ14/6QZqGq9Aly8aRDB3nGUqWjzJLURl+a/daB1k
 cjSz5ZM9U/F4xrlommNzNpTHrSykKjwTBJyrUIlcW8lXWBQsUvRlVOYQeFDtlJdkFMOY
 zMbJit/TJ+jGIMSYTYtfygVr2gbPZlv9pcH86aUI1nFtMSgbwGPTClijmQFYY0Crbd4/
 c17w==
X-Gm-Message-State: AFuF++l/5EZaIQdzJ9I571t6Rreg3kFlZSte3SqqLdRKyzdVxtaJ4VhJ
 lRO1wgK2NEi/t9nC/Ot+88hWntk8lmAg0lsOflUdzY4HsIOlF2YEz6kfzX4srFCkLAy/4AzTdRn
 7EDiQ
X-Gm-Gg: AYBFou2hgFlALpT3GV9Tcl9wbm7mWY9aV8/qbBgcYGpFojNIblqPspXoVBvQzlwsi/B
 t7B5K/BmicvRS+Ls4tip/i65WeMuE/Y3p4DfGAmwwYJ/7ESt7wJkpYBiWfdlArFxx3LSgRSTINN
 dIcoHOAEoaxpjSYIA7Izv23U0H7AMJtT1GZKNYAijM3ygZ+CWSAtMRrB6h4TMRkivvi4wEyYyFM
 8gfcSRANhK/E8Ghqsa0dkGrToEK5Eqi55FNvZS+uQ3ZvwC52r//0yDh7VdgOMQxxZWxvydkJvKG
 ff5NfklnKGpktH43IK6QFKYoVgFbNZ4GFOiPKMfDmKC2PX509YHYhUgvFoIsga1MWt2mJ1gPUg6
 Y6FFhv/JDgcqED5im93he577D+DSFUTkqvCZ9gSfL8Fq8zzo8fyN9hTxpZDU43Ey4QDIk0Zaa/4
 uDOyPH18cP2i65sLYrQjNgaOIW73NDVYRACwk95x4C98N8py+e6WAUHYHgSP6InWRHPy0gCzcvu
 O1Z07BLK4RMQJVhyJCpNONaJ5e1S+LPcqITAtudSVCn/Zznn/cbjQ+/
X-Received: by 2002:a17:907:3f14:b0:c16:1290:11a7 with SMTP id
 a640c23a62f3a-c29e51d71e2mr195276366b.1.1789562352730; 
 Wed, 16 Sep 2026 05:39:12 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c29de086aa3sm136889166b.6.2026.09.16.05.39.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 05:39:11 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v9 01/26] x86: asm: io.h: add rmb() and wmb()
Date: Wed, 16 Sep 2026 14:38:01 +0200
Message-ID: <20260916123826.517181-2-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916123826.517181-1-anders.roxell@linaro.org>
References: <20260916123826.517181-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 16 Sep 2026 13:08:33 +0000
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

x86 has dmb() and mb(), but no rmb() and no wmb(). Drivers that use them
do not build. drivers/usb/dwc3/gadget.c is one of them. It calls wmb()
around the trb setup.

x86 is total store order, so a compiler barrier is enough for normal
memory. The kernel uses lfence and sfence here, but those need SSE2 and
galileo is i586. dmb() is what __iormb() and __iowmb() already use, so
use that.

Reported-by: Marek Vasut <marek.vasut@mailbox.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/x86/include/asm/io.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 1390193f09c7..bd6c3bbfd2f3 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -241,6 +241,8 @@ static inline void sync(void)
  */
 #define dmb()		__asm__ __volatile__ ("" : : : "memory")
 #define mb()		__asm__ __volatile__ ("mfence" : : : "memory")
+#define rmb()		dmb()
+#define wmb()		dmb()
 #define __iormb()	dmb()
 #define __iowmb()	dmb()
 
-- 
2.53.0

