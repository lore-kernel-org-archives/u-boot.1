Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22758D1813A
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 18:43:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EA1A88EA7;
	Mon, 14 Oct 2024 20:42:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728931333;
	bh=83rdNDwIIctQ/K8IuIHGdBfah+zxC7NeMjNBKf+zsw4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SeZt34x2tH2ty3YH2v9Y6TiXGNODf9+SiS6y87YFgkawqcQ/loervZyfeQI1U7FPP
	 fNI2rUOEKffiS1k74TUnHoYEC6OPrZJMPwfmLKEnof3cByfCcXR5BoOHhyJViaGCHv
	 9OhuApMqtvWofO8X76bVb5Nr+ftg0J4/s13CVnOnIk77csXwNrhK+nwlr+kZB53RFs
	 38sgqgXb8QsjonGLjQk/d2kE3wP+cFNKNMr6wRhbUDImTC1GmiukY5s5Lh4hSQBxET
	 P0dgwqexXFnOvbmKCeuBD6BuCIP3Gum+YZrxuUEVdHrB+aiMzSWE4fv58gXlMvsLvO
	 8DpQopaWml7qg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id BDDFB8641A;
 Mon, 14 Oct 2024 20:42:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728931329;
 bh=83rdNDwIIctQ/K8IuIHGdBfah+zxC7NeMjNBKf+zsw4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=a92X4FYovQqU4uXcRJ0OGKkujKiLfOQVVw5/bUwviwSEhNnwBGTqhLbcAPTwkT9+o
 0tLzfJujk9/gzCgmxgRpgEQt4tQvunsJlGMk2vbrDzHK1Qna5bqkczMrBZQkvD3exf
 QtGil9wsB9C4qQD07b3DEWRfJWshAfdhZ1oFuETI5NMGGUZ8UOUid20Fj4iVKVOjvh
 OIMtml2G8KyHwmfVHO7kju+ppHAjXJhQPBLYSV06ft7x1DhCK/NvPw0/RVo14JqfRA
 SQlqNNIB3ADviWz2aG36tZpamOJodMIJ8m7MJYpwVf9BuXNM+vUIyQLeDi1MxwFqUB
 SEuJ2PziZPaEw==
Message-ID: <7a1e1cbf-049f-4815-8bea-e8795faf1b7d@denx.de>
Date: Mon, 14 Oct 2024 20:41:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: board: Increase rng-seed size to make it
 sufficient for modern Linux
To: Alex ThreeD <alexthreed@gmail.com>
Cc: u-boot@lists.denx.de, Ben Wolsieffer <benwolsieffer@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>, Dragan Simic <dsimic@manjaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20241013093244.817790-1-alexthreed@gmail.com>
 <31e0be9e-ba50-4bc6-b07f-d20426b650be@denx.de>
 <CAF4oh-PE7epxtH9FS2PSbcGcd+aVH=7jYhaAUMNKALZNc80x5w@mail.gmail.com>
 <ef7b756e-b72a-4d76-9168-03371235df19@denx.de>
 <CAF4oh-MzDpuTgLmXyXSwm-zNFMd6Fx_NZz_bxa6vPL_8QU_0eg@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAF4oh-MzDpuTgLmXyXSwm-zNFMd6Fx_NZz_bxa6vPL_8QU_0eg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 10/14/24 8:12 PM, Alex ThreeD wrote:
> On Mon, Oct 14, 2024 at 1:34 PM Marek Vasut <marex@denx.de> wrote:
>>
>>> Actually it seems that entropy required to init pool early has decreased in
>>> Linux 5.19 from 64 bytes (2 * CHACHA_KEY_SIZE) to 32 bytes
>>> (BLAKE2S_HASH_SIZE)
>>
>> A couple more random numbers would cover all the bases then.
> 
> Oops, missed this in v2. Is it vital to add support for 2.5 years old linux?

Some of those old kernel versions are LTS and are going to be maintained 
for a while, so yes.

> Old devices probably stay with older uboot, and new devices will get new linux
> (maybe not that new but not 2.5 years old).

It is easy to cover all the based, so let's do that.
