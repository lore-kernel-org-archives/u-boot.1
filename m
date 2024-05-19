Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DDE3C25B77
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 20:54:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 264A8882C4;
	Sun, 19 May 2024 22:53:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="5YhcwcMO";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="q2DjbxNq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00A5688193; Sun, 19 May 2024 22:53:58 +0200 (CEST)
Received: from fhigh6-smtp.messagingengine.com
 (fhigh6-smtp.messagingengine.com [103.168.172.157])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 860DA8817B
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 22:53:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 80C74114010A;
 Sun, 19 May 2024 16:53:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Sun, 19 May 2024 16:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716152033;
 x=1716238433; bh=HGGhjdIBzktfsrN6a24IH5ftL75XU3nRJyM+d4Ewis8=; b=
 5YhcwcMOX75gZkR98KULR82RIP1/D4PPo+Ab+/mnRBOPcUSXjyBsxXQmYV1KoyOD
 f4po0r2zw5l+os+JpEAw8tvq0jLDIC04evaBCX4g/PevP9XqKKk6/KTUysnZmnSC
 nikkjF1ph8sHF43ZOq6+fPLFRcriyWTmYb8vny8OxjN4FjaaSS6XaKNKPrcTmXTp
 Il4jolOPLHKjuDLdn8NHl3PL93SwJbRVIAYm/2cmm4j+cCxLH+syaP0QUPed2rDk
 fNNCnc7m0kt4WrwYlOWO5s2EPFSVLegSvHw/2ARBCGGWNHBkRzqv472JL9spKbEI
 rou6w26NO3oO3v8hTn6h4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716152033; x=
 1716238433; bh=HGGhjdIBzktfsrN6a24IH5ftL75XU3nRJyM+d4Ewis8=; b=q
 2DjbxNqLJsFDZE2NkjrrDU1VzRucwJxXPedEhmhTLJgZd1DKKdq+WANTDMP57yq/
 5tziWXwYKG01OYLdaHLAyTpXaaah/mtSqRR8Q0txT/8/5X059ffxjWkx2HE6lKnC
 /nUtB4TnGHsOQeB3nsrV9aPIWYOEVcEggur9U3UBcmQpV7jsJh5MZqXYHLUpCjxD
 5pE9MoP0C+409fe6QIjCXi4Lk9avzFIGf88COzRhnLjBVj/75MhiBnX4FjpfUK8z
 zQDIUWt/KVTRWblcDpA3HqUHP+e1nR3xOhkHKp4PRzB3FZ6TVJe7gvZhZDunbvKs
 0DdCQ2Dgx2kBL18cuOd5w==
X-ME-Sender: <xms:4WZKZgbKzxP-i2aLH-YoHEg58ctLJlcpHMiPGM1R8WNjkZs5kw3OFg>
 <xme:4WZKZraEeNjUpPL19XbBvffH1q664FtuUNlxZkNDAHtmZ4wzkDQnNN9gOXXOhEBLo
 L7W0fEYv2OjZM3-dJU>
X-ME-Received: <xmr:4WZKZq9dtJXdRuFkxm7jCyiMjcdHE3miFvgeX6i0EHJg2i9WTPRFLCs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehkedgudehvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
 rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
 enucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefh
 ueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:4WZKZqqJLi4Kub9BeGIh0u0iELiIWJp9bduG9fez-wAifjvSBM73nQ>
 <xmx:4WZKZrodewr4VTpcq6Wcl5Ha-WHw0Kc8tgGgatg2rV1FsZbRvKewmQ>
 <xmx:4WZKZoRgf0eRD8Pg6RDKUdw6a8sRY3243NY8iIbPCU2TxDxVWbBzOw>
 <xmx:4WZKZrpBQMYy-iLU-E5IqofoPQ6vWGU84rTu3fu4r02lF90emUb7dQ>
 <xmx:4WZKZse8ex0r77-GJVdSRPzsy6Xl67qDmzuNvkfVynOkiMybc4xzZXAb>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 May 2024 16:53:52 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Sun, 19 May 2024 21:53:49 +0100
Subject: [PATCH 02/10] xtensa: Correct define of _end symbol
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240519-qemu-xtensa-v1-2-8fff0cb11c19@flygoat.com>
References: <20240519-qemu-xtensa-v1-0-8fff0cb11c19@flygoat.com>
In-Reply-To: <20240519-qemu-xtensa-v1-0-8fff0cb11c19@flygoat.com>
To: u-boot@lists.denx.de, Sean Anderson <sean.anderson@seco.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1261;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=CMOosrUZ8OvYNRpXGbk3SzLd/lJWJFV/k1N3YY0PTxU=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjSvtHuPHL/vmDj5qtSDtkMOSo8eGNw6v71nVdPaYv2oN
 zFN7aemdpSyMIhxMciKKbKECCj1bWi8uOD6g6w/MHNYmUCGMHBxCsBENC8wMmw/VHs2ulUqXsj1
 aO7c178y13HMyg36cGem87rby5XtJ0oyMux03f7mzRkJQfHtZxkXOLxccPJy8hrF4w4NSr+iV25
 JOMIFAA==
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

So U-Boot is using _end symbol to detect location of devicetree
appended at the end of the ROM.

It needs to be calculated based on end of .data load address,
as in our lds .current address is address in RAM.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/xtensa/cpu/u-boot.lds         | 2 ++
 arch/xtensa/include/asm/ldscript.h | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/xtensa/cpu/u-boot.lds b/arch/xtensa/cpu/u-boot.lds
index 84ba32c04444..72e4b9a706e5 100644
--- a/arch/xtensa/cpu/u-boot.lds
+++ b/arch/xtensa/cpu/u-boot.lds
@@ -82,6 +82,8 @@ SECTIONS
 
   __reloc_end = .;
   __init_end = .;
+  /* Calculation to get end address in ROM */
+  _end = LOADADDR(.data) + (_data_end - _data_start);
 
   SECTION_bss(__init_end (OVERLAY),)
 
diff --git a/arch/xtensa/include/asm/ldscript.h b/arch/xtensa/include/asm/ldscript.h
index 78a0b230bdaa..bcf0fd5a7443 100644
--- a/arch/xtensa/include/asm/ldscript.h
+++ b/arch/xtensa/include/asm/ldscript.h
@@ -165,7 +165,6 @@
 		. = ALIGN(8);						\
 		_bss_end = ABSOLUTE(.);					\
 		__bss_end = ABSOLUTE(.);				\
-		_end = ALIGN(0x8);					\
 		PROVIDE(end = ALIGN(0x8));				\
 		_stack_sentry = ALIGN(0x8);				\
 	}

-- 
2.43.0

