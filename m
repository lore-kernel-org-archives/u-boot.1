Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7719D690E0
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 07:11:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D7B489510;
	Thu, 28 Nov 2024 08:11:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rY3KoTLI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7823C89608; Thu, 28 Nov 2024 08:11:28 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 573CB893D6
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 08:11:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5cfe5da1251so593842a12.1
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 23:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732777886; x=1733382686; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TTNUsCRROLxZN/RF3nyODhqQB69D+GDX1WXoLBu24XM=;
 b=rY3KoTLItTrvryQZ8UqCsRhj5dHKsN1xJdcCW/y1N4DXbRn4QC5+nLjL9GzFSPV2HP
 E8dkaXxEV2xU3F8o+NvFMECEHvgO9SGYJKhMba/2WTZ+mmwl0JlnraJPzYpl4kBqnaXo
 XzSyZcUQCJg5d2YxEwh0Tlu7KJOh0Hvyu/Oiv3O5O83XDEoBqYyhLrB+gTo/Ox5TafGj
 BHU554XfPvVZQEp8VF8y6ytpYyjXuz5xLGZ8CXxpRvs4EHAvn6vXMMculVwjCPupKJge
 QhFVXVMWIWT8IccECffHFRNibXbYJgswDQyqdjg4EkXD1VEEU5C86eras8i9WnrfcAlh
 S9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732777886; x=1733382686;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TTNUsCRROLxZN/RF3nyODhqQB69D+GDX1WXoLBu24XM=;
 b=cjM/UoqLSwVd49DTjXCd5MedkwGQuh7WAvn2IWONB80+U/6eN8quNru4r8htkM27rz
 yBeCjrOjtiPcPk6ctC2VVUIknE1scvQBQ1Eh9KgOdJLrvYWwHFXdWLLjDX/4bR62dpf/
 n8UWd1xgcsCzrR+M1hcksJhCT0+v/xDpbkV0wGssW1WIHMhYyPV3oppza/nr3B0sqhq5
 V+9doyJuSw1KfgE6YpMl7srlWQurFJ4ZmMFcKkETFR5dKJ4Q+Qy3SSXBodHfGi/fLTOy
 aye/8zsjoOkge5BkuaiygUp22XDmEAnW5INcDHSoyVcPsiwH4PwSzabkO3Ya2diFnpXg
 GKog==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQIhHZXot5mz7htEhyLVdx1ap7DZXub33xwpy+dH8Rob6OTZR2t4KdoTeEjGrdHqAV03Ktx/M=@lists.denx.de
X-Gm-Message-State: AOJu0YzGtuoenPcMX2UYeV1chp7f8phLfCD6LYjiFffb1XMx05R4bH+k
 Qe0TBBSPK/y7PfGY+pquQZvf4ZvH03AN93AqS8xXA6yWoEw4AxhJsGt6je9hZns=
X-Gm-Gg: ASbGnctio+pqGZZSOY+ecsncAYrDlSK/mD+ZCmULNtP1zOiOPagyUvn0cA4QYgQQ53p
 EkMeCJODGfYhnThPkvIQh4+/dcxIHi0DkqC3wsaode/3da6Dg1EKGhi6sIFoTy3LD9+GOIP5KEJ
 5mMS2wNoxEF237q2nQfc8zh5fsm1a5kblNCoHQ9Mrn1pq+L3Cbr/lptf4fRxb/QAnqa4PUjGxPq
 d4wLmpjqecpi7pRrrizRv5Cc4lch7jefMmT+rYhSm/vysPPhGA7BFbQR0HMAwwM/i3rHrD6OB+p
 PmalJCA4nWV1+rdtSSvQx6Ao6A==
X-Google-Smtp-Source: AGHT+IGBd17HbTrNm7ZC9bTJ1NiN7fwVfOLWExobmfaDw6EefqNg1LiS1TiGcZ7A2h4LNYTLGOcGtw==
X-Received: by 2002:a05:6402:4015:b0:5d0:9062:7dfe with SMTP id
 4fb4d7f45d1cf-5d0906282a5mr3806548a12.15.1732777885734; 
 Wed, 27 Nov 2024 23:11:25 -0800 (PST)
Received: from localhost.localdomain (ppp089210064034.access.hol.gr.
 [89.210.64.34]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa5999059b4sm32800866b.145.2024.11.27.23.11.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2024 23:11:25 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Tim Harvey <tharvey@gateworks.com>, Raymond Mao <raymond.mao@linaro.org>,
 u-boot@lists.denx.de
Subject: [PATCH] efi_loader: Don't warn if the TCG2 FinalEvents table is not
 installed
Date: Thu, 28 Nov 2024 09:11:20 +0200
Message-ID: <20241128071121.272072-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
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

When the TCG2 protocol installation fails, we are trying to remove
all the objects we created in tcg2_uninit().

However, there are cases when this function runs before the config
table was installed. So instead of printing an error unconditionally
check against EFI_NOT_FOUND and don't print anything if the table wasn't
installed to begin with.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/efi_tcg2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
index 572c6b5bf630..a15c73162ee3 100644
--- a/lib/efi_loader/efi_tcg2.c
+++ b/lib/efi_loader/efi_tcg2.c
@@ -791,7 +791,7 @@ static void tcg2_uninit(void)
 	efi_status_t ret;
 
 	ret = efi_install_configuration_table(&efi_guid_final_events, NULL);
-	if (ret != EFI_SUCCESS)
+	if (ret != EFI_SUCCESS && ret != EFI_NOT_FOUND)
 		log_err("Failed to delete final events config table\n");
 
 	efi_free_pool(event_log.buffer);
-- 
2.45.2

