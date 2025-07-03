Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A35C83F03
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 14:11:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1731D8206E;
	Thu,  3 Jul 2025 16:11:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GOxl7ly4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 767DE82E08; Thu,  3 Jul 2025 16:11:40 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EB0A82063
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 16:11:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 2F8A3A5387B;
 Thu,  3 Jul 2025 14:11:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B82C4CEED;
 Thu,  3 Jul 2025 14:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1751551896;
 bh=ii+6zZ7gPCLM7Th5hpEZ0QbKx+YcBxor6tlL37sqc68=;
 h=From:To:Cc:Subject:Date:From;
 b=GOxl7ly4ZgZwcXRapyuT537CmjegKsH9Y9ghgR8qLihuPAAsKl5xW69uMYxk1y/dM
 DbOr5XwRYzHzcnL5yQMT7FrzSvLF0XhHAKdAZzzJWGcksJ7JlO57SeRF/eKSnQYfE2
 nrvaHBvUlgwLNDiZKeohd9A4Na0qsDaXCuQzitDhl0uunIG8jGfWDIKvKd/DCNvw3B
 YsZ3+LMo22Vt69aVcou9SHk6WjKkziwTH35WZuZyipsu/9eH1i4vw4DoPD9srXbONt
 P4Crs4reAmHpWUe7kvUp6Tnd6zv6sExJSMk3m+SzmjSCz+i1eEmprwRi4+anTahuwr
 nRM1WJwN+n8PQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Andrew Goodbody
 <andrew.goodbody@linaro.org>
Subject: [GIT PULL] Please pull u-boot-dfu-next-20250703 into next
Date: Thu, 03 Jul 2025 16:11:34 +0200
Message-ID: <87pleh4b55.fsf@kernel.org>
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

Please find the following fixes/developments for next:

Android:
- Fix uninitialized vhdr pointer in image-android.c
- Fix uninitialized vhdr pointer in abootimg cmd

DFU:
- Update maintainers file to include spl/spl_dfu

CI Job:
- https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/26938

Thanks,
Mattijs

The following changes since commit cbb5672790d400e9ec6e9fceaf89ece2660c0117:

  Merge patch series "binman: properly error out if path provided to key-name-hint in signature nodes" (2025-07-01 10:52:04 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-next-20250703

for you to fetch changes up to 4b489f517366595cd3f003d4175e721bd927a18b:

  boot: android: Prevent use of unintialised variable (2025-07-02 12:10:25 +0200)

----------------------------------------------------------------
u-boot-dfu-next-20250703

Android:
- Fix uninitialized vhdr pointer in image-android.c
- Fix uninitialized vhdr pointer in abootimg cmd

DFU:
- Update maintainers file to include spl/spl_dfu

----------------------------------------------------------------
Andrew Goodbody (2):
      cmd: abootimg: Prevent use of unintialised variable
      boot: android: Prevent use of unintialised variable

Mattijs Korpershoek (1):
      MAINTAINERS: Add common/spl/spl_dfu to DFU entry

 MAINTAINERS          | 1 +
 boot/image-android.c | 2 +-
 cmd/abootimg.c       | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

