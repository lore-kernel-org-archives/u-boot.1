Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B35C9EE49A3
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 13:42:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DFF1863EE;
	Wed, 23 Aug 2023 15:42:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eLsaajhe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63D6A863E7; Wed, 23 Aug 2023 15:42:19 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A8D2862EB
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 15:42:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-7925f7d5142so10454039f.2
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 06:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692798136; x=1693402936;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0S9hRUIZ7QAoq9esPRhikOnNBNhsMGYhiKHgLjrwZoQ=;
 b=eLsaajheprR8gZbHtEDR5pPtziK2ndsaki5y87+pt6ACePqUTYhqjwBSIV1FEVoNZo
 Dq5b357un4acFN/xujSfWSOPywBhM/fIdV3GFd0moNB1gftW4sryH9jXTi5rxovpCYzO
 xxHb+P86+ghHtneSYPO1HcU27c+xYNyZw+9ec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692798136; x=1693402936;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0S9hRUIZ7QAoq9esPRhikOnNBNhsMGYhiKHgLjrwZoQ=;
 b=hZ9ivbO7af3ZF9I0fCsmOtyMU6ZzDBB5qxbZ6KQ4M4f9ViAn5IMM5Bk6qLiNP/Gh0I
 3mrzJwBG8O73GbSzKetlB+TmYXxnOhkyxqDan3PTZjhGK/U6Mv5YADXhhP7RZq8KzXPy
 uF3XlLmkkjS1SCNO1YMeIZq2xSCdzGtLz7lbbl3IhqZDsEl7/s5ZXMmZ9PeRG/jMLzci
 7qLKOJZmDBdZVk07VPQbBAJJesAe5C3xcsEeMvqn6Mcs2weFd7LKFoKG5E3YwxK/8QOR
 WFsChsoLK9waFXCt97uy/1U6DEj7RMEKSaQaI0eVPPicwYFwp6qyFFPNoIquG1YTJpmK
 kqKA==
X-Gm-Message-State: AOJu0YyhdHwF4uEH9ubv50LU+1v2CFNKBI+YiA+WfIumXCBSvz9elJYN
 JGsxUeFSTCj+Dc6Ujlp8y7x/AkV8/F6IzMRnMWg=
X-Google-Smtp-Source: AGHT+IFexqtEZbGEPDX+x05wpThXmwL8Up6X+uBJd7CFRmSMh7SpbQ2OCQOZeAw890IbcZqXC3kqbA==
X-Received: by 2002:a05:6602:68a:b0:790:b399:3ae9 with SMTP id
 dp10-20020a056602068a00b00790b3993ae9mr2989523iob.14.1692798135547; 
 Wed, 23 Aug 2023 06:42:15 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 m13-20020a02cdcd000000b0042b4f9ddecasm3800233jap.85.2023.08.23.06.42.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 06:42:15 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sjoerd Simons <sjoerd@collabora.com>
Subject: [PATCH 0/7] Correct confusing lmb error message
Date: Wed, 23 Aug 2023 07:41:56 -0600
Message-ID: <20230823134209.1450567-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
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

I ran into a very confusing error message about overlapping memory. I
found that the message is not correct, so this series refactors the lmb
code a little to permit the real message to be displayed, which is that
the internal lmb table has overflowed.

It also tidies up the code a little.


Simon Glass (7):
  lmb: Drop surplus brackets and fix code style
  lmb: Tidy up structure access
  lmb: Avoid long for loop counters and function returns
  lmb: Change functions returning long to return int
  lmb: Tidy up lmb_overlaps_region()
  lmb: Document and tidy lmb_add_region_flags()
  fs: Fix a confusing error about overlapping regions

 fs/fs.c        |   7 +-
 include/lmb.h  |  29 ++++++--
 lib/lmb.c      | 183 ++++++++++++++++++++++++++++++-------------------
 test/lib/lmb.c |  42 ++++++------
 4 files changed, 163 insertions(+), 98 deletions(-)

-- 
2.42.0.rc1.204.g551eb34607-goog

