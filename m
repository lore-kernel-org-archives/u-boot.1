Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0135C54FB3
	for <u-boot@archiver.kernel.org>; Thu, 29 May 2025 03:30:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FB3C83542;
	Thu, 29 May 2025 05:30:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="a4ukmbSB";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="B7qzYcAo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 201778354B; Thu, 29 May 2025 05:30:27 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4041183487
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 05:30:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4b7Bhb65wfz9slx;
 Thu, 29 May 2025 05:30:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1748489423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=iFK+KCrR12ep4x16opOMvpQVOcdPc7SwILgI5Th5jcw=;
 b=a4ukmbSBGD0nP51K91epEGPsofPaz34+CCeVRVsjmSP4JPYxdtbXIKWXniFxDI8gtejoMY
 Itk17RE1oJ3Ae6bOkrmAuncznwvTIDwjNqwVwNFe6Tn4H2cRVQ+S/QlBQz2D5ycavRGUGG
 qu7uR4yPc4q1F9ToDl0QDAY2puHktkSmxpuVEvo+SlE0BxK2Q0/OXS4TPNm+RLRnM6awv9
 ljVBHBC7JexQRbqOcLiCu4PjZE2WM9H8e5AsLDAGPuOOqOfjKjLFGpibsQjBK0Rm6+R/9C
 y4xsUf4+fqsttTLSZOjsSjrp4Q8N/le3rfjU2svKw0nDojOeAjjaSpugVoCjFA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1748489421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=iFK+KCrR12ep4x16opOMvpQVOcdPc7SwILgI5Th5jcw=;
 b=B7qzYcAohwlfBI6J+l9DrhmreEZZGFTscxmksINaIaByA6MWB4c3uoJOgpFO6vS/gUoOxQ
 swghnIubh/IG9eRCcR+ILHDPo+SrejOCzllqft5YtlzCq82VGerNjFKKR6pfw8wrz+9svx
 4MegZDXsKi6g/ibBJdzR88PoKKlba5IZcZ35ZzuIOuFbD1qDIpAQw3yvfCibEiMkFs6Od1
 tRsyJx+7CpeOeY8+cwjI++PJFIiWG92C/69K1fWrZ/Wa8Tc4E80DHJLUOXeT6VGC5IzbQa
 MjbY/T3fypzK5I3tuHf+9XTQ2Y/1lLH79WdIpNze9gkGBdkIqMMCGi9qwHSHnQ==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PULL] u-boot-sh/master
Date: Thu, 29 May 2025 05:29:50 +0200
Message-ID: <20250529033008.109416-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 9557cc6a33b6d7cfae0
X-MBO-RS-META: 98f6mqbg7nczf4y4dn7a59ao5cr18cnx
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

The following changes since commit e04d137231f2e9e14708a32448c879125b8e308f:

  Revert "ext4fs: Fix: Read outside partition error" (2025-05-27 10:09:12 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master

for you to fetch changes up to 9a1301aa7012184a36920e894c287d3928b469bc:

  board: rzg2l: Update MAINTAINERS file (2025-05-29 00:53:43 +0200)

----------------------------------------------------------------
Marek Vasut (2):
      ARM: renesas: Enable serial RX buffer on Renesas R-Car
      board: rzg2l: Update MAINTAINERS file

Paul Barker (1):
      board: rzg2l: Drop myself to reviewer for RZ/G2L boards

 board/renesas/rzg2l/MAINTAINERS | 5 +++--
 configs/renesas_rcar.config     | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)
