Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D619C61DB9
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 16:03:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 48BD580D6A;
	Tue, 25 Aug 2026 16:03:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cLYwsuKP8U5E; Tue, 25 Aug 2026 16:03:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787673824;
	bh=K5QZCoHNfckhfD4Zj2syAk30bLVnzhuZ4pqaf264Lyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uDa+Jvit2WsFWA2u6JejK0PXeNxay1Qn6eEKUmP4znJDAVy2g7cAlHXsHi3KZTknp
	 PFjneCvV1gDjVagr0ncs5RJ3gwghHHmkHqV9Qyqh5YB29fiAvX/p3tnfWLF/kWFiaO
	 iyU2zlEZZsB6aEOmgO/I3nV9YoskkOrmP56YToq3FDcO7z2u2TwLJ4G4fYzywv0obZ
	 xcWW1qPXJMVc8EMuF6dtpHX2BDpwgyC4bdrk864qi8XMiHsZsopdIHcffvh9NlAkWW
	 P82hDNH2T8ZQb3kWqEbIv0PvBXvxvsxxBq3s2IekY1F7/b+Nrs9twRJSFnl9nNDUuG
	 qe4rTbBQMC27A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 844F680D63;
	Tue, 25 Aug 2026 16:03:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 28EB62FD
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 14:20:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 272F0400F9
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 14:20:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0EeYpGCflZRl for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 14:20:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=pranavkasthuri@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=sp9haCqn
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4419B40092
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 14:20:04 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4956242332dso39093685e9.2
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 07:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787667603; x=1788272403;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K5QZCoHNfckhfD4Zj2syAk30bLVnzhuZ4pqaf264Lyw=;
 b=sp9haCqnkGHmiVFyYAJKjTUDMitVAh7uykpDx2qyGivSaPwWbrt3JFGLYy0rHudzQe
 WNAggvS9E6fv8lmV8gPkTzQ2ZaasBJmFUEcv+pyqDmnO+1x32KEpNCP0ftb5VnzbhSqI
 VAYFUN1KRElCHsdn6O7TkPs1LtcIAVYPc/5I86PeO+qK1BzF3Uf5vsMYeYqut4mEHEyw
 1GVXPa53/NshsF9TEiqRrO/3d6JudKm30uCrEs5UxbaNEjKXS4HuItC2xNqhFq7Mu3ID
 Bj2+lUvRsruUc6lFnUYiVbyPJPRKT0NkaO2V7+ivMIQklf+6m3zRZychqT3H6VI0nDy9
 kfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787667603; x=1788272403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=K5QZCoHNfckhfD4Zj2syAk30bLVnzhuZ4pqaf264Lyw=;
 b=qDSmOqhbfS6nLTVjk2YUfflb6AduAOW80r0+Atsx1KafC5q/YvrcVy9tXXzb18h2y7
 kovPVQvWBTO9FUrlxCTOfhNQtlBiOJ9lh/GYkbeU2E3KzNxwUY+DD0r4Thjw/793w0bC
 T+ufz5GyyLN3tektwxEpKWMdb6FuQXAHahuGxB17w/7UGo6wsoNQSXdjbhmjBRGghEDl
 DNBcp9/SomoivhF2USgMJeUvQu/rhqETFSfpUtdmEHO4eAOh7Z82vVCsE1YKKv6flvN5
 ESEzd8oRvvonkR6HzhgHzBL+yMO+ScPGIDspxRoO7QrZzQLJkfpP17/EG1EyXNpFEh9N
 8dcg==
X-Gm-Message-State: AFuF++lpd5KnlFBTC5zrIiTu8nssexyMYyYtxLbOk6kf6ddd674s/cMH
 QI4jiHHq0BrzzHBM7XvOgAdjE7FarjRI/AVbLDf8/nOD4lQHsOOCQxw40NvpUNoDGIc=
X-Gm-Gg: AR+sD12DwHF2TytMJthc2QlzM9YIxYELvYk6WI+NSRIf4YC8RXzuihPDp/NRxOepK9D
 irZwn484SPHQbRgzak3TNHS+PcVQKgUzFOIQ3ClKwYLEzCM8/nv9/0Qr07lM5ZcgayfgeMV4AxF
 /oZiZryv5Q7mymfRQGk1ZQm8YNXU0taCYS21yOIz9Pha7gx3jJQkx38oPCidLiSsKbfl29CVAjv
 BFMuw/GBkRvi9OhLGDQOsPl19W19PAC2+856me5pa4lLBYNgjhl/BDzAw2CQCMymaGKW+RFuow3
 SIpbqvF3uI9dEi3LQs8MAlH2fUyjIKOPMqV4kb5KUG/Rhh6WrjhW8AJP7Lcl2YNPHabBAERaPme
 HHpPC96oTXf5O9GXGbQCxb9V0Y8zNuS6AseWjCdzAEmPBrqRyetmtRlK/QGsvAFp5ycPTl6xZ+v
 GJPvlh75mLqeFl3ViY/nSBXyG7XOIBQAS9ofk79wpVgw+1SH2+op1N8y9sU90NHE4J4HWWY0F0Y
 nZU47muzjtjgk6TZa49Po/TvhQfa5DN93u/m8zMvKNjL9jvP24vUgAy4MxvmUd50+gvXYrEriYV
 0op0WO7A14ZZjKukVoRm24+/94jsmOdXCaQF
X-Received: by 2002:a05:600c:c170:b0:499:8ba4:8cae with SMTP id
 5b1f17b1804b1-499d64d7824mr89027125e9.1.1787667602429; 
 Tue, 25 Aug 2026 07:20:02 -0700 (PDT)
Received: from Mac (default-188-240-185-161.interdsl.co.uk. [188.240.185.161])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482c9b69d7dsm11745871f8f.4.2026.08.25.07.20.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Aug 2026 07:20:02 -0700 (PDT)
From: Pranav Rajendran <pranavkasthuri@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org, philippe.reynes@softathome.com,
 Pranav Rajendran <pranavkasthuri@gmail.com>
Subject: [PATCH v2 2/5] image-fit: check the length of the
 data-size-unciphered property
Date: Tue, 25 Aug 2026 15:19:50 +0100
Message-ID: <20260825141953.9534-3-pranavkasthuri@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260825141953.9534-1-pranavkasthuri@gmail.com>
References: <20260815220754.11724-1-pranavkasthuri@gmail.com>
 <20260825141953.9534-1-pranavkasthuri@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 25 Aug 2026 16:03:37 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

fit_image_get_data_size_unciphered() passes NULL as fdt_getprop()'s
length argument, so it accepts a 'data-size-unciphered' property of any
size and then dereferences the first four bytes of it. A property
shorter than that is read past its end, and the bytes that follow it in
the FIT are returned to the caller as the unciphered size.

Ask for the length and require it to be exactly one fdt32_t, as the
binding describes.

Fixes: 4df3578119b0 ("u-boot: fit: add support to decrypt fit with aes")
Signed-off-by: Pranav Rajendran <pranavkasthuri@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v2:
- Document the new -EINVAL return in the kernel-doc block above the
  function, per Simon's review comment.

 boot/image-fit.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index ef90c5abd18..872d71d2faf 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -1035,16 +1035,21 @@ int fit_image_get_data_size(const void *fit, int noffset, int *data_size)
  * returns:
  *     0, on success
  *     -ENOENT if the property could not be found
+ *     -EINVAL if the property is not exactly one fdt32_t long
  */
 int fit_image_get_data_size_unciphered(const void *fit, int noffset,
 				       size_t *data_size)
 {
 	const fdt32_t *val;
+	int len;
 
-	val = fdt_getprop(fit, noffset, "data-size-unciphered", NULL);
+	val = fdt_getprop(fit, noffset, "data-size-unciphered", &len);
 	if (!val)
 		return -ENOENT;
 
+	if (len != sizeof(*val))
+		return -EINVAL;
+
 	*data_size = (size_t)fdt32_to_cpu(*val);
 
 	return 0;
-- 
2.50.1 (Apple Git-155)

