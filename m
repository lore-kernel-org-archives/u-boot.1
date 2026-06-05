Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3736ECD6E79
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 14:52:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A020A84975;
	Fri,  5 Jun 2026 16:52:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sigma-star.at header.i=@sigma-star.at header.b="SYYtbEw/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E7D984964; Fri,  5 Jun 2026 16:52:15 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3934D8495B
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 16:52:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard@sigma-star.at
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-490af320e2aso23644035e9.2
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 07:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sigma-star.at; s=google; t=1780671133; x=1781275933; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XyB8qLSg2owQpptSMy4r/Rvm5hH0I4N4zPYS+4pyq6k=;
 b=SYYtbEw/nooNaqi4y6xBJV3vkcHkQhIBmzkATOpwjOIpo2sAiwIzf2O/daopKg9HWi
 3dOiGuhTEBHI3Cu6EarxKBfP5UGmkKmllRIPISOMEQmHX8DxBy1VViaQvcxOhptLXwfU
 VxZxltpr+VFZmAbbaNxdbY8yoEyKSLpYgp1hf23W8OKUg55Wm51F5r2JignpqXaAu/rO
 TQDnBctbQe781ccYsSq4en2r0+oO1SYNLFqDVkOE8k+/gSYfyA8NZaCIlU+GmDGMiAQA
 8ep9GIvi9e0oa4URJexwAhqipqMjjC5XWajsdcAOMC5R2fbqRyp4sOAne+897X9dc3BB
 sneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780671133; x=1781275933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XyB8qLSg2owQpptSMy4r/Rvm5hH0I4N4zPYS+4pyq6k=;
 b=ZbRBoSTKYeY4uMR47XPrbr6ZU+EE/yqNenM1tXmK1Fb+OBYT260MoaRdaa7F7j6z+V
 FP5GkSEeKPBaxLrAYogcVsuNGCwLMaqtb9VwxyQEAWsK0Ia9uGEud4GzpYK+lRoU9zQO
 pcG8cmZB8xWnxHdpfbOiDnrwdlaca43BF8A7A/FLjJAFTfbhnm5r4rFH8VJOA2QBLqAW
 3UU/MUBbwWun2VSqigRolly9JRjwjsP9NIPcP12GUJaAw5qgzJibNk13EIa851za/GPj
 tEL41wfBJ7z0cSLQRKgnlyo6YfQTNyVBrRiSgFY9bgg+f1otiEpu5IlPMni0t7EwvMHg
 Ob1g==
X-Gm-Message-State: AOJu0YwW/aOM5/qF+dF6eDeDGB7GvsdUqk1z+PTcYgUpMhCPn+Z7i7yD
 G6F+6hvYab0pIthrbKm1VYBSGVivnX50T3o+JP4fJaVpIfM0gyYZipKuLULCl2KG/NOeO2gX5Tg
 llTSW
X-Gm-Gg: Acq92OHPtct7BrWTA8zH4YQIwjIuAdYnbFYuIKz4LqWCehFWb8U4TSfV3stKaVMB4D/
 QqQlqTfcT2lA1p4+TVGIsuDGwysaSNSZBWe2/Opfxg3jILxdMnNHmEz2XjJN3zwsyiQ+Hr4Lxox
 BIYbF6r1rYbUvjwb6oAdjt3vY2AuxX62s5hcI1wz2ehEJXMbexkUDNAeLxdUiy6pWYlJUROAy0n
 4sy4UC+dHzKzv/pgH2YaYuC7C5GSHj7hDg6B+KLgfLDWz8Gl04yBehlqAXUfVgof7ZUUWiKXCs+
 bd8rmyEBl+nuje49wG3MEIpJFcf20jLrBDQ2fdN958bTZeq3wEfOu7NeOWdsMcR83RFc1dNhODk
 XpdNMFtORMYhKagqKBFzHdv/5N9TFmlOXjEB9hATJTDPPgNMYqCLJEP9z9LUGoMruL//TOr43i8
 2RjNjlP2SNPeKsMAIVZW6KCbly4JWKNQmUoSvrlV0=
X-Received: by 2002:a05:600c:8b6e:b0:490:9d1b:f05c with SMTP id
 5b1f17b1804b1-490c261746bmr60822765e9.33.1780671132219; 
 Fri, 05 Jun 2026 07:52:12 -0700 (PDT)
Received: from somecomputer ([2001:4bb8:108:d807:aa2:9545:fc4:1e84])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f351ac0sm43990638f8f.27.2026.06.05.07.52.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 07:52:11 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: u-boot@lists.denx.de
Cc: alice.guo@nxp.com, peng.fan@nxp.com, upstream+uboot@sigma-star.at,
 ye.li@nxp.com
Subject: Re: TZASC misconfiguration on i.mx8m
Date: Fri, 05 Jun 2026 16:52:10 +0200
Message-ID: <5857153.7ts2hSHzFV@nailgun>
In-Reply-To: <3208216.Ym5mLc6kNg@nailgun>
References: <3208216.Ym5mLc6kNg@nailgun>
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

CC'ing Ye Li.

On Donnerstag, 4. Juni 2026 19:24 Richard Weinberger wrote:
> Hello!
>=20
> FYI, in arch/arm/mach-imx/imx8m/soc.c enable_tzc380() U-Boot configures
> region0 to allow secure and non-secure world access.
> This is known to be problematic and allows circumventing the TrustZone du=
e to
> memory aliasing[0][1].
>=20
> It causes also recent OP-TEE to panic at startup:
> E/TC:0 0 Panic 'region0 is not secure configured, non-secure memory alias=
 access possible!' at core/arch/arm/plat-imx/tzc380.c:217 <imx_configure_tz=
asc>
>=20
> This is not a theoretical issue.
> On my i.mx8mm evk Board I was able to exploit this and dump all OP-TEE me=
mory from Linux.

I suggest reverting commit b3cf0a8f03d162e030cde1131751d060853e16fc
Author: Ye Li <ye.li@nxp.com>
Date:   Tue Aug 27 06:25:34 2019 +0000

    imx8m: Configure trustzone region 0 for non-secure access
   =20
    Set trustzone region 0 to allow both non-secure and secure access
    when trust zone is enabled. We found USB controller fails to access
    DDR if the default region 0 is secure access only.
   =20
    Signed-off-by: Ye Li <ye.li@nxp.com>
    Signed-off-by: Peng Fan <peng.fan@nxp.com>

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT UID/VAT Nr:
ATU 66964118 | FN: 374287y


