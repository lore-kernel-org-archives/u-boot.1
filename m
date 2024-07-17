Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 146CEC3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 14:33:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A40788A76;
	Wed, 17 Jul 2024 16:30:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="NfWGoTJz";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="LB0MJ8c/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB53D888FB; Wed, 17 Jul 2024 16:30:42 +0200 (CEST)
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com
 [103.168.172.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CFE888A87
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 16:30:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfout.nyi.internal (Postfix) with ESMTP id 9604E1380154;
 Wed, 17 Jul 2024 10:30:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Wed, 17 Jul 2024 10:30:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1721226639;
 x=1721313039; bh=FMem12jrrphcL2JdBxrmSVdBMUS9Qpy7uFxzzEAbk0g=; b=
 NfWGoTJzLbdV0tZOVR/ywdg+yeo7YMLrzUXU7cz+pMkggB7/HzcPazOaogH30JCC
 r+NAlH6kT5RN/tkeCN1mQx4cRiQ6DWZBi1vnha0wmSf6W5z5BN54m2hJrSkUyxp4
 2GCY0lTem9tKsHWkM2TTKSyWp/qkyRfr7nGc6ALd/CI/ihEtu6XyMCfELooWejjE
 C0RRtjz97ROp4YCqfY5+zRQJCIpSMzHqv37MBwx0mkLFTqJagawOyZKdflPPuUq9
 Mb3iDn9so+8Fwzxx8UKminc40cbQwesj6nRciMwJFEGjsJckYeHVZ6mPXnrLvOVz
 bMttAumqyKyVnn0TaknKnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1721226639; x=
 1721313039; bh=FMem12jrrphcL2JdBxrmSVdBMUS9Qpy7uFxzzEAbk0g=; b=L
 B0MJ8c/wPzt57xzEaOU1x0C9L7GtCf1gg9CEztJVj9KRmi9hpP9smFwXJezecYF/
 SdE0CjjHwWYliLl6J9OrTzVDXnOZ6JQ2tBhRm4hF6uwQWF5yTj5jp2adUn/5GOmh
 PnBk84vRjmpAiSDxrJ+lLCLUljCqqqHXYpFpUW9DAgJvcNB8rC9hCkLypiYGdYU9
 sqMq0zZ/ruMdJfFSf4+eHs8A+4vIFPklhvxjAOEFp95ZMx+mT89iC5gFsT92lwp8
 kkmsOCb/JnJNSJXSrkX+WUle9E9WQwGYZRZAmegIB5C1EZV6cv23H6JIDOi+aCm1
 KUslkLRxOId+cVlYNUgPg==
X-ME-Sender: <xms:jtWXZhSxYvRzQDYiriBQxLe-b8b0HYaReJZiiawc0jAZvElLQOJqXg>
 <xme:jtWXZqx5g5fzOdExuGG2E1v8onW-oFNqwqkw_4DVxA3xd_OkdiNifbpLrLB6qxNLh
 Jnhwhs_XnCxWgfWK4M>
X-ME-Received: <xmr:jtWXZm2uO-yQL_Kz7wpspPBmkzRAnUVXVKawFlYYt0_fupPP3pUvwQi-9gMSZV0zYzH4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeeigdejudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhirgig
 uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
 ggtffrrghtthgvrhhnpeegjeegtdeguedtudevveeuheelvdeuudehheehvefffefhvdev
 uedvjeeigeeufeenucffohhmrghinhepthhruhhsthgvughfihhrmhifrghrvgdrohhrgh
 dpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
 rghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:jtWXZpCefsu9i3GktQYi-WpPNcCilYOSSdYb9_WPpsjREF4pDT37wQ>
 <xmx:jtWXZqinYrCsWEH3-aCTgDlPaoi151c6J9h1MqsZkEFbffvI0Q1NYg>
 <xmx:jtWXZtruaHxnBhygJKreQGb7VbaOjaTTN08DKwL7ATqnPLEM5vo0PA>
 <xmx:jtWXZlgg2-7FUjMW5_HENCNmGGcoHN5BhCOS0QzvLumEjUEUx0NIuQ>
 <xmx:j9WXZujGrhP9Vm9ij3wylK75b0ewy6F0D9x1Env28tQYTmJcVueoImve>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jul 2024 10:30:34 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 17 Jul 2024 22:29:25 +0800
Subject: [PATCH 14/18] CI: Dockerfile: Bump genimage to 17
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240717-docker-image-v1-14-7c7fc6251e7a@flygoat.com>
References: <20240717-docker-image-v1-0-7c7fc6251e7a@flygoat.com>
In-Reply-To: <20240717-docker-image-v1-0-7c7fc6251e7a@flygoat.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1037;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=GAqlSp4eLSjfJR06G3YwIRNHu543PLdz0bIffMoUoio=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTpV10s18e1batMaX6654PftbKAx24uBkmm3cF77xyuu
 Cm+szWzo5SFQYyLQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDKEgYtTACbSsZPhn2Kgmpzwj8W6b85m
 ZE2qbevv3DZve87sSxOF+JhjOtjOXWf4p+95pNxL+xTvFYEUN7cjmb2vJ+9ULFeK2DT76v+Js27
 /4wYA
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
 tools/docker/Dockerfile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 91256f0248e4..cc6e9dc4812d 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -200,12 +200,12 @@ RUN git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git /tmp/t
 	rm -rf /tmp/tf-a
 
 # Build genimage (required by some targets to generate disk images)
-RUN wget -O - https://github.com/pengutronix/genimage/releases/download/v14/genimage-14.tar.xz | tar -C /tmp -xJ && \
-	cd /tmp/genimage-14 && \
+RUN wget -O - https://github.com/pengutronix/genimage/releases/download/v17/genimage-17.tar.xz | tar -C /tmp -xJ && \
+	cd /tmp/genimage-17 && \
 	./configure && \
 	make -j$(nproc) && \
 	make install && \
-	rm -rf /tmp/genimage-14
+	rm -rf /tmp/genimage-17
 
 # Build libtpms
 RUN git clone https://github.com/stefanberger/libtpms /tmp/libtpms && \

-- 
2.45.2

