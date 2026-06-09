Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63986CD8CA8
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 10:15:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAC298466E;
	Tue,  9 Jun 2026 12:15:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sigma-star.at header.i=@sigma-star.at header.b="Q0pBpUxT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B65F846D3; Tue,  9 Jun 2026 12:15:39 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47C0883FF5
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 12:15:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard@sigma-star.at
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-490aaeabdb4so33590455e9.1
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 03:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sigma-star.at; s=google; t=1781000137; x=1781604937; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/3y3jCD+ZkBn52XvC83nhsxvpxfddbFK9aTCsXTTUE8=;
 b=Q0pBpUxTvZaESUE/6cB1iaIFDVbnsZ7b4ZQsZpr+G/DhA272R13E7gXu+oUco4L682
 P1RpCAt2wmPCSHPChIh7Zk+ie77XqdJDEARvxrhpVpDFSKpXHxIKPxbpJF5i1KTe/Y9v
 sRtNzXYLpSRvY2Kq9QxVdEhmYWHtbXuggQ75NYuEQaoIbzkUDNb4oqIpC+aEQ56YhsxE
 K3nBTif7ocNVwqV/E024i2cGFJLpkLl3wBIkqHhDnuLr0M3ZSlXCx5AwokutdN1MfPa6
 SVD+2Q6o00GDE6jHTF6SKtQqcvw7UgKDbqC4wOzpG0IduXc0thC//FJM83o4/RDyLK4V
 /AzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781000137; x=1781604937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/3y3jCD+ZkBn52XvC83nhsxvpxfddbFK9aTCsXTTUE8=;
 b=YvuwHdexmoArotVJZEDEUeYyNdpOHrho0OBE3dO0c6Y2ryXS6utcZlBwFhL3OOGqTJ
 YGZH8IK8CGj6ghalioTJpy+83wraLbppXLh2fDn6cV958y2n66Wgphjevwaoxn3j3vgi
 NLebPUnDIYPA6lGf1Iq/54lSsS2ruoFKcc5DNrQx4KoSy479QW91k1CODwlqL+OgaPFE
 OA1Xe2ipP1HZDQFFaZtMo+i4DoUX8Dj3jPOrCnbp8yhrrAZnlMWaGRGD59GDXCNKlRlH
 8Uitk5dog8BXMRyaFcAifyWagCMWIFozJOWoGUNOkP0ne6RP9uwbxcMXZ8q+Lc4BFZco
 L6JQ==
X-Gm-Message-State: AOJu0Yx8JwlfDXoyWV5liL2dnJncZkN8qxIMz0priAaPZTobd66YFKb1
 4QEIEvoYWZEZjqc8gUcfrKCG4Clm0SMumb66sUZYkDiYWxVx4S8G+pHLoKP0krP/9EQ=
X-Gm-Gg: Acq92OGb/DtGG1rGCK5OhSTrQWGLipsDvdPnVVfBHptUfKB512ok2ykqVfkLAGFiuvH
 oTDO8PF9M0bUhEhGarBg9L+d0IDxxeq9qfiRZpNMHUOXCO6lWJMVT8Nt8S86/So50xFPIGvELna
 VG/IPqNbPrW6v6f4M6pSPaJqwb2o4TjzBRxQq+9ooTmbDYba3UdyaawqRXRNF9Kr+lZPhWZwsub
 s7xQc8+LN7YCwNTn6nMS9INP3c3QwJ3kzrFnLR6xh0EIOnzKUieXC3w6R+pTlAu82PGJUhZGl+U
 EC2X67z+pg6cqVYCkWIH7B1SencWY3/dc1JtpEzrf2yYX7DgPx7A+A9kv4iVnyCPeD7n2d5S0ek
 XlxiyIQfCYmb281VMhMBRa6dvs/PFfqSntFeCNBwDKRqpgpeOGjQrZ53xx6RgPvo442BgBR6GHA
 NKQrX8QQp8Awcbm5yUdoneREzoonj9ZpIxnvbQRb+ISIPDt0OQaGWglPKfnvMp7Tq/3syUEJa8h
 nY=
X-Received: by 2002:a05:600c:19ce:b0:48a:906b:14ca with SMTP id
 5b1f17b1804b1-490c25dd679mr311446025e9.20.1781000136603; 
 Tue, 09 Jun 2026 03:15:36 -0700 (PDT)
Received: from somecomputer (85-127-105-26.dsl.dynamic.surfer.at.
 [85.127.105.26]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3d66c8sm448054265e9.10.2026.06.09.03.15.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 03:15:35 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: sahil.malhotra@nxp.com, Ye Li <ye.li@oss.nxp.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, alice.guo@nxp.com,
 peng.fan@nxp.com, upstream+uboot@sigma-star.at, ye.li@nxp.com
Subject: Re: TZASC misconfiguration on i.mx8m
Date: Tue, 09 Jun 2026 12:15:34 +0200
Message-ID: <3324321.byNdk4fJJx@nailgun>
In-Reply-To: <25db2dd8-e381-4b4f-a90e-7a76a7b31c59@oss.nxp.com>
References: <3208216.Ym5mLc6kNg@nailgun> <3228430.DofJx8uAJo@nailgun>
 <25db2dd8-e381-4b4f-a90e-7a76a7b31c59@oss.nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On Dienstag, 9. Juni 2026 12:12 Ye Li wrote:
> >> Why can't this optee patch apply to optee upstream? It is optee using
> >> secure memory, then it should be optee's responsibility to configure
> >> trustzone correctly. Optee can't depends on default value of trustzone,
> >> since trustzone is not enabled by optee.
> >=20
> > Sorry for the harsh words, but that's *your* job at NXP to sort out.
> > You seem to ignore upstream.
> >=20
> I'm not working in optee. As I mentioned early, NXP has decided to fix=20
> it in optee. That's what you find the patch in NXP downstream tree. I=20
> think Sahil will try to upstream it later.

Ok! :)
Maybe Sahil can shed light on the issue.
I find it kinda odd that NXP is only focusing on their tree despite the
upstream solution.

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT UID/VAT Nr:
ATU 66964118 | FN: 374287y


