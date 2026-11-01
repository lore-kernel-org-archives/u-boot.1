Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE15606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 19:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=f1O4+QIP;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=UQmTZP0E
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5439C80CA9;
	Sun,  1 Nov 2026 19:24:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lE3g-bs-4PwT; Sun,  1 Nov 2026 19:24:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 88A4080DB9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793561095;
	b=CdftiTZ8MhNPG0CQn56RoKUGL7/efIJAXIMgfXl/5ybsqvomfZYXyp3NKC2Wp8oj+MgA
	 QKKav0lBJ5DvJMCYLdSzHAfpcQkuIStVlvTrriJfHCNt6qI+8xYzLfnhla3b1o3PlRI/y
	 8qD70++s/JDVI2ChqOGzfG532PqFKVsWF3uMsmUlta9J1FJcK9PkPgWbbqZLmhEO3A2Ou
	 5RfzvYP6/+I3SPiLOjwcQRPtmC2+IQ8KNliHX9GLIrc1XcrKCqYeV41ZBlrAth+xbZ4mc
	 LL/550VDCjPzd4EavISD8bRcLvPi04hHFEKuyOIrwoPkSvTqggbZR5mK7Hrr4sf9jqw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793561095;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=X9QHcAa7IMPY6sOZmxMedVZGLAL/E9xS3u1zpI5Ha0o=;
	b=WDnCRe4+kLneG/lY+oAfZ8YZp45uz4g5fdoAtq36wj2WZsp+aXvys//XHz7f5xTvWBRb
	 hcc0hwywAKDTObeI4930oCbqTY80yQ57ckXv84rUlJDqLSFUTcyIbo48mozwNB/MaYLY+
	 /WiODKTuZTp9HhwvglDM2kUBTl9aRCLibmWzfbkk7Jv2LR8XANKyVeXQtp9uLNRGqubLp
	 dQtNEvQmefcd5mOZe5d7/IxWtzwTKnx9YH1SosoMcotf52uebcQYf5f7k3cceEQKriVnN
	 1Wb4Y4hMYWbq5JeiByzHyFYFsKWnTbL5484PgEPChtV01S2q+d7iEegd1HdbiV+X9tA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793561095;
	bh=X9QHcAa7IMPY6sOZmxMedVZGLAL/E9xS3u1zpI5Ha0o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f1O4+QIPvIaVpFCW+4a1BbSSnDFCmoaNUDuW8BgyhJ4ZOjBC7Pw7LrtiSWSdOXb3x
	 FbOHNyLPHBvZwLEcYF6rrZnS92cqDG7kS5EQudzMBPkfDJC2e4nFNcj/T20h6tiDym
	 LzD2MQkHOua2bJK2FgeWRgQ72sEmOPnms+uOj4k77t0PJvBMtT6nPXenKa4ags33J0
	 h+aIRN+wvJNEi5fbFFW0pvYu0vUlQyKkYB/oetVEqaq0d0dP8/WAGuGZYQidlYuDfP
	 23C647uLB7KOLOGxE4hvdxu86kin9zyj1QlrUH55brrdrZbXuJgpek9TXItdRKuQVH
	 vA2KjtuP3+aLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 88A4080DB9;
	Sun,  1 Nov 2026 19:24:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 496A2EF4
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 19:24:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2FA8760602
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 19:24:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YGu0mkjgzBG6 for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 19:24:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 174BC605FA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793561093;
 b=KnXKMBakEKNL2L47lX7YBvWBOUKW91lDTWTyRnnjWF2QZWahOjpUZ3C630c/Xq0ngUHp
 ntdAexeTaTAqps7CW9hUGHu82U3jKkQULvNhVC5tFWawFX9YkRMK89t5RJoklWPyd1suW
 bO33+OhCrx68PP1IbX2FwbJqfpc3JztoQnvYpbkGkOBVSXivItqTkzq70YX2NLZ+Ondxx
 FzBMizAl9qyDF/A1rr6j2n6RdA/TcZcrHPmK8xr4NSTKGpsVgT9ZTki0WPzp1uK4otWzk
 PqEXOnq8Z9tk51BSDDPePc4unPKZ7fJB3Jdf3gZCdWpkE9LEyQ2CGnJdIP2ODkVZflw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793561093;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=X9QHcAa7IMPY6sOZmxMedVZGLAL/E9xS3u1zpI5Ha0o=;
 b=FQP7GGhnEyGnO8hJ19PuffvqNnhkAGoLhKWO4wgGamkfHXJlPNCzJL0czyJ46qRNgxAf
 n6ptY/V0QdOjMqcWI3p5wQWy4HcEZHrdde83JZlOx551HiwyUx2HAeUcXpISZ3ltWxCvK
 IsAP5bL+sgq8CV7NOF6pN11USmDUhvPWmc+PC2sPIoGvSA1rJKtBStZcVbP1iXG/wspye
 V+9L2hL8XqsbNQJPaNvAjS7oFTxhWfXKSh4tTZTgNrwSLClWPhyQ2EGhWuL05MSUMr5Kp
 YnAh2o0LhdgkFLTeZwz7GVz5/nJu5x/UmKszo+PjmcnNyh0ktmmTIYOm5cx7fP9ntkg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=UQmTZP0E; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=UQmTZP0E
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 174BC605FA
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 19:24:52 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6b3dc272dcfso3046459a12.3
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 11:24:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793561091; cv=none;
 d=google.com; s=arc-20260327;
 b=q0wdlfo1546j5YpzElk2JvOUl0lK3oDIc1wWbu14LN3sjMw7QiDUVYd5QwH5bkZ9SP
 Ny6sdGJksov5zB/NkxZImCLQmPa4vxXfz5qhnnjqa3/2mk9+uhANAdNzsFnPDH3zyYuV
 +11FXJmbhJ5QIHHsJV+v9u4Yt2EP7nyPYgHALIcRgQBNsRBm4OR7VTA+PbtXWsfEUyv1
 GOuDjovKGFkpfBBCiUnHE6KXpuGjjNSzRAhQXgH7W0RzyHaQx8clfLpP6fCoGehldkeu
 RpMXJyxcoyg3+7eZdHxj+NUHmXbCqER1WfNH/3qhalWpXhP8WKUgKxzKLjZVU2JBm+rd
 eB7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=X9QHcAa7IMPY6sOZmxMedVZGLAL/E9xS3u1zpI5Ha0o=;
 fh=a/vRBMu7lXWFy/NezswgA2adqg63zQyiKwtlCiLXgpU=;
 b=jQtkTqxcjXHccaRXMm0K0KvPVVOZ4liMleUy4eVT58b+bGzpVBYuYVm/JU7z88x9Uk
 5VP4gvNLDxjpHTo2IpOgrcWWPrmiuPKql3dAnOB39jAaLylV4Pb3zflB8WhI1XPLfQJf
 blAoa6VkGmGdd17OgjveoheBPiVeLd+Hl4PZyg1uXzA/EPYEQ8wMfyHGrxZ+pPQWRWEb
 YwKiIElN9Y4PWMsKwyNSSF2+hfx6b6ODiqHFi2oDC6m8gr2Sa1owC2DTyV5KDfqy/7EP
 6ffsdIv1VxREwGb9arwG6zGiNCoZrbJCcPK3vXBqOKcpGqN3iBBTHyeJuJLrzgLK4HP4
 /F0g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793561091; x=1794165891;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=X9QHcAa7IMPY6sOZmxMedVZGLAL/E9xS3u1zpI5Ha0o=;
 b=UQmTZP0ExOlv/x0tLBE5CJLY476CqBpdBqojcR6O+S3wUTsmjKNYoNuldm6mpJAm+7
 mI52ZfMDtNC6/YU1WSKNI1P/p5iudt6zmZO93a2AxrbKa2adgPpgapLo8ppO5hiURbiJ
 EWuaqnm+5B1ge1GigdMnF0UrM/hYjLUAMhY0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793561091; x=1794165891;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=X9QHcAa7IMPY6sOZmxMedVZGLAL/E9xS3u1zpI5Ha0o=;
 b=qxioSh52BZhEukL95i6ftt4DouzXA2fqGu67H9mv3bVlVmaq9GxD0c24BzdjnulErM
 8M4nNxbLmDO7G6ZoDvvcyXIXqFAmSnzuzkYjDn4zHi9+KPuiPtkbgDMVzeyl6bX+MRqH
 dMn+J5En02r6PI0ej4NZ0u77R3zkqBGTlDQr9cq2aYqsFaDm0ZTR2Kz1Gu2bJkU68s4W
 T6iJ4BT1rGtpzFaiyBEoQPmsITrCRcJkrninX5fj7UfUgRTTPrt8+SCnLf9lRs5+gSRL
 4yS9q+y8TZxuuMhw0HGVO3n3IoaEcxRWgFrBBE5hjhr8IobgXJpiMd4961OoEmnyZ+mK
 qIvQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxTyjcXfaVtDN23vvoavY1pDHtgA55vmblUO7xW7pZfKw+cd1bPgtuarJx57owtdcTF2e0fwnI=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z960YzhDHyPzDOF4j5ogCARbRx8HRw5MPEYMzbEuvDvbOVlyIZs
 tr/o9WkSPBbZXuYvhSM9Sfb6qNV8VzdiaJ4WAXVDH5EC3bT3ad0x9B2Ypz8MNl5TPYAcbFRy2Nm
 3O3+eayuzhaHjYUN5EiDPbwcWhTOXBDUu6sH+bmbm
X-Gm-Gg: AYBFou3u0Cr/9FqBYvGxl+TTYzI0edwiO5rmyvn1kx6LVqDTg7/IGoFchJjsqaIG6Mm
 rAr514Nw8VLk07XsTM33zXCdcyTnfHiJI0bO3uBxdBLnEEUua6D2gP59Rq5bNAAd57H9Y8NOz6y
 LCr4kfepB6tZBGhN+aYMjib840xHAYfs06Zg2lYyLi6uFexwdraOK9v2AhzB2CShk06p4abh6LQ
 R5NL4n4sGv5/Zy+UvFD14li7sLgmA/jMEVCbvSIMqXnQbgEpr4qHUEt9ALWY/+vI6AArc7SD5Bk
 E+qPT6+4fkeepjzlhkkPhs7Te2o88bdYZ1iUUk9HayJ0aEiAbCa2ZKMC/EKJ8AdU5W5HUrwB64Q
 0MvNO+BR8LrEtOAmUgLY47HY5B0+29jKid8vgV5lVahdxN5HhJslAh3usP2/t9L06PwuaGe9WDQ
 ==
X-Received: by 2002:a05:6402:1cc4:b0:6b1:c774:58c0 with SMTP id
 4fb4d7f45d1cf-6b4d4d812f1mr5774088a12.31.1793561090596; Sun, 01 Nov 2026
 11:24:50 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029-main-v1-0-b5a878627107@kontron.de>
 <20261029-main-v1-3-b5a878627107@kontron.de>
 <CAFLszTgDO26qJUY+3cw1J+mPaofueYyEGUe=BVWmDH30RgA5ow@mail.gmail.com>
 <20261031143318.GP3309461@bill-the-cat>
In-Reply-To: <20261031143318.GP3309461@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Nov 2026 19:24:37 +0000
X-Gm-Features: AclHuK-uZvU-BppW7gwOW7ZTq9igLGq2A6K2uIJO5DiK321ifEknoQDZuxLLAnM
Message-ID: <CAFLszTjoieN+GZNNpKatFv5ig=tJ+Yt3rwWt-4ZTocd-fxHtYA@mail.gmail.com>
Subject: Re: [PATCH 03/10] bootstd: rauc: Fix overflow of the BOOT_x_LEFT name
 buffer
To: Tom Rini <trini@konsulko.com>
Cc: frieder@fris.de, Martin Schwan <m.schwan@phytec.de>,
 u-boot@lists.u-boot-project.org, 
 Aristo Chen <aristo.chen@canonical.com>, Alexey Charkov <alchark@flipper.net>, 
 Daniel Golle <daniel@makrotopia.org>, Johan Jonker <jbx6244@gmail.com>, 
 Francesco Valla <francesco@valla.it>, "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Frieder Schrempf <frieder.schrempf@kontron.de>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

On Sat, 31 Oct 2026 at 08:33, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Oct 31, 2026 at 07:05:55AM -0700, Simon Glass wrote:
> > Hi Frieder,
> >
> > On 2026-10-29T16:23:07+11:00, Frieder Schrempf <frieder@fris.de> wrote:
> > > bootstd: rauc: Fix overflow of the BOOT_x_LEFT name buffer
> > >
> > > The name of the BOOT_x_LEFT variable of a slot is written into a stack
> > > buffer of BOOT_LEFT_LEN bytes with sprintf(). BOOT_LEFT_LEN leaves room
> > > for a slot name of 32 characters, but not for the terminating NUL, and
> > > longer names are not limited at all.
> > >
> > > When booting, the slot names come from BOOT_ORDER in the environment,
> > > which is only checked against the configured slots when the bootflow is
> > > read. Setting BOOT_ORDER to a long name between 'bootflow scan' and
> > > 'bootflow boot' therefore overflows the buffer in find_active_slot().
> > >
> > > Make room for the NUL, and write the name with snprintf() in a helper
> > > that fails with -E2BIG if it does not fit.
> > >
> > > Fixes: 7e5c2c782fb9 ("bootstd: Add implementation for bootmeth rauc")
> > > Assisted-by: LLM
> > > Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> > >
> > >  boot/bootmeth_rauc.c | 34 +++++++++++++++++++++++++++-------
> > >  1 file changed, 27 insertions(+), 7 deletions(-)
> >
> > > diff --git a/boot/bootmeth_rauc.c b/boot/bootmeth_rauc.c
> > > @@ -167,7 +176,10 @@ static int distro_rauc_read_bootflow(struct udevice *dev, struct bootflow *bflow
> > > -           sprintf(boot_left, "BOOT_%s_LEFT", default_boot_order_list[i]);
> > > +           if (boot_left_name(boot_left, default_boot_order_list[i])) {
> > > +                   str_free_list(default_boot_order_list);
> > > +                   return log_msg_ret("env", -E2BIG);
> > > +           }
> >
> > This is a build-time configuration error: a slot name longer than 32
> > characters in CONFIG_BOOTMETH_RAUC_BOOT_ORDER now quietly produces no
> > bootflow, and the log_msg_ret() output only appears with
> > CONFIG_LOG_ERROR_RETURN enabled. Please can you add a log_err() here,
> > as you do for the missing partition names in patch 6, and mention the
> > 32-character limit in the BOOTMETH_RAUC_BOOT_ORDER help? Also, the
> > other callers pass on the helper's return value, so it would be worth
> > returning 'ret' rather than repeating -E2BIG here.
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
>
> I've asked you before to not give both substantive changes and a
> reviewed-by tag.

I felt it was a grey area - the 32-character limit is large enough
that we shouldn't hit it in practice...the error code is very minor.
I'll err more on the side of no review tag from now on.

Regards,
Simon
