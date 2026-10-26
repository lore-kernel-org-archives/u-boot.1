Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D868606A321
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 13:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=I8CoRDN9;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F2TdYETx
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D94BA406C4;
	Mon, 26 Oct 2026 13:40:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8-_zSF34sOhC; Mon, 26 Oct 2026 13:40:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9068A406ED
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793022033;
	b=b3eh0+tGAHYAToBIPvZCUOlxscOsWKdkDLgfjmkDdoWPb6kWYqbf8WhgW2hSNN9AroQU
	 0wEf10urESgUmnE4mpcpeziaZe57nuH5vjR4ZHDcuKdBk8yIUtms1vSiRLfRPpLeGE5ZX
	 Ca/AfZ/dAiny4wDq2nj2OyRNytrTRhrVt48L9dXq0bexZW8ixi0EtLv0q187atp+i2a1J
	 FDX/rbbFtWwHTQoH5egD1QFAw5sf/JGVSul01cIAOm5+sTfE4OS4xT3GhjpQmI2cjL3HT
	 jKRU4fkkF3lWPEOGOMjZZtbEvo8u6S8Bwjy0PCfJ7rp+a926LSfNFTKNRnGUhlJR3qA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793022033;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=QjEn1Qw1z4gEOvIEyh/Lovf+WeH2Yyt9mI7DppKKnsU=;
	b=iKjbVeXrk7k1MwRYDgWKdsT+147lTWosh5bgcoMoJXfo9jGLUsR80G9043Qov/Nvs8kb
	 aD3gnbrp5qX7KuLRkfAXiSJyFmCqfPstTzv6fKGfUVAqnwUqOVmPIH9sVGRzT2trxVG3M
	 3LxnRWrn1NUPRAcevBaPKABmsEyCAOrQ83Du7Ix0KqFBNzQSui3Scv6Cb6dHHyKTf9KZr
	 FBMJMVMt/q1hyKzFtrisweC7m1zIYekzelFKO5WSdf1x1fhDsT+9sV39DEsgi+osLDBMe
	 1l+xucq4foRV9v1BHLOPLo1r2yezkOoO04AGtEnftTvZkqwH/Js1JK/YKHY8J/8bDxA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F2TdYETx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793022033;
	bh=QjEn1Qw1z4gEOvIEyh/Lovf+WeH2Yyt9mI7DppKKnsU=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I8CoRDN9oabcdpfO4px+qK4fyDLKfO7kk9xH5q0IUTacH5CeOdosKaPFgsxnEiKxz
	 Q7aYXgmijctkSoGXKqNzFvYe+bZd9zbjCnZX2F7WSBzhH+XzRn1EKoi8GP+5/rc4ev
	 FgeMRlEGl3kLE5NzQAeVq2nu1CpmVcQVJddUckoD/SK1ZjQ1KHLYhDbzCLx8Na7HJK
	 qMah7YX1AOB7xjDztDPrhh91XfpT9dycsIU2lvDcTv92XlgKeW/XNBpwbUpXSxFUYr
	 wwLk1vf9oYorpaQmobREMSAv0MXCWzS86PZkQVdIVeW+P/G4eHlR39vLe7uILR2fi5
	 JCyA+6XGSLxvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9068A406ED;
	Mon, 26 Oct 2026 13:40:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C1E7E3B6
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:40:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A5079406C9
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:40:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O__6ov0YlMCT for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 13:40:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BB3DE406B9
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793022027;
 b=caGmbsoE1dIeQbUT+sYJhZCvsSjnwPDHUk9XyOWn/P2HlJmyePgqqgkxQ651LvDMaw/E
 mT7WKKU4dtQzAYpg3CQO/wxIK1wDh7M4BrKOyXIKRYs1DiqIb1R6c1mC3qEUmx/xbXg3U
 5cZFDzmBRJB0FG6W2o7nuW2ITZHvHnutcAR87j0wi5SqOP0M+GKNLlNwkcnGqpm/no8aW
 IikTVRVvVkjBd2r/ogZ6juCH+Z6T+IvltLPkxh1m5l/EhtXXwbWUsVU6zwjfavSR3DbUJ
 T+HDwFdlq8HGh9K2u+OUln68KXjCKx9GsI4ARJ5j9s+qTYf9HCEMy+DVnOyowa2AtpQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793022027;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=QjEn1Qw1z4gEOvIEyh/Lovf+WeH2Yyt9mI7DppKKnsU=;
 b=bd5h8JrzDuM8ILprfG6acEek9PJd81mcQhDNgwvlPKXA3L/DCYZlbh+CcyLZzysky/Dw
 QYi5fgE5ToVm5ISGJ4pJz0RGpI6Dt0LjGTIy13IO2JPFkcEjBVoE/6QGsoKyKIUvhWDEW
 ZZeCan4/9scOaaqWdqPmo95eMzaR9lgRPBi5tqN+3+idcYa+4ZSaIApDGeUYXBoC8w89v
 izqFp8F6/EzTtloljLdEJ1yvGODQbfaDkuM9I7l7/D6NzK6EkfeG3oB1VkFxDiQBCqYpt
 jHVpMPwdPYic3R24TdKmLfn5XJCgmPqe0zH+FUFTDBiAHzErsnDm0Uc51r2RKCRVuuA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=F2TdYETx; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=F2TdYETx
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BB3DE406B9
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:40:26 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso14407025e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 06:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793022024; x=1793626824;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QjEn1Qw1z4gEOvIEyh/Lovf+WeH2Yyt9mI7DppKKnsU=;
 b=F2TdYETx6d9EW4FuuLX/kmciGKTEdrujU3AyZ+ruKiBusEycZi6qqDIexikP6n5pdr
 0JQNg4B8NPZmQBhxgIwGCJCsbU/DzE1tToQLSprYmmHyjXZh6v3IH7k410wErqsLs8cQ
 7s3kRrpRCW8yjO1YyPsM1Qx/KBg71bwkGhiGcbyzfnapxYKmwl5EqEHrvLBB5claAgVp
 4q/N/mpb76rxxPOiRGO+7S1qzzwjvKdsjqD3QjX00CyJCtZUHC4kL68ZxO1NTE6HB4eL
 MX0YZZKUTHTPNE011wMiBRe9vAmjZDipGyZJJkgQMcCdax+EcLb/Z/dOeaTNzz/2Aoye
 PyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793022024; x=1793626824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=QjEn1Qw1z4gEOvIEyh/Lovf+WeH2Yyt9mI7DppKKnsU=;
 b=2lTSCxh5zjbcZmd/ZA6BcKSSvDdV/lZkEBiSOo3+wqbWPlYjJyz2qr6TsChxWilXke
 LB3YDMJdQFSAjUPS7ZiVgGX6tN/VFS96HaJfEbh5LwZ92s5sDtU3iB84s9PuAjUx+3sJ
 eKRwOc5//vaNKg14nAeVXWt3LgQl0qJcTvavAl+IOSOrKcePB7NNtV6VMeiwgs4bxmwF
 MD9ZONI7NoI4vpIrn3CVMj67gxF0QfDmf/MX6dnKjkN4AjjsJPtuvspES+3f4bNzjVNV
 vpx0ExEAaNb4QrJejtS/TVWdsOku00nPyg4CRsNbCpKlC7og0KcPp7vpcg3NuOVgAAOy
 Iw8A==
X-Forwarded-Encrypted: i=1;
 AKwUvByltc2KSG78ZOIfgAnPNykc6pBcUdXrQcySkvieyS3IkUVr/TZskalDl6ucbGNc9tDty3o7QGQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLZOm8h2+yKFRpfRD7251DHzg5XX2CPXl1WgMyQ/S1v0hUI6crD
 EU5NFldoCiTqTud3GDtPlqGOwvYwQxk+BcobYQ2+HbAD2vEWEY1wUqOc
X-Gm-Gg: AYBFou1c4aN6E0iNUeuRHEGopyzkHS6IBy3sI199XQaFZZlVm1LGuuchNQfSCxKWGeU
 RFXnYoqdtSg2INyCQPCx4C3qT46WN/6LxLdRLrdX0ZdFenpHWOFHNGkFz6sLQrPWernO+DwQFCc
 wC+QXlmxD0D7406pW1q/0iBEvfqvhu0CJT3tADtDbzdpVxdCk0byZvKqDzn8szCvGM5ubbvwc9p
 3ZKWY2IY4gEwuZC4eoek45SjWq5XK8Ubdif9S25ph+L9lCitU4u9vv0cTvwGeFaOQ9PIyA42kya
 NENlKb4lgUcTzQt7ElphWPmSwiD4SVDm6L2DFWdj5K1nNeuU0tnY0fe2XHPoM+GdzNsgNHYJM5t
 h+h+xjbMkHGBc/7/atsy2lBseTG9MwuoEZBABhzxsxVZvRWC7G7qWaRMWLBFYvn4mKAyMdgrfRv
 5wsxzqGtbZZny6wOJcd7PSGRYuIopgWHXffYmpsG7QF171Fnq3x7cj2gEwpTddYzyCacct+Y9Mu
 aigyhTPn8iYXs9SceLGT4f61vuotMmDAX2Oo5k0uvPntTL86ajkmNXwYziOUOVvElcW0lLioQ9j
 ISBlffMWSS/8x1On1/v7u4LzstD8L+AkvobNw+Dy+0mBYQoyg4OPKef6UTXG
X-Received: by 2002:a05:600c:524d:b0:4a3:59c2:b41e with SMTP id
 5b1f17b1804b1-4a7444042ecmr19858735e9.4.1793022024182; 
 Mon, 26 Oct 2026 06:40:24 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it.
 [93.34.92.187]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4a35a2c0458sm194344375e9.11.2026.10.26.06.40.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 06:40:23 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>, Alexey Charkov <alchark@flipper.net>,
 Daniel Golle <daniel@makrotopia.org>,
 Pranav Sanwal <pranav.sanwal@amd.com>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Anshul Dalal <anshuld@ti.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
 Tan Siewert <tan.siewert@9elements.com>, Yao Zi <me@ziyao.cc>,
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Randolph Sapp <rs@ti.com>, Martin Schwan <m.schwan@phytec.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.u-boot-project.org
Subject: [PATCH v10 5/8] misc: fw_loader: implement request_firmware_size() OP
Date: Mon, 26 Oct 2026 14:39:58 +0100
Message-ID: <20261026134002.109025-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026134002.109025-1-ansuelsmth@gmail.com>
References: <20261026134002.109025-1-ansuelsmth@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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

It might be useful to get the firmware size before reading it to allocate
the correct size. This is needed for case where the firmware size change
across different firmware version and is not always the same. In such case
the only way to handle this scenario is to allocate a big-enough buffer to
read the firmware.

To better handle this, introduce the request_firmware_size() OP to get the
firmware size before reading it. This way proper buffer can be allocated
and dynamic firmware size can be better supported.

FS loader is updated to handle the new .get_size() handler.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/misc/fw_loader/fs_loader.c        | 28 +++++++++++++++++++++++
 drivers/misc/fw_loader/fw_loader-uclass.c | 19 +++++++++++++++
 drivers/misc/fw_loader/internal.h         |  7 ++++++
 include/fw_loader.h                       |  9 ++++++++
 4 files changed, 63 insertions(+)

diff --git a/drivers/misc/fw_loader/fs_loader.c b/drivers/misc/fw_loader/fs_loader.c
index 7f7403403611..c70dff47b2e4 100644
--- a/drivers/misc/fw_loader/fs_loader.c
+++ b/drivers/misc/fw_loader/fs_loader.c
@@ -190,8 +190,36 @@ out:
 	return ret;
 }
 
+/**
+ * fw_get_filesystem_firmware_size - get firmware size.
+ * @dev: An instance of a driver.
+ *
+ * Return: Size of firmware, negative value when error.
+ */
+static int fw_get_filesystem_firmware_size(struct udevice *dev)
+{
+	struct firmware *upriv = dev_get_uclass_priv(dev);
+	loff_t size;
+	int ret;
+
+	ret = fw_get_filesystem_mount(dev)
+	if (ret)
+		goto out;
+
+	ret = __fw_get_filesystem_firmware_size(dev, upriv->name, &size);
+	if (ret)
+		goto out;
+
+	ret = size;
+
+out:
+	fw_get_filesystem_release(dev);
+	return ret;
+}
+
 static const struct fw_loader_ops fs_loader_ops = {
 	.get_firmware = fw_get_filesystem_firmware,
+	.get_size = fw_get_filesystem_firmware_size,
 };
 
 static const struct udevice_id fs_loader_ids[] = {
diff --git a/drivers/misc/fw_loader/fw_loader-uclass.c b/drivers/misc/fw_loader/fw_loader-uclass.c
index 7f19d6c4af4c..4e67f2559fa2 100644
--- a/drivers/misc/fw_loader/fw_loader-uclass.c
+++ b/drivers/misc/fw_loader/fw_loader-uclass.c
@@ -210,3 +210,22 @@ int request_firmware_into_buf(struct udevice *dev,
 
 	return ops->get_firmware(dev);
 }
+
+int request_firmware_size(struct udevice *dev, const char *name)
+{
+	const struct fw_loader_ops *ops;
+	int ret;
+
+	if (!dev)
+		return -EINVAL;
+
+	ret = _request_firmware_prepare(dev, name, NULL, 0, 0);
+	if (ret < 0) /* error */
+		return ret;
+
+	ops = fw_loader_get_ops(dev);
+	if (!ops->get_size)
+		return -EOPNOTSUPP;
+
+	return ops->get_size(dev);
+}
diff --git a/drivers/misc/fw_loader/internal.h b/drivers/misc/fw_loader/internal.h
index 9ff43e872554..1abe7504a81e 100644
--- a/drivers/misc/fw_loader/internal.h
+++ b/drivers/misc/fw_loader/internal.h
@@ -32,6 +32,13 @@ struct fw_loader_ops {
 	 * @dev:	Firmware Loader device to read firmware from
 	 */
 	int (*get_firmware)(struct udevice *dev);
+
+	/**
+	 * get_size() - get firmware size from Firmware Loader driver
+	 *
+	 * @dev:	Firmware Loader device to get firmware size from
+	 */
+	int (*get_size)(struct udevice *dev);
 };
 
 #define fw_loader_get_ops(dev)	((const struct fw_loader_ops *)(dev)->driver->ops)
diff --git a/include/fw_loader.h b/include/fw_loader.h
index 99c47380a172..01f242dcbefd 100644
--- a/include/fw_loader.h
+++ b/include/fw_loader.h
@@ -38,6 +38,15 @@ int request_firmware_into_buf(struct udevice *dev,
 			      const char *name,
 			      void *buf, size_t size, u32 offset);
 
+/**
+ * request_firmware_size - Get firmware size.
+ * @dev: An instance of a driver.
+ * @name: Name of firmware file.
+ *
+ * Return: Size of firmware, negative value when error.
+ */
+int request_firmware_size(struct udevice *dev, const char *name);
+
 /**
  * request_firmware_into_buf_via_script() -
  * Load firmware using a U-Boot script and copy to buffer
-- 
2.55.0

