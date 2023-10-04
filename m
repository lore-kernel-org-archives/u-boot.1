Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F58E7B611
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 13:40:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40B2A8755F;
	Wed,  4 Oct 2023 15:40:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1696426829;
	bh=f/ho20R+zJkwob6g1NoGDM0JrlB5+6K3yUpxDAB5/WI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dQttJSLbWP7LKfK250mWl7L3g3U6rN23Qx5eo48mxo+QIn6jTTP/+jWzuZDH1POzK
	 ftGuQjBGWedMOJzXzyvBILNpnYqeX2rWsYyUyD8bymGEIYQxW9ZCO7gn8+0mj5O1F/
	 wRqr+ZBZ7+UvwPKnLZHi0vuxTLhBY/Nb1YPXLvNEuoZPHJ2OSppaceaEzkSjAypYm3
	 Szv7ge6PwvHHUeGZo+Mrzjv8LupmzMx7uuzVsXyORypuOir+yOl1tCus+dmBWQq4/3
	 gKqwoHxPqtTTg4KWwJnaV1gBnPtCIIgjnM71rXe1hVQXijOmo4K1ElYjQeRrj9nxcT
	 gh6JAYmhXyr0A==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 03C0C8755B;
 Wed,  4 Oct 2023 15:40:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1696426828;
 bh=f/ho20R+zJkwob6g1NoGDM0JrlB5+6K3yUpxDAB5/WI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=qAk4L2uZmCxoZ9NjyNkh6s4Ks6eTY4Xl3mOeoAzTuqpgkl12o864nSIx2RfSC1gu2
 Du3fgJAmnOfzEEvccs+GsG7zOoSd+h1Rk69lX0EQ23JDKsfgzLVg539tu3OmAHEZev
 EEa91w5cnDhaHup6hyGd4makmjxARe7MA2ytzfAUm9xz90oO/RX+cWgRlO+sfkHhVn
 /QFJZtGoa13pHt9htQT3xTuswaw7GDUfENXw7kvsfEDzS66THwXto8TUD5VOYgHXCe
 50JUlED+oWn3UDqvKZhC/Dl6R/bQWAI7xDkiZ+FxwjPsT9y8ZnUP+x5fyb+pI4NvPE
 R5l9hpv4H98IQ==
Message-ID: <721b2c30-483f-49d2-992d-eeb3971f4566@denx.de>
Date: Wed, 4 Oct 2023 15:40:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] board: dh_stm32mp1: Only print board code with
 CONFIG_SPL_DISPLAY_PRINT
Content-Language: en-US
To: Patrice CHOTARD <patrice.chotard@foss.st.com>, Harald Seiler
 <hws@denx.de>, u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com, u-boot@dh-electronics.com,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
References: <20230927124625.247858-1-hws@denx.de>
 <7943bfcb-204d-526d-9208-fd38fbc567b4@denx.de>
 <756093f5-d3da-eeae-9619-763e48d297cc@foss.st.com>
 <6334910c-baf3-4e6a-81b0-784f3dd372f6@denx.de>
 <3cba2f3a-918f-2831-ffbe-e05fe3ccb4f8@foss.st.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <3cba2f3a-918f-2831-ffbe-e05fe3ccb4f8@foss.st.com>
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

On 10/4/23 15:39, Patrice CHOTARD wrote:
> 
> 
> On 10/4/23 13:41, Marek Vasut wrote:
>> On 10/4/23 11:19, Patrice CHOTARD wrote:
>>>
>>>
>>> On 9/30/23 23:02, Marek Vasut wrote:
>>>> On 9/27/23 14:46, Harald Seiler wrote:
>>>>> Ensure that the SoM and board code information is only printed when
>>>>> CONFIG_SPL_DISPLAY_PRINT is set.
>>>>>
>>>>> Signed-off-by: Harald Seiler <hws@denx.de>
>>>>
>>>> Reviewed-by: Marek Vasut <marex@denx.de>
>>>
>>>
>>> Apply on stm32/next
>>
>> This all should be on master, since we're way before 2024.01-rc1 now , 2023.10 was just released on Monday.
> 
> Hi Marek
> 
> Yes it was my intention, thanks for checking ;-)

You're welcome.
