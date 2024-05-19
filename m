Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5EBAC25B77
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 12:58:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F390E88692;
	Sun, 19 May 2024 14:57:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="BUSEbsB+";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZQ5x4b7G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9265588291; Sun, 19 May 2024 14:57:23 +0200 (CEST)
Received: from wfhigh1-smtp.messagingengine.com
 (wfhigh1-smtp.messagingengine.com [64.147.123.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CCD088692
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 14:57:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfhigh.west.internal (Postfix) with ESMTP id AF42318000BE;
 Sun, 19 May 2024 08:57:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Sun, 19 May 2024 08:57:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716123438;
 x=1716209838; bh=SY+OQdlrKvcnW4tIXIyuASiqsBmpIlcKdXOj8aKeeB8=; b=
 BUSEbsB+lRMSrpij8RaUU0CJdWn+4u4gG/RHlqtRoyR6Q4Vm98Nv5rs+Upal3I9X
 4ymfcmMMqjROM/5L9nPAdQRUt1WJb3xZWxp1YJMkmP6KHf4oJ/LoaywVr/RMnC31
 UpuPSRJcOpse9eMfj7cOVgjShZq4jzUJgwITzR5tHx++SxnafmvrDfOPDKXkS/ko
 C0UpSdHkP5W0cdJD8xUenLPGnmKNjEOSW7F77BqEcWnoFQgi4EaiWLeia5z1peud
 wmSg5E4erlJf6hwgtEH4nx2ioE+ZNF0sKCPsH33/pslbt4RzBoLRoz0hcJVc47Xi
 u4Vve8bZxYdbxof+4k4NRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716123438; x=
 1716209838; bh=SY+OQdlrKvcnW4tIXIyuASiqsBmpIlcKdXOj8aKeeB8=; b=Z
 Q5x4b7GqdOQOlGzREr6IlPRB6kJ9iobgg7JlkBNDiq8JAwKsXImWz0saAACGhQx4
 GFIbO/xtb5JZizeOUr1PpK+hV+khB0wTTNZSHHSsmqAdSUNjHiuyr3nBbwlSaXMh
 mayETD/WglHWx75ke9glfRqy6pcJtax2ZBMeSFa8Gii/A3pApOxFpLl4ewD8GQa5
 cWWQdVDnk/1Pj+SYIV49CYDTNo49MCC/920XsiTa7/nc5aqh5BgqlfDp+dNImz0j
 tjAo9hFHEe18lB5vR1wbMLRs6llOLLqjVr2imvwdqGfWm2xW47QOozmPnwy+R2ZS
 9AYVKSnmtmLG05qVsJnHw==
X-ME-Sender: <xms:LvdJZnodjB4ewAAGhVuMo_ZjclcR9qo3XgMuDLkUxfYcGKl-q13f0A>
 <xme:LvdJZhpFkiRn5uXQbh9-ovN_1UbK2EQfXvT3NTpvx4Vj16-OhjrhpKJSefXk7ebZN
 uEI5EdvviCDpw8l9ME>
X-ME-Received: <xmr:LvdJZkMgtTMVbT8CBXnPqbuO-l6v5jcf_HjlMuJOSlU5HVZ0esVfueg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehkedgheejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:LvdJZq5awtur83aiGp6nJiPGOtDkPxChBb8kV7w3Ea_xF031Ibku7g>
 <xmx:LvdJZm605OdTzNeMfxx3ST00xo_vhjxMJNuBbwREy7M02OXTE-NJzA>
 <xmx:LvdJZihDynCIziVnoDbG7w45RcETDdnLC82rfZh39RwW8IB7Wr5Yow>
 <xmx:LvdJZo4Z8smKUnvddhUSzys9ccP8id2WOWI2Wp4KThKv-RuTWiUw3w>
 <xmx:LvdJZrPrplLvp3tQ-UATdKlLzoj0UtxwRrZ39FtGQ7Ooq4_lUh4NmanM>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 May 2024 08:57:16 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Sun, 19 May 2024 13:56:52 +0100
Subject: [PATCH 07/13] arm: Perform byte swap for read and write in io.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240519-aarch64-be-v1-7-75cc328eddfa@flygoat.com>
References: <20240519-aarch64-be-v1-0-75cc328eddfa@flygoat.com>
In-Reply-To: <20240519-aarch64-be-v1-0-75cc328eddfa@flygoat.com>
To: u-boot@lists.denx.de, uboot-snps-arc@synopsys.com
Cc: Tom Rini <trini@konsulko.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Ezequiel Garcia <ezequiel@collabora.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Lars Povlsen <lars.povlsen@microchip.com>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, 
 Alexey Brodkin <alexey.brodkin@synopsys.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1835;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=8W/w0gcrwAIQJVueupqZ1Qc5FAxJxDhYN8e1hIoJjzM=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjTP7/yHTW9cjLoW9l71OW/O5QmsLu9Ep13W23SpaKV/v
 eObrplZHaUsDGJcDLJiiiwhAkp9GxovLrj+IOsPzBxWJpAhDFycAjCRiMUM/xO05xaf6fF03hxR
 kf3j4JWuo33O91VTtrsnK/iHT02XXcPIsFWnsa5ay3JdUv4+8SmeTVVNGRfinbcy+iWmBeV5iiz
 lBwA=
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

I/O is always assumed little endian, so perform byte swap
if necessary, as what Linux did.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/arm/include/asm/io.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 89b1015bc4d3..864ad5ae5c61 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -99,14 +99,14 @@ static inline void __raw_readsl(unsigned long addr, void *data, int longlen)
 #define smp_processor_id()	0
 
 #define writeb(v,c)	({ u8  __v = v; __iowmb(); __arch_putb(__v,c); __v; })
-#define writew(v,c)	({ u16 __v = v; __iowmb(); __arch_putw(__v,c); __v; })
-#define writel(v,c)	({ u32 __v = v; __iowmb(); __arch_putl(__v,c); __v; })
-#define writeq(v,c)	({ u64 __v = v; __iowmb(); __arch_putq(__v,c); __v; })
+#define writew(v,c)	({ u16 __v = v; __iowmb(); __arch_putw((__force u16)cpu_to_le16(__v), c); __v; })
+#define writel(v,c)	({ u32 __v = v; __iowmb(); __arch_putl((__force u32)cpu_to_le32(__v), c); __v; })
+#define writeq(v,c)	({ u64 __v = v; __iowmb(); __arch_putq((__force u64)cpu_to_le64(__v), c); __v; })
 
 #define readb(c)	({ u8  __v = __arch_getb(c); __iormb(); __v; })
-#define readw(c)	({ u16 __v = __arch_getw(c); __iormb(); __v; })
-#define readl(c)	({ u32 __v = __arch_getl(c); __iormb(); __v; })
-#define readq(c)	({ u64 __v = __arch_getq(c); __iormb(); __v; })
+#define readw(c)	({ u16 __v = le16_to_cpu((__force __le16)__arch_getw(c)); __iormb(); __v; })
+#define readl(c)	({ u32 __v = le32_to_cpu((__force __le32)__arch_getl(c)); __iormb(); __v; })
+#define readq(c)	({ u64 __v = le64_to_cpu((__force __le64)__arch_getq(c)); __iormb(); __v; })
 
 /*
  * Relaxed I/O memory access primitives. These follow the Device memory

-- 
2.43.0

