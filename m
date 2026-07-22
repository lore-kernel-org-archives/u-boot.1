Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A16BC4453C
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 16:05:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A741660802;
	Wed, 22 Jul 2026 16:05:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lOENcp95lO2u; Wed, 22 Jul 2026 16:05:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 115966060C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784736347;
	bh=QjByfoG7xUst0toUK7iXxN9uVWqvO3v40OlJQGIYMjQ=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=mekq69jw+nW55HaalqiA+b6/c+PToQE3+XekOpWc/8KzUGmA9LXhT7d8/71h/Zmrx
	 txlylh3EmK0d8MoK+vbUm8Gx99+mEpwCmBo5xk8/ydf611GceIDHAb/RsJDLIWB2zD
	 VDjmPrub2HvFuLVZKisJ/t/36FLscMRCqn1E8yfg0VwYapKxpH9IPKIfNKLwcZqGLK
	 CjdqI4lh1tkOBziT9dHhYg4GjR+E4+YdiYOnqnsfMlqvvOMOx2FMlEoVidTMJkuzNc
	 dFv8lxKSTm3FznrTKzQFsyT8umwXFxJU+uIcT+1idVd29tcFg5VhxQ/TElmoWYcKV1
	 k6kvm1dntHllg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 115966060C;
	Wed, 22 Jul 2026 16:05:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 691FF224
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 16:05:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5B5D4400B8
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 16:05:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tvLL6Y43b9cH for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 16:05:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f2d; helo=mail-qv1-xf2d.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A99F240087
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A99F240087
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A99F240087
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 16:05:44 +0000 (UTC)
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-9034b6b7674so104882696d6.0
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 09:05:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784736343; cv=none;
 d=google.com; s=arc-20260327;
 b=lrgj95JYXCO6VWC1Tskt2Z3PZW2Rw5MeatOp1zgJZBEQ+saAPO6UiCqU2wpV5/Uxij
 zRhfoM3AYuvIKgPA4As+byqt5BRKwxkNx9CjCIIgNlO+t51rtsVGtBeMjgWeTNdDtCR7
 56uB9BBHxWQaczKpXJWEBgm2pGA7xpGyNBj0Ln+1zTFmtqT12cjuv2GQOISDLsSKIq1O
 ygUip+uCVBiAqNbvD8B9eEvCHfdZjZMz0/OyUAPC4JjK0M/1BOquKU7k66JmEUu8RjQN
 uJG21hbaKZuCy3CkcdBNa+lJgct91Dtg29CnJAsbfqgkZA+ZmL3oA0A0QPxTqRjnyInc
 d6WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QjByfoG7xUst0toUK7iXxN9uVWqvO3v40OlJQGIYMjQ=;
 fh=3ud2E9D69tjVAySKG83SrK48vAZRyH9ejBQxVTxKn1g=;
 b=eV8bU3b+LG54JsZORoJV6jZI43CSUOeWSYOppa/yQhEhzaCbO54hmeCIYRt3Ftdeaj
 bm41jzD4iBuJFjSku1oqcCOK2NYF2xpQrVnvemmFEJT2Qm6FIUyeHBx5ME18yUzRzq7k
 m8Yni6chb5wwHtQgDncK8gXkSyt3f0SrbnzNWF327UJK+ZcXDJb4NIL/p8tujKOLCXd+
 4hh+abA5m51FIvaX+JePFdFaoGLZCsU/EKziKBAZZhJfJnitritJvbHxSxC/7CDkDpgy
 VVGADLKWDIaBxIrmlGLKkRImc2NJ1goynunHveTRksF4zQ28ejG0ahXXHJCeXsX5p4Y9
 bnJw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784736343; x=1785341143;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QjByfoG7xUst0toUK7iXxN9uVWqvO3v40OlJQGIYMjQ=;
 b=ReQfQbIRl5nVHEDmoQnqhAmC4D/53dd9soArBhMAcF8C45JJIeRZnXXhuOjLs2yqon
 vHNlUoibAdUDyDS0tm3pYj4wMo4rtwqIZm+a7Zg7KgbOIBMdHIyyxWIwe+Y+oM1h/IB2
 mK1K/aaEy4F1A39F5qmx0BiCGPzS7JDD4d0d5BFflLxPJv9CZ+l6WTTMdg1JaQ/sOfdD
 lyH01qHdObLsCIflxPEI1dNgMjHffI5xFMS8FDuroUk6H1M/nSKqn9j59Hsh6ekAPwr0
 lgDkNVlNXCDfLe4/MkB9JuF/3vG3mT1y1ksMmHqBai8ruhx5D4q56yY6ZII3HIVCBOzI
 0DNg==
X-Gm-Message-State: AOJu0YxMp9ZDBam7pb1RBQIbepklaHI3lQb7Ekvh+SvunWTcV8uqIyjW
 j8t2wtmOicf8jnFvx/1aplLR+MvJGD5yplVJQF9Uy5Fr1NOCsfgRHo3OkIdMshLu2bUltUCEZGT
 3tjQ/aHQbuw8j8d9oeRhvVEKu+76KuWY=
X-Gm-Gg: AR+sD10WZjy22Lil9IO0Sw79/Xe0TjijmBQ9LTt1SBEhGjsOxsHhCrUIF9taIte4f/F
 QjYvQwD1CU/Sji4Leu9EXRkc3OGWXHuSawvcrJ6JjyC3nsGAQRBdvDJUYfESOxAODy+244++3HI
 GqTXXAzP9uzgCnebRNt5V39ZHvR+d5LNYWUg6e4inAG4su/hX2vhMiw759QB40D2anPL30JnCsh
 5YB0TbR3NiPO31H0wUScxYOmBEULzjCX57nrOBsmBw5AczdAvS8ZeprG2Cr3xWh431kv0+8q/tx
 SM8VhpRn+mNJrAnInGAV61W1WNiwlrWxwKGga4VJSqV8zSnkNxJMQbPHSgwdNq2LEbnsb6pcHFF
 eIK25JJwllb63FErwSB/YdSjlaZ6idcrbg4QudfRYqasB9NtwqFtVloU9
X-Received: by 2002:ad4:5dc8:0:b0:8df:1814:3a1d with SMTP id
 6a1803df08f44-9077833cd53mr261385426d6.22.1784736343098; Wed, 22 Jul 2026
 09:05:43 -0700 (PDT)
MIME-Version: 1.0
References: <6c05c5dd87fc1e53a4d4328d3b6ab70f7b49af32.1784722525.git.michal.simek@amd.com>
 <CALeDE9O2oBcbuYVmy-iF49QjwzKsAW7DJzHhr3L1V8pi7vFarA@mail.gmail.com>
 <484ffed0-16b8-4fa6-b36f-84d6d8a66950@amd.com>
In-Reply-To: <484ffed0-16b8-4fa6-b36f-84d6d8a66950@amd.com>
Date: Wed, 22 Jul 2026 17:05:29 +0100
X-Gm-Features: AUfX_mxEnn8FHxpT3WaSZtSbihVIhH0dvgcyHUsJySRKBp0O0QLjIffD0kprfB0
Message-ID: <CALeDE9O6R-iEQxQprMMJLVG_GqKvCSWCmjUx76eCZuAuk=Dp+Q@mail.gmail.com>
Subject: Re: [PATCH] xilinx: Enable CMD_NFS for Zynq and Kria platforms
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.u-boot-project.org, git@amd.com, 
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784736343; x=1785341143;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QjByfoG7xUst0toUK7iXxN9uVWqvO3v40OlJQGIYMjQ=;
 b=QFoSOcvhUiGbT0IzJat+fk06OUQgIDYT1YwszwejS92CGhQBdlV9zjUMnDdTbSeTeX
 kAKXk3pkkhbzWmb6haHgElZAfiGl4DijdH/fnXU3vUriDkDtesY61vjfavJRhRI5J/kC
 hhRDv5f3OOqrVruXMhRGPs8nu/vNXURUmcgXOW3Kdi0XST6J/UehO2S+052u86j/gpgb
 88kSUpRzjI7FbSxBhsk/thVos8f4HmzVG0tSboBypZM6kCTvUMzg4zNTOmGJskeXYMhj
 i+nINpUZxQYq3suBrgs+Gl1jm48TE3WQ6O+ZQT0355rVl7DZoWNUWUvna9xAG/lIuwDE
 bT1Q==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=QFoSOcvh
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
From: Peter Robinson via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Peter Robinson <pbrobinson@gmail.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

> >> Enable CMD_NFS for Zynq and Kria platforms to have it available by default.
> >
> > How useful is this these days? From memory it's NFSv2 and that's
> > mostly dead everywhere.
>
> That's up to every customer to decide if they want to use it or not. We have it
> in u-boot-xlnx tree from quite a while and we don't know if any customer is
> using it or not but I want to stay as close to mainline as possible hence this
> patch. If this is something what it is supposed to be removed we should remove it.

That's ultimately why it was disabled by default, those sort of
options are the sort that are there for the customer to enable in
their builds if they need that feature as opposed to something I would
think you'd enable by default on a board. It reduces possible attack
vectors on the devices by default.
