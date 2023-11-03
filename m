Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF3EC4167D
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 13:34:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42F66870EF;
	Fri,  3 Nov 2023 14:34:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="umqYbDc1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BAC8871B2; Fri,  3 Nov 2023 14:34:41 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55B6B870EF
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 14:34:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-32faea0fa1fso1010308f8f.1
 for <u-boot@lists.denx.de>; Fri, 03 Nov 2023 06:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699018477; x=1699623277;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=zViyrKbhex3njpbNg9nGg8wtU7F4cgj/57h4o+ONlP4=;
 b=umqYbDc1OTT9tpTHGUDyEn1O6Exi4HXc/85pNUsA0nUp8Vnq57AvhgnkuCNhvW/VPj
 hB18F0qQE0Y+bw85fKSRh3lQA97goRhxC+McSkt750tpYrL7k8vTFp4MWkitbVlBpqN2
 SUP3ZnF2gZkJV+OYE0jTmntLSO3eE7eBMrjnAb8uKxss2x2dW+5U8mHbckDcNwj4mGvu
 +v0zhv1mymnwrDgnLEKjzOmj6kVG9YHjg8LTHNhmIEyqqlu62DjoHSeo79tuLvNKl69y
 hpsjVTWOTUb2N3jomVa8E3mqbOuAMdU7X36fwiUL3En0Xp/oEcnWwxsBUciYpHizX0ck
 vOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699018477; x=1699623277;
 h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zViyrKbhex3njpbNg9nGg8wtU7F4cgj/57h4o+ONlP4=;
 b=sfAf0TtCaGlJUU3gC+Q0VE+/dEKLEYC3yVlURttjUlc3Pa0gpR6kfM2tZaAmo3+mFq
 pPTChveNEi2slF0jzsaisAoLWNlWCyh02oTa3FjdJbdBcPoKsELeJCKGmIalaHClkjtD
 zD244+l4Q4ZkKlvY3lqbJCndQPEHRw4WXQgq2mCL+SXkj5OiInF9xzPM/skjfmhejjQB
 MLrUt0E/inqaFgesan8uJlNuYUX6V8ICjBGQHERw2qvpDSBI5D4XNB3gykPfuLxnFEIz
 3g3QMd0I8hoob6w/WXsCmmNTxmIin09BHGrcyyGkOZcwqyHjHtri/xGrAYFKsLONecCt
 fSUw==
X-Gm-Message-State: AOJu0YzpI+OVp3kYwxyv+WnEDeI+LiIAHqYrdcVCQbM5UgkBmLShIQXF
 O7JXw9rGU+BDvLSnof7vtlZqLjCISOa6xXakZxA=
X-Google-Smtp-Source: AGHT+IGyjD92odW6+OyxUUw3L7hPD3UuRp0QRkK9wuFSsFemtY7hqYb06Qr3VBm64GvjrQ8swIUl+A==
X-Received: by 2002:a5d:6da7:0:b0:32f:952f:c51c with SMTP id
 u7-20020a5d6da7000000b0032f952fc51cmr3112670wrs.18.1699018476270; 
 Fri, 03 Nov 2023 06:34:36 -0700 (PDT)
Received: from localhost ([2a01:cb19:85e2:8300:dbea:ecb8:b89e:dd0f])
 by smtp.gmail.com with ESMTPSA id
 t6-20020a5d49c6000000b0031aef72a021sm1863124wrs.86.2023.11.03.06.34.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 06:34:35 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: Lukasz Majewski <lukma@denx.de>, u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-dfu-20231103
Date: Fri, 03 Nov 2023 14:34:35 +0100
Message-ID: <87v8ajm044.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Tom,

Here is my first pull request of u-boot-dfu which includes:

- Fix CRC chunk size in fastboot
- Make size optional for dfu on mmc

The CI job is at https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/18433

Thanks,
Mattijs

The following changes since commit cbba1b7766bd93d74e28202c46e69095ac13760b:

  Merge branch '2023-10-30-assorted-general-updates' (2023-10-30 16:01:54 -0400)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-20231103

for you to fetch changes up to 60d904a494c6e89c323bc13fa9348869e07e86d3:

  dfu: mmc: Add support for exposing whole mmc device (2023-10-31 14:53:05 +0100)

----------------------------------------------------------------
u-boot-dfu-20231103

- Fix CRC chunk size in fastboot
- Make size optional for dfu on mmc

----------------------------------------------------------------
Marek Vasut (1):
      dfu: mmc: Add support for exposing whole mmc device

Wojciech Nizinski (1):
      fastboot: fix CRC32 chunk size checking

 doc/usage/dfu.rst     |  5 +++++
 drivers/dfu/dfu_mmc.c | 10 ++++++++++
 lib/image-sparse.c    |  4 ++--
 3 files changed, 17 insertions(+), 2 deletions(-)

