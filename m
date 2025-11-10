Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6DC2CCFA13
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 18:55:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73A2F83A83;
	Mon, 10 Nov 2025 19:55:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Gb8SPAwY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AA5583A8C; Mon, 10 Nov 2025 19:55:13 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B98783A79
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 19:55:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7c6ce4f65f7so1953447a34.0
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 10:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762800910; x=1763405710; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Agyb4lrdPtnP7TUeiPfqdZijmR8GhMyOP9UckRZxLSM=;
 b=Gb8SPAwYWhNbl/xIE6vdeSMkimxobmDM8Ryr9KCbTMdDfprPloI27ACo1D5d5WgUr+
 ux3sLPRD0GEM2IQSg+MstIXDhw7dvbhaZg0QSWPUczuudHdZrha7j+JYuQfk2jx8BL1M
 CQmQowaMZ/rc3B4zAKkZK0cyBbHRUrXLJhxlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762800910; x=1763405710;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Agyb4lrdPtnP7TUeiPfqdZijmR8GhMyOP9UckRZxLSM=;
 b=Y5YycM9DjP8yLtl6vGawr+6CmVgFjArg8ZdMnkOAb/o7Of5cEl8JxvKx0Yu3ZdwN21
 q6maeHbPdPJIaOgWa+Y9FMhbCKGxMdXBnq0tuMyZd8uGZh2qoZahVskaW6UAiuedadXA
 2CQJ3kK8FiwTDpC6Ifk1IcLKqIQCUWYczqJhfn8CE924BsFIQnJiA1/PWKQNv40qu738
 dJ/uNtc17EOeDC7XfQafTm8MuZE4MtLYkxY2L3GOETlGJ+ktJ4lh/kD8USCVfsnNbKvu
 ocfYkXcDcWR6VFvDB9uY2/LrinIFSQFI/W/wWTL12msK+jUPnn0rdH9YX2XU9kFqSGYD
 mw4A==
X-Gm-Message-State: AOJu0YwURUcWOh1zXzUL2LZ0CRFPos8oi/khDu9mixHzWmrBxUOLdgU/
 dtCbvU15bWbH87xlPuxLBQfm4+4wFoMLWN/OcE1/lXowVKCjHjL3ihwyssJyhRLCsNI5i+Y01KO
 MfqldQGNLxg==
X-Gm-Gg: ASbGncsHyYTyA7OWmlMLDc5Lhxlaxm+pluCvw7lBfr0x8Ol0obhofcn/SlU0v2j8XG4
 j+4OIBmLVGTmI4rGpRH6eGY6PAgTTq/LfUl/qHxzGeAewxuGqR1lY+8ew1D0dDi+vZK0f0Ic2V/
 E1uu5mfpwdB9sd15C4phZeske3aNdlWpJsSsjoXcoeZIZN3U4f9bt8RotQTXTAHqckrLENgsbpe
 nvDG+MsG5tsgmKuWtFr9WNtvXUNpH2lDGWf78MxBMBrrW1A/5hRn4eIqys+ytVF8RvMswWIb4Al
 mucHbAkuCWdGvo14RV9oGdb2wAUT9nfZaWx54TFNYlwaderW4848s7EOY2wdjXu4gM43ptZ2Ssa
 W3e5TG6BosLCo64yZLoe/aLLT2U0DmE/d2YviVuxxPqyU1KEQoMPlSFmqRECmOl1eWX8SH+NkR0
 LgFNSUwun4n17udW2/AMjn9Kw1/T39Yd29kP9C2YWsfvasY7X8DQ==
X-Google-Smtp-Source: AGHT+IH+CgL7Wt470nHT8u83fDQqzcPmhWMIEira2bHzOB4YzTF4qedM4csYITO9JKyyMAWg7FixCA==
X-Received: by 2002:a05:6808:80c1:b0:43f:7a07:44d7 with SMTP id
 5614622812f47-4502a472e2emr5082136b6e.47.1762800909612; 
 Mon, 10 Nov 2025 10:55:09 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45002752e8dsm6009019b6e.13.2025.11.10.10.55.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 10:55:09 -0800 (PST)
Date: Mon, 10 Nov 2025 12:55:07 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Kory Maincent <kory.maincent@bootlin.com>
Subject: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20251110185507.GQ6688@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Z+HlPLO+22j/w9xN"
Content-Disposition: inline
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


--Z+HlPLO+22j/w9xN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Here's the latest report. Just 2 new issues, both from the extensions
series. Can we please address these shortly? Thanks!

---------- Forwarded message ---------
=46rom: <scan-admin@coverity.com>
Date: Mon, Nov 10, 2025 at 12:44=E2=80=AFPM
Subject: New Defects reported by Coverity Scan for Das U-Boot
To: <tom.rini@gmail.com>


Hi,

Please find the latest report on new defect(s) introduced to *Das U-Boot*
found with Coverity Scan.

   - *New Defects Found:* 2
   - 1 defect(s), reported by Coverity Scan earlier, were marked fixed in
   the recent build analyzed by Coverity Scan.
   - *Defects Shown:* Showing 2 of 2 defect(s)

Defect Details

** CID 638558:       Memory - illegal accesses  (UNINIT)
/boot/pxe_utils.c: 485           in label_boot_extension()


___________________________________________________________________________=
__________________
*** CID 638558:         Memory - illegal accesses  (UNINIT)
/boot/pxe_utils.c: 485             in label_boot_extension()
479     			return;
480
481     		snprintf(overlay_dir, dir_len, "%s%s", label->fdtdir,
482     			 slash);
483     	} else {
484     		dir_len =3D 2;
>>>     CID 638558:         Memory - illegal accesses  (UNINIT)
>>>     Using uninitialized value "overlay_dir" when calling "snprintf". [N=
ote: The source code implementation of the function has been overridden by =
a builtin model.]
485     		snprintf(overlay_dir, dir_len, "/");
486     	}
487
488     	alist_for_each(extension, extension_list) {
489     		char *overlay_file;
490     		ulong size;

** CID 638557:       Null pointer dereferences  (NULL_RETURNS)


___________________________________________________________________________=
__________________
*** CID 638557:         Null pointer dereferences  (NULL_RETURNS)
/cmd/extension_board.c: 102             in do_extension_list()
96     {
97     	struct alist *extension_list;
98     	struct extension *extension;
99     	int i =3D 0;
100
101     	extension_list =3D extension_get_list();
>>>     CID 638557:         Null pointer dereferences  (NULL_RETURNS)
>>>     Dereferencing a pointer that might be "NULL" "extension_list" when =
calling "alist_get_ptr".
102     	if (!alist_get_ptr(extension_list, 0)) {
103     		printf("No extension registered - Please run \"extension scan\"\n=
");
104     		return CMD_RET_SUCCESS;
105     	}
106
107     	alist_for_each(extension, extension_list) {



View Defects in Coverity Scan
<https://scan.coverity.com/projects/das-u-boot?tab=3Doverview>

Best regards,

The Coverity Scan Admin Team

----- End forwarded message -----

--=20
Tom

--Z+HlPLO+22j/w9xN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRI1AwAKCRAr4qD1Cr/k
ChnBAQDnRMzjR4DD/ybozldFVd8XyCTWtFu8fo7+4QTQFOQCpAD8CHRWLL0pSgWL
zvU0WNyBRShFbZCf+PrEQdjFTwjwdAU=
=jfbu
-----END PGP SIGNATURE-----

--Z+HlPLO+22j/w9xN--
