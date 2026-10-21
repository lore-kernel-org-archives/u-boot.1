Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E16F606A31A
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 11:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PEuJ9+9v;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=Q4xp/W7S
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DF2818100D;
	Wed, 21 Oct 2026 11:30:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G_AlWUXIC0-M; Wed, 21 Oct 2026 11:30:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C74DA80F24
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792582225;
	b=iaBE+8GHs0LJ7iGagcuvZR22sf0zO5PfRijkGjywsIrsO0ZJfq6kQo/YM2VwYj/WI5Dp
	 le2iWbZ8oQBSQH+7ONrGUOwXxkGEfrSNenjBAPnAFuYS369eaFLeA9bB0LqZGfJzyOdbg
	 U7vMPO/MU0PdP7omIj9mREmrJIrB9zrJIAS9MHGM1IK/AiDy7VI/W0DgBVpEBA+wQKmSk
	 z44YI9hE2yFHCejY7n8y/0JbiBvG9CE33FXm2RNxpCpNz7MrheFkiETdCowcg2dr2HUKC
	 DOnzKT3IOeYHhQz9yK8Ob3uvfvKu2I3nUwt4Xlyh4LMFUjrxfj7legn7sSXxUDkhE4A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792582225;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=zYX18Gdg6qqJRBoCMXR7eCCrdcWzYBNcqeOGqPwDSQ4=;
	b=gAllulRZpKHViXS6hM9kQMb3Gb++qbZeqLO87hjwmg6JGxmkU8QBAOcVZOKnZZY7orsX
	 eMKZGdLb1M92htBJO/xsuKVOKqWxSsvl8CFsVLEpt3a+XYsYCwVVUSbHLpqZX6S/on+lc
	 3VVh4Un/ma6JONFEnpde/yQIg4cGEXeRAF6GnGmu+p8bDv3tIFPKLuhk0GrbyGBe9f6Mt
	 iE796IuJ98XMkB6IH2ddepFqfQytMwKIC+zRBVF0BPk3EFUQuOXALuRXLc+kfDCVmfklo
	 jsrSzvuVTp0aldMHFyr+6swWsb535imi3vNnH1eZwOhrvtSkJGKBUmTUkd5Rqe1v7iA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792582224;
	bh=zYX18Gdg6qqJRBoCMXR7eCCrdcWzYBNcqeOGqPwDSQ4=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PEuJ9+9vYkdTa1G4m94eqxrf7UYz1gOJQhPxtGOwCSMadNU1/HICAjqi8ujKI/hxB
	 zhmAh+cRyCQh9jxvH0RhMRmhVAQn+2KObrlpJ1lbOCLeeyxxkNaZaEFd8G7tLSmkAX
	 u2NAd/iAQhJghUYoD6VBVaaepcD5gCTcqm1F8JrWxcnFX8ZKzo0/ZjAFEsh/b1G7jo
	 Ci+WcUNE23t1NF10smgpLgx5dtn4PqNMqYjThVy5FOo0FFeDPo7JrpBcZREkLAlp/L
	 yZqVb300ATQJFFWAsIPb2AbAQViR1FKJKdwKaIby5AVeGylMxVCjfLBN0Rg8LaAkLU
	 mAh4jd6gMHtKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C74DA80F24;
	Wed, 21 Oct 2026 11:30:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A83DE1AB
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 11:30:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 99F894007E
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 11:30:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rb5JbC1W_dnv for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 11:30:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 59DFD40060
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792582220;
 b=ZRpaIUCFFmtNmOq0rgjNbVx3cRHfb0F9YY+oYEda1XBomE8thQK+iWOG8AKticG+4qUE
 QrK6p9lPV5BSj4eEuIxWcnh26yt8aPrq45evYYQG8422bP19SVlQoH1GekyrhHEjOlaQf
 k6WAEodmMqREADziUIgnUt4ajDWypDllhxTewwhVeaOtAi7f3wMvLY9sB7zMLei4j8k9c
 39SMjCKIqXp2aw2Rc0GD9QUQ/nxQ25Yt9zyO+fOU2mNvdYr70SqeeQQVvhsxg+tK+drCM
 a5NS2/LKPd2DRjusld6IZRPF2dKQwyLBvUe+SE8qPV/gCusL+5240LjGY4z++eEldrw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792582220;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=zYX18Gdg6qqJRBoCMXR7eCCrdcWzYBNcqeOGqPwDSQ4=;
 b=ickihJjm7X3E6e/zcvkThp/CAocp6LcjqeHFF/TJafUVjDf6CtaIAWD8K1jxjj90rQZG
 gSFO56CgYHKvoEaujReV29i8iTTbaoWdA6E25OAeHly+TbKibiaQs3lRwWkw7wxMxTNnR
 MKFSrOxBi0AJd9ZQw2pFGwntvB0ek7iuVyXJHcxgcKtzxD6+ITa9ma9Rz2eQ5H0oyrkph
 AFEhg1z5gtezh8Ts2tSIXknzf5vIcoq/w2ocsjQPL2N7qRNPUOQZgLbTBOpVbu8HIT8X0
 Yz5qbko58+Ep/FWlFpwzPJ1D3TAg9n4CgT586TAt/9pZs5P97h2c9aC+JI1hBVunFWg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b="Q4xp/W7S"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=Q4xp/W7S
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 59DFD40060
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 11:30:18 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48bbb06e746so330636f8f.3
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 04:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1792582216; x=1793187016;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zYX18Gdg6qqJRBoCMXR7eCCrdcWzYBNcqeOGqPwDSQ4=;
 b=Q4xp/W7SoICZYCIBhFr4XPxbAPh2wJcJEK4h09REaGP/oRjwCYmTa+odvs5/2oFdHJ
 QdQtNg3CRUn1zUoNaBYUsVgJN5Q4DdJqUlwBYBqlUcsFRnl0lWM/XrmiphCgtZ18K1Xc
 hCFcr5G09ODjR3ONLv83aqCY4rj+RelC1Nr4rKCb54OfI1e1EXCUjsrEjmyLjOR6RkJY
 EUiI1/TAZcI4Ofl2u+ySPeAFgZXV7+EhoLO7WWbo9yI0g2VVsIefgM7+LjCcdullXmhH
 Sxzg9U+c9JKPf8P3c02z+1lCNh5ARFik4KueTyqw3ZAZ57oSDinhAN7VS52gEvo4mHUJ
 i2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792582216; x=1793187016;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zYX18Gdg6qqJRBoCMXR7eCCrdcWzYBNcqeOGqPwDSQ4=;
 b=mKluaRimURykhhMHOriZvxRJY34vuHqmeAABrCTbXxZcs2Wf4CgjBEAtvfCFWFmMxF
 yocfPf57TNeh4IYD2uD7ofPqwt+oLlUr+Y6O7wNrqLj0/L0CTpKHzoQslo9vW4Tt85ec
 ZX+h6rz2zB+ewjCTeY/v6+T6CaKLr7GfNUTUkmLXqXYOQ18v1iGCrXhhKkASYZdsmxpZ
 9mI2jDVdHK9kqmYmRCCOJTVCiI/8cNz3+quuvV6uyWHuL2Ti9i4T0tAY2stw7piVTIDa
 Ucu0Vgm9+E6qjBSS9RPva6DmTp3hBs8Rk2jtBUPAfDghuPsMdVW6mRe/x0kc8lWlbzX6
 M1Pw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzX7GjZqqRK4SoGFptBFOJuK4iEDN0WIICBw3aDuEX701or7ejQNyG/DixNVrgEcNRlNXsTc5A=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLT7dCS1WHsTJwihhUUGQ2OfW4TlMgQj04raxlwA1UGxO1yOa83
 lHeCU1yV0w4CYJJ20ayci9Wp+xa1L3/dCTO+Eio7CceIUsP8xawMoxhkGvyV4vLtLmo0mK1NPg1
 wrIpMHG0=
X-Gm-Gg: AYBFou3SIkrpBcycLkqKfnA+av6yPECkUYy0wPeFzPS6nLe9pmz4P7YLMtLNvDjZaDF
 UOZsN/8uyY0Ejt038TNkaiZgVapWaB/oa6cR9/PHrjvINZab5LgoXEfiXcydItWQ2mWAKX9x3qc
 ADdGLbtyf4BzxL1EQrOq/zsI5Ba0hzY3bb+VuNmFe3DwJECVoBYYm2tm3VF7FET5rXi6T/0I7hV
 odNXFl9pX6LRauoUHSJLNm6oNw1oT+vlQ2A1jQcLX8edR3zetTb8QV12xIGjBuEtCsYijwJA720
 Fm2Rhuck+n6DaV8H/ikCLx3CVDyaEidxyNyZ/P46E+g46Fzvib+Kmm6wdYAVsjBSSdYjLTknbPP
 UtzBZtSiIATSZv74aW9C3rg25GU7YgEArJoShAPP9O4kbuxPOnrFfu2u3D7LqAD3e2BXGTMn++J
 kTpmAkNpBRVU6ZOEJaeBTMl1c+BmTAEv0Q9z01SWotNY2RbrtoLsLklGkfMS7yDJG0RTyKC0ZWy
 NHpxoS0te1+9hdKJx9D9WEJjYWKtwY2xk+eEjArcHFnyfIpW/h4wavRyT37JuG1ttCov1jQfX3l
 zBV0UWY13cNgnNL9HlhVpGHfe5Atx3Scx+VDMcOGaKtNhfyChUG2Jki2bw==
X-Received: by 2002:adf:efd2:0:b0:48a:efed:ac97 with SMTP id
 ffacd0b85a97d-48e264f06c6mr2428818f8f.33.1792582214853; 
 Wed, 21 Oct 2026 04:30:14 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae.
 [86.98.194.229]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e2581f0bdsm4814932f8f.19.2026.10.21.04.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 04:30:13 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 21 Oct 2026 15:30:09 +0400
Subject: [PATCH] test: dm: rtc: stop both RTCs before comparing them
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-rtc_dual-v1-1-8cf78da56d8d@flipper.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM4QpAMBSG4VvR+W1lK1vciqTZzjgS2kxK7t3w8
 6n3+y4I6AkD1NkFHg8KtC4JPM/AjHoZkJFNBlEIyQvBmd9NZ6OemdXoql4rJUsHKd88Ojq/q6b
 9HWI/odnfPdz3A98DnO5sAAAA
X-Change-ID: 20261021-rtc_dual-daef9ba7765f
To: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2680; i=alchark@flipper.net;
 h=from:subject:message-id; bh=eStpN0oqw7lSbwh8vmBOUGh3HNsoyevY6e2KVAXwT4Y=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTdWOR2WNFoT36P1euLWbs8Dv/JnVs2b/2N2sNLGQR2P
 IiQvn3iecdEFgYxLgZLMUWWud+W2E414pu1y8PjK8wcViaQIdIiDQxAwMLAl5uYV2qkY6Rnqm2o
 Z2ikY6xjxMDFKQBT3biEkWFWoHfr9ztTMj/s5creeO3Q4ccBVbNs1rEknWH5GDPlyPT5jAyNxc0
 mKUUO9xU/WB4uWZZw/XKa4lKLswpL0rcmVC0OecIEAA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Each sandbox I2C RTC emulator takes its base time from the OS when it is
bound, and rtc_dual reads the first RTC on the live system time, then
expects the second one, stopped on its base time one second ahead, to
differ from that reading. When a second ticks over between binding and
the first reading, the two match and the test fails, which happens about
once in a thousand runs.

Stop both RTCs on the same base time and offset before reading them, so
that the second one is exactly one second ahead regardless of when the
test runs.

Fixes: 4772511475ce ("dm: rtc: Add tests for real-time clocks")
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
I got lucky enough to run into a false positive from this test while
running the CI test suite over a completely unrelated patch series:

https://git.u-boot-project.org/u-boot/contributors/alchark/u-boot/-/jobs/119251

Apparently it has never been caught in over 10 years due to a rather low
incidence rate of the underlying race condition.
---
 test/dm/rtc.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/test/dm/rtc.c b/test/dm/rtc.c
index 88f080b64a83..874c21a96762 100644
--- a/test/dm/rtc.c
+++ b/test/dm/rtc.c
@@ -284,19 +284,30 @@ static int dm_test_rtc_dual(struct unit_test_state *uts)
 	struct rtc_time now1, now2, cmp;
 	struct udevice *dev1, *dev2;
 	struct udevice *emul1, *emul2;
-	long offset;
+	long base_time, offset;
 
 	ut_assertok(uclass_get_device(UCLASS_RTC, 0, &dev1));
-	ut_assertok(dm_rtc_get(dev1, &now1));
 	ut_assertok(uclass_get_device(UCLASS_RTC, 1, &dev2));
-	ut_assertok(dm_rtc_get(dev2, &now2));
 
 	ut_assertok(i2c_emul_find(dev1, &emul1));
 	ut_assertnonnull(emul1);
 	ut_assertok(i2c_emul_find(dev2, &emul2));
 	ut_assertnonnull(emul2);
 
+	/*
+	 * Stop both RTCs on the same time before reading them, so that only
+	 * the offsets set here tell them apart and no second can tick over
+	 * between the readings being compared
+	 */
+	base_time = sandbox_i2c_rtc_get_set_base_time(emul1, -1);
+	sandbox_i2c_rtc_get_set_base_time(emul2, base_time);
 	offset = sandbox_i2c_rtc_set_offset(emul1, false, -1);
+	sandbox_i2c_rtc_set_offset(emul2, false, offset);
+
+	ut_assertok(dm_rtc_get(dev1, &now1));
+	ut_assertok(dm_rtc_get(dev2, &now2));
+	ut_assertok(cmp_times(&now1, &now2, true));
+
 	sandbox_i2c_rtc_set_offset(emul2, false, offset + 1);
 	memset(&cmp, '\0', sizeof(cmp));
 	ut_assertok(dm_rtc_get(dev2, &cmp));

---
base-commit: e36b675ebc4c41f1f4187c46d363d581c371d538
change-id: 20261021-rtc_dual-daef9ba7765f

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

