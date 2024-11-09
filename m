Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8617D5E386
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 22:24:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D503889327;
	Sat,  9 Nov 2024 23:24:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="qpgOhY0b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 688318932C; Sat,  9 Nov 2024 23:24:04 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A4AD89318
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 23:24:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731191041; x=1731795841; i=xypron.glpk@gmx.de;
 bh=uoMG3QgQ88s44QFn/iChFW8LkGWuqQiy/44FaDt/gj4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=qpgOhY0blC8jDkiw9+rDWpxyN/AODL2fjF7UDiSq7U6HwWmeQTW8pN552sm2ZOli
 HmNJwbI6R75CYBSPWzdsVv8Kk+jr7DyitLGHcl0EBWtydXRb9BwygGRedqXuqHF0+
 aCzcYOBbrCcduJklP39MJbtAKB948QJIkyVWwAMoDMMYYH6F1UvGCgowwQp7qnepR
 902tqUD9z4+kAYLOQdJU//jZiYo+7z50hNcqF31/uPkaLI6R0u55I/IcrhcskonPZ
 Hx3yBWC65KVMhzTsPDRs6E9+5EujAVgEHh2gjfDEZfStjWxBtnmZG/7bm7pwdWS5T
 bf5VIasb+nme1YJJeA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6KYb-1ttbia1ZhB-014G1Y; Sat, 09
 Nov 2024 23:24:01 +0100
Message-ID: <1f44e6b1-eee9-4895-b06f-fdcecb9dfb44@gmx.de>
Date: Sat, 9 Nov 2024 23:23:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SiFive Unmatched: Linux kernel doesn't start (U-Boot 2024.07)
To: Yuri Zaporozhets <yuriz@vodafonemail.de>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
References: <Zyv8zn2oGmmKz5XU@vodafonemail.de>
 <CAFLszTjGEVsFXdLNQdfD6mNNFC76k+4S0VZLJfbMNO7s1V5K6g@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAFLszTjGEVsFXdLNQdfD6mNNFC76k+4S0VZLJfbMNO7s1V5K6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4p69NiDiBUKIyXm8vXvkNFnNfpgITVslzf2YOFBnCGoyOA2riHK
 Oa5vpH5oH/GG5O3hetEWGaZTi+VtWR/Bn0NjkzDB1e4qpqCd9fTvQmT7vRX4o9ItQW9Sz/I
 mGa4HJWxib+uBOISM3VD8b3L8ZQlRgIkEDteKpeZWPhHK0JCfaYegCh+OzlaZ2flARF5Y/j
 J6fYsubgjHnYn9M07RSVg==
UI-OutboundReport: notjunk:1;M01:P0:h5y5t5g5Zyw=;ByATnuIw+truihja4FpoGAzQb7n
 g/pUyAGl7/QIpsdAxGC/ihgstOo3OG9f4kT55P2aE9myJxWVkWfPqG0TZuOP3iNL/Mohrwbqx
 GQL7MOS+fCqHaBaajJ34D50Vq818KLshpzHEP8+b4N5bYagH/Q2MqGafQaiuYwKXsllN/iZto
 n/qjVw0nl0lglD3t00FVygeeKrkh35r2HhwTeMbQQ3UIYNGwoQchnK2DSirIFmPMPhoSK3gVL
 8Dh07zY6cxIf//FphLfRSyJv30GGaCKT4ABM0Eupj1hOC//+2qLN8W1tEnj4QM0glbWEMo//k
 KqCz6Nbk7r11uIbbZc2VQSWjZqtSQsEyqx0iFRge6PcrLnkPrhPTd/6sodQ2ZNw9lldljk8ao
 y6v8XVW9++D+Dxhh9WgOaJcsYAOEzdeNDqOiPZ7MCWPCD5MZJ4Nv+6WGwMknytHT+Q2J8GBhG
 ZDUqTe9Lo0rqYb7pn63NlY6fCXFfjhdQM6Hq7sVtAWDTupetb7HPWfYL1dGx2/+Mdgjvk8q+0
 EGNdrP7Ns5WrhVwkjrL2eqRyAR5jMfKQIXgs8RW7Zj1C9Pf8esdRGq4ReuH8HFBk0pSUpCG3V
 7OO2BjrgXqVpnW2u3Hpckmg+IQ2Ic4aLynWy4iOu+6lLLSdbZH0pwtd7etgQOEX36dK7LcNvC
 KkerTE+bhX/7YX+WmwUWwibF+F2Jwz49KT6UTYIB+QzUz6fxg1fiCLOS8N49w9ZqyTw/Mh2iz
 k4334jzootMREzDCUcy+GaJZClvX6u7KVppgvwma+ZfTihco2NyANjUvK0Hce1CYOH34XUSzr
 du3KOpNUQFD8iA0T7Vd6jtUitdQCUlukGvpU/ODErkFaP+QfAGQrN5L5OY3A5j66GnHjJD2ps
 H9rPRTO/yRINAYHM7vDpgIjWkOvuv7yxkBGLex2koSiVyllP6lf8rCrBn
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

On 09.11.24 18:34, Simon Glass wrote:
> +Heinrich Schuchardt
>
> On Wed, 6 Nov 2024 at 17:53, Yuri Zaporozhets <yuriz@vodafonemail.de> wr=
ote:
>>
>> Hi all,
>>
>> To all owners & active users of the SiFive Unmatched board: do you have=
 success
>> running any recent upstream U-Boot on your system?
>>
>> I use the default U-Boot from Ubuntu 24.04, and it boots GRUB and Linux
>> kernel just fine. Today I flashed the unmodified U-Boot 2024.07 (compil=
ed with

2024.10 has been released, we are currently working on 2025.01.

>> "make sifive_unmatched_defconfig" and OpenSBI 1.5), and the Ubuntu kern=
el
>> (6.8) doesn't boot at all. The last message I see on the console is:
>>
>> EFI stub: Exiting boot services...
>>
>> Adding "earlycon=3Dsbi debug" doesn't change anything.
>>
>> The same behavior is also when GRUB is excluded from the process:
>>
>> =3D> nvme scan
>> =3D> load nvme 0:5 $kernel_addr_r /boot/vmlinuz
>> 38603264 bytes read in 47 ms (783.3 MiB/s)
>> =3D> bootefi $kernel_addr_r

I would use

setenv bootargs earlycon=3Dsbi efi=3Ddebug

to get early output.

>> Booting /\boot\vmlinuz
>> EFI stub: Booting Linux Kernel...
>> EFI stub: EFI_RNG_PROTOCOL unavailable
>> EFI stub: Using DTB from configuration table
>> EFI stub: Exiting boot services...
>>
>> Is some additional patch needed to run U-Boot on Unmatched?

I just built:

U-Boot 204.07 using OpenSBI origin/master (commit 701948bdec90e290) and
U-Boot origin/master (commit f448c4517b55f401)
using OpenSBI origin/master (commit 701948bdec90e290).

With both I had no problem booting into my Ubuntu 24.04.1 (Noble)
installation via GRUB on the Unmatched board.

=3D> load nvme 0:1 $kernel_addr_r boot/vmlinuz
38595584 bytes read in 48 ms (766.8 MiB/s)
=3D> bootefi $kernel_addr_r

runs up to the point were it finds out that there is no initrd.

If you want to boot via UEFI but without GRUB, please, use the eficonfig
or the efidebug command to define a boot option including an initrd.
Preferably also specify the device-tree that matches the kernel.

You could also use booti to boot via the legacy entry point of the
kernel, i.e. without UEFI.

Best regards

Heinrich
