Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63FE8C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 17:36:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2EC584C19;
	Wed,  1 Jul 2026 19:35:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=espilon.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=espilon.net header.i=@espilon.net header.b="Toh+VKE8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1E8284BB9; Wed,  1 Jul 2026 15:28:13 +0200 (CEST)
Received: from donkey.ash.relay.mailchannels.net
 (donkey.ash.relay.mailchannels.net [23.83.222.49])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29A3384B92
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 15:28:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=espilon.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eun0us@espilon.net
X-Sender-Id: hostingeremail|x-authuser|eun0us@espilon.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 85729382E35;
 Wed, 01 Jul 2026 13:28:06 +0000 (UTC)
Received: from fr-int-smtpout12.hostinger.io
 (trex-blue-0.trex.outbound.svc.cluster.local [100.99.245.113])
 (Authenticated sender: hostingeremail)
 by relay.mailchannels.net (Postfix) with ESMTPA id AB7ED381FA6;
 Wed, 01 Jul 2026 13:28:04 +0000 (UTC)
X-Sender-Id: hostingeremail|x-authuser|eun0us@espilon.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: hostingeremail|x-authuser|eun0us@espilon.net
X-MailChannels-Auth-Id: hostingeremail
X-Belong-Stop: 59fa927872926061_1782912486411_1656039737
X-MC-Loop-Signature: 1782912486411:440935551
X-MC-Ingress-Time: 1782912486410
Received: from fr-int-smtpout12.hostinger.io (fr-int-smtpout12.hostinger.io
 [148.222.54.46]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.99.245.113 (trex/7.1.5); Wed, 01 Jul 2026 13:28:06 +0000
Received: from [127.0.1.1]
 (2a01cb0005479a00b6daaa56fe1feac0.ipv6.abo.wanadoo.fr
 [IPv6:2a01:cb00:547:9a00:b6da:aa56:fe1f:eac0])
 (Authenticated sender: eun0us@espilon.net)
 by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4gr16V5nNnz1yTh;
 Wed,  1 Jul 2026 13:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=espilon.net;
 s=hostingermail-a; t=1782912483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=6tkbNBWi3w569x7ulVDvmAOqjxJrSb1QL/ao7nUAcNI=;
 b=Toh+VKE8lkxEeUpzOYg3bu66di2Ma2YslMGYsgNmTCQnlLLIz+SkdJ32KP34QGYJkHc/Zn
 es7QZ28AQfVYdElfFJYcWIJ4QKHNg+PP3AZ0JoCzdVXIJ++RdSkmDbb3CjBBMsIsxV4IrY
 xeweiO6/GYXZ3bW7cocwUaRzPUY2fqcTsVRG75DegnDdvOf1K+unwN0/zyv2ootKTEwipB
 ZLozo6Q+E4qGqOH6uloYd9AD0d/tKSbTxmpTNLscjMrqPespo22BUxNKs5JH2PMmA7y+ZE
 8WVKDCjSsqxQqdGeNUh7fqkDfZkwwHlYe//r4LVX19ib7LUTf4MtPdY2w/qV7Q==
From: Eun0us / Espilon <eun0us@espilon.net>
To: u-boot@lists.denx.de
Subject: [SECURITY] Two out-of-bounds reads in U-Boot SquashFS parser
 (fs/squashfs)
Cc: Joao Marcos Costa <joaomarcos.costa@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>, Tom Rini <trini@konsulko.com>,
 eun0us@proton.me
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6118752409107970649=="
Message-Id: <4gr16V5nNnz1yTh@fr-int-smtpout12.hostinger.io>
Date: Wed,  1 Jul 2026 13:28:02 +0000 (UTC)
X-CM-Analysis: v=2.4 cv=BvrPwpX5 c=1 sm=1 tr=0 ts=6a4515e3
 a=mfZ/zFgjsVuE+hhpM0+GIA==:617 a=xqWC_Br6kY4A:10 a=ICNSGLm3AAAA:8
 a=YJ6olgf6pVn-cK3pMqoA:9 a=QEXdDO2ut3YA:10 a=6OA6Y5fWGIsqCNDA96sA:9
 a=t4rh5XNxqGnEYYNc:21 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10
 a=orLrujtX7D5PyURxmV8A:9 a=HXjIzolwW10A:10 a=_QsP0IyyxzFEsWpPXeYA:9
 a=IKIoO-ieCDEA:10 a=Yy2xoct6d_2ZlxTvqP-Z:22 a=-W5iAdWQbIJCsXvgvhpT:22
X-CM-Envelope: MS4xfFIY/NMqPR4MdMv2j+l866wdmc4R2Sitm9ATE/YjhwlnvjWU/g2AtL9oPU00d3zg6UbUF00P2suG+BBlRmwy+z2bXLwTsocrFerpaN/f/TqwBhTe2CTj
 7Fqi2kvO3/J5uremx+tDdRd8f7uWI3HTqHxS2Jvm62Z11KG3aHL+PnyleRngTPo5Kww3gtaRJrng9RQ9p+6/bryCyNFbCgBC2MKkRx0kTMaVJnd6s5GIjv9N
 OyoOUbJ5aAkqKetRkPiYXtybQE4Sj6eMmea/wljy5CU9ZCP09dkTlCzAz4PbA/lBUp7LUOkeVrBeHYJjGZDumGyqoH3frIC8GzgOT1EwWNFoSg6aeiT/CcXy
 CQYKVo7JVC3e8/AaoXhvtI132Evmsu2MNy2iLUeAUVh94IjPsgc=
X-AuthUser: eun0us@espilon.net
X-Mailman-Approved-At: Wed, 01 Jul 2026 19:35:57 +0200
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

--===============6118752409107970649==
Content-Type: multipart/alternative;
 boundary="===============6476363572403949793=="

--===============6476363572403949793==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I am a security researcher with Espilon (https://espilon.net), a French non-p=
rofit
focused on embedded, IoT and OT security research, with published CVEs in Esp=
ressif,
AWS/FreeRTOS and Arduino.

I am reporting a memory-safety vulnerability I found in your project, with a
self-contained reproducer attached. This is a coordinated disclosure; please
confirm receipt and your preferred timeline. I am happy to help validate a fi=
x.

The attached archive (poc.zip) contains:
  - reproduce.sh : clones the upstream repository at a pinned commit, builds =
the
    real source under AddressSanitizer, and triggers the issue from a fresh
    checkout (one command: bash reproduce.sh)
  - report.md : full write-up (mechanism, file and line, honest impact, sugge=
sted fix)
  - the harness and stubs used by the reproducer

Summary is below; the full details are in report.md inside the archive.

----------------------------------------------------------------------
# U-Boot SquashFS parser: unchecked wire-size arithmetic - two out-of-bounds =
reads (plus a size-arithmetic hardening item)

**ID:** OSS-UBOOT-SQUASHFS-OOB-DOS-001
**Component:** U-Boot SquashFS filesystem driver (`fs/squashfs/sqfs.c`, `fs/s=
quashfs/sqfs_inode.c`)
**Affected version:** `origin/master` at `f605dcee103c897b6f1a8873549a36949bd=
4e2a1` (verified on worktree `a3f393c0`, 2026-06-27). Unpatched at time of wr=
iting.
**Config gate:** `CONFIG_FS_SQUASHFS` (enabled in many distro/boot-scan defco=
nfigs).
**Bug classes:** CWE-191 (integer underflow), CWE-125 (out-of-bounds read), C=
WE-789 / CWE-190 (uncontrolled / oversized allocation).
**Impact (honest):** Two confirmed out-of-bounds READs (RC-1, RC-3). A third =
related site (RC-2) is a size-arithmetic hardening item, reported as a robust=
ness fix rather than claimed as a standalone vulnerability. There is **no out=
-of-bounds write and no control-flow hijack in any of these paths; RCE is NOT=
 claimed.**
**Reachability tier:** boot-media / pre-OS. An attacker who can place a craft=
ed SquashFS image on any media U-Boot enumerates and parses (`sqfs ls`, `load=
 sqfs`, distro/boot-scan) reaches these paths during the pre-OS parse of raw =
image bytes.

---

## Summary

U-Boot's SquashFS driver reads several 16/64-bit size and offset fields direc=
tly from the
on-disk image and performs arithmetic on them (header subtraction, table-span=
 subtraction,
per-inode walk) **without validating them against a sane lower bound or again=
st the actual
size of the buffers/tables being walked**. Two of these are confirmed out-of-=
bounds reads of
the parser's own heap buffers (RC-1 and RC-3, both reproduced under AddressSa=
nitizer on the
real parser). A third site (RC-2) is unguarded size-arithmetic on the table-s=
pan / fragment
paths; it is reported below as a hardening item (the primary allocation is nu=
ll-checked, so
it is not claimed as a standalone vulnerability), because the fragment-path m=
ultiply has no
overflow guard at all and the pattern matches the accepted bug class.

These are the **sibling paths** of the sigma-star fixes (CVE-2024-57254..5725=
9), which
hardened only the symlink-size and name-length paths. The directory-size, tab=
le-offset, and
inode-count paths described here were **not** covered by those fixes and rema=
in unguarded on
`master`.

---

## Root cause 1 (RC-1): directory `file_size` unsigned underflow -> heap OOB =
read

**CWE-191 -> CWE-125. File:line: `fs/squashfs/sqfs.c:510`, `:648`, `:990` (al=
so `:1048`).**

A directory inode's `file_size` is a 16-bit (basic dir) / 32-bit (long dir) w=
ire field. The
driver subtracts the fixed 12-byte directory-header size (`SQFS_DIR_HEADER_SI=
ZE =3D=3D 12`) from
it and stores the result in the `size_t` field `dirs->size`, with no `file_si=
ze >=3D 12`
precondition:

- `sqfs.c:510` - `dirs->size =3D get_unaligned_le16(&dir->file_size) - SQFS_D=
IR_HEADER_SIZE;`
- `sqfs.c:646-648` - assigns `dirs->size =3D get_unaligned_le16(&dir->file_si=
ze);` then `dirs->size -=3D SQFS_DIR_HEADER_SIZE;`
- `sqfs.c:990` - `dirs->size -=3D SQFS_DIR_HEADER_SIZE;` (in `sqfs_opendir_ne=
st`)

When `file_size < 12`, the subtraction underflows into a `size_t` near `1.8e1=
9`. `dirs->size`
is the **only bound** on the `sqfs_readdir_nest` directory-walk loop, which a=
dvances
`dirs->table` through the parser's own metadata directory-table buffer and co=
pies each entry
via `sqfs_read_entry` (`memcpy`, `sqfs.c:238`). A corrupted (near-`SIZE_MAX`)=
 bound makes the
walk read far past the end of that buffer.

The directory-table buffer is the real `SQFS_METADATA_BLOCK_SIZE` (8192-byte)=
 region the parser
allocates itself in `sqfs_read_directory_table` (`sqfs.c:855`). The existing =
empty-directory
guard (`sqfs_is_empty_dir`, ~`:637`) only catches `file_size =3D=3D 3` on the=
 `:648` path; there is
no guard at `:510` or `:990`, and `file_size` in `{0,1,2,4..11}` all underflo=
w (`{0,1,11}`
confirmed reproducing).

**Observed (faithful host-ASan, real parser):** `heap-buffer-overflow READ of=
 size 48839`, 0
bytes to the right of the 8192-byte region, in `sqfs_read_entry` (`sqfs.c:238=
`) <-
`sqfs_readdir_nest` (`sqfs.c:1060`) <- `sqfs_readdir` (`sqfs.c:1023`); the ov=
erflowed buffer is
the parser's own `dlmalloc` at `sqfs_read_directory_table` (`sqfs.c:855`) / `=
sqfs_opendir_nest`
(`sqfs.c:942`).

---

## Root cause 2 (RC-2): unguarded table-span size math (hardening item, not a=
 standalone vulnerability claim)

**CWE-190 / CWE-789. File:line: `fs/squashfs/sqfs.c:733-734` (+`:744`), `:827=
` (+`:838`), and `sqfs.c:94` / `:136` (fragment path).**

Reported as a robustness / hardening fix. The primary oversized-allocation pa=
th is null-checked
(returns `-ENOMEM`), so it is not claimed as an independent memory-safety vul=
nerability; the
substantive gap is the fragment-path multiply at `sqfs.c:136`, which has no `=
__builtin_mul_overflow`
guard at all (unlike the inode/dir paths at `:741`/`:835`). It is included so=
 the same guard is
applied consistently.

Table sizes are derived by subtracting one on-disk 64-bit table-start offset =
from another:

- inode table: `sqfs.c:733-734` - `table_size =3D get_unaligned_le64(&sblk->d=
irectory_table_start) - get_unaligned_le64(&sblk->inode_table_start);`
- directory table: `sqfs.c:827` - same pattern with `fragment_table_start - d=
irectory_table_start`.
- shared helper `sqfs_calc_n_blks` (`sqfs.c:94`) - `table_size =3D le64_to_cp=
u(end) - le64_to_cpu(start);` then returns `DIV_ROUND_UP(table_size + offset,=
 blksz)`.

Neither the start ordering (`end >=3D start`) nor an upper sanity bound versu=
s the actual image
length is checked. Two failure modes, both attacker-driven off-disk:

1. **Oversized allocation / disk read (primary, confirmed):** a large forward=
 span (or a wrap
   that lands below the overflow threshold) yields a large block count and
   `malloc_cache_aligned(buf_size)` at `sqfs.c:744` (inode table) / `:838` (d=
irectory table).
   The confirmed reproducer drives a request on the order of tens of GB (host=
-ASan reports a
   ~15 TB reservation attempt at `sqfs.c:744`). Even when the allocation is n=
ull-checked
   (`:745`, `:839` return `-ENOMEM`), the subsequent `sqfs_disk_read(start, n=
_blks, ...)`
   (`:748`, `:842`) is asked to read the attacker-chosen huge block count. Re=
sult: memory
   exhaustion / OOM / long hang during the pre-OS parse.

2. **Unguarded multiply (fragment path):** `sqfs_frag_lookup` at `sqfs.c:136`=
 calls
   `malloc_cache_aligned(n_blks * ctxt.cur_dev->blksz)` with **no `__builtin_=
mul_overflow`
   guard at all** (contrast the inode/dir paths at `:741`/`:835`, which do gu=
ard the multiply).
   With `n_blks` derived from the same underflow-prone `sqfs_calc_n_blks`, th=
is multiply can
   wrap `size_t` and produce an undersized allocation (leading to a later ove=
rflow) or a huge
   one.

Note: the `__builtin_mul_overflow` guards at `sqfs.c:741` and `:835` only rej=
ect the case where
`n_blks * blksz` overflows `size_t`; they do **not** reject a merely-huge (mu=
lti-GB) but
in-range allocation, and they do not exist on the fragment path. So the DoS w=
indow is real and
unguarded.

**Observed (faithful host-ASan, real parser):** allocator failure attempting =
`0xdfff0001000`
(~15 TB) bytes at the `malloc_cache_aligned` call reached from `sqfs.c:744`.

---

## Root cause 3 (RC-3): unbounded inode-count walk -> OOB read

**CWE-125. File:line: `fs/squashfs/sqfs_inode.c:131` (loop at `:129`).**

`sqfs_find_inode` walks the decompressed inode table looking for a target ino=
de number. The
loop bound `inode_count` is an on-disk 32-bit field, and `offset` advances by=
 a per-inode
size that is itself parsed from on-disk fields. Nothing bounds `offset` (or `=
inode_table +
offset`) against the actual length of the allocated inode-table buffer. A lar=
ge `inode_count`
(or per-inode sizes that outrun the buffer) walks `base` past the end of the =
table and
dereferences it via `get_unaligned_le32(&base->inode_number)` at `sqfs_inode.=
c:131`.

**Observed (faithful host-ASan, real parser):** wild read reaching an unmappe=
d page - SEGV in
`get_unaligned_le32` (`include/asm-generic/unaligned.h:27`) inside `sqfs_find=
_inode`
(`sqfs_inode.c:131`) <- `sqfs_search_dir` (`sqfs.c:489`) <- `sqfs_opendir_nes=
t` (`sqfs.c:977`).
This site faults even without ASan (see "Reproduction without ASan" below), i=
.e. it is a hard
crash / DoS on any target.

---

## Impact and severity

The two confirmed findings (RC-1, RC-3) are memory-safety defects in code tha=
t parses fully
attacker-controlled bytes off boot media before the OS is running.

- RC-1 (confirmed): heap out-of-bounds **read** of the parser's own metadata =
buffer -> corrupted
  directory listing, adjacent-heap information exposure, and (when the walk r=
eaches unmapped
  memory) a crash. It is a read, not a write; **not** by itself a control-flo=
w primitive.
- RC-3 (confirmed): unbounded walk -> out-of-bounds **read** that reliably re=
aches unmapped
  memory and faults (even without ASan) -> hard crash / DoS. Read only.
- RC-2 (hardening): unguarded size-arithmetic; primary allocation is null-che=
cked, the fragment
  multiply lacks an overflow guard. Reported as a consistency/robustness fix,=
 not a standalone
  vulnerability.

**No out-of-bounds write and no RCE are claimed for any of these sites.**

### CVSS 3.1 base vectors (honest - attacker-supplied boot media, read/DoS on=
ly)

The attacker must get U-Boot to parse a crafted SquashFS image. On most real =
deployments that
means local/physical access to the boot media or an enumerated partition (AV:=
L, occasionally
AV:P). None of these are network-reachable in the parser itself.

- **RC-1 (OOB read):** `CVSS:3.1/AV:L/AC:L/PR:N/UI:N/S:U/C:L/I:N/A:L` =3D **4=
.4 (Medium)**
  (local attacker-supplied image; limited confidentiality via adjacent-heap r=
ead + limited
  availability via crash). If the deployment only accepts media via physical =
access, AV:P
  lowers it further.
- **RC-2 (hardening item):** no standalone CVSS claimed. The primary oversize=
d allocation is
  null-checked; the reported gap is the missing overflow guard on the fragmen=
t-path multiply
  (`sqfs.c:136`). Treat as a robustness fix, not a scored vulnerability.
- **RC-3 (OOB read -> hard crash):** `CVSS:3.1/AV:L/AC:L/PR:N/UI:N/S:U/C:L/I:=
N/A:H` =3D
  **6.1 (Medium)** (reliable crash / boot DoS, plus limited pre-fault adjacen=
t-memory read).

Rationale for AV:L (not AV:N): the SquashFS parser consumes raw block-device =
bytes; it is not
itself exposed on a network interface. Do not upgrade these to AV:N/critical.

---

## Anti-duplication vs CVE-2024-57254..57259 (sigma-star)

The sigma-star series hardened the SquashFS driver against wire-size abuse, b=
ut only on the
**symlink-size and name-length** paths. On `master` (`f605dcee`) those fixes =
are present:

- `__builtin_add_overflow` guarding the name-length copy (~`sqfs.c:267`),
- `__builtin_add_overflow` guarding `symlink_size` (~`sqfs.c:439`),
- `MAX_SYMLINK_NEST =3D=3D 8` bounding symlink recursion (~`sqfs.c:554`).

The three root causes here are the **directory-size**, **table-offset span**,=
 and
**inode-count** siblings of that same wire-size-arithmetic bug class. No guar=
d anywhere checks
`file_size >=3D SQFS_DIR_HEADER_SIZE`, checks `directory_table_start >=3D ino=
de_table_start` (or the
fragment/id-table equivalents), or bounds the `sqfs_find_inode` walk against =
the actual table
length. The presence of the `__builtin_add_overflow` / `__builtin_mul_overflo=
w` guards the
maintainers already added is direct evidence they accept this class of fix; t=
hese three sites
were simply missed.

Checked against public CVEs and our own pipeline - net-new candidate for U-Bo=
ot.

---

## Suggested fix

1. **RC-1:** before the `- SQFS_DIR_HEADER_SIZE` subtraction at `sqfs.c:510`,=
 `:648`, `:990`
   (and `:1048`), reject `file_size < SQFS_DIR_HEADER_SIZE` (return `-EINVAL`=
), e.g. via
   `__builtin_sub_overflow` or an explicit `if (file_size < SQFS_DIR_HEADER_S=
IZE) return
   -EINVAL;`. Additionally, bound the `sqfs_readdir_nest` walk against the ac=
tual directory
   metadata buffer length, not solely against `dirs->size`.

2. **RC-2:** in `sqfs_calc_n_blks` (`sqfs.c:94`) and at the call sites (`:733=
`, `:827`,
   fragment path), reject `end < start` (table-start ordering) with `__builti=
n_sub_overflow`,
   and clamp the derived table size against the actual image / partition leng=
th before
   allocating. Add the missing `__builtin_mul_overflow` guard on the fragment=
-path multiply at
   `sqfs.c:136` to match the inode/dir paths.

3. **RC-3:** bound the `sqfs_find_inode` walk (`sqfs_inode.c:129-138`) so that
   `offset + sizeof(*base)` (and the per-inode `sz`) never exceeds the actual=
 inode-table buffer
   length; return `NULL`/`-EINVAL` on overrun instead of trusting the on-disk=
 `inode_count`.

---

## Reproduction (faithful host-ASan harness)

A self-contained harness is included in `poc/harness/` and driven by `reprodu=
ce.sh`, which
clones U-Boot at the pinned commit, compiles the **real** `fs/squashfs/*.c` w=
ith the exact
sandbox flags, links only leaf stubs (block read =3D memcpy from the backing =
image; allocators =3D
libc so ASan instruments the parser's real buffer sizes; decompressors return=
 error for
uncompressed-metadata images), and builds the ASan harness.

`nm` confirms the parser is the real blob, not stubs: `sqfs_probe`, `sqfs_ope=
ndir`,
`sqfs_readdir`, `sqfs_find_inode`, `sqfs_dir_offset` are `T`; `sqfs_opendir_n=
est`,
`sqfs_readdir_nest`, `sqfs_search_dir` are real local (`t`) text (the enclosi=
ng functions of all
three root causes). `sqfs_read_entry` / `sqfs_read_directory_table` are inlin=
ed at `-O1` and
show in the ASan backtraces at their real `sqfs.c` line numbers.

**Trigger images are NOT shipped in this package** (public list). The craftin=
g logic
(`craft.py` - set a directory inode's `file_size < 12` for RC-1; set table-st=
art offsets out of
order / far apart for RC-2; inflate `inode_count` for RC-3) is included so a =
reviewer can
regenerate them from a stock `mksquashfs -noI` image. Prebuilt private reprod=
ucers are available
to the maintainers on request.

### Reproduction without ASan (honest)

- **RC-1 (read):** without ASan, on a host with a large heap the ~48 KB over-=
read lands in
  adjacent mapped memory and the run returns cleanly (no fault) - it is a gen=
uine read
  primitive that ASan redzones catch but a flat/large heap masks. On a real b=
ootloader the
  over-read silently exposes adjacent memory into the directory listing and c=
an crash if the
  walk reaches an unmapped region. Faulting is not guaranteed without ASan.
- **RC-2 (alloc/disk-read DoS):** aborts/fails to allocate even without ASan =
(huge
  `malloc_cache_aligned`), and drives a huge `sqfs_disk_read` - resource-exha=
ustion DoS
  independent of ASan.
- **RC-3 (read):** **faults even without ASan** (observed SIGSEGV / exit 139 =
in a plain `-O0`
  build) - the unbounded walk reliably runs off into unmapped memory. Hard cr=
ash / DoS on any
  target.

---

## Routing (proposed, not sent)

Upstream OSS -> U-Boot security list / MITRE for CVE assignment; notify downs=
tream integrators
(distro/embedded vendors shipping `CONFIG_FS_SQUASHFS`) per CISA-tier coordin=
ation. This is a
public-list disclosure: trigger images offered privately on request.

**Nothing has been sent.**

----------------------------------------------------------------------

Requirements to reproduce: clang++, git, internet access. The impact is stated
honestly in report.md (this one is a read-only out-of-bounds read / small inf=
o-leak,
no out-of-bounds write and no RCE claimed).

Best regards,
Eun0us / Espilon
eun0us@espilon.net

--===============6476363572403949793==
MIME-Version: 1.0
Content-Type: image/png
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="espilon.png"

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
QmCC

--===============6476363572403949793==--

--===============6118752409107970649==
Content-Type: application/zip
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="poc.zip"
MIME-Version: 1.0

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
oAIAAMk8AAAAAA==

--===============6118752409107970649==--
