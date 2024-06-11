Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 917B7C27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 21:07:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C68D88784;
	Tue, 11 Jun 2024 23:05:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="Smvmp7zN";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="ncfTrDjN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6335E8881A; Tue, 11 Jun 2024 23:04:57 +0200 (CEST)
Received: from wfhigh4-smtp.messagingengine.com
 (wfhigh4-smtp.messagingengine.com [64.147.123.155])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E73DA887FF
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 23:04:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfhigh.west.internal (Postfix) with ESMTP id E3CE11800097;
 Tue, 11 Jun 2024 17:04:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Tue, 11 Jun 2024 17:04:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1718139891;
 x=1718226291; bh=7U8CMY4p/Scs4L6gBUFNsdE7FYN6FQqdWf+X68/GiIU=; b=
 Smvmp7zNk/FYzrqLW/KOufKRUciYFvcq5xEMR58Mlp1cCMe9oYMN8719TWDz1hP/
 p7gIdv0vrnzZl4/25gjop4imfRV0gYZPZchlDJrCgb7wGvFqqqW+iv2bKCAL3NCD
 r/SngFGXJ//3LjTmuFFCa98LpDM7VXE3WWvn4W5sFTOGa3DO4twpXGYG282ax7yP
 ONCQKFjTFKxaACfBAa3JL8WX3RENdp4SJUaHhGZl+oloy5sn1EdWsgE+RjzManTm
 g9m974Sn+kAcuGrdBCCxUHav3RS7M1tDkpLntsBaeJxitPHBG5sNqA59+9LsZ9cd
 78O5dbNeUo/LOGUqvbAs1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718139891; x=
 1718226291; bh=7U8CMY4p/Scs4L6gBUFNsdE7FYN6FQqdWf+X68/GiIU=; b=n
 cfTrDjNvwU6eseXafn59aOtpeOYPVhYTsnyY0k/1pqT+FbHK9BQyrxEw2YYTzQZe
 Hge4FZIA4+NuuYLLtHFA/0eWYyd033Tbp9PSbJ+12qjlbiRTLnnD6MOrE7bmBAMq
 TDrKiqee/n8v/RutvWitg1HQVGfaVD4QRhiNfDJsBV4CYPns11RaBF7v0XyayiVw
 k7PiUaSMxdkpYNKYjKEzeb6A71P1r0fwgpRpW6TRbOW1DunCTUmKh7W2MsOVK/P5
 Ix3dTv5o7BNw9u0xCWYXt38UwOgRyrCA/ZdOtbwPw7umyGf7ocG8qqDX1M10S17x
 8FLUAJ9k8OVg1++ZwJmQw==
X-ME-Sender: <xms:87toZj6mULc5z_6IOUHHKYoczXu5XigCyHvOfx5U_iEDvqrycFYW6w>
 <xme:87toZo6Y0M9lWcs25qR9x5M8XBBGp9--A3UwXv0GZOIJj5oKYyUsg9W6k2A5cmoqk
 fo_CHTEnPW0li3Pd7A>
X-ME-Received: <xmr:87toZqfgKKOgWGO3DGbg4ejPgX7bK0OzXfgQy2S9SD3cbpv4A25StBk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudehgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
 rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
 enucggtffrrghtthgvrhhnpeetvedvleehtdfftedvjeetvdelvddvfeeuheehiefgfefh
 leffudefffehjeegtdenucffohhmrghinhepghhnuhdrohhrghdpghhithhlrggsrdgtoh
 hmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhi
 rgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:87toZkIdFWPQ8Nqhb9hArXR2mnjccrG-2-ZLScygEuklEMZr8G61wg>
 <xmx:87toZnKFYpkGO_gd2z3DHquNIc3-Izqbw6FNDwDjSnrw4AMUiKSB9w>
 <xmx:87toZtzZ1TQ3bUiDqDK-M_wSJ9ejxrYCHcA-HcfP2UrMoGSa6r9zrQ>
 <xmx:87toZjL8NrImhnK6s87ZaCXTaaFJyKvVTdIm1aQj6fSOL1dAHi0FCA>
 <xmx:87toZu9AfWJlj-NCHM4wMnAoegJZO44FqDCe03-qpMAAn0Z17nZPuijv>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 17:04:50 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 11 Jun 2024 22:04:14 +0100
Subject: [PATCH 15/20] CI: Dockerfile: Set global git name & email config
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240611-docker-image-v1-15-51472eb70357@flygoat.com>
References: <20240611-docker-image-v1-0-51472eb70357@flygoat.com>
In-Reply-To: <20240611-docker-image-v1-0-51472eb70357@flygoat.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Aaron Williams <awilliams@marvell.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1683;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=nrrpDaVOramqC5Unih5UycepeFecGaYB71qXIX+D/uI=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrSM3Wd7ZXhYLoZdafQ62J2a+UQlwYBnVwWv861LzhPYv
 n5/rs7TUcrCIMbFICumyBIioNS3ofHigusPsv7AzGFlAhnCwMUpABNZmcvI8Fz3CtvKjk28rRIW
 uqxeb/zdTD8oaQgzPcy2PGkq3yv8n+F/eHAj47KVG6TWahtP50zXM9kf+SZ++12x1Jw7pySbhKc
 yAwA=
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
2.43.0

