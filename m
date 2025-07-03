Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8899C83F03
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 14:40:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6816E82063;
	Thu,  3 Jul 2025 16:40:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="z8EKaS/O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5529A8206E; Thu,  3 Jul 2025 16:40:50 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62F4D80E9A
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 16:40:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-450ce671a08so37906285e9.3
 for <u-boot@lists.denx.de>; Thu, 03 Jul 2025 07:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751553647; x=1752158447; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VdxhT6DOpoeO1x8Cejpt7ny08kS8cmvqm9qrT4ZEAEw=;
 b=z8EKaS/ONmiSNOH4zDr33y7eHaUorZYJ7ftYthLMrdxLJE30BZRw3pbkDPsbpr8mSU
 YyClfhjOjANniS4/ifZffqTl7Eoq4PHcMsToXM6HKBkpw6mRo2Zd71XWEQCcPwxyJaVQ
 zxxuMYUT2XMvDo9BMJn4wGzhuUG+p4VlFANxhutJaTnG789lOKm1pKYCz/wKlOwo1P7U
 CJfEiGhe7LeIMGH4sefDYGGW5ED+beXD5xuxJ/nCU1LNE/GGw45zFf8OT8xT2846bPyO
 lzmMrij3yG5KpJUmzvyVfVvQa2NLmHcg+LFX8qZErKC3AWC4BR7IlhClqgpMjUTCft4A
 6QMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751553647; x=1752158447;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VdxhT6DOpoeO1x8Cejpt7ny08kS8cmvqm9qrT4ZEAEw=;
 b=V9HMjWJ4Gg9Q9UjIuDKVl0f9aiDYSyOiTALgJ81imaNq3iboE+jSt/HFeGucpQqQ/l
 fmVE5TZD7OBrZr7Yft/RwnAe5FoFb6zVgJ7bTC52oYRp2M+DITKY3s/lCwTVqSy3GF2l
 NaeXh/onq8sqEVVCIF4uUrMmsBBqAcNokAYkWL6jpzGDVE+Du+VIW9crvsQdRWBFCkx/
 UsA4Qg88LdtCAekKOy7xxNmmIv9nRy0ivhhpshcmJT9hJhfJ/BcLdpBEdDd7bG3kcJEv
 9VZF7jREjD9U9rLcJkncrXKyvLYmRhbodUraqeASvGQEOJqjE/wA1DIWJw/0z51HRr2e
 MJ2Q==
X-Gm-Message-State: AOJu0YxS9gQyXzf9L5Bnn9xC44w/4qFZ1G11z/GkUv1PwRU3x1GpVuyJ
 b6fvH+GLVb8ojuRVLdpAVEs0cmKJnElE/aVrWQnKuUPO1KbTU3MF3jWN9oaKAHTiVKG1xBYfMpb
 0nwUP
X-Gm-Gg: ASbGncv0Jp00HZdahyWmx0eb8iYvYvvP5cFLfb4S6JKw1uPcs6nsAEIR5Z+Rt53PZqd
 QsFFF7AjeOiRXMJVtaE6VTlWki6Ed8J51M+DGyEvG4hXKIqpK633IU2SZ3KgqLC6POkOWyvYsLR
 aEppwHPduXLcpl9uca+DlG1qqSIKTxD0tLB9JWxw4iitU2lvuDkENndcpqXyM+JgDj9ilCJR+mD
 GyzAr3MQ9ZriIkSlQ4GHVvK3ngUc1RjfwSbiO3Bu5FEL7YfD+ei3/NbzWtOF3sEaM/GymttYbCa
 nPjnRoY/DkHg9+nr2z6gi5OWGJKbWOBkIkqwVYrNGdmoNpW1AxldPmVHzE5a5gHzTfyTIiyHMvt
 JFRNwFCzH1ttC
X-Google-Smtp-Source: AGHT+IFK/91ww6tndekhIE3gZEh0aA2cbTo+7uVFa2mt0hh47pNWz6EffNqEDirgyZL7rYT1ySZ+zA==
X-Received: by 2002:a05:600c:3b82:b0:43d:abd:ad1c with SMTP id
 5b1f17b1804b1-454a3b34003mr73913385e9.6.1751553646788; 
 Thu, 03 Jul 2025 07:40:46 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:e07:801:b5c8:44f:55cc:3182])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a98ebe2asm29534635e9.0.2025.07.03.07.40.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jul 2025 07:40:46 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 03 Jul 2025 15:40:46 +0100
Subject: [PATCH] clk: Return value calculated by ERR_PTR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-clk_uclass_fix-v1-1-9b6cc81c9490@linaro.org>
X-B4-Tracking: v=1; b=H4sIAG2WZmgC/x2NUQrCQAwFr1Ly7cK6WhWvIlKS9dUG6yqJilB6d
 7d+DvOGN5HDFE7HZiLDR10fpcJ61VAeuFwR9FKZUkxt3MdNyOOte+eR3btevwHc77YHSRBpqUb
 CjiDGJQ9Ldmd/wRbxNNT9/+l0nucfva73O3kAAAA=
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

In clk_set_default_get_by_id ret is passed to ERR_PTR but nothing is
done with the value that this calculates which is obviously not the
intention of the code. This is confirmed by the code around where this
function is called.
Instead return the value from ERR_PTR.

This issue found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/clk/clk-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index 2167cd5ad0f..cf48de766fe 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -194,7 +194,7 @@ static struct clk *clk_set_default_get_by_id(struct clk *clk)
 		if (ret) {
 			debug("%s(): could not get parent clock pointer, id %lu\n",
 			      __func__, clk->id);
-			ERR_PTR(ret);
+			return ERR_PTR(ret);
 		}
 	}
 

---
base-commit: 7027b445cc0bfb86204ecb1f1fe596f5895048d9
change-id: 20250703-clk_uclass_fix-eaf648b2ebb5

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

