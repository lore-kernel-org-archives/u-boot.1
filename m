Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E33A1F46C46
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 14:24:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64FE483FA3;
	Mon,  6 Apr 2026 16:24:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="BytAxX7I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F6D88341A; Mon,  6 Apr 2026 16:24:32 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A3DB83936
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 16:24:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2ab46931cf1so32903475ad.0
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 07:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1775485469; x=1776090269; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3SOdY2pGn/z8h0zDG3RRTyREJ6dseBVfoCE76glk3Uw=;
 b=BytAxX7IVH7EwruABEHaP0dWjqAOpXevUcXdlLckqv5talQ4KXblbMdN/XIex1kSJq
 3F1UnYeBucsJq2UVrv8YChm5LgymgFs9nJzgnGU2Gt7p2WEx13pa15z8us4kVfRIfJbj
 BXOnIr7w3uouUsBNS1Yb8P+1Em4s2N1Za2dN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775485469; x=1776090269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3SOdY2pGn/z8h0zDG3RRTyREJ6dseBVfoCE76glk3Uw=;
 b=ANptdxuw7fP116BtWggmGKR3azexEcFNlhwGECVVYyrL/kuOwdiJYBiPoxKS+utKRc
 ejc1uQBlc4HbgMnEM8QIwPi+0auP6ojZ+AFyPpAwWaOMw81Tr2fccyvKi5jVe0qx7p9h
 ntuVC6qgAx9TsDcWag6Ewa2DVpY8Dv+VLU/tDskukDjMJvx3i/P7Vk+bfSVeAhzJq9y4
 gPnBXEbKqYyVnSjay0C4NhQJB7IiuliGEzNNmgNYOKfKk5ZKzeprBfHeFpXxZp2+Q2zl
 GxAXD+vlbibe8WO38/jWMBGSdchnS8CAUHGzNeqVsTiXEnKrojBcrEel1RB1GOuYIh8Y
 4/vQ==
X-Gm-Message-State: AOJu0YxQ8oxpAd8gTmMmMuC8aCAfs7d4yw779CQoOV9YYicWP1m3SbFT
 s54KZ231GNrWSzOEMPeFHwjZJFii6wJNkNOe7Qw5aWPWIRkX4bb0ARKbaBjVJnPzUBV3ZNDHbhO
 Zp+lW
X-Gm-Gg: AeBDieuACK6WUJ710JkwYQgKsKA+P2g8q+/tmGT0f/ZbxTaXcIvTKw1sd60rIPprI72
 p2/EAB7xGCeY+noief/qXSjvuWTUrRYsdDeUE9tOGa8TVaSav6qars9nX8MG6F/rogTXfLaijvP
 CVeqAsD+IrNXTszQEbYuKYtVmIQFMLG8ROegRy0HviK8fiMbTR9G/BbmU4IDWyI09tdM5WxG24t
 TwvPfPkjKaDFjwc+Tw9dLTs76TXmuRiwdm+leSBtdM2WTjlJwYz7hjHzgkSf0A7krYoMIZqEXDR
 UJRK6QKmBiYBzZXpnLkLFXEhsGa9/nYcXhzb1aUJnNjhXy5e58bXqQBKq3+2RietBvJMGETpBv3
 yz17Yibpyvopp7IGbd8Eme3v10YdXapovz1luJRtftKroPjNfrU2LzgB2zdmFTmODiOai0R3SLJ
 UxCLT1plWzJPoveaUnlvyc742XNM6Kp3Gnw1h4kBd73nv85zPBs/K/84z31qaLxdsXyZBnSSbnc
 DukZiK5Iqg=
X-Received: by 2002:a17:903:24e:b0:2b0:6ba2:3d78 with SMTP id
 d9443c01a7336-2b277d62983mr152081895ad.3.1775485468923; 
 Mon, 06 Apr 2026 07:24:28 -0700 (PDT)
Received: from kinako.work.home.arpa
 (p1866070-ipxg00f01sizuokaden.shizuoka.ocn.ne.jp. [180.1.30.70])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2b27478cb4fsm156885295ad.29.2026.04.06.07.24.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 07:24:28 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: visitorckw@gmail.com,
	angelo@kernel-space.org,
	bmeng.cn@gmail.com
Cc: u-boot@lists.denx.de,
	Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH v2 1/5] sysreset: qemu virt: Use __raw_writel()
Date: Mon,  6 Apr 2026 23:24:07 +0900
Message-ID: <20260406142411.2992618-2-daniel@thingy.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260406142411.2992618-1-daniel@thingy.jp>
References: <20260406142411.2992618-1-daniel@thingy.jp>
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

The virt ctrl register seems to be native endian, currently this driver
uses writel(), which works by luck because its currently broken on m68k.

Use __raw_writel() instead to avoid breaking this driver when the
endianness of writel() is fixed.

Signed-off-by: Daniel Palmer <daniel@thingy.jp>
---
 drivers/sysreset/sysreset_qemu_virt_ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/sysreset/sysreset_qemu_virt_ctrl.c b/drivers/sysreset/sysreset_qemu_virt_ctrl.c
index e7cacc9b6e98..5ab16001922b 100644
--- a/drivers/sysreset/sysreset_qemu_virt_ctrl.c
+++ b/drivers/sysreset/sysreset_qemu_virt_ctrl.c
@@ -38,7 +38,7 @@ static int qemu_virt_ctrl_request(struct udevice *dev, enum sysreset_t type)
 		return -EPROTONOSUPPORT;
 	}
 
-	writel(val, plat->reg + VIRT_CTRL_REG_CMD);
+	__raw_writel(val, plat->reg + VIRT_CTRL_REG_CMD);
 
 	return -EINPROGRESS;
 }
-- 
2.51.0

