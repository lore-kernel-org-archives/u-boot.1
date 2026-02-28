Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4019BFEE4EE
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 20:22:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BDF283FA3;
	Sat, 28 Feb 2026 21:20:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kX4R3Hgr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3385083F5B; Sat, 28 Feb 2026 21:20:55 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E16983CDF
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 21:20:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7d596ab0917so1355350a34.1
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 12:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772310050; x=1772914850; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wywvcCo54gqj0LBFob2ISbsDYruEo/5wuk9p8SjRFm0=;
 b=kX4R3Hgr089BxfxBkxEwrBbEtWtXaJK75zEDt0GAka0+Zfa0TPi4z7MmR0Vn4PKjAT
 0AVR+l2tnH//qN010CxNyl4Mke5tDOZIu1gGQklzdHmfhZwu4bM9Em+lGSDybeP9fjlM
 0ZTUYlK+F0er187gI488i+RHPx0skAxabj3+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772310050; x=1772914850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wywvcCo54gqj0LBFob2ISbsDYruEo/5wuk9p8SjRFm0=;
 b=cYrQ9tWdkOEaD/u9umlcfCc8miEbvutKekoXSoWuv3nzNr2PmM1W8kcnDKSUTivUcz
 ElUjkwAA8g+2Zy8ZfEqmwH1qUDELHH4pV1SVLWrrZezjqGX3HSCs0AINOe+x8aGts/7O
 a2FhG6+BSYSejCgwrj1xY7FQEHSNJrTRXj4vUtLykoCqCDBIRBqnIkpISIiXp9OhK0le
 cm3R9Xv6K1cTBFCj9KJyrrUuwQn5U6aO8Pdgn8w5GGR1NssJP6YUXDfny1PTDz3nfVa5
 Lkw0RXCyf8mteTkaFUHMbFivoIEnaZhDlyPKmt+rkVYAGX/rWUJA4Mh1cDpEivzBdkGy
 AG/g==
X-Gm-Message-State: AOJu0Yyp0RlTFCFV4ymkK5wHD/1F0AO7b2URlbYMdKlkByoxR2vJbGvy
 BNaxXHiALQa/5KOKlJjTdy4Rz9utzzXjS9/hQ6Iyf6HpqCnieppPl9MdxydcVT7QlTD8vfmMcmR
 l3rE=
X-Gm-Gg: ATEYQzxlAOakf3IdZ1Ku9Icg6e7Hf7ZwNuBUKKctTD9tZIdLRV+KqwaxugCi+BPHG3f
 knv771YvasQ9l0StWj3uiLNAoourIygeHPva9pc+lGJ+cpTzdOmygpbePBRaSmyG5C7/tiVNDMO
 D9Ydvytget3WgF7WjL046OBOGjV6bELkH1NRIw2UAARvGZFZhAPiFzWIhc8mUsvT2hE4ihJg9XS
 PQbuuK+gyjQT2VzyE7JWdPxMwdbZRH14QJKNwgE6aGtYW5FIcrbKlIbeYQP+YHyb9ja0DfKQS4N
 dFlCCaBaM7X0xfemq7PNc2R7ZTfHt6Rwv+wUbdxBbF5IUv87BMvXdtWYtY6pMxjM7XmLnehcj/B
 2Y5QCj3905YWEUmRuM2wjhuZ6MghKlmbcqcFugPAsrrh7o6VCkDWjjHzjcnOXAcwPqN0+ZyrM67
 T/GfEhN0Po26kXDeOoRg==
X-Received: by 2002:a05:6830:4101:b0:7c7:620:b1b4 with SMTP id
 46e09a7af769-7d591d94084mr4451641a34.0.1772310050691; 
 Sat, 28 Feb 2026 12:20:50 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d58644edfbsm6978361a34.6.2026.02.28.12.20.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 12:20:48 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Marek Vasut <marex@denx.de>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Yao Zi <me@ziyao.cc>
Subject: [PATCH v3 15/17] sh: Call bootm_final()
Date: Sat, 28 Feb 2026 13:20:03 -0700
Message-ID: <20260228202011.1834493-16-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260228202011.1834493-1-sjg@chromium.org>
References: <20260228202011.1834493-1-sjg@chromium.org>
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

From: Simon Glass <simon.glass@canonical.com>

Add a call to bootm_final() before jumping to the kernel. This adds
the "Starting kernel" message, bootstage tracking,
board_quiesce_devices() and dm_remove_devices_active() which were not
previously called on SH.

Signed-off-by: Simon Glass <simon.glass@canonical.com>

---

Changes in v3:
- Add new patch for SH conversion

 arch/sh/lib/bootm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sh/lib/bootm.c b/arch/sh/lib/bootm.c
index 1c118870dad..81d5957edaa 100644
--- a/arch/sh/lib/bootm.c
+++ b/arch/sh/lib/bootm.c
@@ -92,6 +92,8 @@ int do_bootm_linux(int flag, struct bootm_info *bmi)
 			images->rd_end - images->rd_start);
 	}
 
+	bootm_final(0);
+
 	/* Boot kernel */
 	kernel();
 
-- 
2.43.0

