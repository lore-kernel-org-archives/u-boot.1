Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D1CC43327
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 15:55:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8151C84BE0;
	Wed,  1 Jul 2026 17:55:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="m4yvzfQY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED84584C06; Wed,  1 Jul 2026 17:55:07 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0095A84BC8
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 17:55:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-493b966dd74so3543465e9.3
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 08:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1782921305; x=1783526105; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JTB6uFoTPpIeeZCN/lxZN5OGSmF5z/5TM39DDr1YiZU=;
 b=m4yvzfQYijm+8fNlCmw8wyiYOo1u2Yfur4HKjiFm3tUjzGsJBcXFHZCeniebCb/Ssd
 ikr8M+nBJpWartcVgGrQK6mqTnN4ZlmPohTl8zAubOFC5pph/oe5uiafsmQqFG3HwlfQ
 /I+dNpY8ZPjoLXIbou3aL3Ocx7dcSIBZHV/HsPtFa4LpYrJpZU3taz+b2pCoE6izC7bB
 FlK6zcz5/LMLiZBMFbZBf/v60b/m6Ak9fCj1PGcDny4iiaqkcZ9x8e1cf2NflmCPctM+
 vUEzwTz7mHQdikqGjVkvjMMgIgKRt6hPsYEmFRwhSBnyhx88HRdnWNHv02wCGFJnjPIp
 hzDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782921305; x=1783526105;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JTB6uFoTPpIeeZCN/lxZN5OGSmF5z/5TM39DDr1YiZU=;
 b=QS3ZCEirAOftmPyC80bnpyL93Duygp/laTw1w4J6q3C0jn+vFD1Pk+cwmFUY/814rO
 qrc0t0zIHqZaBadZch5jtt7ie5xseAWLudKMbTY+4Z3+ICRWbGcQmwTCjN7rUteoRUu5
 mwPtBwCcx9Lyppylfq3E9q4MLSNex1slZ6rvxB1XYavchqXxq391bclE/3NzvCKMTcY4
 wL2Pzu6zk+3V4BU9DSS+58wSD+kK3+VtuP3XC9kh64ApAAtb0STlRvmtk9MjLfiYgp7D
 6OSpPAvhRTYlI31y8/mjmpOZTXitpZ9i9PlnAb+FlMnzXErHJ07bfsClwJ/0Hb5MIZN4
 hcNg==
X-Gm-Message-State: AOJu0YxzDJK+nlgcL9nkFIdu+XBboS80VOBNCYcTNyU4ki2v2WFfOBsW
 cS0sNPlK2x0iQTX9iLsVYzdnOryZY7kH2SKOM0/TDXitz7EFLsnbHHmJgQQVcKFgwBJGqgNfIw6
 jDdJgaTc=
X-Gm-Gg: AfdE7cmyQeuZxHJl/oFUDVD2Q6bgz/ECwkfxpoXIJFNq+NDEf0YSntOpYy57QyQOYf1
 HQAfpRwdWWF3H25+MnLaCZmrSpnkFdJHgU4ohq+7/pH9pGnJq+Rar47Cnvy83yPEgVTT0aFpQDA
 wP2zQmR99jUvLyDyonH4ChTBeaUH3xamMTqfiGu89+d04vbGP1YpfeawV5yxnTV8DeWhX2QdBcK
 ADdeM5lQhFPiFk2X36VGMGaXQaQLgkCzTkSBcRwXO3vS8fi5B6hfO2fujsE9l7sfHJbF0B8X8tw
 dAWU+mT6MwY33wMRi8R/k37MM01v1sHDPVhBA0jt6Nwq98t4SzE0+MUYE2W6RPdvP8PD7WUJRdA
 Prk4/9qKNIDIjnch/HNI+ZcLrNhm/iBx5EjSkbTEVX0CkCrCWw0IC38fO92e1/f47GrcTZN+VXX
 GK1nODpD4Fr0oyZtrXmxgluID1eKCnePJ64MQnQgcMOlCaFoUasBjLTBmnFF0To/ADY+CfKtH9k
 eg1qkBUYDiQ5Sm0kvbiriSAvwbOlSy1Oufy2gQ9DTVc0sQLiTcS7zhO6xzNe/3BGkFF0Ag=
X-Received: by 2002:a05:600c:c3cd:10b0:493:b7c8:6530 with SMTP id
 5b1f17b1804b1-493c2b56d6dmr27592135e9.16.1782921304902; 
 Wed, 01 Jul 2026 08:55:04 -0700 (PDT)
Received: from [192.168.1.65]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bef11338sm67989275e9.1.2026.07.01.08.55.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 08:55:04 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 01 Jul 2026 17:55:14 +0200
Subject: [PATCH] cmd: kconfig: i2c: add DM_I2C dependency
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-cmd-i2-add-dm-i2c-dependency-v1-1-19ebda3a80f8@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBBG4auQWTtJqUbAqxgXdOYHxoRKWjUaw
 t2tunvf5q2UkQyZTtVKCU/LdosF9a4imfo4gk2LyTt/dI2rWWZl89yrss6lhBULoiLKm7UN+0M
 XusEFT2WxJAz2+u3Pl7/zI1wh9++Ttu0D1wVeEoAAAAA=
X-Change-ID: 20260701-cmd-i2-add-dm-i2c-dependency-d8b349b9f0b2
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Jerome Forissier <jerome.forissier@arm.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Heiko Schocher <hs@nabladev.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.15.2
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

CMD_I2C depends on the DM I2C API but currently does not enforce
DM_I2C in Kconfig.

This can lead to link errors caused by unresolved i2c_* symbols when
CMD_I2C is enabled without DM_I2C.

Add the missing dependency to prevent unsupported configurations.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 cmd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 032e55e8127..636891ed493 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1392,6 +1392,7 @@ config CMD_IOTRACE
 
 config CMD_I2C
 	bool "i2c"
+	depends on DM_I2C
 	help
 	  I2C support.
 

---
base-commit: 23a4f1e22076855df9c8dd93992edd9bd42d7ea2
change-id: 20260701-cmd-i2-add-dm-i2c-dependency-d8b349b9f0b2

Best regards,
--  
Julien Stephan <jstephan@baylibre.com>

