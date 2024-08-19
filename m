Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B632C52D6F
	for <u-boot@archiver.kernel.org>; Mon, 19 Aug 2024 17:27:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16EC288D09;
	Mon, 19 Aug 2024 19:27:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724088455;
	bh=+gjvXxqPbLtVEG2pUK74CyMOgOiUPVrve6ZPDJxlDQQ=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ThbvBjE+WHefdQZRvm115bpIW6HhC2MZZGpzuusvZwrUArUU4v1I+uYNWfVeHUAmc
	 gX9F4xo2h3qMNVebvlrPkerDVbe7E1sD6QEdu+x6t9+TEy+uauTOz0/llr/kYcod8V
	 04FTI0Q1W8GBTDVASoWjSFYdM9BdY7JQO0OyEVFHBNNejn1jz8UjDJfJu0CRD5qPqi
	 pnP8vPn+Rv9PP+82/1N4lcRKQKF1HjaiYxgPdhnDKBvp7M7DYaX2o5qNHLi/BEMDyf
	 3Lht1xcFcLZkdS5MhmNyHk3c2E6rw2eshWMfEAWlOoFNc7HppQI95sKRyGvUHj+bjk
	 D+GOnTYXMgW0g==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id AB91D88D08;
 Mon, 19 Aug 2024 19:27:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1724088452;
 bh=+gjvXxqPbLtVEG2pUK74CyMOgOiUPVrve6ZPDJxlDQQ=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
 b=Z+o3xypKoAXKrq2rxJ17Docb2lc+I6l72c/06Wm9OCtDcssggZVcsdeKX3MLIQFUf
 pDQfdiWpO+LYQL6qo9OVSFRzRPcc80FpUrLxI8rZEaUvvjxo0RnW8ToXvoJHh6Ddka
 fLg9N1F3QmbfNTnnYFkBoKTUDJNqoc3w3LoD4qtGIPbzfUc2oRZpQL9sN6ZSemnMOo
 +uImPjU4i/z6HbEJOTN8qjkSenvAPlt6GlXU75gf3EngJUsVI39iJKrrY7wY7e1Odb
 kY7p9sjABggV8hqHaEOIpc8NK1j1QpKrYPCT6UhdDOlbneG1hLpLDRpKEO0vCkD+xI
 K0g98fC9ShBPg==
Message-ID: <45c74c58-98cf-43df-b837-c48b0341c551@denx.de>
Date: Mon, 19 Aug 2024 19:09:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] power: regulator: Trigger probe of regulators which
 are always-on or boot-on
From: Marek Vasut <marex@denx.de>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, uboot-stm32@st-md-mailman.stormreply.com
References: <20240626235717.272219-1-marex@denx.de>
 <a73dffe5-87e3-4e96-965f-9d029f2af8ed@denx.de>
 <CAPVz0n0C6TPdBRUEvJmgAUGAKoetuzr1j=0cMXweP2EqMTwn=g@mail.gmail.com>
 <0910419d-e8ab-4bf9-a083-dc2783afaca1@denx.de>
 <4D07A6E5-F156-44C3-A26D-0F2D913CE92D@gmail.com>
 <18d84528-d2e5-41d6-ae1d-109ee30853b2@denx.de>
 <CAPVz0n2Jzfih0Z85TSQbnz-8OrX4D6UN=anKGTJ=hckRt8f3xA@mail.gmail.com>
 <a95f0d60-2883-4c3d-8a53-ee3ef414cc32@denx.de>
 <CAPVz0n3Ji1sKQK+Lnq8rP3ZqwX3o-kXe2btj93UuVBa3T5C=qw@mail.gmail.com>
 <eced1020-2157-44a4-98a9-845e218529d9@denx.de>
Content-Language: en-US
In-Reply-To: <eced1020-2157-44a4-98a9-845e218529d9@denx.de>
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

On 8/1/24 2:28 AM, Marek Vasut wrote:
> On 7/29/24 1:55 PM, Svyatoslav Ryhel wrote:
> 
> [...]
> 
>>>>> What is the problem you observe on tegra 3 ?
>>>> i2c line fails since it probes in spl with your patch, but it does not
>>>> relocate and then probes once more after relocation. Probe fails along
>>>> with all devices on same line.
>>>
>>> Could it be that you either have to:
>>> - Add DM_I2C to tegra 3 SPL
>>> - Remove bootph-* from DT to remove the regulator node from SPL
>>> - /delete-property/ regulator-always-on; and /delete-property/
>>> regulator-boot-on; in -u-boot.dtsi to prevent the regulator from being
>>> enabled in SPL ?
>>>
>> Obviously NO, you propose nonsense. Same dts is used for both stages.
> 
> DT source yes, DT blob likely no.
> 
>> And I have to add hack-ish stuff just because you wanna introduce code
>> which causes known regressions.
> 
> I am trying to understand what problem there is on tegra 3, but it is 
> still not clear to me.
> 
> Is the problem somehow related to PMICs (?) being probed in SPL (?) 
> because they have regulators (?) which are marked as regulator-always-on 
> ? If so, then this is correct behavior, and if this is not desired in 
> SPL, then you can remove this property from SPL DT in -u-boot.dtsi using 
> /delete-property/ .
> 
> [...]
> 
>> "We must not probe things as we go. There might be other
>> dependencies not yet bound. It may also take some time. This is not
>> following driver model design, sorry.
>>
>> So please think of a way to do this properly."
> 
> What is this quote about ? Where is this from ?

What is the problem with Tegra 3 and this patchset ?

Can you please explain that so this patchset can move forward ?

Thank you
