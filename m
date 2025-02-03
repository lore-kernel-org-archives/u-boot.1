Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D08CC02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 17:44:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A251800D7;
	Mon,  3 Feb 2025 18:43:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PZf3q/8o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FB28800B3; Mon,  3 Feb 2025 18:43:44 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8453C80762
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 18:43:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3f1c94936c5so2346505b6e.1
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 09:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738604621; x=1739209421; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VouONybJj0XlsGCY8A1U3E/M8k5w+v/cT5GfE15d/YM=;
 b=PZf3q/8o1ryx5+6/ZiV5S3Xoku5BFflZS0bpbqvYTKqqGJix2H8qvmGBCbCWHw3cKR
 3svq+C/THbb4mXUoR4DB0MGfixMjNatj2UjVDzQGKlQgONanFc3v72Rze5pzpnkpE+Kd
 WHhzXx7IgA86Y8eJhJfqO3kTxmWfJ8hWv22wo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738604621; x=1739209421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VouONybJj0XlsGCY8A1U3E/M8k5w+v/cT5GfE15d/YM=;
 b=oc7rpqdk2IPAZEPChARG86plq9ss0XbYYKNMQIxRvZvwA2+m3Ts/TYSjEUPjzq1sWe
 3TIPI4WSMDDaCacOCJjK8Y7LVB+OnjrasJMN5JZzOQZXLeqTEg/2B+jHCfaFYMHDMjX8
 FJp/m+76QndLhOHjCfyo3URbfxk9YbimBMeVTqEOt68wEPleLzNgTwFH7qHlJnENdI6d
 ZbBtCcWwnxFWFtVGKAC077TL1JimTI2N9/21Fd28qSjn+YN0H8o0i63Ve+614Z7p5h/X
 q7XAX3ZgT7qkH2ODXMdzt0EANDlkJdATIwL7G+SReSB96CfYBk/zLnFnQE4pYc2JYy+8
 KvDw==
X-Gm-Message-State: AOJu0Yxoyffq9FhR5ZKZgXkrMMsd6ZI8VVwCnTRqpB33QoganQLQfv8v
 mpAmZgSciH8D6+/ou1M/WOdd5C/RISt0IzX+HzDX4gKsEl/n9uxrFr6ydsw55ZTHCOtY0vwdnos
 =
X-Gm-Gg: ASbGncsQT+e0CR2KaiFTABpgfDz/dkqPP1BgXSvJ2DiRU4zKJUX29JBzIwn0JVPK0vP
 YfFPUDqLPc7wekvCS2RW1H616uoCf9kwGag9XLb70eX11qhvMN1b1+Okpk7BjY3CKWZ0Qtkcm1M
 mfrUUCswCqcEM7QXsABaaDwm0/plIDxxORPyB1OG8NLsFnl6vuLzXCOnS+GGtzQ7FWf0WHnmT14
 bdOsUKOlwSU8HZIT2XtG6WDlpOLLGCBuC03zPYiO9by9ttZsgbtIlqFlnIvWMb9tuUG8c+JfVI9
 B1A2GZHYl2uHD40wccCXdOvOvS4bgZQk13BIKFao1ITWegJtmbuO
X-Google-Smtp-Source: AGHT+IH1Z8kMcoQhaQ56L/3gSB9yqnjoKHr8M4uqPfAoX7xwsLlZ3rev9YLgRVwjSZK3heIL5I3ZFw==
X-Received: by 2002:a05:6808:1b0d:b0:3ec:bfb5:b565 with SMTP id
 5614622812f47-3f36dd45a51mr155549b6e.11.1738604620743; 
 Mon, 03 Feb 2025 09:43:40 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f333558c89sm2564203b6e.24.2025.02.03.09.43.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 09:43:39 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 12/32] efi: x86: Allow setting the global_data pointer with EFI
Date: Mon,  3 Feb 2025 10:42:05 -0700
Message-ID: <20250203174245.1331464-13-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203174245.1331464-1-sjg@chromium.org>
References: <20250203174245.1331464-1-sjg@chromium.org>
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

Provide a function which sets this pointer, for use in the EFI app.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/include/asm/global_data.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/global_data.h b/arch/x86/include/asm/global_data.h
index 06bd80ccc13..1bd1fa92078 100644
--- a/arch/x86/include/asm/global_data.h
+++ b/arch/x86/include/asm/global_data.h
@@ -142,6 +142,13 @@ struct arch_global_data {
 /* TODO(sjg@chromium.org): Consider using a fixed register for gd on x86_64 */
 #define gd global_data_ptr
 
+static inline void set_gd(volatile gd_t *gd_ptr)
+{
+	extern struct global_data *global_data_ptr;
+
+	global_data_ptr = (void *)gd_ptr;
+}
+
 #define DECLARE_GLOBAL_DATA_PTR   extern struct global_data *global_data_ptr
 # else
 static inline notrace gd_t *get_fs_gd_ptr(void)
-- 
2.43.0

