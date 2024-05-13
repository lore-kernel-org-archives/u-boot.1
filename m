Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB9EC25B10
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 18:18:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A54E88321;
	Mon, 13 May 2024 20:17:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="Qvhy07eL";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="HBUJORC5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C9AC87D08; Mon, 13 May 2024 20:13:26 +0200 (CEST)
Received: from fhigh2-smtp.messagingengine.com
 (fhigh2-smtp.messagingengine.com [103.168.172.153])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3156687F39
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 20:13:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 40E5011400B1;
 Mon, 13 May 2024 14:13:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Mon, 13 May 2024 14:13:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715624002;
 x=1715710402; bh=5A+v9T11c3aMCM/NaHaSpLaavHbROY5/ueiLvLXNEMg=; b=
 Qvhy07eLsJ4WNTRq2dPNkCg9odyfYlBv5ZMJ4pWcggUtYHNUl/kexB7THdhaLKdx
 zKL7buzKcZ6gGCiygu3pStfmOWkiu7St827dYfFFNrqmZu76jJdSH349Tlvj1cXE
 LdV7mD7nd0zFEOhaUlJFp5KBObPxZDdMJDIZQY2Ly7/IcI4ZrMTKky382MxNu2VR
 bukXZU5hp63JdP3NZS6I/GKTbqUBmezgKQmh0mCtK1kduGEIfEPkqthyAKRLDPMG
 bua2b+4eZ7gs+2vraXBIzoT2EWIFP8R1zGQMMDL+1JJwyfeR3sjTWgNaZuSfM7tq
 jo9/1iHEHS0fFJAlNksXiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715624002; x=
 1715710402; bh=5A+v9T11c3aMCM/NaHaSpLaavHbROY5/ueiLvLXNEMg=; b=H
 BUJORC5V0jPOeoVlfHL1nmyp61yRNg3EW3OISAHJhehklgBpb+JTyH6iWpE2IgPe
 ccuczxm1MKJEf/fjTRRJGVjTq3UuzrR3j8y9FULjnXCaNvj8fwORCN37aJ3OX9AV
 E/36nl8NggSIKHkttSbS6yMeNGfWKwTh9hSSKz+7xo++5CliSnNZHmiIsQ2isL6d
 ebA4b/aGxp4PZV1ytGrs+xidwnYF5JZRJUEoef2RSjRv4diKbrZJGhV9NJc9w0lx
 2j2BZL56HBHFcmdoMTyKZ0a++81JKc2/Pm/kd2nkSORsmrjkl0KWk8ZfNY/p1EWJ
 CIAt8qJ+qd0jpyhFoBYvQ==
X-ME-Sender: <xms:QlhCZh3iLdFZ_krHD5L69UMv8-Z_23VUIIdac8vcKqIKB9MxLgiwxQ>
 <xme:QlhCZoFwYSosDh8CA8X-CyKGH56TPCnb0njNcUaMx1peqliMRn5lJwXEs9knLs_2R
 H2u7pTnp9EUYlYLCXw>
X-ME-Received: <xmr:QlhCZh4l3SLFdG4h852-0QNC8qMsJbLq5zRt7lD1m8offx7tv28Zn7U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedguddvudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
 rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
 enucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefh
 ueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:QlhCZu0tDQj7K2hcL48WyeTbbrNyTudA9EVdNo1OJkBhyQhPLQjouw>
 <xmx:QlhCZkFAn13MNNwCtb8zveboUTE7xgIFJh7tpAkFJT-iiGOKCwrKSQ>
 <xmx:QlhCZv9dWwsDZkwz3X8bzkXtTztjqquyGrceZjRNLl2DoEGtdoy_kQ>
 <xmx:QlhCZhmxCyi4lMRGb5PQtG1VB2N_YrtpNddeGreDAUcsZg28-gYp6A>
 <xmx:QlhCZs9kyhEm-YiW_ntxK-EaLzOwlY4NECxws4wVa5XTZfyT4kCvf57n>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 14:13:20 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Mon, 13 May 2024 19:13:05 +0100
Subject: [PATCH 08/13] MIPS: boston: Provide default env vars
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240513-boston-v1-8-fac96938417e@flygoat.com>
References: <20240513-boston-v1-0-fac96938417e@flygoat.com>
In-Reply-To: <20240513-boston-v1-0-fac96938417e@flygoat.com>
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
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjSnCOMJmZ3iLS0txjovN12arVvq7Z9+iWOvx/cMsQP3V
 0d94nbuKGVhEONgkBVTZAkRUOrb0HhxwfUHWX9g5rAygQxh4OIUgIlkTmRkaDnR5t3+TP5wy8HF
 7/723plaX/gyZn5irNr+rAQOffW7Lgz/vXvPTAvi+dG5YWqXzr8rSWrPXn2e9JZbMzroNPepbTw
 d7AA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
X-Mailman-Approved-At: Mon, 13 May 2024 20:17:26 +0200
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

