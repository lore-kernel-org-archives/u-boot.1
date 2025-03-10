Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B2F5C282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 09:02:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E3338164D;
	Mon, 10 Mar 2025 10:01:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="bynihoYH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C48B80017; Mon, 10 Mar 2025 10:01:49 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17BDD81417
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 10:01:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-abf3d64849dso474045666b.3
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 02:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1741597306; x=1742202106; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lptYdQWjxqaw9JeiF23UzRatCTLwtupvJCE94PjKlhc=;
 b=bynihoYHMdRz9ledEWM7WN9rBVx751+7fnUULoIRYauKeDxkkkHRFmNRM7FdWsK63i
 gEdQANevm77zdz6KbNbSrMpJWIlwkF60aL7VZ/WbXJxAUEpI1R5ONMj49W8U0HQwv2sj
 pUFdLd322QMNAeCoa4UCTxpIEbV2jdTy5ggQ+g4Azya6arjHYnrl2rfJAdyDtwkPeOUk
 /oRJYXDZuLn5kwOOeLkOkKuMHayfJOWZfLaJCWneRM0EHZzNSn/K+oLOwl9/NNTa/6DE
 NZP+6mWuNZtXJct27wFyo9R+gzvwrxZE+mpQs/OaXDBl65LakXO9/2wBkR+86l68Au3R
 W5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741597306; x=1742202106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lptYdQWjxqaw9JeiF23UzRatCTLwtupvJCE94PjKlhc=;
 b=ZXXIipuqVFj7yrNYqpRx0b1OnIdcP8kAwNY9RjjVDApaZXuFywZyj8s8+SJMiw1LbZ
 vcKn0B66/CWJULLA6XUlJU5JGYiU1mqoFlFTNtFfN4g2WSRpC3QIbW60wcLMRtxaZbvS
 XZ2Ts4ACib51faJ+X6gUPv65hid064cG4uB0MEo1KmnvaiFwWbkqLzoRhvK0B3QIXo4B
 VvfCCYVno0uS9I16NmSvh3PpCuVwRcyoW0rvf1zpvk5OzOu1GiYXscBGG68kEXhdMtIt
 gpPL8Q7CE5doXvMNqHUkpGs/+xQy9L73jUB2tX7oD1rivD+mGYUCsKNMPNUC1qvN9+va
 k4sQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYUvW/XjobSiWPeD21PpsuvAvH/1KDZlq9eg+xHe8+NVE6pd6rBjQyB27ovazmrqsH9yfULso=@lists.denx.de
X-Gm-Message-State: AOJu0YyUEBe8/Naen1+2HdjjmZJ3Oja3PHJComq1vnpwC32Pd16TzMtc
 e1o0zSV2jbrZXHhVWW7f7KWpfRCZS5Kt1IVHMXgkc6efUsTDkFXCGZ9ytUYkr7vKkBsRTxImcxU
 Gj24=
X-Gm-Gg: ASbGncvVKRa9Jy/pSxSqieM++i2wvL5TZlzDVsLGYDBSo6R/Bw5kHM5e3SYK7w4Dft6
 oALP+H03WFr9V17Q/HyWfPp4axYnWKX4ECqDaIohp6I3dx4/BfOtfG1UzaEGmoCUiaEUlUfhuw4
 a1uSPwgI6wv5D+37VHhPPGtfH3piAiJfmO3E885u5hhcfxMZJWfWtiLj8ON/kJPvIRRW0+oF3KI
 4N/0odBPS4FY6rdfG+5aB8ir023W4xI1NdArNBEXSR3qOnIc9PiCDvKk222YMOWLSIoE986pcVU
 QQcN+wJtH9Hsf3mXIEjbR8aj1BhD9/L5ObLFx7GitZYNph6/Y3FDR5RsGkzLyKdewlJGX4rJNWH
 jdAQj6wEnebuleNfiD6C8q9huYbmvWnlMTB2g/aIcS70=
X-Google-Smtp-Source: AGHT+IEMYEvyfKWVSvaaKbc4GwKDHFAZ1fLKwQnC148C+e7EdcgYreEHNEgYDyUQEkYwxXdvwpo5tw==
X-Received: by 2002:a05:6402:5201:b0:5df:6a:54ea with SMTP id
 4fb4d7f45d1cf-5e5e22b92e8mr32831323a12.11.1741597306527; 
 Mon, 10 Mar 2025 02:01:46 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e5c74a7184sm6578082a12.34.2025.03.10.02.01.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 02:01:45 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: Tom Rini <trini@konsulko.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	u-boot@lists.denx.de
Subject: [RESEND PATCH 3/3] emulation: qemu-sbsa: Enable PCI enumeration
Date: Mon, 10 Mar 2025 10:01:34 +0100
Message-ID: <20250310090137.1645083-3-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310090137.1645083-1-patrick.rudolph@9elements.com>
References: <20250310090137.1645083-1-patrick.rudolph@9elements.com>
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

Enable PCI enumeration by default to get the Bochs display driver up
and running before the boot medium is scanned.
This is just to enhance the user-experience while booting the machine.

TEST: U-Boot logo, version, log output and the U-Boot shell is visible
      on the display device.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 board/emulation/qemu-sbsa/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/emulation/qemu-sbsa/Kconfig b/board/emulation/qemu-sbsa/Kconfig
index f4ad63e681c..728cecae6b3 100644
--- a/board/emulation/qemu-sbsa/Kconfig
+++ b/board/emulation/qemu-sbsa/Kconfig
@@ -49,6 +49,7 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	imply CFI_FLASH
 	imply SYS_MTDPARTS_RUNTIME
 	imply SET_DFU_ALT_INFO
+	imply PCI_INIT_R
 
 if DEBUG_UART
 
-- 
2.48.1

