Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 363BAC4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 17:02:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E086A882AE;
	Fri, 26 Apr 2024 19:02:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714150967;
	bh=HE5yCUkVlK6xV85YwDLbWbaKOdAbE9vR0rX7AAcOIVw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=efxE7hNFCbWq9aCIEvJhSrGI0Nr5piNVTQFDiBxfQ2gr0aZoYjfA7lnN8DrWn6u45
	 9cjYaFqf9cEhxqkz+g08X8nWuafIH83MCJLYvd8ElCZpwRVACY/Lqbpvq3DZV6xGk0
	 +A84kqtQP2xod9zs9pOgSD49MfEkHuShAoegmPhZTcQA1oBSs9NN8hwR3f/NEtaBKS
	 e7F4hD7FkCUDM5xpycjqUr0mX5dV4ZBOIp2UM7VJI64X/kYzU6LHQoNkzkDoQKLM5o
	 ejBF/s+KzQ8USa1nPZM+ke6sQeV9xDOnwlWtP0eM8MKvPJvybpnJ9SQbRVij3P0oMD
	 TIqeRqck15soQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 90DBD882E2;
 Fri, 26 Apr 2024 19:02:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1714150965;
 bh=HE5yCUkVlK6xV85YwDLbWbaKOdAbE9vR0rX7AAcOIVw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ILMSYR99CB6PkmQhrcRJXWWZ1WDsHxTyA8fuSXWt/4ekSDsFzxYR7oFP9NFYJI5An
 eNXd6vXd9QZ8p107G1nkdowmBD+m09uLVndshR151EwLLxrysfAW1ph5WJUfjk3SqF
 ubDzg96xL9WHe9D4bXae0907/yjqEorDjG1h8wu13TktaR5gBoVbBwyVvMNQTUd5Xl
 Q0HaZkrhWUCyGj2myM0qKWqXIo00HapqSY77wKCMdrRbNdtr2AXd33UnBw1cmi6Snh
 4LYBleqKIk5C5dzyGe7MRLgjv2bMhT6kW9/EyCIzDK0/5TzCqDjSNjd7dSxDlJmH9i
 D7rKj5ytzTVdA==
Message-ID: <d2c416fe-9de9-4cbe-931a-9bff795b6801@denx.de>
Date: Fri, 26 Apr 2024 19:02:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] imx: hab: Use nxp_imx8mcst etype for i.MX8M flash.bin
 signing
To: Tom Rini <trini@konsulko.com>, Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Adam Ford <aford173@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Angus Ainslie <angus@akkea.ca>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Simon Glass
 <sjg@chromium.org>, Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Stefano Babic <sbabic@denx.de>, kernel@puri.sm, u-boot@dh-electronics.com
References: <20240425230721.497441-1-marex@denx.de>
 <20240425230721.497441-2-marex@denx.de>
 <CAJ+vNU34Zrn8znALzZqsDnkWifhVbz3D4D_hyNurKzH0cn30Lw@mail.gmail.com>
 <20240426155113.GH1054907@bill-the-cat>
 <CAJ+vNU3QHGxwLsYbNouV0x9G0qLnufDSHEUC5OLzT-zxE7dCiQ@mail.gmail.com>
 <20240426160055.GN1054907@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240426160055.GN1054907@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 4/26/24 6:00 PM, Tom Rini wrote:
> On Fri, Apr 26, 2024 at 08:56:29AM -0700, Tim Harvey wrote:
>> On Fri, Apr 26, 2024 at 8:51 AM Tom Rini <trini@konsulko.com> wrote:
>>>
>>> On Fri, Apr 26, 2024 at 08:30:23AM -0700, Tim Harvey wrote:
>>>> On Thu, Apr 25, 2024 at 4:07 PM Marek Vasut <marex@denx.de> wrote:
>>>>>
>>>>> Update documentation and use nxp_imx8mcst binman etype for signing
>>>>> of flash.bin instead of previous horrible shell scripting.
>>>>
>>>> Hi Marek,
>>>>
>>>> To be completely fair we are just replacing a shell script and
>>>> template file with a python script
>>>> (tools/binman/etype/nxp_imx8mcst.py) which also creates the template
>>>> file.
>>>>
>>>> I could care less about shell vs python but do put huge value in the
>>>> idea of making signing easier and doing so without modification of
>>>> U-Boot code. The current implementation requires a couple of things to
>>>> be enabled in defconfig which can be done with a seperate
>>>> 'out-of-tree' defconfig but this new proposed implementation requires
>>>> changing a u-boot.dtsi which is a tracked file.
>>>
>>> A counter-point is that with using binman for signing we start
>>> eliminating differences between different semiconductors on how to get
>>> something signed.
>>
>> Hi Tom,
>>
>> I agree... I'm a huge fan of binman. I just don't want to replace
>> current constructs that use env and/or config items on a clean code
>> directory with replacements that require code diffs to do the same.
>>
>> I'm simply wanting to wrap binman sections with Kconfig items. Is
>> there a way to use environment variables within binman sections (ie to
>> wrap sections or override filenames)?
> 
> I'm honestly not sure if everyone is happy just yet with how integration
> and support for production use cases of signing features is integrated
> with binman just yet.

I am sort-of on the fence with the Kconfig option, I did consider it 
before sending this patch, because we already have #ifdef ...IMX_HAB in 
that .dtsi file, but we would need new Kconfig option for this and the 
binman node is starting to be cluttered with ifdeffery.

The other option would be to add a wrapper section around both the SPL 
and FIT nodes, and for signing the type= of the section could be 
overridden to nxp_mx8mcst , that would work too, but that impact all the 
non-signing users.

So ... thoughts ?
