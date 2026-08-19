Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A59C5DF85
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 09:37:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DEED360611;
	Wed, 19 Aug 2026 09:37:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XYkay7kFws1O; Wed, 19 Aug 2026 09:37:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787132235;
	bh=/mUsw43u7v4e/vrfnwHaW6AxX/zqS6HtiyVmwqW+d4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V87Kyf4i91do9ZQNp1vOyunckR8kn/HiYcguvhH243WPUXSzVHyJhmECmfBrGUVF7
	 KuHLC+KtWKenMrcPv+rPRhwbTR0zf7TesGjibJOt2OsC636m67wGhmqWjoyJJsuAB7
	 GOwoHaD/aKVg3+uYBYdYvfuCx0kq9FFXxIbV7N4fPaUSnXpKN5zR3bG9WW4KTo9zXI
	 qp58uA4/Xk4WACKEXZoSuq1yYO5KFnNF6RgnoZ7/+9z7Pcc49MIMj/q52/mbcbmDXl
	 b03WUVO6Wd1w0KNxYduXLO3GOhMQVXhZrUzNJZxKMZIH87T05SFX/tYTVx/Bwwa9lY
	 v9x5gRdBIt9YQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4A94E6061C;
	Wed, 19 Aug 2026 09:37:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7E9A42B2
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 09:37:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 70A9440077
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 09:37:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4gekRrxLvbT2 for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 09:37:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=FaYYk4KH
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7DE0640042
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 09:37:10 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-4813ea321cdso1290889f8f.1
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 02:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787132228; x=1787737028;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/mUsw43u7v4e/vrfnwHaW6AxX/zqS6HtiyVmwqW+d4A=;
 b=FaYYk4KHNlnnWvGG+lFju5l+e4Ol/LDKLkHZdd3/5T7Pd4Mx1lzXuMoN4ZQ59ldCcj
 gOb/a1Cx67nyjUtOeIGPeYLr5fdUxog/AkvhLcoPi0tlFqFgYJVoeJ6Q2wrwDzOOmd1B
 e0avNe3wN5jbUeetJfKw6zOYtuaSlU1TeWNyMmn0BCFLCxHn6+6i9CzPhoiuQZPBURTq
 7T0k9M5KAc2JmTB1M5Wm2uccDV/6JJCovogD4b/i3bk15e/2ztL+srg3P3rJ+VuoYpKW
 rUWe6Ak51ETcin9RHOySALZDNlGD6MpickIMRakylVoXExP6vmVRNQT0TV1P1zVW0vw8
 j3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787132228; x=1787737028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/mUsw43u7v4e/vrfnwHaW6AxX/zqS6HtiyVmwqW+d4A=;
 b=qIFQ8ieER990SYLcHslREdjvFFaUZ0w20lQubEq//RxeP/EsFKUal+XJumKN1ee9ML
 bYs0Qtg+98MMGvKp6MJTTuJE5E0hb3CrUpVmDrF9wblhlHoniIypMMdyqauK/4dFLarl
 QxC1IP4eVQ0t73SoKfST7Miu/mL3jZlviX3X6VM6mE/FjuI2QW7esa9uz9+QEinKV0rw
 vKmWAOaw61e3zq/HS2ozcoCnVDKwoD/vPkP2FHbDg8ZF2IuRJr4Y8ygX+Szi7SyYILTC
 7fG2rulta27qMrpKZezwD5RodFxsOstH0atHGS1CJeXrU9ns9VT6/ZWdEB5fX2mw7vWv
 GdXg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp9snZM0dkwDKgMO21926t0arx/1IvXp5gsbVX33IvWJmSOR1VRBuYQlmo9CrVYlifVYsqz928=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YydnNZJydgITO4GiDOyIs1NctRjBQI8/e85QFUst2YF+PqGJNyA
 4NGW3VfibJ+5Mf74x6Qb1tph805mi0diDUxTHPh4xqv7+9j8VYRF9anM
X-Gm-Gg: AR+sD13HMWHhUY19ZLd9L5/cE47I3cJTMyATOECvIYrpDOpzFKpk11rhTSEzn9GUFNY
 Con7bpVNgFeecUIo4q0dk2fd5vOidD4sVX2j6mLSV6MDJ65wqAOFhdmlSSicTs2suIqFzEosiB1
 pchk4KNMhJpquk1Odt0Xa+8ann6nnwIMm6ZLagLfFjQ2O+lq1LD/XK1SdErULCdXt0ZCGE6V5Bw
 VNuygVpRA5uOolkMMTjHgEZ1ps1EhoXFsnSvqYmRfWeTiHg1I5nVIB5EoAXGUcJka3jTb31AOH9
 J5JXsLEUr6wcneRxLjheNHDKwbiGXHqN9o3W8Mh29DGgeUz6dqUCwkEvqPmCFZBYaHAY4qycmXq
 kgz1v/dVZOYo1q1yMlCXpF+yunz9z8Ei5HABQaSrNJZvHY1x5OAFpaRPrYyAfex1TN8zQnr++Rl
 9dKPvcZQLguVHihhD0AFUBfs6EWD6Z85i9JLrigyC+F743jV8v7qMq6nACUgX83xP+HMfYJ+leS
 gAJ
X-Received: by 2002:a05:600c:6308:b0:499:59fd:dbfc with SMTP id
 5b1f17b1804b1-499aa0ab6b0mr52518945e9.1.1787132228277; 
 Wed, 19 Aug 2026 02:37:08 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aca21c63sm37939945e9.0.2026.08.19.02.37.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 02:37:07 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: [PATCH 2/3] usb: ehci-vf: drop the empty bind hook
Date: Wed, 19 Aug 2026 11:37:04 +0200
Message-ID: <20260819093705.4143509-3-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260819093705.4143509-1-mehmet.fide@gmail.com>
References: <20260819093705.4143509-1-mehmet.fide@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

vf_usb_bind() only returns 0. Its comment describes a hack that keeps
the second controller from taking sequence number 0, but no such code
is there, and an empty .bind cannot influence the numbering the uclass
does. Remove it.

Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
 drivers/usb/host/ehci-vf.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/usb/host/ehci-vf.c b/drivers/usb/host/ehci-vf.c
index 5d27318de62..e5f9ec0fdbb 100644
--- a/drivers/usb/host/ehci-vf.c
+++ b/drivers/usb/host/ehci-vf.c
@@ -261,20 +261,6 @@ static const struct ehci_ops vf_ehci_ops = {
 	.init_after_reset = vf_init_after_reset
 };
 
-static int vf_usb_bind(struct udevice *dev)
-{
-	/*
-	 * Without this hack, if we return ENODEV for USB Controller 0, on
-	 * probe for the next controller, USB Controller 1 will be given a
-	 * sequence number of 0. This conflicts with our requirement of
-	 * sequence numbers while initialising the peripherals.
-	 *
-	 * FIXME: Check that this still works OK with the new sequence numbers
-	 */
-
-	return 0;
-}
-
 static int ehci_usb_probe(struct udevice *dev)
 {
 	struct usb_plat *plat = dev_get_plat(dev);
@@ -315,7 +301,6 @@ U_BOOT_DRIVER(ehci_vf) = {
 	.name = "ehci_vf",
 	.id = UCLASS_USB,
 	.of_match = vf_usb_ids,
-	.bind = vf_usb_bind,
 	.probe = ehci_usb_probe,
 	.remove = ehci_deregister,
 	.ops = &ehci_usb_ops,
-- 
2.54.0

