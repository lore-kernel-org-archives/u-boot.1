Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D67ACC3DA6D
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 23:49:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4287282C2F;
	Wed, 21 May 2025 01:49:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GyYPPXYG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F37C82CD2; Wed, 21 May 2025 01:49:49 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 634B782BD6
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 01:49:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-2cca475546fso3511176fac.1
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 16:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747784986; x=1748389786; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rouM52iZA1lJ3TNyHnfMxLzdFYtvn4l3brImBBxmy14=;
 b=GyYPPXYGgU96hL44xAbM/+Z2vNsyoTAVyjSu85qoUtLfpDdJtdvWXc3XSNEl5BOOz4
 C32gFyH5aJP1/P8qQT9zjL3ZyP4o4/Bvn/3OTKaLLvO57PGmxnV1VRoWYXA4o0I2qfLL
 rowjxgEVvozXBgQWmuRXISzy1t86gdawL3bUot0sqYFWd76C8XcAd/CxUPe0pLziE5on
 w24qxVXfEJs3hKy3nAm4BSYtqs3KoX2mUOe5AWvomkVyg8HAgzcLEHV8SafHmSibkX6i
 lu9BQEI13ThjaDaBxl8ytrOzly6qhtixIZszVK4b48ewN/gHXaAXSoatDSrrSKoK/ysK
 EmpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747784986; x=1748389786;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rouM52iZA1lJ3TNyHnfMxLzdFYtvn4l3brImBBxmy14=;
 b=Z7l8GLp71etWRp3kcugSUcogvOrBSdqdELdn341kbUWPWX7R937HNv8aFS7rFE5U+9
 7YlQNvPFsVi9JhpgEBtK5HHacxy3X7Z9QF1NriyeDAjqaOzlwGZ8VToVlqi4XhUPxjJl
 s0deSTek1nDsK7g97n27E5lMnJJSE6EE1eBe3NRqCKgv6wvubEkTm/Pyr3x7fqp1rBXY
 RK8XQCHgoSBhLgFvxbNF9vpAqTp4Y1i6FrcTL00U7cKkl85UIB4PpF+JOkON+tZaXo6q
 dkc5GzG4zO5c5Zj2p6yRXhnEhZf/yR31DBDA2p+bPtNEQvd+x4tXqAz4hkWIkz16dDMl
 s10A==
X-Gm-Message-State: AOJu0YwmJqc99nixOo28L6ccZz6cRiceAParx4kpEfKOdYjz9wOx855t
 gRSgVZYpRvoI919PHh3mE5rPKcV5Cx1U1/aNy1rVxJQOzGYSW0Va/viy
X-Gm-Gg: ASbGnct2N+YRhS0KIiedf96l7uBeoDsy9wLcvdJ6mWi/1ypi3Gvz3MxHWlHATgzXZZ9
 YiKJvHiHB0lNS8vaMyQLGR9RUWg5eN2aep69EAL76A/gLtxKvK0KmyNlhj5AjGlzgqDnEJvtJFI
 te0HwqBFdB/AQe5Gk0GY2Lf4IxHD9rUquAFgN5ZpNV3aUQobPOb6vCYe3I5W0J3r6xmEIyQl6dL
 h4Za5MOQJluvRd5qHJRAEIOn30celpHfWhyc6FZdafxW6vJRhwfPx/45V8lYjnsrPH/zrWGe9yg
 lY0fnjnbU/68Kf2AL/l7c7iFDBv5+0DT2dztypylRdf8C3hP6aHpuz+LXj1FQo+1ZoBlVwHdmOd
 bNZpDxxFsg3hMYoDko2bFqAlFr10YppjsH8Njk+g=
X-Google-Smtp-Source: AGHT+IE/jA/YeVe5ODSz3b9uJDKJOmpej/isLYHsBCXEaANhgmuBbtb/jaU7IQtcCOe4ok4znTuTHg==
X-Received: by 2002:a05:6870:44cc:b0:2bc:8c4a:aac2 with SMTP id
 586e51a60fabf-2e3c1e835a6mr12134509fac.27.1747784986019; 
 Tue, 20 May 2025 16:49:46 -0700 (PDT)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e3c0b21e70sm2422378fac.41.2025.05.20.16.49.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 16:49:45 -0700 (PDT)
From: Tony Dinh <mibodhi@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tony Dinh <mibodhi@gmail.com>,
 Marek Vasut <marex@denx.de>
Subject: [PATCH 0/1] fs: fs_devread should log error when read outside
 partition
Date: Tue, 20 May 2025 16:49:23 -0700
Message-Id: <20250520234925.26339-1-mibodhi@gmail.com>
X-Mailer: git-send-email 2.39.5
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


Currently there is a bug in u-boot Ext4 filesystem driver that causes a
"read outside partition" error. This bug only shows when the HDD is
greater than 2TB in capacity (i.e. driver using uint64 lbaint_t). But all
users will see is u-boot silently failed to read the HDD file system
directory.

For example, ext4ls command will return with an empty directory list,
and without any indication that the command has failed.

This was tested with the Synology DS116 (Armada 385) board, and a 4TB
Seagate HDD. Linux kernel 6.14.6 Ext4 driver handles the same 4TB HDD correctly.



Tony Dinh (1):
  fs: fs_devread should log error when read outside partition

 fs/fs_internal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.39.5

base-commit: 126a88d49bcae04bbfc0d6723097cd6341355ade
branch: master
