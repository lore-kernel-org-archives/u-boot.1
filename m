Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22F6C3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 15:09:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00F4A865B1;
	Thu, 24 Aug 2023 17:09:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1692889750;
	bh=6bw4xDTI8hp843s6rDfFkJ1FrKpjdalK6wFvqYTQhT0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z3P5VbrGNYY4pAQsoSHL7HqmERCEtXSpVAK7ZgJ6v1Ik5TczI3vVH+wdeQ9J4ppXS
	 Laq2fcEdmXgmYXhyvPpkVNvsKU5w1Tg/8j3H7WnxUTSfNntYe1JeKnvNw+gN50UF7I
	 dyvqAYoBe8tzockQACSHU0izqi5NDJOpAkG2sTam2dL3hh9sa9ioYNvW2saP+5fykM
	 zkw4J9FjoG6bFf2g8DULNzZ0LT1ipcG2X//DipAPm6KAmuyogXdYn5ORdpx+lToQhX
	 wciQMIy3ncHCUfktrOydPx+DW2MTOd1tiDF0J+Oo6YgyfL13PZMRGsIV4QA8C3SfcD
	 X1AynXSf+2fCA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 252F18056D;
 Thu, 24 Aug 2023 17:09:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1692889748;
 bh=6bw4xDTI8hp843s6rDfFkJ1FrKpjdalK6wFvqYTQhT0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=UozXzCptW/CfGc0ixrH47zZTRPvjxsCWPiQbmEOqbVxRjMnFiOT5w/cQjd5DckCPx
 mTYOAcW61RziHmhouO3HNrLzvNkIDRFYeKnefI2yNUOmvkX1Z6vQar9WTA5M/oTBHe
 RuhdpSwnvxJ5DGehWUn66d+Z/F8rayjNa17R/t59TYZsHh7ziJHGu6vYHuTJKpvIcT
 BoE92IqgFBI3B0i9zVABoBOhK2JfEN2jwEl/sF21Q9CGuAS/AK8SVsMd+IJcNZT65f
 0GFibSsQVEtlqK9BNsxFr/D5pIoLgLgN7Jz4WYKl4SU6fHXmxTj/S06TXh+qd9+xG/
 sG3JaOm3Rs14g==
Message-ID: <4cbffed6-6a07-1a56-bf10-7303e2aff78b@denx.de>
Date: Thu, 24 Aug 2023 17:09:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 6/6] stm32mp15: Use u-boot-spl-stm32.bin instead of
 u-boot-spl.stm32
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
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20230824142505.GM3953269@bill-the-cat>
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

On 8/24/23 16:25, Tom Rini wrote:
> On Thu, Aug 24, 2023 at 05:12:45AM +0200, Marek Vasut wrote:
>> On 8/24/23 05:02, Simon Glass wrote:
>>> A '.stm32' extension is not allowed anymore, so change it.
>>
>> Why?
>>
>> This will likely break a huge amount of scripts, I'm tempted to NAK it
>> unless there is a very good reason.
> 
> This is in the cover letter.  Today, buildman --keep-outputs doesn't
> actually keep the needed for booting outputs from a build for a number
> of platforms.  Simon's response is to stop having a free-form list of
> outputs. With I guess the caveat being ROM-defined names (for example,
> we still keep "MLO" because that is the literal filename TI ROM looks
> for on FAT partitions, on mos of their 32bit platforms).

Why not just place the free-form files into some output/ directory and 
be done with it ? Then they can have whatever extension they want, as 
long as the output/ directory name is stable.
