Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FBA606A320
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 13:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bTGKrWaP;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=GASTDtvx
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C74160602;
	Sat, 21 Nov 2026 13:14:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hO8U_t_AlOX1; Sat, 21 Nov 2026 13:14:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5DE5E60616
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795266848;
	b=G2qJ8t7O3+KQ+E9TcI0e5Cn1DJrszISeRQlWKZWKBowz/gvpQjGlxl8mpLfW56PGC6Or
	 TiFfbg7DGwBf/7Z5ZMw6dM9u5Ekha0oI00EdeSrzX8eDyHay8FUfGl6xcfHhZ5ISAmvNR
	 T4Uw1Z9RIsAgxy8voPlpR+gnmV2JiY3qEjEAUbEY9ypcPdcJIugo8DdiRQEmfyfJ5O0iA
	 ubN18D1O6R1t7hRJDr7FYLkd7DCqfayM7ashPL0SjqGdXjj1ZJthsoA5Oxn6mp0wQc9XD
	 QvIPI2CucmIo3D8K4KKyas/7BKSr8EO3dTdNSpc8xS5cTn0Okoboyegd97FG0GQZnjw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795266848;
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
	b=KNIVMw2+ckbY7eP4byfSCtTJLKMkvGCFr1OMTKjxjwwLIuvWgg9X/eNaiG/oNI83Y+jI
	 +OlpPOLmk/ctPrfFdBjIE746ZinrgdLXMXDRNiiPWYcrIG/4+/quqvMKg0lagcaWjdJEI
	 l7Xtzk4jfW4ITRVuaEIUnbKDgWZAme3kJR0p1x160/uswFQGtTuP0sKhirZ4qeiBdAWnb
	 xbJmqs/npIsmZwTzkBo9Wx5HZj8Gj3yInHfSuOtuFxzYRbviHMjXjnw6SXfrARdNpnZ2o
	 FmZoKezE9nrQug2hHfeDo45m7zZAsCrsqEaiV9tXdNzKjiMa1eJyNlVqGPJcutQE66Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795266848;
	bh=WP5pwwX8W0g0LY/Lq+YQ38anw+6i/EXfaaBvCMvlsx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bTGKrWaPHs4Y0sjzSDYdwKaBZpVge+joOUo2lS+JUzavsqAAHzxCO01EGuo45T8J7
	 q+J3qOFIbSUBSMbACA268bEiTzhiL2yGfJEqLEbet+Adcm3k+i6HDqoTN9zWGnlIrG
	 fnlMn2VWbKPR/jyieeymBwk6crhb0tZ9F88UXeul5J/5hTl6+H898GBXe1hVuM+cr/
	 ZFdu10tsZxC6k5QvvGjD69B6VNQrxnO+3aNKjQJL1SPGvD3qIUylX84Ok5z4uZyzW1
	 5Mm2y4CmAqwYlWJf/qDb325S9kmQiRg709nqtrNghfEwzOI6bN4XCoie+fyF2Yw6g/
	 xonBp9lr6paxA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5DE5E60616;
	Sat, 21 Nov 2026 13:14:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5612F1AB
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:53:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 53496400F5
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:53:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hHoqSb4F7Jmo for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 11:53:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 487F940012
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::533"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=GASTDtvx
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 487F940012
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:53:51 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6ba85ac95b7so1578a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 03:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795262030; x=1795866830;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WP5pwwX8W0g0LY/Lq+YQ38anw+6i/EXfaaBvCMvlsx0=;
 b=GASTDtvxjzQpmypy5cOgy2Dzrb7aQDWqaiEUsGXfrh/O8fvM34IwGbKypn0XKssio5
 nSrp/JKksT4D1wvwJI2sULVaGUBPbqiVNm92VgYHwmc60IlmuhPXfdClmCCqrP1hZHnL
 vGuoErVCZa55L1A2SFMBsFg0+cgOe99kkimdqobxtCZGUJGVS4UhcG05UoRoYu8Cs2bU
 1vE3g2dJQszlzxPGrh8oanZyKKubE8kaMRSV11is0oHdtkxE5dMRi9gU9O1cP1zRLcNb
 z/NPLU8tSJiSZFqwVHr2BHDg01R8uQCJJ60HO8QHXEct7RA2RSMgzdV9v/vS60/21uiI
 2avw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795262030; x=1795866830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WP5pwwX8W0g0LY/Lq+YQ38anw+6i/EXfaaBvCMvlsx0=;
 b=iheN6mAOnuQeMMC0QFYWaMklLFx0dIMbfHpMy6g9SyTk1/7i41b9jQJOm9qthYNM47
 rToz9kuWaDk1Vzvt8nJRKAj9fIqXwDjYIb6u96xGjHkKx+eCEmCD2pL3gkggu2xaziOb
 qz35odnalo0xjyxkbbNN1CbJOiXMaGaFgOiXBn+fgefQYRecsMtuBMzMrlhgEyDH4j6v
 z1XZRb1T7z2cx0xAuATFVI34ShgrV4cNP6D8Tii+zIRA4He1oSeSATKZfgAHHV6SOzI6
 A0o8wimKrLTPeK/Ocr/X9+7w+csN4V9gTfdMfDiLXunKyWohqunVns8QKSEZl/AQmUiu
 mc4A==
X-Gm-Message-State: APuU4Z8tN5aUcUxkUIdBFF8eYoA33TE1x+cARPP29Rtx1y/t2Swq33S2
 7N616hOsa62dox6MRNgAo5+yGNUw07vqq5qPcbJZ/aXK3MFtenMY5/SOmeh/H4xaFyPrf9tkArw
 bJWeP
X-Gm-Gg: AZFdTZe7fl+NFip4Q+Gej4pi446Vwba3P0Fwl9LSSduoN8gIeYV+lyTEJ+laXb/0ooW
 eqLEaHhf3kD03ApKe6hb5giI2GvbUWJq+Q/+c/guK+GNRMP2zI9tNDzHyzaiimk8PLOJNldgJoR
 YbyBp4eLGk498Gs+ahCegoVGcJVGFSFO6THJK/NqKqeuy2xXHtq6Gmiddn7dJ++vz75TsY30ZAO
 9+1GIdPUcIwwZiXZzE3j/Ri1JBZSoTsggzO1UVOxhJP7xYjZWs8W3aL4Tj7HwfrcPADUnXzM7dm
 FzppNnizQtJuzJh4qC9f0hGAhACh0S6gOmhqT3+7Xl98pLysaOmEkDYZJRhnJ/l+oW+NKtKNov8
 9PHGJN8imcVkmj9n9Ol2l3lvxnhyw5IyS9fDiPe3O/3Zeulb6Hi2zny5qWGOU9+qg4zJ8ZFIx/g
 8DBqHAdVpQkfJa4pJaNQscdLo9dBDJbuntVKFuFbHlcIWqYn8221ZcnWSgYnWzJVegvfttZjXsU
 kdwUt41zMPIY03kmFr31etEXjREWrwoDYh8txLBcT/J/L8D6VFREnzCmHlnnqb5UUf51SZNyK5L
 6HwBRm3uXyjeHmRyTdIvuq1nWgpMCZ0PdrXUdgOEdeR8U13M7v12scpV5zJE+bnNv6BhnaLTxgD
 hiLI4kT3Bqhwy3LBKoDH/Auv+hoRGFhE=
X-Received: by 2002:a05:6402:4248:20b0:6b5:4b1f:d8ab with SMTP id
 4fb4d7f45d1cf-6ba37e648a7mr4210796a12.3.1795262029907; 
 Sat, 21 Nov 2026 03:53:49 -0800 (PST)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba370cbeb0sm2366040a12.10.2026.11.21.03.53.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 03:53:49 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v12 01/31] x86: asm: io.h: add rmb() and wmb()
Date: Sat, 21 Nov 2026 12:53:05 +0100
Message-ID: <20261121115335.548142-2-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261121115335.548142-1-anders.roxell@linaro.org>
References: <20261121115335.548142-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 21 Nov 2026 13:14:06 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

