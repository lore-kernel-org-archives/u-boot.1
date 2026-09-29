Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C68FCA5FA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 08:53:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DDBDF405AD;
	Tue, 29 Sep 2026 08:53:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RLLlrFb4FgXo; Tue, 29 Sep 2026 08:53:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 103B1405A6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790671998;
	b=r8dJXZ4j849Jy47VYT7mRiV1GR9d/pDOhd1CdmUuzrdR0DlvRV+pabdOV+aCqzdc6HGQ
	 MyqVg+iwbKCznUI4InpUj0oqsFzhZKHr9hOaZMFEHTWascBdLCE2RzSd4WZ3HNzR61Qz7
	 tE72p1CTINTNIHk3pMz8Do5ozij43CUP9X7q4WKTliDV1TC+fMNvwCXwerhkz7kv5f/bD
	 vrv2ZQhM86S9GrbvgeWSx2Nhol6LaS/NGFBZ2fAwvVKJGGXN5H/NWd+kxQxMS4rdMPLNB
	 fg3un/eGcYmnJ1toPhTKvGW+ETYqikuuluWSJNOCoHiomDWy2/S02aJxPsMukoypXwg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790671998;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=8rV5jyjuOYJYlsT4uTTxDvu9pGJRNcRVUcWkLeZY/f0=;
	b=RkG5kcxwisciSdwFDp9QyRAAGaTcNs2dvjfJUJhkIUm8sDhR2iQDIsmkEBGIvKcy6BAC
	 LbxyDIgxdqWigJdTyjd86Yxo446KWjuUZYm45lu2F+X07S2bztCMPlJlTm/BVZRUt5gAQ
	 +2ZQkXDWgDZipqO/9I/gYh1oiq6V4bxr8bloUpVDRbV/CAAU6V8r4AzF7Vzu6mJ7cZghK
	 qrYB+QrGdmnl3aKDOGcNxSSWnd0d3FLx1g+VOjzfpp1S3EcsQ9su0odfjkVHauHW8WT9R
	 7rvfJ0DgfWtqE5m/sWAOkd+8t1/mdnHDxnL00AOn6dfY+x6Devaase8I23QpQ045mYw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790671998;
	bh=8rV5jyjuOYJYlsT4uTTxDvu9pGJRNcRVUcWkLeZY/f0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BejvRYLorBx9pG9GmFcyeUH3BK1LoJg/zfxUD+0GkvKQ2AEnesYEiiuGvw7j72z3V
	 lAZzeWuO3U34CLV80Lq8Mf2vNH+seiBy9RMEIcCRIBlSy8mMLeujYopiPDHsWYfxjt
	 vITYNcGoO4NgI1YC9+bvR2K3IqC0KxZLtlO2CVmAIcGVIOuHqVizc4yYzhERnQg0KP
	 1+pwsq09Hr7jSr75nwTtd1hptZmxJZ/lU/UbtjZLDnEsQhOEUEE5n5kE5EoOZiVtoe
	 x8lzMKDrjJQkC8p9fRYiqqXrJ/r5r0+msZTnsVMRROClC2ZjOH4CJ31rdaoTMivV4q
	 pJR+I6Mn4EE8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 103B1405A6;
	Tue, 29 Sep 2026 08:53:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6AFDED1
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 08:53:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5C6F280C7E
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 08:53:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hUJIBpedI48L for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 08:53:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 56FC380C77
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:34::20"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790671995;
 b=g6Z1iKBqvTvR/a6muexg8wDLMgZclOx1RHMJ+cJ1TYvWi8Psw8UhS3TtU+/kjG+RBVDs
 6LcO6Ai0mfXvJThNM33krFNBkAAwDAx7Wuq1KmcDcSS0ebtcJZjhueRx2YiBwFC2WTpkq
 3hohASrD399jdg6P6cIldcpWeTamwlwEkGe8R/t1tXOZT0HLHDJoVxQKuCUkh8kImG6Qr
 oOmZgdzjxVc1swKfLJ8BUQUsU+LDzbAxYXCyWpn+kprK59QZME82LM2AYbLQEInOkYpfR
 dZc8oD75cNwRBeRVzj9QrwLuEtalo8KNwSkTgtWflIfsCY0VsdkbfT6hqQHVnGG725w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790671995;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=8rV5jyjuOYJYlsT4uTTxDvu9pGJRNcRVUcWkLeZY/f0=;
 b=VyiqBp7VbzESNN1dB4hqtMVTsxB8aMynpXQlKYY9YU+P7eayT/o/aSvqtwQteFzsHH8h
 x5r9NXCEG9sMtJ4CMSAG1CUS0QSz+VvO08DwNIC9bsutIrRr9ePUlIpctVHxUMuOpfdJa
 yohRwM46oIEzcU/QoV4CdpnFZSXhnv+gm705ZmY6k9jRBPlX3DYT+2le0D57XPj45jbZJ
 aNRw/zFL6M7ccVcO1RPONH4u0+w73RifyGes99aqZZo0xiAtnOILpDgn1ivi8afnwu1Sf
 mSMor+cTZDsD2d3cG56XlH8AKUviOl70An8D/LkRShwnkbCnFQ6PTHe+QXF5w89OyUA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=jwkVvWyK; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:34::20"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::20; helo=mail-ej2-x20.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=jwkVvWyK
Received: from mail-ej2-x20.google.com (mail-ej2-x20.google.com
 [IPv6:2a00:1450:4864:34::20])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 56FC380C77
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 08:53:14 +0000 (UTC)
Received: by mail-ej2-x20.google.com with SMTP id
 a640c23a62f3a-c2af3701927so580896966b.3
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 01:53:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790671993; cv=none;
 d=google.com; s=arc-20260327;
 b=Sddjat2NxU2tcu4g79kv59LjzowhZqiN4JTEYKzmY1bilJE1C/T4yQc1W00fxXLeWv
 DVlrXgJmfhiZppZm2YRUX1XPJ2zknDdykBB32fuskwG4Qrai7bqOwlMRIdaV3xCfsEGm
 FmzKbFUMgYrfwGv0B12IXDIqx5AId5fAaqDb7+ql4vg9I9u7kml0XeeTgQWY0TrtiMf2
 RXYYZWDiN+IskzlUF7BgBOLnD2XsG3VwADb8FhduYyggFKkAPgMXWaHxk5hVn7yF7H7V
 VeUnRLulZUE1SWJIqhbjftMVWaqKS8SEXk+2qxDa00mcRMTq0N8TtuMo/rzG+dacwPz1
 wYtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8rV5jyjuOYJYlsT4uTTxDvu9pGJRNcRVUcWkLeZY/f0=;
 fh=KIfNOq+Km7+/+2Ri7qez7XY3eRRoz5hXWW6tM1vilbg=;
 b=eNXtsB5nsdWnh7w/78duQtzf3vOXlqCNNfOkL7TZupG6tY/oSYhY+ZU9NPSz1+YxWP
 XL9glwaQcGccm/xuf+OiiemX4r0KpGfY7HXKTu357gRh1Xz7zXCs06sg+SqMB2hdrU/w
 cvA1Utx0YgMmA6NYg5wvVBwiLLVG/6ypQRj/fdKcdFM3xzYr0XdD8ytvhNGWdFkruLNL
 Zc0N6C65uVK8FgsKYIBNA80wAwJqExE5lTT3tlvuiNp0AWWpncy7oPZ7/8RcPKyrvxWi
 L9W5OfVpf/BmUCzexfC6+xaM68FdePYi6BoRp8ieLRCIxuUIwFXStHkoYEdYrSnpOptu
 h/eA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790671993; x=1791276793;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8rV5jyjuOYJYlsT4uTTxDvu9pGJRNcRVUcWkLeZY/f0=;
 b=jwkVvWyKnXA4M+WxCemolXQHIM6Qc8spZghh23xOUthSgoxxiqOf9wggXeGbJYEOxE
 DJfg4+/b80i4atR8JPmdT1L1stOIqnARQjm6u7tsZ/nWMkWpApMf89MaGOG5wvQ3dH6L
 I6K7kHy30WMMTgqCj3C/DgPKFJ2RtzrAqgY/rzzAlvCN7Ei9XmBZX8Cmla2RNlcGbNWI
 yOE/If8iwWJnTYxZPAjgcCHfy4K58brIBJzGE0VOs+sl+n5JoFUGtO2YUeV+BPIfE15k
 ODiCQus0Aga6wlpoOPJzbfcp/8rSEcHqN3jkoKdh/+aYC/ui1QuljkSrpaBMwLqu7LYG
 EaeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790671993; x=1791276793;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8rV5jyjuOYJYlsT4uTTxDvu9pGJRNcRVUcWkLeZY/f0=;
 b=eM58i4sy08S7qm/yopX1uusbxcCGn1itoJArwIZIrSi37zgqm6wzj5fSn0aKKjaw9W
 gO1Q7ou7erXLYEt0m8/JwmcQJh11alk+gl8RQEWuIINr5bjhvIZH7jzntsxb0XHu4g8c
 5wbpqG4xF2Os+fpLTPwQgV3VCGXfZQzch+8kFfLItSqOIT1ZDKKfoZfJnjzJGDm5xmZU
 RxlDjwwl2T5PZNm+7ni9zykJkb/s9bhXvWVmwQxCcm7XEAM99UNqFGkP4lN3t+T7szMU
 5nI78JFeHTBDIBaKAybvMjMbrtUrpDJvOkOXFFM3zM541mcNnknPJzObEQZI2yaS2hrK
 mdKw==
X-Gm-Message-State: AFuF++l9Jp5M4FdwwSz/PaJe8mf7j1cq38N76JivlMBB3Y93CclQPE5M
 LKrwOMlpLD07g3qDTa8+McKpjpiDLVaufhAPA9UdsaGdx11AKyCLxKsgxJ0vemfZwV/bFiByybO
 RgoKZGNU9FifmchcUq0lqVzk0r6boORK2kR4d5CYimA==
X-Gm-Gg: AYBFou25JFwCNHOGQBW54V+7M18gHkxTtL+sVn1Ugmr/jStzL9u63ZLvEdnkokANdz7
 wf5jkpCKWkJn+WMDJ3HSV4NZkJyclFZZUpPA2/NvOlqiUMAdQLHnf0ZKnbtIdvc/8ABQjOUJWdQ
 Ji01OPpEsmaXHbwBUWlnyGHni03rgpld/42PKCJGmIZxz4uEGXeaJoOc3RWwwRrEX5pVObEF6FW
 6u9GrvrS6JXmVZXfWs/J1UfBb70Pisrh98U3pc08cdR5IgH8q71A5K6l5jlwk5qUGusZH1q6DbD
 LgIYg4qI+7HmCnkk3jwTslmwFEaHepTHec2mJFeHNbLgaoJyN80i4NO6AOShHQinV4/HM4Wf2Tx
 4wYdHvkuNPb/NEH6KFtGAGUnJHHcs0+ACkswaqtrlv4PV/lHsIdMZy/Xl4Hy7k0pSd4aki8wxMN
 OlEkXaKqyqAg==
X-Received: by 2002:a17:907:3e87:b0:c29:f5d8:9c78 with SMTP id
 a640c23a62f3a-c2ac229ee9cmr1286024366b.39.1790671992719; Tue, 29 Sep 2026
 01:53:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260915-mt8365-add-phy-mtk-mipi-dsi-driver-v1-0-83707ed5242a@baylibre.com>
 <20260915-mt8365-add-phy-mtk-mipi-dsi-driver-v1-3-83707ed5242a@baylibre.com>
 <eded0ea7-a3ee-4735-b520-c0e2beccdd63@baylibre.com>
In-Reply-To: <eded0ea7-a3ee-4735-b520-c0e2beccdd63@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 29 Sep 2026 10:55:13 +0200
X-Gm-Features: AclHuK-WmaAfyHmKGjqme9c-ut4rC77PqTp1O6xXh2-LwmClv5PIdkrzWnZ1Y6U
Message-ID: <CAEHHSvZR-oosVGZLizJpi+Nb=QKsxVU_8Ps+NQ13sM8VhbCJVQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] phy: phy-mtk-mipi-dsi: add new driver
To: David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Pavlo Yadvychuk <pyadvychuk@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

Le mer. 23 sept. 2026 =C3=A0 17:50, David Lechner <dlechner@baylibre.com> a=
 =C3=A9crit :
>
> On 9/15/26 10:00 AM, Julien Stephan wrote:
> > Add a new driver for the MIPI DSI PHY. The driver supports MT8183
> > compatible SoCs. The driver is base on the corresponding kernel driver
>
> s/base/based/
>
> > commit 2ec9c210c1f9 ("phy: mediatek: Add support for MT8196 MIPI DSI PH=
Y")
> >
> > Few notes about the port from kernel:
>
> s/Few/A few/
>
> > - tested on Genio-350 which does not have nvmem-cells, so keep rt_code[=
]
> >   zeroed and fallback to 0x210 has kernel does when no cell available.
>
> s/has/as the/
>
> >   Can be implemented later.
> > - PLL is not registered as a clock provider:
> >     - configure() =3D determine_rate+set_rate
> >     - power_on() =3D clk_prepare_enable
> >   configure() takes a struct phy_configure_opts_mipi_dphy and uses its
> >   hs_clk_rate member, which carries the per-lane data rate the kernel
> >   would have set on the "hs" clock.
> >
>
> ...
>
> > +static int mtk_mipi_tx_pll_enable(struct mtk_mipi_tx *mipi_tx)
> > +{
> > +     void __iomem *base =3D mipi_tx->regs;
> > +     unsigned int txdiv, txdiv0;
> > +     u64 pcw;
> > +
> > +     dev_dbg(mipi_tx->dev, "enable: %llu bps\n", mipi_tx->data_rate);
> > +
> > +     if (mipi_tx->data_rate >=3D 2000000000) {
> > +             txdiv =3D 1;
> > +             txdiv0 =3D 0;
> > +     } else if (mipi_tx->data_rate >=3D 1000000000) {
> > +             txdiv =3D 2;
> > +             txdiv0 =3D 1;
> > +     } else if (mipi_tx->data_rate >=3D 500000000) {
> > +             txdiv =3D 4;
> > +             txdiv0 =3D 2;
> > +     } else if (mipi_tx->data_rate > 250000000) {
> > +             txdiv =3D 8;
> > +             txdiv0 =3D 3;
> > +     } else if (mipi_tx->data_rate >=3D 125000000) {
> > +             txdiv =3D 16;
> > +             txdiv0 =3D 4;
> > +     } else {
> > +             return -EINVAL;
> > +     }
> > +
> > +     mtk_phy_clear_bits(base + MIPITX_PLL_CON4, RG_DSI_PLL_IBIAS);
> > +
> > +     mtk_phy_set_bits(base + MIPITX_PLL_PWR, AD_DSI_PLL_SDM_PWR_ON);
> > +     mtk_phy_clear_bits(base + MIPITX_PLL_CON1, RG_DSI_PLL_EN);
> > +     udelay(1);
> > +     mtk_phy_clear_bits(base + MIPITX_PLL_PWR, AD_DSI_PLL_SDM_ISO_EN);
> > +     pcw =3D div_u64(mipi_tx->data_rate * txdiv << 24, MIPITX_PLL_REF_=
RATE);
>
> (mipi_tx->data_rate * txdiv) << 24
>
> For those of us that can't remember order of operations.
>
> > +     writel(pcw, base + MIPITX_PLL_CON0);
> > +     mtk_phy_update_field(base + MIPITX_PLL_CON1, RG_DSI_PLL_POSDIV, t=
xdiv0);
> > +     mtk_phy_set_bits(base + MIPITX_PLL_CON1, RG_DSI_PLL_EN);
> > +
> > +     return 0;
> > +}
> > +
>
> ...
>
> > +static void mtk_mipi_tx_power_on_signal(struct mtk_mipi_tx *mipi_tx)
> > +{
> > +     void __iomem *base =3D mipi_tx->regs;
> > +
> > +     /* BG_LPF_EN / BG_CORE_EN */
> > +     writel(RG_DSI_PAD_TIEL_SEL | RG_DSI_BG_CORE_EN, base + MIPITX_LAN=
E_CON);
> > +     udelay(30);
> > +     writel(RG_DSI_BG_CORE_EN | RG_DSI_BG_LPF_EN, base + MIPITX_LANE_C=
ON);
> > +
> > +     /* Switch OFF each Lane */
> > +     mtk_phy_clear_bits(base + MIPITX_D0_SW_CTL_EN, DSI_SW_CTL_EN);
> > +     mtk_phy_clear_bits(base + MIPITX_D1_SW_CTL_EN, DSI_SW_CTL_EN);
> > +     mtk_phy_clear_bits(base + MIPITX_D2_SW_CTL_EN, DSI_SW_CTL_EN);
> > +     mtk_phy_clear_bits(base + MIPITX_D3_SW_CTL_EN, DSI_SW_CTL_EN);
> > +     mtk_phy_clear_bits(base + MIPITX_CK_SW_CTL_EN, DSI_SW_CTL_EN);
> > +
> > +     mtk_phy_update_field(base + MIPITX_VOLTAGE_SEL, RG_DSI_HSTX_LDO_R=
EF_SEL,
> > +                          (mipi_tx->mipitx_drive - 3000) / 200);
>
> Is this 3000 supposed to be MIPITX_DRIVE_MIN_UA?

Hmm probably, but not sure. This is copied verbatim from kernel, so I
didn't change it in v2
>
> > +
> > +     mtk_mipi_tx_config_calibration_data(mipi_tx);
> > +
> > +     mtk_phy_set_bits(base + MIPITX_CK_CKMODE_EN, DSI_CK_CKMODE_EN);
> > +}
> > +
>
> ...
>
> > +     /*
> > +      * The kernel reads the per-lane impedance trim codes from the
> > +      * "calibration-data" nvmem cell. No MediaTek board describes tha=
t cell
>
> Technically, mipi_tx0: dsi-phy@11e50000 does in mt8183.dtsi
>
> Not saying we need to implement it right now though. Just the comment isn=
't
> 100% accurate.
>
> > +      * in its device tree yet, so rt_code[] is left zeroed here and t=
he
> > +      * SoC layer substitutes the same mid-scale default the kernel us=
es
> > +      * when the cell is absent.
> > +      */
> > +
> > +     return 0;
> > +}
> > +
