Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F10C636E3
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 16:45:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B54388916;
	Wed, 28 Aug 2024 18:45:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KDOLHeHS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7B5988916; Wed, 28 Aug 2024 18:45:34 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DD808862E
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 18:45:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-81fd520fe0dso259360339f.3
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 09:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724863531; x=1725468331; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8qFAx1sC6oRzF/22o7yKATajbgnq6EMvehikwU8xP7o=;
 b=KDOLHeHSSsnuswWgLrnB/eUFokNEyyIlKrUaURqtHXAV8OaPmcTE07DkypMcUXGB+l
 dKfl4comLBVHVFtDEhHrstrXpChLq7oEOu6rKrGcJivmqO30H8+JkY9yxbLET5E/CUaC
 terN29kyG4HucRruoP3ybhbAQ38gq4oej3Q9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724863531; x=1725468331;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8qFAx1sC6oRzF/22o7yKATajbgnq6EMvehikwU8xP7o=;
 b=UXQUENwprE4UN6c2hdYhQmmiFdUgdRHJk4MZ8fnHlmC5rytH8dQVkSFBIbAFyX3Thn
 iOkR7L7/JrpNpwXSocrHTWqcd/TNPEpfuzmIkoe952donsbcyq6GlRmwelWlEIO05dF4
 qG9Izb+GD7a91qIxdE4/D2FF2/jxm9GqAeyDvoG/ffCikP30IFJg77MBHSrL7SKex5wE
 fKPVD24At0UkERLCnPgCU8xDNgZRi1KHN1aa7HI6+WuZNvMv3iuUHHusN0aLmknOusHQ
 KxLDAjFWEELcBZijJHOU2Tp55YTaQQ5R5hLlS5P8+rOcdm8BSjLf24hbT+9PXz94VW+y
 +vIQ==
X-Gm-Message-State: AOJu0Ywhd28hv86OKfOKk9csChJaqwmcIj8P+gfm3edYQFwrVqpPoPSH
 ritIAbvhSdVMfB+i01pQo88S6Qrbr/xtC6xCWpYDNod/pixdNl4F1KvRbsmHcOYiwCZBgDPeH6g
 =
X-Google-Smtp-Source: AGHT+IG5OQNqS59ncqau56Pv62b2slXKt7JjG1jvdetOP5o70vYosXLQ6uN6r7fUbz32RiD/4pwDHA==
X-Received: by 2002:a05:6602:15c6:b0:81e:4ef0:3a81 with SMTP id
 ca18e2360f4ac-82a1109c87cmr18570639f.16.1724863531177; 
 Wed, 28 Aug 2024 09:45:31 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-82a0ffed35dsm5530939f.31.2024.08.28.09.45.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 09:45:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [u-boot-test-hooks PATCH v4 0/3] Add support for Labgrid
Date: Wed, 28 Aug 2024 10:45:20 -0600
Message-Id: <20240828164523.125770-1-sjg@chromium.org>
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

This adds hooks for use with Labgrid. The only existing hook that really
does anything now is the 'console' one. There is also a new 'getrole'
hook which looks up a role to find various things about it, such as the
U-Boot board name.

Changes in v4:
- Use an environment variable to select the Labgrid hooks
- Add new patch to add .none scripts for power off/on
- Support pytest fully with dual-build boards like Beagleplay

Changes in v3:
- Fall back to conf.${board_type}_${board_ident} if conf.all missing
- Update scripts for latest version of Labgrid integration
- Add poweroff.none and poweron.none
- Provide -n flag when querying board info
- Target the grpc version of Labgrid which is now in -master
- Update README to cover the changes

Changes in v2:
- Make use of the common script (only) to set bin_dir
- Make use of the common script (only) to set bin_dir

Simon Glass (3):
  Create a common file for test scripts
  Add .none scripts for power off/on
  Provide some basic scripts for Labgrid integration

 README.md                    | 50 ++++++++++++++++++++++++++++++++++++
 bin/console.labgrid          | 42 ++++++++++++++++++++++++++++++
 bin/ellesmere/common-labgrid | 46 +++++++++++++++++++++++++++++++++
 bin/ellesmere/conf.all       | 24 +++++++++++++++++
 bin/getrole.labgrid          | 25 ++++++++++++++++++
 bin/poweroff.none            | 22 ++++++++++++++++
 bin/poweron.none             | 22 ++++++++++++++++
 bin/release.labgrid          | 22 ++++++++++++++++
 bin/release.none             | 22 ++++++++++++++++
 bin/u-boot-test-common       | 36 ++++++++++++++++++++++++++
 bin/u-boot-test-console      |  8 +-----
 bin/u-boot-test-flash        |  8 +-----
 bin/u-boot-test-getrole      | 38 +++++++++++++++++++++++++++
 bin/u-boot-test-power-off    |  8 +-----
 bin/u-boot-test-power-on     |  8 +-----
 bin/u-boot-test-release      | 26 +++++++++++++++++++
 bin/u-boot-test-reset        |  8 +-----
 17 files changed, 380 insertions(+), 35 deletions(-)
 create mode 100644 bin/console.labgrid
 create mode 100755 bin/ellesmere/common-labgrid
 create mode 100644 bin/ellesmere/conf.all
 create mode 100644 bin/getrole.labgrid
 create mode 100755 bin/poweroff.none
 create mode 100755 bin/poweron.none
 create mode 100644 bin/release.labgrid
 create mode 100644 bin/release.none
 create mode 100755 bin/u-boot-test-common
 create mode 100755 bin/u-boot-test-getrole
 create mode 100755 bin/u-boot-test-release

-- 
2.34.1

