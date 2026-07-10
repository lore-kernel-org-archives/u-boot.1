Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F1BC43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 18:13:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAC1684B93;
	Fri, 10 Jul 2026 20:11:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OwxbBiGR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B811384AF6; Fri, 10 Jul 2026 16:33:23 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9B1284AF6
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 16:33:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ivitro@gmail.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-4720f3bf164so1064011f8f.1
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 07:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783694001; x=1784298801; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pIQjBgPu6R3CO9PSYIsi0uDYhrAnXr2PAaxdJVZUN+k=;
 b=OwxbBiGRQcqL31m98bel5rlo/54ACJYYfHcmhEVhG3xCUoqKI76QcvmRpAu/Uld7i3
 jw/IlFeglxJldGWFPCIqzATtWd/t+wKfZqP9nwwy5Ws4VQKizpCxjXEOmO3xpOFPt+7b
 WaCYRGGOQUHiJEzeu2leHcS1sE4RNl1x02qSYTrtO2yqGQ4OOk1PKAlLoOz4zlh5ZFBh
 h8jdrHQd+NFnRnXy/l7h6u73hf9psUUqv4e7cCaUTfDqOLtugW9c1TM260/hH+eUQ+sd
 9l6pSL0fMoaBS7M+5rnddn5ZDSZ0hqV5hAlrrqMcnTIJDeKrUtVxIIHClAJ9MQwK48UL
 NyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783694001; x=1784298801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pIQjBgPu6R3CO9PSYIsi0uDYhrAnXr2PAaxdJVZUN+k=;
 b=djfh8KtlKMskHi5fipHQ+2VvS6xjqQVAhLYk1COCyElS3WSXsXAtnY9Lwg+zE0NTkR
 aDYY8enJE0WluSRyHvXcKarRUvLYVtnkJTeI+vUhSnRp36egxUiNNT1655KsWjhnX7JG
 oURvNqQIKfjyjhVgmQJtf6bIePXNMicSHx71sPcsT4XPRxFIqUEbzqlZ06QS3ZnRinGv
 aesHSS7xZGT2hEfhOnuiqESFQl9TUBp3mE4YeMukh+9v8nqy3eMJUgcQGVHanMeiVZdy
 uI18OIQj74Wy8ppWr1runduh2I9xm/H6YfNBhXWBi1GIrzeUSV6vyjZ90HQ+2cCuMMA9
 VJAw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rov7lFs7hrHvTskBIeiSdc6rmxuDfH8wMbLmwKFkum6Y4kE/uejpXSnXMHb+4Mb3y473jFHYi8=@lists.denx.de
X-Gm-Message-State: AOJu0YwVDD/RbDFEbHeokGImvOE4qlqXgBNrxRta397HaOLZAj6nGYRT
 ahqJFb6jbMOKYjSdhMlQlXAgD33bdRG+5zOzmWsUikEuz3xCDE9MhZom
X-Gm-Gg: AfdE7clWsCfZPOziBcHMAVz+Rd0RZ5YnTwqopSH8urE4A4RSzSVCl5FsgS0KnQkq54c
 qWZmb1shAQWJcV3fxG6xwLouXznRySMATHKagAZ2bhEC8/QwlVlOp11QcZWKx+66ZdFxYH/MtnQ
 TzWv8URokKkpEVDIPs63hBogx2XCP9dgZBmf/Mf3Q3prfxPFxsfQkKN69oHfQHIqsrt4uZxCJ3A
 HWa7H7H6wfFI8cStBnhcAM/fdyRm3x/Z3K109iN34w015Vsi1xwMgrRzp13afKEqJj+NLIAdFlW
 bGVaKSxR7yc6VtflUVISoD5Tp1hhh/P/4G+L6MVnTtTAk+RXiscuBw+bUEmpVYIUbHlsZrsv+3f
 Q9kZAgNpISyQaCPpjVF7i9KvOSfMBPF+dxIKg4uLJi6aG2d8sdeWNU7Pp1sgLQyAEpRE/zZlSU0
 xeo3cnMWz7ll5QjCA=
X-Received: by 2002:a05:6000:26c2:b0:474:a0a3:df0c with SMTP id
 ffacd0b85a97d-47f06d9f2fdmr4803331f8f.10.1783694001261; 
 Fri, 10 Jul 2026 07:33:21 -0700 (PDT)
Received: from vitor-nb ([2001:8a0:c4c6:f00:3cb5:ed02:715f:532b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d83bdsm60549688f8f.13.2026.07.10.07.33.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 07:33:20 -0700 (PDT)
From: Vitor Soares <ivitro@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>
Cc: Vitor Soares <vitor.soares@toradex.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1 6/7] toradex: tdx-cfg-block: Add smarc imx8mp 0240 pid4
Date: Fri, 10 Jul 2026 15:33:04 +0100
Message-ID: <20260710143258.285091-15-ivitro@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710143258.285091-9-ivitro@gmail.com>
References: <20260710143258.285091-9-ivitro@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 10 Jul 2026 20:11:20 +0200
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

From: Vitor Soares <vitor.soares@toradex.com>

Add the new 0240 PID4 to config block handling:

- 0240 SMARC iMX8M Plus Quad 4GB WB IT

Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
 board/toradex/common/tdx-cfg-block.c | 1 +
 board/toradex/common/tdx-cfg-block.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/board/toradex/common/tdx-cfg-block.c b/board/toradex/common/tdx-cfg-block.c
index cdeb2e4b4de7..465254ac2bf5 100644
--- a/board/toradex/common/tdx-cfg-block.c
+++ b/board/toradex/common/tdx-cfg-block.c
@@ -199,6 +199,7 @@ const struct toradex_som toradex_modules[] = {
 	{ VERDIN_IMX8MPQ_4GB_IT_64G,             "Verdin iMX8M Plus Quad 4GB IT",        TARGET_IS_ENABLED(VERDIN_IMX8MP)        },
 	{ VERDIN_IMX8MPQ_8GB_WIFI_BT_IT_64G,     "Verdin iMX8M Plus Quad 8GB WB IT",     TARGET_IS_ENABLED(VERDIN_IMX8MP)        },
 	{ VERDIN_IMX8MMQ_2G_WIFI_BT_IT_64G,      "Verdin iMX8M Mini Quad 2GB WB IT",     TARGET_IS_ENABLED(VERDIN_IMX8MM)        },
+	{ SMARC_IMX8MPQ_4GB_WB_IT_64G,           "SMARC iMX8M Plus Quad 4GB WB IT",      TARGET_IS_ENABLED(TORADEX_SMARC_IMX8MP) },
 };
 
 struct pid4list {
diff --git a/board/toradex/common/tdx-cfg-block.h b/board/toradex/common/tdx-cfg-block.h
index 3b32fbb06109..2d038a67a1b9 100644
--- a/board/toradex/common/tdx-cfg-block.h
+++ b/board/toradex/common/tdx-cfg-block.h
@@ -162,6 +162,7 @@ enum {
 	VERDIN_IMX8MPQ_4GB_IT_64G,
 	VERDIN_IMX8MPQ_8GB_WIFI_BT_IT_64G,
 	VERDIN_IMX8MMQ_2G_WIFI_BT_IT_64G,
+	SMARC_IMX8MPQ_4GB_WB_IT_64G, /* 240 */
 };
 
 enum {
-- 
2.54.0

