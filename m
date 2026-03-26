Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FFE310AB82C
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 23:01:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB99884020;
	Fri, 27 Mar 2026 00:00:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RdDZ+29R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7043C80517; Fri, 27 Mar 2026 00:00:32 +0100 (CET)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16D7783FA7
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 00:00:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-40946982a78so579841fac.2
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 16:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774566022; x=1775170822;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6WQ+Hu3duV0r/JrmC11ZGMAtoUahx+16J7Jx/wqz88w=;
 b=RdDZ+29RUWYst5ErHR8bQBfdV4p0er2GbBQ2u44HOxYtngLa6eQrbObWxUU7a4fURh
 WvKwxkKbRttcJXYU2vKvUXXCIXe8zCzqBoB77BETFXcgWJek7pejvUj8K1zVglJ1Oogl
 /W8Q0Ce50dXYgyxP4eNrw7DOaMAOMJ4BbKqOplJhmTZqVuwqShelOBBcZWoXcxcb1+vO
 19mgCYVvpPucuSQouXb3FGymHpuSX/nkvQQVXWQdS3Jm8TVk+TeQ3ehTnTNftpJHM/jE
 z5efBoRYCEumS/eUOkFfWXbNpdjVT0GTC6tStITVQCZ5hOW84WmnkQDqfcJyjD4YQX72
 M4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774566022; x=1775170822;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6WQ+Hu3duV0r/JrmC11ZGMAtoUahx+16J7Jx/wqz88w=;
 b=BwHGK+1MNFA8U/CHE3kRFgRkp8pLhKJhpcz2HwhXIUGaD/hXsXlqPkT7ZgWxdGxmoD
 jNNbKgdg54+yUH2dc/j5nM86ZWOpk4W8xe4oYyc7EmsSuuft7IG+VyW6HeA5BaP1Jf/7
 6KVyIMMTrutacB/ZynNPHiHCp+1yTDnW9E6d0cHlz6LixXUwaY+xXurh2yS60M9RZFHG
 LkmC/wJN8tU2GIPvU2U3Rg9A3LcT/n1bu5v/vdwUaDDeC69NSoTqmw37tsMTLqUVKfky
 YeyJW2313qKtjGQg6wp8MGEDODt/1YMabOYMLdcuzeqpWVjPwso7rowZcAR1ddW1okxH
 RX0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVi5I2eVbPWSnxp8R0U2DynypC5Tw+FuoCPoCh2vnaXt0epGhIQt5oSeTUS8IQkt6K1oiro1QM=@lists.denx.de
X-Gm-Message-State: AOJu0YySIR8uNJrrU6YImOIqnlfGhj+lyfLB3RytgR/pxNyiRiCmj6nA
 eOXzD/oppu7Jue2JwjktFi2VWKR6tzb7ohmDOQ3zfqi9FspyW+BhZ6dnRouzEerb7Dg=
X-Gm-Gg: ATEYQzz39fJ/U0SHNKuUzSCDvGfkB5KML2lwiMaIVh7dqh5OxsD37b8cPKRPCvaVWxB
 rd8+GqRwBFxWuW0KCja40pH9bA8TN3e5+0nmiQnYcKvM2nhVfBiJflF6rCVAD0JarJxcG9jsuoh
 ouTFqRPzgTQMtL8+l3AQF5iovxpsQG/YPVN/4CXQ7Q7Ec/reKYmJKrNfnkk9MlMYslaaR/LMA+N
 nsau4iBbk2BEjhP2YlN3Fqvvf8lqboDKk8gnARP4TyDG4stCYF3snXLmF/HuiXVQMY2zt1y+ra0
 dU9WLkSiLItyC1qFgMz6oEp/hagaIovXfdORaUZUTJmxrG41SShKsO6mamCyEQz3sfvUp2Gxjm8
 fZa60h9KTJu6+vyBKVz2cPUfSwujIZ57H7KveD6R7UF/c/Gn6OnvHVf8paU0xrEVyeBBaiyKehj
 l9+ElgLypSOdKQu6iRvdPrZwetM1ki
X-Received: by 2002:a05:6870:808f:b0:41c:305b:14e1 with SMTP id
 586e51a60fabf-41cec29b160mr76239fac.28.1774566021853; 
 Thu, 26 Mar 2026 16:00:21 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:54a7:4cbc:7d2e:3b99])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41ccb6b1d25sm2742836fac.16.2026.03.26.16.00.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 16:00:21 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 26 Mar 2026 17:59:26 -0500
Subject: [PATCH 4/6] scsi: move scsi_scan() call out of scsi_get_blk_by_uuid()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-env-scsi-hw-part-support-v1-4-55c9dd07a2cb@baylibre.com>
References: <20260326-env-scsi-hw-part-support-v1-0-55c9dd07a2cb@baylibre.com>
In-Reply-To: <20260326-env-scsi-hw-part-support-v1-0-55c9dd07a2cb@baylibre.com>
To: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2107; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=fifEeCAc8l7cFnBsdsn/SvRWgii4bPZn2Kb4Oi0Gj9E=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpxbprkDT/zrHNkhCpjjMbOZunXknLwj/Y9CRV1
 iS6r9JWSV6JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCacW6axYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AtqIIAIJzidAuHVjIuJryUX1YDK01lvRsOQT3wczBvKq
 1yv64civcRH1x9g4NYEwH75Yn2E8/JRfmeAI0aYJkpEAFoZzwTfdTJXAYzLYcUcxx42QYcM6hY9
 adZIqhtMR9h8u/LOaIBw65TU9tahNIlba7Y10Mq3/1OpVvSx7OWe++YXgkDqOOV94SKcDaLoqgP
 B6M4MivR6tNvWOF23DOCzg/pZXuPij2AAR9404sHijb1D1uLHcbGw1rGsli0isnuzMzNxJ34OGC
 PxqAl/ZELqsKpPbiCVlqSvxCpjGm/l+G96wIjwNm0umpnVaVJK2h4m+QtHIUiEUTuFZUZqrojtW
 4HwQ=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Move scsi_scan() call out of scsi_get_blk_by_uuid().

The only caller, env_scsi_get_part(), should be managing this call since
it may also want to use different ways to get the partition information
in the future.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/scsi/scsi-uclass.c | 6 ------
 env/scsi.c                 | 6 ++++++
 include/scsi.h             | 2 ++
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/scsi-uclass.c b/drivers/scsi/scsi-uclass.c
index e7870d7f831..39b4c7476d4 100644
--- a/drivers/scsi/scsi-uclass.c
+++ b/drivers/scsi/scsi-uclass.c
@@ -29,15 +29,9 @@ int scsi_get_blk_by_uuid(const char *uuid,
 			 struct blk_desc **blk_desc_ptr,
 			 struct disk_partition *part_info_ptr)
 {
-	static int is_scsi_scanned;
 	struct blk_desc *blk;
 	int i, ret;
 
-	if (!is_scsi_scanned) {
-		scsi_scan(false /* no verbose */);
-		is_scsi_scanned = 1;
-	}
-
 	for (i = 0; i < blk_find_max_devnum(UCLASS_SCSI) + 1; i++) {
 		ret = blk_get_desc(UCLASS_SCSI, i, &blk);
 		if (ret)
diff --git a/env/scsi.c b/env/scsi.c
index f376f731870..1787dcca92a 100644
--- a/env/scsi.c
+++ b/env/scsi.c
@@ -33,8 +33,14 @@ static struct env_scsi_info env_part;
 
 static inline struct env_scsi_info *env_scsi_get_part(void)
 {
+	static bool is_scsi_scanned;
 	struct env_scsi_info *ep = &env_part;
 
+	if (!is_scsi_scanned) {
+		scsi_scan(false /* no verbose */);
+		is_scsi_scanned = true;
+	}
+
 	if (scsi_get_blk_by_uuid(CONFIG_ENV_SCSI_PART_UUID, &ep->blk, &ep->part))
 		return NULL;
 
diff --git a/include/scsi.h b/include/scsi.h
index c244120c283..2520a8b8fe6 100644
--- a/include/scsi.h
+++ b/include/scsi.h
@@ -356,6 +356,8 @@ int scsi_scan_dev(struct udevice *dev, bool verbose);
 /**
  * scsi_get_blk_by_uuid() - Provides SCSI partition information.
  *
+ * scsi_scan() must have been called before calling this function.
+ *
  * @uuid:		UUID of the partition for fetching its info
  * @blk_desc_ptr:	Provides the blk descriptor
  * @part_info_ptr:	Provides partition info

-- 
2.43.0

