Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE77D3B7C1
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 09:26:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9D7B88CF1;
	Tue, 26 Nov 2024 10:26:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="AnJASFKd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8907A8932F; Tue, 26 Nov 2024 10:26:34 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8753F881E7
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 10:26:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1732613190; x=1733217990; i=xypron.glpk@gmx.de;
 bh=4E+oIGk9CF6r/u2bRUBdz6ZpjyIRbbTVHzMdo4SP6JM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=AnJASFKdoUsWj6nmkn1udXZE/9b/D7ejbNZdQOOMYNCauF8fK74Rbp8Fqy6UYuJL
 HtJopmaTc5zQst6Srv+xIwr/zmZXru5OnrnY9Mf9PIL7k5wdubrG4tlyUw7kgdpSn
 9E3O/G3pDpgE4vPQ26BTw/MpAE9wQf6dT6ISmxo+jKvXoowTzHygrOkwHxvUoTIQL
 EMTiy9tlsOBOls/MxJZluS8RgxonuC3GxQS0Hj6vZfUgAD/K7GdBCIDdLX7Q1skWS
 aLZf/1kv0XkOIOiBSLgnWJIFzj3uKL1z4UjYujk+HivxvEmWRBn19AEJOzo8c1ATw
 nvqC3G/sdxwnAEXAJA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZTqW-1tB09A0oJK-00Iy3Q; Tue, 26
 Nov 2024 10:26:30 +0100
Message-ID: <f6017e02-0fd1-42df-8704-e4f50f5abd5b@gmx.de>
Date: Tue, 26 Nov 2024 10:26:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] efi_loader: Update startimage_exit self-test to
 check error
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20241125204456.1525752-1-sjg@chromium.org>
 <20241125204456.1525752-5-sjg@chromium.org>
 <CAC_iWjLgPqvmvMjHQsY+dPrQ4cmz11KKSKEs87OHW7KEpBWR5g@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAC_iWjLgPqvmvMjHQsY+dPrQ4cmz11KKSKEs87OHW7KEpBWR5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:BPoXSdDSZu4eLw293azZCFI3s5Hu/NMbqr6FGImN2JmsOxm34qb
 IxBbIUyWlPwLY2R6M9eiPLjKcLy8imPQf1lbhH0kMczEZ17O0hLoR2V5tKNjRFkL4WNa0/q
 /taqxkg17zIS/aXKhFeLlfUvyYKdQz25Gb0FZcniCUa6k4x8Sgbw3Dju4/ptdxgO6YRLuUH
 JIJLx7RhBdaSSCM8ia2zA==
UI-OutboundReport: notjunk:1;M01:P0:P3V0qitWEyQ=;hqCarbF4ZAYNQHLQ74bwgqdnUp0
 zKm75d4NZpkbKuTSGelkZ9tlV2TfWKfybT+JfZ1s6p3iEolByicOZaZ7HT2oVEEW4X1W6iw1t
 VExKYtutYontt2kmonTCeJpNoroqMaY5aNa78h9J/TG/3DfUxiE3leRTFC7L/JzqdvotBXAjv
 pWIrpIv46UW46NxHwpsZOgwbAmt/X7Ebn1UpYsmTjppGuBbMNy7hC/+IDNfSWZPRngPazLIhQ
 8Mb7i6FqmwcA0xufLdm1e2G7DOZggBY2OCdn2vsW2NVNrjyE0FfaSwJZalOJDCvuAUkUFhs7Q
 bzaiUr+p8aHeSUmPJmdtfgXiH+3X9ODumbG7kFsDK312hiFExiIYUP4+nYdm7Q5Efanj1Je23
 ri2Ce2UudEBK60itJuhiIZNSCoLphp4IJzU/xkbugnGScC1cTtk18z3vzz2MdrZKI01N0oZW3
 Bz1jUoATra+I4yf0SIFvD/yiAnE0Ptv2GKbauMt0w5j0aZZMxy5iRGcg2eX8uWFaOX2qbHpy2
 X40FXxkld6CVzMpVVRt8j0zVlQcCKOQkBFmValOdZYH+o5qOFjFEcQZI7QIV3/te9cMG3+xrF
 rnxXO2A3sMeN0dsEK05pOIwwe7WKQ0im9OIHdekdcTYdd/clpGFVIiwBvhg75+trCbK/oKtHn
 ZW/7i3TxNft1VRfHMx5aQArTRx/xoqES63kUYJscoF3LT6HtmXQHG9Qm7VlJ8Cdxk75ehcMsq
 T5qVHucjumHqGmkNhGPPoe/Sb7Jh8I+zHcS6pONXSGE+djajh6HFkOD52YAQlG8f09AUMH6Jh
 7eNsDs1LPSF2YabQwspZZP2y4UHVflMhNyjJzUZNKIn1R3FLxPc4GIz72bB1CAP3lGsSGDHFc
 /NxZDttrYoWnmmCPwN4/A03VvZmDdCMwbPCIUgvntnDeWKQrBgd0rlv+W
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

On 26.11.24 07:29, Ilias Apalodimas wrote:
> On Mon, 25 Nov 2024 at 22:45, Simon Glass <sjg@chromium.org> wrote:
>>
>> Check for an error returned from the decompress() function, just in
>> case.
>>
>> Signed-off-by: Simon Glass <sjg@chromium.org>
>> ---
>>
>>   lib/efi_selftest/efi_selftest_startimage_exit.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/lib/efi_selftest/efi_selftest_startimage_exit.c b/lib/efi_selftest/efi_selftest_startimage_exit.c
>> index b65a10b7a4b..8d119f054c5 100644
>> --- a/lib/efi_selftest/efi_selftest_startimage_exit.c
>> +++ b/lib/efi_selftest/efi_selftest_startimage_exit.c
>> @@ -84,13 +84,15 @@ static efi_status_t decompress(u8 **image)
>>   static int setup(const efi_handle_t handle,
>>                   const struct efi_system_table *systable)
>>   {
>> +       efi_status_t ret;
>> +
>>          image_handle = handle;
>>          boottime = systable->boottime;
>>
>>          /* Load the application image into memory */
>> -       decompress(&image);
>> +       ret = decompress(&image);
>>
>> -       return EFI_ST_SUCCESS;
>> +       return ret;
>>   }
>>
>>   /*
>> --
>> 2.43.0
>>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
