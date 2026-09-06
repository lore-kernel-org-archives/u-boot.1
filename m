Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EEFEC79F99
	for <u-boot@archiver.kernel.org>; Sun,  6 Sep 2026 08:15:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA7B8605FA;
	Sun,  6 Sep 2026 08:15:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7v4GY2thkVX0; Sun,  6 Sep 2026 08:15:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 83CBD605EA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788682543;
	b=OhZ5gZ0EtNBooYCs0BdA2g5LDfgHErn3VHZ10E5M8dO3vhUqZn+ORAghtjaaWIEKTTbo
	 QClvJ9s+mpohJredV0A9EbunghPJg5gGEyMM9TTlCr9kUDqlxwqgIEI9PSHIHvHiavqzn
	 l4EV8LyOd7DwyuOx1Vf02URtwLFnbuy4wlxJPF/IOmmqb00gdPrcy/cB7iPquahVxjnup
	 QtkdosryFhnfdYRr+EZNY9mZ8Mrar+s6qRJ0D0tJQ6A3BOA0qbu4f5huHrjlNDzR09yHG
	 3UXDGHHK9baStnLlKOuEyjoK9sVV7EF5ULSUO89ivoltNRKvpBVEgqH0zUhd4mLddmQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788682543;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=eM2OoffhXAwkEynsXzp2Fm2mn6o7hVo7TyZXBgpLlxI=;
	b=d6/QI8J+MX3UQJNcUoA+oHz6H8lB+NsypPq8FWzNPlpVe0Ek/KQ2DG8+BL1wQNyCSsX5
	 jAB57zaab9CbXBYSZ3d7VqjkLR5aWDfRvX1J8P1Nr6Wol8ha5PU8ChNrbQxkaIoZOYJEu
	 9I5y2O1p3Cn3BRw3oDF7j1B4RnPpfQA3b602c65snjSVfYNLkpTUdoCk+gMTruRboHvQP
	 ke+E6QxDN581qAvCo1FF3UQK6RlcRbdMp2feQMx+t4jiepe+MuNuB2knNcfwJ1vPxw3Vb
	 BBBbQhBh2IEuImzF/B//JdUiwIWCF5QMCx5yYHJvapjCoOFrkd7XPu1fmQtLl02U7nw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788682543;
	bh=eM2OoffhXAwkEynsXzp2Fm2mn6o7hVo7TyZXBgpLlxI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ks1paMLke21HYmpZLbnI5IUK0k/k7l3v7ZqpAWcosjcaffFweg6czJ3hvLF2UWSI+
	 4ez0zDSVER6NXF0PAzYFAqLpe7nXBb9S0nxFXgXOycvlaGvtalU2z3ou0dfO/Yaszr
	 B8I31RjA8A1E+5hFUvlJr1CKDQTOgWkLM4+LmLi4U/YV9dEWfztcvk4JUkhE1yma/N
	 K8HtH+kLKxT+DhYlq9Fo1TBZTAjnqTUDnYPJ1sJz+IwQM6EQpjLNzAex/GTa3EITDx
	 2HHPSLJwZzd9LjGZiJVoIAaA8ilsfUqKpUPYMs2Gd2g2sfW+UXa1Cro4WHdAY5XZBy
	 fvuEecfQpHqwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 83CBD605EA;
	Sun,  6 Sep 2026 08:15:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7358A990
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 08:15:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5991E40050
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 08:15:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jarAFhp0R5G7 for <u-boot@lists.u-boot-project.org>;
 Sun,  6 Sep 2026 08:15:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 33DCD4004C
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::134"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788682541;
 b=fw1JoRqEE+jMxpftIbxZ8yBKavtNrSAZB3pWg9bp70Nj3VV25UV/asFJkNf+E7RfEUGr
 nsl16C0Dh037DVezUMmEIH9p5s+0nkix105/xscbxuizNSulc2owzKUtyvWDLFGH5chTf
 ZzrXSZIL3lsxcNieHLcBmIIuRzTPp+THuv5WDZft+XjI0vvGQZVgRiHwYndDA9XE3cUUu
 F4PJ34rtTT2D5YP3tDKFoBiPDiiF+A7AjWG2o1JQ0KZK1eMCBqSgrURwitdeRAmerVOc+
 km9uApO3coMrcQk+kkvL6lyVjE4efBdknjM6sZgjGhed+JGNHi1UyERXE26/nYvaHKg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788682541;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=eM2OoffhXAwkEynsXzp2Fm2mn6o7hVo7TyZXBgpLlxI=;
 b=QXSFB6lgJmVXAh7zu3TjlMi9hDV45JZhgZtGrdfMuWjNHwPQxna7CiU7eRisIoatTPqB
 SaM1dArB1v1RbLJoww2KNNHm7EN+plwF6QMn29EbUrYmT9bv3FWGHFy1a9tChqwzJDY8M
 I2L5RjnCgx+lspE0E+4sD24ih6j9K0JkXm9/pguDMlcRauNm2IXkblEYlt9GRQWiDboUF
 SOn5DjcWFhxVKxQIN/97wfCZiSNy1OAaeiTFBPf94CdkyuR0ceecOmn79WoAmpq4YkrSI
 sVgAD20cCvD3X+YxsnLibeRUO2a8Yy/dbT5Bt4UBGOdVX81AaRpw+b+iRIzzXjXIwGw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=riscstar.com; 
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=pXabDVZY; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::134"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::134; helo=mail-lf1-x134.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=pXabDVZY
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 33DCD4004C
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 08:15:39 +0000 (UTC)
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5b4ab0e4da6so2343645e87.3
 for <u-boot@lists.u-boot-project.org>; Sun, 06 Sep 2026 01:15:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788682537; cv=none;
 d=google.com; s=arc-20260327;
 b=dGBN8vk0InNYN694zVwVhYjv03adPZDcY3noCgm8S5PbUOgaFGIXUvUerozPKoGbZm
 XLONAxMz7Ornd51KTlv2mxU8B/mpvMjEFq/pMfUuu0w7gNOlo5NLAiZqdp47f+kT2h5K
 5nIeJRmjkxaS6eR+CmAwoX7BHfq2WJvJ63vyFwWSOqEZAA4STOrBcdaRC0/yuXifk0ir
 AYjZIe2zskZR9Jg5WmiR3HeipBOWn2D2ZMdSl/DgdHI/wlfbqeeHRHnURib5AL4wdrHK
 ykCej55Ry31QxsTFS/Fd8N4hL5y6e/MXJ8whzM66G25aepQUdnKHp7/2TaPjZ52zdQ/X
 3+4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=eM2OoffhXAwkEynsXzp2Fm2mn6o7hVo7TyZXBgpLlxI=;
 fh=rfIUpixQtBOAmS5RevJVsBSidSRRH2TFoPkxvQ1IwaI=;
 b=dI3ET3dGV/tiL0RTYDsWQTh53t6VxvfY77f48MNnW7Dh21IYK0+rqvEnV7G3F/UaDa
 aMWnv863ax0oSvc6eaY1JePk54SLZ0m2qHEv+ENT5m8yYL0mgu4GQ9ch6UJUsRF9goXj
 AH+P+7TavH3iYRFTtx/E6FzmID8HqMAEqtq4ogKA2l32vMXQtweJq3kvnCRIRt+2pdbN
 dq3rozNZvaFx/g4OpyeP1Xkj9SU/+Frr16e62I3/HLnqEoTN/b6QZCMGsPF+uyvtmCNf
 UxUve/9ffOSvz1V5N7MtSlkPPQXdn7hWZXeODuiv+XGnCG/wE5nbd6DFeg84xoGbMuUz
 YBOw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788682537; x=1789287337;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eM2OoffhXAwkEynsXzp2Fm2mn6o7hVo7TyZXBgpLlxI=;
 b=pXabDVZYJJud9cruUq5alxyY+ek1qfrM3IhWAZvx/YnpZbNWfs6qOw1b+gj0nzm+a1
 vAQtGCau/VMy4PxCGWDfvmJlaA+ptpS704Q5uTr/SYVnCUHkBuH4JJDOMNj/45laK8WW
 RSGEn1/tRPC+7pjM8Vgf53DrBhs5m8p0rlRQiRClHmlNmLkW+W/SIk3wGq1hukyPwLYl
 96CSxbYjptA3Vfa3HyeMIXFLmZvfMdvjHoPVL/dVzPsBI3IFVTaFV9GyspUXb96zLvC4
 Hwexcud0/QKbEo1HOdx9s8dmE58NMnZp4JP9GSgMspsjj7jUdCMFUwHwUydwO/tu5Cj9
 z9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788682537; x=1789287337;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eM2OoffhXAwkEynsXzp2Fm2mn6o7hVo7TyZXBgpLlxI=;
 b=BoN3wd2Lhve23QEfoFbfKtfmHF5nL0hRzVIdAPRn2F7YpDAYJsVIs/R/o6NIjsvZj1
 M0IxBqTotFjhvj0D+skcEq8Fs6wWstpc9HclvfcFUm9Qa6niy7bDPL2bfyIDZSulAFG8
 +Cgx1/ymGQEBHb7ivSo3+5WwwFzPivBWL3XVUfB10Xat+ecQDbgFf1AjDkLTOxa53ZyE
 V0Ibyui1F6bLGbFSk5EMPq5+D9zdrXz394JxWyt2iqAubsGgudHkKDr80FgO/6sBBgPU
 Xvq/VQ4CQgmZFIlBOq5cAQ7hBJJa0xuW4ZIkTPuh7aHDz5P3EkXRAndXCsxqSGW6MXJ2
 okig==
X-Forwarded-Encrypted: i=1;
 AKwUvBy3ibNLWm3SugQ8wNAK4oKsOW684QWV9DxCILw090h3TF9wVntANFWcU1pLUl+emrzGlooSPlA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nYapY9E9BGY5fqi1m7Yc+wek5LSnmjpPskgGOrcvwOmDvjtafU
 JTi2CvQVPiFf9CZXvVOthHMiaTtIJyfg3GiUKr5ENBqTREM2HXSyGw9CkPFCCL380EGS0NJ0hBA
 ZJ0E84+94FIk6YP8JofFIgT39g5UM9IMAHjQpHyLQiA==
X-Gm-Gg: AYBFou3skEFbvyLGk+TqFQWXH3yciVfsf1IkPpv6jr1P+dLV0cU89b0ZURx2BoAzv2L
 fXzsxOEq0petevbOXbGuqCtg6a0p68V8R2Rjfkb0FaTmagND+l28kmZX/+AyBeS8cd6qOj0lq60
 uwBTDaoKMkDbf91gKnWgZRpvOqi27zQ2z1vGwNhwmJTuyZ8oBvjkgRzvpYjwzSBDhQrfPAZBhd2
 dODm4Pg5HySnNxLRDKK9BPtI/MdcOOXuNsG+3PI3FN17QACjebIb2guXPTWxkrghdb/y+vLKBba
 SQjmgwoDkRTcfRnnFvck0ariNCUGtKJgjUOG94RM5YN2ZyPb2OmsvA5F1kKm7FNa3VtZd1ta22+
 oP+QucCSMLQm0M7Wi5paMg0t+RCTco3QMZqgHjz6ZR237JP33YAoQirk+1r2VpU5Kk4rYZEwOHj
 lBww==
X-Received: by 2002:a05:6512:1289:b0:5b6:183c:5c99 with SMTP id
 2adb3069b0e04-5b6183c5e33mr2276651e87.55.1788682537125; Sun, 06 Sep 2026
 01:15:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260824-m4-v10-0-5e0adcb1edb9@riscstar.com>
 <20260824-m4-v10-1-5e0adcb1edb9@riscstar.com>
 <avkysazihbgjh2vsdad4mgw26zhj6y3pdtjbdrwghm5qko4ccg@mggxixrzezuo>
In-Reply-To: <avkysazihbgjh2vsdad4mgw26zhj6y3pdtjbdrwghm5qko4ccg@mggxixrzezuo>
From: Eric Chung <eric.chung@riscstar.com>
Date: Sun, 6 Sep 2026 16:15:24 +0800
X-Gm-Features: AcwNN1WC-2jWxVzisvRFBlwRnbV2uteXj0P4eJV8vcPPI6F18R_hjDDD_BB5cV8
Message-ID: <CAH22mJyZR5y6AUt+DvB-K9fCR=S1PFo3F0EqvV_9_WJike+tQg@mail.gmail.com>
Subject: Re: [PATCH v10 01/17] spacemit: k1: select boot device via config
 registers
To: Tim Ouyang <tim609@andestech.com>
Cc: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 Tom Rini <trini@konsulko.com>, Leo Liang <leo.liang@sifive.com>,
 Yao Zi <me@ziyao.cc>, 
 Wei Fu <wefu@redhat.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Iker Pedrosa <ikerpedrosam@gmail.com>, Alex Elder <elder@riscstar.com>, 
 Andre Heider <a.heider@gmail.com>, Trevor Gamblin <tgamblin@baylibre.com>,
 oyst.lnx@gmail.com
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

On Wed, Sep 2, 2026 at 4:52=E2=80=AFPM Tim Ouyang <tim609@andestech.com> wr=
ote:
>
> On Mon, Aug 24, 2026 at 04:50:36PM +0800, Eric Chung wrote:
> > Add logic to determine the current boot device by reading the
> > SoC's configuration registers, rather than using a hardcoded
> > default.
> >
> > Signed-off-by: Eric Chung <eric.chung@riscstar.com>
> > Reviewed-by: Yao Zi <me@ziyao.cc>
> > ---
> > v9:
> > - Enhance detection on booting from SD card.
> > v5:
> > - Add blank lines around the switch statement.
> > v2:
> > - Use FIELD_GET() to parse boot strap mode.
> > - Remove comments on hacking. Since the sequence between eMMC
> >   and SD device is exchanged in the upstream DTS. So it isn't
> >   a hacking any more.
> > ---
> >  board/spacemit/k1/spl.c | 95 +++++++++++++++++++++++++++++++++++++++++=
+++++++-
> >  1 file changed, 94 insertions(+), 1 deletion(-)
> >
> > diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
> > index d749e21a2d57..b70eed14e6ed 100644
> > --- a/board/spacemit/k1/spl.c
> > +++ b/board/spacemit/k1/spl.c
> > @@ -13,6 +13,7 @@
> >  #include <dm/device.h>
> >  #include <dm/uclass.h>
> >  #include <i2c.h>
> > +#include <linux/bitfield.h>
> >  #include <linux/ctype.h>
> >  #include <linux/delay.h>
> >  #include <log.h>
> > @@ -22,6 +23,20 @@
> >  #include <tlv_eeprom.h>
> >  #include "tlv_codes.h"
> >
> > +/* boot mode configs */
> > +#define BOOT_DEV_FLAG_REG      0xd4282d10
> > +#define BOOT_PIN_SEL_REG       0xd4282c20
> > +
> > +#define BOOT_STRAP_MODE_OFFSET 9
> > +#define BOOT_STRAP_MODE_MASK   3
> > +#define BOOT_STRAP_MODE_EMMC   0
> > +#define BOOT_STRAP_MODE_SPI    1
> > +#define BOOT_STRAP_MODE_NAND   2
> > +#define BOOT_STRAP_MODE_SD     3
> > +
> > +#define STORAGE_API_P_ADDR     0xc0838498
> > +#define SDCARD_API_ENTRY       0xffe0a548
> > +
> >  #define MUX_MODE4              4
> >  #define EDGE_NONE              BIT(6)
> >  #define PULL_UP                        (6 << 13)       /* bit[15:13] 1=
10 */
> > @@ -46,6 +61,17 @@ typedef void (*puts_func_t)(const char *s);
> >  typedef int (*ddr_init_func_t)(u64 ddr_base, u32 cs_num, u32 data_rate=
,
> >                                puts_func_t puts);
> >
> > +enum board_boot_mode {
> > +       BOOT_MODE_NONE =3D 0,
> > +       BOOT_MODE_USB =3D 0x55a,
> > +       BOOT_MODE_EMMC,
> > +       BOOT_MODE_NAND,
> > +       BOOT_MODE_SPI,
> > +       BOOT_MODE_SD,
> > +       BOOT_MODE_SHELL =3D 0x55f,
> > +       BOOT_MODE_BOOTSTRAP,
> > +};
> > +
> >  struct ddr_cfg {
> >         u32     data_rate;
> >         u32     cs_num;
> > @@ -58,6 +84,69 @@ binman_sym_declare(ulong, ddr_fw, size);
> >
> >  char product_name[I2C_BUF_SIZE] =3D "k1";
> >
> > +u32 read_boot_mode(void)
> > +{
> > +       void __iomem *boot_dev =3D (void __iomem *)BOOT_DEV_FLAG_REG;
> > +       void __iomem *boot_strap =3D (void __iomem *)BOOT_PIN_SEL_REG;
> > +       void __iomem *storage_api =3D (void __iomem *)STORAGE_API_P_ADD=
R;
> > +       u32 mode, sel, ret =3D 0;
> > +
> > +       mode =3D readl(storage_api);
> > +       if (mode =3D=3D SDCARD_API_ENTRY)
> > +               return BOOT_MODE_SD;
> > +
> > +       mode =3D readl(boot_dev);
> > +       if (mode =3D=3D BOOT_MODE_NONE || mode > BOOT_MODE_SD) {
> > +               sel =3D FIELD_GET(BOOT_STRAP_MODE_MASK << BOOT_STRAP_MO=
DE_OFFSET,
> > +                               readl(boot_strap));
> > +               switch (sel) {
> > +               case BOOT_STRAP_MODE_EMMC:
> > +                       mode =3D BOOT_MODE_EMMC;
> > +                       break;
> > +               case BOOT_STRAP_MODE_NAND:
> > +                       mode =3D BOOT_MODE_NAND;
> > +                       break;
> > +               case BOOT_STRAP_MODE_SPI:
> > +                       mode =3D BOOT_MODE_SPI;
> > +                       break;
> > +               case BOOT_STRAP_MODE_SD:
> > +               default:
> > +                       mode =3D BOOT_MODE_SD;
> > +                       break;
> > +               }
> > +       }
> > +
> > +       switch (mode) {
> > +       case BOOT_MODE_EMMC:
> > +               ret =3D BOOT_DEVICE_MMC1;
> > +               break;
> > +       case BOOT_MODE_NAND:
> > +               ret =3D BOOT_DEVICE_NAND;
> > +               break;
> > +       case BOOT_MODE_SPI:
> > +               ret =3D BOOT_DEVICE_SPI;
> > +               break;
> > +       case BOOT_MODE_USB:
> > +               ret =3D BOOT_DEVICE_USB;
> > +               break;
> > +       case BOOT_MODE_SD:
> > +               ret =3D BOOT_DEVICE_MMC2;
> > +               break;
> > +       default:
> > +               ret =3D BOOT_DEVICE_MMC1;
> > +               break;
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> > +void write_boot_mode(u32 mode)
> > +{
> > +       void __iomem *boot_dev =3D (void __iomem *)BOOT_DEV_FLAG_REG;
> > +
> > +       writel(mode, boot_dev);
> > +}
> > +
> >  static void i2c_early_init(void)
> >  {
> >         struct udevice *bus;
> > @@ -327,8 +416,12 @@ void nor_early_init(void)
> >
> >  void board_init_f(ulong dummy)
> >  {
> > +       u32 mode;
> >         int ret;
> >
> > +       mode =3D read_boot_mode();
> > +       write_boot_mode(mode);
> > +
> >         ret =3D spl_early_init();
> >         if (ret)
> >                 panic("spl_early_init() failed:%d\n", ret);
> > @@ -354,7 +447,7 @@ void board_init_f(ulong dummy)
> >
> >  u32 spl_boot_device(void)
> >  {
> > -       return BOOT_DEVICE_SPI;
> > +       return read_boot_mode();
> >  }
> >
> >  void spl_board_init(void)
>
> Hi Eric,
>
> I previously said that I found no obvious issues, but after taking
> another look, I noticed that read_boot_mode() is called twice: first
> from board_init_f() and later from spl_boot_device().
>
> The first call returns a BOOT_DEVICE_* value, which board_init_f()
> writes back to BOOT_DEV_FLAG_REG. The second call then incorrectly
> interprets that value as a BOOT_MODE_* value.
>
> For example, BOOT_DEVICE_SPI is written as 8, which does not match
> BOOT_MODE_SPI (0x55d), so the second call falls back to MMC1.
>
> Please keep the BOOT_MODE_* and BOOT_DEVICE_* encodings separate.
> Sorry for missing this in my initial review.
> --
> Best regards,
> Tim Ouyang

Hi Tim,

Thanks for catching this issue. I've fixed it and submitted a new
version. Please review and merge the new version.

Best Regards
Eric
