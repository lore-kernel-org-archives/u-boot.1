Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23341C02182
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 23:26:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 884398077F;
	Tue, 21 Jan 2025 00:25:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="aGplxZ9Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC475800C2; Mon, 20 Jan 2025 20:43:18 +0100 (CET)
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E57AA801F5
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 20:43:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1737402196; x=1737661396;
 bh=BYwJtdYixR6z5TOdJokIDrGm7stkdsrc2Y/rrjWJcWI=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=aGplxZ9ZIGuuDbK8IrerML4VU/VnB8yIijHPPuwUvu63DvSlHMtBXpGWlUraFvMuW
 yYzzOx9qVJee0nOBPtyOwuY2/GY9SyeEnR7s0oascy3YIyo7TiJy/+GOml04QOmH1Z
 sBCtroUso5u32o49GWUa44663Zz2Yk1Je6j8zlrjBFrLp0NMf2Oou8r+LgPiWTEEpt
 SEFkUijDMu/8Vt2TI4DjoHKZOzztj7HWDhLRaxezueFrURV6u6TOjS/FGAOBEsqGhW
 klwq6aq4m+cWaJQFSv6bSdh2OsiKtRHIQ9SlZ1287m4H4QztsWybv6IQvZ/ZJD7vRZ
 pvIdbziQ+wkFA==
Date: Mon, 20 Jan 2025 19:43:13 +0000
To: Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Simon Glass <sjg@chromium.org>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Matthias Brugger <mbrugger@suse.com>
From: Sam Day <me@samcday.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, Sam Day <me@samcday.com>
Subject: [PATCH 1/2] mach-snapdragon: pass fdt to qcom_parse_memory
Message-ID: <20250120-qcom-parse-memory-updates-v1-1-54a7f0550cff@samcday.com>
In-Reply-To: <20250120-qcom-parse-memory-updates-v1-0-54a7f0550cff@samcday.com>
References: <20250120-qcom-parse-memory-updates-v1-0-54a7f0550cff@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 225cdbde7600f817dad83d1b4ec239993c70b050
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 21 Jan 2025 00:25:40 +0100
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

commit fc37a73e6679 ("fdt: Swap the signature for
board_fdt_blob_setup()") introduced a subtle change to the Snapdragon
implementation, removing the assignment to gd->fdt_blob partway through
the function.

This breaks qcom_parse_memory() which was also called during
board_fdt_blob_setup().

The underlying issue here is that qcom_parse_memory is using the of_ api
to traverse a devicetree, which relies on the fdt_blob in global data.

Rather than relying on this subtle behaviour, explicitly pass the FDT
that should be consulted for a /memory node.

Using the OF API is typically preferable because it's easier to read,
but using the lower level fdt_ methods instead here doesn't add too much
complexity, I think.

Finally, a minor tweak was made to board_fdt_blob_setup to use the
passed fdt blob pointer instead of gd->fdt_blob, which removes the last
of the references to global data in this area.

Fixes: fc37a73e6679 (fdt: Swap the signature for board_fdt_blob_setup())
Signed-off-by: Sam Day <me@samcday.com>
---
 arch/arm/mach-snapdragon/board.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/bo=
ard.c
index f1319df4314783622bb5f4f2410d1d4fd28a1c83..2ef936aab757c7045729a2dd919=
44f4f9bff917e 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -88,20 +88,21 @@ int dram_init_banksize(void)
 =09return 0;
 }
=20
-static void qcom_parse_memory(void)
+static void qcom_parse_memory(const void *fdt)
 {
-=09ofnode node;
+=09int offset;
 =09const fdt64_t *memory;
 =09int memsize;
 =09phys_addr_t ram_end =3D 0;
 =09int i, j, banks;
=20
-=09node =3D ofnode_path("/memory");
-=09if (!ofnode_valid(node)) {
+=09offset =3D fdt_path_offset(fdt, "/memory");
+=09if (offset < 0) {
 =09=09log_err("No memory node found in device tree!\n");
 =09=09return;
 =09}
-=09memory =3D ofnode_read_prop(node, "reg", &memsize);
+
+=09memory =3D fdt_getprop(fdt, offset, "reg", &memsize);
 =09if (!memory) {
 =09=09log_err("No memory configuration was provided by the previous bootlo=
ader!\n");
 =09=09return;
@@ -158,7 +159,7 @@ int board_fdt_blob_setup(void **fdtp)
=20
 =09fdt =3D (struct fdt_header *)get_prev_bl_fdt_addr();
 =09external_valid =3D fdt && !fdt_check_header(fdt);
-=09internal_valid =3D !fdt_check_header(gd->fdt_blob);
+=09internal_valid =3D !fdt_check_header(*fdtp);
=20
 =09/*
 =09 * There is no point returning an error here, U-Boot can't do anything =
useful in this situation.
@@ -181,7 +182,7 @@ int board_fdt_blob_setup(void **fdtp)
 =09 * Parse the /memory node while we're here,
 =09 * this makes it easy to do other things early.
 =09 */
-=09qcom_parse_memory();
+=09qcom_parse_memory(*fdtp);
=20
 =09return ret;
 }

--=20
2.47.1


