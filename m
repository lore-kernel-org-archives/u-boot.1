Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE36CD8CB2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 19:02:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE900849A1;
	Tue,  9 Jun 2026 21:02:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DlPzQLOt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89EFB849A9; Tue,  9 Jun 2026 21:02:20 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7809F849A1
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 21:02:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-48662d16d08so2305296b6e.2
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 12:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781031737; x=1781636537; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=j+9IhdSkjSQCiz6AV4cbqgUy5Uijd0e1mDrwddfGQ+4=;
 b=DlPzQLOtho7nt++CepiRb90786V5nWiSs+fDS3LJLftzG+281nHBWhTZjfiJvFAEp4
 LNI7RFhZDRAB0Ozs6Zt9SeODUXZCzE2te8ufr9wcmyFBNq3xpfotYIh/cnXJdKk3I6GC
 QvpNBfWftjGjKzW9mtIyuZ5eA0kb2zResj+MU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781031737; x=1781636537;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j+9IhdSkjSQCiz6AV4cbqgUy5Uijd0e1mDrwddfGQ+4=;
 b=qZRd6Er6WJMFybxAnKxpyuUvmn5MDON9RuVa90FziWbOqfCZNqxUz6WTywpDiCknyZ
 ZgCQ7r71Nzt/sdWU5C5YEdcc2Rbtp27iOEpeDxvRbnHXbAbqu/xhJdjNURXlN/F6SVi8
 Z1hBwGQ/BtwozVF9Tj8lgYyWzZZLB8YDe1h6lhnlnZJZ0pFAf4sY/Ld+/2pJXnURJboP
 um7Ve8V2xVg6J2A+W+LS5oaHOQwlHtzZ+ZpaJ4JJAw19jJSq9JcmpQkNqKFvzgKyMA3E
 iM+4zmEEvBcUQihRL/0iG1rmieb4YpTGK/1+HBvtwblxjx/FH3z5/vrIN6n8kySI3SRP
 IRug==
X-Gm-Message-State: AOJu0Yzg1XW52ukCDjvqhCmdlx7vu78OoroCon6Z4S+mx/B0cA9p+ofy
 92mnuNpxCDcVu2NvXVITpVf8vEIGmADWmRAhkZizz7YuZFKGvlQleIvWCymq+SRcueW7PIoLiCH
 krZeVoD4=
X-Gm-Gg: Acq92OFKKwNCaPnzUH1ZB+DB2xv/FtQiySoCcty0q0mfMD4h2FUSk/81fPakEt3dQcL
 R5IHeKHr1LRsnanWPiDue0OMq4WF1U5T9VIditZQnQkt10Nek1qYlimngF9R8pA27Vyc/H7w/S4
 bxFFM3so20triBfbpuWIz9f5trNssn0ajsmdVzYOfd4a5TOKv0DWpqQAcJXFdDHwrNiJ+OLQ6dx
 VgTKRl/3VTg+Q8zHR7GUW8YuOg0x0Embjc0mtUWk+fA/IBwZYqLAN6zH4EMTQB2EVOnzwCvmVHP
 wn5zxqz3XguBxXNudDks1h6xIu25xrK2L3pL614tOvHYDC2RT8vopflHyjTOs2J+KU1zT4U3IZV
 KparYZsEkWC0w24/LSOv6VwPlavwzBJDwCTScaWLhDkMi7RbF/hI5HnbG4VLrlKYBQifTAtrYY4
 DBSmGplu2OJ9POlcWS+PsqH+1txSGX+/biPLhB1MY5LkxRLJk5RKpGw6Y1+L5sq0Z+gJ/CJQP+B
 QzsQQwNstKqu72xAv9Xb2padF7JlSJSlIkaGe5LxlRGo8n6NAPKb7vbd/nDpQ==
X-Received: by 2002:a05:6808:130a:b0:486:45c7:34c5 with SMTP id
 5614622812f47-4868dce4c24mr12152833b6e.17.1781031737098; 
 Tue, 09 Jun 2026 12:02:17 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4865b9c733fsm16190121b6e.16.2026.06.09.12.02.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:02:16 -0700 (PDT)
Date: Tue, 9 Jun 2026 13:02:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Johan Jonker <jbx6244@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v1 8/8] Kconfig: board: restyle
Message-ID: <20260609190214.GB382693@bill-the-cat>
References: <d1270724-50eb-450d-8847-a3271ea27a2a@gmail.com>
 <8a86f850-bc3b-4de1-b7c7-43d9b89a5856@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aJF2fnAarZTSNl01"
Content-Disposition: inline
In-Reply-To: <8a86f850-bc3b-4de1-b7c7-43d9b89a5856@gmail.com>
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


--aJF2fnAarZTSNl01
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2026 at 03:26:36AM +0200, Johan Jonker wrote:

> Restyle all Kconfigs:
> Menu entries   : no space left
> Menu attributes: 1 TAB
> Help text      : 1 TAB + 2 spaces
>=20
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--aJF2fnAarZTSNl01
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaihjNgAKCRAr4qD1Cr/k
CoelAP93reuOWuUdGoVFVY1qCMRaFsZhXL0vQro0z0Uj8wuMpwEA87xe4b35NwSg
hWduoJTo1MsM2CtM21RwlDt4El/XWAw=
=gCZ5
-----END PGP SIGNATURE-----

--aJF2fnAarZTSNl01--
