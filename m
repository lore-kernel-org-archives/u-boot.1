Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2463AC04FF6
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 16:55:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5FAD88801;
	Fri, 19 Apr 2024 18:55:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="edONunx9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35094887FC; Fri, 19 Apr 2024 18:55:49 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8EBB8882E
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 18:55:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thierry.reding@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a44ad785a44so230330066b.3
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 09:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713545745; x=1714150545; darn=lists.denx.de;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xgrzBsMExDUfUecxBxsh0gljANuZmHYMWdodb2/4Hj0=;
 b=edONunx9bpcTkOG/j9ykfS5jerzy0gFaAVhWK5yAZs+zuf1Q+ULZtbL8N0FaTyHKhh
 J2YkY9gpSxGp1eIjrIhos3PZ5SAkQ1LdARVxrEEubgKc0mdSAccvnKa6hWpMxYbmQaSo
 QgAADp/zdmMP1DAxxnL7bKO7/8wCbEYAZXRpJnL75AabM9vswqQcQvJHRQHXyCjCSJu0
 U0Ci4v2v+SVuD8kSRcgpGUCQo62YIWBB8XSsXcbOstIDMx/E7RzGiBeUOaOGfZVNNtvq
 PuEnkUF0x42RFtChspbx/+XfKAcsXyWBildrHF13JDqB1Gv6qzaelvTGee2Lbm5/J+3n
 ycmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713545745; x=1714150545;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xgrzBsMExDUfUecxBxsh0gljANuZmHYMWdodb2/4Hj0=;
 b=gWGBHcZhSh5H0iiwg+UcqLz3eGVD0De0BCTVrbfrQVDAUhp6Ng/jiQdGcpQFUuG6KK
 SB4sPSJ4VCcuRFuIDZ/hYOhgo3ZpLMFbSh7BXLzE+Ux64A6Lsa8zpUqAc+6MXECyYZqA
 FtrzR4y6IzUQQbzYcRuRP2v6E4faUPi/Trb9ltXfjTY/CogBGomz81ej6gxhLXEKdYm2
 Lc178//nzr+h8h/rcgDd+d0RKNjBOGV137ZmXybjYfzOCz3fFgCO+Yr6DzEwpspfVorK
 6CcRR8Td3GEc/lapOfCqRfJYAw4QBCD1d2f3ot+YYsyQM2V3tL1OOQOvAoskxOGmmLSn
 pP1w==
X-Gm-Message-State: AOJu0YxOMI6lXAPBYyBuG/TFh55xKslg4Xusb5VDYzjDOSXOJrtAM62K
 SAUoloLaqYfzaO85tYMn18puuCoJHyna0g7IYGFSiY1Y2JbZ6V3L
X-Google-Smtp-Source: AGHT+IFS2oPopzKLVu8yWxNsmpvOzXAmyLWuaolmsWkg6GrlDqvrFWXfb9RJDetc3s2FL2lfCFvTzQ==
X-Received: by 2002:a17:906:4f15:b0:a53:fdc6:3ca7 with SMTP id
 t21-20020a1709064f1500b00a53fdc63ca7mr1982732eju.26.1713545745092; 
 Fri, 19 Apr 2024 09:55:45 -0700 (PDT)
Received: from localhost
 (p200300e41f162000f22f74fffe1f3a53.dip0.t-ipconnect.de.
 [2003:e4:1f16:2000:f22f:74ff:fe1f:3a53])
 by smtp.gmail.com with ESMTPSA id
 d3-20020a1709064c4300b00a520e463227sm2393174ejw.127.2024.04.19.09.55.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Apr 2024 09:55:44 -0700 (PDT)
Content-Type: multipart/signed;
 boundary=9b733966f4c715a2eb01b5c62c256c88795b7acd3671ed67821a2cd2d1c6;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Mime-Version: 1.0
Date: Fri, 19 Apr 2024 18:55:44 +0200
Message-Id: <D0O99RL7IEVJ.2RGMNOIINJ0U2@gmail.com>
Cc: <u-boot@lists.denx.de>
Subject: Re: [PATCH v6 07/18] video: tegra20: dc: add powergate
From: "Thierry Reding" <thierry.reding@gmail.com>
To: "Svyatoslav Ryhel" <clamor95@gmail.com>, "Thierry Reding"
 <treding@nvidia.com>, "Anatolij Gustschin" <agust@denx.de>, "Simon Glass"
 <sjg@chromium.org>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240123171633.246057-1-clamor95@gmail.com>
 <20240123171633.246057-8-clamor95@gmail.com>
In-Reply-To: <20240123171633.246057-8-clamor95@gmail.com>
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

--9b733966f4c715a2eb01b5c62c256c88795b7acd3671ed67821a2cd2d1c6
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Jan 23, 2024 at 6:16 PM CET, Svyatoslav Ryhel wrote:
> Add powergate use on T114 to complete resetting of DC.
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/video/tegra20/tegra-dc.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)

Seems correct:

Reviewed-by: Thierry Reding <treding@nvidia.com>

--9b733966f4c715a2eb01b5c62c256c88795b7acd3671ed67821a2cd2d1c6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmYiohAACgkQ3SOs138+
s6Eoag/6A6zZCtShakRmwDI6k9iRD+1ciUUpu7sGp1kd13VH3HqA1+Cetmll9PWu
NljH9OEBmi909zmh393mfnfnuZpL6X5Gm1X3x4t76pOrwt05+ZDPfslRuYxTdurh
wxTfzBAqm+ouaXTHQf8FVXN6Ro0opC3f6YfIhSLf5ODIhHgsYouWitZJocJNFs2X
b72VZSvwoIO+FWs+NIGBe3qT7EW4SFlh2dV5TSAvBG5domUhR0IeRr76fr+SyCrb
UuVPqwVwxl1uRp5KZdYyUEjes44k4sx15xrv38NVFBJIk0e2/RdXOpmkLWQgOrhK
/K16gC7sqFrHv/cfv4buauj2gFmsWsK4HX00zD2H9NDt0a3XsiqyFN+NSGunKsA/
yYeNSzABtYbh0geGvQgIQxsXeen3aSwEAcoyhOEX9SJzMmgeZBhn184BssfWc18O
KYkNVeQDNlsslA7FvNP+tWk3HITUZ0uJPlGUNzOX33dIkwhbA5P3uec3/5YCw4lb
zaOwOqVX2E0iJtDCWzUv6AxhjIg0AE74Szv5eDoH53mQaLkVbxj6RCMsFK2fc2fr
FvBo65469qHK6LO+ARmAQ7oVzJdMHRxoPOJCsjpfyebGfqJHGU7dQxi2u1sCKhw/
KDhmzGFMENZkGfoGlPMCl5BLY5LXd7X2SaG1RoyZKqWt0/5oWZc=
=GEkU
-----END PGP SIGNATURE-----

--9b733966f4c715a2eb01b5c62c256c88795b7acd3671ed67821a2cd2d1c6--
