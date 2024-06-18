Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF84C2BA18
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 13:58:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 459A3883DA;
	Tue, 18 Jun 2024 15:56:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="gEnrf92J";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="eMVFegTu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3604E882D4; Tue, 18 Jun 2024 15:56:50 +0200 (CEST)
Received: from wfout7-smtp.messagingengine.com
 (wfout7-smtp.messagingengine.com [64.147.123.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0DF4883DA
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 15:56:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfout.west.internal (Postfix) with ESMTP id 11A421C000F5;
 Tue, 18 Jun 2024 09:56:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Tue, 18 Jun 2024 09:56:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1718719005;
 x=1718805405; bh=6WReaVLDs6VgTLyuHSIpXI95v3cOFZQCWiAPeRZe0v8=; b=
 gEnrf92JYby7HOx8mjIxe4TiIormX0Lik1N2qwj6z0qGIPul62cOeKkQW6qLNYPp
 5JtqW2TSBu6GaIPjX2Jf6cD+06C0MLEplD2ANuqhII7gYC7N4CVjiwX8kM8vMjKV
 42giuHAbVWfJIX/EfvH8h6obGG3Mgj9PAlILiKYgRfWzmLTK8y4qke4zf/vRu8GP
 14d2TfAsnvvtWp54+G7miBlPfTKadw2yw0VnKlHJJB6Im5oWWvF1nmBPFop+j103
 ZS1VFUijfMZK7y/ODJQh6QkgIp4ogjbZiBQFBamCAehOJ/1IS6pGSEYnieSxU0LX
 qCKxFbDLBXZFexY88/Qy3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1718719005; x=
 1718805405; bh=6WReaVLDs6VgTLyuHSIpXI95v3cOFZQCWiAPeRZe0v8=; b=e
 MVFegTuL2aJxPHQEtBW++sgZXFieuFjkELqQWOrOy7sGm4u4Eb6iQrCmDyBcuctm
 f2ZCD6f4h8sARBpZjQk4ucdeKvi3V5gU/JpBZP15fuAhxCWXROWiTHIf8w8hDp5O
 S6mHBAEhtnmZHrTzuskMNYzmgfpQY8A/6zcOsbqscEDeovSanGxgO7ZFT0FYjiJ7
 wJ7jVUJSFDuEkmPbPuAf4bZbR0t/7z0iZknccWs+8K/fR6qn8wBPfDgaywoFAlXc
 ca+/nJ+mOkIY/KnEn0UZU2qUAuboBf6l9mACkzWtYjVcRxTPA7xVt8cSOz0cHI1P
 zU6vpO7lmFieKQYwF6kMg==
X-ME-Sender: <xms:HZJxZu_26BHTjuIOj-HRlL8uega4E3DTMPR2aiLVfHVsqg4etqzUXA>
 <xme:HZJxZuv5VRxCUxwng0lw1XFM1lgbLJYsbHV6nabuNg9ZybbmFDvfDi2TJJ5ccp7Ya
 1MX0PsPbyPNm6VmgTc>
X-ME-Received: <xmr:HZJxZkDjKHVm6OlTGqpVF54vngWPrKN0RCElIA6a3iCYbdkIBzgZtBk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvkedggedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepheejveejfeeitdffgffhfffgtddtkeekudeujeffveejgfef
 teeigfduffdvueevnecuffhomhgrihhnpeguvghngidruggvpdhgihhthhhusgdrtghomh
 enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgr
 gihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:HZJxZmeud-IDu8d0SexaRfX-PUhaCIapuL-S1wsX9se5sdTdwbglBA>
 <xmx:HZJxZjOQ3Uj1RVCcgVLQq2PVlA-GxCnxicff7j58jsYXQ2LxTzH7Aw>
 <xmx:HZJxZgnUzr_BuiAtyE7wm4QICKUNsNBLdT0zhVZTjsc9xj_N5VEXxQ>
 <xmx:HZJxZlvveTaF6aVxzNQgVxqtnLc0__LmbefZEL3X7AC7-dgnTGy9lg>
 <xmx:HZJxZvD1zY1ZmVb0XYxkUEmKJEzzrcIrvc1OKW5U67pYiO3RbOpVy0LS>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Jun 2024 09:56:44 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 18 Jun 2024 14:56:12 +0100
Subject: [PATCH NFC v3 12/12] : CI Changes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-qemu-xtensa-v3-12-f5af5e6fdd23@flygoat.com>
References: <20240618-qemu-xtensa-v3-0-f5af5e6fdd23@flygoat.com>
In-Reply-To: <20240618-qemu-xtensa-v3-0-f5af5e6fdd23@flygoat.com>
To: u-boot@lists.denx.de, Sean Anderson <sean.anderson@seco.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=969;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=kkVINSddHbNTMK1IpUy4pBazd7zEZeDo3dKAjQoqRms=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTCSYwzHROqdH48j2bfVrpU799W5ZKWVic9RkGHq/Hf/
 Go61szsKGVhEONikBVTZAkRUOrb0HhxwfUHWX9g5rAygQxh4OIUgInsT2b4X1vI+n/qR2lVMe03
 feZrP1e6STDGBAcKl6lPMmZPdrDcz8hwtnC9xq6Aa9k1LlFXb7aZtxvsuLWH5dLTVW1/eKcdbl/
 NAAA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 .azure-pipelines.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index b149db62798f..5cb675d3c975 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -198,7 +198,7 @@ stages:
           # the below corresponds to .gitlab-ci.yml "before_script"
           cd \${WORK_DIR}
           git config --global --add safe.directory \${WORK_DIR}
-          git clone --depth=1 https://source.denx.de/u-boot/u-boot-test-hooks /tmp/uboot-test-hooks
+          git clone --depth=1 https://github.com/FlyGoat/u-boot-test-hooks.git /tmp/uboot-test-hooks
           ln -s travis-ci /tmp/uboot-test-hooks/bin/\`hostname\`
           ln -s travis-ci /tmp/uboot-test-hooks/py/\`hostname\`
           grub-mkimage --prefix=\"\" -o ~/grub_x86.efi -O i386-efi normal echo lsefimmap lsefi lsefisystab efinet tftp minicmd

-- 
2.43.0

