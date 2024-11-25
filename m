Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB18AD59D6A
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 20:41:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57B1489A6C;
	Mon, 25 Nov 2024 21:41:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732567288;
	bh=mhZvb4o1rXF0w0ipynaQxyQySQPX59c1M3weyfzi7RE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=aIFd1LS/l1jjMa86/O6yQdbSq2ZsZVXJRDYxKctRUH0BF66dim99HUZeyp27NyL9D
	 SBxh4AHnigRtduOvhOfF6URHJA9MXixg6ULfRmSEmGZr532eko3vN6boS0F4qlfVfT
	 DpKWsRmWs+IvE/7lbpyF5nYGovrmZO1k3DVctraSTio01+H0Pd/HRfplN6tgqSgliy
	 v0Ey2nJwta6CkqU43mdnCzjXBT4Vy9XAS3BqYr3G5g5TPVEH53tYdxmgF+bpjdWJ1G
	 /BBRf8eQU3XB5sSPFnJzXe6UepjK9bvFJnt9XLIRB7fx83yt7+Ms1iQVcFbl4hx/wP
	 fVR8rKZIbaaAw==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 847CE89251;
 Mon, 25 Nov 2024 21:41:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732567287;
 bh=mhZvb4o1rXF0w0ipynaQxyQySQPX59c1M3weyfzi7RE=;
 h=From:To:Cc:Subject:Date:From;
 b=NOtFZnAuTJjd1CSgNNnKo3NEZOcFBrrpyyAh8Rzon1WoJaJY281HrvSKtJytaxs7M
 1yoqj4DMd6+MFpXPxKaHamQTreMdNl2yLZQ5D6dZj6R8U/G797EWVtCDzCYgdXZeVw
 KXMA+kUsia9mtn+FhoFztOuNqWwPn8Xbcz4Ut7jIjZKjtAYWiINcKjt7d+BOVchB5R
 ZxqrfucQDCSW5+HeoYzQPBBSPlh7GX0rEn8s1kIaiRRIOlj3MV60lg85gAFEOkiPYv
 +lpqD/USEIFugw41vfzw7+7Cejrmozw+xjhLhjPItwLxySEay5aB7g368l4XW30MLJ
 Nyog7aIcaW0eQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>,
	Khoa Hoang <admin@khoahoang.com>
Subject: [PULL] u-boot-usb/master-asix
Date: Mon, 25 Nov 2024 21:41:04 +0100
Message-ID: <20241125204117.18423-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
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

The following changes since commit 52c0e5f8a39ef022ee5ab2dfd67661d1d34941c7:

  Merge branch '2024-11-22-assorted-fixes' (2024-11-22 15:04:54 -0600)

are available in the Git repository at:

  git://source.denx.de/u-boot-usb.git master-asix

for you to fetch changes up to 05278af8b3df1c0c02e345ccf4c8c59bd0111f68:

  eth: asix88179: packet drop when receiving large fragmented packets (2024-11-25 19:11:19 +0100)

----------------------------------------------------------------
Khoa Hoang (2):
      eth: asix88179: Fix ASIX AX88179A PHY hang
      eth: asix88179: packet drop when receiving large fragmented packets

 drivers/usb/eth/asix88179.c | 45 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 8 deletions(-)
