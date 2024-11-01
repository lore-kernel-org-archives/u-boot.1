Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CCE8E6B242
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 10:17:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FBCA889EF;
	Fri,  1 Nov 2024 11:17:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="OW2MznA0";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="QaSC6gIP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDCF188A4C; Fri,  1 Nov 2024 11:17:45 +0100 (CET)
Received: from fout-b1-smtp.messagingengine.com
 (fout-b1-smtp.messagingengine.com [202.12.124.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18932889D2
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 11:17:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j@jannau.net
Received: from phl-compute-04.internal (phl-compute-04.phl.internal
 [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id A166B1140118;
 Fri,  1 Nov 2024 06:17:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Fri, 01 Nov 2024 06:17:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm2; t=1730456261; x=1730542661; bh=2h
 rjCxMV6OFe58GiWBEJrA9W4ralymMITzJ2hOSMXYE=; b=OW2MznA0XgmOUTdFjm
 ZfeNVmyyeuIRgK8NgIcRKFbMKhJMS/5rXxwJcyS5PmC4Di6FNzI9eHD9J/fclZQ/
 noAjp+sm5HTGSXflFCJyiOV6pNfW4V3V6TguGGFht52Hvm2HkQy2wA0sLqgfQ3hW
 hcZU3BQ+Jai1BUrr/VRlI172k9J7gbovJM693fP3oljiOnXtYHQOpll3Knl+haDN
 CGOiQ1gextnvw9BqWh4LGBL3BBxHeLqZ2O5hDunUh9D0q3WbPdXjLjC/aqxStLx3
 LL2epfODPy52TnFQP9pXzJHQb6/kQXp3eQa10u8Zf0HeA5K60b0EnTD1IG5Kt0x+
 /3dQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1730456261; x=1730542661; bh=2hrjCxMV6OFe58GiWBEJrA9W4ral
 ymMITzJ2hOSMXYE=; b=QaSC6gIPP0qbXKLgeH7kMkSrpFtAebfPp3lTecal8Jhj
 3wbh2ZI4QvfDVOBXoJRfJsVN1CWItisKQmeoMGF33Byb9Oi7t1Nsg+7XqNDUMSUQ
 b3Id8jE4LPJBj2PxC4iC+XWay20KfoqlkI/FysIW/1f4hCfGeOdlVQOjxICj9aQd
 eEeRqnk8rSb6E3u199nZgIHiiQOmQbu6L2lbG2vBvtoT2/d8AkI9Vu/4FkjqYIIx
 YD78WaAydoWfZNS4UeCF1Tc7f7Z3OFZl7oL/Q4/WVKZlpET0xKXs/fLUd+TVp+hP
 kkAA+UGOq0ZLSjmP2I/ITLPgI5phDibuVLbE7xvvqw==
X-ME-Sender: <xms:xaokZ91vvFpoimlzuGhtEqHW6X0DjyIexEkARYFI5eLLejGdGPCJKQ>
 <xme:xaokZ0FLbvxUzbVRmO4n9Wo0ZqtAgoBjljKCZIK1lShkqcoK7B8tkJAZDw82Ptaq1
 HBycXStjmvtK7pWxR4>
X-ME-Received: <xmr:xaokZ97I3keEncARmE6_9RBn-21daoE9ahB0QCXJ4iuH4ILFh4dUZD5ekqFom80AFejWLtMya-lAsU7FlVbNY6w4pO_geowBE2Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekledgudegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecu
 hfhrohhmpeflrghnnhgvucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecugg
 ftrfgrthhtvghrnhepueelgffhfedvgeelfeduuefhfefhjeeihfffueefjeeihffhheeu
 teeuvdeuhffhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
 hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjsehjrghnnhgruhdrnhgvthdp
 nhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhrih
 hniheskhhonhhsuhhlkhhordgtohhmpdhrtghpthhtohepkhgvthhtvghnihhssehophgv
 nhgsshgurdhorhhgpdhrtghpthhtohepshhughhhohhshhdrghgrnhhusehlihhnrghroh
 drohhrghdprhgtphhtthhopehsjhhgsegthhhrohhmihhumhdrohhrghdprhgtphhtthho
 pehuqdgsohhotheslhhishhtshdruggvnhigrdguvgdprhgtphhtthhopehjsehjrghnnh
 gruhdrnhgvth
X-ME-Proxy: <xmx:xaokZ61m3rdcEIcN1-vcSA0fOWiv_edzU-joSvahQbVZMypNNIyttA>
 <xmx:xaokZwHqsAMbxMZdZMWJudF1RVn98dBYyibbeb_VbGnYuargEYG56g>
 <xmx:xaokZ78kY5wDEIfPIRwOt3VyuHVQG_xNhb0o-Ap7CxmBHZlqFfK7AQ>
 <xmx:xaokZ9nQ6515xpYSXX8VjiU8XhgF37GdK8DcPN2C65G5iZ-TwfLzsQ>
 <xmx:xaokZ16GSb7VWgxEVPWrAtkFA1UMbs-i_0-2bXAzDqn1SN_snt8x3Ejh>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Nov 2024 06:17:40 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Subject: [PATCH 0/4] Fix IOVA allocation in Apple dart iommu after global
 LMB mem map changes
Date: Fri, 01 Nov 2024 11:15:50 +0100
Message-Id: <20241101-io_lmb_apple_dart_iommu-v1-0-fe4b9a74d47c@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFaqJGcC/x3MQQqAIBBA0avErBPUoqirRIjlVAOZohWBdPek5
 Vv8nyBiIIzQFwkC3hTJHRmiLGDe9LEiI5MNkstaCC4YObXbSWnvd1RGh1ORs/ZiZpZNW+PS8aq
 BXPuACz3/eRjf9wPs5lI0aQAAAA==
X-Change-ID: 20241101-io_lmb_apple_dart_iommu-dc2674ef9036
To: Tom Rini <trini@konsulko.com>, Mark Kettenis <kettenis@openbsd.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1942; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=MsJwRVLM5giCbEJW7R0CTb4TLhJpAB0y8BV07v5/0sY=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhnSVVWH/ps0OPRt5X7LcU1/L+s/ioL9Cu/oNFJaULt82Q
 yX55rMVHaUsDGJcDLJiiixJ2i87GFbXKMbUPgiDmcPKBDKEgYtTACYy8ygjw6yn9yz591ipLtPb
 JvKmQuDPT8kInnbbssXLPHZ//BuW/ZqR4ci+P2suRi7WFfnVeujolBktM4RrhSyvKlz+41snbzJ
 LjBMA
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
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

The changes in "Make LMB memory map global and persistent" [1] break
mapping DMA memory in the USB xHCI driver when using the apple_dart
iommu present on Apple silicon systems.

The IOVA space used by the u-boot driver (low 4GB) and physical memory
do not overlap. The physical memory on this systems starts depending on
the SoC either at 0x10_0000_0000 or 0x100_0000_0000. It make no sense to
manage these distinct regions in a single LMB map. In addition every
device has its own iommu and IO address space so sharing a single memory
map between all iommu instances is not necessary.

To fix this issue restore the used subset (add, alloc and free) of the
previous pointer based LMB interface with "io_" as prefix.

To ensure that low level lmb functions do not use the global LMB
variable reorder lib/lmb.c so that the variable is not visible.

Tested with patches from my "Fix device removal order for Apple dart
iommu" series [2] to fix a separate issue.

The cosmetic commit has two checkpatch warnings in existing code which I
ignored.

[1] https://lore.kernel.org/u-boot/20240826115940.3233167-1-sughosh.ganu@linaro.org/
[2] https://lore.kernel.org/u-boot/20241031-iommu_apple_dart_ordering-v1-0-8a6877946d6b@jannau.net/

Signed-off-by: Janne Grunau <j@jannau.net>
---
Janne Grunau (4):
      lmb: Do not use global LMB variable in _lmb_free()
      lmb: cosmetic: reorder functions and global LMB variable
      lmb: Add basic io_lmb functionality
      iommu: apple: Manage IOVA separately from global LMB mem map

 drivers/iommu/apple_dart.c |  16 +-
 include/lmb.h              |  47 ++++
 lib/lmb.c                  | 608 ++++++++++++++++++++++++++-------------------
 3 files changed, 406 insertions(+), 265 deletions(-)
---
base-commit: 1d147b74f437fb0e85821e8271fe52bc5fd30194
change-id: 20241101-io_lmb_apple_dart_iommu-dc2674ef9036

Best regards,
-- 
Janne Grunau <j@jannau.net>

