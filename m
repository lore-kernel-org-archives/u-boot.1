Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CD3606A33B
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 09:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FpkyKCZF;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=QLHdj8F1
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 673034073C;
	Wed, 21 Oct 2026 09:37:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aPRaWFS_JlIX; Wed, 21 Oct 2026 09:37:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AC5784075F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792575475;
	b=QPFv85zjI1zd6uGEAhaB6OD5w6bhlMsokGx/CVWiCk/yEre+IkSdstvgwZyOfyazrFkZ
	 FRmuDzL4ReRrMk8i+08HuuaURYWmB/ZcBBRXBtAeMuVGgRllmaINiOMCibHe0RE/8346h
	 KlXSafQEcdqbgsq/+nsgP0c8sJlWnjMZUTlW1FAwrb3v16I7s7AlNG8xVj/VilgKAj++/
	 9fUVSgSHcN5LKewqnN4CiA0OQa/rqau3cYoRGGBhtwo779nUT/BwbMtpI5We1NV8Arn/I
	 hpshcSvo0kJus1hsez+ksT1q/hA2omvqhZKqZNepecUN0aXLgNEebeF3vjWzAjs84BA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792575475;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=D5koTWQSvwgNGfwuaTaRV2hRYmYvHRgWxXbC5qaaae8=;
	b=hlwsdF5nb48ngJyPMPFWJ76fmrT/6H9DTZFLinH5ISt0rczdICkoqdfB3U2FjNXifBCc
	 Dn7Em0h2JBR+7dfp5g7Njie77ZwN1LRdOVELv7NM7DqPt1cojyixVpwiVvsECwFZkWvdV
	 PfzLCI+5rKH5QoB6rb0whYZhVw/uYerHtEuFBkpLSkYAKSv4WJbsE7htuwEIEJBOG3U3+
	 kCMo+DYTNtHdog4yBAwfxBmmIKsOawTmjRemAV6UhgSocrJENXLpP4pFeeOzsE287CGAk
	 q9IpaF55UhlzZVdOM0I3grFfxPV0FMa0J6J93fSEuUojfkd0ehmzBlWlmy0OOp6DE3Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=QLHdj8F1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792575475;
	bh=D5koTWQSvwgNGfwuaTaRV2hRYmYvHRgWxXbC5qaaae8=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FpkyKCZFFCsdnY793AirCS0ZU8jGnc0OJZa0AytcP3nZbVjNPSM50JwsJ0bJogMbu
	 6kbVdRf6bHK700+zU711keTz4NooOwXOz9hNZ8pWgC7dP4Z/oakJJ6jKLjMaA5RorQ
	 zaBWoy7z//X+R9LbCv9IfHVfW3mJpXK0E6HdjAjpjRC5zESASrEvOIOXddTd4rjoGV
	 9cP854jf1unw8a5PUj7/ihxry8h4p15Lgxn8tRikiDWyA55H/uBu2n4HQYCNzOk1yS
	 Oq6m99BO2OqudKu5rXaGE1+qhV8DvWht/5q46NS/EkMdr/vVzmQehP55QmQWb6JVuU
	 xiSsTZYvkV1Qw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC5784075F;
	Wed, 21 Oct 2026 09:37:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A7FEF2A8
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:37:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 99AAB4073C
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:37:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ek-s0hacTG2e for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 09:37:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E5C384076D
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792575473;
 b=Cd4DJL/cR828Ng8Lvf5cOQEJ5FVLKZXPWQ7lB4kM77YzsDC6efcSiq+aWHQpTlGIq6P4
 7g7oMpsfJCO10zLICMzMK3SpdVbCqgEDdopPSjfG/e1Uwdt4SEaqhTT9NxQcDn4jXTQEm
 aBP1xYkMhTylPaJoU3weN0DzE0MrP0n3r97XbY7W6LM3C8GN18Pii88sfnHd7mAK+O0uE
 VTllBv6ymt3RwI/NBQJ4t/fxVcfvTwogoaedC0k/uVN970NQLOrjC+LhNSVTBcFUaU21B
 aFcHtQk1FQNenV8n0Nlc69Jd5MciPb93iHLni4mpAyeEGhJ7pgrcCKprPqwFD/EOFrg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792575473;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=D5koTWQSvwgNGfwuaTaRV2hRYmYvHRgWxXbC5qaaae8=;
 b=hhvGhlKwnyk7FqxRPwZO8xC+lLUS6gff4kIXtmkUJiOZZ1UAxJdkJMmWfkCpDHyDjRGM
 gzzn2WBgqLwY5ebDSgHjPF2wB7TGC8N6uprag63eGL8a7dT6fdLSLkmfNvbAkDAM8/GV0
 3I0W4j2wHQQA23BbjIVS1d1aU7ZpCa+uxpl7enan0b1R/bt6cwMetnY4PQgfgYBZS33s5
 da+d5OZIqqf6RGK1e6iXWCHAVdedyU93ButEN9E/WgYCH3zjFG3THeBddviEVuQph8IWX
 +0ZVIhaTAoSw6B8DR12X7AtYmkZGRz8RE/HXh1Owx/TVHOobeEitzy0/2wkoobbEdkg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=QLHdj8F1; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=QLHdj8F1
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E5C384076D
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:37:50 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso4023545e9.3
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792575468; x=1793180268;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=D5koTWQSvwgNGfwuaTaRV2hRYmYvHRgWxXbC5qaaae8=;
 b=QLHdj8F1FnJ5rJ+M79W+k4z/I7pwz4wioa1OQV8Qc19lMGqUOfCHRTK5zf81ZzLXKG
 26Ff7XXBjNA8XtmHTwAunAhlA05IHnXpbma8ErTdkf9A6x3Ia/SjG8ZoqfhamOCMaI5R
 50yhgETFb55VqemYY1wodzHTSSKfspmMPmt+xXCRCc0nlDQo7h8wHHCtX7fwSZN8t27y
 ZS1IS5av25J/qQEFivECTxpIo+H9BbVDsYOwXCPiNsci26X/nLIW17e9rzb2s7v2VBtX
 OxBvOPCmxTfH7jfhOzsfyuLWvw4o0ddyd6gzBLaGqvZ5q4N2kF06XJoVrKCQJUX8dQyX
 D34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792575468; x=1793180268;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=D5koTWQSvwgNGfwuaTaRV2hRYmYvHRgWxXbC5qaaae8=;
 b=i3U9Yvwo6/zVilm51ERmlJJuNDrabGu3dYBoh8ZhcWmHNbzIgHB/NpTkdLaAp23Oyi
 +6vlT/kFIDxiqqXr79p9iEwwnxij/mmFVD9fLWnzEx5xnP6kWD0dHkho02781ZS5D+bO
 X8COon3i99eSm31qfEaFjlrFuUHmFBCPfV+EF4wnpHR8c9vHrl2bzZuHdWaUxV7RSE1k
 T+B+jxKbsOoqCHkecHyCf16dQR4mLxUzLYMbavhZmtUZg6YRj4McchpQNvyEazkibIk+
 vZzmvTWvRjThcb+DC5w4WRBvaUHE/D9CT6j+mV0apKYL0cDllkOkxnynCyIidtF4T38Y
 LnfA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz5PzFRYjc2H87t5ciWSBesA5UclXpubwnNNd1OCXPb7ErKIfCKL34pQr5w2o/Xc5AwY/+IJZQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJI71pSWHiU0zIP2ESGDAKlMujO0XoUIsGvH8ZTPhEd3OJK1e8h
 jieaxhvd62kM9PUkLELSPvIxsj3LtAy18ruZ5lm3khB1aD0zrOJWczFAlMArm44t4YktvrXHtC5
 A2B8L
X-Gm-Gg: AYBFou3EV79YktDCubTKB1iWG28U3CIWdjeMzKPVQPGabkYo351WpNYNAccxqLFecR0
 C6cNhoXT9t2ujE5a8DjZGMNE36w8JFmhSkXwGciyb6+hsS5OPZ8GrB0bpay2i4rvczJGz59Z/ew
 cOb4NFmKCEpKnmIbGm83dOtH/06cs6aQ2apnpi/Lnuw5ML10IFkKhHS87LqaPVT1TcAFvAVZBD+
 yiB76vfaIR2iuC8LhADtSqyTDzVqkxNgSSW/JHAuQjN8V6MU0JTNuZf1Cv/zP4aSSrvU6PRwUEU
 eqwU3nB97yg15IBzNwDDtP0NZbEwuhTkgs14q1AO8+pOsLW7lwKth+8zYEjmV2OXYeMBqYuaIrB
 0SeXi8NFgqvTBQ5+281E3zeljlQZ94ljPf862vufC25QN3rYM1/nWfWC9Sjiy94FlnKJnyyIAaU
 jFEyyJ2Hb9VtZw1fQMd/A6T3IIcRlWmjMKVtd3T2Sbh9BWl21O/BVWC7qhMs7mIylD92HlR1Upj
 fKgqxtKs8VOdVllayA0x861vP/8u6WZR0KWSxYEh0fBEiCRAoBf
X-Received: by 2002:a05:600c:b86:b0:4a1:83f0:7c8a with SMTP id
 5b1f17b1804b1-4a1fd8a68b1mr27900885e9.1.1792575468269; 
 Wed, 21 Oct 2026 02:37:48 -0700 (PDT)
Received: from localhost ([2001:4090:a244:81d0:2c16:1c4d:8a04:e0bf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fcd2eff9sm39207075e9.4.2026.10.21.02.37.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 02:37:47 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Wed, 21 Oct 2026 11:37:38 +0200
Subject: [PATCH] phy: ti-pipe3: Fix reading syscon register offset
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-v2027-01-next-topic-am45-ofupstream-ti-pipe3-phy-args-v1-1-0570d8b7861c@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAOGH2GoC/yXNQQ6CMBCF4auQWTtJS7EkXsW4qGWAMaGdtIVgC
 He36u59m/cfkCkxZbg1ByTaOHMMFfrSgJ9dmAh5qIZWtVarVuNWV49KY6C9YInCHt3SXTGOq+S
 SyC1YGIWFDMr8RpemjM4aa1zXK+8HqN+SaOT9170//s7r80W+fGNwnh+LArxymQAAAA==
X-Change-ID: 20261021-v2027-01-next-topic-am45-ofupstream-ti-pipe3-phy-args-a6363a470ccd
To: Stefan Roese <stefan.roese@mailbox.org>, Peng Fan <peng.fan@nxp.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1213; i=msp@baylibre.com;
 h=from:subject:message-id; bh=JcK9wemicazycQ10c3ymwlnxbshmOLqYInWDjcAxTuA=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqwb7Y/1l9SnJs64s+R4aOkHpTNyTtM53oqtefY8wFeHP
 zHxVtL3jlIWBjEuBlkxRZbOxNC0//I7jyUvWrYZZg4rE8gQBi5OAZgIZwgjw/2151m23wzzu9Wi
 u3ja5shOpiVSkxes11pzIH317PlHFysz/Gb5LzjFm121on3ZlKinaV9cGHeyG8c7vDmhl8v2szj
 9EyMA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

get_reg() parses properties syscon-phy-power and syscon-pllreset.
In the binding these are defined with having one argument but the code
currently doesn't accept an argument and fails with an error.

Change cell_count to 1 to accept the offset.

Fixes: 6184a9b10670 ("phy: ti-pipe3: Use device API for DT parsing")
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 drivers/phy/ti-pipe3-phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/ti-pipe3-phy.c b/drivers/phy/ti-pipe3-phy.c
index 080016ba417d..08939af9e75d 100644
--- a/drivers/phy/ti-pipe3-phy.c
+++ b/drivers/phy/ti-pipe3-phy.c
@@ -450,7 +450,7 @@ static void *get_reg(struct udevice *dev, const char *name)
 		return NULL;
 	}
 
-	err = dev_read_phandle_with_args(dev, name, NULL, 0, 0, &phandle);
+	err = dev_read_phandle_with_args(dev, name, NULL, 1, 0, &phandle);
 	if (err) {
 		dev_err(dev, "parse %s failed: %d\n", name, err);
 		return NULL;

---
base-commit: 8d534cec0cc0109a37c0ded8854da03f1526dc0e
change-id: 20261021-v2027-01-next-topic-am45-ofupstream-ti-pipe3-phy-args-a6363a470ccd

Best regards,
--  
Markus Schneider-Pargmann (TI) <msp@baylibre.com>

