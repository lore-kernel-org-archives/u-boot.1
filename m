Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED34D2D111
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 14:42:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7CB2803F5;
	Tue, 13 Jan 2026 15:42:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GkTFBxYM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23F4480433; Tue, 13 Jan 2026 15:42:51 +0100 (CET)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A62A3800B6
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 15:42:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-65b73eacdfcso1725625eaf.2
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 06:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768315367; x=1768920167; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5uR+Q/zI/IQKPfAf/aVMIUrTBd+NQ7Ht4hitwZfzF14=;
 b=GkTFBxYMSMXCx5iqM4lQxUOugXfiBeLjUtVywRfxZXrPvgNMqJEErJfBjHLrwriWQi
 6c9XWgGZgGVPos5o+Y9CvaXEG2N8TMkqu1fWtSrpPo4oSznSJ3RSlWezqVNnDoYzaHVs
 koACpA+S7j+J3s2oxtOPCM8/q6c05B5YlY3UI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768315367; x=1768920167;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5uR+Q/zI/IQKPfAf/aVMIUrTBd+NQ7Ht4hitwZfzF14=;
 b=TCOncOGH5+FgBHt2XTnpqBqd8GHvD1cdzCePke0Vl4VQ+/sl9skcgepSnUMo83OaRU
 4rQejP8MqB5ebF8KIqnrqcaqFzlfEHD1aZufRYcSDGLtx2luf1hcNa6liGo3a+M3hmFC
 Z3nkaJyrbQ/w2gfS4XiBZUEqgfNkKVA5XCZLcG5ZxiVU/nJBKNvhQGbq3qgu2O1Gwh/G
 3gMoKU479amJTxVJMG1yXseknyzlv9CVxDPguAM/IDrWWulXceVjql3zP4qfZ1ynq2R5
 rdllRC2NzOsbuTSBOxZvz/EFUAxP+dhAMQJtwHmm7Xej7Goqf9ftx6HTfcKZgEnlQp/z
 ucnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8388WkU7loKZ0sL6abMJTIfKJmUeMrfi2rl3fnJh5ism3HcjcF73gz9XmcmF3RGzjJjZFVUY=@lists.denx.de
X-Gm-Message-State: AOJu0YzUyMPxPBanhcnWIzADPeXgOxF27dFlNXH39yJ8bu82K7zm0mW3
 +tuElL659s+kMEPYilFkdyYh+EwdPVTlq3Zbl3d3yDN0GUnJ+f4iF/aUccNCVgzKWnk=
X-Gm-Gg: AY/fxX7a+O9war+liPmKx9Z+sBSEKetBtslPPapi0ofGPvyP34hYfEd54T9IQ6S6FkC
 oLpDLYBWyA0HDNhq7FEjd5/bWagmaQcWEYYpmCxcOdtoALYVutB3/GU84IVAabkr0OBtGOGwZ9h
 m1spba302sy0gZ+A0uTjX5CHKroJ3gxazfvH+OZpCdx1Y2B58ZW0zkxhW+gslHxblRXAP4bSlJB
 6E7FvQHU0yKqL+K0zXRr1DDsHhBt35a0w+3YCmWDJirkedj0o1lbWve8+atOAFRNjMtFbIAVLgZ
 LrtLzhQRW1H8/L5knyjSmFV4gkeoOKElREuiT4bgd+R5fLSocBAWPXZXktPl4NNhHH3aLkZfBM3
 09sVotS+mVJWE2h3iFd4sgMmcpgVWPZUa6gd3HUaB4sTdTCb1K+tx+oQ+4cgCIzMOCJrnMEnOmv
 471JE4MCJERMfILKUpkLROm5WlbgYeSVmrC5ej1SAm9oeSZft2dKKBcl7NaO6SQyc2AXesJbGAH
 VhpS+1aIcqQBkUeY4iOuGSYT5OnybhDxFOm3N4=
X-Google-Smtp-Source: AGHT+IGuzBZc/n5OqDh7B7WuQT3b6waiNl0g8Qu9fbrmJ2gbfso5ilVdZgAe9MOm7G39XAYwhEH7Lw==
X-Received: by 2002:a05:6820:228b:b0:65b:2661:6440 with SMTP id
 006d021491bc7-65f54ef159fmr10333949eaf.23.1768315367362; 
 Tue, 13 Jan 2026 06:42:47 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ffa50722e9sm14300777fac.14.2026.01.13.06.42.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 06:42:46 -0800 (PST)
Date: Tue, 13 Jan 2026 08:42:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, ilias.apalodimas@linaro.org,
 jerome@forissier.org, marek.vasut+renesas@mailbox.org,
 christopher.obbard@linaro.org, me@samcday.com, michal.simek@amd.com,
 clamor95@gmail.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH v5 0/5] Implement reset to EDL for qcs9100
Message-ID: <20260113144244.GV3416603@bill-the-cat>
References: <20260113103840.1948029-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UbfioOaZYRq0PmO4"
Content-Disposition: inline
In-Reply-To: <20260113103840.1948029-1-varadarajan.narayanan@oss.qualcomm.com>
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


--UbfioOaZYRq0PmO4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 04:08:35PM +0530, Varadarajan Narayanan wrote:

> Using the 'reboot edl' command in Linux, the platform can reboot to the
> Emergency Download mode. Implement the same for U-Boot.

Have you used buildman's size checking options before? If not,
https://source.denx.de/u-boot/u-boot-extras/-/blob/master/contrib/trini/u-b=
oot-size-test.sh?ref_type=3Dheads
may be helpful to you, as it can be a bit tricky at first (but IMHO is
better than the linux kernel bloat-o-meter). I ask because, what is the
size impact of these changes on things like say qemu_arm64 and qemu_arm?
I saw the cmd/ portion is guarded by a new CONFIG option which is good,
but I wonder about the more generic sysreset changes. Thanks!

--=20
Tom

--UbfioOaZYRq0PmO4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaWZZ4AAKCRAr4qD1Cr/k
Csm6AQDM2JcAHlrjkMHqmR1b9Jeywk972v7dah7hCE+QCZuj4QEAuCcPRBaSprST
TMs2cnzUiRLTJ1D12ddMT1tkQEmpBQs=
=LsCA
-----END PGP SIGNATURE-----

--UbfioOaZYRq0PmO4--
