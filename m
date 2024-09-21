Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE712CF9C69
	for <u-boot@archiver.kernel.org>; Sat, 21 Sep 2024 14:05:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 715C388AB6;
	Sat, 21 Sep 2024 16:05:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1726927521;
	bh=xinp1MRNE19TsAPbDIheN7bo0VwvxsRAHWpF2DxuUyU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wJ26DODqOhUGpq+iy4N6VZesG0JL+3mT3GEF1RaKWVky6kCb6trqXHRenGkxi4Stw
	 28iQRsfAsfBniNDMC0x4N4C/BNE58m4BTdUmRlTF+0+OQgbktK80ZT6Bb3xdmzmg6M
	 nJp7fnT7itw484gX0T60QurQ36OqEsgw3xS6h7qVkawRwTgWskhV6pt5VHFEOstswu
	 Xv3OkztV9PjPiD7kjP8IFAkHEz9RAxy3QyGjg0GmaH/pXRVGhMEIdVKKv5Kuw2FC8W
	 pb4maojzqsh++4XS4ENpUzRKUl4HFRye3i6fynUzsm7BNgGd+BdVwKn2lUZA+onl8W
	 sLxuPsO/MJZ5g==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 5049C889DA;
 Sat, 21 Sep 2024 16:05:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1726927518;
 bh=xinp1MRNE19TsAPbDIheN7bo0VwvxsRAHWpF2DxuUyU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=zrm08ZOD7Yf2FqvEQwuxNg5/+xxRNwJcobgLY6aX+EdXFTfPTKLB47x0OY1KidJOS
 ZClqItGsJJMFZDt/1Hk6OQf6Z5kDrthOvtA+ineJ6i+Wa7SER5rKgIyGszV9A/QWM3
 8vPPuauR1p2O6c7LSXpau3xx+kEZlYN6fq9PhOwsewdAqm+T1HAadZIrzl4GYCnqfT
 ZfbTgdUehUVYUTjM5yGSljzJQXH0B5ZtVKPuLGCTlvFxEpG7ZqEPNWpLkE2JxsoWVX
 Zrg5+ZT+EjueFz6z9ucuh1o7gKT0bHjKjBjWOAwgE94HIXirmFk8xy67CHIvLQZ+uo
 6h9pcmRjzDjYQ==
Message-ID: <a7abc927-57ff-4b0b-b636-d51dddca288c@denx.de>
Date: Sat, 21 Sep 2024 15:47:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/20] arm: socfpga: Add support for agilex5 clock
 manager
To: tien.fong.chee@intel.com, u-boot@lists.denx.de
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Meng Tingting <tingting.meng@intel.com>,
 Yuslaimi Alif Zakuan <alif.zakuan.yuslaimi@intel.com>,
 Hea Kok Kiang <kok.kiang.hea@intel.com>
References: <20240920070242.20884-1-tien.fong.chee@intel.com>
 <20240920070242.20884-3-tien.fong.chee@intel.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240920070242.20884-3-tien.fong.chee@intel.com>
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

On 9/20/24 9:02 AM, tien.fong.chee@intel.com wrote:
> From: Tien Fong Chee <tien.fong.chee@intel.com>
> 
> Adding mechanism to retrieve base address for Agilex5 Clock Mananger.
> 
> Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>
Can this be turned into clock driver and probe from DT ?
