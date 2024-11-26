Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C96DD5A6E2
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 05:05:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EC6E89C09;
	Tue, 26 Nov 2024 06:05:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732597515;
	bh=MdRvllUmxAbWvdOeL+kYc/lfsNH/obQsASJZ18NljKU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W8AgGAs+oMbgh6lyWHYsUekvswY5qScknA4m6Hs8LCI69F5DzujLgeVLFxQQAEDIs
	 6OsdXyYM5uRWXri3w1BqRLPjVk1Ew2f7tER36ph1B9QoXXb1tiQu2Rr0uOOyJOJWPi
	 1Y5bvMVa1tUyyblYibp1Ut93mTM1wLtx4yZOEsvWnx6QPWjOUkIq40ZsJbyhxu6p1b
	 4sH4m9KlQ2fylyAVfOniVLFyFJ1hJWDjle3LbPTLnwLJefSpnWJz3Ft88g3K3cGlMh
	 lo4zYIioKzPDEZlI7ZgGfCPFNdXZMIQiTsInPKE6z6lps/uHla7sJ4jsEyvgTUZsZd
	 V2Trzwit84iEw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id B0C1089634;
 Tue, 26 Nov 2024 06:05:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732597514;
 bh=MdRvllUmxAbWvdOeL+kYc/lfsNH/obQsASJZ18NljKU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=nJHpbz/KxUzCGDK9yfSZF6Z7bIhcKtrBeGuvOTRKYapaixtgR5PPMdO+Uqo36VhTQ
 3BKvTe449g+RBIitYDXd75O/L7XGvJDv3V2MOR5wzfxFMHWipeSMpenFGwkW3Li4kG
 ehdVitqGlvPJ7+nqvbCYbksO21h6zGNNJWTtJUqPM4GMCRB5zivUCVilg8XuTLB7B8
 bHCuwv8SWkY7gDxZTuImTh16+5PvI41wIXa/fNPksevlEYUvTioxSTZKZl8YX8nf69
 T3FFn4hAbTYH6qY8ILQTuzqJn/Zj+6NWoInKF7y7v0H/SBKd8HfKgLOIi1swhMEKYo
 BWm2KMKI3UnXg==
Message-ID: <e05dffcd-ab63-4276-9234-b7bf3913ea18@denx.de>
Date: Tue, 26 Nov 2024 01:40:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] build: Respect CONFIG_SPL_BUILD in DT sources
To: Simon Glass <sjg@chromium.org>, Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Bryan Brattlof <bb@ti.com>, Fabio Estevam <festevam@gmail.com>,
 Greg Malysa <greg.malysa@timesys.com>, Ian Roberts
 <ian.roberts@timesys.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Stefano Babic
 <sbabic@denx.de>, Sumit Garg <sumit.garg@linaro.org>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
References: <20241122015858.557561-1-marex@denx.de>
 <20241122015858.557561-2-marex@denx.de>
 <CAFLszTjJWrrxbeqr1hRnMsaJyTGLWx2-mY1LKQ4NMkkHHjxYQQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFLszTjJWrrxbeqr1hRnMsaJyTGLWx2-mY1LKQ4NMkkHHjxYQQ@mail.gmail.com>
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

On 11/26/24 1:32 AM, Simon Glass wrote:
> Hi Marek,
> 
> On Thu, 21 Nov 2024 at 18:59, Marek Vasut <marex@denx.de> wrote:
>>
>> Currently the U-Boot SPL build uses the same DTBs that were generated
>> during U-Boot proper build, and calls 'fdtgrep' on those DTBs to filter
>> out uninteresting nodes and properties. Those U-Boot proper DTBs are
>> built from DTS which are first preprocessed by CPP, but that CPP is
>> invoked in U-Boot proper build context and effectively ignores the
>> CONFIG_SPL_BUILD macro. In case the CONFIG_SPL_BUILD macro is used
>> in any .dts file, the content of the macro is removed by CPP.
>>
>> Fix this by building a separate set of DTBs for the SPL, which are
>> preprocessed by CPP with -DCONFIG_SPL_BUILD set. Use the same way
>> for the other PLs.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
>> Cc: Bryan Brattlof <bb@ti.com>
>> Cc: Fabio Estevam <festevam@gmail.com>
>> Cc: Greg Malysa <greg.malysa@timesys.com>
>> Cc: Ian Roberts <ian.roberts@timesys.com>
>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> Cc: Jonathan Humphreys <j-humphreys@ti.com>
>> Cc: Masahisa Kojima <kojima.masahisa@socionext.com>
>> Cc: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
>> Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Stefano Babic <sbabic@denx.de>
>> Cc: Sumit Garg <sumit.garg@linaro.org>
>> Cc: Tim Harvey <tharvey@gateworks.com>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@lists.denx.de
>> ---
>> NOTE: For v2025.04
>> ---
>>   dts/Makefile         |  5 ++++-
>>   scripts/Makefile.lib | 11 +++++++++++
>>   scripts/Makefile.xpl |  7 ++++++-
>>   3 files changed, 21 insertions(+), 2 deletions(-)
> 
> As mentioned on the other patch, this should be handled in fdtgrep
Adam already replied to you regarding this part in 3/4 , please continue 
the discussion there.
