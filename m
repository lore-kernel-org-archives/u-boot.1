Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 062BFC3DA42
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 14:31:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDBC588A78;
	Wed, 17 Jul 2024 16:30:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="G6c2pBrC";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="kqX5v9WV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72ACA88A66; Wed, 17 Jul 2024 16:30:14 +0200 (CEST)
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com
 [103.168.172.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BB7D88A85
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 16:30:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfout.nyi.internal (Postfix) with ESMTP id 4E298138013D;
 Wed, 17 Jul 2024 10:30:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Wed, 17 Jul 2024 10:30:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1721226610;
 x=1721313010; bh=4IMI4iJAUKG3YSLYHVxAb8IS4ZDaQxdgb96aEGpZU4I=; b=
 G6c2pBrCnjvpnD1q5lxL8iAOV2XqtZGDFA3Mgc1koBInDZjE96ktvgaO4u38mi/u
 C1xJOIDvlmEVgXtMMZ1cnMVsNDIhCdTUKC5juoQHRZzXZ0BFs6CC9wWmSCYflR5E
 TMGYHgXVz1wMoUrYwXpmCgslGB+AlZLMQvhtS/bFUPqOY8pwKtHku9jX8ABOFi+w
 vEiQQUbYMxMZ57fCHUwoIZR2hk5vzZLCIHCbuGAFnjP8xhyKbPB/vhSRqddtSChS
 yOBXZ44mpIhx3kb3AR1zafm9yh7FZU5Fs1yQ3oLztk0vSX4miy0ypwMVPLnuQ9Cq
 nNz9UJEgWT1JptaN8+NU+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1721226610; x=
 1721313010; bh=4IMI4iJAUKG3YSLYHVxAb8IS4ZDaQxdgb96aEGpZU4I=; b=k
 qX5v9WVjCgSk4+E8ufrvxigUAnf77wlcI/Qn+tlQryWM2Xpg7DRetOCM8KZp4W4M
 tKTbsbYw6z1HiKMH7838540fYJ9+7v6E37O4lyAYBw4Me5fdZbOzEh0gouKNgsfd
 6V4cfXfcEdvUHZ6CnzoVeKn/jRPiSzKOyMhXV8sNTDlg5Wpgbr53NWkcXKTVJy70
 J29p2XcftiV4I/IuTDrzgTSnt3FLFToTe+5N/W4pJawcoCRFzp4ioQrgwj8tWHn6
 7XKKQACoJPLUW1l/ETcXSMxYDFAj10ON+Zgu0fTQrLTrTgqS/zL9Smkn+cNUzMcL
 VZG7r8Id4qvMizMMJe3FQ==
X-ME-Sender: <xms:cdWXZiRS0dHAIpjsFhLs8ECMFJJggcTlu3xcXriQsSNwMOyX7s2jug>
 <xme:cdWXZnxtEp9budRseE9EXCfBZ0FvZrosFEvin32y2VfOjqFlm_2zevxM_-Z-bt3_M
 sFU6daPQj6vt3pC3o8>
X-ME-Received: <xmr:cdWXZv1d5rYbRYIJqWa4tV1tikqKoqCzHeT1tlUnSfFFzzj8ecGx05ItOt6dAeywj--5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeeigdejudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhirgig
 uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
 ggtffrrghtthgvrhhnpeetvedvleehtdfftedvjeetvdelvddvfeeuheehiefgfefhleff
 udefffehjeegtdenucffohhmrghinhepghhnuhdrohhrghdpghhithhlrggsrdgtohhmne
 cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgig
 uhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:cdWXZuC-pihHpJMgql6eSP-pdh0dN5uO6npYOUjO3eKl0DdyhGQx3g>
 <xmx:cdWXZrhJQJGlqIqq550tY7AhrJpXV3EA_Gb1fX3i3PWTZ1YseDPIfA>
 <xmx:cdWXZqpPIaE2giX6N4nHkl160RoXWEP0KZetMTF765JWGQ_T3OGq8w>
 <xmx:cdWXZug4F9hPngcgValWw32kDozd9yCAjcFdaQpnMfK5aHZLznt5VA>
 <xmx:ctWXZrhOIpfAX1LFkCp8MdJvCfOy9gCYzJrrsvtY-HJVZ6WUAdFzyBfT>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jul 2024 10:30:05 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 17 Jul 2024 22:29:20 +0800
Subject: [PATCH 09/18] CI: Dockerfile: Set global git name & email config
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240717-docker-image-v1-9-7c7fc6251e7a@flygoat.com>
References: <20240717-docker-image-v1-0-7c7fc6251e7a@flygoat.com>
In-Reply-To: <20240717-docker-image-v1-0-7c7fc6251e7a@flygoat.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1683;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=iG3IgS4CQDEWQDnsjhHG2NhOapBPXunikZ7HMVWHc/E=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTpV12khEsDb4dm223OsnNfZX1d2UFZlSH1RSlvUemGd
 4FbVl3sKGVhEONikBVTZAkRUOrb0HhxwfUHWX9g5rAygQxh4OIUgInMLmb4zR54+GBcPcdD/leT
 F7gfbP7lZjhB/9uPVYEd907z7L0uMY+R4VAEkzX7/MDvnh6R8dcK6vlKWjrMEq0m/53358lPRo1
 8fgA=
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

Set global git name & email config so we don't have to setup
it for every project.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 tools/docker/Dockerfile | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index cda87354566d..5824d371f259 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -121,6 +121,10 @@ RUN apt-get update && apt-get install -y \
 	zip \
 	&& rm -rf /var/lib/apt/lists/*
 
+# Setup Git
+RUN git config --global user.name "U-Boot CI" && \
+	git config --global user.email u-boot@denx.de
+
 # Make kernels readable for libguestfs tools to work correctly
 RUN chmod +r /boot/vmlinu*
 
@@ -128,8 +132,6 @@ RUN chmod +r /boot/vmlinu*
 RUN git clone git://git.savannah.gnu.org/grub.git /tmp/grub && \
 	cd /tmp/grub && \
 	git checkout grub-2.06 && \
-	git config --global user.name "GitLab CI Runner" && \
-	git config --global user.email trini@konsulko.com && \
 	git cherry-pick 049efdd72eb7baa7b2bf8884391ee7fe650da5a0 && \
 	git cherry-pick 403d6540cd608b2706cfa0cb4713f7e4b490ff45 && \
 	./bootstrap && \
@@ -180,9 +182,6 @@ RUN git clone git://git.savannah.gnu.org/grub.git /tmp/grub && \
 RUN git clone https://gitlab.com/qemu-project/qemu.git /tmp/qemu && \
 	cd /tmp/qemu && \
 	git checkout v8.2.0 && \
-	# config user.name and user.email to make 'git am' happy
-	git config user.name u-boot && \
-	git config user.email u-boot@denx.de && \
 	git format-patch 0c7ffc977195~..0c7ffc977195 && \
 	git am 0001-hw-net-cadence_gem-Fix-MDIO_OP_xxx-values.patch && \
 	git cherry-pick d3c79c3974 && \

-- 
2.45.2

