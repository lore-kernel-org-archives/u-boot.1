Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E4E9C27C4F
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 22:27:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7E9988664;
	Tue, 11 Jun 2024 00:27:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="B5N+kZPW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0012588675; Tue, 11 Jun 2024 00:27:55 +0200 (CEST)
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com
 [IPv6:2607:f8b0:4864:20::d42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0C08884E7
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 00:27:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd42.google.com with SMTP id
 ca18e2360f4ac-7eb7c8f114eso84363839f.1
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 15:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718058472; x=1718663272; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DTwC9uDVPglbUOeyPPJcHhleADBzqMToSH0r+FhK0jU=;
 b=B5N+kZPWSFpQRXf+91Rfpc3Oh4YirZNJ3Lv28PeHuVEs3pymxY79FaUwxEUGaS6SHt
 Iq9KeKiPL7uixxUJFUAT9+mWgpyVPpioqt5utHXfWm9xt7DXBrBh9siFdxdnHzEwVptw
 eQ3KlsUjmnkKMfj7gnBcoTJQ94JECF6nyQX1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718058472; x=1718663272;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DTwC9uDVPglbUOeyPPJcHhleADBzqMToSH0r+FhK0jU=;
 b=HLDjJVIJrj+hDazyVnqippgOliGHCUWFKQ948lCyNNGzqFmWwtJLdnY8iqY6N9Aro+
 4St5uJ2IpJ1XYLBWYNJacSpKgVqaS/tybFYrYkZRxEDxUjIMJxDQwvhiS/Y1+ybh4ioh
 R0Ql/tDkFFEemMkoesIZf0v7UR+8WWOhe5cn1P+B/ftvsvJjjx2Z21KRVmOjCkzxwjyT
 ZFfiBmNcJziE5yuiwYYRJo/EO/fGy6fXZHzh5fDxJz6RHy1j+A4WBXabBSBvqsv7+mAE
 V9QY91aHa3KFvZdo3SvYi2REShZYpaR9XBt8Vcpf34PecaKmBQZ+B/uoKQ6ZAAGN30Jk
 R9sQ==
X-Gm-Message-State: AOJu0Yxq6sUKCGeoniGiqCQ3MXeKzCp6gzL0Fzz4lMKra3fVaEw31Ul5
 AMBLBLgE8J2YWP5EkQOKBKp3IOe9Aap/w/0CF7JQbIBBXuJqXNRgj5+MMrpLcBoaintMyBfpm1a
 H428R
X-Google-Smtp-Source: AGHT+IFN8cUXtzfKphNBS5002a2HJPc/x6TsNaCYD9Fxk+OUTn7jwsPDX84Z4d51tRnKqDvyooAdBA==
X-Received: by 2002:a05:6602:1507:b0:7eb:6437:203e with SMTP id
 ca18e2360f4ac-7eb6437298cmr1133577739f.17.1718058472233; 
 Mon, 10 Jun 2024 15:27:52 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b90e06ead0sm1181665173.74.2024.06.10.15.27.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 15:27:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [u-boot-test-hooks PATCH 0/2] Add support for Labgrid
Date: Mon, 10 Jun 2024 16:27:41 -0600
Message-Id: <20240610222743.255386-1-sjg@chromium.org>
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


Simon Glass (2):
  Create a common file for test scripts
  Provide some basic scripts for Labgrid integration

 README.md                    | 33 ++++++++++++++++++++++++++++
 bin/console.labgrid          | 42 ++++++++++++++++++++++++++++++++++++
 bin/ellesmere/common-labgrid | 31 ++++++++++++++++++++++++++
 bin/ellesmere/conf.all       | 24 +++++++++++++++++++++
 bin/getrole.labgrid          | 25 +++++++++++++++++++++
 bin/release.labgrid          | 22 +++++++++++++++++++
 bin/release.none             | 22 +++++++++++++++++++
 bin/u-boot-test-common       | 35 ++++++++++++++++++++++++++++++
 bin/u-boot-test-console      |  7 +-----
 bin/u-boot-test-flash        |  7 +-----
 bin/u-boot-test-getrole      | 39 +++++++++++++++++++++++++++++++++
 bin/u-boot-test-power-off    |  7 +-----
 bin/u-boot-test-power-on     |  7 +-----
 bin/u-boot-test-release      | 27 +++++++++++++++++++++++
 bin/u-boot-test-reset        |  7 +-----
 15 files changed, 305 insertions(+), 30 deletions(-)
 create mode 100644 bin/console.labgrid
 create mode 100755 bin/ellesmere/common-labgrid
 create mode 100644 bin/ellesmere/conf.all
 create mode 100644 bin/getrole.labgrid
 create mode 100644 bin/release.labgrid
 create mode 100644 bin/release.none
 create mode 100755 bin/u-boot-test-common
 create mode 100755 bin/u-boot-test-getrole
 create mode 100755 bin/u-boot-test-release

-- 
2.34.1

