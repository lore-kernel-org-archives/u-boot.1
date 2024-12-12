Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC26E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 11:49:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67D8E801A0;
	Thu, 12 Dec 2024 12:49:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1734004171;
	bh=LbsV39nY8FZLZrf/SkwN4WX2uhgyN2cqA/fpugJsaJY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=f7Ucc5wkONTcXJzWVHmb7DL4q+oqir+wP9GF5IBDxYRgk8fBdY6s8vrap9S24HPN6
	 JkAppeHHHehXvMjIgDzIrk+nMHINYkfUr0ZGRGRQR6Bq99OPRSBwqy2AkfNx5tmUlo
	 nqpBwf5awdOQ3l59Xpmf5106kkKsJQ2UcWuo9oSXOYc/BbeQJkgH4ogsuVkGy2fvbe
	 aKZ1slw/cxbpYMp5DmDT4+sfHjye6RVQSlelUX2GByzUcLkTRkp2XuB31puCgbjhOv
	 FtPFUH2CqlNi7HQOidGOGLO4iYUoZ9aJak643cWQd8YtETeau7HBv/M7TorNI+WPln
	 gVODze0ChjO8A==
Received: by phobos.denx.de (Postfix, from userid 109)
 id A730D801DB; Thu, 12 Dec 2024 12:49:30 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E45E480196
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 12:49:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="KQ/Mi41M"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C11801047DC21; Thu, 12 Dec 2024 12:49:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1734004166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=LbsV39nY8FZLZrf/SkwN4WX2uhgyN2cqA/fpugJsaJY=;
 b=KQ/Mi41MHSQUeYx29Pd6H+7A2dU58PwrDyzXeMHaonWK56zXdLq40HhgYJatyigUTiDkvb
 LdyAFpilMqPHJPemCw3Bz71Oe0kngUBtYZ4NDH7R8MsmNuM1nIbbfM1ecCTTz7ipfW/iDZ
 QGsCnHZyLmothCThb8kmTuWOuCPz/oERRP546nF9AfMH5bFDW5Otk6pz5Vgn6qRHg7qjrD
 TepuF7Avgw9EfBNiUwx2jPWIIh7WvzRwI+rWpWXh8qNiT//1nuimM6qUjOkDhWU1JKs+4u
 NbK8bHi/rVsQXxy9dxyjnvQO8FQu6+Q+Pm+acsxOnCAELcWUmlFrlK9dOZClvw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PULL] u-boot-usb/master
Date: Thu, 12 Dec 2024 12:49:08 +0100
Message-ID: <20241212114911.21435-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

The following changes since commit b841e559cd26ffcb20f22e8ee75debed9616c002:

  Prepare v2025.01-rc4 (2024-12-09 16:09:28 -0600)

are available in the Git repository at:

  git://source.denx.de/u-boot-usb.git master

for you to fetch changes up to 0e24474cc323a9012bf1f0942f46d1053e326b3f:

  usb: onboard-hub: Update the bind function based on peer-hub property (2024-12-11 08:22:17 +0100)

----------------------------------------------------------------
Venkatesh Yadav Abbarapu (1):
      usb: onboard-hub: Update the bind function based on peer-hub property

 common/usb_onboard_hub.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)
