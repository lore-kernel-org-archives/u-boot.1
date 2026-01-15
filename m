Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8FC1D4662B
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 22:29:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1B1D830E4;
	Thu, 15 Jan 2026 23:28:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Zvreub1s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AB0883966; Thu, 15 Jan 2026 23:28:43 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 037BD838A5
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 23:28:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7cfd6f321b5so731635a34.2
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 14:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768516119; x=1769120919; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ANQkTlVUYip1ddJiLszXzF4bgGBykbrt3fzJq8s/ox0=;
 b=Zvreub1sTlHUASz/qwVLgO+NX98EcrVIHjo8o5pcgx8b1PSCStfv13U3BgXyVCrDSO
 dkb5InwAe/sCBWEMN4FRswBDTwB0JQXZCshekg7RFAnpgP75xPZQvHtSxdvyhtjTpGhD
 IoDyJgSzcReqpIK5CF0V6Cmyd8P7u4te4jlqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768516119; x=1769120919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ANQkTlVUYip1ddJiLszXzF4bgGBykbrt3fzJq8s/ox0=;
 b=Q91Xgw2DDRu5RTdLtzfvBnOOhkxmSbEbYz1xjMjfbp3RUel1RtVEx+Pv8w9GthcZak
 hkC/ZyupfMWmrE2ORNpIRH93sS6fxYZslcReMGwIhTEE4hxjOX9LIUIGRTmzXKkvnqss
 Ds7OrmAL035fsdJ908+iduKYSwL2LNZWjmhQ3TAzUsmirfESciqHvUpL3DXyBPMUKf2C
 pS76eV5/Y0UTGxRiO6pdwSJkjgtL6F/kuVwEKs3gR8BaqylIjzDltDO4zYKHnpWrkU1t
 o4tXJp3r1pUW/SrYoXOgx6prH+19io/n7DFlH2kn9CSO8sRGhDrl1rHobkQmOZ2m9x+W
 zjoA==
X-Gm-Message-State: AOJu0Yy804ksE5zbEL0s57PG357OsZGxuYe9h675dKzDSXXgOJqXj/ug
 nfTn+A8jb808X2obVthiTu27Y8g+PJD4caz0MWZwwaQKkhE3PeqwIBswEt1EsExNbfzGbIPcTcg
 1k84YImI=
X-Gm-Gg: AY/fxX4S6H1nOoz5MLUDS3hrgU7QzT8eEE2wy7oHmjdWQjmQIoiYsCKsKEQys9aZ8Ps
 d0N8Dig/mfZY1HSSU9PQjQ76/IGVjN1+ZbTwoHyttCn9gnwC5HagRaipU7/L1smIhIk4nEKDgAH
 wonbH4zu6ucnAKnhoAerr3mY6PJ76aCrLehIVwH2aN9/+UmrtxTsExluPynRh4Ux96Nb3NX2mPz
 zSpW9vI9azpS0CsIVn5MYgbBg/FyXttlWxUgbAzU0MwfIephJaGaAj524rbaFkY0BbL4lJnuIVX
 TKC91YV6iwpivUqkR98cNLwnDvQXDjzRiaNw8yUYOhmPmUW2vFUm3JPEuhuR2KpLRIr5Tlhs5/u
 apyl2kjhztKJVO3ljFeHFWbg0EAkqk2in+5jBxha8B+WIvKloXHmEqm+AFQmsUN2+ZnCi1weHMs
 /coY8YDERHe2UFQ98L0uSlYIoCY9qRP0cp5QvgHsY9uaQBsv0C8CJ1dJwXeXzmD+wzsp4XznjP9
 uYrTcJveXXcS9+Sencft/Fipj6Q75XBMa9X2uHb6w==
X-Received: by 2002:a05:6830:6f42:b0:7c5:3a34:994a with SMTP id
 46e09a7af769-7cfdee22628mr707351a34.17.1768516118795; 
 Thu, 15 Jan 2026 14:28:38 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cfdf2b5aaesm544074a34.31.2026.01.15.14.28.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 14:28:38 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Beleswar Padhi <b-padhi@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 04/10] microblaze: Update linker scripts to ensure appended
 device tree is aligned
Date: Thu, 15 Jan 2026 16:19:34 -0600
Message-ID: <20260115222828.3931345-5-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115222828.3931345-1-trini@konsulko.com>
References: <20260115222828.3931345-1-trini@konsulko.com>
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

With commit 0535e46d55d7 ("scripts/dtc: Update to upstream version
v1.7.2-35-g52f07dcca47c") it is now a fatal error to U-Boot if our
device tree is not 8-byte aligned. In commit f613a6e15ef7 ("ARM: OMAP2+:
Pad SPL binary to 8-byte alignment before DTB") Beleswar Padhi explains
that we must have ALIGN(x) statements inside of a section to ensure that
padding is included and not simply that the linker address counter is
incremented. To that end, this patch:
- Aligns the final section before _end (for U-Boot) or _image_binary_end
  (for xPL phases) by 8-bytes by adjusting the ALIGN(4) statement to be
  ALIGN(8) in the final section before the symbol.
- Ensure that we do have alignment by adding an ASSERT so that when not
  aligned we fail to link (and explain why).

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
---
 arch/microblaze/cpu/u-boot-spl.lds | 5 ++++-
 arch/microblaze/cpu/u-boot.lds     | 4 +++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/microblaze/cpu/u-boot-spl.lds b/arch/microblaze/cpu/u-boot-spl.lds
index 09abbea84d06..620ef2c96dbd 100644
--- a/arch/microblaze/cpu/u-boot-spl.lds
+++ b/arch/microblaze/cpu/u-boot-spl.lds
@@ -50,7 +50,7 @@ SECTIONS
 		*(.bss)
 		*(.bss.*)
 		*(COMMON)
-		. = ALIGN(4);
+		. = ALIGN(8);
 		__bss_end = .;
 	}
 	_end = . ;
@@ -61,3 +61,6 @@ SECTIONS
 ASSERT(_end - _start <= (CONFIG_SPL_MAX_FOOTPRINT), \
         "SPL image plus BSS too big");
 #endif
+
+ASSERT(_image_binary_end % 8 == 0, \
+       "_image_binary_end must be 8-byte aligned for device tree");
diff --git a/arch/microblaze/cpu/u-boot.lds b/arch/microblaze/cpu/u-boot.lds
index a2c8fb2e21c0..70fa49c31712 100644
--- a/arch/microblaze/cpu/u-boot.lds
+++ b/arch/microblaze/cpu/u-boot.lds
@@ -67,8 +67,10 @@ SECTIONS
 		*(.scommon)
 		*(.bss*)
 		*(COMMON)
-		. = ALIGN(4);
+		. = ALIGN(8);
 		__bss_end = .;
 	}
 	_end = . ;
 }
+
+ASSERT(_end % 8 == 0, "_end must be 8-byte aligned for device tree");
-- 
2.43.0

