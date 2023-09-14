Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F1EEDE98C
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 07:31:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9FA986BA2;
	Thu, 14 Sep 2023 09:31:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="bBJum+RW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23FFC86BFF; Thu, 14 Sep 2023 09:31:55 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4423C86AEB
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 09:31:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1694676709; x=1695281509; i=xypron.glpk@gmx.de;
 bh=A4wQDS/h6xNPCfmBa16zQP9I+BgDC9X8i1Wy3G7+m4A=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=bBJum+RWvyBExkf2ly4Wv3YkH+d90y8fUqaYxXDee6w/nIEbsFyFimVZVGWcO/cRy4HiZj852Zk
 /uwEpyuzw46dx48n2/sSsAn7xzjsXKCPN20T4fVBpNkDb94TDotpkyCJCIf/XpXtPqZj+jhtQiZx2
 v+zqhyLnqlOF7F8ykl/gjbpHDf5bokgzlhHpxGoneFwolgdmo95qN7rXZhxKzGfK+Bskxd6F1h/z0
 PDVeugAbrKkQvU34t0CzDOoCJZT4SRJZrStbtp2FMmfqsA829xMfWA2t81aWN21cz1rFz9WYvlr3m
 Xu+pyd41uFPYNy6d85py0dCMVyTJh24Exx9w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4zAs-1rhHG53Eyy-010sGV; Thu, 14
 Sep 2023 09:31:49 +0200
Message-ID: <206fb017-be6f-496e-b3a0-474401d12d8b@gmx.de>
Date: Thu, 14 Sep 2023 09:32:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] doc: add new section to build/tools
Content-Language: en-US, de-DE
To: Joao Marcos Costa <jmcosta944@gmail.com>
Cc: trini@konsulko.com, sjg@chromium.org, antoningodard@pm.me,
 Y.Moog@phytec.de, u-boot@lists.denx.de
References: <20230902145310.107054-1-jmcosta944@gmail.com>
 <20230902145310.107054-8-jmcosta944@gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20230902145310.107054-8-jmcosta944@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:b4CZvuZdxDwKv6HZZrQkR79AUzkSpM5lGGFInpTa7EzuF3swu6m
 oS9XDzodDcET5unOwWT7OQl1LipxszFCxHgAHJcxyyS14fV/dcGEFMrxB6xD2L1EfUNDbys
 qTLniYoLuxY29la9ZBiVoitBWyfkB8QLL1r4la4DwwtDce8JZzjKdRyO/eveZyg99IDIa1M
 FKQOd1ed6WImJnLWxfx3A==
UI-OutboundReport: notjunk:1;M01:P0:jSEs7tTl5wk=;RJxYKvKE/RtBJRQuAdj+PPPuLwB
 l2UdJkAcIdPfhmnFW+OeJwhuNOmqe75ae7a3fulsBarn2yjcWU4aNpYrPhbMH6QM7wsBAzHmB
 rq7QXqjIQHg0dVWG++HxVkIdkx0MLUMbz9xmyjqWCK1x4+Aewgj1lFnRmU6aC4wmHUuNLEgss
 H5hy7H2+rkdhvQXRhOpBFk3h03ROzT6ipOd8P1evr2G9fqHbNHRDH6o2iHVW6c3bgQY0qAJDY
 66a878Gcdy5jYoZFU2LGvP/Nqs0anWrVcgipGAi9wMdXudJpQh1JO8Otx77m8GxR7HyqdrvwV
 ciHFvAjw7LMxpS+206qfXKKLuCbn2aI9IuNkruODb2JUG5xeNl5PzfDUOnuFiXMDNPUHc1gMU
 SIfNsc5HlztVSwa1ILAt2nfFKHO2vtNRD16oJZRsH299Qf6EzVMZm2CX8KWaMJ+8WFnUwszTZ
 DfqBISiyOaF66rmzxoOp+JJOQn90gvB9js6n1CioiNFYH4xTm6pqM6SvMu3lRlfEpnuLMXrDv
 9n6fD7KwFefsf/TtuHN/Tq8juobI9T3e3YmEZQcKzQZIM+6lSpK9bWMRNp9Hg4AGfrTC2S2GF
 tJkgX1dUoManJZBiPxJdkhF2AHxs+MVDsOp84dMFqV72c+fpjgsteIkRCN3qLvmeCZpZtp/Df
 eYHlGzJMkrBaL8j0je8gu/v5G7dHCs8MRIF2+vDfQeghwLw/S5W+4AP3iVpNq2HpvouBFIUx4
 W4U2XTGbF54zSWpeXrVURkgyt3aJWxo1NXO0Y/Hw2qZylBPzjcEwBWnGXVObmVRU8WDdWmhRJ
 tZZ8DFCC9RndUU2jDqiHC2GUepOK7PADPQZBncMJC8JPYOJAf5EZoywx/IMJrQC5DTwkoauyk
 Q/MzaKDtyixc1dZ8ICOtSjSLYnj7OVPRdF7Hh22MgKAS4Ymk7MhSTXN2JEjHnrZhEgqGv5O5O
 1B4BHSccjYRahXr9h4mbOZfjYRg=
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

On 9/2/23 16:53, Joao Marcos Costa wrote:
> Add 'Integration with IDEs' section.
>
> For now, this section is mostly a reference to the documentation of
> gen_compile_commands, also in doc/build, but it can be futurely used as
> a guide for other IDE-friendly features.
>
> Signed-off-by: Joao Marcos Costa <jmcosta944@gmail.com>
> ---
>   doc/build/gen_compile_commands.rst |  1 +
>   doc/build/tools.rst                | 13 +++++++++++++
>   2 files changed, 14 insertions(+)
>
> diff --git a/doc/build/gen_compile_commands.rst b/doc/build/gen_compile_=
commands.rst
> index 6b32eb678a..da812525fe 100644
> --- a/doc/build/gen_compile_commands.rst
> +++ b/doc/build/gen_compile_commands.rst
> @@ -1,4 +1,5 @@
>   .. SPDX-License-Identifier: GPL-2.0-only
> +.. _gen-compile-commands-label:

You don't need a label to refer to a document. Just use a :doc: link.

>
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   gen_compile_commands
> diff --git a/doc/build/tools.rst b/doc/build/tools.rst
> index ec01722925..5cdbf27d83 100644
> --- a/doc/build/tools.rst
> +++ b/doc/build/tools.rst
> @@ -45,3 +45,16 @@ Launch the MSYS2 shell of the MSYS2 environment, and =
do the following::
>
>      $ make tools-only_defconfig
>      $ make tools-only
> +
> +Integration with IDEs
> +---------------------

This chapter is not related to our host tools and it is not related to
building. You could put it into a separate document in doc/develop/.

Best regards

Heinrich

> +
> +IDEs and text editors (e.g., VSCode, Emacs, Vim, Neovim) typically offe=
r
> +plugins to enhance the development experience, such as Clangd LSP. Thes=
e
> +plugins provide features like code navigation (i.e., jumping to definit=
ions
> +and declarations), code completion, and code formatting.
> +
> +U-Boot provides a script (i.e., scripts/gen_compile_commands.py) that
> +generates a compilation database to be utilized by Clangd LSP for code
> +navigation. For detailed usage instructions, please refer to the script=
's
> +documentation: :ref:`gen-compile-commands-label`.

