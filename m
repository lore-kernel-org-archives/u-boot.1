Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7559BD4662B
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 22:29:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FE79839DD;
	Thu, 15 Jan 2026 23:28:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gI3JKCEO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A11B83935; Thu, 15 Jan 2026 23:28:45 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C4D783935
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 23:28:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7cfd5d34817so916748a34.1
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 14:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768516122; x=1769120922; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tGQvuXBGGuCoQBZi53eyX4mzAbF0h/gVA8GbctNlgvA=;
 b=gI3JKCEOUN4ctFjhXs9XgTjOuSUFhA3bjucbPd/W8B1qbvbi/RRVhine7QvO5aKwwV
 NF1pVkmf0slxRckL9s5aFb/Cz6Hlpc+MCLTEyopS/D5nMObGrvPl5TvODdNge4nGMATb
 n9dMXYI2SYI6sCMQcTDrcIrj1eIbUT3TMCFt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768516122; x=1769120922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tGQvuXBGGuCoQBZi53eyX4mzAbF0h/gVA8GbctNlgvA=;
 b=MBijk1866LqnOG2OJ4SQVc9G88P0PBSmmrcsrJb4ikzgC/cmD1+5rkbjzVKc1nPqpW
 NWUl+eARLqeu1fAR4qbAwAdwPARHqb8EDs4J/bbY02H1wb9Vth7GazwdVu4bcCyzyFyH
 w6QGka+y0Wjk0KiS8gOddeIA4/LvBW7NKTmd/O+hakE1E9he3tRzhh0mSz69c9YevzN4
 zt4k3U98m0N0hN4eGlw2z0PiIxAqjlJSD83/eKYISbkxnMwm8X+h+Z+2j4Ipt/P+x5KE
 qa7hGYh3vJU9cjfKjoYT6RnisgoAV3S5YPq0qk6NV1JR5bGWAvtNCpCDUBDZdlMaBqPf
 Rzag==
X-Gm-Message-State: AOJu0YxVaYSzwsQ1Nt2zeanqvseu7cDlIte6akeHAEcOHVfOvgwg92OK
 r9Ce7W1wSkIyYYOScIH03rQiY4Axk/uKkXci7cRaduQytihCGL/+MupUIjzzCQNGgQBdFdA5v+9
 zvTfSfPg=
X-Gm-Gg: AY/fxX6dj9k6uv+SfYrA+pJwrA6MNckKcx9mCy5FtX2kq72hUMcMvpw9hBkZPMcYJpO
 LWWNZow/quoMLyvcPoH+iQ8D8BEfVYGncvaca6ZF3MWKO2wgMs20Dfed95eWZuwAzq3C0TIDjTH
 YfIkJivrcNpP1lusaz89+9hG8oPYmOC9MXQG7Olv44X3G2RznAbJf3lEpG+av4PSO3aShgkekVg
 pavy+WlzOqMBiD/fDXTV7lPL4qZ2lRtj0hE2h7O5/SauARPSgn/2sK7o+A/k7OmYE7iEJ8bTF4/
 wGwZG/8bGJuTTZlFfOORzFz8W5xa2c9VdxmCElVbiPWbXV7pkTxsMdpQMLRcuT2zSLnRhCIFuOK
 ocHpU9+7p0Uhk14A2uDqmMDm3XwfKZLUL9ZcyQNTHefTqqsaYYPnOM2ewnr1qUJckcdKkiwI+Dv
 9D4cjBaReLKnWj/qFVpd/8pRwl6QWT6F92MIB1x3Cyf/zM71+cKhuLuaS+o0jQMlkf3ku+FfGKr
 Znh6xJoF/4cYvr/kTBvmL8TTeHr+O2HhaH2Axh/kw==
X-Received: by 2002:a05:6830:440c:b0:7c7:591a:7e91 with SMTP id
 46e09a7af769-7cfdfe21eb3mr345692a34.7.1768516121772; 
 Thu, 15 Jan 2026 14:28:41 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cfdf2b5aaesm544074a34.31.2026.01.15.14.28.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 14:28:41 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Beleswar Padhi <b-padhi@ti.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mario Six <mario.six@gdsys.cc>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 07/10] powerpc: Update linker scripts to ensure appended
 device tree is aligned
Date: Thu, 15 Jan 2026 16:19:37 -0600
Message-ID: <20260115222828.3931345-8-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115222828.3931345-1-trini@konsulko.com>
References: <20260115222828.3931345-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
- Aligns the final section before _end by 8-bytes by adding '. =
  ALIGN(8);' or changing an existing ALIGN(4) statement.
- Ensure that we do have alignment by adding an ASSERT so that when not
  aligned we fail to link (and explain why).

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: "Marek Behún" <kabel@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Mario Six <mario.six@gdsys.cc>
Cc: Richard Henderson <richard.henderson@linaro.org>
---
 arch/powerpc/cpu/mpc83xx/u-boot.lds | 3 +++
 arch/powerpc/cpu/mpc85xx/u-boot.lds | 4 +++-
 board/cssi/cmpc885/u-boot.lds       | 3 +++
 board/cssi/mcr3000/u-boot.lds       | 3 +++
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/cpu/mpc83xx/u-boot.lds b/arch/powerpc/cpu/mpc83xx/u-boot.lds
index 1a1e537b2a76..5becc4d236ef 100644
--- a/arch/powerpc/cpu/mpc83xx/u-boot.lds
+++ b/arch/powerpc/cpu/mpc83xx/u-boot.lds
@@ -56,6 +56,7 @@ SECTIONS
    * _end - This is end of u-boot.bin image.
    * dtb will be appended here to make u-boot-dtb.bin
    */
+  . = ALIGN(8);
   _end = .;
 
   . = ALIGN(4096);
@@ -77,3 +78,5 @@ SECTIONS
   PROVIDE (end = .);
 }
 ENTRY(_start)
+
+ASSERT(_end % 8 == 0, "_end must be 8-byte aligned for device tree");
diff --git a/arch/powerpc/cpu/mpc85xx/u-boot.lds b/arch/powerpc/cpu/mpc85xx/u-boot.lds
index 3af0dfdf336b..3c9959bef097 100644
--- a/arch/powerpc/cpu/mpc85xx/u-boot.lds
+++ b/arch/powerpc/cpu/mpc85xx/u-boot.lds
@@ -78,7 +78,7 @@ SECTIONS
   __init_begin = .;
   .text.init : { *(.text.init) }
   .data.init : { *(.data.init) }
-  . = ALIGN(4);
+  . = ALIGN(8);
   __init_end = .;
   _end = .;
 
@@ -119,3 +119,5 @@ SECTIONS
   __bss_end = . ;
   PROVIDE (end = .);
 }
+
+ASSERT(_end % 8 == 0, "_end must be 8-byte aligned for device tree");
diff --git a/board/cssi/cmpc885/u-boot.lds b/board/cssi/cmpc885/u-boot.lds
index 167606357e00..da9cff64d465 100644
--- a/board/cssi/cmpc885/u-boot.lds
+++ b/board/cssi/cmpc885/u-boot.lds
@@ -72,6 +72,7 @@ SECTIONS
 	 * _end - This is end of u-boot.bin image.
 	 * dtb will be appended here to make u-boot-dtb.bin
 	 */
+	. = ALIGN(8);
 	_end = .;
 
 	. = ALIGN(4096);
@@ -93,3 +94,5 @@ SECTIONS
 	PROVIDE (end = .);
 }
 ENTRY(_start)
+
+ASSERT(_end % 8 == 0, "_end must be 8-byte aligned for device tree");
diff --git a/board/cssi/mcr3000/u-boot.lds b/board/cssi/mcr3000/u-boot.lds
index 66afdebc0f77..1fd98726b2a8 100644
--- a/board/cssi/mcr3000/u-boot.lds
+++ b/board/cssi/mcr3000/u-boot.lds
@@ -72,6 +72,7 @@ SECTIONS
 	 * _end - This is end of u-boot.bin image.
 	 * dtb will be appended here to make u-boot-dtb.bin
 	 */
+	. = ALIGN(8);
 	_end = .;
 
 	. = ALIGN(4096);
@@ -93,3 +94,5 @@ SECTIONS
 	PROVIDE (end = .);
 }
 ENTRY(_start)
+
+ASSERT(_end % 8 == 0, "_end must be 8-byte aligned for device tree");
-- 
2.43.0

