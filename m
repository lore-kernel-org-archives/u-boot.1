Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2163CD128A
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 12:19:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6592987527;
	Wed, 10 Apr 2024 14:19:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cQmzwgeS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79A7D87572; Wed, 10 Apr 2024 14:19:53 +0200 (CEST)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FE6387527
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 14:19:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1e0bfc42783so57205635ad.0
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 05:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712751590; x=1713356390; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZaToIlSrXcI+U19WvECF9JFjtkVWqfSgxBo2L+x9NEs=;
 b=cQmzwgeSpT5z11w7Va45/nCUJ544jGyHl9f2qhII50dqFTjqhp42xhMI+vpDGbIjMw
 6B7nMFSFed5HkZam1ul2RQtfo0AqOBUtDSemPItnuOj5CKLF0iyhEujnxw7yJ2l7RIjC
 EKfuUHp0WK2QJ1/AzOX8U3yJUorn27YZOsJLSjXM2dqMeFq2cPJ3Mxd0pSI4jp/jIV7/
 V9Xi7YaXsHSLEvAW8+MRmbkN38QGDT0Hh206Nj262r/QWgVrY4qXhTjy8IicRFQTCBRh
 WkAhbA85eI8JvajzkJ9Dy+JGgjnB/MRNbDTUmINJBCVYMvMnY5/z+d0kcOr5zUC+g6Zg
 /ZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712751590; x=1713356390;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZaToIlSrXcI+U19WvECF9JFjtkVWqfSgxBo2L+x9NEs=;
 b=SEXeUcvC7KZaIrxDX7ya3ztyAgBDz2lwjLaUQfnHdTuz83OOGyI+QfSpHbbaU/DZuo
 8SJoagD8kmZObYco04iOuarAlJUZNnaPEkd2HQR0TKTKqZ+bweBXi4LW5QI0oKMZn5MY
 QQUut1XhvlApSFSDdm2oiUKcsPzY3K759U/i8Iz6RSV6QfqJCa/GDztqnhHwmLG5vMdD
 t3z9m7k+ALiAxzCfwnENOtGO7HgKTPYvUeZafiP1phvQg/nw2DXpcG0RddLjWowgp4Vm
 Ekz5QebH/xxOoGW5nRRthHPGMcNfg3pWxK5G+ppioLq7SLQaLWxHVBYXG5ndtu1ki0TK
 iP7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWu4K4I9guluXxx4sl8hioxccIilYiu+IwZGVo1AiRk3gqOFcadaj5YLmIWu/QTBoi7SaCtHH7tJgJtAkCI6Y0CvLaZBQ==
X-Gm-Message-State: AOJu0Yzwc//SazPGDWe8wzpqR09JrKWmSkoWpQitXOskmN/54dhGmnQ0
 DSLp3IN48Ogxt89jL51m0oiZqqZY0c8lxLyVpOn5xwBD+BQniQgu
X-Google-Smtp-Source: AGHT+IGMYSTMVrkmGiXPyvkubI8hudgGyUkAT9VbI1ZeiCDTErik/oenB3GEdKatuETC2naM0BuqdA==
X-Received: by 2002:a17:902:ec88:b0:1e3:c419:35c2 with SMTP id
 x8-20020a170902ec8800b001e3c41935c2mr2855033plg.34.1712751589377; 
 Wed, 10 Apr 2024 05:19:49 -0700 (PDT)
Received: from ownia.localdomain ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 c8-20020a170903234800b001e4565a2596sm4940000plh.92.2024.04.10.05.19.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Apr 2024 05:19:49 -0700 (PDT)
From: Weizhao Ouyang <o451686892@gmail.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Weizhao Ouyang <o451686892@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de
Subject: [PATCH] efi_loader: using EFI_UNSUPPORTED for private authenticated
 variables
Date: Wed, 10 Apr 2024 12:19:33 +0000
Message-Id: <20240410121933.152265-1-o451686892@gmail.com>
X-Mailer: git-send-email 2.40.1
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

Improve error message for UEFI SCT tests.

Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
---
 lib/efi_loader/efi_variable.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
index 2951dc78c7..e6c1219a11 100644
--- a/lib/efi_loader/efi_variable.c
+++ b/lib/efi_loader/efi_variable.c
@@ -163,6 +163,7 @@ static efi_status_t efi_variable_authenticate(const u16 *variable,
 		break;
 	default:
 		/* TODO: support private authenticated variables */
+		ret = EFI_UNSUPPORTED;
 		goto err;
 	}
 
-- 
2.40.1

