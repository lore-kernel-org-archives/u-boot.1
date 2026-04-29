Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D57BFF886F
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 02:14:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9F5184671;
	Wed, 29 Apr 2026 04:14:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=archcloudlabs.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=archcloudlabs.com header.i=@archcloudlabs.com header.b="KB/x+che";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10FA0846AC; Wed, 29 Apr 2026 04:14:30 +0200 (CEST)
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com
 [91.218.175.182])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A46584661
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 04:14:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=archcloudlabs.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dllcoolj@archcloudlabs.com
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archcloudlabs.com;
 s=key1; t=1777428863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p0i8XtGUKQgANw0ECQ9hk0r8ou3plM/q678r1H3pt/s=;
 b=KB/x+cheKscavjhn8WpWgxjDfoCrTVfWKXgXQP6Hdj0m3JZaGGP3OUo6KkdL/9Y1kubQ+v
 /aYec8KklKO7xAwIeCCpvqXo2sWvUed7zeZMpTT4j8XbPrQjwQEvS7XU5v+7S++YDhkPld
 g0dH9z09+QxgeOu7+Ko35bqSEvD5tIa24nVifgKyvtvZ7OKAvN5LjFBwERnTFf9m0Tbztn
 B5HeuoYP40bpTgGzEs0oA2YIyLTP+XqOYao3ALJXRFoDUQxu5A0yfcC5hciq8+7EROQKMs
 RRtimaYVs0CBkK9zyrXRbFYcpDyrG76BBEOQJFu42iKPwZQ4RYkSoSYdAA+eBA==
Date: Wed, 29 Apr 2026 02:14:21 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: dllcoolj@archcloudlabs.com
Message-ID: <08f84ffbb08da4ed1f4a264735632f7a9dcbd4b2@archcloudlabs.com>
TLS-Required: No
Subject: Re: [PATCH] adding check to prevent overflow in sqfs_find_inode
To: "Richard GENOUD" <richard.genoud@bootlin.com>, u-boot@lists.denx.de
Cc: joaomarcos.costa@bootlin.com, thomas.petazzoni@bootlin.com,
 miquel.raynal@bootlin.com, trini@konsulko.com
In-Reply-To: <0e0d12e7-f318-4500-b242-cca9cf1cf709@bootlin.com>
References: <20260428003100.123201-1-dllcoolj@archcloudlabs.com>
 <0e0d12e7-f318-4500-b242-cca9cf1cf709@bootlin.com>
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Richard,


>=20
>=20The commit message should be wrapped between at 75 characters (
> the rule can be bent for log messages like the one bellow, but for the =
description, it's the preferred way)
> You can use scripts/checkpatch.pl to help you with.
>=20
Understood!



>=20
> I'm a little confused by the fix.
> If there's no overflow, we will have offset +=3D sz above (in the __bui=
ltin_add_overflow)
>=20
>=20>=20
>=20> offset +=3D sz;
> >=20
>=20...and again here ^^
> So, sz will be added 2 times instead of one.
>=20
I=20mistakenly thought __builtin_add_overflow just performed the check.
Upon fixing this on my end, I'm still crashing.

I'll dig into this and follow up in a day or so.



April 28, 2026 at 3:01 AM, "Richard GENOUD" <richard.genoud@bootlin.com m=
ailto:richard.genoud@bootlin.com?to=3D%22Richard%20GENOUD%22%20%3Crichard=
.genoud%40bootlin.com%3E > wrote:


>=20
>=20Hi Jared,
>=20
>=20Le 28/04/2026 =C3=A0 02:31, Jared Stroud a =C3=A9crit=C2=A0:
>=20
>=20>=20
>=20> While fuzzing attributes of the squashfs_reg_inode structure, if th=
e file_size attribute is a large value,
> >  &base->inode_number within the sqfs_find_inode function will jump to=
 an arbitrary location
> >  in memory resulting in a invalid memory access and crash.
> >  This bug is similar to CVE-2024-57254 in that memory operations are =
occurring based on inode values.
> >  I applied a similar fixed via the commmit c8e929e5758999933f9e905049=
ef2bf3fe6b140d.
> >=20
>=20The commit message should be wrapped between at 75 characters (the ru=
le can be bent for log messages like the one bellow, but for the descript=
ion, it's the preferred way)
> You can use scripts/checkpatch.pl to help you with.
>=20
>=20>=20
>=20> Prior to the fix, the bug was triggered via the following commands =
from
> >  the U-Boot shell:
> >  ```
> >  =3D> host bind 0 random3.sqfs
> >  =3D> ls host 0 /
> >  AddressSanitizer:DEADLYSIGNAL
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >  =3D=3D122741=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0=
x0000670e4716 (pc 0x55a504b86ea6 bp 0x000019af1280 sp 0x7fff04b3b740 T0)
> >  =3D=3D122741=3D=3DThe signal is caused by a READ memory access.
> >  #0 0x55a504b86ea6 in sqfs_find_inode fs/squashfs/sqfs_inode.c:131
> >  #1 0x55a504b7f17e in sqfs_search_dir fs/squashfs/sqfs.c:489
> >  #2 0x55a504b80ffb in sqfs_opendir_nest fs/squashfs/sqfs.c:977
> >  #3 0x55a504b426e9 in fs_opendir fs/fs.c:669
> >  #4 0x55a504b42a6d in fs_ls_generic fs/fs.c:66
> >  #5 0x55a504b42dc8 in fs_ls fs/fs.c:537
> >  #6 0x55a504b42dc8 in do_ls fs/fs.c:881
> >  #7 0x55a504b42dc8 in do_ls.isra.0 fs/fs.c:870
> >  #8 0x55a504a0eb40 in cmd_call common/command.c:582
> >  #9 0x55a504a0eb40 in cmd_process common/command.c:637
> >  #10 0x55a5049f00c4 in run_pipe_real common/cli_hush.c:1672
> >  #11 0x55a5049f00c4 in run_list_real common/cli_hush.c:1868
> >  #12 0x55a5049f0800 in run_list common/cli_hush.c:2017
> >  #13 0x55a5049f0800 in parse_stream_outer common/cli_hush.c:3207
> >  #14 0x55a50492efcc in parse_file_outer common/cli_hush.c:3299
> >  #15 0x55a50492efcc in cli_loop common/cli.c:306
> >  #16 0x55a50492efcc in main_loop common/main.c:86
> >  #17 0x55a50492efcc in run_main_loop common/board_r.c:584
> >  #18 0x55a50492efcc in initcall_run_r common/board_r.c:776
> >  #19 0x55a50492efcc in board_init_r common/board_r.c:806
> >  #20 0x55a50492efcc in sandbox_main arch/sandbox/cpu/start.c:584
> >  #21 0x7f60aa6276c0 (/usr/lib/libc.so.6+0x276c0) (BuildId: ca0db5ab57=
a36507d61bbcf4988d344974331f19)
> >  #22 0x7f60aa6277f8 in __libc_start_main (/usr/lib/libc.so.6+0x277f8)=
 (BuildId: ca0db5ab57a36507d61bbcf4988d344974331f19)
> >  #23 0x55a50491e414 in _start (/usr/src/u-boot/u-boot+0x285414) (Buil=
dId: 964ae5120238bc46d7af63402fa25331ca86b3b4)
> >  =3D=3D122741=3D=3DRegister values:
> >  rax =3D 0x00000000670e470a rbx =3D 0x000055a504ef7100 rcx =3D 0x0000=
000000020000 rdx =3D 0x0000000000000000
> >  rdi =3D 0x0000000000006fd5 rsi =3D 0x0000000000007abd rbp =3D 0x0000=
000019af1280 rsp =3D 0x00007fff04b3b740
> >  r8 =3D 0x000000004d5f348a r9 =3D 0x00000000670e4716 r10 =3D 0x000000=
0000000501 r11 =3D 0x0000000000000001
> >  r12 =3D 0x0000000000000002 r13 =3D 0x0000000000000001 r14 =3D 0x0000=
0000199caa00 r15 =3D 0x0000000000000001
> >  AddressSanitizer can not provide additional info.
> >  SUMMARY: AddressSanitizer: SEGV fs/squashfs/sqfs_inode.c:131 in sqfs=
_find_inode
> >  ```
> >  > Post-patch, the following behavior is observed:
> >  =3D> host bind 0 random3.sqfs
> >  =3D> ls host 0 /
> >  Error while searching inode: unknown type.
> >  > Signed-off-by: Jared Stroud <dllcoolj@archcloudlabs.com>
> >  ---
> >  fs/squashfs/sqfs_inode.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >  diff --git a/fs/squashfs/sqfs_inode.c b/fs/squashfs/sqfs_inode.c
> >  index ce9a8ff8e2a..d2efc07c78e 100644
> >  --- a/fs/squashfs/sqfs_inode.c
> >  +++ b/fs/squashfs/sqfs_inode.c
> >  @@ -135,6 +135,9 @@ void *sqfs_find_inode(void *inode_table, int ino=
de_number, __le32 inode_count,
> >  if (sz < 0)
> >  return NULL;
> >  > + if (__builtin_add_overflow(offset, sz, &offset))
> >  + return NULL;
> >  +
> >=20
>=20I'm a little confused by the fix.
> If there's no overflow, we will have offset +=3D sz above (in the __bui=
ltin_add_overflow)
>=20
>=20>=20
>=20> offset +=3D sz;
> >=20
>=20...and again here ^^
> So, sz will be added 2 times instead of one.
>=20
>=20>=20
>=20> }
> >=20
>=20Regards,
> Richard
>
