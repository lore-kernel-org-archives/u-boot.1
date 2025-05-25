Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A3B2C54E90
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 12:11:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8233482B2F;
	Sun, 25 May 2025 14:11:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DyHIaIRd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C17E82B70; Sun, 25 May 2025 14:11:08 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 799BE82991
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 14:11:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a0ac853894so1466844f8f.3
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 05:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748175066; x=1748779866; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Kqth++kTbtpKZv8gQRRqdXDkdMVjexrLV/pnMnQ77y4=;
 b=DyHIaIRdeaPBhp/cyrrUDj9h9avK+cn9pSA0i129WwILaK3LTV8Of4AvneLmXdJ5c7
 ombmwD1UEhTxZA2X8hWBYEFv77Ox5a4YIi7eOoTaAHhaXggB9dvM6pUw1dJ3+f3NmeyV
 7W7c+jMvJkfJIwDQ6rCmMrWXj7YyiFybeKkiEFs5TwsImB+/ek2/yAiFpQ4z2kcQcTWf
 iv5p1JrXTui7PORVcKq2ymM0ijRf59Hr8nV6EqRSwkzFH17/a/hJkYfGFtT9oLtCxAf5
 RO9XqvtaIIBaPTztXwWhbD6sz4QQcCPDEJ9iZyxk1OO4JFCNEyGRhcu15A16u2LDiONq
 lPUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748175066; x=1748779866;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kqth++kTbtpKZv8gQRRqdXDkdMVjexrLV/pnMnQ77y4=;
 b=n+cAlo28oS6GOvBqUTVzbSB98PeND8GumX3JomxmbKd9f6rIvnAvzD69CPb+7LCPe2
 ED/JycHZoyds9VS/1PkNN2pV4XuTvcFaLDCDX/iBWImrnqgZ0RPi/d+DfLA9EwSz6VMc
 opuq2+8KNL1oQd0dPHeJFE9TdBT95F5a08k3g0tvYVFr/eo2OQzkBrqo30s2qbmvehFm
 oLOjU9n+iKeWhfEeeciR3PTadQ6iITCylaDC6ndjRqcnTtIj0wEj8m1JnwyX3T8qbYFI
 AfsVER8A0xv+u2mi/JIYKoBdUz+NA53/4R9V44nym8nyZuOO6O/HGMWpVeJ+XFzyGox7
 zIog==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOGFxpOGyO7oFgaDCnj2bLZ1DncjM4q9G5B7CP1oRD6Ly5m1g+uD6nU2ztRKZ73DCkJgLvfPc=@lists.denx.de
X-Gm-Message-State: AOJu0YwF/Ws4HzIcv0XmLabARITwsmRFt3/eRv09wEqP0imxe75Qp+gp
 8BN+ocHlnz6OMxgE/BdTTfV+2IPCxUJ+7f5qFAbK8HMIdSPNQJHjxeJ2
X-Gm-Gg: ASbGncvXjCQg3Y4XdDZ6UE3ZaoOrgt1ZVCgHPaayiRXi3Q3K2ZmCvHB7WOhfEZ5VX7e
 bcnwsKBi/tJaRRMa4YaA7lsVZP0blU+TmR3Yd0IfvfqElSG2rL37Gr2YYDmXb5loH0Muwb30ahn
 RhWFRD60nnuXmYMCRjeUizsHbFitwoHndta48ourzhTVQ4zleJW9aZvzhi4P8Qbg36Xn3idFLnD
 M37tB2/kAKPtkLkp7FwgWx31led3le9G5ZtvDEWIDBkIOO79/+ZDBa1muecLoYz0GPEtC/dAjrl
 vWqDOxQ6T/Gx6k+DM+SWdnugtVAZ+0g3EnrN/UAObyn5uVEGbYiEWkMrOLgO4k/w9H/joWMm7DU
 YvGN42LjC7G8MIYVdTUl9UXmLBqzPdJNl7IcFTLh8Vw302BxD0YJ0TizCj91YhXSL0M1EguoTab
 VX4h75Ffi0Tg==
X-Google-Smtp-Source: AGHT+IFNxwYWfEm2OD03jkEOORnXirngmcboffPmsxmqujfxJmxsndy9BfaNxsAGbvs7jBshd7nf2Q==
X-Received: by 2002:a05:6000:2908:b0:3a3:5e77:436e with SMTP id
 ffacd0b85a97d-3a4cb489b95mr4159482f8f.43.1748175065640; 
 Sun, 25 May 2025 05:11:05 -0700 (PDT)
Received: from cypher.home.roving-it.com
 (2.c.4.1.7.3.6.4.2.a.a.3.0.f.c.2.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:fb11:2681:2cf0:3aa2:4637:14c2])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3a4d007bbccsm3405025f8f.89.2025.05.25.05.11.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 05:11:05 -0700 (PDT)
From: Peter Robinson <pbrobinson@gmail.com>
To: Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 Tom Rini <trini@konsulko.com>, Dhruva Gole <d-gole@ti.com>,
 u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH] doc: board: ti: Add missing firmware for BB-AI64
Date: Sun, 25 May 2025 13:10:58 +0100
Message-ID: <20250525121102.415770-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.49.0
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

The details of the sysfw.itb from the R5 build that
also needs to be copied as part of the target images
is missing, but is included in the image formats a
little further down, so add it to the instructions.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 doc/board/beagle/j721e_beagleboneai64.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/board/beagle/j721e_beagleboneai64.rst b/doc/board/beagle/j721e_beagleboneai64.rst
index 090b2b3b86a..a57bc743569 100644
--- a/doc/board/beagle/j721e_beagleboneai64.rst
+++ b/doc/board/beagle/j721e_beagleboneai64.rst
@@ -83,6 +83,7 @@ Target Images
 Copy the below images to an SD card and boot:
 
 * tiboot3-j721e-gp-evm.bin from R5 build as tiboot3.bin
+* sysfw-j721e-gp-evm.itb from R5 build as sysfw.itb
 * tispl.bin_unsigned from Cortex-A build as tispl.bin
 * u-boot.img_unsigned from Cortex-A build as u-boot.img
 
-- 
2.49.0

