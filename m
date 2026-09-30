Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D94CBCA5FB1
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 09:45:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6BFCD6085C;
	Wed, 30 Sep 2026 09:45:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mis0cUZOh_0O; Wed, 30 Sep 2026 09:45:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 62C986082E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790761521;
	b=F0fVFdq+tjNWMnBmBixjHO4PmzjYrCuGz9w4dqQen+LYkhuvLukssNspB1ivBRpTRZsY
	 FMkoPrVzpJ+UgznP5yzDbrg3MQQYr5LQU5FHIgDsBakemY0TN1ctIKvEwj/kjiwBqlF2T
	 0io1V8AfvZkelT/4EPLyqr50U7V334T9KTWVqF5t3JZp9+Bmiw55sscqevcRlUYd37Wly
	 k122PrCW50knj/g61f/QaVO4s6tfNgoQQ4PZ2UiFcS0IgLLfHgf6yuPmEaXikUX2WRw+S
	 zsEEE/kbvwkajrXJ0DtqiWK9JBrZQOT7HTqQaL0QfsTDaD7TJ+FmcGyCcVZzHiXFSqA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790761521;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=supoa2/tqEYpx7EGtDFlYGdPXvv5qVGZNr3CvoRBIlE=;
	b=TsryWIuxDP+RXw3q9iqiTqImyKzUBvi5ZwkveylqIv5rVoJMzhVlg6ZRrCacRcTrkH6Q
	 MPuA65Mq4xdkN0tabUX0APdmro1zgH7z9w6n8S/OHg2xIrV44uZvldxpYErshpGtjWS1u
	 3iMMwqnasKg2gqs/RI9dVwEkQCZVNZPhqb9j49BY61DPS/lYVTVAI2X+Y4vym8nTzs5nK
	 GNDVu0w/R+EF7ObLjyToDGu1Pj5Izt0hGL3QeQLmD3cZGdnO6eRus+RyoeqouYEt4b1FF
	 ArVRyzJcEBP/vnZyElmcx2bnRsReqQib5eCy3lgCELB4rofLSF3MYvVtn0Hd3nrZPJQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790761521;
	bh=supoa2/tqEYpx7EGtDFlYGdPXvv5qVGZNr3CvoRBIlE=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LQUpgnUR8eaC1HXfs6/VBl7hkZ8+vj6L7gznYGWtAHoq1JZh7Wzs2LY6nniArY9ZA
	 Fqf3lHaxIm/A/6cgFCFrTdeJEF+8BVLNgmbM3YH/87v5tZn3nyoeK8Ih1ohT9xRoaN
	 ZZHPCOdWElpd6SPRBA82WbNfvYaxNTvrT/NlpmEaoBCdnGYGJ623je2lN+PkSnGavH
	 obiQnZ87Di6rpgdDz8THMvbbGwrCTG0VuP6KY0yBKLGpaXhUlUaTxbZFtrUHsnKUjm
	 fn0GR+EA2oc0njkEFhng+1NXrjk248NRjVLJRg3yh4VQY9ROVT68jW+J9FKMavbox+
	 YpLeIOEQxMpyw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 62C986082E;
	Wed, 30 Sep 2026 09:45:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1EEBF380
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 09:45:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1C90A80FF9
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 09:45:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id obzbDoikiP7e for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 09:45:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2FF8F80C8F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790761519;
 b=JaAQd+nshC9e8rQhbIO2gbAqL/L1hDWY2k/drj3SAtgyLuYMqwZxXMGIHm4ILeV3/yeO
 Lf7e4+Afa10mmxCFp2UltGMYixcYAkwfGZCTQKEid4OgOu18eOQuWT0gn//YD2OUdd+uj
 uM8vx83gZMsatv4IdtGR/kI4laAOTCJh+wu9q6vz1TQtA786DWKrVFiDMgB+a7tXTSXYS
 dCnkUcXNSUkPBHZWTi/5OUBIDG4duVVr1njeS2/5S3B52n16W48USisp0gZOM7gG/iFst
 Z/WQ4IXRqTtwS6+YLpQ2GNP9oqkyD6sNI7Hrt4WgWK3BCe2rpjdsPKwKMboR2tIzDmg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790761519;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=supoa2/tqEYpx7EGtDFlYGdPXvv5qVGZNr3CvoRBIlE=;
 b=d7Zq7cxMboSn8UpwA8CBikhq78G7Rx/nntWNUmC5uKf0V3jjPl5Zwk55SvLzsHGqWq0h
 Ypft5nTUjZWPIub6piW8TX1pL1kW6pbHR2NuQzOknHiBTIaM1fT8Bx9J8rDTTQGvNZnm+
 4FyKU7zHZOxasOIgL/Swt85EMUZshsS0Fa8zp0SE//3ksSOaGshcwFhxN5UjcPLgwd8Q2
 oPrQxNqHUA/C3HzenQZvvNQ5KnbXqCLLZQsyRKj212U4uN9tUKHz+1BQqQ3NLFG72mG03
 Au1iHWWuhGgt+90UB31kGsoi8U+JpGZSrS7ceObTFkAgg7sBwtWxl6vNQ15nVlaObmw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=bGmXpZeN; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=bGmXpZeN
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2FF8F80C8F
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 09:45:17 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49ffe817151so21559755e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 02:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790761515; x=1791366315;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=supoa2/tqEYpx7EGtDFlYGdPXvv5qVGZNr3CvoRBIlE=;
 b=bGmXpZeNkXl/1L2TOcJc9GRF53TBVqMBek4Bj6nQK6xR0Zl5hDlOeymsfDyDw6xCpp
 ObNZcsB7K7S7kRmb+UpclWGa3FQxUf7jTbVqSkaKuP0C3EkOk03h2+RJ5yPmiVRTh7cL
 +Ac6A7It6PcKuFX/8sOnIOCS9QKpLtVKy3Wxt8D8pUFvbl4RUeaAOJKNrGHsKi35vZ6k
 473XPgPcSqgQSFKtomBczF5KRfvRWSMhIU6VHry5eVaH52NDakEON0aHCz/fTVRtjwS3
 zkt8zlI62LLnLHMfYjW08gXwejwr90MJYVXyCoKTS4mHyj1zkmwuyWGEcCbll5eJWsTh
 qxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790761515; x=1791366315;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=supoa2/tqEYpx7EGtDFlYGdPXvv5qVGZNr3CvoRBIlE=;
 b=ypLSW/iB3q9nMeETsBL2x3LlEbmBqVITiUOFpVFxJ4Z/vkCtmJZDCfowG8h0xAD/7p
 pKcd/qIW10oPHlp9HKV8ELMSy6WKOdR/NVb0YOnL4mrd8YZ7qep4nFaI0srzGuwnw5DG
 5No7kqOwwGnY3BuA/6T5XayAX5OD9oIrDy1RXt0cLwPhp4+eV54ji0Deuk0itdPEMRJz
 tCZ/wonEywOVtd1LX1iiaDMrQEi6lPOdT2yo6B3BEKNcekT3ojUuYs/pIlMNjkX1ZGGM
 G4aWSwncaGSAo9jWQEb9hOm5+rJzGYD2exroLSxJlI+uguTSqvsAtcBUtfxYgZ9QHTB3
 M4FA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxTSzaZNQi4o/L9VJSN1/ZvsDziQzEYo2n4jdu5Ej8HtrHX6A6U+UQRWzXkurO2ZsauUh73aUM=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++ntvkAccFeq9bvHhMKNCchEv5lRUf5w4zUPDsFiM9yAxsZwv6mp
 /smqZCua3yv3BtS4k7p3xVbSc/gPfV0TEvA4A+G1xdSNoYR9Z9l6LDqNLhvUMXuX/ks=
X-Gm-Gg: AYBFou0Vl7PINOH3vYZgQfIJiq9UrQAgA6EqGWqnzh0j1B1nR5pKuj4NzVxAUAGx351
 Ea5GxpuokasxKu/drFut9pcJny5LXfM3MYluu07nlv4QDxjUODzHnghMCfGxRYVuqDC/pvORsMY
 i4jIMkw68ys6ek231rsaBosqI8LoUlJtcPQvgmzAGhIEpD5H+W8bd9YR22tm7WDZkPqVd1XD6K1
 Ca/nbjjy0dfiBspSv2ZHCvciXOhskbOYYNkIqhTDBc1xeDhQcSu/q0B7it6tXIcFHkzE+UyPvku
 SVR+hP9oAYz6eQEtjvMBzee/16hgsVOKkj2LJkqAHrO8uKqYKjz/FJ2mToJY8vvwA2MPtMVnHP0
 7+eI3ebO3MBzmBWl244Mwi+DFVutVwHSP0+nqE1dvPRtnYR8WBC2tL/d2huu9V6bO/KtJchQfoN
 /yPKUutd7iMasBgMZz/Yo6ERLf9PiPA5WXGPvHVJPLpYr2uryQzbAwMbp1NlCGtdT92vWW6F+yt
 zYnGhPtovdz78gThaFAj+k2T2XctznBOAmrFI0q6ewjksWw7nz0BcuWYoPoernJ4GuI70/WUb2+
 XWVUrAeLFzoK/7/b189zRZxUhWWCVibSCgzx5vdN1XCD60dVZt5ne9ph
X-Received: by 2002:a05:600c:8b5b:b0:4a0:159b:d283 with SMTP id
 5b1f17b1804b1-4a01b120613mr14265235e9.30.1790761515113; 
 Wed, 30 Sep 2026 02:45:15 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a017468b10sm54109345e9.0.2026.09.30.02.45.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 02:45:14 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 00/15] clk: mediatek: merge single ops into mtk_clk_ops
From: Julien Stephan <jstephan@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>
In-Reply-To: <20260924-clk-mtk-single-ops-v1-0-1c3b5d8744ba@baylibre.com>
References: <20260924-clk-mtk-single-ops-v1-0-1c3b5d8744ba@baylibre.com>
Date: Wed, 30 Sep 2026 11:47:31 +0200
Message-Id: <179076165160.1985961.2539005097677862185.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1790761655; l=3504;
 i=jstephan@baylibre.com; h=from:subject:message-id;
 bh=TUfRsd0eF1O5NRp4p/1u+b5XcNi4o2NVXd9GLilNi4A=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgphAWFBQbyQxHwqbCvwEwIl9NQxnNa
 Ewt+3w/AUXP10QAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPzb0lbQeYHOk0NjzunEWFcqpp+uKMECO7k9PK8hS9DYS2frC1BoWgMQWmD8WsdS1gqQELIvBH2
 P9KUEGu/UeQw=
X-Developer-Key: i=jstephan@baylibre.com; a=openssh;
 fpr=SHA256:PPc8djUi3lnQXuiRHH4CZ/icbEYOsksrEsOV7pDEmZg
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

> This is the final chapter in the year-long quest to remove duplication
> and increase consistency across the MediaTek clock drivers. Most of the
> clock ops now are duplicated code that can be combined into a single
> functions. So we do that and then consolidate all of the mt8xxx clock
> drivers to use this single set of operations (mt7xxx have some extra
> hooks on certain clock trees, so they are not consolidated here).
>
> This depends on [1] to apply cleanly.
>
> And if you happen to be working on a clock driver for a new MediaTek
> target, all of this will be available in the mediatek-staging branch
> shortly to base your changes on [2].
>
> [1]: https://lore.kernel.org/u-boot/20260917-clk-mediatek-cleanups-v1-0-4dccf8ed98fc@baylibre.com/
> [2]: https://git.u-boot-project.org/u-boot/custodians/u-boot-mediatek
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> David Lechner (15):
>       clk: mediatek: add fclks_offs to struct mtk_clk_tree
>       clk: mediatek: merge the of_xlate callbacks
>       clk: mediatek: merge the enable and disable callbacks
>       clk: mediatek: merge the get_rate callbacks
>       clk: mediatek: merge the dump callbacks
>       clk: mediatek: use a single clk_ops for all drivers
>       clk: mediatek: mt8183: merge the apmixedsys driver into mt8183-clk
>       clk: mediatek: mt8188: merge the apmixedsys driver into mt8188-clk
>       clk: mediatek: mt8189: merge the remaining drivers into mt8189-clk
>       clk: mediatek: mt8195: merge the apmixedsys driver into mt8195-clk
>       clk: mediatek: mt8365: merge the apmixedsys driver into mt8365-clk
>       clk: mediatek: mt8366: merge the apmixedsys driver into mt8366-clk
>       clk: mediatek: mt8512: merge the apmixedsys driver into mt8512-clk
>       clk: mediatek: mt8516: merge the apmixedsys driver into mt8516-clk
>       clk: mediatek: mt8518: merge the apmixedsys driver into mt8518-clk
>
>  arch/arm/mach-mediatek/mt8516/init.c |   6 +-
>  drivers/clk/mediatek/clk-mt7622.c    |  10 +-
>  drivers/clk/mediatek/clk-mt7623.c    |  10 +-
>  drivers/clk/mediatek/clk-mt7629.c    |  10 +-
>  drivers/clk/mediatek/clk-mt7981.c    |  10 +-
>  drivers/clk/mediatek/clk-mt7986.c    |   8 +-
>  drivers/clk/mediatek/clk-mt7987.c    |   8 +-
>  drivers/clk/mediatek/clk-mt7988.c    |  12 +-
>  drivers/clk/mediatek/clk-mt8183.c    |  18 +-
>  drivers/clk/mediatek/clk-mt8188.c    |  18 +-
>  drivers/clk/mediatek/clk-mt8189.c    |  40 +---
>  drivers/clk/mediatek/clk-mt8195.c    |  18 +-
>  drivers/clk/mediatek/clk-mt8365.c    |  18 +-
>  drivers/clk/mediatek/clk-mt8366.c    |  18 +-
>  drivers/clk/mediatek/clk-mt8512.c    |  18 +-
>  drivers/clk/mediatek/clk-mt8516.c    |  18 +-
>  drivers/clk/mediatek/clk-mt8518.c    |  18 +-
>  drivers/clk/mediatek/clk-mtk.c       | 379 +++++++----------------------------
>  drivers/clk/mediatek/clk-mtk.h       |  10 +-
>  19 files changed, 144 insertions(+), 503 deletions(-)
> ---
> base-commit: 8189f1c305fa8af99780a84dbffc34d2f0f06743
> change-id: 20260924-clk-mtk-single-ops-75410cf38279
>
> Best regards,
> --
> David Lechner <dlechner@baylibre.com>


Tested en Genio-350 and clk dump before/after is identical.

LGTM, except for the two nitpicks that can be fixed while applying.

For the whole series:

Reviewed-by: Julien Stephan <jstephan@baylibre.com>
Tested-by: Julien Stephan <jstephan@baylibre.com>

-- 
Julien Stephan <jstephan@baylibre.com>
