Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C60C3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 14:29:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DD21888FB;
	Wed, 17 Jul 2024 16:29:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="TMpvrldc";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="BbyP5KKE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17FC3888FB; Wed, 17 Jul 2024 16:29:35 +0200 (CEST)
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com
 [103.168.172.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9FD888636
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 16:29:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfout.nyi.internal (Postfix) with ESMTP id 8849813800F8;
 Wed, 17 Jul 2024 10:29:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Wed, 17 Jul 2024 10:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm3; t=1721226569; x=1721312969; bh=0V
 b7ZaMDKclRMxmUYj6lUAdkH31LSS4u3BZHzdL9pRY=; b=TMpvrldcQg0iY4obh+
 SucW3iKhWE7elsgpkzgskoHR/adx3PVuFAuwZoPLz8nLrvsT/2/ZQglyTn9jvSXW
 cNk35a68pToJqTtl1oyV8bz84M1Ce9VnsRcaYmQcpv7G157130eDV+Y/ibwFAv0B
 pTvEu/2w2iBKoZPeavCVUxuadZ99iwhwBCn6fIYFpD3Zahhod+VP5Ghq/egCGTie
 9yZwyy390I/Av9RYf0VIVgluqxJqpx4UFi/mMB8yxhYiX4s39ofKljD9MJry6xMN
 5+Md6iMiYUtFiqIVaV+R1W5rgjtEOFIfW255ZN1fX89QlYL3elQQt/R5BVNMVhQP
 S7ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; t=1721226569; x=1721312969; bh=0Vb7ZaMDKclRM
 xmUYj6lUAdkH31LSS4u3BZHzdL9pRY=; b=BbyP5KKE7ZFxn0k1POm80Lawj6IQt
 Hn5mtSu+vYXRpougzfXkGzVM5zwJHvb6XMTqwQJDvxUHyCzUbOeefnFdQDZVbkr8
 Eq+4y7sfGLn7jynKZkEOpYtwwJnz/jiJI0Mlvc0tgXKfgYIVvsto6iXHRlkH8m/Y
 cQgSeIKgBdDBjnstQKuent1BZ/TLKJtmAUBiLIcu3NvCMTcLTpfoIQ4hw+mPYT/T
 0+XikFCNDYl4fkch3F8A7IZHqF+sLrefs7Zu0p5R6H6Fpo/8jHGVMZA0Alqp72ZU
 PkC9etAW5ghlY2u2sGBnWP625UhNAWuIwhN1RR3OYu6GCXzGy0YefREEQ==
X-ME-Sender: <xms:SNWXZihS5lu6j2qd10ZDwSQAM7QiI74C29eOdT1aq2O1u2d1pSgj7g>
 <xme:SNWXZjAHt8NIvWyE6BuWgQer1mMO2tXFQNwNJ5bomMvAIwXfGnsYqDvoRmfK49YoE
 LjXW3iKdQvDOKNNGPE>
X-ME-Received: <xmr:SNWXZqGHA_2YRFRoHABV1AjRAvKxEUXKOwjkXc7IOSMVwc4_4UL0Ynw0vE5lQLARg7ia>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeeigdejudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomheplfhirgiguhhn
 ucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenucggtf
 frrghtthgvrhhnpedtudfhieduieelleffkeeihfejfeehfefhtefgveeghfejgeegjeeh
 veevudevfeenucffohhmrghinhepvhhishhurghlshhtuhguihhordgtohhmpdhkvghrnh
 gvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
 ohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:SNWXZrTRqtEV8A60NPZiAmpH4dYhlADnwhzcMPMDfn5uBUHZRgzHkg>
 <xmx:SNWXZvzFVmSrGOaOiYqJdGf1KWXGOd72wjqe5tQHh0tANkl0egKs6Q>
 <xmx:SNWXZp5QCTwiqo6vX2EKHuqRcWdutMqB5Lf5VAYsAjXnUnggE7pdag>
 <xmx:SNWXZszYqrbn7hpunkcBY7-hHN4DqJlUSk9hBJk-C_e6bZYGpQNtcw>
 <xmx:SdWXZmy9sFMDXdnf1zHLn4tVhTRq3fvDXee_OKQWL5Lj3FjJQhPpazrU>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jul 2024 10:29:24 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 00/18] New CI image and fixes
Date: Wed, 17 Jul 2024 22:29:11 +0800
Message-Id: <20240717-docker-image-v1-0-7c7fc6251e7a@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADfVl2YC/x2MQQqAIBAAvyJ7TtAlRPtKdBDdaok0FCKQ/p50H
 IaZBpUKU4VJNCh0c+WcOuhBQNh92khy7AyocFRGKxlzOKhIPn131liNxmvv0EFPrkIrP/9uXt7
 3AzeIzmVeAAAA
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3219;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=uaRvgHv0DALf3A5UOSR37Srst2t//piMl7fOMI4tan4=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTpV11uRllqWv+f8Ubuxez/fQtyj/8I9zNaO+v/UlndL
 vuMrw1tHaUsDGJcDLJiiiwhAkp9GxovLrj+IOsPzBxWJpAhDFycAjCRz4sYGb7oLHVqjapzeqR1
 cWGi6qPsstDoyOQ555sP93jvdFYLCWZk6Nzq78LdtZs7Zu3db6Gyy6zEzbbF/z93czNjZres47J
 +JgA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

Hi all,

This series build a new CI image based on Ubuntu focal with LoongArch64
support, fixed various python scripts for python 3.12, fixed various
problems popped up when testing againt latest software.

Last two commits are for demonstration purpose and not for commit
into repo.

CI runs passed at azure [1].

Thanks
[1]: https://flygoat.visualstudio.com/u-boot/_build/results?buildId=64&view=results

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Jiaxun Yang (18):
      binman: Replace pkg_resources with importlib.resources
      py: Replace distutils.core with setuptools
      doc/sphinx: Remove usage of six
      py: Bump pylint version and clear warnings
      binman: Workaround lz4 cli padding in test cases
      tests/test_event_dump: Relax match rule for output
      lib/charset & efi: Fix possible unaligned accesses
      CI: Ensure pip install is always performed in venv
      CI: Dockerfile: Set global git name & email config
      CI: Dockerfile: Bump base OS version
      CI: Dockerfile: Bump GRUB to 2.12
      CI: Dockerfile: Bump QEMU to 9.0.1
      CI: Dockerfile: Bump fiptool to 2.10.4
      CI: Dockerfile: Bump genimage to 17
      CI: Dockerfile: Use kernel.org upstream for trace-cmd
      CI: Dockerfile: Bump coreboot to 24.05
      CI: Dockerfile: Add LoongArch64 support
      [NFC] Use Jiaxun's CI Image

 .azure-pipelines.yml                            | 22 ++++----
 .gitlab-ci.yml                                  | 19 ++++---
 doc/develop/python_cq.rst                       |  4 +-
 doc/sphinx/kfigure.py                           |  3 +-
 lib/charset.c                                   | 21 ++++----
 lib/efi_loader/efi_device_path.c                | 11 +---
 test/py/tests/test_event_dump.py                | 10 ++--
 test/py/tests/test_ums.py                       |  1 +
 test/py/tests/test_usb.py                       |  1 +
 tools/binman/control.py                         | 18 +++----
 tools/binman/etype/fdtmap.py                    |  1 +
 tools/binman/etype/fit.py                       |  1 +
 tools/binman/etype/image_header.py              |  1 +
 tools/binman/etype/pre_load.py                  |  2 +
 tools/binman/etype/ti_board_config.py           |  1 +
 tools/binman/etype/x509_cert.py                 |  1 +
 tools/binman/ftest.py                           |  8 ++-
 tools/binman/setup.py                           |  2 +-
 tools/binman/state.py                           |  1 +
 tools/binman/test/184_compress_section_size.dts |  1 +
 tools/buildman/builder.py                       |  2 +
 tools/buildman/requirements.txt                 |  1 +
 tools/docker/Dockerfile                         | 68 +++++++++++++++----------
 tools/dtoc/setup.py                             |  2 +-
 tools/microcode-tool.py                         |  1 +
 tools/patman/test_checkpatch.py                 |  2 +
 tools/qconfig.py                                |  1 +
 27 files changed, 123 insertions(+), 83 deletions(-)
---
base-commit: 902d8ee94ce29a088a325da6e69eeb1a25f1fec7
change-id: 20240610-docker-image-868126a1a929

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>

