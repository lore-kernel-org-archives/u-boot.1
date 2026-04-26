Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 046C2FF885E
	for <u-boot@archiver.kernel.org>; Sun, 26 Apr 2026 19:45:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD90883FDB;
	Sun, 26 Apr 2026 21:45:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="iX3zyV7y";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xNh1jGHr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0C1883FF5; Sun, 26 Apr 2026 21:45:24 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4D45839D9
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 21:45:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+usb@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4g3ccK12h3z9tWd;
 Sun, 26 Apr 2026 21:45:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1777232721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=mBtVZ/2NyFDmaKxo1Ib/4gTjvzfpd52dqQ2B4ERaxf4=;
 b=iX3zyV7y9sYHjmiW05VILFAT75PotMzzV+GosWQzyhkBPhTooY+ILFHHznJUgCVdjFXNp3
 9+ivAF45Vg+WGJdM+cYo537TK60qugSK8eZyaKgzV1R+ASqi9F9rHsOqDkRc0JRM9fT2q2
 sidPIZjcewdLZfgVlyC1whhzlU4dlV0pTxd0vdEXmUOthcxt54Zp8BnHoNeXBOAhyuadH3
 /Fg5wJBAimvIPKLmZ7GplUay5U8xU9zfaPSxF016NZ3EnIHuCwUVxqZFab7dBl7Zqqcfvz
 VYFczhTvFm0SxBZ+fcD1VsFuntnT5X3Wr/LTwGQJS+vAgtqPQwfB5tbtWWCMfw==
From: Marek Vasut <marek.vasut+usb@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1777232720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=mBtVZ/2NyFDmaKxo1Ib/4gTjvzfpd52dqQ2B4ERaxf4=;
 b=xNh1jGHr4TadIhd+OqLomP/SIDLfevobMKKIo8+Lu71qxUiyrqa6krREgg6Funucp2kIWH
 3HhTaCEYCLM8jWzimn0UuIpV3oie5w/cLbL4BLTda6JD97Hrm4pzc8Nn+z5z/xivE4Ddhz
 RSNkOLkXR6lO8CnVAcGxy7V0xt4C6Sagi/6E2gGrWr8uE1SRBrl0Tuc8ZLIhElpLiTS3K3
 Jgz49qPnwshTTnqxksK0FokDtKQbHnZKp23VRezQoToXJUhoI+pObHqGFJxsK30HjepUaN
 xO0Dxrf06OksBSckgHTTtGTTeCIcWkv+Qq8d+MA6C+kGb98Tmu7XXdmycFNnNA==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>,
 Michele Bisogno <micbis.openwrt@gmail.com>
Subject: [PULL] u-boot-usb/master
Date: Sun, 26 Apr 2026 21:44:51 +0200
Message-ID: <20260426194506.220004-1-marek.vasut+usb@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 3b4pr896ff3n68etru1a9ky817xmz8bs
X-MBO-RS-ID: 9d83332072a112dabe6
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

The following changes since commit 9f61fd5b80a43ae20ba115e3a2933d47d720ab82:

  Makefile: fix host CPP pollution in cmd_gen_envp (2026-04-24 12:49:27 -0600)

are available in the Git repository at:

  git://source.denx.de/u-boot-usb.git master

for you to fetch changes up to d0d1d11119282b76551d45e531235238da51d7bc:

  usb: gadget: rcar: Add support for RZ/G2L (R9A07G044) (2026-04-26 17:52:36 +0200)

----------------------------------------------------------------
Michele Bisogno (3):
      usb: gadget: rcar: Fix gadget registration lifecycle in remove
      usb: gadget: rcar: Add support for reset controller
      usb: gadget: rcar: Add support for RZ/G2L (R9A07G044)

 drivers/usb/gadget/rcar/common.c      | 65 ++++++++++++++++++++++++++++++-----
 drivers/usb/gadget/rcar/renesas_usb.h |  1 +
 2 files changed, 58 insertions(+), 8 deletions(-)
