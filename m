Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2BEFCA5FC1
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 12:47:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 75B1C80FF3;
	Sat,  3 Oct 2026 12:47:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xNGy2pK4xN3B; Sat,  3 Oct 2026 12:47:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 56CE380EF4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791031672;
	b=f1LHZUQ1AOS/GQ8lhPD5573NMEOFBmLVAYmVJ2XP+OQ1l23NpeCqZlPgcZYBSYU+fMys
	 F3KqEiSfnTz8U99RmBSaqxpdk8NiN3qIxOnm5MrAgjbEhhEdCxygIX8WpnsSS4FAsmrmL
	 o0P7AUC4fYGQc8bY7z/7r99oDXl3kuozbfZdNGFocuvpPM2EPXBaNXE2OGIkVGNjK0/VF
	 gTPfdhLRYZMRfdg75A5aHNpfyrFRw/+2chl8IaID4qd46x+HsN9Z4vhYKAC2kIda3Q2Zt
	 JpRJx2OQVrNRxI1ax8hQqOuCNnWkTFETzNpeR3KhNYRtx+uA8xWFN7g7So8oWy84qUw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791031672;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ibSQMulgWU+lvGckx5t+ltVXcFNbHqt8Ohe5Ax7Ql/g=;
	b=tBjc+pykv/3O4RfJfqBJEOJPArfMz/DlGVAvXOkq7dTvbfA9ozVdWyWMvwX059PqLPdN
	 AfVSVR1QZoZOTJWKO1nigihlAR7EeJCIYQE2QBmgk0chxLGyByf7tweFWEOXuKL7cJmoL
	 W2VUIQyHI+3KKOXljZgNr3MxDrsMRzWIouTrIEQZj8VQBgZINQbhgwRARkK6s0+Dgvjm0
	 xJCWq2LsuzmVwWhEk6x2NBQUY/vCK7l0FgaTZO3QCquenf6pee4qFJfRIpuKCaszqbO0g
	 Qc1LcaTnnia8DuQxAXF+fhePwL1vCKB8AckyUd+QfAul/hgmle7RIkuGZleXHR6mGUQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791031672;
	bh=ibSQMulgWU+lvGckx5t+ltVXcFNbHqt8Ohe5Ax7Ql/g=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l/Kn87wh0dd+pdWjAKtWrnLD12ZYovqFU8KoCbRZ3JqmgtmFfmluNY+OYCYNyyobz
	 BCVgLuv7A3egKA49nCk3zxFWpSJUbDi0moPVKI7A7CFv/s7mKqXeOJTfywvxzl5Bn9
	 cWCCkdfN8cLlhmKr9+rdDU7W09+TUnxewDb2XGaBkUMhCrrlgUCzSLDdOo+EPmgjD8
	 RkJ/5UoORMNQFwIn9aiIa47JltcyVAjl37o/SpaG7N90S+DfHpq5F+Gv/F21tyfql6
	 9CsNIKSvtXVBviwioyPBEgB9eovRmC8p74N8E2v1LkGUChtFP4U/Vyo9MGdg5OSYKC
	 S4hTc8ZRFdBGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 56CE380EF4;
	Sat,  3 Oct 2026 12:47:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 92D7A32F
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 02:39:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8D4F56064B
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 02:39:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zuumn5MCgYiW for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 02:39:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D13E560649
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=109.224.244.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790995179;
 b=ehnBDfoaRb+TuCzsJgQ0/dxHALOeDpv3hINdxvjv/jqvn2ZorpSkQpF9K+8FH75XhwwF
 Oyz4JWi1DJl+Kt2F8BHi8jMCymYlwFENSf7yVBIq9KP44hM7IqstBeP6Syh/oZIDwb1qp
 OxkmJ+OetrFtQp60fHTMAwHNbdtG+ih2S28KP3b/exebc/Ie2C2Q4IFBwgJCbHAx6JMB3
 8FHzti/fJjz7Ptrdl7cvZHYCEzmbHU+GGDKKZ3IvVtY+Bzq852LDlFvOzlm66zyCalP7O
 lHfQRPv637VmIEnFGSHpFoQBZEb3YIdQz5rRjSnLOgMim31z30lF6H8hmIwkjcL6epQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790995179;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=ibSQMulgWU+lvGckx5t+ltVXcFNbHqt8Ohe5Ax7Ql/g=;
 b=Dcv57UgkhknruEMJyWQHs8mj7l+oQ85yITPoU9P4zK1bobD5lQsRMpq7bcroNMaHknzn
 QKQGZNkb4fYkD/rFhYbK3xZlt3NXjIr9skLNtqtaaKncdcwI5s2Q5HveL80fibmLwrhON
 0LapLtl8lIboYRbKo3T0kwacG6bjtz9zCb5LQpjEz+Wl48AQG+0C0I3dUPWJ95HKJ4hpJ
 8zCW0waA6h/4hUPeA972OrmTlbrYpVfnEnqcBoV7vw7Mz6sOGjxbtrHAKJDPoMBL2CSAn
 JHHoGKFvWk/lTmb8lGJSLD5uQ/AyVWybHvpr10IEtweAxj9kAmJ0syrW76me+ffmSEw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=oeOP+EJO; 
 arc=none smtp.remote-ip=109.224.244.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=109.224.244.123;
 helo=mail-244123.protonmail.ch; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=oeOP+EJO
Received: from mail-244123.protonmail.ch (mail-244123.protonmail.ch
 [109.224.244.123])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D13E560649
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 02:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1790995176; x=1791254376;
 bh=ibSQMulgWU+lvGckx5t+ltVXcFNbHqt8Ohe5Ax7Ql/g=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=oeOP+EJO8cZIkJbHeLg5VG9OD+57st2B5A/ixij11N23R7/F9ynihcEq/d/aDNO7R
 bVmagaVrBEIYFI1ug1841SeHZZM1te0N6DI9tGLkfnvWZsCJmRegO4Tn3Q1ugc7nVX
 JdN8qp8+vDdNhac4ILGFELIphsrblFlfZHFjsgwBq3EJRAyIpvAE7Oe1aPpIPGmySg
 695IDKDYYzlA175ieb2kwCHRUnRC3A/Df7XQ0RXF+7ZoawLsrfqnbaG5ecH4kHvQip
 Jnl1jK1GfBvFmc6lWbdbbIliWaYUsqcNsqdrEgtLKPL8f+lwrZMB3iDLPQaoYHkI97
 d+Qq86k+4dJmA==
Date: Sat, 03 Oct 2026 02:39:32 +0000
To: Yixun Lan <dlan@kernel.org>
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: u-boot@lists.u-boot-project.org, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>, Junhui Liu <junhui.liu@pigmoral.tech>
Subject: [PATCH v2] clk: spacemit: program the mux when setting a mix clock's
 rate
Message-ID: <25a05161c25d59a153acde52f798e5fcf570bd41.1790993264.git.DaveWK225@protonmail.com>
In-Reply-To: <5aa2337bcb969568749c4728354164d5a6c88f27.1790975596.git.DaveWK225@protonmail.com>
References: <5aa2337bcb969568749c4728354164d5a6c88f27.1790975596.git.DaveWK225@protonmail.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: 52c628c37e0ab97642c921d03984a1d91db63923
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 03 Oct 2026 12:47:49 +0000
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
---
Changes in v2:
- Reparent through clk_set_parent() before programming the divider, as
  suggested by Yixun Lan. CCF enables the new parent only when the clock
  itself is enabled.
- Reparent also when only the hardware mux disagrees with the chosen
  parent, including the SPL's single-parent clock registration case.
- Share parent-index lookup with ccu_mux_set_parent(). Keep the no-write
  case when the mux and divider already match.

v1: https://lists.u-boot-project.org/pipermail/u-boot/2026-October/633805.h=
tml

The parent/divider selection algorithm is unchanged from v1. This
revision changes how the selected parent is applied.

Retested on 2026-10-02, with the integrated board-support lane on next
bd2f5794b7e2, OpenSBI v1.9, and "clk: spacemit: ccu_mix: fix inverted
condition in ccu_mix_trigger_fc()" from Yixun's k3/for-next tree:
- OrangePi R2S: eMMC SPL boot, SDH2 I/O clock 204.8 MHz instead of the
  BootROM's 409.6 MHz; U-Boot HS200 at 200 MHz/8-bit, normal EFI and
  FreeBSD boot, and a final unattended reboot.
- OrangePi RV2: microSD SPL boot, U-Boot SD High Speed at 50 MHz, EFI and
  FreeBSD boot with root on NVMe; two boots checked.

Both CPU clusters remain at 1600 MHz on both boards, with SSH working
following boot. The R2S, RV2, generic K1 and RV2 SPI configurations build
SPL and U-Boot proper without compiler warnings; checkpatch passes.
Generic K1 and RV2 SPI are BUILD-ONLY for this revision. No before/after
performance benchmarks were run.

 drivers/clk/spacemit/clk_mix.c | 79 ++++++++++++++++++++++++----------
 1 file changed, 56 insertions(+), 23 deletions(-)

diff --git a/drivers/clk/spacemit/clk_mix.c b/drivers/clk/spacemit/clk_mix.=
c
index a1158512a9..fc8e0fd41d 100644
--- a/drivers/clk/spacemit/clk_mix.c
+++ b/drivers/clk/spacemit/clk_mix.c
@@ -136,14 +136,63 @@ ccu_mix_calc_best_rate(struct clk *clk, unsigned long=
 rate,
 =09return best_rate;
 }
=20
+static u8 ccu_mux_get_parent(struct clk *clk)
+{
+=09struct ccu_mix *mix =3D clk_to_ccu_mix(clk);
+=09struct ccu_mux_config *mux =3D &mix->mux;
+=09u8 parent;
+
+=09parent =3D ccu_read(&mix->common, ctrl) >> mux->shift;
+=09parent &=3D (1 << mux->width) - 1;
+
+=09return parent;
+}
+
+static int ccu_mux_parent_index(struct ccu_common *common, struct clk *par=
ent)
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
+=09=09index =3D ccu_mux_parent_index(common, parent);
+=09=09if (index < 0)
+=09=09=09return index;
+
+=09=09if (clk->dev->parent !=3D parent->dev ||
+=09=09    ccu_mux_get_parent(clk) !=3D index) {
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
+=09i =3D ccu_mux_parent_index(common, parent);
+=09if (i < 0)
+=09=09return i;
=20
 =09ccu_update(&mix->common, ctrl, mask, i << mux->shift);
=20
--=20
2.55.0


