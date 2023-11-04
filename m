Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5816C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 20:38:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6B50871A1;
	Sat,  4 Nov 2023 21:38:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NC93Ya0M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C151C87083; Sat,  4 Nov 2023 21:38:08 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D2D486F65
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 21:37:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-66cfc96f475so19731426d6.3
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 13:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699130277; x=1699735077; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RRbwhPzKqs+wgHGjH3YtUMbtwBdJmErU+sUpNWJ+7Hk=;
 b=NC93Ya0M3rFYJkM66ygHn1xLW2TD9ZXDxG1jNUXyR3FsziRrnm38HH5Zy0hUaUwZAx
 FH3hphqORwl3CN6eqDfOdjEJ7R4C4JZQd7edkk3a/Wr71HKALbvwJA/PznXwr7P7xXI8
 Js6XBuUAA/+0C0tly2nUbvUXDAqCWQVeUOx3Gh/m0BNIE2A6N4VHZXCydrZ2Q4sQrCwX
 HklvvZ3NAj8z185B0z0xErdPWm3vxLRQbxBbajpLwqliFf56NyIv0L8OOte3j59LfEcy
 KTROWHjsz47RanrC1SvGphtShzXH0IWSF/B9thk1yUNj8YbE/BqYbXZ4TugZjTu5G8X8
 NdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699130277; x=1699735077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RRbwhPzKqs+wgHGjH3YtUMbtwBdJmErU+sUpNWJ+7Hk=;
 b=U8kDR99ssRjCKYWK1MlBb8Lk6cUkgkwwFCkPI2SKcAVm8qROc7Uras7/xLWFvtq2TW
 MQiaYVS6gaL9yuwc8/EFEz+ti12p/OVeNmIFdQa/BYKOIKBluQZF3H8ZNxyP7hW0SgvP
 VdN07B5QtFpl8GVzAEzTtkpNnUh1nnGffimm2r2fhIQrjaNDc7DKaCFJWuqOuAnsMOn+
 UGMguVlWsDQVkiU6awTW4tJnQxBOn4+d9QQn4jzhHKUhljsQO+f/VULN3pFsZvidCv7v
 O12Kkh7MCKAUIeAUtUuJin6Pdvhc+7hAVAopSj+YvDD9hPJOSgkeaPGwnspmWX+paN0/
 YoxA==
X-Gm-Message-State: AOJu0YxeLsX5OslIFYsOoEyT1OLGC8+eHTC9zyX7pyz73GDkXj7QY1nX
 ZBcyv7gZ32IaOhhwyioG3Y05furVxAPRNA==
X-Google-Smtp-Source: AGHT+IFA9+T8tYuPJmXun9o/Xvs0bLHpcgOBM3xDtk7uwzsqnlmb5nRxRE6VsuAuzmAz9URTFEHrYQ==
X-Received: by 2002:a05:6214:3009:b0:66d:65ae:18f6 with SMTP id
 ke9-20020a056214300900b0066d65ae18f6mr28645335qvb.50.1699130277260; 
 Sat, 04 Nov 2023 13:37:57 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 d9-20020a0cf0c9000000b0066d1348bdddsm1934057qvl.44.2023.11.04.13.37.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Nov 2023 13:37:56 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>,
 Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2 01/15] spl: nand: Fix NULL-pointer dereference
Date: Sat,  4 Nov 2023 16:37:39 -0400
Message-Id: <20231104203753.1579217-2-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231104203753.1579217-1-seanga2@gmail.com>
References: <20231104203753.1579217-1-seanga2@gmail.com>
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

spl_nand_fit_read unconditionally accesses load->priv. Ensure it is set.

Fixes: 00e180cc513 ("spl: nand: support loading i.MX container format file")
Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

Changes in v2:
- Don't set load->priv for spl_nand_legacy_read since it doesn't use it.

 common/spl/spl_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/spl/spl_nand.c b/common/spl/spl_nand.c
index 07916bedbb9..5b6932bf7e0 100644
--- a/common/spl/spl_nand.c
+++ b/common/spl/spl_nand.c
@@ -105,7 +105,7 @@ static int spl_nand_load_element(struct spl_image_info *spl_image,
 		struct spl_load_info load;
 
 		load.dev = NULL;
-		load.priv = NULL;
+		load.priv = &offset;
 		load.filename = NULL;
 		load.bl_len = bl_len;
 		load.read = spl_nand_fit_read;
-- 
2.37.1

