Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFCCEC4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 14:14:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FC0C8863E;
	Fri, 26 Apr 2024 16:13:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ALHL9ypj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63CEC885BE; Fri, 26 Apr 2024 16:13:53 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 746EB8857C
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 16:13:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D27443F8DF
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 14:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1714140828;
 bh=kHme1oKORNvND9fAuaPL5yDjhH0XVg0WgDGvImvhoac=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=ALHL9ypjFS4Av+Ey4AV8byIYJ3mbR+lRDH5WUomfhqMDFaWwK5olyqfXXzUxn4bYM
 Ki7aLNZPUGodVnXBqO8bOhQzTLDkULqy24fJ3auUcHAQrWUViJDwu9670L1tWW0DZO
 AljjMGB7kj/x4iQaOKuAqTORj4YZsCdUG58N8rfz0gkMCsfyxC+AvUUcEaiaDgzBrc
 uz1Z0VmrFHK/wvlQIyxzx9ApEwfkQgbe+KWnMt7eLOMgtzIRRvjQJpYgZw7s0zRBBm
 upSJdCuwacgvqrC1qKu1CTeHgsYyfWjAT7QeC7yZxb4u0JqPHRqzEi7Jllz8Za4q0u
 1ziywTb/yo0QQ==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-343f8b51910so1290043f8f.3
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 07:13:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714140828; x=1714745628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kHme1oKORNvND9fAuaPL5yDjhH0XVg0WgDGvImvhoac=;
 b=vzX3sCRVs0nzqMCTzJSMafusFxxlYtzHdN9EBqD9Rcv4iOWNqaDb7O5hhGKr1R1geh
 kBoLgvCmvY+YvoGaDqMBYAeQBWga7/evZ3Xr9oKlfMTJN1ft5Zo47Xe+poP0e+J5V9k9
 7NHNLXmpDe1joiQbsxC3qiddMykui8Jq4dFTuiIXqPtXJ+zqoBWoKhMbvwct5BndbRD+
 JwEh5lZ+pkLHldLEI5/LghnwLkQ2dtXhUtpEu1flKpF3XfvFAJVsQ2wZ97NzJvI0icv4
 Nw3StHXO87HeVRQCtwJ20TN6dVZxA/E4qjJjW33sUcllHqr1kqxJCOVjcIpfd73K9bmu
 0HaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAis+itJFrXenMut18GtcVD9DgLIVJAMP16jlk5hBSfudtr12bJ/nEPdbreN5BRXJXA3p0dCX0md7jx6WTGdA5M1QDOg==
X-Gm-Message-State: AOJu0YxPDPD39oDTzCNoaE1c1VXSimYJDu0ZC6GytTdNn+gWSCLcV4Ui
 tA4fTd8qWf04Afsr3/C6LeuOLdzI6wnW+/BALtMbPKyEfzRK7k0mOXWBeLZro5ot3ZNxw9CccSj
 iFoExMbPUjmmZldMJMaOU6ISJfImqAkGHLCh2myHgJuO3WuZdHf2xakQqX805J0bnegY=
X-Received: by 2002:a5d:614c:0:b0:343:7a0c:62ff with SMTP id
 y12-20020a5d614c000000b003437a0c62ffmr1701864wrt.61.1714140828493; 
 Fri, 26 Apr 2024 07:13:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtgm/VMfvBKlv2uq2FlDhT4qzwJpfBkl7u4HVF5uUoZYMC5DfQ6E8lZVuDMz3VDAQDPGWbfw==
X-Received: by 2002:a5d:614c:0:b0:343:7a0c:62ff with SMTP id
 y12-20020a5d614c000000b003437a0c62ffmr1701850wrt.61.1714140828142; 
 Fri, 26 Apr 2024 07:13:48 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 s20-20020adfa294000000b003455e5d2569sm1460593wra.0.2024.04.26.07.13.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Apr 2024 07:13:47 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Shantur Rathore <i@shantur.com>, Bin Meng <bmeng@tinylab.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Joao Marcos Costa <jmcosta944@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [RFC 02/14] efi_loader: library function efi_dp_merge
Date: Fri, 26 Apr 2024 16:13:09 +0200
Message-ID: <20240426141321.232236-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240426141321.232236-1-heinrich.schuchardt@canonical.com>
References: <20240426141321.232236-1-heinrich.schuchardt@canonical.com>
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

Provide a function to append a device_path to a list of device paths
that is separated by final end nodes.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/efi_loader.h             |  3 +++
 lib/efi_loader/efi_device_path.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 9600941aa32..a7d7b8324f1 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -944,6 +944,9 @@ struct efi_load_option {
 
 struct efi_device_path *efi_dp_from_lo(struct efi_load_option *lo,
 				       const efi_guid_t *guid);
+struct efi_device_path *efi_dp_merge(const struct efi_device_path *dp1,
+				     efi_uintn_t *size,
+				     const struct efi_device_path *dp2);
 struct efi_device_path *efi_dp_concat(const struct efi_device_path *dp1,
 				      const struct efi_device_path *dp2,
 				      bool split_end_node);
diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
index 46aa59b9e40..16cbe41d32f 100644
--- a/lib/efi_loader/efi_device_path.c
+++ b/lib/efi_loader/efi_device_path.c
@@ -270,6 +270,37 @@ struct efi_device_path *efi_dp_dup(const struct efi_device_path *dp)
 	return ndp;
 }
 
+/**
+ * efi_dp_merge() - Concatenate two device paths separated by final end node
+ *
+ * @dp1:	first device path
+ * @size:	pointer to length of @dp1, total size on return
+ * @dp2:	second device path
+ *
+ * Return:	concatenated device path or NULL
+ */
+struct efi_device_path *efi_dp_merge(const struct efi_device_path *dp1,
+				     efi_uintn_t *size,
+				     const struct efi_device_path *dp2)
+{
+	efi_uintn_t len, len1, len2;
+	struct efi_device_path *dp;
+	u8 *p;
+
+	len1 = *size;
+	len2 = efi_dp_size(dp2) + sizeof(END);
+	len = len1 + len2;
+	dp = efi_alloc(len);
+	if (!dp)
+		return NULL;
+	memcpy(dp, dp1, len1);
+	p = (u8 *)dp + len1;
+	memcpy(p, dp2, len2);
+	*size = len;
+
+	return dp;
+}
+
 /**
  * efi_dp_concat() - Concatenate two device paths and add and terminate them
  *                   with an end node.
-- 
2.43.0

