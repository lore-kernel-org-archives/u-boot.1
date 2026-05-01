Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2996ECD13DE
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 01:37:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48B5A845C8;
	Fri,  1 May 2026 03:36:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=traverse.com.au
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=traverse.com.au header.i=@traverse.com.au header.b="kOf0yXAW";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="oKHZGTC0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6BC08464E; Fri,  1 May 2026 03:36:33 +0200 (CEST)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDEB5845C8
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 03:36:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=traverse.com.au
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=matt@traverse.com.au
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 3B8621400157;
 Thu, 30 Apr 2026 21:36:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Thu, 30 Apr 2026 21:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=traverse.com.au;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1777599391; x=1777685791; bh=oQbsKuaHnFG/N0e76x3iG2FQ/aWzQd3g
 6zXuZS3HLw8=; b=kOf0yXAWy+/u6irkevPkK/IBxd+nFfVrbmh7LFJTn1n/s4lJ
 LadyVldM/kuiAQtzyC8VQebAUgpfJJMBScjKvvLV6FtMcqxPZqfscAlOGQa5IyG1
 E4aEMPmQ0GZUYjEl+SGL64xUFz9G3Zhv2Rb1m4VGdzPd/he8IM8yCCSu+YRnSekp
 UjNaxRbHyaPuwwaZt7DzTin5a1ltsBEMy9treiBE37qYM54YFlLNhxWVuC3a9+ED
 HMaErlJOJ6cOtd90NJ7olplE83EKuajh7VJINXTXjGqMzEiQ6rwnCzb1sH+7Q79T
 vbPGi9GiZdUkkZJzt/nq/lUVKRks7iXI5LsvcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777599391; x=
 1777685791; bh=oQbsKuaHnFG/N0e76x3iG2FQ/aWzQd3g6zXuZS3HLw8=; b=o
 KHZGTC0/QFnb1ZExeFVo7GXz3VSYMR3HQsx2vpt+MoRLsD3qXh57Id7MwCRptvh6
 zOPGCJBUh+4SvRyCJd0OHoDr9TtInpFJ6EO6ETPuOTbSJ9wn9UbSZknBuKQ3oppz
 9ND7sLBRWHmt5mXJPi+t6qxrfnqahUP9cNBY7BI95S8aj9aFygHb1qE2alF3BaWE
 yORu/y+rgsXy0M71GDrpC1lrrRw0zVOpfjkLvWrqZSrSX5swMi1u3kNKOkKup8Mw
 tDu5DRID9L9c5bNdWET3ZAT3jnP3cKFD2gfMQvHF7YWikjur6LT/TonMRZh/mgn3
 KXYM3xTZgz/dqf3OR8pXA==
X-ME-Sender: <xms:nwP0aYddlRFUTCToQX0kaCadCkEeYVjsty17nJ8sgWLo6aoTncxTFQ>
 <xme:nwP0adQdiSmlw-SlqL3EmHNzJmHKBdJ4i3VSdVnDVuggjRcTdPu89doULN4W1NV9v
 eatp7luH96HLBxuVaqzgokAwuSqss7epg0vNn2b3pVylBnrGwCiyTA>
X-ME-Received: <xmr:nwP0aUIDvJM8iIn22pEDMgdf9knP08wWrW25We3k1VqN3o2PRNJ5RA_KwnW8Kw05-rB9Q-ibjP5uKsbH-ayCR3QouLpfQewxY_VJcgBo-VkXn1bNrNjHm1y7>
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
X-ME-Proxy: <xmx:nwP0aaIm1eeH42pWrGX47DF1YaYIr58PZxlLHSAryrFsU7jodn0I7A>
 <xmx:nwP0afhnj-NlmLq17M20JMkN7GWsMRQPEq62TSykKoBaoVpg_cclbw>
 <xmx:nwP0aUMlimbtvreSbRvUSS2-USWxdkV0ipYV0a6QKoATkwBImbfJAw>
 <xmx:nwP0aarRisPGCcx9QQmj73SRSLc-v8pwfndJSACn7iYcwaLPmxi64A>
 <xmx:nwP0aZa1ScrrTq9uXMOV8AgTnm6KXRvZFprOFCU5u_-iwosNGQGPlkXG>
Feedback-ID: i426947f3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Apr 2026 21:36:28 -0400 (EDT)
From: Mathew McBride <matt@traverse.com.au>
Date: Fri, 01 May 2026 11:36:07 +1000
Subject: [PATCH v3 6/8] configs: ten64: switch to OF_UPSTREAM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-ten64-add-usb5744-v3-6-234c5b2f8c6f@traverse.com.au>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777599366; l=1547;
 i=matt@traverse.com.au; s=20260115; h=from:subject:message-id;
 bh=h42XMh3MBZLrc7DEHeVOvdwlOAhJZ4KJILDDaO+GSuY=;
 b=jBytW9X2bWU81fkb+1aPFjAnWzgKhsjMJs5OSh0hIlGH2dsJHyhY7YiWgms7JHsgUbrMjbu9u
 PdRVZudjg9aC88Pcm81K8MI6IhunuW+5z+hS/b/3gIXgvSxqUghjV5g
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

Two recent additions to the mainline device tree allow us
to switch away from the local U-Boot copy:

* Board/embedded controller (traverse,ten64-controller)
  is now in the mainline device tree.
* USB Hub (USB5744) connections were also added to
  the mainline device tree but not in U-Boot.

The LS1088A and Ten64 device trees in U-Boot were actually
'synced' to mainline some time ago, so the content
(except for the changes mentioned above) is identical.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Mathew McBride <matt@traverse.com.au>
---
 configs/ten64_tfa_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configs/ten64_tfa_defconfig b/configs/ten64_tfa_defconfig
index 65363d013a0..26d41b3f366 100644
--- a/configs/ten64_tfa_defconfig
+++ b/configs/ten64_tfa_defconfig
@@ -7,7 +7,7 @@ CONFIG_ENV_SIZE=0x80000
 CONFIG_ENV_OFFSET=0x500000
 CONFIG_ENV_SECT_SIZE=0x80000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="fsl-ls1088a-ten64"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/fsl-ls1088a-ten64"
 CONFIG_QSPI_AHB_INIT=y
 CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT=y
 CONFIG_SEC_FIRMWARE_ARMV8_PSCI=y
@@ -24,6 +24,7 @@ CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_BOARD_FIXUP=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
+CONFIG_OF_UPSTREAM=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 ramdisk_size=0x3000000 default_hugepagesz=2m hugepagesz=2m hugepages=256"
 CONFIG_SYS_PBSIZE=532

-- 
2.52.0

