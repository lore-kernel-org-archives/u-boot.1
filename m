Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 467BCD46604
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 18:50:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A483280325;
	Thu, 15 Jan 2026 19:50:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IWn+SfPq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B18782BF2; Thu, 15 Jan 2026 19:50:39 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FF2C80077
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 19:50:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7cfd48df0afso808295a34.1
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 10:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768503035; x=1769107835; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LeueNxBBWnZn17nD0VxaE5K3b7uSgSI+cmQ7cw+87NA=;
 b=IWn+SfPqBLGcUT6FSkKAcQ+99Y4WSAeXjuiDzKNwbezqE2HYfE+s1ljDIEzC19YAaf
 Sq9kvKiaiS6hjf0Vq7RjOMCRZmv59junbfFTRjetZxAORftSgBZchGEs3cumHjbB7M+d
 lr4WRiq7s6LxkLHLbBIxJGDA3mES0isFJxUC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768503035; x=1769107835;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LeueNxBBWnZn17nD0VxaE5K3b7uSgSI+cmQ7cw+87NA=;
 b=w8PirCjBNMjNmlAWr1rPTTSDszBuHo5xohPvpVqQuxO9pWe3nOSVb0mKWa/XkQ8F50
 e0RmIsagvPt/1tsCts3ppGY8cswLLx+Zh/ESdRqhT1+i8+KzFZD+9JOsYFVSZm9XWZfE
 NrW2OONu24D+Cd+0kmAR9r2Pnb8nVl9e9p8PCwRv5U365lTXfao6FxXBrQOvX6CgRfx/
 xfj6blxqp+FmmmcIMPWWplmCk6HdNDM/aJ2cukiz2RZcZVFCUMwIJm3mhpW8Tlu0S5AS
 pzMhDXBMqIkFeNQWLd7uU/qlwYxOEAobGIt56A2NVdC7SbYy/FT+/yusX8VdXdXfY08L
 raYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKGWXGVhZZm2XFSUdfLXIr/zUC5zjmXXF53ujAV3z6NxPXZie1fZv6qizsQ7pMuYMNK1fNuak=@lists.denx.de
X-Gm-Message-State: AOJu0YzSdR3kjG8j66+PxH7Gcj7YlA8iX/m4ot8Y31NYCQdXTiKFfXEv
 1OvzcF4KfpJg/2wRClyuTz9E5dfY8U1JX3M5RNBqgw3b5lqJUzHd5f0nGqsYbikefuI=
X-Gm-Gg: AY/fxX7GlerS7N914f/vr/sAbUVC4GPwa4UrMY8gEXytI13WpfzXaNXPl6Od+uGXxwE
 +XavDop2QIsYzhrubWZX/NNsLD7E9SAvoRWGuPDBHGOQkFyVsMYQduyBKReO8Q8ADsgveWjJDdY
 uCngkUT6UI7xC6CU95k/4QGViKfqv+zGlBbdKCl6hqc3NtfozdD8eaiRnGV0iQ/hmri+0G6o+QF
 V6y2oqOpYWAZ4sQceBs95YXnUL0WV0yB4JWRfhzTRgodiXBoYN0tr6LbPdUxf8rL/vI/Sj3mgja
 LKCAmPEWkArVMCvvtXfAC3x9nRhU5saER3BTFTxASqelVRyU0mZdWCEiZ3Bg+4LJiBDJp9APfIr
 r28psRVaUg1TO9wL2swhP/ZE2Qim6jN0TEaCVF8Zz++zLQilDlGjp4v6E2B5DtQqwwHe0XGzJ4p
 7CUQE4SOx+Pb8Y2GrN+umhcYkLBAuDiGEoa2krxYsrLAcqunWWu3KC1acGeXr2m7SU4DNcFLi3w
 QU8ogAtgch6yLCyj5MOBnjYZIAiPgd1xV3nouE=
X-Received: by 2002:a05:6830:370e:b0:7c7:da3:ed27 with SMTP id
 46e09a7af769-7cfdeeaae86mr247938a34.35.1768503035069; 
 Thu, 15 Jan 2026 10:50:35 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cfdf2a696esm162600a34.21.2026.01.15.10.50.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 10:50:34 -0800 (PST)
Date: Thu, 15 Jan 2026 12:50:30 -0600
From: Tom Rini <trini@konsulko.com>
To: "alexander.feilke@ew.tq-group.com" <alexander.feilke@ew.tq-group.com>
Cc: Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, u-boot@ew.tq-group.com
Subject: Re: [BUG] silent hangup when debugging lib/fdtdec.c
Message-ID: <20260115185030.GH3416603@bill-the-cat>
References: <302c38-69287300-35-2a0bce00@4807151>
 <d6f95-69660800-e9-39c27bc0@93971335>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cP9tPGlatbGDATsl"
Content-Disposition: inline
In-Reply-To: <d6f95-69660800-e9-39c27bc0@93971335>
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


--cP9tPGlatbGDATsl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 09:52:35AM +0100, alexander.feilke@ew.tq-group.com =
wrote:
> > > Description: U-Boot hangs silently during boot when enabling DEBUG=20
> > > in lib/fdtdec.c
> > >=20
> > > Not sure if its really a bug or rather a configuration issue on my si=
de.
> > >=20
> > > Minimal steps to reproduce: <see patch>
> > >=20
> > > The hang is caused by `panic("FDT overlap");` later inside the if blo=
ck.
> > > (see `lib/fdtdec.c:1279` in `fdt_find_separate(void)`)
> > >=20
> > > Additionally, no boot log can be seen because serial is initialized a=
fter
> > > loading the devicetree in this boot stage (see `common/board_r.c:665`=
 in
> > > `initcall_run_r(void)`)
> > >=20
> > > Tested on i.MX6 with configs for tqma6d_mba6 and other tq boards that
> > > aren't, mainlined yet (tqma6ulx_mba6ul and tqma7d_mba7).
> > >=20
> > > Any idea what to look for to fix this on our side?
> > >
> >=20
> > I can boot and reproduce the hangup issue on mx7dsabresd:
> >=20
> > <debug_uart>
> > FDT 8787da38 gd 0091de20
> > top 87887538 sp 87800000
> > sys_init_sp_addr 0091ff10
> > gbl_data_size 000000f0
> > FDT overlap
> > resetting ...
> > System reset not supported on this platform
> > ### ERROR ### Please RESET the board ###
>=20
> Just want to revive this topic as the issue is still unresolved.

OK, so looking at this, it's a "feature" as the check doesn't take in to
account that we might not have relocated gd out of initial memory (in
this case, 0x009.....) and in to sdram (0x8.......) and so is a faulty
check.

--=20
Tom

--cP9tPGlatbGDATsl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaWk28gAKCRAr4qD1Cr/k
CvngAQCAh3+6Gs5boVB1SwXEIrn+CQW9ZeS97bvpzxIlPz3QJgEAw2Zk/lOXBP5M
RtRHxUZYmCZVZk7JQ0cNKpLvdY1TSA8=
=QZUL
-----END PGP SIGNATURE-----

--cP9tPGlatbGDATsl--
