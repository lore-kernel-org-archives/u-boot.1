Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D62C48BF8
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 16:36:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A5BB87F51;
	Mon, 19 Feb 2024 17:35:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="w5HlGgkZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBA8387F22; Mon, 19 Feb 2024 17:32:45 +0100 (CET)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com
 [IPv6:2607:f8b0:4864:20::114a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B5F583CF3
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 17:32:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=3n4LTZQYKBigFEVREWKSSKPI.GSQY-FSSXPMWXW.HIRb.HI@flex--barnas.bounces.google.com
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-607cd6c11d7so63995157b3.0
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 08:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1708360352; x=1708965152; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=O7PUmy+xQ3/8cEPxwAI006xHbvDymz/RHTPdFuXk89Y=;
 b=w5HlGgkZdcmMcTtmJD8e+0aVONfvPXz56NfDuJu7uTj9cHE6U6vDM2NZgXH3EaNABJ
 j51eiqFmt7nOl6ekkKKmSlKd57gH6x0cIa0jNymQXHUHyajrFo5Yd+0jDwWr/padl8GW
 JpbOtdCM0dA6x6LQx5Hf/EyPgKlBkvojMnNYALIO8BIoE+Ma1xAIcs/jProD+Xh72wXL
 dkIEsZhvEHhltbUtcuz4Bt5RRpCZmGsecmd9HJ5pD8bJQKnOQ64voAb4gR+YQT23im1L
 /vxR42dl0U+w6kGvGOmDmqzRvOG6pBjGKp5118YIDbUzzye5jAF+bSBEq+r8sIOFbgwc
 +lgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708360352; x=1708965152;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=O7PUmy+xQ3/8cEPxwAI006xHbvDymz/RHTPdFuXk89Y=;
 b=aBbhunlHOeA0lSFvtNHdg28gszdA6Fb/iLIbSWnbMusNbK9nnNnlZkjV8fpaxpZ6cC
 UgcgMP6KCx2DYBZAfaVhydPAoXjdqXSEcbwq8zgALx2IPeFDn9+D/ICTUHwxCmi4UzD+
 7rXMAAw/EklXPUc93DC7Gx+02ThYfUY7rTGuGu3BensiISU6MMcunR1V9b4FYdGG+XWn
 TWuZC5dDWpO3xoMyaQcrHz9kTGqumFkzCBi1qzm88kcGJVi/4IINW5GdFx2ivafydKfo
 JV+oZAW4UazQQL+rYgGT7sTqpWKaX4QlqsQxqdCwUQ4N0W+rQmVkJ0WVSxQogkN/tyMf
 wT9w==
X-Gm-Message-State: AOJu0YxF7yDab1jrTRzY/J+AsTWD42+PUNt/v8qa4QaW9v5I7LnoeR2I
 DpXs0JuxTcEP+BCPZAwIl3Dkkmgxy4GtlXLU1VL9IcxbV/gQIYyhxk3UpKTtpMbXsb2BATsghmb
 LZomKnwwliaQqkq4O5ifMpt6UZiHQcPBY+V4agdQP77jxQHvdjkdCnfmd1LMR1R6S8CMifuqHpX
 m0qXZgWpDmgH02yrsklvuDeR3VxkihTQ==
X-Google-Smtp-Source: AGHT+IEt+z9kj5a4v9d/6e6UNWRvUxfUuFlHDxY95YyEKOp6HVhYYxKgMmAFR7VGC8i7rV6wLWPO8Ov9IVA=
X-Received: from zombine.c.googlers.com
 ([fda3:e722:ac3:cc00:68:949d:c0a8:7f3e])
 (user=barnas job=sendgmr) by 2002:a05:6902:1001:b0:dcc:79ab:e522 with SMTP id
 w1-20020a056902100100b00dcc79abe522mr515037ybt.11.1708360351892; Mon, 19 Feb
 2024 08:32:31 -0800 (PST)
Date: Mon, 19 Feb 2024 16:32:02 +0000
In-Reply-To: <20240219163213.855667-1-barnas@google.com>
Mime-Version: 1.0
References: <20240219163213.855667-1-barnas@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240219163213.855667-2-barnas@google.com>
Subject: [PATCH 1/3] misc: atsha204a: remove broken for loop
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

Some previous commit changed the continue statement to return,
making the for loop used to retry waking up the chip to always
return after one iteration. This commit removes the loop, cleaning
the code a little.

Signed-off-by: Micha=C5=82 Barna=C5=9B <barnas@google.com>
---

 drivers/misc/atsha204a-i2c.c | 45 +++++++++++++++---------------------
 1 file changed, 19 insertions(+), 26 deletions(-)

diff --git a/drivers/misc/atsha204a-i2c.c b/drivers/misc/atsha204a-i2c.c
index d3c515828f..ab83bbc3e9 100644
--- a/drivers/misc/atsha204a-i2c.c
+++ b/drivers/misc/atsha204a-i2c.c
@@ -96,40 +96,33 @@ int atsha204a_wakeup(struct udevice *dev)
 {
 	u8 req[4];
 	struct atsha204a_resp resp;
-	int try, res;
+	int res;
=20
 	debug("Waking up ATSHA204A\n");
=20
-	for (try =3D 1; try <=3D 10; ++try) {
-		debug("Try %i... ", try);
-
-		/*
-		 * The device ignores any levels or transitions on the SCL pin
-		 * when the device is idle, asleep or during waking up.
-		 * Don't check for error when waking up the device.
-		 */
-		memset(req, 0, 4);
-		atsha204a_send(dev, req, 4);
+	/*
+	 * The device ignores any levels or transitions on the SCL pin
+	 * when the device is idle, asleep or during waking up.
+	 * Don't check for error when waking up the device.
+	 */
+	memset(req, 0, 4);
+	atsha204a_send(dev, req, 4);
=20
-		udelay(ATSHA204A_TWLO_US + ATSHA204A_TWHI_US);
+	udelay(ATSHA204A_TWLO_US + ATSHA204A_TWHI_US);
=20
-		res =3D atsha204a_recv_resp(dev, &resp);
-		if (res) {
-			debug("failed on receiving response, ending\n");
-			return res;
-		}
-
-		if (resp.code !=3D ATSHA204A_STATUS_AFTER_WAKE) {
-			debug ("failed (responce code =3D %02x), ending\n",
-			       resp.code);
-			return -EBADMSG;
-		}
+	res =3D atsha204a_recv_resp(dev, &resp);
+	if (res) {
+		debug("failed on receiving response, ending\n");
+		return res;
+	}
=20
-		debug("success\n");
-		return 0;
+	if (resp.code !=3D ATSHA204A_STATUS_AFTER_WAKE) {
+		debug("failed (response code =3D %02x), ending\n", resp.code);
+		return -EBADMSG;
 	}
=20
-	return -ETIMEDOUT;
+	debug("success\n");
+	return 0;
 }
=20
 int atsha204a_idle(struct udevice *dev)
--=20
2.44.0.rc0.258.g7320e95886-goog

