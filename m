Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AFC2C3DA42
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 08:16:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D57F98841D;
	Wed, 17 Jul 2024 10:16:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sigma-star.at header.i=@sigma-star.at header.b="PNWAHz0w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F1D7884C5; Wed, 17 Jul 2024 10:16:10 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1C7988381
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 10:16:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard@sigma-star.at
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42122ac2f38so2917315e9.1
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 01:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sigma-star.at; s=google; t=1721204168; x=1721808968; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7LhgmWP20fV3oq4Vj8TBgGnwuqU8Ey810wobOuU6I+k=;
 b=PNWAHz0w90/1FjsXXp3Uh/8jzn9h0j2RPNawMQuTNbSc6aKUXBFX+A1IF/31RbLoji
 G9lCMmGuO3ZZhTflPrj8An4gdMQq6qQbhY40szeqXponyCWuvmNkgH1kGfVzj+QM/A7Y
 Zs+m+vIfNN5Q+vT7JPaW9sOpwX9PRyVTQc3y5xcqtxIfbLTYraEl4uC/Q/yCgQrvkV8Z
 s+cOD10ofzByTYs/eSnX/PnZe+tAxCYcgSwDlINqo+JiyRb5b7dwsWc4528gyOS/1lYT
 KRJpGiVCDg8C/i/8gCd556jjZ4+xuQQ+KvsIuAXUXaIU3f72hJiQ3wLQUSrDGxP3o9np
 ngoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721204168; x=1721808968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7LhgmWP20fV3oq4Vj8TBgGnwuqU8Ey810wobOuU6I+k=;
 b=svSRiauCkPJoEGQQtLhuXTsgOiLzKzD7lQ5V637F/HTSUoLWNwk/SuDlM3MSyAo0LU
 rUBfHHMKMzaXbYpoTcCE+TmO/SJxWISsHGDlgVhbOfaul5knB7rJfvzFKmYYTEPdmbaf
 u1s3nXYK4wN2urVP1KeVn0McJakdHr1TSEy32MXocTmPn9Q/PGSPps2jVh0M7jQBp0Zt
 71/JRFZize3D5gjsQosb0n+nDK2B0/lCcuNjKQh8EfA2HciESGprgahu3XBFyV4rS8Ut
 ueh1Oa51JKvhypu00ZbrZEQBxdG+QYvtO/izMEbnj0LMNp65W4lbJnZzfM9RgN096Ebl
 /Gng==
X-Gm-Message-State: AOJu0YzsKAtscY7pDOIxq4O3v18HZN04919vxxhEeSeAdUvWIH3CTcj3
 4/9Ff6A3A4ti+xTw5juJKn0UqcTti9Hl6lKcBggVwiYgYRsn2+zpk/mej0NwZ/4=
X-Google-Smtp-Source: AGHT+IEk50HijzabHy0Cdfy3z5w9/bWMqHnmQkR14oBOivaPdtY7pySuADgCVzXwsdiSPIprP2BYKQ==
X-Received: by 2002:a05:600c:3507:b0:424:7871:2e9e with SMTP id
 5b1f17b1804b1-427c28f8dddmr7053445e9.6.1721204168031; 
 Wed, 17 Jul 2024 01:16:08 -0700 (PDT)
Received: from blindfold.localnet (84-115-238-31.cable.dynamic.surfer.at.
 [84.115.238.31]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f276b8dsm196558145e9.21.2024.07.17.01.16.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 01:16:07 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: Richard Weinberger <richard@nod.at>, upstream@sigma-star.at
Cc: u-boot@lists.denx.de, jmcosta944@gmail.com, thomas.petazzoni@bootlin.com,
 trini@konsulko.com, upstream+uboot@sigma-star.at,
 Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 4/4] squashfs: Fix stack overflow while symlink resolving
Date: Wed, 17 Jul 2024 10:16:06 +0200
Message-ID: <3173526.TQGk6oTFT5@somecomputer>
In-Reply-To: <20240717100635.19491668@xps-13>
References: <20240712082344.8655-1-richard@nod.at>
 <20240712082344.8655-4-richard@nod.at> <20240717100635.19491668@xps-13>
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

Hi Miquel,

Am Mittwoch, 17. Juli 2024, 10:06:35 CEST schrieb 'Miquel Raynal' via upstr=
eam:
> Hi Richard,
>=20
> richard@nod.at wrote on Fri, 12 Jul 2024 10:23:44 +0200:
>=20
> > The squashfs driver blindly follows symlinks, and calls sqfs_size()
> > recursively. So an attacker can create a crafted filesystem and with
> > a deep enough nesting level a stack overflow can be achieved.
> >=20
> > Fix by limiting the nesting level to 8.
>=20
> As this is I believe an arbitrary value, could we define this value
> somewhere and flag it with a comment as "arbitrary" with some details
> from the commit log? Right now the value '8' is hardcoded at least in 3
> different places.

I stole the value from the ext4 code.
Since U-Boot lacks a common filesystem code, there will be always
duplication. I can happily add a common define for the value.

> Also, 8 seems rather small, any reason for choosing
> that? I believe this is easy to cross even in non-evil filesystems and
> could perhaps be (again, arbitrarily) increased a bit?

=46or ext4 the value seems okay.
So dunno. :-)

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y


