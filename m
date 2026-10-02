Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D5ACA5FE4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 21:35:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4CCE96064B;
	Fri,  2 Oct 2026 21:35:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 06vp9kc0iBTb; Fri,  2 Oct 2026 21:35:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9EFAB6065F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790976916;
	b=c8+70TG5QlzKNzhxZuvkSDv+cOSuRfwslUKkaATik9pQYPq/OHTCNLZLDEgU9jEv9qFk
	 /+yhAlf4EdGfx/qXsNz1A9jl0FHAjDo+iXM+sVk+BGzANGWFxHDZOnFqYdJpdVb9B8Wxq
	 EJTtFL5tat47OaWaqyiwx5ktWVsnXn9YVW4t2DZ9x316nihK2ecGXaOcO0I5HXT8GezG8
	 p92oBehqTmr8hBAd+XnG992mDKkzD42vksdGR17ozJ56F2zoBmceifZHEgg/4GgjSOk+B
	 /SOV+b6R5/C1ohG5ApYXEY5wJ0i6WZtDyjsfc9ZvSU/usHB5BO8PSW1oDg8TX9SksAw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790976916;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PeHQ0aC8cgJSadACPyWTG7NJSB8Is9JjjmCIzMaDbyY=;
	b=M7ELqzwlBK12hC0Jk/dJW8JBzJU3fjKJ3JCLuVww00loiLLZBuEKo4FOsK345wf2Nt59
	 AGr8kM9LdaTut1SyQV4dNKUAf3wJ16Iu6PfLxloxEeXru7yRzPBmvySDGbrFD1G6FDBIT
	 S1jLdVxaUUly/2R/3dcezA3lG6iuOu4e7oaRGpwTsAPa01mJU8P5Cr9j96Et9xkKIbOAP
	 o/PnzybSfFN1hePITLfnqvwMrwGbRL+xmi+tYg+AlDvZVebtdhR9Wj9UMTjg1UkoDk+cD
	 vqhkSeZO0m327SsUw3YiVGxhnYR+DrpGB6smbUWUKNVbf7cM5634r7qE30pHIljeHew==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790976916;
	bh=PeHQ0aC8cgJSadACPyWTG7NJSB8Is9JjjmCIzMaDbyY=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rE6tu7Pb3dfn+izPjBMA3UzttPYs7tDfzi+5bKiFXsxZq7Ndg0tym4pUJ8zHO722F
	 wGo0KK8+/CKQcn9o/yzgBObt270zXBcdBdtUWM0pF93vLByybarJ3FVITUqc1y2sla
	 rogY8cCdeKAJC5vyDSo4kt+GBqt874Hv1C6jgFEceuIJQOrRjuUvfjV3mVSix0+TpB
	 ngOMCOr2YZT/1AP/9jnOFQ0roi6QmeKSzuwpCwS/gymKSHq98C7RJJK8m/mynDtSI+
	 uHl/ze88lbF7dHRTPFcsQADNvOBUNcJ+haKl8nKZwYb2hiwBx/uOZswL2VUozQd80d
	 /ND3FTQnN5Q3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9EFAB6065F;
	Fri,  2 Oct 2026 21:35:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 981F81D2
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:33:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7E03540DB5
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:33:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J4Tc6lB55vYr for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 21:33:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 888FF40B6F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=185.70.43.21
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790976825;
 b=n5OHLVKWW5w3FeZPbTF89lY2HsdPArxG8iOFLNXfl8zX1tnY0xev4FijikX1n0BuVnPc
 fg0bQ7Kb+ySTFTtSe+oqT2Ofk4RS2rrK3lfG4m96IwewputgCqGfd7Anx+FDqZvI/rdJR
 lDoPJZyGxw0iYaNm2rDOAxeWiUZOik/bnHz4pfIm3+YM8xzTXNlHeiM2YaPxuE3avQPFS
 f/cfOAzS+SPvOZCBvw1BKPbipepAqUolqGHzqCUUBFdJo4lCfs+frNhZFIP1Y3GN8uzhE
 +BC9m2Q/tfc41V0UrYHnVHSjZZAGtXgbmURXfGLTT/VQreyEw6UlyuVPm7ez+YKyVwg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790976825;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=PeHQ0aC8cgJSadACPyWTG7NJSB8Is9JjjmCIzMaDbyY=;
 b=MFHyvvDhz22rOLtNiBJO4mYverYAAbuARTb1NVh3I6s+ETDl0386htQoj5nrx/O3kYuW
 RQ7fbHSsvnNDOQm6FuXgeK/y0YAwSlogbp2foVKaEetp7IFxJE9UY0jN1BPNh1hI6M+0s
 hEzLqjj+Cyc7uAFAebSwy8mWoibnappMLge4Bkgyye3ybVMlAJE9fK3JVfJIRQklRieCh
 EIv0m1bILB0uR7ogvuGSZS6ssnYr6169qD7BK1LjZeRv+NTyqGbBdPIw3C9NzLlFTe9D7
 o+MFqhjqEgdMEQUdEX36gnWrRD2m21w9aAoJ7F2dKy9fpqZ5Ojfo/tnI01apQHz+KmA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=CCfVbyoU; 
 arc=none smtp.remote-ip=185.70.43.21
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.70.43.21;
 helo=mail-4321.protonmail.ch; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=CCfVbyoU
Received: from mail-4321.protonmail.ch (mail-4321.protonmail.ch [185.70.43.21])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 888FF40B6F
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1790976574; x=1791235774;
 bh=PeHQ0aC8cgJSadACPyWTG7NJSB8Is9JjjmCIzMaDbyY=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=CCfVbyoUzzTsNwyO1j4fwMnWgG6qEJ91OCT5OxT1p4wvF7XqzR3sjyHWt+PctTZD+
 VwvcqRd9sx36pB/mXsWyWCizuPg95wKt/WkkekxtMXBa3uaEv9qP/n3zSC7RzNiyOn
 xhjDZpawxo2wxJ5aeL4sZopQFHfN1frmfMclJasCg3F1E2JUhD/5RIPNiV98/xrCQn
 V7nLEi4+Ltg2ikiXRIjuQHHHwk73wPZ+UUhAAdPWGbqWZ7sw+vkWsJpqdWcdk+yTeM
 GfAQ1SEifFPQyJnCw+maivN1P1SMc9J8uixetBxO5WpXN4mlWoBK/W7htAbXDmxfBC
 v195b4LvpTRGQ==
Date: Fri, 02 Oct 2026 21:29:27 +0000
To: u-boot@lists.u-boot-project.org
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: Huan Zhou <pericycle.cc@gmail.com>, Eric Chung <eric.chung@riscstar.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, Yixun Lan <dlan@kernel.org>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io
Subject: [PATCH 1/3] mmc: k1: handle a missing max-frequency and
 clk_set_rate()'s return value
Message-ID: <ef56cc2cf2361bea7bdb478b253f9cf3a1cb6ea3.1790975596.git.DaveWK225@protonmail.com>
In-Reply-To: <cover.1790975596.git.DaveWK225@protonmail.com>
References: <cover.1790975596.git.DaveWK225@protonmail.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: 95e8c314ba01f7fd921c1cbd6f55aa86317813af
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 02 Oct 2026 21:35:15 +0000
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
---
 drivers/mmc/spacemit_sdhci.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/spacemit_sdhci.c b/drivers/mmc/spacemit_sdhci.c
index f5578f38bd..bbd49b76c6 100644
--- a/drivers/mmc/spacemit_sdhci.c
+++ b/drivers/mmc/spacemit_sdhci.c
@@ -606,10 +606,28 @@ static int spacemit_sdhci_probe(struct udevice *dev)
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
+=09=09long rate =3D clk_set_rate(&clk, plat->cfg.f_max);
+
+=09=09if (rate < 0) {
+=09=09=09ret =3D rate;
+=09=09=09log_err("Failed to set io clk: %d\n", ret);
+=09=09=09goto err_reset;
+=09=09}
+=09} else {
+=09=09plat->cfg.f_max =3D clk_get_rate(&clk);
+=09=09if (IS_ERR_VALUE(plat->cfg.f_max) || !plat->cfg.f_max) {
+=09=09=09ret =3D -EINVAL;
+=09=09=09log_err("No max-frequency and no io clk rate\n");
+=09=09=09goto err_reset;
+=09=09}
 =09}
=20
 =09/* Set quirks */
--=20
2.55.0


