Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C0BCD4F25
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 15:05:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65F50846FA;
	Fri, 15 May 2026 17:05:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cULgwFOw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A2DB847C5; Fri, 15 May 2026 17:05:52 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28C73846BE
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 17:05:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-67bc6098640so15492205a12.0
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 08:05:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778857549; cv=none;
 d=google.com; s=arc-20240605;
 b=IXigxpF5hKcjDXV87tOLsFOe//nj0bpfVF6PazIYUf+yI/EVpNOEAJafaTnc+xQr+X
 b73awyAqvGYShvaTiRHje6r+MQcXn4H5iK8H6u/QuVhZeUQKhJbzlVBiC3ECtr7V5y+f
 /UoF0rwvrejD/Jtyx63qjMDZhhZ1WLBexsyk2eS9gsLIuaInEkmWe7J7fwN3WrBFPnyX
 CNfIbdXj7iYL18o53J3WUS643nYA+MM0pAr7e7yhsdF7Xx/tUB8PR1sJ64vLEFSIVpGw
 kKnyuLVGK/DyzVep4UICi2POrM4r/NWNpwGMwZCE0dmmobuBlr6OsnLffWWM47asvn6y
 BVJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=At3R7LuJMxOXVnvdecSJUxIxrwKq96k3XpL1IUZeBfA=;
 fh=bnupiERZn2PI+MmEvXIHvRvb/x9C+g9PVm9rW1kLi8I=;
 b=JzdDpP7pkmMiP/ZV2Ux50WdvfnRXQFwTLnKbnSVro3902m6ItqugptY/cyuHWuNPFD
 EsBOlGNdMdSiHAWIayWAKX4+ATWlgkM1JUCc6GTXkrX53v7L/qQqqrjbNdsWW4hlO9Cq
 PxvAMYHnTj4vvn+mua8GFW/UV4oD/QDDVTSnjOMUc10brxBrjUvyc/+PvqspKvZ/ArFn
 cZ9XAmhbaGrBRfCpvJa39eef2ReM9+P9ZEd9nss6qr2ULH2LRh86Kiw5kYCSrjkhNNPl
 t4ps96FZsVr6bpAMGPUfJIeInwhnc5tt68MdUOSIOvUMu+hcqn0+udDPfdBcmbeDOZc7
 ygNQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778857549; x=1779462349; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=At3R7LuJMxOXVnvdecSJUxIxrwKq96k3XpL1IUZeBfA=;
 b=cULgwFOwiVNXRqSX/I7l6lqkmf93Ul3Pf2RcdzoWKi6Mka04+b7iaZTvzxy7sbhafp
 69k1gFbBoOnFOMWaD+WmDBmwYQiE9RfEeRMtwdudWjo8pUTaHwNF0JVaroB4tiTNkmSe
 sWn1uKlnsxUDh5kY8IQnAD7UtJdiQGOFbUFzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778857549; x=1779462349;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=At3R7LuJMxOXVnvdecSJUxIxrwKq96k3XpL1IUZeBfA=;
 b=WwFl7D2S99ibiT4f5HesQmY19YAwE9BA6VENNYPy3tTa/YKkXQqYtl8/bbcQDHxWPj
 Y1ugG3n3e34o5k3b6qcFvAF5YmZQO6zb+TdGYqZImg1P1WXKGX5G44p/dQYOjpnQ9kJA
 lxFgncx5rklw5FOKnnBEVPlajP9gyk2SUuedKOaKZ/U768tGeLXEvqswZPRC+XpvH+v5
 3DEQ5a+YN+u3pYpBAacrU08YrpcCyORehL0e2zgNztcYUObIMtF03y2aBNB/8610tVDu
 oQUmLIQh8sUGSvjK0JRZBtsv1ykpaGIq59V3ucdQvpMjuZCvJIgVMNOQMm2ajGr9/R3C
 LUVg==
X-Gm-Message-State: AOJu0YwNSSYZf3DFAXivi54q3YN4K3PjVv0B/GoYlh/a/FDXPVTFUv9F
 i2tI9fVL5nap0CRmAJ0+/avauW2Ofanmmy1NkuNXP+N+Zmym27dF2AsCwB6ZDXXrZMvBisNp2fu
 55DxlfYN1ITvzg78QID1FyK34Y/y9wd+82vT5IPVr
X-Gm-Gg: Acq92OHu5ld2xQdLmCpK9VKk/uJ3/bOZIicCr3/cP+LlnqvHPqK+2K8RgE0edu1w2xP
 ur8mew8PafU3tUQk5bfHd4M/Q/BKylQQJVvyV7Bs8Uxx6b5KzHLzFqbK3rXJTW/ni0rN5Dh0PNJ
 NroTLZJrmNuw3/35uFxI4HIqnobCtAJ95OR+Nr4ZTsKat7i/GexqeM7D96dpYbjF1f4sCAcu/WH
 KVAkycZNBLGKh5UFbgxicxQwYmXhg4zSHwKCnIEmP5adZzUOgVHxW8H/Q0rgYYGLGh71XjoKqcO
 2Jr6H8yfVZ42F3Yp
X-Received: by 2002:a17:907:6e86:b0:bd5:2cc7:d845 with SMTP id
 a640c23a62f3a-bd52cc7de89mr78557866b.30.1778857549321; Fri, 15 May 2026
 08:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260511220555.GM1858239@bill-the-cat>
 <CAFLszThULFjq_R4A1nWYjQcQ4Odw3aZ200RPmQ56Ecf3gO4UYA@mail.gmail.com>
 <20260515141043.GY1858239@bill-the-cat>
In-Reply-To: <20260515141043.GY1858239@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 09:05:37 -0600
X-Gm-Features: AVHnY4Im8Cr6zB_EGkx7ivu8Qdvcc1QpHWZqnHbGPS6uo6NFcD1vxI-5QiHSe5U
Message-ID: <CAFLszTg8HQK-tkCnGkH_Reju6frdNzPZNF6d+ekwKtWvWTrLmA@mail.gmail.com>
Subject: Re: [ANN] U-Boot v2026.07-rc2 released
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot-custodians@lists.denx.de, 
 u-boot-board-maintainers@lists.denx.de
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

On Fri, 15 May 2026 at 08:10, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, May 15, 2026 at 06:49:25AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 11 May 2026 at 16:06, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > Hey all,
> > >
> > > So it's release day and I have tagged and pushed things out.
> > >
> > > As I mentioned earlier today[1], I would like to again thank DENX (and
> > > the Denk family) for supporting the project for so long, and we're
> > > starting the process of moving our infrastructure to the OSU OSL lab and
> > > the u-boot-project.org domain.
> > >
> > > The delta between -rc1 and -rc2 looks OK to me, and I do still think
> > > there's a few outstanding PRs to come in and a few things I should pick
> > > up as well. But, the next branch is now open and so bigger changes
> > > should target that and I will be applying a few things there shortly.
> > >
> > > To repeat what I said in rc2 (and will keep repeatint) is that it might
> > > really be time to retire support for running our tools on Windows under
> > > MSYS, rather than something like WSL. The move to support more modern
> > > OpenSSL versions has hit a lack of support problem in MSYS[2].
> >
> > I'm not really the right person to answer this, since I'm not a
> > Windows user. But as I understand it, this would mean not building
> > Windows executables anymore. Is that right?
> >
> > Should we perhaps just build without the pkcs11-provider feature?
>
> In the age of WSL, I'm not sure the value of supporting MSYS. If someone
> is using this, and steps up to resolve the problem, great. Otherwise we
> should end up dropping it. Unlike the macOS side, we haven't had a
> report of a user in well over a decade I think at this point.

We were certainly using this when UPL was being worked on- 2023 I
think. The Tianocore people use Windows and needed mkimage.

I took a bit of a look at what is involved here. Basically with WSL
you should be able to run 'wsl.exe mkimage ...' and things should
work. I haven't actually tried it though.

It would not be too hard to add the package to MSYS, but that just
makes it build...it would not actually be useful without hooking into
Windows APIs about which I have no knowledge.

So I agree it is best to retire it, perhaps document WSL as the means
to run mkimage - will we be able to have some CI tests for it?

Regards,
Simon
