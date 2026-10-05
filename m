Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB7CDCA5FF0
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 17:56:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1A9E0406D1;
	Mon,  5 Oct 2026 17:56:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o0pGut-UOMUL; Mon,  5 Oct 2026 17:56:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org F26DC406C5
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791222996;
	b=SrLG5PYxKz7DmUdPh8pbB7mZDinDCbZ1Seg1Xgunz79Yply52QgZLJPif8zrSmO7a96e
	 0GWh4frttBOCKX2ihVubbUqLHrYvRkx1AimQ+7YPynyMet9rDVM1o7fzeqLrKAf+MclYy
	 Nl6LoRQQwMeYkC+iqRa59iHgvRZe6CNF9dXdKo29eO2CMu9MyOWxfBF8DE+Mf+ttAePBN
	 tphe70XGPYtaCx/p7SFMBAM0CQbUEQrOS397mfwBVr9iDlrehhLPn6AxbCRcgxy8wvO+A
	 9S3nucO0WPPBsJ7FrXAqsSpSnFAFgaOUvRDbKsAO4R/drovKkmynVVfX2au9sO9sYzg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791222996;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=tFJO/gRfCvFYdWrqDtZMizL22xLIIUdHAlkRM/inzzc=;
	b=jzOpKebyYODExEiwtXrgVT6Kg8gNywoNDRVlZQS1PC6A7JFe5KE9m1h40yAo4Z5tjoa4
	 /oZdSErgaO5ZPl1emjO2wss1AY9yNDSr9KzxmsM7CgxQtIvO6zmPfNBKBgAC2fZJ54Q8k
	 ajSz0ppVDFG9rT8df3US3jdwc/2xXcC2X2jepflhTB9Fndb2EqL0/ggBH90s3Dg91FbyP
	 F0YZIGE4PZXrSldDmupb4/OPz/essPaQQS//HmQzKv2TPZCFInOxDZjvC5Ms8g67bwkSW
	 fOE5+KI0baPHFZl2pMEXkLCjAQWFOvwp+NU4mFfbMqayy6A7mYvAZYY0UUyYOYNRtNw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=fKOeSzHc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791222996;
	bh=tFJO/gRfCvFYdWrqDtZMizL22xLIIUdHAlkRM/inzzc=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NGEngX6RpGUMpk+9rly2j0koVqAXz3Q6jSkyMVNcAECgVEI4gVq5jaFipKF9ooszu
	 Tj8xT7fsQWXb9l2KqObJgFtJ+nletQB3qAPwW5VIY9/DWIq0DHa7dlchaAmftNzM6E
	 yMm6NKzW/5ie9iwYURY3TQYHG2kaJqCHjjp49B2SMe5UMuTgGOg66e4JHguK8O2M+O
	 pZsUXs4WwMf4/2iVwmHxmMFtXRcJQCuLLpICQHCIHmxvEE6kfyw28tkXo/h1nRbzwk
	 XRDph/L8nJka3T49vlsCCbdTK6iZK06Pwk5Qlek7aqAXfA3+2EnydjPRWPgvuDEx9J
	 oQV05F4+e2ksg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F26DC406C5;
	Mon,  5 Oct 2026 17:56:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 012611A6
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 17:40:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DB01B40670
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 17:40:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EFwCjoGYgttb for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 17:40:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9E58D4064E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=185.70.43.16
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791222034;
 b=pcPsTgi82ti2H0R9JDCzPgLouhX31V/GhzGgtCc9OfNM/DFmq6ITO91rrbfui3dYceCf
 5udqrQyG4F2WkSrt5hOi0RYeTbfQF9OtIin2xQv1cb1v2KfZ6PFyCyYDXIUxhgoKAFmuf
 t8xoZu0Fat9i37NrCTvHOP48MJKJqlivfWgnLt/4LWh+qeY1LXmrS8TvA3eR2Zg8RGJ2w
 zKHpFlmSPTAjpbacHBmvcMh1Ez2EV6xkzz/VC+C8Xj0I9vzsLnkO6wlDEDqulQeB+YO5B
 gIV6PQj4nNutn2kaAQskwIIGVZL0gZKM3tCAio1rVtLregSGCY2vKo3omhrNiQTwH7Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791222034;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=tFJO/gRfCvFYdWrqDtZMizL22xLIIUdHAlkRM/inzzc=;
 b=TkNN0dSw/D0JavXQKqxgf0mdugBdcz9MTI9ASmMiaqAg3ZmaojyITnxuIthEz2QD1kUu
 nkrh0iI2jnLbA29yi/y12PbHX1TI+Odoavw5xYbcBYMiU3jKRchv8Ul3qcsOTH712GKFi
 iJZCmuKSDbNmnhg2PBqjjWOS+XupyLge+QERnM+c7fbn++RBrK2Za3MPhU3txWegEG+wa
 argrPU2qsPDFcbZyWamWAAwTLe22SeRBxNmAeHn8d2JElJ3LHobGM8jqUjdRH1RmH3F2e
 P5n/YFbPVcwpHMKBnRcBl+BRDyVFvMAjBDJTfdBligWcJ97CSGWWeSvAh3I6vVr+waw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=fKOeSzHc; 
 arc=none smtp.remote-ip=185.70.43.16
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.70.43.16;
 helo=mail-4316.protonmail.ch; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=fKOeSzHc
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9E58D4064E
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 17:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1791222030; x=1791481230;
 bh=tFJO/gRfCvFYdWrqDtZMizL22xLIIUdHAlkRM/inzzc=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=fKOeSzHcGp0Kolp0Sw9p0LMlmwiFgTn6j5ygKvekST1A7Fz3gc9lZx1DYOhKQqtN0
 4vx5eufsEoebvypscGojMuZGd2ULss/isyG8idDElIFXLy3lxzTaw1IImSBPGg7xl+
 4x7/w13nL4M3ROO8rWad38ar6HU7hwINnl7o2OFQFVzhgpjzSRfn+yj1UtZoi69bJS
 udXgj8l8aV4wo5s1kMMleIp3/M/KOtx58FhxqHCYd2voFUql9yX/DbXzZFDXbLc9AB
 ed2j4aKGnYT6Lrm/Pp6oraa/nxGqCH2pQb4M5XxiyU2l2P/HXCGjrfpSTQjYWumSOc
 klU1/TXosxSkQ==
Date: Mon, 05 Oct 2026 17:40:25 +0000
To: Yixun Lan <dlan@kernel.org>
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: u-boot@lists.u-boot-project.org, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>, Junhui Liu <junhui.liu@pigmoral.tech>
Subject: [PATCH v3] clk: spacemit: program the mux when setting a mix clock's
 rate
Message-ID: <20261005T133627-0400.clkmux-v3.DaveWK225@protonmail.com>
In-Reply-To: <20261004021830-GKD68132@kernel.org>
References: <5aa2337bcb969568749c4728354164d5a6c88f27.1790975596.git.DaveWK225@protonmail.com>
 <25a05161c25d59a153acde52f798e5fcf570bd41.1790993264.git.DaveWK225@protonmail.com>
 <20261004021830-GKD68132@kernel.org>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: 5d3aaa66eed665631748f457ce3b5ead549cb2ba
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Reparent the clock to the chosen parent with clk_set_parent() before
programming the divider, as the clock core does in Linux. Do so also
when the framework already has that parent but the mux selects another
source. Nothing is written when the mux and divider already match, so a
clock left running at the requested rate by an earlier stage is not
disturbed.

Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
Reviewed-by: Yixun Lan <dlan@kernel.org>
---
Changes in v3:
- Rename ccu_mux_get_parent() to ccu_mux_current_parent_index(), including
  the set-rate and clock-registration callers.
- Rename ccu_mux_parent_index() to ccu_mux_wanted_parent_index(), including
  the set-rate and set-parent callers.
- Name the hardware parent-index local variable index instead of parent.
- Carry Yixun Lan's Reviewed-by. No functional changes from v2.

Changes in v2:
- Reparent through clk_set_parent() before programming the divider.
- Reparent also when the hardware mux disagrees with the chosen parent.
- Share parent-index lookup with ccu_mux_set_parent() and preserve the
  no-write case when mux and divider already match.

v2: https://lists.u-boot-project.org/pipermail/u-boot/2026-October/633842.h=
tml
Review: https://lists.u-boot-project.org/pipermail/u-boot/2026-October/6339=
11.html

Validation: exact-base replay and inverse-renaming comparison against
v2 pass, with zero checkpatch errors or warnings. Both R2S and RV2
configurations build successfully.

An integration containing this patch, the MMC corrections and a separate
DDR firmware overlap fix passed warm-boot tests on a 2 GiB OrangePi R2S
and a 4 GiB OrangePi RV2. Both reached DDR/SPL, FIT verification and
automatic EFI boot to their existing FreeBSD 16 installation, with the
expected memory and eight CPUs. These are combined-integration results,
not isolated tests of this patch. Cold boot of the corrected firmware
and clock error paths remain untested.

 drivers/clk/spacemit/clk_mix.c | 87 +++++++++++++++-------
 1 file changed, 60 insertions(+), 27 deletions(-)

diff --git a/drivers/clk/spacemit/clk_mix.c b/drivers/clk/spacemit/clk_mix.=
c
index a115851..b626295 100644
--- a/drivers/clk/spacemit/clk_mix.c
+++ b/drivers/clk/spacemit/clk_mix.c
@@ -136,14 +136,63 @@ ccu_mix_calc_best_rate(struct clk *clk, unsigned long=
 rate,
 =09return best_rate;
 }
=20
+static u8 ccu_mux_current_parent_index(struct clk *clk)
+{
+=09struct ccu_mix *mix =3D clk_to_ccu_mix(clk);
+=09struct ccu_mux_config *mux =3D &mix->mux;
+=09u8 index;
+
+=09index =3D ccu_read(&mix->common, ctrl) >> mux->shift;
+=09index &=3D (1 << mux->width) - 1;
+
+=09return index;
+}
+
+static int ccu_mux_wanted_parent_index(struct ccu_common *common, struct c=
lk *parent)
+{
+=09int i;
+
+=09for (i =3D 0; i < common->num_parents; i++)
+=09=09if (!strcmp(parent->dev->name, common->parents[i]))
+=09=09=09return i;
+
+=09return -EINVAL;
+}
+
+/*
+ * U-Boot's CCF has no determine_rate step, so the parent giving the best =
rate
+ * is chosen here. As in Linux, the clock is reparented first and the divi=
der
+ * programmed after. Reparent also when the framework already has the chos=
en
+ * parent but the mux selects another source: init registers a clock under
+ * parents[0] when the mux selects a source this build does not list (the =
SPL
+ * lists only a subset). Nothing is written when mux and divider already m=
atch,
+ * so a clock left running by an earlier stage is not disturbed.
+ */
 static unsigned long ccu_mix_set_rate(struct clk *clk, unsigned long rate)
 {
 =09struct ccu_mix *mix =3D clk_to_ccu_mix(clk);
 =09struct ccu_common *common =3D &mix->common;
 =09struct ccu_div_config *div =3D &mix->div;
-=09u32 current_div, target_div, mask;
-
-=09ccu_mix_calc_best_rate(clk, rate, NULL, NULL, &target_div);
+=09struct ccu_mux_config *mux =3D &mix->mux;
+=09struct clk *parent =3D NULL;
+=09unsigned long parent_rate;
+=09u32 current_div, target_div =3D 0, mask;
+=09int index, ret;
+
+=09ccu_mix_calc_best_rate(clk, rate, &parent, &parent_rate, &target_div);
+
+=09if (mux->width && parent) {
+=09=09index =3D ccu_mux_wanted_parent_index(common, parent);
+=09=09if (index < 0)
+=09=09=09return index;
+
+=09=09if (clk->dev->parent !=3D parent->dev ||
+=09=09    ccu_mux_current_parent_index(clk) !=3D index) {
+=09=09=09ret =3D clk_set_parent(clk, parent);
+=09=09=09if (ret)
+=09=09=09=09return ret;
+=09=09}
+=09}
=20
 =09current_div =3D ccu_read(common, ctrl) >> div->shift;
 =09current_div &=3D (1 << div->width) - 1;
@@ -158,35 +207,19 @@ static unsigned long ccu_mix_set_rate(struct clk *clk=
, unsigned long rate)
 =09return ccu_mix_trigger_fc(clk);
 }
=20
-static u8 ccu_mux_get_parent(struct clk *clk)
-{
-=09struct ccu_mix *mix =3D clk_to_ccu_mix(clk);
-=09struct ccu_mux_config *mux =3D &mix->mux;
-=09u8 parent;
-
-=09parent =3D ccu_read(&mix->common, ctrl) >> mux->shift;
-=09parent &=3D (1 << mux->width) - 1;
-
-=09return parent;
-}
-
 static int ccu_mux_set_parent(struct clk *clk, struct clk *parent)
 {
 =09struct ccu_common *common =3D clk_to_ccu_common(clk);
 =09struct ccu_mix *mix =3D clk_to_ccu_mix(clk);
 =09struct ccu_mux_config *mux =3D &mix->mux;
 =09u32 mask;
-=09int i =3D 0;
+=09int i;
=20
 =09mask =3D GENMASK(mux->width + mux->shift - 1, mux->shift);
=20
-=09for (i =3D 0; i < common->num_parents; i++) {
-=09=09if (!strcmp(parent->dev->name, common->parents[i]))
-=09=09=09break;
-=09}
-
-=09if (i =3D=3D common->num_parents)
-=09=09return -EINVAL;
+=09i =3D ccu_mux_wanted_parent_index(common, parent);
+=09if (i < 0)
+=09=09return i;
=20
 =09ccu_update(&mix->common, ctrl, mask, i << mux->shift);
=20
@@ -238,7 +271,7 @@ int spacemit_mux_init(struct ccu_common *common)
 =09struct clk *clk =3D &common->clk;
 =09u8 index;
=20
-=09index =3D ccu_mux_get_parent(clk);
+=09index =3D ccu_mux_current_parent_index(clk);
 =09if (index >=3D common->num_parents)
 =09=09index =3D 0;
=20
@@ -304,7 +337,7 @@ int spacemit_mux_gate_init(struct ccu_common *common)
 =09struct clk *clk =3D &common->clk;
 =09u8 index;
=20
-=09index =3D ccu_mux_get_parent(clk);
+=09index =3D ccu_mux_current_parent_index(clk);
 =09if (index >=3D common->num_parents)
 =09=09index =3D 0;
=20
@@ -353,7 +386,7 @@ int spacemit_mux_div_init(struct ccu_common *common)
 =09struct clk *clk =3D &common->clk;
 =09u8 index;
=20
-=09index =3D ccu_mux_get_parent(clk);
+=09index =3D ccu_mux_current_parent_index(clk);
 =09if (index >=3D common->num_parents)
 =09=09index =3D 0;
=20
@@ -379,7 +412,7 @@ int spacemit_mux_div_gate_init(struct ccu_common *commo=
n)
 =09struct clk *clk =3D &common->clk;
 =09u8 index;
=20
-=09index =3D ccu_mux_get_parent(clk);
+=09index =3D ccu_mux_current_parent_index(clk);
 =09if (index >=3D common->num_parents)
 =09=09index =3D 0;
=20

