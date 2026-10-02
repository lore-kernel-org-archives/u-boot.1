Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E319DCA5FDD
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 22:10:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 50E9C60DB5;
	Fri,  2 Oct 2026 22:10:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id boUzd63a2z9D; Fri,  2 Oct 2026 22:10:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4C7A460DB6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790979006;
	b=gcS5dfzLImp/auiuGF587jJLDfVDQBpmaN4v9yWQt7K42fSoBWPgrMjwpkAJS09+jWng
	 sER7d/m9VmXL8Ldo0IsxxOCkHK+UEWb+AS5fmEis7bFcBOI/Hl72k8uPeS5pz9M341DYY
	 OHOWVODVGNEtQB+5gV4+53G9wH1L5noNRro2Z6MGP0vL5pIcW3jZ//j8G2Re+nwqz4BzM
	 6xjNzg10Iq7HAMXVqcyc54DO8bbqhoJGxiPMmj34v2ZHpDbSNBnqoWezssv5PgnzE4U7t
	 7s73ZVDnm/9COX+6CsLrp1YKy8/LHGWYfjlZ3P135n+CTKCNoM2wozigcTgMcfTD+KQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790979006;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:Feedback-ID:
	 X-Pm-Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=yomNX0sWHvPoEtsmXlZK/xIX6uLq+CGV6MSttl1On+4=;
	b=evKJSArf4DL1XMuuVqqfBMVL/1XYmlrsa1QuEbZrx51/kpSQ4CErRjUgBaURmYB+H23K
	 p3Z7F2atbR6v6dUXkdxQIMKrCoxNyG1gIqSBGIEJLTOPOlRX10yQYhNvr/e9AZIVMyk00
	 x3KHY78FCqn7cMXyPYt4e6lMqCUamAqsckd6HCCGmkQeK4pCsDBurPCedtMvIjwweXHBU
	 yYlkdaDFCEcLT/kS8VbVfg7zXoSzlV2zw7rcqOuR/QLkOu6yUNHknaZRgZSwV9Ng20+p6
	 M7Q0ccZGQbR6iQVh2WOsIgL1L8RpXZn2eKC6Yb4m+mhy8XUvxU3mB94Qyrk31ZX7tQA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=gAks1DZi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790979006;
	bh=yomNX0sWHvPoEtsmXlZK/xIX6uLq+CGV6MSttl1On+4=;
	h=Date:To:From:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=D+ILQwW4wt+gJdlLZLIxGzPQwElflV1C1GjPUjkiSXvf00K5sw+zVz00bhN4TmLiv
	 vIySBxglgbJ4kpqWOeD7KT0y5v1OAkAbeAOxahYfVWtzrfLbEUzvA8q5laXEaqxDAx
	 MQmfEQcafdCGBZw3s74dW7exMTsM7jNO2ooUMFTyu7SazEo7EWpNpd7cbw5+H6yfTr
	 5kOdiZ/x5vfYCCfZc2Ukq1RkyTPj0Lj8Ey4UtQtX2OP8P/thkdAIBRpXhxKyCbZ9SY
	 H7WK2xxnwLtInC0krVuLkwS4V9fkkY5KaT040iq1j6bPd9o37Lm5Nwk8GR68mGpqgC
	 95sOu/jPqpJmQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C7A460DB6;
	Fri,  2 Oct 2026 22:10:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 60CB42E0
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:40:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 467A560D96
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:40:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gsiDvm6fj7Qt for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 21:40:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 646236065F
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=79.135.106.110
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790977204;
 b=SABqQYm2qn01ZC3wAzGAQlwyGnfpoxKlyJ4uhOS5USUbfsNLc8cjsAohYR0CqPD7PKTM
 xphoP1X0yGGfCZAg4w7xQbXiaOA884GhJjYGi3s5ASkdGIGeJNIz+PEiURYHEBDVX/l42
 aRXL7xnzL+pTyWAk1iwuKfMR6RqqOvOXrY/cc8c097v5T1zH5+yOCiwHnexg4WJUmt2wA
 gdQSQPCLcqsYx/cAULkYpmq9zBgUD4mLKEoVSYAePT1PH8BRLM60l0AMt/Yz+xdDWirkN
 Pq9O4+WObeFDwKokFoRu+EmwCCp0cVCUhtO4sOaVyc0BNFickTkAVmeJ4s0Wx+NcSug==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790977204;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=yomNX0sWHvPoEtsmXlZK/xIX6uLq+CGV6MSttl1On+4=;
 b=IkSQ2GkFOVFklKDTZA4lAUioqKPiPBxY/RL/7vZEC49402Nu2YxoAGHTbmnJtU9gffoH
 fVKpWWKYGV9+lydKUCpMLscove/GvzW/xpNivB8UUUDCfKN0KxVt49YRGysEelligaGAt
 b6ykhZO9K6aeNiyZHQtnC+dHPFSrH5vNRxojEdrc3px0FePYUE4j2ns9q3J4Mw1ozn5RS
 U+Ve8IQLDT4fOZMgtcZjWwFv0Yu48b0YfupSkFPgc/zJRLZ/pnq22u2gg4h8ZyuUdqo6+
 UGE9e9BGq9bwUSVnV5rB2t2HT0/UANTpZYlxVp7/IkgypERPsKoH5DR6Mdt/OasB3iQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=gAks1DZi; 
 arc=none smtp.remote-ip=79.135.106.110
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=79.135.106.110;
 helo=mail-106110.protonmail.ch; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=gAks1DZi
Received: from mail-106110.protonmail.ch (mail-106110.protonmail.ch
 [79.135.106.110])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 646236065F
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1790976560; x=1791235760;
 bh=yomNX0sWHvPoEtsmXlZK/xIX6uLq+CGV6MSttl1On+4=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=gAks1DZiuv3ozPenAYwggWDzQ8vnTeEP/T1vsEQTPbYfAQ590fB9vf43JttoQzCFg
 sIH2mx3Uc5bii08DYstiIM56CghaAQupEzag3BXYVoQ3U6jDG4jt/rKyI4rwxDTSfJ
 kvgJesPx2aGvn3LKjiAebsgn4Od8TrAlDnkuu+oC8aEvinvIarrxq4m+8z0DFCR4KN
 hMk326x+w5KKN/SvLyW7h1F+MKwKv5Zd5yVwwZoJt16OuRlEbm7QaD0ihzTaBrk7Jt
 hqheRtJmNlx/KdBzPaxup4r+Qku7jBw0rv1q4aTzBazI1EY3Kc7pXTxCc5nW61ezbg
 W+bYs8hKOUriw==
Date: Fri, 02 Oct 2026 21:29:16 +0000
To: u-boot@lists.u-boot-project.org
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: Lukasz Majewski <lukma@denx.de>, Yixun Lan <dlan@kernel.org>,
 Tom Rini <trini@konsulko.com>, Junhui Liu <junhui.liu@pigmoral.tech>
Subject: [PATCH] clk: spacemit: program the mux when setting a mix clock's rate
Message-ID: <5aa2337bcb969568749c4728354164d5a6c88f27.1790975596.git.DaveWK225@protonmail.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: 78f4e7c8ea723e84e60e096f60d42b26c1ce1097
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 02 Oct 2026 22:10:03 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

ccu_mix_set_rate() picks the best parent and divider but writes only
the divider. U-Boot's CCF has no determine_rate step that would reparent
the clock first, so the clock keeps running from whatever source the
mux selects, at a rate the caller never asked for. Worse, when the
hardware mux selects a source that this build's parent list does not
contain (the K1 SPL lists only pll1_d6_409p6 for the SDH clocks), init
registers the clock under parents[0] and the clock framework's idea of
the parent no longer matches the hardware.

Write the chosen parent's mux index and the divider together and latch
both with one frequency change. Enable the new parent first and reparent
the clock device after, so the framework follows the hardware. Nothing
is written when the mux and divider already match, so a clock left
running at the requested rate by an earlier stage is not disturbed.

Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
---
Tested on an OrangePi R2S booting from eMMC, where the SDH2 io clock
moves from the BootROM's 409.6 MHz to 204.8 MHz in the SPL, together
with "clk: spacemit: ccu_mix: fix inverted condition in
ccu_mix_trigger_fc()" from the K3 clock series, and on an OrangePi RV2
booting from microSD.

 drivers/clk/spacemit/clk_mix.c | 54 +++++++++++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/spacemit/clk_mix.c b/drivers/clk/spacemit/clk_mix.=
c
index a1158512a9..3521ab9374 100644
--- a/drivers/clk/spacemit/clk_mix.c
+++ b/drivers/clk/spacemit/clk_mix.c
@@ -9,6 +9,7 @@
  */
=20
 #include <dm/device.h>
+#include <dm/device-internal.h>
 #include <dm/uclass.h>
 #include <div64.h>
 #include <regmap.h>
@@ -136,26 +137,63 @@ ccu_mix_calc_best_rate(struct clk *clk, unsigned long=
 rate,
 =09return best_rate;
 }
=20
+/*
+ * U-Boot's CCF has no determine_rate, so the parent is chosen here along =
with
+ * the divider. The mux is programmed from the chosen parent rather than l=
eft
+ * where it was found: init falls back to parents[0] when the hardware mux
+ * selects a source this build does not list (the SPL lists only a subset)=
, and
+ * the clock would otherwise keep running from that source at a rate nobod=
y
+ * computed. Mux and divider are written together and latched by one frequ=
ency
+ * change, and nothing is written when both already match, so a clock left
+ * running by an earlier stage is not disturbed.
+ */
 static unsigned long ccu_mix_set_rate(struct clk *clk, unsigned long rate)
 {
 =09struct ccu_mix *mix =3D clk_to_ccu_mix(clk);
 =09struct ccu_common *common =3D &mix->common;
 =09struct ccu_div_config *div =3D &mix->div;
-=09u32 current_div, target_div, mask;
+=09struct ccu_mux_config *mux =3D &mix->mux;
+=09struct clk *parent =3D NULL;
+=09unsigned long parent_rate;
+=09u32 target_div =3D 0, mask, val;
+=09int i, ret;
=20
-=09ccu_mix_calc_best_rate(clk, rate, NULL, NULL, &target_div);
+=09ccu_mix_calc_best_rate(clk, rate, &parent, &parent_rate, &target_div);
=20
-=09current_div =3D ccu_read(common, ctrl) >> div->shift;
-=09current_div &=3D (1 << div->width) - 1;
+=09mask =3D GENMASK(div->width + div->shift - 1, div->shift);
+=09val =3D target_div << div->shift;
+
+=09if (mux->width && parent) {
+=09=09for (i =3D 0; i < common->num_parents; i++)
+=09=09=09if (!strcmp(parent->dev->name, common->parents[i]))
+=09=09=09=09break;
+=09=09if (i =3D=3D common->num_parents)
+=09=09=09return -EINVAL;
+=09=09mask |=3D GENMASK(mux->width + mux->shift - 1, mux->shift);
+=09=09val |=3D i << mux->shift;
+=09} else {
+=09=09parent =3D NULL;
+=09}
=20
-=09if (current_div =3D=3D target_div)
+=09if ((ccu_read(common, ctrl) & mask) =3D=3D val)
 =09=09return 0;
=20
-=09mask =3D GENMASK(div->width + div->shift - 1, div->shift);
+=09if (parent && clk->dev->parent !=3D parent->dev) {
+=09=09ret =3D clk_enable(parent);
+=09=09if (ret)
+=09=09=09return ret;
+=09}
=20
-=09ccu_update(common, ctrl, mask, target_div << div->shift);
+=09ccu_update(common, ctrl, mask, val);
=20
-=09return ccu_mix_trigger_fc(clk);
+=09ret =3D ccu_mix_trigger_fc(clk);
+=09if (ret)
+=09=09return ret;
+
+=09if (parent && clk->dev->parent !=3D parent->dev)
+=09=09return device_reparent(clk->dev, parent->dev);
+
+=09return 0;
 }
=20
 static u8 ccu_mux_get_parent(struct clk *clk)

base-commit: a000f2af240eaa996cec92f8d44bad96fdf3f898
--=20
2.55.0


