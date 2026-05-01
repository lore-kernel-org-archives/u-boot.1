Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 177F1CD13DE
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 01:36:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 309D9845D8;
	Fri,  1 May 2026 03:36:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=traverse.com.au
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=traverse.com.au header.i=@traverse.com.au header.b="JV6GTgCr";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="uGyWFVO4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA8FF845D8; Fri,  1 May 2026 03:36:26 +0200 (CEST)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CE22844CF
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 03:36:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=traverse.com.au
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=matt@traverse.com.au
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 4BC401400156;
 Thu, 30 Apr 2026 21:36:24 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Thu, 30 Apr 2026 21:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=traverse.com.au;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1777599384; x=1777685784; bh=SViB1eZIGKLgpS9IEh0AqDC4rCI+dMJ2
 vUyjPXVQ9K0=; b=JV6GTgCrkttrvhAX8PRSWH/0bWyQmCKHMWQ4Z2DtwOlubGOi
 HzD+OKJE7xbKlUgNozi3n3x7t7CPffk1RZFHjKcnws5GDqd0iQbmwqi7VA+uXfK0
 vbJ755Ufj8KJTTppXlLkxP7kaCjKonkWlv/5D2HEPiPjsTiTShf+qaMGtoy3Csdy
 f8YMM7kBtlVp2ThZD32C5ZdDQPQEI03MjZkeG3yJEQw98WhHTbNFoJQK7jo5ueig
 WGc8zRNcjWXOiUPCZN1TLDufcUWlX3QU+46a6Bm5/FcQHw6EJSUmjJPZ1qm0z/c5
 7LnomDRjTe0eSY3tovhSDNED5RcCA3eOY6OAhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777599384; x=
 1777685784; bh=SViB1eZIGKLgpS9IEh0AqDC4rCI+dMJ2vUyjPXVQ9K0=; b=u
 GyWFVO4kXlCipqh33vLMjpdMepNn5N6XrPHUAETrVhd20ALTWTPw+9lxUT/jTRb4
 k7YpjxsOopqDtCle40cw+uCmvNpg3WNnCmNBEBbfrzb2dSWCN3I4RsQbFe+nPamU
 VDNzgHuHXHnj38GzCrPDIigtGmb6cYeWFUYVGtbB4ZEzN/bkcdOAyqfk/4jGvu4o
 EX2tKfdfBJeDE+phfT70rW4gYO2h0WFOcirtokOnEITdQ5beRR8e4rUWDlxqMaFn
 aUkVEEprq3Cu5EUJLqLO+a82tfBxp6RtwpsB9DUgop0Lk4/wNTRIHNH5QXVX4OB7
 hFhnjM/QBhh7H+TgtuC1Q==
X-ME-Sender: <xms:mAP0adl4F1ub8GJBHtlOPz_ONc23Aprmu22cRrxq4fOPD0g_2ldkcg>
 <xme:mAP0ab5rEqZtMdHiXinbPjcwaLJS1EKHt0bUV3hb0y8_Hvc1XTjUM8H-O0JqHMm9v
 dcF9Lea0dAUzty7-8l_AQatu4T_7OzqAo1ldWm3XR1P8TSC3oQGAe0>
X-ME-Received: <xmr:mAP0aeRr6rWgeMVVvsNi3h9ltzJ-Rz8CasnZSmkN2xIouD3L1R-nhVv3yTB2mWlsqB8bTOXJnzQnKlE6zjpkJdL4H3NvEpbxtzt0PmTapkiT758Y-jabVORf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekkeeltdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofgrthhhvgif
 ucfotgeurhhiuggvuceomhgrthhtsehtrhgrvhgvrhhsvgdrtghomhdrrghuqeenucggtf
 frrghtthgvrhhnpeffvddthfeklefffffgjeekfeetueehhfeigfffgfekudeujeehffet
 ffeltefgheenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehmrghtthesthhrrghvvghrshgvrdgtohhmrdgruhdpnhgspghrtghpthhtohepuddt
 pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghtthesthhrrghvvghrshgvrd
 gtohhmrdgruhdprhgtphhtthhopehluhhkrghsiidrtgiivggthhhofihskhhisehthhgr
 uhhmrghtvggtrdgtohhmpdhrtghpthhtohepshhjghestghhrhhomhhiuhhmrdhorhhgpd
 hrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdhrtghpthhtohep
 mhhitghhrghlrdhsihhmvghksegrmhgurdgtohhmpdhrtghpthhtohepmhgrrhgvkhdrvh
 grshhuthesmhgrihhlsghogidrohhrghdprhgtphhtthhopehprggumhgrrhgrohdrsggv
 ghgrrhhisegrmhgurdgtohhmpdhrtghpthhtohepphgvnhhgrdhfrghnsehngihprdgtoh
 hmpdhrtghpthhtohepqhhuvghnthhinhdrshgthhhulhiisegthhgvrhhrhidruggv
X-ME-Proxy: <xmx:mAP0aZw_8RjHpOVZb8K1IKXiN9vX2ct84mqjSHw_zEmMdC6RswqtPA>
 <xmx:mAP0aWqmbt27othbwLs7gvY7Bjb6Nbw1ZzE3zczUf2gtCMcHmnQThQ>
 <xmx:mAP0ac0nysnqDY5WfCwYJUQRAs_3OfmqG1M_NWekvQGQPpOKPeFyBg>
 <xmx:mAP0aWziS4txH6qBT5tKIisX5VpUYNWlyqh5nLbUDd32Rq1fw0qsGA>
 <xmx:mAP0aRjFCVN7lLsUrxh2LmUeMONbOy0-6E0NQx5xsgQa5bOG9jaaygiL>
Feedback-ID: i426947f3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Apr 2026 21:36:21 -0400 (EDT)
From: Mathew McBride <matt@traverse.com.au>
Date: Fri, 01 May 2026 11:36:05 +1000
Subject: [PATCH v3 4/8] configs: ten64: enable OF_BOARD_FIXUP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-ten64-add-usb5744-v3-4-234c5b2f8c6f@traverse.com.au>
References: <20260501-ten64-add-usb5744-v3-0-234c5b2f8c6f@traverse.com.au>
In-Reply-To: <20260501-ten64-add-usb5744-v3-0-234c5b2f8c6f@traverse.com.au>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Michal Simek <michal.simek@amd.com>, Marek Vasut <marek.vasut@mailbox.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Mathew McBride <matt@traverse.com.au>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777599366; l=718;
 i=matt@traverse.com.au; s=20260115; h=from:subject:message-id;
 bh=3gGFhLKFpsbs/a5oqkhf7a0iUXN73IsYG7sdk/vbIdI=;
 b=FW5vJtS5ECONvalc66dWR/LkVnLe3u3QCaLp6ZdI2CWGhMfXOpUZzu2NW2rKTlrU52aFF6xBi
 +Jv0r5CQTjQDOP16zHCVmbpHQyB/NTI3rNmDHhwL/Lj3GuXlt1xtqhn
X-Developer-Key: i=matt@traverse.com.au; a=ed25519;
 pk=SM+aGm9Y2fPJ2prfH/b5lab73fTBrKL5UsJwdzv7Pbg=
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

We have added board_fix_fdt to remove elements from U-Boot's
internal FDT related to the USB hub, so CONFIG_OF_BOARD_FIXUP
needs to be enabled to utilize it.

Signed-off-by: Mathew McBride <matt@traverse.com.au>
---
 configs/ten64_tfa_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/ten64_tfa_defconfig b/configs/ten64_tfa_defconfig
index a65209e8335..0254aa6b4a5 100644
--- a/configs/ten64_tfa_defconfig
+++ b/configs/ten64_tfa_defconfig
@@ -21,6 +21,7 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_BOOTSTD_FULL=y
 CONFIG_BOOTSTD_BOOTCOMMAND=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_BOARD_FIXUP=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y

-- 
2.52.0

