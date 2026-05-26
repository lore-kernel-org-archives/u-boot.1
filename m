Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB63CD5BC9
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 03:44:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A1AF84963;
	Tue, 26 May 2026 05:44:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="S6kVHkIL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CD38848E7; Tue, 26 May 2026 04:09:55 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C44A1846D3
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 04:09:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7443E3F6C9
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 02:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779761393;
 bh=Qg0ceKWH6QFJAzNv5pkaH6QQFKpMOJg/BCTA8AZBLIY=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=S6kVHkILnlUfBpJ25wpgrf7g7xLOusc6L3IZ3gYaw8JkpdwT6IaQPLTPuhxwnMRI9
 uEj1Esg0PzJcEGz4zwsMJGXHEuMJ5FyNatVW+eKdwqSugVHSZ2VeLyAgcQyB2czTFA
 TRgCnhl6MrzGzOJpE7Gu2/0Db80CwS2cZF7cztUupaqxGDlR7NFWaMNy5EPWCEU7Zm
 XCJITVEgTBhNCseAz8+9ZnVjYBOWN5ZskL2dAHnG6OI7Hsu3LOEK5xyXOn5CylHgLt
 29Z3CNBy19XJmtzS8kHkOkAEsZEjca3Xe8QmiQhRZrnxLOdQ4KRXY3rQ8S8vtlWFVJ
 bsk6wd6LuzDSvWBTIdIEgq/ii4oML7t4K2jc7E9FSfXcxEGJtwkYk66KTjvPhee7L4
 miu3oqIPciNegekB8dAsUIkOOhY5/bKRF9062gtQaR4A2rvfwPoavs/5jzXb/27Qe0
 vTiNiSGB+lUS8mO4FLc2lh4fSo4Cusmu0iMnHzKgnhyhs4GhV3qtwLwgXl2IuNFNCB
 ROepPvYVjzktYqcsiYkPNmfH5IocTn34hkiVSnm/ZLstGN9KNaAk3n+DsLAVSe49Hw
 E7AjbxdEvkc3XOyH2V3EI3S5JQsY7Tf31GH7A6pAMNM/VYrJZS4FMl0J1VGKblJvgQ
 LWs8xoRvpp5i/ipj3sNmZcIE=
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2ba3245a43dso111097345ad.0
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 19:09:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779761392; x=1780366192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Qg0ceKWH6QFJAzNv5pkaH6QQFKpMOJg/BCTA8AZBLIY=;
 b=kcjuPT+z7xueARRWuSI7l8uS2UPplkVFbDLt1axVfOOcSEH87aJdnUJfvTJdwqThf3
 hHCsMvKL7r6zMSg1F94/ZOoppibmA6eO4NvZ+w1OUHgDXJVQjvlPyY9ULCVwxw3P/b9Y
 9vonMB2JA8T9PmN3RnDZt5MCf7ryNuifHZ6LNZCVBowqRDgWYb0ViARfyu1xytICqOeK
 XUiPcqp+esChkVG2aBlQXgesTY9E4ba8zhGgTfN6odYojs8T/FdxBqlH7N1SRucZtobP
 GnkQ5nUtMriyFLWyvY51jgFBPP4R2NgZEu0P9RIDHJRqSoFNppRu4JOusCtQEkriE6ir
 qd9Q==
X-Gm-Message-State: AOJu0Yyib+a1vnWQdpErAgjFmnf1wQHidJ1gnMxjUuhJe3uX+z/o7hkh
 PxV1WLF2Nk5At7Emmq6YsUnmVYRCkmgMIMLRgojd/0BFSTZdwMQLhD7tti26GKWNlWb/Xe4S9m1
 EMKS8ZE6tx5ZShvbysS5H1LiP0BtN1CFntPVsRtpCT4/D/G1Yt2HDlYQjmD++CgvxhOuePMQIM0
 vVNWi3hQKO
X-Gm-Gg: Acq92OFF61Aq+3tH7eRJ2sq5Szw9YEOak+TO7vOp8H+0PqNGI54hVcKqbZoKQ1nzNeN
 oqMS0zbBF4dxubBaVrXwI2k4rR1f4lrQ86lV5uXJvVEE6UeUcUicJmdKJNq4flEzvuJg/4NIXZm
 J//kZyyaUit4bMfsYhIaVTJAEalfwStq+kjWPFr/fZAVT3lw4kl8gW45foKWjbNOLRPsT2LQBk5
 KW7Uq1d9KOlVcsYuKMjO4cD+oezHBhTNenw0UiE1n9vuEu3dQPSvS8ZxdCWYtb1fIjD1faF3CRF
 abYZTVeS59m7OC+2Pt4xGkLL6GHaiuLep/hWmgqrekDaWCRcTjKr/qd/KBqVLnw3qkWgmy+w9hj
 MnBtqYpN39LWPXo1rtxzExdq6m/5vs87IsXSTcXSqQAE3CGAkTxYqruwyqyW7DDD8+p5XgT/9X8
 Lw/JAl4CMQbLr6o9M=
X-Received: by 2002:a17:903:2f4c:b0:2ba:9e1c:7cbb with SMTP id
 d9443c01a7336-2beb063361dmr178583045ad.34.1779761391660; 
 Mon, 25 May 2026 19:09:51 -0700 (PDT)
X-Received: by 2002:a17:903:2f4c:b0:2ba:9e1c:7cbb with SMTP id
 d9443c01a7336-2beb063361dmr178582745ad.34.1779761391284; 
 Mon, 25 May 2026 19:09:51 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb5695b2esm101522015ad.4.2026.05.25.19.09.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 19:09:50 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>, Tom Rini <trini@konsulko.com>,
 Richard Weinberger <richard@nod.at>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Adriana Nicolae <adriana@arista.com>
Subject: [PATCH v2 2/2] fdt_support: validate dma-ranges length in
 fdt_get_dma_range
Date: Tue, 26 May 2026 02:09:15 +0000
Message-ID: <20260526020917.8438-3-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526020917.8438-1-aristo.chen@canonical.com>
References: <20260526020917.8438-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 26 May 2026 05:44:15 +0200
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
Use debug() rather than printf() for the rejection text so that
production builds do not pay any .text or .rodata growth for the new
diagnostic.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 boot/fdt_support.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/boot/fdt_support.c b/boot/fdt_support.c
index bdf651364b4..632d5b380d7 100644
--- a/boot/fdt_support.c
+++ b/boot/fdt_support.c
@@ -1633,6 +1633,13 @@ int fdt_get_dma_range(const void *blob, int node, phys_addr_t *cpu,
 		goto out;
 	}
 
+	if (len < (int)((na + pna + ns) * sizeof(*ranges))) {
+		debug("%s: dma-ranges too short for %s\n", __func__,
+		      fdt_get_name(blob, node, NULL));
+		ret = -EINVAL;
+		goto out;
+	}
+
 	*bus = fdt_read_number(ranges, na);
 	*cpu = fdt_translate_dma_address(blob, node, ranges + na);
 	*size = fdt_read_number(ranges + na + pna, ns);
-- 
2.43.0

