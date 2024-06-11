Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F87C27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 21:07:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45B2A88820;
	Tue, 11 Jun 2024 23:05:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="mboLaCnH";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="TSThrIn1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C16E588813; Tue, 11 Jun 2024 23:05:03 +0200 (CEST)
Received: from wfhigh4-smtp.messagingengine.com
 (wfhigh4-smtp.messagingengine.com [64.147.123.155])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6142488709
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 23:05:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfhigh.west.internal (Postfix) with ESMTP id 66F77180014F;
 Tue, 11 Jun 2024 17:04:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Tue, 11 Jun 2024 17:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1718139899;
 x=1718226299; bh=kS+fVm5DV4RBZaXbgp7MZYgFbzP+6rbOxf2sYC5XeVo=; b=
 mboLaCnHGEYiNOXyRu9jgKyKcw78e1fD76ZZp41A1x+bUhuzEFGdSKeeNZDV6qKy
 bxu72A1XuBEC5Ws9uwzJ07Dsbpin/VEkeJkTm0223Fq31z4q9MRTUnCnwEa1PQ2z
 8t4Inwm86xDf6+q1reJvowYGr7GI5JclaMYC0GQ4feG9P28S2OoAZ8YhCyTZtEEj
 Fow4FkXVfFjq7IT0uvS4iQmOZ30h2rkZSKdA1Wf1HtbCak5rw1hdJFfeBvt9iUBT
 FpzkQIrJqt87RF7Whp7N1nUZuRmf8cS5GoVjyOmQQoEtZiZ+isXGWaRcjJhVxtUC
 iYMxx23IoRvQR1pPUBgBwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718139899; x=
 1718226299; bh=kS+fVm5DV4RBZaXbgp7MZYgFbzP+6rbOxf2sYC5XeVo=; b=T
 SThrIn1SreVTLP+TL6Sm/zaVTwuwlfCWrf0ya4O5SYoxbCO9CNjBQkxBB6B3oCtE
 7QGZBP5ynIMQ+MiaVSihweW+c2jjU2joP8igcUAJoEVJakMRCKXsUDqkxWQQ2+yZ
 imuBZGFGe2xcY7GB7MK4nycAZ3wvdw6UykDFgWJs6VdblldBIEVaufLajtTcucgF
 mvfmZrUamv4U+T8U77uSKgpeu3JlxzXVZgwTTxRo8b2aA1tGuCd06cYby8BD7OBg
 coK3kXKwV5bls6ZhnUJ3T21kXaPE1LkE0hILqbOuSMB0yJZgj6L1YwIzXBQZYaA/
 LRPhhv406VeMQVzbBEYwA==
X-ME-Sender: <xms:-rtoZg2T2NlNAroNze95y3NsGY72lf0gwcEBXxUKJ_X4fW-vAk0CxA>
 <xme:-rtoZrFmRnNen4vHwFlAhJXcBfafmykxx1kd5NDfk7F_lAc5V3OsulZxSGCmIylZs
 yL10_w1qdIOwqkawE0>
X-ME-Received: <xmr:-rtoZo4XyXU5_3YQyuZfTMEOglUoPFuxcFsHtasQyfeofWAbu4rI2HE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudehhecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
 rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
 enucggtffrrghtthgvrhhnpeeggfdthfdvleelffdtffehheefuddtgeelledvffevkeet
 uedvgfdufffhkeeutdenucffohhmrghinhepghhithhlrggsrdgtohhmnecuvehluhhsth
 gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghn
 ghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:-rtoZp0HlPFusWK7RBn7KiHJGvl-txYXQjhPvvAzowgaPDu3XozERg>
 <xmx:-rtoZjEQ3kE1Yk3kf5GhooYUbZUtirSoVdwN434FOepzOLUZrOawhQ>
 <xmx:-rtoZi-HK3pGAbWMjyWZDNAxtdwBheXOAIr_ZoGvpg03NXyc24y0QQ>
 <xmx:-rtoZola7vMkVQ23kokdp5pGAKg15z1H_xCUdWkZgFGI8MyfBKc00A>
 <xmx:-7toZpb_RJ7Gr-CDxQ16b7-tUQTtyo_uG7MxbHcWyrjFjoTYM-iHa4QN>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 17:04:57 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 11 Jun 2024 22:04:17 +0100
Subject: [PATCH 18/20] doc: ci: Document how to run pipeline on gitlab.com
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240611-docker-image-v1-18-51472eb70357@flygoat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1786;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=m+P1ze01xShAB+kAvjfNYizclgQZR5etJ1vVLVp/M2o=;
 b=kA0DAAoWQ3EMfdd3KcMByyZiAGZou87I7ZGPf3SJM0GBqpgJgv83xU8qCWYOMw1WSzIyvW0Xy
 Ih1BAAWCgAdFiEEVBAijrCB0aDX4Gr8Q3EMfdd3KcMFAmZou84ACgkQQ3EMfdd3KcM/WQEA6kLq
 p+rBIzF6SV3cOBRq0rEqbqt4OqUakday9AWlZpgBALEi+IXOoZAupy6IKkJG9WjixVo8gR5xct2
 WJI5WYZIO
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

It's now possible to run CI job on gitlab.com.
Document the process.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 doc/develop/ci_testing.rst | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/doc/develop/ci_testing.rst b/doc/develop/ci_testing.rst
index ffaacedc3d88..b616d1c807d3 100644
--- a/doc/develop/ci_testing.rst
+++ b/doc/develop/ci_testing.rst
@@ -46,9 +46,10 @@ resources the project has available.  For Custodians, it is a matter of
 enabling the pipeline feature in your project repository following the standard
 GitLab documentation.  For non-custodians, the pipeline itself is part of the
 tree and should be able to be used on any GitLab instance, with whatever
-runners you are able to provide.  While it is intended to be able to run this
-pipeline on the free public instances provided at https://gitlab.com/ a problem
-with our squashfs tests currently prevents this.
+runners you are able to provide.  To run this pipeline on the free public
+instances provided at https://gitlab.com/ you will need to fork the repository,
+enable the CI/CD feature [1]_ for the repository, rise pipeline timeout [2]_ to
+at least 2 hours and then push your changes to the repository.
 
 To push to Gitlab without triggering a pipeline use:
 
@@ -74,3 +75,8 @@ developing features.  In that case, it can be useful as part of your own
 testing cycle to edit these pipelines in separate local commits to pair them
 down to just the jobs you're interested in.  These changes must be removed
 prior to submission.
+
+References
+----------
+.. [1] https://docs.gitlab.com/ee/ci/quick_start/
+.. [2] https://docs.gitlab.com/ee/ci/pipelines/settings.html#set-a-limit-for-how-long-jobs-can-run

-- 
2.43.0

