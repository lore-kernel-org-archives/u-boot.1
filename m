Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 962C0CCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 18:05:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1069383835;
	Fri, 17 Oct 2025 20:05:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 822E783837; Fri, 17 Oct 2025 20:05:13 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44D1D83829
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 20:05:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [98.97.25.82]) (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 68BB0B2201CA;
 Fri, 17 Oct 2025 20:05:06 +0200 (CEST)
Message-ID: <f2d63028-352f-4689-aeef-b3cc989afb8c@freeshell.de>
Date: Fri, 17 Oct 2025 11:05:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] doc: make pdfdocs: Specify texlive-xetex as a
 prerequisite
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Adriano Carvalho <adrianocarvalho.pt@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Nishanth Menon <nm@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Apurva Nandan <a-nandan@ti.com>,
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>,
 Bryan Brattlof <bb@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Peter Robinson <pbrobinson@gmail.com>, Dhruva Gole <d-gole@ti.com>,
 Minkyu Kang <mk7.kang@samsung.com>, Neha Malcom Francis <n-francis@ti.com>,
 Anshul Dalal <anshuld@ti.com>, Chintan Vankar <c-vankar@ti.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Garrett Giordano <ggiordano@phytec.com>,
 Parth Pancholi <parth.pancholi@toradex.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 open list <u-boot@lists.denx.de>
References: <20251005221057.255029-1-adrianocarvalho.pt@gmail.com>
 <20251005221057.255029-2-adrianocarvalho.pt@gmail.com>
 <263454e4-2602-4f61-9454-dae294729fa1@gmx.de>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <263454e4-2602-4f61-9454-dae294729fa1@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 10/17/25 06:57, Heinrich Schuchardt wrote:
> On 10/6/25 00:10, Adriano Carvalho wrote:
>> Dockerfile updated as well.
>>
>> If I don't apt install texlive-xetex, this is what I get with
>> docker.io/trini/u-boot-gitlab-ci-runner:jammy-20250714-25Jul2025:
>>
>> uboot@35c89b9ab70e:~/u-boot$ make pdfdocs
>>    HOSTCC  scripts/basic/fixdep
>> doc/Makefile:89: The 'xelatex' command was not found. Make sure you
>> have it installed and in PATH to produce PDF output.
>>    SKIP    Sphinx pdfdocs target.
>>
>> NOTE: This won't completely fix the pdfdocs target. See next commit(s).
>>
>> Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
>> Reviewed-by: Tom Rini <trini@konsulko.com>
>> ---
>>   doc/build/documentation.rst | 2 ++
>>   tools/docker/Dockerfile     | 1 +
>>   2 files changed, 3 insertions(+)
>>
>> diff --git a/doc/build/documentation.rst b/doc/build/documentation.rst
>> index b55a4666643..81548390d78 100644
>> --- a/doc/build/documentation.rst
>> +++ b/doc/build/documentation.rst
>> @@ -16,6 +16,8 @@ the following dependencies are needed to build the
>> documentation:
>>     * texinfo (if building the `Infodoc documentation`_)
>>   +* texlive-xetex (if building the `PDF documentation`_ through the
>> *pdfdocs* target)
>> +
>>   When submitting patches for documentation always build with
>> KDOC_WERROR=1 to
>>   treat warnings as errors.
>>   diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
>> index 5b4c75f8400..8e166eda4bc 100644
>> --- a/tools/docker/Dockerfile
>> +++ b/tools/docker/Dockerfile
>> @@ -136,6 +136,7 @@ RUN --mount=type=cache,target=/var/cache/
>> apt,sharing=locked \
>>       sudo \
>>       swig \
>>       texinfo \
>> +    texlive-xetex \
> 
> When I try to run `make pdfdocs` I see an error message
> 
>     ! LaTeX Error: File `xeCJK.sty' not found.
> 
> Why wouldn't you install package texlive-lang-cjk?
> 
> Best regards
> 
> Heinrich
> 
>>       util-linux \
>>       uuid-dev \
>>       vboot-kernel-utils \
> 

$ apt rdepends texlive-lang-cjk
texlive-lang-cjk
Reverse Depends:
  Breaks: texlive-xetex (<< 2021.20220204)
  Recommends: yatex
  Depends: texlive-lang-korean (>= 2024.20240401)
  Depends: texlive-lang-japanese (>= 2024.20240401)
  Depends: texlive-lang-chinese (>= 2024.20240401)
  Depends: texlive-lang-all (>= 2024.20240401)
  Conflicts: texlive-base (<< 2024.20240401)
  Depends: texlive-full (>= 2024.20240401)
  Suggests: sisu-complete
  Suggests: sisu-pdf

$ apt rdepends texlive-fonts-recommended
texlive-fonts-recommended
Reverse Depends:
  Breaks: texlive-base (<< 2019.20200213)
  Depends: wims
  Recommends: wiki2beamer
  Depends: tth-common
  Suggests: texstudio
  Depends: texmacs-texmf
  Depends: texlive-science (>= 2024.20240401)
  Recommends: texlive-latex-extra
  Depends: texlive-formats-extra (>= 2024.20240401)
  Recommends: texlive-fonts-extra
  Depends: texlive-full (>= 2024.20240401)
  Replaces: texlive-base (<< 2019.20200213)
  Depends: texlive (>= 2024.20240401)
  Conflicts: texlive-base (<< 2024.20240401)
  ...

Should that be texlive-full or possibly texlive-fonts-recommended ?

https://qa.debian.org/popcon.php?package=texlive-base

Package popularity by dkpg action:
texlive-base                    23153
texlive-latex-base              21623
texlive-latex-recommended       18692
texlive-fonts-recommended       17301
texlive-pictures                16209
texlive-luatex                  12072
texlive-metapost                 5498
texlive-xetex                    9345
texlive                          8392
texlive-full                     3513
texlive-fonts-recommended-doc    6340

Not texlive-full as this is much less likely to be installed. Maybe then
texlive instead of texlive-xetex.

-E
