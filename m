Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46DF0C04FFE
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 18:16:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DABB388570;
	Fri, 17 May 2024 20:15:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="eAWFCl42";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fm6AeDBK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C5858856F; Fri, 17 May 2024 20:15:10 +0200 (CEST)
Received: from fhigh7-smtp.messagingengine.com
 (fhigh7-smtp.messagingengine.com [103.168.172.158])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E40688540
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 20:15:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 8568D11400BD;
 Fri, 17 May 2024 14:15:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Fri, 17 May 2024 14:15:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715969707;
 x=1716056107; bh=5A+v9T11c3aMCM/NaHaSpLaavHbROY5/ueiLvLXNEMg=; b=
 eAWFCl42Wj+KEeA5gFpZ8wmzER9Z1hqLm+rVf10Im2IDk0cggBMPYfcWg+F1sPdt
 UZNW2zN6eRgASgNJLQq8IGWTA/CBIpSMO2yjnQPHgGGlE7uvWGmta32MEfcKVoc+
 huFhldqAnDBJNPEDPIEWnZEwP4ep8hx3zpYzIxv1ATpmWqkK6w+ZIKpKfMnXFHgm
 348HXEtk0zTQdJ1AquGoU4+OpF3F5Ek2C81HQgy5IKE5sbTaxYYenb+AUV52IXec
 ODxKSparDv+5Xe0UgP4+6RKybgcgYnmEyJci1ayyC19itAFquaCSKIzXl7JGNq3N
 cZZWJ3h06lpzuLFmoOJN1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715969707; x=
 1716056107; bh=5A+v9T11c3aMCM/NaHaSpLaavHbROY5/ueiLvLXNEMg=; b=F
 m6AeDBKzVurm+KQZNJmDA6pyC4R3nDk2yaKARqn/ueG7h42wisAy5ewgWtJtTKQK
 ANAWvJOxeeTRAT5vjZEyiZXsqrjz+zMdZC/PMEZW/KPxbcTLj5xIxttrUKQyN8rQ
 xRtmMH9jCUaEjIFwyjF9yTBOSqHeNw4TlreciObk02tCNXdMIFZMRUumNdEHBTDp
 amkdr9VKQUQyoTj1sdJrVP5k2B3ZdLxf/WnDLgVly2bNXOie014WWebMLxd+3soH
 LdsZuFJPnCGID/JorRG9Qb/HN88DfGjPm0sSa8D184+UK9ohNMpyidShZY+iwi6B
 91fK017u6v9ro08HDyRHg==
X-ME-Sender: <xms:q55HZiW2E8adgbm31oZlLlteiexjzEOrBQNoZSI2SPWV35SNSunnqA>
 <xme:q55HZunnG1TJj4Sic7GXuuub4USuXmob8ZCawaKL8UPLHXXBRly0g1v5L0aPfyJfi
 uzo_Yv4cFeET4ILkKg>
X-ME-Received: <xmr:q55HZmZsabIpeOJyHSemTuX7OYHZkkEZE3n21lMWhmgucIFawRFPWyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehgedgvdelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:q55HZpU3MlXgaAbPxZUgZvWy4mnOb503S5vs34fUY2NhwHEXCQQOtw>
 <xmx:q55HZslM8RNGeOjAMRHfqx_gbppIcXa1U40FU6qWhJnZgClcTORg8g>
 <xmx:q55HZufj7OCAexyssBZry811EeZuYthupyYJMm-zCcygRRQAVloFPg>
 <xmx:q55HZuEkMHfprSgl064gFotaqHxIDusKh2YB99d31WLQBrUuGkPX0g>
 <xmx:q55HZme-Lxl0yODS9uEcBen3obDom1uEFNvW66wVlFIp-yGJgR9ncyef>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 14:15:05 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 17 May 2024 19:14:56 +0100
Subject: [PATCH v3 08/12] MIPS: boston: Provide default env vars
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240517-boston-v3-8-1ea7d23f4a1d@flygoat.com>
References: <20240517-boston-v3-0-1ea7d23f4a1d@flygoat.com>
In-Reply-To: <20240517-boston-v3-0-1ea7d23f4a1d@flygoat.com>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Paul Burton <paulburton@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1132;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=X/exFweBaw4YaWQqHejIcCkvdfFZ8YxGkPm7qJQlKPA=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjT3ebPDPe5c2im47WVP5tzP3C38/eY1T4q030y+cDfJy
 CCvzkW+o5SFQYyDQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDKEgYtTACZy0ZeRYWvs61hxNZXaXz7b
 BDyLwxn22s8xWsekrSnobXR/t53mfYb/Tgv/hn57vnHVrGfz9hSclXp9IuzGdiXDVimvV7wy686
 xsgIA
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

