Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9FD1C7882B
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 13:02:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59A7888D36;
	Wed, 25 Sep 2024 14:58:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kkGTBnFg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A44DB88D1C; Wed, 25 Sep 2024 14:58:25 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0886588D0C
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 14:58:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-53653682246so1237006e87.1
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 05:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727269100; x=1727873900; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dLLyvDkf5gJ+hqK5Vec9TXviVOInvFkQZkC8/eLLa8E=;
 b=kkGTBnFg7dQk9vwHMVYiPF8P6VzpxqUueYvq2uxdUNSGW/1BTpCfLLkdjxzJbfkbMt
 GeFliIYFJMTngEPyjtfqGJgghlOnU8bMeffJDvB2l1qEJpZK9iMFp43ljNrtyl+mpwzs
 k3xcMj9HTnlJM5IVO4YZwmBnOpxRHOYwFK/Lw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727269100; x=1727873900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dLLyvDkf5gJ+hqK5Vec9TXviVOInvFkQZkC8/eLLa8E=;
 b=KlTJfUjB+BaAfTaefEBoucGBGg51GQ3PRpxhDmXQqFWQ5CA5FyZnREHxtDwLH2rxfi
 7gD7MG8rjoJG5diYTNYdsBQwfTUcyK5BkkWAIunkB2Rsc5PQh+GnsO3JOb0HsO/WKgQY
 M0N4lZ0/Fovpz46yLvz4ExUkLmJf3HIQajyHBYTONvjlpiXtUYvGTN+QG9JIJ7EzDW56
 IFy0alIG9w0dT5Mozu2MVSIL7lnetveGsoKPFwgu8UUxFsLO83awW1NcUQfhAUTMjEmi
 psI/i8dA6o+xqtDAVolNp5EyRxuGYT6P7Wo4iT1MF562+sYFPio+Be0pyFA6MyI/MiOV
 caWw==
X-Gm-Message-State: AOJu0Yz0vw2KVVUuhmkgXGIperWjaFaRhoqEunScsn183a9CVGMRpm0M
 DW2Hb9Je8YaVte0kNdre5udM5W0GShXGYJ8TF0HWguVajSCpMi2K4cJnEMJi3EZZwvtt3dFihd5
 GKg==
X-Google-Smtp-Source: AGHT+IGqEsr9SDkyRySjhxpl/zypF0Mn0RlFBLT0jWcwLJAtx8aM6IAoAW77uHS1NmdonIxahMqUSw==
X-Received: by 2002:ac2:4e07:0:b0:536:5413:2d47 with SMTP id
 2adb3069b0e04-5387c2b3059mr1760893e87.41.1727269100001; 
 Wed, 25 Sep 2024 05:58:20 -0700 (PDT)
Received: from chromium.org ([82.132.187.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93930f7889sm209209766b.179.2024.09.25.05.58.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 05:58:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 17/19] arm: Provide an rcode section in ARMv8 link script
Date: Wed, 25 Sep 2024 14:55:43 +0200
Message-ID: <20240925125622.197915-18-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925125622.197915-1-sjg@chromium.org>
References: <20240925125622.197915-1-sjg@chromium.org>
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

Collect the relocation code in one place so that it can be used by the
SPL relocating-loader.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/cpu/armv8/u-boot-spl.lds | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/cpu/armv8/u-boot-spl.lds b/arch/arm/cpu/armv8/u-boot-spl.lds
index fed69644b55..a296af39320 100644
--- a/arch/arm/cpu/armv8/u-boot-spl.lds
+++ b/arch/arm/cpu/armv8/u-boot-spl.lds
@@ -27,8 +27,16 @@ SECTIONS
 	.text : {
 		. = ALIGN(8);
 		CPUDIR/start.o (.text*)
+
+		/* put relocation code all together */
+		_rcode_start = .;
+		*(.text.rcode)
+		*(.text.rdata)
+		_rcode_end = .;
+
 		*(.text*)
 	} >.sram
+	_rcode_size = _rcode_end - _rcode_start;
 
 	.rodata : {
 		. = ALIGN(8);
-- 
2.43.0

