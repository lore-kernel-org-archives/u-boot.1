Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1053EE88D87
	for <u-boot@archiver.kernel.org>; Sat,  4 Apr 2026 06:31:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67E7483B48;
	Sat,  4 Apr 2026 08:31:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PxBghcOy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A56D5840BE; Fri,  3 Apr 2026 22:44:55 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1FC083F9D
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 22:44:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=manizzle.msf@gmail.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-38c620f1699so24393121fa.0
 for <u-boot@lists.denx.de>; Fri, 03 Apr 2026 13:44:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775249092; cv=none;
 d=google.com; s=arc-20240605;
 b=bbKJYzA8GElsToETFPYnT/tbuLvC++7HsEYWqUa6RkdyOeyShwOmBRrnjMKC6M1WEj
 xibUhjzxTY7kgMWmD0hJafljIcbxTM8AypNtPqZCLoCyh8AuXR5CiV2ju4+1aXtwFm7o
 Kp5E9WAvm12Ab+cnZcUu89yMyXxkfybAQnDCu/m8XWcbbtHSP6lLEFsxBc4ZgNR/KQW9
 y0DAj6mZtkVH42S7df2MUk1KV788WAPqmddQZjwGZ3nr2h0l8wjAkfYIv6AD7iBmeMYJ
 nSp/J+yt1hF7XWkt5hUj3buHhoYLNxiIKJYUWVoNaZOEzAGQMBu5VmmmuC+iEyFYnZ7R
 xXPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2EKp3+uSikhAJQtfUI+unecTVPUBKKtc2ZWga17l5Ug=;
 fh=3cGkqt4Xgv2w9dTeeIJFEJ5AO4AvGobPArcY4WlS1wc=;
 b=dn7fZyy/3jjh0Ybe3Koz5RVCZSfcLmnXE3lU68AbK0XIE4jmyuy6F0W+PCruWIFo4e
 ig4UdRlAqWRENmjcFTQYAMG+UrQnD4WfB/P043uDsHaRd/GJ6NcFOCX3ZVtbSsn/gDV2
 Tu4JRtDKhq1xbmwpjqULX7BqPRff9dg+BEFcN06u0jyU3VJEZ2CAR1u6xvuhGkNGp28w
 oI1SV/r1EReHsj45oipeFxF4crxU1q1anFUkac88ittLrVaD3fVnf6bSI99At8v+yih8
 /NY2bRnRoMAMSF5+bAkgRmM8bP6DzapZ+dnQjXBKDCihJZp/1MZw+o8k6uoMcpqTBP4j
 ccpA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775249092; x=1775853892; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2EKp3+uSikhAJQtfUI+unecTVPUBKKtc2ZWga17l5Ug=;
 b=PxBghcOyslHzwXwai2llyP0seGkfiMdUMp5O2R2KAMnB4E6SL0+k5Z+fkECZ2tYlkw
 0ayFt6a9V8VGUnU06yF5Vox6rfNaQJ+PV3d8S6PGeaoDX5xSJ+8OnPJn3ApyZNiY9bRb
 1oNyInEXTwAKvM+Lx+z3MuFMPv3SvuWp3ZBdHZF9NphZnZ8npwYb1Ii3s6GaDaVCbrbU
 /9ItF3rDPC8Y7teoab1HCZOgylC4k+6/+i3HGPWXR9Ba1FbsQ1JFeYNiJ51vml0s4kiv
 owa+krfQ4Sm8JZtIIWQfSPDPYC2XBH4vvyqNVIjRX+wLaJ8lowX7oDFiFo6UMZPhyLLo
 fH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775249092; x=1775853892;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2EKp3+uSikhAJQtfUI+unecTVPUBKKtc2ZWga17l5Ug=;
 b=CnaRIt6Qmg0My4ktlabkEGr1kRt83xkFgl3k2qNNLKnPgevOfrBkvgylJr+QOeXJUo
 MVkczVx44hC7fod/+DpQPnnAPbu+m4nTWSiXlL4pqc+ZrL9ofT/dCCRTq+wIuywnno1u
 sexM5g6S/iasuHURoJXKxv5mmV3V+9PZYmC2rAiQ6VPCGJLcfxc5RyxA2o1fAyT1aQU3
 KQsNsuGwqMKkDjQdcMN0QVQQGEGxqSGcjSNRE2cH0SOptPeg93FBGYLcIFuIE5ZgRffb
 7MP6pokifstVPi+Mv/ltmdLM1O8IrHbbkBmVtq3ykiVfWVzSHfTnr70GVJn/DDH0z2bq
 psTw==
X-Gm-Message-State: AOJu0YzBmQGG5jJqOntdqEnvvep8md5/xbFlteSTCx71k1RMrR+vEQTR
 fRuK6zrItUx3YC0E/H2cU/W0DMOYAz0XaD7L5lBlJbJz5eF635ePdTPSK+lH7iHVUrfMjkNkFB8
 RDHBFjo/Anox2r9XCF6Gh/9OBP36l0WmoAA==
X-Gm-Gg: AeBDieuT7s5u9lUH6qQCaJ9Hzy0QnDiroCv+h9POT2sa7y6XsFhdkzDYxFEQgJfH8RR
 W/rV3qhJMh6VC24FRIoDYMS+jzRwFRCucEyK5FfMBK4ZAJbwj+aOoX/UO77Edy6KB+VwjT2vtte
 d7c+dwtOp/UygVFzvU07RrzLs+tklCk58oIYGNhD1F768FEuHBGWsuqtaPa7kdbuQHWi9QpL3HP
 PEDNzVsahfang5C64m7xSBXd5dosATdOvQjM8ah38sEQLm+qetK9FK4BxUBwsTm+RrlJl3tnSK0
 bkaAAka2VlIT+/dqFgDDkp0jowwx9iVw+tkBkYzBEEjgCW9cf2gL
X-Received: by 2002:a05:651c:1447:b0:38a:8602:71aa with SMTP id
 38308e7fff4ca-38d91d6d4b5mr14774921fa.16.1775249091337; Fri, 03 Apr 2026
 13:44:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSCTzpeXqM7X1oOeejumd6HMCJxhxWxy9D8KOajYaevT=09Mg@mail.gmail.com>
 <20260403194955.GK41863@bill-the-cat>
In-Reply-To: <20260403194955.GK41863@bill-the-cat>
From: manizzle alexandria <manizzle.msf@gmail.com>
Date: Fri, 3 Apr 2026 13:44:41 -0700
X-Gm-Features: AQROBzAgA8NL5G9KWs45caiPhZo7oZHqKQR_P_SvlsJtuCcovsAIqLSYTHT8vbg
Message-ID: <CAJSCTzqxkLEhXdNWeK8vP2Uaw+a0szOXukJwv_yFE8AZ3WK9LA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BSECURITY=5D_NFS_symlink_chain_buffer_overflow_=E2=86=92?=
 =?UTF-8?Q?_remote_code_execution_=28net=2Fnfs=2Dcommon=2Ec=29?=
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
X-Mailman-Approved-At: Sat, 04 Apr 2026 08:31:19 +0200
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

Will clean up the PoC and send a proper patch following the link.

Thanks for the quick review.

On Fri, Apr 3, 2026, 12:49=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:

> On Fri, Apr 03, 2026 at 11:44:49AM -0700, manizzle alexandria wrote:
>
> >   Hi Tom,
> >
> >   I'm reporting a remotely exploitable buffer overflow in U-Boot's NFS
> >   client that I've confirmed leads to arbitrary code execution.
> >
> >   SUMMARY
> >
> >   A rogue NFS server can chain two READLINK (symlink) responses to
> >   overflow the global nfs_path_buff[2048] in net/nfs-common.c by ~141
> >   bytes. This corrupts the nfs_path pointer and adjacent globals,
> >   allowing the attacker to hijack the NFS state machine and deliver
> >   shellcode to a known memory address. I have a working end-to-end
> >   exploit with code execution confirmed on QEMU ARM (Cortex-A15).
> >
> >   No authentication is required. The overflow triggers during normal
> >   NFS boot before any OS is loaded.
> >
> >   AFFECTED
> >
> >   - All U-Boot versions with CONFIG_CMD_NFS=3Dy (NFS boot support)
> >   - Tested on: 2026.04-rc5, commit c704af3c8b0
> >   - File: net/nfs-common.c, function nfs_readlink_reply(), lines 667-68=
6
> >
> >   ROOT CAUSE
> >
> >   nfs_readlink_reply() reads the symlink target length (rlen) from
> >   the RPC reply and validates it against the packet size, but NOT
> >   against the destination buffer (nfs_path_buff[2048]):
> >
> >     rlen =3D ntohl(rpc_pkt.u.reply.data[1 + nfsv3_data_offset]);
> >
> >     // Checks rlen fits in packet =E2=80=94 CORRECT
> >     if (((uchar *)&rpc_pkt.u.reply.data[0] - (uchar *)&rpc_pkt + rlen) =
>
> > len)
> >         return -NFS_RPC_DROP;
> >
> >     // Copies rlen bytes into nfs_path =E2=80=94 NO CHECK against buffe=
r size
> >     memcpy(nfs_path + pathlen, ..., rlen);
> >
> >   A single response can't overflow because rlen maxes at ~1128 (packet
> >   size limit). But two chained relative symlinks accumulate path length=
:
> >
> >     1st READLINK: 1100-byte relative target =E2=86=92 nfs_path grows to=
 ~1060B
> >     2nd READLINK: 1128-byte relative target =E2=86=92 writes to offset =
2189
> >                   =E2=86=92 overflows nfs_path_buff[2048] by ~141 bytes
> >
> >   EXPLOIT CHAIN
> >
> >     1. Portmap lookup  =E2=86=92 attacker returns fake mountd/nfsd port=
s
> >     2. Mount           =E2=86=92 attacker returns fake file handle
> >     3. Lookup          =E2=86=92 attacker returns file handle
> >     4. Read            =E2=86=92 attacker returns NFSERR_ISDIR (trigger=
s symlink)
> >     5. Readlink #1     =E2=86=92 1100-byte relative symlink (grows path=
)
> >     6. Readlink #2     =E2=86=92 OVERFLOW =E2=80=94 overwrites nfs_path=
 pointer to
> >                          attacker-planted "/x" string, state machine
> > survives
> >     7. Mount/Lookup    =E2=86=92 re-enters NFS flow with controlled pat=
h
> >     8. Read            =E2=86=92 attacker serves ARM shellcode as file =
content
> >                          =E2=86=92 written to image_load_addr (0x420000=
00)
> >     9. Code execution  =E2=86=92 shellcode runs, writes "PWNED!" to UAR=
T
> >
> >   PROOF
> >
> >   GDB output after exploit:
> >
> >     =3D=3D=3D SHELLCODE AT 0x42000000 =3D=3D=3D
> >        0x42000000:  mov   r0, #9
> >        0x42000004:  lsl   r0, r0, #24      @ r0 =3D 0x09000000 (UART)
> >        0x42000008:  mov   r1, #0x50        @ 'P'
> >        0x4200000c:  str   r1, [r0]         @ write to UART
> >        ...
> >
> >     =3D=3D=3D AFTER EXECUTION =3D=3D=3D
> >        pc =3D 0x42000040   (completed, infinite loop)
> >        r0 =3D 0x09000000   (UART base)
> >        r1 =3D 0x0a         (newline)
> >
> >     =3D=3D=3D QEMU UART =3D=3D=3D
> >        Loading: *T #PWNED!
> >
> >   SUGGESTED FIX
> >
> >   Add a bounds check before the memcpy in nfs_readlink_reply():
> >
> >     --- a/net/nfs-common.c
> >     +++ b/net/nfs-common.c
> >     @@ -670,6 +670,10 @@
> >          if (((uchar *)&rpc_pkt.u.reply.data[0] - (uchar *)&rpc_pkt +
> rlen)
> > > len)
> >              return -NFS_RPC_DROP;
> >
> >     +    int current_len =3D strlen(nfs_path) + 1;
> >     +    if (current_len + rlen >=3D sizeof(nfs_path_buff))
> >     +        return -NFS_RPC_ERR;
> >     +
> >          if (*((char *)&rpc_pkt.u.reply.data[2 + nfsv3_data_offset]) !=
=3D
> > '/') {
> >
> >   I have a full advisory document and working PoC (Python script, ~300
> >   lines) attached. The PoC runs as a rogue NFS server and was tested
> >   against QEMU ARM virt with qemu_arm_defconfig.
> >
> >   I'm requesting a CVE for this issue. I plan to follow standard 90-day
> >   coordinated disclosure. Please let me know if you need anything else
> >   or would like to discuss the fix.
> >
> >   Thanks,
> >   Murtaza Munaim
>
> > # Security Advisory: U-Boot NFS Symlink Chain Remote Code Execution
> >
> > ## Summary
> >
> > A buffer overflow vulnerability in U-Boot's NFS client allows a rogue N=
FS
> > server to achieve remote code execution on the target device during
> network
> > boot. No authentication is required. The attacker serves crafted NFS
> > symlink responses that overflow the global `nfs_path_buff[2048]` buffer=
,
> > corrupting adjacent pointers and hijacking the NFS state machine to
> deliver
> > and execute arbitrary shellcode.
> >
> > ## Affected Software
> >
> > - **Product:** Das U-Boot
> > - **Component:** `net/nfs-common.c`, function `nfs_readlink_reply()`
> > - **Affected versions:** All versions with NFS boot support (at least
> since NFSv3 support was added; tested on 2026.04-rc5, commit `c704af3c8b0=
`)
> > - **Configurations:** Any build with `CONFIG_CMD_NFS=3Dy` (NFS boot
> enabled)
> >
> > ## CVSS Score
> >
> > **8.1 (High)** =E2=80=94 CVSS:3.1/AV:N/AC:H/PR:N/UI:N/S:U/C:H/I:H/A:H
> >
> > - **Attack Vector:** Network (rogue NFS server)
> > - **Attack Complexity:** High (target must be performing NFS boot)
> > - **Privileges Required:** None
> > - **User Interaction:** None (beyond initiating NFS boot, which is
> typically automatic)
> > - **Impact:** Complete compromise of bootloader execution context
> >
> > ## Vulnerability Details
> >
> > ### Root Cause
> >
> > In `net/nfs-common.c`, the function `nfs_readlink_reply()` processes NF=
S
> > READLINK responses (symlink target resolution). At line 667, it reads t=
he
> > symlink target length (`rlen`) from the RPC reply:
> >
> > ```c
> > rlen =3D ntohl(rpc_pkt.u.reply.data[1 + nfsv3_data_offset]);
> > ```
> >
> > The bounds check at line 669 validates that `rlen` fits within the **RP=
C
> > packet buffer** (1152 bytes):
> >
> > ```c
> > if (((uchar *)&rpc_pkt.u.reply.data[0] - (uchar *)&rpc_pkt + rlen) > le=
n)
> >     return -NFS_RPC_DROP;
> > ```
> >
> > However, it does **not** validate that `rlen` fits within the
> **destination
> > buffer** `nfs_path_buff[2048]`. When processing a relative symlink (lin=
e
> > 672-680), the target is appended to the existing path:
> >
> > ```c
> > strcat(nfs_path, "/");
> > pathlen =3D strlen(nfs_path);
> > memcpy(nfs_path + pathlen,
> >        (uchar *)&rpc_pkt.u.reply.data[2 + nfsv3_data_offset],
> >        rlen);
> > nfs_path[pathlen + rlen] =3D 0;
> > ```
> >
> > ### Exploitation via Symlink Chaining
> >
> > A single READLINK response cannot overflow the buffer because `rlen` is
> > capped at ~1128 bytes (by the packet size check) and `nfs_path` starts
> > short (~10 bytes). However, by chaining **two** symlink resolutions:
> >
> > 1. **First READLINK:** Server returns a ~1100-byte relative symlink
> target
> >    with directory separators (`a/b/c/.../x`). After `nfs_dirname()`,
> >    `nfs_path` retains ~1060 bytes.
> >
> > 2. **Second READLINK:** Server returns a ~1128-byte relative symlink
> >    target. The `memcpy` writes to offset `1061 + 1128 =3D 2189`, exceed=
ing
> >    `nfs_path_buff[2048]` by approximately **141 bytes**.
> >
> > ### What Gets Overwritten
> >
> > The overflow corrupts global variables adjacent to `nfs_path_buff` in B=
SS
> > (verified via `nm` on QEMU ARM build):
> >
> > | Offset from buffer end | Variable | Type | Impact |
> > |------------------------|----------|------|--------|
> > | +0 | `nfs_path` | `char *` | Pointer to current NFS path =E2=80=94 co=
ntrols
> future memory writes |
> > | +4 | `nfs_filename` | `char *` | Pointer to filename component |
> > | +8 | `nfs_download_state` | `enum` | Controls boot success/failure |
> > | +12 | `filefh3_length` | `uint` | NFS file handle length |
> > | +16 | `filefh` | `char[64]` | NFS file handle =E2=80=94 controls whic=
h file is
> read |
> >
> > ### Code Execution Chain
> >
> > By overwriting `nfs_path` to point to a short valid path string (e.g.,
> > `"/x"`) planted within the overflow payload itself, the attacker keeps
> the
> > NFS state machine alive. The state machine then:
> >
> > 1. Re-mounts the filesystem (MOUNT `/`)
> > 2. Looks up the file (LOOKUP `x`)
> > 3. Reads file content (READ) =E2=80=94 the server serves **arbitrary sh=
ellcode**
> > 4. `store_block()` writes the shellcode to `image_load_addr` (e.g.,
> `0x42000000`)
> >
> > The shellcode is now in memory at a known address. In typical embedded
> boot
> > configurations, `bootm` or `go` is called on the load address after NFS
> > download, executing the attacker's code.
> >
> > ## Proof of Concept
> >
> > A complete working exploit (`nfs_rce.py`) is provided. It was tested
> > against U-Boot 2026.04-rc5 running on QEMU ARM (`qemu_arm_defconfig`,
> > Cortex-A15, 256MB RAM).
> >
> > ### Tested Exploit Chain
> >
> > ```
> > [1] PORTMAP      =E2=86=92 returned fake mountd/nfsd ports
> > [2] MOUNT        =E2=86=92 returned fake file handle
> > [3] LOOKUP       =E2=86=92 returned success with file handle
> > [4] READ         =E2=86=92 returned NFSERR_ISDIR =E2=86=92 triggered sy=
mlink
> > [5] READLINK #1  =E2=86=92 1100-byte relative symlink (grew nfs_path to=
 ~1060B)
> > [6] READLINK #2  =E2=86=92 1128-byte overflow payload
> >                     Overwrote nfs_path =E2=86=92 valid "/x" string
> >                     State machine survived and continued
> > [7] MOUNT/LOOKUP =E2=86=92 re-entered NFS flow with attacker-controlled=
 path
> > [8] READ         =E2=86=92 served 68-byte ARM shellcode =E2=86=92 writt=
en to 0x42000000
> > [9] EXECUTION    =E2=86=92 shellcode wrote "PWNED!" to PL011 UART
> > ```
> >
> > ### GDB Verification
> >
> > ```
> > =3D=3D=3D SHELLCODE AT 0x42000000 =3D=3D=3D
> >    0x42000000:  mov   r0, #9
> >    0x42000004:  lsl   r0, r0, #24      @ r0 =3D 0x09000000 (UART base)
> >    0x42000008:  mov   r1, #0x50        @ 'P'
> >    0x4200000c:  str   r1, [r0]         @ write to UART
> >
> > =3D=3D=3D AFTER EXECUTION =3D=3D=3D
> >    pc =3D 0x42000040   (completed, hit infinite loop)
> >    r0 =3D 0x09000000   (UART base)
> >    r1 =3D 0x0a         (newline =E2=80=94 last char written)
> >
> > =3D=3D=3D QEMU UART OUTPUT =3D=3D=3D
> >    Loading: *T #PWNED!
> >    >>> CODE EXECUTION CONFIRMED <<<
> > ```
> >
> > ### Reproduction Steps
> >
> > ```bash
> > # 1. Build U-Boot for QEMU ARM with NFS enabled
> > cd u-boot
> > make CROSS_COMPILE=3Darm-none-eabi- qemu_arm_defconfig
> > # Enable CONFIG_CMD_NFS=3Dy in .config
> > make CROSS_COMPILE=3Darm-none-eabi- -j$(nproc)
> >
> > # 2. Start the exploit server
> > python3 nfs_rce.py
> >
> > # 3. Start QEMU
> > qemu-system-arm -machine virt -cpu cortex-a15 -m 256M -nographic \
> >     -bios u-boot.bin \
> >     -netdev user,id=3Dnet0,net=3D10.0.2.0/24,dhcpstart=3D10.0.2.15 \
> >     -device virtio-net-device,netdev=3Dnet0
> >
> > # 4. In U-Boot console:
> > setenv ipaddr 10.0.2.15
> > setenv serverip 10.0.2.2
> > nfs 0x42000000 10.0.2.2:/boot/uImage
> >
> > # 5. Observe "PWNED!" in UART output (or verify via GDB at 0x42000000)
> > ```
> >
> > ## Suggested Fix
> >
> > Add a bounds check against `nfs_path_buff` size before the `memcpy` in
> > `nfs_readlink_reply()`:
> >
> > ```c
> > --- a/net/nfs-common.c
> > +++ b/net/nfs-common.c
> > @@ -670,6 +670,11 @@ static int nfs_readlink_reply(uchar *pkt, unsigned
> int len)
> >       if (((uchar *)&rpc_pkt.u.reply.data[0] - (uchar *)&rpc_pkt + rlen=
)
> > len)
> >               return -NFS_RPC_DROP;
> >
> > +     /* Validate symlink target fits in nfs_path_buff */
> > +     int current_len =3D strlen(nfs_path) + 1; /* +1 for '/' */
> > +     if (current_len + rlen >=3D sizeof(nfs_path_buff))
> > +             return -NFS_RPC_ERR;
> > +
> >       if (*((char *)&rpc_pkt.u.reply.data[2 + nfsv3_data_offset]) !=3D
> '/') {
> >               int pathlen;
> > ```
> >
> > Additionally, consider replacing `strcat`/`memcpy` with bounds-checked
> > alternatives throughout the NFS path handling code.
>
> Thanks for the report, please see
> https://docs.u-boot.org/en/latest/develop/sending_patches.html for how
> to properly submit a patch, thanks!
>
> --
> Tom
>
