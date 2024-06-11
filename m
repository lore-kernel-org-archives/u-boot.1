Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E94C27C65
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 21:05:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A70A8887AD;
	Tue, 11 Jun 2024 23:04:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="BwU83LJp";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="GSAKiq6s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 298C7887AD; Tue, 11 Jun 2024 23:04:28 +0200 (CEST)
Received: from wfout2-smtp.messagingengine.com
 (wfout2-smtp.messagingengine.com [64.147.123.145])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1879F88739
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 23:04:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
 by mailfout.west.internal (Postfix) with ESMTP id 13F321C00091;
 Tue, 11 Jun 2024 17:04:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Tue, 11 Jun 2024 17:04:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1718139863;
 x=1718226263; bh=+hTHAPUndmDGnJBOKypzjfNfd8Kd/QBOKlVs3aF1skM=; b=
 BwU83LJpZIFecxpOa7T2JJX9mHKwpIfqyI5JivcqPica1W/MFzilbzfNGLYdSScA
 HjDZkj/EqZi//P/8NN+hIvzbvlzeAR4VrZAHxkHbeaYgqHNoisE8yNOylHB3m2zd
 1cwAi1l9TO5BjML48X1/Ecjx4V/xgc1sxEZZ8h5+FS+c//SRsm8BIxICeFfKr83+
 IGG5w5tPAcaS1D6Rdhu1orJEpnzuaJNbflZqj1UswgHJe2WsjwDLh20FaEkJxeds
 0w9RVFhxKR+jCi5u3SC20JoUVhLVTxGQHNOeAeeB7yIoHZZOo0iZczta2oIsDX8a
 7lFmTyNRNU8a3DMAYDrqRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718139863; x=
 1718226263; bh=+hTHAPUndmDGnJBOKypzjfNfd8Kd/QBOKlVs3aF1skM=; b=G
 SAKiq6sf3zvdnC6+b+ba084HAZUp9ehGSNFDCZ1jq1efcyAsqzh2ewA6X9ZaYqfl
 ru3IUvCYTqhISSHDyLPFp307Z1MuUK5HLx++vBL9sJb4l2yZUQvmYzobtrEYNigr
 sxcoV6HBudbS9ojncgEIQHh9ZJ1U5QtW67YFC1/8whwghmMFnF/ZSNfcNkxmuaYM
 djNsY59b9K48tJieA/zw//AxLXBPImoCA3H12ZGYQIDe25zX+aPVO96ND8hqsbuS
 qHUN6txysPPmwbvEHtk7oJ1Mf6atzP7DgWXEN1kZzQ2kYgA+O/iqkTIYL7N+rvtZ
 MWYU7G3tz9KBY6nCQjoFQ==
X-ME-Sender: <xms:17toZm8AhdljIJrVldba6H8NRPXA-LsNia0y53CTDXRNOk6UEZdG1g>
 <xme:17toZmsFTwxl1SohiC-tTpKLsnehtPvJAy6wzbHKHKyg-t5X24yqgrr7GCoE-oreh
 ircfBAfc-bVZN6zYbM>
X-ME-Received: <xmr:17toZsDIh_z_tORLkgfCrVY0Jp_lH34JcABAINe7cy34NJYXRR-KdGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudehgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
 rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
 enucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefh
 ueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:17toZudlEFrI0bBOYVV__vF0EigDRBP_Z6F0WWMCXJxOcSuOLppsAw>
 <xmx:17toZrOxwJMgqvL0XJr6aA_Qlxb6_hkq3Nh4EQgbjIJL0bRGHu_glA>
 <xmx:17toZokXnZROmkAF0YPIjJQFBcsPtyMqqpiJDQBK_WBZVUEmEg5qJQ>
 <xmx:17toZtus8VydrO9bLgGHirMXmKe5RqOCYIkB02HxXi8MACyelph2HA>
 <xmx:17toZkhhulxp69j4NOXmh1qs8HuonxoMfzgaf9BBRvHzGHxHayf3_AYr>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 17:04:22 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 11 Jun 2024 22:04:03 +0100
Subject: [PATCH 04/20] py: Replace usage of configparser.read_fp
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240611-docker-image-v1-4-51472eb70357@flygoat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2603;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=MvBMS4bIxSpnJoVB2N02fbsWWXoqEEDrI6IX3K/8MVk=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrSM3WfLuNRUPdV6cxcEfY2a3blPJ27B+w3X0ndsZJvn0
 2F0S8Suo5SFQYyLQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDKEgYtTACaypp2RoUHza56JzIO4Vckv
 LHsfXe9e1cktErVXgjvIb13/4WCJwwx/pfMZ9e85XFvjGe+pOjlGeDl/QrrjugczF3D+PLfd/Pd
 sdgA=
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

configparser.read_fp is deprecated long ago.
Replace with relevant API.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 tools/buildman/bsettings.py | 2 +-
 tools/patman/settings.py    | 9 ++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/buildman/bsettings.py b/tools/buildman/bsettings.py
index e225ac2ca0f4..7dbc638d5841 100644
--- a/tools/buildman/bsettings.py
+++ b/tools/buildman/bsettings.py
@@ -29,7 +29,7 @@ def setup(fname=''):
             settings.read(config_fname)
 
 def add_file(data):
-    settings.readfp(io.StringIO(data))
+    settings.read_file(io.StringIO(data), data)
 
 def get_items(section):
     """Get the items from a section of the config.
diff --git a/tools/patman/settings.py b/tools/patman/settings.py
index 636983e32da8..308626107037 100644
--- a/tools/patman/settings.py
+++ b/tools/patman/settings.py
@@ -41,7 +41,6 @@ class _ProjectConfigParser(ConfigParser.ConfigParser):
     - Merge general default settings/aliases with project-specific ones.
 
     # Sample config used for tests below...
-    >>> from io import StringIO
     >>> sample_config = '''
     ... [alias]
     ... me: Peter P. <likesspiders@example.com>
@@ -59,25 +58,25 @@ class _ProjectConfigParser(ConfigParser.ConfigParser):
 
     # Check to make sure that bogus project gets general alias.
     >>> config = _ProjectConfigParser("zzz")
-    >>> config.readfp(StringIO(sample_config))
+    >>> config.read_string(sample_config)
     >>> str(config.get("alias", "enemies"))
     'Evil <evil@example.com>'
 
     # Check to make sure that alias gets overridden by project.
     >>> config = _ProjectConfigParser("sm")
-    >>> config.readfp(StringIO(sample_config))
+    >>> config.read_string(sample_config)
     >>> str(config.get("alias", "enemies"))
     'Green G. <ugly@example.com>'
 
     # Check to make sure that settings get merged with project.
     >>> config = _ProjectConfigParser("linux")
-    >>> config.readfp(StringIO(sample_config))
+    >>> config.read_string(sample_config)
     >>> sorted((str(a), str(b)) for (a, b) in config.items("settings"))
     [('am_hero', 'True'), ('check_patch_use_tree', 'True'), ('process_tags', 'False')]
 
     # Check to make sure that settings works with unknown project.
     >>> config = _ProjectConfigParser("unknown")
-    >>> config.readfp(StringIO(sample_config))
+    >>> config.read_string(sample_config)
     >>> sorted((str(a), str(b)) for (a, b) in config.items("settings"))
     [('am_hero', 'True')]
     """

-- 
2.43.0

