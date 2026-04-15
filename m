Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84AACF43848
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 16:04:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 470AF84285;
	Wed, 15 Apr 2026 18:04:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="PH5u846+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A382C84255; Wed, 15 Apr 2026 18:03:58 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E75908424E
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 18:03:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso85076645e9.2
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 09:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776269033; x=1776873833;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lDYUu1aHVrYp0+wxOiCzVg/9i2lTGsLfGTX+3LGFjyo=;
 b=PH5u846+KGAn+tM1dCWziUyoBixHGVWPeqTKNJ+dt3iSnsgJuGYnYrgKKCrSq1rwU+
 jEfGGm0J6Ly1asfj+VaYdoqP/PoANrNdzkUsL9BOlA4tcJutOmpoiIYrjLdmSKDieBRA
 Q88VVGRQvN8K7XjsbUb5fgkKQ9fTAnc5h9AKUvtMGdq1c7G6J2dRS8RASi3kV9p0zFHq
 yMW7JIJ7Aue8oijFQFIsgUwSrf8IzQ5yLeOrEiqGjiR7FzWUyJX4SFPgehiR1+czUl8H
 IsVeNH9Htn6BxnZMtUJW6rRXTDVHkePsRRiYxACvoI9LOAAnviaydwwqmeD+DpLhPPjg
 KZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776269033; x=1776873833;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lDYUu1aHVrYp0+wxOiCzVg/9i2lTGsLfGTX+3LGFjyo=;
 b=bJaiNad/xkDM0lLcx61pj/Faf1i8PsVxRGz5F5ZrxqQ7/vhR2a+02Ce2En+ZUzcOaL
 j10cO24CO9HKbbYoysZhSyVLr0isbt61UDzmn7WqLXzfDn4TzSbMIJuYOyvImWk3EB8V
 WdxJ39lOC0ckuodwDXOBBSNim1PSezdiO7QdC+twv9+oPeuFDKJ/eyZ/1S0TbNTvPXR0
 /IrzCmu7yX0BTQjOo5MntdtrDqettBE3CPjEIyCosbRlvtWJMxiZMsMm1aSoh1l0ZW6N
 Hg78PzrOQlraWS5F8WSeJBIH3ORe3kbfZ6PUnN0CmjugA1GqhEVzW1dNwCbpr6UWeFUT
 XnSA==
X-Gm-Message-State: AOJu0Yz45BZqcACFC8xDgw4w82fGYWEshbM4fa00FtoYzTTG373slEYm
 oMCXs26lqwEflrDgEdr4cgjUN+W8gNWOkVBrsCxUOPXI0jgTJHoB7pr6IVVPL7VjsTs=
X-Gm-Gg: AeBDietSVSXeT8rkqB24DuBeU+aIRqoHAisBKA+y2mXjg0I+PJC6E2f3IX259rULdsC
 /YTW7e0OK4iM4YagXRtG5Eb5kkkTnEPGDojRCldRpy56BtPd8QuSxwOT+hGkwoZt11LTALO/5/1
 27IcMOKPsUQT+/60xCl1/mh/mNAqhVqHKIJ9udVIB0Fkt3hGJv2FuEa+Qyf5htP0d0jvxYdceZF
 pk64z1kJbjyKUZL3/CYnuf5nAyttri2rlh91fmUxYJQ1bCIAg/C7FuzDZbmEz1LpEEuYSrfHZ0i
 0SlsSV4n/OJ9O46ZLXUnob/BrXB1H0Fh2oHaHS+N3w9VBlvlvJikOjZOvW0ODQjFGz33FDydJm4
 qd8BGJun2E6jtuAwXurf6hpyDmhXbMlYfnor6iu3EyC/xBXDF0FszDkh8qTmpZOQueGbQsvpzCS
 s3rZTZELMsKORLiVFbtj+yxnjswPm4Ogw=
X-Received: by 2002:a05:600c:1f83:b0:488:b99b:4177 with SMTP id
 5b1f17b1804b1-488d687bf61mr306376625e9.25.1776269033297; 
 Wed, 15 Apr 2026 09:03:53 -0700 (PDT)
Received: from localhost ([2001:4090:a246:83ca:1917:a47e:1872:2063])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f4352af8sm5047785e9.0.2026.04.15.09.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 09:03:52 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Wed, 15 Apr 2026 18:02:25 +0200
Subject: [PATCH v6 04/14] configs: am335x_evm: Enable SPL_OPTIMIZE_INLINING
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-topic-am33-evm-oftree-v2026-01-v6-4-94cde349bb01@baylibre.com>
References: <20260415-topic-am33-evm-oftree-v2026-01-v6-0-94cde349bb01@baylibre.com>
In-Reply-To: <20260415-topic-am33-evm-oftree-v2026-01-v6-0-94cde349bb01@baylibre.com>
To: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>
Cc: Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Parvathi Pudi <parvathi@couthit.com>, 
 Basharath Hussain Khaja <basharath@couthit.com>, 
 Paul Barker <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>, 
 Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Johan Jonker <jbx6244@gmail.com>, Brian Sune <briansune@gmail.com>, 
 Hai Pham <hai.pham.ud@renesas.com>, 
 Bernhard Messerklinger <bernhard.messerklinger@at.abb.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Parth Pancholi <parth.pancholi@toradex.com>, 
 =?utf-8?q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Paul Kocialkowski <contact@paulk.fr>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=859; i=msp@baylibre.com;
 h=from:subject:message-id; bh=I3wCr584w4qrMpmEFlt3u8b1PmfLml6qkprQmPgETBk=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsz721bceStro31527H6DQ9PLH9WzC4dlW1btML+ScmRZ
 Wf4V7b1dpSyMIhxMciKKbJ0Joam/ZffeSx50bLNMHNYmUCGMHBxCsBEdvYwMhy8vLB6fdG6Dq9v
 7Fsb7B9EFO1alcOaPXWSkV/x27zpWayMDM8e6p1aNpPVL0FQyUVlddpL7l0zEhQVzn50lPxwepW
 aGAMA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

Enable SPL inline optimization to shrink the size. After enabling
OF_UPSTREAM the size is otherwise too big. Enable it before enabling
OF_UPSTREAM to maintain bisect ability.

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 configs/am335x_evm_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/am335x_evm_defconfig b/configs/am335x_evm_defconfig
index bd188c252780fb541afbbe61a243bddaab79be93..17c0f840d3ad3cb6f09fa914655b304e90d0066a 100644
--- a/configs/am335x_evm_defconfig
+++ b/configs/am335x_evm_defconfig
@@ -23,6 +23,7 @@ CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SPL_FIT_IMAGE_TINY=y
+CONFIG_SPL_OPTIMIZE_INLINING=y
 CONFIG_SPL_ETH=y
 # CONFIG_SPL_FS_EXT4 is not set
 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"

-- 
2.53.0

