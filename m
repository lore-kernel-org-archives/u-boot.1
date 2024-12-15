Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 957E5E7716A
	for <u-boot@archiver.kernel.org>; Sun, 15 Dec 2024 14:46:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE0048004F;
	Sun, 15 Dec 2024 15:46:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="fmHOEZM2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0D6280050; Sun, 15 Dec 2024 15:46:39 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6ED080040
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 15:46:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2efded08c79so2222159a91.0
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 06:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1734273995; x=1734878795;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=kyUP2J/ZvtP+fPkplWXNDM9zq5P9fQfgb1y+jTfUPAU=;
 b=fmHOEZM2AINJi7HhgjpwDcOa0kTQvRlOdcn1t79QQtmuAAVtJ2rhUQbpPsqkubUE0r
 dBxH404TS7etIoFeveKMGvlSMREIuhtGdd1JvUIfkUcI1fWfKRzBcrZNPm047j1xsYx0
 d0LR9yyQz0EAnobPk+LJh5QaeQsBwA7g4LkJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734273995; x=1734878795;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kyUP2J/ZvtP+fPkplWXNDM9zq5P9fQfgb1y+jTfUPAU=;
 b=TOSMpa9aQyMXqZvV6hdOf8fUmkXKJS1Gk1MBmMmUhsVpnCWLnOKnumdliQ8reiCn/S
 x1sO9u0xorB6WhRsZMcZkGGR3KCNJGcp6kOTmu2v7V7BUe83yKs9dB19XXZ8Vpj39WhO
 BiHz+bhau8d7VGZsCTlbG1hk9ZDS+PN8Kd5ppBwj8EuxUSLwycSoQWpoqEmi4P5P46Xq
 wvZ1CYaJ4QPayJN0e89fPJqjRuohX6cqJhfM9h3pWpAkNLWMkQmaSIIlS+ncl3c6PkrR
 U6WgcvS4uUxo66MEz343Gj4p1+M2P8qgUFGdoM+xUD9P7FzJyoR4qVyFyDfrYzZcF6JA
 g5/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCyH7AYe67eZMydIuJ+VvK5T58YtVWAg8ny1YvgRL2K0P77PtpE8ZyfhZDnFAY2A/BDrXX8PU=@lists.denx.de
X-Gm-Message-State: AOJu0YxAIwYNDWkY3BgICQjCW73myh1XzzQ3e1EciJERGxXW8Ujc00lm
 g1VsRXkyOLf11O3uC1Bj/AzH9wVJn5DAGGyad6UioEhC+zRy29aeRFjPFrhd1TV/jqWwynETiDe
 1hafJm/yUns8e6aU+9BlOkOX0pP1bhdiuwlBZxb0WLWYSstr1x6I=
X-Gm-Gg: ASbGncuJYVezQE83JMqMb/HXpX1eILYmNmVANm/ecormuLmf28n0jiZWdxPSWctm5rp
 tEV+SPqOIpJpSEb2NygDwj5OIhVeohoelTm7g5w==
X-Google-Smtp-Source: AGHT+IHbE70NYZdS7hbu3oEJf7N1bwX5C9YfbIlj+pZrVF/W/f6Cd7ORRuMU7qzQj9vleXUlGD622f2BgWo6/pteheU=
X-Received: by 2002:a17:90b:4f:b0:2ef:e0bb:1ef2 with SMTP id
 98e67ed59e1d1-2f28fd6b782mr13462444a91.19.1734273995039; Sun, 15 Dec 2024
 06:46:35 -0800 (PST)
MIME-Version: 1.0
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sun, 15 Dec 2024 15:46:22 +0100
Message-ID: <CAOf5uwnqcLbVH6Chd_rKc_Q5aEe0jC+-Z5g_K_nQD8wF+qmDOw@mail.gmail.com>
Subject: Pull request for u-boot-nand-20241212
To: Tom Rini <trini@konsulko.com>, U-Boot-Denx <u-boot@lists.denx.de>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom

The following changes since commit 9452fb7484118822b878ad445237d111b7b1a28d:

  Merge branch 'master' of
https://source.denx.de/u-boot/custodians/u-boot-sh (2024-12-11
12:50:29 -0600)

are available in the Git repository at:

  git@source.denx.de:u-boot/custodians/u-boot-nand-flash.git
mike/u-boot-nand-20241212

for you to fetch changes up to 65ac40c1e99826b346c5e3b829143902494415e2:

  nand: Add a watch command (2024-12-12 19:28:07 +0100)

Small addition to uboot-nand. Nothing relevant for now. Anyway
a nice new command coming from Miquel Raynal and small changes.

The patches pass the pipeline CI:
https://source.denx.de/u-boot/custodians/u-boot-nand-flash/-/pipelines/23837

----------------------------------------------------------------
Heinrich Schuchardt (1):
      cmd: mtd: simplify mtd_show_device()

Marcus Folkesson (1):
      mtd: nand: raw: atmel: remove unnecessary return value

Michael Trimarchi (1):
      nand: Add a watch command

 cmd/Kconfig                                  |   5 ++
 cmd/mtd.c                                    |   2 -
 cmd/nand.c                                   | 103 +++++++++++++++++++++++++++
 drivers/mtd/mtdcore.c                        |  22 ++++++
 drivers/mtd/nand/raw/atmel/nand-controller.c |  10 +--
 5 files changed, 132 insertions(+), 10 deletions(-)
