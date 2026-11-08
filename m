Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92904606A320
	for <u-boot@archiver.kernel.org>; Sun,  8 Nov 2026 23:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rZj0HI8e;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pJwe+sEa
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 698946070D;
	Sun,  8 Nov 2026 23:34:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e18H9gfr6Sx5; Sun,  8 Nov 2026 23:34:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A2E4160715
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794180868;
	b=kKrJeI/TJWv/Cbl4vLfZndmwfoXgMUJCKV2Lng0ejIQCTMEvLejBFiyDa8ZWP7ffWNhI
	 lYuvxlZIGSCIzr5SZUYKBenIBZKKz+8dQeo94Zqfe+FkC2bx5+l2F+tG9Vz0DwMiD9uhB
	 /ABTHPHzaaCso+oayX88r85nWO71oKCt/Yspk07b/T7RT1FakjF+BJM/AvhrCyC1a3pwq
	 HDKKpYfJmQA/JmCm97/08RSDdLdzpMaaoJxrUGCSQK4/muXlIwpRL2UWdeba9NmHujO4z
	 3RcpmyGyfz4m3pQoCKHv/zlhkNo89nQ096XyALUQhsg9x60HQoQyroSTqJfkz08RHTQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794180868;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=neMKljHLq/eZ7aSflHChSWOwee4YIX8fccUDWo7LN9s=;
	b=Ze/7oB1lP84OC/ndFRcKM/Kyt2voxRALOzsKX2p6tR3SO6ieam0QjeLQXbrYd579aPWb
	 aTAh9C8ZVIKsxJfS8ApeDb15ne0LsuX8KZIOKBKG19aNPmg160alq7hKjZnzEP0EkKvYj
	 t9pBlgXFXC8NAmxcRe6FW9J1MpW3tbBB4Z7rLr2KwaZvGZ477t+Q+Q5HdacQKO0AEsPEc
	 P8x/XB+RZj2sVoNtTZd4HxvLNJehMoOyzALAtKUm5xgPmvGbEWtSdonVk/cnSgU+d9Cpo
	 XA71DFYycsKEO03p5V9bmALUzRy+IKdCKrgVeHds4QoZpGqGpQq7LXuDJkl6qpdQr3w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794180868;
	bh=neMKljHLq/eZ7aSflHChSWOwee4YIX8fccUDWo7LN9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rZj0HI8e/sf87yuwz+fUc3wXFRM09QFBfuUaGjH/0zIW29OycDdXslWUIFB2B0xMy
	 jdKzLh9Fj82L0t7+BJasexCRGHyVElfcUkLzUo4ddpaGoJTd0NIqZgNM/Q5TrqgcIy
	 O5WXWlTlrcCQc+jvuN8JvMOrtEEfD/4CUnDqQ48DzX9VuO9QqGBXpOZkZRhtKbGphO
	 t75ujS9GZMCgM2qfnEHxQqgboy/1u1B6cOJM4UvMOdc579x5C4O1SGVqmacfNuWFOu
	 p7V3G4WrJsrvD41vA1JMPysm8pnw0SZb9SUQjDhXub3MRw5m/V3xdxoVU3WCgxHbZa
	 7h++M4OVn160Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A2E4160715;
	Sun,  8 Nov 2026 23:34:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id AF633932
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 23:34:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9554B400FB
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 23:34:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iM_SaLpnUCxi for <u-boot@lists.u-boot-project.org>;
 Sun,  8 Nov 2026 23:34:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E1B1140050
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1233"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1233; helo=mail-dl1-x1233.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=pJwe+sEa
Received: from mail-dl1-x1233.google.com (mail-dl1-x1233.google.com
 [IPv6:2607:f8b0:4864:20::1233])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E1B1140050
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 23:34:23 +0000 (UTC)
Received: by mail-dl1-x1233.google.com with SMTP id
 a92af1059eb24-1a8cc11ac42so172070c88.0
 for <u-boot@lists.u-boot-project.org>; Sun, 08 Nov 2026 15:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794180863; x=1794785663;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=neMKljHLq/eZ7aSflHChSWOwee4YIX8fccUDWo7LN9s=;
 b=pJwe+sEaJF/SujBon/qknefeWCr8a1X+28BhKTjp0LiDwXYwie8itxZVtD+azmg2SN
 Tz6aYQk4yPO7t0wRBtHmI8vzVVwMq0bZLv4QV4eug2ouchf/IvPMoVoXqwQQJ9fCQx5Y
 E9SHLF2KuEKBHbRWO8fCvUrT1tP1/S+nr2GcKNks57VYuNL6yJwhqfOVcTPzW+K459dU
 7OPeHhKUwGXdvhxX2Mo6Oj9gD6kd8XRrZHtF8BIohlwskzln3ZBgxo/BTbFGRyiL4lY6
 LcNlEiLQjZe8tOVmnFN9lCm0r59ktnXtsqdWST0Ekv9aKzHUhoiVNtHn7yUnsR4HGmtr
 qNPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794180863; x=1794785663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=neMKljHLq/eZ7aSflHChSWOwee4YIX8fccUDWo7LN9s=;
 b=lQf9t4HSwIgKwW8R6Jy13bohPbbQdpcUH7jucmUToJYRh7QHJhJMcakOYu8OtjpFdf
 c58w6c9UEk7pryeYQJd/jNdA91NJ3mmrCU5kh060v6s+oIu4khL7B6oe0SiRNqdRkiss
 R/RioytLrzHq42pWBkJN1kydT60WkGQz+1t4K90yJhfkF88NuGFRCfhN/AXrybBM0yGA
 N4oOujZGsPEItoy1aFUUjgCZwg96uJYbOTA8ZpzipoxQmgGPKQ06WFz5bzqRdbw8zZbJ
 3rdZ9YtWPng4/IIWChODW4vbxfIE+cnGT6jel2lk7IPWCcBuTwd7wJR3/k49alj3KlWC
 HvVw==
X-Gm-Message-State: APuU4Z/05/Mu0avMY60WkRXtclh1tmlGcYE4KLmFAFW5n2Hr5R3Bd7XZ
 DYlnh5ou/P4SEVjp1yMZX68+cUROQjiG7WPHH6o5ngMdJ3bFXdNaRPNYVPf++AqZ
X-Gm-Gg: AYBFou1c8hhTpK7zNl/2eI2xSJlfv2Zc68xXWZMIypPJRYUVapF8EObd6AIeB5CWwVH
 6BfWjQafIGS7dzmHb+EJq+GYI/Xg18102frWHmArfx6WMH4wsDQ8szSUhblGiwZabKFXZRvplGg
 CCzp7GuRawwylgYpVJDI4S1axs9IX9PPGWwCNqs/aKhPKWCGwJk/uK8yWJafAn5eByZwezq7b6L
 R52q0hYKHVRdMEoUchqRsALjm4fKUcKM2a4rzaGrkOrAHTlp9jYKy+Va4A2d/w9Z9bE8/lJsg6r
 5GT+4LfwpWvYrB7CksJFxWwXyi0BEPiTupDJD+n4idavt3XNKCLiDuFB3zf+b2ObUH17uVOZBXe
 FGEoNoYjue6HDGmJ8W7UkXTj2AdUYeJDmdI9tr4aTUuFWTn9vq5FQzt+3+hYYdANgo77sRtJ16Q
 yIBZiBUBF+cEMUlsdtZevdNiCxovalkAE4T1WEtysDaPswK9F8GPwgicTurAGwROT5gGejacAca
 Q6BMR15pkeJQN+3SHdwtILt/D7kCXeuzWU0byxYBfKsvJgSVfjVhwd24g7OaoAm/whMtWuW67UZ
 hovu3u80cUKshQiN6pFoVYaMktrJqq8n7/7dqe/ohUX/N+pfvP0eITwAH7q5YKSGLV96f7Nqi1E
 kjYWAcgXynPxCBRPGikz6BYPuuByhrmVXtBs3X7OXxQL8OVjG1JrpkCe+XaxKZVW+TbLOJrYvpn
 AvLWlmipTxzg==
X-Received: by 2002:a05:7022:5f11:b0:14d:c53a:f6a0 with SMTP id
 a92af1059eb24-1b39fe878aemr3166774c88.13.1794180862524; 
 Sun, 08 Nov 2026 15:34:22 -0800 (PST)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b3771eccb9sm7221006c88.19.2026.11.08.15.34.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 15:34:22 -0800 (PST)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: bmeng.cn@gmail.com, bin.meng@processmission.com, trini@konsulko.com,
 visitorckw@gmail.com, sjg@chromium.org, xypron.glpk@gmx.de
Subject: [PATCH v7 6/6] doc: virtio: Explain how to reach the virtio RTC
Date: Mon,  9 Nov 2026 07:34:06 +0800
Message-ID: <20261108233410.1556875-6-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793836645.git.alan.tseng.cs@gmail.com>
References: <cover.1793836645.git.alan.tseng.cs@gmail.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The date command only uses RTC sequence 0. On the QEMU ARM, RISC-V and
x86 machines that is the PL031, Goldfish or MC146818 RTC, so date never
reads the virtio RTC unless that driver is disabled. rtc dev does not
help, as rtc read reads raw registers, which the virtio RTC does not
have.

Give the virtio RTC its own section and say this there, along with the
QEMU version it needs.

Suggested-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
---
 doc/develop/driver-model/virtio.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/doc/develop/driver-model/virtio.rst b/doc/develop/driver-model/virtio.rst
index 30df0e944..05204b5f4 100644
--- a/doc/develop/driver-model/virtio.rst
+++ b/doc/develop/driver-model/virtio.rst
@@ -78,9 +78,19 @@ Requirements
 ------------
 It is required that QEMU v2.5.0+ should be used to test U-Boot VirtIO support
 on QEMU ARM and x86, and v2.12.0+ on QEMU RISC-V.
+
+VirtIO RTC
+----------
 The VirtIO RTC device (``-device virtio-rtc-pci`` or
 ``-device virtio-rtc-device``) requires QEMU v11.1.0+.
 
+The ``date`` command only uses RTC sequence 0. The QEMU ARM, RISC-V and x86
+machines also have a PL031, Goldfish or MC146818 RTC, which gets sequence 0,
+so ``date`` reads the VirtIO RTC only if ``CONFIG_RTC_PL031``,
+``CONFIG_RTC_GOLDFISH`` or ``CONFIG_RTC_MC146818`` is disabled.
+``dm uclass rtc`` shows the sequence numbers. ``rtc dev`` does not help, as
+``rtc read`` reads raw registers, which the VirtIO RTC does not have.
+
 Testing
 -------
 The following QEMU command line is used to get U-Boot up and running with
-- 
2.43.0

