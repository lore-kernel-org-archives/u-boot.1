Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93FA0C5475B
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 17:37:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CA0687F02;
	Fri,  8 Mar 2024 18:37:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="R1pHtEFE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC5A987DDD; Fri,  8 Mar 2024 18:13:16 +0100 (CET)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com
 [IPv6:2607:f8b0:4864:20::114a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B064087EE7
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 18:13:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=3KEfrZQYKBpk43KG3L9HH9E7.5HFN-4HHMEBLML.67GQ.67@flex--barnas.bounces.google.com
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-60a015ca1c5so21082287b3.1
 for <u-boot@lists.denx.de>; Fri, 08 Mar 2024 09:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1709917993; x=1710522793; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=LrExuqWEQTTFK/vjDGHJbCIa+xaX5xYpaN/chIyyq2g=;
 b=R1pHtEFEvLV77C3By2a2QHr1dYk3fsbd3I2eJR5f4D8PgW4zC6mmzRjW/TwK28ug8m
 LxpdrDUnKKbc71sCYMV5alXn3idi0YpxvIWxrW/obpOCRaRaok0W5zPqLZ7z4+6AmizX
 7ybbPHA/ybEXRgxYcKE+68BLsF6JLy+LGrIlUoJMqb3nmg/vlsp/ZokOyBpB6sHgwW8o
 9ua5/nO82scVTtMZ+agVfZRlKSGMCDwrNJk+VjX65GydxSld4sxbIF4y9TJmSWwoqkUk
 e6SXYuZShdbXHOpIDmyK/a9h7/RxVW9f3nymBfS7vVuRDWgtwYNftXqEaha8IJWD8fE/
 c3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709917993; x=1710522793;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=LrExuqWEQTTFK/vjDGHJbCIa+xaX5xYpaN/chIyyq2g=;
 b=sxdCoz7KJ/jq7kEPX/AFYMrTeG3T9uG4zW+vLXvVi596rIbGxyRdqZjRdl64f6sPYV
 yomxkbObpLecuVZKvoqNVhsmDgL1lOlXoa8RaXVKz2yEHfR7P8oF9AV3zVmTIIeGZCYy
 JwtfIqR8VPlgmzqm894BulrNmBGoENg8osZ3O1mM+BvW0jHEUSOHEsKPpWaR5b7+fozW
 VNtd0D9WWG89CyosoftCHGBOVQiAsM/WORG0UQxHHhyeIjqc1SY/SJt6CvOIdFW3dHK+
 hVG5iUuwij5PUB9PkO1OpVnuWI0mjh1sVYDjrWMQJCK59EvshDApLAsOCvETn9jDR1SE
 /hjw==
X-Gm-Message-State: AOJu0YydgrHNVnS9hjaW6OZ8f7badmNMXQNxa5w11IhfLAG4Svzj4jbc
 wM7FFIyuz00v1HIDwgrbPYhrkGd9D0XEP7B0B+grg3HulbWyt+rqb30zvVeL+Zk3pKB1lD7G4Fj
 oW240YDn6AqI6wfQBwrY+6qMI2wZjO+hTJZqgdL1KRiwjQenc76MWBaIc5gT77tw3BN2VbbV4kz
 rJIHMcbgcvYju8tS3RHDnAbG9/dFRenQ==
X-Google-Smtp-Source: AGHT+IE+HD6AgGSKac3teNTuJT1elQ1s09m5s9wJz+khTnEjiEOsLvCwAIhTgaq+xgFUR2M+0XkGSdZIz0s=
X-Received: from zombine.c.googlers.com
 ([fda3:e722:ac3:cc00:68:949d:c0a8:7f3e])
 (user=barnas job=sendgmr) by 2002:a05:690c:a87:b0:608:a8da:1caf with SMTP id
 ci7-20020a05690c0a8700b00608a8da1cafmr6008562ywb.6.1709917992924; Fri, 08 Mar
 2024 09:13:12 -0800 (PST)
Date: Fri,  8 Mar 2024 17:12:48 +0000
In-Reply-To: <20240308171251.106144-1-barnas@google.com>
Mime-Version: 1.0
References: <6a69588a-7c50-425a-af7f-96caff727113@kernel.org>
 <20240308171251.106144-1-barnas@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240308171251.106144-3-barnas@google.com>
Subject: [PATCH v2 2/2] chameleonv3: set in defconfig for FPGA to reprogram
 every reboot
From: "=?UTF-8?q?Micha=C5=82=20Barna=C5=9B?=" <barnas@google.com>
To: u-boot@lists.denx.de
Cc: "=?UTF-8?q?Micha=C5=82=20Barna=C5=9B?=" <barnas@google.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 "=?UTF-8?q?Pawe=C5=82=20Anikiel?=" <pan@semihalf.com>,
 Simon Glass <sjg@chromium.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 08 Mar 2024 18:37:36 +0100
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

Set CONFIG_TARGET_SOCFPGA_ARRIA10_ALWAYS_REPROGRAM as enabled in
chameleon v3 board's defconfig.

Signed-off-by: Micha=C5=82 Barna=C5=9B <barnas@google.com>
---

(no changes since v1)

 configs/socfpga_chameleonv3_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/socfpga_chameleonv3_defconfig b/configs/socfpga_chamel=
eonv3_defconfig
index 6ea61ca6ea..25615bb4b4 100644
--- a/configs/socfpga_chameleonv3_defconfig
+++ b/configs/socfpga_chameleonv3_defconfig
@@ -7,6 +7,7 @@ CONFIG_DEFAULT_DEVICE_TREE=3D"socfpga_arria10_chameleonv3_4=
80_2"
 CONFIG_SPL_TEXT_BASE=3D0xFFE00000
 CONFIG_SPL_DRIVERS_MISC=3Dy
 CONFIG_TARGET_SOCFPGA_CHAMELEONV3=3Dy
+CONFIG_TARGET_SOCFPGA_ARRIA10_ALWAYS_REPROGRAM=3Dy
 CONFIG_SPL_FS_FAT=3Dy
 CONFIG_FIT=3Dy
 CONFIG_SPL_FIT=3Dy
--=20
2.44.0.278.ge034bb2e1d-goog

