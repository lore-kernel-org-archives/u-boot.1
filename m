Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27FB1C27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 21:05:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D62EC887C7;
	Tue, 11 Jun 2024 23:04:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="VcPDuoiK";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="lHv3HH3e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAF37887DD; Tue, 11 Jun 2024 23:04:35 +0200 (CEST)
Received: from wfhigh4-smtp.messagingengine.com
 (wfhigh4-smtp.messagingengine.com [64.147.123.155])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EAF58839F
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 23:04:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailfhigh.west.internal (Postfix) with ESMTP id A35571800146;
 Tue, 11 Jun 2024 17:04:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 11 Jun 2024 17:04:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1718139871;
 x=1718226271; bh=2vRX1JwwqtdbAOuomTgo4I+n1KbsmbmyWQvKjIMPbxc=; b=
 VcPDuoiKdQEXHK+zPJXsGoDHNE3YujxZldGzzqQK/u4PMFqr6Dd9n+DnkKdy4pfy
 X/N1vfYu4CZFWBd6eTEUVL3E0HOWxBmmVVUw7wIRVz7z5QE0Xr7FiBNuO+U658xf
 e0tYUd+/FOmRvnech+OntHmEHjw85MSl76SwDGRn4OnEET6Clp2qJllCRUtCl6Gr
 CIN/+9KknQFl8FYHYaJ4E4Boz3zewDVOX0tkIt592IXl6w7b33zEWLB45lCz6sYG
 aek9RGnBBJhClQKDi1NjotDe/DcvIfTc0vPfcFiyDiIkIv8fAhEKEZYFmxB1mcL6
 jyC6pCHfEekArjaJin8PaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718139871; x=
 1718226271; bh=2vRX1JwwqtdbAOuomTgo4I+n1KbsmbmyWQvKjIMPbxc=; b=l
 Hv3HH3eplk4GzonLodbae0k1t8ooCHxoqXXg0u3YgeVnK1ciLV5BJhTD4X6eKNCw
 hWskKynW6KMt8IWpw+bOPRhVgXo7nZ4/sv1FdR2YSr3C7F/hVHnT7E0vNjrNg7L8
 3o504hoDQsOFibQGZUU96+ogzzEWrg54tK4ssibYSFR5VlDDcdIEqK0pQxJs59Yo
 LJePFkcUCDIas0R5fdJ1RbsHFsOYpKhd7qVqadY3NUHBMqS72nQhW1ZmDXvuovSH
 OlEtEnGCLqdPR71FZuWkw82dyQ08+rn5GJ0t/17GOm8XJUG9/WyToseL68VCmgRs
 grfv2rB2L9AJlgggGBNGA==
X-ME-Sender: <xms:37toZmEDjf6lq8mDQ_ACa9jh_phMe-2_RljpWIPAAL25cL-48QJSyw>
 <xme:37toZnWydZZ1o28soCGh3TZpBgycXsIdQ7I124eXE2x4HxFHIPmOqWv1xkO8jJubq
 9ixpzMUhbd5NwPsbbM>
X-ME-Received: <xmr:37toZgJyrr-Vs7o7DM0fWwz8lp8huHYgxYucXrBx3WrjGyAiDj_wVhc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudehgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
 rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
 enucggtffrrghtthgvrhhnpefgleegfeekgeeggeeifeethfejjefhuddvleelheetveek
 tdehgeeghefhffegteenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsth
 gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghn
 ghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:37toZgHDb3JwWI7EkWnlaeF8uVIb9xxLTmo_aLfg0A5b_EQxIX1IyQ>
 <xmx:37toZsWx-AGT79XHJWVSvXtDSqmCobGL-lKDhvfhvVL9frSSIQRk0A>
 <xmx:37toZjNLHX805LWGPkCRefhxUF_MMKTup-X_r8KLtbaa-XPpiptftQ>
 <xmx:37toZj1oqnBv_O1L15qtFW6Qezchk8e-rCY46saXNxGovuNxY1cZTA>
 <xmx:37toZgrfxaidgzkvaQy8c0WmOKtnuElo40kkR0FZ1o0b7dbf7vGAxhc4>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 17:04:29 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 11 Jun 2024 22:04:06 +0100
Subject: [PATCH 07/20] py: Bump requirements versions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240611-docker-image-v1-7-51472eb70357@flygoat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1224;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=Be3jhFZkBITpCP4KOiVsaEb5bqE98m/zZH5kYBmlntE=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrSM3WdbPshH9okXlyvcCPMOf37hpdTvPK9JQZZiRvEaW
 xZzLD7aUcrCIMbFICumyBIioNS3ofHigusPsv7AzGFlAhnCwMUpABOJWs/IsIWFccViVbeDQf5O
 H/cnr9zVfEZ2z8rkm97eTyZMO3Droxwjw3brLV6vHq4wVmkqeuRi8vzZm0q+3PyJgoeDbux5Zqe
 wjQkA
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

Bump python packages to reasonable versions to fix build
error with Python 3.12.

Link: https://github.com/pytest-dev/pytest/pull/11094
Link: https://github.com/yaml/pyyaml/issues/736
Link: https://github.com/pypa/setuptools/issues/4002
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 test/py/requirements.txt        | 6 +++---
 tools/buildman/requirements.txt | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/test/py/requirements.txt b/test/py/requirements.txt
index f24a842bfe6f..b7658d66665d 100644
--- a/test/py/requirements.txt
+++ b/test/py/requirements.txt
@@ -6,7 +6,7 @@ pycryptodomex==3.19.1
 pyelftools==0.27
 pygit2==1.13.3
 pyparsing==3.0.7
-pytest==6.2.5
-pytest-xdist==2.5.0
+pytest==7.4.4
+pytest-xdist==3.6.1
 requests==2.31.0
-setuptools==65.5.1
+setuptools==70
diff --git a/tools/buildman/requirements.txt b/tools/buildman/requirements.txt
index 350da42c0ebf..2b40d8e2499a 100644
--- a/tools/buildman/requirements.txt
+++ b/tools/buildman/requirements.txt
@@ -1,4 +1,4 @@
-jsonschema==4.17.3
-pyyaml==6.0
-yamllint==1.26.3
-setuptools==65.5.1
+jsonschema==4.22.0
+pyyaml==6.0.1
+yamllint==1.35.1
+setuptools==70

-- 
2.43.0

