Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA67A606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 22:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EBQGzJ01;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=MesxJlr6
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9838760640;
	Thu, 22 Oct 2026 22:27:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OHRDIxaFyUrl; Thu, 22 Oct 2026 22:27:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DC6F560883
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792708029;
	b=NPvSgwNqvuRXp1LUqHyotyAKYFAkS6zQYJ0WGcb5gbTV+Ud+EDe0PlOoM6oryIKeQ5Zm
	 e4VmuA0buwaXS5VDXkyOqe8l3IIoL6/r+1JNmfW8kgCqsqrHSFRHpEJ2Cz8BWekG5gCW2
	 LHbuSQ/Byl3Ou6ZU0N8o/KDuq0IGGR1G2cyGRa37NNNecX3IjQwZ8Sci4ssX/jN/0/akP
	 fDTernkSos0GOO+JlA1m+EnHzp349Ywu06QIJDU9W6P9QfnbLYNhUSm9ed43WX1bDBveN
	 r4lOrz2Ny27ccvF0gX+0boIscRaJReXb811ZJMaJMUrrqTSyCUm3uSf0csh+5N9UCeQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792708029;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=p4UWJf9DaeAqnyr+2DbmjWeFyAx5x+pDja51L4PpNFs=;
	b=LHwAI5L/7ZWrBk6itjSe2HyuyCFpfSflV/rB4ujxkTBEeQ93Y9wSmotzglBV172yqMq+
	 ui/uY989C8FXZJzoc2cMD+PobtUI6o7FKkbwtqmJVfC9vsDk9cStHOPG6mGoEGO2QevL/
	 CnRUWGuzz2jH2tENIM+5r9tZJgU04GzLA6kbbRMemG06ojkQQy+MiUhs1Dvl1H7Y+8b/1
	 yvUkAmCDkDuwx+ieMx6rQyYqP3HO0C0VBCkZdi24zir2f3SHtw+mDG5C2tobGdEw1ouh4
	 Ri5vFWTtcNzet8bciHixSItOKJdq7GRj59oHFxRCNn5iNf+Q9TyBeuDWrmhmqsKpnPw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792708029;
	bh=p4UWJf9DaeAqnyr+2DbmjWeFyAx5x+pDja51L4PpNFs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EBQGzJ01VpBgHpkW4yj8OlgZCYor46Sh1rOQM0H+vIRfxRXUrTyf8J861CEBLWnqx
	 MvCWownn9r0wWOXoYEtm+E9+IwTBi5zmTaeP0HnAR/SLDjyQUAGtdYD1JR0ZfJsykv
	 cpuPI7Iz6B2KGvUDLaKJpo5G5R6euybcy9Y8P/AK+l9q9KUHfFxtopaLNontdLubXc
	 JJk1tU9RZQocStDrP5stEaAk9qVKzSPIrCzLvBJNblGNwTgo1++vBxyYzP/l5OXzP6
	 CPIl0TxH6GwnlJWkDVjqxKhPoUk2I5aq5K5yGpxsvYyzA1tvWtmFC0SST05eS05ikN
	 r2K7YG0JDZmNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC6F560883;
	Thu, 22 Oct 2026 22:27:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5422E3A7
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 22:27:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 45C8781287
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 22:27:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LfN_qJ6K4RI0 for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 22:27:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 46FC98122A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::333"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792708026;
 b=Py9ZApFwgAYLvvPLG7Dht+ajvoqvmgPFx9GuVwAa1vMwYGSsYW1AezemzcgLiX4XSD42
 qGR40b8cmRsKe63i+JDSDfQ6MBA14lrYuv27krZimMsAuBTMltY+5PNNvjQGxQSPD72A6
 zDxLSnV5ZndwkCu++g+r4RTP8ob0+UCcD6FJ0yLX3wudVHfurLvQD7XtWWOPEvsAfNQ7Q
 r3/ET1Tvkvv8BD5uYXk5WNJI6PWVpwaAfFfcZRCWwdEpShyFbRFpLY94Oz/JA2wj51zbe
 2kAqyPAbV1adgvpP++PIhBw8kSzm9vQvvbQAwyLrTHC/BhtC8Ufui7RozbZiqSIFSog==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792708026;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=p4UWJf9DaeAqnyr+2DbmjWeFyAx5x+pDja51L4PpNFs=;
 b=Iohe9zliIqo63PFZPY7PjsI09QQ9b2un34CJzcTS+B4ebCuS2X1VOXHuW2oTOFsM8870
 bBnkdY7fIeZF2pVgRS0vWnD5mxdQBk/yB6Z/tOAXY4k0JKG/nbY6hye9Obl3EEAvPWuTE
 aVJ9cbSFqCXnYYyV2LsWiJEHuPH8iCwjzSyXFwV+6dlLHiMhY4AH+CFdQlhn4/4T3Xtq5
 Ojg0rfFLnwbQLDBTIZq+bO6mHek+rcI6yZ10HeWfuwZ7cLCKvhdvD6+Eos/jh7TGjN+1y
 K1O+R3E4RnQB1OyCkEXtovD2HlZV2+c9M3rUZ/b3D2Y+8TMF2LjyYGhl/hSDKWVHdJg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=MesxJlr6; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::333; helo=mail-ot1-x333.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=MesxJlr6
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 46FC98122A
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 22:27:03 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7fccba9c675so1600355a34.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 15:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792708022; x=1793312822;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p4UWJf9DaeAqnyr+2DbmjWeFyAx5x+pDja51L4PpNFs=;
 b=MesxJlr65klN4ww8jxImlZ84KGa0MLSdZcmV2mI7rHgauJlAINwLNWZCYPJfJ1lTZf
 bStsf4LzjqqDKG29896so+NZv+d0GugsSVNPyKaWoCKUeeFjFUvefz7eAqv5qZuCNHE/
 fX+VkSiivMAkAOoXjV7g8bkOjKQw1D1kiqds12R54eJpH0EcTzqLNjTckPt2wZXJ4ugC
 pMDR/xgryOscOZqB5PkrZ35oC5Pw/dIMc1WTeigwq5RAW6UM2goWi8QXcCAar5xw1H0t
 QdKJfHflQigB87nj7h8/oFaH1tEdf8IO+gp0PSkpACpTn/3hUBxF9DPDPwRP7i0j55op
 +kyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792708022; x=1793312822;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=p4UWJf9DaeAqnyr+2DbmjWeFyAx5x+pDja51L4PpNFs=;
 b=1Fq9sS3UvSBoWS51xlcLyhdmmsLcCuVgKDmZczDUcJu5XDPC17Pule657j4L93O7zm
 SwiATJ/Go+dcl88kkrdLNZx71S3nLZX1VYif8PybysRaweiGKbmumEij/MDJjSD8OLoJ
 c/MmqiTUJfhzTVOpzIpYmNi6oSvPnAls5NORzDLn8SyoUCOTKCwicZMSCIV3j8L74Wwz
 1nFLMaus9PmRTus0DeX2BPtCMQaUgYK4HDW/vf85zipQXqte/ZRYOiXMnqiXWmjoADft
 tV+ZJjqIeWLTQmIUvZizHpm02CrWIChK1XBpdOUTEliYb6L8Iwz0/Q5DTRPUxSZzeTv9
 TupA==
X-Gm-Message-State: AFq9FYJ/KGMoW3omzJlWGJlFjpiB1nLV9bZ3nRZmTC0kXTisCUPo0xi3
 tupeh8KYwUZCslUtJhgyolmob9UXX0laRU9u2nrqHANKYZHGQ6Qx92J0dzXhWBjkZ88=
X-Gm-Gg: AYBFou0t0O2YByWHz9Ujx5sBrd18Mz1rtKhzL/1BcEzESTYxyoOMCuwRDu8G4rzwj8b
 kdHkjo9B9o49gBPQqO0hn9kwNJyCAMGdBfSw8px/BKa2uHYIVNdFapPGHVR9iyfAENhCjRKm5Is
 Ukfg/RwN9kBTjolQGUJvJphXyF5K6OVtDrRpswPTO7/aEkuRDJjwm0/CyT35hKZLZb4oGaUcFA/
 xoL07Tl1TqAm/+acie5da58Ln6x//ydlGI5hG1nTBwLdVPhs684JgGEoP1YpuSNfl1FWk8GFHsy
 Kb9P8bpAl+zY8ybfTMbL/8nAkQUUBnv0v1NN9luKxZ0OOfsCmMWuVlzUP67zMKtRYQks0lVKHK+
 UhyvfPlcNokbN47T/v4F4rOwunYzqttJmkTrfbQlO2PTD4tFMSu7JQZSCwCxVaDb6BIAeokz63/
 FnnrvHmCJ+XXcX2NfNEYW9BjQIPPf9CeoIVQWfT5u+yRCMSVgbB0aExXRqHCl1KMrsVbnU04viY
 fXDgmQJhhZNMbMSM3cDD4D8qzZJPNZnvLatoaX5lrkCmcXl2qjaUyAh8/j4
X-Received: by 2002:a05:6820:2007:b0:6df:ac2e:85ae with SMTP id
 006d021491bc7-70a7fb091f9mr2307029eaf.14.1792708022529; 
 Thu, 22 Oct 2026 15:27:02 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d0bd:a587:44ef:f6bb])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a8209e203esm280158fac.8.2026.10.22.15.26.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 15:27:00 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <20261006-mtk-genio-720-dsi-v1-0-7fa10e9c4506@baylibre.com>
References: <20261006-mtk-genio-720-dsi-v1-0-7fa10e9c4506@baylibre.com>
Subject: Re: [PATCH 0/8] arm: mediatek: add DSI display support for Genio
 520 and 720 EVKs
Message-Id: <179270800964.3711947.2315440431420541788.b4-ty@b4>
Date: Thu, 22 Oct 2026 17:26:49 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1738; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=Z/Xsa0CkPNhJddtuPvpiRxUwLmIlild8PLqP2kDsT08=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq2o2rDgIuvNYS0iKI0TakBlgxFV8CJiWeF00LG
 EGYPxcGxceJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCatqNqxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AlPAH/3tn7/YyFJn5AR5tlkqorF8qddbVl2p4v+e18LV
 sMYSkDSokGiMEb3RlQHiuGqmFMV2jototXZGGJPtLe6kdFM/yl/xdHM3JjsCFgwqk8IypFgm7Mo
 3dj1K1yxgOfeu+Mwb4h7T0fMccaeDalhoN/MYIQ5gBJYdqZJxPqcVh3rrXHxfws1Gxjp7NYilRG
 CRlMKDt3bWlofwsaT3WPqMv1FZmU/ECNsmsnKWMrL46eoG9fCmin1PyZQTwjExucKMvFW3XSkg6
 brAL8p2ytuNVaPw21XKH9AxXCi8YbwleSMFc0rtzK0sJ4PRiteE0yj0+XlHQvxPdhaMkdD9Jwt8
 c8Rk=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 06 Oct 2026 16:36:12 -0500, David Lechner wrote:
> arm: mediatek: add DSI display support for Genio 520 and 720 EVKs
> 
> Add the MT8189 DSI display pipeline and enable the Startek KD070FHFID078
> panel on the Genio 520 and 720 EVKs.
> 
> The MT8189 OVL0 -> RDMA0 -> DSI0 pipeline reuses the existing MediaTek
> display drivers, so the driver patch only adds per-SoC data. The panel
> has a VDDP input that these boards switch separately, so the panel
> driver gains an optional vddp-supply and follows the panel's power-on
> sequence more closely. The Genio 360 EVK panel node now describes its
> VDDP supply as well.
> 
> [...]

Applied to mediatek-for-main, thanks!

[1/8] video: mediatek: mtk_disp_mutex: describe the DSI pipeline with data
      commit: 7656fcdfbe785bb8fb0ae409aa7475b5461c5e64
[2/8] video: mediatek: add MT8189 DSI display support
      commit: f6c14aff85f8d08ef7e56cb5f5b3b6f4aef161dd
[3/8] video: panel-startek-kd070fhfid078: support a separate VDDP supply
      commit: 35342d64707322c422f695a94180e85b1db35d45
[4/8] arm: dts: mediatek: drop the USB port 4 VBUS regulator on Genio 520/720
      commit: 4729926dccb825df711ca25fee8d38474bc73376
[5/8] arm: dts: mediatek: describe the Genio 360 EVK panel VDDP rail
      commit: 67560938f0cba89a9130303afa589280e8e1ed78
[6/8] arm: dts: mediatek: mt8189: add the display blocks
      commit: d72c4f4f1725c0acec89df77ec192c7315fe883f
[7/8] arm: dts: mediatek: add the DSI panel to the Genio 520 and 720 EVKs
      commit: a07022fda660312c17df68066455ac14faa48dbd
[8/8] configs: mt8189: enable the DSI display
      commit: 0415893e39d1158539f5c3615552561d7ce60d0a

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

