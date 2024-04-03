Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB90CD128A
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 15:44:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 423F888238;
	Wed,  3 Apr 2024 17:44:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZamfA1DL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FE4088359; Wed,  3 Apr 2024 17:44:05 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D207881AA
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 17:44:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-56c0d1bddc1so7802114a12.3
 for <u-boot@lists.denx.de>; Wed, 03 Apr 2024 08:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712159043; x=1712763843; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sDk2v1Fs89JO/27Mh6GzrbuSedkwTCoAobkt4ehItTo=;
 b=ZamfA1DLaac9hTEbwdLugb1qoNsFB4dWCc7IuxpBh3NT/w0uI4EkJige8j0IHtFyzn
 U5NXD/B4slORss2+IBNbaQBiYabuo5M5zLj0zALdx/BmJn8hjH1Fu8oiPKV4A2/vHEVU
 w7Kk+GbwuZ+tLQgVmfx9ALuUXHugsKaFpOgT36zPZDuFB8BY6HITCFvNIIO1jhb9a2L5
 YjI2gqgWY5BQvZlZ0r2of4FFzPh0hu7L+2p0gRw/cWqdz/lyVqNtZ6YqYmhgmoi/A7ju
 +8hRR7wb9+l+ULGk3QMkAHhwl6yV2QSLqNiVuwCMc6K9lwAaeuhFGdVX+bJs8vxeV0qS
 /Vmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712159043; x=1712763843;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sDk2v1Fs89JO/27Mh6GzrbuSedkwTCoAobkt4ehItTo=;
 b=WV8bBLN1/AxNBJCM1oYLfx6e8stj9yQEPcA43DW471a2PGhJ/HdJrYA1hu0CDGRu3q
 4SO3kXZ75nadEsLBw4z2qrXx3RJzRv4iRXoOpIzZVP3NWfRwja3ejv9DlzosvSZsS4jb
 N7/euzSCK6uQ9OVLtbRJ80A5wkFJa2Rz+IrjKw2dDIRgERV+BDp3jKfqjoQPt5TTFU1K
 9M00maVzcsuShsYWFRdTp359q8ffI0ddWbUV1dYvouHaS0mdziCus4d9tuHY/XxR5KLr
 ZDC0IGwKdm/zw/cZoug+vrl2ZKflxMMwbLk6C0+tqFFloSIGj0K5d3vFuTroGQl2y1k6
 EU9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjukn7t+lzjpEE2e4DO0AD1bxjAy6Qyt9IhE7GB1nn/VOhqA2tf+TJEEejATPbkZ7a1r5hNNlVJI6CG6apys13ZBaQcw==
X-Gm-Message-State: AOJu0YwLfv3HLubKURVmedTmul6Blhjpm9BFOWxfib09/sHpEpsMZWjY
 F0mQJxEcy8NAfHhDh6jkrchSrscYpj9jzkqTArBjlDwg9bjAiW8G6FeOawx3ZIk=
X-Google-Smtp-Source: AGHT+IFrQjyaFO8Gzl9703ach/gNOdb20SylW83p0bUBqVJUQuXN5JVPTEPlwO2eYuJ+5QCElrsuRg==
X-Received: by 2002:a17:906:f2d0:b0:a50:9190:b751 with SMTP id
 gz16-20020a170906f2d000b00a509190b751mr1246315ejb.10.1712159042452; 
 Wed, 03 Apr 2024 08:44:02 -0700 (PDT)
Received: from localhost.localdomain (ppp089210071137.access.hol.gr.
 [89.210.71.137]) by smtp.gmail.com with ESMTPSA id
 g4-20020a170906198400b00a46da83f7fdsm7935021ejd.145.2024.04.03.08.44.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Apr 2024 08:44:01 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: heinrich.schuchardt@canonical.com
Cc: Ilias Apalodimas <apalos@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: [PATCH] efi_loader: Don't delete variable from memory if adding a new
 one failed
Date: Wed,  3 Apr 2024 18:43:53 +0300
Message-ID: <20240403154353.440959-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.43.0
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

From: Ilias Apalodimas <apalos@gmail.com>

Our efi_var_mem_xxx() functions don't have a replace variant. Instead we
add a new variable and delete the old instance when trying to replace a
variable. Currently we delete the old version without checking the new
one got added

Signed-off-by: Ilias Apalodimas <apalos@gmail.com>
---
 lib/efi_loader/efi_variable.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
index 40f7a0fb10d5..b6e60626a260 100644
--- a/lib/efi_loader/efi_variable.c
+++ b/lib/efi_loader/efi_variable.c
@@ -342,11 +342,12 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
 		ret = efi_var_mem_ins(variable_name, vendor, attributes,
 				      data_size, data, 0, NULL, time);
 	}
-	efi_var_mem_del(var);

 	if (ret != EFI_SUCCESS)
 		return ret;

+	efi_var_mem_del(var);
+
 	if (var_type == EFI_AUTH_VAR_PK)
 		ret = efi_init_secure_state();
 	else
--
2.43.0

