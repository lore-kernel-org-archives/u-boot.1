Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6AB6C48BF8
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 16:37:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B65AB87F57;
	Mon, 19 Feb 2024 17:35:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="mIaAfVKf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A060783CF3; Mon, 19 Feb 2024 17:32:46 +0100 (CET)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com
 [IPv6:2607:f8b0:4864:20::114a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9E01874B1
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 17:32:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=3poLTZQYKBi8MLcYLdRZZRWP.NZXf-MZZeWTded.OPYi.OP@flex--barnas.bounces.google.com
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-60761bdbd4cso82089727b3.3
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 08:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1708360358; x=1708965158; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=/qu+M7VTGiGaeSLYLihyK8S/nXk79S+1zY7hDGlK8Ik=;
 b=mIaAfVKfTqxf7o336WOvlOPoipPfoo4uOxd9nnWKVEY1C0NxUD5yxwuo3EeORsSreb
 p4Eu+4O1/veMXCceb/uRUxRYytjy7Pm56F2F8HgZomKOE3jY6dseLWjdXWo8wj9NJZfU
 PEN4cWgybzvS6IpZNxuqu1vuTquuNTZu9EXnDiKRc3fRp4xY+pg9Afqq/5Fasu2AAKwA
 lIqOyA5uQavTh7SeoIYZnm9Es2y/G+dYKL5QYHydo/yT8a+W7tgwCR95j7qR6Q+jrxdW
 LCz+ZFJmajfHeWfhaaXkDp3ldu7Ix0oF7Dag9DVDoqxN0+6VHQKTaIBv1ibw1OBhDLoi
 A7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708360358; x=1708965158;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=/qu+M7VTGiGaeSLYLihyK8S/nXk79S+1zY7hDGlK8Ik=;
 b=TeyLPIEG2RuQWfPHbPMkVjatEgEdL8UclmhL0i5pVZ6VE6sUnYnfdQqm4lVmsi9c7B
 L+zUk5IkSWZHruj+X2kdGhuGteeamrBhF+hTw4k+5GkvS6oRr9P+w5WczU4r7dB/bDn0
 aIWRDDfMorZoKsriXJQwYR+9D8CuKJgVVIHA2+xnEF2gI56FuGrydu/okXTJAE2JjHcg
 NQUzXaxgSZTkpW1DXJhGKTGGVcJnUuGJ03WkoMCUfd0tDQHvsUWEYg3YbYZH6bn5i5jQ
 jgWtZXJ0taiK1HQg3gRQVA7K2KdvAAwGSQDOo6Logn9LWhq2x0B/Dl9yMtCWStP31Ojo
 Ngkg==
X-Gm-Message-State: AOJu0YxAhQZvyaPUEB+6S13zNK0sHNcpcjYsFPZ6Ov/d3EcqqqwSsSCM
 egVK12Jd+g2ydbWsEOcoG81DE7mFKX6oz7+DMbppNfrB+YojTpR7TscZ0APf3uf7GXt+EblNWdS
 OmTvqRTaxiUK61dt4duD+l/fatj9l3yuR5zdjpTmIllrnwLgt3Q34O7UI5IvTmPE/tc5xQAOrUR
 9c/A31htYV91wSi34ZMzs5pyY4eN0/ZA==
X-Google-Smtp-Source: AGHT+IETLJsqQX5no/SBOLqadEe91uq0pqnMRcEkBvxQGGY1FtPZwJ/spnBt30lOnWLed6qUEbpijuEKsE8=
X-Received: from zombine.c.googlers.com
 ([fda3:e722:ac3:cc00:68:949d:c0a8:7f3e])
 (user=barnas job=sendgmr) by 2002:a05:6902:100b:b0:dcc:c57c:8873 with SMTP id
 w11-20020a056902100b00b00dccc57c8873mr3738004ybt.9.1708360358492; Mon, 19 Feb
 2024 08:32:38 -0800 (PST)
Date: Mon, 19 Feb 2024 16:32:03 +0000
In-Reply-To: <20240219163213.855667-1-barnas@google.com>
Mime-Version: 1.0
References: <20240219163213.855667-1-barnas@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240219163213.855667-3-barnas@google.com>
Subject: [PATCH 2/3] misc: atsha204a: fix sleep function
From: "=?UTF-8?q?Micha=C5=82=20Barna=C5=9B?=" <barnas@google.com>
To: u-boot@lists.denx.de
Cc: "=?UTF-8?q?Micha=C5=82=20Barna=C5=9B?=" <barnas@google.com>,
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 19 Feb 2024 17:35:44 +0100
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

Fix the sleep function to issue the sleep command instead of idle one.

Signed-off-by: Micha=C5=82 Barna=C5=9B <barnas@google.com>
---

 drivers/misc/atsha204a-i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/atsha204a-i2c.c b/drivers/misc/atsha204a-i2c.c
index ab83bbc3e9..29daefb2a5 100644
--- a/drivers/misc/atsha204a-i2c.c
+++ b/drivers/misc/atsha204a-i2c.c
@@ -139,7 +139,7 @@ int atsha204a_idle(struct udevice *dev)
 int atsha204a_sleep(struct udevice *dev)
 {
 	int res;
-	u8 req =3D ATSHA204A_FUNC_IDLE;
+	u8 req =3D ATSHA204A_FUNC_SLEEP;
=20
 	res =3D atsha204a_send(dev, &req, 1);
 	if (res)
--=20
2.44.0.rc0.258.g7320e95886-goog

