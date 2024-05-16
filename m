Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11180C25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 11:42:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECD9A882D9;
	Thu, 16 May 2024 13:41:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="dcjSRHfr";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="glM/sNOc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA95D882D9; Thu, 16 May 2024 13:41:04 +0200 (CEST)
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com
 [103.168.172.149])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C7E988361
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 13:41:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
 by mailfout.nyi.internal (Postfix) with ESMTP id 92CAD138027E;
 Thu, 16 May 2024 07:40:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Thu, 16 May 2024 07:40:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715859659;
 x=1715946059; bh=8V2Qr/6eSx/MT+l/EtFNwAEO9j/M8gqIVbnvZ+Zafpc=; b=
 dcjSRHfrSzVlvVQ1M9ycUgDxmfi2F/6j22V7F1FEV1vD9DX4GXEWpOLFUO99i4Fy
 l+Zq8oOK8R7jMuCqHguh6aIY+O5v7+k2R/70WlIrTYUeU6sH/v7oYRfmafvrjQBC
 y+j6josNbIYsiBsmcse+owbzt+B8Uj8Ec/odauUnVf6YVztgzw1UiuuyojgCqb12
 BdEtK3uPNtGXrzpziyfSat7h+kKYjAtAXBnlZn3KgR34ndU90aWUq4yQFdiA4wja
 vs4Vzs8hkwTxumeocABYKeVvZh3DYR5/D0051/x21YGmxoLZp7lrECOXFhhs2/2W
 UfrPFMVsxUc/XF5CO2M9Sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715859659; x=
 1715946059; bh=8V2Qr/6eSx/MT+l/EtFNwAEO9j/M8gqIVbnvZ+Zafpc=; b=g
 lM/sNOcd7jP2X8bQiIAGuVMBzozY5Ov7TcrDKGC+W1gdU4mnHaxRz88v770vU/k7
 eoDRT98UTEqgnQ8YWdo+dXDScsWbRLwyOWwcUFstNQzva7nfd1r7QRV4neEJUapb
 r4+798tC3Ub23U3yWW0ULwNFvDE3vGL0GmyA2DNQ8mmhQA9S8zJQXM7tzoqG0gX5
 LpbPWH2DrKq7ZqffggSkw2NefZnifCjnZ4utAd74k/jeSNNnlw9L7nRbaO/5ZoSb
 lujP9BAVPzR1uygow7QwZ800fei4yhQPGd6HdghEhIkAIWZj3ODD62Uwbui1hNe9
 /v1e51Q+Qo9l/df+c0S6Q==
X-ME-Sender: <xms:y_BFZuIABolCWQ_t_0isiQD0yJq7NR69ORFxvAHJ_B-cx6N-SQH0zw>
 <xme:y_BFZmKIp9AEHpCF0CoudAKzXyfgaHhdQp2wfnFuDCos_ySnqnS5fMq9f9w4GZTYe
 M3ZNZ69K23Oup7pmHc>
X-ME-Received: <xmr:y_BFZut1lQk7NFNU_mM8dXOjy_xE4pFSY8ID9itl_cQa_BhQkN3oSEM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehuddggedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhephefgleegjeeugfelhfeuudehleeitdethfeljefhvdevgeef
 feevteehheekudeknecuffhomhgrihhnpehkvghnrhgvlhdrohhrghenucevlhhushhtvg
 hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhg
 sehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:y_BFZjbDGyBdraiPA5BOXWndCv5iLl8sMFLmidFHrhHuOHu4oq1ywA>
 <xmx:y_BFZlZmQKOnZmdD0gEP5ftyEFSwsef0cVzk8kup7kI7NRWsBJINMQ>
 <xmx:y_BFZvByi8oVigbe9wgWgnEnr5Ud1wXnRYSdZTuOtQRKpNPxuxS52g>
 <xmx:y_BFZrYhgQ76YJGjtM8TKm_iQ0KetBZaFxSm_cSURnYvPuIRfSd0rQ>
 <xmx:y_BFZiQ6hSPL4jb6_wiP0Sd1lTROIoglkKb2ICW8WeOhSCzMhxhECaez>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 May 2024 07:40:58 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 16 May 2024 12:40:32 +0100
Subject: [PATCH v2 12/12] mailmap: Update email for Paul Burton
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240516-boston-v2-12-77938800d1dd@flygoat.com>
References: <20240516-boston-v2-0-77938800d1dd@flygoat.com>
In-Reply-To: <20240516-boston-v2-0-77938800d1dd@flygoat.com>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Paul Burton <paulburton@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2072;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=qT8F2GfpoNQmppl7T68l24x0+KoFuNYyRrCngUMWAMI=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjTXDzt2KbzZf/1LqVC2eo7+oWIX+9wZV43872oc4vrj3
 sP2ReB0RykLgxgHg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAEzkqwEjw//qPX9Yp4a+3+n5
 ijt5r+rXMznPRfTKXCUUHL8ZWB7kbWP47+H/r/XojOBHLkkLTHSmVvd/WHl1lqyho0nOI6b4PqZ
 vLAA=
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

