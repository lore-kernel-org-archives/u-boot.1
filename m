Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E24BE95A67
	for <u-boot@archiver.kernel.org>; Sun,  8 Oct 2023 21:37:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8652286DC3;
	Sun,  8 Oct 2023 23:36:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fdPuYvR+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 962CE86CDB; Sun,  8 Oct 2023 23:36:58 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A0C586CF4
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 23:36:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-35135f69de2so13111325ab.2
 for <u-boot@lists.denx.de>; Sun, 08 Oct 2023 14:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696801014; x=1697405814; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kQuwC6NH05GTtnfdw69dFe912rD3BmnTnAEj/B+J88k=;
 b=fdPuYvR+9BGkZu+TvgswT7RytQZL4aFnAm74L5cD6BejOfZHbKayrC0p7ZSPL8K2OB
 4P8Bf1O8PyrEaO+QNNeeRByDQfqbDk2ky1drv76NXB+Lkal1Tccr3J/oRtLTKIxR2VI1
 vnWIBVj9cs24suJ0naWrzROowwt8vv44bAFCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696801014; x=1697405814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kQuwC6NH05GTtnfdw69dFe912rD3BmnTnAEj/B+J88k=;
 b=FSp4Q/7ET72SXhxbkBzsDo5N6GzhNinS5EjbaRYdWaOMD0YHj0o29aFpEcA/3xDEb9
 NAwCi0Pa5e7/q7HeU6I7VRYX2ydRL1KWTLTmKyH6WSrV2sGtYU7uCG41Zr9rpIaCKXmn
 hzsqUaJtURATK0WV4W03hs8YSqCaVqHj+9I5aOHlkBPc2qb2V5zb30XcNcGndElnNl0S
 YOXnUxD1i37vNK5V6MDa4ggzknAMacgp3PFr6kkj1OFhcycTJniMp4WKgjxEhrE+ftJO
 vHvjVtdlpprfqo7GMpxRb4eieAqAxIOLSiTS7dRQIpASHPqUZfWLlayN/ZSeuOpvUQDE
 5tPQ==
X-Gm-Message-State: AOJu0YxdVpCkYHplLZ+Ji8GtwCgqQMdPwL4wR75aFY1+YrirReQJLI/6
 4LzSu1m++/X9yA3Z412lGGiw0mu94AuoJaeU91s=
X-Google-Smtp-Source: AGHT+IGrStK+8GJrAWDmBFaVQmrlMR8dF2icK1O/TwJ8bmhSVaGG9MD5AQSGW3TfQplutfQyVlEnVw==
X-Received: by 2002:a05:6e02:12ea:b0:351:1647:5f7e with SMTP id
 l10-20020a056e0212ea00b0035116475f7emr17954880iln.15.1696801014428; 
 Sun, 08 Oct 2023 14:36:54 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 f12-20020a02cacc000000b00430bb70004dsm1751826jap.103.2023.10.08.14.36.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Oct 2023 14:36:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 5/5] smbios: Require the caller to align the SMBIOS table
Date: Sun,  8 Oct 2023 15:36:44 -0600
Message-ID: <20231008213646.622002-6-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231008213646.622002-1-sjg@chromium.org>
References: <20231008213646.622002-1-sjg@chromium.org>
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

All callers handle this alignment, so drop the unnecessary code. This
simplifies things a little.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/smbios.h | 5 +----
 lib/smbios.c     | 2 --
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/smbios.h b/include/smbios.h
index ddabb558299e..31d997287588 100644
--- a/include/smbios.h
+++ b/include/smbios.h
@@ -248,12 +248,9 @@ static inline void fill_smbios_header(void *table, int type,
  *
  * This writes SMBIOS table at a given address.
  *
- * @addr:	start address to write SMBIOS table. If this is not
- *		16-byte-aligned then it will be aligned before the table is
- *		written.
+ * @addr:	start address to write SMBIOS table (must be 16-byte-aligned)
  * Return:	end address of SMBIOS table (and start address for next entry)
  *		or NULL in case of an error
- *
  */
 ulong write_smbios_table(ulong addr);
 
diff --git a/lib/smbios.c b/lib/smbios.c
index 82e259f31791..735a9487c019 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -483,8 +483,6 @@ ulong write_smbios_table(ulong addr)
 		ctx.dev = NULL;
 	}
 
-	/* 16 byte align the table address */
-	addr = ALIGN(addr, 16);
 	start_addr = addr;
 
 	/*
-- 
2.42.0.609.gbb76f46606-goog

