Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B41BC02182
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:55:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84B26807DF;
	Mon, 20 Jan 2025 22:54:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="diI8lBvG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B91E58032B; Mon, 20 Jan 2025 22:54:06 +0100 (CET)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E9BB8032B
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:54:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3ce7c4115e8so20449145ab.1
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737410042; x=1738014842; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e9m2j7TeNvV7D/P4Y/T4wpwugqvAYndIn5HYlg7qz7I=;
 b=diI8lBvGj9BARMOg/YroMvtij9tJpILIoFtjU3TDtMODuktJZckPsSsEg0iIy1uvvp
 LbZGSTzL11Sio2GQpIQS8lHBYkIhNNNGnzLV1o9zSi6DOGMJHKpVgtGZt10EiCQw4qi8
 QPnhlgeAblOsSNO3tCghdzrDKOqPwyVmZ4z5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737410042; x=1738014842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e9m2j7TeNvV7D/P4Y/T4wpwugqvAYndIn5HYlg7qz7I=;
 b=m7wTL5h9uACxNdP/iYgj9ULd9Wm0I5O/x3kokx6DxgxDL3x8uJUwXlhi/OiFld951p
 IRbqC0SJB7bJBPun4mpwoeE6loYXE1oWS/hc5fCA+fexG9H2MhzkqcYGiWFxddV7mgyA
 Zv2olYNBvmBcc3W0fQzEPpRpCH7crn81lAl16IzxOwIvYFSRsODgoBt7CVoTfwy2/MaX
 zrs/xHsfLTxlLE8hJckqHAkxiMnuHZoW0RZRSZbxBefSl1tkLWw2oBHfAC2n3ROMLIBZ
 LeguzchDRrX2IITqRdSa8P3s9gaSXedDvvF2VliDtC0qDrHF/SV8oVVHjJ6gDZLo463r
 j2pg==
X-Gm-Message-State: AOJu0YxzEqzW4RlPu2xfJ4bRMiMZ/DxAOT9XgRpks4/uLbJKo7L2mP1V
 u1G6qsnWnNlGT+X7GFB+zT4xCFvPmkvG9hw1Ryi4OeYShMFuEtetb4+Bm5NABfGdNT4tZX24QxM
 =
X-Gm-Gg: ASbGncvG0HEHB2fLFmXPvPdX0H3zCfPlUuT4T8fjIPXmlbszRUolwEaTQh84WGQqKky
 7drKXYG20aXcoEiHH2dqrlcUu5IRWIkDlXinx0upftQo0R8IzItqBJUGE/vGRIzmEp6P31rNo87
 wF8Arzt6vK14dWgnH2zzd/x/ZZ2MXiAzo0yyQFIpFV+hI6kHSajzUJhGj0BXgsIomJHjIRuv9sG
 q4VhDd3f0SjBrxuawtG2VTMnz90KUTjqc1dNmrxLc7HZ3p+0KuQmqy9d/hFyZiEvAfXql6GP71h
 ten2y6xvQ69yXQuuolS+VRl2dpyfoeQ=
X-Google-Smtp-Source: AGHT+IFmjsrDA+8V3k/4/tAQVxygSpUpikxmk/KqUcxtKbIVewT1GMweel4m5JNM3pt0ZVMZeqjZpg==
X-Received: by 2002:a92:de50:0:b0:3a9:cde3:2ecc with SMTP id
 e9e14a558f8ab-3ce84a1ab85mr154635345ab.6.1737410042382; 
 Mon, 20 Jan 2025 13:54:02 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea7568067csm2809650173.129.2025.01.20.13.54.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:54:00 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bryan Brattlof <bb@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 08/28] test: Move env-test rule into test/
Date: Mon, 20 Jan 2025 14:53:08 -0700
Message-ID: <20250120215340.617194-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250120215340.617194-1-sjg@chromium.org>
References: <20250120215340.617194-1-sjg@chromium.org>
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

The Makefile rules for tests should be within test/Makefile so move the
'env' rule over.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 Makefile      | 1 -
 test/Makefile | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 1e29796602b..c86e289718b 100644
--- a/Makefile
+++ b/Makefile
@@ -893,7 +893,6 @@ ifdef CONFIG_POST
 libs-y += post/
 endif
 libs-$(CONFIG_$(PHASE_)UNIT_TEST) += test/
-libs-$(CONFIG_UT_ENV) += test/env/
 libs-$(CONFIG_UT_OPTEE) += test/optee/
 libs-$(CONFIG_UT_FDT_OVERLAY) += test/fdt_overlay/
 
diff --git a/test/Makefile b/test/Makefile
index 47a07d653a9..17716ef384a 100644
--- a/test/Makefile
+++ b/test/Makefile
@@ -19,6 +19,7 @@ obj-y += ut.o
 ifeq ($(CONFIG_XPL_BUILD),)
 obj-y += boot/
 obj-$(CONFIG_UNIT_TEST) += common/
+obj-$(CONFIG_UT_ENV) += env/
 obj-y += log/
 else
 obj-$(CONFIG_SPL_UT_LOAD) += image/
-- 
2.43.0

