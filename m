Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131A7CCFA03
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 08:54:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E17283B47;
	Thu,  6 Nov 2025 09:54:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="H0jHkKQU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D17F83B48; Thu,  6 Nov 2025 09:54:22 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9047483B22
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 09:54:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id ECAE44034C;
 Thu,  6 Nov 2025 08:54:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E803C16AAE;
 Thu,  6 Nov 2025 08:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1762419257;
 bh=33njn4Wkp1PBXgEPYw/Lgc6IiD4goqmEzepSs+v865o=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=H0jHkKQUs4smpCLvhCQiEPRBSJtXoFPTrFw5TBM0VDH8Cqqbh1twoZzJjrOW5uty4
 n9DPvKRjvCUAPJZMnxt1p80lxfBhqAbj0Ry3FQv/b2zZyIkiSr4PzOpavJY6LRyNs4
 TsLxv++T8s6l38nkjnukfnyxSrUzkh1CcjqiM/PlgDZvEcFA46DLhIeiQNxp+AHQLg
 fBodoMyscUxWK7e4BfCppkHqn3Ga1qHkmHkzaRzPgB6OmNNUFrY9MHUx3MBtI5a3/J
 0io+rQVMHXnDOfpuSrNu85gN6OylJStM6FkydZjhWvAjIo1dueSD76s8Ld0SAEKml0
 +zVQiva1/SJzQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: george chan <gchan9527@gmail.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] boot: bootmeth_android: Conditionally dependent on
 abootimg
In-Reply-To: <CADgMGSssT8veYtjzwPTiyzLWcPZ0TWhAY_FzOV4KHOHRGjQYvw@mail.gmail.com>
References: <20251021-abootimg-minor-v1-1-88a12f53d8de@gmail.com>
 <176192343323.290092.16053648607478981549.b4-ty@kernel.org>
 <87tszb2ts7.fsf@kernel.org>
 <CADgMGSssT8veYtjzwPTiyzLWcPZ0TWhAY_FzOV4KHOHRGjQYvw@mail.gmail.com>
Date: Thu, 06 Nov 2025 09:54:15 +0100
Message-ID: <87zf8zwngo.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Tue, Nov 04, 2025 at 18:40, george chan <gchan9527@gmail.com> wrote:

> Hi
>
> =E5=9C=A8 2025=E5=B9=B411=E6=9C=883=E6=97=A5=E9=80=B1=E4=B8=80 20:19=EF=
=BC=8CMattijs Korpershoek <mkorpershoek@kernel.org> =E5=AF=AB=E9=81=93=EF=
=BC=9A
>
>>
>> Hi George,
>> On Fri, Oct 31, 2025 at 16:10, Mattijs Korpershoek <
>> mkorpershoek@kernel.org> wrote:
>>
>> > Hi,
>> >
>> > On Tue, 21 Oct 2025 00:36:33 +0800, George Chan wrote:
>> >> If target u-boot img do not support androidboot v3 or greater,
>> >> abootimg might not be necessary.
>> >>
>> >> aarch64-linux-gnu-ld.bfd: boot/bootmeth_android.o: in function
>> `boot_android_normal':
>> >>
>> /home/user/sources/u-boot-next/boot/bootmeth_android.c:541:(.text.boot_a=
ndroid_normal+0xd0):
>> undefined reference to `set_avendor_bootimg_addr'
>> >> aarch64-linux-gnu-ld.bfd:
>> /home/user/sources/u-boot-next/boot/bootmeth_android.c:543:(.text.boot_a=
ndroid_normal+0xd8):
>> undefined reference to `set_abootimg_addr'
>> >> Segmentation fault (core dumped)
>> >>
>> >> [...]
>> >
>> > Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu
>> (u-boot-dfu)
>> >
>> > [1/1] boot: bootmeth_android: Conditionally dependent on abootimg
>> >
>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/4b493b96643=
90e16f61a6409ec60676df7759c7b
>>
>> This patch causes CI to fail:
>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/jobs/1283315
>>
>> """
>> building current source for 1 boards (1 thread, 8 jobs per thread)
>>    sandbox:  +   sandbox
>> +cmd/abootimg.c:26:6: error: redefinition of 'set_abootimg_addr'
>> +   26 | void set_abootimg_addr(ulong addr)
>> +      |      ^
>> +include/image.h:2042:13: note: previous definition is here
>> + 2042 | void __weak set_abootimg_addr(ulong addr) {}
>> +      |             ^
>> """
>>
>> This can also be reproduced locally by building sandbox:
>>
>> $ make sandbox_defconfig
>> $ make
>>
>>
>> Can you have a look please? I will have to drop this from my branch
>> until the build error is resolved.
>>
>> If you find a fix, please send a v2 of this patch with the fix included.
>>
> Thx for testing and report. I am sorry that not available for some time so
> please drop this patch or find volunteer to follow this up.

Ok thanks for letting me know.

I'll drop it for now

Mattijs


>
> Regards,
> George
>
>
>> Thanks
>> Mattijs
>>
>> >
>> > --
>> > Mattijs
>>
