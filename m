Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C026CCD98D2
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 23:21:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43A12849BB;
	Wed, 17 Jun 2026 01:20:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Kav20CAV";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="O6R2tJ2h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FA38849A3; Wed, 17 Jun 2026 01:20:22 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA34E84894
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 01:20:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gg2yq32ZPz9v0L;
 Wed, 17 Jun 2026 01:20:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781652019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vPRj+WYwfFMmPH8kAlpZM0AJD2TTDX/cZUtJ0HBJQJU=;
 b=Kav20CAVtSY6UKSBhZzVQ3Ja7V/tfrcGrj9NrDnTmhYJPL3E612VPUDC4I2LO/hGj0OTIB
 qFTqfD6mYwLGzkayDd2mw+p0LYjLyHWn3vF8aes9evx1Vx2sSxZZOcmQOO/xblYzfKvSkQ
 BK/TdsnzXFiOcIikgdQvifr5xy4lNTYW/XpqyTUt4/XwLqpQnlTLXsYSUX3je9Mk78rJws
 +W7Wy0gtkveKo1DSOVYEAeUHSDuDWC2SboeMfqhaNO+wDJK0uiOeK6v6wfwKGo3WATn9vN
 zohODzhDF3Nmr8OAPwAl0JlZFP1F4SBz8Tvmma+RE/O+Tb+RO7Mkymm9PodjEw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781652018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vPRj+WYwfFMmPH8kAlpZM0AJD2TTDX/cZUtJ0HBJQJU=;
 b=O6R2tJ2hHJnC4yHVxh94iIMEgebDjtL0ZjpP8UNtW2L6tulzPwpYSd3KdRG/PJOuVQfXKC
 GqTHLbuA9+d23blEwiAHgdZYDbRD4oe0cz3bSaOcXebn+JXgROwZ4RfAe/RRwpzMIDr82f
 MCgXGOgNBI+u9x4PnyKAX9RHYuBnZZSsRUl8EowNNhqBpvb+GLfvL7qWA3xmfWHPn3hmlE
 ElKuCx1cU88USonNjnQGAcpzMY2ahz0QWh6mEzCCi/dPtoSG9wu4OIOSN1zLog9VSNB4Rd
 9yaG1KxpwR/daXMeIjAG8eBv3AtnwZENFRSbHw3USGlN6lQWJnDfw3+SP/nqUQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 11/11] doc: board: renesas: Convert Renesas board support
 table to grid table
Date: Wed, 17 Jun 2026 01:18:52 +0200
Message-ID: <20260616231933.44392-12-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260616231933.44392-1-marek.vasut+renesas@mailbox.org>
References: <20260616231933.44392-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: rni7onanupsej7mtj89hh4x6pwn5fnq9
X-MBO-RS-ID: d315f650e83f3305c74
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

The list-table layout does not allow grouping columns together,
convert the table into grid-table layout instead and rework it
such that SoC families, generations, architectures and SoCs are
grouped together. Include SoC column to group SoCs together, and
Core column which is useful on SoC like the R-Car X5H where U-Boot
can run on multiple cores in the SoC.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 doc/board/renesas/renesas.rst | 334 +++++++++-------------------------
 1 file changed, 85 insertions(+), 249 deletions(-)

diff --git a/doc/board/renesas/renesas.rst b/doc/board/renesas/renesas.rst
index 41272c6e32a..c0cefc15dd8 100644
--- a/doc/board/renesas/renesas.rst
+++ b/doc/board/renesas/renesas.rst
@@ -14,255 +14,91 @@ Renesas SoC based boards
 
 Renesas is a SoC solutions provider for automotive and industrial applications.
 
-.. list-table:: Supported Renesas SoC based boards
-   :widths: 10, 25, 15, 10, 25
-   :header-rows: 1
-
-   * - Family
-     - Board
-     - SoC
-     - Arch
-     - defconfig
-
-   * - R2D
-     - R2D-PLUS
-     - SH7751
-     - :doc:`sh <build-env-sh>`
-     - r2dplus_defconfig
-
-   * - RZ/A1
-     - GR-PEACH
-     - R7S72100 (RZ/A1H)
-     - :doc:`arm <build-env-aarch32>`
-     - grpeach_defconfig
-
-   * - R-Car Gen2
-     - Lager
-     - R8A7790 (H2)
-     - :doc:`arm <build-env-aarch32>`
-     - lager_defconfig
-
-   * -
-     - Stout
-     - R8A7790 (H2)
-     - :doc:`arm <build-env-aarch32>`
-     - stout_defconfig
-
-   * -
-     - Koelsch
-     - R8A7791 (M2-W)
-     - :doc:`arm <build-env-aarch32>`
-     - koelsch_defconfig
-
-   * -
-     - Porter
-     - R8A7791 (M2-W)
-     - :doc:`arm <build-env-aarch32>`
-     - porter_defconfig
-
-   * -
-     - Blanche
-     - R8A7792 (V2H)
-     - :doc:`arm <build-env-aarch32>`
-     - blanche_defconfig
-
-   * -
-     - Gose
-     - R8A7793 (M2-N)
-     - :doc:`arm <build-env-aarch32>`
-     - gose_defconfig
-
-   * -
-     - Alt
-     - R8A7794 (E2)
-     - :doc:`arm <build-env-aarch32>`
-     - alt_defconfig
-
-   * -
-     - Silk
-     - R8A7794 (E2)
-     - :doc:`arm <build-env-aarch32>`
-     - silk_defconfig
-
-   * - R-Car Gen3
-     - :doc:`Salvator-X(S) <rcar-gen3-salvator-x>`
-     - R8A77951 (H3)
-     - :doc:`arm64 <build-env-aarch64>`
-     - rcar3_salvator-x_defconfig
-
-   * -
-     - :doc:`ULCB <rcar-gen3-ulcb>`
-     - R8A77951 (H3)
-     - :doc:`arm64 <build-env-aarch64>`
-     - rcar3_ulcb_defconfig
-
-   * -
-     - :doc:`Salvator-X(S) <rcar-gen3-salvator-x>`
-     - R8A77960 (M3-W)
-     - :doc:`arm64 <build-env-aarch64>`
-     - rcar3_salvator-x_defconfig
-
-   * -
-     - :doc:`ULCB <rcar-gen3-ulcb>`
-     - R8A77960 (M3-W)
-     - :doc:`arm64 <build-env-aarch64>`
-     - rcar3_ulcb_defconfig
-
-   * -
-     - :doc:`Salvator-X(S) <rcar-gen3-salvator-x>`
-     - R8A77965 (M3-N)
-     - :doc:`arm64 <build-env-aarch64>`
-     - rcar3_salvator-x_defconfig
-
-   * -
-     - :doc:`ULCB <rcar-gen3-ulcb>`
-     - R8A77965 (M3-N)
-     - :doc:`arm64 <build-env-aarch64>`
-     - rcar3_ulcb_defconfig
-
-   * -
-     - :doc:`Geist <rcar-gen3-geist>`
-     - R8A779MD (M3Le)
-     - :doc:`arm64 <build-env-aarch64>`
-     - r8a779md_geist_defconfig
-
-   * -
-     - Eagle
-     - R8A77970 (V3M)
-     - :doc:`arm64 <build-env-aarch64>`
-     - r8a77970_eagle_defconfig
-
-   * -
-     - V3MSK
-     - R8A77970 (V3M)
-     - :doc:`arm64 <build-env-aarch64>`
-     - r8a77970_v3msk_defconfig
-
-   * -
-     - Condor
-     - R8A77980 (V3H)
-     - :doc:`arm64 <build-env-aarch64>`
-     - r8a77980_condor_defconfig
-
-   * -
-     - V3HSK
-     - R8A77980 (V3H)
-     - :doc:`arm64 <build-env-aarch64>`
-     - r8a77980_v3hsk_defconfig
-
-   * -
-     - :doc:`Ebisu <rcar-gen3-ebisu>`
-     - R8A77990 (E3)
-     - :doc:`arm64 <build-env-aarch64>`
-     - r8a77990_ebisu_defconfig
-
-   * -
-     - :doc:`Draak <rcar-gen3-draak>`
-     - R8A77995 (D3)
-     - :doc:`arm64 <build-env-aarch64>`
-     - r8a77995_draak_defconfig
-
-   * - R-Car Gen4
-     - Falcon
-     - R8A779A0 (V3U)
-     - :doc:`arm64 <build-env-aarch64>`
-     - r8a779a0_falcon_defconfig
-
-   * -
-     - Spider
-     - R8A779F0 (S4)
-     - :doc:`arm64 <build-env-aarch64>`
-     - r8a779f0_spider_defconfig
-
-   * -
-     - S4SK
-     - R8A779F4 (S4)
-     - :doc:`arm64 <build-env-aarch64>`
-     - r8a779f4_s4sk_defconfig
-
-   * -
-     - White Hawk
-     - R8A779G0 (V4H)
-     - :doc:`arm64 <build-env-aarch64>`
-     - r8a779g0_whitehawk_defconfig
-
-   * -
-     - :doc:`Sparrow Hawk <rcar-gen4-sparrow-hawk>`
-     - R8A779G3 (V4H)
-     - :doc:`arm64 <build-env-aarch64>`
-     - r8a779g3_sparrowhawk_defconfig
-
-   * -
-     - Gray Hawk
-     - R8A779H0 (V4M)
-     - :doc:`arm64 <build-env-aarch64>`
-     - r8a779h0_grayhawk_defconfig
-
-   * - R-Car Gen5
-     - :doc:`Ironhide (Cortex-A720AE application core) <rcar-gen5-ironhide>`
-     - R8A78000 (X5H)
-     - :doc:`arm64 <build-env-aarch64>`
-     - r8a78000_ironhide_defconfig
-
-   * -
-     - :doc:`Ironhide (Cortex-M33 RSIP boot core) <rcar-gen5-ironhide>`
-     - R8A78000 (X5H)
-     - :doc:`arm64 <build-env-aarch64>`
-     - r8a78000_ironhide_cm33_defconfig
-
-   * - RZ/G2 Family
-     - Beacon EmbeddedWorks RZ/G2M SoM
-     - R8A774A1 (RZ/G2M)
-     - :doc:`arm64 <build-env-aarch64>`
-     - rzg2_beacon_defconfig
-
-   * -
-     - HopeRun HiHope RZ/G2M
-     - R8A774A1 (RZ/G2M)
-     - :doc:`arm64 <build-env-aarch64>`
-     - hihope_rzg2_defconfig
-
-   * -
-     - Beacon EmbeddedWorks RZ/G2N SoM
-     - R8A774B1 (RZ/G2N)
-     - :doc:`arm64 <build-env-aarch64>`
-     - rzg2_beacon_defconfig
-
-   * -
-     - HopeRun HiHope RZ/G2N
-     - R8A774B1 (RZ/G2N)
-     - :doc:`arm64 <build-env-aarch64>`
-     - hihope_rzg2_defconfig
-
-   * -
-     - Silicon Linux RZ/G2E evaluation kit (EK874)
-     - R8A774C0 (RZ/G2E)
-     - :doc:`arm64 <build-env-aarch64>`
-     - silinux_ek874_defconfig
-
-   * -
-     - Beacon EmbeddedWorks RZ/G2H SoM
-     - R8A774E1 (RZ/G2H)
-     - :doc:`arm64 <build-env-aarch64>`
-     - rzg2_beacon_defconfig
-
-   * -
-     - HopeRun HiHope RZ/G2H
-     - R8A774E1 (RZ/G2H)
-     - :doc:`arm64 <build-env-aarch64>`
-     - hihope_rzg2_defconfig
-
-   * - :doc:`RZ/N1 Family <rzn1>`
-     - Schneider RZ/N1D board
-     - R9A06G032 (RZ/N1D)
-     - :doc:`arm <build-env-aarch32>`
-     - rzn1_snarc_defconfig
-
-   * -
-     - Schneider RZ/N1S board
-     - R9A06G033 (RZ/N1S)
-     - :doc:`arm <build-env-aarch32>`
-     - rzn1_snarc_defconfig
+.. table:: Supported Renesas SoC based boards
+
+   +--------+------------------+----------------------------------+--------------------+--------------------+----------------------------------------------+----------------------------------+
+   | Family | Generation       | Architecture                     | SoC                | Core               | Board                                        | defconfig                        |
+   +========+==================+==================================+====================+====================+==============================================+==================================+
+   | R2D    |                  | :doc:`SH <build-env-sh>`         | SH7751             | SH4                | R2D-PLUS                                     | r2dplus_defconfig                |
+   +--------+------------------+----------------------------------+--------------------+--------------------+----------------------------------------------+----------------------------------+
+   | R-Car  |                  |                                  |                    |                    | Lager                                        | lager_defconfig                  |
+   |        |                  |                                  | R8A7790 (H2)       | Cortex A7 or A15   +----------------------------------------------+----------------------------------+
+   |        |                  |                                  |                    |                    | Stout                                        | stout_defconfig                  |
+   |        |                  |                                  +--------------------+--------------------+----------------------------------------------+----------------------------------+
+   |        |                  |                                  |                    |                    | Koelsch                                      | koelsch_defconfig                |
+   |        |                  |                                  | R8A7791 (M2-W)     |                    +----------------------------------------------+----------------------------------+
+   |        |                  |                                  |                    | Cortex A15         | Porter                                       | porter_defconfig                 |
+   |        | Gen2             | :doc:`arm <build-env-aarch32>`   +--------------------+                    +----------------------------------------------+----------------------------------+
+   |        |                  |                                  | R8A7792 (V2H)      |                    | Blanche                                      | blanche_defconfig                |
+   |        |                  |                                  +--------------------+--------------------+----------------------------------------------+----------------------------------+
+   |        |                  |                                  | R8A7793 (M2-N)     | Cortex A7 or A15   | Gose                                         | gose_defconfig                   |
+   |        |                  |                                  +--------------------+--------------------+----------------------------------------------+----------------------------------+
+   |        |                  |                                  |                    |                    | Alt                                          | alt_defconfig                    |
+   |        |                  |                                  | R8A7794 (E2)       | Cortex A7          +----------------------------------------------+----------------------------------+
+   |        |                  |                                  |                    |                    | Silk                                         | silk_defconfig                   |
+   |        +------------------+----------------------------------+--------------------+--------------------+----------------------------------------------+----------------------------------+
+   |        |                  |                                  |                    |                    | :doc:`Salvator-X(S) <rcar-gen3-salvator-x>`  | rcar3_salvator-x_defconfig       |
+   |        |                  |                                  | R8A77951 (H3)      |                    +----------------------------------------------+----------------------------------+
+   |        |                  |                                  |                    |                    | :doc:`ULCB <rcar-gen3-ulcb>`                 | rcar3_ulcb_defconfig             |
+   |        |                  |                                  +--------------------+                    +----------------------------------------------+----------------------------------+
+   |        |                  |                                  |                    |                    | :doc:`Salvator-X(S) <rcar-gen3-salvator-x>`  | rcar3_salvator-x_defconfig       |
+   |        |                  |                                  | R8A77960 (M3-W)    | Cortex A53 or A57  +----------------------------------------------+----------------------------------+
+   |        |                  |                                  |                    |                    | :doc:`ULCB <rcar-gen3-ulcb>`                 | rcar3_ulcb_defconfig             |
+   |        |                  |                                  +--------------------+                    +----------------------------------------------+----------------------------------+
+   |        |                  |                                  |                    |                    | :doc:`Salvator-X(S) <rcar-gen3-salvator-x>`  | rcar3_salvator-x_defconfig       |
+   |        |                  |                                  | R8A77965 (M3-N)    |                    +----------------------------------------------+----------------------------------+
+   |        |                  |                                  |                    |                    | :doc:`ULCB <rcar-gen3-ulcb>`                 | rcar3_ulcb_defconfig             |
+   |        |                  |                                  +--------------------+--------------------+----------------------------------------------+----------------------------------+
+   |        | Gen3             | :doc:`arm64 <build-env-aarch64>` | R8A779MD (M3Le)    | Cortex A57         | :doc:`Geist <rcar-gen3-geist>`               | r8a779md_geist_defconfig         |
+   |        |                  |                                  +--------------------+--------------------+----------------------------------------------+----------------------------------+
+   |        |                  |                                  |                    |                    | Eagle                                        | r8a77970_eagle_defconfig         |
+   |        |                  |                                  | R8A77970 (V3M)     |                    +----------------------------------------------+----------------------------------+
+   |        |                  |                                  |                    |                    | V3MSK                                        | r8a77970_v3msk_defconfig         |
+   |        |                  |                                  +--------------------+                    +----------------------------------------------+----------------------------------+
+   |        |                  |                                  |                    |                    | Condor                                       | r8a77980_condor_defconfig        |
+   |        |                  |                                  | R8A77980 (V3H)     | Cortex A53         +----------------------------------------------+----------------------------------+
+   |        |                  |                                  |                    |                    | V3HSK                                        | r8a77980_v3hsk_defconfig         |
+   |        |                  |                                  +--------------------+                    +----------------------------------------------+----------------------------------+
+   |        |                  |                                  | R8A77990 (E3)      |                    | :doc:`Ebisu <rcar-gen3-ebisu>`               | r8a77990_ebisu_defconfig         |
+   |        |                  |                                  +--------------------+                    +----------------------------------------------+----------------------------------+
+   |        |                  |                                  | R8A77995 (D3)      |                    | :doc:`Draak <rcar-gen3-draak>`               | r8a77995_draak_defconfig         |
+   |        +------------------+----------------------------------+--------------------+--------------------+----------------------------------------------+----------------------------------+
+   |        |                  |                                  | R8A779A0 (V3U)     | Cortex A76         | Falcon                                       | r8a779a0_falcon_defconfig        |
+   |        |                  |                                  +--------------------+--------------------+----------------------------------------------+----------------------------------+
+   |        |                  |                                  |                    |                    | Spider                                       | r8a779f0_spider_defconfig        |
+   |        |                  |                                  | R8A779F0 (S4)      | Cortex A55         +----------------------------------------------+----------------------------------+
+   |        |                  |                                  |                    |                    | S4SK                                         | r8a779f4_s4sk_defconfig          |
+   |        | Gen4             | :doc:`arm64 <build-env-aarch64>` +--------------------+--------------------+----------------------------------------------+----------------------------------+
+   |        |                  |                                  |                    |                    | White Hawk                                   | r8a779g0_whitehawk_defconfig     |
+   |        |                  |                                  | R8A779G3 (V4H)     |                    +----------------------------------------------+----------------------------------+
+   |        |                  |                                  |                    | Cortex A76         | :doc:`Sparrow Hawk <rcar-gen4-sparrow-hawk>` | r8a779g3_sparrowhawk_defconfig   |
+   |        |                  |                                  +--------------------+                    +----------------------------------------------+----------------------------------+
+   |        |                  |                                  | R8A779H0 (V4M)     |                    | Gray Hawk                                    | r8a779h0_grayhawk_defconfig      |
+   |        +------------------+----------------------------------+--------------------+--------------------+----------------------------------------------+----------------------------------+
+   |        |                  | :doc:`arm <build-env-aarch32>`   |                    | Cortex M33 RSIP    |                                              | r8a78000_ironhide_cm33_defconfig |
+   |        | Gen5             +----------------------------------+ R8A78000 (X5H)     +--------------------+ :doc:`Ironhide <rcar-gen5-ironhide>`         +----------------------------------+
+   |        |                  | :doc:`arm64 <build-env-aarch64>` |                    | Cortex A720AE      |                                              | r8a78000_ironhide_defconfig      |
+   +--------+------------------+----------------------------------+--------------------+--------------------+----------------------------------------------+----------------------------------+
+   | RZ     | A1               | :doc:`arm <build-env-aarch32>`   | R7S72100 (RZ/A1H)  | Cortex A9          | GR-PEACH                                     | grpeach_defconfig                |
+   |        +------------------+----------------------------------+--------------------+--------------------+----------------------------------------------+----------------------------------+
+   |        |                  |                                  |                    |                    | Beacon EmbeddedWorks RZ/G2M SoM              | rzg2_beacon_defconfig            |
+   |        |                  |                                  | R8A774A1 (RZ/G2M)  | Cortex A53 or A57  +----------------------------------------------+----------------------------------+
+   |        |                  |                                  |                    |                    | HopeRun HiHope RZ/G2M                        | hihope_rzg2_defconfig            |
+   |        |                  |                                  +--------------------+--------------------+----------------------------------------------+----------------------------------+
+   |        |                  |                                  |                    |                    | Beacon EmbeddedWorks RZ/G2N SoM              | rzg2_beacon_defconfig            |
+   |        | G2               | :doc:`arm64 <build-env-aarch64>` | R8A774B1 (RZ/G2N)  | Cortex A57         +----------------------------------------------+----------------------------------+
+   |        |                  |                                  |                    |                    | HopeRun HiHope RZ/G2N                        | hihope_rzg2_defconfig            |
+   |        |                  |                                  +--------------------+--------------------+----------------------------------------------+----------------------------------+
+   |        |                  |                                  | R8A774C0 (RZ/G2E)  | Cortex A53         | Silicon Linux RZ/G2E evaluation kit (EK874)  | silinux_ek874_defconfig          |
+   |        |                  |                                  +--------------------+--------------------+----------------------------------------------+----------------------------------+
+   |        |                  |                                  |                    |                    | Beacon EmbeddedWorks RZ/G2H SoM              | rzg2_beacon_defconfig            |
+   |        |                  |                                  | R8A774E1 (RZ/G2H)  | Cortex A53 or A57  +----------------------------------------------+----------------------------------+
+   |        |                  |                                  |                    |                    | HopeRun HiHope RZ/G2H                        | hihope_rzg2_defconfig            |
+   +--------+------------------+----------------------------------+--------------------+--------------------+----------------------------------------------+----------------------------------+
+   |        |                  |                                  | R9A06G032 (RZ/N1D) |                    | Schneider RZ/N1D board                       | rzn1_snarc_defconfig             |
+   |        | :doc:`N1 <rzn1>` | :doc:`arm <build-env-aarch32>`   +--------------------+ Cortex A7          +----------------------------------------------+----------------------------------+
+   |        |                  |                                  | R9A06G033 (RZ/N1S) |                    | Schneider RZ/N1S board                       | rzn1_snarc_defconfig             |
+   +--------+------------------+----------------------------------+--------------------+--------------------+----------------------------------------------+----------------------------------+
 
 Generic build procedure
 -----------------------
-- 
2.53.0

