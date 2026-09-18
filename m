Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 608D2C982D9
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 11:05:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0FBC040B6A;
	Fri, 18 Sep 2026 11:05:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z8Y8PIjxEBoN; Fri, 18 Sep 2026 11:05:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1FE1440B5E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789729510;
	b=a/TN88gp+r9r/0Z/M5qMxKDBqIYNaNJ+aAyRNoz5rXsFRBaWvMvepK1nV1nuRSJn2f4w
	 WHrMUM1ROisksFl+hYX+jQZjNAZReKV1+zivyqP8T+rsNk+BYstBVR9ugb7USh5yObxxr
	 CPt0drzpKPvRhj0o93D2Dh6qMfCIj55lv96HZTdCRwxkeeSv8sse8ULWX8ZkY+zI3/y7e
	 BdNtRalfPFEbz8syFuoFQ+dLngYmo6YWdPYrGsGoxqcW4/a6s6htlU77HWC6bFT9xFQyX
	 Ddbn4ip86ntpxnptC8gc2tUeC4KMUyZehnwpNCvlLiHauBO47AnDTol2LmgXvfZS3RA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789729510;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=5snXmwV64jYIOwvYRMvXmIrcVO7e5vm5GcsOdam73ZU=;
	b=KM+7lehqO2UBnYg07+7vCJcA0M5xX7e1dhugnSk6pRLXQ9k06JNEVvfAcYUSAg60ixz7
	 WyDMBSZvkcoPOExa7q81Li4HYGU6pQLIvPsba9wfOcFAzdsb8+Xi5C1ZLCdUrN8F16GO4
	 AWFKcbXZXJCPuwiLHk3MaasZUvfrLuXo2toLLqd0ikEhQ+PxvWSjFv98kHvEUq9vwHg/4
	 82J7B2WwXoBIETpSzHzyPZIIff7ln55O/4dKiW/d16AGpTZIs5ykLUmrx60PeD7JtEGIU
	 xAJGmp01jfcRAz/TkTUuEawRsBxFyWV2l8IESXt8Zoeo+oaSlGWpQu7UA576M1Jt7/A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789729510;
	bh=5snXmwV64jYIOwvYRMvXmIrcVO7e5vm5GcsOdam73ZU=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tdhccItwYoR8g5C+pQfREK3Xkbve/B4hbw1cvUtitF1aRJdrml8t4hhVgFQoA8GPt
	 bOpFa0uQ2rmG9eZ72B6zGiBoKtdbJFyBuplnpfwavLhzoJNgo11r1gbEuudTe1+U3H
	 pxEcrWfZmJurLCd7LR2YZ/xEbp7CiE0NqKc6WzsrWKU7199Ytc8ujhfTfN5NR79FiE
	 e+W7lHxdnEwVjrVLRvp7uwUPh2XQ8l1aQvfLryDn8q0e3e26RcKWmhjI8D25MgLM+F
	 uyeimRxdtQd1kanrIcn3vJUZqMzAo/VPC7ahMDjSnPhQhf++0YW6v4EtjAV19RfuTv
	 xXjvo+Q4tFIyw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1FE1440B5E;
	Fri, 18 Sep 2026 11:05:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E8FFA362
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 11:05:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DA27B60D4E
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 11:05:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mKakqZRG9-pm for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 11:05:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A417F60C1E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789729508;
 b=rIu5l9UcvIo0+Xj7RcBythjQbMGknBr6B/mOHlz/gnMAO+0UHtO+bwF128qT0CEuGfy7
 ysKICwQ6ZXCasMP6dI07sqZq7Ibyjs42R5jgNkVwCxT0+atWALCIVID4O11Ly6n8zwYTS
 GdnZr/wzJpjfxwW7MM0A3cJbS6TQu1tsDGii6vL3W3DwQsWcHEy3C4Pd9SsbQo3cWkC8Y
 VuRNcSEsw5hiSez2FkdB3eYap6XCxoSE5R1kAOv8Ziti9Ak5/zAInKKlJQNLQamycj0H7
 HeOv8Wb0sazc8lk1creJUeoURkLpwGY9YD9qYiYq1q1aNO/IuQp862UrFDcRn1PwYDA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789729508;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=5snXmwV64jYIOwvYRMvXmIrcVO7e5vm5GcsOdam73ZU=;
 b=FdUO5sk4BQY8D7XLwu+Xmm8CKWzvJDCCgXL57+MA++KiXlxj2mZGcEsC0JpCDDpKyuyT
 ghsVn3/KyuRfnwBUIyCwI0pCO0sMemNTa7+JRH8ZhDMEpvGVPFI9SKrjT2lYPQEWADvrW
 SfpusYW4HrNrILXs/jIf+nulwomvKKf1F1rpVGBXmZPk1cSoJuSiLxdiqxT/sw7zyrSdl
 XGqrt9KbXEHx1LQUQVTQHky+SkhtZxXsWbfZFbYYHSRBiLSiOf/RphankAsG5MKhGmzhl
 NXa1tEc1ChgkTpelOrS2XWQmQBU/O+AiNKCIPmgJJufM8hDxr+K+vTS0gfhGl4VocUw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=PVfQAwKT; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=PVfQAwKT
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A417F60C1E
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 11:05:07 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49cd5462b69so3405695e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 04:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1789729505; x=1790334305;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5snXmwV64jYIOwvYRMvXmIrcVO7e5vm5GcsOdam73ZU=;
 b=PVfQAwKTERJCIXjVHKHBBFFkwzmC3HjxXuZJiHD7ny3dexvN0pEWzoxTB0HElzvsdp
 a2bd66oHTlBCONM24oywyFq+8ZKWno/97hpxjk6c3Ol4AAvqntnnrarS0109l3PU1iq/
 oSNnLfIo2MCb3+IFLGTPlMPTPJyRnnRL3qwEYhh3BwUwsHpmZG31k41/zeUuXDAWQw3q
 dvKDsmyCVHSMRJPE7fEH4lTqmzZCpZ5lDzkkOeyQcVVyQW3apG9IzSNjbWYaO7MM0KUy
 PkwLk2Pelit0UlPgEht6rvk98zmOoMzMmsAprnFpCPBsaCCHxLRVDsUiRjTLb+oWOq43
 j9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789729505; x=1790334305;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5snXmwV64jYIOwvYRMvXmIrcVO7e5vm5GcsOdam73ZU=;
 b=UjHxbn+4Mn7dA+0Q3Pv3zI+Xpcp7+dXqhP9Vi+W/sGBttjpLrXTHp5lrLEt4Xq3VZE
 GpfOcbYcZ2UWLp874ZfvLl7OovJohe7atf6CwgM4Vx9O4ax0BVer/Pm4DtpPSOQaCenB
 MjsqTm7Gi2W+fl7QKR8ESFTUAQN2n/Y8T64eVJeWy88owAa0nl/j80IM/eMWCvFblgqG
 zEzv2WDW8+KoV0aAoQm6y6zHDG8Ozx5vAC+mb5k7GotVc4kGGlXmlemJfD7N/N3Zs7bq
 1u7NMOKXVOWKZ+DOyP2tdONl8iGEjoYEpNf0jJ1z8NBVv9iiw8GFntr0R5OJ/Pm/mgdG
 Z40w==
X-Forwarded-Encrypted: i=1;
 AKwUvBymjNvUWt42a8qbFovc4N2CVUhfCCnhAmas0zKKyJC/A9MlbfG44UYKGS2CUk7ckmWRrgAKHmk=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kWM+cCWkuVZRCwHMVlgDMVBHdIyrBdnZ59N53Mk/8svx2QwK7M
 hJGscxl2qI7nIXW+09KCSSELveVZFBhY2oDGKCUPg5Zs8PCL7tqBG8xezXXcmlTcXIU=
X-Gm-Gg: AYBFou22+qwnbocsDeBQKPfjBLm0+orikeHaSFxL1WqAL+ToqoY+hqB330jji+a6EmN
 oh2gdYhKimMWoZOsCDS/pZKOVG4fHaQpd2Zo+ZOcaw0Khxwdb2u6qe+6r/lEc2FtmoWUN+P1Lwk
 EvCFONG+IPRsJktkvqL1X1GtTpXvrUt96NEo2O3B0vVAkNtN/zz7b9ljW9/8fLo2fWmHAcpYnmj
 7o84e3U59SA1CqwTqxwwGkf28d4hUdUQl7Gzy2tFSOwFg/7BCiRegP50Peo+VnYxXrA2KpVb1jr
 O74xbf1w9QdqrwVgRo9IRtlf2TZf7VhSmSkbKxVBjYohsgZtKtTkEH48R5Sa3NV1eLL0rW3e1Qk
 hGILxrXJaapdZmADrOfBHiB08ZEpFW1ertnPDZ2dOZWl0JoCcaTB5tyQdYJlZ7gTVzAAmNAeAts
 rv/8/3u2lhhXKIUAzdMafnrTK+qO6P2cr9ovdvqwRNoIrJn6DschSfVaS2fY8QMpdvPHvmpyu2y
 brBJB1JAbhBuKKYmSeLLIqUf09HU19TygK7uSIrYU82MWPQUZ+d
X-Received: by 2002:a05:600c:1f95:b0:49f:bcb7:8e9 with SMTP id
 5b1f17b1804b1-49fc5726c1fmr50111995e9.9.1789729505134; 
 Fri, 18 Sep 2026 04:05:05 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc5748e56sm48063845e9.2.2026.09.18.04.05.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 04:05:04 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 18 Sep 2026 15:05:02 +0400
Subject: [PATCH] ubi: part: Claim only the block device UBI created
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-ubi-part-test-v1-1-cad4306b45a7@flipper.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ5AMBBA4avIrE2ildTPVcSiZTAWSKdEIu6uW
 H6L9y4Q8kwCdXKBp4OF1yVCpQl0k11GQu6jQWfaZJUqcXeMm/UBA0lAp42i3PTGFiXEZvM08Pn
 9mva37G6mLrwTuO8H/sgXFnEAAAA=
X-Change-ID: 20260918-ubi-part-test-b261e36d6a78
To: Alexey Romanov <avromanov@salutedevices.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 u-boot@lists.u-boot-project.org
Cc: Kyungmin Park <kmpark@infradead.org>, Heiko Schocher <hs@nabladev.com>, 
 Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2184; i=alchark@flipper.net;
 h=from:subject:message-id; bh=I1pmkG0LjKKmAGl/1ODx1oo49nTxJenkGFy+RFddYs4=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWStlXoUv0L3+dkAxX798p0LrH98e7pxWXrbiuma3LUpE
 b1KM5X6OiayMIhxMViKKbLM/bbEdqoR36xdHh5fYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyMdYx0jBi5OAZjqmwmMDJ/0FrTW8iX1RL51ubPs1Z67T7oPW5m+e7Bf9YbU6xfp9ccYGX7+yKo
 JuVHIt3/u5q1fLq9PlvpRknzvy+bupzzhHlbOu7kB
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

part_test_ubi() reports success for any block device whose first block it
can read, as soon as a UBI device is attached anywhere in the system. It
never looks at which device it was handed, so any device that has no
partition table of its own is labelled as holding UBI volumes:

  => ut imagemap ubiblock
  => blkmap create x
  => blkmap map x 0 800 mem 0x1000000
  => part list blkmap 0

  Partition Map for blkmap device 0  --   Partition Type: ubi

  0: vol0

The blkmap there is blank, and vol0 lives on nand2.

Check that the descriptor belongs to the block device ubi_bind() created
before claiming it. cmd/ubi.c and test/boot/imagemap.c already pick that
device out the same way.

Fixes: aa5b67ce2262 ("disk: support UBI partitions")
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
This was discovered while adding additional tests for the GPT layout using
blkmap, where it turned out that a stale UBI partition table gets
recognized on the blkmap where none exists.

CI for this: https://git.u-boot-project.org/u-boot/contributors/alchark/u-boot/-/pipelines/1327
---
 drivers/mtd/ubi/part.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mtd/ubi/part.c b/drivers/mtd/ubi/part.c
index fb30f45e2135..689f5af95a39 100644
--- a/drivers/mtd/ubi/part.c
+++ b/drivers/mtd/ubi/part.c
@@ -8,6 +8,7 @@
 #include <memalign.h>
 #include <part.h>
 #include <ubi_uboot.h>
+#include <dm/device.h>
 
 static inline struct ubi_device *get_ubi_device(void)
 {
@@ -92,6 +93,14 @@ static int part_test_ubi(struct blk_desc *dev_desc)
 	if (!get_ubi_device())
 		return -1;
 
+	/*
+	 * Only the block device UBI itself created holds UBI volumes. Without
+	 * this, every readable block device in the system is claimed as soon as
+	 * a UBI device is attached anywhere.
+	 */
+	if (!dev_desc->bdev || dev_desc->bdev->driver != DM_DRIVER_GET(ubi_blk))
+		return -1;
+
 	if (blk_dread(dev_desc, 0, 1, (ulong *)buffer) != 1)
 		return -1;
 

---
base-commit: b8e0086b585791a771416ce51b58ce0097bc0b28
change-id: 20260918-ubi-part-test-b261e36d6a78

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

