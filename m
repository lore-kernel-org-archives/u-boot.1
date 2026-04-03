Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43FC8E85389
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 19:50:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFF5A8414B;
	Fri,  3 Apr 2026 21:50:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="E+6gXqNq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9CBD84118; Fri,  3 Apr 2026 21:50:08 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BCE4840ED
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 21:50:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7d9c98e437cso2054023a34.0
 for <u-boot@lists.denx.de>; Fri, 03 Apr 2026 12:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775245798; x=1775850598; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yWeAVi99PgGj3/ZRJWqZG/uAhqgC1Mxv5H1ATIjN7Ts=;
 b=E+6gXqNqzPuuaLzTFzIqugRwg+cpD8TsXdy/wB6ZvwKsKmfKgpRZFzX0QFtL7E1UUS
 N0L0GGiNiqE9NvFyry8ecRTOqhddOnv3KRlUNtaR8C0DlTVvvZkmms79lruBIG/d3xqn
 1NN9bjsRDpc8kRnkDmk5y6t9IDuTq3yoTKjk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775245798; x=1775850598;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yWeAVi99PgGj3/ZRJWqZG/uAhqgC1Mxv5H1ATIjN7Ts=;
 b=nn9xZfW103Unyt6+xpFyM0eVgolpt2Ln1LglwJqHt7qgcbfJNLITOQYrvdELfUAaAh
 M3VsckfPkDk/Rl1iHoUY2w5y1gWqplQ0x0jPCFWvM7byIKJBkGp80SYP9dSxxWCtaydO
 bW2ybg/sa0Hkn6sDDHPIXkT1WbOe7Rzpm+vWKZD4fEFhtoSFSEvOyqLVEDudIZGkVDOa
 GK9rP9N1jia149KUFh6PHDcjIlkcX78cLET27JAegi4sYhGfHzAeiqseBBR8as21zg8z
 PkprIkci07wQtpSYamu0mRiNcEqbaztsnd7VWKaNwgirmWlvXXm8ofa5ihozk3MB2XyI
 PyrQ==
X-Gm-Message-State: AOJu0Yy8Jz7LNJvvo1LYxsiGWOmCUYD6a7P1CBCcfYOMAElPAzB7+FAT
 a5t7h2NybDWgr2wcGcY3Rg19PgvHKHZyhRknlvbxicLn8ZbxYECiI6dBoQNJYtmMVqY=
X-Gm-Gg: ATEYQzxS2f6f3EfqLOYE6PX/pnmY86nBaJZH13ScL80ZhUbdDVyQ3h/azbWI3mn7jVn
 XxapvmqxBIBtPNB5/SqCwxHXgmiXgaqRfMgdv+qpjnG5Ts580eOWVBKCbTt+ntCjHROhZXoQNe+
 EWZSrplC8AtvkFWrJZtzi64OQoZNe2xDFp2CMSYjbVQf4VGqTKzWu9vs5ykTCnoEFSJVcd6ryZw
 MPeL+AlZ+as+xlJuBOaSBS1n12q5FO46zIpszZWYlhAtqwKFsTUN32qxbMFzntTImuQW5RG3phV
 Y6XnddjZFz5QbJvrE9NxhHegen5FDxuwSyTvMM3oU/UnixDjfRY1sJitrUVzKQPs88ypGGn55Zf
 WinrRuWzjCWI3b5GKnPy9LsdT6QUs36wbLirXoSWO0hpMc0hv3vpwdY50SBPZpH6HFiivLuEKtH
 EMthor2ROgaIYdYmA2O1hH3ZeRUyq4E5InIOJX3BrHWuDh/Zg3YcdUhs7IzIfv7PzQGZzUmvQXs
 Ea76zatgv4h+0zTi31BUq+L2Uc4aSaQBqH51Jp19HoycGMS
X-Received: by 2002:a05:6830:6285:b0:7d7:f15b:e399 with SMTP id
 46e09a7af769-7dbb712a397mr3155190a34.16.1775245798080; 
 Fri, 03 Apr 2026 12:49:58 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dba734a329sm5056529a34.20.2026.04.03.12.49.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 12:49:57 -0700 (PDT)
Date: Fri, 3 Apr 2026 13:49:55 -0600
From: Tom Rini <trini@konsulko.com>
To: manizzle alexandria <manizzle.msf@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [SECURITY] NFS symlink =?utf-8?Q?chain?=
 =?utf-8?Q?_buffer_overflow_?= =?utf-8?B?4oaS?= remote code execution
 (net/nfs-common.c)
Message-ID: <20260403194955.GK41863@bill-the-cat>
References: <CAJSCTzpeXqM7X1oOeejumd6HMCJxhxWxy9D8KOajYaevT=09Mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0iQ8LTMuWoDDm9ik"
Content-Disposition: inline
In-Reply-To: <CAJSCTzpeXqM7X1oOeejumd6HMCJxhxWxy9D8KOajYaevT=09Mg@mail.gmail.com>
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


--0iQ8LTMuWoDDm9ik
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 03, 2026 at 11:44:49AM -0700, manizzle alexandria wrote:

>   Hi Tom,
>=20
>   I'm reporting a remotely exploitable buffer overflow in U-Boot's NFS
>   client that I've confirmed leads to arbitrary code execution.
>=20
>   SUMMARY
>=20
>   A rogue NFS server can chain two READLINK (symlink) responses to
>   overflow the global nfs_path_buff[2048] in net/nfs-common.c by ~141
>   bytes. This corrupts the nfs_path pointer and adjacent globals,
>   allowing the attacker to hijack the NFS state machine and deliver
>   shellcode to a known memory address. I have a working end-to-end
>   exploit with code execution confirmed on QEMU ARM (Cortex-A15).
>=20
>   No authentication is required. The overflow triggers during normal
>   NFS boot before any OS is loaded.
>=20
>   AFFECTED
>=20
>   - All U-Boot versions with CONFIG_CMD_NFS=3Dy (NFS boot support)
>   - Tested on: 2026.04-rc5, commit c704af3c8b0
>   - File: net/nfs-common.c, function nfs_readlink_reply(), lines 667-686
>=20
>   ROOT CAUSE
>=20
>   nfs_readlink_reply() reads the symlink target length (rlen) from
>   the RPC reply and validates it against the packet size, but NOT
>   against the destination buffer (nfs_path_buff[2048]):
>=20
>     rlen =3D ntohl(rpc_pkt.u.reply.data[1 + nfsv3_data_offset]);
>=20
>     // Checks rlen fits in packet =E2=80=94 CORRECT
>     if (((uchar *)&rpc_pkt.u.reply.data[0] - (uchar *)&rpc_pkt + rlen) >
> len)
>         return -NFS_RPC_DROP;
>=20
>     // Copies rlen bytes into nfs_path =E2=80=94 NO CHECK against buffer =
size
>     memcpy(nfs_path + pathlen, ..., rlen);
>=20
>   A single response can't overflow because rlen maxes at ~1128 (packet
>   size limit). But two chained relative symlinks accumulate path length:
>=20
>     1st READLINK: 1100-byte relative target =E2=86=92 nfs_path grows to ~=
1060B
>     2nd READLINK: 1128-byte relative target =E2=86=92 writes to offset 21=
89
>                   =E2=86=92 overflows nfs_path_buff[2048] by ~141 bytes
>=20
>   EXPLOIT CHAIN
>=20
>     1. Portmap lookup  =E2=86=92 attacker returns fake mountd/nfsd ports
>     2. Mount           =E2=86=92 attacker returns fake file handle
>     3. Lookup          =E2=86=92 attacker returns file handle
>     4. Read            =E2=86=92 attacker returns NFSERR_ISDIR (triggers =
symlink)
>     5. Readlink #1     =E2=86=92 1100-byte relative symlink (grows path)
>     6. Readlink #2     =E2=86=92 OVERFLOW =E2=80=94 overwrites nfs_path p=
ointer to
>                          attacker-planted "/x" string, state machine
> survives
>     7. Mount/Lookup    =E2=86=92 re-enters NFS flow with controlled path
>     8. Read            =E2=86=92 attacker serves ARM shellcode as file co=
ntent
>                          =E2=86=92 written to image_load_addr (0x42000000)
>     9. Code execution  =E2=86=92 shellcode runs, writes "PWNED!" to UART
>=20
>   PROOF
>=20
>   GDB output after exploit:
>=20
>     =3D=3D=3D SHELLCODE AT 0x42000000 =3D=3D=3D
>        0x42000000:  mov   r0, #9
>        0x42000004:  lsl   r0, r0, #24      @ r0 =3D 0x09000000 (UART)
>        0x42000008:  mov   r1, #0x50        @ 'P'
>        0x4200000c:  str   r1, [r0]         @ write to UART
>        ...
>=20
>     =3D=3D=3D AFTER EXECUTION =3D=3D=3D
>        pc =3D 0x42000040   (completed, infinite loop)
>        r0 =3D 0x09000000   (UART base)
>        r1 =3D 0x0a         (newline)
>=20
>     =3D=3D=3D QEMU UART =3D=3D=3D
>        Loading: *T #PWNED!
>=20
>   SUGGESTED FIX
>=20
>   Add a bounds check before the memcpy in nfs_readlink_reply():
>=20
>     --- a/net/nfs-common.c
>     +++ b/net/nfs-common.c
>     @@ -670,6 +670,10 @@
>          if (((uchar *)&rpc_pkt.u.reply.data[0] - (uchar *)&rpc_pkt + rle=
n)
> > len)
>              return -NFS_RPC_DROP;
>=20
>     +    int current_len =3D strlen(nfs_path) + 1;
>     +    if (current_len + rlen >=3D sizeof(nfs_path_buff))
>     +        return -NFS_RPC_ERR;
>     +
>          if (*((char *)&rpc_pkt.u.reply.data[2 + nfsv3_data_offset]) !=3D
> '/') {
>=20
>   I have a full advisory document and working PoC (Python script, ~300
>   lines) attached. The PoC runs as a rogue NFS server and was tested
>   against QEMU ARM virt with qemu_arm_defconfig.
>=20
>   I'm requesting a CVE for this issue. I plan to follow standard 90-day
>   coordinated disclosure. Please let me know if you need anything else
>   or would like to discuss the fix.
>=20
>   Thanks,
>   Murtaza Munaim

> # Security Advisory: U-Boot NFS Symlink Chain Remote Code Execution
>=20
> ## Summary
>=20
> A buffer overflow vulnerability in U-Boot's NFS client allows a rogue NFS
> server to achieve remote code execution on the target device during netwo=
rk
> boot. No authentication is required. The attacker serves crafted NFS
> symlink responses that overflow the global `nfs_path_buff[2048]` buffer,
> corrupting adjacent pointers and hijacking the NFS state machine to deliv=
er
> and execute arbitrary shellcode.
>=20
> ## Affected Software
>=20
> - **Product:** Das U-Boot
> - **Component:** `net/nfs-common.c`, function `nfs_readlink_reply()`
> - **Affected versions:** All versions with NFS boot support (at least sin=
ce NFSv3 support was added; tested on 2026.04-rc5, commit `c704af3c8b0`)
> - **Configurations:** Any build with `CONFIG_CMD_NFS=3Dy` (NFS boot enabl=
ed)
>=20
> ## CVSS Score
>=20
> **8.1 (High)** =E2=80=94 CVSS:3.1/AV:N/AC:H/PR:N/UI:N/S:U/C:H/I:H/A:H
>=20
> - **Attack Vector:** Network (rogue NFS server)
> - **Attack Complexity:** High (target must be performing NFS boot)
> - **Privileges Required:** None
> - **User Interaction:** None (beyond initiating NFS boot, which is typica=
lly automatic)
> - **Impact:** Complete compromise of bootloader execution context
>=20
> ## Vulnerability Details
>=20
> ### Root Cause
>=20
> In `net/nfs-common.c`, the function `nfs_readlink_reply()` processes NFS
> READLINK responses (symlink target resolution). At line 667, it reads the
> symlink target length (`rlen`) from the RPC reply:
>=20
> ```c
> rlen =3D ntohl(rpc_pkt.u.reply.data[1 + nfsv3_data_offset]);
> ```
>=20
> The bounds check at line 669 validates that `rlen` fits within the **RPC
> packet buffer** (1152 bytes):
>=20
> ```c
> if (((uchar *)&rpc_pkt.u.reply.data[0] - (uchar *)&rpc_pkt + rlen) > len)
>     return -NFS_RPC_DROP;
> ```
>=20
> However, it does **not** validate that `rlen` fits within the **destinati=
on
> buffer** `nfs_path_buff[2048]`. When processing a relative symlink (line
> 672-680), the target is appended to the existing path:
>=20
> ```c
> strcat(nfs_path, "/");
> pathlen =3D strlen(nfs_path);
> memcpy(nfs_path + pathlen,
>        (uchar *)&rpc_pkt.u.reply.data[2 + nfsv3_data_offset],
>        rlen);
> nfs_path[pathlen + rlen] =3D 0;
> ```
>=20
> ### Exploitation via Symlink Chaining
>=20
> A single READLINK response cannot overflow the buffer because `rlen` is
> capped at ~1128 bytes (by the packet size check) and `nfs_path` starts
> short (~10 bytes). However, by chaining **two** symlink resolutions:
>=20
> 1. **First READLINK:** Server returns a ~1100-byte relative symlink target
>    with directory separators (`a/b/c/.../x`). After `nfs_dirname()`,
>    `nfs_path` retains ~1060 bytes.
>=20
> 2. **Second READLINK:** Server returns a ~1128-byte relative symlink
>    target. The `memcpy` writes to offset `1061 + 1128 =3D 2189`, exceeding
>    `nfs_path_buff[2048]` by approximately **141 bytes**.
>=20
> ### What Gets Overwritten
>=20
> The overflow corrupts global variables adjacent to `nfs_path_buff` in BSS
> (verified via `nm` on QEMU ARM build):
>=20
> | Offset from buffer end | Variable | Type | Impact |
> |------------------------|----------|------|--------|
> | +0 | `nfs_path` | `char *` | Pointer to current NFS path =E2=80=94 cont=
rols future memory writes |
> | +4 | `nfs_filename` | `char *` | Pointer to filename component |
> | +8 | `nfs_download_state` | `enum` | Controls boot success/failure |
> | +12 | `filefh3_length` | `uint` | NFS file handle length |
> | +16 | `filefh` | `char[64]` | NFS file handle =E2=80=94 controls which =
file is read |
>=20
> ### Code Execution Chain
>=20
> By overwriting `nfs_path` to point to a short valid path string (e.g.,
> `"/x"`) planted within the overflow payload itself, the attacker keeps the
> NFS state machine alive. The state machine then:
>=20
> 1. Re-mounts the filesystem (MOUNT `/`)
> 2. Looks up the file (LOOKUP `x`)
> 3. Reads file content (READ) =E2=80=94 the server serves **arbitrary shel=
lcode**
> 4. `store_block()` writes the shellcode to `image_load_addr` (e.g., `0x42=
000000`)
>=20
> The shellcode is now in memory at a known address. In typical embedded bo=
ot
> configurations, `bootm` or `go` is called on the load address after NFS
> download, executing the attacker's code.
>=20
> ## Proof of Concept
>=20
> A complete working exploit (`nfs_rce.py`) is provided. It was tested
> against U-Boot 2026.04-rc5 running on QEMU ARM (`qemu_arm_defconfig`,
> Cortex-A15, 256MB RAM).
>=20
> ### Tested Exploit Chain
>=20
> ```
> [1] PORTMAP      =E2=86=92 returned fake mountd/nfsd ports
> [2] MOUNT        =E2=86=92 returned fake file handle
> [3] LOOKUP       =E2=86=92 returned success with file handle
> [4] READ         =E2=86=92 returned NFSERR_ISDIR =E2=86=92 triggered syml=
ink
> [5] READLINK #1  =E2=86=92 1100-byte relative symlink (grew nfs_path to ~=
1060B)
> [6] READLINK #2  =E2=86=92 1128-byte overflow payload
>                     Overwrote nfs_path =E2=86=92 valid "/x" string
>                     State machine survived and continued
> [7] MOUNT/LOOKUP =E2=86=92 re-entered NFS flow with attacker-controlled p=
ath
> [8] READ         =E2=86=92 served 68-byte ARM shellcode =E2=86=92 written=
 to 0x42000000
> [9] EXECUTION    =E2=86=92 shellcode wrote "PWNED!" to PL011 UART
> ```
>=20
> ### GDB Verification
>=20
> ```
> =3D=3D=3D SHELLCODE AT 0x42000000 =3D=3D=3D
>    0x42000000:  mov   r0, #9
>    0x42000004:  lsl   r0, r0, #24      @ r0 =3D 0x09000000 (UART base)
>    0x42000008:  mov   r1, #0x50        @ 'P'
>    0x4200000c:  str   r1, [r0]         @ write to UART
>=20
> =3D=3D=3D AFTER EXECUTION =3D=3D=3D
>    pc =3D 0x42000040   (completed, hit infinite loop)
>    r0 =3D 0x09000000   (UART base)
>    r1 =3D 0x0a         (newline =E2=80=94 last char written)
>=20
> =3D=3D=3D QEMU UART OUTPUT =3D=3D=3D
>    Loading: *T #PWNED!
>    >>> CODE EXECUTION CONFIRMED <<<
> ```
>=20
> ### Reproduction Steps
>=20
> ```bash
> # 1. Build U-Boot for QEMU ARM with NFS enabled
> cd u-boot
> make CROSS_COMPILE=3Darm-none-eabi- qemu_arm_defconfig
> # Enable CONFIG_CMD_NFS=3Dy in .config
> make CROSS_COMPILE=3Darm-none-eabi- -j$(nproc)
>=20
> # 2. Start the exploit server
> python3 nfs_rce.py
>=20
> # 3. Start QEMU
> qemu-system-arm -machine virt -cpu cortex-a15 -m 256M -nographic \
>     -bios u-boot.bin \
>     -netdev user,id=3Dnet0,net=3D10.0.2.0/24,dhcpstart=3D10.0.2.15 \
>     -device virtio-net-device,netdev=3Dnet0
>=20
> # 4. In U-Boot console:
> setenv ipaddr 10.0.2.15
> setenv serverip 10.0.2.2
> nfs 0x42000000 10.0.2.2:/boot/uImage
>=20
> # 5. Observe "PWNED!" in UART output (or verify via GDB at 0x42000000)
> ```
>=20
> ## Suggested Fix
>=20
> Add a bounds check against `nfs_path_buff` size before the `memcpy` in
> `nfs_readlink_reply()`:
>=20
> ```c
> --- a/net/nfs-common.c
> +++ b/net/nfs-common.c
> @@ -670,6 +670,11 @@ static int nfs_readlink_reply(uchar *pkt, unsigned i=
nt len)
>  	if (((uchar *)&rpc_pkt.u.reply.data[0] - (uchar *)&rpc_pkt + rlen) > le=
n)
>  		return -NFS_RPC_DROP;
> =20
> +	/* Validate symlink target fits in nfs_path_buff */
> +	int current_len =3D strlen(nfs_path) + 1; /* +1 for '/' */
> +	if (current_len + rlen >=3D sizeof(nfs_path_buff))
> +		return -NFS_RPC_ERR;
> +
>  	if (*((char *)&rpc_pkt.u.reply.data[2 + nfsv3_data_offset]) !=3D '/') {
>  		int pathlen;
> ```
>=20
> Additionally, consider replacing `strcat`/`memcpy` with bounds-checked
> alternatives throughout the NFS path handling code.

Thanks for the report, please see
https://docs.u-boot.org/en/latest/develop/sending_patches.html for how
to properly submit a patch, thanks!

--=20
Tom

--0iQ8LTMuWoDDm9ik
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCadAZ4AAKCRAr4qD1Cr/k
Cpi0AQCuKNhnMURiQLu5DbHvboDYh8WQzNEpzx4TtWpqsWozqwEA6yhY29jrUkOO
/cnlMZyzYHiYbJh9OZAnVHebQQBcIAA=
=WRoN
-----END PGP SIGNATURE-----

--0iQ8LTMuWoDDm9ik--
