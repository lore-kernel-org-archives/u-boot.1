Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A1DC0219E
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 03:51:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93EEF803CC;
	Tue, 11 Feb 2025 04:51:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DEGCHIKi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AED50806FE; Tue, 11 Feb 2025 04:51:35 +0100 (CET)
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E25E800CF
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 04:51:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linux.alibaba.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hsiangkao@linux.alibaba.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1739245889; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=CTd6Vl7o8+ZAzWgQBfavyB4d/FR4e36IxwODWJTzF0s=;
 b=DEGCHIKiyYmhuImei/HppVdbDi1j2Kqr1SLzfU7nSJQQ6p6gtjmE7xep0SiTczz2J6RsKu7YdK5Tuv53KFflnK/+96/jsOvBdBpTbqDxLrlxZcbTsDPmYpQKFDCGIN8B+ghLdX2d/1iAJ4Fc226Q1p3U7T/7tqORIdqWd/3EF+g=
Received: from 30.74.128.255(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0WPFRzq._1739245887 cluster:ay36) by smtp.aliyun-inc.com;
 Tue, 11 Feb 2025 11:51:28 +0800
Message-ID: <7e9d99b5-59c9-47ed-a5c9-c4449e3068c0@linux.alibaba.com>
Date: Tue, 11 Feb 2025 11:51:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Security vulnerabilities report to Das-U-Boot
To: Tom Rini <trini@konsulko.com>, Jonathan Bar Or <jonathanbaror@gmail.com>, 
 Huang Jianan <jnhuang95@gmail.com>, Joao Marcos Costa
 <jmcosta944@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: u-boot@lists.denx.de, linux-erofs@lists.ozlabs.org
References: <CABMsoEGyEgWGHYMoL9kH2Os_=krqSTwdLaMu+XSOJd+micYpGQ@mail.gmail.com>
 <20250207155048.GX1233568@bill-the-cat>
 <CABMsoEGLaMGch7gEuGGcyPy5REj4RDAFmX=AGnOmMnnbuSmhWA@mail.gmail.com>
 <20250210164151.GN1233568@bill-the-cat>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250210164151.GN1233568@bill-the-cat>
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

Hi Tom,

On 2025/2/11 00:41, Tom Rini wrote:
> On Fri, Feb 07, 2025 at 09:53:01AM -0800, Jonathan Bar Or wrote:
> 
>> Thank you.
>>
>> So, I'm attaching my findings in a md file - see attachment.
>> All of those could be avoided by using safe math, such as
>> __builtin_mul_overflow and __builtin_add_overflow, which are used in some
>> modules in Das-U-Boot.
>> There are many cases where seemingly unsafe addition and multiplication can
>> cause integer overflows, but not all are exploitable - I believe the ones I
>> report here are.
>>
>> Let me know your thoughts.
> 
> Adding in the eorfs and squashfs maintainers..
> 
>>
>> Best regards,
>>              Jonathan
>>
>> On Fri, Feb 7, 2025 at 7:50 AM Tom Rini <trini@konsulko.com> wrote:
>>
>>> On Thu, Feb 06, 2025 at 07:47:54PM -0800, Jonathan Bar Or wrote:
>>>
>>>> Dear U-boot maintainers,
>>>>
>>>> What is the best way of reporting security vulnerabilities (memory
>>>> corruption issues) to Das-U-Boot? Is there a PGP key I should be using?
>>>> I have 4 issues that I think are worth fixing (with very easy fixes).
>>>>
>>>> Best regards,
>>>>              Jonathan
>>>
>>> Hey. As per https://docs.u-boot.org/en/latest/develop/security.html
>>> please post them to the list in public. If you have possible solutions
>>> for them as well that's even better. Thanks!
>>>
>>> --
>>> Tom
>>>
> 
>> Filesystem-based Das-U-Boot issues.
>>
>> == erofs
>>
>> === Integer overflow leading to buffer overflow in symlink resolution
>> In file `fs.c`, when resolving symlinks, the function `erofs_off_t` gets an `erofs_inode` argument and performs a lookup on the symlink.
>> The function blindly trusts the `i_size` member of the input as such:
>>
>> ```c
>>      size_t len = vi->i_size;
>> 	char *target;
>> 	int err;
>>
>> 	target = malloc(len + 1);
>> 	if (!target)
>> 		return -ENOMEM;
>> 	target[len] = '\0';
>>
>> 	err = erofs_pread(vi, target, len, 0);
>> 	if (err)
>> 		goto err_out;
>> ```
>>
>> The `erofs_inode` structure's `i_size` member is defined with the type `erofs_off_t` (which is a 64-bit unsigned integer).
>> Thereofre, if supplied as 0xFFFFFFFFFFFFFFFF, the `len + 1` input to `malloc` would overflow to 0, allocating a chunk with 0.
>> That chunk (saved in `target`) is later written with `erofs_pread`, overriding the chunk with partial data controlled by an attacker.
>> Therefore, we will have a heap buffer overflow due to an integer overflow in `len` calculation.

Yeah, it's a corner case, I will try to address it later.

Thanks,
Gao Xiang
