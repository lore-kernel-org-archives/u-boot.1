Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E771CC4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 14:14:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9AD0885FA;
	Fri, 26 Apr 2024 16:13:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="T8FFlUr0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A87D88693; Fri, 26 Apr 2024 16:13:57 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BCDB885D7
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 16:13:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B68633FE65
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 14:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1714140833;
 bh=UQwxMiyxtvMWstvMDeSEN4/MV5/euifFUh/aIMyoaJw=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=T8FFlUr0OLcoiduag09Bs8ptyi5gKC9xLkkXBP8T+OoPLFLeDobk1TjMzUV4vE0gA
 c8TOmhdG8f4gNtXhr7PpIbRjyZ7jPF4rcEr0DIioJ55Ew6i0TKCRZ1/YYKlbQo4UMk
 zhN5nU7kgEaqyxj5Y9bLGG+yZOd2ytZxTCGNYtOzS3Gbawo7Jx/NZy+wpczIHGXiA4
 f4A0wnQ8SazBQsICDj3zIADEAmTWL5brYrUtKUWdVEtGdIIouSRuBx4vCXwbxrs7oH
 mnsmOb33FfUpo9S6yuNKrCXW7sai3npDry8QU+jP4+8uS4GXcn0/m+vfvVjVXVMiQT
 GT8MPwrEOjmtQ==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-34c65b59e18so320947f8f.3
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 07:13:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714140833; x=1714745633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UQwxMiyxtvMWstvMDeSEN4/MV5/euifFUh/aIMyoaJw=;
 b=YB1tvTyEy71WWIxcgHfTOC85kSVr+U6B4vsjMnbDyffgVLnrCBqxeoD3hCoXGGFTIW
 XQ0lAB9d5W6ZZZGH0hNIRRlPWqhxBEGAkebz8aUQ9prl6EpuVzi1KSNbmmdt1aT6lFQj
 h+3mdSKHG4J267mOcLNX4R9+M1vNx0rE1GPmEM7AwX2UvaYCTp6JODN3nrE1w5mIG2W8
 LsS9IOSwH86GV8YeXvm1IM677otTxGwtM/5sLCFee7JRJJ80BahK7XSoMHokBcfSDegf
 BxepSDoELoqC1k00becTqXZri64DBx/1hUUI0YOXTjrojUMrwMZuMyCvsgMEJNTup2/4
 64Rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeVLNIQGy8HQTYR1qMO1Umb/coObOrkKIDUR3lre/pGC9ekgBrfTJsvTuFuyJTd97Ow9BZbMD/EdGfwgW63CzcoLGouw==
X-Gm-Message-State: AOJu0Yx0i8q9lg1aXcN1tghWLmFw4rHJuooppUY/HH8725SIFU04sxRW
 nlETa3Kplpw/8gtym2M6R3UdrfI17SeEL8ijbKtnKGqiAOrm5DeIPjIqTxc6VFsBb2Jx8yu51cy
 pCC60gW2wNO/RQHpgoACX7EaB8rGf5hdi4Y4KNQcLJ0V8xXFRJIaAtPjkN+pdptpxGjI=
X-Received: by 2002:a05:6000:178e:b0:343:a183:4218 with SMTP id
 e14-20020a056000178e00b00343a1834218mr3328209wrg.52.1714140833203; 
 Fri, 26 Apr 2024 07:13:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFx8Z86VeJ9mHpHjmGdqjrMPsZU9kZvbLDO6YOc6wuXnHMxXbXLOP2+whB1PMsFoHM13A2Khw==
X-Received: by 2002:a05:6000:178e:b0:343:a183:4218 with SMTP id
 e14-20020a056000178e00b00343a1834218mr3328191wrg.52.1714140832849; 
 Fri, 26 Apr 2024 07:13:52 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 s20-20020adfa294000000b003455e5d2569sm1460593wra.0.2024.04.26.07.13.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Apr 2024 07:13:52 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Shantur Rathore <i@shantur.com>, Bin Meng <bmeng@tinylab.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Joao Marcos Costa <jmcosta944@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [RFC 07/14] cmd: terminate efidebug test bootmgr early on error
Date: Fri, 26 Apr 2024 16:13:14 +0200
Message-ID: <20240426141321.232236-8-heinrich.schuchardt@canonical.com>
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

If efi_bootmgr_load() fails, there is no point in trying to start an image
that has not been loaded.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 cmd/efidebug.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/cmd/efidebug.c b/cmd/efidebug.c
index 30def6b6831..9a1b38c352b 100644
--- a/cmd/efidebug.c
+++ b/cmd/efidebug.c
@@ -1459,6 +1459,8 @@ static __maybe_unused int do_efi_test_bootmgr(struct cmd_tbl *cmdtp, int flag,
 
 	ret = efi_bootmgr_load(&image, &load_options);
 	printf("efi_bootmgr_load() returned: %ld\n", ret & ~EFI_ERROR_MASK);
+	if (ret != EFI_SUCCESS)
+		return CMD_RET_SUCCESS;
 
 	/* We call efi_start_image() even if error for test purpose. */
 	ret = EFI_CALL(efi_start_image(image, &exit_data_size, &exit_data));
-- 
2.43.0

