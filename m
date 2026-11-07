Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE7A606A32C
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 12:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PSA+8Nmr;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jgMEL7Ct
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EFBA960684;
	Sat,  7 Nov 2026 12:49:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZID54rjh_WDq; Sat,  7 Nov 2026 12:49:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 52C7160746
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794055790;
	b=AF19FGZhyLaDUW9xUPSEu2E6AlN5i77Q3SNOOlXEWIeJ3iGgHHA1CRuQ19TKY4EO+OhR
	 HGwYyfjEJDUuDvLkzC9TG0ZH07q+7pvyk1IG5VohceMZEufPE+D0MLEfy701F9rjvAPt8
	 hf+Zy57JA0W1fi81njkBzRbnO351tbqUP9a5J5e23ouAhD3EZH/9vQgvudq/EHcsYNnQF
	 kdiVaQ563cPOpJQTv5JsWk6rkRWAQs4EUzGF1OIyGVfF/nWGhL8lG21O6TvVTn4944WPW
	 7jsbups1s7uXEB/H/re4l2by5U06J50E8Vjum3HEQCx62aaWe54qqJhgNahhgdJn+Ig==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794055790;
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
	b=LF8VfiMziKo0kkRmV2KQp2YFHmJVHtjONBA+NpKiHXi1MCSHN4WKgp5l+gl0I4PxQoD5
	 lQ9VjMzS3kS+W87hSZvFfpm2Z8NjzG/TB18Pqa2UzQNSV43ORB0iPeFX9i+0tMGNdWOg1
	 gEyFRtlYRyILPitF/wzy+JtMn18kx3VVGW8BNWJ5pobJ1/U9a6m5liSURvGt1brHvEQAc
	 umWrkFjILRfSE8g2b96lVkm8oNkEqJ/ykV0lFewVMYlekjNRPVFEsku1Njwz9mc6V0R/I
	 xKlAoAh3uArZDV52jbnEcmlOZe6S55yFk39QOtE41ZTQyi8CYrCNlEgo3x6Fq7VYRIQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794055790;
	bh=WP5pwwX8W0g0LY/Lq+YQ38anw+6i/EXfaaBvCMvlsx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PSA+8NmrIFAqEl3zNChnUxDnzKgv7nXGO2fjhCNAGroxDqX91VZ3X6Miq8z8Gd6a9
	 Zck0EGc7Vh+KG/p9UPuF7cicuw0B1Hp2Ki0KoZUmH23ZP/190DHC/Zs3QoDPzWsN9o
	 O2baa1i8OEkt0JAfxqK+cHRBAyHrN0/aRV2dFYBDSXR+9hy4RwkYDS9wwcDnUmPF0s
	 TKqQrcRFLxcbhAET3DD9TGx8vAgKnxUoiaUKdIcRIRCLt2Jf9giOQirhiWB06j3oZj
	 P94uXAuclSXMaqxkjxvoR5B8GygO5Jcq4nUU2Nhv+U9+DwigeSWNDj3GC7n5XFbBIc
	 v21BxthCuZJeA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 52C7160746;
	Sat,  7 Nov 2026 12:49:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C3D4F2AC
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:22:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A9948400B3
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:22:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JTXsGaflD-tj for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 07:22:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C8C224005F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::52e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=jgMEL7Ct
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C8C224005F
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:22:33 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6b5785aea56so228226a12.2
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 23:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794036151; x=1794640951;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WP5pwwX8W0g0LY/Lq+YQ38anw+6i/EXfaaBvCMvlsx0=;
 b=jgMEL7Cte3bwg7t4qHruqBsrmKMiD21dWjjxSVQACM/qte3REaEb9O3dbVSfsV1UGG
 I1+oohTMT7Q9wJQtxQH4mVpPPnWBcawkviKzV4rly8ChNljRUnl7LWtsyvDa+ktZ/7wg
 BUeP0YlbjxuC7Q6hreJXQ+ft1UN3QXY/egIbo3NscnOQQQtcvqgIeK5g2d4XeIpYght9
 +UlSoCuImct+I9G49d/+aXdU//R9jZ9v65X1PpDLuns+9fKzSQsLZLWfQE1cihiDkQjk
 4dYpDmYs2WuXL3VabgiSUw+pIIfERrojrOwqY6Ku2Cq2dU3XZHkBA14V4Kc8niHuVbjf
 FSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794036151; x=1794640951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WP5pwwX8W0g0LY/Lq+YQ38anw+6i/EXfaaBvCMvlsx0=;
 b=CR0++O10d/7OCVcdqvB7t6bsq7zEv9wc0Zd2Vy7DRjQt3Y1mJSPvVTS0n4fE4jm1q2
 qeP5gzA9pu5XnY5y3p8vI6JvSWcBizxqCuHwuwz77dmMEEj/zvfMagKZNhvW6eKpZCCk
 bM5ztb/SO3CGu9JA7DgNwImcgrgmX4pJN5LhBEdH1j4vx2zn42D1rnN3Lt3j7O8r1W92
 jNt1YyHrw3Co3XoPKsrK5MRWBYDDg8rfJevcQWeJDfah5i9G8PmMWvKomROsQvZb+H4V
 eE7QrZg82FGKpITwTUzc5mBqMjXZncED1hu64Ay6AIkGzZZdC+DNqDO113yimjZju1mr
 OGYQ==
X-Gm-Message-State: APuU4Z/5K70OCiQsNagimWK64qQb+91B50wGaAlHyfQbAU1/prI1X/L8
 PLPs+8izJJn8ggfDCMsI/dIoICIUxikvxtLzsX5ehZ9qT7wXAqrcon4dA2SfzzQSDP3MWGVOkNa
 I2+Cd
X-Gm-Gg: AYBFou0cQElSaV/KOFnW6hQw9xSltfIC6dtYrr8usHrcnMCa6+BiYR503EQO162eYMS
 Hc9yLoNcWECTIxVoBIXDSKwASMTvgo6eqjraWg54J4gT6vPWlWDriqqdohhz8IzkTm0/wYrIjJD
 a6PNFPgs7M6GMpXJk5BxbmSHUcRAn8BCuHhE6MMY7SzTWZ0YvblI1gDSmZW/8zQ0b886c2xXdQ3
 9XIza4qelLKeQYQQfzUdU2e9AXMBvCmjXlMSB736inHZZ3oHiwHAANAnrX34P8kJHqPtNsqAoWC
 xzaFNWsYlkWvGumeOqQF+8ptKYGh+4HVrmBla/ZB496gZ/EDVc/BeiTu0VeSVniJpe8kRm4aVp9
 gztB75XNojiZzhuwg7Xao6ErgfCdzt0/IBAnkRSB2/5C2DOE4PVYov+j8ULAQ53LogZhJ+DOeQW
 wLSZgM26RHXVYIPdxKY4ov44pkRr/4bn5PrPfxS1hGGtJj7KS00rQ/kcCqu2WURgE5Ee7OsrKBv
 5jD2Gexd2CSBbA547sMpcLR8vjkU6A2mM4CpIIcrVjLqXYEmPVMBh5xWsKZ7/NFGW5cyz/ppiCr
 mapt7bU/lZgvtiCtdSSpBUAQL6J4cH3/jlvqrWACytKQC7lVNAuFlmwZ4OmsrwQxw6AbaafUxIA
 Qr5Q/Ewzj6g==
X-Received: by 2002:a17:906:c1d4:b0:c4d:2b77:681e with SMTP id
 a640c23a62f3a-c4d34c90417mr359051966b.3.1794036151487; 
 Fri, 06 Nov 2026 23:22:31 -0800 (PST)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d356eae34sm132640566b.85.2026.11.06.23.22.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 23:22:31 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v11 01/30] x86: asm: io.h: add rmb() and wmb()
Date: Sat,  7 Nov 2026 08:21:55 +0100
Message-ID: <20261107072224.3492260-2-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107072224.3492260-1-anders.roxell@linaro.org>
References: <20261107072224.3492260-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 07 Nov 2026 12:49:48 +0000
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

