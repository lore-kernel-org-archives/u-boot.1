Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B49E784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:45:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90E4587128;
	Mon,  2 Oct 2023 03:43:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ldWuF24x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18FA28719D; Mon,  2 Oct 2023 03:43:32 +0200 (CEST)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDB0587128
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:43:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-41995d42c3bso3893431cf.1
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696211008; x=1696815808; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Nv4Re5cRpHhSCuctM/9DunHrrV8XFxlIYZBoMidkAuA=;
 b=ldWuF24xdK+nLurJyTKNOJ20SvL4hkrzN4lbsDu8zgiXLmow4V6Sxl6g2xt1xuSq4Q
 T9N14l0KMpvBn03GePyEo2cQ1pAibRS4zU4RmfYCTvoa5tDN3kAi4C0lb/ljyl8lN9ot
 bt7YwoxSWIF0Sx9ApK6Y5cMTpBazjlqvZ3BuTJKbbdcwov4NFSGfNBo+AIz45FCagURg
 s0HEOcaALdVfTmHzkFMCYtfRfdfv8hX590gz0OvJ7p9Oz7lnK/yVctbcmqmUwCCtA0s9
 J4aX9WcQH84YAi4LsuUBLJb2WCPcG+uqAPaQBoRh8FcxvoAoG7SLNThxooHv8GFHPxzO
 fHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696211008; x=1696815808;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nv4Re5cRpHhSCuctM/9DunHrrV8XFxlIYZBoMidkAuA=;
 b=MDZokD61RzwTmtKk7SBf8E8b5Hpxwb8sK1I0om0Vr8pZ1hpcV+B7rOh88typPcGfR4
 PCl+fyKFGnvo39wgaFF9pSQ5Xj7wx5KYGMQdrYDflBnTgp5kmkbYid7g9YrlhOrEHDPv
 A9jZvk/uHq1q18a0SvUrphEQeO5xGXyT5cdQ85/mummyDaNCFh3mawW2Q1awoBtuFtWo
 r8s3hiTomrrhG2+/m0ANraw/r9gcmX06rOfEakOlzsh3hsPvdYVVpnPaQVZ8bNm25y6Y
 CVAP5ri5hM7G1z8eSEDvT8TrIHxibUyGznPdf92HbtLJK2wx3FH8HOaIqgU93pc1/lt3
 JH1Q==
X-Gm-Message-State: AOJu0YzI4M6MbBQJyDWzW2oJijklkv7+iWhR0SzbwdeWa4mHZLzqbVNR
 p4Oe7U98TnicN8WAjmWz7ng=
X-Google-Smtp-Source: AGHT+IFhZUyWRafJZregAAoXIp3QdEg/aeszL20t3vbFmwSEwfV1EQ2+TSaC3TbvaKhTmeXpPiSVyg==
X-Received: by 2002:a05:622a:130b:b0:418:1a08:729 with SMTP id
 v11-20020a05622a130b00b004181a080729mr12221703qtk.10.1696211008443; 
 Sun, 01 Oct 2023 18:43:28 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 r15-20020ac87eef000000b004181a3eeff4sm5303195qtc.5.2023.10.01.18.43.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Oct 2023 18:43:28 -0700 (PDT)
Message-ID: <29c14b2a-8872-ba11-b1de-040fb68da416@gmail.com>
Date: Sun, 1 Oct 2023 21:43:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] linker_list: Fix ll_entry_get alignment
Content-Language: en-US
To: Simon Glass <sjg@google.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>
References: <20230930143623.318903-1-seanga2@gmail.com>
 <e3663767-0f99-aadc-924c-5295dafc1e6a@gmail.com>
 <CAPnjgZ32HSq0TOaULvt+TJ3NNeT7ScCVZFh3ft4sqtNZ7QRH6Q@mail.gmail.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <CAPnjgZ32HSq0TOaULvt+TJ3NNeT7ScCVZFh3ft4sqtNZ7QRH6Q@mail.gmail.com>
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

On 10/1/23 21:16, Simon Glass wrote:
> Hi Sean,
> 
> On Sat, 30 Sept 2023 at 09:23, Sean Anderson <seanga2@gmail.com> wrote:
>>
>> On 9/30/23 10:36, Sean Anderson wrote:
>>> When ll_entry_get is used on a list entry ll_entry_declare'd in the same
>>> file, the lack of alignment on the access will override the
>>> ll_entry_declare alignment. This causes GCC to use the default section
>>> alignment of 32 bytes. As list entries are not necessarily 32-byte aligned,
>>> this will cause a gap in the linker list, corrupting further entries.
>>>
>>> As a specific example, get_fs_loader uses DM_DRIVER_GET(fs_loader) in the
>>> same file where U_BOOT_DRIVER(fs_loader) is present. This causes a crash
>>> when walking the driver list.
>>>
>>> Fix this by adding appropriate alignment to all accesses.
>>>
>>> Fixes: 42ebaae3a33 ("common: Implement support for linker-generated arrays")
>>> Signed-off-by: Sean Anderson <seanga2@gmail.com>
>>> ---
>>>
>>>    include/linker_lists.h | 5 +++--
>>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/linker_lists.h b/include/linker_lists.h
>>> index f9a2ee0c762..e0c8a01b9ba 100644
>>> --- a/include/linker_lists.h
>>> +++ b/include/linker_lists.h
>>> @@ -209,7 +209,8 @@
>>>     */
>>>    #define ll_entry_get(_type, _name, _list)                           \
>>>        ({                                                              \
>>> -             extern _type _u_boot_list_2_##_list##_2_##_name;        \
>>> +             extern _type __aligned(4)                               \
>>> +                     _u_boot_list_2_##_list##_2_##_name;             \
>>>                _type *_ll_result =                                     \
>>>                        &_u_boot_list_2_##_list##_2_##_name;            \
>>>                _ll_result;                                             \
>>> @@ -229,7 +230,7 @@
>>>     * @_list: name of the list
>>>     */
>>>    #define ll_entry_ref(_type, _name, _list)                           \
>>> -     ((_type *)&_u_boot_list_2_##_list##_2_##_name)
>>> +     ((_type __aligned(4) *)&_u_boot_list_2_##_list##_2_##_name)
>>
>> OK, so this causes an error in clang. And it isn't really necessary
>> because the entry is already declared at this point.
>>
>> So I guess the right fix is to replace DM_DRIVER_GET with DM_DRIVER_REF in
>> get_fs_loader. But this seems like a really big footgun. You can use the
>> wrong one and there are no errors except at runtime. I wonder if we can add
>> a warning of some kind?
> 
> I can imagine having a runtime check, something like:
> 
> ll_check(sizeof(struct something))
> 
> which checks that the linker list (end - start) is a multiple of the
> struct size. Do you think that would find the problem?

Most of the time, yes.

> If so, then it could be perhaps be turned into a link-time check. This
> produces a list of the linker lists along with their individual
> members:
> 
> or ll in $(nm /tmp/b/coreboot/u-boot |grep u_boot_list_2 |sed
> 's/.*_u_boot_list_2_\(.*\)_2_.*/\1/' |uniq); do echo; echo "linker
> list: %ll"; nm /tmp/b/coreboot/u-boot |grep $ll; done
> 
> ...
> linker list: ut_str_test
> 011a9a20 D _u_boot_list_2_ut_str_test_2_str_dectoul
> 011a9a30 D _u_boot_list_2_ut_str_test_2_str_hextoul
> 011a9a40 D _u_boot_list_2_ut_str_test_2_str_itoa
> 011a9a50 D _u_boot_list_2_ut_str_test_2_str_simple_strtoul
> 011a9a60 D _u_boot_list_2_ut_str_test_2_str_simple_strtoull
> 011a9a70 D _u_boot_list_2_ut_str_test_2_str_trailing
> 011a9a80 D _u_boot_list_2_ut_str_test_2_str_upper
> 011a9a90 D _u_boot_list_2_ut_str_test_2_str_xtoa
> 011a9aa0 D _u_boot_list_2_ut_str_test_2_test_str_to_list
> ...
> 
> Then you can check that the address of each one increments by the same amount.
> 
> Maybe.

Yeah, this would be the best way to find errors in the current system.

But maybe ll_entry_get should look like

#define ll_entry_get(_type, _name, _list)				\
	({								\
		ll_entry_declare(_type, _name, _list);			\
		_type *_ll_result =					\
			&_u_boot_list_2_##_list##_2_##_name;		\
		_ll_result;						\
	})

(untested)

Regardless, I think a link-time check would be a good sanity check.

--Sean
