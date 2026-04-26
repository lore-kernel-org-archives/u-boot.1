Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBEABFF8850
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 04:55:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC37C83693;
	Mon, 27 Apr 2026 06:55:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=archcloudlabs.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=archcloudlabs.com header.i=@archcloudlabs.com header.b="FFWZgNks";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 610A383FDB; Sun, 26 Apr 2026 22:45:24 +0200 (CEST)
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com
 [95.215.58.177])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C38F80087
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 22:45:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=archcloudlabs.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dllcoolj@archcloudlabs.com
Content-Type: multipart/mixed;
 boundary=6cafb2f3c59859c127b88ea0c9d64ab27fe765b023581055df2ca1b28985
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archcloudlabs.com;
 s=key1; t=1777236320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=Cm4m2oY3KYM2ldZV5kl38dUJ3qryT4KMddZRnoVWHx4=;
 b=FFWZgNksxZ3Akby5cQdKYq1EDv948JEtLdD5ML6xADl3rPrGgqAZIMBSK+kO3H0AvXgOse
 qKU6AZi0aujdYJewwLydVTIzO3atYdBCwz2AWOf/Vf/7CF1QuCwsyLOHurAhLavs8AfH5Q
 +kBUbW4n/J8JZz0GBUsAXAThi62/xiqThM+zk6/FeEKgvj5rJzHrUmYs5kmnUMOwPEii8L
 6DMFHPE1JkXMSww+TsmN6gf8G7M9KxaoxN2b5+7Xy5WlNx5j0jd75GbK+7kzIEqI+6Lnur
 uHbOVqaTyh0ZzNL8PPTuVHqUviiDswRaIbXiZxvFL3KNqolmmP3XxfIdCXk9tg==
Mime-Version: 1.0
Date: Sun, 26 Apr 2026 16:45:15 -0400
Message-Id: <DI3DOZXB8ES4.12PBN3MVHW911@archcloudlabs.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: "Jared Stroud" <dllcoolj@archcloudlabs.com>
To: <trini@konsulko.com>, <joaomarcos.costa@bootlin.com>,
 <richard.genoud@bootlin.com>, <thomas.petazzoni@bootlin.com>,
 <miquel.raynal@bootlin.com>, <u-boot@lists.denx.de>
Subject: [PATCH] fs/squashfs fix overflow in sqfs_find_inode()
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Mon, 27 Apr 2026 06:55:50 +0200
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

--6cafb2f3c59859c127b88ea0c9d64ab27fe765b023581055df2ca1b28985
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello u-boot list,

I found a parsing bug in sqfs_find_inode().=20
While fuzzing the file_size attributes of the squashfs_reg_inode structure,=
 if the file_size attribute has a sufficient large value, &base->inode_numb=
er will jump to an arbitrary location in memory resulting in a invalid memo=
ry access and crash.

I tested this with a modified file SquashFS file system and U-Boot Sandbox =
with release 2026.01.

```
	for (k =3D 0; k < le32_to_cpu(inode_count); k++) {

		// 3) jump ahead in the inode_table from new offset
		base =3D inode_table + offset;

		// 4) attempt to access location in memory
		if (get_unaligned_le32(&base->inode_number) =3D=3D inode_number)
			return inode_table + offset;

		// 1) large file size is read here
		sz =3D sqfs_inode_size(base, le32_to_cpu(block_size));=20

		if (sz < 0)
			return NULL;

		// 2) file size is added to offset
		offset +=3D sz;
	}
```

The crash and resulting ASAN output can be seen below.
```
hit any key to stop autoboot: 0
=3D> host bind 0 random3.sqfs
=3D> ls host 0 /
AddressSanitizer:DEADLYSIGNAL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D75950=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x0000671=
28936 (pc 0x0000006689a1 bp 0x000019b354a0 sp 0x7fff2b718600 T0)
=3D=3D75950=3D=3DThe signal is caused by a READ memory access.
    #0 0x0000006689a1 in sqfs_find_inode fs/squashfs/sqfs_inode.c:131
    #1 0x000000660c79 in sqfs_search_dir fs/squashfs/sqfs.c:489
    #2 0x000000662af6 in sqfs_opendir_nest fs/squashfs/sqfs.c:977
    #3 0x0000006238e3 in fs_opendir fs/fs.c:669
    #4 0x000000623c67 in fs_ls_generic fs/fs.c:66
    #5 0x000000623fc2 in fs_ls fs/fs.c:537
    #6 0x000000623fc2 in do_ls fs/fs.c:881
    #7 0x000000623fc2 in do_ls.isra.0 fs/fs.c:870
    #8 0x0000004eae8e in cmd_call common/command.c:582
    #9 0x0000004eae8e in cmd_process common/command.c:637
    #10 0x0000004da9d6 in run_pipe_real common/cli_hush.c:1672
    #11 0x0000004da9d6 in run_list_real common/cli_hush.c:1868
    #12 0x0000004db112 in run_list common/cli_hush.c:2017
    #13 0x0000004db112 in parse_stream_outer common/cli_hush.c:3207
    #14 0x0000004117eb in parse_file_outer common/cli_hush.c:3299
    #15 0x0000004117eb in cli_loop common/cli.c:306
    #16 0x0000004117eb in main_loop common/main.c:86
    #17 0x0000004117eb in run_main_loop common/board_r.c:584
    #18 0x0000004117eb in initcall_run_r common/board_r.c:776
    #19 0x0000004117eb in board_init_r common/board_r.c:806
    #20 0x0000004117eb in sandbox_main arch/sandbox/cpu/start.c:584
    #21 0x7fb1a66105b4 in __libc_start_call_main (/lib64/libc.so.6+0x35b4) =
(BuildId: 5e8f131adc80bf454af46edf4a1527ae61e1b968)
    #22 0x7fb1a6610667 in __libc_start_main@@GLIBC_2.34 (/lib64/libc.so.6+0=
x3667) (BuildId: 5e8f131adc80bf454af46edf4a1527ae61e1b968)
    #23 0x000000401524 in _start (/usr/src/u-boot/u-boot+0x401524) (BuildId=
: 7121dd98eb40baab73fe6c0941c8200f29e1ad23)

=3D=3D75950=3D=3DRegister values:
rax =3D 0x000000006712892a  rbx =3D 0x00000000009dbaa0  rcx =3D 0x000000000=
0020000  rdx =3D 0x0000000000000000
rdi =3D 0x0000000000006fd5  rsi =3D 0x0000000000007abd  rbp =3D 0x000000001=
9b354a0  rsp =3D 0x00007fff2b718600
 r8 =3D 0x000000004d5f348a   r9 =3D 0x0000000067128936  r10 =3D 0x000000000=
0000501  r11 =3D 0x0000000000000001
r12 =3D 0x0000000000000002  r13 =3D 0x0000000000000001  r14 =3D 0x000000001=
9a0e900  r15 =3D 0x0000000000000001
AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV fs/squashfs/sqfs_inode.c:131 in sqfs_find_i=
node
=3D=3D75950=3D=3DABORTING
```

This bug is similar to CVE-2024-57254 in that memory operations are occurin=
g based on inode values.
I applied a similar fixed via the commmit c8e929e5758999933f9e905049ef2bf3f=
e6b140d, re-tested U-Boot with the crashing file system, and successfully a=
voided the crash.

```
 fs/squashfs/sqfs_inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/squashfs/sqfs_inode.c b/fs/squashfs/sqfs_inode.c
index ce9a8ff8e2a..addd76cc07e 100644
--- a/fs/squashfs/sqfs_inode.c
+++ b/fs/squashfs/sqfs_inode.c
@@ -135,6 +135,9 @@ void *sqfs_find_inode(void *inode_table, int inode_numb=
er, __le32 inode_count,
 		if (sz < 0)
 			return NULL;
=20
+ 		if (__builtin_add_overflow(offset, sz, &offset))
+ 			return NULL;
+=20
 		offset +=3D sz;
 	}
=20
--=20
2.53.0
`

--6cafb2f3c59859c127b88ea0c9d64ab27fe765b023581055df2ca1b28985
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename=0001-adding-overflow-check-for-offset-calculation.patch
Content-Type: text/x-patch; charset=utf-8;
 name=0001-adding-overflow-check-for-offset-calculation.patch

RnJvbSAyNjAxNDJkNjc2NWUwODkzOGFiMDZiYTgzZDVjMmVjZGJjZDA2NDdjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBkbGxjb29saiA8ZGxsY29vbGpAYXJjaGNsb3VkbGFicy5sYW4+
CkRhdGU6IFN1biwgMjYgQXByIDIwMjYgMTI6MTc6MTIgLTA0MDAKU3ViamVjdDogW1BBVENIXSBh
ZGRpbmcgb3ZlcmZsb3cgY2hlY2sgZm9yIG9mZnNldCBjYWxjdWxhdGlvbgoKU2lnbmVkLW9mZi1i
eTogSmFyZWQgU3Ryb3VkIDxkbGxjb29sakBhcmNoY2xvdWRsYWJzLmNvbT4KLS0tCiBmcy9zcXVh
c2hmcy9zcWZzX2lub2RlLmMgfCAzICsrKwogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KQoKZGlmZiAtLWdpdCBhL2ZzL3NxdWFzaGZzL3NxZnNfaW5vZGUuYyBiL2ZzL3NxdWFzaGZzL3Nx
ZnNfaW5vZGUuYwppbmRleCBjZTlhOGZmOGUyYS4uYWRkZDc2Y2MwN2UgMTAwNjQ0Ci0tLSBhL2Zz
L3NxdWFzaGZzL3NxZnNfaW5vZGUuYworKysgYi9mcy9zcXVhc2hmcy9zcWZzX2lub2RlLmMKQEAg
LTEzNSw2ICsxMzUsOSBAQCB2b2lkICpzcWZzX2ZpbmRfaW5vZGUodm9pZCAqaW5vZGVfdGFibGUs
IGludCBpbm9kZV9udW1iZXIsIF9fbGUzMiBpbm9kZV9jb3VudCwKIAkJaWYgKHN6IDwgMCkKIAkJ
CXJldHVybiBOVUxMOwogCisgCQlpZiAoX19idWlsdGluX2FkZF9vdmVyZmxvdyhvZmZzZXQsIHN6
LCAmb2Zmc2V0KSkKKyAJCQlyZXR1cm4gTlVMTDsKKyAKIAkJb2Zmc2V0ICs9IHN6OwogCX0KIAot
LSAKMi41My4wCgo=
--6cafb2f3c59859c127b88ea0c9d64ab27fe765b023581055df2ca1b28985--
