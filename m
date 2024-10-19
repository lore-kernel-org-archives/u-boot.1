Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B314D3C919
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 15:25:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D39F489312;
	Sat, 19 Oct 2024 17:22:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iGOc+PDk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 678DD892FB; Sat, 19 Oct 2024 17:22:52 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45A47892F3
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 17:22:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-83ab21c269eso113183939f.2
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 08:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729351369; x=1729956169; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Al8TEeZy7lTL2qjjSsdEOUOodZd9X+HxzIiGCBjyJ4=;
 b=iGOc+PDkzE1sa/kMo5NZYN3+/nXkXr2QSysYmnU7NjwBfGcp61CYZ6/5TRWPbRg/Vw
 sZ2oges6cVpKDii0TszAiVn2NFVHBuEBhUWI5dwxLR46zOAFIviNyCeUTgxw5D4uUUO/
 d0lpxGexZ5eFE7GcMcAODqhlcul4mcAIAhse8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729351369; x=1729956169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Al8TEeZy7lTL2qjjSsdEOUOodZd9X+HxzIiGCBjyJ4=;
 b=Mb5wohIavlLIQfTvGw7ztA20m/WRwKfTevIjyTvXy0bHpq+UbdvE5Q8wSfY0np9cxV
 05F/F6OWkXdNGzbcnyPCBFIlqNzzpfu0Zj6LF1gxCTqylOsQv/rf9eMOeh6tw7Rj0sw1
 Bi2UNNWtgbl5GMzim+VXWaTHn9Y/SAc1p9524JQAPC78YN7KrUXnBUtzXMsZj/iqeTRc
 b6S/UijRt2K4RuCcDs/uxh+Xh0AQBZeKT8XmKXekGCyXaomtj6scz5MW79zjixEfwPVh
 qHnc/cyoPJKh9Ja87fG4YaHlswNzagckPjl6qFeuZ4GO/Kbl+vl8ZDlYGMx94tKT7QT5
 onQQ==
X-Gm-Message-State: AOJu0Yz+NF4xrHIvmqKjdPwFgcqDyLOCMBsXB9Ao8PbPSxlc1In3TJqz
 nAZGtzWSJTSIaq6c8pwx/hjzw13CdoJk9LKZZPitP7kx8y2qI56WD5as2WxS4UhahjnbEWFoKNc
 =
X-Google-Smtp-Source: AGHT+IH3n/yhl8cIEmzHIZC26516a4Q15PfSrSGjFtdWwBL7s2UCcrmPLMX70BD593+f0LjR2M1GeA==
X-Received: by 2002:a05:6e02:160b:b0:3a3:9f21:6c3 with SMTP id
 e9e14a558f8ab-3a3f40b59dbmr53356995ab.24.1729351368937; 
 Sat, 19 Oct 2024 08:22:48 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b83faasm1006111173.52.2024.10.19.08.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2024 08:22:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alexander Gendin <agendin@matrox.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v2 17/31] test: Drop the duplicate line in
 setup_bootmenu_image()
Date: Sat, 19 Oct 2024 09:21:57 -0600
Message-Id: <20241019152211.1014896-18-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241019152211.1014896-1-sjg@chromium.org>
References: <20241019152211.1014896-1-sjg@chromium.org>
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

The mkimage call is done twice. Remove the duplicate.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/tests/test_ut.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index 39aa1035e34..9166c8f6b6e 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -208,8 +208,6 @@ booti ${kernel_addr_r} ${ramdisk_addr_r} ${fdt_addr_r}
             cons, f'echo here {kernel} {symlink}')
         os.symlink(kernel, symlink)
 
-        u_boot_utils.run_and_log(
-            cons, f'mkimage -C none -A arm -T script -d {cmd_fname} {scr_fname}')
         complete = True
 
     except ValueError as exc:
-- 
2.34.1

