Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95BD3C3DA50
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 16:36:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C89F86B87;
	Thu, 17 Aug 2023 18:36:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="luhp3poh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE74986B91; Thu, 17 Aug 2023 18:36:53 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4542286B7E
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 18:36:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1692290207; x=1692895007; i=xypron.glpk@gmx.de;
 bh=YfWdbEBoFSRqKqqQ9JDwBEP9Hm5ozpBYwDTwZf2fs/4=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=luhp3pohm0kSx13BwCdra+UMRvhEHHDMzYbrejmo1VfOsqJcI8dyrnaGdUeSga++mRXtBmo
 VEnap2Ma13jOgOM7SBf9szJTdf3QqQGV3oXkzwbdm1f33gWzFEXKAxnVIw1N41l7vYEBlyh46
 1/4DbM+ufID9XSZeUoYnDPkRaB3tmKG0JIGAhm+MrFHFP6P8qHWjpttan076zFnrUYyVdSfH5
 6PHkw6DrtlwF3VdpbjY8hMFAYjXm2/62D9gCXkcHJiYFF4h6GH/xlVoYDnvTEFT9/LukaZm9y
 4AjaLNgl0t/y0WR6Ox1hng1ZtvNKxDY1GEPYATs2qRNtxroYIs+w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([62.143.244.162]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N49hB-1pp3fC05eT-0102fR; Thu, 17
 Aug 2023 18:36:47 +0200
Message-ID: <dfac4932-7cbc-3a4e-bde7-c2048516ddf1@gmx.de>
Date: Thu, 17 Aug 2023 18:36:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Doc style for method functions
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: linux-doc@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Jonathan Corbet <corbet@lwn.net>
References: <CAPnjgZ0vPwd9v+V8Pg5Bo87OELD-vokB7ZrvU3Bv5dQ_O9z6Sg@mail.gmail.com>
 <877cpusybz.fsf@meer.lwn.net>
 <CAPnjgZ3Lo4Na7YeKPFaY30bwsv_gBGapN_DXeab+k7yhCF3uww@mail.gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAPnjgZ3Lo4Na7YeKPFaY30bwsv_gBGapN_DXeab+k7yhCF3uww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RAaueV9ewgc9CAWOYC5n2wrMEia0Y/KzEN23+g5Gkfw6w5WZZHx
 +y6YSta7UoOSqD2YGirZb6wbG2sLYbDwWrA+FaePKP93lrnCGNIe11UpZtqyc/SxA++lQV5
 R8aQYwIT9wjazJOsTO1dknEJcDTuGv7kyTT+hzxBEIeEHOR5Q8FjvvRKYhafKmbJNcN5DDR
 OinxeZVsKYYb3a0Wxg9FQ==
UI-OutboundReport: notjunk:1;M01:P0:ZhfQWipqPjg=;vy1XGRb6DQ6m79qCADRPI5OC3vV
 9MyRPJfwp9P3xNOGwqoAOWTHaIltVA8rnUUE+8mKdNJLyf18zvA/reV4vHU7OxVvcvi9XE8zP
 lxriUcg5rVBRp0MxKgymaJPqqNG0ly1JHQrL4i4oY+GLizD1BvVZ+jkcGpJ2XbR+4d3zy9/Pr
 8ywPU0hiGCKlh4Nl3OHq+6dDOL48gImw5MW7muiTQotKMD4UotvVvhm4wRFWD6T1n7/Iw8HYQ
 yHQ7DI6x4v0d/VgBwIlfW18lHnFYsX99D8kUqDFLj1i/LELZUbI4kwY9scJIVG3qqiJlWNFkg
 7han2kZWQHAdDm/ukoxsBCXRJf8AUYYBwbg7WLqHCdQbSrapDLoE6VXvGt3MwM9np/4uAVPHC
 NKzPogrGueoFBoutUsQNnpTxsPbAK1IHbktq7/vG6GvdWV/HAPIvsNTOVqo60AfYHqKaP0woU
 yilnWaryzfcFAejIfc2vKNoAvvta4YPKS531m0LSA0muH2N5Fs/9iD1FGkcjJcN5qi5XgWDGJ
 hriw37MClayErHr81ujP0BPCeRStdbWgmnW+n3Gq6M+DdCSfZOpXWYZLbORLyCbgWhjAy/BNf
 IcB9nEsw4+iBeKx4AJ2PWDaH+WImD74+bIwp6QR7uk1GGtWSIU2HjYRaPgF4ByAbcDoGIntbj
 BeH8TAk8rCN3RMjoOxyo6PQAr2wD3cYD4YD5TZ7wsGk5axSf6bvBId6+/nHqpUYb68e99+ELA
 h1ynw0cNzggjkghMRbmOUSBcApYusmJLYwdjIgvLPllCgEboBxzsukw5qjUdfGqWmcBA5gMD8
 Y8CrVhXlhL+Ao2UM1imtpsF/wk4YrHvdf08y00T2e52ogzwSs0RTs8SCUcgM6P8s6inFjdARn
 x3mijVxLbnpSDB71rJt8O5rtFAjyx/jGQ0UfIo0z3gZABiOdDykADy7L9Uw12jeauTmjoucky
 WhDHi7Rw1Q5cL74rIinXENSXkag=
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

On 16.08.23 19:47, Simon Glass wrote:
> Hi Jonathan,
>
> On Wed, 16 Aug 2023 at 11:15, Jonathan Corbet <corbet@lwn.net> wrote:
>>
>> Simon Glass <sjg@chromium.org> writes:
>>
>>> Hi Jonathan,
>>>
>>> I would like to do something like this:
>>>
>>> struct part_driver {
>>>     /**
>>>      * get_info() - Get information about a partition
>>>
>>>                ^ causes error
>>>
>>>      *
>>>      * @desc: Block device descriptor
>>>      * @part: Partition number (1 =3D first)
>>>      * @info: Returns partition information
>>>      */
>>>     int (*get_info)(struct blk_desc *desc, int part, struct
>>> disk_partition *info);
>>> ...
>>> };
>>>
>>> But this gives:
>>>
>>> scripts/kernel-doc:292:
>>>     print STDERR "Incorrect use of kernel-doc format: $_";
>>>
>>> Without the brackets on get_info() it works OK. What is the purpose of
>>> that check, please?
>>
>> That's how the kerneldoc syntax was defined, well before my time as the
>> maintainer.  This could be relaxed, I guess, but one would have to look
>> at the parsing code to be sure that the right thing happens all the way
>> through the process.  I'm not entirely sure it's worth it...
>
> I see. It is inconsistent, since we use () after normal functions.
>
> I think I can fix it just by removing that check.
>
> Regards,
> Simon

If the structure element in not a function pointer, we probably still
want to forbid adding parentheses. Just dropping the check might not be
the solution.

Best regards

Heinrich
