Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536B1C0219D
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 02:05:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 412A180C6E;
	Sun,  9 Feb 2025 03:03:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="j34c5Qf7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D2E5807D7; Sun,  9 Feb 2025 03:02:42 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9B5080805
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 03:02:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-8551c57cb8aso4810239f.3
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 18:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739066557; x=1739671357; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VzbAbn6jezAfM2vkzs+3zRWqKNCeNhI3O86hiTSibVA=;
 b=j34c5Qf7wwv+RjN/Z3kmnNSgtEZyo6wmiEGLhzFHb8asLsXRHsB/XAZzDDpRhgk0ud
 1EZ+QuwmC9KcCOJbv6JsyCgv4Cwc07L6NuBFz+uSdMU0zfFynIQNjqdvXLBI32deveLv
 z8CSc1iX98zQGDm7X4Qh5GT8h2IlnlHckQHXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739066557; x=1739671357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VzbAbn6jezAfM2vkzs+3zRWqKNCeNhI3O86hiTSibVA=;
 b=ELSfs9c1Y+4UOKB/CgaIGJUZYqSkjPYWie4nO3Q9hf8ZTiqRcHghGYg/Fh655XilGu
 L+2yyoeQhPrIUmvg0kj6iCl9OgHYb/TQHz98CyzzYhDQFl6e6G6eanlXzfKJ2Xnf4Mmr
 pdGrAAdXB+Le8ebjH0k+a4TPO3G7j7ukWYK7BK9L2IT8S3VPF0HRReJrToMTDib8acBp
 eL7f3Qnssho8ORIagTegXxTyCn2w/c6NE9kgF11r7olFrTF/8X93SLm3HOuMSzFhNPMw
 qAAdAWjp+y++xMJzuGIbJ84vIYF3v6SP1uVw8mqFzXEvfIyLbKUzYbnakRSvuV0juwUF
 HAWg==
X-Gm-Message-State: AOJu0YwwjWyqe/P/MDcw8SG25e2OW17U8t6H2mis3BTiETyRwo7jfgRy
 72vfJdRgO0vyOzTtB/TWbdgNih3sIwHNkBX70u5GuOXp0NADHuJQ40/hI+OlGeSJZmNlyQddwic
 =
X-Gm-Gg: ASbGncs3fCGyREFkPA9QZMFgEn1yA2pne2/QYlUp8EF0TVYQojDntW7br3nQtO0pq9H
 Ldx8NlyKY/BGTuJGLfwNoAsjraZzs2Wr1WQ+4fapdUKlQVnG2/v2ms4NJdYbkjDqj0KMgtBlJIy
 ruvCK8h/UceTFOWjxJWD3Ltje+pSLJ+HJDH2nlDLK1t8RU6Qz50dExsw+vfqQ7ZVpaUgjyUr9Ar
 2qqfzOZxEX6JOcCO/57HOejh2xzI3zeIe0fPdaA2sYAgudmN0I8sNqG2R5KuSYOt3CRwNX+TCWV
 oUgkLRSetUxm/lojfODGU63XhFVFP8csJLzcDFfizMSM4nbNo6eB
X-Google-Smtp-Source: AGHT+IGtUk2qV/gKVdAKbc2D2IFuDXQf/O0aWM/EGje9wv0m0Skxme+/+XgE5ZsMSt9BvahKbQuLRw==
X-Received: by 2002:a05:6602:750c:b0:807:f0fb:1192 with SMTP id
 ca18e2360f4ac-854fd885527mr809615939f.1.1739066557336; 
 Sat, 08 Feb 2025 18:02:37 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4eccfad03d4sm1506705173.75.2025.02.08.18.02.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 18:02:35 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 20/29] efi: arm: x86: Allow use of the EFI table in the app
Date: Sat,  8 Feb 2025 19:01:19 -0700
Message-ID: <20250209020136.4108987-21-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209020136.4108987-1-sjg@chromium.org>
References: <20250209020136.4108987-1-sjg@chromium.org>
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

It isn't worth the hassle of omitting this field for the app, since code
is shared between the payload and the app. Adjust the condition to avoid
a build error in the 'efi' command with the app on 64-bit ARM.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Document the x86 field better and add a comment for ARM too
- Mention '64-bit ARM' here, rather than just 'ARM'

 arch/arm/include/asm/global_data.h | 4 ++--
 arch/x86/include/asm/global_data.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/global_data.h b/arch/arm/include/asm/global_data.h
index 8d51111f095..ba12da6204e 100644
--- a/arch/arm/include/asm/global_data.h
+++ b/arch/arm/include/asm/global_data.h
@@ -108,8 +108,8 @@ struct arch_global_data {
 #ifdef CONFIG_SMBIOS
 	ulong smbios_start;		/* Start address of SMBIOS table */
 #endif
-#ifdef CONFIG_EFI_STUB
-	ulong table;
+#ifdef CONFIG_EFI
+	ulong table;	/* holds the table address from previous EFI firmware */
 #endif
 };
 
diff --git a/arch/x86/include/asm/global_data.h b/arch/x86/include/asm/global_data.h
index 1bd1fa92078..0d9fa823121 100644
--- a/arch/x86/include/asm/global_data.h
+++ b/arch/x86/include/asm/global_data.h
@@ -110,7 +110,7 @@ struct arch_global_data {
 	int has_mtrr;
 	/* MRC training data */
 	struct mrc_output mrc[MRC_TYPE_COUNT];
-	ulong table;			/* Table pointer from previous loader */
+	ulong table;	/* coreboot/EFI table address from previous loader */
 	int turbo_state;		/* Current turbo state */
 	struct irq_routing_table *pirq_routing_table;
 	int dw_i2c_num_cards;		/* Used by designware i2c driver */
-- 
2.43.0

