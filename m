Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA42C25B78
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 11:42:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BB8688354;
	Thu, 16 May 2024 13:40:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="d8OwmOPy";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="N81cBhKy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04557882CE; Thu, 16 May 2024 13:40:57 +0200 (CEST)
Received: from fhigh4-smtp.messagingengine.com
 (fhigh4-smtp.messagingengine.com [103.168.172.155])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28BC888352
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 13:40:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 59E681140078;
 Thu, 16 May 2024 07:40:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Thu, 16 May 2024 07:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715859653;
 x=1715946053; bh=5A+v9T11c3aMCM/NaHaSpLaavHbROY5/ueiLvLXNEMg=; b=
 d8OwmOPyLfXlEha3Ezc5bko7FMeAOSMYy8enWDMhvWldSiynyVFBF6oEyUb+AUgz
 rgHH2AH2WHKSg2cBvRUop6eMgAO9iA17H6+ORr+dVkz/0m7xl92/Q1a3YcKDSEI7
 ma+meO6Tx1RuvALyQvuSwCg4I3GXQGhqtty6wOUBSl8wwf0sjuHWEGu83frNbyil
 MtJ3iTm2mA+k4XCpWS/b9JLoaDkTOw2d6TNv43Fu94w6cAy5yr5Ts6pQU9mxLEgF
 3h62u4vkg7sbvHCRc+VUtT0cyg40pXuSLDuhGqQL/0O0sjiVA2nSzggkydZO2JN0
 Se9G8lE6/Fwq2R6zl4AypA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715859653; x=
 1715946053; bh=5A+v9T11c3aMCM/NaHaSpLaavHbROY5/ueiLvLXNEMg=; b=N
 81cBhKyhmKDQVzXbKGpoee3Sj2cO3SfX+eTbmdpmZv5K/hBU9lRg3I5dl7Y17x4p
 VrGdUkSyStN1mXtlLszr58gAWg6vuYqpn4xXK+b70W+7Vor699mx2YwTvcbSoWs0
 NRCGeyOvFhND42Gbhb5HAFLJMn52plOlmETanzlSZDn1MeWHyVcJru4pdxKYFk1+
 yZQSVye/9uvHvZO3A2425vfci9Yyfy57E5eMAF/Sex0ECGI7pcmxvtakbBXhA72q
 seoueWMHm2b5YxD52wHHPPmZxNjZLSH/xegqi1D6oRI2ROUQtEJpeOFmOIdVAFvN
 /QD3ZZFxbQo6HyOJnNabw==
X-ME-Sender: <xms:xfBFZmgdhRx3AaH_5MyZj1zW-HowhB2Rfo0rAmG5Q_m1QNhRme1KVw>
 <xme:xfBFZnAR71CpcgxXWcWddQaNjcrmHE1ZVN8Xe9pt_TjVVG3hzVqzuXthVmEJ95Omo
 m270cq34Neue3cf7lA>
X-ME-Received: <xmr:xfBFZuFkFWpESwdOm56gQMOyDZTxE51E_uvWzAnobYYb8t--2_p8YVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehuddggedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:xfBFZvSFDcbbnB6OSbTFSOeC_Mx0L7HafrPRFUzHjcwTiygfRIfUxw>
 <xmx:xfBFZjwFT8uBc7GbDQc1xMeyFvwK8H8SwyQ8HhUx81uJVKtQhb3WYw>
 <xmx:xfBFZt6-j-td7Z2J9zlSMjyv_Fx8SE4tgJclcFX505Hb3igwyeL-Eg>
 <xmx:xfBFZgxK9VzQEyWhEtduHROQr8D065i1EGUpjazcyGJvfvORc6PaQA>
 <xmx:xfBFZopesawCImN87g8ln-Nt5Zo1j5fXXzJKjw3d9hYA0dh3UeteT2o1>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 May 2024 07:40:51 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 16 May 2024 12:40:28 +0100
Subject: [PATCH v2 08/12] MIPS: boston: Provide default env vars
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240516-boston-v2-8-77938800d1dd@flygoat.com>
References: <20240516-boston-v2-0-77938800d1dd@flygoat.com>
In-Reply-To: <20240516-boston-v2-0-77938800d1dd@flygoat.com>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Paul Burton <paulburton@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1132;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=X/exFweBaw4YaWQqHejIcCkvdfFZ8YxGkPm7qJQlKPA=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjTXDzsm36vJNWFXvhOTIHP/b2Dx7do/p1k4C13rr3Y+q
 Fwre2JXRykLgxgHg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAEzk1HmGPxzv2WN6lH7NYUl+
 evCzRPLkS+x8+x75PbZq/XdrUUKMiiYjw9tNWn/Wb+UTkmOrDorKEYtmO7Po8In/wi9eXDM+zne
 ugA0A
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

Provide default environment variables on image loading address
to make the board useful.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 board/imgtec/boston/Kconfig    | 4 ++++
 board/imgtec/boston/boston.env | 9 +++++++++
 2 files changed, 13 insertions(+)

diff --git a/board/imgtec/boston/Kconfig b/board/imgtec/boston/Kconfig
index 5537788001a3..965847d9650d 100644
--- a/board/imgtec/boston/Kconfig
+++ b/board/imgtec/boston/Kconfig
@@ -9,6 +9,10 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "boston"
 
+
+config ENV_SOURCE_FILE
+       default "boston"
+
 config TEXT_BASE
 	default 0x9fc00000 if 32BIT
 	default 0xffffffff9fc00000 if 64BIT
diff --git a/board/imgtec/boston/boston.env b/board/imgtec/boston/boston.env
new file mode 100644
index 000000000000..796e0fd6bf98
--- /dev/null
+++ b/board/imgtec/boston/boston.env
@@ -0,0 +1,9 @@
+#ifdef CONFIG_64BIT
+fdt_addr_r=0xffffffff80001000
+kernel_addr_r=0xffffffff88000000
+ramdisk_addr_r=0xffffffff8b000000
+#else
+fdt_addr_r=0x80001000
+kernel_addr_r=0x88000000
+ramdisk_addr_r=0x8b000000
+#endif

-- 
2.34.1

