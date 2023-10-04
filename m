Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1151BE7B5FA
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 11:41:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 788398751A;
	Wed,  4 Oct 2023 13:41:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1696419692;
	bh=9WXTuMY1i00rT+7DRvvoiiWPXdMjPkUBrK4GTBxM64U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tIC3lr7XNM0QhxG2DtbWOnjbRd6Ke9mmg6UHWPtU4g37PuSB9wtn/xm7YhcHlwRNg
	 VnGiXB5PiJsKVv592WCZtyuP3kvBwi8+1wjUe+C51oECvzJ1Fqt5AKyqiCdAxTNKge
	 Nha1o6RgkbFyNWpOjm7jgatHYhwDFKLb/CLXKnkCUkpkYP/X/jTrGLayPxThKH4cG2
	 Lux+FsAgSPgP4eSZrFRcRMip2WZkIou6UMiY0zGmxDYgpwezwnLClhDgVGf+11szrp
	 x7QtUUqXBCJk529jfECGIEF+Rsef1jmCoy37mCIcpf5qEiPqIKLtu/TTdxMhnNy9kG
	 FfgMuD+WlUpmQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 11BA5874FB;
 Wed,  4 Oct 2023 13:41:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1696419690;
 bh=9WXTuMY1i00rT+7DRvvoiiWPXdMjPkUBrK4GTBxM64U=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=YkLDyhSVqC1GqgECqx42tRTQ/tlU2fXPMrpHKKso0ck812laky30MH9TySd80c/kA
 MGcrkgjjFg1b40pcScRP7yHYX1VmbLNR4KhigGCaynbSLfibUQnEG93C0aJDvng7Hd
 X2RwDvbNJO4g8j8WCTvOZokRWjHCMg4uc0O7UtAt3O7SyjYDCFWzBhwLDpMXZHRsqy
 oGclJp3u8e1H36yGeVz5+z//o/gB4t0HGhYQrBNimW1NafFuR0tN/V+IovxGIXqKH7
 mLf0d2S/U1BeQgQXwZzBLqCBkes6XPTa/m766uUuuoP+mWmDTXMcApTQVvFvLhwK8X
 1SRBa4EMHp9Gg==
Message-ID: <6334910c-baf3-4e6a-81b0-784f3dd372f6@denx.de>
Date: Wed, 4 Oct 2023 13:41:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] board: dh_stm32mp1: Only print board code with
 CONFIG_SPL_DISPLAY_PRINT
To: Patrice CHOTARD <patrice.chotard@foss.st.com>, Harald Seiler
 <hws@denx.de>, u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com, u-boot@dh-electronics.com,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
References: <20230927124625.247858-1-hws@denx.de>
 <7943bfcb-204d-526d-9208-fd38fbc567b4@denx.de>
 <756093f5-d3da-eeae-9619-763e48d297cc@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <756093f5-d3da-eeae-9619-763e48d297cc@foss.st.com>
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

On 10/4/23 11:19, Patrice CHOTARD wrote:
> 
> 
> On 9/30/23 23:02, Marek Vasut wrote:
>> On 9/27/23 14:46, Harald Seiler wrote:
>>> Ensure that the SoM and board code information is only printed when
>>> CONFIG_SPL_DISPLAY_PRINT is set.
>>>
>>> Signed-off-by: Harald Seiler <hws@denx.de>
>>
>> Reviewed-by: Marek Vasut <marex@denx.de>
> 
> 
> Apply on stm32/next

This all should be on master, since we're way before 2024.01-rc1 now , 
2023.10 was just released on Monday.
