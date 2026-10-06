Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB2ACA5FFC
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 21:48:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 50D6140808;
	Tue,  6 Oct 2026 21:48:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o3gNmgF5lTIG; Tue,  6 Oct 2026 21:48:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4CA0F406C3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791323307;
	b=tIdmdOddkHNzcv0ViYyQ2ajaPvdd891Vc0hh/tyzKKDGMeMdBhY5J/lZgDJ3pIC3kC1N
	 hqYChpBL2MF1PDvpBUeye7Z1OoefnM0xe36HMubAEwk6H1JrzobTbAp8ZUjTabKJPJ/uD
	 NBjmsLa5/B7tHXlq63uTSDLBm5QRpy+vsf6FCDw6F8/tcSRVHvzIm3wouZL8LoepFFCvL
	 SyKQ7Ne3+3KZv5mleCjYAUgLfl5PrSY4iwoKrnU1Ua/m6FmNnst8KXu2ozmPcG/325e8L
	 L6frhsIatn3R/bTkjunHj15a538B6377RbpHIhzGI2guzVM71YGJKxbNN6sVEto/s6Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791323307;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fS+19SAa69QNshDWv3XzomjCGlzhgn0pAuo9j/AZxIk=;
	b=jnpe2djdlM+smtfGrHyQ+0J7msLx5RFQilo/JWySn/wOrbi9xaEO3crc5KI+sCGeQ0kO
	 geZeIRHt9IoTCOT4p4uTGyYxeKPhaTm7hy2OgQfYPHqFnhkboTjxBG0UoLbOB7hikQhCj
	 GzHp1LGgEXUbGMDKuaBgkTVBiEwicF4YfWkIQjTokfiv3WpVyDPOoKxnUj6QLJmtS8H+/
	 xzBiaDUIlj1rLvD6d2VA5HHl19u9wDSN5QfQcxCXRc7ASc4BZON8DFloaezKe8ocUWrI7
	 QcTjYxNvcPqsMwaOwS3gVH3Qe/Pl0ytZz67NxJf+ZR7SHI6p8m58TBebtu23R02sA0A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791323307;
	bh=fS+19SAa69QNshDWv3XzomjCGlzhgn0pAuo9j/AZxIk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qru594IYWFBW8SNil1pHwQHWCc49+M8A8zg0Fbtn6k3L3sESm8kNx4y8aVIfAlgFu
	 rEgRbM0jwcF6mkKuXUkkjcunZFJz7X6awpHGmxTFOHXWp1ZOFBk2rQeuGwlf2OaA5x
	 RCdQ4IVVTRs/Nt0LTOzaTVl76KEFnMPxW9hK+z2hWgNeHZJhq00knF8WtbAZbCHgVY
	 vbIN5xzPNPoSoavlE1aYYoMeuKbfj/fYLTgIYUsrksn08O1gqF38VcHC2/udZjWqe7
	 UFZUZrGmENIcyomn5T3krHs0JsCJ4UjPkEN+U+BfB0eOQis3talomTSrvpM4Cuo+6u
	 pvDQ5pICMC2cA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4CA0F406C3;
	Tue,  6 Oct 2026 21:48:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 855E432F
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 21:37:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 76D7F402D6
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 21:37:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fEJMPTPPMgBu for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 21:37:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org B310140210
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791322647;
 b=FKEHN3JI6H4Q0RjCop4tGhanm4n2Rmnu/V6DEK1ILwYyBREfDFuplZY/Adqn/kveOi+/
 osO7OcAs7wLuHCuEp8O40XRwy3btppGe72zI4zzdbYdMpsAUI0u6Ek63jkVrL8Hcx7rbp
 +jiwbaigTBBO3MpH2XFuMN7S0px4kOF53zgMr0tfHB5x1SIYJHPjYk651TKM/H0+NvZTF
 SHroQ6UacdvrIOccVJM21A6mjnRATtghE4DO53zRpcgPxSYt/4fK7g3HtZb91OgYAk/Ye
 cXZ1PltCEz3vA2wMo8I/L7iwqA3N/yJ7XbtOlkBUWfeHhaFH99Sm1wKCoqC0FKp3uqA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791322647;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=fS+19SAa69QNshDWv3XzomjCGlzhgn0pAuo9j/AZxIk=;
 b=gjaALACagN+1cBBcIxyubEUBR8RJivsCGzNOFbUUeHJguLMqkNRSzHmENkkK6pHheTkv
 NKQL81fAywZKa1qbSwWmBVg7nvh4iU34k2OpqP49Uj45lyIKojjuRQv20/kL7HOyqBS3+
 NtWLZkfEXqiA9ba8ZUkLTA2gmz0YMB/jre19nBk46/IA/5Kwv7yabzHpwZsx1/U/bJnco
 5QJXCuHeIXkEUS6HP6AJPfQZsO4ucaislesH4sq3VFNboS6ngwYdg/yQJd34wYO0J+6ZT
 w4rZ3WJ39A14TM+/2j0QqvWwW6XR9ARN0IlESVVEQkOyDvLOzXOKbo5nT7Cr+XAk/Rw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=FMk215x6; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22e; helo=mail-oi1-x22e.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=FMk215x6
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B310140210
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 21:37:27 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-4daba36229cso615957b6e.2
 for <u-boot@lists.u-boot-project.org>; Tue, 06 Oct 2026 14:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791322646; x=1791927446;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fS+19SAa69QNshDWv3XzomjCGlzhgn0pAuo9j/AZxIk=;
 b=FMk215x6q6H7/zlveAhhK2XUNzXfTdtaI52OWBhiLHIpyxWAsY3xS4YzCZ7dNWAaMO
 R5wIiDSQzVJZbTgaQPzyHC2+uZG0BEVxABla4cNCFL9l7EzL21EtQADdk9NuP1T5k9k0
 46IO9buhSQ6b3+1DzCQtY4foVyFg+aikhfqR0QB/kfFJwwt5Pnk/maMY5DXiEXDpaZRo
 28clSOY5EJ1DJ2BY8mKy7j7lsg+Pqpt0gPVX0zxlLEuCntq1jQivx6/MlEGb2vyPbgyj
 jrq42qsWw8Oza0bKatiug2OpeXYTqmmeEB8vgBZmLsHKVzxX39nYo+ZknsK79ykCalSK
 MEKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791322646; x=1791927446;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fS+19SAa69QNshDWv3XzomjCGlzhgn0pAuo9j/AZxIk=;
 b=svk95MeiPfYcPmPSfD0Zd+2B7iIK4LDp9Q0pfuZg6G7pAEIiz4hKdAwfDVhwBHZNGA
 lHH2/MEh+enl8CDqtacX8scHxOsnPBWWcbX3t7um7eBI0JTxjkpjXb72qjSDXbOqsQub
 bUtI7r3ATCW9t27Lrw1ZKsQtheSrlkiioo8DkMjMPez73KEzlEWx6j812192lZdJUhk3
 QgxDKLLFVx5hv6L/qO3Jgj1UZHkNPf1nI+t5ZBTJ/1pJhEYbK5hqwBrhfzlBrVAr+skg
 NTFiYEpN9EH30iFSDyWl/jL+hKwhaXCe3DrBlMfxrkzSoFo9o+zMBqiBxl0oHBAaf6FW
 sanA==
X-Gm-Message-State: AFuF++koXuqHs/vZzbUKK9cFfhdIWUvXJVg+QzpzzHvNcQCPcY8ggjvY
 mG9VS710bjrDOO6qsG/2NVQM3QMsyFOgPBpDYPlAOAMXFROPwbqqnP9/se/f4Ek/kpo=
X-Gm-Gg: AYBFou3GCmnItx8IvJhRWgTbz6g3cXiL4VHqvyj72b/x8IoqZNV/dBXLvL9PIuapoAe
 0oKWL6xwMUU+c92Bg4tiMAvO2nSO0VDqw+AqwyzN3a1G8GTpqoOg9qHCaXnjNBk9iAqXwXobTwZ
 mkbUnXYoqzPmg2YABKY0ivF90Vqun+SzTp3kV2p+Qw+MhK1epvos1dnsJykUTOwWbUnJ/YeDUi2
 47fGNfi+0my6HNV5VLT8bsdgOZNC2ZLUPCqYe6x4Wp192lfsZN0kdffELRuxAVbm/meSUjF6qs1
 EXxAighlpTqtlaNfUrjDI9+VAjCFeMbeKpM+ETu51/rdf19wQGe4vQvGdxjrkSytAj7vkaRa91l
 aEKoG6N57psVNlzzT3Op4P/i8+Flb2GbcRNMD6J5aXmpd0KPYb6PV8u5FWc1/iqLVkSNwG8vySz
 AI9XIBdBBEF6uHe0GeRnCyE+n0m8LXp6AhfVg+5ct7YRB6DIALypCkXfGGmafYa/V92RdufK85f
 g==
X-Received: by 2002:a05:6808:f8c:b0:4bc:2295:1687 with SMTP id
 5614622812f47-4fc4636e7acmr564201b6e.40.1791322646381; 
 Tue, 06 Oct 2026 14:37:26 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:372:3180:ce34:1fe7])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4fc4953f89fsm389386b6e.12.2026.10.06.14.37.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 14:37:25 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 06 Oct 2026 16:36:15 -0500
Subject: [PATCH 3/8] video: panel-startek-kd070fhfid078: support a separate
 VDDP supply
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-mtk-genio-720-dsi-v1-3-7fa10e9c4506@baylibre.com>
References: <20261006-mtk-genio-720-dsi-v1-0-7fa10e9c4506@baylibre.com>
In-Reply-To: <20261006-mtk-genio-720-dsi-v1-0-7fa10e9c4506@baylibre.com>
To: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3967; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=BiTF3GHgXRwlnZmD/i8FIOz4rpq6YWR5Y31YD2TwfoE=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqxWnjjpu5U1D6H2VscE6mT6+JxDugSSm4j9HS3
 gYm1wd+atOJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCasVp4xYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AT0AH/3yiPY2DENhcXqTtJ9EjfUrzm0qKMYLpktO5Wr2
 0Pu18ARJjWLNoVEsQMrBu1leMTqtutXDbCwpMlztu/CFqb3FQibO34YE1nSDIVsm80xvRQPf7qf
 tM94y6FR2syzyWEijjhW9tpEB0Ru9sdjwaepZXjPNVN9VPA1m0L+nrJScGukjEZhAOKVgMY6Riv
 y4xtlYlK9uhVslhe5obeOxiJUVITeJERiwz26MvVIOSYW/gjFGrPq4MXaJmHkLq/dZxK52jLSm3
 /1WURRnBetZaZdY9qmuAVgCr8kKd4MC2TMFfO5GRUcMDCEf0yudXBf/Ig2RHi3mB5eGBFR7zIdI
 r/cY=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Add an optional vddp-supply, and power VDDP and IOVCC up before VDD,
with a 10 ms wait in between.

The panel has three supplies: IOVCC (1.8 V logic), VDDP (the input of
its DC-DC converter) and VDD (backlight power). The Genio 520 and 720
EVKs switch VDDP from its own GPIO, separately from VDD and IOVCC.
vddp-supply stays optional so that older device trees without it keep
working.

The panel's power-on sequence requires VDDP and IOVCC to be on at least
1 ms before DCDC_EN, which is what the enable GPIO drives on these
boards. VDD is not part of that sequence, so enable it after the other
two.

On the Genio 360 EVK, whose supplies all point at the same regulator,
the new order changes nothing: the later regulator_enable() calls only
take a reference. The new wait makes power-up 10 ms longer.

Note that the upstream Linux himax-hx8279 driver instead enables all of
its supplies together.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/video/panel-startek-kd070fhfid078.c | 52 +++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 10 deletions(-)

diff --git a/drivers/video/panel-startek-kd070fhfid078.c b/drivers/video/panel-startek-kd070fhfid078.c
index 12bf04e9912..be85bbbef62 100644
--- a/drivers/video/panel-startek-kd070fhfid078.c
+++ b/drivers/video/panel-startek-kd070fhfid078.c
@@ -90,6 +90,7 @@ struct stk078_panel {
 	struct mipi_dsi_device *dsi;
 	struct udevice *iovcc;
 	struct udevice *vdd;
+	struct udevice *vddp;
 	struct udevice *backlight;
 };
 
@@ -219,16 +220,32 @@ static int stk078_panel_enable_backlight(struct udevice *dev)
 		dm_gpio_set_value(stk->enable_gpio, 0);
 	mdelay(10);
 
-	ret = regulator_enable(stk->vdd);
-	if (ret < 0) {
-		dev_err(dev, "enable vdd failed: %d\n", ret);
-		goto out_detach;
+	/*
+	 * VDDP and IOVCC must both be up at least 1 ms before DCDC_EN (the
+	 * enable GPIO). VDD only powers the backlight, so it comes last.
+	 * Boards that switch VDD and IOVCC from a single regulator simply see
+	 * the second regulator_enable() as a reference count.
+	 */
+	if (stk->vddp) {
+		ret = regulator_enable(stk->vddp);
+		if (ret < 0) {
+			dev_err(dev, "enable vddp failed: %d\n", ret);
+			goto out_detach;
+		}
 	}
 
 	ret = regulator_enable(stk->iovcc);
 	if (ret < 0) {
 		dev_err(dev, "enable iovcc failed: %d\n", ret);
-		goto out_vdd;
+		goto out_vddp;
+	}
+
+	mdelay(10);
+
+	ret = regulator_enable(stk->vdd);
+	if (ret < 0) {
+		dev_err(dev, "enable vdd failed: %d\n", ret);
+		goto out_iovcc;
 	}
 
 	mdelay(15);
@@ -241,25 +258,28 @@ static int stk078_panel_enable_backlight(struct udevice *dev)
 	ret = stk078_panel_init(stk);
 	if (ret < 0) {
 		dev_err(dev, "panel init sequence failed: %d\n", ret);
-		goto out_iovcc;
+		goto out_vdd;
 	}
 
 	ret = backlight_enable(stk->backlight);
 	if (ret < 0) {
 		dev_err(dev, "enable backlight failed: %d\n", ret);
-		goto out_iovcc;
+		goto out_vdd;
 	}
 
 	return 0;
 
-out_iovcc:
+out_vdd:
 	dm_gpio_set_value(stk->reset_gpio, 0);
 	udelay(100);
 	if (stk->enable_gpio)
 		dm_gpio_set_value(stk->enable_gpio, 0);
-	regulator_disable(stk->iovcc);
-out_vdd:
 	regulator_disable(stk->vdd);
+out_iovcc:
+	regulator_disable(stk->iovcc);
+out_vddp:
+	if (stk->vddp)
+		regulator_disable(stk->vddp);
 out_detach:
 	mipi_dsi_detach(dsi);
 
@@ -283,6 +303,18 @@ static int stk078_panel_add(struct udevice *dev)
 		return ret;
 	}
 
+	/*
+	 * vddp-supply is optional only for compatibility with device trees
+	 * that predate it.
+	 */
+	ret = device_get_supply_regulator(dev, "vddp-supply", &stk->vddp);
+	if (ret == -ENOENT) {
+		stk->vddp = NULL;
+	} else if (ret) {
+		dev_err(dev, "Failed to get vddp regulator: %d\n", ret);
+		return ret;
+	}
+
 	stk->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_IS_OUT);
 	if (IS_ERR(stk->reset_gpio)) {
 		ret = PTR_ERR(stk->reset_gpio);

-- 
2.53.0

