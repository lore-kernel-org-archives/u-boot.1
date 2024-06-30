Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7796EC27C4F
	for <u-boot@archiver.kernel.org>; Sun, 30 Jun 2024 18:49:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A66E08845A;
	Sun, 30 Jun 2024 20:49:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FE4488629; Sun, 30 Jun 2024 20:49:13 +0200 (CEST)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00F7488208
 for <u-boot@lists.denx.de>; Sun, 30 Jun 2024 20:49:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=csgroup.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christophe.leroy@csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4WByrP3sJsz9tdf;
 Sun, 30 Jun 2024 20:49:09 +0200 (CEST)
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wOfMNHbUqhtP; Sun, 30 Jun 2024 20:49:09 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4WByrP2l29z9tdJ;
 Sun, 30 Jun 2024 20:49:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 51A558B768;
 Sun, 30 Jun 2024 20:49:09 +0200 (CEST)
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id GJM6eyoEs4vl; Sun, 30 Jun 2024 20:49:09 +0200 (CEST)
Received: from [192.168.232.162] (PO26725.IDSI0.si.c-s.fr [192.168.232.162])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id F37028B763;
 Sun, 30 Jun 2024 20:49:08 +0200 (CEST)
Message-ID: <c88fbe6b-1205-4b73-ae16-2a4ae1fa9df7@csgroup.eu>
Date: Sun, 30 Jun 2024 20:49:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zlib: Fix big performance regression
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Tom Rini <trini@konsulko.com>
Cc: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
References: <9756b956da953de2c32278a81f711cf3ac281bad.1719476684.git.christophe.leroy@csgroup.eu>
 <20240627193455.GE38804@bill-the-cat> <20240627194006.GG38804@bill-the-cat>
 <d53c76b8-2962-4b8e-b2d5-b969a0cf08cf@csgroup.eu>
 <20240630145422.GH38804@bill-the-cat>
 <a40866e3-025f-493c-b1f7-db3bb1bb5bb2@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <a40866e3-025f-493c-b1f7-db3bb1bb5bb2@csgroup.eu>
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



Le 30/06/2024 à 20:28, Christophe Leroy a écrit :
> 
> 
> Le 30/06/2024 à 16:54, Tom Rini a écrit :
>> On Sun, Jun 30, 2024 at 10:47:06AM +0200, Christophe Leroy wrote:
>>>
>>>
>>> Le 27/06/2024 à 21:40, Tom Rini a écrit :
>>>> On Thu, Jun 27, 2024 at 01:34:55PM -0600, Tom Rini wrote:
>>>>> On Thu, Jun 27, 2024 at 10:25:21AM +0200, Christophe Leroy wrote:
>>>>>
>>>>>> Commit 340fdf1303dc ("zlib: Port fix for CVE-2016-9841 to U-Boot")
>>>>>> brings a big performance regression in inflate_fast(), which leads
>>>>>> to watchdog timer reset on powerpc 8xx.
>>>>>>
>>>>>> It looks like that commit does more than what it describe, it
>>>>>> especially removed an important optimisation that was doing copies
>>>>>> using halfwords instead of bytes. That unexpected change multiplied
>>>>>> by almost 4 the time spent in inflate_fast() and increased by 40%
>>>>>> the overall time needed to uncompress linux kernel image.
>>>>>>
>>>>>> So partially revert that commit but keep post incrementation as it
>>>>>> is the initial purpose of said commit.
>>>>>>
>>>>>> Fixes: 340fdf1303dc ("zlib: Port fix for CVE-2016-9841 to U-Boot")
>>>>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>>>>> ---
>>>>>>    lib/zlib/inffast.c | 51 
>>>>>> ++++++++++++++++++++++++++++++++++++----------
>>>>>>    1 file changed, 40 insertions(+), 11 deletions(-)
>>>>>
>>>>> Both this, and my mostly revert lead to CI failures around compression
>>>>> tests:
>>>>> https://source.denx.de/u-boot/u-boot/-/jobs/859329
>>>>
>>>> A full revert however, is fine.
>>>>
>>>
>>> Is it that ? :
>>>
>>> FAILED
>>> test/py/tests/test_ut.py::test_ut[ut_compression_compression_test_gzip]
>>>
>>> It seems like when the optimisation was added by commit cd514aeb996e 
>>> ("zlib:
>>> Optimize decompression"), only the pre-increment implementation was
>>> available.
>>>
>>> When POSTINC was added by commit e89516f031db ("zlib: split up to match
>>> original source tree"), I guess it was not verified because POSTINC is
>>> #undef by zlib.h.
>>>
>>> With the following change I don't get the FAILED
>>> ut_compression_compression_test_gzip CI anymore
>>> (https://source.denx.de/u-boot/custodians/u-boot-mpc8xx/-/jobs/859937)
>>>
>>> diff --git a/lib/zlib/inffast.c b/lib/zlib/inffast.c
>>> index c271d85ea1..5dc0574202 100644
>>> --- a/lib/zlib/inffast.c
>>> +++ b/lib/zlib/inffast.c
>>> @@ -257,7 +257,7 @@ void inflate_fast(z_streamp strm, unsigned start)
>>>                          sfrom = (unsigned short *)(from - OFF);
>>>                          loops = len >> 1;
>>>                          do
>>> -                           PUP(sout) = get_unaligned(++sfrom);
>>> +                           PUP(sout) = get_unaligned(sfrom++);
>>>                          while (--loops);
>>>                          out = (unsigned char *)sout + OFF;
>>>                          from = (unsigned char *)sfrom + OFF;
>>
>> Ah, thanks! Testing again now.
>>
> 
> That's probably not enough. I thought other failures were unrelated but 
> I gave it a try with a full revert and I get no failure at all with that 
> so there must be other things.
> 
> I find that pat16 = *(sout-2+2*OFF) suspicious, sout being a short it 
> means -4 bytes which is not what is expected I think.

That's it. I get all green with the following, see 
https://source.denx.de/u-boot/custodians/u-boot-mpc8xx/-/pipelines/21391

diff --git a/lib/zlib/inffast.c b/lib/zlib/inffast.c
index c271d85ea1..69268caee8 100644
--- a/lib/zlib/inffast.c
+++ b/lib/zlib/inffast.c
@@ -257,14 +257,14 @@ void inflate_fast(z_streamp strm, unsigned start)
  			sfrom = (unsigned short *)(from - OFF);
  			loops = len >> 1;
  			do
-			    PUP(sout) = get_unaligned(++sfrom);
+			    PUP(sout) = get_unaligned(sfrom++);
  			while (--loops);
  			out = (unsigned char *)sout + OFF;
  			from = (unsigned char *)sfrom + OFF;
  		    } else { /* dist == 1 or dist == 2 */
  			unsigned short pat16;

-			pat16 = *(sout-2+2*OFF);
+			pat16 = *(sout-1+OFF);
  			if (dist == 1)
  #if defined(__BIG_ENDIAN)
  			    pat16 = (pat16 & 0xff) | ((pat16 & 0xff ) << 8);

Christophe
