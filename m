Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F388FC55182
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 18:52:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A12AD6069E;
	Mon,  3 Aug 2026 18:52:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1D5_v3Pfg2Mf; Mon,  3 Aug 2026 18:52:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C307C606AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785783164;
	bh=GcBUztU+vFgtvG12+0GnySbKHexuBzDf/kGs4arTLJs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0zIE+y3m3mWFOB6wYl75AfD/5d8lZ4uA2RGwcsIcDFeUPxhhj0gdttUJXlLxbsl/H
	 OlF7aXi7m42qZnG+fjYzQSDhsM9UdHoHI+PirCuPj7JCfv7OHZWWB8l4Wg+0sVOWNY
	 v8eMSkwnjFkfht7/GfFqGR8BShyrYWTzKs98PCJPO9HsudA7XjEin53Ux4f6GSCtUQ
	 pm47dvUFah9nLQ4NOwQLWZXq3UISWP9Cs0pVLt+W9Z/9nbZz389Lg/mCgGrpC6LqNB
	 KIT4wiQSEROOSkk4/emhNnS4oR0U1vfswLPI8DX5QKCX50OJiHZHRNHGSLGcQp7c0c
	 FbOduBdFAVgWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C307C606AE;
	Mon,  3 Aug 2026 18:52:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B27F3282
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 18:52:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9AA53400B8
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 18:52:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xki_qYzQc5xG for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 18:52:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::12e; helo=mail-lf1-x12e.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org AD3F84009A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AD3F84009A
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AD3F84009A
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 18:52:42 +0000 (UTC)
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5b01146b205so2313885e87.2
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 11:52:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785783160; cv=none;
 d=google.com; s=arc-20260327;
 b=JvE6U27TOlEYuDcp50nrzAbK7dY46vW5IL2sfh8eu7LkIGq30ECjCdGuNIZ5Omd+Nf
 3TGHwg8uOG3+arYs4nQImEeJgNnjXaXc8ZANxerSMAl8tmZbEyFYaf9BgTyLnN/vB7rg
 0nygqtollAb8qXyupw0hRrxjLmN0oZzPqg17qUN8MptEuUqKDQDlVCbWxPlYcSItGbre
 pMVYMP6TPMpdQkwata9XlHfzHnaGnXpmUXx/z2EW0+HN5C2VgfmC7zpffSdFWsl8MKGs
 TYZf7ZfUgItI2NCnPqyJUm/xU3hS3pjDAxhWOPhj204BEeUHi1ZSaFfUdQUBqf09cEB2
 ULEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GcBUztU+vFgtvG12+0GnySbKHexuBzDf/kGs4arTLJs=;
 fh=bl+At+nPO6a39NyqTZTME8snnK72GzXdnBavCEa5Ank=;
 b=qG8ZLUhyuA39LEyJJYPxr/KTLJsjXJsFKowTIUs0wyLqmyGH/MqOc+Qd8pbnaLLp8m
 FnoOGdMrq1l0xqX7QDxBxdPujKC0+xLs/NsdxP/CR2BeC/f2IkTQosAchuTLQ6x4jkER
 UjjdleeLdnFRRz6oSAEhiNE+hQv5b8aCbVUCoVhfyV1LmaoYAh85OUcMkNq+cda5bWLk
 xcE9zoLHKaPonUS5RdDpKkxjki+pqleFE7/Ch6PVu/ZNSCSL+k+2VWuqPf+Fivbj5A+B
 y7yxOQtAJQlDB61zXxDUdzpqv84Qcql/mA3oFjfg2kUJdMRnfSY2MyY7Axq5rgJv4Y2I
 kPZA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785783160; x=1786387960;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GcBUztU+vFgtvG12+0GnySbKHexuBzDf/kGs4arTLJs=;
 b=WZ+oYH2+DnC/0yZgA+rgwsF9WP0IxHl9QycxgSQzk7rB9yr566EvZVwkmN2M3JlRDN
 emudQF3upPGsKQJUZpV8f9PfNXPMjxiHi0Ljj3nqM7GNwo3WkLRF5u3w2Nr9UkMkcAoK
 2bjuyL630VRtVeARUxqLmKPMKNrLXx6J6asU8krrmYGeEvWhpggML2AFx9AtBfns085e
 c+UTVAjljCzXCfYFoKRBmxNA33u6ME7rUU+w6/7yS3jes6uUJ39KdVWNuJiRZDEcoxDa
 L4Es355oEaiKvWYHBU9DNgrtW7ie4jcsreFSFbCF+JTKAOmreYFRnzQgR/evQTVv92nL
 V+xA==
X-Gm-Message-State: AOJu0YyhEBvxs0gpwGAUIGwaSglDWtzyWmtmlfroKr+DLnIVX4+Z5cDm
 tk8Q5Gp/GIPzp/z8X68SXowXsBkEJpUtTjQzJbIXM/G1pIFsaJCWPjWJQvnVVeM3PzEJvGpOj2Z
 u7AI1eEei2lYXGnT3WFXOlfSRzKOQEuk=
X-Gm-Gg: AR+sD13Jsp+XXWjefsE6MJdbKb+n9P09e8Zm1jYqqHfd/J28T5remgH7CAiZRdBHY50
 gyIbheyfT3NAwnLWSm23NjcIlRmGUGU020YEPNI9CdEw89U/boWIUl+Kyfl5IC3utxQ7gXm/rWP
 jM9FCNroNNx+z6x8P8Cc6XSgOAUdtfpd/K6EY+nknhC2UKkKmxyu6snPAOf/qUM6FkZCR5nNerd
 JSkzMsrWg3Hsv2XBrU4uiCqLFDNH20Tj1yayxgnoDf48+d2+zQQ91QIWHYN3v9OkHtbHeXFjA9l
 5IP0QIYO862HzQqpnHD/iE01GCwP784Xdd8G6a7XILuCO3msp74nq3Ev92a092O3sS/ZGqZKo+P
 Gb0jjs190M5lQExwy/IlkTy89qtGIXRDrHQ==
X-Received: by 2002:a05:6512:2242:b0:5ae:b6b1:5fcd with SMTP id
 2adb3069b0e04-5b2e4f184f0mr2128252e87.10.1785783160150; Mon, 03 Aug 2026
 11:52:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAAMcf8A2fkH41UP9jsJZSaPS2PUaoB_CNT5g4E4KXG0thmUvOQ@mail.gmail.com>
In-Reply-To: <CAAMcf8A2fkH41UP9jsJZSaPS2PUaoB_CNT5g4E4KXG0thmUvOQ@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 3 Aug 2026 15:52:28 -0300
X-Gm-Features: AUfX_mxYD4eOZt2yFc3wvzSydlTI3NUrBFWUnudWhyC-cIh5onD24ALp8r-Jd_8
Message-ID: <CAOMZO5BEWJanHUwdzzJ9YL+c-M=8XW43vvD_Lg28=ZU6+cPK6g@mail.gmail.com>
Subject: Re: Issue found when porting to new device.
To: Vicente Bergas <vicencb@gmail.com>
Cc: u-boot@lists.u-boot-project.org, heiko.stuebner@cherry.de, 
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785783160; x=1786387960;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GcBUztU+vFgtvG12+0GnySbKHexuBzDf/kGs4arTLJs=;
 b=Zr0S9Iz2ZctWKUlhuIoyxRAsbn/fxvsHP7pInLxxvNtp7Rc2BAWremmvVwRvdXBEio
 yYV1ICQ0JXkqdVKVXHpeu5kFcoy/AwJrr9RfqvK+48hAMzsR6cJ2Rd0GYlwo2N1HBxot
 3Rjtk6K8GmUqFJp9Ii5GlRCbzn4cXVtTH16mEUNpf1pklxIzIwb58yDuJqZ0gJ4UzRXr
 n/seV161Qwc7rnE6LdkxCXMtZvpUsTy/E3ig8VUt6fStgjOIHUdfntePZI8YbittMM0W
 NPjDqFo88sh6K+0iENv9+o8vadD3g6HZlOPg1hWx72KzTdLWrPIsW6RWqq1QTQFBAAT5
 kuxg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Zr0S9Iz2
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Vicente,

[Copying the U-Boot Odroid GO2 maintainers]

On Sun, Aug 2, 2026 at 1:35=E2=80=AFAM Vicente Bergas <vicencb@gmail.com> w=
rote:
>
> Hi,
> i am porting u-boot to a new device:
> https://handhelds.wiki/R36S_Handheld_Wiki
>
> Given the similarity with ODROID_GO2, i've based my efforts on it and
> all goes fine up to the very last step: jumping from u-boot to linux.
>
> In the file arch/arm/cpu/armv8/transition.S there is a call to
> armv8_switch_to_el2_m which is supposed to jump into linux, but it
> doesn't.
>
> I've added some debug prints around it (see patch below) and it prints
> the first message:
> "before switch from EL3 to EL2"
> but it does not print either of the messages after.
>
> As another test, i've tried to replace
> armv8_switch_to_el2_m x4, x5, x6
> to
> br x4
> and then it indeed switches to linux, but then linux crashes, prints a
> trace and reboots, that is, it doesn't like running from EL3.
>
> Please, can somebody help here?

Are you using a recent ARM Trusted Firmware?
