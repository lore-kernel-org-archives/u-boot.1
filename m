Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59BD6C43458
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 18:34:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D5338404D;
	Fri, 26 Jun 2026 20:34:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="DGhbEeJg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F34F8496E; Fri, 26 Jun 2026 20:34:01 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A61B483FEE
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 20:33:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-490b3637b90so8408745e9.3
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 11:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1782498839; x=1783103639;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=e+DPUP1KUki/ydzOtsBGHOev2fUYV7UG7z2pZ0Lyxvg=;
 b=DGhbEeJg6s8Jc+gTQAG4jXMi/ZOwdcGwHqjDQpvkWB1ARiJv4A7vLdYs9d1OG8s19C
 tRL78VwiYxaAu/mnjegUtqzDhNWVU/Rf+it0HwLuaGOxTHTL42J+v8q+nOc0zzHu30tY
 gpVrttjFxt7flbYw0MjZDzxpA5aeLb40tLb4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782498839; x=1783103639;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e+DPUP1KUki/ydzOtsBGHOev2fUYV7UG7z2pZ0Lyxvg=;
 b=gwRTm39y37PJHh3iMTzySMgYvgO72FIcbzVvCSKGocJgB81hy3Q5/Gt/ywNXIJGpp8
 h/PVWLHoNfOGeJxqwBXsuJTVSz00HVi/0cofx11XA/mHDkV7CZgFPTmOoF2TDsm6hZu/
 c2IpES18GRaW8uSouAUy1i/9cyjW02SP+OwVbxJMy/J+iNj+PWo2U/RqpoVtROWCr3lc
 a/NbJvvF9Z/HPdbgKA/OVVruce3DbLM1u0DG8DkPs63cCH3JV1ByuR4bFjxl3NyXoJk3
 Y6iCXAqv73as/N0cI32zOERPdV1lg4BwGN40806s82l0Dip0/E1FMYBUankNaYlblZuJ
 V5Fg==
X-Gm-Message-State: AOJu0Yzeh6NOJf9M2v7szYPcgltV7bqfoc7NPeBbX2JwH3anFKyw6Wzr
 D0O2EzY0DO9yi2Fnt1aVj2arLRJd8NUh1iWnrIIVUfe6pFiY/ONMET1BI6q7FJLiIsv0doN/Q7C
 bEY0BqwA=
X-Gm-Gg: AfdE7cksa7WvM8A+S4DEyzywLZuv4opAGugeZMFwgR7aoYLyEm1wpZ9meBtacwsofuw
 WOlAvE10SqHW2V5ieyhQasSkcI1VBdRfCylH/IKTs1eZYIxC73sYfscMCY6HXcZC5XsbbDG6Y5A
 F+Kb/3y1lwSgpUOik+YO32fGJyofHOfi4dtQo/nzvq+huxqZvEKijF0r2QOabXf8pdJyLVaS8jj
 y3EP4w8rZTUuDJ3Mh1wKR6hD218zl2hDhIkaqXWjHoRdEJhsUOmR5Xrdo7J8e0iTyHb8jtl1zbO
 QUmm2cCcZd2FFI6KRIFc0lBkF6uzhn2MD2Rxk9L88Ub5GvwmqVy9QVm6DYL0C7smwKn1k9wPR4f
 oE9eVpsLiI5I/WKnWjtUNs9dC5WKAq+8cW52Qm7cUp6l9YFsBFuF8hAwl8Qz1NdNTEEsaA4sq8O
 TuWrQREIbMrBdokldZMzhWhSlRrYn5XopCMIosk7J0/b9iwn0yDS7ear4FcklYxZNtw6ZWlBW3S
 1ztkNvExDm4Nuf0ceiIWM4VVQEhDqGifrtQKXuzjcUPwJ3SKY2n86McPQcbiSYQBwpq6EZfzQwi
 EXZ4hKQ8Iy++5Q==
X-Received: by 2002:a05:600c:3143:b0:48e:6db3:ff2e with SMTP id
 5b1f17b1804b1-49266864cc8mr115849995e9.15.1782498839071; 
 Fri, 26 Jun 2026 11:33:59 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-82-48-44-238.retail.telecomitalia.it. [82.48.44.238])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49268f7670bsm96524615e9.0.2026.06.26.11.33.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 11:33:58 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: quentin.schulz@cherry.de,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] test: cmd: part: fix integer handling in
 setup_gpt_partitions()
Date: Fri, 26 Jun 2026 20:33:49 +0200
Message-ID: <20260626183353.1666667-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
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

Coverity reports an INTEGER_OVERFLOW issue because ut_asserteq() compares
an unsigned int (mmc_dev_num) with ret, which can hold a negative error
code.

Addresses-Coverity-ID: CID 646439: Integer handling issues  (INTEGER_OVERFLOW)
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 test/cmd/part.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/cmd/part.c b/test/cmd/part.c
index e0149011476c..b01bc286723b 100644
--- a/test/cmd/part.c
+++ b/test/cmd/part.c
@@ -50,7 +50,7 @@ static int setup_gpt_partitions(struct unit_test_state *uts,
 	if (ret == -ENODEV)
 		return -EAGAIN;
 
-	ut_asserteq(mmc_dev_num, ret);
+	ut_assert(ret >= 0 && ret == mmc_dev_num);
 
 	if (CONFIG_IS_ENABLED(RANDOM_UUID)) {
 		for (i = 0; i < ARRAY_SIZE(gpt_parts); i++)
-- 
2.43.0

base-commit: 6902fb4c17faa375003124c451c2550deab5463d
branch: test_cmd_part
