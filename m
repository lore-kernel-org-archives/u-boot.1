Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40BB4CFD312
	for <u-boot@archiver.kernel.org>; Sat, 22 Nov 2025 22:18:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4A0183AB8;
	Sat, 22 Nov 2025 23:17:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="S3lnOv0w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 276C683B55; Sat, 22 Nov 2025 23:17:58 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25AA383A36
 for <u-boot@lists.denx.de>; Sat, 22 Nov 2025 23:17:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1763849875; x=1764454675; i=xypron.glpk@gmx.de;
 bh=fuCW19/d2uZEqYdP5CU4mxerPYfPEc6J+dxWU57XE+0=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=S3lnOv0wfopKCl9Pkd8XYOjJL0TbPCX1fCruFg1tDLEJKdRpS0mpoYzXKonYVGQ6
 Y6JZSpLnaysbgKUSAN50PKKeWpPIU2wj2py3W4BlNjVBg2ZFUB/U+fMKAOubthkuC
 pl3GREosNi0z1cG+RuF07rBlBxJyPFWtyggYIgMmJeCDNdL4lRrPcU05GIRYeVR75
 aId5Svn92yseiPPBSjSJtPhB7nuFZTi2wtxuZbBwct9LtVgVSj55Az9xjuv20MT7B
 IuKYAfAx/c7EwiMfkQHMJJTkHoQUDH9WhKq+1H5QvJ2wQmFuEd5uhbF6zLZOik+ER
 a1hmrGf+BpSFcrMJlQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from LT03 ([46.114.110.111]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7sDq-1vQlPM2vY2-007Qb6; Sat, 22
 Nov 2025 23:17:54 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 0/2] doc:  add a page for downloading the U-Boot logo
Date: Sat, 22 Nov 2025 23:17:36 +0100
Message-ID: <20251122221738.238704-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:syAcSvoL96IKr57wr6UNaTDqUtTBA71oXxNKUsLRRblLC2O98Zu
 1XghIkiRUil7Q/U13d5hoUXTBpqHJL428xvAv8UqtH4fzVVz9RqUrrJ1xJ3Sfex+6WY/5sp
 N6Qab5BzEnZLHrEwP0tMGCz8Qqn/KAGBEH5h5awTWceoRwP6vcPneOAR63HM5TSzAHX4CrR
 SZ8i14Blk/DqzVlshUDXQ==
UI-OutboundReport: notjunk:1;M01:P0:P5hDCeK8JuI=;te+lteVCVfzSoJcMj15XSUbxwat
 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
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

The logo with the text 'U-Boot' has been used in multiple presentations.
Up to now it was only available from my upload to wikimedia.org.
Make it available in our repository.

Add a documentation page showing the logo with and without text.

Heinrich Schuchardt (2):
  tools/logos: Add U-Boot logo with text 'U-Boot'
  doc: add a page for downloading the U-Boot logo

 doc/learn/index.rst                   |   1 +
 doc/learn/logo.rst                    |  20 ++
 tools/logos/u-boot_logo_with_text.svg | 280 ++++++++++++++++++++++++++
 3 files changed, 301 insertions(+)
 create mode 100644 doc/learn/logo.rst
 create mode 100644 tools/logos/u-boot_logo_with_text.svg

=2D-=20
2.51.0

