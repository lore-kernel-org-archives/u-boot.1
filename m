Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E23C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:45:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43AEA81E5A;
	Wed, 19 Mar 2025 15:45:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OJ0rmu3k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35E6B81FBC; Wed, 19 Mar 2025 15:45:03 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E575581DCC
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:45:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-225e3002dffso80859425ad.1
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742395499; x=1743000299; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TFJ1MQOgIM7kLsbQbExOmMu7IFs5QG0fyoX/i0CSwho=;
 b=OJ0rmu3kj7bgrir4UKCHZqGIRiwRumfPk96TEg1QPUfMRWRfwqVP+bI+mkJU0QCzjH
 EFotoCCsFlY7ouyMTpalIBbP/+orXlllqeAVYN9RPK5R7rqsavz74H+KvVF9YvvqG4se
 gXpcTJAtQ3NwCGsRowGvU/xKQyuXZI4cNI5CQwdNNY3T9hNP7HIldLx0AGcWG56DPEC1
 84YtUm/irgJheqvX36O4hVoTxBJgL+SEkFlgmcidJ13tWR8aXjdelDcnVHtxPNFbid3Y
 8nWDGSl6oZyoLRNLUMeoStLW6pjdUgOly/K/fCaMZ+gURsQRi+cAWVeC6Kf45b4QnNBv
 vB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742395499; x=1743000299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TFJ1MQOgIM7kLsbQbExOmMu7IFs5QG0fyoX/i0CSwho=;
 b=cCzfXZ7UDDI4IUiQH8oHq6F6kbSmn1CxYb3SBOVg2BJzNa7i5OM3Z0iC0dJHDNbJQb
 HA0caGxZ+6bh4jOs9OrzflOzRlg6xdPiJdAhSX78QIYscAwAAkMnHTQwOdLgnY7PjPKO
 5FxP+vt7VxpF+IxINW1BR4GgLTWCB/scesIZZ7oQpVGipcYSiQXpCy+PHAqudK4SiHZ3
 krvF/wCfCwlZJzfJntwFmWNx16aZaCnShgAD69dHxtQGQapINvPXW1BGY6S7tRoTOFQ8
 pl9EuFep3iYB/4U3HeM7DcBGmWwVuRWsuqHqwe4aj5yQ19oHMDv9l0Utnx+BILvAphvu
 M+yg==
X-Gm-Message-State: AOJu0YyDiWSolocnsuImXAGdajsFRq0JMRpHgwlZuqcV6ompi3U8Lc5D
 oygnENlrmhOjO6FIl/hYfnAjmVH/yBNIgAekx388Uihbc9CqukXmtuLaqNa8yIEq3A==
X-Gm-Gg: ASbGncv6AUCt3GkoPyTDMzrQ6Ffiueq7AN4xB84rOOU2LE5BV1kQ97RJeMG9qNr4kN1
 n1zuzR4byz2GsHhkoYxDJnYMEmEaIfYlcSR8DuGKBtRSqJEPbGbAe0iSE65VeJxM1qVNZV1OMQn
 OzB+7c2sY9V/xb09jAGuB0plpBsGU/qUmiRVIk0aCkGfLjRF1v/XfYOp7O5JXuOtw9BjTiosse/
 D+sM/GMCuopb76wKlgSMCmkyxRINs4yf7brF5lktC4w6OHDRcs04y8wQxMbE6zRJF9bnxTdGIWa
 hBl46qlmbNuo6WjIMdxM9zP/lK/ZIMu+gOSZ4vl5LxHufgdk6hZoRWc=
X-Google-Smtp-Source: AGHT+IG288YqiIeM+033OIKhhAGkOnjfba1+YLhcT9QVLmFW2OzOKMH7Wt8Y7V4AAJFFIO4lr+VdQg==
X-Received: by 2002:a17:902:da85:b0:224:1c1:4aba with SMTP id
 d9443c01a7336-22649a67ed8mr40670655ad.50.1742395499445; 
 Wed, 19 Mar 2025 07:44:59 -0700 (PDT)
Received: from adriano.. ([186.175.132.62]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6ba734esm114812915ad.141.2025.03.19.07.44.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:44:59 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH v2 3/3] bootm: add support for initrd in do_bootm_efi
Date: Wed, 19 Mar 2025 11:45:01 -0300
Message-ID: <20250319144501.32277-4-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319144501.32277-1-adriano.cordova@canonical.com>
References: <20250319144501.32277-1-adriano.cordova@canonical.com>
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

Pass a pointer to a memory mapped initrd and its size to
efi_binary_run. The EFI stack will register an EFI_LOAD_FILE2_PROTOCOL
for the next boot stage to access this initrd.

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---

(no changes since v1)

 boot/bootm_os.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/boot/bootm_os.c b/boot/bootm_os.c
index f403f352be1..35a32f8c912 100644
--- a/boot/bootm_os.c
+++ b/boot/bootm_os.c
@@ -508,7 +508,8 @@ static int do_bootm_efi(int flag, struct bootm_info *bmi)
 	ret = efi_binary_run(image_buf, images->os.image_len,
 			     images->ft_len
 			     ? images->ft_addr : EFI_FDT_USE_INTERNAL,
-				 NULL, 0);
+				 (void *)images->initrd_start,
+				 (size_t)(images->initrd_end - images->initrd_start));
 
 	return ret;
 }
-- 
2.48.1

