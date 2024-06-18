Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC3BC2BA18
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 13:58:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D875188413;
	Tue, 18 Jun 2024 15:56:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="nar2dnqe";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="rspzHiYz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB08187F5C; Tue, 18 Jun 2024 15:56:47 +0200 (CEST)
Received: from wfhigh8-smtp.messagingengine.com
 (wfhigh8-smtp.messagingengine.com [64.147.123.159])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABF50883DA
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 15:56:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
 by mailfhigh.west.internal (Postfix) with ESMTP id D9C5D18000D7;
 Tue, 18 Jun 2024 09:56:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Tue, 18 Jun 2024 09:56:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1718719003;
 x=1718805403; bh=A01cnMSFJgBVxMzE0hPHwkoESZYxD0PNvMhBF2hWkcI=; b=
 nar2dnqexGzVodNREQ7itUJO7sxbEOHZ63fff2fOaAzjyMWQli4qlUzH3bzq+mCn
 tKG83p6JsTshTdETihp252rgqq8mmfZ5M7zL+WGupzJfE3qEpLjnMNdErMvun0un
 YWhq3KlUFqyJJnIAE0Lw4A7VLQzGdnJ0JFaujQgYxFnFFiQpwSsJylKtnzhl2zOE
 wKs7PasX70/m32B7AEJMg3nxlP8/VjBgIrcOQ7DQNP9XplU93ZLWqBy9/DbRELAk
 Rut0ovP+0/UmE21U/iT4wygvhnamOTKGN7/K4RhFGaX4H5p0k6PP+URj3sL3NtsY
 caLV9UyPInvKg5qlENEXxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1718719003; x=
 1718805403; bh=A01cnMSFJgBVxMzE0hPHwkoESZYxD0PNvMhBF2hWkcI=; b=r
 spzHiYz/plwU2TU6tWtEUnnCg2JKop2swYp8MFnR2BFA/WZtfLSqziHYjwl1GzR7
 0qea8o++qZ/zvZTYQIey/V4CTx1Zje8BJ8qgCPGkAId+sv+QFxM/ZLM4GrBxBHpX
 H7Wg9bGbGosccSbcMHV+zVM6zTKsVLhKStX1PDnFKA5QuLr8giTa57Z+mVOaXhoJ
 KH6DluAU3/AktkPfCYDTBc68AUEO6+CRTCWG7MmqCFjGJFdvbVAShZgsTTIMJhNl
 sgAchrae3QvCvnhDhnPKBd4UG/cFwDQnNJB8B3br5BO/pzSMkKvZez6z8GsRnujX
 uwtucFidIDtKrlqFozHwQ==
X-ME-Sender: <xms:G5JxZmvoSiYGF9haMN5jejNWHRnCl8l6dX_1j8UUNARgIZr-T3iCFw>
 <xme:G5JxZrczT-91h9XPEBGSpU6nckTe_ALwWrRLXsVrMtEeyNy7Dtu5aPXNsFXVxMQZ8
 vdjAMtHVEgyk3dyatc>
X-ME-Received: <xmr:G5JxZhzHQ2P6hOhqkdPJhdoKncIhRK3SExNBPYT6TBwJKh8cEStq21s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvkedggeduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:G5JxZhNbckMxhoF2yPfCyhdMaf6vVuk_6ixSoFy3n0xw2Wv5WlCm2A>
 <xmx:G5JxZm-dSyGzT1OF1yLVWWlPGK8kT9DlbkOzta0i8Mud3Fa5Be0Hiw>
 <xmx:G5JxZpVe3gGPy596IqxjFgIJVyTadRBuH9a6jBoF0L0KgHg2hQH_EQ>
 <xmx:G5JxZve0oW5w36_vUxxcWvBjgZwZcdUfmdGInvWjNYg8FBFZ6PnBDQ>
 <xmx:G5JxZmw-v2o16qKNwZQNqwKvZ7sDnzu_LfMCb3VPQGsp5MOABRILGlNb>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Jun 2024 09:56:42 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 18 Jun 2024 14:56:11 +0100
Subject: [PATCH v3 11/12] ci: Wire up qemu_xtensa_dc233c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-qemu-xtensa-v3-11-f5af5e6fdd23@flygoat.com>
References: <20240618-qemu-xtensa-v3-0-f5af5e6fdd23@flygoat.com>
In-Reply-To: <20240618-qemu-xtensa-v3-0-f5af5e6fdd23@flygoat.com>
To: u-boot@lists.denx.de, Sean Anderson <sean.anderson@seco.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1185;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=VUxZL4V/YX1xSaAz/5vxbEi1O9K5mg2R57wFiFOJmoQ=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTCSYx7cm8L75E/uXpKX0BClnPeyoqdcfb+ttHntqRfc
 J3+1bCxo5SFQYyLQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDKEgYtTACai6sHIcLj75tfeP0w32uu/
 Sm3d4SetLvgqSK7M8tbBhpkRj602z2BkeLBbb67f9C9/Q1Yqz/qzLKv3iFi568NFC69bWpuFbY9
 05AIA
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
 .azure-pipelines.yml | 3 +++
 .gitlab-ci.yml       | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 27f69583c655..b149db62798f 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -413,6 +413,9 @@ stages:
         qemu_x86_64:
           TEST_PY_BD: "qemu-x86_64"
           TEST_PY_TEST_SPEC: "not sleep"
+        qemu_xtensa_dc233c:
+          TEST_PY_BD: "qemu-xtensa-dc233c"
+          TEST_PY_TEST_SPEC: "not sleep and not efi"
         r2dplus_i82557c:
           TEST_PY_BD: "r2dplus"
           TEST_PY_ID: "--id i82557c_qemu"
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 165f765a8332..83dd07e26f4b 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -419,6 +419,12 @@ qemu-x86_64 test.py:
     TEST_PY_TEST_SPEC: "not sleep"
   <<: *buildman_and_testpy_dfn
 
+qemu-xtensa-dc233c test.py:
+  variables:
+    TEST_PY_BD: "qemu-xtensa-dc233c"
+    TEST_PY_TEST_SPEC: "not sleep and not efi"
+  <<: *buildman_and_testpy_dfn
+
 r2dplus_i82557c test.py:
   variables:
     TEST_PY_BD: "r2dplus"

-- 
2.43.0

