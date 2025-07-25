Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFAB9C87FCE
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 12:58:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FB7C839A8;
	Fri, 25 Jul 2025 14:57:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="epSiZ5+j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B32318398C; Fri, 25 Jul 2025 14:57:36 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1F798399A
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 14:57:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45629702e52so10096085e9.2
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 05:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753448254; x=1754053054; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TRC3mvndYmNJvlM3uLp9uRFtSSyGuRfSDBCHfL9d23k=;
 b=epSiZ5+jXDC7Vx3P7TJrHodfSWezW8RmWM3ZwPtMrgoAjmzorUd6Egq7U0P6HBK9RD
 HwpR7IPNm5z5pP0QiFnAgJ0bijtPOH97qsQY2k8I/EqtRWIL5ixuQEY+weZnj4oImdsJ
 XV/jT6od12BhWXlZCZEElyQuiCY1ED5IAPp6CIcQqUYl1UdG+intVzzWhL9hMdBHVhP/
 RJqQufKgIMVoAbxpPaNBRYtOuWbYL6u7hHVCOndy9+Ag1CuyCt83/Ks1/BZDn/TI+9oo
 z5KFc5T8ec8MhNMtwLI6U4LLKcRGFOQim+OfMybcLIztdDALDcwCcydhz0gRwONHbhs8
 BGWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753448254; x=1754053054;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TRC3mvndYmNJvlM3uLp9uRFtSSyGuRfSDBCHfL9d23k=;
 b=FpLavcnux3WycDZ9e7GDbEiyjOfTjdzbWdVyYIEmgDnMDdN+ZSxcOr0mVMR/prqCIY
 pC1Ac+Bb3kN5uVd3TbhzPVOcnoiWL/2SB3yr/oLvu608Hco/YnRZbmfLLWEsdDoFXd/l
 JRj9Fh3Y3mMBK18V9yXqFnQXtyC4G5PHBeRHQ/7iLXRF3sCkQoQF29Dt+LNbr1x1VQAv
 D5eAjI2l2VrNw0fyyDTdm4AWQUAK2Rmml0cItNPOg5OGsoSw9H8OSZdKrsBV3RwcttgX
 NyInjDUdMSw2SEBStwFvN/8/WWvjiLXA1mPe0F4N9ekgq8V263MqaAn3C/OPbzbf9Dts
 2vFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFGCMsRANHPvxk43IqKudpGRrgEnJDKIjDZnH/uMuvZjlR75rI5sbvTRQ/8jnRFdgwTJ/0llg=@lists.denx.de
X-Gm-Message-State: AOJu0Yz4qMFcqAvGaCvMeFbSS24Idik2mHAy2Og+N3pNX5OXaULEfrt3
 S1mSZZrOfjVeOLUKN8sPQzADH8YLHBWa9fvcs6NFcmGT/gYjCfUO4bLeqMycQpzxZQM=
X-Gm-Gg: ASbGncsG0JjjEcWgw9ja2Ha8Cw6+TlZ3TME9pU0sd+1PSWJoXlTx482VUMC2+4Sgb7/
 lIBXTUg8sww5xtX2c3NnwNW/2KZ4+q/BYb2jtd85L73i2ekB8zvUj5m8aMlhngouqT6oU5DkrxI
 sS+lbdWSwFAe4nz712MWavQXA3lz9eubeyoAXTd0bTWUIH1OytFctzYkEu26SOY5zzUPT+RgKXo
 NkWpuDbt0IrhAF+si23aHLs0CFEKIMYHbxyg/f0YOSylwZUvRyAhJU3/T0MrgpDTPgipSKHfjuh
 Au1O5Mcp53PoJmVTbt/FfbsL9qlJnFbV6IlLw+RFI1HHswkj1Ksvl8iGeDg9Tk+BYDduvFX7ijh
 +qjv68was2x0g1ip0AxFN93PGpMGMc3C2bcSj5OrL5r3uQ1vDMCujN3r6ZTevMipApg==
X-Google-Smtp-Source: AGHT+IGgnRDPOCl9PXAK8KvmZwDBQh8Ai8QK+nB7yEM8ErGSQnxCY+gVAf6PhNCUJDqIS7+B2cb0rg==
X-Received: by 2002:a05:600c:1c86:b0:456:1fd9:c8f0 with SMTP id
 5b1f17b1804b1-458762fd0bamr17743575e9.2.1753448254097; 
 Fri, 25 Jul 2025 05:57:34 -0700 (PDT)
Received: from lion.localdomain (p549d4bd0.dip0.t-ipconnect.de.
 [84.157.75.208]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458705c4fcfsm53115355e9.29.2025.07.25.05.57.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 05:57:33 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Fri, 25 Jul 2025 14:57:09 +0200
Subject: [PATCH v2 5/7] arm64: initialize the frame pointer register
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250725-b4-arm64-backtrace-symbols-v2-5-230a9665085b@linaro.org>
References: <20250725-b4-arm64-backtrace-symbols-v2-0-230a9665085b@linaro.org>
In-Reply-To: <20250725-b4-arm64-backtrace-symbols-v2-0-230a9665085b@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=938;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=cAVslgfAJxDHinnp66+Btex1V8Bz3i/YgfSMstEDfnY=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhozmejMpWeYlnCUBiwsvuZn/Lj+3e+m8mZdcf8yT9I/UX
 q+pavK5o5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAEzk6VZGhmllzwR7Ok5O+CjJ
 1uU0K03IfNN+kZdbQnLimX+fyXrqV8DwP2zPTYF1358uj/BhYHi/brVk6wFrPvHQz5uVzv8utuG
 oDQQA
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

From: Heinrich Schuchardt <xypron.glpk@gmx.de>

U-Boot may be compiled with frame pointers depending on defaults built into
compilers are via explicitly passing -fno-omit-frame-pointer.

To stop walking frames it is necessary that the initial value of the frame
pointer register is 0.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 arch/arm/lib/crt0_64.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/lib/crt0_64.S b/arch/arm/lib/crt0_64.S
index f3f279f2c39c..3ff0577e9c87 100644
--- a/arch/arm/lib/crt0_64.S
+++ b/arch/arm/lib/crt0_64.S
@@ -167,8 +167,9 @@ clear_loop:
 
 	/* call board_init_r(gd_t *id, ulong dest_addr) */
 	mov	x0, x18				/* gd_t */
 	ldr	x1, [x18, #GD_RELOCADDR]	/* dest_addr */
+	mov	x29, 0				/* frame pointer */
 	b	board_init_r			/* PC relative jump */
 
 	/* NOTREACHED - board_init_r() does not return */
 #endif

-- 
2.50.1

