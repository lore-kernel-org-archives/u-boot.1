Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A138C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 16:40:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04ED380FDA;
	Tue,  1 Apr 2025 18:40:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ud6hNJO5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 088E080FDA; Tue,  1 Apr 2025 18:40:23 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51579801BE
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 18:40:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-2c873231e7bso2473285fac.3
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 09:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743525619; x=1744130419; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IV4t0gS25hM4N68vm/O38rs+RhD4L+ZBwAfY/L203oA=;
 b=Ud6hNJO5B1RFV9V2i92fIXfyALbVhYJjjerWJgd4VHl1dw7ZcE9NECOdfQsS1gC9W2
 IBJV72bucuqY3/rvZKXsHUPfrWjVXMzMdpnzCAPqRiO1vJuTPoTUIykkUzE2KTOAHEcV
 aQMrIdDTEAhKQVP5K/7Wh5oT5tFVOF90GnJng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743525619; x=1744130419;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IV4t0gS25hM4N68vm/O38rs+RhD4L+ZBwAfY/L203oA=;
 b=bBNVUfldm3IaY8ezs3PcYJT8KXP69QtdrAvkoG1hHWHvq5zvdn1RQJ92HvIIPa6Uc/
 90JYtuQmV34XiGpZr9u8sPniZomp+CGd5cwkuB1Sr/5GOboH5+p4HPBi5Quvu+OEMiQH
 1dJ5cC1p8H8xZDU/CMvk3IxjL+lRBc1V3VaIkgohk1QtrWvPpFlktM0xlZlTTDq5Zsvj
 HSa+Pd2syFh7tmeyykMfCGrZdBjZCd2hJyc5pE8qZ6Y3EAlrxpUGFK1j4ad70MuXhl8O
 Y4Ez8cQo2ZY0O/MT1vh6A+XE9p6SpWFjbsSIqPFhuhEV6p21YamPb7Z0q8CY5t8Z1wQY
 5BTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCbTzFoIyqUBh22DAfGKtvUWLmQmEcq6/mNatvqwL96udA53mUa0eX9cVoGKGV/XPmZj3kSXg=@lists.denx.de
X-Gm-Message-State: AOJu0YxuXYMZ4zKAn6XzyuT5E2bE+JJ4B8MWcAaCAxpB0MNt/tO7fkzt
 yUxxvUSr8i+OkjLA5/TPlup1ctevHS+8MSUK8S+xUjXqvNJlAtzyKVnK4x+25yA=
X-Gm-Gg: ASbGncuZHayHazXWQoHLuf5RkQFLXIZlUkw3KQ0CU6y8ItNbdF21AGwHlxgCCNtfA6a
 Ak/0YcbxRPzmD+s0LktfR6iQmL5ZVqSMouYDA+4CBmFXoSmKWbkDpZAuN3NiDP36Re6Y4eq8wHP
 KbIg0h7oZgcjdK571BN1Ys/Qinn8bn7icqnlMfK5mWAB3z0muEX1ElJUgUSazzlY96STchnt8sB
 ZGbzpf4kMQv3JRh5/xVOdfjxUKukRnrneyg2F2gS8SyVZbNc7E79v3WANePAcXABCl4ifcixFtN
 5k28htjOKaIlxHjlb2O9uaZx52mliGXr59EBWF2OsopQn4bY6uc1gJY4ZlPUg4W++GC+tgP/NCZ
 yeM8maA==
X-Google-Smtp-Source: AGHT+IEJB5Vw25EGEo6Sp9xv2n9pmgSM0Cir+1Sh2qkO2Bu7fTob/CHsTMzwsiNxryopX/0LQkDQYQ==
X-Received: by 2002:a05:6870:5154:b0:2c2:37d2:c1d1 with SMTP id
 586e51a60fabf-2cbcf77227fmr8703540fac.26.1743525619047; 
 Tue, 01 Apr 2025 09:40:19 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c5826741bsm1926100a34.45.2025.04.01.09.40.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 09:40:18 -0700 (PDT)
Date: Tue, 1 Apr 2025 10:40:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor.dooley@microchip.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 5/6] dt-bindings: clock: drop NUM_CLOCKS define for
 EN7581
Message-ID: <20250401164016.GF5495@bill-the-cat>
References: <20250314185941.27834-1-ansuelsmth@gmail.com>
 <20250314185941.27834-6-ansuelsmth@gmail.com>
 <7923a39a-184c-4774-ad94-4d72563c8b60@linaro.org>
 <67e5659b.df0a0220.19a25c.f830@mx.google.com>
 <37c1455f-8d53-4643-b57e-3a888e5dd23d@linaro.org>
 <20250401144420.GE5495@bill-the-cat>
 <7b6542f2-0a2b-48ce-aaac-0bdf2f9b2fca@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RySAL1zPmhEnDM7j"
Content-Disposition: inline
In-Reply-To: <7b6542f2-0a2b-48ce-aaac-0bdf2f9b2fca@linaro.org>
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


--RySAL1zPmhEnDM7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 01, 2025 at 05:27:30PM +0200, Krzysztof Kozlowski wrote:
> On 01/04/2025 16:44, Tom Rini wrote:
> > On Thu, Mar 27, 2025 at 03:58:52PM +0100, Krzysztof Kozlowski wrote:
> >> On 27/03/2025 15:50, Christian Marangi wrote:
> >>> On Thu, Mar 27, 2025 at 03:43:47PM +0100, Krzysztof Kozlowski wrote:
> >>>> On 14/03/2025 19:59, Christian Marangi wrote:
> >>>>> Drop NUM_CLOCKS define for EN7581 dts/upstream/src/include. This is=
 not a binding and
> >>>>> should not be placed here. Value is derived internally in the user
> >>>>> driver.
> >>>>>
> >>>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> >>>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>>> Please drop my Ack. I have never acked such patch for uboot. If I di=
d,
> >>>> it was by mistake - probably you CC-ed me for some reason.
> >>>>
> >>>
> >>> Some explaination, uboot introduced the concept of upstream where they
> >>> "import" linux patch for dts and dt-bindings.
> >>
> >> I expected OF_UPSTREAM to be taking the sources, not patches.
> >>
> >>>
> >>> This and the other patch are the exact upstream patch with only the p=
ath
> >>> changed so I keep all the patch commit message with tags and added the
> >>>
> >>> [ upstream commit ] thing.
> >>>
> >>> Hope Tom can better suggest how this should be done. You were CC
> >>> probably because the git send-email included you as present in the
> >>> different tags.
> >>
> >> Well, Ack is still not valid because I did not Ack exactly that change.
> >> It does not matter for the ack, but for Reviewed-by it would matter,
> >> because it is a statement (of oversight...). I cannot control what you
> >> put into patches taken out of kernel, but at least do not Cc me on tha=
t.
> >=20
> > In specifics, yes, we should update doc/develop/devicetree/control.rst
> > and maybe doc/develop/sending_patches.rst to use --suppress-cc=3Dall for
> > dts/upstream.
> >=20
> > But in general, what do you expect people to be doing with content from
> > devicetree-rebasing? We're doing some direct cherry-picks in between
> > merging of the tags. I think it would be weird to be dropping the tags
> > and un-attributing peoples work.
>=20
>=20
> I rather expected something like how kernel is importing dtc. You just
> list the commits you get. If you want the full git history, then I would
> expect simple git submodule. In both cases there will be no such patches
> on the lists.
>=20
> For the Ack it does not matter, but I would feel uncomfortable if people
> were sending stripped and modified patches with my Rb tag.

I guess I'm confused. Looking at
https://patchwork.ozlabs.org/project/uboot/patch/20250314185941.27834-6-ans=
uelsmth@gmail.com/
we're doing the normal thing of havig "[ upstream commit <sha>]" after
the imported log. When I merge the subtree and tag it indeed gives what
you're expecting too.

--=20
Tom

--RySAL1zPmhEnDM7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfsFuwACgkQFHw5/5Y0
tyzXNQwAjKMbfOYbG15L8YATT7yFWHbzoLq2WpxjGBxybqtr44cOuLPeJoeYpNwo
vk+j8uRpgmPqCWHScELPbIu+t16/eOZwfRPeK4Oxa6/1lQn0zDVof3dxhxnK2PDw
KsXipccqMJfVzmtnMkCavl6SQt/6IdI2RjnOpVxrc7BmSL6HjMohJRToX9C6wTa7
qViMCiquvhkmOr3ClPKe85j3cMhMlU5sQBMaPkzSPJBiiyiM7jYuhFOJDjmRitDW
y/vD5d/Vgw6mevTCXYhZuUESankrNYFJ5Fx5g+tCaPNZA6tl0vxr20RXY0KP/trU
S9klDXOk9ho55MqUKT3qoBIIap6a0mgS5gN+/fiCVi0CTgrL458/B6nxfyPbxYAv
zF24CMisHx0yGgOug7VBTQkmm4TeE82kXeGDSqbi9FIjuxzCylcUOdDEFVaUtAmk
FZfLUSDYaSfG8lvK9Cilb0uCJyjf82l+u00ltP42+7KYLUtFNBh1fX6nyuFSwLbq
JsOYlzZ6
=jWmi
-----END PGP SIGNATURE-----

--RySAL1zPmhEnDM7j--
