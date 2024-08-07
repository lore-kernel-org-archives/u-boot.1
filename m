Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DAA5C3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 15:14:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D97988BBC;
	Wed,  7 Aug 2024 17:14:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723043686;
	bh=9eKmm89c1fL7XPg1l2XJiqJa/WgKuspc18RmhmTjrYI=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=ng4JCDbjFH4/lq+KOxAPuzK72akCPfvwYbYzajwI/yuHYiKU3qfI4DUP3jpJ/CIbv
	 UP6s0vIoFvGK1h6Ojwg6acx3ucbqrmLtHTYMQhMQx4Eb+eI/lleVEzBOWHEgV6+8TZ
	 cNqhz88zu8BqkNN+lHMZuoYapYo715H0nXB/OL2uHrd0y/NQ5Qz73s9YMvvCE3ObPl
	 LOsQQuqHxcEtIQH5MRsdKpdnuscfVWf7eHglwjd71E6pBgUMnuXHvft8I/suYNxMkG
	 TLqwQgQgfVm+oyUEcYNe3YZs8QCKG2+DSoPE2A83taKvJRplFqPaSIPYZ7xLIAf4e0
	 Ln/3p9+Ge9uRg==
Received: from [192.168.1.107] (82-131-232-44.pool.digikabel.hu
 [82.131.232.44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id CF36B88B92;
 Wed,  7 Aug 2024 17:14:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723043685;
 bh=9eKmm89c1fL7XPg1l2XJiqJa/WgKuspc18RmhmTjrYI=;
 h=Date:Subject:To:References:Reply-To:From:In-Reply-To:From;
 b=CDCbR8zvX7CpQL8+ZGtMUdz+mZv+AXMv+HmZy45TkI6nuC8YiU3sZ7LBhOI3FLvEG
 i/WiqEMG042l57UFqMQ7SKipfAtiKMc0Oj+lyxG6p6PtiBY0vNTnErSco5cIlizEid
 6FPCcGxXPE2f/Q9ZsjpA3VDzOxTJPqeOA618usIDdR88qnmOm1/cxLXbnU+N8b4mk6
 ACEMUsBrO9trKHAtu4wEJ6kxqQijGgdtsjb+gCbr2JMtJOd0zwOUql02BohFhutymL
 Jcub8+4MNaWzsEDa4NuixcI0uvj9/BJJ8ASg5h4Kc+UQg19ozBOKoAdQ7F+0zvF2Bk
 LW/TmoycTy1wA==
Message-ID: <b698ec3e-d857-6512-8cc9-4edcab0a41b9@denx.de>
Date: Wed, 7 Aug 2024 17:14:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC PATCH] ubifs: Call ubifs_iput when ubifs_iget is used
Content-Language: en-US
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20240805173140.84453-1-michael@amarulasolutions.com>
 <20240807-pancake-estimate-ea370d7f9dc8@thorsis.com>
 <CAOf5uwk10U0u-h=Lxkhn026kWKCHMP5JZxzb1KCzHHcJ1B6OHw@mail.gmail.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <CAOf5uwk10U0u-h=Lxkhn026kWKCHMP5JZxzb1KCzHHcJ1B6OHw@mail.gmail.com>
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean



On 07.08.24 16:57, Michael Nazzareno Trimarchi wrote:
> Hi Alexander
> 
> On Wed, Aug 7, 2024 at 4:55 PM Alexander Dahl <ada@thorsis.com> wrote:
>>
>> Hello Michael,
>>
>> Am Mon, Aug 05, 2024 at 07:31:40PM +0200 schrieb Michael Trimarchi:
>>> The inode should be freed after a reference is get to avoid
>>> memory leak
>>>
>>> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
>>
>> Tested this on top of my recent ubifs series.  No obvious problems
>> found on U-Boot command line with various combinations of commands,
>> no crashes, so …
>>
>> Tested-by: Alexander Dahl <ada@thorsis.com>
>>
> 
> I think that we can resend including last heiko remark and let heiko
> to pick it from his own tree
> 
> Heiko I will add CoDevelopment if it's ok for you

Fine for me! Thanks!

bye,
Heiko
> 
> Michael
> 
> 
>> Greets
>> Alex
>>
>>> ---
>>>   fs/ubifs/ubifs.c | 9 ++++++---
>>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/ubifs/ubifs.c b/fs/ubifs/ubifs.c
>>> index 048730db7f..6acd6c3776 100644
>>> --- a/fs/ubifs/ubifs.c
>>> +++ b/fs/ubifs/ubifs.c
>>> @@ -319,9 +319,7 @@ static int filldir(struct ubifs_info *c, const char *name, int namlen,
>>>        }
>>>        ctime_r((time_t *)&inode->i_mtime, filetime);
>>>        printf("%9lld  %24.24s  ", inode->i_size, filetime);
>>> -#ifndef __UBOOT__
>>>        ubifs_iput(inode);
>>> -#endif
>>>
>>>        printf("%s\n", name);
>>>
>>> @@ -557,6 +555,7 @@ static unsigned long ubifs_findfile(struct super_block *sb, char *filename)
>>>
>>>                        /* We have some sort of symlink recursion, bail out */
>>>                        if (symlink_count++ > 8) {
>>> +                             ubifs_iput(inode);
>>>                                printf("Symlink recursion, aborting\n");
>>>                                return 0;
>>>                        }
>>> @@ -568,6 +567,7 @@ static unsigned long ubifs_findfile(struct super_block *sb, char *filename)
>>>                                 * the leading slash */
>>>                                next = name = link_name + 1;
>>>                                root_inum = 1;
>>> +                             ubifs_iput(inode);
>>>                                continue;
>>>                        }
>>>                        /* Relative to cur dir */
>>> @@ -575,6 +575,7 @@ static unsigned long ubifs_findfile(struct super_block *sb, char *filename)
>>>                                        link_name, next == NULL ? "" : next);
>>>                        memcpy(symlinkpath, buf, sizeof(buf));
>>>                        next = name = symlinkpath;
>>> +                     ubifs_iput(inode);
>>>                        continue;
>>>                }
>>>
>>> @@ -583,8 +584,10 @@ static unsigned long ubifs_findfile(struct super_block *sb, char *filename)
>>>                 */
>>>
>>>                /* Found the node!  */
>>> -             if (!next || *next == '\0')
>>> +             if (!next || *next == '\0') {
>>> +                     ubifs_iput(inode);
>>>                        return inum;
>>> +             }
>>>
>>>                root_inum = inum;
>>>                name = next;
>>> --
>>> 2.43.0
>>>
> 
> 
> 

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
