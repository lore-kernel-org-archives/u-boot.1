Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BEF1CA5FFC
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 21:48:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AF90140748;
	Tue,  6 Oct 2026 21:48:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S3YGS5rfA4Jy; Tue,  6 Oct 2026 21:48:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A32C24061E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791323300;
	b=CwLz5+OcmV7th97Kbe/D3zwb3NKTKwnQvJZBfqwtL0Df1mXKsY7oHm6lo90ooMFl/QzM
	 r8PzzZrbe+qE978Vj9dmqtb65uT9RGwXOuddjN+34vvcDEP5WcBkZ7H85uAYiM7bpgs28
	 7kJQtgrE8gMHcfpAFj1TPx8mwi/jliGmDT0FJTOhjlR9Vvj/o8C7S041cQ7EdWolVINie
	 P3N56xW9kIQjzuLI0mRkyQakAfQmZ6cq70WA0wm1d8kmg22OJJ3Sbas4ewqb0wQWwClzA
	 CHbd2linjlFNuhDlT0rJ0F8o9NBrDkvPN6KSZCRBHS82a5L5ofIjS6mZyOyo8Mnn8+A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791323300;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Yal9Rsxm5FGFyZPhoPBOLQpmkiMQNlMunOaQbMGnR38=;
	b=GgvlvMiQRY2raZ0vhPT5OdFhCRqdtCa0WR7r2toq8iMs/owvqGinrxUYtz0Nkb+6rF+b
	 9bUCC5NCpUbY2Mq6bVy/2bcxsdMnWKOOCF8m79CKK5mxtYQ9GFwBRWS3W9+rGqynuzI+S
	 g6p5KswJ8XPDMgvCMez12rq+fuwixUXihUoJ0U1dq8kXvYrio/18AQO0dpOsvEC6sW2G3
	 O6ly9B65tW7mYLTpEV3sr3H08sTYekQ7DsK0amupAV2r8q3XrdR3DQnM5OLuQRqab0b4T
	 ohTWpS2+5P1E7nDVLhCoj3yPo+KEUKU+imKrrRO0O8eXTKrhCIVsGtV/gQINeWpsjlg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791323300;
	bh=Yal9Rsxm5FGFyZPhoPBOLQpmkiMQNlMunOaQbMGnR38=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=AogwddY5B0V2s5FLHKKuNLDLw7h5fKYE4R5vXgYjFY6ICYqNLytxlP9CAO9s3uGMv
	 cngfLDy+VQ/hvaspWZ0wuCuYL0viz9DjTii4ulj9rZyYbbfnIPSqEXhsYSPS7LTcN/
	 qPq+QL7FHkvknFDV50Jc2XHbvRGCXSRwUnC2wmzFtcvVNM3ZMnU6ZYKBuVbiNZqNao
	 4KUE5T/IYTv7oYoWW0ggpCZI/cyHCQF3LaG3tr3oyoWxK2adut/39RdVUWcuX4GBzo
	 5Oe3ZDE9222PZzlXTr6brFRqLtQv9vAEIU1eV5SXCeE2PkL3ZRpwJyY/2zVQ0H2Mtd
	 7rOKz8zdVN12A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A32C24061E;
	Tue,  6 Oct 2026 21:48:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D826A22B
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 21:37:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D5646402D6
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 21:37:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sdRriFrYGjG1 for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 21:37:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 1BB7240210
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791322644;
 b=slvq961K6MndSeOsQ1a0HcXFzzvtDfjmSF9MPbWMCHEmrLxgvCH4lI4ZSq7ia36jQNez
 rbE5Fu3vlrSylJIKVlYd23QncDE0vQBxQ3Z15Og6sKZwFZJ0m3KAcjnBp7n9Pc5LcwJkb
 dpT783MHrrC9iRyCB27fnXDcWo5C+xHkHMgz1NDLrIRGbA/BNP380FXkF+LcWIv/B8urP
 KuUEM4cljWXMusoPgh/6JkvDWuWlWfDC/O1l/PGI6ZlP5dmXlQ8QdwLgICP9N2l5KwpzW
 KVyv08nNipGlLJmKhbosstyICK/ZS10x7Qv9GF8CUamEp7N6KN5GZw0dc7ZLGbI7ZCA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791322644;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=Yal9Rsxm5FGFyZPhoPBOLQpmkiMQNlMunOaQbMGnR38=;
 b=FokzO+8vlU6HBsRt4GN4PqskEFJ4dKPSSp7ke5ZvPCTRTugS38AeEfbeHk+e3EqDnoio
 eaPl9yx59i2DemRyfijgoKSLBpm+/8pY4UkaXz+sLU9bZTqKOH5ajpJ1E9mUOYEo32hwO
 ljiETd1yZ2y4WyBlk82SblvnM+UyCuZf//kw7e2+QO2GHsSfAWRYJy4Ekuv1Vl3Mjo/td
 i0j6CDJZQjGtr3ySYv+UzAZqvSPN5vvEd6eJDnsGlbphSvlMQql9U0E9O0NcUk3d8Pfr/
 NjCCOUhqlkq20MTs0r8uSifKxsr0/AgbeycoHmB+BpdCzKwCfgvt+s55enf9Lrp5xTw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=N6GzNfR7; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=N6GzNfR7
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1BB7240210
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 21:37:22 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-81ae6aefdceso3143448a34.0
 for <u-boot@lists.u-boot-project.org>; Tue, 06 Oct 2026 14:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791322641; x=1791927441;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Yal9Rsxm5FGFyZPhoPBOLQpmkiMQNlMunOaQbMGnR38=;
 b=N6GzNfR7bjLkG0zBAcAZRdg+EKj/DggJaa9x5k64KvZEb8vS2hDVNPU0t1lgXuGXW4
 pphIoUlihoi3Bn2t1CvkgT/Vo5TaJXItdyu/h+450+7PoxIP3C3wqcunnPN8Dv9jqrO3
 78UfZBK5CwMPweqntJokd2NFKHKPi712kcnR8AXbIfNpEeY5viUeUueBIMdLV1AFqAvZ
 VS3hmmRgUiI3XyPjA5+LCk0x6w21Q1iwhjxvcoCkdFIsHvqxrY5QhIXbcS5uDi3nTFbK
 vub/BK0PoKNtTzrFeykStiiJn8yTd4F/vse/xeoY4s9HzVgtBWJ06N6bJAET2nJNf8gS
 PF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791322641; x=1791927441;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Yal9Rsxm5FGFyZPhoPBOLQpmkiMQNlMunOaQbMGnR38=;
 b=0JFV2CkDCGaFmwFER6bSvy6FfGODtMmpnWO134/OD6gHnPuxfYFfVf2R26c9RZ9SjD
 hD1wzCQWVI6CFHmFyFRykyU6xdMPNiHRavwze7Ra6Qg6kVZ0B0zFZo5Wghu6oxYgoMVd
 pcRG+JtqdaVKX4ca9WgV6ONfQ6lIwge96VLFBDQHWXbVsR5wRFL7IYYAjxkvSdJkhYBT
 /0qEEETGbbwt7OSose1LxTX8GmyWyMfodV/cxxG34YX1FVsaNTrlkK8ofvXBdAhP3kLh
 TZKqgsLXZkwJA5zAZCNXFp0hEr6wh3UXhAzsMUtm6mWIEcA0aWqZEoycVqlf1qOAJFlA
 T1cg==
X-Gm-Message-State: AFuF++kVz3pgTUOFL2xXmbEdKUCn2pZqsHp+1p2VhA0BOyCeUPeIy9KG
 Wpg+F47tY2R5s7hf8JE61qgt4felIBceKV4i0mzm7aIWGL+8fWU/xELYNLoR2MP9QZ4=
X-Gm-Gg: AYBFou3lLJyQT/XYWDHkcJGUXKYy2c4tbQx4nWPtDkfWYbtyHIYUzqojwx94fiEG7vV
 tpycXXQlrfKo0ytCXrdi1MyDy9UUvDl8ABhOXkm7xaKF6ArRkV3e9EFEb+Y8uZjh4BQSduYjqi/
 PNddBCJODvWmH1wKqGGJatWbURK1rjAcsUGsUnQEjcVYUfjF+hm5uZ2TxeKJJW4E0bZsYM0dQ3X
 BfrCBfNxup4CMQSASfPzfvGkyJlVLQYn0ROhFNHdug90GWZaMCTD7Xi/Rdch1QZcrQwzArDO7PZ
 GPrr48qnMzs8HF7wsATdlHu/L9JSOR3fPGWHP7B4fTcgL9EoFizT7NjeQzzHSVNgZ0pv9vTdZaN
 NGulS0rtFxvYBnorQp+2dayi+wgQCXZ5/EYfsbrQZFfRxHvdxygjaSTpjudblPpelTMIf2QXCqK
 8QYhstqX7uPfyscXHlVxvE6vIlOryQvs/MUnaaCCjLSrsCYm08yYEkGYnu3RO+mJ0WJxqgmN6xP
 w==
X-Received: by 2002:a05:6808:3089:b0:4b9:e5fa:8903 with SMTP id
 5614622812f47-4fc44d4750amr742965b6e.22.1791322641368; 
 Tue, 06 Oct 2026 14:37:21 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:372:3180:ce34:1fe7])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4fc4953f89fsm389386b6e.12.2026.10.06.14.37.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 14:37:19 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/8] arm: mediatek: add DSI display support for Genio 520
 and 720 EVKs
Date: Tue, 06 Oct 2026 16:36:12 -0500
Message-Id: <20261006-mtk-genio-720-dsi-v1-0-7fa10e9c4506@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WPwW7DIAyGXyXiPGtA0gTyKlMPBEzH0kAGJOpU9
 d1HkmnStsNO1m/Z32ffScLoMJG+upOIq0su+BLYU0X0q/IXBGdKJpzyllHawpRHuKB3ATpOwSQ
 HTFvRGX6SNW9I2ZsjWnfbmS/nI6dleEOdN9DXRMT3pcjyMfajA9/ivtq0VDJRtKJuT0dpQRmzq
 9MyzyFmaCzFVlvT0Zr3K//t+EMUrNkfWZ3BALPyeIWUVcw4Au0EMCXVUAsU0nb92vzLk7zeefo
 6bicyIWGa0keCzqIclNZM2bZf2QYaVCqAME0u99W+tKQcjFP+ecJSthtsiODxlsn58fgEAcFy7
 aMBAAA=
X-Change-ID: 20261006-mtk-genio-720-dsi-1cf87d259324
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3101; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=gT2dXYFVatydEeONdf3vbFVga4lUgWq91qCR7xT+P4I=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqxWnPyXJiSoBZoj0xakXJbw9kiBmrQHzwnKf8Q
 mZp5pBlzy+JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCasVpzxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AjaQH/0kfuLTlgmIIm94A2Xwcc5eWj8U/N4Kzu6bQPP0
 sBh8CFtGWMcF0bUMPPJ0GoOR2kQ1u/IJdnNw6l68WeLfrf6WoxEjEjRflVUnGzVj8tK4lHkh2bU
 GCPoFea0gxuY+lyeqnSl8NaLsHTknkft4ypgF2zMa2s2QFEN6DOqmr7BDXyGzq2NwnRufUKSBEf
 okQL0Eia4Q/CIZEkdNvVvz+Fa916Z8me0+Vrd5/m6bO5zpzsTy7z9IHlr2PfkQ5m7xMZ2PSY/gW
 P4XpzoD6pCEUIKwZ6SI60eH4ygZfCTXEQ/LywSddMcmNUy+uPLzJSc3jAENc0RseeAF0JldJS42
 yxEI=
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

Add the MT8189 DSI display pipeline and enable the Startek KD070FHFID078
panel on the Genio 520 and 720 EVKs.

The MT8189 OVL0 -> RDMA0 -> DSI0 pipeline reuses the existing MediaTek
display drivers, so the driver patch only adds per-SoC data. The panel
has a VDDP input that these boards switch separately, so the panel
driver gains an optional vddp-supply and follows the panel's power-on
sequence more closely. The Genio 360 EVK panel node now describes its
VDDP supply as well.

The vddp-supply property is being added to the himax,hx8279 binding in
Linux [1]. The mediatek,mt8189-dsi compatible is from the in-flight
MT8189 DSI binding in Linux [2]. The mediatek,mt8189-mipi-tx and
mediatek,mt8189-disp-pwm compatibles have no upstream binding yet, and
mediatek,mt8189-disp-rdma is not settled: we use the
mediatek,mt8195-disp-rdma fallback, whose FIFO size matches MT8189's.

Tested on a Genio 720 EVK: the panel shows the U-Boot console and Linux
boots afterwards.

This series depends on the MT8365/MT8366 DSI series [3] (and its
prerequisites), the Startek KD070FHFID078 panel driver [4] and the
MT8189 mmsys clock compatible fix [5].

[1]: https://lore.kernel.org/all/20261006-panel-himax-hx8279-vddp-v1-0-50d884b42aae@baylibre.com/
[2]: https://lore.kernel.org/all/20260916110825.102631-4-angelogioacchino.delregno@collabora.com/
[3]: https://lore.kernel.org/u-boot/20261002-mt8365-mt8366-add-dsi-support-v2-0-9e435457b90c@baylibre.com/
[4]: https://lore.kernel.org/u-boot/20261005-mtk-video-panel-startek-078-v4-1-2b18dc72ddb4@baylibre.com/
[5]: https://lore.kernel.org/u-boot/20260924-mtk-clk-mt8189-mmsys-v1-1-cb4abe521454@baylibre.com/

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (8):
      video: mediatek: mtk_disp_mutex: describe the DSI pipeline with data
      video: mediatek: add MT8189 DSI display support
      video: panel-startek-kd070fhfid078: support a separate VDDP supply
      arm: dts: mediatek: drop the USB port 4 VBUS regulator on Genio 520/720
      arm: dts: mediatek: describe the Genio 360 EVK panel VDDP rail
      arm: dts: mediatek: mt8189: add the display blocks
      arm: dts: mediatek: add the DSI panel to the Genio 520 and 720 EVKs
      configs: mt8189: enable the DSI display

 arch/arm/dts/mt8189.dtsi                      | 147 ++++++++++++++++++++++++++
 arch/arm/dts/mt8366-genio-360-evk-common.dtsi |   5 +-
 arch/arm/dts/mt8371-genio-common.dtsi         | 139 ++++++++++++++++++++++--
 configs/mt8189.config                         |   5 +
 drivers/memory/mtk-smi.c                      |   7 +-
 drivers/video/mediatek/mtk_disp_mutex.c       |  71 +++++++------
 drivers/video/mediatek/mtk_disp_ovl.c         |   5 +
 drivers/video/mediatek/mtk_dsi.c              |  20 +++-
 drivers/video/panel-startek-kd070fhfid078.c   |  52 +++++++--
 9 files changed, 399 insertions(+), 52 deletions(-)
---
base-commit: ca1c29c01bbd03f89cd86159b2959b4e72d41aa9
change-id: 20261006-mtk-genio-720-dsi-1cf87d259324

Best regards,
--  
David Lechner <dlechner@baylibre.com>

