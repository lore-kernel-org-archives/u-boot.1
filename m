Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FFFCE7716A
	for <u-boot@archiver.kernel.org>; Sat, 14 Dec 2024 18:20:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1773E80081;
	Sat, 14 Dec 2024 19:20:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="j05uUBNy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB0DA8007A; Sat, 14 Dec 2024 19:20:36 +0100 (CET)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C31680073
 for <u-boot@lists.denx.de>; Sat, 14 Dec 2024 19:20:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3a9cdcec53fso24472935ab.1
 for <u-boot@lists.denx.de>; Sat, 14 Dec 2024 10:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734200432; x=1734805232; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=e2mbZz2po4gMCBplyf2+5gNwgauBG87rWGsHO37/WMI=;
 b=j05uUBNyDwB90HAX4YLyLy57+N7dKsZv945lySZin+/tahczoYhxvojsUpUwfWvuJD
 qKk/swPwMTN0cuieAWOy4pkgVpoHbJukGrqHC+3hY7frWGOV1bQ6jSd0BLiJ1l3yKaHB
 rvCSgZxNyWsJBb3oUGLdXJ3u2rdTrAX+g1Is8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734200432; x=1734805232;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e2mbZz2po4gMCBplyf2+5gNwgauBG87rWGsHO37/WMI=;
 b=pJley4ptJqn7WySPzLSXefiKHoRPpqw4fr7W4eqOs6US8DmFR5sZGIwk/Azg41tWI/
 yZrAprrw2fleKnBEAYFFyP8skMHLTc7J904mWVegQ2NYUcVaCvfl9czLf+pgHB2t0/zz
 aKVU/8ZTBNjV8SY7Cr9EL+Eot7ywO0n6tzDjrALkZ7Ps6NB1eXkkY5LXT9V/dylEQWCy
 juiOexnTf2VV+kxeZ6vy8nQIk1YKlbd0r5SoZDm/vel4hv/7wXpUxxYHRGaW7rJyJgrr
 QNKMzZSkdRQStypQyPjpkIZD6eTYfwfFT0Jaos5/+WP0YHkz2Z7/W9bqr7yfl+JBmii8
 1KPQ==
X-Gm-Message-State: AOJu0YwXggwsIVixLDY0DmumDtnk7JUGP1zEkwkfHymOQw7aLzhpe8PT
 cwvwK579EacnkaVcuD0+io9Boczvf5CVOIi8D6VN9iOLoeWH/ja0CXMp2Zeo1L2cOQudydt8zeo
 =
X-Gm-Gg: ASbGncvgyDQ+nS8FnuexussHT2IdLrZKambBecfL0PPesKMJz4qPOmAbmhimrzr0tot
 AbdzRHAS2iGHe3S9k0kmLoqkC4JAuJPl2jzYiirxqY9v0dDwkVZaYPIT0TwKTeCAmYfdWRBGzaV
 4/F1Kqrxqv/QUT+9WOxm/4vdLYlN+Ao2Am8pUVS/NLKBfjOzX8xRw43VYR/fM7SQKo0BrycRpPj
 pUZytyVOz5EB9ZTJSDPw+zCC6Q62CzE5srAIklIwK20JTFve/5zzWEaFBqueHHOnfnquQsmuKjx
 V2vx1n2NKM4b2BQy6g==
X-Google-Smtp-Source: AGHT+IFFHc5oE7iWte7/cF4oLeX7NVSR6JStT4X6zNtId4Oaoz4zD3EbQ1wKRCbJCHgPOgsCLgs+eQ==
X-Received: by 2002:a05:6e02:174e:b0:3a7:66e0:a98a with SMTP id
 e9e14a558f8ab-3aff6020017mr68710865ab.9.1734200431827; 
 Sat, 14 Dec 2024 10:20:31 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e5dd620e20sm415135173.0.2024.12.14.10.20.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Dec 2024 10:20:29 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH 0/5] gitlab: Fixes to get StarFive VisionFive2 into the sjg lab
Date: Sat, 14 Dec 2024 11:20:19 -0700
Message-Id: <20241214182024.1954974-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
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

This board fought valiantly against attempts to add it to my lab. After
several hours of debugging, I found problems in the Labgrid integration
(not included here), test.py and buildman

This series fixes these and the board now seems to be reliable enough.

Note that the board fails test_dm_compat

Link: https://github.com/labgrid-project/labgrid/pull/1411


Simon Glass (5):
  test/py: Provide the correct U_BOOT_SOURCE_DIR to getrole
  test/py: Handle u-boot-test-getrole failure
  buildman: Drop unused OUTPUT_FILE constant
  buildman: Record an error if a toolchain is missing
  gitlab: Add a StarFive VisionFive2 to the sjg lab

 .gitlab-ci.yml                  | 5 +++++
 test/py/conftest.py             | 9 +++++++--
 tools/buildman/boards.py        | 1 -
 tools/buildman/builderthread.py | 8 ++++++--
 4 files changed, 18 insertions(+), 5 deletions(-)

-- 
2.34.1

