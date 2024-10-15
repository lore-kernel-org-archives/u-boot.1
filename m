Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2176D20682
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 23:30:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CC1888995;
	Wed, 16 Oct 2024 01:30:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729035021;
	bh=vslqs3vYEmcd3tB4op0RofMwhoj6zjj8XAtbxv39vv8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YTVE3q9bvr04wmPkNd7+9+ljtTVIZlyHmA0nEXzyzmQNtJ9ioUf0R92UlGOHKanEo
	 pI54vYOl9572ppX9hOrJ74vncitYZCVa5Yrx3zeHc3dCmp5+j1m3/Y5qzjIKocaMNt
	 rxdzJLLBdAH4swODFrJJ2DzaZa8uMT34Ja0Q6Yqp5pgJI/km8Gk4BvAZbLTcl5i7oa
	 TB722Hd/h9+Pm9k874K93EdChGazqac934jtrJTHpNoM6F+91NmUkxDW84MVa3sKvM
	 DQfBVTfwM+T4wM1rW3vhpk+N31HRNqUtGHjbacwvaNbJLFfMg2YIOiy5P1K1ixeGii
	 3Rm2ByTx02ArA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id BFA8D88216;
 Wed, 16 Oct 2024 01:30:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729035019;
 bh=vslqs3vYEmcd3tB4op0RofMwhoj6zjj8XAtbxv39vv8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=fV7QUj9WasW1lcVaA9huFkr+IMJCS/aqFqis8UKIHgv9SCWL8SbphXvd24XHp+EKf
 3R4dpk7MCqFR4aezWWyTXHjmWlgkCez7McD8rejAVUnzEZfmVaF4OrNdpN4taunwSr
 kCsUyrRkkCTY2rfUsWmVCG/cg1wb7ayIFDfkd2q690FkQjIIaPPig+nVrh63ah9slF
 1vwOP67nNPW630GVkvXfjOjBAHJR31R5FRIcpWdsUPToM2d/664VkGZcBi9jFPM4im
 e3WenmOcwlsO6i64Wa7JxeIyXFrBuK8hON+h1a6+cV1mw4exenP31sN3IDy5LPPVsA
 jIxKtfDvf8YdQ==
Message-ID: <13639f31-5ef4-49d7-a695-9cc064ef2371@denx.de>
Date: Wed, 16 Oct 2024 01:27:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Makefile: Drop SPL_FIT_SOURCE support
To: Tom Rini <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20241004230756.371153-1-marex@denx.de>
 <172902143755.5381.3133865412226742988.b4-ty@konsulko.com>
 <8cfc2a0f-dfef-4528-95fa-298bfc701ac7@kwiboo.se>
 <20241015225241.GA6412@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241015225241.GA6412@bill-the-cat>
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

On 10/16/24 12:52 AM, Tom Rini wrote:
> On Tue, Oct 15, 2024 at 10:48:12PM +0200, Jonas Karlman wrote:
>> On 2024-10-15 21:43, Tom Rini wrote:
>>> On Sat, 05 Oct 2024 01:07:13 +0200, Marek Vasut wrote:
>>>
>>>> The SPL_FIT_SOURCE is long superseded by SPL_FIT_GENERATOR which
>>>> is long superseded by binman, drop SPL_FIT_SOURCE support as there
>>>> are no more users.
>>>>
>>>>
>>>
>>> Applied to u-boot/master, thanks!
>>>
>>
>> Look like 5b9261fb0b1e ("Makefile: Drop SPL_FIT_GENERATOR support") may
>> have broken ARCH_ZYNQMP, it still seem to use a mkimage_fit_atf.sh and
>> CI pipeline now fails:
>>
>> https://source.denx.de/u-boot/u-boot/-/pipelines/22715
> 
> Sigh, thanks.
And yes, I missed that, sorry.

Do you want a revert for 2/2 ?
