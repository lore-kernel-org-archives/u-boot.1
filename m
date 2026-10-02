Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 330E6CA5FD4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 13:06:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5BF3C81235;
	Fri,  2 Oct 2026 13:06:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0FIEPhvMnBH7; Fri,  2 Oct 2026 13:06:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 87D5181230
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790946383;
	b=fBcacRfY/19VGewyPN/VKWzLCY7NXpm1oa9SLvsBgW4D8d2K+VzzlDZyu02srJwfOS/g
	 Q9ysDrwYyuGWI+8Kxuz9gaAqUDNtdP2rhYUaKnJUaiXn/RMswZZ5RBmO75qfxy3Olxdq5
	 39DzFtfoDbQkhwY+2arBwl6oqpUYUAQyiNxVPCrglMYAv3hukZa/QagGHDb66L9xbkoN/
	 7Qhb02QRYFtPESgIHYq5elVxnY2zPMUFlz3OOZuChlOvPaLI2fH91PJPsK3p/7Bz6o/bU
	 OB//ZvU8vlutNf6ERGMPF6UDsUSeq1ATrNwJbFAQ+enjO2MDOSxYHboT6fOenGkUOTA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790946383;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=creoGRhEJ3H9W42lqGOdMGhWdIzKhEne0BBl6cWmVQk=;
	b=UtBaeSX95+RpsPHF2eyMRqOWcxYy2rMt6cV+iarLo+hTPHBOABYcHYRM2a7CreNN4hGj
	 tYKH3QZAvNYDyhLu4hLHxWI4AXwj5l3nn3Xq4Npi9OFL6dgFWQNGUUEDjnvxh8HCPZkYT
	 XiFrTk6AcrzzbOnSGLQjapvoRMapBWRcKuqQ9iCZXnEy2RZIyWMs1/XIdtqpYYJNbfoxs
	 KYQv4cehe93jbjwEs70hXDB7Y2cGLQneTrYjEFKuCY2VBcuUe7m+x0UIEJryqvw2y8MDO
	 WyE046jHEeRYmHNE3rKUpjd7bNeiVPxd87c9XZmBpQrKi4SaURqa48ucCkWEtevdYbQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=r9bnJwb3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790946383;
	bh=creoGRhEJ3H9W42lqGOdMGhWdIzKhEne0BBl6cWmVQk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wknW30D5ejJH4GzSQU0jluHA4oYHUJM1cnkbIVIC6RLJS+fFpxGla0tS5nKMLMVIk
	 n9KICph0L8ggQ30zbY9qX/+dqqgQKogjlRHEduWYRgh9QzIcdvcu2G105cBcLWfCTJ
	 CGs1AwBNLqbBV6p4ELisGhYLyyfpnh4dimtAkFKYbpt3mgm3oweq1D8UQ0dJMwEdxP
	 qUIKyrpHOs8t/m+1xjWknoVpNdHj60PrrIbJ6BgBH3vMOVQYjEeZwgbGBV12NvEoRf
	 kL7PDQbzt7a4q2scmEHLlt5iOK+Ewz69Tg7SRdhtxjh2zL8rd5bTFH8hqLA3bDnMCO
	 pE+RC67dLXpzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 87D5181230;
	Fri,  2 Oct 2026 13:06:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1ACB732F
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:06:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F3A0081230
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:06:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ydirWi7W6CNL for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 13:06:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org EA1268113C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:34::d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790946381;
 b=dMbZ/kGYqkPH+P7JEj2oUmfvFFPTbqmQ5JiYgbR+Aq5gq9mAWE5t+d1RfyrOPmGB5bMX
 JTALuyBF9eSg+0tnuY+Usnw5Hb+fIgQK0lMRj8oheGsmBNv9aPDuYfbtM8ZzC7aQJ2Q2o
 GsYoDjl1TnaR6rnp5ehg5g5z/+d/Ocgw0cq2an9rKqZLpq5+wLFqbPoTBc6WQks49xPPk
 VmE4S1JGRpbOY6TJD7W2xRu+hD+VUuQIX71TfuYdNomupoTHANiyETJ6Wcpr38Zh/02/J
 pUY+xq/yqY04kZZvixn3ag/0eUkGFw7StuNgMCE6JX4cyKmyJV9qanMOgUVrQvZ7TuA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790946381;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=creoGRhEJ3H9W42lqGOdMGhWdIzKhEne0BBl6cWmVQk=;
 b=bi0XzNaM91Xzvv+RcVAOjHJeZDoDhjAqAJG+Ul+c8iz04Ozq14w6bX9Dswh7loUFxeHC
 hv9wb53wXVLYlfIgLuhh9V0AmkrAeg8GqCAKyOm9xrzdxsJBdBnDKEbUrnzTbFNAQ/T2l
 c4oHn5afsKVwA6v4rMmUVLlH42XhQRqz3xSn2eKPbnTgaz7LnNrjBlI9GJ9bolXogMVMV
 oBZUeOOo4RarlGA/IU0VDfYmVEoMl0K3VQ/2kAfdWH9zfPDMX+MOu5wLkdmkLdYRoWAXW
 cyOop3N5vM8jw+gWkmwVIwFq90lJkMusSRkWk2MbySN+ehNJyL5LaeYJ/HbMWYsYv3g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=r9bnJwb3; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:34::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:34::d;
 helo=mail-ej2-x0d.google.com; envelope-from=alchark@flipper.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=r9bnJwb3
Received: from mail-ej2-x0d.google.com (mail-ej2-x0d.google.com
 [IPv6:2a00:1450:4864:34::d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EA1268113C
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:06:20 +0000 (UTC)
Received: by mail-ej2-x0d.google.com with SMTP id
 a640c23a62f3a-c2e01f5c0aeso1137466b.1
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 06:06:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790946378; cv=none;
 d=google.com; s=arc-20260327;
 b=VehEudLDCtQ72ENS9ms9X2VCXGuuyNHYKaxDxLglWwvoQ5di2dMvFJDIGNxCZi2RU6
 h7PB9dun8ZDbegn2U6CuTcH/809eXTd45F6rHdDE5Y2O2ds0nxWkj/uE+hTLIWe0U2xM
 eVa1oD+p5qHHPWM+fzI0dbIae+5+m7LZf4jOuAEyBkxjBmcPecCPbkanGeR21JBJkPj1
 Ur2YHH8OQCZGnbhRh3IOo4yuQJ0q+TfWJPX8jjPl1e5st26FY71couFqkuM7YzOmOgk9
 cCO0xFGV5zTXjGudN/JmFRyHUJ5iRKKYgKubLLOWFI26yEZaPBc7+eQlIvjY8b92l+a0
 Ae9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=creoGRhEJ3H9W42lqGOdMGhWdIzKhEne0BBl6cWmVQk=;
 fh=gGIEZCUd1EPXQ57ZrFxq8R0YkFiEQsmyIp9rBcYCt/Y=;
 b=ewqisVV15PjykSuNxrFl7cwthkE0MUMdODjinEIPKhBI5iv6Jx7wkiT2qojTgfzUEg
 jr1+uhenNL0ex10nOA3OU4gdkSnc4FoymWA7JJmxYc/d/zWfOvvn+PayWX4Ut4z7PYi/
 g2DmCkpn9eMxM6urtrws9poy+lliRONjRqCqQ+66HM5juFfABhLV14CArdLjDhng0Err
 dbSxtACm6vzBe3v42ByohzhTOrW8fmHzUvE+Y/EOy4PtQZNnbkaXVaG1YnqeOrFNfLTy
 GNkk7+6ZYlfZks34LvYkx+NIlXVYu3OpDzuWII8oJQf3FtxAPl996hF7Pue2Y+urws8H
 sxSw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1790946378; x=1791551178;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=creoGRhEJ3H9W42lqGOdMGhWdIzKhEne0BBl6cWmVQk=;
 b=r9bnJwb3xz5Z+DPLz6KN6m6TLRm7wbrbKcHP+lHUaxjGcvkSNYby0OHymqjwi4wnMC
 dJVT8hoM7eHqvY16EtaJRHsfdf6PvK8gJY6szOQYpdC7y+H3PBRJC0NxjSzIR+lNiQ9p
 67Tqt6lJqC9vsB61RVXNLNqa4NFDQ9qAWFsCtDs9lCei7nwobWNMUtbvRYAtCCR6NZAR
 cPhbFWakPa3v13bsQYn91iV6S7M7oD9PAJQ5g+s+nML9J5U7GV2HwKoRsnX30w7q0zUh
 Ub0Fcy3BASBPSYuMh1NtBDf/bH2otUEM2IRRKBU5HNz7AznxB/OfKiTJzGjNhAPlaoHD
 +cpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790946378; x=1791551178;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=creoGRhEJ3H9W42lqGOdMGhWdIzKhEne0BBl6cWmVQk=;
 b=hH/DTbqLf2R9rcyjtWKEeqNYfOFBa5wfN9Fi6CXohS1vsmDPevwiOrZrO6Lc4Md9qM
 hVpzibziNrPrWejhONTZyQSlQAOKkGCPAiBemvk6Ork2EgwwqVl2Xtqw5DronGnJ0he6
 76YvRS2q1IvzY43hGjOyzYhihagBWEL8NKBGgldE79CES8halt0pPpIbslHKMWTDmvUy
 iQz04yJ96J4gSed0vghlrWKIT+Gf9ND4qa75hck3Zq1nnrZDo5wnaW8kr5Wjor6adwLy
 yNzUYqHIB+hqhCJrvBKRNQwWrYt8w+dZjfqZu7qVbxWpFemR8YYxTDUy8aXftuPU6svk
 EvwQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxnMe+zMWyInkzQmQ0TRviSd2LnryW2NQxQ6jqEo5MLEtjwwt5DuAWxS91MvUgcbuNyiPMRQK4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mPt0gzVJ3Sv8/4sN7nlpFdhJ+zts+qVDpTkaKG9ZjoIQzvyY+7
 FLLYsnPejcHkgpv6YTRu6yYdC4/mFV4f8NAunz9iZp5dVSJFy/D1emH/irA6D63M5XVzQU2utlJ
 01YvIGsJREx7g80BODxyxTdASsaJHaGLGaQEMXAP2MQ==
X-Gm-Gg: AYBFou2m0DRHxzsgBw2g6oSf7rEMu8UqHmoXtz9jLh8/Hcox2tekLutVpF9t3uHwVPH
 pUEuWEIKMRI2ItV4/A5IC+3izRtYtgEpYsqj/5RSCJv+kRj9iv2vqOXIvvBz6aHXlHqgM4loikY
 FELTsa5Jru808Tzlfyriqga0Uf0Iq/d0XxZxL/SS4tVmpWZcqOYLGwEJOvpjosKFhmgvsocmnLl
 9cqr6vJykcTAPYOk2LYx1qkfeNhEnoEOOyF0YhtdwvqVLpcRkFxCUDbZawOUhpqkpF69Z9aDg2v
 9W8cB7YOz22X6+6nkhqtTXtvkVScUpItQHlEVvqiHm4kFe7jwmCB4Rx+XzkKKqnwe2thp8egv+u
 lRL998QqPHzT7
X-Received: by 2002:a17:907:6d24:b0:c2d:ca8d:435a with SMTP id
 a640c23a62f3a-c2e4af80457mr206269966b.38.1790946378172; Fri, 02 Oct 2026
 06:06:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
 <20260918-spl-fit-compression-v2-1-28e946f57357@flipper.net>
 <69076012-7d9c-4603-be4b-f39beebaf9f3@gmx.de>
In-Reply-To: <69076012-7d9c-4603-be4b-f39beebaf9f3@gmx.de>
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 2 Oct 2026 17:06:06 +0400
X-Gm-Features: AclHuK817DvvWgkQualJjfsvldjW9FZm2_65k_NT935YDcB7V-AOYp5kXKnaAkI
Message-ID: <CAKTNdwG+D-fQATccmF6ns9p-Fj=OmF=MuvV8Uz7jXqhzF8S1Lw@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] boot: image: Keep the image-type table out of xPL
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, 
 Cole Munz <Munzzyy1@proton.me>, Richard Genoud <richard.genoud@bootlin.com>, 
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>, 
 u-boot@lists.u-boot-project.org
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

On Mon, Sep 21, 2026 at 7:45=E2=80=AFPM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 9/18/26 12:52, Alexey Charkov wrote:
> > print_decomp_msg() names the image it is about to unpack, which drags
> > uimage_type[] and its strings into any phase that links image_decomp().
> > That is about 2.5KB, measured on a Rockchip RK3576 SPL, spent on one li=
ne
> > of progress output in a phase built for size.
> >
> > Name it "image" there instead. U-Boot proper is unchanged.
> >
> > Reviewed-by: Tom Rini <trini@konsulko.com>
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > ---
> >   boot/image.c | 7 ++++++-
> >   1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/boot/image.c b/boot/image.c
> > index 185d52ba492f..a7dc69e858ad 100644
> > --- a/boot/image.c
> > +++ b/boot/image.c
> > @@ -416,7 +416,12 @@ void image_print_contents(const void *ptr)
> >   static void print_decomp_msg(int comp_type, int type, bool is_xip,
> >                            ulong load)
> >   {
> > -     const char *name =3D genimg_get_type_name(type);
> > +     /*
> > +      * The image-type table and its strings cost about 2.5KB, which i=
s a
> > +      * lot to spend on a progress message in a phase built for size.
> > +      */
> > +     const char *name =3D IS_ENABLED(CONFIG_XPL_BUILD) ? "image" :
> > +                        genimg_get_type_name(type);
> >
> >       /* Shows "Loading Kernel Image" for example */
> >       if (comp_type =3D=3D IH_COMP_NONE)
> >
>
> The print_decomp_msg() output is irrelevant to end users.
>
> Do we need print_decomp_msg() at all in XPL?
> Even for main U-Boot this should only be a debug message.

I believe it is a helpful progress indicator. End users would rarely
stare at xPL console messages if everything goes well, and if they do
stare at it (which requires having console output, a debug feature,
enabled in the first place) they'll probably want to know where
everything stopped going well without jumping through too many hoops.

Best regards,
Alexey
