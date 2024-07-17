Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB803C3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 14:32:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD93988A9B;
	Wed, 17 Jul 2024 16:30:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="Zxc9lIb1";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="WxVp84eS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 645E788A87; Wed, 17 Jul 2024 16:30:29 +0200 (CEST)
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com
 [103.168.172.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C50ED88A87
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 16:30:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfout.nyi.internal (Postfix) with ESMTP id F3E821380130;
 Wed, 17 Jul 2024 10:30:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Wed, 17 Jul 2024 10:30:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1721226624;
 x=1721313024; bh=XXpEa1QbtT++7mTRT9Zmq7X33FfxIJ7BgyCoL7BttcY=; b=
 Zxc9lIb16ELJzVoBkUT69nRNE95JiWcdfQJQfrHplcHqOFsY14ZB68XKEf8RwkMZ
 TmtbdSrIszFBi5M621dEJg0XVvHIensF2p4Qx1q7Y6LqFy2D5QbEj4JbuXbg/XHe
 5zePHwcYkAtp3q3oNn5SKcAHe42rXzevWim+3hKTfecvw5zIa40veoh41nmkdc8x
 gq2qO6WC2bdxBSV2uRq0RaxRqTuBL48qPFY/wdTKyyd+xQynmNrtfSHaz3a7Eo7J
 Z6lODqSR/cxoCUXLJztyGbaPk1g2GjeF1y8BFWJuL8mL+rn9oDvVSVtbxbB9Olmn
 YFZEi6Trydtkrr7f/9iGsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1721226624; x=
 1721313024; bh=XXpEa1QbtT++7mTRT9Zmq7X33FfxIJ7BgyCoL7BttcY=; b=W
 xVp84eSqUuE0XrvLLhPq6h7scARbNssCqSCmD62azClyiuARV3sLpCAo8zSOmjcw
 kei++xnspyWf5IyWV4IWxYJqGeCP6WmBMIIepu/XeVbfwDQxOgfLnIptqrMRzSWf
 MtZzHQ+CkrngqaRE1J15DAAdXdh60Iw+sGf8/2i/xoWZxp6aSYNR6ZSKDtov+wSd
 ow4VZM7v4o+O03apUpBj98VbQR30i/ItIe+3uTNW6olYgU4MtUB5iyJY6Jb8aH0f
 K6ksis/Ppcn9/JOd8qJV6mfwg+fwRu+o0iKpO7yfjUoUXrrLtQjGeH9Dd9uebo+2
 tNOlXZDmNFaB0BNkTIVOw==
X-ME-Sender: <xms:f9WXZkwQbwKh0One_28rJFbteMdpi9GLAdERKXbpN9BVUJgEjm3g1g>
 <xme:f9WXZoRU9Afg3Lvnu5ZtT730adQHunqTABbRzfQyFUee-2TTXRUc_OtMI-9EwNh_H
 jBZML936FVokqiz23E>
X-ME-Received: <xmr:f9WXZmXsBkDAg4AIC5DEUdrK2RQOcoiOUbTk6eufzw2kJRS9kox7wjzBmtf1ZJZvNf_0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeeigdejudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhirgig
 uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
 ggtffrrghtthgvrhhnpedtkeeiueegtdffteeuffejledvkeekffegudelgedufeektdeg
 hffhhfeigeeigfenucffohhmrghinhepghhnuhdrohhrghenucevlhhushhtvghrufhiii
 gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhih
 ghhorghtrdgtohhm
X-ME-Proxy: <xmx:f9WXZijRVEN3W5mmgiql8a-Z0vpOKTo8iMfdbbSKOwSxY4Z9aQ6znQ>
 <xmx:f9WXZmDCKpzKgZ5X4--2L_ilKQAggw5NIn6w-Bq1ivxWQPnXOskySQ>
 <xmx:f9WXZjKfPdoaU4rLlBKJEFeVHibMBccwFP8cffcdvEzLr6r2UyJj8Q>
 <xmx:f9WXZtBF-dnACO3i3AAEmhN-r0dN6Wds1I5Z0QugIpsBfKiJpFZcBg>
 <xmx:gNWXZsAH7KtE_ekwrha_bpff2ocYH64VCPgJu42SMyW17ftm7h8nt4Mv>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jul 2024 10:30:21 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 17 Jul 2024 22:29:22 +0800
Subject: [PATCH 11/18] CI: Dockerfile: Bump GRUB to 2.12
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240717-docker-image-v1-11-7c7fc6251e7a@flygoat.com>
References: <20240717-docker-image-v1-0-7c7fc6251e7a@flygoat.com>
In-Reply-To: <20240717-docker-image-v1-0-7c7fc6251e7a@flygoat.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=820;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=n+ZeAC8hM1FLi6n8sgOC8GqeaYk2lyAnsS0AA9gFqZs=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTpV10+z4yNrNrafbfm0Ppaa1cL0fdLHszkcJi7lH1fi
 O1zcz/PjlIWBjEuBlkxRZYQAaW+DY0XF1x/kPUHZg4rE8gQBi5OAZiIwEuG/5VOblXn5jbx3X4Y
 dWWBsdP0gnkM0dI2HtzTarf2icq6VjMyTNu8IkjG7Hmf2IEXT7WkulKFKs4W6Xw/+uXyhbuh8ww
 vsAIA
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
 tools/docker/Dockerfile | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 0bf2d180e255..8e144a2b64e9 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -136,9 +136,7 @@ RUN chmod +r /boot/vmlinu*
 # Build GRUB UEFI targets for ARM & RISC-V, 32-bit and 64-bit
 RUN git clone git://git.savannah.gnu.org/grub.git /tmp/grub && \
 	cd /tmp/grub && \
-	git checkout grub-2.06 && \
-	git cherry-pick 049efdd72eb7baa7b2bf8884391ee7fe650da5a0 && \
-	git cherry-pick 403d6540cd608b2706cfa0cb4713f7e4b490ff45 && \
+	git checkout grub-2.12 && \
 	./bootstrap && \
 	mkdir -p /opt/grub && \
 	./configure --target=aarch64 --with-platform=efi \

-- 
2.45.2

