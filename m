Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0FA8FEE4F7
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 20:22:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36FAD83F93;
	Sat, 28 Feb 2026 21:20:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VqOSmZFi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46E0F83F7D; Sat, 28 Feb 2026 21:20:50 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 079F783CDF
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 21:20:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7d4c85307b2so2242755a34.0
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 12:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772310046; x=1772914846; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dsIdhHsYcEFdWbwkwMuiSU4MtOPRCNoXJzyMRmZxXM0=;
 b=VqOSmZFiQ5UgQhQCuXc9SDkb3Bk6Obaj6B0rHkQmh2l/uCkLmvWFXuU+YaqRV14haQ
 svRjA4NttCNIMU+BYDYlId92Fx3fbDtVjTiJDs/PV2cHuFglpZfFJTVu9fpBpNgyx+9X
 531qoNWJ2KJwnxOewEgSdgfkNtw+/IX9Y1r/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772310046; x=1772914846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dsIdhHsYcEFdWbwkwMuiSU4MtOPRCNoXJzyMRmZxXM0=;
 b=lGNQJDZ4CM30+O3aLL6pLdkQiUJQYdS3TCSjzidsAUw8odLIbmEeXC2gLqbBX7K5MR
 m6ziUaOIzbVcu4XmHHKNEzIk7rtGwM4SnIbYRDSxDn8AD/Z2/3nWTqm0T7hzq9RAw1i4
 GTA7TuNMltgFmftid7Tk/4hv4GLi2KK/QyW/3uj/OAeuhZbgszJqttfkpdO8P/AZFJPF
 EpgYrq5Ki0FUT+nZQ9vM5qEQfg+IYisQq/tdIhDkAf8rkUxqAfLWRibfAv8DVophzYks
 GoH7un57duwZSjB8Z9MSaYiA9MtBMInEuHPnfnIP9q1Jfv2eUAa7nWWKZ+qUqKba1wvd
 DquQ==
X-Gm-Message-State: AOJu0YwOi1ceP3eyiEmhgd+eDUdz7yr0NuJC+ROxJD+hyJVeeCjvgZzM
 fR5TManKCQxq5lF2V29D7z/L8WcOxaNMZ5PbUuL7a9Mu138sBhFNMwzBoICK8UOksgXEPsb5yey
 4QJE=
X-Gm-Gg: ATEYQzz+nQFIKX+gAFKqrsMAgdjUHerp6w0oFH1pGa4TEJ8wQLZDLNbyJYgO/Vi1gbU
 cb2vt2nxL095CId/42vAT0r6XRtYeooCck1mgbDMO/LQVE7JuEXAkwcBZAtqvqFEFTICg5/w8q8
 igBC8+OvJcJwEwOQnvXmtyMUvHx3+tMdhQBBagPHApyo5/2fPFR1Oxu637L9G9LDiyrOSVRryw1
 DOjaOw8fUzQySjCaXz4yPnrX6XysJAvGm/CRlgJQ0YEoBZZK9Vex0aJ6je856QjEyxHz4t7/TBM
 wa0oV1ltIK4jr2L1N5Qs/Xoz1mp2lPJl8oKcPaeW4/O+5M86RZ6fB2WRzr8FXAefBcq4gmfzkMc
 K13qc8/g7MmUSiTp6261xj+NGbYgEJD6zVcxxrDiY75Yw6g7hUMw4/+Yo7uUZ0fb2GKcytLJYUj
 WLaiXsoPzp5YGyQtmO2Q==
X-Received: by 2002:a05:6830:2105:b0:7d5:17fb:6af6 with SMTP id
 46e09a7af769-7d591af2b73mr4243588a34.2.1772310045879; 
 Sat, 28 Feb 2026 12:20:45 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d58644edfbsm6978361a34.6.2026.02.28.12.20.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 12:20:44 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Alison Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Angelo Dureghello <angelo@sysam.it>, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v3 13/17] m68k: Call bootm_final()
Date: Sat, 28 Feb 2026 13:20:01 -0700
Message-ID: <20260228202011.1834493-14-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260228202011.1834493-1-sjg@chromium.org>
References: <20260228202011.1834493-1-sjg@chromium.org>
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

From: Simon Glass <simon.glass@canonical.com>

Add a call to bootm_final() before jumping to the kernel. This adds
the "Starting kernel" message, bootstage tracking,
board_quiesce_devices() and dm_remove_devices_active() which were not
previously called on m68k.

Signed-off-by: Simon Glass <simon.glass@canonical.com>

---

Changes in v3:
- Add new patch for m68k conversion

 arch/m68k/lib/bootm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/m68k/lib/bootm.c b/arch/m68k/lib/bootm.c
index 3dcff8076e3..7e36ac73169 100644
--- a/arch/m68k/lib/bootm.c
+++ b/arch/m68k/lib/bootm.c
@@ -65,6 +65,8 @@ int do_bootm_linux(int flag, struct bootm_info *bmi)
 
 	bootstage_mark(BOOTSTAGE_ID_RUN_OS);
 
+	bootm_final(0);
+
 	/*
 	 * Linux Kernel Parameters (passing board info data):
 	 *   sp+00: Ignore, side effect of using jsr to jump to kernel
-- 
2.43.0

