Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CFB8C43458
	for <u-boot@archiver.kernel.org>; Sat, 27 Jun 2026 06:20:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A998B8404D;
	Sat, 27 Jun 2026 08:20:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="ZjJ6Gquk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26F3184105; Sat, 27 Jun 2026 08:20:08 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABAAC8056B
 for <u-boot@lists.denx.de>; Sat, 27 Jun 2026 08:20:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wqu@suse.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4926046fbc5so18563685e9.0
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 23:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782541201; x=1783146001; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=SFzdlb27/MpaRmEwRFHERvB6j30+IAbPz8fBlXt96Ik=;
 b=ZjJ6GqukZ/8NYuKMM6VaUagTGWIpppW30TLsGiMt19KgDxfvz/JaV19BCpiY0oG2Cq
 fEfPAQudvFONsZ4pUGO0uSUyHGtGAUJ0jKiEl8KIeEy5+NJNo+3HH0ySkbTJQB5yEw64
 DsmWQZXv0L7XVSXI556mFJkTLTZxsRnOe7Jx3ZCvgDDE4h6DoBG4QYoSOGeiYAM0Kv0S
 bnQDsaJYb2fDlqIE6hjSxdVHQwSPwrZEV0nFYae2kmeGM7sGIVhdyynjy4EzPwAJ7QBp
 FPE+7ODqZzcNuF1TrDiku/Sjji+U4MCgqSM5Vkr5G4lxK5jkxMAIAjHZg+DmDbO3yBTJ
 VBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782541201; x=1783146001;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SFzdlb27/MpaRmEwRFHERvB6j30+IAbPz8fBlXt96Ik=;
 b=o4ulODKaAMdA/vhc3n7rrSuq5nL3ytAGdznleUKX2XGjSi8ZbiW0pZ7SCcLcIiP0gO
 yTd3GiYlM59TY+yR1BjBpx76KO/qcTum3XiaF2m/oqY184eALtRR7WbzlIeE8pydQW6o
 M5jxWvJQjwda9eVpOGfyvhi/laYXLWI5ZT2nwodnRT7VX7ArdKMgKNbGL16LzQ7TnFKM
 36ttv0kBEcjjvOcACDWuBjdDIlxF4pF2RjSrWz49/dMKvgfOIf9gOxrbnTnf1OUIvuHg
 btVM7KPEhvHym3P/k4NGCbV1girWbrD08P5w0g/jA7ns4uOvQb5bsZD3djAC1sswep3b
 TYmw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9skFn7C/p2mZu9/I5xNPntp69OEfvEAghr91KhZVHCautjlZ0vFUd9742aRK+9ZEiXFaaAUNM=@lists.denx.de
X-Gm-Message-State: AOJu0YyWbfJ4dOvtzmZ43+EprmBnsNbEsca/axaTuHEcf0pB1H+aP998
 /erh07wZucaR2kJsqajAQPD+Pq468Zscl3lYDUZx0dzR5k228IHs5wELLiAKpxFKVu0=
X-Gm-Gg: AfdE7cnFlel0KcSqYhImXSGrMRrBO1ktI8v0gdffx5hhtW2LIBAoPGFgXlmt/EUNYac
 7nMbOq24g+GrkG0yvTfli1gGFdCZNqusGmFoXfWr+W4MjIoHGeki7rR/0ol1EP8ANhV3r0yjVOb
 R1ugd3jxMJyQ+2QU0MgY9iVLqCxOwBek73jK2KrvhYuVZfYkRw5N22LfQ6Et7zyEk9cgYQ16QQt
 shfOnoxCH8Z8dE6kIKhOJob2MdgmE8INO4AP9OP5pQpbLG5zl07Wghu/HCB1JyCWOLOQPH5kFJg
 ye3G9f6WBbmoVGisaf1+B50Xfk8TTHk7HvhYAtd13F9BzKde04CiPl9wKLpX/p/1ulaBB81iz4/
 dHyLHCabuv3+tb8XntMh0Luk9qzou8hwkFxErsxDdtuout9ll+a5t0mNL40Spv2X2GTClbFN295
 0j1nogmTRdUcvI1zlQrn0KoL2fJ0lr5C/jeozsbFc=
X-Received: by 2002:a05:600c:8b28:b0:493:72d2:e96f with SMTP id
 5b1f17b1804b1-49372d2ebcemr7847095e9.5.1782541201028; 
 Fri, 26 Jun 2026 23:20:01 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299?
 (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7cac87dcsm27871297eec.31.2026.06.26.23.19.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2026 23:19:59 -0700 (PDT)
Message-ID: <b10b2e22-37bd-4b92-b999-d2403321835d@suse.com>
Date: Sat, 27 Jun 2026 15:49:51 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] fs: btrfs: implement opendir(), readdir() and
 closedir()
To: Alexey Charkov <alchark@flipper.net>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org, u-boot@lists.denx.de,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 =?UTF-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>,
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Yao Zi <me@ziyao.cc>
References: <20260626-btrfs-readdir-v2-0-7dd43f72d1b4@flipper.net>
 <20260626-btrfs-readdir-v2-1-7dd43f72d1b4@flipper.net>
 <09eca73c-1f50-46b2-a307-76eef0408159@gmx.com>
 <CAKTNdwEdonby8W9=iD54Fw1UVH88CBmjf+3L9r-jCUfhZrxzpw@mail.gmail.com>
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
In-Reply-To: <CAKTNdwEdonby8W9=iD54Fw1UVH88CBmjf+3L9r-jCUfhZrxzpw@mail.gmail.com>
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



在 2026/6/27 15:29, Alexey Charkov 写道:
> On Sat, Jun 27, 2026 at 2:27 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
[...]
>>> +     key.objectid = dirs->subvolid;
>>> +     key.type = BTRFS_ROOT_ITEM_KEY;
>>> +     key.offset = (u64)-1;
>>> +     root = btrfs_read_fs_root(fs_info, &key);
>>
>> You can save the root pointer into btrfs_dir_stream, so we can avoid
>> subvolume root lookup for each dentry.
> 
> That was in fact the first thing I tried, but turns out that it
> doesn't work because a root pointer created with one fs_info structure
> stops working once fs_close at the end of the generic fs opendir
> caller closes the fs and deallocates the fs_info structure, due to it
> referencing trees allocated for that instance of fs_info. The result
> is a synchronous abort.
> 
> Hence the comment above the btrfs_dir_stream definition and this
> second-best solution.
> 
> Please let me know if I've missed a more elegant option!
> 
> Closing and reopening the fs at every call which the FS layer does
> sounds like a huge overhead, but I must assume it was unavoidable when
> the interface was designed.

Oh, I wasn't aware that u-boot closes the fs after opening the dir, 
that's sounds very weird.
But if that's the case, the current one is indeed our best solution.

Thanks for point this out.

With that said, the series looks good to me now.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> 
>> You do not need to bother the lifespan of subvolume roots either, they
>> are properly released during the close of the fs.
>>
>> Otherwise looks good to me, except an unrelated question just lines below.
>>
>>> +     if (IS_ERR(root))
>>> +             return PTR_ERR(root);
>>> +
>>> +     memset(dent, 0, sizeof(*dent));
>>> +     ret = btrfs_next_dir_entry(root, dirs->ino, &dirs->offset, dent->name,
>>> +                                sizeof(dent->name), &type);
>>> +     if (ret < 0)
>>> +             return ret;
>>> +     if (ret > 0)
>>> +             return -ENOENT;
>>
>> I'm not sure what is the proper/preferred/sane handling of end of directory.
>>
>> Ext4/fat returns -ENOENT, squashfs returned -1, erofs return 1, exfat
>> returns 0 but without populating @dentp.
>>
>> Personally I found the exfat behavior more sane, but considering the
>> caller fs_ls_generic() doesn't really bother the return value but only
>> cares if @dent is populated, it should be fine either way.
>>
>> But still, returning -ENOENT will populate errno, which may be confusing
>> for debugging.
>>
>> Anyway it's an unrelated nitpick.
> 
> Happy to switch to exfat-like behavior. I was only looking at ext4
> implementation as that is likely the most widely used and tested in
> various corner cases, but it sounds like either way should work.
> 
> Thanks a lot,
> Alexey

