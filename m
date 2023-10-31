Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94FB9C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 05:18:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02C29874A8;
	Tue, 31 Oct 2023 06:18:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sholland.org header.i=@sholland.org header.b="tWq/6+Cj";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="lLE8qNzJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B897E86FFE; Tue, 31 Oct 2023 06:18:11 +0100 (CET)
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com
 [64.147.123.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A91F0874A8
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 06:18:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=samuel@sholland.org
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.west.internal (Postfix) with ESMTP id 09F7A3200A59;
 Tue, 31 Oct 2023 01:18:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Tue, 31 Oct 2023 01:18:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:sender:subject
 :subject:to:to; s=fm1; t=1698729486; x=1698815886; bh=qXKbRg8egv
 rsFItzba36s5MhA3i4VVIlVHuRplD9q78=; b=tWq/6+Cj1G5rh7vkXiH+9avzMw
 DpuAFdnoP8SJ/Ob0ofy6KZ8xQ0cYOCMq6in23Y5xi/mSMKxw60nYeKwz6J+DEUh8
 VzprLo7nFOx0HlF5FX+SYQKL+uHPFNOWFZ1G606mUHP/rRe9Irs5CivfM/J3vn4c
 a+834GS/OBTsEVu7A/tDTmQ47wLBQhLZWQI/oX3GIla01JuNDKMASbCplb+tm58X
 hmpxWJqAS1RCVg2s6H5bi/zNMwdrR38cmWoDBzuXLOXQkOSkzd2t3nNWv83kVFz4
 sGl1AFjlANmkpUEzVfEqCMTpvn47gkUrlcATgNdAKE8lG3PK81dcZdoaL1Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1698729486; x=1698815886; bh=qXKbRg8egvrsF
 Itzba36s5MhA3i4VVIlVHuRplD9q78=; b=lLE8qNzJYKvi+Pbxcj6NHYBnxtHrQ
 CeIQpwzHM6+uxzjo/GK+GJwtenJBYulMxVozdssBe647Eyo43QvpTlBDc/2gSWQV
 gRK7IVaDtgpvw3UFrO8h0mfOcS8lXmV3CE88Or8IMD4oygjIHtQ/FkRYqIhABrif
 P/m5Wz8XSmhZwaPNJzLk4pnFviMdg8ilh4zEzpbkeLXMHFCd+g7UlYIJsJw309d3
 DvuM7LjyDB3hW7f1kvdl577GsMGdPgmeEdHnLffR4odx7Pj7+g4C3KWQzamXNZ13
 z2rOA6oGkProuBjmlq4a+1bpeOXr5qScztA/IM7JOGBZt9ROfeKi0twug==
X-ME-Sender: <xms:Do5AZebNwDUJoxF6DUG1XMOJFFrm2JI_7uf9YeRGYLscbYEf4M-npA>
 <xme:Do5AZRZrEqjDWkh8CW8HxBfkJp7OaQkYBzw5nD1-EyGOsxZXyPv7Wn-QnZWCo2axp
 encRkdf1Ixdjzb0-w>
X-ME-Received: <xmr:Do5AZY-0td9OF1lvSIYFYrto1qwmpP9-lDRVDmO0uEOQbIZRy1G1Vz_EHVbohfd_I_LfwIoyjJCWAPcS9sXpO2nazDdezajnsyf-Qj85imPh6M0TPcGiQTfDenqsqDHgFtr4Bw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddgjeelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
 ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
 grthhtvghrnhepkeevlefhjeeuleeltedvjedvfeefteegleehueejffehgffffeekhefh
 hfekkeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:Do5AZQrHTTvSAJgdNHapUWVZrdnk1rSKBSzxTcJ4sCnyCB38xd3rFg>
 <xmx:Do5AZZp_bIZ-jLBL2DyqlynoA9Qgzw_Yu2UeLr_kqZ7GqJao3yDS8A>
 <xmx:Do5AZeRMtWWtcxsPH51fiu0S_WAvwZnDGcXRaLbL0TdYCQ0vQ6m8_Q>
 <xmx:Do5AZakuxhNPNCeikIg3uTLLgazhSTGcxBKAyD4f2JkY8yIiGRfBFA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 01:18:05 -0400 (EDT)
From: Samuel Holland <samuel@sholland.org>
To: Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Icenowy Zheng <icenowy@aosc.io>,
 Jesse Taube <Mr.Bossman075@gmail.com>, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 0/4] sunxi: SPL FIT support for 32-bit sunxi SoCs
Date: Tue, 31 Oct 2023 00:17:37 -0500
Message-ID: <20231031051805.62430-1-samuel@sholland.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This series makes the necessary changes so 32-bit sunxi SoCs can load
additional device trees or firmware from SPL along with U-Boot proper.
Crust (SCP firmware) has support for A33 and H3, and H3 also needs to
load an eGon blob to support CPU 0 hotplug (a silicon bug workaround).

FIT unlocks more features (signatures, multiple DTBs, etc.), so enable
it by default. A10 (sun4i) only has 24 KiB of SRAM A1, so it needs
SPL_FIT_IMAGE_TINY. For consistency, enable that option everywhere.

After this series is applied, we can increase SPL_MAX_SIZE for H6 and
newer SoCs, both 32-bit (e.g. A50, T113) and 64-bit. I did not do that
yet because there is some discussion to be had about the correct value:
it must be adjusted to guarantee return-to-FEL functionality, and the
exact adjustment depends on the sunxi-fel tool implementation.

Changes in v3:
 - Rebased and collected tags

Changes in v2:
 - Disable padding from SPL_PAD_TO
 - Rely on binman min-size instead of using explicit offsets
 - Use Kconfig for firmware addresses instead of an #ifdef staircase

Samuel Holland (4):
  sunxi: spl: Disable padding from SPL_PAD_TO
  sunxi: binman: Move BL31 and SCP firmware addresses to Kconfig
  sunxi: binman: Support FIT generation for 32-bit SoCs
  sunxi: Enable SPL FIT loading for 32-bit SoCs

 arch/arm/Kconfig               |  1 +
 arch/arm/dts/sunxi-u-boot.dtsi | 39 ++++++++++++++++++----------------
 arch/arm/mach-sunxi/Kconfig    | 17 +++++++++++++++
 common/spl/Kconfig             |  6 ++----
 4 files changed, 41 insertions(+), 22 deletions(-)

-- 
2.41.0

