Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD521C2BD09
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 11:19:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B07988667;
	Fri, 12 Jul 2024 13:19:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ECFfxkUv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A87A88709; Fri, 12 Jul 2024 13:19:50 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A966E87FF7
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 13:19:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1720783173; x=1721387973; i=xypron.glpk@gmx.de;
 bh=Wv3C/n9NiVdWTmfzSKYHhyGOBQypYMaAOfkOgNyPPEk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ECFfxkUvFkFnMVtpeuvf8DC7S17rDs1YXIKXs2Q2vy+KPCsqgFN5sEHpt1Ckx6tO
 MERDQKRXc46gEdorC1LLM4y9ef0UEv31bz156PyD1BL8Gu0lBVofO7cvhY7ptQcnh
 0F42vrimeM+nFj+ksMoMVx5eXk1+Iz8hiS0rif/lJWk5sNpwSpHjweEkJEWDJd2Zx
 qi7yqB7PyOsOXzRK3oydEtooBHSiSF35M/XjoDZFIX/kAcCezyYCtiWcyLKLCx2Lf
 l0RH+i6t3r2SnZMnftZmG2TQJ/Wt2KyS/sAjqTNYcMnE+a1MvKU8qK77smf8VVvaF
 05mz2Y7XG5Z0skwcOg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([62.143.93.80]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MSt8Q-1swb0d2Fws-00JpIu; Fri, 12
 Jul 2024 13:19:33 +0200
Message-ID: <59ebc379-66f7-493a-b024-fcc3224b320c@gmx.de>
Date: Fri, 12 Jul 2024 13:19:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ext4: Fix integer overflow in ext4fs_read_symlink()
To: Richard Weinberger <richard@sigma-star.at>
Cc: Jixiong.Hu@mediatek.com, sjg@chromium.org, patrick.delaunay@foss.st.com,
 ilias.apalodimas@linaro.org, seanga2@gmail.com, trini@konsulko.com,
 upstream+uboot@sigma-star.at, u-boot@lists.denx.de, upstream@sigma-star.at,
 Richard Weinberger <richard@nod.at>
References: <20240702194223.31998-1-richard@nod.at>
 <96973f0e-a185-4758-8e8c-837206c6bdde@gmx.de>
 <3244366.vfdyTQepKt@somecomputer>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <3244366.vfdyTQepKt@somecomputer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:imb+WAq7PFRNy/cjktUXxRQAx9q17nQjM50dG/RyVfLnmDfABXV
 cFovXBiq6HBR9dn5y/gLcnb9YeF9vteG1hlPycoQsKNEf12ddXM8979d9k45Ayaem5v8gPm
 ++NtnsHhF+iji0jlOV07N63LF2733uXzsXNYPcnylosRKqxLfl6InvwtWDUQjBtNpeyw6O/
 d2iNV+uyfrpNaTVHHOa2g==
UI-OutboundReport: notjunk:1;M01:P0:ObXjwEL+pW4=;oS7/zUxOjYtQoiA3qubJDf2eJMJ
 BWofofQVOFKsqpHHbpCpgs/3COhQ6MDkQITYPMF4/Yrd0stMsrA3XoNMooGVi4FOQUusEAOS9
 zpQdqAHtHnD6Nd6WqKvAw8JWPZeun+MXNbtrAjBwMEo/p5o4SJSAVtl4KA9zbOykq3TiEDbKy
 vis5H8XDbVyB7OVrsa+XyyLeeTpAplDbP1soobmlkF5Z0EZc6JQgh/+ieh0FOd2AbuFNry/Ng
 bKl3FIbL+yWVmN7N1tUouLOwPNF2Mt4m1glqS2M7q1E4aRXLE8C8B01O5sasq5ADvS5CTx0lQ
 KLY7afnKKaxlydS/feroAF7d+fpbeYqATYCWlJEH6JmtwnCyckYS8XCA3Tu3x8pio4pBPmyDi
 dRm9c5ZMByhKegXfuJCZafJj9lCYpjcBKNZ4oN3KkgLoEUqE4xmlF4ihTQs8SkgpILo0lWO9U
 EQ37PVnYm1oaBOjLP/t1g0VxUJ/7wj4flGdn5iat4xQW4zlf/wX6IHv2VByKe9hqwQ+b/zknp
 dXA6qUnjIeWujzZW6+AgkBSwgtptCMiLZgm08tz+abEyE8lic7ex2C4xDSLhqfSmCuii2ihYY
 Mrbw0RhGpUjJndbgAZmYLZbvRgtiNp2kLaoaDXKq1PE/DS1oPMYYo90Jnqwna7GSvjk1LlmEY
 sBjom5YdeNmHmPh+41ytbBDyjV/4Lhsd9wFQuCZkna2Pajm54uqu4xLQpOch4Ayh+JOhlweaj
 SIq28LFipH/SCDkIZ3fW+jz4KTrl2dJKoJxuIlnN4xr89aPD49W7HpxgSXF0lOsarLDM6jJ8+
 Ok6+4sFTJ7qdF3e4EldcrmlA==
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

On 12.07.24 13:14, Richard Weinberger wrote:
> Am Freitag, 12. Juli 2024, 13:10:12 CEST schrieb 'Heinrich Schuchardt' v=
ia upstream:
>> On 02.07.24 21:42, Richard Weinberger wrote:
>>> While zalloc() takes a size_t type, adding 1 to the le32 variable
>>> will overflow.
>>> A carefully crafted ext4 filesystem can exhibit an inode size of 0xfff=
fffff
>>> and as consequence zalloc() will do a zero allocation.
>>>
>>> Later in the function the inode size is again used for copying data.
>>> So an attacker can overwrite memory.
>>>
>>> Avoid the overflow by using the __builtin_add_overflow() helper.
>>>
>>> Signed-off-by: Richard Weinberger <richard@nod.at>
>>> ---
>>>    fs/ext4/ext4_common.c | 7 ++++++-
>>>    1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/ext4/ext4_common.c b/fs/ext4/ext4_common.c
>>> index 2ff0dca249..32364b72fb 100644
>>> --- a/fs/ext4/ext4_common.c
>>> +++ b/fs/ext4/ext4_common.c
>>> @@ -2183,13 +2183,18 @@ static char *ext4fs_read_symlink(struct ext2fs=
_node *node)
>>>    	struct ext2fs_node *diro =3D node;
>>>    	int status;
>>>    	loff_t actread;
>>> +	size_t alloc_size;
>>>
>>>    	if (!diro->inode_read) {
>>>    		status =3D ext4fs_read_inode(diro->data, diro->ino, &diro->inode)=
;
>>>    		if (status =3D=3D 0)
>>>    			return NULL;
>>>    	}
>>> -	symlink =3D zalloc(le32_to_cpu(diro->inode.size) + 1);
>>> +
>>> +	if (__builtin_add_overflow(le32_to_cpu(diro->inode.size), 1, &alloc_=
size))
>>
>> U-Boot is freestanding code. You cannot use built-ins.
>
> Hm, I see man built-ins in the U-Boot source.
> Why is this one special?

See the definition of COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW in
include/linux/compiler-clang.h.

Best regards

Heinrich
