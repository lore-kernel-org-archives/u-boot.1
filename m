Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6C8606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 21:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JwJ6d/En;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S6AQ68cR
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 01A688112C;
	Fri,  6 Nov 2026 21:04:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id or2iNr6xSHmE; Fri,  6 Nov 2026 21:04:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 55A24810F7
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793999058;
	b=Sop0Lcyu5bGg81HsXMtnTqFZ4Vf/Qw9FN+xKZO1xSOw6DSuF36/YeJuB9955PPKiQs6B
	 sz4n1xPrYggOzMiXhC42J9fy5OatQanmKBPk9tL/sKhMOHYo6N1kWJhasbjiBA7OeTDof
	 4NFeo/ILYpyBau8bBllF185Hevo59DrkctgYGkKAZVXWJ2x/uqGSi6hpTXPopTjIl8tDi
	 E+dksdHDwpfzhxEE+Nd9sVPvGqLVcXsI+uL62WOo2V3/cDzHkDcapI5FKYBcuxfHpybHV
	 /OHy0HRgyD5h08aBs6ecf2DJ0EciqGuNa698RQsDXeyEvSUtOGCCiMWqoVO+z/pOaWg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793999058;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xazE8OqALVdc95no5YrHzTuvhkRjlW1x4pvG76PZZdY=;
	b=QaPrtXsI8PzCh8K269U7CPRN0TW75jAkkuqlKPAEV7kCPqduiJpqzLGHKrrZolKp7FNg
	 EKfL1GRx7V69vxB1z+0lbxH8i2DQ9AotzZieAcx1DRVBZ8sA7wSsIHGEiaVb21xqse0LI
	 npb7J2BIdX4lEUN2UY4Cn4AX/3I3l4yJfoCq6CZDej+EdjsciQjfqEQ0hyOniXQkww/fZ
	 6zTdBeG2GCJjMS6hqKylm5zPNN/OruqRGvmQnHBHFtRXGQyTVImZhyLXSL5DYLAaDRJuf
	 GWt3DpiaLiPH/NKfWyEOfZrLMnmCyVUxadQwHhJIUuxoAfe4uyqzQUv+NPwtRnEZQ3w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793999058;
	bh=xazE8OqALVdc95no5YrHzTuvhkRjlW1x4pvG76PZZdY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JwJ6d/Enez63jcunstZdSo+oZQrd4EgPy0VVOaVtI/usUPLKV2Cljjr9H98rdiYkh
	 bptnsumPSPa4f1xl4e04o3C9Rxw5txkWbTnXKyZPnxfcoz622vbbXqZwDC+R6TsviT
	 5+Ykh+n/m28pIUlwW2kojBUdse4h1+hsqSI5tNGW3pBqp57NigVm8pPjf4ewdA3H/P
	 bJYMOWMDVXZs2a3jAZgpqwzPZOtU4FOU19vz6HkDvGLKrWzQCbXLX1LkB/PDZJCJTw
	 evENxMqQjnpyNvUtXPSZnFSz74+qh9g9x5W2LtY8BRfC+BgSb5T5NIsTasnYDjJ8sz
	 6nr+ZkTKgKf8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 55A24810F7;
	Fri,  6 Nov 2026 21:04:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id CF65032A
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 19:38:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C0FCB607AD
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 19:38:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zmcmGJApFZW9 for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 19:38:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0A72460771
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::835"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::835; helo=mail-qt1-x835.google.com;
 envelope-from=oss.patchbox@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=S6AQ68cR
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0A72460771
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 19:38:12 +0000 (UTC)
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-5364d86f7f0so11492211cf.1
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 11:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793993891; x=1794598691;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xazE8OqALVdc95no5YrHzTuvhkRjlW1x4pvG76PZZdY=;
 b=S6AQ68cRPimv63KQDl+wUkouUd0b3HVbGkAwTOx5WxRW+KCl6zVdpsZ8y6PeGDpOKD
 6fxYFeizPjROFRqhdTVYlB6ZEb/ldAL2mEvWidKFKs+Szsy3oucp0HB/s/28Tvd93Li/
 MIWJLC55GpN8p5+ZAGPgbMrtqgWQD2ArBDFhJBG8cAF86Nqjz2lmk2nHrDkr6zkNZx2B
 +ta7azCbPfh5Pr0UwCC/rdLYlqhldPWlHV0v2+1hDK1fImRuiPuYxorNnzWbwch2jGfp
 Rq0wCkz+MV1Q1qbSUyb5vlpZuAyKH/R09Jng8dWOPzSoz22UqMOzHXtruRrGoMKCto8V
 FJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793993891; x=1794598691;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xazE8OqALVdc95no5YrHzTuvhkRjlW1x4pvG76PZZdY=;
 b=2mYwN0p8NfE9A0K4Hk4VtHueGFnDDYLK25P4qUNTMzpdrbQUdoconCGMakDIBHW9Ld
 3dfpYlxRLM1yxgp5dcElsdxKHb7AhW5hW9rcjvFWADz0FIDsMcAgxcn7gTnKFrdgimet
 x0cBslbrP1qa4Xe6nYe5TDnCvCM/ZNJ/c34oP5xmqBfVXlt+pbD2+q221dWg8sIWArHw
 mN/DSG3KjXXVtHa83fJQ5FJ68XHMS2HMDjAyd8IcXRG2TEgO+xbkL2zt/gslr7/orXEU
 nF4c1b1wUkyI536YZaWrBPy1YFDuUfTeHDd2x0RIrHz38TUZnaKy89QpOAyB4vmMjBqc
 eycA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwAJDOroypyXjKDa0uVYVaxekBImIRI+I4As3u5aX61iajsPyUDSo/7VbCvV/PkJDPIoT1K1J8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+N4esYLuIHCmdcEroJefG4/HNECU6RgYy6Z8PNJpzZ++D4Q49d
 Wq5duiNyG/iB5io/fnc/sw45bMwiJgS4KdS8cyUcca+3D9C72ZORi5b7
X-Gm-Gg: AYBFou3MZeAHEF+vHRBRtoN9j3tlySZXGOeyIXE87WIZ77vR10CBcet/3QppIwmYtf/
 L6PujKT3sblsJC9xulvaFnau3bnUKaf8T1kk1yGv7tifVgduGAkHxrHQX+Yj36d9ocOkbeAKjuk
 6ZdNmlM8j7dX3hPu4wSk4oSAMasiQVxL4chLsiY5I7dN+ABLaxtC8c1c6i1KDBTqrTBrf0bcNr0
 /sQKyKAX5GCXcfk68Jl4PMlJSoqN72GnRluA49fmDd1XBu8Jmu8wPygQn3JoJQhjJWQ3myqW9O3
 5I/brVTva7Ggdgyiu6TI9l65NBjaz4cmrvD0tSkT2E5qPvm7w58lp7thmoON9LvcgHm6wjo3rEg
 23oUedC5f1kcYlJAedBD57j8+04WFExGRXZqSsd/oFWnFoaO2uswMFgK2ENCTirL/jmvtkIfyIJ
 Ur/YoZt9RUcvEABWpPFQAPmxIqNeSavUIf/MIAoH36iIw+wYYaD6PdE3N71EXCtlGq86EGcE0dl
 u8/c7ggZq/5ytjmLLYmUmvToUvjlp55YOB8DA/l2trbt5opyrjMVqEIQLdusbVkXj5OYDR/G8UA
 uqprNiIwLhw+B74yBc/rxWAio00pZwwG1WJkN7xFCrcpg9XXhoL3
X-Received: by 2002:ac8:5f85:0:b0:537:83ea:2fc6 with SMTP id
 d75a77b69052e-54e154697e0mr56007001cf.58.1793993891213; 
 Fri, 06 Nov 2026 11:38:11 -0800 (PST)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ea6a847e8sm27734646d6.28.2026.11.06.11.38.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 11:38:10 -0800 (PST)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH] usb: musb-new: mt85xx: Free the controller if the host probe
 fails
Date: Fri,  6 Nov 2026 14:37:52 -0500
Message-ID: <20261106193807.507911-1-oss.patchbox@gmail.com>
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
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In host mode, musb_usb_probe() allocates the struct musb with
musb_init_controller() and returns the error when musb_lowlevel_init()
fails, for example when no device is connected. The struct musb is not
freed on this path, and the driver core then frees the private data that
holds the only pointer to it. Each 'usb reset', or 'usb start' after
'usb stop', probes the controller again and leaks another one.

Free the struct musb when musb_lowlevel_init() fails.

Fixes: 7d017d607eaa ("usb: musb-new: mt85xx: add musb-new gadget driver.")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
Build-tested only, with mt8518_ap1_emmc_defconfig and
CONFIG_USB_MUSB_HOST=y.

 drivers/usb/musb-new/mt85xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/musb-new/mt85xx.c b/drivers/usb/musb-new/mt85xx.c
index 14b28bbae6b..2e13b2a30d8 100644
--- a/drivers/usb/musb-new/mt85xx.c
+++ b/drivers/usb/musb-new/mt85xx.c
@@ -365,6 +365,8 @@ static int musb_usb_probe(struct udevice *dev)
 	ret = musb_lowlevel_init(host);
 	if (!ret)
 		printf("MTK MUSB OTG (Host)\n");
+	else
+		free(host->host);
 #else
 	pdata.mode = MUSB_PERIPHERAL;
 	host->host = musb_register(&pdata, &glue->dev, base);

base-commit: feb8913982e4462c01fd914271f92254a25dc101
-- 
2.43.0

