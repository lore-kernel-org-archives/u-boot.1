Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 816B4F46C4E
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 15:49:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B5A28352B;
	Mon,  6 Apr 2026 17:49:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uWzZUQCn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3A3D83FA3; Mon,  6 Apr 2026 17:49:42 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 220978341A
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 17:49:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7dbccb6ae20so910854a34.3
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 08:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775490579; x=1776095379; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qMSa362Qo89YfkIeIUvKBEoUoWXPVLUA+caEke69oxg=;
 b=uWzZUQCnf/WpVQoVJEI8hsLCCCv6/VJsmQ+t9P0eUZJzq81k7+Hxf53Q3Bc1LiSB9l
 G1TjSoHn5RiDHpMyzCO7EC+G6UYgT0FZQWVFboaj9rZljkRN3jaIS+dBbVbO2hoYBkHw
 7IooJiHPGfdB02FBMdnhSkAAdF6NE2zS3zO2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775490579; x=1776095379;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qMSa362Qo89YfkIeIUvKBEoUoWXPVLUA+caEke69oxg=;
 b=ZwfgfN4WykmDpqqVSPSawHGh7cbQN+DOyNvturmCvika/ACUqoIbDuoX1DlmHOznGF
 QI0AyhdoiWtYZiZGqO6QFfAfvDdNjZBrYfjf32+SZl+DGFnR3r8xB4kfnOhRMfwPkAck
 HsH9wxLtv5nA0uvsq1zvs+278zEqGRFvq9nzzEfPEqGb4P/4j0k0qOGC2hJ4gGljW+Qf
 p/ql2SmA9YROOKnC20qgs7uFhGmAmjq/fm6DIOl6eGbP1ubxizdW4qS7OT+0sqC7J7aF
 zfKY88hAc++nCdhzrzhv17tw7iQ0FAKVO/C0NJVvS/jS7AZg60mMfceQRuK1lXqXE2Tw
 VDjQ==
X-Gm-Message-State: AOJu0YwPwX+9ki5SX24rwMrOZ446D+uOPKho2cwZLsof1RN57cTv1wpj
 V0C/vm2//tJFogHJL0nZySL998K3MmLJI7wOj5sgH5I3IsC2RWEodg8ys6QmvNHHzdc=
X-Gm-Gg: AeBDietBUFYMgi4Ie+jERR/88eqOkLaIvm8kaBYQbFkhMW4dxvwEVziW8DK+iAcEMSn
 lhsDw3Q7EKE8g1sqT9NAQWJHyu116p9eG4PWODIagZk7cJNrRFBLBs85lV6DOiHmtdZysVC8RmO
 3wDrawtLVziHJyFTg/JcUtWkxQK4kAHzAmMhQqjJ+HnuSLvR1yHaQFfurcIwEhtHJ/jb9Q15yUv
 Rkq78vvp+piU1hroCLPO5N7S1zgEm50bCKuHnFd7Roswldwb+rsmrPifsuLFWMpdslua7F5cUHe
 7I41GbFQZATqaSvjIdKaVKINeDRbtCkzwcLhbzTFRER83jWTGEpXmx99oqQctR2BkBE9+K6/h+a
 7WWgWzPHVekDabXwpTRGR+L0CXLh6Ls7limlCeUp8IXZqi7v00NcrOctLpgRNawBgXdYXJ66xW7
 JZ6xrW3e2/Q54e2Q0ASKHjKkhrpS/u1QYMh6S4QUK/hl9mhBuLRkZuWu8zq50O0YZ1s4YM+dQan
 wZEdr5oVoX0A+FS1QEx9jCuna0aRdiSPEGUBQJ3xM4ALe6L
X-Received: by 2002:a05:6830:391c:b0:7d7:419a:7ac8 with SMTP id
 46e09a7af769-7dbb7517e0cmr7918461a34.15.1775490578559; 
 Mon, 06 Apr 2026 08:49:38 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dba72febcdsm10815120a34.18.2026.04.06.08.49.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 08:49:37 -0700 (PDT)
Date: Mon, 6 Apr 2026 09:49:35 -0600
From: Tom Rini <trini@konsulko.com>
To: manizzle alexandria <manizzle.msf@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [SECURITY] NFS symlink =?utf-8?Q?chain?=
 =?utf-8?Q?_buffer_overflow_?= =?utf-8?B?4oaS?= remote code execution
 (net/nfs-common.c)
Message-ID: <20260406154935.GR41863@bill-the-cat>
References: <CAJSCTzpeXqM7X1oOeejumd6HMCJxhxWxy9D8KOajYaevT=09Mg@mail.gmail.com>
 <20260403194955.GK41863@bill-the-cat>
 <CAJSCTzqxkLEhXdNWeK8vP2Uaw+a0szOXukJwv_yFE8AZ3WK9LA@mail.gmail.com>
 <CAJSCTzozBeu86O-rwODrVB2K=3Jdx1MhkyVNdTDhdwrRAkWe-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Lmac13SvtPRMv5Ga"
Content-Disposition: inline
In-Reply-To: <CAJSCTzozBeu86O-rwODrVB2K=3Jdx1MhkyVNdTDhdwrRAkWe-w@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--Lmac13SvtPRMv5Ga
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 03, 2026 at 09:05:40PM -0700, manizzle alexandria wrote:

> Hi
>=20
> Attached is the .patch file in the format requested. Thanks!

Please send the patch directly (git send-email is good for this), and CC
the appropriate maintainers as well, in order to start discussion.
Thanks again!

>=20
>=20
> On Fri, Apr 3, 2026 at 1:44=E2=80=AFPM manizzle alexandria <manizzle.msf@=
gmail.com>
> wrote:
>=20
> > Will clean up the PoC and send a proper patch following the link.
> >
> > Thanks for the quick review.
> >
> > On Fri, Apr 3, 2026, 12:49=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> >> On Fri, Apr 03, 2026 at 11:44:49AM -0700, manizzle alexandria wrote:
> >>
> >> >   Hi Tom,
> >> >
> >> >   I'm reporting a remotely exploitable buffer overflow in U-Boot's N=
FS
> >> >   client that I've confirmed leads to arbitrary code execution.
> >> >
> >> >   SUMMARY
> >> >
> >> >   A rogue NFS server can chain two READLINK (symlink) responses to
> >> >   overflow the global nfs_path_buff[2048] in net/nfs-common.c by ~141
> >> >   bytes. This corrupts the nfs_path pointer and adjacent globals,
> >> >   allowing the attacker to hijack the NFS state machine and deliver
> >> >   shellcode to a known memory address. I have a working end-to-end
> >> >   exploit with code execution confirmed on QEMU ARM (Cortex-A15).
> >> >
> >> >   No authentication is required. The overflow triggers during normal
> >> >   NFS boot before any OS is loaded.
> >> >
> >> >   AFFECTED
> >> >
> >> >   - All U-Boot versions with CONFIG_CMD_NFS=3Dy (NFS boot support)
> >> >   - Tested on: 2026.04-rc5, commit c704af3c8b0
> >> >   - File: net/nfs-common.c, function nfs_readlink_reply(), lines 667=
-686
> >> >
> >> >   ROOT CAUSE
> >> >
> >> >   nfs_readlink_reply() reads the symlink target length (rlen) from
> >> >   the RPC reply and validates it against the packet size, but NOT
> >> >   against the destination buffer (nfs_path_buff[2048]):
> >> >
> >> >     rlen =3D ntohl(rpc_pkt.u.reply.data[1 + nfsv3_data_offset]);
> >> >
> >> >     // Checks rlen fits in packet =E2=80=94 CORRECT
> >> >     if (((uchar *)&rpc_pkt.u.reply.data[0] - (uchar *)&rpc_pkt + rle=
n) >
> >> > len)
> >> >         return -NFS_RPC_DROP;
> >> >
> >> >     // Copies rlen bytes into nfs_path =E2=80=94 NO CHECK against bu=
ffer size
> >> >     memcpy(nfs_path + pathlen, ..., rlen);
> >> >
> >> >   A single response can't overflow because rlen maxes at ~1128 (pack=
et
> >> >   size limit). But two chained relative symlinks accumulate path len=
gth:
> >> >
> >> >     1st READLINK: 1100-byte relative target =E2=86=92 nfs_path grows=
 to ~1060B
> >> >     2nd READLINK: 1128-byte relative target =E2=86=92 writes to offs=
et 2189
> >> >                   =E2=86=92 overflows nfs_path_buff[2048] by ~141 by=
tes
> >> >
> >> >   EXPLOIT CHAIN
> >> >
> >> >     1. Portmap lookup  =E2=86=92 attacker returns fake mountd/nfsd p=
orts
> >> >     2. Mount           =E2=86=92 attacker returns fake file handle
> >> >     3. Lookup          =E2=86=92 attacker returns file handle
> >> >     4. Read            =E2=86=92 attacker returns NFSERR_ISDIR (trig=
gers
> >> symlink)
> >> >     5. Readlink #1     =E2=86=92 1100-byte relative symlink (grows p=
ath)
> >> >     6. Readlink #2     =E2=86=92 OVERFLOW =E2=80=94 overwrites nfs_p=
ath pointer to
> >> >                          attacker-planted "/x" string, state machine
> >> > survives
> >> >     7. Mount/Lookup    =E2=86=92 re-enters NFS flow with controlled =
path
> >> >     8. Read            =E2=86=92 attacker serves ARM shellcode as fi=
le content
> >> >                          =E2=86=92 written to image_load_addr (0x420=
00000)
> >> >     9. Code execution  =E2=86=92 shellcode runs, writes "PWNED!" to =
UART
> >> >
> >> >   PROOF
> >> >
> >> >   GDB output after exploit:
> >> >
> >> >     =3D=3D=3D SHELLCODE AT 0x42000000 =3D=3D=3D
> >> >        0x42000000:  mov   r0, #9
> >> >        0x42000004:  lsl   r0, r0, #24      @ r0 =3D 0x09000000 (UART)
> >> >        0x42000008:  mov   r1, #0x50        @ 'P'
> >> >        0x4200000c:  str   r1, [r0]         @ write to UART
> >> >        ...
> >> >
> >> >     =3D=3D=3D AFTER EXECUTION =3D=3D=3D
> >> >        pc =3D 0x42000040   (completed, infinite loop)
> >> >        r0 =3D 0x09000000   (UART base)
> >> >        r1 =3D 0x0a         (newline)
> >> >
> >> >     =3D=3D=3D QEMU UART =3D=3D=3D
> >> >        Loading: *T #PWNED!
> >> >
> >> >   SUGGESTED FIX
> >> >
> >> >   Add a bounds check before the memcpy in nfs_readlink_reply():
> >> >
> >> >     --- a/net/nfs-common.c
> >> >     +++ b/net/nfs-common.c
> >> >     @@ -670,6 +670,10 @@
> >> >          if (((uchar *)&rpc_pkt.u.reply.data[0] - (uchar *)&rpc_pkt +
> >> rlen)
> >> > > len)
> >> >              return -NFS_RPC_DROP;
> >> >
> >> >     +    int current_len =3D strlen(nfs_path) + 1;
> >> >     +    if (current_len + rlen >=3D sizeof(nfs_path_buff))
> >> >     +        return -NFS_RPC_ERR;
> >> >     +
> >> >          if (*((char *)&rpc_pkt.u.reply.data[2 + nfsv3_data_offset])=
 !=3D
> >> > '/') {
> >> >
> >> >   I have a full advisory document and working PoC (Python script, ~3=
00
> >> >   lines) attached. The PoC runs as a rogue NFS server and was tested
> >> >   against QEMU ARM virt with qemu_arm_defconfig.
> >> >
> >> >   I'm requesting a CVE for this issue. I plan to follow standard 90-=
day
> >> >   coordinated disclosure. Please let me know if you need anything el=
se
> >> >   or would like to discuss the fix.
> >> >
> >> >   Thanks,
> >> >   Murtaza Munaim
> >>
> >> > # Security Advisory: U-Boot NFS Symlink Chain Remote Code Execution
> >> >
> >> > ## Summary
> >> >
> >> > A buffer overflow vulnerability in U-Boot's NFS client allows a rogue
> >> NFS
> >> > server to achieve remote code execution on the target device during
> >> network
> >> > boot. No authentication is required. The attacker serves crafted NFS
> >> > symlink responses that overflow the global `nfs_path_buff[2048]` buf=
fer,
> >> > corrupting adjacent pointers and hijacking the NFS state machine to
> >> deliver
> >> > and execute arbitrary shellcode.
> >> >
> >> > ## Affected Software
> >> >
> >> > - **Product:** Das U-Boot
> >> > - **Component:** `net/nfs-common.c`, function `nfs_readlink_reply()`
> >> > - **Affected versions:** All versions with NFS boot support (at least
> >> since NFSv3 support was added; tested on 2026.04-rc5, commit `c704af3c=
8b0`)
> >> > - **Configurations:** Any build with `CONFIG_CMD_NFS=3Dy` (NFS boot
> >> enabled)
> >> >
> >> > ## CVSS Score
> >> >
> >> > **8.1 (High)** =E2=80=94 CVSS:3.1/AV:N/AC:H/PR:N/UI:N/S:U/C:H/I:H/A:H
> >> >
> >> > - **Attack Vector:** Network (rogue NFS server)
> >> > - **Attack Complexity:** High (target must be performing NFS boot)
> >> > - **Privileges Required:** None
> >> > - **User Interaction:** None (beyond initiating NFS boot, which is
> >> typically automatic)
> >> > - **Impact:** Complete compromise of bootloader execution context
> >> >
> >> > ## Vulnerability Details
> >> >
> >> > ### Root Cause
> >> >
> >> > In `net/nfs-common.c`, the function `nfs_readlink_reply()` processes=
 NFS
> >> > READLINK responses (symlink target resolution). At line 667, it reads
> >> the
> >> > symlink target length (`rlen`) from the RPC reply:
> >> >
> >> > ```c
> >> > rlen =3D ntohl(rpc_pkt.u.reply.data[1 + nfsv3_data_offset]);
> >> > ```
> >> >
> >> > The bounds check at line 669 validates that `rlen` fits within the *=
*RPC
> >> > packet buffer** (1152 bytes):
> >> >
> >> > ```c
> >> > if (((uchar *)&rpc_pkt.u.reply.data[0] - (uchar *)&rpc_pkt + rlen) >
> >> len)
> >> >     return -NFS_RPC_DROP;
> >> > ```
> >> >
> >> > However, it does **not** validate that `rlen` fits within the
> >> **destination
> >> > buffer** `nfs_path_buff[2048]`. When processing a relative symlink (=
line
> >> > 672-680), the target is appended to the existing path:
> >> >
> >> > ```c
> >> > strcat(nfs_path, "/");
> >> > pathlen =3D strlen(nfs_path);
> >> > memcpy(nfs_path + pathlen,
> >> >        (uchar *)&rpc_pkt.u.reply.data[2 + nfsv3_data_offset],
> >> >        rlen);
> >> > nfs_path[pathlen + rlen] =3D 0;
> >> > ```
> >> >
> >> > ### Exploitation via Symlink Chaining
> >> >
> >> > A single READLINK response cannot overflow the buffer because `rlen`=
 is
> >> > capped at ~1128 bytes (by the packet size check) and `nfs_path` star=
ts
> >> > short (~10 bytes). However, by chaining **two** symlink resolutions:
> >> >
> >> > 1. **First READLINK:** Server returns a ~1100-byte relative symlink
> >> target
> >> >    with directory separators (`a/b/c/.../x`). After `nfs_dirname()`,
> >> >    `nfs_path` retains ~1060 bytes.
> >> >
> >> > 2. **Second READLINK:** Server returns a ~1128-byte relative symlink
> >> >    target. The `memcpy` writes to offset `1061 + 1128 =3D 2189`, exc=
eeding
> >> >    `nfs_path_buff[2048]` by approximately **141 bytes**.
> >> >
> >> > ### What Gets Overwritten
> >> >
> >> > The overflow corrupts global variables adjacent to `nfs_path_buff` in
> >> BSS
> >> > (verified via `nm` on QEMU ARM build):
> >> >
> >> > | Offset from buffer end | Variable | Type | Impact |
> >> > |------------------------|----------|------|--------|
> >> > | +0 | `nfs_path` | `char *` | Pointer to current NFS path =E2=80=94=
 controls
> >> future memory writes |
> >> > | +4 | `nfs_filename` | `char *` | Pointer to filename component |
> >> > | +8 | `nfs_download_state` | `enum` | Controls boot success/failure=
 |
> >> > | +12 | `filefh3_length` | `uint` | NFS file handle length |
> >> > | +16 | `filefh` | `char[64]` | NFS file handle =E2=80=94 controls w=
hich file
> >> is read |
> >> >
> >> > ### Code Execution Chain
> >> >
> >> > By overwriting `nfs_path` to point to a short valid path string (e.g=
=2E,
> >> > `"/x"`) planted within the overflow payload itself, the attacker kee=
ps
> >> the
> >> > NFS state machine alive. The state machine then:
> >> >
> >> > 1. Re-mounts the filesystem (MOUNT `/`)
> >> > 2. Looks up the file (LOOKUP `x`)
> >> > 3. Reads file content (READ) =E2=80=94 the server serves **arbitrary=
 shellcode**
> >> > 4. `store_block()` writes the shellcode to `image_load_addr` (e.g.,
> >> `0x42000000`)
> >> >
> >> > The shellcode is now in memory at a known address. In typical embedd=
ed
> >> boot
> >> > configurations, `bootm` or `go` is called on the load address after =
NFS
> >> > download, executing the attacker's code.
> >> >
> >> > ## Proof of Concept
> >> >
> >> > A complete working exploit (`nfs_rce.py`) is provided. It was tested
> >> > against U-Boot 2026.04-rc5 running on QEMU ARM (`qemu_arm_defconfig`,
> >> > Cortex-A15, 256MB RAM).
> >> >
> >> > ### Tested Exploit Chain
> >> >
> >> > ```
> >> > [1] PORTMAP      =E2=86=92 returned fake mountd/nfsd ports
> >> > [2] MOUNT        =E2=86=92 returned fake file handle
> >> > [3] LOOKUP       =E2=86=92 returned success with file handle
> >> > [4] READ         =E2=86=92 returned NFSERR_ISDIR =E2=86=92 triggered=
 symlink
> >> > [5] READLINK #1  =E2=86=92 1100-byte relative symlink (grew nfs_path=
 to ~1060B)
> >> > [6] READLINK #2  =E2=86=92 1128-byte overflow payload
> >> >                     Overwrote nfs_path =E2=86=92 valid "/x" string
> >> >                     State machine survived and continued
> >> > [7] MOUNT/LOOKUP =E2=86=92 re-entered NFS flow with attacker-control=
led path
> >> > [8] READ         =E2=86=92 served 68-byte ARM shellcode =E2=86=92 wr=
itten to 0x42000000
> >> > [9] EXECUTION    =E2=86=92 shellcode wrote "PWNED!" to PL011 UART
> >> > ```
> >> >
> >> > ### GDB Verification
> >> >
> >> > ```
> >> > =3D=3D=3D SHELLCODE AT 0x42000000 =3D=3D=3D
> >> >    0x42000000:  mov   r0, #9
> >> >    0x42000004:  lsl   r0, r0, #24      @ r0 =3D 0x09000000 (UART bas=
e)
> >> >    0x42000008:  mov   r1, #0x50        @ 'P'
> >> >    0x4200000c:  str   r1, [r0]         @ write to UART
> >> >
> >> > =3D=3D=3D AFTER EXECUTION =3D=3D=3D
> >> >    pc =3D 0x42000040   (completed, hit infinite loop)
> >> >    r0 =3D 0x09000000   (UART base)
> >> >    r1 =3D 0x0a         (newline =E2=80=94 last char written)
> >> >
> >> > =3D=3D=3D QEMU UART OUTPUT =3D=3D=3D
> >> >    Loading: *T #PWNED!
> >> >    >>> CODE EXECUTION CONFIRMED <<<
> >> > ```
> >> >
> >> > ### Reproduction Steps
> >> >
> >> > ```bash
> >> > # 1. Build U-Boot for QEMU ARM with NFS enabled
> >> > cd u-boot
> >> > make CROSS_COMPILE=3Darm-none-eabi- qemu_arm_defconfig
> >> > # Enable CONFIG_CMD_NFS=3Dy in .config
> >> > make CROSS_COMPILE=3Darm-none-eabi- -j$(nproc)
> >> >
> >> > # 2. Start the exploit server
> >> > python3 nfs_rce.py
> >> >
> >> > # 3. Start QEMU
> >> > qemu-system-arm -machine virt -cpu cortex-a15 -m 256M -nographic \
> >> >     -bios u-boot.bin \
> >> >     -netdev user,id=3Dnet0,net=3D10.0.2.0/24,dhcpstart=3D10.0.2.15 \
> >> >     -device virtio-net-device,netdev=3Dnet0
> >> >
> >> > # 4. In U-Boot console:
> >> > setenv ipaddr 10.0.2.15
> >> > setenv serverip 10.0.2.2
> >> > nfs 0x42000000 10.0.2.2:/boot/uImage
> >> >
> >> > # 5. Observe "PWNED!" in UART output (or verify via GDB at 0x4200000=
0)
> >> > ```
> >> >
> >> > ## Suggested Fix
> >> >
> >> > Add a bounds check against `nfs_path_buff` size before the `memcpy` =
in
> >> > `nfs_readlink_reply()`:
> >> >
> >> > ```c
> >> > --- a/net/nfs-common.c
> >> > +++ b/net/nfs-common.c
> >> > @@ -670,6 +670,11 @@ static int nfs_readlink_reply(uchar *pkt, unsig=
ned
> >> int len)
> >> >       if (((uchar *)&rpc_pkt.u.reply.data[0] - (uchar *)&rpc_pkt +
> >> rlen) > len)
> >> >               return -NFS_RPC_DROP;
> >> >
> >> > +     /* Validate symlink target fits in nfs_path_buff */
> >> > +     int current_len =3D strlen(nfs_path) + 1; /* +1 for '/' */
> >> > +     if (current_len + rlen >=3D sizeof(nfs_path_buff))
> >> > +             return -NFS_RPC_ERR;
> >> > +
> >> >       if (*((char *)&rpc_pkt.u.reply.data[2 + nfsv3_data_offset]) !=
=3D
> >> '/') {
> >> >               int pathlen;
> >> > ```
> >> >
> >> > Additionally, consider replacing `strcat`/`memcpy` with bounds-check=
ed
> >> > alternatives throughout the NFS path handling code.
> >>
> >> Thanks for the report, please see
> >> https://docs.u-boot.org/en/latest/develop/sending_patches.html for how
> >> to properly submit a patch, thanks!
> >>
> >> --
> >> Tom
> >>
> >



--=20
Tom

--Lmac13SvtPRMv5Ga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCadPWDwAKCRAr4qD1Cr/k
ChPWAQD1QKYOoiLpMpKJBVztGvIz+/xjeR1tqOuBJtWXjpqV2AEA1R0urJ5MiaSn
thZ6vFcYPi7JJpWkR2eQ6XWrg76kugM=
=ieXy
-----END PGP SIGNATURE-----

--Lmac13SvtPRMv5Ga--
