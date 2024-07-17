Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 286F2C3DA42
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 14:32:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A02B88A9F;
	Wed, 17 Jul 2024 16:30:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="tbhItXYQ";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="omPwBdZH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70DF288AA6; Wed, 17 Jul 2024 16:30:37 +0200 (CEST)
Received: from fhigh4-smtp.messagingengine.com
 (fhigh4-smtp.messagingengine.com [103.168.172.155])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29DDC88A76
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 16:30:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute9.internal (compute9.nyi.internal [10.202.2.228])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 3D8DC1140143;
 Wed, 17 Jul 2024 10:30:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute9.internal (MEProxy); Wed, 17 Jul 2024 10:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1721226634;
 x=1721313034; bh=hVZ0FtAKVJIpA4AXHbfifawc7/qZhq8pPmjcyUbiGRs=; b=
 tbhItXYQcynzzfbkv+kQ+sOoExDe9/gepRlOUxWz/ZyZLpxQX6bVrhG1cKpPw0IT
 67fgGZBHCxi9z2SCrBXdEgDfzM4XvadTsjuYNJLfc2X1tMhUMBjfxZQL6KMHYTKB
 LNzDlzAhCBpWb4bLPj8dG1FZWREh6Ne6Rbsd4joXCuTV2WKP5lGoB7bLPu5hizD7
 XX7ncu1RjqdpCUICvBaQx5hryneBlctE5B6cVjPNpIjQrA0T9utc/P6uRyHnhD6p
 YmgnLQLWVr3KzgfIV1QeODkPJMUHugop/X/h8506KIHhP3D4YEN3UkWP62Mzqkpk
 RStN0g7Aqu32WtJGzcShDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1721226634; x=
 1721313034; bh=hVZ0FtAKVJIpA4AXHbfifawc7/qZhq8pPmjcyUbiGRs=; b=o
 mPwBdZHIPOHCqdUz+jbXnYU6qETCSI1NK9ia5CXkDOaxxWMz+IS5MYL108nbZn/c
 kxTH38JZCyLtgnBgGehCjPYfxg13B+gpVe8EnvAcxnygOkbxmv22RDNAN2WOptQf
 F7TKIlbmbeW4PCyyJP5IVCu/SLjyUOZ0CVU4MciQZzy9TcwRRoPgtWdFm6j87vmG
 It3xZ6XIYFUXL1EQ/LuU3R1g6brlPHCpkYrsRmf0oupWuFABMBcIqkrI6rITqtpu
 8a+CK1IXRojjpXW+fhjCPQza4ZUQA9+SeQN18mdy5Pen1XCTOt3r5e8DuUsdq4hZ
 ljfJTwXm8watXX/3t3w9A==
X-ME-Sender: <xms:idWXZsAOAlm6dUb9N5wMxa94jVfmxNPQ5fvsqh_ywvrYHeSL6CnUHA>
 <xme:idWXZujjFiCsCnAmbgmf0WneX8_UEV-mOg9HuObuUXNrfcDAtKqxOTbuqN0m4r3Do
 Wy-NwMDRYLz6y2ZXIA>
X-ME-Received: <xmr:idWXZvnRwXtMSbd0btV03_Fz32ece-PUE_g5rh9j5xVKDsc81N7eVbV2GcF33rTNNvNB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeeigdejtdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhirgig
 uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
 ggtffrrghtthgvrhhnpeelkeeivefhfedvgefhlefhkeeiieejffehfefhvddvleeftddu
 uedtjeekgfdvudenucffohhmrghinhepghhithhlrggsrdgtohhmpdhtrhhushhtvggufh
 hirhhmfigrrhgvrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
 rghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:idWXZiyJm5g1d49g2DXKCGGTn4bEXfW6L-hM2owZ2yOoLZgtCwpNiA>
 <xmx:idWXZhS0SpAZW2dNhompo4w-xrmxu6nR4zwYXL6nppn4Gq5lJxDAnQ>
 <xmx:idWXZtZA72grINehXHqt644snjIQZrPcwzPxNhJ0IctWVHjD_gC2Uw>
 <xmx:idWXZqRwBG4YT3-3E9zpc7xPyEm0FCMdwaNy1X-JDLyJw3urUQjc9A>
 <xmx:itWXZiQ4IYtdDYJRo5X8fmCKaZ1ZZ8zCkYmagenBfSTjUfLsH_wDphXr>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jul 2024 10:30:29 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 17 Jul 2024 22:29:24 +0800
Subject: [PATCH 13/18] CI: Dockerfile: Bump fiptool to 2.10.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240717-docker-image-v1-13-7c7fc6251e7a@flygoat.com>
References: <20240717-docker-image-v1-0-7c7fc6251e7a@flygoat.com>
In-Reply-To: <20240717-docker-image-v1-0-7c7fc6251e7a@flygoat.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=678;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=fHLj07WIf/DT4HZgfNWJTbSTP1NZDYeSYwOgx+Wai2w=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTpV10a1+U/YJ7ofL/jpNLHAGvTLSvjJ7/4mcn33q7Dy
 5FXT2ZtRykLgxgXg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAExkhQAjw8y351Ri5c7EXJva
 fSezaYHyNZVjjHr9TIdDS7gVuY7c12D4K173p2Yl6/K9Nxit5+h1hQdcyUjxD/sc3/bQyHPC7vL
 9fAA=
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
 tools/docker/Dockerfile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 8e242d08297a..91256f0248e4 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -192,7 +192,7 @@ RUN git clone https://gitlab.com/qemu-project/qemu.git /tmp/qemu && \
 # Build fiptool
 RUN git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git /tmp/tf-a && \
 	cd /tmp/tf-a/ && \
-	git checkout v2.10.0 && \
+	git checkout lts-v2.10.4 && \
 	cd tools/fiptool && \
 	make && \
 	mkdir -p /usr/local/bin && \

-- 
2.45.2

