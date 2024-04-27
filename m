Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25093C4345F
	for <u-boot@archiver.kernel.org>; Sat, 27 Apr 2024 23:19:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D44A88221;
	Sun, 28 Apr 2024 01:19:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714259949;
	bh=6RaFxigssgAD5RPr+syr+CsglnK3+k68ZqX/M9ojev8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lsxRw/iMtNSsIxExv1TtYCVNJXCYWDZAUp6HxlNY/i5mBj07aB33wATb5++LgcuYw
	 HZaOuceLva4GQNu1XSPpNtqZP6NSA/UEFiwXuUspQu2huije/+L2d7mBj7BnlqbPAq
	 mQPICeh1HTxC2h0iznZXQDsMrR6Y1GNgp/VjW+kQhtVhxYX7Fdow08RyunS3P70M1K
	 VbYKbDL/aoQlpU7pHiIrBuF8+cf8/dqUwXsYLYDF5N214HlJ7fbjrVV61uWyfNCBY9
	 2jfhRzl7J1wKnY2hSmqH/4ATrqay9ergQK46gK+SbzO8W7/mEeuZrsP3YActP3DGDz
	 dV0UMWwNA0A3A==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 7AAE58820E;
 Sun, 28 Apr 2024 01:19:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1714259947;
 bh=6RaFxigssgAD5RPr+syr+CsglnK3+k68ZqX/M9ojev8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=BPiGaWYIdL/JxXsZV1z2Xb0abpZZFmS/dWZda6gt4t0oKQ99tTE6OUS1PDCREHx3G
 uh0V7rF9mWEPfIGM4Ja0cBvPOGoGgvk798L6N4v2q9kAJlTSDpsrNOm6iIbLf64qsa
 GX99Ruuc/rMnMdQbTfpCYlhq1MK84zlfftnkUYozx1chFO5IS++QHmKdBdUeJN4ljL
 BVpzHrsFxAvLljt79eNGbu5w73F7Skjx6w2M5Mvirzq2EP+vSrCBW4l0WxXWrSZGrg
 2U9hunmAQ2j1pwnkUZhDj7JrI967rrfw9w/pOB22tz1YIQ7cZcoSlwTBCX1XMYU2rz
 JnXHeq+YA+qNA==
Message-ID: <4ca5984f-ea3b-4d18-bd01-37e0b0e191f3@denx.de>
Date: Sun, 28 Apr 2024 01:19:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mmc: allow use of hardware partition names for mmc
 partconf
To: E Shattow <lucent@gmail.com>
Cc: Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Fabio Estevam <festevam@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de,
 Dragan Simic <dsimic@manjaro.org>
References: <20240427001157.1460302-1-tharvey@gateworks.com>
 <52d7d87e-19b0-4474-bf75-33dbbc150c31@denx.de>
 <CANV2PTOQknpnfKsZQC9Tr0AhZgMQOOTTND0T+WMp8pwv-5TNdQ@mail.gmail.com>
 <d8a77dd7-39bf-4ccd-979a-97eedb054b36@denx.de>
 <CANV2PTPt3Ey9uO5rVdLmaDvQdf=v=JEN52kNhcYbvRWfFb_2OQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CANV2PTPt3Ey9uO5rVdLmaDvQdf=v=JEN52kNhcYbvRWfFb_2OQ@mail.gmail.com>
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

On 4/27/24 2:06 PM, E Shattow wrote:
> On Sat, Apr 27, 2024 at 3:22 AM Marek Vasut <marex@denx.de> wrote:
>>
>> On 4/27/24 3:29 AM, E Shattow wrote:
>>> Hi Marek,
>>>
>>> On Fri, Apr 26, 2024 at 5:49 PM Marek Vasut <marex@denx.de> wrote:
>>>>
>>>> [...]
>>>>
>>>>> diff --git a/include/mmc.h b/include/mmc.h
>>>>> index 4b8327f1f93b..7243bd761202 100644
>>>>> --- a/include/mmc.h
>>>>> +++ b/include/mmc.h
>>>>> @@ -381,6 +381,21 @@ enum mmc_voltage {
>>>>>     #define MMC_TIMING_MMC_HS200        9
>>>>>     #define MMC_TIMING_MMC_HS400        10
>>>>>
>>>>> +/* emmc hardware partition values */
>>>>> +enum emmc_hwpart {
>>>>> +     EMMC_HWPART_DEFAULT = 0,
>>>>> +     EMMC_HWPART_BOOT0 = 1,
>>>>> +     EMMC_HWPART_BOOT1 = 2,
>>>>> +     EMMC_HWPART_GP1 = 3,
>>>>> +     EMMC_HWPART_GP2 = 4,
>>>>> +     EMMC_HWPART_GP3 = 5,
>>>>> +     EMMC_HWPART_GP4 = 6,
>>>>> +     EMMC_HWPART_USER = 7,
>>>>> +};
>>>>> +
>>>>> +/* emmc hardware partition names */
>>>>> +extern const char *emmc_hwpart_names[];
>>>>
>>>> Maybe the array should have fixed size here, i.e. 8 ?
>>>
>>> Is there an ABI reason to do so? Can you explain further why it would
>>> be needed to do that?
>>
>> It has nothing to do with ABI, it is only to let the compiler validate
>> that nobody would index the array with index > 7 by accident.
> 
> At least GCC knows this without doing its work again ourselves. How
> about a const for the upper limit, where currently EMMC_HWPART_USER
> substitutes for expressing an upper limit? You may as well be writing
> EMMC_HWPART_MAX = 8 in the enum and using that for the initializer
> also any iterators with a less-than condition to make it more
> expressive.

You could use ARRAY_SIZE(emmc_hwpart_names) in iterators, no extra 
symbols should be necessary.

> $ gcc -o testobj test.c -Wall -Wextra -O2
> test.c: In function ‘main’:
> test.c:16:5: warning: array subscript 8 is above array bounds of
> ‘const char *[8]’ [-Warray-bounds=]
>     16 |     printf(emmc_hwpart_names[8]);
>        |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> test.c:3:13: note: while referencing ‘emmc_hwpart_names’
>      3 | const char *emmc_hwpart_names[] = {
>        |             ^~~~~~~~~~~~~~~~~
> 
> #include <stdio.h>
> 
> const char *emmc_hwpart_names[] = {
>         "user",
>         "boot0",
>         "boot1",
>         "gp1",
>         "gp2",
>         "gp3",
>         "gp4",
>         "user",
> };
> 
> int main(int argc, char** argv) {
>      (void) argc; (void) argv;
>      printf(emmc_hwpart_names[8]);
> 
>      return 0;
> }

In case of this patched code here, the example is more like this:

a.c:
#include <stdio.h>
#include "h.h"

int main(void)
{
     printf("%d\n", arr[8]); // This code contains a bug here
     return 0;
}

b.c:
int arr[2] = { 1, 2 };

h.h:
extern int arr[];

Compile:
$ gcc -O2 -Wall -c -o a.o a.c
$ gcc -O2 -Wall -c -o b.o b.c
$ gcc -O2 -Wall -o out a.o b.o

You won't get warning when compiling a.c , because gcc does not know the 
size of the array until the linking step. You will get a warning if you 
change the header like this:

h.h:
-extern int arr[];
+extern int arr[2];
