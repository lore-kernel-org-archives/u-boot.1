Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7BE1C88E5C
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 09:37:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 02A864046D;
	Wed, 16 Sep 2026 09:37:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5Sd1dU5Vg_UE; Wed, 16 Sep 2026 09:37:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 494014035C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789551462;
	b=gKbhLgyW0wLt9Blp5mfygdiKBR8G1Ped5YNsWbMU5BFORrkKbBmkUtTHw6XbwGH6/xAK
	 ZaajpyUblcluvNFs/Hi+t9yI9L7aVh/+cmwW5cn/vV0HEE4zshgYz3FKaihoZ1eSbcuKb
	 VL10KYMV5oPWY7RUI8HUx4FNwp9uJjAr96Uibp88lrFtkWVHWFXqV26hh1Mym7+gBzRba
	 v1FpT5SYDitgNjDxivQvPJtS3KfaBq+PzcLJm9h0PKx0QSgHKX2IrbseIzc+XADPTjjwh
	 Mw6uC/z7ni6chRYEgUfymi6yxlb1i1MklmVF+U+q0APRFmdO/NUjwo8L9Ru379oigcA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789551462;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=0LnAcxOmzhh8cikNUoNXaMHMHLsuXANh4B1Ydb94IoU=;
	b=V6AZ7RYbPKEUDczIetzWfczaxnwoJf+bND7Qw0T02EXfCKWN/xExZGEpJnUG2K7fPSX3
	 LpHKDodp04Bf3+8WnGDdV404a8S+5h86JrDp1ufWmXScPrWdI6xrCPtGg6Mme0Pio73V0
	 JrceyQ8KGMwaoy50uNJ1G5r9HxWA3ifgbq1L1vf0hAtlQ0q4Ckedj2qAj111UTa7KIX2M
	 PMkQYQcZLXWOcK7JCHnlgZ/Tz3+2dYTsH4OTGqQopQ3WUwBo+D8YfEMgvZYpPoA4HbonJ
	 i+yXHefQZmN1jiJrPUQL7F0UoC9arxbWdN/LMqu30T0taj5dU5chuyKl6ilihuoj8qQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UNENyO2X;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789551462;
	bh=0LnAcxOmzhh8cikNUoNXaMHMHLsuXANh4B1Ydb94IoU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w30yr8k9RghJtft11t/jjMNSbyis229fejMbmFFjXX3tntxrG+wwTVCfT7Ohr5+PB
	 zZQOqbMrNkiQBna2zktoo0Zri//N/xl05BlsXthel4l67Rh48I+7tYCy0SpvU20Sdg
	 a6hb+V4EjgwFrI5WKmUgl20IBektGFqRtIZ7zILdBcNXkm+VpzV7HVnoHrBXUUMoGC
	 klLVqicR89xcJpFNZ3gv3oxDePlZRsSI6XZy5I5OTF3jEVhTX+WmkoOQXoOI3/rMXk
	 Mr22Q6suN2i1MQ+zyUWlbctBP3r0kntJr9CaI3Yb375hQEtm1ira0VwMwOgbWo8GSV
	 WErGj4F0WNjeQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 494014035C;
	Wed, 16 Sep 2026 09:37:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DA14129B
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 09:37:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D7CB64035C
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 09:37:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ScSOUjXbC7Td for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 09:37:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 44F8D40345
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789551460;
 b=O/ljFVy5EmUJXh8M3q2ikNplTMQNEskMNJ3MLilhbDktyEqLVoVbrsGD4DvWaHuUG10y
 Vickt85EKP+M/DvakiEAnX25HHxyGoGKWGbP+wBDtDd/Io7jzKASP2mKZh7XoXUKPMd17
 3a+xCWQDMy9GSCaKtexFRkRiKoWt9SGgnjy5v/6dqQsfUldVFPoIOyt8dhNk+vDww0fN9
 E3+xHKNbKdI1yNQ0WGhgl8qgRA1jPP2Tdqg3eJJM1r8xHxOqbXuY6WNxDhxhKrbaWeynG
 PjSOalXEoAaRstTNWEL9U5jgHAdBm7eBqj+r+bXtP05jRMGRGRdUbz8oDP1QYAc3gSw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789551460;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=0LnAcxOmzhh8cikNUoNXaMHMHLsuXANh4B1Ydb94IoU=;
 b=i8iJKd1buFlCissEVH4GmCP2koPMAG9CqQwDd/KiF4eCMeKoOA4A7u/PwEUa4HlJ1P3b
 enBm/AxpSlhT4Ki9E2oJp8DD2ns+UXIxd3z/ZJ7Fds8ds4FJhlnUQn2pQSz2Fc47roaS6
 tgrm98mFpwr80V10bsneRzZuEIcqOgdc0ZxrK9q1CmQoW5xPBIuvMqFLgSJICM1gpozhv
 WgDQjwlz7TM5vIn2uu2w+VTj98RGTz601xUfsPncrJlQ3i9safgMI4s90BLrFVs+x2MBR
 A+DQxFWRZ5M5ZENy0Ne2cOGb79/88pdDEfXs8ISUzad0RVE+k750D0rv32AzfP70ESQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=UNENyO2X; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=UNENyO2X
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 44F8D40345
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 09:37:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 853C2413B5;
 Wed, 16 Sep 2026 09:37:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAAB71F000FF;
 Wed, 16 Sep 2026 09:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789551459;
 bh=0LnAcxOmzhh8cikNUoNXaMHMHLsuXANh4B1Ydb94IoU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=UNENyO2XtOf5W9oRs/WO1RmjImUVzCSyJD7HPEhTkbAnmklau5Gw42OaeKEfB78KW
 QBaIjOJ3GpJEAHSDLEr2iYdz0TYk5UzkAW9QRrhEVU1CFz3rRh9kPv0rP9JvgznQlW
 0kChTArqzuj+mzzOxiPyvh+lUmBPnP3/b3QpwzP4pCKvFA4MKNLkeXXcLxkWHQ9m2B
 MAGRfsi7nOjZPgPLiyRiAaymHvjKXca2n95Xjln1KLN5Mz5eLozEn5FDCsdYtRK1DC
 6LsggbTePwIpAf6YimTahv7mUxxJPMGk5HKaaXbOmJpuy9KfY6UbmuDRm9jSZ4qr8R
 UtPTdTV66Hh4g==
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 11:37:33 +0200
Subject: [PATCH 1/8] mmc: arm_pl180: Configure Ux500 signal direction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-mmc-pl180-improvements-v1-1-5d7670c3bb32@kernel.org>
References: <20260916-mmc-pl180-improvements-v1-0-5d7670c3bb32@kernel.org>
In-Reply-To: <20260916-mmc-pl180-improvements-v1-0-5d7670c3bb32@kernel.org>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Cc: Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
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

The Ux500 MMCI variant can control external level-shifter signal
directions through the power register. Parse the standard ST MMCI
device tree properties and set the corresponding direction and
feedback-clock bits.

This is required by the external SD card slot on Samsung Janice, where
commands cannot reach the card unless the direction controls are set.

Reviewed-by: Stephan Gerhold <stephan.gerhold@linaro.org>
Acked-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/mmc/arm_pl180_mmci.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mmc/arm_pl180_mmci.c b/drivers/mmc/arm_pl180_mmci.c
index f00b0ff0dc95..af21b814641e 100644
--- a/drivers/mmc/arm_pl180_mmci.c
+++ b/drivers/mmc/arm_pl180_mmci.c
@@ -427,6 +427,19 @@ static int arm_pl180_mmc_probe(struct udevice *dev)
 		host->version2 = false; /* ARM variant */
 	}
 
+	if (dev_read_bool(dev, "st,sig-dir-dat0"))
+		host->pwr_init |= SDI_PWR_DAT0DIREN;
+	if (dev_read_bool(dev, "st,sig-dir-dat2"))
+		host->pwr_init |= SDI_PWR_DAT2DIREN;
+	if (dev_read_bool(dev, "st,sig-dir-dat31"))
+		host->pwr_init |= SDI_PWR_DAT31DIREN;
+	if (dev_read_bool(dev, "st,sig-dir-dat74"))
+		host->pwr_init |= SDI_PWR_DAT74DIREN;
+	if (dev_read_bool(dev, "st,sig-dir-cmd"))
+		host->pwr_init |= SDI_PWR_CMDDIREN;
+	if (dev_read_bool(dev, "st,sig-pin-fbclk"))
+		host->pwr_init |= SDI_PWR_FBCLKEN;
+
 	gpio_request_by_name(dev, "cd-gpios", 0, &host->cd_gpio, GPIOD_IS_IN);
 
 	ret = mmc_of_parse(dev, cfg);

-- 
2.55.0

