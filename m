Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A35C282DE
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:13:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9043281DE5;
	Thu,  6 Mar 2025 17:06:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZWL8X1Ci";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E42F81DDF; Thu,  6 Mar 2025 17:06:18 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2087D805D7
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:06:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-85add67e9c1so31804639f.0
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 08:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277174; x=1741881974; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pcg90l1jRbB5AHpHadrVl+7bPISm830OmrkRvdO1JBo=;
 b=ZWL8X1Cibii/gtismEvB51au9uYiHB7qFEIlF7QO3LJCGfqOuiVPfE1ZhSQNwh/neq
 MF/hDNubIJTPsbX1C40h4jPlDBF7JfIkczjVTFTNYEHbx9IIMnckKPvbGphRR9mfCpSG
 Nyp7A7Wf3A8+gQ6zvoLXB02sQfRzxw7vQNv6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277174; x=1741881974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pcg90l1jRbB5AHpHadrVl+7bPISm830OmrkRvdO1JBo=;
 b=k1lccTxwXKk4wBF7IwOn4DqgJaL6ApqTqFTUAziDLJbUecCOKwe7E1ky060dLwQsMA
 jhkH7tztCU+SkNXEqQbM0JQXVIoRDo51SRJYqMjuLH3iAk3QT2KcRJ1o2cxwA39Ffe0X
 tYI/nblFRTL9dH+sZuYor8tIkfLJ0DYz+SF2779iy/dgyEcvQBmkcEhvpk8Tftcy0HW6
 bwvNgNboBw2uUU5xVlQAo/KAXJeKVPyiJrtr3TaDa3K+k/1ajEP8XflNZxElXQC5soiR
 J3wE7vjzS9C0gS+cMbl3NlwJfeCfsp6wf/cB7sf9nng/K/a0wFwBDOjIbUiXEjO3ecT5
 VBgQ==
X-Gm-Message-State: AOJu0YwIJf1i7GfAz/0EmSHEL81W0XWkcM5WY5pn2ZCOxpDvLBfjxQBx
 GFuzS9vDgswxFXPkhMo0Du5250yPBYYdtWMcbGHQ8vCTs4n/rMUEna9jNDijwzYic6XDsiKLURQ
 =
X-Gm-Gg: ASbGnct+7rw29OtEG7rHszSPnGqU1Oh3NBynJJ3EXdVneGUjUjz0nkomfuN5Gjb57H3
 zdIKeDYjFPC+b0njxK4MJtvR+6DFLHS3CCX1ExI0GNXGLFs5LCpNjRnkKGu1AYwAwJOEaAvtphM
 f2+3y5ZQptFQyouWtg9OxJISGq+axXYXUxa3ltyTxqoRSZx9a7Wtbphwz8WFYxTpCOxp833J712
 S0c5O29325Fsz9CaHM2c4g4ymOtxiAz5ZplNV+SNlHYHip6DebCYyFsQ5QPWO/3fLP7/g/92lEg
 CBAIfglUHGBkEjPTF7ytRllr1j5IrKsHgLPMo4h3ZMiAZU/Yb22FiYTprqDrpunAr+Qmvnh7vcQ
 GhSIMxg==
X-Google-Smtp-Source: AGHT+IEP/i0Zf8PSbxeH5QcicLuKmXaNkjDZQ2ENiyTK7vWR1ey5cked9wrqDmUfMYzsDjeqy6t0fQ==
X-Received: by 2002:a6b:d009:0:b0:85a:ec52:aa72 with SMTP id
 ca18e2360f4ac-85b0eaedd30mr375211739f.3.1741277174225; 
 Thu, 06 Mar 2025 08:06:14 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f213b959c1sm46759173.38.2025.03.06.08.06.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:06:12 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 40/47] boot: Support IO UARTs for earlycon and console
Date: Thu,  6 Mar 2025 09:04:07 -0700
Message-ID: <20250306160428.3041057-41-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306160428.3041057-1-sjg@chromium.org>
References: <20250306160428.3041057-1-sjg@chromium.org>
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

Update the string to take account of UARTs which are connected on I/O
ports, as on x86.

Fix a typo in an error message in the same command, while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Add new patch to support IO UARTs for earlycon and console

 boot/bootflow.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/boot/bootflow.c b/boot/bootflow.c
index 58a1afa7a75..4054a966af8 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -942,8 +942,9 @@ int bootflow_cmdline_auto(struct bootflow *bflow, const char *arg)
 	*buf = '\0';
 	if (!strcmp("earlycon", arg) && info.type == SERIAL_CHIP_16550_COMPATIBLE) {
 		snprintf(buf, sizeof(buf),
-			 "uart8250,mmio32,%#lx,%dn8", info.addr,
-			 info.baudrate);
+			 "uart8250,%s,%#lx,%dn8",
+			 info.addr_space == SERIAL_ADDRESS_SPACE_IO ? "io" :
+			 "mmio", info.addr, info.baudrate);
 	} else if (!strcmp("earlycon", arg) && info.type == SERIAL_CHIP_PL01X) {
 		snprintf(buf, sizeof(buf),
 			 "pl011,mmio32,%#lx,%dn8", info.addr,
@@ -954,7 +955,7 @@ int bootflow_cmdline_auto(struct bootflow *bflow, const char *arg)
 	}
 
 	if (!*buf) {
-		printf("Unknown param '%s\n", arg);
+		printf("Unknown param '%s'\n", arg);
 		return -ENOENT;
 	}
 
-- 
2.43.0

