Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A24DEC47422
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 04:40:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62F4D8790F;
	Wed, 17 Jan 2024 05:40:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BXdxWAKN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ED508792C; Wed, 17 Jan 2024 05:40:10 +0100 (CET)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 022CF8790F
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 05:40:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-58962bf3f89so1487155a12.0
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 20:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705466403; x=1706071203; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3MpDZAKW0GtvfJUZzRZqB7/dnvoYqSper+30bo2fhw0=;
 b=BXdxWAKN7M9UZh1EtqqSKPd1S86veQsiNq3Jv3jb0HHx2v96DCtZSXbRr2eOsYYEyU
 k+rqr0BWk0c1BxXHgqbJSrJl+so5bSWrlLeR3dErrs0KUQPlUew59fy9ovCk94h24n+A
 XgvjJGyLzjKxtGFO5s+5yyCsCvA2/nN8+pJ6pfrpXXhxuDxg/SwZPZ1vzztD3F0N8//g
 h5yfDEyLN+VLKTb4uDqK5ayKHCk2E8otBCHh0nFL7QdBwYOMI/2jPyaMV0Oxh6JIzxfJ
 lKjzaLuie/t4NldSvwItVqKS/xUKEu6SOwGvzHpk+8SKADAGOhz6Gho4BxA1V5wvr9hQ
 3VHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705466403; x=1706071203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3MpDZAKW0GtvfJUZzRZqB7/dnvoYqSper+30bo2fhw0=;
 b=hlpOJWnmt8z16NV3kDs+rzUEf+nVdmP7m4DPab3BE2E/w7Qs3WCK2O8rkNeUtjbx/0
 Ap+kQ8V0Jm6yMbT74FSkSmE1pdr1uz+w3CnPn1wY93lzb5nGwYKN3krLzssNe63mp1DB
 3vg7O3zNZ5WKuycj1izw+bJvAbVF3p345bGrq7W7XIl7JnED0x33b9K7LV/oO32L42xO
 OB65qUIxkHzMmsC5th+S05yaiKFCz33uUakZ3TZExwkjhGqehfBh0e+6aRlitM57HYoa
 1gd9AjsxmRmNhTTDTf6ckYY/8YG1qs4w/WS3wPrm/zP4nbC6Rzznaut+swE3mulgVcjN
 +KKA==
X-Gm-Message-State: AOJu0YxL0FcMMsWt9M/ZoWHDbw6+frKOFEIZGoYsVv2j8zcSAxjDUN+2
 L4wUrsrJuoVES9FK9JLXTKQFZiiiR+3T6Q==
X-Google-Smtp-Source: AGHT+IGPbKzKmDZclrbutJia3s0offa5wN85kgTjrnfnmHFdTmKVaQbs5O1ncdvATzsEsvtgYSCkFw==
X-Received: by 2002:a17:902:eb13:b0:1d5:efd6:20f with SMTP id
 l19-20020a170902eb1300b001d5efd6020fmr2958488plb.1.1705466402895; 
 Tue, 16 Jan 2024 20:40:02 -0800 (PST)
Received: from octopus.. ([2400:4050:c3e1:100:e481:26af:1a49:433a])
 by smtp.gmail.com with ESMTPSA id
 s17-20020a170902ea1100b001d403969bf4sm10048668plg.309.2024.01.16.20.40.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 20:40:02 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org
Cc: u-boot@lists.denx.de, AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v5 3/4] net: tftp: remove explicit efi configuration dependency
Date: Wed, 17 Jan 2024 13:39:43 +0900
Message-Id: <20240117043944.477358-4-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240117043944.477358-1-takahiro.akashi@linaro.org>
References: <20240117043944.477358-1-takahiro.akashi@linaro.org>
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

Now it is clear that the feature actually depends on efi interfaces,
not "bootefi" command. efi_set_bootdev() will automatically be nullified
if necessary efi component is disabled.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Reviewed-by: Ramon Fried <rfried.dev@gmail.com>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
 net/tftp.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/tftp.c b/net/tftp.c
index 88e71e67de35..2e335413492b 100644
--- a/net/tftp.c
+++ b/net/tftp.c
@@ -302,12 +302,10 @@ static void tftp_complete(void)
 			time_start * 1000, "/s");
 	}
 	puts("\ndone\n");
-	if (IS_ENABLED(CONFIG_CMD_BOOTEFI)) {
-		if (!tftp_put_active)
-			efi_set_bootdev("Net", "", tftp_filename,
-					map_sysmem(tftp_load_addr, 0),
-					net_boot_file_size);
-	}
+	if (!tftp_put_active)
+		efi_set_bootdev("Net", "", tftp_filename,
+				map_sysmem(tftp_load_addr, 0),
+				net_boot_file_size);
 	net_set_state(NETLOOP_SUCCESS);
 }
 
-- 
2.34.1

