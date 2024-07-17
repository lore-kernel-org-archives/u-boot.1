Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63544C3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 14:33:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 934FC88AB8;
	Wed, 17 Jul 2024 16:30:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="AB/Axx6W";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="A+LEKxij";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0523188AB7; Wed, 17 Jul 2024 16:30:48 +0200 (CEST)
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com
 [103.168.172.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C76E188AA6
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 16:30:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfout.nyi.internal (Postfix) with ESMTP id 013D3138014C;
 Wed, 17 Jul 2024 10:30:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Wed, 17 Jul 2024 10:30:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1721226644;
 x=1721313044; bh=+cUo9amc+i8WCXZ53M4FyXy8H0c1vt/Ah7pT2l5EVLk=; b=
 AB/Axx6WZjh/NjiprtJDsY7bixuCXsVDaRVRMf4x0FG+4BpMacM/9e8rOUr8bktJ
 fGLJzjlMFNiMU3E2iXnz7+RnAvOnB2IdH0Q11wye0bFtWV1bWPggR9GTo8N+yig0
 3dI/loMTbqG/Sz8Ohec0tK+49Ji5anyVI3diQr3AXbow7q8fSQL/Ikek0V+ZWfmf
 WWEcqOKTrLCEIwcOYBJiG+OTITO5sfpHMZn1BQ7PdusnPY093MNoZ8mrzAISWC28
 uSWAx4iNl/794xBu4O9+zCQuQPSQ/ljKZZSBrA84g877XcetEOoRfRf1T206fSLC
 sWcVuXy5zYnfX+mbIwn4GQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1721226644; x=
 1721313044; bh=+cUo9amc+i8WCXZ53M4FyXy8H0c1vt/Ah7pT2l5EVLk=; b=A
 +LEKxijpFtc+nHnHugkVKjlPuBIpFDUNAbUArujKY6f8ISObpUEVs0YtSgcg/Xew
 CNdI0/eResS+U/czocMux87BoDN4A+0YRZ+aL5Tk2xFe/SwL6smlFZ5kzOfhQmwA
 jq/zkLV/P+luSYQqFWZfHgBF2gnkZdUnR315A3mZ0ZkrkTIrgGemwSNFsKuqGS+d
 gApJZN0Oa326ZbSzL9y4XjAE0NaXnC1/2oDk+EDInaZM+HOhHl4BOSFy313+8/+E
 7EBKWUluDe/zwcy7fylpSmrYPZH71IBfqRnvI6qeQ34m4tPYv7QqYE4+/MV9kkB5
 DGsCVINeTREhOZjwrtVFg==
X-ME-Sender: <xms:k9WXZjLUj7JOGdgtmIncA3_p_VPgLJGxKQDJeP9nxwtqc2PSYGHviw>
 <xme:k9WXZnJh8IFR2UWhcB17Beov88U3bKVuoB1Qw4UFsHtIIaE9ysQATPCqFCiOAbA6T
 5KfpOPBFjGLSE_zOYc>
X-ME-Received: <xmr:k9WXZrtBXvM9VE2gRbI_u7lSSpmi4_g5gOa_XcfhF8e3gg-MstLeEgUHzsENCXgll0rt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeeigdejudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhirgig
 uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
 ggtffrrghtthgvrhhnpeffveeifeeljeejfeetgfeiueejieffgeeuieegtdekffekgedu
 udduteejleevtdenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdroh
 hrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehj
 ihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:k9WXZsZqd1VU2aTwfbnZxYN59lR4TgPHE-jIooQbmpXJpdp0d2QQCg>
 <xmx:k9WXZqYekgwGUUikU13EPltvfQuUKcu-Hq9jERzoHFmhkg6ltfX_0Q>
 <xmx:k9WXZgDNrlfpwa-ljQR2Bi6JLW47JL965zRh04I9V6KTY3kwe71N2w>
 <xmx:k9WXZobaONBPZdsajP8xO-773qW88ShNA5gHGbxuXrcNbOP8MITEoA>
 <xmx:lNWXZi4s3biWrVN7kHJH8czkhZqMRG-yZT4q_Jpd9Rg5Mas0O2oXsOAa>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jul 2024 10:30:39 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 17 Jul 2024 22:29:26 +0800
Subject: [PATCH 15/18] CI: Dockerfile: Use kernel.org upstream for
 trace-cmd
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240717-docker-image-v1-15-7c7fc6251e7a@flygoat.com>
References: <20240717-docker-image-v1-0-7c7fc6251e7a@flygoat.com>
In-Reply-To: <20240717-docker-image-v1-0-7c7fc6251e7a@flygoat.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=775;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=8Su4CY/mP0535T8VmwKnDw1/ew0nsCKf8ogkc93BGII=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTpV132PUqSWq1b95ltRe0qjfsvVFu/TxNelnEgKTPlj
 sICXdE/HaUsDGJcDLJiiiwhAkp9GxovLrj+IOsPzBxWJpAhDFycAjCRVzsZGX5lSp41MEo+cMew
 L7y73Z+33ObvxOtHX0/fWPF7Tv+vPn6G/3lnvThrL4keOTat5X/tHIl7W7t8zza92Ovl365zfI9
 4Fj8A
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

This is project's upstream URL.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 tools/docker/Dockerfile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index cc6e9dc4812d..f45283d72441 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -236,7 +236,7 @@ RUN mkdir /tmp/trace && \
     cd /tmp/trace/libtracefs && \
     make -j$(nproc) && \
     sudo make install && \
-    git clone https://github.com/rostedt/trace-cmd.git /tmp/trace/trace-cmd && \
+    git clone https://git.kernel.org/pub/scm/utils/trace-cmd/trace-cmd.git /tmp/trace/trace-cmd && \
     cd /tmp/trace/trace-cmd && \
     make -j$(nproc) && \
     sudo make install && \

-- 
2.45.2

