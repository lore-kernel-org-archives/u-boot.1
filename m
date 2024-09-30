Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26EEECDD1D5
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 20:30:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 445EE889AA;
	Mon, 30 Sep 2024 22:30:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="COFu7PnN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BA3A88995; Mon, 30 Sep 2024 22:30:45 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1542588F94
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 22:30:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1727728225; x=1728333025; i=xypron.glpk@gmx.de;
 bh=pGXG/o7l7QVMxQomVhV6n4VqXc2aHJREWodUU+CAcb0=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=COFu7PnNkipI/GfZesZB7HEPMn4/V/4DIzCX0S6otJOflNLPzbG0K+NL737saDpZ
 HEkSxXmNbkiuxwHYNYJ1POPwXQxz1wbEgTzu8q+gEODSP9MrPU0oB4sv0mMDYOD3M
 +pbPVkoncmZTokBlrWMRYE7iGrDbd7F60x089bMdeVaZ5/jMRFPsKXoR7gnLOiMvE
 kJWNSW7j+I6WfeIyyHIHDnTFBzh3O8j61I6tXC7HxOuygXdCLpxjUT9iv0bGRN/LM
 DRhWqJn3wYgEv7kZ+SP0ERPGfs1a3MIjzKJow56RgRRTMQSpLhcjm4pL+oGlYEBw6
 vh1v9sqAmnshqlrz/w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([46.114.105.187]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgvrL-1sGYBB1A69-00dMk6; Mon, 30
 Sep 2024 22:30:24 +0200
Date: Mon, 30 Sep 2024 22:30:16 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Brian Ruley <brian.ruley@gehealthcare.com>, 
 Marek Vasut <marex@denx.de>, Alexander Dahl <ada@thorsis.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Joao Marcos Costa <jmcosta944@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Sumit Garg <sumit.garg@linaro.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_3/3=5D_binman=3A_Add_a_tutor?=
 =?US-ASCII?Q?ial_on_resolving_test-coverage_bugs?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20240930185139.2185983-3-sjg@chromium.org>
References: <20240930185139.2185983-1-sjg@chromium.org>
 <20240930185139.2185983-3-sjg@chromium.org>
Message-ID: <A39A5EDD-52AF-475F-B789-036640D2FAA8@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0eQkPr9mpOUzZgNzCY4A2aUCeURrfTYW3EA21qCqtlSbnmLOQZL
 Zll4/X+iIunJ/mk++rUuE2Xw2INnLLZigRmJ4hUZhi0muKgYosqzCG7ktHdLOYkeM2uS35y
 EU+sbmV3zy+1xCgdIPS7lHfHTOJ9+MCz8+MJuRqoPNhsTaOHuFl8akV0W2UjksL9BXls4qJ
 HlxW3QcuJNezXduyMjRgQ==
UI-OutboundReport: notjunk:1;M01:P0:5UeDSz6I61U=;/doCWykehLupdboxQqmK4FYbIXz
 L4VH6A0Ka2Z57jNElCnCoki734/VS1fY6njfQBn19DqG4EGFqWPIHM98ZaoiSlYmQRdFmb9HL
 9UeizlLNIkOwTvRa872STmp7T3OfiswtjtXzR6XWfIsPirJ6hOI5wqWm1ZNIr+BT8H6MLgyqC
 ofGGQLgS1+jYRxXzxhK29LAIxzYNuNiTg4m/utsD+7TVjv1DVfOmQuSq4mhJ/+RPVKc3cY94o
 NkAIUcwP/sicXMbkJTaYf0FXDG9ZxaNLYLB/ID+b3jV5yVhcmHHQCLTP98Jub9BG+VxWXErcj
 2uAndGvT5g4LWCrn9okIAffiay4AOEzXBL0lLhZkI91kkU2/boNY1dnSX0GekKxANRzl8aHjI
 1aSpuxnNOyF2GrtOpi9kZ4KY9NDWf9CzFu/pEA3LMN6GoO2d+6VKTXni9zZZfaB+53l9MVsHp
 QV+m/lcZTWokyyZir4H9F4pE5NudwKKrtdeAwgvLOjajRhCBr4Zw6CZup/+wd1ZlxxxrAqoI7
 DZYfjRHe+LA5laX4VnBoHqkq0ijDIP1x/4j4Li784OK9VVeBYKQjf08sTzdoTMdJt7NQPnxxc
 YL1+yMbkQeyi6/wMedhzqj8YCn9yxCFvTMzO7LgawIJ64abfBILwq4lUmuqjbviql593edQKR
 LmHRWmn1dX3s/7nstBLU/POaxnyKoBqy1dTJnMZFlgsCsIHqHR+t2GgebBEtJBVGRJv3aNZu9
 nxHcSXms6EJMw8q2oZbrGjfpGbbY4zFxYNElK7MVtZrLK40jBzTjF7CYA+S5Echq9/GZOMO1t
 c4CeDQO9Yd39u13nElWaD9TWfih73BzvHOoPEl+K+dCj0=
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



Am 30=2E September 2024 20:51:38 MESZ schrieb Simon Glass <sjg@chromium=2E=
org>:
>Provide a short description of how tests work, why they are so critical
>and how to resolve gaps in Binman's test coverage=2E

This is really a nice piece of documentation=2E

Acked-by: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>

>
>Signed-off-by: Simon Glass <sjg@chromium=2Eorg>
>---
>
> MAINTAINERS                  |   1 +
> doc/develop/binman_tests=2Erst | 734 +++++++++++++++++++++++++++++++++++
> doc/develop/index=2Erst        |   1 +
> tools/binman/binman=2Erst      |   5 +
> 4 files changed, 741 insertions(+)
> create mode 100644 doc/develop/binman_tests=2Erst
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 7ab39d91a55=2E=2E65a9ea1face 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -909,6 +909,7 @@ BINMAN
> M:	Simon Glass <sjg@chromium=2Eorg>
> M:	Alper Nebi Yasak <alpernebiyasak@gmail=2Ecom>
> S:	Maintained
>+F:	doc/develop/binman_tests=2Erst
> F:	tools/binman/
>=20
> BLKMAP
>diff --git a/doc/develop/binman_tests=2Erst b/doc/develop/binman_tests=2E=
rst
>new file mode 100644
>index 00000000000=2E=2Ea632694a6fe
>--- /dev/null
>+++ b/doc/develop/binman_tests=2Erst
>@@ -0,0 +1,734 @@
>+=2E=2E SPDX-License-Identifier: GPL-2=2E0+
>+
>+=2E=2E toctree::
>+   :maxdepth: 1
>+
>+Binman Tests
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>+
>+=2E=2E contents::
>+   :depth: 2
>+   :local:
>+
>+There is some material on writing tests in the main Binman documentation
>+(see :doc:`package/index`)=2E This short guide is separate so people don=
't
>+feel they have to read as much=2E
>+
>+Code and output is mostly included verbatim, which makes the doc longer,=
 but
>+avoids its becoming confusing when the output or referenced code changes=
 in the
>+future=2E
>+
>+Purpose
>+-------
>+
>+The main purpose of tests in Binman is to make sure that Binman actually=
 does
>+what it is supposed to=2E Various people contribute code, refactoring is=
 done
>+over time, but U-Boot users (developers, SoC vendors, board vendors) rel=
y on
>+Binman producing images which function correctly=2E Without tests, a one=
-line
>+change could unintentionally break a corner-case and the problem might n=
ot be
>+noticed for months=2E Debugging an image-generation problem with a board=
 you
>+don't have can be very hard=2E
>+
>+A secondary purpose is productivity=2E U-Boot contributors are busy and =
often
>+have too much on their plate=2E Trying to figure out why their patch bro=
ke
>+some other vendor's workflow can be very time-consuming and frustrating=
=2E By
>+building in tests from the start, this is largely avoided=2E If your cha=
nge has
>+full test coverage and doesn't break any test, all is well and no one ca=
n
>+complain=2E
>+
>+A lessor purpose is to document what Binman actually does=2E If a test c=
overs a
>+feature, it works=2E If there is no test coverage, no one can say for su=
re
>+whether it works in all expected situations, certainly not wihout manual
>+effort=2E
>+
>+In fact, strictly speaking it isn't completely clear what 'works' even m=
eans in
>+the case where these is no test to cover the code=2E We are often left g=
uessing
>+as to what the documentation means, what was actually intended, etc=2E
>+
>+Finally, code-coverage helps to remove 'zombie code', copied from elsewh=
ere
>+because it looks reasonable, but not actually needed=2E The same situati=
on arises
>+in silicon-chip design, where a part of the chip is not validated=2E If =
it isn't
>+validated, it can be assumed not to work, either now or later, so it is =
best to
>+remove that logic to avoid it causing problems=2E
>+
>+Setting up
>+----------
>+
>+Binman tests use various utility programs=2E Most of these are documente=
d in
>+:doc:`=2E=2E/build/gcc`=2E But some are SoC-specific=2E To fetch these, =
tell Binman to
>+fetch or build any missing tools:
>+
>+=2E=2E code-block:: bash
>+
>+    $ binman tool -f missing
>+
>+When this completes successfully, you can list the tools=2E You should s=
ee
>+something like this:
>+
>+=2E=2E code-block:: bash
>+
>+    $ binman tool -l
>+    Name             Version      Description                Path
>+    ---------------  -----------  -------------------------  -----------=
-------------------
>+    bootgen          ****** Bootg Xilinx Bootgen             /home/sglas=
s/=2Ebinman-tools/bootgen
>+    bzip2            1=2E0=2E8        bzip2 compression          /usr/bi=
n/bzip2
>+    cbfstool         unknown      Manipulate CBFS files      /home/sglas=
s/bin/cbfstool
>+    fdt_add_pubkey   unknown      Generate image for U-Boot  /home/sglas=
s/bin/fdt_add_pubkey
>+    fdtgrep          unknown      Grep devicetree files      /home/sglas=
s/bin/fdtgrep
>+    fiptool          v2=2E11=2E0(rele Manipulate ATF FIP files   /home/s=
glass/=2Ebinman-tools/fiptool
>+    futility         v0=2E0=2E1-9f2e9 Chromium OS firmware utili /home/s=
glass/=2Ebinman-tools/futility
>+    gzip             1=2E12         gzip compression           /usr/bin/=
gzip
>+    ifwitool         unknown      Manipulate Intel IFWI file /home/sglas=
s/=2Ebinman-tools/ifwitool
>+    lz4              v1=2E9=2E4       lz4 compression            /usr/bi=
n/lz4
>+    lzma_alone       9=2E22 beta    lzma_alone compression     /usr/bin/=
lzma_alone
>+    lzop             v1=2E04        lzo compression            /usr/bin/=
lzop
>+    mkeficapsule     2024=2E10-rc5- mkeficapsule tool for gene /home/sgl=
ass/bin/mkeficapsule
>+    mkimage          2024=2E10-rc5- Generate image for U-Boot  /home/sgl=
ass/bin/mkimage
>+    openssl          3=2E0=2E13 30 Ja openssl cryptography toolk /usr/bi=
n/openssl
>+    xz               5=2E4=2E5        xz compression             /usr/bi=
n/xz
>+    zstd             v1=2E5=2E5       zstd compression           /usr/bi=
n/zstd
>+
>+The tools are written to ``~/=2Ebinman-tools`` so add that to your ``PAT=
H``=2E
>+It's fine to have some of the tools elsewhere (e=2Eg=2E ``~/bin``) so lo=
ng as they
>+are up-to-date=2E This allows you use the version of the tools intended =
for
>+running tests=2E
>+
>+Now you should be able to actually run the tests:
>+
>+=2E=2E code-block:: bash
>+
>+    $ binman test
>+    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D Running binman tests =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>+    =2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E
>+    =2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E
>+    =2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E
>+    =2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E
>+    =2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E
>+    =2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E
>+    =2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E
>+    =2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E
>+    =2E=2E=2E=2E=2E=2E=2E=2E
>+    --------------------------------------------------------------------=
--
>+    Ran 568 tests in 2=2E578s
>+
>+    OK
>+
>+If this doesn't work, see if you can have some missing tools=2E Check th=
at the
>+dependencies are all there as above=2E If it is very slow, try installin=
g
>+concurrencytest so that the tests run in parallel=2E
>+
>+The next thing to set up is code coverage, using the -T flag:
>+
>+=2E=2E code-block:: bash
>+
>+    $ binman test -T
>+    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D Running binman tests =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>+    =2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E
>+    =2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E
>+    =2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E
>+    =2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E
>+    =2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E
>+    =2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E
>+    =2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E
>+    =2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E
>+    =2E=2E=2E=2E=2E=2E=2E=2E
>+    --------------------------------------------------------------------=
--
>+    Ran 568 tests in 17=2E367s
>+
>+    OK
>+
>+    99%
>+    Name                                                    Stmts   Miss=
  Cover
>+    --------------------------------------------------------------------=
-------
>+    tools/binman/__init__=2Epy                                    0     =
 0   100%
>+    tools/binman/bintool=2Epy                                   263     =
 0   100%
>+    tools/binman/btool/bootgen=2Epy                              21     =
 0   100%
>+    tools/binman/btool/btool_gzip=2Epy                            5     =
 0   100%
>+    tools/binman/btool/bzip2=2Epy                                 5     =
 0   100%
>+    tools/binman/btool/cbfstool=2Epy                             24     =
 0   100%
>+    tools/binman/btool/cst=2Epy                                  15     =
 4    73%
>+    tools/binman/btool/fdt_add_pubkey=2Epy                       21     =
 0   100%
>+    tools/binman/btool/fdtgrep=2Epy                              26     =
 0   100%
>+    tools/binman/btool/fiptool=2Epy                              19     =
 0   100%
>+    tools/binman/btool/futility=2Epy                             19     =
 0   100%
>+    tools/binman/btool/ifwitool=2Epy                             22     =
 0   100%
>+    tools/binman/btool/lz4=2Epy                                  22     =
 0   100%
>+    tools/binman/btool/lzma_alone=2Epy                           34     =
 0   100%
>+    tools/binman/btool/lzop=2Epy                                  5     =
 0   100%
>+    tools/binman/btool/mkeficapsule=2Epy                         27     =
 0   100%
>+    tools/binman/btool/mkimage=2Epy                              23     =
 0   100%
>+    tools/binman/btool/openssl=2Epy                              42     =
 0   100%
>+    tools/binman/btool/xz=2Epy                                    5     =
 0   100%
>+    tools/binman/btool/zstd=2Epy                                  5     =
 0   100%
>+    tools/binman/cbfs_util=2Epy                                 376     =
 0   100%
>+    tools/binman/cmdline=2Epy                                    90     =
 0   100%
>+    tools/binman/control=2Epy                                   409     =
 0   100%
>+    tools/binman/elf=2Epy                                       241     =
 0   100%
>+    tools/binman/entry=2Epy                                     548     =
 0   100%
>+    tools/binman/etype/alternates_fdt=2Epy                       58     =
 0   100%
>+    tools/binman/etype/atf_bl31=2Epy                              5     =
 0   100%
>+    tools/binman/etype/atf_fip=2Epy                              67     =
 0   100%
>+    tools/binman/etype/blob=2Epy                                 49     =
 0   100%
>+    tools/binman/etype/blob_dtb=2Epy                             46     =
 0   100%
>+    tools/binman/etype/blob_ext=2Epy                              9     =
 0   100%
>+    tools/binman/etype/blob_ext_list=2Epy                        32     =
 0   100%
>+    tools/binman/etype/blob_named_by_arg=2Epy                     9     =
 0   100%
>+    tools/binman/etype/blob_phase=2Epy                           22     =
 0   100%
>+    tools/binman/etype/cbfs=2Epy                                101     =
 0   100%
>+    tools/binman/etype/collection=2Epy                           30     =
 0   100%
>+    tools/binman/etype/cros_ec_rw=2Epy                            5     =
 0   100%
>+    tools/binman/etype/efi_capsule=2Epy                          59     =
 0   100%
>+    tools/binman/etype/efi_empty_capsule=2Epy                    33     =
 0   100%
>+    tools/binman/etype/encrypted=2Epy                            34     =
 0   100%
>+    tools/binman/etype/fdtmap=2Epy                               62     =
 0   100%
>+    tools/binman/etype/files=2Epy                                35     =
 0   100%
>+    tools/binman/etype/fill=2Epy                                 13     =
 0   100%
>+    tools/binman/etype/fit=2Epy                                 311     =
 0   100%
>+    tools/binman/etype/fmap=2Epy                                 37     =
 0   100%
>+    tools/binman/etype/gbb=2Epy                                  37     =
 0   100%
>+    tools/binman/etype/image_header=2Epy                         53     =
 0   100%
>+    tools/binman/etype/intel_cmc=2Epy                             4     =
 0   100%
>+    tools/binman/etype/intel_descriptor=2Epy                     39     =
 0   100%
>+    tools/binman/etype/intel_fit=2Epy                            12     =
 0   100%
>+    tools/binman/etype/intel_fit_ptr=2Epy                        17     =
 0   100%
>+    tools/binman/etype/intel_fsp=2Epy                             4     =
 0   100%
>+    tools/binman/etype/intel_fsp_m=2Epy                           4     =
 0   100%
>+    tools/binman/etype/intel_fsp_s=2Epy                           4     =
 0   100%
>+    tools/binman/etype/intel_fsp_t=2Epy                           4     =
 0   100%
>+    tools/binman/etype/intel_ifwi=2Epy                           67     =
 0   100%
>+    tools/binman/etype/intel_me=2Epy                              4     =
 0   100%
>+    tools/binman/etype/intel_mrc=2Epy                             6     =
 0   100%
>+    tools/binman/etype/intel_refcode=2Epy                         6     =
 0   100%
>+    tools/binman/etype/intel_vbt=2Epy                             4     =
 0   100%
>+    tools/binman/etype/intel_vga=2Epy                             4     =
 0   100%
>+    tools/binman/etype/mkimage=2Epy                              84     =
 0   100%
>+    tools/binman/etype/null=2Epy                                  9     =
 0   100%
>+    tools/binman/etype/nxp_imx8mcst=2Epy                         78     =
59    24%
>+    tools/binman/etype/nxp_imx8mimage=2Epy                       38     =
 6    84%
>+    tools/binman/etype/opensbi=2Epy                               5     =
 0   100%
>+    tools/binman/etype/powerpc_mpc85xx_bootpg_resetvec=2Epy       6     =
 0   100%
>+    tools/binman/etype/pre_load=2Epy                             76     =
 0   100%
>+    tools/binman/etype/rockchip_tpl=2Epy                          5     =
 0   100%
>+    tools/binman/etype/scp=2Epy                                   5     =
 0   100%
>+    tools/binman/etype/section=2Epy                             418     =
 0   100%
>+    tools/binman/etype/tee_os=2Epy                               31     =
 0   100%
>+    tools/binman/etype/text=2Epy                                 21     =
 0   100%
>+    tools/binman/etype/ti_board_config=2Epy                     139     =
 0   100%
>+    tools/binman/etype/ti_dm=2Epy                                 5     =
 0   100%
>+    tools/binman/etype/ti_secure=2Epy                            65     =
 0   100%
>+    tools/binman/etype/ti_secure_rom=2Epy                       117     =
 0   100%
>+    tools/binman/etype/u_boot=2Epy                                7     =
 0   100%
>+    tools/binman/etype/u_boot_dtb=2Epy                            9     =
 0   100%
>+    tools/binman/etype/u_boot_dtb_with_ucode=2Epy                51     =
 0   100%
>+    tools/binman/etype/u_boot_elf=2Epy                           19     =
 0   100%
>+    tools/binman/etype/u_boot_env=2Epy                           27     =
 0   100%
>+    tools/binman/etype/u_boot_expanded=2Epy                       4     =
 0   100%
>+    tools/binman/etype/u_boot_img=2Epy                            7     =
 0   100%
>+    tools/binman/etype/u_boot_nodtb=2Epy                          7     =
 0   100%
>+    tools/binman/etype/u_boot_spl=2Epy                            8     =
 0   100%
>+    tools/binman/etype/u_boot_spl_bss_pad=2Epy                   14     =
 0   100%
>+    tools/binman/etype/u_boot_spl_dtb=2Epy                        9     =
 0   100%
>+    tools/binman/etype/u_boot_spl_elf=2Epy                        8     =
 0   100%
>+    tools/binman/etype/u_boot_spl_expanded=2Epy                  12     =
 0   100%
>+    tools/binman/etype/u_boot_spl_nodtb=2Epy                      8     =
 0   100%
>+    tools/binman/etype/u_boot_spl_pubkey_dtb=2Epy                32     =
 0   100%
>+    tools/binman/etype/u_boot_spl_with_ucode_ptr=2Epy             8     =
 0   100%
>+    tools/binman/etype/u_boot_tpl=2Epy                            8     =
 0   100%
>+    tools/binman/etype/u_boot_tpl_bss_pad=2Epy                   14     =
 0   100%
>+    tools/binman/etype/u_boot_tpl_dtb=2Epy                        9     =
 0   100%
>+    tools/binman/etype/u_boot_tpl_dtb_with_ucode=2Epy             8     =
 0   100%
>+    tools/binman/etype/u_boot_tpl_elf=2Epy                        8     =
 0   100%
>+    tools/binman/etype/u_boot_tpl_expanded=2Epy                  12     =
 0   100%
>+    tools/binman/etype/u_boot_tpl_nodtb=2Epy                      8     =
 0   100%
>+    tools/binman/etype/u_boot_tpl_with_ucode_ptr=2Epy            12     =
 0   100%
>+    tools/binman/etype/u_boot_ucode=2Epy                         33     =
 0   100%
>+    tools/binman/etype/u_boot_vpl=2Epy                            8     =
 0   100%
>+    tools/binman/etype/u_boot_vpl_bss_pad=2Epy                   14     =
 0   100%
>+    tools/binman/etype/u_boot_vpl_dtb=2Epy                        9     =
 0   100%
>+    tools/binman/etype/u_boot_vpl_elf=2Epy                        8     =
 0   100%
>+    tools/binman/etype/u_boot_vpl_expanded=2Epy                  12     =
 0   100%
>+    tools/binman/etype/u_boot_vpl_nodtb=2Epy                      8     =
 0   100%
>+    tools/binman/etype/u_boot_with_ucode_ptr=2Epy                42     =
 0   100%
>+    tools/binman/etype/vblock=2Epy                               38     =
 0   100%
>+    tools/binman/etype/x86_reset16=2Epy                           7     =
 0   100%
>+    tools/binman/etype/x86_reset16_spl=2Epy                       7     =
 0   100%
>+    tools/binman/etype/x86_reset16_tpl=2Epy                       7     =
 0   100%
>+    tools/binman/etype/x86_start16=2Epy                           7     =
 0   100%
>+    tools/binman/etype/x86_start16_spl=2Epy                       7     =
 0   100%
>+    tools/binman/etype/x86_start16_tpl=2Epy                       7     =
 0   100%
>+    tools/binman/etype/x509_cert=2Epy                            71     =
 0   100%
>+    tools/binman/etype/xilinx_bootgen=2Epy                       72     =
 0   100%
>+    tools/binman/fip_util=2Epy                                  202     =
 0   100%
>+    tools/binman/fmap_util=2Epy                                  49     =
 0   100%
>+    tools/binman/image=2Epy                                     181     =
 0   100%
>+    tools/binman/state=2Epy                                     201     =
 0   100%
>+    --------------------------------------------------------------------=
-------
>+    TOTAL                                                    5954     69=
    99%
>+
>+    To get a report in 'htmlcov/index=2Ehtml', type: python3-coverage ht=
ml
>+    Coverage error: 99%, but should be 100%
>+    ValueError: Test coverage failure
>+
>+Unfortunately the run failed=2E As it suggests, create a report:
>+
>+=2E=2E code-block:: bash
>+
>+    $ python3-coverage html
>+    Wrote HTML report to htmlcov/index=2Ehtml
>+
>+If you open that file in the browser, you can see which files are not re=
aching
>+100% and click on them=2E Here is ``nxp_imx8mimage=2Epy``, for example:
>+
>+=2E=2E code-block:: python
>+
>+    43        # Generate mkimage configuration file similar to imx8mimag=
e=2Ecfg
>+    44        # and pass it to mkimage to generate SPL image for us here=
=2E
>+    45        cfg_fname =3D tools=2Eget_output_filename('nxp=2Eimx8mimag=
e=2Ecfg=2E%s' % uniq)
>+    46        with open(cfg_fname, 'w') as outf:
>+    47            print('ROM_VERSION v%d' % self=2Erom_version, file=3Do=
utf)
>+    48            print('BOOT_FROM %s' % self=2Eboot_from, file=3Doutf)
>+    49            print('LOADER %s %#x' % (input_fname, self=2Eloader_ad=
dress), file=3Doutf)
>+    50
>+    51        output_fname =3D tools=2Eget_output_filename(f'cfg-out=2E{=
uniq}')
>+    52        args =3D ['-d', input_fname, '-n', cfg_fname, '-T', 'imx8m=
image',
>+    53                output_fname]
>+    54        if self=2Emkimage=2Erun_cmd(*args) is not None:
>+    55            return tools=2Eread_file(output_fname)
>+    56        else:
>+    57            # Bintool is missing; just use the input data as the o=
utput
>+    58 x          self=2Erecord_missing_bintool(self=2Emkimage)
>+    59 x          return data
>+    60
>+    61    def SetImagePos(self, image_pos):
>+    62        # Customized SoC specific SetImagePos which skips the mkim=
age etype
>+    63        # implementation and removes the 0x48 offset introduced th=
ere=2E That
>+    64        # offset is only used for uImage/fitImage, which is not th=
e case in
>+    65        # here=2E
>+    66        upto =3D 0x00
>+    67        for entry in super()=2EGetEntries()=2Evalues():
>+    68 x          entry=2ESetOffsetSize(upto, None)
>+    69
>+    70            # Give up if any entries lack a size
>+    71 x          if entry=2Esize is None:
>+    72 x              return
>+    73 x          upto +=3D entry=2Esize
>+    74
>+    75        Entry_section=2ESetImagePos(self, image_pos)
>+
>+Most of the file is covered, but the lines marked with ``x`` indicate mi=
ssing
>+coverage=2E The will show up red in your browser=2E
>+
>+What is a test?
>+---------------
>+
>+A test is a function in ``ftest=2Epy`` which uses an image description i=
n
>+``tools/binman/test`` to perform some operations and exercise the code=
=2E Some
>+tests are just a few lines; some are more complicated=2E
>+
>+Here is a simple test:
>+
>+=2E=2E code-block:: python
>+
>+    def testSimple(self):
>+        """Test a simple binman with a single file"""
>+        data =3D self=2E_DoReadFile('005_simple=2Edts')
>+        self=2EassertEqual(U_BOOT_DATA, data)
>+
>+This test tells Binman to build an image using the description=2E Then i=
t checks
>+that the resulting image looks correct=2E The image description is:
>+
>+=2E=2E code-block:: devicetree
>+
>+    /dts-v1/;
>+
>+    / {
>+        #address-cells =3D <1>;
>+        #size-cells =3D <1>;
>+
>+        binman {
>+            u-boot {
>+            };
>+        };
>+    };
>+
>+As you will know from the Binman documentation, this says that there is
>+one image and it contains the U-Boot binary=2E So this test builds an im=
age
>+consisting of a U-Boot binary, then checks that it does indeed have just=
 a
>+U-Boot binary in it=2E
>+
>+Test data
>+---------
>+
>+Using real binaries (like ``u-boot=2Ebin``) to test Binman would be quit=
e tedious=2E
>+Every output file would be large and it would be hard to tell by looking=
 at the
>+output (e=2Eg=2E with a hex dump) if a particular entry contains ``u-boo=
t=2Ebin`` or
>+``u-boot-spl=2Ebin`` or something else=2E
>+
>+Binman gets around this by using simple placeholders=2E Here is the plac=
eholder
>+for u-boot=2Ebin:
>+
>+=2E=2E code-block:: python
>+
>+    U_BOOT_DATA           =3D b'1234'
>+
>+This is just bytes=2E So the test above checks that the output image con=
tains
>+these four bytes=2E This makes verification fast for Binman and very eas=
y for
>+humans=2E
>+
>+Even the devicetree is a placeholder:
>+
>+=2E=2E code-block:: python
>+
>+    U_BOOT_DTB_DATA       =3D b'udtb'
>+
>+But for some tests you need to use the real devicetree=2E In that case y=
ou can
>+use ``_DoReadFileRealDtb()``=2E See ``testUpdateFdtAll()`` for an exampl=
e of how
>+to check the devicetree updated by Binman=2E
>+
>+Test structure
>+--------------
>+
>+Each test is designed to test just one thing=2E Binman tests are named a=
ccording
>+to what they are testing=2E Individually they don't do very much, but as=
 a whole
>+they test every line of code in Binman=2E
>+
>+So ``testSimple()`` is designed to check that Binman can build the
>+simplest-possible image that isn't completely empty=2E
>+
>+Another type of test is one which checks error-handling, for example:
>+
>+=2E=2E code-block:: python
>+
>+    def testFillNoSize(self):
>+        """Test for an fill entry type with no size"""
>+        with self=2EassertRaises(ValueError) as e:
>+            self=2E_DoReadFile('070_fill_no_size=2Edts')
>+        self=2EassertIn("'fill' entry is missing properties: size",
>+                      str(e=2Eexception))
>+
>+This test deliberately tries to provoke an error=2E The image descriptio=
n is:
>+
>+=2E=2E code-block:: devicetree
>+
>+    // SPDX-License-Identifier: GPL-2=2E0+
>+    /dts-v1/;
>+
>+    / {
>+        #address-cells =3D <1>;
>+        #size-cells =3D <1>;
>+
>+        binman {
>+            size =3D <16>;
>+            fill {
>+                fill-byte =3D [ff];
>+            };
>+        };
>+    };
>+
>+You can see that there is no size for the 'fill' entry, so we would expe=
ct
>+Binman to complain=2E The test checks that it actually does=2E It also c=
hecks the
>+error message produced by Binman=2E Sometimes you need to add several te=
sts, each
>+with their own broken image description, in order to check all the error=
 cases=2E
>+
>+Sometimes you need to capture the console output of Binman, to check it =
is
>+correct=2E You can to this with ``test_util=2Ecapture_sys_output()``, fo=
r example:
>+
>+=2E=2E code-block:: python
>+
>+    with test_util=2Ecapture_sys_output() as (_, stderr):
>+        self=2E_DoTestFile('071_gbb=2Edts', force_missing_bintools=3D'fu=
tility',
>+                         entry_args=3Dentry_args)
>+    err =3D stderr=2Egetvalue()
>+    self=2EassertRegex(err, "Image 'image'=2E*missing bintools=2E*: futi=
lity")
>+
>+The test collects the output and checks it with a regular expression=2E =
If you
>+need to see the test output (e=2Eg=2E to debug it), you will have to rem=
ove that
>+capture line=2E
>+
>+How to add a new test
>+---------------------
>+
>+This section explains the process of writing a new test=2E It uses an ex=
ample to
>+help with this, but your code will be different=2E
>+
>+Generally you are adding a test because you are adding a new entry type
>+('etype')=2E So start by creating the shortest and simplest image-descri=
ption you
>+can, which contains the new etype=2E Put it in a numbered file in
>+``tool/binman/test`` so that it comes last=2E All the numbers are unique=
 and there
>+are no gaps=2E
>+
>+Example from ``tools/binman/test/339_nxp_imx8=2Edts``:
>+
>+=2E=2E code-block:: devicetree
>+
>+    // SPDX-License-Identifier: GPL-2=2E0+
>+
>+    /dts-v1/;
>+
>+    / {
>+        #address-cells =3D <1>;
>+        #size-cells =3D <1>;
>+
>+        binman {
>+            nxp-imx8mimage {
>+                args;    /* TODO: Needed by mkimage etype superclass */
>+                nxp,boot-from =3D "sd";
>+                nxp,rom-version =3D <1>;
>+                nxp,loader-address =3D <0x10>;
>+            };
>+        };
>+    };
>+
>+Note that you should use tabs in the file, not spaces=2E You can see tha=
t this has
>+been cut down to the bare minimum, just enough to include the etype and =
the
>+arguments it needs=2E This is of course not a real image=2E It will not =
boot on
>+anything=2E But that's fine; we are just trying to test this one etype=
=2E Try not
>+to add any other sections and etypes unless they are absolutely essentia=
l for
>+your test to work=2E This helps others too: they don't need to understan=
d the full
>+complexity of your etype just to read your test=2E
>+
>+Then create your test by adding a new function at the end of ``ftest=2Ep=
y``:
>+
>+=2E=2E code-block:: python
>+
>+    def testNxpImx8Image(self):
>+        """Test that binman can produce an iMX8 image"""
>+        self=2E_DoTestFile('339_nxp_imx8=2Edts')
>+
>+This uses the test file that you created=2E It doesn't check anything, i=
t just
>+runs the image description through binman=2E
>+
>+Let's run it:
>+
>+=2E=2E code-block:: bash
>+
>+    $ binman test testNxpImx8Image
>+    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D Running binman tests =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>+    =2E
>+    --------------------------------------------------------------------=
--
>+    Ran 1 test in 0=2E242s
>+
>+    OK
>+
>+So the test passes=2E It doesn't really do a lot, but it does exercise t=
he etype=2E
>+The next step is to update it to actually check the output:
>+
>+=2E=2E code-block:: python
>+
>+    def testNxpImx8Image(self):
>+        """Test that binman can produce an iMX8 image"""
>+        data =3D self=2E_DoReadFile('339_nxp_imx8=2Edts')
>+        print('data', len(data))
>+
>+The ``_DoReadFile()`` function is documented in the code=2E It returns t=
he image
>+contents as the first part of a tuple=2E
>+
>+Running this we see:
>+
>+=2E=2E code-block:: bash
>+
>+    data 2200
>+
>+So it is producing a little over 8K of data=2E Your etype will be differ=
ent, but
>+in any case you can add Python code to check that this data is actually =
correct,
>+based on your knowledge of your etype=2E Note that you should not be che=
cking
>+whether the external tools (called 'bintools' in Binman) are actually wo=
rking,
>+since presumably they have their own tests=2E You just need to check tha=
t the
>+image seems reasonable, e=2Eg=2E is not empty, contains the expected sec=
tions, etc=2E
>+
>+When your etype does use a bintool, it also needs tests, but generally i=
t will
>+be tested by virtue of the etype test=2E This is because your etype must=
 call the
>+bintool to create the image=2E Sometimes you might need to add a test fo=
r a
>+bintool error-condition, though=2E
>+
>+Finishing code coverage
>+-----------------------
>+
>+The objective is to have test-coverage for every line of code that you a=
dd to
>+Binman=2E So how can you tell? First, get a coverage report as described=
 above=2E
>+Look through the output for any files which are not at 100%=2E Add more =
test cases
>+(image descriptions and new functions in ``ftest=2Epy``) until you have =
covered
>+each line=2E
>+
>+In the above example, here are some possible steps:
>+
>+#=2E The first red bit is where the ``mkimage`` call returns None=2E Thi=
s can be
>+   traced to ``Bintoolmkimage=2Emkimage()`` which calls
>+   ``Bintool=2Erun_cmd_result()`` and ``None`` means that ``mkimage`` is=
 missing=2E
>+   So the etype has code to handle that case, but it is never used=2E Yo=
u can
>+   look for other examples of ``self=2Emkimage`` returning ``None`` - e=
=2Eg=2E
>+   ``Entry_mkimage=2EBuildSectionData()`` does this=2E The clue for find=
ing this is
>+   that the ``nxp-imx8mimage`` etype is based on ``Entry_mkimage``:
>+
>+   =2E=2E code-block:: python
>+
>+       class Entry_nxp_imx8mimage(Entry_mkimage):
>+
>+   It must be tested somewhere=2E=2E=2Ein this case ``testMkimage()`` do=
esn't do it,
>+   but ``testMkimageMissing()`` immediately below that does=2E So you ca=
n create a
>+   similar test, e=2Eg=2E:
>+
>+   =2E=2E code-block:: python
>+
>+       def testNxpImx8ImageMkimageMissing(self):
>+           """Test that binman can produce an iMX8 image"""
>+           with test_util=2Ecapture_sys_output() as (_, stderr):
>+               self=2E_DoTestFile('339_nxp_imx8=2Edts',
>+                                force_missing_bintools=3D'mkimage')
>+           err =3D stderr=2Egetvalue()
>+           self=2EassertRegex(err, "Image 'image'=2E*missing bintools=2E=
*: mkimage")
>+
>+   Note that this uses exactly the same image description as the first t=
est=2E
>+   It just checks what happens when the tool is missing=2E Checking the =
coverage
>+   again, you will see that the first red bit has gone:
>+
>+   =2E=2E code-block:: bash
>+
>+       $ binman test -T
>+       $ python3-coverage html
>+
>+#=2E The second red bit is for ``SetImagePos()``=2E You can see that it =
is iterating
>+   through the sub-entries inside the ``nxp-imx8mimage`` entry=2E In the=
 case of
>+   the 339 file, there are no such entries, so this code inside the for(=
) loop
>+   isn't used:
>+
>+   =2E=2E code-block:: python
>+
>+       def SetImagePos(self, image_pos):
>+        # Customized SoC specific SetImagePos which skips the mkimage et=
ype
>+        # implementation and removes the 0x48 offset introduced there=2E=
 That
>+        # offset is only used for uImage/fitImage, which is not the case=
 in
>+        # here=2E
>+        upto =3D 0x00
>+        for entry in super()=2EGetEntries()=2Evalues():
>+            entry=2ESetOffsetSize(upto, None)
>+
>+            # Give up if any entries lack a size
>+            if entry=2Esize is None:
>+                return
>+            upto +=3D entry=2Esize
>+
>+        Entry_section=2ESetImagePos(self, image_pos)
>+
>+   The solution is to add an entry, e=2Eg=2E in ``340_nxp_imx8_non_empty=
=2Edts``:
>+
>+   =2E=2E code-block:: devicetree
>+
>+       // SPDX-License-Identifier: GPL-2=2E0+
>+
>+       /dts-v1/;
>+
>+       / {
>+           #address-cells =3D <1>;
>+           #size-cells =3D <1>;
>+
>+           binman {
>+               nxp-imx8mimage {
>+                   args;    /* TODO: Needed by mkimage etype superclass =
*/
>+                   nxp,boot-from =3D "sd";
>+                   nxp,rom-version =3D <1>;
>+                   nxp,loader-address =3D <0x10>;
>+
>+                   u-boot {
>+                   };
>+               };
>+           };
>+       };
>+
>+   Now write a little test to use it:
>+
>+   =2E=2E code-block:: python
>+
>+       def testNxpImx8ImageNonEmpty(self):
>+           """Test that binman can produce an iMX8 image with something =
in it"""
>+            data =3D self=2E_DoReadFile('340_nxp_imx8_non_empty=2Edts')
>+            # check data here
>+
>+   With that, the second red bit goes away, because the for() loop is no=
w used=2E
>+
>+#=2E There is one more red bit left, the ``return`` in ``SetImagePos()``=
=2E The
>+   above effort got the for() loop to be executed, but it doesn't cover =
the
>+   ``return``=2E It might have been copied from some other etype, e=2Eg=
=2E the mkimage
>+   one=2E See ``Entry_mkimage=2ESetImagePos()`` which contains the code:
>+
>+   =2E=2E code-block:: python
>+
>+       for entry in self=2EGetEntries()=2Evalues():
>+           entry=2ESetOffsetSize(upto, None)
>+
>+           # Give up if any entries lack a size
>+           if entry=2Esize is None:
>+               return
>+           upto +=3D entry=2Esize
>+
>+   But which test covers that code for mkimage? By figuring that out, yo=
u could
>+   use a similar technique=2E One way to find out is to delete the two l=
ines in
>+   ``Entry_mkimage`` which check for entry=2Esize being None and returni=
ng, then
>+   see what breaks with ``binman test``:
>+
>+   =2E=2E code-block:: bash
>+
>+       ERROR: binman=2Eftest=2ETestFunctional=2EtestMkimageCollection (s=
ubunit=2ERemotedTestCase)
>+       binman=2Eftest=2ETestFunctional=2EtestMkimageCollection
>+       -----------------------------------------------------------------=
-----
>+       testtools=2Etestresult=2Ereal=2E_StringException: Traceback (most=
 recent call last):
>+       TypeError: unsupported operand type(s) for +=3D: 'int' and 'NoneT=
ype'
>+
>+       =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>+       ERROR: binman=2Eftest=2ETestFunctional=2EtestMkimageImage (subuni=
t=2ERemotedTestCase)
>+       binman=2Eftest=2ETestFunctional=2EtestMkimageImage
>+       -----------------------------------------------------------------=
-----
>+       testtools=2Etestresult=2Ereal=2E_StringException: Traceback (most=
 recent call last):
>+       TypeError: unsupported operand type(s) for +=3D: 'int' and 'NoneT=
ype'
>+
>+       =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>+       ERROR: binman=2Eftest=2ETestFunctional=2EtestMkimageSpecial (subu=
nit=2ERemotedTestCase)
>+       binman=2Eftest=2ETestFunctional=2EtestMkimageSpecial
>+       -----------------------------------------------------------------=
-----
>+       testtools=2Etestresult=2Ereal=2E_StringException: Traceback (most=
 recent call last):
>+       TypeError: unsupported operand type(s) for +=3D: 'int' and 'NoneT=
ype'
>+
>+   We can verify that you got the right test, by putting the lines back =
in and
>+   getting coverage for just that test:
>+
>+   =2E=2E code-block:: bash
>+
>+       binman test -T testMkimageCollection
>+       python3-coverage html
>+
>+   You will see a lot of red since we are seeing test coverage just for =
one
>+   test, but if you look in ``mkimage=2Epy`` at ``SetImagePos()`` you wi=
ll see
>+   that the ``return`` is covered (i=2Ee=2E it is marked green)=2E
>+
>+   Looking at the ``=2Edts`` files for each of these tests, none jumps o=
ut as
>+   being relevant to our case=2E It seems that this code just isn't need=
ed, so the
>+   best solution is to delete those two lines from the function:
>+
>+   =2E=2E code-block:: python
>+
>+       def SetImagePos(self, image_pos):
>+           # Customized SoC specific SetImagePos which skips the mkimage=
 etype
>+           # implementation and removes the 0x48 offset introduced there=
=2E That
>+           # offset is only used for uImage/fitImage, which is not the c=
ase in
>+           # here=2E
>+           upto =3D 0x00
>+           for entry in super()=2EGetEntries()=2Evalues():
>+               entry=2ESetOffsetSize(upto, None)
>+               upto +=3D entry=2Esize
>+
>+           Entry_section=2ESetImagePos(self, image_pos)
>+
>+We should check the updated code on a real build, to make sure it really
>+isn't needed, of course=2E
>+
>+Now, the test coverage is complete!
>+
>+If we later discover a case where those lines are needed, we can add the
>+lines back, along with a test for this case=2E
>+
>+Getting help
>+------------
>+
>+If you are stuck and cannot work out how to add test coverage for your e=
ntry
>+type, ask on the U-Boot mailing list, cc ``Simon Glass <sjg@chromium=2Eo=
rg>`` or
>+on irc ``sjg1``
>diff --git a/doc/develop/index=2Erst b/doc/develop/index=2Erst
>index 0d0e60ab56c=2E=2Ee75169ef14c 100644
>--- a/doc/develop/index=2Erst
>+++ b/doc/develop/index=2Erst
>@@ -81,6 +81,7 @@ Testing
>    py_testing
>    tests_writing
>    tests_sandbox
>+   binman_tests
>=20
> Refactoring
> -----------
>diff --git a/tools/binman/binman=2Erst b/tools/binman/binman=2Erst
>index c25914312a8=2E=2E381e55686f9 100644
>--- a/tools/binman/binman=2Erst
>+++ b/tools/binman/binman=2Erst
>@@ -2194,6 +2194,11 @@ Use '-P 1' to disable this=2E It is automatically =
disabled when code coverage is
> being used (-T) since they are incompatible=2E
>=20
>=20
>+Writing tests
>+-------------
>+
>+See :doc:`=2E=2E/binman_tests`=2E
>+
> Debugging tests
> ---------------
>=20
