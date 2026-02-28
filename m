Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03115FEE4C8
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 18:23:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 197F383E76;
	Sat, 28 Feb 2026 19:23:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dpvTyj/6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AADC883EEF; Sat, 28 Feb 2026 19:23:23 +0100 (CET)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5153383CDF
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 19:23:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-506a1b23c05so37609231cf.0
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 10:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772302998; x=1772907798; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qHfF1r5DwSDccRvHx+VicBqpeeFGtPSH5BiqYv0/2O0=;
 b=dpvTyj/6qsWngVQts6z/iIudnJKgFPKJDPb3KgnVjTM1HMwpJAyK9q8rLZGUeiaXgg
 FmEjfxNLNi8jteDEuiUQs/MbdPEajDn3VmS+DHuWmv6wJYNKnBoSWtxNkX9+c/3Fp6+j
 GX+3+A8ySiyWILHzqfeV98VS04i4BSsfSqUDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772302998; x=1772907798;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qHfF1r5DwSDccRvHx+VicBqpeeFGtPSH5BiqYv0/2O0=;
 b=RWyadqaF9uHUUHvBKRDIg0aQtnnoKnQ+H/bpeATFGd4wjpIuV9Fiht0wLvlXl76MRZ
 al0DmTQ+a52JUOPVJ4k197QfrhHOtso9YMxjoFsGvspzLkblxv689dQXOg72eDEXogOp
 TvQqkGvibDZNzHQr/Y2wvO8Hbb1vyQMke63PpWEOdEGDk2KlfERnMow1r9iuYZcR2kWK
 fzA3qJefEhOEsJM7m8Pflb0Dxm0zMDceV11O4QIhyvmmzMjvX2Th5/pOAalJ3llJosS3
 iTnwNzjBajfSztxevwb1WJ8Jb0Mh7eGezEAxltWpmdicfqaCDQdEWc9dmWxQX7sce+33
 vbNA==
X-Gm-Message-State: AOJu0YyAJSQOKFsixI5AftWgHM81pOAgbaiak5fzx127G9HvC3KWEbMt
 uKzZL5QrZ/ssn8Yc5EsHFUDicr1ypjV6dRpvw5nhJaHG/FUJNN03a+lfe/zAlRerIHVyLAC4BNK
 myuM=
X-Gm-Gg: ATEYQzxqh1PJ1Fbi6dzSr+2x2WKhTLv6OsC33Ap+9MFeMyGYEu/mHON4u/8pbM7Xujq
 Ht1mPMWM+s1cOSar+1jT7c5jZ8hh/lf8DFs5ohZlPE+HO2tLFCmZo0aQi3w7CNnJH8Fz4dU9zaZ
 VuAdoLP3qkvHHBMDwDmdiT6+RfpYumHN5u1jWr0S82NkeUtedcJrScMgRhzL0ptBXUznyfN1x1R
 74HHMeFA1Xjg+U6bGOblqvItG9mVLSazVvoYvVMIq64Etw0StAq8TOVKboG2FpDxX7tkoowvpBS
 OjkvDSe0kVcNn711oZlfaVhPzvDmWke2K6wC//mLpreLPHiPc0E6fIY3b1SxlvQoS5yDcTYr+gD
 fQda6dXPybdyouX746RNeYBAqvkK6gq5W63LO8LV/0XyrCgiRqLC7PZicBfsWxP7OFOcb8+QVXo
 Alv7Zegc5Dlz9zyWl1jA==
X-Received: by 2002:ac8:5ac5:0:b0:501:4446:2ce with SMTP id
 d75a77b69052e-5075288b728mr103891551cf.49.1772302998289; 
 Sat, 28 Feb 2026 10:23:18 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-507449a66f1sm78508601cf.12.2026.02.28.10.23.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 10:23:17 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Marek Vasut <marex@denx.de>
Subject: [PATCH v2 0/7] Provide classes for building disk images with FS
 partitions
Date: Sat, 28 Feb 2026 11:22:40 -0700
Message-ID: <20260228182304.3728735-1-sjg@chromium.org>
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

From: Simon Glass <simon.glass@canonical.com>

Refactor the test filesystem helper into a class-based design, reducing
duplication and making it easier to create disk images for testing. Add
a helper class for creating disk images with partition tables.

Convert a test over to use it. Provide a few other minor improvements as
well.

Changes in v2:
- Split the quiet flag into a separate commit
- Fix fs_img to accept only a leaf name, always under persistent_data_dir
- Add new patch to split the quiet flag out of the previous patch
- Split the pylint fix into a separate commit
- Explain why setup_image() is left to later

Simon Glass (7):
  test: fs_helper: Allow passing the image filename
  test: fs_helper: Add a quiet flag to mk_fs()
  test: Update comment for fs_helper.setup_image()
  test: fs_helper: Drop the size_gran argument
  test: Convert fs_helper to use a class
  test: Add a helper class to create disk images
  test: Convert test_efi_bootmgr to use FsHelper

 test/py/tests/fs_helper.py        | 310 +++++++++++++++++++++++++-----
 test/py/tests/test_efi_bootmgr.py |  38 ++--
 2 files changed, 273 insertions(+), 75 deletions(-)

-- 
2.43.0

base-commit: f6963fc232603007c661411fb31c57f1a9678a87
branch: testfs2
