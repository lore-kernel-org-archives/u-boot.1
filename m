Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C558F54AD7
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 16:05:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BB00807C0;
	Tue, 24 Mar 2026 17:05:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tjeoGGIv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 623CD838FA; Tue, 24 Mar 2026 17:05:05 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B044780087
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 17:05:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7d9c98e437cso728335a34.0
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 09:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774368301; x=1774973101;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g4IHo9gUuL2kMiML+PcPbClxAQ5zRu6U3/IqfT9TeUw=;
 b=tjeoGGIvBRxgNixrnduMLg889eKcMeRF1KfSNsuwkvi7kLyhLkoUpweldWWRzdlNPK
 glUZg7AkjlFDrEb3hfaw4InR2B7rnQ4bj0hpwhSMypMKCaIe01M/i93TDpoOLXjVEMMK
 /5DkKwTl1K9E/lcki5EfzpIWomCaZfp+WbltMGsQSGfqdjXa/QufImlqec583pVn6Idr
 J1CnNK1TJB3WBZU0w52sW87zlYEQYafmlHsW3YGv5FNCJ+q3qgSj21Y+YKj6YHwLBp6i
 /te+DFOcjK8+aL/H+5GAzmxCMGg9Wl9dQtbj1NdMBQxJBN3W9duoX3NWKJFY5sKU3ftU
 AvxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774368301; x=1774973101;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g4IHo9gUuL2kMiML+PcPbClxAQ5zRu6U3/IqfT9TeUw=;
 b=b+epDrfxbt9QYppbV+O4FSHCq9D9taStY4POru+cu95rwlG3n0ANParpfPk8I5EChL
 leUhceut3YZZy4Hi0JaeX0cbvNmsb3xcdwvI2IqKqKavL2AKI+KBqrmMQtzYJAjw5lH7
 nVwLgH8ErnWGKzLdnBBDwnzPojtYndf4mGi8Kc79RkOhn4uC4L0wdTdL9pNveRg8aXOM
 z3E49t67KN2RUszr73Fh+EgWiRMQBEnc0QPFiexEHdTGtOIKy9Cyq5hE2Nhp86ezIlDP
 Rwxi0PpDwod2OLBcoolZdAtESeE01x1Rj4R50tl7J8i6Xb2Hb7mGy4+5QoAltN55DHbE
 ZQGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoMb9RveMrbdg/yj6qEIY/zKfK8ew96CxtQslIaRCE5BTH1B8+7W5/BtT4ulwTAEKnuCQY4iE=@lists.denx.de
X-Gm-Message-State: AOJu0YwT1MVG5NunG+Ru7uIN+V6dXnMA1ezzjeJ8Cs35i1jzL3qKul/4
 C5N1QkwqgyxzTScT1wQaQ4OcSPAAJSFxB0Pbv0GDJ4bXHrtOAoEHHEi0MQOLd3qrtbw=
X-Gm-Gg: ATEYQzyHhtdAd3kTOuofkMZ75WZx6Eoa3mnVV0Gxg5SQhjGFZrGKtIemXsDKwJjM62u
 0iSbs5iQ2Q8fzC4/dq6J/VrUln+A3yLPONxl3FgTQ3k32LQsJ1KRxYrK30zQfvdtESvuzcJXeeP
 L3MJIS+7RDuEb2aDNtJ0nn1RKYfPYjjmjI/yTPl/+BTpumr4cGy+/m5NoQfrQ9NBtWEv3BuWSND
 FDd3w4LtgvxIABgkleFAHtevZV3JlZIheTc9AkoQ9OPHIw60t2CFIFhLFSC4yiej6f3pzo4kjZN
 /Z8yO+7L2NQzsC8NfNyqzGraq1lklqXlHlf9reGKg/kXtiySUebp+tx45P0G9MICDMsG5IEOR5F
 vQqX6bCYfU8HRusRjoGgaUdJOtJztEF9pfMEEvrgnnZKu4dkyH2DW3fIwqCoyRu0x/ImFErj7Gg
 5Gxtmne7/Qq+wtr1HWG9RCYcSZb3s=
X-Received: by 2002:a05:6830:648b:b0:7d7:f13a:761c with SMTP id
 46e09a7af769-7d7f13a787fmr10392706a34.23.1774368300940; 
 Tue, 24 Mar 2026 09:05:00 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:8a85:a776:3f75:a1d])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7eaa025dcsm12821134a34.0.2026.03.24.09.05.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 09:05:00 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
In-Reply-To: <20260310-clk-mtk-parent-cleanup-v1-0-66175ca8f637@baylibre.com>
References: <20260310-clk-mtk-parent-cleanup-v1-0-66175ca8f637@baylibre.com>
Subject: Re: [PATCH 00/16] clk: mediatek: remove CLK_XTAL/CLK_PARENT_XTAL
Message-Id: <177436828706.3897241.523698758984337394.b4-ty@b4>
Date: Tue, 24 Mar 2026 11:04:47 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2496; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=VtYqJze2+elo5DHkFg3cIBTrDES4cJ0FgWTkuucrhRE=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpwrYjxo2roYgqWnJhmIlIpP6TOIhxfEZ0Eqls6
 FOnVL5/wvyJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCacK2IxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Ao+UH/RBWE2U1fKoCByHv4OeBKLA0QA14EYwd0xB+Frp
 Cy0Aq0J+i48c3dVrkoAwV+LdQv7qyYXwh39kJ9qK0hnbw/UHKOqmVJThDpLmUYiF5M+/7vSWz6o
 a07miVrWqrz9biSVnIl4Eh5S3jISZDkGoINgnukR+8beyND7yE4oyrEQTM4ZlAX/C7HlEuLFAi4
 ZeYeQ8ZgTbh9YPaRB8DnnG4lBkYZT8Ph5q6WiLcvW/ArZKfOmJ+vnggp+9vr7EY1hNDEX9NgUoQ
 NT+23eBbhDehPMwpSITQFMYM67c8Kn5wJoDEIbqoHMWiID0uPzlmnQSljPOaQY/+bN5Xhry210H
 bwdc=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Tue, 10 Mar 2026 10:32:13 -0500, David Lechner wrote:
> clk: mediatek: remove CLK_XTAL/CLK_PARENT_XTAL
> 
> Since many MediaTek SoCs have more than one fixed-rate external clock,
> CLK_XTAL/CLK_PARENT_XTAL is not sufficient to represent them, being
> limited to a single clock. We have since introduced CLK_PARENT_EXT that
> allows an arbitrary number of external clocks to be represented.
> 
> [...]

Applied to mediatek-for-next, thanks!

[01/16] clk: mediatek: replace xtal2_rate with struct mtk_parent
        commit: bd79703ba6bf074dc645c26a9ebb936faa37150c
[02/16] clk: mediatek: mt7622: convert CLK_XTAL to CLK_PAD_CLK25M
        commit: 0f2fb0d8f4b4ac924abd63f2a989896abf52ee29
[03/16] clk: mediatek: mt7623: convert CLK_XTAL to CLK_PAD_CLK26M
        commit: 09bef33f713223343007369442c49e42e7727457
[04/16] clk: mediatek: mt7629: convert CLK_XTAL to CLK_PAD_CLK40M
        commit: 70313ab220be39a032b9597647a57ab253adf1dd
[05/16] clk: mediatek: mt7981: convert CLK_XTAL to CLK_PAD_CLK40M
        commit: 781a3aaca8c56fd970cb23aaf9ff36a75de2746d
[06/16] clk: mediatek: mt7986: convert CLK_XTAL to CLK_PAD_CLK40M
        commit: ce10db8048806c6c3bb0f3ea3479d00e008ead36
[07/16] clk: mediatek: mt7987: convert CLK_XTAL to CLK_PAD_CLK40M
        commit: ad15c5d5f03434f58eeeecb8a55db675619e902d
[08/16] clk: mediatek: mt7988: convert CLK_XTAL to CLK_PAD_CLK40M
        commit: 9c0d3a02eabfa6cbca8c58603a6bc56e79fef7b7
[09/16] clk: mediatek: mt8183: convert CLK_XTAL to CLK_PAD_CLK26M
        commit: ae32ee9273d21635c647853182c39f888934c937
[10/16] clk: mediatek: mt8188: convert CLK_XTAL to CLK_PAD_CLK26M
        commit: 2ea4728575df1c915e6d9851ef3879074e35c219
[11/16] clk: mediatek: mt8195: convert CLK_XTAL to CLK_PAD_CLK26M
        commit: 43a4f0de6656c705792889ecc78e24e326a2d25c
[12/16] clk: mediatek: mt8365: convert CLK_XTAL to CLK_PAD_CLK26M
        commit: 8747ef9ceb1af43c0037bce0a830195c4cc2e984
[13/16] clk: mediatek: mt8512: convert CLK_XTAL to CLK_PAD_CLK26M
        commit: 8fae93c2f081caa6270143ba5c128c06f515ca35
[14/16] clk: mediatek: mt8516: convert CLK_XTAL to CLK_PAD_CLK26M
        commit: 9b10b61eceb2eee7574608564611ae3b02ab42a4
[15/16] clk: mediatek: mt8518: convert CLK_XTAL to CLK_PAD_CLK26M
        commit: a0757eb64c45a5a1cf7e17a8e2bdc35323bc2561
[16/16] clk: mediatek: remove CLK_PARENT_XTAL
        commit: 741f9ab9cc0d46f087b467e24931392f13cc2848

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

