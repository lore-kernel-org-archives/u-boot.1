Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A18E88D87
	for <u-boot@archiver.kernel.org>; Sat,  4 Apr 2026 06:32:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE4EC841C8;
	Sat,  4 Apr 2026 08:31:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DrooHs3z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B665840ED; Sat,  4 Apr 2026 06:05:57 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B4D383B8F
 for <u-boot@lists.denx.de>; Sat,  4 Apr 2026 06:05:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=manizzle.msf@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-38dd5f28a4cso7651211fa.2
 for <u-boot@lists.denx.de>; Fri, 03 Apr 2026 21:05:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775275553; cv=none;
 d=google.com; s=arc-20240605;
 b=I6xCTTot1Gjz+domTfy+Ec1LPSGRufEnpGef1F/tIWZDE224aZ7w9RLf2T5fcTNVf5
 TT4CGCkiRGLy0JfuztEE1m4RWtQf82tLI1YxiISdIl+ew7TRM688rFkfuOYZNQrFP1Cz
 QDAwcuLinRLVXoBoCa1UozQRSAd38zS9hUuJ9XbGdL7ZUTZdDj1kDnhxs35uGDRFtHLH
 QFxFW4DUrWK6jCzj7CLVAr8222FD+wkjHPiyuyWNTMaTgvBHPbrlQEhmjwmQadiuzr5U
 pNFQVrnAzP7e9gH5RxsoDPQGh7qHMg6QYw9wDGNZgm2zCB+IaqGnX5HqGybrSwyrTA9o
 XRng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=41gYOj605NQyijBChaNUTNGdhivL/wmI0uOISgfLnu8=;
 fh=3cGkqt4Xgv2w9dTeeIJFEJ5AO4AvGobPArcY4WlS1wc=;
 b=HRY+G/vAKksTdJxq4Y41XDEhmtRz1gEsTGmKozytNDVHzSnFDFxZq7dpr76bTEZgFT
 C3ko6FPeZNU7bND9cIGx1aa7vyzMpo1vF4/y0WXBdVwDw9pBjENcRofLkd7qYYWNLbIr
 LNZRiREZqLkYhs4VBSkoTd4E1YsFRdZhggrUQwcYhD4p0rnTG9dYEIFLBcXH2Onucde9
 rAWNTaTVI+Zuzk4arYF2PnDRFimmXPOGK9CQz3PkeS+/QdI6Z4lGIPe6S1X0JYV0oQLG
 ocJjsQRKapW3J2oF1jMkDpB8XOE1QPoov0jmSIcO6ukcyaDPuA3fnmBPAq04yV6eb4cG
 YFww==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775275553; x=1775880353; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=41gYOj605NQyijBChaNUTNGdhivL/wmI0uOISgfLnu8=;
 b=DrooHs3z0VKAhuuBqGoLMJWEQ0tpcTHc/aPzo5DufrryaMdm0p8KxXyZxDTVODvzlS
 DmKc8xBJuphvi2wu3UXH/5EOvtSSnxG9l3npB9ig3jFv8GOUltV888o/TJK4hr+myL+g
 caEK34T0b5iIe5bR6dC+1RDWxLXkQoIy2xGxEf9uodJTy0ZMHhIXWfFCXYbV7S59WMDt
 O8L/XwQSLuduX9sNloQRuUkMnsjqv4RQcSq4DI+PuRMHxndJvQD/7nq+kACvItbzK1Bc
 24bIkuazZmIQeiTAYcVXauxFYFZFH/52nsGMc8dNAh3eK74sx4uYJy8aRynby4CFtI88
 TKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775275553; x=1775880353;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=41gYOj605NQyijBChaNUTNGdhivL/wmI0uOISgfLnu8=;
 b=Zs8AZ8n01fIAH++TyXnzXesb20M09efNS+xzibyAIgCfBo/zL/14F4L/ypETLIayt2
 li3h/iesrTGsOFQtHOq095pqdfKVxae6ia8uwkgzFmYBFYrKBhUzkcliE9lSzmjuzTTz
 f/EAKgD4chdZDH0ssSXte64aIqO06BvsCynvPwrfRDy/nd7RN3WvYqt8b2d/XxML8yQ7
 /bYOrHFYqR1rxI52xY/QEQIjOzhY6hOHtL3GIsbNAfGjU5eSoWSNkd+wL4Ok/0yTgEMF
 8iMsTSlBsdBtJa9qpfqK7c9TZ+yuzXSSBootJjTm9aNWfj025WvhmNcn/tmJV4sr2+7D
 rT1Q==
X-Gm-Message-State: AOJu0Yw0dd1+b367PXxXtXg6yQGEJaXXyU/uQM5ma+66XEa1SDsfm60A
 MYmHDeUh8esKbxRIUB5sI2N5MX5xh+55y2wJgN9+u+tiX0yIaKM0EpgHfdC0Shqc+FJ1Qe5/GNI
 YrRQvigb4RwChb/7SlnnLzCDSbuaH/54ocQ==
X-Gm-Gg: AeBDietDqP6ausgc9Zlcsc4Tjc0QpyCVLDV+ljXb6IoRJaT/TNV3GMjtYRng4WAwp5F
 7NPdiU3E7ye7KymYqKiQjCQWmXfH0hEuYT20pzNX7U8cPmKJvHrX5HPEvSV38iIHxn9ksAZj31X
 NVwJLaAWOEngUUPgOLFxBF95hXd/yLy3i95XUp/6CePWxUWeC56MQKQ2bo7dv4xXOMGboi0iUYg
 kcNDX7eZGbgrtgYoFsGcTjqIYpIHAiAkG7wZ7JBOyBY3jy8PlvJxAoySofcwRZgneinEdTGqWOO
 nqXRF3LD1sVm33Hz3ntS6QnDAMQJVVHRFZyAtnQ+B/kCJhIqoEU=
X-Received: by 2002:a05:651c:30c9:b0:38c:b9f3:eeb with SMTP id
 38308e7fff4ca-38d8d4ec0f8mr16295141fa.15.1775275553017; Fri, 03 Apr 2026
 21:05:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSCTzpeXqM7X1oOeejumd6HMCJxhxWxy9D8KOajYaevT=09Mg@mail.gmail.com>
 <20260403194955.GK41863@bill-the-cat>
 <CAJSCTzqxkLEhXdNWeK8vP2Uaw+a0szOXukJwv_yFE8AZ3WK9LA@mail.gmail.com>
In-Reply-To: <CAJSCTzqxkLEhXdNWeK8vP2Uaw+a0szOXukJwv_yFE8AZ3WK9LA@mail.gmail.com>
From: manizzle alexandria <manizzle.msf@gmail.com>
Date: Fri, 3 Apr 2026 21:05:40 -0700
X-Gm-Features: AQROBzDiGTlrjzaPkwOC5YGverXl1fY1sST7gcaZRIJ5RkorjGgH5lP0bGfwgig
Message-ID: <CAJSCTzozBeu86O-rwODrVB2K=3Jdx1MhkyVNdTDhdwrRAkWe-w@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BSECURITY=5D_NFS_symlink_chain_buffer_overflow_=E2=86=92?=
 =?UTF-8?Q?_remote_code_execution_=28net=2Fnfs=2Dcommon=2Ec=29?=
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Content-Type: multipart/mixed; boundary="000000000000b76c1c064e9a8cee"
X-Mailman-Approved-At: Sat, 04 Apr 2026 08:31:19 +0200
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

--000000000000b76c1c064e9a8cee
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

Attached is the .patch file in the format requested. Thanks!


On Fri, Apr 3, 2026 at 1:44=E2=80=AFPM manizzle alexandria <manizzle.msf@gm=
ail.com>
wrote:

> Will clean up the PoC and send a proper patch following the link.
>
> Thanks for the quick review.
>
> On Fri, Apr 3, 2026, 12:49=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
>> On Fri, Apr 03, 2026 at 11:44:49AM -0700, manizzle alexandria wrote:
>>
>> >   Hi Tom,
>> >
>> >   I'm reporting a remotely exploitable buffer overflow in U-Boot's NFS
>> >   client that I've confirmed leads to arbitrary code execution.
>> >
>> >   SUMMARY
>> >
>> >   A rogue NFS server can chain two READLINK (symlink) responses to
>> >   overflow the global nfs_path_buff[2048] in net/nfs-common.c by ~141
>> >   bytes. This corrupts the nfs_path pointer and adjacent globals,
>> >   allowing the attacker to hijack the NFS state machine and deliver
>> >   shellcode to a known memory address. I have a working end-to-end
>> >   exploit with code execution confirmed on QEMU ARM (Cortex-A15).
>> >
>> >   No authentication is required. The overflow triggers during normal
>> >   NFS boot before any OS is loaded.
>> >
>> >   AFFECTED
>> >
>> >   - All U-Boot versions with CONFIG_CMD_NFS=3Dy (NFS boot support)
>> >   - Tested on: 2026.04-rc5, commit c704af3c8b0
>> >   - File: net/nfs-common.c, function nfs_readlink_reply(), lines 667-6=
86
>> >
>> >   ROOT CAUSE
>> >
>> >   nfs_readlink_reply() reads the symlink target length (rlen) from
>> >   the RPC reply and validates it against the packet size, but NOT
>> >   against the destination buffer (nfs_path_buff[2048]):
>> >
>> >     rlen =3D ntohl(rpc_pkt.u.reply.data[1 + nfsv3_data_offset]);
>> >
>> >     // Checks rlen fits in packet =E2=80=94 CORRECT
>> >     if (((uchar *)&rpc_pkt.u.reply.data[0] - (uchar *)&rpc_pkt + rlen)=
 >
>> > len)
>> >         return -NFS_RPC_DROP;
>> >
>> >     // Copies rlen bytes into nfs_path =E2=80=94 NO CHECK against buff=
er size
>> >     memcpy(nfs_path + pathlen, ..., rlen);
>> >
>> >   A single response can't overflow because rlen maxes at ~1128 (packet
>> >   size limit). But two chained relative symlinks accumulate path lengt=
h:
>> >
>> >     1st READLINK: 1100-byte relative target =E2=86=92 nfs_path grows t=
o ~1060B
>> >     2nd READLINK: 1128-byte relative target =E2=86=92 writes to offset=
 2189
>> >                   =E2=86=92 overflows nfs_path_buff[2048] by ~141 byte=
s
>> >
>> >   EXPLOIT CHAIN
>> >
>> >     1. Portmap lookup  =E2=86=92 attacker returns fake mountd/nfsd por=
ts
>> >     2. Mount           =E2=86=92 attacker returns fake file handle
>> >     3. Lookup          =E2=86=92 attacker returns file handle
>> >     4. Read            =E2=86=92 attacker returns NFSERR_ISDIR (trigge=
rs
>> symlink)
>> >     5. Readlink #1     =E2=86=92 1100-byte relative symlink (grows pat=
h)
>> >     6. Readlink #2     =E2=86=92 OVERFLOW =E2=80=94 overwrites nfs_pat=
h pointer to
>> >                          attacker-planted "/x" string, state machine
>> > survives
>> >     7. Mount/Lookup    =E2=86=92 re-enters NFS flow with controlled pa=
th
>> >     8. Read            =E2=86=92 attacker serves ARM shellcode as file=
 content
>> >                          =E2=86=92 written to image_load_addr (0x42000=
000)
>> >     9. Code execution  =E2=86=92 shellcode runs, writes "PWNED!" to UA=
RT
>> >
>> >   PROOF
>> >
>> >   GDB output after exploit:
>> >
>> >     =3D=3D=3D SHELLCODE AT 0x42000000 =3D=3D=3D
>> >        0x42000000:  mov   r0, #9
>> >        0x42000004:  lsl   r0, r0, #24      @ r0 =3D 0x09000000 (UART)
>> >        0x42000008:  mov   r1, #0x50        @ 'P'
>> >        0x4200000c:  str   r1, [r0]         @ write to UART
>> >        ...
>> >
>> >     =3D=3D=3D AFTER EXECUTION =3D=3D=3D
>> >        pc =3D 0x42000040   (completed, infinite loop)
>> >        r0 =3D 0x09000000   (UART base)
>> >        r1 =3D 0x0a         (newline)
>> >
>> >     =3D=3D=3D QEMU UART =3D=3D=3D
>> >        Loading: *T #PWNED!
>> >
>> >   SUGGESTED FIX
>> >
>> >   Add a bounds check before the memcpy in nfs_readlink_reply():
>> >
>> >     --- a/net/nfs-common.c
>> >     +++ b/net/nfs-common.c
>> >     @@ -670,6 +670,10 @@
>> >          if (((uchar *)&rpc_pkt.u.reply.data[0] - (uchar *)&rpc_pkt +
>> rlen)
>> > > len)
>> >              return -NFS_RPC_DROP;
>> >
>> >     +    int current_len =3D strlen(nfs_path) + 1;
>> >     +    if (current_len + rlen >=3D sizeof(nfs_path_buff))
>> >     +        return -NFS_RPC_ERR;
>> >     +
>> >          if (*((char *)&rpc_pkt.u.reply.data[2 + nfsv3_data_offset]) !=
=3D
>> > '/') {
>> >
>> >   I have a full advisory document and working PoC (Python script, ~300
>> >   lines) attached. The PoC runs as a rogue NFS server and was tested
>> >   against QEMU ARM virt with qemu_arm_defconfig.
>> >
>> >   I'm requesting a CVE for this issue. I plan to follow standard 90-da=
y
>> >   coordinated disclosure. Please let me know if you need anything else
>> >   or would like to discuss the fix.
>> >
>> >   Thanks,
>> >   Murtaza Munaim
>>
>> > # Security Advisory: U-Boot NFS Symlink Chain Remote Code Execution
>> >
>> > ## Summary
>> >
>> > A buffer overflow vulnerability in U-Boot's NFS client allows a rogue
>> NFS
>> > server to achieve remote code execution on the target device during
>> network
>> > boot. No authentication is required. The attacker serves crafted NFS
>> > symlink responses that overflow the global `nfs_path_buff[2048]` buffe=
r,
>> > corrupting adjacent pointers and hijacking the NFS state machine to
>> deliver
>> > and execute arbitrary shellcode.
>> >
>> > ## Affected Software
>> >
>> > - **Product:** Das U-Boot
>> > - **Component:** `net/nfs-common.c`, function `nfs_readlink_reply()`
>> > - **Affected versions:** All versions with NFS boot support (at least
>> since NFSv3 support was added; tested on 2026.04-rc5, commit `c704af3c8b=
0`)
>> > - **Configurations:** Any build with `CONFIG_CMD_NFS=3Dy` (NFS boot
>> enabled)
>> >
>> > ## CVSS Score
>> >
>> > **8.1 (High)** =E2=80=94 CVSS:3.1/AV:N/AC:H/PR:N/UI:N/S:U/C:H/I:H/A:H
>> >
>> > - **Attack Vector:** Network (rogue NFS server)
>> > - **Attack Complexity:** High (target must be performing NFS boot)
>> > - **Privileges Required:** None
>> > - **User Interaction:** None (beyond initiating NFS boot, which is
>> typically automatic)
>> > - **Impact:** Complete compromise of bootloader execution context
>> >
>> > ## Vulnerability Details
>> >
>> > ### Root Cause
>> >
>> > In `net/nfs-common.c`, the function `nfs_readlink_reply()` processes N=
FS
>> > READLINK responses (symlink target resolution). At line 667, it reads
>> the
>> > symlink target length (`rlen`) from the RPC reply:
>> >
>> > ```c
>> > rlen =3D ntohl(rpc_pkt.u.reply.data[1 + nfsv3_data_offset]);
>> > ```
>> >
>> > The bounds check at line 669 validates that `rlen` fits within the **R=
PC
>> > packet buffer** (1152 bytes):
>> >
>> > ```c
>> > if (((uchar *)&rpc_pkt.u.reply.data[0] - (uchar *)&rpc_pkt + rlen) >
>> len)
>> >     return -NFS_RPC_DROP;
>> > ```
>> >
>> > However, it does **not** validate that `rlen` fits within the
>> **destination
>> > buffer** `nfs_path_buff[2048]`. When processing a relative symlink (li=
ne
>> > 672-680), the target is appended to the existing path:
>> >
>> > ```c
>> > strcat(nfs_path, "/");
>> > pathlen =3D strlen(nfs_path);
>> > memcpy(nfs_path + pathlen,
>> >        (uchar *)&rpc_pkt.u.reply.data[2 + nfsv3_data_offset],
>> >        rlen);
>> > nfs_path[pathlen + rlen] =3D 0;
>> > ```
>> >
>> > ### Exploitation via Symlink Chaining
>> >
>> > A single READLINK response cannot overflow the buffer because `rlen` i=
s
>> > capped at ~1128 bytes (by the packet size check) and `nfs_path` starts
>> > short (~10 bytes). However, by chaining **two** symlink resolutions:
>> >
>> > 1. **First READLINK:** Server returns a ~1100-byte relative symlink
>> target
>> >    with directory separators (`a/b/c/.../x`). After `nfs_dirname()`,
>> >    `nfs_path` retains ~1060 bytes.
>> >
>> > 2. **Second READLINK:** Server returns a ~1128-byte relative symlink
>> >    target. The `memcpy` writes to offset `1061 + 1128 =3D 2189`, excee=
ding
>> >    `nfs_path_buff[2048]` by approximately **141 bytes**.
>> >
>> > ### What Gets Overwritten
>> >
>> > The overflow corrupts global variables adjacent to `nfs_path_buff` in
>> BSS
>> > (verified via `nm` on QEMU ARM build):
>> >
>> > | Offset from buffer end | Variable | Type | Impact |
>> > |------------------------|----------|------|--------|
>> > | +0 | `nfs_path` | `char *` | Pointer to current NFS path =E2=80=94 c=
ontrols
>> future memory writes |
>> > | +4 | `nfs_filename` | `char *` | Pointer to filename component |
>> > | +8 | `nfs_download_state` | `enum` | Controls boot success/failure |
>> > | +12 | `filefh3_length` | `uint` | NFS file handle length |
>> > | +16 | `filefh` | `char[64]` | NFS file handle =E2=80=94 controls whi=
ch file
>> is read |
>> >
>> > ### Code Execution Chain
>> >
>> > By overwriting `nfs_path` to point to a short valid path string (e.g.,
>> > `"/x"`) planted within the overflow payload itself, the attacker keeps
>> the
>> > NFS state machine alive. The state machine then:
>> >
>> > 1. Re-mounts the filesystem (MOUNT `/`)
>> > 2. Looks up the file (LOOKUP `x`)
>> > 3. Reads file content (READ) =E2=80=94 the server serves **arbitrary s=
hellcode**
>> > 4. `store_block()` writes the shellcode to `image_load_addr` (e.g.,
>> `0x42000000`)
>> >
>> > The shellcode is now in memory at a known address. In typical embedded
>> boot
>> > configurations, `bootm` or `go` is called on the load address after NF=
S
>> > download, executing the attacker's code.
>> >
>> > ## Proof of Concept
>> >
>> > A complete working exploit (`nfs_rce.py`) is provided. It was tested
>> > against U-Boot 2026.04-rc5 running on QEMU ARM (`qemu_arm_defconfig`,
>> > Cortex-A15, 256MB RAM).
>> >
>> > ### Tested Exploit Chain
>> >
>> > ```
>> > [1] PORTMAP      =E2=86=92 returned fake mountd/nfsd ports
>> > [2] MOUNT        =E2=86=92 returned fake file handle
>> > [3] LOOKUP       =E2=86=92 returned success with file handle
>> > [4] READ         =E2=86=92 returned NFSERR_ISDIR =E2=86=92 triggered s=
ymlink
>> > [5] READLINK #1  =E2=86=92 1100-byte relative symlink (grew nfs_path t=
o ~1060B)
>> > [6] READLINK #2  =E2=86=92 1128-byte overflow payload
>> >                     Overwrote nfs_path =E2=86=92 valid "/x" string
>> >                     State machine survived and continued
>> > [7] MOUNT/LOOKUP =E2=86=92 re-entered NFS flow with attacker-controlle=
d path
>> > [8] READ         =E2=86=92 served 68-byte ARM shellcode =E2=86=92 writ=
ten to 0x42000000
>> > [9] EXECUTION    =E2=86=92 shellcode wrote "PWNED!" to PL011 UART
>> > ```
>> >
>> > ### GDB Verification
>> >
>> > ```
>> > =3D=3D=3D SHELLCODE AT 0x42000000 =3D=3D=3D
>> >    0x42000000:  mov   r0, #9
>> >    0x42000004:  lsl   r0, r0, #24      @ r0 =3D 0x09000000 (UART base)
>> >    0x42000008:  mov   r1, #0x50        @ 'P'
>> >    0x4200000c:  str   r1, [r0]         @ write to UART
>> >
>> > =3D=3D=3D AFTER EXECUTION =3D=3D=3D
>> >    pc =3D 0x42000040   (completed, hit infinite loop)
>> >    r0 =3D 0x09000000   (UART base)
>> >    r1 =3D 0x0a         (newline =E2=80=94 last char written)
>> >
>> > =3D=3D=3D QEMU UART OUTPUT =3D=3D=3D
>> >    Loading: *T #PWNED!
>> >    >>> CODE EXECUTION CONFIRMED <<<
>> > ```
>> >
>> > ### Reproduction Steps
>> >
>> > ```bash
>> > # 1. Build U-Boot for QEMU ARM with NFS enabled
>> > cd u-boot
>> > make CROSS_COMPILE=3Darm-none-eabi- qemu_arm_defconfig
>> > # Enable CONFIG_CMD_NFS=3Dy in .config
>> > make CROSS_COMPILE=3Darm-none-eabi- -j$(nproc)
>> >
>> > # 2. Start the exploit server
>> > python3 nfs_rce.py
>> >
>> > # 3. Start QEMU
>> > qemu-system-arm -machine virt -cpu cortex-a15 -m 256M -nographic \
>> >     -bios u-boot.bin \
>> >     -netdev user,id=3Dnet0,net=3D10.0.2.0/24,dhcpstart=3D10.0.2.15 \
>> >     -device virtio-net-device,netdev=3Dnet0
>> >
>> > # 4. In U-Boot console:
>> > setenv ipaddr 10.0.2.15
>> > setenv serverip 10.0.2.2
>> > nfs 0x42000000 10.0.2.2:/boot/uImage
>> >
>> > # 5. Observe "PWNED!" in UART output (or verify via GDB at 0x42000000)
>> > ```
>> >
>> > ## Suggested Fix
>> >
>> > Add a bounds check against `nfs_path_buff` size before the `memcpy` in
>> > `nfs_readlink_reply()`:
>> >
>> > ```c
>> > --- a/net/nfs-common.c
>> > +++ b/net/nfs-common.c
>> > @@ -670,6 +670,11 @@ static int nfs_readlink_reply(uchar *pkt, unsigne=
d
>> int len)
>> >       if (((uchar *)&rpc_pkt.u.reply.data[0] - (uchar *)&rpc_pkt +
>> rlen) > len)
>> >               return -NFS_RPC_DROP;
>> >
>> > +     /* Validate symlink target fits in nfs_path_buff */
>> > +     int current_len =3D strlen(nfs_path) + 1; /* +1 for '/' */
>> > +     if (current_len + rlen >=3D sizeof(nfs_path_buff))
>> > +             return -NFS_RPC_ERR;
>> > +
>> >       if (*((char *)&rpc_pkt.u.reply.data[2 + nfsv3_data_offset]) !=3D
>> '/') {
>> >               int pathlen;
>> > ```
>> >
>> > Additionally, consider replacing `strcat`/`memcpy` with bounds-checked
>> > alternatives throughout the NFS path handling code.
>>
>> Thanks for the report, please see
>> https://docs.u-boot.org/en/latest/develop/sending_patches.html for how
>> to properly submit a patch, thanks!
>>
>> --
>> Tom
>>
>

--000000000000b76c1c064e9a8cee
Content-Type: application/octet-stream; 
	name="0001-net-nfs-fix-buffer-overflow-in-nfs_readlink_reply.patch"
Content-Disposition: attachment; 
	filename="0001-net-nfs-fix-buffer-overflow-in-nfs_readlink_reply.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mnjt7vt00>
X-Attachment-Id: f_mnjt7vt00

RnJvbSA2MTQ2ZjU3NmVlZjRiMWZkNzM3ZDIwMWVhNGI3NWJjMWM1NDAzYzc2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNdXJ0YXphIE11bmFpbSA8bWFuaXp6bGUubXNmQGdtYWlsLmNv
bT4KRGF0ZTogRnJpLCAzIEFwciAyMDI2IDIwOjQwOjM4IC0wNzAwClN1YmplY3Q6IFtQQVRDSF0g
bmV0OiBuZnM6IGZpeCBidWZmZXIgb3ZlcmZsb3cgaW4gbmZzX3JlYWRsaW5rX3JlcGx5KCkKCm5m
c19yZWFkbGlua19yZXBseSgpIGNvcGllcyB0aGUgc3ltbGluayB0YXJnZXQgZnJvbSBhbiBORlMg
UkVBRExJTksKcmVzcG9uc2UgaW50byB0aGUgZ2xvYmFsIG5mc19wYXRoX2J1ZmZbMjA0OF0gdXNp
bmcgYSBsZW5ndGggKHJsZW4pCm9idGFpbmVkIGZyb20gdGhlIFJQQyByZXBseS4gVGhlIGV4aXN0
aW5nIGJvdW5kcyBjaGVjayB2YWxpZGF0ZXMgdGhhdApybGVuIGZpdHMgd2l0aGluIHRoZSBSUEMg
cGFja2V0LCBidXQgZG9lcyBub3QgY2hlY2sgdGhhdCB0aGUgcmVzdWx0CmZpdHMgaW4gdGhlIGRl
c3RpbmF0aW9uIGJ1ZmZlci4KCldoZW4gcHJvY2Vzc2luZyByZWxhdGl2ZSBzeW1saW5rcywgdGhl
IHRhcmdldCBpcyBhcHBlbmRlZCB0byB0aGUKZXhpc3RpbmcgcGF0aC4gQnkgY2hhaW5pbmcgdHdv
IHN5bWxpbmsgcmVzb2x1dGlvbnMsIGEgbWFsaWNpb3VzIE5GUwpzZXJ2ZXIgY2FuIGNhdXNlIHRo
ZSBjb21iaW5lZCBwYXRoIHRvIGV4Y2VlZCAyMDQ4IGJ5dGVzLCBvdmVyZmxvd2luZwpuZnNfcGF0
aF9idWZmIGFuZCBjb3JydXB0aW5nIGFkamFjZW50IGdsb2JhbCB2YXJpYWJsZXMgKG5mc19wYXRo
LApuZnNfZmlsZW5hbWUsIG5mc19kb3dubG9hZF9zdGF0ZSwgZmlsZSBoYW5kbGVzKS4gVGhpcyBj
YW4gYmUKZXhwbG9pdGVkIHRvIGFjaGlldmUgcmVtb3RlIGNvZGUgZXhlY3V0aW9uIGR1cmluZyBO
RlMgYm9vdC4KCkFkZCBib3VuZHMgY2hlY2tzIGFnYWluc3Qgc2l6ZW9mKG5mc19wYXRoX2J1ZmYp
IGJlZm9yZSBib3RoIHRoZQpyZWxhdGl2ZSAoYXBwZW5kKSBhbmQgYWJzb2x1dGUgKHJlcGxhY2Up
IG1lbWNweSBvcGVyYXRpb25zLgoKU2lnbmVkLW9mZi1ieTogTXVydGF6YSBNdW5haW0gPG1hbml6
emxlLm1zZkBnbWFpbC5jb20+Ci0tLQogbmV0L25mcy1jb21tb24uYyB8IDEyICsrKysrKysrKysr
LQogMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYg
LS1naXQgYS9uZXQvbmZzLWNvbW1vbi5jIGIvbmV0L25mcy1jb21tb24uYwppbmRleCA0ZmJkZTY3
YTc2MC4uMzBmNTQ5ZjllMWIgMTAwNjQ0Ci0tLSBhL25ldC9uZnMtY29tbW9uLmMKKysrIGIvbmV0
L25mcy1jb21tb24uYwpAQCAtNjcxLDE0ICs2NzEsMjQgQEAgc3RhdGljIGludCBuZnNfcmVhZGxp
bmtfcmVwbHkodWNoYXIgKnBrdCwgdW5zaWduZWQgaW50IGxlbikKIAogCWlmICgqKChjaGFyICop
JnJwY19wa3QudS5yZXBseS5kYXRhWzIgKyBuZnN2M19kYXRhX29mZnNldF0pICE9ICcvJykgewog
CQlpbnQgcGF0aGxlbjsKKwkJaW50IG5ld19sZW47CiAKIAkJc3RyY2F0KG5mc19wYXRoLCAiLyIp
OwogCQlwYXRobGVuID0gc3RybGVuKG5mc19wYXRoKTsKKwkJbmV3X2xlbiA9IHBhdGhsZW4gKyBy
bGVuOworCQlpZiAobmV3X2xlbiA+PSBzaXplb2YobmZzX3BhdGhfYnVmZikpIHsKKwkJCXByaW50
ZigiTkZTOiBzeW1saW5rIHRvbyBsb25nICglZCBieXRlcylcbiIsIG5ld19sZW4pOworCQkJcmV0
dXJuIC1ORlNfUlBDX0VSUjsKKwkJfQogCQltZW1jcHkobmZzX3BhdGggKyBwYXRobGVuLAogCQkg
ICAgICAgKHVjaGFyICopJnJwY19wa3QudS5yZXBseS5kYXRhWzIgKyBuZnN2M19kYXRhX29mZnNl
dF0sCiAJCSAgICAgICBybGVuKTsKLQkJbmZzX3BhdGhbcGF0aGxlbiArIHJsZW5dID0gMDsKKwkJ
bmZzX3BhdGhbbmV3X2xlbl0gPSAwOwogCX0gZWxzZSB7CisJCWlmIChybGVuID49IHNpemVvZihu
ZnNfcGF0aF9idWZmKSkgeworCQkJcHJpbnRmKCJORlM6IHN5bWxpbmsgdG9vIGxvbmcgKCVkIGJ5
dGVzKVxuIiwgcmxlbik7CisJCQlyZXR1cm4gLU5GU19SUENfRVJSOworCQl9CiAJCW1lbWNweShu
ZnNfcGF0aCwKIAkJICAgICAgICh1Y2hhciAqKSZycGNfcGt0LnUucmVwbHkuZGF0YVsyICsgbmZz
djNfZGF0YV9vZmZzZXRdLAogCQkgICAgICAgcmxlbik7Ci0tIAoyLjUwLjEgKEFwcGxlIEdpdC0x
NTUpCgo=
--000000000000b76c1c064e9a8cee--
