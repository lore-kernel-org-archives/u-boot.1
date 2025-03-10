Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D60C282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 23:33:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25809807D9;
	Tue, 11 Mar 2025 00:33:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1741649628;
	bh=wjKCL8MKt/Gc9O/6Gcr1An1vryYDDJXg3/tSnvlL2YE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BdvPEphjOU7mZ4IOzs6StEjyKmM3PUx2/wpW0QBezExRAoXmyVRZOkuIRpfAhS9Ev
	 FIRK/oZ9zv7mo8T9OC9hSUS4R4gRGJpdnbjYTnQoDwVFy7WQ6fePyfPJWGaTp5kulj
	 KyOJ+u1R32gbbCcesvTcj7HZjt7sSplqCK1uX60P5OKxalx+uDH8EJTatAHJ2jiVUM
	 w88PbMxCiEinRJmTVLXasIkgoDo8FLJCx/G2e1tOFtAOmQgJSJSJFe4dlTtk6xrugk
	 f0PXnLt8ihmo4yNftHTjP/WzQKYMN+B8vziGyV5DhoSLuRxdKgGv+e3sUL1AkLLmpQ
	 hbhPagInO+sSA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 748AB811C1; Tue, 11 Mar 2025 00:33:47 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E1B1806D8
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 00:33:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="GMcu+jv6"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EFC41102A4CBA; Tue, 11 Mar 2025 00:33:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1741649624; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=wjKCL8MKt/Gc9O/6Gcr1An1vryYDDJXg3/tSnvlL2YE=;
 b=GMcu+jv6SE+vVDsxcZIW9J3dDzOoZkRXtMn0k/6ZOr8cyV121Qgyfy2OJv1+ilDvo6NQI6
 LPNXCewQ32FfMr/Mqk/TtZ49fsILDL3lBjLA/Wl47kNFqVVeAR4QnF0BId72T5y9A4AxSa
 mRkeZfxMSDQVXDWCUr6kwHU4J5JqGx4qak+Pf6mcjF9JChvGp8T7nEMwMhWS7u1rzQ1AYt
 dU6sIMD6PLBFRDGgJvrW4ysbcFvkxULRScDvjIOU1E4YPWJQYQ481W80u2YjRnqHz46q3a
 5xwiTDi2SvJnfswzpTdR2tp6xWB4cChL13IEWVd3yHoO4R8Itu8DM3U6SQHbZg==
Message-ID: <48ca36cd-39a7-4a8a-97c0-81cbda3f4697@denx.de>
Date: Tue, 11 Mar 2025 00:19:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/12] pytest: requirements.txt: Include setuptools
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Baruch Siach <baruch@tkos.co.il>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
References: <20250308201533.1315951-1-marex@denx.de>
 <20250308201533.1315951-12-marex@denx.de>
 <20250310135557.GW2640854@bill-the-cat>
 <20442227-eb4d-49a3-8401-9031d818c91a@denx.de>
 <20250310213117.GM2640854@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250310213117.GM2640854@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 3/10/25 10:31 PM, Tom Rini wrote:
> On Mon, Mar 10, 2025 at 10:07:40PM +0100, Marek Vasut wrote:
>> On 3/10/25 2:55 PM, Tom Rini wrote:
>>> On Sat, Mar 08, 2025 at 09:12:15PM +0100, Marek Vasut wrote:
>>>
>>>> This seems to be needed for filesystem tests at least on
>>>> ubuntu 22.04 machines. Add setuptools into requirements.txt .
>>>>
>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>> ---
>>>> Cc: Baruch Siach <baruch@tkos.co.il>
>>>> Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
>>>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
>>>> Cc: Hiago De Franco <hiago.franco@toradex.com>
>>>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>>> Cc: Nam Cao <namcao@linutronix.de>
>>>> Cc: Simon Glass <sjg@chromium.org>
>>>> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
>>>> Cc: Tom Rini <trini@konsulko.com>
>>>> Cc: u-boot@lists.denx.de
>>>> ---
>>>>    test/py/requirements.txt | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>
>>> This belongs in the requirements.txt for the tool that requires
>>> setuptools, not pytest. It's also listed as a required host tool /
>>> package in doc/builds/gcc.rst. Having just re-created the
>>> requirements.txt file, I don't want to add things that will get dropped
>>> again the next time.
>>
>> This seems to come from pylibfdt . I can drop this patch too.
> 
> Thanks.
Dropped.
