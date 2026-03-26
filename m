Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B1210AB82C
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 23:00:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62231838BB;
	Fri, 27 Mar 2026 00:00:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XPSg0ELG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C878783FAF; Fri, 27 Mar 2026 00:00:26 +0100 (CET)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74F9683F14
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 00:00:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-40438e0cba6so966293fac.1
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 16:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774566021; x=1775170821;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GKmlXLxbMfQwtK0s7gQqz09EPgGB5Qp7/8l8MLvMeVY=;
 b=XPSg0ELGvqHs+079vdIJPJDqf34EB+ClRjxAHCjGGlD+dDRfYHkfR4AruAqqa1A7Bl
 //tRz2WzxF5Y55/+xkZyGpClv0Kka1Veo8aM2/Q8adfY9mCp2F5rDKCuD0PfS81qyrW7
 6GJyFPefkf2hopA849RCmMnGNMbt4pjshhMwfOG0tou3TlCX5rMzgCFHnXvKlcD9f3Rg
 KzupJXylIl2xDA1GcOYq8gFkO/eHINT0aidl24sQDoPjvQWixrhx+ypV5lnl3auXjtuI
 8/V73sSGMWVKHR6E1XUr0rYlxS47WKaOoa+cEK2vQFpo70E03sNgV9j11lWxTKH15/EB
 fqnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774566021; x=1775170821;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GKmlXLxbMfQwtK0s7gQqz09EPgGB5Qp7/8l8MLvMeVY=;
 b=sYCx6Ry6KQk08EHuUDyttyRF+c09fMWNRawX/rL+2h364gmJR8V2gEitNOzvhageu2
 6uQLvASwaACCoj8JoaESn6z8gHbRqk7eTdn8nB+2y9PcUD2l/wUKB31Ukrbqh4lIC1V9
 fIXpHLzcxdkvL1qnyye12BMemmB9YdRPIbxF55ZHizqrpsARV58JO/VQDhl/RBcOe81U
 QvVUCwLr+duPRKK9ACjZXI7qmDO1yHP3LY/I7HiydW8PRXpGgjZvapSRyb2G9Q7XSLCB
 detaN1oRoTkVuKIw7JKuKoGN3zN+hgmsHMV3s9yj5GW6sZyVU8LRVtP2epdqGE1nwXYL
 yf1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUaJ9kBSMxT93/KXBWnPrCmLQ4wvi9XGp/VM7i7Wx2ZTuviyFt4mHW9Jg0m38SZKyD6BQk9Po=@lists.denx.de
X-Gm-Message-State: AOJu0YzNgs/12IfvivMX6+WajKvkp0MSNB3daa9sV8S3PcuuMDQHQ9cM
 8g2HGiRkBTxnkUCTv0S7rXTrfXtqHuZpk72tKbxRdnXNh/dfeJ1JcBCUbEmkjPViGpI=
X-Gm-Gg: ATEYQzwBDdL2RabAc1yTW9NkqENl5UaQgRpfvb4PHGNrGhVWZM80r0OErFEdPKnFOtO
 bPX0Yk+4b5BpiITOEb24Zsp/PPaJAoFoRZ2nC/sJ9Pm46i6xHCnoDaryRfJ2J45/pKp1lQ+PDG2
 1vYaQ9K4QFKvBOtMCtFgRQfv18+VPCYlrPjY98Q8RXXu0PR0PbAFXCH5K8V1nx3GIWSDjQE9Nux
 B1mua/mu91XFWbggAQ/SnKr74R3l7e5jlF0ScgbKoPf+2UyvqJSzl+lshuYdw5UdS16UqVb9bp+
 dPyZ5huYJK3lCulPX6+/VZeKVhiTVT5Tiz06htszGOba/eCZCLZcigIY4nW/IJbclH054gomZEd
 hhPDjvP6JBS9w1gmJ3u0hwX5loZecT5kf0ihn5Nc+2Gh3vEFVlKk99AbbIE5O0N0IskWwk/T3Ns
 KIQaZLxSFQs4eslWCTY6v8t/j5+eQ0
X-Received: by 2002:a05:6871:a84a:b0:41c:e8ab:e008 with SMTP id
 586e51a60fabf-41cec3d6f5fmr75138fac.49.1774566020955; 
 Thu, 26 Mar 2026 16:00:20 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:54a7:4cbc:7d2e:3b99])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41ccb6b1d25sm2742836fac.16.2026.03.26.16.00.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 16:00:20 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 26 Mar 2026 17:59:25 -0500
Subject: [PATCH 3/6] scsi: document return values of public functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-env-scsi-hw-part-support-v1-3-55c9dd07a2cb@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1251; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=us8TXyySa7UFnlCKyCatnihXC9uI1wOizbztgoSpSa8=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpxbpjloF2Vwvkx+mMWqD+7wwDCre6rgneI/jvP
 5waelPds2iJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCacW6YxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AO88H/0wKewFHwUDsmlnDB8h6xUOgVhmtT9BhEJzXHav
 EJiVM93n+NZeizD6COHrAY80mEPuu/ZYCg8FbJwGZsRaouiIUyVtuIREdvZjWn2mr8/9g2azvO1
 T0LIufDXsag3DtCXZzmBz2JaK9MlfvJ5qeR8E0FiuQdsF31iuQSrYKtg9VkOxySEClnl9cVW/0z
 uLtkymGe69SignnL3AqROmqsm977BgkRR9paQ3utLiKvdIv4Df7njXZkLgurXpqLuPugbvkktaL
 qooi63nhLEhbv2B2Sb7NtFZHYSHuKCvvKh2it7hJFqj6k6/8Seq517A0D7QATFp/La0fj69bUE0
 ue+A=
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

Add Return: documentation for some public functions in scsi.h that were
missing it.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 include/scsi.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/scsi.h b/include/scsi.h
index 8d6c5116419..c244120c283 100644
--- a/include/scsi.h
+++ b/include/scsi.h
@@ -340,6 +340,7 @@ int scsi_bus_reset(struct udevice *dev);
  * scsi_scan() - Scan all SCSI controllers for available devices
  *
  * @vebose: true to show information about each device found
+ * Return: 0 if OK, -ve on error
  */
 int scsi_scan(bool verbose);
 
@@ -348,6 +349,7 @@ int scsi_scan(bool verbose);
  *
  * @dev:	SCSI bus
  * @verbose:	true to show information about each device found
+ * Return: 0 if OK, -ve on error
  */
 int scsi_scan_dev(struct udevice *dev, bool verbose);
 
@@ -357,6 +359,7 @@ int scsi_scan_dev(struct udevice *dev, bool verbose);
  * @uuid:		UUID of the partition for fetching its info
  * @blk_desc_ptr:	Provides the blk descriptor
  * @part_info_ptr:	Provides partition info
+ * Return: 0 if OK, -ve on error
  */
 int scsi_get_blk_by_uuid(const char *uuid, struct blk_desc **blk_desc_ptr,
 			 struct disk_partition *part_info_ptr);

-- 
2.43.0

