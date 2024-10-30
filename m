Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE30D5CCB0
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 13:41:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CA0388D36;
	Wed, 30 Oct 2024 14:41:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="kFvuXw2w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE02688F1E; Wed, 30 Oct 2024 14:41:14 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBE7788D29
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 14:41:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730295671; x=1730900471; i=xypron.glpk@gmx.de;
 bh=3RVNDrxY8ymtMzdzbilgD3W4+jE4Oh2nIy4yYzXY/zQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=kFvuXw2wBzq4NfxRRpY6Wjz4EufK8b3KwgnuxQR33ax2O9hAuEPIt5lgJVCNTc7B
 DSOsXmdbWMaQoOF94nodO5XN8mHdgQ+dUe9nVgbdroFb8rc8ta/g7vdFY4SCScHcm
 CP1dTzUb95eEg+leYyddbdveu4Kj7YFMzpe1AcI5uw0oe7D43nQqw2wLqk9e0Rgjj
 RryN/q41Ovt4zl3vX5KMySc+FhSIhuWoEHoLxYdDpl0vwmVrUC5NRJvJXk9JhOgAX
 iq9LPMMg5b6fLgtvmf+gNtJN91qwEJtD/M0J9KwZaF2CbSv6sOjclLLipFHsX3bBc
 bW4kZlT3ZbJ0TSqmNA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.150.8.169] ([145.103.114.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MkYc0-1tZOgL0Xfy-00n19R; Wed, 30
 Oct 2024 14:41:11 +0100
Message-ID: <69e2a425-6a6f-4fcb-aa92-fdb25919aa61@gmx.de>
Date: Wed, 30 Oct 2024 14:41:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lmb: Correctly unmap memory after notifications
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20241024104625.1340355-1-ilias.apalodimas@linaro.org>
 <06be7096-2e06-44d6-ba00-55ea578121d8@gmx.de>
 <CAC_iWjJdsJLT6arwynmVx5_fTeOr6rZkp8+AdA1rx_zG6Jandw@mail.gmail.com>
 <CAC_iWjLctP3DuuB8brYUMuhDBwuzpMw6CZ-dhbuaRrSk3O5BYg@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAC_iWjLctP3DuuB8brYUMuhDBwuzpMw6CZ-dhbuaRrSk3O5BYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/XcM1OlusdIn5IBaHbRaEmJkzyS+z5U9bbYwO5HjPKtux18THeB
 AIliERpbicuKtxJeNAAHp01m7UjeP3tPlmY48MRqBpiZ48TbG1SCZBfyPltQFOiCb+9hs14
 ULNq5O5WBBj7FLCoxVmZNz2Sksq7L49IzIocRJwYvGz440/ojFvbTCjA1mKjImJGqoirgiI
 VaKmjHH4sUI414zUNZvPQ==
UI-OutboundReport: notjunk:1;M01:P0:l1C45vq/LfM=;bQbKG//O/MxVSHsL4AoRiUSaGMt
 ctCTe+AmLUSLOOd7MOF3OshWAfBNu2bd2CjPxya4HpQoWtb0kkzWRmHpBkmJR4NgOurJrnwog
 RcBaoeafBqn4ZkU0zvJr5PF1UC61aUSqKJ8NmPbiCemtBXz536IiCpJwleBWocnOBDffg/SOp
 Mnx2rY0kJfPYHFYswlJdQ0Bo0hMam5fDAa8gSe81sGjAgYU5HMIaoTnYpI0Q4TZJAqEkF+STn
 /z7kU3eHKywxWBj+lUhC/YVeC02WJ1uPtEzNsYl/Dfyim461fuv5IkrLLuIuZ0K+7U1T/m6Tx
 o9DfHxUt5AFpURC0LH5WOjVchsVkbAZpzb757waDZBvIymTLcRqqMMXfiiyE0F+hznN0I+gG9
 lFr9EwH8PW3eaHW5unsc+vBo/mBCms1VKdFTSlqKB43QnnYmRq5ITCXecCc/G9xdAdQGoMmZq
 XYRvgqYdu6DCjznXBwTIS3yyFh+XrL2y735HmFP/zHJUsBKyMANwoCM+qPoeqPsJF/7Kr3IJT
 rf/3U5JftoH8w5rNxUMr9ivBwexA2lELDdQGDzXePMOzho0D2UmvLOk1Kp5aw7hTCyZeIBGca
 SpuEPHJqSsZ12exHnibwZCa14XAdI1RtJ/vFFfC5eal2WxHPV/1Q7d3BKjHlRopPZ8t1csDNS
 eyQlzod53izMltQ3T675XlH4sF3F6cOyTxR+9urUSi1BfsCvLV4yGDJ0maqkyVKKMtnAGxehV
 MSnGtkeIydAvCiLW8zKEDpdouXWsitXiNqVEEKfZPj0dZIvmxncEtlSmq4OYw2iDq0bRYkKUZ
 ElmTM9u1qouXkhraiswhkk9g==
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

On 10/29/24 09:48, Ilias Apalodimas wrote:
> Hi Heinrich
>
> On Tue, 29 Oct 2024 at 10:00, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
>>
>> Hi Heinrich
>>
>> On Mon, 28 Oct 2024 at 08:37, Heinrich Schuchardt <xypron.glpk@gmx.de> =
wrote:
>>>
>>> On 10/24/24 12:46, Ilias Apalodimas wrote:
>>>> We never unmap the memory used to update the EFI memory map after
>>>> notifications
>>>>
>>>> Fixes: commit 2f6191526a13 ("lmb: notify of any changes to the LMB me=
mory map")
>>>> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>>> ---
>>>>    lib/lmb.c | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/lib/lmb.c b/lib/lmb.c
>>>> index 890e2cbfdf6b..38c6e1d5ba8d 100644
>>>> --- a/lib/lmb.c
>>>> +++ b/lib/lmb.c
>>>> @@ -65,6 +65,7 @@ static int __maybe_unused lmb_map_update_notify(phy=
s_addr_t addr,
>>>>                        status & ~EFI_ERROR_MASK);
>>>>                return -1;
>>>>        }
>>>> +     unmap_sysmem((void *)(uintptr_t)efi_addr);
>>>
>>> If PCI memory was ever mapped via pci_map_physmem(), I don't think tha=
t
>>> we want to unmap it here.
>>
>> Ok, so looking at it again, not calling unmap_sysmem() here won't
>> break anything, so I guess we can drop this patch.
>
> Looking at it again, for special sandbox tags, we need to correctly
> decrease the refcnt. So why do you think this isnt needed here?
>
> Thanks
> /Ilias


Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

>>
>>>
>>> Why do we map the memory in this notification function first hand?
>>
>> Because the memory was added as such in efi_allocate_pages(). So for
>> sandbox we need to find the correct virtual memory that was added.
>>
>>> Can't
>>> we use len =3D 0 when calling map_sysmem()?
>>
>> We are using len =3D 0. But I am not following up on how could this
>> help. All you will get is a warning for sanbox if a pci device mapped
>> more that 0.
>>
>> Thanks
>> /Ilias
>>
>>>
>>> I guess we have to critically review all map_sysmem() calls.
>>>
>>> Best regards
>>>
>>> Heinrich
>>>
>>>>
>>>>        return 0;
>>>>    }
>>>

