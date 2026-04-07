Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FD5A1073C93
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 12:57:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A34CE8419C;
	Wed,  8 Apr 2026 14:55:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OR5FqQ4A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2119F840AB; Tue,  7 Apr 2026 23:33:21 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10D498404A
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 23:33:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=manizzle.msf@gmail.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-38704f70ea3so50197251fa.2
 for <u-boot@lists.denx.de>; Tue, 07 Apr 2026 14:33:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775597597; cv=none;
 d=google.com; s=arc-20240605;
 b=Bc17JW9tXPT4uGKw2PBUGCVnRmzn7ZcgkNUlXGwBPWLeRj581owMCg4+vemLAQiT8A
 A0tp/5kJPhw3O/UNXdcJ2Jb1rGmGXVeVrb+1SbRpU2xMIukj8KYOZTfY1QYocPFAffay
 CatngOpkbpvQvdhs78OBDfT8jTmHSPGJhGeHeXO/nOudo09Qu0yr3T+1OKjjXCipkPVZ
 1YLZyyai8nucS6lDV0U+kPWdkX2xCzZRICvppPAcRLdIItcIxqDAjT1mo9h+08PQg6xw
 bnhJC/ssiciuAg7WryxSIRp5BhcuX2NS9dg7Y1Hu4YxiRUi0gyMRPueiey9+THQSuMco
 agog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XV3An3FqIm/uMA63vtOdEw9AGWQnooxC1EXqM8LO8Gc=;
 fh=3cGkqt4Xgv2w9dTeeIJFEJ5AO4AvGobPArcY4WlS1wc=;
 b=GX77z6NmDKSZtzeFDJmFq0Qb3SqNNhFDADBcCC8f6LQc+40sioBI6u1OyvonTeCyCy
 TLCBr/nVxZ/lwM9iVZuBRTLTU3/juGIJ6V+aS2eNQeYkcSV8uOnmrTjBipmKwkVss0Wi
 YlvZNPvJHsqtKqbJr74n3NXrRk0eTI0l7+Hu5HK4qW27aqQz83Caw0cW/WqgCluHrR8/
 9suDDRZLHu4Blp6EBV1YmlKaAqyHbULtY+iuNTSFeVeQqiY1uu7tokJYrTpbwVITN1Nu
 uO8mPED1oDBGL8QPhnOPiZ9BCaXY0hnIQdNilOuCZVWFF8OJDn6AfSuKGkGgInc5RIMS
 rtzg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775597597; x=1776202397; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XV3An3FqIm/uMA63vtOdEw9AGWQnooxC1EXqM8LO8Gc=;
 b=OR5FqQ4AcwMO8eci8TVJSslA0Z8BJAPmks0zrWC0FYEXJEBc+/VI2g+9P3h/xCANPa
 j4zjX84KG101G265QE+ozknKODK/cSpxJwZrpQohKuhQpVH4P0nZdK3aRbqTcyXKR3lp
 42I2n6cGS1eNxiytu+Y/TOC9X1bATFxNckeSCjGzqGhG/ydjwR4GLGoXxMEMStOHNAyG
 AZwXecf9O6TPlI4+MFoxpEfkw1hDIGy+xG6hVRjFh3rlHFS3RhrFGZE64P/cIGwu3a0/
 JuEapaJP2wtGEg7aMAI7N4E2uovEtzgzgqUgwTC19bKKSz+hVqnxFetixOrcXoN/rHKM
 Ms8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775597597; x=1776202397;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XV3An3FqIm/uMA63vtOdEw9AGWQnooxC1EXqM8LO8Gc=;
 b=lAi8DNpTerTrt+1pSQbd1U2oCw+oEzUjEwr/QCevP+XTRkANDBnYfgwvL554V+Gd4c
 MrpqMgCauqczLaoWdQVxn4A1EQEkqUGVMHL75mz+cCvrlggPTyXAybWGIvm7l6GLrr36
 zwGHp1US6Wg4239Cd3nCf0Qq6/olBiaKv+GYX4CS0ieYd3vwzQOdVYN0TgyzV8lbNSWb
 x2NKRSkQdtIfAuhsO8nKus1d0QHGrbm/ouZyCv3iBEmea7bJJRD//ubV2pi5PRraa5Gc
 mDMgnhUzbxlud/RcSZFWSJkpr1RJsvmUiAvlTHMoTKXl5HtAlMQs/G1u1NKfMWvoFa+N
 2ZKw==
X-Gm-Message-State: AOJu0YwiSNe4inSFLmqsWChWvaLj2u7H36MKebAyzoHkYGgkt0n9YapJ
 03A0imD4V6z9J70mhsT0eTn4SEEjsbuDt8PbM2qWTSu2Xp0HrWFJqfsC5BDYV6ca+mLYIeyrCSP
 jhV/NNyQs2PurZxOMFg0O/Hf5dpAmzvW6QQ==
X-Gm-Gg: AeBDiet2cG2f6EX5Nr8NtCO8ipcYqPYEZHKezKicANN/eBxNXr1aBpIRcWe6ytIxIQ0
 FHcNJK3TAXswTWbPsSKsSLrsTVGQxqRqnN2f10TynlaQGBnrNMXzGxInl7zpQE+cglrlW0HEyAV
 RRUiNlCwRmPLjRE6btzv1jFmDN8TDMrFFSzzd+goIkEKDzcPeIFduTy/oBWIYNCQXzyuM2fB8zR
 5NvLmRxWLWrWBEQNrKg9dUwJ6rPs43YwjfOPnHu+zlhK0b6/ifLFO/WzQh6hbavW8T5g0VqWSBc
 B0LENb9qB88YVDr5GtZMDxhmgYT7tHJA7KT5USrfYxTsz15urck=
X-Received: by 2002:a05:651c:420f:b0:38d:e744:8677 with SMTP id
 38308e7fff4ca-38de744890bmr45371261fa.2.1775597596812; Tue, 07 Apr 2026
 14:33:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSCTzpeXqM7X1oOeejumd6HMCJxhxWxy9D8KOajYaevT=09Mg@mail.gmail.com>
 <20260403194955.GK41863@bill-the-cat>
 <CAJSCTzqxkLEhXdNWeK8vP2Uaw+a0szOXukJwv_yFE8AZ3WK9LA@mail.gmail.com>
 <CAJSCTzozBeu86O-rwODrVB2K=3Jdx1MhkyVNdTDhdwrRAkWe-w@mail.gmail.com>
 <20260406154935.GR41863@bill-the-cat>
In-Reply-To: <20260406154935.GR41863@bill-the-cat>
From: manizzle alexandria <manizzle.msf@gmail.com>
Date: Tue, 7 Apr 2026 14:33:04 -0700
X-Gm-Features: AQROBzDjpMlmiae_sv2Pw2Zdsb6KdRIo3gh5gpK4wmAwgOxnyJDhJRruN2NHoHs
Message-ID: <CAJSCTzrN6vtYK1Z1jiatZG5CgCUHLUzwqbUk9MYdmtYLhA6jzg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BSECURITY=5D_NFS_symlink_chain_buffer_overflow_=E2=86=92?=
 =?UTF-8?Q?_remote_code_execution_=28net=2Fnfs=2Dcommon=2Ec=29?=
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
X-Mailman-Approved-At: Wed, 08 Apr 2026 14:55:46 +0200
Content-Type: text/plain; charset="UTF-8"
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

Done!

Thanks!

On Mon, Apr 6, 2026 at 8:49=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote:

> On Fri, Apr 03, 2026 at 09:05:40PM -0700, manizzle alexandria wrote:
>
> > Hi
> >
> > Attached is the .patch file in the format requested. Thanks!
>
> Please send the patch directly (git send-email is good for this), and CC
> the appropriate maintainers as well, in order to start discussion.
> Thanks again!
>
> >
> >
> > On Fri, Apr 3, 2026 at 1:44=E2=80=AFPM manizzle alexandria <
> manizzle.msf@gmail.com>
> > wrote:
> >
> > > Will clean up the PoC and send a proper patch following the link.
> > >
> > > Thanks for the quick review.
> > >
> > > On Fri, Apr 3, 2026, 12:49=E2=80=AFPM Tom Rini <trini@konsulko.com> w=
rote:
> > >
> > >> On Fri, Apr 03, 2026 at 11:44:49AM -0700, manizzle alexandria wrote:
> > >>
> > >> >   Hi Tom,
> > >> >
> > >> >   I'm reporting a remotely exploitable buffer overflow in U-Boot's
> NFS
> > >> >   client that I've confirmed leads to arbitrary code execution.
> > >> >
> > >> >   SUMMARY
> > >> >
> > >> >   A rogue NFS server can chain two READLINK (symlink) responses to
> > >> >   overflow the global nfs_path_buff[2048] in net/nfs-common.c by
> ~141
> > >> >   bytes. This corrupts the nfs_path pointer and adjacent globals,
> > >> >   allowing the attacker to hijack the NFS state machine and delive=
r
> > >> >   shellcode to a known memory address. I have a working end-to-end
> > >> >   exploit with code execution confirmed on QEMU ARM (Cortex-A15).
> > >> >
> > >> >   No authentication is required. The overflow triggers during norm=
al
> > >> >   NFS boot before any OS is loaded.
> > >> >
> > >> >   AFFECTED
> > >> >
> > >> >   - All U-Boot versions with CONFIG_CMD_NFS=3Dy (NFS boot support)
> > >> >   - Tested on: 2026.04-rc5, commit c704af3c8b0
> > >> >   - File: net/nfs-common.c, function nfs_readlink_reply(), lines
> 667-686
> > >> >
> > >> >   ROOT CAUSE
> > >> >
> > >> >   nfs_readlink_reply() reads the symlink target length (rlen) from
> > >> >   the RPC reply and validates it against the packet size, but NOT
> > >> >   against the destination buffer (nfs_path_buff[2048]):
> > >> >
> > >> >     rlen =3D ntohl(rpc_pkt.u.reply.data[1 + nfsv3_data_offset]);
> > >> >
> > >> >     // Checks rlen fits in packet =E2=80=94 CORRECT
> > >> >     if (((uchar *)&rpc_pkt.u.reply.data[0] - (uchar *)&rpc_pkt +
> rlen) >
> > >> > len)
> > >> >         return -NFS_RPC_DROP;
> > >> >
> > >> >     // Copies rlen bytes into nfs_path =E2=80=94 NO CHECK against =
buffer
> size
> > >> >     memcpy(nfs_path + pathlen, ..., rlen);
> > >> >
> > >> >   A single response can't overflow because rlen maxes at ~1128
> (packet
> > >> >   size limit). But two chained relative symlinks accumulate path
> length:
> > >> >
> > >> >     1st READLINK: 1100-byte relative target =E2=86=92 nfs_path gro=
ws to
> ~1060B
> > >> >     2nd READLINK: 1128-byte relative target =E2=86=92 writes to of=
fset 2189
> > >> >                   =E2=86=92 overflows nfs_path_buff[2048] by ~141 =
bytes
> > >> >
> > >> >   EXPLOIT CHAIN
> > >> >
> > >> >     1. Portmap lookup  =E2=86=92 attacker returns fake mountd/nfsd=
 ports
> > >> >     2. Mount           =E2=86=92 attacker returns fake file handle
> > >> >     3. Lookup          =E2=86=92 attacker returns file handle
> > >> >     4. Read            =E2=86=92 attacker returns NFSERR_ISDIR (tr=
iggers
> > >> symlink)
> > >> >     5. Readlink #1     =E2=86=92 1100-byte relative symlink (grows=
 path)
> > >> >     6. Readlink #2     =E2=86=92 OVERFLOW =E2=80=94 overwrites nfs=
_path pointer to
> > >> >                          attacker-planted "/x" string, state machi=
ne
> > >> > survives
> > >> >     7. Mount/Lookup    =E2=86=92 re-enters NFS flow with controlle=
d path
> > >> >     8. Read            =E2=86=92 attacker serves ARM shellcode as =
file
> content
> > >> >                          =E2=86=92 written to image_load_addr (0x4=
2000000)
> > >> >     9. Code execution  =E2=86=92 shellcode runs, writes "PWNED!" t=
o UART
> > >> >
> > >> >   PROOF
> > >> >
> > >> >   GDB output after exploit:
> > >> >
> > >> >     =3D=3D=3D SHELLCODE AT 0x42000000 =3D=3D=3D
> > >> >        0x42000000:  mov   r0, #9
> > >> >        0x42000004:  lsl   r0, r0, #24      @ r0 =3D 0x09000000 (UA=
RT)
> > >> >        0x42000008:  mov   r1, #0x50        @ 'P'
> > >> >        0x4200000c:  str   r1, [r0]         @ write to UART
> > >> >        ...
> > >> >
> > >> >     =3D=3D=3D AFTER EXECUTION =3D=3D=3D
> > >> >        pc =3D 0x42000040   (completed, infinite loop)
> > >> >        r0 =3D 0x09000000   (UART base)
> > >> >        r1 =3D 0x0a         (newline)
> > >> >
> > >> >     =3D=3D=3D QEMU UART =3D=3D=3D
> > >> >        Loading: *T #PWNED!
> > >> >
> > >> >   SUGGESTED FIX
> > >> >
> > >> >   Add a bounds check before the memcpy in nfs_readlink_reply():
> > >> >
> > >> >     --- a/net/nfs-common.c
> > >> >     +++ b/net/nfs-common.c
> > >> >     @@ -670,6 +670,10 @@
> > >> >          if (((uchar *)&rpc_pkt.u.reply.data[0] - (uchar *)&rpc_pk=
t
> +
> > >> rlen)
> > >> > > len)
> > >> >              return -NFS_RPC_DROP;
> > >> >
> > >> >     +    int current_len =3D strlen(nfs_path) + 1;
> > >> >     +    if (current_len + rlen >=3D sizeof(nfs_path_buff))
> > >> >     +        return -NFS_RPC_ERR;
> > >> >     +
> > >> >          if (*((char *)&rpc_pkt.u.reply.data[2 +
> nfsv3_data_offset]) !=3D
> > >> > '/') {
> > >> >
> > >> >   I have a full advisory document and working PoC (Python script,
> ~300
> > >> >   lines) attached. The PoC runs as a rogue NFS server and was test=
ed
> > >> >   against QEMU ARM virt with qemu_arm_defconfig.
> > >> >
> > >> >   I'm requesting a CVE for this issue. I plan to follow standard
> 90-day
> > >> >   coordinated disclosure. Please let me know if you need anything
> else
> > >> >   or would like to discuss the fix.
> > >> >
> > >> >   Thanks,
> > >> >   Murtaza Munaim
> > >>
> > >> > # Security Advisory: U-Boot NFS Symlink Chain Remote Code Executio=
n
> > >> >
> > >> > ## Summary
> > >> >
> > >> > A buffer overflow vulnerability in U-Boot's NFS client allows a
> rogue
> > >> NFS
> > >> > server to achieve remote code execution on the target device durin=
g
> > >> network
> > >> > boot. No authentication is required. The attacker serves crafted N=
FS
> > >> > symlink responses that overflow the global `nfs_path_buff[2048]`
> buffer,
> > >> > corrupting adjacent pointers and hijacking the NFS state machine t=
o
> > >> deliver
> > >> > and execute arbitrary shellcode.
> > >> >
> > >> > ## Affected Software
> > >> >
> > >> > - **Product:** Das U-Boot
> > >> > - **Component:** `net/nfs-common.c`, function `nfs_readlink_reply(=
)`
> > >> > - **Affected versions:** All versions with NFS boot support (at
> least
> > >> since NFSv3 support was added; tested on 2026.04-rc5, commit
> `c704af3c8b0`)
> > >> > - **Configurations:** Any build with `CONFIG_CMD_NFS=3Dy` (NFS boo=
t
> > >> enabled)
> > >> >
> > >> > ## CVSS Score
> > >> >
> > >> > **8.1 (High)** =E2=80=94 CVSS:3.1/AV:N/AC:H/PR:N/UI:N/S:U/C:H/I:H/=
A:H
> > >> >
> > >> > - **Attack Vector:** Network (rogue NFS server)
> > >> > - **Attack Complexity:** High (target must be performing NFS boot)
> > >> > - **Privileges Required:** None
> > >> > - **User Interaction:** None (beyond initiating NFS boot, which is
> > >> typically automatic)
> > >> > - **Impact:** Complete compromise of bootloader execution context
> > >> >
> > >> > ## Vulnerability Details
> > >> >
> > >> > ### Root Cause
> > >> >
> > >> > In `net/nfs-common.c`, the function `nfs_readlink_reply()`
> processes NFS
> > >> > READLINK responses (symlink target resolution). At line 667, it
> reads
> > >> the
> > >> > symlink target length (`rlen`) from the RPC reply:
> > >> >
> > >> > ```c
> > >> > rlen =3D ntohl(rpc_pkt.u.reply.data[1 + nfsv3_data_offset]);
> > >> > ```
> > >> >
> > >> > The bounds check at line 669 validates that `rlen` fits within the
> **RPC
> > >> > packet buffer** (1152 bytes):
> > >> >
> > >> > ```c
> > >> > if (((uchar *)&rpc_pkt.u.reply.data[0] - (uchar *)&rpc_pkt + rlen)=
 >
> > >> len)
> > >> >     return -NFS_RPC_DROP;
> > >> > ```
> > >> >
> > >> > However, it does **not** validate that `rlen` fits within the
> > >> **destination
> > >> > buffer** `nfs_path_buff[2048]`. When processing a relative symlink
> (line
> > >> > 672-680), the target is appended to the existing path:
> > >> >
> > >> > ```c
> > >> > strcat(nfs_path, "/");
> > >> > pathlen =3D strlen(nfs_path);
> > >> > memcpy(nfs_path + pathlen,
> > >> >        (uchar *)&rpc_pkt.u.reply.data[2 + nfsv3_data_offset],
> > >> >        rlen);
> > >> > nfs_path[pathlen + rlen] =3D 0;
> > >> > ```
> > >> >
> > >> > ### Exploitation via Symlink Chaining
> > >> >
> > >> > A single READLINK response cannot overflow the buffer because
> `rlen` is
> > >> > capped at ~1128 bytes (by the packet size check) and `nfs_path`
> starts
> > >> > short (~10 bytes). However, by chaining **two** symlink resolution=
s:
> > >> >
> > >> > 1. **First READLINK:** Server returns a ~1100-byte relative symlin=
k
> > >> target
> > >> >    with directory separators (`a/b/c/.../x`). After `nfs_dirname()=
`,
> > >> >    `nfs_path` retains ~1060 bytes.
> > >> >
> > >> > 2. **Second READLINK:** Server returns a ~1128-byte relative symli=
nk
> > >> >    target. The `memcpy` writes to offset `1061 + 1128 =3D 2189`,
> exceeding
> > >> >    `nfs_path_buff[2048]` by approximately **141 bytes**.
> > >> >
> > >> > ### What Gets Overwritten
> > >> >
> > >> > The overflow corrupts global variables adjacent to `nfs_path_buff`
> in
> > >> BSS
> > >> > (verified via `nm` on QEMU ARM build):
> > >> >
> > >> > | Offset from buffer end | Variable | Type | Impact |
> > >> > |------------------------|----------|------|--------|
> > >> > | +0 | `nfs_path` | `char *` | Pointer to current NFS path =E2=80=
=94
> controls
> > >> future memory writes |
> > >> > | +4 | `nfs_filename` | `char *` | Pointer to filename component |
> > >> > | +8 | `nfs_download_state` | `enum` | Controls boot
> success/failure |
> > >> > | +12 | `filefh3_length` | `uint` | NFS file handle length |
> > >> > | +16 | `filefh` | `char[64]` | NFS file handle =E2=80=94 controls=
 which
> file
> > >> is read |
> > >> >
> > >> > ### Code Execution Chain
> > >> >
> > >> > By overwriting `nfs_path` to point to a short valid path string
> (e.g.,
> > >> > `"/x"`) planted within the overflow payload itself, the attacker
> keeps
> > >> the
> > >> > NFS state machine alive. The state machine then:
> > >> >
> > >> > 1. Re-mounts the filesystem (MOUNT `/`)
> > >> > 2. Looks up the file (LOOKUP `x`)
> > >> > 3. Reads file content (READ) =E2=80=94 the server serves **arbitra=
ry
> shellcode**
> > >> > 4. `store_block()` writes the shellcode to `image_load_addr` (e.g.=
,
> > >> `0x42000000`)
> > >> >
> > >> > The shellcode is now in memory at a known address. In typical
> embedded
> > >> boot
> > >> > configurations, `bootm` or `go` is called on the load address afte=
r
> NFS
> > >> > download, executing the attacker's code.
> > >> >
> > >> > ## Proof of Concept
> > >> >
> > >> > A complete working exploit (`nfs_rce.py`) is provided. It was test=
ed
> > >> > against U-Boot 2026.04-rc5 running on QEMU ARM
> (`qemu_arm_defconfig`,
> > >> > Cortex-A15, 256MB RAM).
> > >> >
> > >> > ### Tested Exploit Chain
> > >> >
> > >> > ```
> > >> > [1] PORTMAP      =E2=86=92 returned fake mountd/nfsd ports
> > >> > [2] MOUNT        =E2=86=92 returned fake file handle
> > >> > [3] LOOKUP       =E2=86=92 returned success with file handle
> > >> > [4] READ         =E2=86=92 returned NFSERR_ISDIR =E2=86=92 trigger=
ed symlink
> > >> > [5] READLINK #1  =E2=86=92 1100-byte relative symlink (grew nfs_pa=
th to
> ~1060B)
> > >> > [6] READLINK #2  =E2=86=92 1128-byte overflow payload
> > >> >                     Overwrote nfs_path =E2=86=92 valid "/x" string
> > >> >                     State machine survived and continued
> > >> > [7] MOUNT/LOOKUP =E2=86=92 re-entered NFS flow with attacker-contr=
olled path
> > >> > [8] READ         =E2=86=92 served 68-byte ARM shellcode =E2=86=92 =
written to
> 0x42000000
> > >> > [9] EXECUTION    =E2=86=92 shellcode wrote "PWNED!" to PL011 UART
> > >> > ```
> > >> >
> > >> > ### GDB Verification
> > >> >
> > >> > ```
> > >> > =3D=3D=3D SHELLCODE AT 0x42000000 =3D=3D=3D
> > >> >    0x42000000:  mov   r0, #9
> > >> >    0x42000004:  lsl   r0, r0, #24      @ r0 =3D 0x09000000 (UART b=
ase)
> > >> >    0x42000008:  mov   r1, #0x50        @ 'P'
> > >> >    0x4200000c:  str   r1, [r0]         @ write to UART
> > >> >
> > >> > =3D=3D=3D AFTER EXECUTION =3D=3D=3D
> > >> >    pc =3D 0x42000040   (completed, hit infinite loop)
> > >> >    r0 =3D 0x09000000   (UART base)
> > >> >    r1 =3D 0x0a         (newline =E2=80=94 last char written)
> > >> >
> > >> > =3D=3D=3D QEMU UART OUTPUT =3D=3D=3D
> > >> >    Loading: *T #PWNED!
> > >> >    >>> CODE EXECUTION CONFIRMED <<<
> > >> > ```
> > >> >
> > >> > ### Reproduction Steps
> > >> >
> > >> > ```bash
> > >> > # 1. Build U-Boot for QEMU ARM with NFS enabled
> > >> > cd u-boot
> > >> > make CROSS_COMPILE=3Darm-none-eabi- qemu_arm_defconfig
> > >> > # Enable CONFIG_CMD_NFS=3Dy in .config
> > >> > make CROSS_COMPILE=3Darm-none-eabi- -j$(nproc)
> > >> >
> > >> > # 2. Start the exploit server
> > >> > python3 nfs_rce.py
> > >> >
> > >> > # 3. Start QEMU
> > >> > qemu-system-arm -machine virt -cpu cortex-a15 -m 256M -nographic \
> > >> >     -bios u-boot.bin \
> > >> >     -netdev user,id=3Dnet0,net=3D10.0.2.0/24,dhcpstart=3D10.0.2.15=
 \
> > >> >     -device virtio-net-device,netdev=3Dnet0
> > >> >
> > >> > # 4. In U-Boot console:
> > >> > setenv ipaddr 10.0.2.15
> > >> > setenv serverip 10.0.2.2
> > >> > nfs 0x42000000 10.0.2.2:/boot/uImage
> > >> >
> > >> > # 5. Observe "PWNED!" in UART output (or verify via GDB at
> 0x42000000)
> > >> > ```
> > >> >
> > >> > ## Suggested Fix
> > >> >
> > >> > Add a bounds check against `nfs_path_buff` size before the `memcpy=
`
> in
> > >> > `nfs_readlink_reply()`:
> > >> >
> > >> > ```c
> > >> > --- a/net/nfs-common.c
> > >> > +++ b/net/nfs-common.c
> > >> > @@ -670,6 +670,11 @@ static int nfs_readlink_reply(uchar *pkt,
> unsigned
> > >> int len)
> > >> >       if (((uchar *)&rpc_pkt.u.reply.data[0] - (uchar *)&rpc_pkt +
> > >> rlen) > len)
> > >> >               return -NFS_RPC_DROP;
> > >> >
> > >> > +     /* Validate symlink target fits in nfs_path_buff */
> > >> > +     int current_len =3D strlen(nfs_path) + 1; /* +1 for '/' */
> > >> > +     if (current_len + rlen >=3D sizeof(nfs_path_buff))
> > >> > +             return -NFS_RPC_ERR;
> > >> > +
> > >> >       if (*((char *)&rpc_pkt.u.reply.data[2 + nfsv3_data_offset]) =
!=3D
> > >> '/') {
> > >> >               int pathlen;
> > >> > ```
> > >> >
> > >> > Additionally, consider replacing `strcat`/`memcpy` with
> bounds-checked
> > >> > alternatives throughout the NFS path handling code.
> > >>
> > >> Thanks for the report, please see
> > >> https://docs.u-boot.org/en/latest/develop/sending_patches.html for
> how
> > >> to properly submit a patch, thanks!
> > >>
> > >> --
> > >> Tom
> > >>
> > >
>
>
>
> --
> Tom
>
