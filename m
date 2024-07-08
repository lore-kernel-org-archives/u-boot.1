Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED55BC3DA42
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 12:21:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25F8088755;
	Mon,  8 Jul 2024 14:20:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GcTF3e4a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3F178872E; Mon,  8 Jul 2024 14:20:34 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A6838872D
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 14:20:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-58ef19aa6c4so3883913a12.2
 for <u-boot@lists.denx.de>; Mon, 08 Jul 2024 05:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720441232; x=1721046032; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uPc9gWUo0fO78Y9Jb3dlpFsxrUG0+LSQScGp3BE+wTs=;
 b=GcTF3e4arag6QS7Szjsz6GKLB2gSJbm1UIGPHNa54QN3G/+RJzKpuHu36MkPJImjqw
 Jj0gEiFwv+K+ln8dbwS+mZsMHApfThE73CgbxFy5S6BukIRaLwEkWUJ2NTmAsspGaVZL
 Mdk5+tSXy6tp79IffS7IHJ9bPYBZAYIt5YMleQV6dZzcC6kmN20coeoGG+BTZGhs7t9G
 5XTJCu8Pl9+bYZ6nBlekX7iraVArm+AuI6CfIvLuGw8abYta+ROo8U2sdPI9FnY1D0BZ
 rNTOhHNFp8++5nLp8xAWEeDDuJSIlbupIQiS0hzv5qSfxP3c4wr9aPSjiZnIB7BVwAC3
 3MnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720441232; x=1721046032;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uPc9gWUo0fO78Y9Jb3dlpFsxrUG0+LSQScGp3BE+wTs=;
 b=R/PuikjkHzqLDua0GISrPbjtiKGHBuo7rMcnPAn97jRj7WCzI5U1iIqfRfeKiSzopQ
 wqaFfzz21IPM1BYABAIMlNepaTBr08/Cz07i56m/AAvGupJo68xd1BhgDotfYC513bHO
 Us23sEu5uelpTgraj/DJIpJVX5+cGQ9IM2L8+ly/YyR6XBZcriQZxoSVSwttkr6ox72B
 OmO0cBuvaxbJunZuf5DI+8MzGVvczDxl4mEeKyRrw6P8tImkxqkxxY8HNVM8Oa+DZdLK
 W88zbD1cYiZlwoqSX19ptjJGk9iQgMH4+bwYHCwvOghKG7qdCvr+RBLin9DRfcNqZ8GM
 Gg3w==
X-Gm-Message-State: AOJu0YxwVk91SqYwdwj/j+MJIACoVxNv5869uTMwXu4IQ37ODWpLZdDC
 ccAl4kjjqbhtqkX2ip3fg+3akfBBWLlG0sIaXUXYjshl3P0p4ByQH1PYoODwLHo=
X-Google-Smtp-Source: AGHT+IGeCK6s9ozzWT2Ev/p9/nGvfE3s7b+Lwb1LAngxc6P1RuafdAAATOg4MHHzipK+hjbX1KcGKA==
X-Received: by 2002:a17:907:3f22:b0:a77:e7cb:2982 with SMTP id
 a640c23a62f3a-a77e7cb2b62mr449359366b.26.1720441231682; 
 Mon, 08 Jul 2024 05:20:31 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::18f8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a77e8a7eeafsm188364766b.47.2024.07.08.05.20.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 05:20:31 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 08 Jul 2024 14:20:27 +0200
Subject: [PATCH v3 5/5] fixup! soc: qcom: rpmh and cmd-db drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-b4-qcom-rpmh-v3-5-846cc6c5b728@linaro.org>
References: <20240708-b4-qcom-rpmh-v3-0-846cc6c5b728@linaro.org>
In-Reply-To: <20240708-b4-qcom-rpmh-v3-0-846cc6c5b728@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=517;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=BNxyqNQeIOSHNEN48099YTKLWS2Lttb7sdxClkImJyg=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmi9mJVZha/LTf23JVsyip9Wq1qgeD63nfK8jN7
 oxXrbPMudyJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZovZiQAKCRAFgzErGV9k
 tpd4D/0cYy12Dhf15Zl+93CHUJtEDtCFla2/Kp4ZauQ4ceMPUSgUnrOnqaSW5WGeqI0DPTWuxcB
 MBdfcImqrpQXyuJ8f2F/okYOj0PB5CsN3Nmzgmj3tr8iGxNxRkfQME86e5Cd6Yk2gsrRikkwBN3
 zgcTGlc3pxu34AtYWzBAaZkuEc/GYwpPZwVzJsiub1uupZCh7pxHIxRDxYZHAagT4VifcMRm8rD
 Aiw24w1iAtKwke9TSQEcpXOHw8LvZlw5gYJcDQzHeTRO/sLnQo7KIRnc6xAInsDfHYa+WJhbk9P
 oIpKt2l8mjLMSAHj6BcQWjlFbq6Xv7IcAt+5KnaaUvsDSoo2HB41qvCLCmGjI3ueOuiXiu/ErNX
 3iINQkPw1QGf9ZvZOUAtyRzyCfRBafrCLWvey/1NcpYewrVHh9k7ywHq/6woxEwkbC1eLv3iq3s
 3rarCXAj6PtzvmYEhpbZZujPQDc3zrwMjhsc5uhW79jaTj7uP7Xk9GI1KcMl/cOfIwFPBhsTDmx
 T56t5UD5ouuJcdEYeCZHY5BeD7B59vtnRXBPF0COhC/lfQHXpZxxmHVqKc3yaSEZdxLhUkhmF1W
 JAmD5iqzCWYDUXairUSTLjOUI0z8tawKkN/Mbymlb+scsxg5zhwaGzJ0JJAe5QVnmButyKjid42
 fpb45UcmwhV2d4A==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
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

---
 drivers/soc/qcom/rpmh-rsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 1f8428c415a1..30756a32d590 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -549,9 +549,9 @@ static int rpmh_rsc_bind(struct udevice *dev)
 	ret = cmd_db_init();
 	if (ret)
 		return ret;
 
-	return dm_scan_fdt_dev(dev);
+	return 0;
 }
 
 static int rpmh_rsc_probe(struct udevice *dev)
 {

-- 
2.45.2

