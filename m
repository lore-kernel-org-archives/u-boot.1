Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC549606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 23:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=d9Okp2o7;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sdAYKPQT
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B5D6160611;
	Mon, 26 Oct 2026 23:46:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MinWRj-vpfrl; Mon, 26 Oct 2026 23:46:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 115FA6061D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793058415;
	b=MFbrm2Oq1WkTml9v3cRmcAtk/cJFGY+Dkfb6o+kTAy9+vqRCDWS099fM8ebT441WVO2J
	 GahbbVcow5A1RZD2w5RsIRjcjL5VN3WPGw0PY0YjJ976pZIdtcYAFpQ9eeUO8HkanpaWO
	 L4LvFdTI5C35Z5T8P+BsjXXJLJe9SJvoPAMnoZa9faWKlkmTxao2uugmyLYgbqs/RzkXe
	 YymPNcVOCRoJ3GiurHVyfk+CktsSZwthMDkid1zcKxJieossoyB9vjW3SvJMjdidDo2F9
	 WVdtc13NpA7+2fbF5FAbagzbI8aUwvpFSVYrPgIRqCw6fpm2pIuqHnSTbtZq8TDRT4Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793058415;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=3JbAPTy3aL6Zd4CyaCkOvd0Bmf0FvfYSApB0Pcfqsi0=;
	b=VscOR033R0dIf5X35io7+br5zC4GxoD/dDigpe0YEmEayCPo19Fo04pQRtz7YppAGGgF
	 hPFBxPXW5QpzesWzfKE0iCpyI8fAeZUB3At08mUzLqmObOUobrwT3cT6MD06VoNYdaWoz
	 3524rqU0F7eiaEk8+4uyw+yVSCT+yns1RX58cddebvMvhdAPVA1LGxJm9e8aBNi/CviA2
	 gzP+TjklNmg53O5KpZFoBReVRCZfxaJgQPRFTrTdGJ1XJOp+RkcPbqD9BzCRWw741tv5d
	 Rc2B/2bGKLn4XZsY38ZGOnl2Q9Oy8RIbmyLZED/k9ALnP1kh35i18VRYvaNQO0/fzPw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793058415;
	bh=3JbAPTy3aL6Zd4CyaCkOvd0Bmf0FvfYSApB0Pcfqsi0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d9Okp2o7GCwgKCnmRsj3YbJfIL7UnLuSOIsF8cubljPA29Axe8VVZ9/Hffanox/ez
	 FxiUAbLZQTNFhVEaWtiNlgd5eUzO7t3mdwaqBgQkvMYc0EwbNfc8g9aq5tsouSOFR6
	 538P3raf02Uhumz8LPKZBaEseL9/9ZImzOCWpUvO2+QeAjD38RGbB3aHInDyB0hZVx
	 VaGrxdiykLIsxoKsD0PpC7nCWuCtUnJihigApQ6m2x2dXTHFkmmX6I6wc9owYfv4O0
	 FgKl/MKE19aP5DdDdg/q5cMH9hzyKJDRM+RhjnWlNe0sb+4gBJLIV1Z5ZY5gnjMm8t
	 aMCn1n9eD90Rw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 115FA6061D;
	Mon, 26 Oct 2026 23:46:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CFCD92F5
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 23:46:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C147780BBE
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 23:46:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ruPrA1CkP6tc for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 23:46:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 063A280BBC
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c36"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793058407;
 b=h4p4gFYiIh1+WBPYCRvSBzStCrgK2xTGL7g9yVJa+E48dzrcW+5+ucbOK8vxSv4qP3GA
 oXNKqPn1X26MagZ4X5/0mh47VwWN7txt3YTyz7ay1iYYISWdHVqzK0+nx6Zliydjg3GEp
 ZdVgDzlX9Y+S/1dXeLNr5qUSZRcQFxxozBYmYJmBmIQEPARNAcQWYuEvEO4SA75qJ2p14
 MAPEtyoM7Z5Bglj/76dMpszv56HDuJlm2OYyOjJqXspSt5ZFjeKH1qM4eqaipmYYfPQWX
 uStt7KtjU/G563lzEVRePPRxRRMHndCr1wnwNf9hUVNWOVRy7fX3TazZFwFF7auCu2Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793058407;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=3JbAPTy3aL6Zd4CyaCkOvd0Bmf0FvfYSApB0Pcfqsi0=;
 b=BaIGCpjml1J7gs9DWh6/RyO1lObdmwnMgPJmgcRJQPmsYF2+LvKrnCjDlP+5xkkaW+zg
 X0fCtRIj+AbS8GnbpIDda3TByzigEiRpDWmJyDXz45bMfLPMt8W55Q8wXQNVnWZg9+bJH
 6qfyBlQ2Bq4D3Efb0vPDHnZjZ/VfTIhPlI9GooRH8oV5HpTQrWOvek04n55jDbgvk110z
 kcTFbH/j3y0Y6WMLVtVduMJLscczRoTC+2Wj5xCUAFlV25aRTxoGhy0gI9+c8RhYcD5kq
 nOlQnjUMQk4MQGNpE7qBp3FLAX5raudjbRxu8Eh1DeoVp8kurYgi8dBzfzJY7qGNEqQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=sdAYKPQT; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c36"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c36; helo=mail-oo1-xc36.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=sdAYKPQT
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 063A280BBC
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 23:46:46 +0000 (UTC)
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-70b875f6f13so2066080eaf.0
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793058405; x=1793663205;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3JbAPTy3aL6Zd4CyaCkOvd0Bmf0FvfYSApB0Pcfqsi0=;
 b=sdAYKPQTYzi7VyuPL2rL2XwP3RXXxbdoIyxycF6/2Zum/ZyKLS3+mL5aJRzDpvE5p5
 F+Cba7JI+rE6/XJOUYXvkFLZc1FShk8bdieixK9E9fOq1Hgk6qXIsBACiaEOzz76PIMu
 vVL83qMzGTuI1QXp/3UIHJOKhgjJnsMFXNJXSfIcXiEmrNtMJeMtQsPtWn+vhJHLRVBd
 MhylqiJsmTCicLnejbDtcOdb53Ic/wM0gqnjT1OaJ+PvzXkPZMFPnaVI4alF2KIwMzCw
 DEALwiFiTO6n7wNSos1RIddypzf/yqUTM8bBDAafxZP+9o6AzBpeW5MKt6rouYbE31zt
 2yKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793058405; x=1793663205;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3JbAPTy3aL6Zd4CyaCkOvd0Bmf0FvfYSApB0Pcfqsi0=;
 b=ejPN3CeqJqSP6J4T1gPEcVRKxZNLQ/Xx9rzdF11Wi3j/3ViRRG2zHKgcOpgSmG4W/q
 dnH0Zmd8VkERCvPWlNG/8HLM061UJCdR9B2sbkRwPsAlCAaSURtuXw5fWLxFsFIhuxd0
 6tFzyWsr3TRJKKOifc2vYggUdSROZYjiC0VB+3MFIA07n+qY+qf63HAZWSbwT0hPTiL4
 NWliB2oqzrTqqChtu7GmSk3PLAuwjJXWyVENRwHLfafPu9+urzhaCwF8ok7LJoOVWePy
 asQU6SfR9BXbfWLQnkK1OD1LepmRhHKBL/oM7j06QlXKjcNAnw75jJCBn1kaW4SzWp3n
 XAmw==
X-Gm-Message-State: AFq9FYIrX1mxafcuCAHYmb1fn2NjQAaKzhbFOZAglc9oyo//GdFoJe2q
 ROYO2TfwYEcHfrnzqZQg1LBb6ddLAQdnorHWeySfQTJG1G3DqYR8cinj
X-Gm-Gg: AYBFou2aGlmnX2NClBOk6No3ZdDRSkHPrAflR/wfqqvz6v/I3F/gMbbXyKHq8t6j4ZF
 RuZqGR7BirJLjuiiu6eYHAKNvEGN0YWqnr9GxnG0O5QM3fwPtpfVsZIRVC8rtHdYbFWGgws+aBP
 5r8U3rrvfUYJUCv13TawyVWA0NTHGrmT3BGLJPg9FOu+446DnfkZjf1ac9t63a7Bd8RvJ/XdS4e
 4p1kZbsUtTpiPio6C4pQfNPI7K1EIQ6uBEhJ25cbDbWgsha3GH6DlqaKazTr+SZwlN0xKADjtj7
 uRo/Hl0fCbujSuzabiLplcDE+MmwrAfeTrBg0OqYWH4fz/dGzep1140ygouI1vyS1zGjwhm1GK3
 lEZ7ZNJizoB/Is0BdjHUcxI00wV34kewgSQ+0nhNYTbXD1IR5VIKt3Aal6hNqor1Q+xkXea3t1x
 tn6nSoAlZuAlcoVjlxxa+UQcUeLjc/rAhD27FO794KmniNephCLGkFRMZ5gwkIiUPbX3u1pwHDX
 3b32pFsd4bVmb06K5L3JUI3zhBFBOWJoOFNqzLb+zBxzzLuHaumxsWmuSvz9D4i0fQjiq2+FpXT
 fmAGvBLcNVOrVcVE5ust/O4+edrau9qyE6+JzWD1lt9KCiTwSEAu7WXJ516YJJJoii4HnGG419b
 49YNibTETMDMLqYlD+QIeSejCUJXIr5qHLXWNTYSK0f0i64O0Fxkw6T2ivaaxbSw7AX5B3eFzO4
 dqi+A=
X-Received: by 2002:a05:6820:3387:20b0:6dd:4f30:258f with SMTP id
 006d021491bc7-70ba0e82ffemr3295889eaf.56.1793058405445; 
 Mon, 26 Oct 2026 16:46:45 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-850fc005bd7sm9509137a34.24.2026.10.26.16.46.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 16:46:45 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 26 Oct 2026 17:46:37 -0600
Subject: [PATCH 5/9] net: sun8i-emac: add H616 EMAC1 support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-submit-xpowers-acx00-ephy-mainline-v1-v1-5-e22389e4076b@gmail.com>
References: <20261026-submit-xpowers-acx00-ephy-mainline-v1-v1-0-e22389e4076b@gmail.com>
In-Reply-To: <20261026-submit-xpowers-acx00-ephy-mainline-v1-v1-0-e22389e4076b@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Pranav Tilak <pranav.vinaytilak@amd.com>, 
 Sean Anderson <seanga2@gmail.com>, Andre Przywara <andre.przywara@arm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 =?utf-8?q?Jo=C3=A3o_Loureiro?= <joaofl@gmail.com>, 
 Anshul Dalal <anshuld@ti.com>, kongchen <3305708832@qq.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Daniel Golle <daniel@makrotopia.org>, Peter Robinson <pbrobinson@gmail.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Lukas Schmid <lukas.schmid@netcube.li>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The H616 second Ethernet MAC uses the H6-family controller with
RMII support, but its syscon control register is at offset 0x34 rather
than the first MAC's offset.

Add the dedicated compatible and variant data so Linux-compatible
H616 EMAC1 nodes can bind.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/sun8i_emac.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/sun8i_emac.c b/drivers/net/sun8i_emac.c
index 29562e14e16..30e3553647f 100644
--- a/drivers/net/sun8i_emac.c
+++ b/drivers/net/sun8i_emac.c
@@ -918,6 +918,11 @@ static const struct emac_variant emac_variant_h6 = {
 	.support_rmii		= true,
 };
 
+static const struct emac_variant emac_variant_h616_emac1 = {
+	.syscon_offset		= 0x34,
+	.support_rmii		= true,
+};
+
 static const struct udevice_id sun8i_emac_eth_ids[] = {
 	{ .compatible = "allwinner,sun8i-a83t-emac",
 	  .data = (ulong)&emac_variant_a83t },
@@ -931,6 +936,8 @@ static const struct udevice_id sun8i_emac_eth_ids[] = {
 	  .data = (ulong)&emac_variant_a64 },
 	{ .compatible = "allwinner,sun50i-h6-emac",
 	  .data = (ulong)&emac_variant_h6 },
+	{ .compatible = "allwinner,sun50i-h616-emac1",
+	  .data = (ulong)&emac_variant_h616_emac1 },
 	{ }
 };
 

-- 
2.53.0

