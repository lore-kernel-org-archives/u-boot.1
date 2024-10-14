Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7924D16260
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 13:18:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EBC2891B4;
	Mon, 14 Oct 2024 15:13:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="K84Q1b16";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C7CF89063; Mon, 14 Oct 2024 15:13:10 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5263A891BE
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 15:13:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-37d4821e6b4so2637348f8f.3
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 06:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1728911586; x=1729516386; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lMxWbG3IzboBy+GjbpVI1B+44dHkVyWcI9T24UQ7YSc=;
 b=K84Q1b16n4YHRPq7irm5kO6rCabaX7BwTYdUstLNRDd2oNyEddDmaOrppiyDbF842z
 ycVH4EoQfROKEdzAJvvSKeFs0xX0icjA5UQoMs35I0m2muCIg1HuCB/mJKPJOSPsaN+A
 /7CtV7NcAxRezMSivEjXHtrT48aiRHDts+Nj+mQZNILx3uS81gDMIV8/NjNaZrYPxam5
 rSqkI4TQ02JmV4HLZGBkVuxcy+5kvpl6Zk1Uk0+L1s3LNPA56yuwO1m9Yxwz8j0Gpyfy
 dH+Fwbqsxo/IrkuvP15WjloYqNwlXHdWbdlrKlos93Syl1HUzMnznpLjdbY8AwFcSvAz
 9SYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728911586; x=1729516386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lMxWbG3IzboBy+GjbpVI1B+44dHkVyWcI9T24UQ7YSc=;
 b=U3/O4krYO9QCwG4VwUJ4Boxf9gbbr3xqKUm5AjO1kPK4DuXw/RcCIw+wW1wGyxvNkd
 fRKeF3u+0vIlu33+wR5X+HIh49u7PJ8lsKBUVTXghBI2tJH0uYiVVlLLTZaagIquwJpW
 VfmAecQtVC1/1eXiDf2jCzseKlfIamSeKrC0a5tizuiEPn1bxRSDkLVJY+uhzdMmmH/I
 aWf3/KHEuGz2FqB9FYt2M1bbaQ3KkmbFC7b2Md5AsB+jnkZumM+iOoPw2UIQkgrheztz
 zptHEOV+tx6vGhVZtGODRMfnOgQrrSZqnaXas2SJ2jUPJFH5pobpoYUGgchHWS40R+xs
 +Z9A==
X-Gm-Message-State: AOJu0YysJeGwsYdpcPNE/dgIk6UyN2lw1MRjwUi8WtlR0RFOZ8zlNNeL
 V7UVpdwnGL2aboU5n24aInl8Ndz2MwzSSKYu+E2BN9cfFVyg1j0eKlLvWcAhO8ugMvPSY1/BRKK
 0
X-Google-Smtp-Source: AGHT+IEPo6MAy2c+4GzFFcgx3sGQ/2Os/WfUJwtAh8XUeAuMsQOlwNE9ajuG1rMx3nJ9KAV3UNhhAg==
X-Received: by 2002:adf:ea8d:0:b0:37c:ccad:733a with SMTP id
 ffacd0b85a97d-37d55304285mr7994847f8f.59.1728911585726; 
 Mon, 14 Oct 2024 06:13:05 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d605c197bsm7103718f8f.38.2024.10.14.06.13.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 06:13:05 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v8 32/37] arm: Implement read_mpidr on armv7
Date: Mon, 14 Oct 2024 15:10:48 +0200
Message-ID: <20241014131152.267405-33-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241014131152.267405-1-patrick.rudolph@9elements.com>
References: <20241014131152.267405-1-patrick.rudolph@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Implement read_mpidr() on armv8 to make use of it in generic
code that compiles on both armv8 and armv8.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 arch/arm/include/asm/system.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 2237d7d006..9eb30c2ade 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -394,6 +394,15 @@ void switch_to_hypervisor_ret(void);
 #define wfi()
 #endif
 
+static inline unsigned long read_mpidr(void)
+{
+	unsigned long val;
+
+	asm volatile("mrc p15, 0, %0, c0, c0, 5" : "=r" (val));
+
+	return val;
+}
+
 static inline unsigned long get_cpsr(void)
 {
 	unsigned long cpsr;
-- 
2.46.2

