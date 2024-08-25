Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C96CCC5320E
	for <u-boot@archiver.kernel.org>; Sun, 25 Aug 2024 12:26:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A018388A08;
	Sun, 25 Aug 2024 14:26:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="LJ8pX4pw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 815B98852A; Sun, 25 Aug 2024 14:26:32 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 939E88895B
 for <u-boot@lists.denx.de>; Sun, 25 Aug 2024 14:26:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2f3f0bdbcd9so38767551fa.1
 for <u-boot@lists.denx.de>; Sun, 25 Aug 2024 05:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1724588790; x=1725193590;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zfgQFY50ArhCt4JCqg9HePmw2ZEGsA30/N1SL6afrKo=;
 b=LJ8pX4pwvcEOX4EI6KmGl65R7nEHcJYrI0OwGDXO/gyERFv4AgPSCK+bUIm9RpWRV8
 +7FpUF4vbmCG8ojYLE2+rQlxIZvsoCxW2+O/swcFyQF4P9qLgBbJvbvyjPUH+tBM7aV+
 2iWWTOkvqTzSpUPnYNVg0XpPj+XMwhI6hUTNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724588790; x=1725193590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zfgQFY50ArhCt4JCqg9HePmw2ZEGsA30/N1SL6afrKo=;
 b=CyVZw7HBxt++ZDf4id/VoV0MFfT/XVBeXYW+cGTjxkouuU+HuIO+vzpVpjjRgbmTnN
 b5uXyJDYh9IhvwmY55T8kN5pFLv5zixny9gmEvsV9FoAmWlXCFlDo/Y6zY2XKkjVDLet
 QdPDdrAYmPnLLSVrKzOZIqf79BCEHpuOv/l71sNLr0oHte32BdJHsoRWiswcDFMznLLn
 /z6O1LAAE4vraYmq25vPxXq/EvVPChTo8luhDLthcBiNCXgFd6OI1YYiKfnE/axn0VyQ
 cv2MruFR80Fcn95d1lW6nCNpIle3Lds8K80xHq5u7GX4gOVaKWLWlSCcrMiK7r6lUWF0
 TKNg==
X-Gm-Message-State: AOJu0Yw4/wNpyfnv+7ixsCN5UzFS0eBnjwyeAFBH6VyMTCP1zw2yR67t
 Vw8rY71bDxDBbQj54BOLdKOEV2mEhIgiR9KjOmJGqcwNkpEzHvhN1HhNN9CB2+9HSkkj0G1TSKF
 aJv8=
X-Google-Smtp-Source: AGHT+IHAZK5Nb9+BCp/u4mJnjy4fWy/zFiOtyfBIq2hZW0NTuPF9m9JD4bS3xlpEz93GIgM3Ifoyhg==
X-Received: by 2002:a2e:6101:0:b0:2ef:1f51:c4f2 with SMTP id
 38308e7fff4ca-2f4f48f9354mr45710611fa.14.1724588789495; 
 Sun, 25 Aug 2024 05:26:29 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-79-25-99-149.retail.telecomitalia.it. [79.25.99.149])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c04a4c4377sm4651563a12.74.2024.08.25.05.26.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Aug 2024 05:26:29 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] cmd: booti: adjust the print format
Date: Sun, 25 Aug 2024 14:26:08 +0200
Message-ID: <20240825122617.3708982-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240825122617.3708982-1-dario.binacchi@amarulasolutions.com>
References: <20240825122617.3708982-1-dario.binacchi@amarulasolutions.com>
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

All three addresses printed are in hexadecimal format, but only the
first two have the "0x" prefix. The patch aligns the format of the
"end" address with the other two by adding the "0x" prefix.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 cmd/booti.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/booti.c b/cmd/booti.c
index 62b19e834366..ea811244a0a9 100644
--- a/cmd/booti.c
+++ b/cmd/booti.c
@@ -78,7 +78,7 @@ static int booti_start(struct bootm_info *bmi)
 
 	/* Handle BOOTM_STATE_LOADOS */
 	if (relocated_addr != ld) {
-		printf("Moving Image from 0x%lx to 0x%lx, end=%lx\n", ld,
+		printf("Moving Image from 0x%lx to 0x%lx, end=0x%lx\n", ld,
 		       relocated_addr, relocated_addr + image_size);
 		memmove((void *)relocated_addr, (void *)ld, image_size);
 	}
-- 
2.43.0

