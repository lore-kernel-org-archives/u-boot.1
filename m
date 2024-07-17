Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B8CC3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 14:33:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F38AD88AA7;
	Wed, 17 Jul 2024 16:30:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="fQrnieH/";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="u+bniPo6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F163D88A48; Wed, 17 Jul 2024 16:30:53 +0200 (CEST)
Received: from fhigh4-smtp.messagingengine.com
 (fhigh4-smtp.messagingengine.com [103.168.172.155])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F3C588AAD
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 16:30:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 9BAD7114013F;
 Wed, 17 Jul 2024 10:30:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Wed, 17 Jul 2024 10:30:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1721226649;
 x=1721313049; bh=OBk3eZKwy1ahZoqV/pq+SHftXZIZpoc0Zhzx3lmpEwU=; b=
 fQrnieH/pWfAinOf0RzxMc+2qRmW0NNjMujMZ4/s77GWd/cL/VlOWMFr3j3Kb8Cp
 nTigwZlSPde5iTe+4LwlCVVr//jBjd+T2I4m8VvYzAgaIklk/M+hQSlpGxoTrhES
 Xja0F4M8pWMrTlCjtcKvpLdSvMHIj6/3plr6Z6BbAkFwugL/b2FY1aLqtxdANjeq
 GArkGSOjklKWmVfHa5P0g+mBE7l9W9yRxlQzHkh/OCj7zptq0wcd4XjJRZseOYeg
 zt5hVpHK0JLT9e+75urPNlbENuAkeCOUxLCoTHWKz4VVQRsim1AlwjJGxXCEJfDn
 UeucrhwYaiSumNyZig4tIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1721226649; x=
 1721313049; bh=OBk3eZKwy1ahZoqV/pq+SHftXZIZpoc0Zhzx3lmpEwU=; b=u
 +bniPo6hRh+8DkGX0nOhb1fPqJZC6655q13FIFCjDdZS/7ca9hXLG22o1HwPaxHB
 4KvMkd1kWx1m6GtqtldOTQnDbXhD31RfRlcB935+hara3wFHh5oYEe28wq7dTMah
 /5yj7n2SnCSCwwgthYnpvMMaK4Et8QzyrZYphyBUYXpgTpqN9FFcHWlrItf5pyrG
 C6Z0JcSE4QUY1Cg419gOfcOztaT/Mi6rWcIrFDvQXid4fv0kksIZGGISrRVwpPOE
 3ByUq2pH8busXto1zAqYuxrB1P5kdKn0yF3I0HTsc/eF4GJWlneUW0io1Gmyhl4m
 L4NX1WZ6pG8Lg3xxdoXTw==
X-ME-Sender: <xms:mNWXZkSFR8y5QeQRD7lLIFUyYQhgbUQQo6tYuzTcffDbJxeMRMK8xA>
 <xme:mNWXZhzy1Fb3Ez9PlN0aOHsaSXoRW7Tc6k5Q50WrWRYuOkVC72ze22gqhJa5IeQ38
 nvx4H-UkzhtVoVX1f4>
X-ME-Received: <xmr:mNWXZh2WYLv-b2d4EbTq71QJvLD4ZfPbdbS8N_2jDlPPiw_SBdxnvWihX3uAKPAHXaMO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeeigdejudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhirgig
 uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
 ggtffrrghtthgvrhhnpeefuefgffeutdevgeeuffeuhedukeeggeehledtfeelgeffvdeh
 leeuheejheelteenucffohhmrghinheptghorhgvsghoohhtrdhorhhgnecuvehluhhsth
 gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghn
 ghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:mNWXZoBknVwPZE6jgqawLhcguRVIUDGInSbhmyzpfShTMPslFbbAlA>
 <xmx:mNWXZtiOkrlm93huWJf6mn1Qw92HFjldHHOmc3LqKF1AgRzfHcNjsw>
 <xmx:mNWXZkp-wy8RnDy2tTguZGqtpgGWFUBBxUBun8cFRCRJc4imI6NgXw>
 <xmx:mNWXZgjTiAQUpmi0irC-OxS3QHonNeIOh88wm8lYVl1dA0S3QsYZ2g>
 <xmx:mdWXZlg7D90bX_X4WsDyIpte2Q29RWS7lGS9FsS6DUMcxYKhU7jY0g53>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jul 2024 10:30:45 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 17 Jul 2024 22:29:27 +0800
Subject: [PATCH 16/18] CI: Dockerfile: Bump coreboot to 24.05
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240717-docker-image-v1-16-7c7fc6251e7a@flygoat.com>
References: <20240717-docker-image-v1-0-7c7fc6251e7a@flygoat.com>
In-Reply-To: <20240717-docker-image-v1-0-7c7fc6251e7a@flygoat.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1161;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=Vb69xwnwcZjnpIx+q3tBoNzThEvUIIjlayL3BwSecfk=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTpV11+fu0x+FN6sWTa7Sfrqz4umTNjyhZBh62OFvWr3
 rXv9pgk2lHKwiDGxSArpsgSIqDUt6Hx4oLrD7L+wMxhZQIZwsDFKQAT+cLJ8E+n2WbvFMZvJj3L
 K1+ZLdKpMzkRqbNSc94aff+dTy5tsJnAyNCQmLnGICNNY2P+Nz3zb6aLQw88r9za/2ntib7VJfU
 qi7gB
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
 tools/docker/Dockerfile | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index f45283d72441..5ff1ac449e1f 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -243,15 +243,17 @@ RUN mkdir /tmp/trace && \
     rm -rf /tmp/trace
 
 # Build coreboot
-RUN wget -O - https://coreboot.org/releases/coreboot-4.22.01.tar.xz | tar -C /tmp -xJ && \
-    cd /tmp/coreboot-4.22.01 && \
+RUN wget -O - https://coreboot.org/releases/coreboot-24.05.tar.xz | tar -C /tmp -xJ && \
+    cd /tmp/coreboot-24.05 && \
     make crossgcc-i386 CPUS=$(nproc) && \
     make -C payloads/coreinfo olddefconfig && \
     make -C payloads/coreinfo && \
     make olddefconfig && \
     make -j $(nproc) && \
     sudo mkdir /opt/coreboot && \
-    sudo cp build/coreboot.rom build/cbfstool /opt/coreboot/
+    sudo cp build/coreboot.rom build/cbfstool /opt/coreboot/ && \
+    rm -rf /tmp/coreboot-24.05
+	 
 
 # Create our user/group
 RUN echo uboot ALL=NOPASSWD: ALL > /etc/sudoers.d/uboot

-- 
2.45.2

