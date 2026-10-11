Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC23CA9ECF
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 23:35:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F2D4740578;
	Sun, 11 Oct 2026 23:35:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yUCOfGLG_5D3; Sun, 11 Oct 2026 23:35:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2C362405E8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791761719;
	b=UyBFsQsOyywEvi+lccpJSfKSISJN8iZlvKavKTcUzyu2rvoBaMnuv1QyfCjPE/4JIMrO
	 BItV88E678qLE3HYPfsCdxu9rrOdoKzoXrKQ1shRfb35UkTuu+mZ0ynb7/Ok+C9jKZ6jw
	 FM2oiEwpZ7npP8iObx1oDV0eSHthblGgSB9qtYCXzYU4pteh4wdT8K+s7uih3iB2ualV2
	 0rM7MpD70jhrAcgyxym/J7Rzm793/G+f1bC1LIkBoX1m/pEL2s2BRWVJ3ILSrIzMvCLEP
	 9PS8TaJTqtGXjBTrJ0c2VeyPP4WtV1oUAycFYZziFtC41N93S6Zo7P6/bfDrWY/UQPw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791761719;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=b//LNHyzozc43+1ywcj2GCgynY7KVJ1ZK7vozmI+TB4=;
	b=rR7u8b1X7w8th9Lv3PPpNAAFnVJRpRgd21mzVu4tIn1/QkwtL2Q5oKtrbkoCsAKYN3qZ
	 /yEr6aQh6AP8ziuFlFDdVx7XfeQxcyNQojy5yzmVPUz3k1R7uzgZFQU2pXkH8TqjdvkTC
	 WcT3aQcJFgHsjeK65ynBzmnNzBfGLMhE7B7qZtWcPVL7bClB19aCiqtsAevPQFzgXWpn0
	 6UmZv5nxcgGkJQP/fO/BgzVX6Zs93byQqIiZQldinR74CWpGRv88j64Ql+gXWGqcCs8Kw
	 qCyXRka2ndmn/29fmou1D/lQsBeaAL6MPK2LVcxReT/0gSnVEwvkssm2afLJN42clZw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791761719;
	bh=b//LNHyzozc43+1ywcj2GCgynY7KVJ1ZK7vozmI+TB4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BwXznkc4qS+Rptj6XAj27pZ51pUlZ7d931WQSswQFr0q1tbG/28rqyItSN1+0uBvD
	 fwD/onP5SXoWVC4jdcTB46FZVMfCautbJdvKBFBJ7prdkwnckF1J8JNrIceOqI3PGv
	 l7N3X7NEZ16oMBbRuPySD7H0J7VQzyw8kIbpXYigAJlcXqIN3H2AUgPPQmsDv+UbT6
	 8hteYzQplR8QWo2pTOI0rggXu8/ZMj/lOOEqcnp3Wc7sbr2I7m6mr/C/Y8WNO0jiBM
	 R7xvsJkbLMOWIGwyaCIvp2014JE0B5/nSruNJYtb31YtEABhRqQR67lrX2ATcW7Cv7
	 vrI5Vj/1M0now==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2C362405E8;
	Sun, 11 Oct 2026 23:35:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E7E5E111
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 23:35:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CDDA040082
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 23:35:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wAMXKEPFFa2q for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 23:35:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0721540075
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1330"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791761717;
 b=T0/kIpjsDSStPnzOZxy+14dyoP1uepVMFHtM6vhJFpvo0+ijPo/VkhDYtZ28XFyja40R
 PSBR1FQtg8XrasKOtvUkIkN+jf0Z0LYg3VaHOqbxh+3KtaQdeQwca/4+550FYri/anmP1
 pkNX+lH76b1HECb6n0l+oNjdVgnK/vqcG5Oqgr2aX7x5QIlTs4APcUD+9UzP3X/0GhamT
 nffl9cO8w94OwXkictpyQndHafO/Rw5DXftlrqi0s/5f1OEKdAzePAnFX9sQuZrEbyJiq
 GwpJWEdZ6dad1Vs5BdT3wpEMtj+MuYYTtvd5MhfywUCNCMzmOvdnVaMdHM63j7dYmWw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791761717;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=b//LNHyzozc43+1ywcj2GCgynY7KVJ1ZK7vozmI+TB4=;
 b=Mv6lQ7q9i6aIvgK2fbp0UOzwvna0A3v18vCkF4KWWt1988ufZISV5vJVSnVDbsMepXDn
 2uF/f6bTI1wM195U4kfPGwdBZjEJZhdC+kUAK5g+WLomIGNw/fhSUV/eDjw0kvZ0bg1Os
 AczMUbkMc5CJNgj2gunKsL8AHpSFzWVdk6fyvhbBijAMNo6TVS4R9Io0NIDfw6h7Yzev/
 qXfz2DbJiizIE70DxfW9yCF2R6e2Lm3/bOvSMLyw8r13HmO29EEW+iZ6SvGEfF+4+NJlZ
 5h37Uf7nZd44SHGJX1JiSB30Dw/7IZyKWGBBjWVJ0GJ0mvZq2A3CVFiTRZRbapN42Pg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="ne/TQ9lK"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1330; helo=mail-dy1-x1330.google.com;
 envelope-from=imkyufie@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=ne/TQ9lK
Received: from mail-dy1-x1330.google.com (mail-dy1-x1330.google.com
 [IPv6:2607:f8b0:4864:20::1330])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0721540075
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 23:35:16 +0000 (UTC)
Received: by mail-dy1-x1330.google.com with SMTP id
 5a478bee46e88-35829219da8so1251996eec.0
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 16:35:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791761716; cv=none;
 d=google.com; s=arc-20260327;
 b=ZwtY2hVHC8N4Vlh/MhEQWGWbVaF2YxiCKicjVwIr0samb2RciqFwEU5dY/D4Ys83BL
 3PkS1JYtNCwPi2YavcwQJL3UXuRmBaxc8AKDVdpMxKfS7ufkJpgXcN1dxqdMRh5cks+7
 /Gro1+PBff74Q4EJyqb1zIbWZERm66z5eW2ZXBjdaHdPuH75RGBI/EPlrhOV6mFbKV/5
 P4dU77z9F5g3j3RZFOBCwfbK7KoGjO1UIkALVUoHcOxEiAx5ALzRG/a7QCXkqMSREMNy
 P3uxbUNIlHGmkK5GZMsECqRhddt6Iu07X5nRA+VU4EXc673GxGxJwOQ5WJOjpASAhVCn
 awJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=b//LNHyzozc43+1ywcj2GCgynY7KVJ1ZK7vozmI+TB4=;
 fh=kHF9wZLcBkrCWncwVWnDn3wWNxWkl4/Ax/KzWzm3z7A=;
 b=pWSxQR0zGqFMldCA11i0wAiU1ryAoENlnIdub3XDdMlSwS3+HKMKEpJ1Io2XSUi0UG
 ipxqgLff6uLEc7ncDi8vUtsH1mzYkAot/tUOogEZobpPa8vWSAYRqUHmlfZwk/3Mwd3+
 IuB4HY3WksY1ptJ+YUtX8Qhnw1l0DYwwGItRhnzJXIt3gcAYaQ/x6/WZfzupIxIp+w3d
 m0N2XDIFMXWQKIMTfnFjVBGufc7MM1p9UgZ6kW79TQPDbtemvDMzUZULTVxjnYSxQU3K
 b7Cu3JnSyLq1Uq2QSk6Apgj5IDebiFukx223ilmkIw/TBLfcba+B8GymsP3drOHzsC+I
 nOKw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791761716; x=1792366516;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=b//LNHyzozc43+1ywcj2GCgynY7KVJ1ZK7vozmI+TB4=;
 b=ne/TQ9lKDPGNHzEzTvqC+X7DwCmbb2ICjHepXKtji4D1iRZTCVjkEUUFG0qMwZSh6d
 1W3ey6oYUZF5W9DT8/vlhFE1KCnK/rYhAhLcDgDskHZuMp1KaBwuk4tZmyeCcxYIX1NW
 lkRi4gWjKouGynPDfdCwFVP97rQEfBW6Sj+MQ+Zg5+2bhqCSQZDdhGcqNbwiJOfFJpv7
 GtiG7qJsa1gPWLSTE9QUvpEtfL7BTNWBwV/QNVjj4t3Pw8XvXgtJn+avorm7KnK8op1B
 GYbxaxyRi9LOFeEaZuJVMSY5ks5c6204Tf26OhpieqFbWHAx39JIFof4yQpgXENhgU0d
 MFsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791761716; x=1792366516;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=b//LNHyzozc43+1ywcj2GCgynY7KVJ1ZK7vozmI+TB4=;
 b=GSapbyoJke8ca2QvkrSzoFTPGENzdjANqLTwjzevp1IBVO38p7LGsTaKYUjBrJTdmg
 UD/jKdvpYeP8LYIf9WaxszKibW1yinF2GvppN1HUE3/YoR0XVuMvieCEUtwblZxvweXg
 cWjBExcrzY680TsuSylCxZGmWr1xRGNpByCNy4k6EZQTBOD/ScqQdcQzq4UJZapj946a
 NNS1ngAhfNOQtvGa5e6g7Karv1Zs4K4cU6r9+lYwDTlT2ahlNkgGFr5vSAMTo6I0sbjQ
 +TKFLXcfuNqYeNEYucKzsZpTt9h/YDjxaBFpJiS+iisHHvix4a32It//193kTVTMk5Lk
 H53g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzqRP4i6+iLzxMXjEUJ+iwPH7cC9MvqYugi/fCzSQHRw3XzY5cC0kbVXg/LmoQcDavgUW2+XJk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIQDZGno4lr5y3zM5XmT39TH2ROV8Oa3zlk1gL4XFZtSDCVd6fv
 utZIPmjIUoRzarTo3Yzlfd+WeSwuiptsJjwtuEpNsTekWCz9dw8nBXNqmZX5LaGlwtOgKzpWff9
 MZRqY/WiyY1MSacI2zT3aS6PV0tXxuNc=
X-Gm-Gg: AYBFou1k0SR0lM2ZF9PxXyGRc4jNFc4irIQYiOqXnD7kudgzdw24Nyi+OFVu4TlMNX8
 ApU05l8GvCEQzmDXSYui+0NHponbeRVNxvs4N/gk9Vw5CDHBq3b8TVDktjvsywwy6CYvVYrgxEa
 1gQyU3oXcWjt5aApYXm0xBakrJplz1f/UUZ2OfiDZo6/BVA2LaAmI1xW7Uuh70dj04shwssx/Xs
 y7ed012HgK7dRC0CDnyDg7Dpsn4/F9UCFR3Bq5teoxzDtjy/IHwPjbPWAoGgsqi+COg/1BmSAF8
 ZHkPMeDkPxd3icDLRU4RS68+wKo8rzyBPDbh1pr1d4j4h9lpxIDsRIv1K8aeIN3XsxV2mK20yMj
 IPUH3du9qrH/C51lMS6Q8Ig==
X-Received: by 2002:a05:701b:4510:20b0:15b:1439:1fcb with SMTP id
 a92af1059eb24-16a5b979b4bmr10870896c88.10.1791761715518; Sun, 11 Oct 2026
 16:35:15 -0700 (PDT)
MIME-Version: 1.0
References: <20261008-bpp-helpers-v1-1-475d1b2513c9@gmail.com>
 <CAFLszTj7kB=JkLx1ws9QbKX682ZiYyy8LHJywzVq_pZnObbUQw@mail.gmail.com>
In-Reply-To: <CAFLszTj7kB=JkLx1ws9QbKX682ZiYyy8LHJywzVq_pZnObbUQw@mail.gmail.com>
From: Reza Kurniawan <imkyufie@gmail.com>
Date: Mon, 12 Oct 2026 06:35:02 +0700
X-Gm-Features: AclHuK_mgmJiIMIAVnrIVjikI6ge8eMwSbDGI1cj_bCvvb6ejuzvwgchPF3K2BQ
Message-ID: <CAAq9HC5oHhXKSEOkeWkvz7F6o9GuWt_Od6dbooZ8kMLFsbW-Eg@mail.gmail.com>
Subject: Re: [PATCH] video: use bpp conversion helpers consistently
To: Simon Glass <sjg@chromium.org>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.u-boot-project.org,
 u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Eugen Hristev <ehristev@kernel.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>, 
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
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

Hi Simon,

On Sun, Oct 11, 2026 at 11:09=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:
>
> Hi Reza,
>
> On 2026-10-08T13:51:38, Reza Kurniawan <imkyufie@gmail.com> wrote:
> > video: use bpp conversion helpers consistently
> >
> > Use bpp conversion helpers for consistency and to reduce the
> > reliance on the specially crafted VIDEO_BPP* enum values. No
> > functional change is made.
>
> Thanks for doing this!
>
> Please can you name the helpers here (VNBYTES() and VNBITS() from
> video.h)? It would also help to say that VNBYTES() is only correct for
> 8bpp and above, and that every site converted here is 16bpp or 32bpp,
> which is why there is no functional change.
>
> >
> > Signed-off-by: Reza Kurniawan <imkyufie@gmail.com>
> >
> > cmd/bdinfo.c                           | 2 +-
> >  drivers/video/atmel_hlcdfb.c           | 2 +-
> >  drivers/video/imx/mxc_ipuv3_fb.c       | 2 +-
> >  drivers/video/meson/meson_vpu.c        | 4 ++--
> >  drivers/video/mvebu_lcd.c              | 2 +-
> >  drivers/video/sunxi/sunxi_de2.c        | 2 +-
> >  drivers/video/tegra/dc.c               | 4 ++--
> >  drivers/video/tegra/tegra124/display.c | 2 +-
> >  drivers/video/ti/tilcdc.c              | 4 ++--
> >  drivers/video/tidss/tidss_drv.c        | 4 ++--
> >  test/cmd/bdinfo.c                      | 2 +-
> >  11 files changed, 15 insertions(+), 15 deletions(-)
>
> > diff --git a/drivers/video/atmel_hlcdfb.c b/drivers/video/atmel_hlcdfb.=
c
> > @@ -315,7 +315,7 @@ static int atmel_hlcdc_bind(struct udevice *dev)
> >       uc_plat->size =3D LCD_MAX_WIDTH * LCD_MAX_HEIGHT *
> > -                             (1 << LCD_MAX_LOG2_BPP) / 8;
> > +                             VNBYTES(LCD_MAX_LOG2_BPP);
>
> The subject says 'consistently', but a few sites are not converted.
> atmel_fb_lcd_bind() in drivers/video/atmel_lcdfb.c has exactly the
> same pattern:

Thanks for pointing that out, I did miss some of them. I'll try to
look for more.

>
>     uc_plat->size =3D LCD_MAX_WIDTH * LCD_MAX_HEIGHT *
>             (1 << VIDEO_BPP16) / 8;
>
> The others I spotted:
>
>     drivers/video/sunxi/sunxi_de2.c:221  (1 << l2bpp) / 8
> (efi_add_memory_map() size)
>     boot/fdt_simplefb.c:62               xsize * (1 << bpix) / 8
>     drivers/video/video_bmp.c:322        1 << bpix             (VNBITS())

Is changing 1 << bpix appropriate in this case? Since bpix is already set t=
o
VNBITS(priv->bpix), that bit shift shouldn't be aimed at calculating the bi=
ts
out of a log2 bpp. Should this be left out?

>
> Please can you convert these too, or say in the commit message why
> they are left out?
>
> Regards,
> Simon

Best regards,
Reza Kurniawan
