Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC1BC531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 07:15:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 00E62605F5;
	Mon, 27 Jul 2026 07:15:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N-jzEl6TKpEm; Mon, 27 Jul 2026 07:15:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D2781605FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785136510;
	bh=3mnzO2WJb4xsZBhxYlN9RPkZMrhbtsGov+JQ/3pxD+4=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=eOO/JHKDfYjrntuZ6Tj9qn0r7VKHwjrGcxWVid22u3IwFvoiO1KQ9UtnIpPmjDitZ
	 ElhzmrZ1n4YdarPsAuMPXQi78brP3286WpCmFlPDj+kXtalj4icgJ4xTi3SlGRuYLd
	 HBxr0n6aOoX4RPyd4r+rmOVAk+ycWQMZkfKx3gl4Nq+xmw5P8ZVd4Uy2W6l90xzm1z
	 QT/Tkzc9QJ8yTYBKULXM6TwZgEj5YwtV/sXNx3fls35ruG4FksJQ0oNR9wqAoxN4/I
	 LXcKgz1pS5O7inGFjU+eMi+1D37uv8ATehDV38SIggvcFhwzsCCRYwLNoTq9EB3oGT
	 4AzcWgOczLCBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D2781605FC;
	Mon, 27 Jul 2026 07:15:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 494C1350
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 07:15:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3BE95605FC
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 07:15:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZnBhODUUXqRI for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 07:15:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::22c; helo=mail-lj1-x22c.google.com;
 envelope-from=leo.liang@sifive.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4BFD8605F5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4BFD8605F5
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4BFD8605F5
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 07:15:08 +0000 (UTC)
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-39f20d19895so15093341fa.2
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 00:15:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785136506; cv=none;
 d=google.com; s=arc-20260327;
 b=cPn8vHoEY4bTXcmxKPEjwGGlUO0ByC5M2JeCH6C5cPU6mdOWp2rzBaityZb47yEAUl
 hBNGw2I5uGPa8Q6+gKU3PTn75yYUATvFrdz5HA29wa9URPMa5GyVjs5ccPrcA8GaMxW0
 RamslWVnOzSeIYfAKWp4l4TDAWNfAm8Bxtz40jrffkgvv6oxrQEZA3RuDU54UapoAct3
 UZk3DXXilxjn2hXdrtmhEuNpv1uVjn1lAY5V1n2uXW6mNf6ly9aMYmP44liFbXnlo/G1
 8n+TwnA3Gw+9bjRL9hcgOC3DFs4oL+n662XFx0sDNBZcjehGYQtCTKLSNXON/zJcWMRT
 N5eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3mnzO2WJb4xsZBhxYlN9RPkZMrhbtsGov+JQ/3pxD+4=;
 fh=zpsbHlI/eAY11kuRQ48E15PTXFh0bupDgsYWtDv5VxE=;
 b=kPABB14MOQSd2UIUgSENEuLFV8fCLz8QbzcAkeVx/32Lb1vMk48SnfJpg06dsW13f4
 HCTc24OxMcTjgy4mPyxnZneEaCto8Slyx1FKExVptJ8/n1VVv+77+ANezhtrzdCF2CkC
 reuqVDKyw20UDnY28W7w5dCSqcFokCe+cEauf92vWKpYyBvbPTZG27Pe7bKJSmvtczQt
 xgw4FO82ABrRPnrP8Z4pErFmkAIm1c5PQ5GB3ncupRHRqG27BCMkjk4d9nE4EhAaLZJo
 ajdxe535hdjeXjF+so62UGOTM4viSXkvhaaz6VC+JhzuhAUJeLsNerK9LcqsPAiN2MhN
 1CPQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785136506; x=1785741306;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3mnzO2WJb4xsZBhxYlN9RPkZMrhbtsGov+JQ/3pxD+4=;
 b=C6/5/MgiQSNgeiZ68V8fgLPJoIjof/odqRQA0maAkNDY+ofYCYNcOKQ8wrri6mnAI1
 SlTfTv9Qo3ftO3gGsjFYv5y+kGn7seVfcMoqGSeyg+Wo5d33VmWuHrNvsQ/Z9TvR04SC
 XNQrTdb9zmPCfihBwjXc9Kr9tL/VWkeWzs8Rn418r9bSdeNV9lSVZFcGi5lO6MsIU3hr
 664rsUCm5vZNiC6DMliJaZiWRqywPof8gU33Iblkmy/hjBuW0JOtz4p0nlihyvmAXGbg
 e/K8CjD+jC9X+etzEODSldeKGGEBymz4m/OOog47Jn8dvp6/46t47w2PDx0Fjjk3hxSK
 T1Aw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqHp1JExT94TUH9K+DiDs3RLxBmuT5luQQuCRcA/PzVW97qb807rVjFTP+W+HmSfhiyqWB8ccY=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yz/GdQwgwpHLeVm2Wt/NWoZe5d02qUdrNTfJrwgfhMX7gvSngAn
 NFAWUi1VByPXAbapogOrNje4dRohiLkpDd8uJ3oxpePGqJsUZaoDdrwtqsLpr4uKkK2L7w6vLPs
 wYaiJUoqXAAjZ6VT4jyS4P+n8eWtE9kiFNYxh/CZOYQ==
X-Gm-Gg: AR+sD13Qv89q89CIe1Zp2Yi9XF8NG+xdnMybKvHupUldLChQA7Hp+vZXR1ErKBwxkmq
 uU4YfGo7a3AZD/tRJOuNS0tx6OT/QTimtu8GyWeyDUUB81TVeSHKUAsAP8orHqXsjfOobYKV9M9
 wHwX3gaKxUIzhLgGT8DppK40x+qFOfTkXlJmaffntL8nYzAG0pLoal1sKHhBGIBR8go+2lSeaUK
 k423xuE+GEZM8QzVIh+N1S57dSy4aqVAhKEwhNC6uSnwjzcsVjhUBQz5Sy0u8+b
X-Received: by 2002:a05:6512:350d:b0:5ae:b9b3:8ba8 with SMTP id
 2adb3069b0e04-5b2c1b69db5mr1221302e87.57.1785136505843; Mon, 27 Jul 2026
 00:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260722154602.3373184-1-jamie.gibbons@microchip.com>
 <20260722154602.3373184-5-jamie.gibbons@microchip.com>
In-Reply-To: <20260722154602.3373184-5-jamie.gibbons@microchip.com>
Date: Mon, 27 Jul 2026 15:14:51 +0800
X-Gm-Features: AUfX_mzrvbaePenWs00EnL8RRTf5LopOKxvnMspdgdlN3Lu_xCQ7UhVkn1EdTRk
Message-ID: <CAC7DN2AnNNEj78iT65vOhWrm4P2GkBfHH6sAuM9OEBiQERSo6w@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] configs: microchip_mpfs_generic: enable MPFS RNG
 support
To: Jamie Gibbons <jamie.gibbons@microchip.com>
Cc: u-boot@lists.denx.de, Conor Dooley <conor.dooley@microchip.com>, 
 Valentina Fernandez Alanis <valentina.fernandezalanis@microchip.com>,
 Tom Rini <trini@konsulko.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, Sughosh Ganu <sughosh.ganu@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Martin Herren <sputnik@on-the-web.ch>,
 Michal Simek <michal.simek@amd.com>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1785136506; x=1785741306;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3mnzO2WJb4xsZBhxYlN9RPkZMrhbtsGov+JQ/3pxD+4=;
 b=TpH1APUmhH9v3IEeor5UGpw1SKhnjZGXXKWBtKEKEt6V9zuktizVdbddaFeL1aRLg5
 GS7xlMiyiDCFlWwXnPpnzWX4ZLWxkDQA7WqB0iXMcYYSY7S3K3IKMvvYp6pn5Tq3PnCv
 9Xc19iQ6kd41cIgiQpJvXvttat+waajPtEHpsvbz8CtJH7VChe60kYCHdzKsCpXSAj6O
 cbIEK2Jcuib8JVIfpomLH/aF4dmemMBvzWsyk9/gCKyHMA+vhMQe6RVPrEZGt+pE5KAK
 0EFDSYwG45TWAZRFSQEqhEF2bYueV5JODameToei4TKAT+OuIz37LKjGRu3KH6O3h/yX
 IniQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=sifive.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com
 header.a=rsa-sha256 header.s=google header.b=TpH1APUm
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
From: Leo Liang via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Leo Liang <leo.liang@sifive.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Thu, Jul 23, 2026 at 8:52=E2=80=AFAM Jamie Gibbons
<jamie.gibbons@microchip.com> wrote:
>
> Enable the MPFS hardware RNG and associated infrastructure in
> the Microchip PolarFire SoC generic defconfig.
>
> Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
> ---
>  configs/microchip_mpfs_generic_defconfig | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Leo Yu-Chi Liang <leo.liang@sifive.com>

Best Regards,
Leo
