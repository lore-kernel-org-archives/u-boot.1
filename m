Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68ECBCD4F54
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 08:55:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E5BB846BD;
	Sat, 23 May 2026 10:55:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gu1LHjmv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C14C484659; Sat, 23 May 2026 10:55:05 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22EC384659
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 10:55:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7e568ab0bc5so8962346a34.0
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 01:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779526500; x=1780131300; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Hz6Bw+/HNLI5buZinJYX0C5Tl/8IZBLddSdMbMyCir4=;
 b=gu1LHjmvFzr20G0GQNnnGJhUfel9vsYU0eevHvABfmCHlrGniQA3msKkOQGj++kRFP
 ptzxQmMOQWcJWWI7yyw41zZfuaVVBuf8AohPWV/9k7Gwjm+czYR+CQlUs64OyfKs+jFc
 SfGTq6eZkX2b2K/p863iy/trOQ4x2/M4BoMpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779526500; x=1780131300;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hz6Bw+/HNLI5buZinJYX0C5Tl/8IZBLddSdMbMyCir4=;
 b=gGoxnA+0ddV8IgWPoj1CwkFRGGGwCoFgrddPv7tUKScYD8624q6ryMtQo+mHvrPcv/
 rsm2y6nWYX9afM+LCu8aoboImvAn52R6IM71cF6Ml6w88SchwnFpicJT+5rCv5hyjgBJ
 EeZJD30EDOrKR1N8Dn/BqpBC1DvQ/YDaK/4b3WWNTqWvP2kE5lSLeEpXu84jKi7Bboo5
 OUJP9335uOF6aSAYou9qHppUd3vO7T0JfesJvXlMTjU05tjs8ZLvDMyrGNhOUl4UlpR6
 dQpE6oC0DcIZACMerzS7RPbJCXgzqQjjDRdF8hoA5wFxnsc1iiRV0XPDvFuwjlZLh02t
 RNTg==
X-Gm-Message-State: AOJu0Yzj5saJeiHfP/hqtNWNA+RJsWByzoio/L9dMXB8xvDwy1BZr8iv
 R1ce4JjdHdYvOBF0AJo5Eb3yDh3kio/ArSU+9qdkrXorxLROeGH8tlMYkrNodwLvwhogw0/uDGn
 Slz3bGUsO
X-Gm-Gg: Acq92OEEoCJJDoMtaESAo6EDdOQycQ8DXZ8AV8c9KSE1dsoUtlEVaWRlMEj+LdUjCbR
 Gz6yqGFbpqkheU/OKla2UsEzgKPZDasB47l2wyiMc7cACdnRvjEGjvyd6hLmVLD75UDtFO95LiW
 1npdfYrUB2DgcA/vGw3kbjVvoGg73zfN1nizW/esZE7CEh6VJFBjqdTHZDK1VbVsFN+CqqXVS87
 hEpqujRCAq2voHu3H6TCfgjHc+Oep+PBevoHAAigWHZkc1GIWcN4TNhM0MQKusF+HSWWFeElN1d
 gszQh2wnJUPixSVIX+Dp0HOEc0jFurjQWQBNQceb6F6GB0tS9zN76C8ZsGNaCgbjV+QWK6H3jvK
 DCVFwaUXFQoUpRpRxDjbe0QG59ADlrYR9GHuAQNf4Chf3sQIM86QizgHRLWbI1WjwXZSIlSLXwv
 Hwyb5WRhP3u8+/BQuNFQ==
X-Received: by 2002:a05:6830:451d:b0:7de:c870:46d4 with SMTP id
 46e09a7af769-7e5ea310baamr3345105a34.1.1779526499909; 
 Sat, 23 May 2026 01:54:59 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e60666ae5fsm2893602a34.24.2026.05.23.01.54.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 01:54:58 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marek Vasut <marek.vasut@mailbox.org>, Marek Vasut <marex@denx.de>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>,
 Yao Zi <me@ziyao.cc>
Subject: [PATCH v2 00/11] Move test/py image creation into separate modules
Date: Sat, 23 May 2026 02:54:36 -0600
Message-ID: <20260523085455.750591-1-sjg@chromium.org>
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

test_ut.py has accumulated a setup_*_image() helper for each image that
the bootflow tests want to boot. Each one is mostly shell script and
partition layout, so the file is large and the test logic is hidden
among image-creation details.

Move each setup function to its own module under test/py/img/, with a
shared common.py for mkdir_cond(), copy_partition() and the
make_extlinux_disk() helper. Each patch moves one image at a time so
reviewers can see the relocation cleanly. The modules are named after
the bootmeth or feature they exercise rather than the distribution they
are modelled on.

While here, also redirect the generated disk images to the
persistent-data directory instead of writing them under the source
tree. The sandbox mmc, scsi and usb-flash drivers now look there first.

Further improvements are planned, such as using the context manager
when creating partitions.

Changes in v2:
- Rename the setup_extlinux_image() helper to make_extlinux_disk()
- Rename the module to extlinux and the function to
  setup_extlinux_image(), naming it after the bootmeth it tests rather
  than the Fedora distribution it is modelled on
- Rename the module to script and the function to setup_script_image(),
  naming it after the bootmeth it tests rather than the Armbian
  distribution it is modelled on
- Reword to drop the per-OS naming, since the modules are now named
  after the bootmeth or feature they test

Simon Glass (11):
  test: Create a common file for image utilities
  test: Move extlinux image-creation to its own file
  test: Move script image-creation to its own file
  test: Move ChromeOS image-creation to its own file
  test: Move Android image-creation to its own file
  test: Move EFI image-creation to its own file
  test: Move the configuration-editor setup to its own file
  test: Add Args docstrings to img setup functions
  test: Reformat line wraps in img setup functions
  sandbox: Find disk images in the persistent-data directory
  test: Move disk images to persistent-data directory

 MAINTAINERS                      |   5 +
 drivers/mmc/sandbox_mmc.c        |  13 +-
 drivers/scsi/sandbox_scsi.c      |  15 +-
 drivers/usb/emul/sandbox_flash.c |  14 +-
 test/py/img/android.py           | 143 ++++++++
 test/py/img/cedit.py             |  24 ++
 test/py/img/chromeos.py          | 153 +++++++++
 test/py/img/common.py            |  86 +++++
 test/py/img/efi.py               |  37 +++
 test/py/img/extlinux.py          |  36 ++
 test/py/img/script.py            | 132 ++++++++
 test/py/tests/test_ut.py         | 541 +------------------------------
 12 files changed, 666 insertions(+), 533 deletions(-)
 create mode 100644 test/py/img/android.py
 create mode 100644 test/py/img/cedit.py
 create mode 100644 test/py/img/chromeos.py
 create mode 100644 test/py/img/common.py
 create mode 100644 test/py/img/efi.py
 create mode 100644 test/py/img/extlinux.py
 create mode 100644 test/py/img/script.py

---
base-commit: bacf09599a133f0274bc9fb8e67bfb444f057c16
branch: testc-us2

-- 
2.43.0

