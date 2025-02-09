Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0A1C0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 21:15:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A354A80AE6;
	Sun,  9 Feb 2025 22:15:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Bag31cZM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D820280AE6; Sun,  9 Feb 2025 22:15:34 +0100 (CET)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7B2A803B5
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 22:15:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3d150512bd5so4354865ab.3
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 13:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739135730; x=1739740530; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tQFP2M+hSI0/F4RqhZR9nvNeaybgPUUpM5wZ+Fusg6U=;
 b=Bag31cZM0+A2ykVtp2PgF00wrpdo53pRz8IEvethkbUk+nJzRRgewrDt3kNO/5vP56
 yXF8IHg3qpUhlkKzxKZk20y1zEJi2CdLo1zzpNVnZyiSo8ll/frphbjVKfHSzMpwJlAf
 ihpgaWnrMdsvdjzJyDoFMQU5/Lbf8QEJiM0VM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739135730; x=1739740530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tQFP2M+hSI0/F4RqhZR9nvNeaybgPUUpM5wZ+Fusg6U=;
 b=Gz3OyBt5HSBAtfzQWM588LCTXwLCHOFCPdKyPJUZzM+dQWLwBs/BqvrH2li2HGNLwv
 NLjLjNpWlbM6LfxMFoErbVe2njWipgE0PYSTW661d8qdr3h6r7ysWcUPCEWuE8hK5Lwa
 gOK9s2MWfvgk0kSRGzZvFpeNpQKPIKhE6FmkzsErXwljPHTNK/c457rAsrp+if6xh5Fh
 Zdrjb8y5yF9u3FqkvS64fK6VaAuMxBJmYnX4bw1bDKUkx+Ylz1nUzufcaG4X0vVvC8tf
 b/08GYNqdz/gXsIvSVV21+jX3RXnBtX2CBdlBOsP0bqMK+iAP3GBOqi5h0Rid4a7W9CV
 kj4Q==
X-Gm-Message-State: AOJu0YxxZHT3bfbbs3RR4N2rLuFiNqp/hSxpWF3g78ApE3txJ7/TlAMq
 XApryGPncYxEk0efP+d+q0L+nOy3Fylc3BtNOw4iD1NPLP1AmLD1yMJkT92QMHSYZoN0NrR7wjA
 =
X-Gm-Gg: ASbGncsyytbL5bPXmwDUOz3pjh6fWuKrCuYFmDS+qhOzUVyGKZU57Tyv0nLN1MN7bC1
 3TNl1FJTUInXygrD6ESrvzkGxjyQWcqajiWwggGVKXg+1iZDZ4Zc4zvtDOr6bvrlxd07nKKnI57
 XD+VIOVc0RoQiF+bGQk3U1byhPgpiTPw0tsTPLZVWL/bplNxBbMYwJ8AnikooA96RoOpm9Af9us
 VnkXGP8NeITV3D112D+fnd/gKpaEp+tc53JCmnlfxSjaedgh3TsaZG5XjbORCsKJM3osGhJN2Nh
 u/saXyJeYeScMdkDGnkelZGZI7QbutAsremqw1XlUAhFognAvXPn
X-Google-Smtp-Source: AGHT+IFtdmO2ok1nXYWS72tJrjGwB1HCPdQjENQJEUBWcMrQ5u+xW5cOS7HzVyxwNpoFaNbcQZ/tZA==
X-Received: by 2002:a05:6e02:2181:b0:3cf:b87b:8fd4 with SMTP id
 e9e14a558f8ab-3d13dee4bb0mr83403585ab.15.1739135730549; 
 Sun, 09 Feb 2025 13:15:30 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d05e96f245sm18978655ab.51.2025.02.09.13.15.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 13:15:28 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 05/35] spl: Adjust xPL symbols
Date: Sun,  9 Feb 2025 14:14:26 -0700
Message-ID: <20250209211502.2299245-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209211502.2299245-1-sjg@chromium.org>
References: <20250209211502.2299245-1-sjg@chromium.org>
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

Update for the new xPL naming, which was missed in a previous patch
which purported to do this.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 common/spl/spl_reloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/spl/spl_reloc.c b/common/spl/spl_reloc.c
index 324b98eaf98..216c0f36623 100644
--- a/common/spl/spl_reloc.c
+++ b/common/spl/spl_reloc.c
@@ -59,7 +59,7 @@ static int setup_layout(struct spl_image_info *image, ulong *addrp)
 	uint need_size = image->size + image->fdt_size;
 	margin = buf_size - need_size;
 	log_debug("spl_reloc %s->%s: margin%s%lx limit %lx fdt_size %lx base %lx avail %x image %x fdt %lx need %x\n",
-		  spl_phase_name(spl_phase()), spl_phase_name(spl_phase() + 1),
+		  xpl_name(xpl_phase()), xpl_name(xpl_phase() + 1),
 		  margin >= 0 ? " " : " -", abs(margin), limit, fdt_size, base,
 		  buf_size, image->size, image->fdt_size, need_size);
 	if (margin < 0) {
-- 
2.43.0

