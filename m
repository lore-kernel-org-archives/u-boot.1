Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB9BDC35FFC
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 13:03:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3236281C84;
	Tue, 25 Mar 2025 14:03:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Xh1JhPwq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4016981CAF; Tue, 25 Mar 2025 14:03:00 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2013080EEF
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 14:02:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4394345e4d5so35381685e9.0
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 06:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742907777; x=1743512577; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/Syhwa7N1WhpauCJ/V6w/a/atGDCDlbyQUts+Sksfgc=;
 b=Xh1JhPwqNUHTNvntOUP6UH8CifL0n4VzD7duaCbHe7tKOgVILAcqcAYBCqS2PeVory
 o9hX+W0b8WQ97yQp2M4OVB13txdlUJXaXxBbaQZ3Q04J+GJozhka75PdwXRsIwk+foPl
 khQsjnxGnqAsHY8E+cedAHKPqSfGwp5CcDt9m523pZ7wbe9NhCA8HdI/EssgLz5BSsOS
 n2K0Eoao0MgB1sLEg9VwfSZIzbU3uBuP/Foqy6E/5zuDtTIR1Tr4EpP0XIWVrpS8B0Hc
 UmTzZP82y9dGGApuRctsq1vdk9CNpZtEqtnFDTgyZYGu00fwJrP+HP0EZwrovxj+x5zY
 QAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742907777; x=1743512577;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/Syhwa7N1WhpauCJ/V6w/a/atGDCDlbyQUts+Sksfgc=;
 b=RVUyWh7oFSJy5cSfG7Zm7jr/G5XZnVbHUFgPZeviqdqXYVyU5v6HizrtUIJ0pdK2Kq
 aFCSjhXfhruM0o9rjGQFsrnisL4k0xVKVAscIq5AGJbH9WAsUZ35rGBm+ITZheHuOUi7
 J8X4/16Mm5gyVdO3PWupn52di49MulJGh64bm4VkrRFK8Car3Zbse8sOsMu8uZSyIEFg
 u/yzJFMBWJ53CtAVfSmY4Ib3L6q/NeRyPSTPKjih1pMIZIDP9CFYw51RBC82gQ1klWr2
 7N+u7sF+7Sm0bPEQj+/xVN7s27khI0mEcsDkRTxtv+glzOuWdxPE09joExB/UGbxXnD2
 f3eA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWia8A66ZhplxTWlkglhrRYDRYMYmhhBQYnEoKSp+mFBlWA7lJYB1Pnstun1ZlakBEIBW08S1s=@lists.denx.de
X-Gm-Message-State: AOJu0Yw2U6lDQRqAbU9hBiu2EQHIaJ0zao57HB3eFynia59s5RfNCZt/
 GSXLmk6XMmWMI3o9JZPhpbzA+AXitQinCTp0K4GXhfBGdaiTBkvM3wvFAvjPuu8=
X-Gm-Gg: ASbGncsNDMQOA35t+Qd2VJfCcWQWOlUnQhQ5ffuUliYlUt1vnMGt37FlOf8gGzalRRK
 cS8edPcPgsaF34XZclxstpGsNdXVbs6adqxbOYNc1k5oomyT57DzYcIA4IBnX1b4+sdOvZLAyH5
 xnb19Ff59F9JI0rr5jDJh07lhxlUmK+JdN0pQikG4I7Oo5lYfjddytK7jywdFOUSRLdk0vi6ALs
 ZJFA40KFaDlxLHsNA3pYdOsB/GwXqhcslBEsPFHsBH5IfsEcXmHuCWH97HaHlTmVsBY89sdBoI8
 5uJ6u+bHoe7VoASUmmW4p4fvjAigXxLW+PIK+ev2bWE6R7cZkaB+mMg28ucIrSnejVFkwHVFCA/
 mXwenYYw0ksZA
X-Google-Smtp-Source: AGHT+IGYuqOzOBy4Ad7D2yZ0jKLQjWDfYyYRcXfrrMh7JX7hj48T2MEu/hC+r4lZOtFemsUb/t+Tng==
X-Received: by 2002:a05:600c:1da5:b0:43c:e70d:4504 with SMTP id
 5b1f17b1804b1-43d50a212b4mr153405765e9.19.1742907776780; 
 Tue, 25 Mar 2025 06:02:56 -0700 (PDT)
Received: from toyger.tail248178.ts.net (i5E863BED.versanet.de.
 [94.134.59.237]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed793sm204706095e9.39.2025.03.25.06.02.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 06:02:56 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH 0/3] scsi: ensure writes are flushed to disk
Date: Tue, 25 Mar 2025 14:02:51 +0100
Message-Id: <20250325-scsi-sync-on-write-v1-0-3575aa1342e0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHup4mcC/x3MTQ5AMBBA4avIrE1SLSKuIhY1BrMp6YifiLtrL
 L/Few8oR2GFNnsg8iEqa0go8gxo8WFmlDEZrLGVcbZCJRXUOxCuAc8oO6Nphpq8s3U5TJDCLfI
 k1z/t+vf9ALqNRG5kAAAA
X-Change-ID: 20250325-scsi-sync-on-write-08b6ca3264bf
To: Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io, Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1263;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=aW4FRinhVt6w+970dkuenit+cYRk8Y5uZorqK2CeYxo=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn4ql+ucsFvGiRxtRchf2mr+pbKetIrgPZaiXDW
 AShys0ORCyJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ+KpfgAKCRAFgzErGV9k
 trNdD/sEDkaxwczhHAAidI1gBQ1J3D/UUSJFinZ4emXeDuuLKcFRZR0i3ftwexXXnkOi0BTEKlK
 d/HlGpWLHLKi0gaHKMC/rwI0VpLdDkGl0VseE1Q50laIx0K07OuV3czSR1HDDN8xp4jcr/bXtcB
 zw/a5LPj4sLDYjEV4nH/cEZjhlorLoCaXMa7Ll3xjHGcjRh5B0wk79u3j1X2dLAd+DqjyCKxB2O
 sBQyUgrkRqEGqQ3FjmlszuDDYkp1oqMvpAyJtGEp5RCIaR1ycQBl3LF0deAW4SCj6UQSZemART1
 sSRX1CHGV4YrWKkLHAxaofNBxDTvhuBHX486L6Zamaa1hmTduWI6XLijbAJSgUbB84/BUUIO/Mc
 F6nqSYNlAv29c7ASswqC7avHDCCatVemBQHSGgrGsYPeLf5l219CkyqiXuKDJvwD7ly81hnjAmj
 jIJnuLgNd7r6Jfrt7W9rXafUknnQS3Is4awdM8cmkqlmw1LH7yu83638CYQEChDtTOxxrylP82L
 IBRSGWpT0ofz1aUqaSYPQcR8Wr298SYxh9l+bvWIOcmQh8EC78SN6Q+nZ2RpjUZkEQxgodD/Q7q
 KhJe+SD+hKyiUvrlV/OwMjKuKlg9NNGn/bqnpGhSW7Hb5+C9G16DB2qW39m4i/VbQmTjXRZbi4r
 rtnAUrS00U5ynEA==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

SCSI devices like UFS may maintain their own cache to speed up writes,
however this is lost on board reset (and may be lost on device removal
or reset by OS drivers).

Currently this can be worked around by "waiting for a while" after
writing data to disk, but of course this is not an acceptable solution.

Ideally U-Boot would have a mechanism to flush caches during board
reset, but until that logic is hooked up let's be sure that all writes
are actually propagated to the storage device so that we don't lose data
on board reset.

This is particularly noticeable during capsule updates, since the update
file is deleted and the board is reset immediately afterwards which
resulted in the same capsule update being applied over and over again.

This specifically fixes Qualcomm SDM845 devices with UFS 2.1, but likely
all UFS devices that use a cache.

---
Caleb Connolly (3):
      scsi: fix typo in setup_read_ext()
      scsi: de-dup calls to scsi_setup_write_ext()
      scsi: sync cache on write

 drivers/scsi/scsi.c | 47 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 7 deletions(-)
---
base-commit: a383b9bd4d7e430fe7c254297540bae596649dba

Caleb Connolly <caleb.connolly@linaro.org>

