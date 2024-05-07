Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A74C10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 10:05:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DD7D8875E;
	Tue,  7 May 2024 12:04:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="bm2ZPJ3w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9371188742; Tue,  7 May 2024 12:04:43 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B67318873A
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 12:04:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a59a8f0d941so758704366b.2
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 03:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1715076279; x=1715681079; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BSGurHe28qrCxQerOrRZiFNpjgoWWWIO5x6tYS0bToA=;
 b=bm2ZPJ3wLk7raHuCNXmwNduMdr4PJh+byvst6BJQq9hErtsfj6R1Na+bFeNmV5ZI9O
 Vp6ID1iAnXdlJWTdMpDbnKyjP5sWfeMdH0RPRDr3YO2d49IbU9qVKLHm1eupILxsV6l+
 i8H3gJp4F4Mf9XvEvPuUPB2P2rMba0rYdXeNB2DoWWU8E9oNJwo98Dj1+sdm65PMRJr+
 QaXva/biiAqtj5SfAR5eH7IGL9HILkKHnOr/6t2UwkjGo85HCxdU0bD9nEjE0mcfqOdN
 Cn4iPaIfDS+DjRuzTjB5sj5rrmtK0ELL9AAzfKPnqI1+oflxbvj+kZvQJfi0d+BKfs/G
 /r1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715076279; x=1715681079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BSGurHe28qrCxQerOrRZiFNpjgoWWWIO5x6tYS0bToA=;
 b=SymgS8aRSaHGqowt77irgW1mAQxQR1B7h5vcLGS/thd/uuoyKbH9RCS3Xp6jvNbxfB
 zFTEqRh47b+ReOvYEwK0/YbXkDuKjbRdfFV/RYqLpSHpgGev0T4tZJ85WCIt211SEq/a
 zk1z54SA4Csc0DaFwgsGFC3YuhHLkesEhX3lrHI0U2SRIlVleoY6ZmhPqwG7JguPlDGL
 H1w974iL3VtmyEPRcjKC+nC11wve6bLlZhmlHPiGEHKcPGfDCHcYx0iTDhk5xInl0r7f
 Fv4irF6lSRqsWV4Ah8Z1sR/qiaPsX9W3ZxlrmDUmD6pcdnitlpEtlArzff6NwI+DpryW
 SHfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcOXS/DNVtSmkwHErhTHw0m7VQXr0Ecn5YBPpa+SdqorC3E3cm863zm2RVbLzuWK9oJQH4WyETQuWJQ7t6UjD/48fIoQ==
X-Gm-Message-State: AOJu0Yx3azZyVH99pixkWrxqQXIlZfLn96C7o6tu16vnI0RUCr+XToKv
 NJ+R2f5mUk1wgdrL7Z6im3WCWLRh3fUxlGg/hUiKE3PX1+TzkkzU7Rf1lG/s3tY=
X-Google-Smtp-Source: AGHT+IFZDJbqpQ7CCpD6UffKkw4o/GaiZJz6BVpL04juNUbP6lITkg3E4750XZGAq2wYuQKWAhaz8Q==
X-Received: by 2002:a17:907:9493:b0:a59:bacc:b082 with SMTP id
 dm19-20020a170907949300b00a59baccb082mr4680178ejc.60.1715076279287; 
 Tue, 07 May 2024 03:04:39 -0700 (PDT)
Received: from fedora.. (cpe-188-129-46-59.dynamic.amis.hr. [188.129.46.59])
 by smtp.googlemail.com with ESMTPSA id
 s20-20020a170906455400b00a59c4a16e4asm2878350ejq.120.2024.05.07.03.04.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 03:04:38 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: sjg@chromium.org, trini@konsulko.com, jagan@amarulasolutions.com,
 vigneshr@ti.com, marek.vasut+renesas@mailbox.org, u-boot@lists.denx.de
Cc: j.beck@linefinity.com,
	Robert Marko <robert.marko@sartura.hr>
Subject: [RFC PATCH 5/5] sysreset: call .on_reset for UCLASS_SPI_FLASH before
 reset request
Date: Tue,  7 May 2024 12:03:53 +0200
Message-ID: <20240507100431.206670-6-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240507100431.206670-1-robert.marko@sartura.hr>
References: <20240507100431.206670-1-robert.marko@sartura.hr>
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

Call .on_reset method for UCLASS_SPI_FLASH devices before requesting
reset.

This fixes the issue with 4-byte adressing mode being left enabled on
board reset.
That is an issue on Qualcomm IPQ4019 boards since the CPU expects flash
to be in 3-byte adressing mode and will just hang otherwise.

Note that this does not fix a case where you remove the power while U-Boot
is still running and in that case it will still be stuck in 4-byte mode.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/sysreset/sysreset-uclass.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
index 6151b5fe03..8321cc4230 100644
--- a/drivers/sysreset/sysreset-uclass.c
+++ b/drivers/sysreset/sysreset-uclass.c
@@ -30,6 +30,13 @@ int sysreset_request(struct udevice *dev, enum sysreset_t type)
 	if (!ops->request)
 		return -ENOSYS;
 
+	/*
+	 * Call the .on_reset op for SPI flash devices.
+	 * This is required for most devices in order to exit the
+	 * 4-byte adressing mode.
+	 */
+	uclass_id_on_reset(UCLASS_SPI_FLASH);
+
 	return ops->request(dev, type);
 }
 
-- 
2.45.0

