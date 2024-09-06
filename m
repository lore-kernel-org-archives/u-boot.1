Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511D8CE7AB9
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 07:23:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EBA688D59;
	Fri,  6 Sep 2024 09:22:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="hcRgayil";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC1A988D45; Fri,  6 Sep 2024 09:22:45 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 268D988CFD
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 09:22:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a8b155b5e9eso16014166b.1
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 00:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1725607361; x=1726212161; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8gbXhu2qYPJTNkxev4E3P09i34w3ZySHrDQHvq7bev4=;
 b=hcRgayilqNRNcBpuEcnIYUD0fkQCjIh1D9zj+bX0YieLZya2MBPJuXIlB1XaV5tTBE
 8zseLKP+q1IokRhRvS1Y1dnt9Uh5eaE5DxOxnTZZo8M/VQAOb6awI7TccxwihsmIqtni
 v007NNiMDVgySZbNlLRf0X0iIH3OQkDHGfxL2P1L5hUFcDK1kmAHJYwj2Rw/S782HHLa
 syul7N35lA0suaDVA60ZFHS8tVC2WyoD6JDFV1v2UfHP+h/dfyNik8CDul2CfYqrcN2X
 Imhof1R7mxETSnKxFIU5f6wQTrr6Nj11SFAv+bQHXsgNFwsWTXBlcttaXA3MVJrvCPP4
 W3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725607361; x=1726212161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8gbXhu2qYPJTNkxev4E3P09i34w3ZySHrDQHvq7bev4=;
 b=Zb1pP5iH5j0aQQ97rmbOqdILfOaR0yZA6IdwyORsAPv6D8hagth9LHLFyWq4LtMtYB
 OMZdIqtcLd/QYnaUbDLKwCANZtLGAOxirslDlnL4JaSch9KyXx7evGKvhK1m/7XDG/KM
 GmZMFzEqWi6dy0IjGbLSGY7LVL2u4OlhAM2IKjVB454y7vyPDZJR8yFvwgiiw2R0vvox
 aLRb9+Xltu1py7ehDGnTKuwXb8iYVCfFwBTFiiT103G+pDcY36LgMyR6zTgzq7lfT5f6
 k4CCc3SNqX1vNl5niEk7bbBoQeVmzxYaakbUSGGlNzw80p33ANEPkX9ykvGDKpcUYNr8
 RmfQ==
X-Gm-Message-State: AOJu0YzTnr+pP1gyS0wHgjfDuxepIng5tdEMf9FrLuH0D1kUZaPGRN0t
 57QMNtUaRIsxnHWnufPeaYDQMBbu7LEm8f0e4be8fSROs419rzgrbaqYlan7cqs0fdXLNTEoTnP
 c
X-Google-Smtp-Source: AGHT+IGrXr1PAnZR9pOmV+9iL1nD01omcLMKF9Af0+yFJFZbVRfwpU1f2Lx406W51qUdy1Kg6C+tdA==
X-Received: by 2002:a17:907:36c2:b0:a7a:97ca:3059 with SMTP id
 a640c23a62f3a-a8a88667f98mr134859466b.34.1725607361651; 
 Fri, 06 Sep 2024 00:22:41 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8a7f7f541csm107748466b.193.2024.09.06.00.22.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 00:22:41 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, bmeng.cn@gmail.com, trini@konsulko.com, sr@denx.de,
 pbrobinson@gmail.com, mbrugger@suse.com, maximilian.brune@9elements.com,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH v2 06/28] acpi: Add define for GTDT
Date: Fri,  6 Sep 2024 09:22:08 +0200
Message-ID: <20240906072231.2531491-7-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240906072231.2531491-1-patrick.rudolph@9elements.com>
References: <20240906072231.2531491-1-patrick.rudolph@9elements.com>
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

Add the interrupt flag used in ACPI GTDT table as define.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Cc: Simon Glass <sjg@chromium.org>
---
 include/acpi/acpi_table.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
index 8a25c76cf3..ac2dd0d6ad 100644
--- a/include/acpi/acpi_table.h
+++ b/include/acpi/acpi_table.h
@@ -707,6 +707,8 @@ struct acpi_gtdt {
 	u32 virt_el2_flags;
 } __packed;
 
+#define GTDT_FLAG_INT_ACTIVE_LOW	BIT(1)
+
 /**
  * struct acpi_bgrt -  Boot Graphics Resource Table (BGRT)
  *
-- 
2.45.2

