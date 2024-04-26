Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E84EC4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 14:15:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DF0D88684;
	Fri, 26 Apr 2024 16:14:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="gG8iZ2Fm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F2C0885AF; Fri, 26 Apr 2024 16:13:59 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E1FE885AE
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 16:13:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 335AE3FE67
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 14:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1714140834;
 bh=ltUYpRNGnv4wfLBuoAuRbFJeDHL/GBUqFsfXIX6LmHc=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=gG8iZ2FmWxKtw0SsCzyFz/EcjiR8tzS5JMW1R4recSevu0ZkHzoiKF6Tg9w0T0APd
 2VsugvHxTj9tfzeVJTGhY0IiBSBOq3vvSXbdCKMBgmcys0E9MCm4bjxQ/Dz7zbq2NM
 mChHtI1ipB4CpygWravGhKD16CQgfiBKcXcCe5SZsXO4BxQWg0EqruU4d/l9zmVzmd
 q4InS0iWXREk3/SMeIZwI9sSi+2BrwhnY9nlQ0UKKsz77xZYLdVp1CxIUfKo7aRTRn
 3HpHlsue/HXnK1yiO1uffb9eV40i/B3KJe+K+7hAYvWx0nhwA/bQybm9q7xwX3Vl2+
 i0K/hOPi07HzA==
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2d87b880861so19458421fa.1
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 07:13:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714140832; x=1714745632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ltUYpRNGnv4wfLBuoAuRbFJeDHL/GBUqFsfXIX6LmHc=;
 b=XfAkV919+ee7ZCUa0DexN9MnPmpsQ4aFemL32v0E78ih1IfcYzHXp0U523HgWqwu8/
 WSccNi9CT3SW8VPMqqKK2tDQiN0iEHL0zg8mvjcdgPibyxFOFgN40xvvztbtHtNSXBJj
 SJkdF+hxWgjjXsq6bWOZrsvD3IO0KX2783dn85H3JaIyb4TOSZIsx1q7hzYH6NQDFBY/
 UHI+pePSzA7I5fMIf1xbJ6BCRIpRt4xAqgfoh+853mkkuFKtFHzjr4o5Jx6k39dJHWl5
 lFAIdkwRzj2DAhr7JwA1wSkCgvDS/B8dchIV3dcavqHlMtROSsY5fD1FhUAoUTGPH3Y1
 2q8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZOlmvwmmIwgdHbsLiQWaHGLYm4I/tNampdQZ4kcGgbI2qn1H0OyFjwMc5WtWBTpMDbNfodzLKgqeJkdixzu0sBbb0SQ==
X-Gm-Message-State: AOJu0Yw4kM3VuOdvpXmadfsMuxWPY2DjUftOTDHU9vS+sxikmxeC0wpD
 qbP5BemxxvtHRnJlYLgsmQEwOV8CH5NBBN7N6YsOi1rqpD6YlWRUNm4ag+7MMJTmSUOqNFv5nco
 xvnVg/ER2BXWb68bRVuZm6YHXlP/wqNkyN10Bo3KCRfM1gV+uqo1jUU5ZwuiMiE+QUKI=
X-Received: by 2002:a2e:9246:0:b0:2d8:729f:cf3a with SMTP id
 v6-20020a2e9246000000b002d8729fcf3amr1710671ljg.32.1714140832330; 
 Fri, 26 Apr 2024 07:13:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQ+wGccsQ3FfPWcERPpl/8UoHuaizd2YptDubtlj2PJp5aoXCdeelyDM88DAH0AK36YMhe7Q==
X-Received: by 2002:a2e:9246:0:b0:2d8:729f:cf3a with SMTP id
 v6-20020a2e9246000000b002d8729fcf3amr1710644ljg.32.1714140831913; 
 Fri, 26 Apr 2024 07:13:51 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 s20-20020adfa294000000b003455e5d2569sm1460593wra.0.2024.04.26.07.13.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Apr 2024 07:13:51 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Shantur Rathore <i@shantur.com>, Bin Meng <bmeng@tinylab.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Joao Marcos Costa <jmcosta944@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [RFC 06/14] efi_loader: superfluous efi_restore_gd after EFI_CALL
Date: Fri, 26 Apr 2024 16:13:13 +0200
Message-ID: <20240426141321.232236-7-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240426141321.232236-1-heinrich.schuchardt@canonical.com>
References: <20240426141321.232236-1-heinrich.schuchardt@canonical.com>
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

EFI_CALL() invokes __efi_entry_check() which executes set_gd(efi_gd).
There is no need to execute set_gd(efi_gd) again via efi_restore_gd().

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 cmd/bootefi.c               | 1 -
 cmd/efidebug.c              | 2 --
 lib/efi_loader/efi_helper.c | 2 --
 3 files changed, 5 deletions(-)

diff --git a/cmd/bootefi.c b/cmd/bootefi.c
index 578dbb19a7e..c1454ffb948 100644
--- a/cmd/bootefi.c
+++ b/cmd/bootefi.c
@@ -107,7 +107,6 @@ static int do_efi_selftest(void)
 
 	/* Execute the test */
 	ret = EFI_CALL(efi_selftest(&image_obj->header, &systab));
-	efi_restore_gd();
 	free(loaded_image_info->load_options);
 	efi_free_pool(test_device_path);
 	efi_free_pool(test_image_path);
diff --git a/cmd/efidebug.c b/cmd/efidebug.c
index 32c64711b6c..30def6b6831 100644
--- a/cmd/efidebug.c
+++ b/cmd/efidebug.c
@@ -1466,8 +1466,6 @@ static __maybe_unused int do_efi_test_bootmgr(struct cmd_tbl *cmdtp, int flag,
 	if (ret && exit_data)
 		efi_free_pool(exit_data);
 
-	efi_restore_gd();
-
 	free(load_options);
 	return CMD_RET_SUCCESS;
 }
diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
index c5d13c0f19c..73d0279e843 100644
--- a/lib/efi_loader/efi_helper.c
+++ b/lib/efi_loader/efi_helper.c
@@ -544,8 +544,6 @@ efi_status_t do_bootefi_exec(efi_handle_t handle, void *load_options)
 		}
 	}
 
-	efi_restore_gd();
-
 out:
 	free(load_options);
 
-- 
2.43.0

