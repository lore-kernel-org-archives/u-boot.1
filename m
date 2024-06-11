Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23831C27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 21:05:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72422887CB;
	Tue, 11 Jun 2024 23:04:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="WH1/b8Mj";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="H3ltZr44";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 282A8887C6; Tue, 11 Jun 2024 23:04:33 +0200 (CEST)
Received: from wfout2-smtp.messagingengine.com
 (wfout2-smtp.messagingengine.com [64.147.123.145])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F7848839F
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 23:04:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfout.west.internal (Postfix) with ESMTP id 202631C00095;
 Tue, 11 Jun 2024 17:04:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Tue, 11 Jun 2024 17:04:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1718139868;
 x=1718226268; bh=YQEWiyBxAjbY6orLgHGoxohH3NPgkf+UQcq2NXmJ8RA=; b=
 WH1/b8MjsLL9cjIlLNPQ3zjZ08zUmfG5WqzyvsS0XikbthuOOMUuHeFsN7Uzj7Wq
 168NSmFELKFY8UiR0XIXiFBVmU6DmR/BA9/MmYvD9VcDncTROFKLy9X/bxoxFX18
 Rhpei97v+NbglITlOmxWmdRMO+Ot4IsqeqibxN589MCPKK3kYOUGHv3DAgHVSFwD
 HM6EBp1/6nRLYvYFvqOYQu2yDoOVdJSQBvCEgDO739nlqbls9qLZV2nm+w9vqrwU
 WrdniS6MhNLosKPgp/H+gkPuLGHiwekFvGz3IMnhAtrcyMemO4WMkVdRkRzbrMeL
 DnT0AA/imSOE3AMk1c8pIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718139868; x=
 1718226268; bh=YQEWiyBxAjbY6orLgHGoxohH3NPgkf+UQcq2NXmJ8RA=; b=H
 3ltZr44FP0mYpeGXCu9WdFK8nyoIiueYdO/lAtmfBQ1xe1ZPrx/GId7g616X3+Hl
 uzLeu2Sav1bkwNO0QlFnUEpJMhRZGeLMaCDQupoM28kU7/XQXTLUcYlyXk3dQF26
 pi0gKMViACJx3E5Mr4G/fdDhuNHt1y9N2JKG/uYbYVbhPPMY+v4jPZW3sXiaXT2L
 nhxwMyFWVivpK4xa0OCfPDtgSKcPWbbjHJl88TqUbhLEgtda1B2uIP8AfIC66Fdl
 u4+Tt337YAuAJRgemrJb9mqzzEqM68OYwKH/8qNLNy9ehPVTQTLK5AkRVcsnGN7b
 M0X2I6nuzTK1WH+UKYGsg==
X-ME-Sender: <xms:3LtoZgL7mLGhmJOqxy55T9-ouTVA_pYATkffdQAZgJuRPFY8ZxIuyQ>
 <xme:3LtoZgLIdHlM4-3fk_0_mkDCzLFbuRvTv-3JRUTO6Qzg0SdXnpk5EKr9NqkVB4tw7
 5rQeq3lTCW_9skNoX0>
X-ME-Received: <xmr:3LtoZgtNo7ebORbThsZefF_yZQrhYkpGPdxiftouZKU1DmfUqdkib3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudehgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
 rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
 enucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefh
 ueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:3LtoZtYbx7yHJxcdVo6E9yqmG0mezkSfvezoRiZVDSxnhklfFOBc_g>
 <xmx:3LtoZnbiVL0Kul5B5HSnxBbMgxdMcBDD_NfhvvSqjOnjKhEtZ32IZg>
 <xmx:3LtoZpAMSXq9BgZsBM10D2WTzwdZ_Y0maHGVBr1BYshV_IiqcxdpYw>
 <xmx:3LtoZtZKwZmL3lU42ZS4CKBviliblC-qHQah9VDLVi_ztpbx3Tkvvg>
 <xmx:3LtoZlOOuyctLDY0eavfQsk9ctO2KoOJ3xMCkbW1vmxOF4cF4YirNGfG>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 17:04:27 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 11 Jun 2024 22:04:05 +0100
Subject: [PATCH 06/20] py: Remove unused entries in requirements.txt
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240611-docker-image-v1-6-51472eb70357@flygoat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1499;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=eFjr3KYML01q04WDpbrMulfdmGyiWgpUAU7i2N7XL30=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrSM3WfXVO39tnnugRs9FeJtrzkMo3T2l/qJ9MzyfpnoX
 3vxmkZBRwkLgxgXg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAEzk9XuGz6wn61627gxMznRL
 XdJjMf3T4a8SW95NjnviltRcFee6l+GfSUBP1JSdOeeT5mtxykztlrRROVo/5aD5RhffH9Om2GU
 wAgA=
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

Many packages in requirements.txt are not actually imported/used
by any test case, some of them was for python2 compatibility.

Remove them to keep our environment clean.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 doc/sphinx/requirements.txt |  1 -
 test/py/requirements.txt    | 18 ------------------
 2 files changed, 19 deletions(-)

diff --git a/doc/sphinx/requirements.txt b/doc/sphinx/requirements.txt
index 426f41e1a028..12447386d29b 100644
--- a/doc/sphinx/requirements.txt
+++ b/doc/sphinx/requirements.txt
@@ -10,7 +10,6 @@ MarkupSafe==2.1.3
 packaging==23.2
 Pygments==2.17.2
 requests==2.31.0
-six==1.16.0
 snowballstemmer==2.2.0
 Sphinx==7.2.6
 sphinx-prompt==1.8.0
diff --git a/test/py/requirements.txt b/test/py/requirements.txt
index 0f67c3c61949..f24a842bfe6f 100644
--- a/test/py/requirements.txt
+++ b/test/py/requirements.txt
@@ -1,30 +1,12 @@
-atomicwrites==1.4.1
-attrs==19.3.0
 concurrencytest==0.1.2
 coverage==4.5.4
-extras==1.0.0
 filelock==3.0.12
-fixtures==3.0.0
-importlib-metadata==0.23
-linecache2==1.0.0
-more-itertools==7.2.0
 packaging==23.2
-pbr==5.4.3
-pluggy==0.13.0
-py==1.11.0
 pycryptodomex==3.19.1
 pyelftools==0.27
 pygit2==1.13.3
 pyparsing==3.0.7
 pytest==6.2.5
 pytest-xdist==2.5.0
-python-mimeparse==1.6.0
-python-subunit==1.3.0
 requests==2.31.0
 setuptools==65.5.1
-six==1.16.0
-testtools==2.3.0
-traceback2==1.4.0
-unittest2==1.1.0
-wcwidth==0.1.7
-zipp==0.6.0

-- 
2.43.0

