Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B82BCAC597
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 00:57:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83DC7829E7;
	Fri, 19 Sep 2025 02:57:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2714A82C84; Fri, 19 Sep 2025 02:57:54 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A18B81E13
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 02:57:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [98.97.61.9]) (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 6F8A9B2202B3;
 Fri, 19 Sep 2025 02:57:50 +0200 (CEST)
Message-ID: <a29fc221-7d35-4454-be40-5a7132e08760@freeshell.de>
Date: Thu, 18 Sep 2025 17:57:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] doc: make pdfdocs: Specify texlive-xetex as a
 prerequisite
To: Adriano Carvalho <adrianocarvalho.pt@gmail.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Neha Malcom Francis <n-francis@ti.com>
References: <20250825224459.682403-1-adrianocarvalho.pt@gmail.com>
 <20250825224459.682403-2-adrianocarvalho.pt@gmail.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20250825224459.682403-2-adrianocarvalho.pt@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 8/25/25 15:44, Adriano Carvalho wrote:
> If I don't apt install texlive-xetex, this is what I get with docker.io/trini/u-boot-gitlab-ci-runner:jammy-20250714-25Jul2025:
> 
> uboot@35c89b9ab70e:~/u-boot$ make pdfdocs
>   HOSTCC  scripts/basic/fixdep
> doc/Makefile:89: The 'xelatex' command was not found. Make sure you have it installed and in PATH to produce PDF output.
>   SKIP    Sphinx pdfdocs target.
> 
> NOTE: This won't completely fix the pdfdocs target. See next commit(s).
> 
> Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
> ---
>  doc/build/documentation.rst | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/doc/build/documentation.rst b/doc/build/documentation.rst
> index 098c96a4c4f..68d7e11c572 100644
> --- a/doc/build/documentation.rst
> +++ b/doc/build/documentation.rst
> @@ -16,6 +16,8 @@ the following dependencies are needed to build the documentation:
>  
>  * texinfo (if building the `Infodoc documentation`_)
>  

> +* texlive-xetex (if building the `PDF documentation`_ through the *pdfdocs* target)
> +

needs one additional package recommended:

* texlive-xetex texlive-fonts-recommended (if building the `PDF
documentation`_ through the *pdfdocs* target)

>  HTML documentation
>  ------------------
>  

-E
