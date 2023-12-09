Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA5CBC4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 19:12:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CF468761B;
	Sat,  9 Dec 2023 20:12:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="URJlaTad";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AC8A8769A; Sat,  9 Dec 2023 20:09:39 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2D8787645
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 20:09:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5dd3affae03so31240377b3.1
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 11:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702148975; x=1702753775; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hAaCL7BYmZMnuSKoibN7rs7/9V7TiLn5z7cfjm6tVjY=;
 b=URJlaTadlZc7QCMiW/nVpiJFaDLzpjNCDXY/VNvWLl1Fm1IXNka+67nRg6bij1enDq
 EF3EVutog5Fm2xhX0RDPO5uKtyWXGyqX8uPFcg2QPI2bg0IhwSwX/cp5d1+Tbw1R67b9
 lzxdzqRfSCUCvAQDvzQ3t+M2qDaGSvuHssfQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702148975; x=1702753775;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hAaCL7BYmZMnuSKoibN7rs7/9V7TiLn5z7cfjm6tVjY=;
 b=mxi5+Q6v63BBZyeXffs2ca57wRcQBIzBUWGknYBj1rOLc77e6r9Yn4L0iRnO8MW5+A
 IYW734F/Y1gv4rTL17zZO96qlSJJEAbCFxaFU4xH7L/4eXdBRuU0RpUuZ8Urrw/bmE26
 y2YCsPn9Jg/q7GEOw1H78QDn/WfegMHUcnzN1UjbOMQfpTnirEN0axElp3Fi1RpOKHuW
 cKmBIkZ9ULN3VXq8Ic5Ce82wEPPnoYxy5dpmIeJ7fLROElTivMSbP8OnfWL/9IQU36ZO
 F1/s2olsBxlhWWPX++bsITke6Ff6ChXKLJ1Ey1OTCsehVtBcS/s0A9FVKuzDcN0qg+0s
 06hw==
X-Gm-Message-State: AOJu0Yy+blxxCUoyUJBLt9/eS3Ab+R+fBXNh8cQ6gfCEE8IONLuVMFDQ
 Bt5o/eZi+CwLbdIeCROyUVx6IA==
X-Google-Smtp-Source: AGHT+IH8FTtoV4LCORXGJ+R6BHeB5aH+dJQUVyWeNCHkuUcuDO2DyMTwIqTO/zJsccalwWf7/X4yjw==
X-Received: by 2002:a81:49c2:0:b0:5d3:d6c3:dca with SMTP id
 w185-20020a8149c2000000b005d3d6c30dcamr1568268ywa.21.1702148975323; 
 Sat, 09 Dec 2023 11:09:35 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-b2bd-da43-c83a-80e1.res6.spectrum.com.
 [2603:6081:7b00:6400:b2bd:da43:c83a:80e1])
 by smtp.gmail.com with ESMTPSA id
 i75-20020a816d4e000000b005d78504d649sm1663917ywc.46.2023.12.09.11.09.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Dec 2023 11:09:34 -0800 (PST)
Date: Sat, 9 Dec 2023 14:09:32 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Alison Wang <alison.wang@nxp.com>, Andy Fleming <afleming@gmail.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Angelo Dureghello <angelo@sysam.it>, Bin Meng <bmeng.cn@gmail.com>,
 Chanho Park <chanho61.park@samsung.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Eddie James <eajames@linux.ibm.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo <ycliang@andestech.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marek Vasut <marex@denx.de>, Mario Six <mario.six@gdsys.cc>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Nikita Shubin <n.shubin@yadro.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Priyanka Jain <priyanka.jain@nxp.com>,
 Rick Chen <rick@andestech.com>, Safae Ouajih <souajih@baylibre.com>,
 Scott McNutt <smcnutt@psyent.com>,
 Sean Anderson <sean.anderson@seco.com>, Stefan Roese <sr@denx.de>,
 Thomas Chou <thomas@wytron.com.tw>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>,
 Wolfgang Denk <wd@denx.de>, uboot-snps-arc@synopsys.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 00/18] Complete decoupling of bootm logic from commands
Message-ID: <20231209190932.GZ2513409@bill-the-cat>
References: <20231204002642.895926-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UjHsMEPOxitlg71z"
Content-Disposition: inline
In-Reply-To: <20231204002642.895926-1-sjg@chromium.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Sat, 09 Dec 2023 20:12:32 +0100
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


--UjHsMEPOxitlg71z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 03, 2023 at 05:26:16PM -0700, Simon Glass wrote:

> This series continues refactoring the bootm code to allow it to be used
> with CONFIG_COMMAND disabled. The OS-handling code is refactored and
> a new bootm_run() function is created to run through the bootm stages.
> This completes the work.
>=20
> A booti_go() function is created also, in case it proves useful, but at
> last for now standard boot does not use this.
>=20
> This is cmdd (part d of CMDLINE refactoring)
> It depends on dm/bootstda-working
> which depends on dm/cmdc-working

Since I would ask "what's the size impact of all of this?", I went and
checked. I rebased your current cmdd-working branch on top of current
next, and compared. While I'm sure this will change a little given
feedback so far, generally platforms shrink a little (probably due to
the bootm args stuff you dropped, but may need to keep). The only big
growth I saw was branch specific and your "rpi" patch, oh yes, that
grows rpi_4 given that you change a bunch of stuff there. So that
doesn't count.

So generally speaking, I'm OK with this series up to cmdd-working, and
will continue catching up and providing specific feedback.

--=20
Tom

--UjHsMEPOxitlg71z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV0u2kACgkQFHw5/5Y0
tyxSigv+IZ4ufD+fIfkPuYLNx9+PKyqjDrgpua68CZ++L8UZ2QuAckn4LSkpx39O
DDUlm86F3LUm1ZtC2Xh8rD5Zh8pHOs79+7OTpd483CpbZXrhDyC8lQyx5CP5+8V2
g78JsFFT1BTOQ5T3Kl3MaweeZcuEtyRc0QX9XUCjY/ZX5c8EjC0FDaoxf6vPYauX
F4AK6QqsOXW+oKz8ktifukAHm0p1YgOZJLflUxTzYVEuwBdhXM5g8Sb+vSmCxNP4
Hiqifk75yInO8abtgpFaGgE9aCyzLeXwC5izNOcMN7O++8bcZXnoS3T4Rsmg47uR
YDPKogcguiVlZGK3TTWry88quimCxmTZwmXhbz8KPh2JEdYbqTmPtH27sCjUQSBs
+Z3QM6ZTi4fjlGZF6uhZcaLCi9R0agxD8vh9WZvbkMydy9Hls1coW+HnfCRdRc90
3Nz5VL9h2FFZVRdyw/HmS+LGJq16VNh5ShG6Gnka8e1SgNtSpuKaUfcYq9+wH+Gl
7gDJTX2G
=UVkb
-----END PGP SIGNATURE-----

--UjHsMEPOxitlg71z--
