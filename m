Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9493C5B572
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 15:57:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A942B812D6;
	Thu, 13 Aug 2026 15:57:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z0SeYpiLM65f; Thu, 13 Aug 2026 15:57:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E077881291
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786636640;
	bh=2doG0fJLR1DyRn5IZ7i/qPvPD52ANf7Yk9R1Y+HpMMM=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=X/A+xHRlMTr/oMpGcq01fQI+S5WQ+4en+iIOs6KSPewcODAyKrHvtToLSvW6jc5LI
	 zAiWS5QHsYkhPQyQIZ6mOnV3n8VZwD92sSm0LdY13VepgnnPvj7n7W7WdLEVk0IbUK
	 sl8eTRBjLddI9jFdGkI3BQ3RDQtxfg73Q51TAciYx0pDXMfd1lP4Andg9z+SpzXjGO
	 Sky090PU/AxhuXpdk0ROrZzKFp3exCRpb1HyStKYflGI2WucKWoE897Bl9fxQofck/
	 m9KNCo7G6nB6dg+nt+8P0JpB1Xyz1g+xX47G25j58EjM5XPWtWiufsbkpbwLWI/5Kv
	 FBYhlS1Uu7QSA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E077881291;
	Thu, 13 Aug 2026 15:57:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D4BB0EC
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:56:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BAFE580E30
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:56:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7iXF8ZU9NSsN for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 15:56:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B716981247
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B716981247
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B716981247
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:56:56 +0000 (UTC)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D10523F0B5
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:56:54 +0000 (UTC)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38e7b87ce77so4924911a91.0
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 08:56:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786636613; x=1787241413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2doG0fJLR1DyRn5IZ7i/qPvPD52ANf7Yk9R1Y+HpMMM=;
 b=i+HCUXWnl26ywLr9Pb+phPW5NBhM4y7M9L7w00fvOhyO3kLA7JLj2dUQIsFJOon9qu
 gqJ0SPSEA/TqKSU3XKXuUxwsmJm8UuOvSGUEEr84D9NDGnWFJ2ee+NxN39WEs64hOEiF
 INTU1WF8n4ZjcrZZ4Tg1/PzYLDzmYP5fGsz3ulfUwj3A/JSv1hFpE/DlR7ZOs1VHYyN0
 /MXqJMVnhX9oZv/TPUAEsHCvVaLCTDfjJSmalYSp6o6MPmYqKyKhuBnCr+qtW8q0BWKm
 4Y/l5egCcdSEhQEgyH0uUB7E7jpnAkeri3RQfyRKGM9ROMoewOF1SV9kBFxa3xMcCLOj
 WVLw==
X-Gm-Message-State: AOJu0YyXq0Czp8ijT8ARPi7vDo7JsFyxgrSJsdGusAYAK6s7u7S6Uo/T
 of0uSEKeFm50tRJWW/DQ6SnZOcD92xMTKm19e+pNu1hOM4aeuJKDADZ4bb06neeNgVQGOclfJAz
 L4nE8Z+1yxP3iZyRnNnA3D8MLvq2+Die9zcdsUKQLX5oIIVcPfzCA9PmeOsnUtDoeIE9gOhNGZR
 LnoIPyq612GNcWgs6k0Q==
X-Gm-Gg: AR+sD11yiVW1cziwbp0eQK3YK7bZs4TSTDEPE02cvKV1dGI2OwTrGQGbUcTrgOdd8FK
 r2XzhRkzbL6OrNGe3k60jyQEC9J0nmpDZU/S4XLCdMPn0XbNh+J3wsK5ebouXT96mZmeep/mh0C
 aYtdqxNdbREBby9W47f/ehjXF5YgfNAR0T6OdkTWikSiwHp5cYbjHhsPd+JeO79mqTrR3HDoRSB
 rNdprDiUx0Kcjx3emGRjlNyMl8/JPVYRnkaHRRQyKqCiCyPqjJG7VTiOQfFU83eO/0RMcJr9Fnm
 kc75ExMUYvRigOhyd3wgTffqjggBOlT8U/rQoO9XtIZdjVbsa4xyGp7Q2BtqltYgaTmXl99UE23
 nhkunk1xryaGvb9ZexxgRRDI6jRwOCL7qfoZsTyLWLiF4Yu99XAw=
X-Received: by 2002:a17:90a:e7cd:b0:38d:f096:a1dc with SMTP id
 98e67ed59e1d1-3931e270affmr7945739a91.11.1786636613268; 
 Thu, 13 Aug 2026 08:56:53 -0700 (PDT)
X-Received: by 2002:a17:90a:e7cd:b0:38d:f096:a1dc with SMTP id
 98e67ed59e1d1-3931e270affmr7945686a91.11.1786636612776; 
 Thu, 13 Aug 2026 08:56:52 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3931f44de1esm3603538a91.13.2026.08.13.08.56.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 08:56:52 -0700 (PDT)
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Martin Schwan <m.schwan@phytec.de>, Francois Berder <fberder@outlook.fr>,
 Denis Mukhin <dmukhin@ford.com>, Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 7/7] bootstd: rauc: Clear bootmeth_priv after freeing it
 when booting
Date: Thu, 13 Aug 2026 15:56:17 +0000
Message-ID: <20260813155617.184928-8-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813155617.184928-1-aristo.chen@canonical.com>
References: <20260813155617.184928-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 13 Aug 2026 15:57:15 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1786636614;
 bh=2doG0fJLR1DyRn5IZ7i/qPvPD52ANf7Yk9R1Y+HpMMM=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=cEJREF1sV+PY5iVBmvEsIHhP5JVlcr/s9GlaTpJlklUd3xEU3mMhhA6VYQFSjjYxN
 Em9D//8jcGhYswxiDDtb0R69Ztrv7nFjhAWkqHRHcPDchGL5ssR3MFK6uCcoQjswPp
 vW635rV6DITXwRba/GV3cNtwf0QteHdFIJ5ERIO0RG81KY8WThnurt6B3NMnHKD3B7
 XRfA/dQVep8rwr0MJwxYWoYNoAL0C23qhXUkqpDTZjWGEDxzO7i0edfjMzWplhwlQg
 ZVIjbqipTzoNvaZsZJj1wfktIrH6KMY7IR6NSyyJJLlma2GfcUaUyjdtkXn9cxybLJ
 K3nSdPTxaYJcf+gmDJEXeduMV/QzJOo/EfhBkrZgy7vtkE9tfYfJt6Ol3FZwL5i0iv
 BCn5XG2NvgOan4dGsbJqpgriKVv7l70R+O1uPlS7ZW/hnKjWcxf/yrOcjgNx4vLs+F
 uDXdDCLv+QRHEBh7ALZwT7i7ELfe1snY22jnHQcR3q3J1OsEltIJLbtMTqfyAJ2BG1
 dxmbt6ANYK6+A0amkkF5euRXa1E3/iiVvMY7/J6avVsXeb2rKDbXFHgNYItohOY08a
 kOqFJkhkT1SHeYN5ewYpjJLYBUTOACkXrzyTYVrdx3JgTlrJ5xiyX6g7URk7pbAsQ8
 n0eCJSuIutnIzZt0NjCluOVU=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=cEJREF1s
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Aristo Chen via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Aristo Chen <aristo.chen@canonical.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

distro_rauc_boot() deep-frees the private data once the boot script
has been loaded and run, but leaves bflow->bootmeth_priv pointing at
the freed memory. The bootflow being booted is the one stored in the
bootstd list, so if the boot script returns (bootflow_boot() treats
this as an error), the stale pointer is kept and bootflow_free()
frees it a second time when the bootflow is removed, for example by
the next 'bootflow scan'.

Clear bflow->bootmeth_priv after freeing, as the scan error path
does. Also check priv before using it, like the other users of
bootmeth_priv in this file: after a failed boot attempt, a retry now
finds bootmeth_priv NULL and must not hand it to get_slot(), which
would dereference it.

Fixes: 498e423457a0 ("bootstd: rauc: Free private data when booting")
Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 boot/bootmeth_rauc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/boot/bootmeth_rauc.c b/boot/bootmeth_rauc.c
index 2df141f7424..844df7576bb 100644
--- a/boot/bootmeth_rauc.c
+++ b/boot/bootmeth_rauc.c
@@ -398,6 +398,8 @@ static int distro_rauc_boot(struct udevice *dev, struct bootflow *bflow)
 	if (desc->uclass_id != UCLASS_MMC)
 		return log_msg_ret("blk", -EINVAL);
 	priv = bflow->bootmeth_priv;
+	if (!priv || !priv->slots)
+		return log_msg_ret("priv", -EINVAL);
 
 	/* Device info variables */
 	ret = env_set("devtype", blk_get_devtype(bflow->blk));
@@ -464,6 +466,7 @@ static int distro_rauc_boot(struct udevice *dev, struct bootflow *bflow)
 		return log_msg_ret("boot", ret);
 
 	distro_rauc_priv_free(priv);
+	bflow->bootmeth_priv = NULL;
 
 	return 0;
 }
-- 
2.43.0

