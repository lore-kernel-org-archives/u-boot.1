Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 651C2C2A09B
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 14:30:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 85F9381313;
	Fri,  7 Aug 2026 14:30:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tAH0xVewqxvk; Fri,  7 Aug 2026 14:30:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 579E68130C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786113009;
	bh=ANLlRfplbWQa+NrIJX7tcqSih52aYaE597HJXsGIb5Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qlBnd+3POaeVscrZRXP4qoPM7fm1b45RdYp/c+azAOVwxyD844oB9I93W+7aw4jo9
	 CUIOelsviPLaPR53kdDcV0OhjqeK9udJ2QHKztNbMeHJBSLHI1CtGkc7fWCdnaJzrq
	 RtmAHnqXufJR39unN6+wEMgkK09x9IDrs5xT2QO1592r4KqVbPjDMETmGabIveuOaC
	 nrk1I/FEyeH65yB2yJBonfJjqZXRftD2L3svYBy44tpa/1hIT0g20FD+yCyX6Nle1G
	 pAXFHc0DjxS6rB6tsMpU09CQwLEla4b+6bbt3WOs3XZlLNSb97vMAVO4Tk3P+QhPza
	 lUkNjA98nCscg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 579E68130C;
	Fri,  7 Aug 2026 14:30:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 905D9198
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 14:30:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 76B3440244
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 14:30:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QoLjoc-0sGFZ for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 14:30:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A4CE140074
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A4CE140074
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A4CE140074
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 14:30:07 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c20755e8295so213817966b.0
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 07:30:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786113005; cv=none;
 d=google.com; s=arc-20260327;
 b=cs4aELmJNNdiYa3S5vbrRrnPYG60VI4DFqzLxsMmRo/+omnVfNbsYruDuej8CQ7cae
 ZHtsits/jOMmotMsa9MEwEc9U+8qlewbT0A/JxWWadfq7fmbYZaLZVVJ7NzEUooowD2G
 +9Pr7bwU1FUmD4FHIpBzLvMizn7ylTC85B3ocEkGhxx2VwaYvqJbtvFVcuWN2QiqOwNL
 hSrh9j0dnwgqsPYNnYQlbQivVIxRGbO1xxRQY7FU3J2LZJY5tWFdDYQZEaB32gjbB0w0
 cuxUY2Ng9/nET6irPH4fR0pkrWWYmyGfxnqCAx0bwokzSXhgDHZizo+OG1sKdigSFFJR
 BZ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ANLlRfplbWQa+NrIJX7tcqSih52aYaE597HJXsGIb5Q=;
 fh=Vl0FVV7eM/XtO7KGYFQi7JH9vhc7oqGmgnhetUs44nM=;
 b=QXmtMcFqSyaSCl9FGNkezZY6qciJzL4EPwy+6izaLB8JjW0dXRIAPEAMHK3rzWhqzT
 8A7xKUUOn7rxPaDsokeAeUAWGV17VEVZh6BsCu8fIaZTgEvOoi4OiN+U6VjBcb4csyoS
 sWegrj9K2DszU3ET9XwjI7BfQRazgikEIaLljKrCpDH322HQPDAOJ90vk97ej2Hoe/ML
 wMVBMJuTCqk71WMYIfJakpj9hl/n4LzgYYiRRZrY0s0kEFXo+z/ppXliwM/vx33bzb1p
 ZROhVochL1kRK29plxqk6sA84DJNn1DfPNhxnYp1GO/xcEfgF5WRRGmBBZ7J2ezzr2FI
 qOhg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786113005; x=1786717805;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ANLlRfplbWQa+NrIJX7tcqSih52aYaE597HJXsGIb5Q=;
 b=DBI6I9wi42PTTHMfJqtoDGKqF3PYQYTvRkihzjd2b+Muc82su6/rMK/CBT/ugBhsms
 +OPqKoOaQyv6iydaTPGbxXHj1ROxSfdWRuUH1huVhcAG6A9kLPYRXOIQqe+x4IbCpd1X
 k3AYpe5sTP6l/dGDjXWTjw3pm9/4/vDXNgAvTaqZcXY4ZF77f+6VYMUl00rpdLE+Q4JH
 eMM0/eQGZD1ddekXBTDXbWORawa93r96OTxn7uRwJgLO6XOicpR2olIss4acavsBQ+c0
 1uvBbPVM0fhYDm20AC/UGHpvqjezGm3NUu4/rarpdzE7NS24uNKPRGbmaCW/CnKhKpLT
 yvaQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpHQKCBG4/jpUwy0dTsj3Sa4sWmcxFOD3XsqcS2Bv+RzlOMAigwLDTtnSCthtcKO2OcTH3FI8o=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwLU0Svbp/ePdsxa4xyu0CBO3iDaVKkjkrouwAEbBIUY/n6dDdl
 nNf7f2qmy3QfpTzzypS3VvtVJlTLhZhQSJJsrx0YUZhT+hxckSVgm6HEJ+yfuy1T6fT2WCvICWj
 Wg1yggtrC6AnXLBq/Elzh5DtVK85a0LqBfiGjkES7jQ==
X-Gm-Gg: AR+sD12eXbZh4dbj7y/hwpCoMji+P8o9Y5U49J9MGb42lyI7MwpcacW8+ZANF/zAFGw
 Rz8AL0vArauYAZD9g6udi+WD3yj9cTGArPkPF1NoIMAxWh/OtZAGN8NWvWSsQMjOR1l/Swp6wUk
 Oy2GDrs1FeiL3dPK0N/Zqf7ljJqQfpErvV0t/lWl3LCcm4mJfWhNzgJtndZIqnOMYuZZweaWeRb
 Jciw998XTW4c7C/F85a+ARl1JEEcnvQLbwI0YIUKCfE24NVDd2EXDov3DQ/TFK/jVknul4o/FhR
 rhrj8YpBqu5GHq6Lw5jRtYZpfJo9kzUAtJ/a70zJIOONG3fLhmXSfQhzvysICdpqXLIqVHDM0kx
 yBuu+juNcQF1hf04ZXxZLZXKlAJ3noA3LMjF9tC+YKUptuMggSyu4apVbl/N1Vq8=
X-Received: by 2002:a17:907:3ea5:b0:c12:525b:4e7d with SMTP id
 a640c23a62f3a-c2088bb0452mr4622966b.15.1786113005564; Fri, 07 Aug 2026
 07:30:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260806-mtk-snor-fallback-compatible-v1-1-74559b491b4a@baylibre.com>
In-Reply-To: <20260806-mtk-snor-fallback-compatible-v1-1-74559b491b4a@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 7 Aug 2026 16:29:55 +0200
X-Gm-Features: AUfX_mwiP9nAaH7xbbCFiaO_0f1xAwysXi_lmF_DNf_oEEMa_KgXLmIkq0zANTY
Message-ID: <CAEHHSvb1XjkT5WD6zxzaSYqjdBj7EJoVHPqxH+=OhV2f7+xGYw@mail.gmail.com>
Subject: Re: [PATCH] spi: mtk_snor: combine mt8188 and mt8189 into mediatek,
 mt8186-nor
To: David Lechner <dlechner@baylibre.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786113005; x=1786717805;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ANLlRfplbWQa+NrIJX7tcqSih52aYaE597HJXsGIb5Q=;
 b=hb7JAdezhlHWg2hYrBJzrlgu01IBLTxZOK+X6ywZbsMXVDAVJfzWQ9sFd3+jCDxXgT
 cSgBkpyBe0tcnNQByr5vwy9wz2hgXkRnKZRhMns1c5SBK3ApBG585dG24IWSOvvy0+rW
 4mGWVYBCryM8kq+T2vZ2jLMg20xLGnbKHSM7FEN5hbCwM2co5OtVzyV73vPrcNP/MW4X
 OYd4D9uwqwW9n9dwYT1S5yOmfISBojHO2mg307CMoPJoitwdk40Sh87N1BEMvqDT/Qpd
 w1JcBPp/pgtZbwHC/FMXC3AmWb+V6SpQgkXM0Pxb4u7Y2zZg41FEr9BF+EuUEL18FCYP
 ViyA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=hb7JAdez
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

Le ven. 7 ao=C3=BBt 2026 =C3=A0 01:40, David Lechner <dlechner@baylibre.com=
> a =C3=A9crit :
>
> Replace "mediatek,mt8188-nor" and "mediatek,mt8189-nor" with
> "mediatek,mt8186-nor" in the mtk_snor driver. Both of these have
> "mediatek,mt8186-nor" as a fallback, so we can use that instead of
> adding each new compatible when we add more similar SoCs.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/spi/mtk_snor.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/spi/mtk_snor.c b/drivers/spi/mtk_snor.c
> index 40fc1826db6..95bd8f06eb9 100644
> --- a/drivers/spi/mtk_snor.c
> +++ b/drivers/spi/mtk_snor.c
> @@ -607,8 +607,7 @@ static const struct mtk_snor_caps mtk_snor_caps_extra=
_bit =3D {
>
>  static const struct udevice_id mtk_snor_ids[] =3D {
>         { .compatible =3D "mediatek,mtk-snor", .data =3D (ulong)&mtk_snor=
_caps_default },
> -       { .compatible =3D "mediatek,mt8188-nor", .data =3D (ulong)&mtk_sn=
or_caps_extra_bit },
> -       { .compatible =3D "mediatek,mt8189-nor", .data =3D (ulong)&mtk_sn=
or_caps_extra_bit },
> +       { .compatible =3D "mediatek,mt8186-nor", .data =3D (ulong)&mtk_sn=
or_caps_extra_bit },
>         { .compatible =3D "mediatek,mt8195-nor", .data =3D (ulong)&mtk_sn=
or_caps_default },
>         {}
>  };
>
> ---
> base-commit: 24ecb168a113c9de96c172086bc357597a8d1e6e
> change-id: 20260806-mtk-snor-fallback-compatible-5733ceffb9fa
>
> Best regards,
> --
> David Lechner <dlechner@baylibre.com>
>

Reviewed-by: Julien Stephan <jstephan@baylibre.com>
