Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18880606A321
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 18:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=P418AZim;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ev6Lp3gT
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DC45780CEC;
	Thu, 12 Nov 2026 18:28:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yVbnPGP7uu2Q; Thu, 12 Nov 2026 18:28:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 388DD8119F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794508128;
	b=FRPaeMGH7JPgZvjKfmVJn1jDADXoJwlY5/wOhG0uPBw1ksPUdFsUWe+45s2X/cWGUBvi
	 ZZCi74lcrGsl/mKmDXyo4iMC7bJfq3rZt2j2Ys/XJnBDYuKkl01qcFV2G4JkQSdDDEMTd
	 /GyK4NbtEXndOU5tLJTqPF/hw+bfI97Ne+3n9ab+BI7VXU2SADTZtpvxXANFpuX6YAlDM
	 Mi3hUJ0/kj0WAesTDwgAj0Dy31CZjjQ5QqMFTd8XxepTouU9eMjL5Nfi6BEl8KD5iCmY0
	 wlEdVtyqetxlsKdvpUxDOzE/IGAqfHabiQ0bJJOvLWYo9gPPr1sMLwKOgMmHZCsgeKQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794508128;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KlriQlXQQEx9ZHGbF1gJdR4/nwCmPssIfasNnhyY26M=;
	b=FGZr90QUlP8v3fPu9GKXRasddrEvG8wbWNJUAkfx6aYVNkU1IYOmm+fiz6bjQvI7ClTy
	 VQBCM5wZ0da6PtIYhz4Hk85MVz/yIrqdm8oyYXP3lX0tFsOkAfqgmckqVntApnnbvkvCx
	 ztL8GPwOdOcNje2mdD6/72enZHmlEAdKxCbruXBn1rMXkupDKMZbOPBxv1MGeCK2Ko+j+
	 7lkqXp75bdMsMhfcr7swJDcTp9/fqEXy8Jv6eqN6vlYXngDi9H656l+ZJ/qjVkrMVBuCb
	 FB+4Tt3e1dKD0kE8rwPLpJmh4tqZwTh3egKEcoiT/36faTl9MeTgc5GCcs5z6t+MRdg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794508128;
	bh=KlriQlXQQEx9ZHGbF1gJdR4/nwCmPssIfasNnhyY26M=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=P418AZim89dagrRQyBjXhoF6ZYfHQdWxgTF60qqVUL7ej6oIAGyhcGAb7m8nXXvnw
	 iscG+GLcspYiCpV1we7pGnbEEzQAAC2CzVX4OxpUzp1SSGfvbOImv7121yfR7zjF0N
	 8QuoWmaG/XlM77FzWTNjdCUF8epMEZQCQim/qK6OltjIdGNWTFtLyc6te/yAEZn468
	 DG5zLt8ucaHfFyug+YkAXmAMjbLtbSmo0FAM/z1bYOFhcHtnfdafV4A09J3NiW2CPE
	 OUplzjvzqsXqfINwBfbHWSjoryoZ1coJ7ZA8m1HXhS5XMzuBQI6HnkkAb9jgJlRNX7
	 F2AYxXUGT8ifw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 388DD8119F;
	Thu, 12 Nov 2026 18:28:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7CC69E09
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 18:28:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 62A29606B3
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 18:28:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wO3xFfqyGFE5 for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 18:28:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 69CB16067E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=jernej.skrabec@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=ev6Lp3gT
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 69CB16067E
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 18:28:44 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a210470b49so908645e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 10:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794508123; x=1795112923;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KlriQlXQQEx9ZHGbF1gJdR4/nwCmPssIfasNnhyY26M=;
 b=ev6Lp3gT4caeMSJ1beqt+xqvKg5S88uZFBz+4AJWPlvUn2cPuyBZ4zY0df9LAY+j4c
 KPuHEKW6wDnJXyND14VemU2qhe577uZdAY2ZRCZNgDUuADbHrJq3v/l93wCA3gAA1biF
 nHfH6j040QkqQTUolarQr4XnuUAutfxByOn7tknMx1TLsRKTT+bsGVR5v4/RmhfAlImU
 JDxrs2GzS89u4c8dDH3geEYgNiiZYZv0OL2zPPPJ6FAw1tTWdSlInn/HR/gpON8t5i1L
 08jJ+Z5P3G4opqZw5nLjUw1b/VbC2I/SLi+Hn8QigYxqb/GFqDNd5yXW2LiuPT/AzdyI
 zmig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794508123; x=1795112923;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KlriQlXQQEx9ZHGbF1gJdR4/nwCmPssIfasNnhyY26M=;
 b=yt94zNKUrYNwReydWh20fXyQk2JQoX3JQ5siD3hDIh9q0VmeXKoJ6nM89oAJX6Gr6X
 ndQFe4tzBpoOhwLr/2hgujWs4S+IvJ+OcRpqzHhqbt5gxH4vrMukCgRL4QOqp30iT6x4
 arPdyqBIs7t+9Zm3HGc+X4JWCjohMuT4bPKYvZiFnb9AZNLIZM1pMxOG+IEM+xLmoh5x
 vMa59lC6VRGUGfIQZDLagX+N+KvSFDHJX0B6tumQ9kjempR/9pDx57o4TsDEa3mxcj8r
 QakmopCVd49kDzi9HxzJxOi8Kb527GdFiMu9mHpXuw0FEvpq38NDNpXtVUylHNaBXXP3
 3R0g==
X-Forwarded-Encrypted: i=1;
 AL+hErHGL/+7kJyLdt3ImJIpIEmLSFdKC4iOGyO1o6bn7ry/La3Chu43xR+iygCjS+bp7uxkcSHXIRU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9prnyRUm1WxKJ0HsAT97CPUVHAo5aiH6kP2KaAClCJp5esz0JS
 2pWx/1jlNDhNB3i6pEailpnvBtZToOOhTakBY30qZ2yQBPOQQd4/6c0vEZU/6g==
X-Gm-Gg: AYBFou0N/Xzoz3iik9Qw1lcGpLnKVP3CZnZC0XzY71T+hi4/mRMiqGfkaTvz2qkdrK+
 rnzydvilm8WuwE305n/WGWU/52sWD8gGRt2DoDYy0iwK/a9ArRnJMmG3TEF3Sc4Aep+pwgMnWsy
 9wQzwwivNuGpHa9j3X8NJuveRllU47VPyXmAnDnsMDuPMdmyIJMtK4BeBeetvdqj3piGbg9+7kq
 wnfXY9GkWSrS/j9NjhSL5FbPRTSmk6XkLEAMH8R+4oCNFRol1Vqffqq+SH/OnrlmFhfaZfFCBqw
 3a2NEQzD4Z/JdkND8i+8dw+3KwkGwNLLSSnaOyX1hzyoEGoJ8Q/Xf+SLiUAw/fpcJFmyl2hxy4Q
 Ds+wtWZHx34eDBLqu+qyHYh1dy8GGPVIHEQh1RC5DDwwYqeqwEIArkEooXJRANDv3FRUqK8qW/Y
 CdJE42uWraMXREq30h1kZV3dR5VTmiDZuHWzTelSFfEnntNnFlkGWFjgZ6kVzhUyJ9zxg06ctQn
 H4w0g5qognXr3QsxlhkD9p3fJZWNQvNmmCWMx0RwaOG1GMDlSaE6gdZHgL/KpN6mTW6J8sDhOJf
 ngmKVAUY+zfbOeanQr+03Q2XgSgR/SZsnmXqH6saY315tKTZhH9R4JYBzJOhOSs7SP5j7PwO2zp
 wN7X3LuXO+3EbxN6JPUY22WIo+UrEWENBL/0PLRA7sXJADreJAXfsZAWQeGIUyQj7R6aN/1u+yT
 eqRvA/QLfHKYeIoTMbYyjFW+L+IeutybkDJFLsfosBtvTGprdbBjQTa3AziBt93dg9LPhs8REyH
 1Qr664Kz284N10anbASLIsfuGbr2oaxiB+J+hAFU9wu4ZRSsm4=
X-Received: by 2002:a05:600c:354a:b0:4a2:18d4:f9e0 with SMTP id
 5b1f17b1804b1-4bb55abaedcmr707835e9.25.1794508122616; 
 Thu, 12 Nov 2026 10:28:42 -0800 (PST)
Received: from jernej-laptop (86-58-12-36.dynamic.telemach.net. [86.58.12.36])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e2adf53sm86647975e9.15.2026.11.12.10.28.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 10:28:42 -0800 (PST)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: marek.vasut+usb@mailbox.org
Cc: trini@konsulko.com, u-boot@lists.u-boot-project.org,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH] usb: host: ohci/ehci: halt the controller before booting an OS
Date: Thu, 12 Nov 2026 19:28:38 +0100
Message-ID: <20261112182838.2792025-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.56.1
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently, OHCI is not stopped before OS starts booting. This means HCCA
is still being written into during OS boot. This may cause all sorts of
random and hard to catch errors, if same area is being used for some
other needs.

Mark OHCI and EHCI drivers with DM_FLAG_OS_PREPARE so remove hook stops
both controllers during OS boot.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/usb/host/ehci-generic.c | 2 +-
 drivers/usb/host/ohci-generic.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-generic.c b/drivers/usb/host/ehci-generic.c
index 1ae3619ce25d..8075fb069f15 100644
--- a/drivers/usb/host/ehci-generic.c
+++ b/drivers/usb/host/ehci-generic.c
@@ -167,5 +167,5 @@ U_BOOT_DRIVER(ehci_generic) = {
 	.remove = ehci_usb_remove,
 	.ops	= &ehci_usb_ops,
 	.priv_auto	= sizeof(struct generic_ehci),
-	.flags	= DM_FLAG_ALLOC_PRIV_DMA,
+	.flags	= DM_FLAG_ALLOC_PRIV_DMA | DM_FLAG_OS_PREPARE,
 };
diff --git a/drivers/usb/host/ohci-generic.c b/drivers/usb/host/ohci-generic.c
index cc44226f5e0b..66f1fd6fd668 100644
--- a/drivers/usb/host/ohci-generic.c
+++ b/drivers/usb/host/ohci-generic.c
@@ -110,5 +110,5 @@ U_BOOT_DRIVER(ohci_generic) = {
 	.remove = ohci_usb_remove,
 	.ops	= &ohci_usb_ops,
 	.priv_auto	= sizeof(struct generic_ohci),
-	.flags	= DM_FLAG_ALLOC_PRIV_DMA,
+	.flags	= DM_FLAG_ALLOC_PRIV_DMA | DM_FLAG_OS_PREPARE,
 };
-- 
2.56.1

