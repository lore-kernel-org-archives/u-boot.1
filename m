Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05BACC3DA42
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 14:32:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F9DD88A50;
	Wed, 17 Jul 2024 16:30:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="oD4hDEVz";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="P2P4gwI9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C79AA88A8F; Wed, 17 Jul 2024 16:30:22 +0200 (CEST)
Received: from fhigh4-smtp.messagingengine.com
 (fhigh4-smtp.messagingengine.com [103.168.172.155])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C80288A50
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 16:30:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 5BB541140142;
 Wed, 17 Jul 2024 10:30:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Wed, 17 Jul 2024 10:30:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1721226619;
 x=1721313019; bh=W523CBR1liKL/Ww+IcSbTbmzM93VBstcqBDnc7WroBI=; b=
 oD4hDEVzEVT78RaVj08FX2QEwIiB79Ee1e5ysLBHAJ1GgdQjUzRyk3HOdS4Ndd31
 Ggg10Azdaa/ALTW8QTTjzRJx2ZZnL8AoxUkKaQge7rHHDt9qP22leqddhr378quy
 C3/i2oegfiDDsyDwpcN9bygT9vXUFfzX9RHTes9/xaqH48t2zmQ65z6c5wH4gBP1
 h6uC1I/0y/0q+dDBNEDzt3hUPlIWTSDUqr1kPMIhsCqfmkB+AMAOLytYRl+bTI8i
 OAp8uov5KRm5rRZKSzZZmUctg0yY5NicjKiNdZ4CxAS7paKOSaKmLBtPQ6iFxDVL
 2mvMo5iKKrWjfmyGiS5DGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1721226619; x=
 1721313019; bh=W523CBR1liKL/Ww+IcSbTbmzM93VBstcqBDnc7WroBI=; b=P
 2P4gwI9G5Gckff09WCcnheHp4Sb5IUkumVqW7eMt1smInA0kJQfzdqGh6FIrpSSc
 1hyNM++QWPBvtDsX1WYwmZcAAndyNARwFaYzByEfrmybfx+WRoHXqiX183eCt1KX
 ivq3TdOpQHsD/G49EyXQyU4rO8CYblRx6w1nu9n2EqMOjuCi2gKAsEPoQ44viBhs
 50MsG5b5qin4jReKgXpKlp8bRsp8e/9U4x9P8V5bHKmJtPouKeQvNDxUNel+NK97
 l1VPksmx0chfFUk7NwuH4C3/dPJ2HQ6V34TyxXmZHxoYZGWlpVXKYlDlTDZ3FKp+
 4gJmx1Ao3beJr90Ck0cOQ==
X-ME-Sender: <xms:e9WXZodtsh0XeXCS2Eje5nW9o2l3RQWKEyXyK0Q7bF6atqi32BZk-g>
 <xme:e9WXZqMIykVcp_ALu12ol2X11xUrDEkUuA7-N2JjaZToutydGYM89z6UC8C__E5dn
 QXjvo7hSX5SC8zfAKs>
X-ME-Received: <xmr:e9WXZph3bIKyRFVrtcmQ09Z93I0E6ES4rFsuRpvRiH4MSzEUMQT6cgRsj4PYK8ggTrW->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeeigdejudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhirgig
 uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
 ggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefhueev
 geffgedukeejleenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfh
 hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:e9WXZt_npFBgAQ3pdsmeBrIskn29XYF0r0wb-7q_KclQTYFn6I2GpA>
 <xmx:e9WXZkvYYN5rE03P6aJ5VKzrSp-6sA5MNvY_MP1NT07QqmQLcgBvjg>
 <xmx:e9WXZkEWmqFSBDp6ELUCHiEdq3ayy8M-BffSYpQU2zlgttI6TKuDYw>
 <xmx:e9WXZjNxI5OGK4NvZYzsGPgb-ZZUUFiOX3_IfZrS95w_Wmo6hRIoxg>
 <xmx:e9WXZp8Bo0irtImkV2kALDsNuELhojdEw69QWL6a8SOAnkrY0eyUQYU5>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jul 2024 10:30:11 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 17 Jul 2024 22:29:21 +0800
Subject: [PATCH 10/18] CI: Dockerfile: Bump base OS version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240717-docker-image-v1-10-7c7fc6251e7a@flygoat.com>
References: <20240717-docker-image-v1-0-7c7fc6251e7a@flygoat.com>
In-Reply-To: <20240717-docker-image-v1-0-7c7fc6251e7a@flygoat.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1348;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=8xRkf3ZGlsq7qM5E93/MPz91Ss5Qyrv6RL3obg0kFl0=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTpV11uNJqsuvokyffa04yecB2petUVabr/t+s2Cc83D
 1PpyijrKGVhEONikBVTZAkRUOrb0HhxwfUHWX9g5rAygQxh4OIUgIk8sGVkuOY4+VFF8/WbH6wF
 zMqrdE/9vJy1dOf3Q4yHjy2ZFlB26A8jw0kuu8nvDpVvtZA43q0lYd0ks8jqQXzrbPc1HGt3mrs
 eYAAA
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

Bump base os to latest jammy release and install more
required dependencies.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 tools/docker/Dockerfile | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 5824d371f259..0bf2d180e255 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -2,7 +2,7 @@
 # This Dockerfile is used to build an image containing basic stuff to be used
 # to build U-Boot and run our test suites.
 
-FROM ubuntu:jammy-20240227
+FROM ubuntu:jammy-20240627.1
 MAINTAINER Tom Rini <trini@konsulko.com>
 LABEL Description=" This image is for building U-Boot inside a container"
 
@@ -55,6 +55,7 @@ RUN apt-get update && apt-get install -y \
 	gawk \
 	gdisk \
 	git \
+	gnat \
 	gnu-efi \
 	gnutls-dev \
 	graphviz \
@@ -98,10 +99,13 @@ RUN apt-get update && apt-get install -y \
 	python2.7 \
 	python3 \
 	python3-dev \
+	python3-jsonschema \
 	python3-pip \
 	python3-pyelftools \
 	python3-sphinx \
+	python3-venv \
 	python3-virtualenv \
+	python3-yaml \
 	rpm2cpio \
 	sbsigntool \
 	socat \
@@ -118,6 +122,7 @@ RUN apt-get update && apt-get install -y \
 	vboot-utils \
 	xilinx-bootgen \
 	xxd \
+	yamllint \
 	zip \
 	&& rm -rf /var/lib/apt/lists/*
 

-- 
2.45.2

