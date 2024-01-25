Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A2D2C47258
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 16:54:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AEA787B84;
	Thu, 25 Jan 2024 17:53:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CYO8XuJz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8A1E875FC; Thu, 25 Jan 2024 17:53:57 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 127C7878CB
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 17:53:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-510218ab26fso656754e87.2
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 08:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706201634; x=1706806434; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FdvPsZD2ypC1pxcvbGkYbo4IMa0jO5s4aEN03m041qY=;
 b=CYO8XuJzl8Se/cAGPx4Bhx4fJjVSt5wqx0k6mnKzALZbEwkZ0ZgQF9AuWH1zPoW+do
 7CGM4WNadwSadkH2DpUwIrcuV507ZzkgKWXVmD/DHmKNWf8vtWnUHe1DS6NiOD4VtpFL
 vZkufJ4Yx+gg7FT98n43Xxu4FTOpG1p2sdaZS3wWNpAwP8NZ54oibKcBoUHg4z9pwvla
 /n1EW2lXxZ9ekl46UfWUd7gmJQl983QLkb30ejT3l2WJy/om0gRYNg0Gqtjt3SoGVqeg
 14BSfj+PossA4iFxb8bFHSXwo42ShEpGiyLc6pZpqczBDw8RAtsTxUuP00IbZMCz6+g9
 mSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706201634; x=1706806434;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FdvPsZD2ypC1pxcvbGkYbo4IMa0jO5s4aEN03m041qY=;
 b=q5sfoNCKDbYk0WoZVDV5TiuuCKdsorgIw0gbeldKyi73qVrnoQuLDFtXGuEX5HZoQv
 Mercezyqk6/twiBg54AeCtTTlBxDAgFr/q6yGZ32eJaiVBlE9CQ9QTnbpnGRDV1DFeN/
 cRjtK6J321HcLTt4uCZobLCy+Kj4wVFGhywouRAj48ron42MVKN50KJStrJAAJhTetaL
 ZxQ+xOyvMO0kjZqMF93m4a9EQglmwlbK1nGsLcsLjmVeY4cSmsR6To5Vr5nU++/6vWV4
 R3U0Oiir2xEMZ37hJxuQ0aMkLAPjyPqwR+x0JO4dqywzvMtfR0jBj9XELkGN4oS/dGaI
 9eAA==
X-Gm-Message-State: AOJu0Yw5YMaGt0+R+kq9d4rVg43e+YPMG3KzajyhvkrADtBdTvZEdGiU
 Mg6MEl6B7wEKU+w6hx/qs0M0Ryipc6YC746U8ioYXTAjLwq2wQuhplve1xHsCE5LbTVGcrgkgK9
 /6DrU92GJXFUal8cCue8TQcsKcFgnGiGJyMswyg==
X-Google-Smtp-Source: AGHT+IHnN7PTy5RwpYs6XRJpR4MhB8D4phgUOYMskRyKuOh/C2kQaOiyk90XrNhPilopeUt0N7ID4W3IfPOnRnNwI9k=
X-Received: by 2002:a19:770d:0:b0:50e:7749:7b99 with SMTP id
 s13-20020a19770d000000b0050e77497b99mr68321lfc.37.1706201634177; Thu, 25 Jan
 2024 08:53:54 -0800 (PST)
MIME-Version: 1.0
References: <20240125155438.47617-1-heinrich.schuchardt@canonical.com>
 <20240125155438.47617-6-heinrich.schuchardt@canonical.com>
 <20240125161414.GN3652023@bill-the-cat>
 <fe5d249b-70f9-4465-9c65-90c16d2c5e82@canonical.com>
In-Reply-To: <fe5d249b-70f9-4465-9c65-90c16d2c5e82@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 25 Jan 2024 18:53:18 +0200
Message-ID: <CAC_iWjKKZezEio47=z7+eMkQ1AS8ju1WP5EGcyfbaRWrEVpq8g@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] configs: enable smbios command on sandbox
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 25 Jan 2024 at 18:26, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 25.01.24 17:14, Tom Rini wrote:
> > On Thu, Jan 25, 2024 at 04:54:37PM +0100, Heinrich Schuchardt wrote:
> >
> >> To make use of the Python smbios test we need the smbios command.
> >>
> >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >> ---
> >> v3:
> >>      new patch
> >> ---
> >>   configs/sandbox_defconfig | 1 +
> >>   1 file changed, 1 insertion(+)
> >
> > We should do sandbox64 too I think? Ilias was saying something I believe
> > about testing one path via sandbox and another via sandbox64 (since they
> > have different base dts files, putting stuff for one code path in one
> > and stuff for the other in the other).
>
> Currently the test asserts nothing that would be sandbox64 specific:
>
>      assert 'DMI type 0,' in output
>      assert 'String 1: U-Boot' in output
>      assert 'DMI type 1,' in output
>      assert 'Manufacturer: sandbox' in output
>      assert 'DMI type 2,' in output
>      assert 'DMI type 3,' in output
>      assert 'DMI type 4,' in output
>      assert 'DMI type 127,' in output
>
> In a future series we might check more and then adding
> sandbox64_defconfig may make sense.
>

I plan to use sandbox to parse the smbios table provided by the
sysinfo specific DT entry and sanbbox64 for the fallback code we
added. I'll enable it as part of my patchseries

Cheers
/Ilias
> Probably this would also require providing text output for other SMBIOS
> table types.
>
> Best regards
>
> Heinrich
>
