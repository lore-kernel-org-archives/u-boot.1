Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8630C46CD4
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 07:42:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AA1E878E7;
	Wed, 27 Dec 2023 08:40:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cSSv/mo9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA888876D7; Wed, 27 Dec 2023 08:40:53 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEC5E8760D
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 08:40:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-336746a545fso2803851f8f.0
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 23:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703662851; x=1704267651; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e9NpO911cvORFYi6sSWMLRWW6HI7G7HgcFnGHe/hSWY=;
 b=cSSv/mo9SvTW/xfF9kMVAxF2w17GKzctgwLtL7Pu+iHmYP0mtRxan6F923e1LsUwG6
 GXPk8NRn2Jl+Mh7eJtVTS96QNmBX+dwyUtzpy7/QCBw7FehGQ2AMmIivAP5OZ10Apd0/
 GdqMRYCTqzSvKavFIAyflV/lKPKMRGavvbHXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703662851; x=1704267651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e9NpO911cvORFYi6sSWMLRWW6HI7G7HgcFnGHe/hSWY=;
 b=qf1ntR+5ODZUgohnxSeHWyQ5xOqKgQxWxN8EDKoTz3jcMUPNIiV64Vstc2EXCN754o
 cHQT66gcCCW8mSltmqGsguN3CdiAzFmDY0bv0a0YQRSmIdTWOZNZf96NEJEv2gNVX6pa
 4rsgqeLq1P8lbl/P4xNVudctXm4SJty9VeTd1FJnXMfLy4JTwoh963AtE9Eb94DiXNun
 4EpLcgY+uEOp99MC52hfekhufxuifKRYMsyi0Z41Ta8tGZhIAtACjUbzyK6nruoVOlOk
 N55wwU6dR2nOdtMollPL3jgU7CuuICEIobSmRtu54iaOdjtDjaGJOrbLTHgTrN15aSAV
 jdaQ==
X-Gm-Message-State: AOJu0Yxx5chichr2C2Pq1X5QjcOQkaE1F+yaZJDeoxMTUi3OXIyhFS6h
 S9j9lBkD6G0SMxt0lrPGEyXQlN3YWt+TWIuDqR+4OAoYm5Ai
X-Google-Smtp-Source: AGHT+IHyE1uVQz9wWgO7cNJkA3i7VKVtQYokyhBg8zZ9NhJW7THOAktLK+NJyP1XnD7JCk99kzDvMg==
X-Received: by 2002:a05:6000:d87:b0:336:c851:a5f2 with SMTP id
 dv7-20020a0560000d8700b00336c851a5f2mr1930359wrb.60.1703662851198; 
 Tue, 26 Dec 2023 23:40:51 -0800 (PST)
Received: from tasman.chapterst.org (80-42-48-87.dynamic.dsl.as9105.com.
 [80.42.48.87]) by smtp.gmail.com with ESMTPSA id
 s23-20020adf9797000000b00336813bb588sm14314426wrb.111.2023.12.26.23.40.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 23:40:50 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v4 7/7] smbios: Require the caller to align the SMBIOS table
Date: Wed, 27 Dec 2023 07:40:24 +0000
Message-Id: <20231227074025.2178825-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231227074025.2178825-1-sjg@chromium.org>
References: <20231227074025.2178825-1-sjg@chromium.org>
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
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---

(no changes since v1)

 include/smbios.h | 5 +----
 lib/smbios.c     | 2 --
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/smbios.h b/include/smbios.h
index 77be58887a2..879b8a814b8 100644
--- a/include/smbios.h
+++ b/include/smbios.h
@@ -258,12 +258,9 @@ static inline void fill_smbios_header(void *table, int type,
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
index 7f79d969c92..cfd451e4088 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -563,8 +563,6 @@ ulong write_smbios_table(ulong addr)
 		ctx.dev = NULL;
 	}
 
-	/* 16 byte align the table address */
-	addr = ALIGN(addr, 16);
 	start_addr = addr;
 
 	/*
-- 
2.34.1

