Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF99EF99C1
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 17:53:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0A7183DE0;
	Fri, 13 Feb 2026 18:53:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="a00q3XEE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0ED6A83C4B; Fri, 13 Feb 2026 18:53:49 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FE2D83DE4
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 18:53:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b8fa7e3672eso167008466b.2
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 09:53:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771005226; cv=none;
 d=google.com; s=arc-20240605;
 b=QnVAgcJjUXstGM3fccHZaPVzV4H2rlYjE+wTKjDZbZz8EsjuJVOC6/CLo7d0O4xVS8
 ekcQiO0k57RzJ2DNjQzAsBZNM4+XiOZWfn72tY18nSgeynh13r1e+MvU/ljJM+3XmYLo
 xZ340110Om6n8deL7uAhHqdmVTGqC/WaQ4Rtgj79WHWMZTwo0uPgy7ZAiwfHPh3ZMCT8
 4UfznB9+U2ImJEiyKn+d+QxMfLl5ptXYGf0VKNGwa2F6vxf8lP5lJmOLjgsBJACjFzOq
 V+x2uP/DgEUyC9HfGUeaYavRIek1XX573zpyBkI/gxL23Az4LgtgGvC4gT/eMSo4SlMV
 3JTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FOWivUcSHOt98QrOD+5z7glXFynX4hrCMgTEsXHkRqU=;
 fh=UFOIHENB9OyRLHo5EhMU/+v3+TTyRpbYR3vEGQnBiZA=;
 b=QIVTrUHD3tu4GQRR2Kkp3DURmwAnTUeBq3jvUx4QCNNsuxP4yWdbZSmavX47TfwPBt
 jvAWTuMghhQXdr16lMe6kUfAWfEio4lkVEv4BGImbBy6uxQSAOx6NH+L5mXqpUYNjt08
 mDv8FnJkRzfdLTs3IU91q0blQr15QWvlgQqiPQlb40p55zHQDh3cSDfuCWCPWdUyN33/
 m0Q6mbuP/yK6o5yy0WDvp6ghiHHErYiIRxoE/lF0ndNJX4u00SqLv7KX8ybIzfI75izF
 KMsK51adKz1y8jzwUrq1NXtt6jCfT9YCZN4rks5XjwbRvCC3aoVjr+XC5QUjbPWzx37s
 e7ZA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771005226; x=1771610026; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FOWivUcSHOt98QrOD+5z7glXFynX4hrCMgTEsXHkRqU=;
 b=a00q3XEEZE+SFzblAGI3mBGZuaiQ0SpojuqDM1VPFIIThx9I1DIpiXDb8uNWWAbVAT
 FF3ZFKO+F22k9AMT9Jc1JGa36IYCLEFPs9L2wKy39OkA/alPc5NnWYvfBzVMC16cSPgn
 Irz0Ao/mTgJ9YgXWgZ+iTcRRQfApV3JPe/mkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771005226; x=1771610026;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FOWivUcSHOt98QrOD+5z7glXFynX4hrCMgTEsXHkRqU=;
 b=bL7EkiRDgQs/p6GhzIEQld5Kfmks4kYYql1CyuzvVwnGe+k57XPvUa1hcgX5alocz8
 Ast7YKQ2tadXNa/VPOZXvC9V1H2ziIc3+vn6D9c37DWlQwuIhAPvydqUcaNxba3XVZHI
 cpCtUZeBnWR6CKey7ujW2SCmZhLXVe+CKDb+jIDIqDdR3PyPNH/SIMV7aB+sBix4j5PC
 td2y5sve9giZbPE1EQazD+fVJ3Xa5lSkqLevrnmM2MEkXh8rDTnansTfaj/YLf9nnTvg
 BLjscY8O/xY2NVbvHwNfGVlVJd1NYh9NnnQ2tE43I6MoHsiySe4yR61KZjA6kSQ/bzTJ
 iMgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhOh+Jtlc5kePOtUWLNKUDHhZr3VSiCTtSdMUNljSm5Aw4NK38Y4IrOx9VZwKhSx483rLIKJg=@lists.denx.de
X-Gm-Message-State: AOJu0YyEwh3FIphbDrtWUYM22JblbycNXpXAMW/d3LSH67xoMcI7CWc5
 5ehHD5Rcrc0B0jeKRqQyfqPfZ8fRFHglhRkmoWDl27DEeUizQmg6TbZ/kxXlrI7uVSV96SPsPWz
 SSvfkXK2cYReVPZ9v/rHoMaXP0vZp7PIUYc/6tz+7
X-Gm-Gg: AZuq6aKhLbUv59MfJrHiIvGT8fECKoBokHWtxri4BR2oqRbMJxdozD9hK2XcKR1iuwv
 LafjPKj1rCMwckORKrModO/fLhsb+kcYPcQ4lFFXinUNuETBFdedraRDnkjs9g/9VFn0LB7lyvw
 zaaBv7dM93BMx2v8t/3WtoV03GbwnWadxy6k/jgnLMsF+UiQXy2wecLWfEYW3hrjKDKQOBWJIkI
 kveEtwYxGNYtnE40uf0fU18aigMmtfMwxjmh9bI7t7dkq+uAgx/sr69fLJVVm2fGT+iAk+jxBqQ
 jkjdZZOMbYZynjYy
X-Received: by 2002:a17:907:c23:b0:b86:ecfe:b3d with SMTP id
 a640c23a62f3a-b8fc3cb8f4dmr16943066b.43.1771005226409; Fri, 13 Feb 2026
 09:53:46 -0800 (PST)
MIME-Version: 1.0
References: <BESP194MB28058C540F0C3D28F4D08541DAA3A@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
 <ffa1bf53-9d40-4297-a30c-ffb9d8113820@linaro.org>
 <20251209141706.GV303283@bill-the-cat>
 <20260213165658.GJ2747538@bill-the-cat>
In-Reply-To: <20260213165658.GJ2747538@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 13 Feb 2026 10:53:25 -0700
X-Gm-Features: AZwV_QhG2DDfIjesMMTVTUYQM4ObsB0Iw44ZWs03KNG8QKE8XPYGNFByFKnPoKE
Message-ID: <CAFLszTi2dWCN+rhXDkBX33ph4ww=6RumXAPECY5_MdzkcB3edg@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi: Add missing free in sf_get_bootflow
To: Tom Rini <trini@konsulko.com>
Cc: Francois Berder <fberder@outlook.fr>,
 Tudor Ambarus <tudor.ambarus@linaro.org>, u-boot@lists.denx.de, 
 Vignesh R <vigneshr@ti.com>
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

Hi Tom,

On Fri, 13 Feb 2026 at 09:57, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Dec 09, 2025 at 08:17:06AM -0600, Tom Rini wrote:
> > On Tue, Dec 09, 2025 at 12:16:33PM +0200, Tudor Ambarus wrote:
> > >
> > >
> > > On 12/9/25 11:56 AM, Francois Berder wrote:
> > > > Free buf if spi_flash_read_dm fails.
> > > >
> > > > Signed-off-by: Francois Berder <fberder@outlook.fr>
> > > > ---
> > > >  drivers/mtd/spi/sf_bootdev.c | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/mtd/spi/sf_bootdev.c b/drivers/mtd/spi/sf_bootdev.c
> > > > index 017a74a3016..720faf51a1f 100644
> > > > --- a/drivers/mtd/spi/sf_bootdev.c
> > > > +++ b/drivers/mtd/spi/sf_bootdev.c
> > > > @@ -35,8 +35,10 @@ static int sf_get_bootflow(struct udevice *dev, struct bootflow_iter *iter,
> > > >
> > > >   ret = spi_flash_read_dm(sf, env_get_hex("script_offset_f", 0),
> > > >                           size, buf);
> > > > - if (ret)
> > > > + if (ret) {
> > > > +         free(buf);
> > > >           return log_msg_ret("cmd", -EINVAL);
> > > > + }
> > >
> > >
> > > can we use a devm alloc method to get rid of the extra free handling?
> >
> > No, because this isn't the kernel and devm alloc doesn't always free
> > here. Making that no longer be the case (always freeing) is on my list
> > to look at doing (drivers that use devm alloc always implys/select'ing
> > DEVRES).
>
> We've since changed so that devm alloc does behave in U-Boot the same as
> the kernel (except in xPL phases), so Tudor's suggestion is a good one.

I still like the idea of having this patch so that others don't hit
it. Does it show up as a leak on any code-analysis?

Reviewed-by: Simon Glass <simon.glass@canonical.com>

Regards,
Simon
