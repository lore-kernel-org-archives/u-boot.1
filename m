Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C95C4C25B75
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 20:54:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 860398831D;
	Sun, 19 May 2024 22:53:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="O3YAVKD2";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZOxj38OB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 718A188193; Sun, 19 May 2024 22:53:58 +0200 (CEST)
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com
 [103.168.172.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89FFA87E0B
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 22:53:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfout.nyi.internal (Postfix) with ESMTP id C48DC13810DC;
 Sun, 19 May 2024 16:53:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Sun, 19 May 2024 16:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716152035;
 x=1716238435; bh=bQlBt+iVfUSK4kxzCcJXnHm/QJScWt2flOGPD1wpAxo=; b=
 O3YAVKD21R3XbwWYg3wyzsk6jIkEzdWqcObP+tEIYftB8ZTEVDtDK5lY/e0hwWcQ
 QTKQ4idHerVhKfAyhUL6cxRSECLTZRqXWcqUmeDlrRNSegNjQanPR/u/Qtjvpl1Z
 oh/2rEeDi+n+TkGdQGbquMwYLSt8v/TxUM+zOPC0C3ioI3aoFg51tcLsigEMyA27
 /LnEyCVynRrvCO7+vhzl9sIYhD1ld9PoiPV7HEobBeTv/Iq3PiWDqTkoE8w699TD
 DPCVwyMfwDuYczOlqjbfmWVkJ55/QWqRefL4BYigqWbPZwNq95mzGT8U5xmRTq/M
 howTPjCT39twD0zpAY8bIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716152035; x=
 1716238435; bh=bQlBt+iVfUSK4kxzCcJXnHm/QJScWt2flOGPD1wpAxo=; b=Z
 Oxj38OBGD5o/PYbrXA4d801RZMozzaHz1pMOFOQYdsF8XloiDPPvjrx9uc/WlZyl
 9GbE4k4owQHk99saA6Nap57BopgpP8gCN1qPwf1liJMixqnDdlAppTuFZuGaywEY
 eURgd15DxFXGtSr08JoInmFZbDIXo+wf146XzZQj3D2kIYQwIPX4/3v42zt/KM6f
 620219adXT/rwo9lITuvD+vx6WoD9U1Dq/npAEfvWkc9sbU8liGPqIrnp6eOay8e
 qF8sgyZOeV+gvP2/7LYr+RCib1+US4FJZksWh30bJ/xqXpcKQ8lY6f0zK4zSJA7t
 IzXLFjYXhE3aQEvhNtv5g==
X-ME-Sender: <xms:42ZKZvvi_N0nIaa7E9IUpbxK-5C20QLQkRuSL5GE9cVyb7KEKABZ1Q>
 <xme:42ZKZgdD9OmgJ7MF6PHCu0--7IxChiYoxwb59gQbsDsBnDTCJ17ip5iDvXNBgHORD
 -IcsHaMfYvJyH28syE>
X-ME-Received: <xmr:42ZKZiwsDeWsmIk1XVhxbEpchGy3Ng3zrSMKkbPrJwinoRyMfm4ydDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehkedgudehvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
 rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
 enucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefh
 ueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:42ZKZuPCvoEbSLE7-sQjG2TbWmcLLxA1cQSLR0MQNywUHwjhsQkLhQ>
 <xmx:42ZKZv-w2GCu4xbaSALd8g3sq3xWMdyI0_9AVQQCnVUWkaCm0KE4Bw>
 <xmx:42ZKZuUSQ7mxLg7pOPogf1SRA4yc1TAcE2hsvPmDfI3T_YsB6D_yTw>
 <xmx:42ZKZgdbQphi3YYAxz1c80SWg9Fn24cDyUqqUIijem8_FTGHmWahcw>
 <xmx:42ZKZvz8JPyT2MXC7MB4ebi4OB8q4x3fRJTkXeAnZb0TSM4gnSMekRpX>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 May 2024 16:53:54 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Sun, 19 May 2024 21:53:51 +0100
Subject: [PATCH 04/10] xtensa: Define PLATFORM_ELFFLAGS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240519-qemu-xtensa-v1-4-8fff0cb11c19@flygoat.com>
References: <20240519-qemu-xtensa-v1-0-8fff0cb11c19@flygoat.com>
In-Reply-To: <20240519-qemu-xtensa-v1-0-8fff0cb11c19@flygoat.com>
To: u-boot@lists.denx.de, Sean Anderson <sean.anderson@seco.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=563;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=rwWOyoCrytE0GM6aaqNh8lvMI1u0TbaivPUiRWgPlkQ=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjSvtHtpbVM+3f7zjm1xmeumDrvdJZ/POrrEfjOb+O2r3
 ImnJj5cHaUsDGJcDLJiiiwhAkp9GxovLrj+IOsPzBxWJpAhDFycAjAR5W6Gf2ZvbU28fiWYhqhs
 m7W2apd99oknLzax/vsSYV3DzND+7QAjw9wZ3dteJshOjdXXrrv3eP2To2s6D+5rlvxzUWuJFlt
 kDwcA
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

u-boot.elf target requiures it to work.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/xtensa/config.mk | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/xtensa/config.mk b/arch/xtensa/config.mk
index b0809999e403..3ec936272f25 100644
--- a/arch/xtensa/config.mk
+++ b/arch/xtensa/config.mk
@@ -7,3 +7,6 @@ PLATFORM_CPPFLAGS += -D__XTENSA__ -mlongcalls -mforce-no-pic \
 		     -ffunction-sections -fdata-sections
 
 LDFLAGS_FINAL += --gc-sections
+
+PLATFORM_ELFFLAGS += -B xtensa -O elf32-xtensa-le
+

-- 
2.43.0

