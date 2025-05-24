Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B91C54FC6
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 14:13:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D875782F67;
	Sat, 24 May 2025 16:13:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ci3ZFYYT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA3DA83082; Sat, 24 May 2025 16:13:55 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A99F382AE2
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 16:13:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-85e46f5c50fso78434639f.3
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 07:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748096032; x=1748700832; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6mRJvoRqaSfvfKhGio5gXq13We+T9BeWSENItwW6FZ0=;
 b=Ci3ZFYYTsjHs0uy79vkqqb1J+7sY4nBJi47CXBF2tyxgTW7IG5/Ari86cPKvPj4D6a
 U7HHwcFPoktrwR0jSyCPilyvnmsHrs2uNRoYeW2SY86yvTew7NBLZZA8hvV7dtk1ubDY
 BxrPrxgJtXXjFLG85lIkE9Z4liRlenz2MJxz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748096032; x=1748700832;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6mRJvoRqaSfvfKhGio5gXq13We+T9BeWSENItwW6FZ0=;
 b=QrUBxCPfY+E1WpJczcgHD3skGHOqSYnhv9bAExdqV6DuwEJeBvVMVoYR1pLiefBZdN
 sNpGAt8mvbu34qwCIQcku3ufxClzGzL+n1iP6YccgpPLst70BkCHtwZNCUeb4yQ3yS9r
 rDbcjvkmu2QSBBlrnzeSFRlc+U8i6WlcIMxVyKkIf3Xix57slvloAjl/0t6WOW2tlKtT
 naJ2vuxvpaIe2msnYdXCAtMwNOzuF+Ry/c9ZYxrFgsEOnfYCa4/uI8Iu8xHXIYhE121X
 JuhpvRDF4UcZbJaHh3kK1os0YeaQPIMPiFxlffzToxuWeAswlRmMNJ7g3xKzJB2Mtnan
 5S5A==
X-Gm-Message-State: AOJu0YwE9+r+rkezwCUECTSpfv55R5UGu+1zUgYG27Pg08npJITAP9fL
 shBUI/hHj+TmAM+kuWK1a7RRsbjU+Dy+QkvkLvkfYg5XcpXijbj5QP7Oc6qF894iFxAu7lvwxxN
 JSEro/ltC
X-Gm-Gg: ASbGncspQi8Ml4n5W74bapKRUOtc8DwfnH17/3xEZ55AD0Q3trJE7uHzZhfn8lx08IN
 0JBhL8R1C8aIH61EfMxC1Kq2Erz659S6yLAOnEbc7bsPGoR76ZQpOCHtSNatY1palWtnWbNotLG
 +n/5Fbwavf1UAWz1xJx3AkCMBDOGvn53EV5pcQC9qX7rneJLJ1sbNgA0y5GaoN1a9tF71LQGqMu
 LYT09o0xuPNL3pIMLJFfg165OaIfHh90R2jRoxRN9QTINWZXJ3PfnFxivvlKIJUpb4g15ugt/nE
 1ornUin7l2QhZFvrl7A6Mf9LhDDbmN8Y07qarLl5I/r7Mqz2jfqzrgqqBKf7vTXQ3llNnxwHUAL
 Tmfxwffno3dHqvuHQqodksCA=
X-Google-Smtp-Source: AGHT+IG5gZxsLO1TxhXXVW0jDLAQrOvZy4HlJvIlJ3Nw0ddkswIxRsZbrEwdsXKd8y6SUWCbekrL3Q==
X-Received: by 2002:a05:6e02:1606:b0:3dc:87b5:2ca6 with SMTP id
 e9e14a558f8ab-3dc9b6d3abcmr25369485ab.7.1748096031818; 
 Sat, 24 May 2025 07:13:51 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3dc63c1bd8bsm34615685ab.38.2025.05.24.07.13.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 07:13:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] tpm: Export the function to set up the TPM log
Date: Sat, 24 May 2025 08:13:46 -0600
Message-ID: <20250524141348.965322-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
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

In some cases, we may wish to set up the TPM log under full control of
a driver in U-Boot. Export the required function to make this possible.

This avoids calling the weak function tcg2_platform_get_log() when the
caller already knows where the log is.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/tpm_tcg2.h | 9 +++++++++
 lib/tpm_tcg2.c     | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/tpm_tcg2.h b/include/tpm_tcg2.h
index eb6afe49e77..189a93ee840 100644
--- a/include/tpm_tcg2.h
+++ b/include/tpm_tcg2.h
@@ -345,4 +345,13 @@ void tcg2_platform_startup_error(struct udevice *dev, int rc);
  */
 u32 tcg2_algorithm_to_mask(enum tpm2_algorithms);
 
+/**
+ * tcg2_log_init() - Set up the elog
+ *
+ * @dev: TPM device, used to find the number of PCRs
+ * @elog	Platform event log
+ * Return: zero on success, negative errno otherwise
+ */
+int tcg2_log_init(struct udevice *dev, struct tcg2_event_log *elog);
+
 #endif /* __TPM_TCG_V2_H */
diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
index c314b401d0b..9909d9e14d5 100644
--- a/lib/tpm_tcg2.c
+++ b/lib/tpm_tcg2.c
@@ -220,7 +220,7 @@ static int tcg2_log_append_check(struct tcg2_event_log *elog, u32 pcr_index,
 	return 0;
 }
 
-static int tcg2_log_init(struct udevice *dev, struct tcg2_event_log *elog)
+int tcg2_log_init(struct udevice *dev, struct tcg2_event_log *elog)
 {
 	struct tpm_chip_priv *priv = dev_get_uclass_priv(dev);
 	struct tcg_efi_spec_id_event *ev;
-- 
2.43.0

base-commit: bab54f5942c428be698216224fd10b91d974d4da
branch: tpma
