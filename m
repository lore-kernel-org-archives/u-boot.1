Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C573DCD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 14:46:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 547FD848A4;
	Mon, 25 May 2026 16:46:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="N26Ty/Co";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AC538460E; Mon, 25 May 2026 15:26:52 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4F4F846AA
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 15:26:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4D7F43F581
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 13:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779715609;
 bh=aDM0nR0bsshNEgN5M52mHtOwjyew6RKtHE2JHMySUP4=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=N26Ty/Co7r+aJ+9/8Qf/pHXfktntWeLvHuhnlQc1wWMLzFnXM3WTdVhNof26cfecd
 /gh6ijaTomtTqimi2Zua2UQe6kZw/Fh1xNQmtMmm33BABTiGuWlwySLN6uIoknA5lw
 QziL+cu0+u5AUIVW/NC1pAPjzPSPIWgNY/YWYY1b0SKzfDIh5MHdl+xf2YmTjKc4wl
 abBrNILlU3uN/9QXd8w5F+C4Zy1KE7zGdu+yO08G/6oLL3uuHmMZtPTb1eNKxl5Mfl
 xBMc17q3v8kdmwdLHm9VVYYlwODuLx1la9KyB5f9+giu6r/1gQfrUISwUbnnJnl/WM
 xbke5N0mEpUnnJLu6sPz0stISNn8WiFHGrwdBf7qnNa13iLahGKmB5LmrAM41n7gIP
 52bsdxFJmZiBH4oja/YgoQ0L8G2kEuKH33Fs9+uK9BWRpvXIa+V4ToIj1KPmC9x88+
 zeWtO1zMznnwwkTONKoHXuQvut6UJlDht8GxcZI6dt+bUBWeCGSxcZBWItATajGpkX
 ZUuhlzZ48OWBf2QJuGhe5mSSshcm/OX7FQ/rr6RYQT2C8c7CnIbJLBN38cWrGRQvwL
 d3KIsiV6zY9goyMSSLw+miwUnU84INHlLNEH8ui2PoDVqq8lAxzuqB/WD4h39L8N70
 O4F/+MPy7SRxURtfaWHg7jk8=
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c8294d8c48eso5991695a12.0
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 06:26:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779715608; x=1780320408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aDM0nR0bsshNEgN5M52mHtOwjyew6RKtHE2JHMySUP4=;
 b=h8/3kYMQXn4YqmocToXdhhL0Zj/ufHdjxMINLpHa+TB6KC6AMi78uSxdpIkT5hqkKr
 b3s9b8rKuxo2Yw8Wl20mEaZg/46r77FPDugSZ5xIVasTzWZXGB6wPoQtDs75rsMNIMc+
 sZikBZ9buf93RDGbvMs6XveBNVKU5ZB3AypIhFVl9gRsQr0vXyWpD3BK0Pxy+IAsTU7w
 XspOAGZ/uDSQwxDSO8Zcj7lCy+SCWtEPSPJloG00bC7IcEkft408y5baBjv1RBG/zlao
 QBIVMykrEZAwwnXAWuBhvWVAh3GDW8Bi0sKynatdrSciBoleoVrnSgsY6lzum+Y9DJVm
 Mv2A==
X-Gm-Message-State: AOJu0YwXqiGehDkoDLOAjewg0M4v7Amvu7RzuARZdka3LXY0QZYH1eZN
 4eqdIR+JFrhthWuBKJN218r4S3srAznkpj4kFrqHfpZB+D97ycULZPQLtG8gi5Jet2bgQFSNt+f
 1o0k8ESWxlPY4eCOsNT0CL2z2OF9ZqjN6g+d7r6WH0M1xSLWD5IZ0SGDsOx9Q/1ilMLfwFA/SYp
 XuklLKRQ==
X-Gm-Gg: Acq92OHv6BKojwyXK7uedvrTDxA/F66+BRzmClNhQ39mKEUKEETxU8lBo34iMnSvv/t
 60/qfvpiINSGTctb5pbrERzPbM9tq2JZYVtgPmmmMm4TNkiGJghoobZfVX8dLd8my5V5a7NwEfg
 pP7G1d9vOnCSo22Vit55tsy2Aj+/FBx0UKiw2zGKIjiha6cxWE/diEnLTlpbvK3k5CH2ttE6ppK
 SZFfxgkIWFnPC+6rzTpvoZ7uAkemjUBw0gtZJbKOLJF+k72onIUkC2R5QMW5FE9htdS6nocnLCT
 2ivSi2YVovnsDif5HMqalRLbXzVddKD6qP05ZhtnkjnSTXUBnIOs76Qe6vmcCMptX1LC9GPfyA3
 a0USkK1b+NPSSqYLsj6IL7+u/lXDueJUOrO5pAOsv4aj7mlC4zhqx9V42ui+9SGloWFWi2PCnT3
 v8ok9PQGCsjHXOytw=
X-Received: by 2002:a05:6a21:6e8e:b0:3b3:fc6:6226 with SMTP id
 adf61e73a8af0-3b328e74dabmr13646416637.24.1779715607911; 
 Mon, 25 May 2026 06:26:47 -0700 (PDT)
X-Received: by 2002:a05:6a21:6e8e:b0:3b3:fc6:6226 with SMTP id
 adf61e73a8af0-3b328e74dabmr13646394637.24.1779715607507; 
 Mon, 25 May 2026 06:26:47 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-841648a2bf2sm8806449b3a.0.2026.05.25.06.26.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 06:26:47 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>, Tom Rini <trini@konsulko.com>,
 Adriana Nicolae <adriana@arista.com>, Richard Weinberger <richard@nod.at>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH v1 2/3] fdt_support: validate dma-ranges length in
 fdt_get_dma_range
Date: Mon, 25 May 2026 13:26:24 +0000
Message-ID: <20260525132628.755148-3-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525132628.755148-1-aristo.chen@canonical.com>
References: <20260525132628.755148-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 25 May 2026 16:46:18 +0200
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

fdt_get_dma_range() fetches the dma-ranges property with fdt_getprop()
and checks only that the length is non-zero before reading one full
entry from it. The entry size depends on na, pna and ns cells returned
by count_cells, which come from the parent buses in the devicetree.
A dma-ranges property shorter than (na + pna + ns) * sizeof(u32) bytes
causes fdt_read_number() and fdt_translate_dma_address() to read past
the end of the property within the FDT blob, an out-of-bounds read of
attacker-influenced data when the OS devicetree is not signature
verified.

Reject the property when its length is smaller than one full entry and
return -EINVAL, matching the existing failure paths in this function.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 boot/fdt_support.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/boot/fdt_support.c b/boot/fdt_support.c
index 3e9445603ff..c4c2a5d02f6 100644
--- a/boot/fdt_support.c
+++ b/boot/fdt_support.c
@@ -1633,6 +1633,13 @@ int fdt_get_dma_range(const void *blob, int node, phys_addr_t *cpu,
 		goto out;
 	}
 
+	if (len < (int)((na + pna + ns) * sizeof(*ranges))) {
+		printf("%s: dma-ranges too short for %s\n", __func__,
+		       fdt_get_name(blob, node, NULL));
+		ret = -EINVAL;
+		goto out;
+	}
+
 	*bus = fdt_read_number(ranges, na);
 	*cpu = fdt_translate_dma_address(blob, node, ranges + na);
 	*size = fdt_read_number(ranges + na + pna, ns);
-- 
2.43.0

