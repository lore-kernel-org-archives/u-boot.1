Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC4B6C41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 15:45:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61DA5877BC;
	Fri, 22 Dec 2023 16:45:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="S1/XfSJt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4B6B874D5; Fri, 22 Dec 2023 16:45:14 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65750877BC;
 Fri, 22 Dec 2023 16:45:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 8CB06B8201F;
 Fri, 22 Dec 2023 15:45:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17DC5C433C8;
 Fri, 22 Dec 2023 15:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1703259907;
 bh=u0Q7YhNf3CgnAfeK4oxJ+W7K14P+Z8LHZpgbWUc10E0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=S1/XfSJt4dQnxf1vAmrEnK3ttAmx/1fRGqrLnIW7WBYpZiND2hCk0brCd7SR+lsOR
 AszV0hzrssu3G1Mk0T09SXLZWyAbsGcAXpadRuTXAlScMn/UFWs0C2Ks4jPfrlCQLJ
 W3vmPS7VjirfOCo1oCXX3ZHH2vvtdcJELIDcAeWqhr2kN37H8Hby06nVeZQmE92eec
 /1Xl8x0SLugrY/G8BB56CMhxIVGADChzbM2T/Jyr9L2AiWKu+8eELm+P6iKWshCF4O
 cZ8Zhczt8PRAvsi4ZdvsxBvp6Hfu71xhenGGZxmyM6QbwmF1jKbPeRTgBejmIc0/rJ
 SmQvVw+KIeNgg==
Date: Fri, 22 Dec 2023 15:45:00 +0000
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de,
 trini@konsulko.com, sjg@chromium.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, neil.armstrong@linaro.org,
 caleb.connolly@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
 maxim.uvarov@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de,
 michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk,
 peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com,
 marex@denx.de
Subject: Re: [PATCH v2 0/8] An effort to bring DT bindings compliance within
 U-Boot
Message-ID: <20231222-whole-canola-81240881c2e7@spud>
References: <20231222061208.3009970-1-sumit.garg@linaro.org>
 <02fdfc4b-113b-409f-8aaf-8f4a04822706@linaro.org>
 <CAFA6WYM8EVY-D_Kptggsvxq0ZrFdP0gQ3y4UEbM+vLu0F8tLjw@mail.gmail.com>
 <c6d65491-c407-4518-aee9-f53f6d4a84ed@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3YBv+EiNoAY7R9JG"
Content-Disposition: inline
In-Reply-To: <c6d65491-c407-4518-aee9-f53f6d4a84ed@linaro.org>
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


--3YBv+EiNoAY7R9JG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 04:38:01PM +0100, Krzysztof Kozlowski wrote:
> On 22/12/2023 14:43, Sumit Garg wrote:
> > On Fri, 22 Dec 2023 at 13:48, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 22/12/2023 07:12, Sumit Garg wrote:
> >>> Changes in v2:
> >>> --------------
> >>> - Patch #1: excluded gitab CI config check and added commit descripti=
on.
> >>> - Patch #3: s/UBOOT_DTSI_LOC/u_boot_dtsi_loc/
> >>> - Patch #4: s/DEVICE_TREE_LOC/dt_dir/ and s/U-boot/U-Boot/
> >>> - Patch #5: s/U-boot/U-Boot/
> >>> - Patch #6 and #7: Picked up review tags
> >>>
> >>> Prerequisite
> >>> ------------
> >>>
> >>> This patch series requires devicetree-rebasing git repo to be added a=
s a
> >>> subtree to the main U-Boot repo via:
> >>>
> >>> $ git subtree add --prefix devicetree-rebasing \
> >>>       git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/device=
tree-rebasing.git \
> >>>       v6.6-dts --squash
> >>>
> >>> Background
> >>> ----------
> >>>
> >>> This effort started while I was reviewing patch series corresponding =
to
> >>> Qcom platforms [1] which was about to import modified devicetree sour=
ce
> >>> files from Linux kernel. I suppose keeping devicetree files sync with
> >>> Linux kernel without any DT bindings schema validation has been a pain
> >>> for U-Boot SoC/platform maintainers. There has been past discussions
> >>> about a single DT repo but that hasn't come up and Linux kernel remai=
ned
> >>> the place where DT source files as well as bindings are placed and
> >>> maintained.
> >>
> >> Thanks for doing this.
> >>
> >> I really suggest to store information that kernel DTS is directly
> >> re-used, thus DTS backward and forward compatibility matters, also in
> >> Linux kernel sources. The point is that sub-arch maintainers should be
> >> aware of it. I don't think that as DT maintainers we can efficiently
> >> keep an eye on it. Maybe create a subsystem profile and include it to
> >> maintainer entries of such affected platforms?
> >>
> >=20
> > From U-Boot point of view, currently we have the config option:
> > "CONFIG_OF_UPSTREAM=3Dy" per platform which means directly re-use of
> > kernel DTS. So U-Boot sub-arch maintainers should be aware of
> > platforms which get converted to re-use kernel DTS.
>=20
> I was speaking about kernel.
>=20
> >=20
> > I suppose we have to relay information to kernel sub-arch maintainers
> > who aren't the same as maintaining U-Boot counterparts. How about
> > adding U-Boot ML to CC for whichever DT change gets submitted in the
>=20
> And every other project? Just setup lei filters.
>=20
> > kernel? Otherwise adding U-Boot sub-arch maintainers as reviewers for
> > corresponding kernel DT changes works too if that's acceptable.
>=20
> You just entirely ignored my proposal without addressing it... ok let it
> be. No, CC-ing U-boot maintainers changes nothing because as I said, I
> want kernel maintainers and contributors to be aware.

I don't think that adding U-Boot platform maintainers as reviewers for
the platforms in the kernel is a terrible idea. Certainly kernel
platform maintainers for which U-Boot platform maintainers are added to
the MAINTAINERS entry will be aware. That said, something like your
"strict dts compliance" maintainer profile entry [1] would be helpful I thi=
nk
to denote which platforms' dts are being shared in this manner

1:
ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES
M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
R:	Alim Akhtar <alim.akhtar@samsung.com>
L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
L:	linux-samsung-soc@vger.kernel.org
S:	Maintained
P:	Documentation/process/maintainer-soc-clean-dts.rst
Q:	https://patchwork.kernel.org/project/linux-samsung-soc/list/

--3YBv+EiNoAY7R9JG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZYWu/AAKCRB4tDGHoIJi
0k9fAP99rmdtK95+6oX2Ou8Vu0ml3aQR5ogo7Lnt53Jzc6BCPwD/eirBHSirp7Tf
tUulTDiSp9B78sZrW5Ke4M3btwX0RQc=
=3qta
-----END PGP SIGNATURE-----

--3YBv+EiNoAY7R9JG--
