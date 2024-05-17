Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E46C25B78
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 18:17:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7E5488582;
	Fri, 17 May 2024 20:15:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="U9jYjTHv";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="jLdHKab1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E768D88581; Fri, 17 May 2024 20:15:17 +0200 (CEST)
Received: from fhigh7-smtp.messagingengine.com
 (fhigh7-smtp.messagingengine.com [103.168.172.158])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37E8988586
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 20:15:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 6DCE411400BD;
 Fri, 17 May 2024 14:15:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Fri, 17 May 2024 14:15:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715969714;
 x=1716056114; bh=8V2Qr/6eSx/MT+l/EtFNwAEO9j/M8gqIVbnvZ+Zafpc=; b=
 U9jYjTHvUrOgngi0VfM7B3Extf3Ls+089p9xnnHP2Q4cmWcGofneHncJSPBwPOb6
 doFIp9YLnPndUFhwwlrp33E0326JqVQTZ7IPqZpKwr1MHBaLHJomvhSAKWPMCNcV
 YZYwDld9PsyT6QMX+vHMnUgJY8dY3k6nWfgSCNw/PBrT74NMBfzlCFIQvuBi7sUM
 xCQbRTm7zPM/jUCbCqn0O6de4+TkZqRFyqbaLMMclsmI06tlD/4Fj4L/pVU/SxxU
 gffMFp2lq4HQeBeYlwOaFYkiccb50rrlgZavDp5S+t8FIOpwE9weLzfPgZ/Xcdwk
 8mMqO+gO14LvSaIA0AFNKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715969714; x=
 1716056114; bh=8V2Qr/6eSx/MT+l/EtFNwAEO9j/M8gqIVbnvZ+Zafpc=; b=j
 LdHKab1CV8/QdH8tcGMr+kpq3vcNv8s70l+etjyc+3sUdvgj/tr9fCQbRqLEi/Te
 7aSxwn3g9TfUK5IdCPw8a4qg9iZXg/8RDrRML3DxS0Pf6POultYDsqgcj9wE7C89
 Kya+mfkR6zkFs0RgrWGzOdLXFXItF2ivncIg49jXQwWKRwCU54202EqjrCgdZrzv
 LYomuHPsTi4el418gS7awD6ImGvGttLKwe+DbC5Jqg2Q/DIP9OtbeVhEJlbNZoPP
 y1IJGP7280MbiJfQ8tRCp62sRq/Nfn6brQrObl2p/ud4XHEGJkUx8G0Q8unuSfhP
 6YPqISB0NrEsBxj8Etvew==
X-ME-Sender: <xms:sp5HZv5QaZf0mJBKc_njOojNILCrddSpotZx4KRifg4Ut8S4IFYw3g>
 <xme:sp5HZk7MuUxVg1U8yPl1rXhb0giqtYeXcXjOcH4S8NE7ldZWnf1sTWU1_m8EaLBEp
 RefTVoldhV78eOQTTI>
X-ME-Received: <xmr:sp5HZmdp8ouoL5VBNv_AmcwoGM2YdbaAAnKPV_nPuy3OihNCNcYbEuY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehgedgvdelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhephefgleegjeeugfelhfeuudehleeitdethfeljefhvdevgeef
 feevteehheekudeknecuffhomhgrihhnpehkvghnrhgvlhdrohhrghenucevlhhushhtvg
 hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhg
 sehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:sp5HZgLXwCJlIVGdCMOYGYQ_Bs7DnWN7asllGZKtJ289riITAARYXw>
 <xmx:sp5HZjIcYzveOrTpw0NXHzUalt3QQreCouqx541tEGqP7UoaR2Gb1Q>
 <xmx:sp5HZpyJhi-dP3S-AOmDoDjua3QeJhv5WATX3ew6xErwA8teKSawLA>
 <xmx:sp5HZvJQWLJIPJWjBWO4NDX6el1625HdPX60axDyQ8sWYYBiUksmdg>
 <xmx:sp5HZlw7gjcZU2BxonHhfBFPcRdhuqwpoHBP9Hr_c4V0UjgQcrtQ2OSo>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 14:15:12 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 17 May 2024 19:15:00 +0100
Subject: [PATCH v3 12/12] mailmap: Update email for Paul Burton
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240517-boston-v3-12-1ea7d23f4a1d@flygoat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2072;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=qT8F2GfpoNQmppl7T68l24x0+KoFuNYyRrCngUMWAMI=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjT3ebMrft/T0nw4d5ND3dyE5RnmLm63pj4td152W91Z2
 orxau+JjlIWBjEOBlkxRZYQAaW+DY0XF1x/kPUHZg4rE8gQBi5OAZhIshgjw+MzR9hEJLyW5Tjd
 MvTLyOnwE9so5MV0dNcCjcMSy2+8ucDwh6uxbNs2TpFeH94le6U3rFyyQePN2YCMQ0IFRq/sbil
 ZsQIA
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

Paul had left MIPS a couple of years ago, his email address is
no longer valid.

Replace it with his kenrel.org email, which has been used in
kernel and QEMU, in case we still want to reach him.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 .mailmap                        | 3 ++-
 board/imgtec/boston/MAINTAINERS | 2 +-
 board/imgtec/malta/MAINTAINERS  | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/.mailmap b/.mailmap
index 8049856d41c3..bb7c1c3869ab 100644
--- a/.mailmap
+++ b/.mailmap
@@ -87,7 +87,8 @@ This contributor prefers not to receive mails <noreply@example.com> <pali@kernel
 This contributor prefers not to receive mails <noreply@example.com> <pali.rohar@gmail.com>
 Patrice Chotard <patrice.chotard@foss.st.com> <patrice.chotard@st.com>
 Patrick Delaunay <patrick.delaunay@foss.st.com> <patrick.delaunay@st.com>
-Paul Burton <paul.burton@mips.com> <paul.burton@imgtec.com>
+Paul Burton <paulburton@kernel.org> <paul.burton@imgtec.com>
+Paul Burton <paulburton@kernel.org> <paul.burton@mips.com>
 Piyush Mehta <piyush.mehta@amd.com> <piyush.mehta@xilinx.com>
 Prabhakar Kushwaha <prabhakar@freescale.com>
 Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@amd.com> <punnaiah.choudary.kalluri@xilinx.com>
diff --git a/board/imgtec/boston/MAINTAINERS b/board/imgtec/boston/MAINTAINERS
index 12e1652858bb..b03a6487db29 100644
--- a/board/imgtec/boston/MAINTAINERS
+++ b/board/imgtec/boston/MAINTAINERS
@@ -1,5 +1,5 @@
 BOSTON BOARD
-M:	Paul Burton <paul.burton@mips.com>
+M:	Paul Burton <paulburton@kernel.org>
 S:	Maintained
 F:  arch/mips/dts/boston-u-boot.dtsi
 F:	board/imgtec/boston/
diff --git a/board/imgtec/malta/MAINTAINERS b/board/imgtec/malta/MAINTAINERS
index b1cf297f4fac..252c5e45ab56 100644
--- a/board/imgtec/malta/MAINTAINERS
+++ b/board/imgtec/malta/MAINTAINERS
@@ -1,5 +1,5 @@
 MALTA BOARD
-M:	Paul Burton <paul.burton@mips.com>
+M:	Paul Burton <paulburton@kernel.org>
 S:	Maintained
 F:	board/imgtec/malta/
 F:	include/configs/malta.h

-- 
2.34.1

