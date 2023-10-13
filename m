Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8731CDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 15:18:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 927C186EF6;
	Fri, 13 Oct 2023 17:16:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TB5rKqe5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D1F086EB9; Fri, 13 Oct 2023 17:16:08 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EBD786EDB
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 17:15:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5a7a7e9357eso26747817b3.0
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 08:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697210142; x=1697814942; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2MTfngVbB3/k6uhp4CWnQx+xahgxowDeKwmzLt31lZM=;
 b=TB5rKqe5TeOOsxR5gc1MD3OrsUuCLysPwPkg5sdGnttM9Bj6oVs+iO32dcsF78kpOg
 4hs3A7ni8CbZiFqajxg3FOnr7tFmjKmYPInbEu8dODCa8DSWH6LBgENZxCM2lyc/2Dr4
 jlyxoQYq7RbDEvLIHfJwgDlrfqnhhAYljytM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697210142; x=1697814942;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2MTfngVbB3/k6uhp4CWnQx+xahgxowDeKwmzLt31lZM=;
 b=u5jmKE2wPDZqqsEhaSzCywb0QUDBuR3ZUxrYchVhMzRoxVLvbxtuhF9Bsm9Tte9QUb
 rBDC5mFYRS8A5BgPRS13RMOW9xwUb4DnWEdB4SDjepWun9qlmAVlDItT7ju4jOVjQnji
 xKBOZXiiruM8untWK8AotPaNIiYMsdL9t5TDC8QAmtG0Qkxr0DEqf0F2g8CTVjRKNJLl
 K2MViXuf8krYzKAhaJKtJXIz9FUzOKKD6hjb64Q2jbMZLUMn3XajqW2s/V/9sQVdjnu4
 7aAwcTOsj8TbL3qBdkRkB4lVL/qVlhKMfsnvos7f6reUXSgZ5IjZljUa/51Cmjmuzl5u
 2rfg==
X-Gm-Message-State: AOJu0YyumbfE+Z7IpZHcFkk70IpDddjE+ceRzOzg5NtG8Gr8l5Bqa9R6
 oOs6J7iSB/xsFP+0M28/35rgJg==
X-Google-Smtp-Source: AGHT+IGkaI9bYs1vzl6UeGOx3D1oAF60XY2Tpj7rWJDYOmU29wyuAllLZNV/JWmBV+nrs7BHJzrdWw==
X-Received: by 2002:a0d:c906:0:b0:595:9135:83c7 with SMTP id
 l6-20020a0dc906000000b00595913583c7mr27622439ywd.47.1697210142339; 
 Fri, 13 Oct 2023 08:15:42 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5647-4a14-f04e-8d8d.res6.spectrum.com.
 [2603:6081:7b00:6400:5647:4a14:f04e:8d8d])
 by smtp.gmail.com with ESMTPSA id
 h1-20020a0df701000000b0058038e6609csm747744ywf.74.2023.10.13.08.15.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 08:15:41 -0700 (PDT)
Date: Fri, 13 Oct 2023 11:15:40 -0400
From: Tom Rini <trini@konsulko.com>
To: Da Xue <da@lessconfused.com>
Cc: Marek Vasut <marex@denx.de>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com
Subject: Re: [PATCH v2] usb: xhci: Workaround to fix the USB halted endpoint
 issues
Message-ID: <20231013151540.GJ3119521@bill-the-cat>
References: <20231013045356.25789-1-venkatesh.abbarapu@amd.com>
 <2016c1bc-dfe0-416e-a910-75e6cf25036c@denx.de>
 <CACdvmAju3wDL0yCJtVdEf47u+L5R3AvRpcuJ+ruKFXDTcQ-TBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CHv0WF/Ct9t/QLFH"
Content-Disposition: inline
In-Reply-To: <CACdvmAju3wDL0yCJtVdEf47u+L5R3AvRpcuJ+ruKFXDTcQ-TBw@mail.gmail.com>
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


--CHv0WF/Ct9t/QLFH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 13, 2023 at 11:11:04AM -0400, Da Xue wrote:
> On Fri, Oct 13, 2023 at 7:47=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
> >
> > On 10/13/23 06:53, Venkatesh Yadav Abbarapu wrote:
> > > The xhci host controller driver trying to queue the URB's and it is
> > > getting halted at the endpoint, thereby hitting the BUG_ON's.
> > > Mostly these kind of random issues are seen on faulty boards.
> > > Removing these BUG_ON's from the U-Boot xhci code, as in Linux kernel
> > > xhci code BUG_ON/BUG's are removed entirely.
> > > Please also note, that BUG_ON() is not recommended any more in the Li=
nux
> > > kernel.
> > > Similar issue has been observed on TI AM437x board and they created a=
 patch
> > > in Linux kernel as below
> > > https://patches.linaro.org/project/linux-usb/patch/1390250711-25840-1=
-git-send-email-balbi@ti.com/
> > >
> > > Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> >
> > I already explained to Xilinx how to sync the driver with Linux and why
> > this is needed to move forward, multiple times, and even provided a
> > script which does most of the work automatically, since it is basically
> > automated process. Xilinx did not even bother to test the script and
> > provide any feedback.
> >
> > Until that happens, this patch is rejected.
>=20
> This patch also causes all of the USB devices on certain platforms to
> not be detected:
>=20
> scanning bus usb@c9000000 for devices... Device not responding to set add=
ress.
>=20
>       USB device not accepting new address (error=3D80000000)

Yes, we are stuck at the impasse where the custodian is asking for
someone to try and do the re-sync, and everyone else will assist with
testing on other platforms, but the re-sync hasn't happened.  Can we
please get someone from AMD to attempt the re-sync?

--=20
Tom

--CHv0WF/Ct9t/QLFH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUpXxgACgkQFHw5/5Y0
tyzTEwwAnDpJaE/QlvfjwJBcaw4u74enLzO9grvMhrSbi1YmLU9OnuJJAG5Ugdnh
rLeLPz+x1my5VS4dZOxDV8HFPiZ4+10Dj5mjf159pbymYpxOB/UB8OP0l2lrKZCz
5gkTxbovAfWMqziDctKaWtp35kSSz3Sz9XEZx9tJ6IJfdIaHsEpMDcU47iAteLhW
VDCQaPgEMjYYr6IxpSPJdMb5XpZ7BduXNReDI6/2dUqD2DsFAOAA930Pmg7vrVc9
kuae0onG4NOrxPngb2tk/vlnMe13+dQbzy5UhDVNhWQCgkXJVxCA+ljvmS8QCZ55
nbFFhbBA03tr8Mr8FyO6yGZJIJ33SISoAUbR/dRfJ3c/qSnHBo1wxAHFiutsEWbh
L7yh8J1R/K5Wz8J6wT2S/vQthr/ctbWTevhQ7B7KRhnahyfPgI149NoXFJ8cLCb5
afQ33gZHQVwMiQgo1U2PiYLLrqfApAysLalxa8veqZcb/jlar1QMRQydyDfxCvBI
+u+8fqI1
=xCu1
-----END PGP SIGNATURE-----

--CHv0WF/Ct9t/QLFH--
