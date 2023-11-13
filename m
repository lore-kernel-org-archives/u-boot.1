Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D73EBC4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 00:18:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D831C86DCE;
	Mon, 13 Nov 2023 01:18:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="SuVtnvr+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 704EA86E2F; Mon, 13 Nov 2023 01:18:48 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E26FE86DB8
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 01:18:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1699834719; x=1700439519; i=xypron.glpk@gmx.de;
 bh=3rmUGOz8ektN2rg5ySrUN0oEOyCr57/UWF0RMMJELWc=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=SuVtnvr+PPfzd84DnEy1m7iM0bHnjNEtqvPRlKx0X49gske9ko/rKUO5lIJcQSjA
 PvH9aMUjjckGMBvEzrqLTjHORUzc83JCIaT1SbMe6c9WHbEPyZqq+Uu9DB3N1HMYE
 JK1x+vBb6PNkoB3q//WV/q/7WHzx1h9geFBhnRM/cugdibWBj6yCMYcigN8sAh/Dp
 LuOkE4aP22s5SQKugl2x/hYmGxJgJDDx1Cr2pcefD2MKxUtXGRTAAgTxFcHFHAGUN
 meHlJ9ez9weID6Lgv11IQFowFMHuLknfaAbEvgTX79eQ7GLwsfiSDpRdlBpP7yUhJ
 FNMO76rrjW153yiUeg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPogF-1qgYNY3GwV-00MuNX; Mon, 13
 Nov 2023 01:18:39 +0100
Message-ID: <a3a82431-59b7-4e7d-8eaf-fcac5a71bfad@gmx.de>
Date: Mon, 13 Nov 2023 01:18:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sandbox: Fix VPL instructions
Content-Language: en-US, de-DE
To: Simon Glass <sjg@chromium.org>
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Corentin Guillevic <corentin.guillevic@smile.fr>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20231112144412.120369-1-sjg@chromium.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231112144412.120369-1-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1S+lYZVRB7HI5QYiPtUXwmmK2AkaJFlugTtJeJBB8du7wz4DgtY
 kEfJXaXvji3kV72yMhrvycMVjGWIEyaJjvFDWtbh9A2w8EOpZ5r0UGCQMYz+qH08O53Yi9D
 nhMw334+HfbyFNb6YLUTI/Hwh+0Xb3j9t7U/mIpSydUhy6/tMtqedOBQ5U7O0LGyzb1yd2g
 6D1pNS4x7wpfarAycwr/A==
UI-OutboundReport: notjunk:1;M01:P0:GSDQKAnM13s=;lh1VMc7qrorMoTg1o8MTTxRYmtU
 J7SnLfqzKZD2/jJ/qMx8DNLY3nDw7HgzP139topgUJwBXDHIUdMURVgbSPxYGlEEJXIRmPM88
 ztLCFphIQ56dlrWKh/WuL/892KQ7P3O6kwW8+wBj7aYP6lGRv9BB29dY6etDYMCEHYmh1ORlM
 D1KWVq4V7xC0noSBg8aw/iiJufJytXjIJQe4KviHtLwtf2pF7oS9lz/b+KLljGrjYW0yiATpQ
 QFRNbKbWR97/j1+YZeP9fjrRjQ4X4wGHOnEyqHpODjkS4hBwEwcd1G/9XoHdVRFwY322PkWEX
 Ev6T8ev95TfooVhAaRr7CVajFyrtqYXUqZlmJBzfBmK4TX7sSot0dt7gd3wAyATy6mCNn7DGi
 t4HURl9V6yxeQfpG1j+G0BxU1qzz59zk9VsO/1YcntIrHGnCt9b++o/ifnQXFEWzVWX1Fwwor
 XQxtJ9XKsue7Y+FqbSFT02qKXwTRiYYvURhouCCu8L//9rpJlnoJgAbsZJBUIfL0Ww/k0M9Cn
 S+sBe01sTYrHPte/lVqKHsOv1AxpCrw6RQZMDTinbLu5BCBKFEJh3xYRlfJz4DhELBKTLKmAC
 FyCMgl1N0hqLbcAUvEyDIS/o/beEBLILTO4rK2H2m24I86M6RVu+mplZBIFf/aOp6O1Ja/3Iv
 cswX+FOQkcAuH0jIVIOLkk1iT6QgiwAgNAxAnHexwU4vg0ZO2urBSCNCSXsQlKSMoW1u/+tyM
 yVK12bsSKZGdEUSQIOih3HQLAr9P4vo98MQwbe6lgi7HZwIbEmGzo/W/s129I6EzLdbSVWR/k
 3to/JcXJZmNtGM1OyDwuyKiW8QahTFEbBGjOdwEbYO6MnBDjFsNh1GGoB1epYIz7YfU7ajmZU
 sVL7CignuHh77wftiYBFv3EtqemK8c97ZPw/ZOcR/uoommwF4kA/ke8u9Nqn3Y4/J2G/299f0
 gvwl/mQY4CpKwaRn/wWYLKUg8Po=
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

On 11/12/23 15:44, Simon Glass wrote:
> Fix the devicetree used with sandbox. This is needed because the
> default (full) devicetree must be used by all phases of boot, with
> sandbox.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>   doc/arch/sandbox/sandbox.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/doc/arch/sandbox/sandbox.rst b/doc/arch/sandbox/sandbox.rst
> index 23902dee89e7..9c69dea81ed1 100644
> --- a/doc/arch/sandbox/sandbox.rst
> +++ b/doc/arch/sandbox/sandbox.rst
> @@ -427,7 +427,7 @@ VPL (Verifying Program Loader)
>   Sandbox provides an example build of vpl called `sandbox_vpl`. This ca=
n be run

This will be confusing to a rookie. Please refer to sandbox_vpl_defconfig.

>   using::

using:

.. code-block:: bash

>
> -   /path/to/sandbox_vpl/tpl/u-boot-tpl -D

Please provide the full instructions:

make sandbox_vpl_defconfig
make
tpl/u-boot-tpl -d u-boot.dtb

> +   /path/to/sandbox_vpl/tpl/u-boot-tpl -d /tmp/b/sandbox_vpl/u-boot.dtb

Do we really use /tmp? We should place all build artifacts in the build
directory instead.

I could not find any directory called sandbox_vpl in my /tmp directory.

I could not make the example work:

$ make sandbox_vpl_defconfig
$ make
$ tpl/u-boot-tpl -d u-boot.dtb

U-Boot TPL 2024.01-rc2-00002-g66024fa8d5 (Nov 13 2023 - 01:09:03 +0100)
Trying to boot from sandbox_image
Trying to boot from sandbox_file
(tpl/u-boot-vpl not found, error -2)
TPL: failed to boot from all boot devices
### ERROR ### Please RESET the board ###

u-boot-vpl is not in tpl/ but in vpl/.
The VPL example seems to need rework.

>
>   It starts up TPL (first-stage init), then VPL, then runs SPL and final=
ly U-Boot
>   proper, following the normal flow for a verified boot. At present, no

Best regards

Heinrich
