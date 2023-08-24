Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD05C7EE43
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 15:26:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50D648669C;
	Thu, 24 Aug 2023 17:26:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1692890766;
	bh=6s8cWWlyfIBhZUO7513pV36nguCNywdgdGXhyMqgxXA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ogrBOxeKk/0dGiY1GnoIRa8ebf9SzFF8Ir2X5gbrB6vMK1oYe1j6VvYMLXVqjg++7
	 dn3uBNgT92qgx6ZJWxVqaBkKErZ9zytGTVk1SU58/D3ZMwMmrDY1+h7KedIGoGpI2p
	 nQoQiANIqVa6D1fN0nGt1q58Wd5pIpA002dozYIxpVTU6xj1jHeY/POCl+YjywI3+8
	 8aaMwoOAJTv56hFF3t6clXay/yBTXmV17+5Vj8WXSQTtDiUz4+5TO9SIDtC8cbVKhP
	 niFz/XJkhtFa7Ezk7UUfrfFUsifUefpORoMDh9cvQFPaJNdHYQ7xHpWv2SKegheJ5v
	 76qUeqaQAzpVg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id B2DCA8468A;
 Thu, 24 Aug 2023 17:26:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1692890764;
 bh=6s8cWWlyfIBhZUO7513pV36nguCNywdgdGXhyMqgxXA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ykmJrSYvLUKm5nDRAa1pQWgahGGrw2MLsNrDBN1E/zAPpSziqgg+xL5UoFXmJVa4p
 TuZ2NrV6PHY1kUo+hjsrOcrvjNmCnMbHnlM/ObHiRQSiZVe+ODsS/6TfLZRhxEDa9N
 i7X7pAZ27DjpghoAF/RAZ/NbC69yRvQirWc6MJ6SHRVQoNVOkd6psUXOyIpI+mxA1m
 aveFbz6QtLAea35pnd3FAQhvWrg36TLPr3K1cKETtvahM3WOV9luQ8LA89MQjx/D6m
 ujDgx6b0MVjDIHfw32iuWEqgf3yUCKrtKVacnHyCc0KHjhWsLZMXNTVDVDtf6foKvP
 rBiJ8UpSUGVCg==
Message-ID: <7fc90036-0be8-6567-fb3b-b97fa7643180@denx.de>
Date: Thu, 24 Aug 2023 17:26:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 6/6] stm32mp15: Use u-boot-spl-stm32.bin instead of
 u-boot-spl.stm32
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List
 <u-boot@lists.denx.de>, Dillon Min <dillon.minfei@gmail.com>,
 Kamil Lulko <kamil.lulko@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Vikas Manocha <vikas.manocha@st.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20230824030304.1555547-1-sjg@chromium.org>
 <20230824030304.1555547-7-sjg@chromium.org>
 <3ab486b0-be22-48b9-7417-742ed8360f0f@denx.de>
 <20230824142505.GM3953269@bill-the-cat>
 <4cbffed6-6a07-1a56-bf10-7303e2aff78b@denx.de>
 <20230824151419.GU3953269@bill-the-cat>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20230824151419.GU3953269@bill-the-cat>
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

On 8/24/23 17:14, Tom Rini wrote:
> On Thu, Aug 24, 2023 at 05:09:07PM +0200, Marek Vasut wrote:
>> On 8/24/23 16:25, Tom Rini wrote:
>>> On Thu, Aug 24, 2023 at 05:12:45AM +0200, Marek Vasut wrote:
>>>> On 8/24/23 05:02, Simon Glass wrote:
>>>>> A '.stm32' extension is not allowed anymore, so change it.
>>>>
>>>> Why?
>>>>
>>>> This will likely break a huge amount of scripts, I'm tempted to NAK it
>>>> unless there is a very good reason.
>>>
>>> This is in the cover letter.  Today, buildman --keep-outputs doesn't
>>> actually keep the needed for booting outputs from a build for a number
>>> of platforms.  Simon's response is to stop having a free-form list of
>>> outputs. With I guess the caveat being ROM-defined names (for example,
>>> we still keep "MLO" because that is the literal filename TI ROM looks
>>> for on FAT partitions, on mos of their 32bit platforms).
>>
>> Why not just place the free-form files into some output/ directory and be
>> done with it ? Then they can have whatever extension they want, as long as
>> the output/ directory name is stable.
> 
> Yes, an alternative here is to just extend the list that's removed in
> patch 2/6.

I ... am not on CC of that patch ...

It would be really good if Simon CCed everyone involved on all the patches.
