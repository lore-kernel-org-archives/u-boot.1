Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97AD9CDD0E2
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 20:09:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E33F89024;
	Tue, 22 Oct 2024 22:09:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729627786;
	bh=g/fdu4MA89T36EmsaH3eXahU9O7ShaB7zxrpWK+vtEY=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bV+2Z1OiGVWrTmwlVoIsPozC3g/76GKIL/nFh7HtwYWwZpUH2M9CVgcCLi1k/9lYR
	 9U+8wo96O7leKbrzW1oynzUzWn9zHOAdSUrcY7iHadLgVPPcyUXHXLDiLcVVH91dN+
	 quXuHWrFCCOZXKk+QDNOAAoF+aXItN1wL1AhwDa5xhqNAPlmd+HrJXUuwa64yQfGPh
	 ZRztRl2IMzD2D4+7Ho0BCUOLZ32xMW//Eu75BD5CMEmzS3iqXWoJ5ztqKxxpx41C7i
	 bbCqo7TwY80D5O+v1gmTu2wU66iOXtt9C/XeG/AyobbXZFGbMlNRDGWh31lqcI0ffs
	 fQYT8ZY3ilwfQ==
Received: from crub (p5483347b.dip0.t-ipconnect.de [84.131.52.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: agust@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 1C24088FA5;
 Tue, 22 Oct 2024 22:09:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729627785;
 bh=g/fdu4MA89T36EmsaH3eXahU9O7ShaB7zxrpWK+vtEY=;
 h=Date:From:To:Cc:Subject:From;
 b=JuGBcL8315tknWZhAgNO96ox+pof4+guv3ROb4INMR0iALc41sJXXOH8K+JaSXS9O
 EVFPCXyzqF9DZ3/HHPYWynHQe0N7CiDKrTRrJbRUH5/EOqfeDwbzG1khv8kgtostE5
 25qF9GPuysJbk3CV70NZLz8sMrR8zKjbaM8nEuwu6h1SAIU9/L5q1PkCJ52j9YUm8+
 mYj74BIkJdBAU9bnovY1wv9czsJTcvZNAKyzZgSKyVRwvCVn39yael4O2tiz91LvWm
 KhqI9L9lNkubZXLxY/V44UgtE+/o/ib8cTI5cy4siHtyF2lOXJK083W/VxpCGy4Zrp
 Twk/rpSjvh2ag==
Date: Tue, 22 Oct 2024 22:09:44 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] u-boot-video/video-20241022
Message-ID: <20241022220944.45a4eb2b@crub>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

please pull video driver updates.

CI: https://source.denx.de/u-boot/custodians/u-boot-video/-/pipelines/22907

Thanks,
Anatolij

The following changes since commit 6606a6adfaf8517cff7e5fe0fb206beed80087d5:

  envtools: make them build again (2024-10-21 20:51:23 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-video.git tags/video-20241022

for you to fetch changes up to 722073a0653dd18d0148dd435f067be4e82f9129:

  video: simplefb: Fix build warn with CONFIG_FDT_64BIT=n (2024-10-22 20:56:28 +0200)

----------------------------------------------------------------
 - VNBYTES() comment fix
 - add VIDEO dependency for FDT_SIMPLEFB
 - fdt_simplefb: drop not needed CONFIG_VIDEO check
 - am62x,evm: preserve splash screen while OS is booting
 - simplefb: warning fix for CONFIG_FDT_64BIT=n

----------------------------------------------------------------
Devarsh Thakkar (3):
      boot/Kconfig: Add Video Kconfig as dependency for FDT_SIMPLEFB
      boot: fdt_simplefb: Remove conditional compilation checks for VIDEO Kconfig
      board: ti: am62x: evm: Update simple-framebuffer node in device-tree

Eva Kurchatova (1):
      video: simplefb: Fix build warn with CONFIG_FDT_64BIT=n

Miquel Raynal (1):
      video: Fix VNBYTES() macro comment

 board/ti/am62x/evm.c     | 21 +++++++++++++++++++++
 boot/Kconfig             |  1 +
 boot/fdt_simplefb.c      |  2 --
 drivers/video/simplefb.c |  3 ++-
 include/video.h          |  6 +-----
 5 files changed, 25 insertions(+), 8 deletions(-)
