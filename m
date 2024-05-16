Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F80C25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 11:41:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA9C788318;
	Thu, 16 May 2024 13:40:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="gzK3xCcm";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="jUU3aSEh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FEEA882A6; Thu, 16 May 2024 13:40:48 +0200 (CEST)
Received: from fhigh4-smtp.messagingengine.com
 (fhigh4-smtp.messagingengine.com [103.168.172.155])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CACF88287
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 13:40:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 57CB81140094;
 Thu, 16 May 2024 07:40:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Thu, 16 May 2024 07:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715859645;
 x=1715946045; bh=x8LDYv2RenMOlJR07nmGqmXKuo8xzS8MSIcW3Gnujww=; b=
 gzK3xCcmX5wZ+hSbwBsWRoCtslZaQpPMIBdyAJMiSrzCVKAnYqn+bKxbMtVGpfJr
 uqVkSrYZNBA8uWPN5WZ61K84UYL7UuuNIPmCvdBbM90p9LY1n/96uK1dhXSCpAMI
 p2mvSU2yZ5vv77V8sNhOM9RQqbHedpR6fSHuyLkg+yI5Y/6SblEobscSbIdkrPtA
 dGOsiuQKitE+bIli9FPTvG8Pj6BWTdzvIx815VBfqGh7GGoB9dQLC5lJBeyw1gcK
 JV+nl8xxLZLzfkBQ4kIv5Ed/oOQ4ovNZdBXXPPyb3v5u85HiZ0pIUiRwIPVm1c/w
 /GEv0bQJuBsnLoNuZwWp7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715859645; x=
 1715946045; bh=x8LDYv2RenMOlJR07nmGqmXKuo8xzS8MSIcW3Gnujww=; b=j
 UU3aSEhAKNYSGBhCRSHBA3pibRW/bjj/DtvY0hACBTTCzzAptaBqIZ9Vv1dyHYUE
 et1SrEWVgedjy50Pn6CSc2enY+CdFJEEATDM2h6w5in2Qlo6udLMbBvkLOwAyMe8
 emwaXk88MssGbU0c73eslsAeCZ6Q2m+4o5Bmdl+JhOe3YcCjmMgSKcr8mMcEgfJ2
 rRwVWcZGOUjEILLNaEwpYPUJoKNv9qm85tzjC98mnMpti5RKLzfCWAChNz3GGu9c
 qjBiWLku0fX4Uz3GQxghlWvfj+xoAnyGQDj3XoRykDC453T8W46eY/o//YTdqjLq
 sJbzNuPEXMmTeF3K8blbQ==
X-ME-Sender: <xms:vfBFZl5mVryAp0XWbHPwzhBhyrVb6LUnVWql-igIrUb7Gsd4NmUzaw>
 <xme:vfBFZi4mYPu957VflFFIAVWzKyMqPo3iptSsTyeqblLyKparGZAXcniGzp1tSmcHm
 KmH_14703t5ZhgbCFE>
X-ME-Received: <xmr:vfBFZsftBXjhFF_rjur6wAmzfVSBew1bGYkYfSAS9_oQa-JBlZzs_Tk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehuddggedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:vfBFZuJzfnjRQr88ISNSKBXUGhA1yzjzkFlsLjRmilJy0m1_b4NA6g>
 <xmx:vfBFZpInkPaJ17luvUh9V5wTtJmCSfIr9FJ1Ra0kx1-BS-HkzLy8tA>
 <xmx:vfBFZnyhbBbmemWlqUs48fGQ-XDPeZ-uJcWY77X08JJUr7_XoiXGAQ>
 <xmx:vfBFZlK7Q_7gR8uyGZXUzpqnvkcW-OnEYslDl2p6Zll1bkmrrfLWZA>
 <xmx:vfBFZmDCd_m7DmE5qwYrYzTk59XVL6HWEzzK1vhkEdzPGRCP8ZPnxYwd>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 May 2024 07:40:43 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 16 May 2024 12:40:23 +0100
Subject: [PATCH v2 03/12] pci: Enable PCI_MAP_SYSTEM_MEMORY when
 ARCH_MAP_SYSMEM is not set
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240516-boston-v2-3-77938800d1dd@flygoat.com>
References: <20240516-boston-v2-0-77938800d1dd@flygoat.com>
In-Reply-To: <20240516-boston-v2-0-77938800d1dd@flygoat.com>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Paul Burton <paulburton@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=845;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=5P0kah0j1rkZJDtXsUvgnBypLjtGpRRBsmtGjzJbCg4=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjTXDzv2paVLecoxPTpcveataUrWziJHkeNpWXU3W3pPc
 bUzxJl2lLIwiHEwyIopsoQIKPVtaLy44PqDrD8wc1iZQIYwcHEKwERWJTEyXM5jnfTuyRLfxy/7
 2bV7nv9KaNn/RVZj/yPGnz/LLzycwszwv2Yeu+ZhtytXM0TuzVD49d+gKPSbxZs7nSqLq3xXSvw
 5xwAA
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

For MIPS we are always looking gd->dram in virtual address so
PCI_MAP_SYSTEM_MEMORY should always be enabled.

If in future we ever want to make it physical we have to set
ARCH_MAP_SYSMEM.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 drivers/pci/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 289d1deb38b6..14f6067fa29b 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -67,6 +67,7 @@ config PCI_CONFIG_HOST_BRIDGE
 config PCI_MAP_SYSTEM_MEMORY
 	bool "Map local system memory from a virtual base address"
 	depends on MIPS
+	default y if !ARCH_MAP_SYSMEM
 	help
 	  Say Y if base address of system memory is being used as a virtual address
 	  instead of a physical address (e.g. on MIPS). The PCI core will then remap

-- 
2.34.1

