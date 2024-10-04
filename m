Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE26CF34DD
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 01:45:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 699FD88CC7;
	Fri,  4 Oct 2024 03:45:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728006309;
	bh=JxwatPK4V6RZiHtTXFDlAYirxlxg/NW8khSjnnf+CmM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a3rvqwpgHsJiKv/R6/cgVN0ji+WoERA0tKoY5+jSft+mfHwZqSLqWenm1BMrMj8VL
	 3kGcZEnv/Y+s03NneVqoLXitZ6VcfkieOYKEWovbzHNHOOtrqVp/LGoS+vz4JqomNe
	 CD7+0M+wu7r5qxw1VqTmPq1S0LJr66QQCxGKRB3SnbDFi9fsRL4aSqeFw3AwqYGMH/
	 STXl5yMjYVo+2HhIds8I5BU5w/jT+nrZ+P38VLrnchrQ2t0B4FI4n0nBDfLfcTn3U1
	 7sfy1y63qlHpxSA6UAGsOUlfD5ZwhgCJ/p/xORHnOgGHnQOpBuP1QWlks2WA3nTu0R
	 cV/ngAVU+BEcQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 3C1938897C;
 Fri,  4 Oct 2024 03:45:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728006308;
 bh=JxwatPK4V6RZiHtTXFDlAYirxlxg/NW8khSjnnf+CmM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=LBXNv78J2lXUUKzCDcfd+UczptQxFIXIk8MUk0JZtsDnoB6owchFzY9SA+/eL6wV1
 0Fa/jOO1QiB+jaMO1lMFnBYPzVRzHvrCOlIMcYBLUT6jFdj3jbNC6a8UXivai8QmY8
 uWDs1iYy8+YpaQD2MyW+IXqlLC/QaK+JPqrY8NaFl/NUv0oBA4t7Ervt1Aw+xKgBwr
 nC2G44cJ+3zx79LFUN0vGjcsJXSw7h/TJk691dYHrMH1wE1xp4Fqa5JHvgRJypfHsT
 6G/hBHxVMgAZX/PxK6XDvYwZ5FIgHkmgWVX+K7TaENaSaBU2r07nf2nVa2QYo1PMfO
 npNigAAz0q0uw==
Message-ID: <609e203a-45cd-4155-8f0a-26f3f1e8c497@denx.de>
Date: Fri, 4 Oct 2024 02:05:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dts: Add ability to build DTOs only from
 arch/$(ARCH)/dts
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Fabio Estevam <festevam@gmail.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Lothar Rubusch <l.rubusch@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Simon Glass
 <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com,
 Jan Kiszka <jan.kiszka@siemens.com>
References: <20240927214955.394224-1-marex@denx.de>
 <20240927214955.394224-2-marex@denx.de>
 <CAFA6WYPPXDJC4kSiBAR=jL-Z0v3a8+=_=+hLx+Ug0+yu407y3Q@mail.gmail.com>
 <75eb6eb6-dd55-4509-a041-a5941286493f@denx.de>
 <CAFA6WYM8KJQkTQ6YtMC7ByKU-h1Yss9K50veWmsnni3gYsgj_w@mail.gmail.com>
 <066867d2-6d16-4ebe-9a42-8ce58d3889ec@denx.de>
 <CAFA6WYNy+XzWvMcfJqmLRfinKUPnvx7Ha42xOxF4a=izPKMr4Q@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFA6WYNy+XzWvMcfJqmLRfinKUPnvx7Ha42xOxF4a=izPKMr4Q@mail.gmail.com>
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

On 10/3/24 9:58 AM, Sumit Garg wrote:

[...]

>>> IMHO, the OF_UPSTREAM migration can wait until all the required DT
>>> sources (.dts and .dtso) are present upstream. If we start to mix and
>>> match DT sources then it is going to turn into maintainers' hardship
>>> again. However, I am still open to further convincing arguments for
>>> this.
>> With some Linux kernel architectures, it takes months to get a singular
>> patch review out of the maintainers.
> 
> Okay I see the pain but we already have that rule for .dts files for
> OF_UPSTREAM switch but having a different rule for .dtso files is
> going to make maintainability complex.

What kind of rule is that ?

If the rule for .dts files is either dts/upstream or arch/*/dts, then 
the rule for .dtso is either dts/upstream+fallback to arch/*/dts or only 
arch/*/dts .

> The Linux kernel
> sub-architecture maintainers remain the same for both .dts and .dtso
> files.

Well, yes.

>> For systems which already have DTs
>> upstream and only have DTOs left, the OF_UPSTREAM conversion and DTO
>> upstreaming can be done in parallel, hence expedite the process.
> 
> Fair enough, let's try to find a middle ground to gate the local DTOs
> behind a config to make the use of local DTOs explicit. How about
> CONFIG_OF_UPSTREAM_LOCAL_DTOS?
Do you think another Kconfig option is really necessary ? I don't mind 
adding one if you think that would make a difference, but I don't see it 
as strictly necessary.
