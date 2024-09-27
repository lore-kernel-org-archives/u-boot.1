Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F699CDD1B2
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 14:10:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 992848908D;
	Fri, 27 Sep 2024 16:10:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nUOAQuWC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11DC489126; Fri, 27 Sep 2024 16:10:20 +0200 (CEST)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E432089089
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 16:10:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7ac83a98e5eso184070285a.0
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 07:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727446217; x=1728051017; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GvJ9J3KWVb3bKV+uP26jbWJcski2NpjF2XpUnpcbyFI=;
 b=nUOAQuWCHIaUFIoLTKQZGxJF27Ux+5TDBY+9bpWPOf5WegG0lYZikE2kxRQVXQcwpT
 ZBo4HHr1lAhZpA0d7J4Mm5jLD6ZM5rVa+bz4rL/fSi19xDy7mLP3PSGuULphRtAvR7h0
 0WmP27di0DBdab7yak1snIAzTstm40YYE5MTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727446217; x=1728051017;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GvJ9J3KWVb3bKV+uP26jbWJcski2NpjF2XpUnpcbyFI=;
 b=fl1cq5uveUlPp29kPJgb4Qce2xy5FdR6zu+UC6g9FoChpjzJe7EQarCtbFTkrfAdNF
 5wzvGuYqNpza2SPWcFKGdmMu47LwH7aWNuUQAAzK0r17UV0VMHwhV91T74+xfdtM7ZKs
 xF7rfPQoWnsOvA++j+Dy/jOulf/BzK/WzZd6VkbEW/arDp4CeNzUQVd70OleIJICX4M0
 Xsqsu5ZzewwaP6Gcz4DD9u1RGEk+wXwL1NpGa89Trir6lNXtDJ0cZS1s1QDemr1tQQm1
 y2qtSbZj9ookcD0W6gNREOLC5Jo/JzJtByZqswsn14m1lvG1wfViLhTnYUvaCPuSRiTL
 3WxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZ6bGR4n/mF729bR8WvvikCn+OYDE4okvO4D/GwEVuOyvEjfxcgsywyjwtd3TZdqxFx8O1RUo=@lists.denx.de
X-Gm-Message-State: AOJu0YxDCJOPLVQ/Iiae7dHG1zpVJrEW0Pqq0ruxAVNoIkSU7+4b7E9i
 fd37O9Lb5nn5sDCr2RnOv82LhHHPuOaJ15TzCQWGpxAxcPIh19CxBzVodlY1rJ4=
X-Google-Smtp-Source: AGHT+IEWPWbJuP/zBF4G5cfNNFPG8yAoHlMMdZXaQ4NylwsdbrLaEh5lqRA3tvX4W4a+prExBbZ9YQ==
X-Received: by 2002:a05:620a:3954:b0:7a7:fe96:880a with SMTP id
 af79cd13be357-7ae2c7a0ec3mr1098913485a.31.1727446216541; 
 Fri, 27 Sep 2024 07:10:16 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae377bc9efsm92444385a.18.2024.09.27.07.10.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Sep 2024 07:10:15 -0700 (PDT)
Date: Fri, 27 Sep 2024 08:10:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v4 14/35] efi_loader: Allocate and write ACPI tables
Message-ID: <20240927141011.GU4252@bill-the-cat>
References: <CAFLszThA5eOM_xiMgDu=B4wAcP7wV9bzfc565rES8z6d1F8fjg@mail.gmail.com>
 <CAC_iWjLqmN0uA85RayC2hnMOJfCqumCpiq=waQwakd6ECfbXkg@mail.gmail.com>
 <CAFLszTgaVdgPNSC+vxZoH7ko5n_d6F_QnGfgL-biZ19edaUxQQ@mail.gmail.com>
 <CALNFmy3-0u=RhhiPgCzj2szzhaADXrWm79jkD1p3pmpmto456g@mail.gmail.com>
 <CAFLszThqaF9oSxEW5ZYw9udqtC+8n3BhQj313qUvRvrQV=OwWw@mail.gmail.com>
 <CAC_iWjKPrUu+j5dJNbQWZB+J7OUa1X01e_d8cN=YSrO_86cOhA@mail.gmail.com>
 <CAFLszTjoZuF6x38j_PyQdO9W_zzyQY+DPrXKm8J2pM-T_GYsgA@mail.gmail.com>
 <CAC_iWjLR7ndQAPOhe+Z-11F-nFXBGpPUOZB=Mmwt36CzJtvD0g@mail.gmail.com>
 <CAFLszThcqgvAf0DDKhOXnKAdQ21r-PLDppTM=CASbaaONTei4g@mail.gmail.com>
 <CAC_iWjJnANTb27oWVJiucUSPfuE5gW7HWDQCjTegDy1iVeQqNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yBznm9voplnH4okU"
Content-Disposition: inline
In-Reply-To: <CAC_iWjJnANTb27oWVJiucUSPfuE5gW7HWDQCjTegDy1iVeQqNg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--yBznm9voplnH4okU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 04:14:55PM +0300, Ilias Apalodimas wrote:

[snip]
> > Well, I suppose so. But if it doesn't
> > matter, why is Sughosh spending all this time solving the problem?
>=20
> First of all, we got multiple asks from Tom saying LMB wasn't doing
> all that it should for a long time and needed fixing regardless.
> LMB prior to the patches was calling efi_get_memory_map_alloc() on the
> reserve function and be aware of EFI mappings, but that wasn't the
> best solution. With the lmb created on the fly we also had to call
> that function every time before LMB could decide what memory is free.

On this point, to be clear, I asked Heinrich to tie EFI and LMB together
because I had missed that it wasn't doing anything before and wanted to
avoid a round of CVE assignments over "you can use EFI to overwrite
U-Boot" similar to the CVEs that caused us to start abusing the old LMB
mechanism too. Nobody liked that original change and it was intended to
be reworked.

--=20
Tom

--yBznm9voplnH4okU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmb2vL8ACgkQFHw5/5Y0
tyzkBwwAoZJAb9e0jpl7t5BR1/WjVs8QZQlIvZP1Yiw9TN+rJub0gbuttE/uRbZC
6aq/fShqoobFHUb1CXlmn22HxYChIOP3ITYLzE3M45hq8/9IBeoqeJKxw85jWlEl
+d/3MZMFJPwLAUBucCHADw8k8l7l841JwWkUNTQGoxCmSTQ+WZDNV2u4EZDvdZB5
4VaTk82dWF8/cPDF6iFfBWFprAhkPUVxQ9tRamEvPvT3kQHDcF0rt00iGMAYJo7n
2cOSHI+IuZugrfoJGCbUk1QNGk5K8zWAvpYwXtjOsFx/3XsYCn563eg3lJck/gKy
p8J2jj5M0hEpy28Tyzp46OkM+AkCms1Kz0lhgCA56CLQZEab0vo4LG6qNRxnO67v
olULvFHEEeQACHt7hVx5MCtGNxWB3jrQ3e/LWN4RXe5PuNA8R6JXEmStBGBYw5g6
j66mex8fgU/iFxoY0Crmgn+41h5jpzRGF1PaXlbMVooiS+nOqS+wFf9YqEWIIDQZ
zoCHMAFb
=bsu/
-----END PGP SIGNATURE-----

--yBznm9voplnH4okU--
