Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C572CCA5FF0
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 17:57:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8BAA460754;
	Mon,  5 Oct 2026 17:57:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HvIsjcNpqM3H; Mon,  5 Oct 2026 17:57:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C60086076F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791223032;
	b=HipxAY3D6WshrcOTKPSuldygte3dFej3HG3VdjgdsbI1DON5m9a4Xlsur00O/bGINpQL
	 r1P8as2LSRNFdkoRWNwF7H//CPpJns6agYG7RqArh6SCJyoUOyad59MUjIzgXaEwJgUzi
	 6syCnJlyIGNsABK7WBZY42DCXZQr3MF+4bfOT6mTVSS1EoDveilXeMx3meTCSqJM64vbU
	 oJUZdZxNiZNSydrKU+YoD/o2VtQguvP+n9oLfEAIpinMg3Lc2zqwp88c07ligIlT46vOM
	 eiH+iXzFjqjyM4NSmoit31mK1VlWRHRBzlptDu7XRoleI0mU8Q0p7ir/fKTYUAd1j2w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791223032;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=MOqE+/yQH7R0N7wa5Gux2GYLp/ly7OauFqySC6EAIfI=;
	b=HWtIK7TTIiwV0YWitMwK4qGqQKnsVFi5A/oTof83SEZT/Iwnm0nVWkCPqS9ap1ELcJnw
	 cbGWeZWi2kzii/R/oAPrbi7LI9+5249MOdkn1CyNXzkctTXpHSz95HNy1AwTM33U5DvXT
	 1D9qNoacR2X3bnT7fRNRNXU625mw315xQFt/r+Z3cLamOSbCGLq18LtQfMoEMkejVmMUu
	 5iXekc29E14AKy2hjowovTArOnL82TFO0i6N9/j1yMitlATwSNspQDvGBJ5rj4tUJpotA
	 5Hq1tE+GNojcOGenMF4LynyoV+AuaAcmqmDQ2+updD4OC5i4HeZ48B708QPfj3t2xqg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=wfrB2PiP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791223031;
	bh=MOqE+/yQH7R0N7wa5Gux2GYLp/ly7OauFqySC6EAIfI=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J3aerZGPxai/mxgI+wXY2urt7aZEEYFk/zhK5SxofzjNiRtpkrbkfyVEQG9wD/fOm
	 aosG/2IpkaFclT79d1C9nmWO799Ko4Jvc5UqiYX5IR+mQX7+Ii+ugalbGGt3sG6Gd7
	 dXo30Erf20Cmj4GrY70e46DCdvjObwsdx0tInWUmJw6/sssMkrJ0i/q+yP/smOuPJO
	 W8n+9e/clv/d1je37lXITVbPy0qYtv4ofI/lMT5zkNx4jYqJ5m6Sitvl4avUoml6U+
	 rDjfNAZNdc39/YauFiLueF0nJP2pDgRHzrpn5uT4+JbN3cBfpe4Ox9JvCxzN6nPeSf
	 ylFGuvcd9jp4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C60086076F;
	Mon,  5 Oct 2026 17:57:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B451C22B
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 17:55:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A5FAF60748
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 17:55:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SjKbQ-yj4LRf for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 17:55:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C2A6D60730
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=79.135.106.119
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791222930;
 b=R72dBLZ2v+QRJuqtVn85/h3u+eghML3Uknwbj79A70YGQuiCraWNpvW8ZbJ19I3sZiMq
 FlGB6au53i0RCBEvh39bxoGzUbMyyQ2qhkDEcfzSnH1ZR188ODnysSMCD0rh5oFOhO0ol
 N8ttuyjBfdvQlFMs1duNF6neBBp7P9T0husM0rySdQMRyM5lJKDBRYyGyoqDg2GqmgWyY
 nXeOUrK30FhNRdhY9w9k0JPCB9Zt4EDZrnYG/lPv6DEDSnLEMKoofemt9axzk0mJQq1Tm
 cLG4XIrs9EOZSE9wTq4460xF3D936QeoVi1gfVEilsoqbWL+UQtgkUMhw8M+45zR6PA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791222930;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=MOqE+/yQH7R0N7wa5Gux2GYLp/ly7OauFqySC6EAIfI=;
 b=pV8nBdlYvT5Wr+fE5SsfMAbwti1jgiytpDS+zJCQVIOXpke9IZFhhnmjn2crrd+8dZ2h
 ManDG1auHLAMQtTzqu290Zyicu5BasKfU7hwOU9MDe/lBEPt7Tfa8Gvj4f30vCQVYQaww
 eXJvs3flU6VsaiIm15VHPBtxZxGdVAgbuFObEznhpqEA6i/eT/eYvUEqkUYpACctHlDAo
 nX2FIODviIS/gw/aqYn1ie2fIbfnyt7MvefazJ1jFmgZPIcpT4ue3hiJ/RFPDzLYECxRr
 dYOSV3KrADxdG0SMJA9AAW3MDaY85/h/d6/PreR14snvauPkyqJxW4VozEzxPaN2Jkg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=wfrB2PiP; 
 arc=none smtp.remote-ip=79.135.106.119
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=79.135.106.119;
 helo=mail-106119.protonmail.ch; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=wfrB2PiP
Received: from mail-106119.protonmail.ch (mail-106119.protonmail.ch
 [79.135.106.119])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C2A6D60730
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 17:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1791222924; x=1791482124;
 bh=MOqE+/yQH7R0N7wa5Gux2GYLp/ly7OauFqySC6EAIfI=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=wfrB2PiPcY9tQmTYMK07cXRfktHCKdNzNQ2ZbAs8kigJ8FBh/xdbAbr/T32BKhMU1
 DDD0vq+m3EC8tcq3u00Pql13KDXSIPM+Y808uynZEjlbmpmaMdvdPCWDSUqAfwCrp+
 Jx6aqtZMVE++SLhvt9jpDf2sFJROax7RsnSUHJkqXis69Gh7mRL1hgQqpfz4NhY9Fe
 ZgEeAJS1tZ/uZ6xJhNsr5RGm0b+SNVo7WVsYugPxbWbf81KDtQR7GGN5BemexdD03J
 ybWyH0ySqXON1BH44v3MLEifwBSevyxo0NDrgNtJU9+IXXsgr2z1Exi0LAzaieClXK
 qptWN3vroAvJA==
Date: Mon, 05 Oct 2026 17:55:19 +0000
To: Yixun Lan <dlan@kernel.org>, Eric Chung <eric.chung@riscstar.com>,
 Peng Fan <peng.fan@nxp.com>
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: u-boot@lists.u-boot-project.org, Jaehoon Chung <jh80.chung@samsung.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/3] mmc: k1: handle a missing max-frequency and
 clk_set_rate()'s return value
Message-ID: <20261005T135220-0400.mmc-v2-0001.DaveWK225@protonmail.com>
In-Reply-To: <20261005T134748-0400.mmc-v2-cover.DaveWK225@protonmail.com>
References: <cover.1790975596.git.DaveWK225@protonmail.com>
 <20261005T134748-0400.mmc-v2-cover.DaveWK225@protonmail.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: 7d520a5f0d34139cfa8de678e8d0930161d5e9bb
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

The driver sets the io clock to the max-frequency the device tree gives
and fails the probe on any non-zero return from clk_set_rate(). Two
problems follow:

- clk_set_rate() returns the new rate on success and a negative error
  code on failure. The SpacemiT clock driver happens to return 0, but
  any clock driver that reports the rate makes the probe fail.
- A node without max-frequency asks for 0 Hz. On the K1 clock driver
  that picks no divider at all and writes whatever the calculation left
  behind into the io clock's divider field; host->max_clk is then 0,
  the capabilities register gives no base clock either, and the probe
  fails in sdhci_setup_cfg().

Treat only a negative return as an error. Without max-frequency, leave
the io clock as an earlier stage set it and run from its current rate.

Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>

Changes in v2:
- Use ulong and IS_ERR_VALUE() for the clock API return values.
- Validate clk_get_rate() before narrowing to cfg.f_max and retain the erro=
r.

---
 drivers/mmc/spacemit_sdhci.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/spacemit_sdhci.c b/drivers/mmc/spacemit_sdhci.c
index f5578f38bd..6488ae0fdb 100644
--- a/drivers/mmc/spacemit_sdhci.c
+++ b/drivers/mmc/spacemit_sdhci.c
@@ -606,10 +606,30 @@
 =09=09goto err_reset;
 =09}
=20
-=09ret =3D clk_set_rate(&clk, plat->cfg.f_max);
-=09if (ret) {
-=09=09log_err("Failed to set io clk: %d\n", ret);
-=09=09goto err_reset;
+=09/*
+=09 * Without max-frequency there is no rate to ask for: leave the io
+=09 * clock as an earlier stage set it and run from its current rate. The
+=09 * capabilities register gives no base clock on the K1, so it cannot
+=09 * stand in. clk_set_rate() returns the new rate on success, so only a
+=09 * negative value is an error.
+=09 */
+=09if (plat->cfg.f_max) {
+=09=09ulong rate =3D clk_set_rate(&clk, plat->cfg.f_max);
+
+=09=09if (IS_ERR_VALUE(rate)) {
+=09=09=09ret =3D (int)rate;
+=09=09=09log_err("Failed to set io clk: %d\n", ret);
+=09=09=09goto err_reset;
+=09=09}
+=09} else {
+=09=09ulong rate =3D clk_get_rate(&clk);
+
+=09=09if (IS_ERR_VALUE(rate) || !rate) {
+=09=09=09ret =3D rate ? (int)rate : -EINVAL;
+=09=09=09log_err("No max-frequency and no io clk rate\n");
+=09=09=09goto err_reset;
+=09=09}
+=09=09plat->cfg.f_max =3D rate;
 =09}
=20
 =09/* Set quirks */
--=20
2.55.0

