Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D43C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 21:06:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A89F08708B;
	Mon,  6 Nov 2023 22:06:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1699304778;
	bh=MOIjMC6BeUw8eiFNGNqIHgCicEUKgDiN6z1jGA9jo4k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CXpMrpsFL7TNK5aBGX+N9y3JzeGhKe5Eb/i01nz/TA3D4u/qI0A7eE9cfilNDmErL
	 BkTCIL1pc0wTOD5paht6rXOWEKJR/ElhnWWAzHQA86PGOXu+7Ts+FkWxJA5mMncGqQ
	 trCSX+c3KtUafvCugSV2vBpgVdUicH+QEZNEm0JAAtjq00I0+6yVzSFZI8tz+p8Y1b
	 nt3+Ie+w9Ro6cst0DR3LOVUkI9tILlCGnQWmXhqsMUv8g5owQH+1onK34ZSk1uLOR0
	 38PWIsSSsyvSuI2WBJJpwv9TAfF2NvCJLR8vxdU2MzI5DGW89vGbq4r3t0IqTHPF2h
	 rgbGKRqlIENag==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id B00E2863F8;
 Mon,  6 Nov 2023 22:06:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1699304777;
 bh=MOIjMC6BeUw8eiFNGNqIHgCicEUKgDiN6z1jGA9jo4k=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=FRvawsfLhbD9AZ8jpPf7TRTO5xtyyvgpNqP+5gl3yk/HBZRfepUUW6GDV2lDgK/J6
 N5rPWvL7o3OsOjdQh+CAHql6IpwO1zXQw2pT16H3mtpZhr4f0ElheDNq6wY+BiXB6b
 g6wS1WVY5koiCsN273C+Dq7kwZwQUQN89W7hMOMFXpAa4/wKVxrHj2dhj3dgCz9xXy
 /QCl/hBxNn69D3oZsO9Bia1yh+AHY8ckFrvF4n6jL1URUZvriOpUNN7vHSP/wwoIyi
 a5mFMSuaDfcTN1MKTna8NKC8vhGsqork6UMp8mDMBi17wUCn6dJbQ9a19BPUdk8NrP
 Q/6aq8TIbhx5A==
Message-ID: <dadc3f5d-1a4a-4820-8015-b9184b648ff5@denx.de>
Date: Mon, 6 Nov 2023 22:06:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Need advise with u-boot on SH-7785LCR
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Vagrant Cascadian <vagrant@debian.org>
Cc: u-boot@lists.denx.de
References: <bf1e575239af2f0dae872543dbc4f9974c618c95.camel@physik.fu-berlin.de>
 <CAPnjgZ0zjD+vrsyHkRpAzatZvA7Cv5-9Q+96O1mUN0Ei4H70uw@mail.gmail.com>
 <891544b36a1a9a1cd62345f341828c144e7f1ec6.camel@physik.fu-berlin.de>
 <CAPnjgZ35bJSBE_HqVxh_fb42AYm+vYmx-oyaDQzXqcsmqFvHxA@mail.gmail.com>
 <1b27e5f825851f6a3c0c198c0b42e50bc36f67b8.camel@physik.fu-berlin.de>
 <CAPnjgZ1PmHzB1jYRwjDUiUAydSvS=-Q50mzDLdHROr2xA1NYWg@mail.gmail.com>
 <60c58204161b27c044b19a657a3270e77519fafa.camel@physik.fu-berlin.de>
 <CAPnjgZ3Xk87GOYXaUZNPE7wjDi4fGim5zZCt0H_QW=THTPJyKQ@mail.gmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAPnjgZ3Xk87GOYXaUZNPE7wjDi4fGim5zZCt0H_QW=THTPJyKQ@mail.gmail.com>
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

On 11/6/23 21:42, Simon Glass wrote:
> +Marek Vasut <marex@denx.de>
> +Vagrant Cascadian <vagrant@debian.org>
> 
> 
> On Mon, 6 Nov 2023 at 10:33, John Paul Adrian Glaubitz <
> glaubitz@physik.fu-berlin.de> wrote:
> 
>> Hi Simon!
>>
>> On Mon, 2023-11-06 at 10:24 -0700, Simon Glass wrote:
>>>> So, I assume, I should just be able to write u-boot.bin to
>> /dev/mtdblock0?
>>>
>>> Maybe, but you will likely brick the device if you have no other way
>>> to write to flash.
>>
>> The flash memory is actually on a daughter board that can be easily
>> replaced
>> and I have multiple of these daughter boards. It turns out that just
>> writing
>> the image to /dev/mtdblock0 works and I can boot the board into the freshly
>> flashed u-boot version.
>>
>> However, the u-boot version 2019.01 built from git won't work while the old
>> 2014.01 version that I copied onto disk from /dev/mtdblock0 does work when
>> flashing it to a second daughter board.
>>
>> So, flashing works indeed like this and I can successfully start u-boot
>> after
>> flashing it into /dev/mtdblock0. Now I just need to figure out what the
>> difference
>> between 2014.01 and 2019.01 is and why the latter doesn't work.

In U-Boot, parallel NOR flash is flashed by cp.b into the parallel NOR 
memory mapped address , there are hooks which do the NOR writing.
