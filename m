Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 504E3CD6E74
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 17:24:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE2FF84975;
	Thu,  4 Jun 2026 19:24:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sigma-star.at header.i=@sigma-star.at header.b="qc/CmSER";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B81F84979; Thu,  4 Jun 2026 19:24:40 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C85D684940
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 19:24:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard@sigma-star.at
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-490b7866869so11868355e9.2
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 10:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sigma-star.at; s=google; t=1780593877; x=1781198677; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dC1aNBRubKB8Fsz5jWcRQHqqyT9MqNmJCYlBnQDW5AI=;
 b=qc/CmSER2foeD3cZmP/QkFYEwBhIs+oTvVJm2B6R+C1JQKki6SCn39utDjkR2DcX/E
 hcdZ27xjtyHIKijFUkpUvhV56dgGj1/mUyMUxgwYrVI0he9hPr1/0e1QTh3XdlDv5yRi
 mEz9nnnmkl6Hy6mCYWruhc7vsyUT3gaT/KM1U0f0GyVODw+ssvfFm7uAY7lO6slfQqSS
 Au5ASbu+Oo4jK+TsRcxdi19soQ4U63DpdYSF6NjPkXB77ZU99adZvkGXEPoMBBlmBa45
 /LOS4WSr1yXSPWMzAiOJL9L1HZxyoWRQ/E6473SWoETFw4LWdgEeu6c9kMwdyU17otNR
 BBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780593877; x=1781198677;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dC1aNBRubKB8Fsz5jWcRQHqqyT9MqNmJCYlBnQDW5AI=;
 b=BKYBjE7sHKeG7jqQ/gHJIIUyf2RYUXtRDW3AydxnygEKDIhw6AGMlftVqNrthEJ+1X
 h+PcQU1RwSZ/GdLysCuBOJvxOx4oE88u+mYTCQ2uRktU/ZvwytxAZ/JlFAD3uL34Ivs+
 VQo8yRM64ZCvwUoh0cdEi5IOr6nkwxxOghVSN4m2S+8ph/Kqz9wDLsIJP9q2XihGqYDL
 gXkzmfjzjQ6AcPvVXF6+TTpYw74O5Nb2R0oqblu5etX10eSqw6ABH9+hCl01IM1baPzn
 aLiwFWXYj8eQw7JahXOlzfzeRXdIc0Up9r/XBivYJDlmdX0b3qVEFbTqBkMzddj6HgQ6
 wJZg==
X-Gm-Message-State: AOJu0Yyg3ZCX636Vr75/EzTPY3IXgkPaqOskDVYnB1rrUmYejyBbxQ8r
 SpPCxxIRHOv7OPhSN8xXlts+Yar3gTLBQ+DuwaPq4nnLpcb7nQykI0FUOzSU/lLfDW/DNIbQPMY
 wXhRd
X-Gm-Gg: Acq92OEZfphB1jFuJSvQzC7WSeagcRPu29z7Nk8zcU6Vm4qtOrsOgLXdavBWDSsRnLM
 9a/ke21K3+5+25JjXWCzuof2lgPc25ho5Ux9wzilxzSfLiIMad3n3b1URJ/B+Hbme/GqUIDuAXV
 KXSnwCUTlty5MuP9U8wRvvgwIihv3B4HJhpTAd56PHukSRVrRQsLBAeJWxtSfbhnkYLwm7xr3YO
 BfU9XXnPK43zrAIvRL2ZTOmCjKH6VdTlUKLkm5ifoLjrpZMqcvU/QuNRZ0o+GvlH3f3VDShzW+g
 c5jpnR+ZtN182Xd4QMmQR25qRIPH6pGnROOj/GsNaY5VZnI466p8uNViPy9HCRq1gMomEUkNxmj
 Sjv2hSoNMOMe5Rw5IUA6jiRFuiC898BZ9CiLwlse56nFNBXo5gfO+DnNGUvIrRsslCrujbERc/5
 p9DHNSQMaup+snSkhDycpW8ZvPBAwsCMPT3YU2uG77GQ1+XK74LuAlLtL2vX4AeLOURJBz+tYks
 1o=
X-Received: by 2002:a05:600c:198a:b0:490:bb45:79ee with SMTP id
 5b1f17b1804b1-490bb457a7bmr96694925e9.0.1780593877106; 
 Thu, 04 Jun 2026 10:24:37 -0700 (PDT)
Received: from somecomputer (85-127-105-26.dsl.dynamic.surfer.at.
 [85.127.105.26]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3c183asm88712015e9.6.2026.06.04.10.24.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 10:24:36 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: u-boot@lists.denx.de
Cc: alice.guo@nxp.com, peng.fan@nxp.com, upstream+uboot@sigma-star.at
Subject: TZASC misconfiguration on i.mx8m
Date: Thu, 04 Jun 2026 19:24:35 +0200
Message-ID: <3208216.Ym5mLc6kNg@nailgun>
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

Hello!

=46YI, in arch/arm/mach-imx/imx8m/soc.c enable_tzc380() U-Boot configures
region0 to allow secure and non-secure world access.
This is known to be problematic and allows circumventing the TrustZone due =
to
memory aliasing[0][1].

It causes also recent OP-TEE to panic at startup:
E/TC:0 0 Panic 'region0 is not secure configured, non-secure memory alias a=
ccess possible!' at core/arch/arm/plat-imx/tzc380.c:217 <imx_configure_tzas=
c>

This is not a theoretical issue.
On my i.mx8mm evk Board I was able to exploit this and dump all OP-TEE memo=
ry from Linux.

Thanks,
//richard

[0] https://github.com/ARM-software/arm-trusted-firmware/commit/9bf148071aa=
d597e7fe7d1080c00aeb35b67a3dd
[1] https://github.com/OP-TEE/optee_os/commit/443c5817de47f1bd19091b4198068=
98070382a67=20

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT UID/VAT Nr:
ATU 66964118 | FN: 374287y


