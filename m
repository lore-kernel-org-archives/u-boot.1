Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6843FD10BEB
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 04:19:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3E5A88E74;
	Sat, 26 Oct 2024 06:19:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729916362;
	bh=ECoGkhpL92ejMDem5kf7UfduH488YsQ6Zeu11ARZ4VY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GtrjMGZ509dN0fq/b11gt/oror8ftYEqDChOpcMVnzjNnvzvXl/q5vlQzHiV8XI/K
	 zSKjfitQEYtX0aUcc5zwmi+RV3GmSKfZABKqA2j2k+gEmwz8lBKfH+S42743ncphmN
	 OKok/zZOo5AVGuiOR0RIK0hRHD3ZAhvw+z3ZEkjKiJN0hHsRZGSfvOAY2i7/2X6/KC
	 bwEq/8v/2tRQIWmPdgH8SbBv8OK+Cv3HZ8BKLFkvIZbDJ6vd02TfxWLTWyvZIy0D4m
	 /fyomwsW/zXQe4G2yG5lrQHyEhcTZpVdHEz2RMpI5uhRwQgfYVDnmR/EMSVts3pIoa
	 l98YQhrtr9+pw==
Received: from [127.0.0.1] (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id AB2B188DF1;
 Sat, 26 Oct 2024 06:19:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729916362;
 bh=ECoGkhpL92ejMDem5kf7UfduH488YsQ6Zeu11ARZ4VY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Jd9/IXNM97uoZqUHVc3/PAHVsjqiZp7ukZhj8gDPkDVNnuAvfvSX2G2Pk+OVKaDet
 Gi066syWOBWZoWKlwAIg5+ov1bRFUjGSjGKpYuRcOhNWASdi6v9BuUNqqzaVo4dUXD
 eEY/kakOgIeXFauU/PN6umZJtTC90boAnLthnwE6F6s7m5GZsGAgl+Zlg3LXMGhe3x
 Nq35aHFhT+fnOJFquFGHW+yOKh35DoNlMRJGG1uPP/JIrXIFgCwGEHEtA85uIVrZQe
 O2AmWlmcnnY0OB3PPUSCMyEhbk8Ah/Vlr9u2J2j3Rx/vo02GMs9/WQ2BMhRD10RjWU
 yf2IuCzwsz6jQ==
Message-ID: <31a9d878-9f1a-48a2-abae-a59031596b9c@denx.de>
Date: Sat, 26 Oct 2024 01:00:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] arm64: imx: Deduplicate DH i.MX8MP DHSOM defconfigs
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, Andreas Geisreiter <ageisreiter@dh-electronics.de>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Sean Anderson
 <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com
References: <20241019220322.341324-1-marex@denx.de>
 <20241019220322.341324-4-marex@denx.de>
 <CAOMZO5A9AGG_X=ztxMZWJvVH4yV63RvCm0KdugpUCpqoXcxXfw@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAOMZO5A9AGG_X=ztxMZWJvVH4yV63RvCm0KdugpUCpqoXcxXfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 10/25/24 1:26 PM, Fabio Estevam wrote:

Hello Fabio,

>> Deduplicate defconfigs for all DH i.MX8MP DHSOM by factoring out the
>> common parts into generic _dhsom_defconfig and including those using
>> the #include <configs/...> preprocessor macro, which is applicable to
>> defconfigs as well. This enables CMD_EXPORTENV on all iMX8MP DHSOM
>> systems to be consistent with other DHSOM systems.
> ....
> 
>>   create mode 100644 configs/dhsom_defconfig
>>   create mode 100644 configs/imx8mp_dhsom_defconfig
>>   create mode 100644 configs/imx_dhsom_defconfig
> 
> CI complains about this:
> 
> $ ./tools/buildman/buildman --maintainer-check
> fatal: detected dubious ownership in repository at
> '/builds/u-boot/custodians/u-boot-imx'
> To add an exception for this directory, call:
> git config --global --add safe.directory /builds/u-boot/custodians/u-boot-imx
> WARNING: no maintainers for 'dhsom'
> WARNING: no maintainers for 'imx_dhsom'
> 
> Please fix and resend.

V2 is out, should build now:
https://source.denx.de/u-boot/custodians/u-boot-usb/-/pipelines/22987

Thanks
