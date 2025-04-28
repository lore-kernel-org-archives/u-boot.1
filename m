Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE958C369DC
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 21:40:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3042482145;
	Mon, 28 Apr 2025 23:40:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="M7F8udr8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6785C82132; Mon, 28 Apr 2025 23:40:39 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB7928210E
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 23:40:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-72c14235af3so3456782a34.3
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 14:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745876435; x=1746481235; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ClgoISiYN7bwQHaJFMTLptQbJMqqlJ+ryBZ8by4cZQ4=;
 b=M7F8udr8tv9Ouakf3gq2pWF/2fhg1WHhg7yZeLBBksC8cXlA6Zra9lRuEKstL263nk
 wZC2rkpl+8yqk2iCLWDXgjGwpG9WSXja/AaNWV8MNoJT7Fi+FrtMLacuBl5cwM/DczMO
 skBgMLq7RCdjOuxA5R5r4hwV2z/TM4WJVnxNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745876435; x=1746481235;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ClgoISiYN7bwQHaJFMTLptQbJMqqlJ+ryBZ8by4cZQ4=;
 b=lTw7WJ4eq2hVymoIvv8xx4r8Kgx9puUfnP+hZWy7R7yd6sZAeXRMUNCcAkZPaJSScz
 YbEigptTkGW/R+kA7Ee58EjK0G0gCcnFf4nrxcj2mfzQRlxxROp2jYxbU4G/UNTWzXUu
 PL1Y2dqgfZe9kR56l+wQBCT6KRJxhjx9uk2EiqcbCr5bwf0kQ25j1qebgfhMJBSHJxPV
 tmu3iEroKUohHNGiqvBMUkbXakobZBNruL/DbbFYXFDRAc5+CuMKxE/Gsw/8syIywtRn
 ceI9BfMBQSeVSO/h8glNoSTpINo0noNJggWo+OKsd0BMHGBXsPPLWDWBK8XiPwilTG2Q
 w72w==
X-Gm-Message-State: AOJu0YxGwfUiEVSHzTCBtUqVQb+64KGLIVqgslmJz1pshbqlOgzc3b5Z
 ZfWOMNkgADIFIc9j94e9jMAfDwHSQaNY2llbjaFa/dcO952fKFlP9e2DBUg5flDz2WmKITOjISW
 R
X-Gm-Gg: ASbGnctyuskkOWvqoyVh2k/1g4Wo5tZZOVgXsqYNUAAWlULotTvec3wBzLu/qeFO9k8
 /oV12Pj3ajOcSiR3oQNmbvEwNS9ZLu07N5vPdxxyRFVIzfdWZMawZnGWA09FFpD90G8ODvVFD3s
 ilRYPlVNbLL2oLg4CDKJ5J6puJyRukOmu4wvwFhWs7IRo6Q4synaLxuIWpp4arcRPGeTuiaztyP
 MXasulAFwmZJcQO1734rew4QaKz2aIoITZ2XlFu5G1ksXZ7lQf1kJGZgTAaKY/KAfdXd0+4SYbv
 N+IlLH2MsAtMPWN+dlK0v5UlgKlOkkNOguXBbD+kRsh1jV7y/aEXc6x18q3lUWU8VHYbJmEnowa
 MKA==
X-Google-Smtp-Source: AGHT+IHMo6Es4mQoim4D2Rn+BMVtxxWF/7bF+dm3RPLm49s304l36FevcMZrCKyw2LJE9ND1nI7mAA==
X-Received: by 2002:a05:6808:2f10:b0:3fa:4418:67c9 with SMTP id
 5614622812f47-401fd75c3f8mr7522529b6e.22.1745876435292; 
 Mon, 28 Apr 2025 14:40:35 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-401ec971691sm2230587b6e.39.2025.04.28.14.40.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 14:40:34 -0700 (PDT)
Date: Mon, 28 Apr 2025 15:40:32 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2025.07-rc1 released
Message-ID: <20250428214032.GG5495@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="r6VByUDKnVB+Ts+y"
Content-Disposition: inline
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


--r6VByUDKnVB+Ts+y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

So it's release day and I have tagged and pushed things out. Looking at
my own TODO list, I think it's in reasonable shape. I do think there's a
few other pull requests that need to happen still and I am optimistic
will come shortly (but I've not reached out to anyone in particular). If
there's anything big that people see missing, please speak up.

We're continuing with a community meeting following the release and the
calendar link is
https://calendar.google.com/calendar/event?action=3DTEMPLATE&tmeid=3DN280N2=
tlcXE3aDVtbjlicnNkcm82YnA1bDAgODliZTdiODEzMTM2YmVjMDZhODNkZTRkYTU5NzQ1ZjBhY=
mQxMWMxYjgzNjA2MWFlMDZjMWM3ZGJjZDE4ZGY0MUBn&tmsrc=3D89be7b813136bec06a83de4=
da59745f0abd11c1b836061ae06c1c7dbcd18df41%40group.calendar.google.com
and once again this is the same time as the previous meeting. The
meeting details itself are:
https://meet.google.com/btj-wgcg-euw
April 29th, 2025. 9am (GMT -06:00)

To join by phone:
https://meet.google.com/tel/btj-wgcg-euw?pin=3D1307528552322&hs=3D1

In terms of a changelog,=20
git log --merges v2025.04..v2025.07-rc1
As always, more details in pull requests (or the tags referenced by
them) will result in more details here.

I continue to plan to do an rc release every two weeks and the final
release will be 07 July 2025.

Thanks all!

--=20
Tom

--r6VByUDKnVB+Ts+y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgP9dAACgkQFHw5/5Y0
tyxN7gv/WBzreP2eQDK0zUP0qFsme4kVo3ArlhIRfKs9I/BZuPzwsd8nMX/3/1rD
1NyeiyxEvEUcof22GTaAH1OyZXrtiIS2LxMu2dbwELm9e0x9RBri2SJhQrCfQxBM
95DN+l/7Brv50yXaNAYBwDcUO5FgGmLqPzVyR+McFpu7kt/+to0wWO4iC4M8TgeW
bDqYalq+viDVZuDkYErh810dZ501uKSk607nXM62XCBt62clvLxNU7QrgL23ghGo
S+gVH6/9uyEI6M/+aHKUQazDjDToVNEPFI7747HVy2h0PJ9HUTx0G2h2j+JFFC6g
02vOXwKmC2TxkuqiVvkGPyvPwqon8/thqm9AbGrrLfuNMZPL4qawuhJjdtKXzCE7
6T2CsxdbEzlSMEEjNBvo/4NkM+UoXJwobWGYlqFOp3IRZ+kbRHbvKq+kCuWSNEMA
MHWjXGtaGU9DJHnYDPmszAkfMDO9cOUWuZ6JMSat2B2pejW6FuQ/1id/wqeabWF2
wV2QhpFx
=nDAE
-----END PGP SIGNATURE-----

--r6VByUDKnVB+Ts+y--
