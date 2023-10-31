Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF6FC4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 05:18:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9312F87ACE;
	Tue, 31 Oct 2023 06:18:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sholland.org header.i=@sholland.org header.b="V5meX+iv";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="SE4QNbEa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DD2C87AC2; Tue, 31 Oct 2023 06:18:13 +0100 (CET)
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com
 [64.147.123.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12F6D87AC2
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 06:18:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=samuel@sholland.org
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.west.internal (Postfix) with ESMTP id 3090C3200A5B;
 Tue, 31 Oct 2023 01:18:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Tue, 31 Oct 2023 01:18:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm1; t=1698729488; x=
 1698815888; bh=iKlnWlTIsYjiMFWF56hKrnd8NjC1BUNj2DC/sE2sYC0=; b=V
 5meX+ivMrhVPh4TRf4H+zuU2dPh/iXTya6sTVWQskC2ezF65LGDrhk57waPlD5Gs
 eAUHEXYOuoF2ypSzT88e5unFUXplvWRDcdavbhqZ5pW/voRXYC1vk/my0kJvA+DL
 a/z0DWCfEzOalUsn/FzyouvgyK481y2fN9tDfnA6l6rEj2GNJ3TR85uJrliDHRfo
 IsLQMcaAq/DmAE2pAK6RCe84Qfx4n8gAR0m1oWUAEoF1pzl4vMSFz+Znn6427ed1
 KNulZJgzjmN9SSxD9Z4A+WaTb46eaxjP+6m8PRdYdM9lcmzKXd+PYSluXTb0DKHF
 lolVUW9pukdxrzycqVkUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1698729488; x=
 1698815888; bh=iKlnWlTIsYjiMFWF56hKrnd8NjC1BUNj2DC/sE2sYC0=; b=S
 E4QNbEa6GOoI5kxK8MzaNqDJ66DpG91iKEbbGoPfxiVYr9qS+LHQzZ71rq7Ym+97
 yqGXClBGfDh6UJ6Rhq5bu5PknNraEUXva+ngLsAdjm0teq7Z1s81mFA2Yuw2iDt/
 n93F1gqDp5+1MhaXNtKUijwhmwqY2Dd7wvrGW8DT6Jbe/QB8moHBEcI2eedoq6e9
 qYj4HSkZLmURo6FO24tvFz/6JET/0LqCrBuIwXAOZao402HNQo3hP9+sV3NCAt+I
 2+9W+NGytK22Mej6wOMyTNTmcUQBtrH9IUB7nWLiKXDk6EI9kfAtI3/voITEBYo+
 DmlsyFhsfld4V+5RDs0Dg==
X-ME-Sender: <xms:EI5AZRWynYga-EpsyTQqSy7s_6V7y6Vdjd8TSFOHWsWXHXb0mPvfxA>
 <xme:EI5AZRnNdYKRePNrPlNLKEzdNpb_O5TR3YZUeKWX--Zc_74m-Ag_k8Nu8UJbCIz9c
 2PLi6nLrVM_ccAD4g>
X-ME-Received: <xmr:EI5AZdYh2RosXmdXCqPwr4zLyKI4c2_X6hJ6iRr2udaltpQxf-ADQxNTOjHbBrlktvcHfgl374WTCPicv_tZFiiARm2Te9mMNTnvYVw8pOk8eVCo7L13sRZ2isp12CAr3JKj_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddgjeelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
 vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
 ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
 udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:EI5AZUUYBY3KyMza5zk54_8-407iX5_vbHKGHqnYGG84UeF1E2d6zg>
 <xmx:EI5AZbkX2RAXRZS9CoYQFAQy6I4xM9Eaph16h4ASrmgA8iXbErkrjA>
 <xmx:EI5AZRfsMQWXrgN44V6K5_rKB_kaCmp76KQnlJN_g4CepqRPfUdldQ>
 <xmx:EI5AZUDJ350AuHozuW3l-o53D_mBz2YF_Fnlloo_rm06JCYPEqXVbg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 01:18:08 -0400 (EDT)
From: Samuel Holland <samuel@sholland.org>
To: Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Icenowy Zheng <icenowy@aosc.io>,
 Jesse Taube <Mr.Bossman075@gmail.com>, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 1/4] sunxi: spl: Disable padding from SPL_PAD_TO
Date: Tue, 31 Oct 2023 00:17:38 -0500
Message-ID: <20231031051805.62430-2-samuel@sholland.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231031051805.62430-1-samuel@sholland.org>
References: <20231031051805.62430-1-samuel@sholland.org>
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

Starting with H6, Allwinner removed the artificial 32 KiB SPL size limit
from the boot ROM. Now SPL size is only limited by the available SRAM.
This limit ranges from 152 KiB on H6 to a whopping 2052 KiB on R329. To
take advantage of this additional space, we must increase SPL_MAX_SIZE.
Since we do not want to unnecessarily pad SPL out to these giant sizes,
we must set SPL_PAD_TO to zero. This causes no problems because binman
already takes care of appending the SPL payload at the right offset.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v2)

Changes in v2:
 - New patch for v2

 common/spl/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 25cd18afda7..a0968ff1065 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -97,8 +97,7 @@ config SPL_PAD_TO
 	default 0x31000 if ARCH_MX6 && MX6_OCRAM_256KB
 	default 0x11000 if ARCH_MX7 || (ARCH_MX6 && !MX6_OCRAM_256KB)
 	default 0x10000 if ARCH_KEYSTONE
-	default 0x8000 if ARCH_SUNXI && !MACH_SUN50I_H616
-	default 0x0 if ARCH_MTMIPS
+	default 0x0 if ARCH_MTMIPS || ARCH_SUNXI
 	default TPL_MAX_SIZE if TPL_MAX_SIZE > SPL_MAX_SIZE
 	default SPL_MAX_SIZE
 	help
-- 
2.41.0

