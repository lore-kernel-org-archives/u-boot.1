Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADBEDCCA472
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 13:56:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B04083D77;
	Wed,  8 Oct 2025 15:56:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="E5r1j2Ie";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6009583F89; Wed,  8 Oct 2025 15:56:00 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B28D83C91
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 15:55:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7a8e7ece907so4258917a34.0
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 06:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759931757; x=1760536557; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CVt3W6DqHL1vgxwBaes8eNTJeguvaGMtzZpifLHfQH0=;
 b=E5r1j2IebO3ogD6JzPoTGLpbMEGZtwqVGgCM0jqnspsyFhiYI7OoRsFe4q6s+mv0a0
 Y9xgJx16ns3Xf/pbSfIl/G1XgG2m1XgqHelEGsPCNiRZBI7oHyysDAjGF/iIlZUme57/
 KrqwJyqvO1+cR4qtqlxUFrbKPztx6Kp1Py0Lc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759931757; x=1760536557;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CVt3W6DqHL1vgxwBaes8eNTJeguvaGMtzZpifLHfQH0=;
 b=R1Dx5MT5xmBtAJlKcNQiHXDhmsbOxu4POepHXHRgSMXSPycHw/OK4/DuqghOHpWGNP
 Ks7JlIcLXmWylnxBj/VcNu0962p5t1IT1hgt+EACRLAQSa2gcRpisJfR4ZmCfWm4yAni
 IyD8ZHe86F8EVvJmVsrvRMJpn97GPyRPzNwXhwz/XNHfwoyqAQJw0Ef9Pw8BGl9gaV71
 +8+nptPUhIb0ny1LK28SRyLgpXVb8knlxTC1G5Qx4eFmWV7Q+a9qNX4ZKPejmzayERgJ
 ArhHU39QeRB0vsQJ2yZSGLJG2OgHiI6SLfASotyFrXdMEecZ8xJBKBdOKCSG0vZm30DW
 A0Ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCULzW+ZkJomNtiQNUlukAFf+e4anHcp4gJlCy16+oHA+LLgIatEjdLfRJB2TzG/HdYRjql7fP4=@lists.denx.de
X-Gm-Message-State: AOJu0Yy6Jjox/7OiEHlurwTmMpMrEd/b+KDCWyrZUTw46By6GyaX4zYo
 pB6fxPumTpd20zzzVCRoXnqnzHQBIhce/2rzdcuzG/EwHUtBIMWuYSVDl1hM4txRlpo=
X-Gm-Gg: ASbGncsX2M+z20b/HxNSlJwVPGMfIdXXcIZoB6Gzfss1vISlkdDrMX/Ms8dCru7WiC4
 Ym4N6Vf8uptaxcsZUzGiXrL3r/renWNfyCSGQM9Wz6IQn/tPZl+I1HyKL4fGNSgArz9O6ib/c9Q
 JD7Db4775Pvw+UDV/h/2/uBnzrpjPFq4TxFYivW2hJsp5UzjmvwCTGKi5swnncknmM5Kk3mdLTH
 9iWqAcRz/ErEtKVcJQv6LiDapTmd15MHX5PPM+rMqW4Ls4R5gtzsPKUZx5jhEvkTNEtM0RbC6vY
 yR6xKBL0jJDqsFnMKkev90BowQR2ZrlnzDOneJlBITSixeItQqX/YqvloQHK4Cij8vQ7D/7Av6Y
 +Y0SFxYFYNMt9mWXbgxE6aia7+a6bu1SW1YzrHb3lmF3eAEChRDa/X/sKC3O9o8SOXkHBiqD13W
 u+qkfc58leJA==
X-Google-Smtp-Source: AGHT+IFvbIdzaqNv4L3btFQKYq0lRCIwwCZwr9fNgOlwBMhZNvtZqiLiv8IS811I/lhWUSVob7ahZA==
X-Received: by 2002:a05:6830:2115:b0:795:99bb:f719 with SMTP id
 46e09a7af769-7c0df79f751mr1852323a34.23.1759931756859; 
 Wed, 08 Oct 2025 06:55:56 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7bf43028a10sm5775538a34.22.2025.10.08.06.55.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 06:55:55 -0700 (PDT)
Date: Wed, 8 Oct 2025 07:55:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Benjamin Hahn <B.Hahn@phytec.de>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v3] bootstd: make it possible to use tftp for netboot
 with standardboot
Message-ID: <20251008135553.GR298503@bill-the-cat>
References: <20250924-ip_dyn_bootstd-v3-1-f67864b81a79@phytec.de>
 <20251007234906.GA577000@bill-the-cat>
 <f6fb56e3-f1ab-432a-8d08-89bdd63bd8df@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="peBMEeL4h3xxNSG0"
Content-Disposition: inline
In-Reply-To: <f6fb56e3-f1ab-432a-8d08-89bdd63bd8df@linaro.org>
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


--peBMEeL4h3xxNSG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2025 at 11:20:12AM +0200, Jerome Forissier wrote:
> Hi Tom & all,
>=20
> On 10/8/25 01:49, Tom Rini wrote:
> > On Wed, Sep 24, 2025 at 09:41:41AM +0200, Benjamin Hahn wrote:
> >=20
> >> Add the option to load the bootscript with the tftp command (static IP)
> >> instead of the dhcp command (dynamic IP). For this a new function
> >> tftpb_run similar to dhcp_run, is needed. The selection of which comma=
nd
> >> to use can be done with the ip_dyn environment variable, which can be
> >> set to yes or no. The ip_dyn variable was chosen as it is already in u=
se
> >> on the imx platforms.
> >> Also edit the bootstd doc.
> >>
> >> Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
> >=20
> > OK, so this fails to build on qemu_arm64_lwip (and a few other lwip
> > targets) because tftpb_run was defined just for the legacy stack and not
> > lwIP too. But, and this is a question for Jerome too, why isn't dhcp_run
> > already in the common network file and instead written again in
> > net/lwip/dhcp.c?
>=20
> No particular reason. This must have been an oversight when I introduced
> lwIP.
>=20
> > And for both of you, can we perhaps have a common
> > function or functions? The lwIP one does handle tftp it looks like.
> > Thanks!
>=20
> Yeah. IMO, dhcp_run() should be common, but I'm not sure the NET_LWIP one
> is correct TBH. The comment "Assume DHCP was already performed" is
> suspicious and I'd rather use the NET one. That is, move dhcp_run() from
> cmd/net.c into net/net-common.c, discard dhcp_run() from net/lwip/dhcp.c,
> and see if that works as expected.

Sounds like a good plan, thanks!

--=20
Tom

--peBMEeL4h3xxNSG0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOZtZgAKCRAr4qD1Cr/k
CmOKAP9J6zX38ffPEeqybIMik0fUbmORmUrCnAf4RcjXUSNxMQEA96gXiQhRB4VZ
tW5Q0+qVl43IlvGd2M0o8enIuGRRmQY=
=zRV2
-----END PGP SIGNATURE-----

--peBMEeL4h3xxNSG0--
