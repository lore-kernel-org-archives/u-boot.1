Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D24C282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 23:33:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C49928083E;
	Tue, 11 Mar 2025 00:33:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1741649632;
	bh=P0qCc2D7iq8L3ntU32kd0IdDihFlBnXwsYlumtLJ6Zk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xaVSRQLApBvrJJLTc1JOs4Dnb/EIa/BmJB6vNrIK4Nx+DjtKCKE6LkpRvDmkkSELx
	 8v8RtjTg9AfhBxAysVWA/Ss0n2WKe4JQdZtdWI6LNa9o9cM7w53H7h6ybcvle9wuDd
	 /qfyFeapMUBKYRVJUQAq6DjC5oOMPCOUxEVI1nNqUHMX4EgGrq2dIcy1YeE1Xym/yY
	 4y9S9zQ7Hd9Qnu+xdnBg/3e5ldqTpRsmswugU8tEZ+1i4Abrrwm0FPIMRehofc/gy2
	 dasVixpSkNCvIl+dN7BBpgqm8ko5plluXn8Xglo57kKz9r1AJnWiZ2RKGZOcqHJjpt
	 jrH1hR7K+NpZQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9904A8144F; Tue, 11 Mar 2025 00:33:48 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A41F48083E
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 00:33:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="JK8IXdGZ"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 01CCA1020E4DE; Tue, 11 Mar 2025 00:33:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1741649626; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=P0qCc2D7iq8L3ntU32kd0IdDihFlBnXwsYlumtLJ6Zk=;
 b=JK8IXdGZNvTlufHPwPbsnFXVg7ld9jxS4q37hFnABVz3M/wep+R4dOE8xQ+UfzWTJ5+ZS/
 x/xmWvMVnzQ7alj51FcBNbkKxOAcvVQAeSt2+i4shIGjkdmd/hZPpBV+lhp6PgPei8XVox
 Fufb7TB1MPae+4+9WEENsqZSd88J+ynl9e1ih0GCIGzsJp77S0ysSLExeNL6uync9/5GiQ
 2xYY46ukCooKdXjeYqfvmuDgwV+vlB6RlHTR2Flw72si7CS0JGnXOIBaQyknwHnKgSYg9s
 +1e6I+aK3o3W2tXZCA23+edI+SOzT5sR5g8ffdWMdO94br3sv5kDSdBv184mqA==
Message-ID: <2f0ba682-0f1a-4b5e-a168-f3829a58f16a@denx.de>
Date: Tue, 11 Mar 2025 00:22:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] test_fs: Add exfat tests
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Baruch Siach <baruch@tkos.co.il>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
References: <20250308201533.1315951-1-marex@denx.de>
 <20250308201533.1315951-13-marex@denx.de>
 <20250310153055.GI2640854@bill-the-cat>
 <6d68d2f0-c969-43f1-86c6-1ccbf039291a@denx.de>
 <20250310213754.GN2640854@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250310213754.GN2640854@bill-the-cat>
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

On 3/10/25 10:37 PM, Tom Rini wrote:
> On Mon, Mar 10, 2025 at 09:37:36PM +0100, Marek Vasut wrote:
>> On 3/10/25 4:30 PM, Tom Rini wrote:
>>> On Sat, Mar 08, 2025 at 09:12:16PM +0100, Marek Vasut wrote:
>>>> Add tests for the exfat filesystem. These tests are largely an
>>>> extension of the FS_GENERIC tests with the following notable
>>>> exceptions.
>>>>
>>>> The filesystem image for exfat tests is generated using combination
>>>> of exfatutils mkfs.exfat and python fattools. The fattols are capable
>>>
>>> Did you mean "exfatprogs" and not "exfatutils" ? But we need to update
>>> tools/docker/Dockerfile to list the tool there.
>>
>> It seems the CI container already has the tools in it ?
> 
> Implicitly and not explicitly then.
> 
>> Where do I update the docker container, is that tools/docker/Dockerfile ?
> 
> Yes, thanks.

Added in V2, thanks.

>>>> of generating exfat filesystem images too, but this is not used, the
>>>
>>> Presumably because "fattools mkfat" seems to have further external
>>> dependencies and so would be more of a pain to use.
>>
>> I don't think it does, but I think we should stick to tools which will be in
>> production systems as much as possible, and that is mkfs.exfat from
>> exfatprogs . The fattools is only used here because mkfs.exfat cannot create
>> an image from list of files.
> 
> Well, I tried "fattools mkfs.exfat" and it wanted tkinter to be
> installed, so that's why I'd not bother with it.
Uh OK.
