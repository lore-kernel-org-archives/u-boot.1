Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A745F8DFF9
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 17:43:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39C168428C;
	Fri, 17 Apr 2026 19:43:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="faFJ1D7A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 444E884310; Fri, 17 Apr 2026 15:42:41 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 581C9842CD
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 15:42:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ernestvanhoecke@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso8557115e9.3
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 06:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776433358; x=1777038158; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rCEHC3eoH6iJgPV3QG5p/+nITlT0VKbSK9xK4Jps77U=;
 b=faFJ1D7AFI3N9R9qOJ04IV5JsmRxKfO9xfk5div0RCiKoWgYIINDVUOghkMqII5nwn
 msnpJMZLhs1pq/qgrgOphfbpcKFJx6ECTA41qm/HTTUvCS0RnsLhoh8aDPUq916vcbyM
 jCDPfUBKT/51caYDsYjLonhDdD8DvIdyiYKfpmG2JgyEuS7PH3SwxsEpVh1TPqNBYgkY
 qBYk853WrGjpl8R+mhPa12/MC9VYPLo8qIw+Rh6UsYgn082pwHp+RfxodvKaDN44KVfl
 p8iXOvEVF4uHObTCE3J+NxTfhSMg/PqTVzhmnFTs+KvU1B+YxOhCsz+lFT+V75gEcHNu
 4egg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776433358; x=1777038158;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rCEHC3eoH6iJgPV3QG5p/+nITlT0VKbSK9xK4Jps77U=;
 b=Ttur57UwObysIHH8jr9RciAJlU1atVJfd4u5V+OjCqNKm1YXOHnzloup8dcCjd2J3b
 7frbpA8trecGlUTWYvGuoXZLysw9rrcT6+c/CKSAEHiiAWWj0gDfwYHOe8rp+TxV9SZz
 eX3Er/Pm4B4HdTA3bZGZwhgRBWcwjYkKTlxtLNyXBYHh7JigUdeQCEQMEuRC3Cwpovyg
 u3IIFkqoOkRTC2casmcIkGKgdawP2iMAQvXpMkHAGYK3BNQjopsr6PGZokMMcekvD1Qt
 sb7fhtB3QaOAae3pU3+xzHmnFfJw1+T7PV0jT9xWn+CjMZkhFxLovcs5wJkpeyWgLZtx
 bvRw==
X-Gm-Message-State: AOJu0YyWqZmjV6u5Xj20AuA986tFhNt8abEtrUpX4lHkGc91pom3Klsw
 rMvmJFtsclu2AXoOQAIFuGGP5Fo8LS6RHOhv3IPF0XhOK6oMP4GVR9yzuBkrnb3I
X-Gm-Gg: AeBDieti9xK9TQK+9e7mjqZZmaMOVahv6LtpcozLwqcNngGkKjYnOSAEDjsnhqbgmNq
 1NknjgnhFcKd6++l0sfibfGKAEOMvRRdqm0ro+CyRbmNpNXGzDXxOpJOgan5K7Mx5YwYsd0jpLU
 3DlRrV1T12foU+lGgZ6TQLHSxVoMvXbqjXY8iJg3oiD16L83KAvxvkY4nZa0wErKIzT/OPj4F0H
 tObZoUWKQudrNSZeFjkmAI5lLw6aYENCiQ237puev9bHRrcmX5VnvxsZw/ukwqWK0+q7N+bdYhd
 /Fz1Mlhe96oy30sSy4xKar7VibIWuHcK8Z+dJm3wE1I9QinF2ALG0bM/fMd9qqpIKdoi/+8ZwuR
 8wUgvVtu2eYi1RiRa6zinAS5GBztaBd1qPYlltzFX3vQrV1mUawjQbVPi9kaEY4PQwb1Qmyww8w
 ce6nKc964sK7vqM2OGMGteEC9oMOZRRQsmH0z3QVYQThH8SDJmVhCtlBYcnhmIqh4q4/RLLgwmC
 HIDrojOMJEAG4+40Okox8fPO1ub+oQamZ1ljYgtoA0sgtCl
X-Received: by 2002:a05:600c:8909:b0:485:30f7:6e88 with SMTP id
 5b1f17b1804b1-488fb78a385mr33710635e9.31.1776433358423; 
 Fri, 17 Apr 2026 06:42:38 -0700 (PDT)
Received: from ernest.hoecke-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb7a0b60sm16729095e9.17.2026.04.17.06.42.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 06:42:38 -0700 (PDT)
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Date: Fri, 17 Apr 2026 15:42:04 +0200
Subject: [PATCH 2/2] board: toradex: aquila-am69: add remoteproc firmware
 pre-loading
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-elb-6911-aquila69-ofupstr-v1-2-400d93db3747@toradex.com>
References: <20260417-elb-6911-aquila69-ofupstr-v1-0-400d93db3747@toradex.com>
In-Reply-To: <20260417-elb-6911-aquila69-ofupstr-v1-0-400d93db3747@toradex.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Apurva Nandan <a-nandan@ti.com>, Vitor Soares <vitor.soares@toradex.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
X-Mailer: b4 0.13.0
X-Mailman-Approved-At: Fri, 17 Apr 2026 19:42:59 +0200
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

From: Vitor Soares <vitor.soares@toradex.com>

Some use cases require remoteproc firmware to be loaded before Linux
boots. Introduce rprocsemmcboot and rproc_fw_binaries to load the
remoteproc cores from U-Boot, relying on the TI k3_rproc framework
which already handles the secure firmware variants, firmware loading,
and proper initialization.

The firmware binaries are expected to be present in the eMMC rootfs
under /lib/firmware/.

To activate, run rprocsemmcboot or add it to bootcmd:
  bootcmd=run rprocsemmcboot; bootflow scan -b

The upstream U-Boot does not yet have the remoteproc DT nodes enabled
for the Aquila AM69, making firmware loading fail. Marking as pending
waiting for remoteproc enabling, which could happen along with the
OF_UPSTREAM migration.

Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
 board/toradex/aquila-am69/aquila-am69.env | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/board/toradex/aquila-am69/aquila-am69.env b/board/toradex/aquila-am69/aquila-am69.env
index f8b7363dcf51..d61898091aa9 100644
--- a/board/toradex/aquila-am69/aquila-am69.env
+++ b/board/toradex/aquila-am69/aquila-am69.env
@@ -1,3 +1,5 @@
+#include <env/ti/k3_rproc.env>
+
 #define CFG_RAMDISK_ADDR_R		0x90300000
 #define CFG_SCRIPTADDR			0x90280000
 
@@ -39,3 +41,22 @@ update_uboot=
 			setexpr blkcnt ${filesize} + 0x1ff && setexpr blkcnt ${blkcnt} / 0x200;
 			mmc dev 0 1; mmc write ${loadaddr} 0x1400 ${blkcnt};
 		fi
+
+rprocsemmcboot=
+	env set boot mmc;
+	env set bootpart 0:2;
+	rproc init;
+	run boot_rprocs_mmc;
+	env set bootpart;
+
+rproc_fw_binaries= \
+	2 /lib/firmware/j784s4-main-r5f0_0-fw \
+	3 /lib/firmware/j784s4-main-r5f0_1-fw \
+	4 /lib/firmware/j784s4-main-r5f1_0-fw \
+	5 /lib/firmware/j784s4-main-r5f1_1-fw \
+	6 /lib/firmware/j784s4-main-r5f2_0-fw \
+	7 /lib/firmware/j784s4-main-r5f2_1-fw \
+	8 /lib/firmware/j784s4-c71_0-fw \
+	9 /lib/firmware/j784s4-c71_1-fw \
+	10 /lib/firmware/j784s4-c71_2-fw \
+	11 /lib/firmware/j784s4-c71_3-fw

-- 
2.43.0

