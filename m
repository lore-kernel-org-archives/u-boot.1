Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF4B4CD3442
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 08:06:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00A5384A20;
	Thu,  7 May 2026 10:06:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="c4J12/2S";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="PlGxMrcB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DCE584A29; Thu,  7 May 2026 10:06:22 +0200 (CEST)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 871A0849F6
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 10:06:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j@jannau.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id 5916FEC0351;
 Thu,  7 May 2026 04:06:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Thu, 07 May 2026 04:06:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm1; t=1778141176; x=1778227576; bh=o+
 S7n+zg1D8m1U2o2c1Sf4P7+Afk4SAaB5R+p8J294Y=; b=c4J12/2SdANKSJgJMH
 h9tGvUjlieJJhhXEsT6KPY+VKCbOAZdHutWBlLch9g4g4eCKXE2yR1WDaHuJQqmq
 sbkpTEpgPyonNk60A5k7tlq24pzvsY8CpOMVbgOKTmuEIk8gvYmo6MJpiIxJHElE
 FzcmX98HyUp+rxUQGRtQMSz7fzWLeRVq4JPA0wEMeGNrB9IlHM6LBvP/jds+z/u1
 E39woslaJ/cQit/RVhGhUNrcGD8lxeZhb7BNXKK1f9yIzGOZq4y7O5l82ksnDHS2
 H9SsP5vCi81ukB1qzWRUpO68C7IyL6y5GvfEtSa93Fa9qSH7OjS3UwWKQLij60Hr
 2eYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1778141176; x=1778227576; bh=o+S7n+zg1D8m1U2o2c1Sf4P7+Afk
 4SAaB5R+p8J294Y=; b=PlGxMrcBl0IqXft5K5/jBhAoL54APD+AOAWUOcCzWT8+
 5Ambqr+/W3nBDK0UpujX6MOpm/02pMdzR5OSZ8FUCCodOGYApKLtBQCOKEKZhcyy
 OLfSeiARsUBMf90xzXaF2g0KIg6v3QAOVnB0FOkjepL9cW4FjVOFkR845GdYhztc
 SYszqcQtf6EpBlsC2nk9WIHlST57A8gkhXK2Rfprn3G2AWU9vy2xNHpuNiS54amt
 6HBNN5HjPmiEEY48egm4lp8S/gIh8hO7n/Q5oorfOFAMBpAV89MOargMd44O1SVd
 X85p7XPzphMDKB/vN6d0onxRMmr9CxEqIR6wQYnkUg==
X-ME-Sender: <xms:-Ef8aXNNKZ0mMRoQ3pxXN2HhgnCtjb-N976hkfuNNgzgpKHFokGVqw>
 <xme:-Ef8aY8MXolSik_oepebEWDTux_wE38DFFb7jN8S8GmyH37y2a6UAJLAu78xRSN9I
 o346s8xrE53RudfNUAfN7iwJsHHlDVL-fhecCI3HlQVP7QyMBT6nQo>
X-ME-Received: <xmr:-Ef8abTgEQCyE7Ao__cjwmKXXpJG3FtPhhMGlNTIBgE4LSwaqXR68i45fwz3k4vaobjgskS6KAccxISggohBKPl5Kx0p99MEmgaAVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdeileehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpeflrghnnhgvucfi
 rhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnhepgffhge
 egheeviedtuefhieevteeufedvvdeiheelhffgleffvedugeevteejkeelnecuffhomhgr
 ihhnpehmshhgihgurdhlihhnkhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
 epmhgrihhlfhhrohhmpehjsehjrghnnhgruhdrnhgvthdpnhgspghrtghpthhtohepgedp
 mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgvthhtvghnihhssehophgvnhgssh
 gurdhorhhgpdhrtghpthhtohepjhesjhgrnhhnrghurdhnvghtpdhrtghpthhtohepthhr
 ihhniheskhhonhhsuhhlkhhordgtohhmpdhrtghpthhtohepuhdqsghoohhtsehlihhsth
 hsrdguvghngidruggv
X-ME-Proxy: <xmx:-Ef8aalyji7XjDt1P3FPxZeD9avhVZjj4OnoVzuGQZOwT3UrOvsx7A>
 <xmx:-Ef8abTdt7wqcnqwTQ-DDTRA1X25AMj_hfiVEZSL3Mv53LQJXJi32w>
 <xmx:-Ef8aYNr_1Of32mbBNjygpODUt9VfY11VZ5w5BmzsnyzfgK0CqEg7g>
 <xmx:-Ef8aUWMB30pRybsXTDC5z3osRbCkhI71_s5lRcnEvzfM-uy_cwKHA>
 <xmx:-Ef8aVu7twYDzsSy4iz5CUcGfoq7q1NL7LfEAE8Pk5S0XwZTkhy6HjoK>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 May 2026 04:06:15 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Subject: [PATCH v2 0/3] Switch Apple silicon boards to upstream device
 trees
Date: Thu, 07 May 2026 10:05:48 +0200
Message-Id: <20260507-apple-dt-upstream-v2-0-35181f2b0509@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NQQrCMBBFr1Jm7cik1YCuvId0MSRTG9E0JGlRS
 u5urFuX78F/f4Uk0UmCc7NClMUlN/kK7a4BM7K/CTpbGVpqNSk6IYfwELQZ55ByFH6itjxQd1Q
 0iIG6C1EG99qa177y6FKe4nu7WNTX/mqHjv7UFoWE1rLWRmkhy5c7e8/z3kuGvpTyAWmpQFWzA
 AAA
X-Change-ID: 20260109-apple-dt-upstream-6daf03510fec
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <kettenis@openbsd.org>, 
 Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2633; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=I6BDIltjA+pbNoiZ5dxMMU7w3rZmC7Z4gnNGYNwMjJ0=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhsw/7t/2L7rv29xybafW7W2Jq/LNJFwOzdVYaDrfOLy3T
 Lz6fk5DRykLgxgXg6yYIkuS9ssOhtU1ijG1D8Jg5rAygQxh4OIUgIkc9WD4pxhjKS17z8ZQrvVy
 n2hA7yruA6Ed+23PFz44oH0qM1nYkpHhzIbNb6s+B8ibmm/6ZCzfLqTd23F0U26P1UxGvtdzvS4
 zAgA=
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

The Linux device trees for Apple silicon devices cover now most of the
hardware as u-boot's internal device trees for M1 devices. Linux has in
addition device trees M2 and M1 and M2 Pro/Max/Ultra devices which were
never added in u-boot.
The most common use case for u-boot on Apple silicon devices does not
use DTBs from u-boot but passes runtime modified device trees from an
earlier boot loader (m1n1).
This change regresses support for the SPI on M1 and M1 Pro/Max notebooks
as SPI keyboard support is not in upstream Linux. This regression is in
my opinion acceptable due to the limited use of u-boot's DTBs for these
targets.

Signed-off-by: Janne Grunau <j@jannau.net>
---
Changes in v2:
- Add CONFIG_OF_UPSTREAM_BUILD_VENDOR=y and
  CONFIG_OF_UPSTREAM_VENDOR="apple" to build all apple DTBs
- rebased onto v2026.07-rc1 for Linux v7.0 based DTs in dts/upstream
- Link to v1: https://patch.msgid.link/20260430-apple-dt-upstream-v1-0-dda66c16e0da@jannau.net

---
Janne Grunau (3):
      doc: board: apple: Mention M2 and M2 Pro/Max/Ultra SoCs
      doc: device-tree-bindings: Remove apple,pinctrl.yaml
      arm: dts: Switch Apple silicon devices to dts/upstream

 arch/arm/Kconfig                                   |    1 +
 arch/arm/dts/Makefile                              |    7 -
 arch/arm/dts/t8103-j274-u-boot.dtsi                |    1 -
 arch/arm/dts/t8103-j274.dts                        |  129 ---
 arch/arm/dts/t8103-j293-u-boot.dtsi                |    1 -
 arch/arm/dts/t8103-j293.dts                        |  116 --
 arch/arm/dts/t8103-j313-u-boot.dtsi                |    1 -
 arch/arm/dts/t8103-j313.dts                        |  111 --
 arch/arm/dts/t8103-j456-u-boot.dtsi                |    1 -
 arch/arm/dts/t8103-j456.dts                        |  117 --
 arch/arm/dts/t8103-j457-u-boot.dtsi                |    1 -
 arch/arm/dts/t8103-j457.dts                        |  105 --
 arch/arm/dts/t8103-jxxx.dtsi                       |  143 ---
 arch/arm/dts/t8103-pmgr.dtsi                       | 1138 --------------------
 arch/arm/dts/t8103-u-boot.dtsi                     |   25 -
 arch/arm/dts/t8103.dtsi                            |  696 ------------
 configs/apple_m1_defconfig                         |    4 +-
 doc/board/apple/m1.rst                             |   15 +-
 .../pinctrl/apple,pinctrl.yaml                     |  106 --
 19 files changed, 13 insertions(+), 2705 deletions(-)
---
base-commit: 4433253ecf2041f9362a763bb6cb79960921ac7e
change-id: 20260109-apple-dt-upstream-6daf03510fec

Best regards,
-- 
Janne Grunau <j@jannau.net>

