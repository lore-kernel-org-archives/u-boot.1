Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA037606A320
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 12:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qGR4NaZ8;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d8rM+MWm
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7EBB86078E;
	Wed, 28 Oct 2026 12:13:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FDz4b0z_spFx; Wed, 28 Oct 2026 12:13:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2ACF5607CC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793189613;
	b=dHDVId5jvzZ995WVL0Ai37A/bICyWozsTuw4yRRYjtSBPbmdWF3n3EzV/m/54SYtxYt0
	 P2nnZbaMATBNKX44tfYBEasmK44mzPDPKgZ7CxYY6R+9v1ha8AfbUJdrAw17tTgS2+fic
	 4sR/pW/9nQZFoPVWchQya91Nt/bjyqian0gzYdFPSr+bltjafNhWt0pVf7Nrxhq//OjqR
	 ol5c8ClwCbSRvrputC25w2Q5/auq1TQcdZEFJVVs0zDmv7fW9hA2/5CBdrDt0FQKxRPgo
	 FXWsS6b2GeoCDP0JcQBjpmZpS6PKpXZLUdduHSdiAGqMVxsYJJIVY/mxnzELmLoN2vg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793189613;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Irgc/3Ihp31sJNcHURfE/7566ii2Sf3dLVOHKK4fMVk=;
	b=VMrw20fnl6IfRIH5DB6G5ZbMYEtsG/RPlHkXegPO3bASqDr2SHsOSCuth4GfjQlzMkIH
	 r+KrI++B8LYVa47+KioRWIH+YvuEDGxejGv8Ok1lpLnCZlOpDX5b9aU0zrg/ncPjQeBhu
	 Eie0eybY9eSJ4SRigRAb6Dij0W0FBEiApq8SxLDdlBM+Y8IY0eNhie3GUL20h3gcqav/+
	 JecGvF5yH4Z5GkpQxQmBztl4cxnNS7jDo869a+8YvXvzlN+vWNfg2q3wHrTbRkrEIrD+k
	 A0Opl5wgrNgpVCD7pzvj4tkfME4GaodFhATGRsrDyCKPiVSDcfNVn7ZUq5W8BqYb/mw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793189613;
	bh=Irgc/3Ihp31sJNcHURfE/7566ii2Sf3dLVOHKK4fMVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qGR4NaZ8wBEPiW+GoIhXpSepRbH9C+9iL62WbU6r0P88KQM4AcFIcOZIV08KJnBvd
	 W7uc8E2WZQkycdzhbSIDaAr6codwpc2Ptc/4iCw3DUoiKNqSootAA9X/hQ89A1xxN/
	 1S201w4AvwGLo4QjG45Pgv4hH2nCAhfCOOgRzEAXNG+yNjClSCfoF3m/twuGLDoJxz
	 yRPWJXioL7k5K6rJEXLVxHfh4JmqvEmk0GLaQdFYRvndz14pOQ3k/8w67CaPVYDNxL
	 IAnrDLKWXE6gOGI9UdVuHYI2QLSaXy1cEGFktuWsGQ+rw+YZClPELiehHAmuYYaAYB
	 JXJyM5rwNKLKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2ACF5607CC;
	Wed, 28 Oct 2026 12:13:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 84F532AC
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 12:13:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 76B7C400D6
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 12:13:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LlJsNDQgJK7O for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 12:13:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9122D4009E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793189604;
 b=E0pf4Yq8CNaI2v/LEIAbbWgCL2Y8gg/XnKHuSZejUDq0qgEANG17UXyLwfQk+u8WIcEE
 sDdsuXXJ1BWT7TIUnZdv7D/kyu228uul+IsbwYW3bn/MjI0pMq8a6wfTDGQpzS7BP+8AI
 KzTUBlCPBGXWsdKOSPWR0guRXztijN45QnTxwqELDoXzqKMkYcOf2sfd0qJvv9lnooXUa
 MJ3ja4LlJkZbQh4if2i2DR8bUj1cREd4SMcUTa/hrAAl3fvZNJSeNBBYgRq7VGOke4kS8
 J/6jQW5gl9eoMtkLIjStT//kZNaetNMK5sn03gM8wKuXCciWMnHDipcESPN25klaFXw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793189604;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=Irgc/3Ihp31sJNcHURfE/7566ii2Sf3dLVOHKK4fMVk=;
 b=j3WOXjO1dnX2IG3dr1Wb8h4U+MRVw3DRDw0p3Q4yKLViJ7Q95oLbs3qhw/HJf3F7xThS
 l8i/KvWpHFTcazXOW0ZLhpak3lWnFHtfEjCAtZx03CUFpOlVXkyaCmWSJsZ7EPfHm4AB5
 Z3o5guW4mIKU43l4jUrzT/VQNwJ4C986UTSeX80AzGO+FjwLJHSAeK7VYGkZ1xcsVeW+/
 QZB0O24lOpW9I3igaWEYLgkZgxnAmaWyHS7MZKSKuicro4BHDpq3uIybSryHuaeT3yKq7
 6DgPBc3x+aUtPpornV4QHqr2yv1JqaiKdwXu7FxqaaUvaHzFOWKfu1lehtCfhp8yemQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=d8rM+MWm; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=d8rM+MWm
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9122D4009E
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 12:13:22 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso6933335e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793189601; x=1793794401;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Irgc/3Ihp31sJNcHURfE/7566ii2Sf3dLVOHKK4fMVk=;
 b=d8rM+MWmmAAQ0pVpJ9hfjtwfFap8VL0LCjAa/TCWzzIeyDsttexajXzfG+8dVRLibc
 SaqUts30QxwKnknNt/etr3LIt+z+RqDNz8pbh5G2d+wC4VEpzKJhKoVwkU/n7p5euhUt
 oSAQMPT4xVsM6BsWGdzUgR9YMQIzxSpj911Mt31K2TqRldFpR5TcC1dBRBYh0eKBzzLj
 sE0tVOKAB+0hPkJnChBybc21HRdLCa5fAgpu6qVq8x2D2sDea+4a+ajmtNn4+7mOG+/H
 nBx4/tJNvK8i55KopM0gWSAz6aCzuh3+DCEwCIY4qyVYMaPnL9g7yBZadavGyUaqDD8S
 Am/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793189601; x=1793794401;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Irgc/3Ihp31sJNcHURfE/7566ii2Sf3dLVOHKK4fMVk=;
 b=JKR5O0RsxR3gsjSdNX9F61cPY4vb+HsDGzhiJzWmFMT3Rj7GnGRYRklOEw9UCg8KHO
 5+OJMJnhqPDJA15l+Mpec1KQCGfjnKRjjwecpBEK4tjdcLyV4rxA7JZvhwAz8soRCTWS
 Ia5URmFSJFay4bEY5Ff9kSMeeXjOPUL2rZ7TkB7FOOJ6oheYEtj2RemNs0Igz2vrhuql
 SDIyZUXRad2rof9tYj94E76Ud1rFe8X4La6TXKxGEkNv0bIh9rSl8GaA6nZIKl5KYCJ2
 9XGasZ4C1ogBS1KaKfes4akwtJEruuQq4qlPv0srpk+BrxqbOXvKHjTi7GkG9pFOOZ+A
 CCtQ==
X-Gm-Message-State: AFq9FYKQ6JVoTZzTl63Pijn79p3UW5X9dDGSkY6eyRYNJrfKJ3v3jqHn
 d0fWvMOEMhfbTiR51b/k/JtmER+dFnb3yTv9zvHuA+PytaePeT2hsAfp5gnStSz4
X-Gm-Gg: AYBFou0f7jUM0uYdYlxDjbiCVO1f7G7IGFnKOn2v3FsDSdsx4hKwVwSY4T3E2llxbD1
 NsMrxpTtBiT1rQtoGcR3Yt+Q+S2jRi83oP93pakUrN7xqqZpuZjhSab7GXeDOBc1ToMhd9y6b9y
 V2haOXB54RrIpfDURwgWriw0vI8MdI7eWXg+z0O8SVfZUPXw9mGcKUJ/WZE8cSQc3T90N9gRDrv
 w3xiTiUC0fP6wOaglESJhEZshDck5iDONWooHP9Y1wLu38V1YeQQH7TuIP/L6IYqzJuMxhn2jMD
 r42tU0VrZLM/lZ7Hg8gS9Ne/vY46xEBlqo9A339K6Wr7r5Y85LZkl7JxZdhA+IakPSbTAgXey/a
 AP10VD0LZLRyRy6Wh90MkQBeqWHjf9vlU1hwzxrga3aiiQ4WuFcnSkf1qbG2oAeyku8lrv2ZyoG
 MXdxfgfyzJH4G9HEYzPmHaYTEB60ET8gZ+kgrEb8eazDc3Iz+k3HVdni5KQVOIDzKocY++sS5g1
 SjohcKy3YsunV6Ui4ZH7NMPJp8RhYbb1MyhjZ2DF3f2CxGERn6yOoKdpiTpIgpjpXyykRnPbv56
 r6CR8cFHJ588NF37LOrI5Ma23437bk4qUiNjqDHSnDZNU+seZ2l8FwXr/1nz+NC+J5kY3A01aE0
 g89BrqOYSfSMk6YZag3ky6vRJ8Ykpkx2aZnoDnxP9Ay6nx1KJ6LLQqQ47sKYVW44LisTLv2B9Q4
 btVJpyQaK36ws/PmS54tJ1CpxHDhbSkPmwxi6eE/rGiS3i0uE4CTR0
X-Received: by 2002:a05:600c:5246:b0:4a1:faa1:3813 with SMTP id
 5b1f17b1804b1-4a9674e813cmr42802495e9.27.1793189600827; 
 Wed, 28 Oct 2026 05:13:20 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-301f-0e2e-7b95-b045.ipv6.o2.cz.
 [2a00:1028:8388:a84e:301f:e2e:7b95:b045])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a97a093e86sm41139085e9.1.2026.10.28.05.13.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Oct 2026 05:13:20 -0700 (PDT)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Anshul Dalal <anshuld@ti.com>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>,
 Sam Day <me@samcday.com>
Subject: [PATCH v2 5/5] Makefile: Set LTO_ENABLE before including config.mk
Date: Wed, 28 Oct 2026 13:13:13 +0100
Message-ID: <20261028121313.814-6-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261028121313.814-1-pepe.schlehofer@gmail.com>
References: <20261028121313.814-1-pepe.schlehofer@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit a55014d09b29 ("Makefile: Allow LTO to be disabled for a build")
made the condition in arch/arm/config.mk that leaves out
-ffunction-sections -fdata-sections with LTO test LTO_ENABLE. The top
Makefile, however, sets LTO_ENABLE only after it has included config.mk,
which reads arch/$(ARCH)/config.mk, so for U-Boot proper the condition
has seen an empty LTO_ENABLE since then. The xPL builds are not
affected, as scripts/Makefile.xpl adds these flags for them anyway.

Set LTO_ENABLE before config.mk is included. After the previous
patches, this leaves the flags out only for U-Boot proper of the
32-bit LTO boards without SKIP_RELOCATE_CODE.

Fixes: a55014d09b29 ("Makefile: Allow LTO to be disabled for a build")
Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Marek Behún <kabel@kernel.org>
---
 Makefile | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 6303a0cca6a..547053d7bab 100644
--- a/Makefile
+++ b/Makefile
@@ -819,6 +819,13 @@ u-boot.cfg spl/u-boot.cfg tpl/u-boot.cfg vpl/u-boot.cfg:
 -include include/autoconf.mk
 -include include/autoconf.mk.dep
 
+export LTO_ENABLE
+
+# This is y if LTO is enabled for this build. See NO_LTO=1 to disable LTO
+ifeq ($(NO_LTO),)
+LTO_ENABLE=$(if $(CONFIG_LTO),y)
+endif
+
 # We want to include arch/$(ARCH)/config.mk only when include/config/auto.conf
 # is up-to-date. When we switch to a different board configuration, old CONFIG
 # macros are still remaining in include/config/auto.conf. Without the following
@@ -858,13 +865,6 @@ export CFLAGS_EFI	# Compiler flags to add when building EFI app
 export CFLAGS_NON_EFI	# Compiler flags to remove when building EFI app
 export EFI_TARGET	# binutils target if EFI is natively supported
 
-export LTO_ENABLE
-
-# This is y if LTO is enabled for this build. See NO_LTO=1 to disable LTO
-ifeq ($(NO_LTO),)
-LTO_ENABLE=$(if $(CONFIG_LTO),y)
-endif
-
 # If board code explicitly specified LDSCRIPT or CONFIG_SYS_LDSCRIPT, use
 # that (or fail if absent).  Otherwise, search for a linker script in a
 # standard location.
-- 
2.54.0 (Apple Git-157)

