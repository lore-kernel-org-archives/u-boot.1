Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA54CDE008
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 10:23:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A31648460E;
	Fri, 26 Jun 2026 12:23:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="VUFjW7Wg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 586B18494B; Fri, 26 Jun 2026 12:23:55 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 906D78404D
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 12:23:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wqu@suse.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4924f8db066so3910105e9.2
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 03:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782469432; x=1783074232; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Lzs37CHTk7DgicK6OAuLqr6L4003x8EvgSSRyy0ZdYI=;
 b=VUFjW7WgFGay7b4WD+yKYMuhwHfG1OywF1IyiznFlXa3EhevVAEylfbSKt816xiJE7
 jBCID6RoMMVpprfyok3X+4oSUhRH0O73TbLis40NSlIZHPqFQDnBWqjWCog+hJ98O0x+
 p9QKbv9xMABCb1jXRU6QZ2R1Jh7OR+DQs3DFC1lkDTDvQ6KWy56+PxJva4upqL2DZYvd
 72D1utvGYIih4FMyGZIErRAM26OxqptFPDUtIx4aLhdmSNdFfrbSs4qSaRlmh+M93jPX
 eR0CIYegwQBfLhbB0g0yQYF5b0bNxCcHVTXV8+opVA0oUtwKChVFliUVqrTKgei99R3n
 0qJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469432; x=1783074232;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lzs37CHTk7DgicK6OAuLqr6L4003x8EvgSSRyy0ZdYI=;
 b=XuvYKCK6QEjYUeZsfhaDgYovCMhc3+4w34u62b7nygc9YrHbqk3/Ryf+isOZlJyJYL
 zh/SfxPNJzaJt5nM+3HvR2+J/VEKhXyG53mx4Z3wjN7nZyFcJQHm5AfaNwAvAI5wIoWf
 xbyuTG99aXZ1s6ck0K5oz9faOAas9fQKiHDSsb+TjL01wRElkkIuq/y4XtvhAUb9qzHK
 ECrqIT0INDESig4XuA4kAuVH5yxVZU4rlr7NW0FckX5OlK2I1b4zKWMEm+trPNUU31pO
 ZUtdc4/7vBXsKlFsOLqi7zTODPQQbHi0c3iznAG9UKOBUHTmfAZrvYY8SLFSjx+Uw4g9
 9bmw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9nZYW/EzIteO2FoL2Dc7X5jjMWk3B4+WyqhS9XAFo6tR5HCPsGpOqEEKM9YG5Eos26++Tl09s=@lists.denx.de
X-Gm-Message-State: AOJu0Yyrrx8O2J4coXJYWV5zZ9AMuUb89lTLDBzQcFWTMboslHxeyvDm
 iuzPt11HilZSxWlDfoQF6n06ATB/UpwW3bOFbyzpw+z7ISgDx/g9/0FphCGWApCDJLk=
X-Gm-Gg: AfdE7cmMt2z+/ghk+i+4IeEJPu3AlBHYdKHQOvtZjbdPWhkLj6Oogjw34NE+b+jFpvR
 ZCgshuQHrRGzEOf61S9AD91xj9Wy3tgEkO6E6cchSrk747mTSr5qvFii0EGlqsOojlco5sE3f0S
 iRBNSYSbpIadp5Noij81NqcvwhqYV9crbt5XqmicRBkEbehuNzdVgMoIxEy4LPuHj0WvOg6b1Ax
 sM6MiIVitVrWgtZNfwpDCMf3YgQ3vmhBAf70GfgK1nCtRA7lgds0OApWvU9uvcU/qKdZRKPi3jc
 +iC/IOGrBDoH6Nd+TINz8TiGFC5fTDIFbpsKlBYbJMmOQ1dAEeAVfCreFBDItj7YqHPCXzTgyvO
 ZW75Kj2jiSFeJRJwewHdC5DbPEduNgzCBQSo1+va0TcbSCf2WEdoNgyRdSbJL8maCJIeXgNnrps
 puECgI3mM2EfaivgPd6ICz2i7RpdNtfdX8e06CtdQC
X-Received: by 2002:a05:600c:1d04:b0:492:4714:2d7e with SMTP id
 5b1f17b1804b1-492668b76f4mr94619375e9.36.1782469431884; 
 Fri, 26 Jun 2026 03:23:51 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299?
 (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8b1a80sm16265208eec.18.2026.06.26.03.23.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2026 03:23:50 -0700 (PDT)
Message-ID: <46cac806-1f84-4648-a725-6d239763ea0b@suse.com>
Date: Fri, 26 Jun 2026 19:53:42 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] fs: btrfs: implement opendir(), readdir() and
 closedir()
To: Alexey Charkov <alchark@flipper.net>
Cc: linux-btrfs@vger.kernel.org, u-boot@lists.denx.de,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 =?UTF-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>,
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Yao Zi <me@ziyao.cc>
References: <20260625-btrfs-readdir-v1-0-dd781a2b3965@flipper.net>
 <20260625-btrfs-readdir-v1-1-dd781a2b3965@flipper.net>
 <bbeac2f6-685d-4ace-b689-10d64c4e3ce5@suse.com>
 <CAKTNdwGH2OCWJ1A=jQWiLYQmxG8UFTBGwGh0Qno7OkUfxs4dtw@mail.gmail.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <CAKTNdwGH2OCWJ1A=jQWiLYQmxG8UFTBGwGh0Qno7OkUfxs4dtw@mail.gmail.com>
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



在 2026/6/26 18:51, Alexey Charkov 写道:
> On Fri, Jun 26, 2026 at 10:38 AM Qu Wenruo <wqu@suse.com> wrote:
[...]
>>
>> So it looks like u-boot only supports the above 3 types, and unlike
>> linux kernel the values doesn't match the btrfs internal ones.
>>
>> In that case, I'd still prefer a proper convertor function.
> 
> Hmm, but the convertor function would still be the same switch
> statement, and it's only used in this single place. Would factoring it
> out actually improve readability?

This is mostly a cross-project tendency.

Inside kernel, we do not need a conversion because all the BTRFS_FT* 
flags matches the FT_* inside kernel.

In progs we have btrfs_type_to_imode() to do the conversion to S_IF* flags.

Thus I'd prefer a convertor, even if there is only a single user.

> 
>> [...]
>>> +
>>> +             *offset = key.offset + 1;
>>> +             type = btrfs_dir_type(path.nodes[0], di);
>>> +
>>> +             /* XATTRs share the key space but are not directory entries. */
>>> +             if (type == BTRFS_FT_XATTR) {
>>
>> This doesn't looks correct again.
>>
>> XATTR has their own keys, they should not show up among DIR_INDEX keys.

Firstly, xattr is per-inode, not per-dentry.
Thus I doubt if you can hit an XATTR type inside a DIR_INDEX.

The easily way to test the theory is just create a simple XATTR for 
compression:

  # mkfs.btrfs -f test.img
  # mount test.img /mnt/btrfs
  # touch /mnt/btrfs/foobar
  # btrfs prop set /mnt/btrfs/foobar compression zstd
  # sync
  # btrfs ins dump-tree -t 5 test.img
  [...]
	item 6 key (257 XATTR_ITEM 550297449) itemoff 15812 itemsize 51
		location key (0 UNKNOWN.0 0) type XATTR
		transid 10 data_len 4 name_len 17
		name: btrfs.compression
		data zstd

You can see that XATTR_ITEM key is for that inode 257, not for the 
parent directory inode (256).


Secondly, if you check the tree-checker.c from the kernel, 
check_dir_item() will reject an XATTR dir type if the key is not 
XATTR_ITEM_KEY.

So even if you really find a btrfs with XATTR dir type but with 
DIR_INDEX key, btrfs will refuse to reject that tree block.

Thanks,
Qu

> 
> Let me double check and adjust accordingly.
> 
> Thanks a lot for your review!
> 
> Best regards,
> Alexey

