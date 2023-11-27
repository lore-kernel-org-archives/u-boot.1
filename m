Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE54C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 21:21:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 347CC87618;
	Mon, 27 Nov 2023 22:21:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=smoch@web.de header.b="N0nH1gmP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6D15877C8; Mon, 27 Nov 2023 22:20:59 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCB2F8744C
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 22:20:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=smoch@web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
 t=1701120055; x=1701724855; i=smoch@web.de;
 bh=7NoZwkE+zv2g/Po+ffAo6vnQafygPHpFrI54vXSQKlI=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=N0nH1gmP/Zla9tgwRz9lkqPd9LWP/wGbKR6WskY4Vn0OA9kp/ZCgpP/3oiqlkxHn
 vAkp/j1t9k9Plk8+w0iEBGIZ3ekkmQHxDRzjz5lsxGzcFH8vIOJ0sa1boibPNBVF7
 7lfqykaD5KZAV6XX6uO0DLz0kT2yVT7phEF9FpV/esT1wZI2cXWGSeTb3XuWj1LeH
 x7bBDvt0wo3G4rzerW9DRMhP82gmHW0Om5TTU3wvh94jmL8xryKajEqZ7MYukvydE
 ww/xIa0LLWlIF7UzcaTQL6RQbJkajrJN7mcEbqu+WTyD2yVgrFEfFtqCFV1pu6JdA
 8GYzxH64bw7JYsrDHA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.1.40] ([78.54.67.122]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N2BMA-1rIPij2lY6-013elj; Mon, 27
 Nov 2023 22:20:55 +0100
Message-ID: <c7022ef3-ad0c-4f89-ad47-a0f7df2a24c6@web.de>
Date: Mon, 27 Nov 2023 22:20:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATHv11 26/43] configs/tbs2910_defconfig inc limit
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
 goldsimon@gmx.de
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <20231127125726.3735-27-maxim.uvarov@linaro.org>
 <20231127131129.GD2513409@bill-the-cat>
From: Soeren Moch <smoch@web.de>
In-Reply-To: <20231127131129.GD2513409@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q4EBIuYwI+RLhftc3u3OfrrSDbJw8S3hv7bPYj+tMjli5IqA8we
 z27l85LmxC/Jy0A38yFIkqVYiQag80WJRT9P0buE/7NKgPUcSvFDPOs3gPI0z+Y5xgDvqR6
 prfTJLe0GIdAQbSUpTmmz3x+BCu42EZR+xBRbn50ObAjkc1Q4T4gXGH8t7qRXI2+/1fS6k3
 d9wIoGX0IHTqDTgJzRSBg==
UI-OutboundReport: notjunk:1;M01:P0:z8mZIxwo0II=;B5LGLeFc+cTAyJF4yL/ppmLFUaQ
 csW0EB2ZEji0k20g6YiREnRK8lVF0MZIGd5c/JNIvfGzgT2B0YI2eiMTvUdrD65Y6ZQExSD0o
 49SGsQ/jgBP6hlyr/OOH2zOPeHk8Lcg0qG5n4i73tqs4YXypKysMd5ilc4+MGoUJYq1f2Qrw1
 vQQkO+ETN0RJ22uCiOj/is8UKRbsXs3mfcPx25bcnNytvLeHSyttxEkpOi1EyoSLSrbE5wJUU
 dZOZ+ZdfJNSQAA4a3HL8fkSvTsIwNPk+t21VjHFrCXGWzr5/13Gx7tPNNgvBhGOT6vdTVMRod
 89/aa5NLqPhiC4nVUCUJu/PBCnQ9inEBQKRzXjdE+Z5kuyN74A1PqswjRKOuxVoXNMRsgB7KY
 veGkKYqT5s9DwH9gXRn12Irk3M6aQQa5C5gYg7fEd7PrE0NY3linWxmZlKN3Pem7gLNKi5L38
 3b+y1doT/u1f/YEyuPTda8nYj7SzzrfIcNXNaBGnLBVjOs48FRPxQWwiX0VZPIg8L1WA3A6wX
 N2FyAymPkXJLSwUxxBpfDMFkys9lP2b3uYQdgbWtReBxc1glgoAzDMlUdYEv3Swm5KFyFLMyU
 CAU0R5qqMAqm3Iv9xEvVl8rRRxMzFwkhSsHjCdafjHhn3E2/xb40JBuC5h2aZuznddGaHAaNo
 koc59bXhdLw785d0UXJMP9AoXKQy+aOKmGpMA3UnG0feTzkzomK6hGPzntXQPkqgO0A2Vdxp+
 p0zW+IeHbUXQQdvfJkrKkZIf5KGG6815OPlm2mzJ8T7nY6lwvBg4FDfDMjsdjZhgPQ1PKY1/L
 oy/ffVGJc1tCsTFBe5KzVX4YsmNKtXfUu3b53F6f2DXhdrHgXvAMpAA7+dOHoBEv4iZ5zPCfR
 SmGrRgf3Fcxq7NnKh1h03dW+NN/ERjZ00I/iNmLmJ3nL1F68bp6hcnz4x+yU6Tm6aAu47X16z
 Zygh3w==
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

On 27.11.23 14:11, Tom Rini wrote:
> On Mon, Nov 27, 2023 at 06:57:09PM +0600, Maxim Uvarov wrote:
>
>> Increase allowed binary size to fit lwip code.
>>
>> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
>> ---
>>   configs/tbs2910_defconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/configs/tbs2910_defconfig b/configs/tbs2910_defconfig
>> index 8fbe84f1d2..ce40efa9ab 100644
>> --- a/configs/tbs2910_defconfig
>> +++ b/configs/tbs2910_defconfig
>> @@ -17,7 +17,7 @@ CONFIG_SYS_MEMTEST_START=3D0x10000000
>>   CONFIG_SYS_MEMTEST_END=3D0x2f400000
>>   CONFIG_LTO=3Dy
>>   CONFIG_HAS_BOARD_SIZE_LIMIT=3Dy
>> -CONFIG_BOARD_SIZE_LIMIT=3D392192
>> +CONFIG_BOARD_SIZE_LIMIT=3D417792
>>   # CONFIG_BOOTSTD is not set
>>   CONFIG_SUPPORT_RAW_INITRD=3Dy
>>   CONFIG_BOOTDELAY=3D3
> This is another case where the binary size is a fairly hard limit. You
> forgot to cc the board maintainer here (and I assume the rest of the
> series too) for these config changes.
ThanksTom for sending a notification to me.

Yes, the CONFIG_BOARD_SIZE_LIMIT is a hard limit and this patch in its
current form will break tbs2910 support and even brick the board for
some configurations. So NAK for this patch.
> I think on this platform it's not
> impossible (like it is on am335x where I just replied) but really
> difficult. I'll let Soeren comment on if switching the network stack to
> lwip is the kind of feature enhancement that warrants the pain of
> dealing with the size change here or not.
Network boot is no important feature for this board and not used in
the default boot configuration. But network support always was part
of the config, may be used by some users, and is at least required
to communicate the ethernet address to linux.

So I'm not interested in a new network stack for this board, but
also cannot disable network support completely. This seems to be a
problem for this patch series, since networking support implies LWIP
now.

The question for me is, why is the new network stack consuming so
much space, with only a few enabled commands? Is the whole library
linked in with some unused features (the cover letter mentions much
more than what seems to be used in the converted commands). Or is
the old network stack linked in in parallel to the new one? Can
we save space here?

NFS support in the old networking code is quite big, enabled by default,
and probably still there in parallel to this new lwip library. If there
is really no other option to save space, and lwip in general is agreed
to be the way forward for U-Boot, and only tbs2910 is blocking that,
then from my point of view disabling NFS for tbs2910 could be a way
to stay within the size limit.

Regards,
Soeren

