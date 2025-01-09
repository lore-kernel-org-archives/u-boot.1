Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC5EE7719A
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 22:28:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A188A800C2;
	Thu,  9 Jan 2025 23:28:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qPsv12MO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5693C800D0; Thu,  9 Jan 2025 23:28:27 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C4EC8001F
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 23:28:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-467a37a2a53so15066591cf.2
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 14:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736461704; x=1737066504; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iGCwrn/LyJXzb7m/+pTj0p0ChfXrYtyo4So5dzAdABg=;
 b=qPsv12MO1FRorg54dwBJ3b/T/4rPyU0q2QBspTkeQk4GT4JYeom3NxZrh/hQ6zWlVZ
 PnHX87DETPG67wcC910sJRoynfUOiQhsnXqRV7OhxuSxPM5N9bvmxe4/zlCWr6QMFbgZ
 ZRCqcy2N0h8WeOAwUsAPE2t+sMdZoyvvJ+jao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736461704; x=1737066504;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iGCwrn/LyJXzb7m/+pTj0p0ChfXrYtyo4So5dzAdABg=;
 b=VsCm9xj6AOoWCAJcbtetT3T9x19v6MqNIx9nZUMcwwmtvz58NgCxXXFVsixdlM938x
 3g1i1tYaIRrF9IgWHGUHxDNo5sDLhgBMJdWI3J5P05WdEWoo9iGtbLbDyv9MkEqnpNfK
 UFZnWIVfhD9bmq69PhmL3860Lrrr0EOJach+Ckbf8wlYGnljyr0/2o4aEExDdO3w8aGT
 fHa3ZV0puH7+YNw/tuuX0+ayun6/AQUPhAa8gca1S297SuLwolNsrQCDMvHC0QSBwym+
 oh1/D8LN6qR1ZwC15EiiRL30tIgzCDNttltO/UCf2i/xY3prXkoBxjLa+hc0U1QP7HNv
 11qg==
X-Gm-Message-State: AOJu0YzU8WfEk+JD7If7EoijVwiZ9oNVfBB2hQkMRqKjapgvk8exbB7h
 FLQlc37ptrefH3tR7IJo1717F3PSsqw+TqpZP1aINyib06KUMFuKnj1tMFvvKjM=
X-Gm-Gg: ASbGnctuS9idwrr+EmIAnAbE9Q/WW6EikPWlBHUvQWF2bmmUJdY7zdb6qRJoR09ld14
 2wsQRgPHgRDkf1JDx4Wjj1fsfy82ZANhyd9PJMlt42Q2SurWpcr+7d8FAKzdvEp8/RFtv88NkPT
 ytp0Uisw9TD8NJzymZJacUsKlWyI0r3ERa6uBG8D+/36Y1waV39KOogM6nNpZIANURABGENogUY
 bMCQC77ZnF0nrJzhDYd41X3jiq2wfWYt7udLvaR2oln42saRlgwRXA=
X-Google-Smtp-Source: AGHT+IEiDgAeneyT0k6kdpMHEM+e9+Jrj0H5ieMO5FP0ViVwJB9ARlg+lu5YuI7FcLSmGdLE32iy/Q==
X-Received: by 2002:a05:6214:6215:b0:6df:9cfa:8df2 with SMTP id
 6a1803df08f44-6df9cfa8e47mr79272336d6.41.1736461703990; 
 Thu, 09 Jan 2025 14:28:23 -0800 (PST)
Received: from bill-the-cat ([187.144.0.100]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfadeb40eesm2787166d6.123.2025.01.09.14.28.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 14:28:23 -0800 (PST)
Date: Thu, 9 Jan 2025 16:28:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Anand Moon <linux.amoon@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: Re: [PATCH v2 22/33] emulation: Use bloblist to hold tables
Message-ID: <20250109222819.GE3476@bill-the-cat>
References: <20250106143229.3023771-1-sjg@chromium.org>
 <20250106143229.3023771-23-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7uBm78r8pV30MybD"
Content-Disposition: inline
In-Reply-To: <20250106143229.3023771-23-sjg@chromium.org>
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


--7uBm78r8pV30MybD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 06, 2025 at 07:32:18AM -0700, Simon Glass wrote:

> QEMU can have its own internal ACPI and SMBIOS tables. At present U-Boot
> copies out the SMBIOS tables but points directly to the ACPI ones.
>=20
> The ACPI tables are not aligned on a 4KB boundary, which means that UPL
> cannot use them directly, since it uses a reserved-memory node for the
> tables and that it assumed (by EDK2) to be 4KB-aligned.
>=20
> On x86, QEMU completely takes over the generation of these tables, thus
> making it difficult to use any common code.
>=20
> Adjust the logic to fit within the existing table-generation code. Use a
> bloblist always and ensure that the ACPI tables is placed in an aligned
> region. Set a size of 8K for QEMU. This does not actually put all the
> tables in one place, for QEMU, since it currently adds a pointer to the
> tables in QFW.
>=20
> On ARM, enable bloblist so that SMBIOS tables can be added to the
> bloblist.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Commits that are "big external project is doing things wrong, we need to
work around it" are at best worrisome to me. If re-thinking what you're
doing here isn't right, re-wording what you're doing to not be negative
about other projects is what's needed then.

--=20
Tom

--7uBm78r8pV30MybD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeATXgACgkQFHw5/5Y0
tyzJCgv6Az6k2QwbrSsZBuorAYfF2+HbkHYSZahFXTDJYCLdmpgFkFkd6H1lLRb4
LfeZcpoB1MmhLYxd4Ep5Fa/VZ066fitRXng7uurMDiNGRQKV83ZlcULwls0jOIbh
oWgjrvL32vzAblt8R+Xmdf30tJY4N21ZMGs/ZD0XUxtbVlo3bP5cvWDIyOLwV++4
6COxQ1nJLNar7DJWn3HUH5rPgGx0g58PNYMHRLtXr3VxX9lk3TATBpOgGAmpvzZs
TMn5+wTOKYRMDQF7gbJjNi2wSoOuoeKOJQAyhc1TNhKZaY+MF0QhQdTALZifYD7o
eCRmer3FAMEzROkSdbz6mPdJeRncmTNDTABHE0UhQwVl3l6sjqXH1i4tUG6w0DRk
NdV+fzzWqJCUspYA+WtVi7CdVRzJMa/03zNTIjpltb/HMJDpDHntlLZiztXzWpT4
b2HJEQP/BrPQdu9kOzot5j46CioPe/cBY9jkCMxLL/yXbNAybpaWSZVsPVLNwzcq
uFsj6LEq
=rfXU
-----END PGP SIGNATURE-----

--7uBm78r8pV30MybD--
