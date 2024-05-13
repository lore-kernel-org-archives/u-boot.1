Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A382C25B74
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 18:19:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4245A883AF;
	Mon, 13 May 2024 20:17:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="M87/gyZK";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="jojt9cNc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 934FF87D08; Mon, 13 May 2024 20:13:33 +0200 (CEST)
Received: from fhigh2-smtp.messagingengine.com
 (fhigh2-smtp.messagingengine.com [103.168.172.153])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 782E988303
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 20:13:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id ABB9011400B1;
 Mon, 13 May 2024 14:13:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Mon, 13 May 2024 14:13:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715624010;
 x=1715710410; bh=8V2Qr/6eSx/MT+l/EtFNwAEO9j/M8gqIVbnvZ+Zafpc=; b=
 M87/gyZKgEEmsHPE7qbtmlAgpKCRnahsBvTnXlyr1qGXhwcXSrreb8wTK5UD/fm/
 rTd1hoPQMDQsLr7eJoUSBxkvnglIunGZu56iyPPxVmzy+vMQyrPO0QGhBP4gClox
 7Wrp4t7SVQeA0m2KjYt8Q8NlaERSVvdLcU4uZJF5ExcdxFC2O4bCiAT2hr/9ntgo
 1Bwxtu6sP3RFOHrVyA1U5smsbfLQJ8gbuER2bpa+D3h9rAUM3PNhuNVtoMORyluQ
 YOdYwK7hQSdozJRGvtuwPEy1p8TtwzO7oswhepzt66yZsDRB6z7UNHAXvE6yPUEd
 hfn6WDKNzY62iOdeQbcn2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715624010; x=
 1715710410; bh=8V2Qr/6eSx/MT+l/EtFNwAEO9j/M8gqIVbnvZ+Zafpc=; b=j
 ojt9cNcorizn59nkXkkwzRv4TH81dfTCxWHmeaJSlap96ZdFS9Nt0+AlikmghJqw
 DIZ0mtoGtWGAZoY21IliJif2/rVpkSqSuLHtXcQ0cL1qFDnCWpnHMLR0oHiipeX0
 5WrmPu3XjyRrvk9yBjWnDkNyOzy0mvH6Sn4RW4Us1Apmlh3Kt8OghW42FDExoKVj
 HF6MLEI82RuDzd/44wrKbXqJZnRj2463+56wHAJ5u224I7ut2aPewIEp8XjYtheA
 7+adcIz+MwDmRyOUA+OwKy4LguDhbm9TZ+ZIJS4qctcJltJt8Hu30Irej7PrAuGE
 Z2V9//wzdPZmAVjd1RB7Q==
X-ME-Sender: <xms:SlhCZlFcf24kk8jtZP-LZEXXCsC51-ni1w8msGFNJdKVRyKz0XYyQA>
 <xme:SlhCZqUwzRkxs8q0j-RAhAM7IVX13LJI3cbgDWZrJhMEqEVnmaoE97p-XHLbq5cy7
 U8jwRC6-53TTaH4A5w>
X-ME-Received: <xmr:SlhCZnJMjjtoQEMt-pQLuoDCXabtyNULBHYkEvD527qS3uMtWHCzEqc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedguddvudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
 rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
 enucggtffrrghtthgvrhhnpeehgfelgeejuefglefhueduheeliedttefhleejhfdvveeg
 feefveetheehkedukeenucffohhmrghinhepkhgvnhhrvghlrdhorhhgnecuvehluhhsth
 gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghn
 ghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:SlhCZrFkQM7GvqpauRCt_bgvTVGci2QieXNOkgx4i9Mwe3ILplO4JA>
 <xmx:SlhCZrWpUTn9ooUs5udSWtjwJDi6Lw6UGh1cCaZu53Xpq54gtjtolg>
 <xmx:SlhCZmN8ALBnG7U9J1QZ1gOEwci64Kul_kgbGzl5KC6HvKnSoISxIg>
 <xmx:SlhCZq1511dDXAU1G_l1GbMCFSY6o7xcYgs_vFpSAkD0Cks_p20Txg>
 <xmx:SlhCZkMTeofEMObrf5PM7rX4D-yaelfwp4qwd6BiPOB0O2-NZYtu5GMC>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 14:13:29 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Mon, 13 May 2024 19:13:10 +0100
Subject: [PATCH 13/13] mailmap: Update email for Paul Burton
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240513-boston-v1-13-fac96938417e@flygoat.com>
References: <20240513-boston-v1-0-fac96938417e@flygoat.com>
In-Reply-To: <20240513-boston-v1-0-fac96938417e@flygoat.com>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Paul Burton <paulburton@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2072;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=qT8F2GfpoNQmppl7T68l24x0+KoFuNYyRrCngUMWAMI=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjSnCONJBWVrfrPmFPiH5z2J0851nfLlSzij3a8TBj/2O
 GSeK5XtKGVhEONgkBVTZAkRUOrb0HhxwfUHWX9g5rAygQxh4OIUgImsk2VkuGe7MqP5Nec9/TZb
 tn3vA1m6313on3RCb9kz21nxLim6GQy/2U7u8bWUOunQ9CkkpkHNrVLqTfvKe+8dk+a0/PrRY7+
 bBQA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
X-Mailman-Approved-At: Mon, 13 May 2024 20:17:26 +0200
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

Paul had left MIPS a couple of years ago, his email address is
no longer valid.

Replace it with his kenrel.org email, which has been used in
kernel and QEMU, in case we still want to reach him.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 .mailmap                        | 3 ++-
 board/imgtec/boston/MAINTAINERS | 2 +-
 board/imgtec/malta/MAINTAINERS  | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/.mailmap b/.mailmap
index 8049856d41c3..bb7c1c3869ab 100644
--- a/.mailmap
+++ b/.mailmap
@@ -87,7 +87,8 @@ This contributor prefers not to receive mails <noreply@example.com> <pali@kernel
 This contributor prefers not to receive mails <noreply@example.com> <pali.rohar@gmail.com>
 Patrice Chotard <patrice.chotard@foss.st.com> <patrice.chotard@st.com>
 Patrick Delaunay <patrick.delaunay@foss.st.com> <patrick.delaunay@st.com>
-Paul Burton <paul.burton@mips.com> <paul.burton@imgtec.com>
+Paul Burton <paulburton@kernel.org> <paul.burton@imgtec.com>
+Paul Burton <paulburton@kernel.org> <paul.burton@mips.com>
 Piyush Mehta <piyush.mehta@amd.com> <piyush.mehta@xilinx.com>
 Prabhakar Kushwaha <prabhakar@freescale.com>
 Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@amd.com> <punnaiah.choudary.kalluri@xilinx.com>
diff --git a/board/imgtec/boston/MAINTAINERS b/board/imgtec/boston/MAINTAINERS
index 12e1652858bb..b03a6487db29 100644
--- a/board/imgtec/boston/MAINTAINERS
+++ b/board/imgtec/boston/MAINTAINERS
@@ -1,5 +1,5 @@
 BOSTON BOARD
-M:	Paul Burton <paul.burton@mips.com>
+M:	Paul Burton <paulburton@kernel.org>
 S:	Maintained
 F:  arch/mips/dts/boston-u-boot.dtsi
 F:	board/imgtec/boston/
diff --git a/board/imgtec/malta/MAINTAINERS b/board/imgtec/malta/MAINTAINERS
index b1cf297f4fac..252c5e45ab56 100644
--- a/board/imgtec/malta/MAINTAINERS
+++ b/board/imgtec/malta/MAINTAINERS
@@ -1,5 +1,5 @@
 MALTA BOARD
-M:	Paul Burton <paul.burton@mips.com>
+M:	Paul Burton <paulburton@kernel.org>
 S:	Maintained
 F:	board/imgtec/malta/
 F:	include/configs/malta.h

-- 
2.34.1

