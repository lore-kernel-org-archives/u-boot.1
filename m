Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B371CC2BD09
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 11:14:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7A8B88709;
	Fri, 12 Jul 2024 13:14:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sigma-star.at header.i=@sigma-star.at header.b="TbZsoLfW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 071A88871F; Fri, 12 Jul 2024 13:14:19 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFBFE88667
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 13:14:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard@sigma-star.at
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42797289c8bso13857905e9.0
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 04:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sigma-star.at; s=google; t=1720782856; x=1721387656; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kZOvpr3jkyGkOKeXnPQx2LP3muUQY+V2rP+fdk4Z9h4=;
 b=TbZsoLfWguKhk5CJ0Wv9uOAhcvtYB0Ua8J+hsdhtP/SccmWA6U7vLvgYCHltdZ+Ehp
 3AGFI1cZjxXZsVuIRF8KqpSzlrvcAVs45C+e1lIAKvTKcPW6c2KziABeDeOB1n/GoJu6
 6xx1+5g//hl8jpdLgijYDtS6n1AQwuxAuvEZAqBNJWX3K8FlZ3es9MK5NQtENPjwXOs9
 Y0vraM4OW/hGvEw4T6okbk+RHmjJjLyqyIviGsj9p35qwGZ/uz4myvjE+3lF5IXBMmFQ
 xHCXtOqqgSIh2phv7XHrkJUcfZtqPmRH/9qRCLXe2ajQdmseY88Ngga1ncdWbHl9t1sE
 mtTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720782856; x=1721387656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kZOvpr3jkyGkOKeXnPQx2LP3muUQY+V2rP+fdk4Z9h4=;
 b=KAUaKPyceE35jMFj8aTr9bt7NqWpYi/A3Jymc11nEF5wCZV+D3FSRKjFRtv5kWn9Q4
 AT6p/tl3iTzgM+CoJlATuarYr8xv25BvIpIDb2LDwEqhmXY2DfBjydOHBZQ4fK0NdQmw
 q41ACQwzyCE1mBOgnpy3T73Pzd0ycNQUx7BAHIqR/WiYsCNUH05q7GoQB/MlLMH9GKpG
 /0hkJjFFPwKU9WlEjNfFTOqPtx+papAD0KD299xof5DXGLxfRetd6D1qZ7AB5dABJRi5
 1UJ5Mdbi5AxxQG0AUFiHL0593iCtJ9fIPzx5bCEEDHV4jOBb+Lmy4JsGRwqGZDEBWhah
 Nhug==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDtGHx9B/Ls6V+mKt03QU+1H7kWQNNbUTt4xaDykTDIjMcBi/DUcGKRt3otQUSwHMfyRgq9wSHosHy+0pmqkD/vZIzKg==
X-Gm-Message-State: AOJu0YzRGyiwJaKIYh0353DaTHGFsz3z0h4//r/Piyc+sUcm7WiriTl7
 mswyf3OKJC3RT+87BXfGIgHgg3fPssZ7X7TTGrRVQEfHWQQE2P7h+sJGOarz5bI=
X-Google-Smtp-Source: AGHT+IGD10UO5hS94y0mHwdFe9lJV4ly7vwljD6EQVyK3QZG4B7JbW29uS6qHMUMEN2oti85JZl7ww==
X-Received: by 2002:a05:600c:188d:b0:426:5f7d:addc with SMTP id
 5b1f17b1804b1-426708f18e2mr69178885e9.37.1720782856331; 
 Fri, 12 Jul 2024 04:14:16 -0700 (PDT)
Received: from blindfold.localnet (84-115-238-31.cable.dynamic.surfer.at.
 [84.115.238.31]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f285a76sm20044705e9.21.2024.07.12.04.14.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jul 2024 04:14:16 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: Richard Weinberger <richard@nod.at>, upstream@sigma-star.at
Cc: Jixiong.Hu@mediatek.com, sjg@chromium.org, patrick.delaunay@foss.st.com,
 ilias.apalodimas@linaro.org, seanga2@gmail.com, trini@konsulko.com,
 upstream+uboot@sigma-star.at, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH 1/2] ext4: Fix integer overflow in ext4fs_read_symlink()
Date: Fri, 12 Jul 2024 13:14:14 +0200
Message-ID: <3244366.vfdyTQepKt@somecomputer>
In-Reply-To: <96973f0e-a185-4758-8e8c-837206c6bdde@gmx.de>
References: <20240702194223.31998-1-richard@nod.at>
 <96973f0e-a185-4758-8e8c-837206c6bdde@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

Am Freitag, 12. Juli 2024, 13:10:12 CEST schrieb 'Heinrich Schuchardt' via =
upstream:
> On 02.07.24 21:42, Richard Weinberger wrote:
> > While zalloc() takes a size_t type, adding 1 to the le32 variable
> > will overflow.
> > A carefully crafted ext4 filesystem can exhibit an inode size of 0xffff=
ffff
> > and as consequence zalloc() will do a zero allocation.
> >
> > Later in the function the inode size is again used for copying data.
> > So an attacker can overwrite memory.
> >
> > Avoid the overflow by using the __builtin_add_overflow() helper.
> >
> > Signed-off-by: Richard Weinberger <richard@nod.at>
> > ---
> >   fs/ext4/ext4_common.c | 7 ++++++-
> >   1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/ext4/ext4_common.c b/fs/ext4/ext4_common.c
> > index 2ff0dca249..32364b72fb 100644
> > --- a/fs/ext4/ext4_common.c
> > +++ b/fs/ext4/ext4_common.c
> > @@ -2183,13 +2183,18 @@ static char *ext4fs_read_symlink(struct ext2fs_=
node *node)
> >   	struct ext2fs_node *diro =3D node;
> >   	int status;
> >   	loff_t actread;
> > +	size_t alloc_size;
> >
> >   	if (!diro->inode_read) {
> >   		status =3D ext4fs_read_inode(diro->data, diro->ino, &diro->inode);
> >   		if (status =3D=3D 0)
> >   			return NULL;
> >   	}
> > -	symlink =3D zalloc(le32_to_cpu(diro->inode.size) + 1);
> > +
> > +	if (__builtin_add_overflow(le32_to_cpu(diro->inode.size), 1, &alloc_s=
ize))
>=20
> U-Boot is freestanding code. You cannot use built-ins.

Hm, I see man built-ins in the U-Boot source.
Why is this one special?

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y


