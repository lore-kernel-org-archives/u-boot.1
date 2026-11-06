Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D385606A335
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 21:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=E87kBxou;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fjbGLrfY
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3643D608BB;
	Fri,  6 Nov 2026 21:04:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tCsRaWXUxbpr; Fri,  6 Nov 2026 21:04:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 77CE3608A5
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793999056;
	b=AGpppS2oz1uQZ08nlphjODNArYrnAOv3jfKoo1FMYrk62ucq6vdtYyLMWjD01xQjUDCu
	 bjwarCvggjbQWmS82saMXMhB2fP7vmoNfyzau+Wuy8EKglLQOOYHTISZ6Xdzfc3k+8wlI
	 Fg9lk30dhqUyd216lOyIHLnYrSvdug+17Ok2FFplGbgw+BJtXlJd1uov5T2m4RUIaOu8Y
	 giuHfUQLi9Xv54pshqEKV97VlqDCrltAhXjKx/+2OS9HNpB/mcN8+4vOQNzBKZs+nfLjK
	 THHyC0Y0JdHux8AP334z46YC1vIPQ60iGCIiJiRznIb1E5II+96lPDh0phg2nnI230g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793999056;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=tWE4Vi/honkULmN41lIUYSifMjPbkBEq3iMH5eBsIAA=;
	b=c7dUkSAkaek1Ym6OE1ApeJvDd6xMxMeqQ3yud/QysCJGYNU27/9AQE8eIA6b9S0pQYHt
	 hV7kHtnpA5d8IuZPyZ1G73nLhS3AjIexn6/f5NqPeRL0q6mkIrkf7nTzRw6hqmoYN1MvM
	 N4s4uiSXUDDDCNDni6LH1FpjbWN+QNaRBP/DZGGFFU9KWT1BEIe7vz4XzsMCrktF0kgBU
	 oFlDLjNdRY5YduIToBPM0mPvgiqgiTlWy28JC54zUE5RoVfVCPwCe89cZ7CbGp7iD604o
	 07okkMAMYqUo150anBfUHhDLGHW8yZ5SyU5xjoxFpjEthBekJlKGaYjafx6xg+MjDPA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793999056;
	bh=tWE4Vi/honkULmN41lIUYSifMjPbkBEq3iMH5eBsIAA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=E87kBxouTJpXalWKomCk8bA9Su6k5nE2+p8se3ZDLsZyabyL/9PR87n2jQ+ejunNy
	 nYTcZA54QwbbVApeKTR8JsyBV1QUuDsmrftPRidZ4+sQ8kMY1NonPfsMzsZmwd0tUq
	 28LiUcNeMcuX9ocwcouh7GAdRZF4rVQteMOuTsbw1Ruoo6QBuzI6Dxc7+RJfrT/qkg
	 /3jf1QlDcaNqLIMORxYS9Du5pLdCKfbf0cCzJK6at50hshcF1mA9cqQlUGEZfvmbmK
	 UErnaArbTb63l7Md/O+034Vjfl7XynFKFHI4UM5ZKevh10oVfqXqh8853L7lE/43nS
	 EqsSod/KIOntw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 77CE3608A5;
	Fri,  6 Nov 2026 21:04:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E29E42E5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 19:36:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C7DC7403FE
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 19:36:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GRkKl7LjdaOD for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 19:36:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0F242403D8
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::f30"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f30; helo=mail-qv1-xf30.google.com;
 envelope-from=oss.patchbox@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=fjbGLrfY
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0F242403D8
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 19:36:40 +0000 (UTC)
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-91ccfb88e4dso11850246d6.0
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 11:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793993799; x=1794598599;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tWE4Vi/honkULmN41lIUYSifMjPbkBEq3iMH5eBsIAA=;
 b=fjbGLrfYLHQH1CDRMYdXG330AijSLXZ7ih5/5qbae4Txpnhml0vKzIkFqg05I6vLP/
 Z9XI2uiWIPrGLGWAGSE1J1Phpsd045kvJtvSyLTBYJXdURE3FP45VlwykirgZDLJMFMH
 amJEXAET/LrCykOwztCRIfO7EP/ze1gkIoWxqXoZAU/WZlTd66hp7fwlwMy5ZDFJRGTs
 4q8rdS+UOs4FuK+Y4CJVyF1k/DZsGh0rF5fXRIMeV8EtB8+pWzA2+fenneaQsKkFKE89
 EGusH2p21+3GBJ9IYn3FXyFez4w8gnKBMQo7qP5qU6HSX3In+rqsxSEiC34RCrFIMlQQ
 lp1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793993799; x=1794598599;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tWE4Vi/honkULmN41lIUYSifMjPbkBEq3iMH5eBsIAA=;
 b=MsTIESw+GSFxPZnpWbilI5dldF+12B10QAnW0aRZo6dM4eFXN72sEQPxcXeykEjcKS
 24IIbIY/30tJkz3J4InGplItSBjZTzXRWx4C8M2uDErvNsTwbY0RHOLVRoXsYeOveSTt
 QcbkKy/kX642jv8y3ZlGm6fD7D+3DJF25jyfNXubkO+d/OoVfjT7ggL25Sp+Zn7rZ7yJ
 bSZZuAFCQTBL3BXiIiPxwasF9xLnxbM293mbUgw+7Anlaw7nsWQfQNHEyVGVB/zpFpRo
 R7P7GvxXvLlBhHfILzydSVwCO4TWvvxGlZHONNBu2IWhAcR2qhc6f+rD4oWG8ef0T2/m
 uXyg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxaxIyqi4m1d2DVDcWa1ypPRyKRG/qga3sxBiOs9gjmwsw5DdPDtlfLpSfda33MfNiESPUF4U0=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/yNQIrYsRjMMRuZABeQTIDSWYCgMujWfyrxjH04uvaJwHTVTnT
 nhdWjvj+35gg8jRERy7k8AVlXEfE5kiHEwPRQPMTFy7xYuDH4tJ9zV8uN7RbIQ==
X-Gm-Gg: AYBFou0fPKAcOggHG5mM/y/CqXg7GIrTRdblU0qZzm2GodCzCojTACtAJQdTl5tGoJv
 vFnohbVODvZXd8mQncbny0CN/G+JZ9bro0KRuUdEs87hZV2F1ibkj6i+RqRSNTRENMBwQFdbxCw
 wiTm9KPZSVHI6oRIG+jmDgNRps1o+tjQKbYoL5SX2EGoe2NfGc7HJd5kCKbfXiBmgg8OKjhXvvW
 bg+a0SNLak5MsK/KjES08a7VNn/m55By8/FaRTW+Dau08iAzWx3/Is8wM+4Zv5Ov1HxHS0vk2OF
 LppZvCvod2agqS04Dk35OZCmtBvoFvo92jlm+t+CrAxm1MICb+KBbf2LB+SjjaSxj6khzRSnjMp
 +gvVk1uED/EHygWe/cy4799k4CG9Tx6l2g6E5jk5JHQ7fHbcBSrgHLYNceMYwEjKVMGbUu7kuYZ
 2r9VjDpdqq0foRYj0vyIvl/00Ip1gquULxsP+G2I4S5dfUPTjNc0N+9R9h++HrXX2CxStHPynuz
 R8Pa7u9crpi82+Yvbt0ubDTN67fMD058s3pS4PQAPnQB+BPT8cHqbNYdrgW3yKj8T2aVkCk9o0G
 qP9Mo40A5XMoR3mFMc+Vk0c0/bOTZ5A8F1n6SwnD62btXeYxG5j2
X-Received: by 2002:a05:620a:601a:b0:93c:bdb4:2be7 with SMTP id
 af79cd13be357-945f35cdf70mr497012985a.60.1793993799328; 
 Fri, 06 Nov 2026 11:36:39 -0800 (PST)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-945f5c00be0sm214151085a.33.2026.11.06.11.36.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 11:36:38 -0800 (PST)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH] usb: musb-new: sunxi: Free the controller if the host probe
 fails
Date: Fri,  6 Nov 2026 14:36:13 -0500
Message-ID: <20261106193635.507619-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 06 Nov 2026 21:04:15 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In host mode, musb_usb_probe() allocates the struct musb with
musb_init_controller() and returns the error when musb_lowlevel_init()
fails, for example when no device is connected. The struct musb is not
freed on this path, and the driver core then frees the private data that
holds the only pointer to it. Each 'usb reset', or 'usb start' after
'usb stop', probes the controller again and leaks another one.

Commit 7c22e26ec5ba ("sunxi: musb: Re-init musb controller on repeated
probe calls") made the probe call musb_usb_remove() on this error, but
the call was dropped when the driver was converted to driver model.

Free the struct musb when musb_lowlevel_init() fails.

Fixes: 3a61b080acee ("musb: sunxi: switch to the device model")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
Build-tested only, with A33-OLinuXino_defconfig.

When musb_start() fails, as it does when no host cable is detected,
musb_lowlevel_init() returns without calling musb_stop(), so the
platform init done by musb_init_controller() is not undone either. That
is not changed here.

 drivers/usb/musb-new/sunxi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/musb-new/sunxi.c b/drivers/usb/musb-new/sunxi.c
index 0747f025f2a..1f1c33a6672 100644
--- a/drivers/usb/musb-new/sunxi.c
+++ b/drivers/usb/musb-new/sunxi.c
@@ -481,6 +481,8 @@ static int musb_usb_probe(struct udevice *dev)
 	ret = musb_lowlevel_init(host);
 	if (!ret)
 		printf("Allwinner mUSB OTG (Host)\n");
+	else
+		free(host->host);
 #else
 	pdata.mode = MUSB_PERIPHERAL;
 	host->host = musb_register(&pdata, &glue->dev, base);

base-commit: feb8913982e4462c01fd914271f92254a25dc101
-- 
2.43.0

