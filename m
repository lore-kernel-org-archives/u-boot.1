Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 863D3C53209
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 21:41:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ADBEE80EDB;
	Mon, 27 Jul 2026 21:41:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vvxLlwuFaJJV; Mon, 27 Jul 2026 21:41:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B4D2080F42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785188509;
	bh=5THCZ0O8w38nZFnqHR8xCODz3YVQhpSGM08ii5/GOc8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wac72znt4UORinhgBOBRo2Y45/GKXE5LEbwhE5sbAkIpE3mNstds6LT+SG+o+Lf2L
	 DJZAV4sheFldXoh6hyhX+xz6tFgb19FC7zhzY3w7V3AvQL6+UWxGzgys/7yhTNuL5J
	 7UrXgnF0+rJOBhdLIBbx6A+RdirDVoGfFfyLEScYvW9puaw3M4EJq3SwYqd4xWz8ZX
	 FA554Ad3C/v5XfigVudg2TJ+IT1YQAdBiKUzYsxaMKNg2QfZM9u4ZXSW3JLrqDUBjD
	 Vf0zFYbXPG2dE4UDPefRJ3G/lFCl94oWrF3pDie+TRmF2WzcGUbJT/g5AB02vz0l0m
	 hj0CwVumlefpQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B4D2080F42;
	Mon, 27 Jul 2026 21:41:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4FCE4194
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 21:41:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 418EB60777
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 21:41:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HzQhYRi1oTMS for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 21:41:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::235; helo=mail-lj1-x235.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 26748605F1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 26748605F1
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 26748605F1
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 21:41:46 +0000 (UTC)
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-39c908d6cb6so27186881fa.1
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 14:41:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785188505; cv=none;
 d=google.com; s=arc-20260327;
 b=SMojhQN2jGJhdl1QKuymVcnso3xpMGnuKMZUVgABneRnN+2SI3EdjFQsmuvzPx3KBL
 QpI+HfzD/oeQ+ZXTaAzztPzyydCZp6P4BylCD6Fb53HFNi0xEGXnEpFSViCcvvJ5bSNO
 jUVHN0yY5956zMdLFJOfSLgSyph2CRisjNGZfm2ASa+P1lvF0x4t1Re3mLdOyKu0zZ7l
 CezIvKjZC1TLzw5arWnEn3IdqyrRQkgw4O/s7xrMMuNWuku431Gjpn5T97NIk9IZZ5HY
 L6h4N0lSBgRwuYVHKr44ECZgQj0DGMldpxwj0f+b+UdMarF+h0R9jBbqOu5D0ZhYpYhM
 xMrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5THCZ0O8w38nZFnqHR8xCODz3YVQhpSGM08ii5/GOc8=;
 fh=Mg9/ywXZu+5sfA4T/+JwamI8ok07ScfEb6T9zO4qTbs=;
 b=TNoi25goacdzb9qs6Tk2Of4ItdtJwkmlgb7fUPv9dEN9oErbYgAaqSxpONUVoZsA/L
 M0NsHioR40rji49O/k7PvLfQU1YlrPjyX8GVEr56IV7mV4Cohypy/jWsCo+sbGLRNfTi
 FbrRFCKQaRj/WYapxlRbf9lbxE3jMzIvtRVb8Eg1BpoFbBI34HOsFCLIs8TnBHa9ybUR
 Qtc/GnxHQvanumGQjIwzrvV+4u5DhLwAzEv5HyvIDJDJESggYn76pyTXTzW57YCTmFaw
 7UZOVoaK1YJ+NoZ6CRjnt0n/qi/gV/TAGxaMpBdjFUGcOuKv42otRKZazJxgre1vB8eq
 IAKQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785188505; x=1785793305;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5THCZ0O8w38nZFnqHR8xCODz3YVQhpSGM08ii5/GOc8=;
 b=NZDPdvdxyxCid4jeMEkIMuQZf0YCVIQueVTZ9dC/bz2qoH3p2GOb5orcahmWhOPvQM
 x9K+FAVYg/H4j4ykGn6oaih8EDy1jXwbu4vaN28gdBC/6ooOCPxKwV1d9qIHyzo2G3Mw
 GM9CR/s9AsZqWCSozGtRXtAMxIXMUKWzvHg7dR4X2cAZ0XTiqTwO0/0Jm2Pc62n7ihE5
 5ga337jsO/WYm1mI8JF09Hnb2zR0NDD+HJtxkqOah9XI3I6tY5VJTDZvCM2lLH0iiPyt
 o8/S99GcXYLowmnK30yByeXOICVDHdpOVFt2CbsBUCNFZF7jypzvCC3PwknnAzDzKQ1D
 KcYg==
X-Gm-Message-State: AOJu0YxEHgMV/G/L59vBpElkDrl1buib5ZYuY/dqESkd9ll0dew07tsl
 xV730OzJujvAHxfFmxIrJozYOfo1pkkA7KSLyCwaiYRcN2yYVAR/V9OysGKRiR0r8WNzaSINU6c
 NN0puGIREHXIXq9tTOTqLFhqVAJHWoqCOtA==
X-Gm-Gg: AR+sD11SapVe7a+h79DgsMdiHu0RFMF4EL6hOPLr0JoOwJU+FgD0pCd+NpenYX3GD5o
 p0F+xAN6Ll+GUWRSGAz8wlJNoCKGpupRwM0dQ48pV7r2jBdg/s9CcwBcZiKuG+AvRIi0pm0cKCk
 wY2eKcj43tdMijze/1+IB+xfJgMgBTkXrsxJhH2yPpjIu7tRTTdaeI433/dsnKMhStdSTn/vAY1
 JDE315PGjP2zGXRNjM5Pi9ZKXvEzm2SLaaSV+jVVniSRcdwBuV/HdLc7mmMiImKSs4p0x0QxOIJ
 1K14A5p6VAeA5uEvMRUdnFFRgwh1Ai10LSZkV7bK8w6A9ME6wZ0D+k7V2hFxvg==
X-Received: by 2002:a05:6512:3196:b0:5ae:b952:6c with SMTP id
 2adb3069b0e04-5b2ced6f0f8mr143933e87.13.1785188504351; Mon, 27 Jul 2026
 14:41:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260724-imx952-v1-0-bb060ca157e8@nxp.com>
In-Reply-To: <20260724-imx952-v1-0-bb060ca157e8@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 27 Jul 2026 18:41:32 -0300
X-Gm-Features: AUfX_mwASOqKtU3bTj4GAtgKT1JrzxSn7fH72PGo0uyZ220mtazVcBbqY1YChj8
Message-ID: <CAOMZO5DGKJ61iy04OYA4ZvQzyHC_GBpU+R3044dSj9=kobE10g@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] net: fsl_enetc: Add SGMII 1G support for i.MX952
To: alice.guo@oss.nxp.com
Cc: u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>,
 Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785188505; x=1785793305;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5THCZ0O8w38nZFnqHR8xCODz3YVQhpSGM08ii5/GOc8=;
 b=lyyjnoqyg5dlLIFoeDyL3KTWRPh0PxxyTvKEMOYM3SI/aumrOqxZpbmKs64N28KE1S
 Ze8qMzzP/soZzxIlCZAgw2+QO3cBwhv6uBTKyPmjHZxFxpPgY8JsWF04078hrx4G/dwk
 hdf1wGyVTUUKasBFQW+DzJc6gNg89NA52Q3LDvFV0HY5PGOh6mVvdgWRrrrR9WSC9MEI
 FqpgYBMTl8TPCyYXIlNU+qoloYXxsoJI5VWR7Z3vh713X52gsCOkSbfNuZP2OizYjAc5
 hxum3RaJLnVq7sWjR/MwUJqnlm8wvg3iLh0CIUWZ4M+RIEihrsXHWBcfQifbz2laK1rX
 o47w==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=lyyjnoqy
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

Hi Alice,

On Fri, Jul 24, 2026 at 12:40=E2=80=AFAM <alice.guo@oss.nxp.com> wrote:
>
> This series depends on the i.MX95 SGMII support series.

Please rebase and resend, thanks.
