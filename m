Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F083FC4167B
	for <u-boot@archiver.kernel.org>; Thu,  7 Dec 2023 20:31:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2ADCA86A81;
	Thu,  7 Dec 2023 21:31:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mLvEXxIH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5128286EEC; Thu,  7 Dec 2023 21:31:36 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5F3986CF7;
 Thu,  7 Dec 2023 21:31:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 6B959CE2562;
 Thu,  7 Dec 2023 20:31:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68584C433C8;
 Thu,  7 Dec 2023 20:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1701981090;
 bh=ERsTvu9DxLCUZ8VCkU52IXgN4PiP+2Fxz34Nyvaa7ls=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mLvEXxIHIXQ/I66z/Ii5y/a+zHtpiAKQKjr9U4MPhLkWzbOAtbdGfW8qhqxHMiqSs
 seO6qHJJqOr2BhTiFsAX6sLubl0EwmAPgmvpeFH6jfsrLQGDicAmm2OJLPSJjAVitk
 mSovVJCc/PMKXcwo+CpuyXNbaDch/XhlUvF5mmHLUdoemtCH8uWekmQOmn7pLEc9G1
 sFBOr1CeFxEr3dvFW9zEDoZznaI4vJvxjh7mFyO9BSmhTu2GkcE7dVriyj1vBkXZI5
 c2oU6NQW7Rzp0BbFiOABufMfj5enXpeeld4+P4sFszVJjrkLJKsOAgvHp8voVfQl9B
 qql2JFa/tkIUA==
Date: Thu, 7 Dec 2023 20:31:24 +0000
From: Conor Dooley <conor@kernel.org>
To: ff <ff@shokubai.tech>
Cc: Rob Herring <robh+dt@kernel.org>, Sumit Garg <sumit.garg@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 "u-boot-custodians@lists.denx.de" <u-boot-custodians@lists.denx.de>,
 Tom Rini <trini@konsulko.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Simon Glass <sjg@chromium.org>,
 Boot Architecture Mailman List <boot-architecture@lists.linaro.org>
Subject: Re: [PATCH 00/21] Qualcomm generic board support
Message-ID: <20231207-unmixable-surround-ff6c525e36fd@spud>
References: <CAL_JsqL4dKbziAgwaCDz7sw-evuX7LZ3E-H6h=xQ9cXiyThY1Q@mail.gmail.com>
 <CAFA6WYPnobZ+eTGuOs+yTYNnuBu6i37Db9ZS2gr36heH1mFV5Q@mail.gmail.com>
 <f72c772b-7fd7-4558-96d3-086f8ab7515a@linaro.org>
 <CAFA6WYOPh6UBt3FDm-c0tfp3YvWtRHkaxy2CJNg8ORKOwPwq0w@mail.gmail.com>
 <34334add-4017-46f6-873a-d9233e29f640@linaro.org>
 <CAFA6WYN_uf0+tHm7RxXXz_7U3tdbdsK1rttnQN-rcfRknrcDQA@mail.gmail.com>
 <CAL_JsqKEjv2tSGmT+0ZiO7_qbBfhTycbGnhJhYpKDFzfO9jzDg@mail.gmail.com>
 <5C77B3D5-3659-40BC-86BB-E73E7034E017@shokubai.tech>
 <CAL_JsqLBQCStz39-5d0CSnZzuSfc6473d2=HEY2NF7Hm83L9YA@mail.gmail.com>
 <61B1DEC4-4004-491A-B5A9-1548ACAD6104@shokubai.tech>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="SOwhAdF2sefchLDe"
Content-Disposition: inline
In-Reply-To: <61B1DEC4-4004-491A-B5A9-1548ACAD6104@shokubai.tech>
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


--SOwhAdF2sefchLDe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

What on earth has happened here with quoting? Please fix your mail
client man, this mail is a mess to read.

On Thu, Dec 07, 2023 at 08:24:01PM +0000, ff wrote:
>=20
>=20
> Le 7 d=C3=A9c. 2023 =C3=A0 19:51, Rob Herring <robh+dt@kernel.org> a =C3=
=A9crit :
>=20
> =EF=BB=BFOn Thu, Dec 7, 2023 at 2:08=E2=80=AFAM ff <ff@shokubai.tech> wro=
te:
>=20
>=20
>=20
> Le 6 d=C3=A9c. 2023 =C3=A0 21:42, Rob Herring <robh+dt@kernel.org> a =C3=
=A9crit :
>=20
> =EF=BB=BFOn Tue, Dec 5, 2023 at 11:05=E2=80=AFPM Sumit Garg <sumit.garg@l=
inaro.org> wrote:
>=20
> On Tue, 5 Dec 2023 at 15:39, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>=20
> On 05/12/2023 10:45, Sumit Garg wrote:
> + U-boot custodians list
>=20
> On Tue, 5 Dec 2023 at 12:58, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>=20
> On 05/12/2023 08:13, Sumit Garg wrote:
> @DT bindings maintainers,
>=20
> Given the ease of maintenance of DT bindings within Linux kernel
> source tree, I don't have a specific objection there. But can we ease
> DTS testing for firmware/bootloader projects by providing a versioned
> release package for DT bindings? Or if someone else has a better idea
> here please feel free to chime in.
>=20
> This doesn't work for you?:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-reb=
asing.git/
>=20
> Thanks, this is certainly a good step which I wasn't aware of. Further
> simplification can be done to decouple devicetree source files from DT
> bindings.
>=20
> Why?
>=20
> I suppose you are already aware that Linux DTS files are a subset of
> what could be supported by devicetree schemas. There can be
> firmware/bootloader specific properties (one example being [1]) which
> Linux kernel can simply ignore. Will you be willing to add all of
> those DT properties to Linux DTS files and maintain them?
>=20
> We already added them and we already maintain them. DTS describes the
> hardware, not the OS-subset of the hardware.
>=20
> Let look at some numbers if your statement is justified or not for the
> example I gave:
>=20
> u-boot$ git grep -nr bootph-* arch/arm* | wc -l
> 4079
>=20
> linux$ git grep -nr bootph-* arch/arm* | wc -l
> 267
>=20
> I have no control over whether anyone has submitted the other 3812 instan=
ces.
>=20
> It looks like there is always going to be a catch up game regarding DT
> properties which either Linux kernel or u-boot or any other
> firmware/bootloader project don't care about.
>=20
> As long as dts files in u-boot are manually sync'ed, yes. That is the
> problem and it doesn't matter if we have a standalone repository or
> not.
>=20
> If you want to move in that direction, start automating what u-boot
> imports. You need to do that for bindings if you want to run
> validation, so why not dts files too?
>=20
> However, DT bindings are something which should be common, the
> hardware description of a device should be universal. IMO, splitting
>=20
> Both DT bindings and DTS should be common. I don't see the difference.
>=20
> If we really care about DTS to be common then the contribution model
> has to change where there is a single repo hosting DT bindings and
> DTS. All other projects whether it is Linux kernel or u-boot or any
> other OS/firmware/bootloader are just consuming DTS files from that
> single repo.
>=20
> Really, only the kernel and u-boot matter. No, I don't mean I don't
> care about other projects, but those are the 2 with the widest h/w
> support by far and which have a major effort to sync copies of dts
> files in both projects. The rest are just noise in terms of this
> problem.
>=20
> I suppose this is something that Linux DT maintainers
> have objected to in the past for ease of maintenance. I am not sure if
> you folks are willing to change that stance.
>=20
> The issue is no one steps up to help maintain such a repository while
> there is lots of review and maintainer work on what goes into the
> kernel tree. I'm happy to direct my binding review attention to
> wherever the majority of the bindings go. But the work on the DTS side
> is mostly SoC tree maintainers and sub-maintainers.
>=20
> Assume for a minute we have this standalone repo. What happens next?
> We start with an empty repo and then merge and move platforms 1 by 1?
>=20
> What about leveraging SystemReady-IR compliant board maintainers and star=
t with a core of motivated people ?
>=20
> I think there are 2 ATM. Synquacer and i.MX8 variants.
>=20
> Based on  https://www.arm.com/architecture/system-architectures/systemrea=
dy-certification-program/ir
>  roughly 30 boards.
>=20
> Synquacer only
> has a DT in u-boot, so not really anything to do there.
> I'm pretty
> sure the certified DTBs for i.MX8 don't match what's in u-boot or the
> kernel tree. Hopefully, it's just a subset, but still, there's a gap.
> I don't know that there is motivation there either.
> Note that SystemReady currently only requires every node with
> 'compatible' have a schema. It does not yet require no schema
> warnings. If we went with a 1 by 1 approach, I would push that
> platforms have to be free of warnings.
>=20
> How many years will that take?
>=20
> Should all platforms following that organization be a goal?
>=20
> You mean should all platforms be moved? Absolutely. I don't think we
> want to solve the problem of having DTS files in 2 places by creating
> a 3rd place.

I think this bit here is the only thing you actually wrote:

> Actually, if we limit he DTS in the third place for SystemReady-IR,
> there should be no DTB in the Linux distribution.
> It would be the equivalent as ACPI boards . So is it still an issue ?
> A reference to the the third repo may be hinted in a text file.

SystemReady is only for one architecture, why would using it as the
centralised point for devicetree files make sense?

>=20
> I don't really think 1 by 1 is the right approach. I was just
> enumerating how this could work. It's not that useful to say we need a
> standalone repo without working thru the logistics of how exactly that
> will work.
>=20
> Rob

--SOwhAdF2sefchLDe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXIrnAAKCRB4tDGHoIJi
0rrCAP9ug5PYPtnbzuiwBmmDuBG7yhnJ3ALjrFzU0zFZ1h8gAgEAv+/xkgiERzyn
R+UgGU4evDxky5KJeRfVSGinmRjQDwA=
=+88U
-----END PGP SIGNATURE-----

--SOwhAdF2sefchLDe--
