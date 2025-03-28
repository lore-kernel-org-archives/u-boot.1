Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00128C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 16:18:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 780808144A;
	Fri, 28 Mar 2025 17:18:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t9vE3HtU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 298D681951; Fri, 28 Mar 2025 17:18:53 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C48A810EA
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 17:18:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-72c0b4a038fso1567746a34.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 09:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743178729; x=1743783529; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MrTNOVqmXCFRiugJpVHkHN3nMupNOL+VQffvMEPLhuM=;
 b=t9vE3HtUbu+6TXkFrbgIgfF/5pGs9wIdscBaKZBNpZldj6PO4bJyv6NgB4AnTZUxuy
 zswyADccjEVUcpmO52LhHWdojlAFkPSs6LJbN1piN132MwXYVWTD0P93ezilMp+nFffh
 yEGrXfJ5ThwHSH/bSWH5jmc3h4WM9HFdZKRWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743178729; x=1743783529;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MrTNOVqmXCFRiugJpVHkHN3nMupNOL+VQffvMEPLhuM=;
 b=URYw5JYTrMbI0yh3r9ngNBwelhb7D0gvnjls9INTR0ipL9IVcz8vIqdhNu7SiB1O+9
 w6E1hJ04HT3WZIqiNT3ll67KsiSkWhC6ITcBNHjZ41tCpNKWNdNIkpNzci6GtUoLn30e
 fZdDfcErbfoQZu5bQBbdzVMB6Qe+TFEC0CRXLr1qY/AQiMpTzjtz+pqSGLtgFjBTS6xb
 pKTTy6Ht83uwigM2qcV06gXe7PdPqn9E01XPlPhFFsCmdks690tHCsOJIx0Qnkf7qbu4
 UpSeQ0nSVCSW+x/3U2cRa4I3KiKFTkvnKiKRMleQBnC8MVveqanr5US+XcKjuXq7ovbr
 pU5Q==
X-Gm-Message-State: AOJu0Yw/xQmZM9oADGJGzQE2fG5IMPfEybxzQjjUjCLh/OGPT0UgRVou
 0bzfWMlQE2cEB0qsvVurxr7x2i92XW/50JUp6WfTNFbh06MScVQjEgvlzuZzwto=
X-Gm-Gg: ASbGnctzwTAqZ54rJGL0Zn0DYKy3obJDL1qpz3k5YGd2v2gtElCeYQShC+sw787xJFa
 QBvRRcc8D7kMvG7mLQBGFHX7VzL68EWlKqtLpOPERr+gAybmTPlVAE7gY1sGoGlx+uKHency/E9
 yNmSJhW3uTFlfCwQXf88DG5qNElbaOZ0EFDjcrb0awbudCEKk7/y+Feb8NlgfhwNwp6abUbpNP8
 UWM0WVMnm9rv7R/5IkVLOJS9bE99wj8ifqDcDDq+GotdBS3S63ljW0kcBOrFqC+qUlA7eMN+Trh
 aH1Ceycn3ffVMEPBzIE9gKj9NrGLBB9XdsqxmnqFJT35GLx0Oe5Rfl2hjbfT9ReuN/Cw50KxeGa
 opjzHtiXsRe5WXhLx
X-Google-Smtp-Source: AGHT+IGmwUbgaisle9TCAHUanF/kVEFXeTPBXvVEJyVjHkPMht0NQnqh13zsXGlC/50jCEDQac2OJQ==
X-Received: by 2002:a05:6830:6997:b0:727:39d7:b0d5 with SMTP id
 46e09a7af769-72c4c989332mr6743708a34.15.1743178729130; 
 Fri, 28 Mar 2025 09:18:49 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c580915b1sm421795a34.9.2025.03.28.09.18.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 09:18:48 -0700 (PDT)
Date: Fri, 28 Mar 2025 10:18:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Jerry Van Baren <vanbaren@cideas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Levi Yun <yeoreum.yun@arm.com>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marek Vasut <marex@denx.de>, Matthias Brugger <mbrugger@suse.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@kernel.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 mason1920 <mason1920@use.startmail.com>
Subject: Re: [PATCH 0/4] bloblist: fdt: Clean up the code
Message-ID: <20250328161845.GB93000@bill-the-cat>
References: <20250328154401.3563921-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NE78sIRqP/iLyYqO"
Content-Disposition: inline
In-Reply-To: <20250328154401.3563921-1-sjg@chromium.org>
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


--NE78sIRqP/iLyYqO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 09:43:54AM -0600, Simon Glass wrote:

> The bloblist code took what I consider to be a wrong turn a year or so
> ago. As discussed with Tom, this series proposes a way to arrange things
> so that it is simpler to understand and manage.
>=20
> - Unwind some of the nesting in bloblist_init()
> - Avoid needing to init the bloblist just to get the FDT
> - Create a deterministic OF_BLOBLIST option rather than using guesswork
>=20
> It is to be hoped that we can get a platform which uses OF_BLOBLIST into
> CI at some point. In the meantime, the standard passage series[1] could
> be resurrected to give some coverage.
>=20
> [1] https://patchwork.ozlabs.org/project/uboot/list/?series=3D281465&stat=
e=3D*

Based on how it's documented to be run in
doc/board/armltd/vexpress64.rst in the next branch, have you confirmed
that platforms using the handoff spec still work?

--=20
Tom

--NE78sIRqP/iLyYqO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfmy+UACgkQFHw5/5Y0
tyxPHQv9GkC1tSMMqrwXWM8UwzKF3NoYwotBtXBJlZ5ybyMWb67jIvBJ0r/oPCPB
Or33XJiB2WpUxTVvxl67FLhG+d8LAbnDj3cqXgCLi3rmfyWEErxgLLG2Ht35ogzq
jcbTFufJ1jIpUdoS89AKY+BphXLWSZZr06+aqOqUxUl54RtIEhARpzliJCrH3p82
9ZKhrIec7dls9BoCPdJn33HeH6yTdtK7vuFxJ9dVjNWJ9UqjO89x4npimBZ7KOXh
Hxswf2CNGuxbQvTAxsQj9+EYFpTjO+txckPaBvpxa/QSZA10vKo/USqAXykth9+G
5pwWK2oVwS29UO3bxLQWN+pEVtkUTFidIVdYj7FOtPj3AJjvwnZR0wWJyx+KxEjw
1CYq7OJzKj11iCOqU4qugqljoHSvxy9lsU+6vL3JxhyDz//j1wLbSLngWK4p0+Dz
J41zFj39FDIMo0kYrP0ZLXs4y16tYTxe627Q/tYc3gwhxa5lzjJeYabBcn5jHKOz
c1jqEo9R
=owHK
-----END PGP SIGNATURE-----

--NE78sIRqP/iLyYqO--
