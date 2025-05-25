Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F211C54E90
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 13:56:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFBE982B37;
	Sun, 25 May 2025 15:56:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RdRECNfC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E71082B6B; Sun, 25 May 2025 15:56:00 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4194382998
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 15:55:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-731e277a6b0so1125967a34.1
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 06:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748181357; x=1748786157; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OFfx7g7czQ6poGraHxQsD/zApTG0tzdqzqymT/Pf8Ts=;
 b=RdRECNfCanX1Rel23HzkZwRlDk5N+vZRTvL6noMZX61PVo/2yxghl7cYjTYkYS+kBY
 Co7dMfZ3sVUMxI4RVTvnHU8mk1UcbOZwhOdQwip586WFXfv5Hg7y2oJQFcUaWPMopuyl
 6yE9iQ8v+Jjl/cXVq7Bxq0bdvaQZ0YPToRZXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748181357; x=1748786157;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OFfx7g7czQ6poGraHxQsD/zApTG0tzdqzqymT/Pf8Ts=;
 b=MCxKCWZ2mjAxRx1aonYTG/lvFSS9yHtcvL4y1fi6VLfneT3qyyuqpRNrusw5fDjMQR
 /OeD3TnsDu209kPtHacR0fe3wU2T+HRoysFxdfWp1Exs5mMtIBUhRNfVpV+BVtLp5ebW
 fhsb6ma+MPAm0SpXgqVmlS+FlJOUrXQBSkPVrk+rsrBVCVTDKbBYhYTWBaegb0Jb8wMJ
 IadCj1Zo4lS3g/fiisNaqBKYbw7aaDSJIx+5cYcof24h0voBv8Z8AXU3HX/lu7458KIc
 E62tRkYKXYKqy/+FZ13AtVLCNXq/LM0l+lfUrqcyB9cX4ytvDbO9v+OpMTtDvcuC4Zxh
 MNtg==
X-Gm-Message-State: AOJu0YwLVeBJ83v7jRiXbpTKRWjHSzSESzfGf7+291TY5F/UT95aR6ex
 V9N4hqqRm63ZVsaJrEJ6okUXHK8l3cZOyyU0uRwyOX49PDKd5vpjq9SwHE49L33seOI=
X-Gm-Gg: ASbGncs7mnEZ+qZwA32Am8Mbkl7C5Pu1/IkHSmEoD0UHby13cHrxfxD36ZM8jkc9bH8
 fo7/sUex1Z/089tFLM98sgoxz2VRwAFiy4h/M+c/nlJx/BvDybFNIO7wO/vANPRrLe/RD9FvmDL
 aLHF6DUd+GISmO6qcXbZkdHLDzyhodoV/GODzqt+8TNLyci6Vuyqh8w0GAspEjQMJGivl9/ZOPv
 oa1srq8o+tpwDLP6bMknkS7yRG6yuHg5JvkrJMuQMFP4Hr5h1hX7MlRE27RqJz9XYE8Mj1bVxud
 c3W+e2q5V5jF7877hZ/YaAwUUcQlgO6tZ4nc3LzWhQbdnhqWk7SJALlDT/f8pxp74FdFjULV31l
 VD8grywepLBM8
X-Google-Smtp-Source: AGHT+IF6Jd7USduxc4BdOlmYCXxwFpPHWEpeN5nJRtDHA7xKEtvyn0eo0cBCaHhIX7DOhTVh4u/eYg==
X-Received: by 2002:a05:6830:3c07:b0:72a:47ec:12da with SMTP id
 46e09a7af769-7355cf4fb65mr4112046a34.10.1748181356916; 
 Sun, 25 May 2025 06:55:56 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6b5f5e7sm3637438a34.65.2025.05.25.06.55.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 06:55:55 -0700 (PDT)
Date: Sun, 25 May 2025 07:55:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Broken boards?
Message-ID: <20250525135553.GQ100073@bill-the-cat>
References: <CAFLszThbRhKF1Xwqk+hLu8Y-VXB6+fHVXYfphfVjWMN=dVC1dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+r8EG/SzOwkeLzyM"
Content-Disposition: inline
In-Reply-To: <CAFLszThbRhKF1Xwqk+hLu8Y-VXB6+fHVXYfphfVjWMN=dVC1dg@mail.gmail.com>
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


--+r8EG/SzOwkeLzyM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 25, 2025 at 09:46:03AM +0100, Simon Glass wrote:

> Hi Tom,
>=20
> It seems that some of the boards in my lab are broken in your tree.
> Have you noticed that?

Your lab has never fully functioned in mainline, so no I've not paid
attention to it and don't use it. I figure it's part of the lab
maintainers duties to figure out false failures and
more-or-less-expected failures.

--=20
Tom

--+r8EG/SzOwkeLzyM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgzIWUACgkQFHw5/5Y0
tyywBQv/XJ7qoVdR4BTEYZ46BR74GcSjxsn3b3IUDgH3UyCHUSzvdsgpzP5diCEk
X16cmeTYw4z6bN5Hlioj6z6wz1ofht03J+F4nLyTArAAEdZNxvKm2ZGCWy6CEqpW
216bXBXwBSF9R1E4sIACfC6gS+egQXdWJDucG2eO97lsjKgp8dzGyQnrENqGPFDz
kKJWWdlhykcl3E7KtPwBFp3RMYElsM+iuJGjjlmbW6siMBMpAij63EtAtnu+WQpJ
bjVdoBe07qq0VPC4CnFqqJvBotqfNppHoO4pIpB6z9cHbzh3d28z8in6+hMHbQ5T
xYJ1HsIbI4ywq6FYZzgLXClR1Pf7Ir6RBmwkLEd5ics5p5COL43YKuGZ2jHFBV1c
1dXSxCmgw4Adu2m6r41KQa1EwxloD3JUWzcFkF0y2I//yLTrU14d2RM4xyFwk9Td
rLMrZQ1FNT2QZc0q+zSwCqrk3BQADrKZ4xOmidPh8ED2rr4PeGop9wqRtORgyHHp
61K4c3MC
=dn1I
-----END PGP SIGNATURE-----

--+r8EG/SzOwkeLzyM--
