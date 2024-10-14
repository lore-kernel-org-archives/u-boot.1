Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C18D18157
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 22:35:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3693892C5;
	Tue, 15 Oct 2024 00:32:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Cy+7pfdA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EA5387042; Tue, 15 Oct 2024 00:32:41 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFCC9892C5
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 00:32:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-8354d853f91so182784239f.0
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 15:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728945154; x=1729549954; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J742mQZS5jPLv/vpb4OaUzyAC9isUaTB5rS8acqZO3g=;
 b=Cy+7pfdAn+99DSy8q2xc946X3YOgnN3LkxtPPT5pejhmjknYgb0uJzT3rHW+UPEgHp
 srObm/TE7jfcIAJIF9NAnrQP4LKYFJTaGobJr36I4TokJPWxv0MmmJ1hkC0pKbgNrW1t
 4/OJJ2tb5SzvTpDWIM+9i72ailpp8DfGMFRHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728945154; x=1729549954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J742mQZS5jPLv/vpb4OaUzyAC9isUaTB5rS8acqZO3g=;
 b=r5+zMbOVVgstQhLt9MKNvq75CdsJxBum+wkFGFe7ITvX1U4d7o7JyfKzX59N1p323e
 3aV9mLohASm78zp+1fwubLgYO5ZklF/eyz4gXFUekfj+WFArE+RLwp24IkuQIhf0U7hB
 s6JZHGqTGB2D40rONOOchZk4GyTLd3fIq555e37fGt3reAn9WfAxqGoLZJdCSDBXXTcU
 3R9zOxUvuBMjcuEhiHI9dUs+q/qHIT2qzyOQa741ONBVS0aaamQvXLaXPgF1tos2uY3f
 kZOujDyXyhMNtc651mfdJfjoDkeKQFMqIE0BWxIdEfiIBzueqVx51sbY38sZ+mQ4tIBK
 qQPA==
X-Gm-Message-State: AOJu0YypyKq4SkBPpbp0HlDNo/rZQ+BCsiVJ/2/xFk4I1B5pmWF11tOO
 BUN3F3CQ1XRXGazNZNsjYiKY9QwB4tTPrZZ3lp07UXerIgSAsr5WiEVHvU6Q8NMX9ljQnTi2Re7
 CAw==
X-Google-Smtp-Source: AGHT+IFV5YOdmt40NQhnw0bUfUCrYmbB6M5kK5WsqKN4csmKUkMcmxrOG9J7DL2iwKHBlKikXJfebA==
X-Received: by 2002:a92:c241:0:b0:3a0:926a:8d31 with SMTP id
 e9e14a558f8ab-3a3b5fa4d7emr104592905ab.16.1728945154620; 
 Mon, 14 Oct 2024 15:32:34 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dbecc4924dsm14847173.153.2024.10.14.15.32.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 15:32:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v3 20/20] x86: Enable RTC command by default
Date: Mon, 14 Oct 2024 16:32:12 -0600
Message-Id: <20241014223212.2212442-21-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014223212.2212442-1-sjg@chromium.org>
References: <20241014223212.2212442-1-sjg@chromium.org>
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

The real-time clock is needed for most X86 systems and it is useful to
be able to read from it. Enable the rtc command by default.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Rebase to -next

 cmd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 031a4f5e9bf..48461e70d67 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2266,6 +2266,7 @@ config CMD_DATE
 config CMD_RTC
 	bool "rtc"
 	depends on DM_RTC
+	default y if X86
 	help
 	  Enable the 'rtc' command for low-level access to RTC devices.
 
-- 
2.34.1

