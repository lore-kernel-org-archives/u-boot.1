Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF4FCAC587
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 21:54:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8ECE833AD;
	Thu, 11 Sep 2025 23:54:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="psE+WMwn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06430833C0; Thu, 11 Sep 2025 23:54:15 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D633C83285
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 23:54:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-88432ccd787so82582839f.0
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 14:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757627651; x=1758232451; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=X8zn2dLSVGJt1pAwxQ4anH8DMtqtPKN455uNBael+Uc=;
 b=psE+WMwnTThrbmz4pox7oqup3uEoNR8IbMMayHlCpNK160+YiqSoopxm//2vZislcJ
 hbzVP2JMwe9Z772KM0FbZI+eZCbkLvSb1s7m0RCbk+mPqFopTnlrPfJVlhJhe3fiOH7y
 lUs0u7ltAc5/CMnP+20P902sGMyMvOSjTQxsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757627651; x=1758232451;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X8zn2dLSVGJt1pAwxQ4anH8DMtqtPKN455uNBael+Uc=;
 b=k2IIC3ANoFzHxH7Hx8GMWco/IYJojzx96/vHs9s+jVDE8rIptm+awZZbDB6OHeavLk
 4yim5vQ+MHDGDXhp88oIaGosnQhLmGd+0HgAICe6gpBl7SvqJFZmcjyfHp6lAKqJqWiB
 XpNVu56soYnC+bCUG3W6IrkFx522592keRSyki941h3xOgmqPZ9gv+aGamg2kMhOqJ0+
 vuHuaCJ+kD8C62FnSPCoPWUW1TWByhw8j0ar5lMfiqUTvbMd5+GeCP5+44xWET4f4mG+
 wrU9aqcDOKm0uObey93MnokHuKzwfTr7BDYnT2xETvkm4DT2xKWhZ9S5XhokltYian8h
 7mUg==
X-Gm-Message-State: AOJu0Yw+ueYUm/7DPlcGzuJ/7XKI1zicRSu6r2IpmnQm8rt+1Nkzyl1A
 Li+oU7MuY53BPGuEdUOgxCSk6F26d+yU5ZafWHwX1RHB7diY1sk7cok/nDrXFuY32WuF5Bt33mQ
 +4b9vebc=
X-Gm-Gg: ASbGncvciMJViWreNMx2y4tHaZNTqlJ9tIUzeVgj+h4KuNlVaItMi5X/OxnLkpP4cp7
 Wh4koUPOwzxZtsQEIkzEmJ1r1tcaaWtB3DbJ/P+6IN7ZtG9uz/MZ2S5kq9FLIpJSf6bndrSE6Ia
 Xot7N/LdMSibS4l/bUnMc3+s2tSRa6UABhrAE1pwHGK3qBtDG63AU/dupM8pZLX2FKPMHzX9CYR
 UgjRSuPUal8BVSxZ3XhouKboWT+tFUbh+wwDYb0sCEeJamewRq9Sz/vud2DPUZAlsyb4kYzoY1z
 tsTMJcqFb0uL5carbEhuYfGgu2S+u7mDtE+IHK3JPPMH7ija5tDKN8VyA7iIASNZrHdcVXWTAZk
 7GMXTQQYXvMw7yycWD2zRfS9IVeTA4Tl4DmRu0VBcwM8Zvo9fdy6T0WWOu7W/PiEAoAQ4PQ==
X-Google-Smtp-Source: AGHT+IFpog5aReaq98uXoC9crZTY0E4/0thKoKZFIMMTD4ByPV04J5xfL+9MWA1jiukZqTeoeINRxQ==
X-Received: by 2002:a05:6602:7506:b0:887:1d1f:c2cf with SMTP id
 ca18e2360f4ac-890322345d2mr157132639f.3.1757627651637; 
 Thu, 11 Sep 2025 14:54:11 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-88f2a7db2f1sm101517639f.0.2025.09.11.14.54.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 14:54:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>
Subject: [PATCH v2 0/8] USB preparation for "allyesconfig"
Date: Thu, 11 Sep 2025 15:50:17 -0600
Message-ID: <20250911215404.3955132-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

Hey all,

In order for "allyesconfig" to work we need to start out by either
declaring some drivers as invalid for the target (as they have
non-trivial problems to solve such as architecture headers being
required), remove drivers because no one is using them anymore, or do
the easy fixes required.

This series takes care of drivers/usb/ for allyesconfig by adding
dependencies in a number of places and removing some unused drivers.

Changes in v2:
- Pickup Marek's tag when applicable.
- Drop the musb portion as Peter Robinson had an existing series for it
- Reword the commit message on the two gadget driver removals.
- Add this cover letter.

-- 
Tom

