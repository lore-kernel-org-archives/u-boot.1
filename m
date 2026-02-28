Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF7D2FEE4F7
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 20:20:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C4EA83F30;
	Sat, 28 Feb 2026 21:20:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C0qUnjth";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 105DA83F2A; Sat, 28 Feb 2026 21:20:31 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2BAD83EF9
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 21:20:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7d4b9c839b1so1613913a34.1
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 12:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772310027; x=1772914827; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ePAGYq8uRJaOCd+sBfUz1KHdg2xfNTZj/mGE1n6hKrY=;
 b=C0qUnjthVWws03wNUT2tvhXe7ASdZTq8ldj3sNhXBLbBMp0VIa98CERxAetABcbu/v
 FufdF4OzoGeoctGblPHgI13z5qkIKyKp0lHIOy9pbefFVaKi4OFQ2bvECFJvUTNf8HQT
 iZ999FovgGs5NGIRbDKiLwDOpBL1tSoBvnlkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772310027; x=1772914827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ePAGYq8uRJaOCd+sBfUz1KHdg2xfNTZj/mGE1n6hKrY=;
 b=cWhHgTjlIwT3ls++jSZUMbeHdM5Uywiyb4v4hMjP1COOlqYOJT2Y/UxQbJrrZgJQmM
 I8AxlB+x8sLtEyqoKBL+d4dRfBCkjDLAEXf0VwSdt5o+cNysZQFexmaFnd8kZCy1/yPl
 TnD6L89WWzTTI718wUqRU0Ne3vO4QzgpcsRX29xBt6FS41jxwEs7gNZ/5acP1bx1a8f/
 tdb2qRPkDN7O/2F+wb15V9O1qlptDA+El/Kv5I5sZmhT2t9yj44ztZtwzN8zl5OWpS7/
 IOwBXNk7qHiSnF3cHjk6gWOUBrG0+R045jxsTkY511lKrVAm+mlRztGkqTaLYapo8ExJ
 8SMA==
X-Gm-Message-State: AOJu0YxIeRdX/o12/2dfWQRb7Yj5sRzxZ6hf6NMqOu5W1rk0uRJ1eUpU
 h+EtqW7tr7UGzsNzJlyVXkh9/LLUT48QVAO4NmQ7Jiq31oPkYHFAmsTAAj+qhITFP8gWczA+VyN
 2/SA=
X-Gm-Gg: ATEYQzwkmhKlMdFK17ufdEz6dlVITqvFsggGLIU0Ts17eDir8eFhiCH5yBWxQt76FSA
 mR4n7OQ1TkZ+rQnhEWc4tms0+3nSObiwh/Hw6h/jDbhQmIi4QPeIEF/vPnLXR68uRORE23BP2ks
 JlLtSVBOmmr6BIUpFzikQzjzd7Kb0lYu4RfVYh5LV4kavucvSuPZd5L9QdHiKdw4PD6hi+AYhp0
 2ZKUTeKV1i4D1IvAyF9jKZy2ehz7EyT6rWZqt+b1TDhsW835USFVO/6wLgEHgMK4ix0Y25O3Z7D
 e7bg3pIz24cM2nzM8q01J5ZegpdR/vcKLacqzqVhmB4cEOlM1Ozv6PQ/nbIzWPukS3m9ivAXPyh
 npgrcp0BqgbBqhVUTMTbKZyd22Dp43vojnqb6jzR2lmL6U15+yQp7zTiWZKdIOoJxZcj8Uqib7f
 pnJkd1VpMqtY9yGBdyHw==
X-Received: by 2002:a05:6830:8d0:b0:7cf:c482:4982 with SMTP id
 46e09a7af769-7d591be531fmr4226251a34.25.1772310026946; 
 Sat, 28 Feb 2026 12:20:26 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d58644edfbsm6978361a34.6.2026.02.28.12.20.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 12:20:25 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Aristo Chen <jj251510319013@gmail.com>
Subject: [PATCH v3 03/17] bootstage: Add some missing dummy functions
Date: Sat, 28 Feb 2026 13:19:51 -0700
Message-ID: <20260228202011.1834493-4-sjg@chromium.org>
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

Neither bootstage_fdt_add_report() nor bootstage_report() has a dummy
double for when bootstage is disabled. Add them.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

Changes in v3:
- Move earlier in the series so bootm_final() can use bootstage from the start

 include/bootstage.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/bootstage.h b/include/bootstage.h
index 528d0ca0614..62fb99110f0 100644
--- a/include/bootstage.h
+++ b/include/bootstage.h
@@ -435,6 +435,14 @@ static inline uint32_t bootstage_accum(enum bootstage_id id)
 	return 0;
 }
 
+static inline void bootstage_report(void)
+{
+}
+
+static inline void bootstage_fdt_add_report(void)
+{
+}
+
 static inline int bootstage_stash(void *base, int size)
 {
 	return 0;	/* Pretend to succeed */
-- 
2.43.0

