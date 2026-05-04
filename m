Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA1D2CD3427
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 15:52:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC84880F0E;
	Mon,  4 May 2026 17:52:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=vitorallo.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=vitorallo-com.20251104.gappssmtp.com header.i=@vitorallo-com.20251104.gappssmtp.com header.b="g6yT+9uH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 049ED83EF9; Mon,  4 May 2026 10:51:14 +0200 (CEST)
Received: from mail-yx1-xb12f.google.com (mail-yx1-xb12f.google.com
 [IPv6:2607:f8b0:4864:20::b12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A8C780F0E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 10:51:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=vitorallo.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@vitorallo.com
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-651b17f1bcdso301890d50.3
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 01:51:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777884670; cv=none;
 d=google.com; s=arc-20240605;
 b=kmzAG4ypftv8UC3AQ3V7P9MKYTaBpqn4pO74mmCGNBxSLGCh6Wfk8il250inPT9c1z
 B81t1KPbw7ie1WKf+/+QuEFOpHIhWlYavUoDJvYfBBp+u+3kcjU4tJDDIsm1zFKpkZzA
 wzKVIOsFtKUXKwazy4nxYQcKXiLFllr7t/hPzImFecm1tY8Ccp7Aza4mkqKAc9IDdo6V
 a9mQbTabMZMd0Ov02XY9kMOyD1D5DDUk33B6/DO0ZDIbV4/lXSRysD6C0GBZKWCZFXKJ
 XLZl8n7XNywTZhEQXem3u5j3pq+DPzaOUUnQGB+EVc7NGBcXps9Q5noNtF0Q54zqqGTQ
 VWDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=nuIHJILXdrsG/4XWNWT2rYkkEjSezOhBrqEtjS+rqyI=;
 fh=ea3Lb1kmqTyoSSOGd3r79PdCdfQHXBjS15GzGXd6hwE=;
 b=WVmgQmaVVmYDC8gbE3rjRYUBaPsnrppx5hAfAvtqMMFSyznzbHaMGvPUQezf6jm5Fr
 TqdxLPQ7/qpRbWlUwuFIaORY9FmHG/1XfY33IWxkkNLDHlbSWhUU4eL/sm00OPgFIM1/
 bSUmpAFe/jDD68sUHjqFfNoOO2Q4m5VgjR+VRNIemgvfB234omovtTNKGOCh4YOLLFVf
 lgH57EOt3y0goz7Z+Z4cwf3dPd/liX93KGXJUU4DKAWxPOsRbvtLgj1+6fg3fIJPWl/v
 Ki7RJqJeUabJR2LF/dlAn8YY9RKGWwEyMWNgk7WnwOsuz/j56HECfcqIbyi2yZ/NoguT
 Rr/g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vitorallo-com.20251104.gappssmtp.com; s=20251104; t=1777884670; x=1778489470;
 darn=lists.denx.de; 
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=nuIHJILXdrsG/4XWNWT2rYkkEjSezOhBrqEtjS+rqyI=;
 b=g6yT+9uH88UvjkSmYoaJw1GfYpN0w9Igcndfrqr3virF0AkSt2xVD+u8gBBLbw9ZHi
 goGKyJG3AMMv7qQe9YzH0/MDvDZRe1hHrHO3WiJWeu1HiCLmSChEPfBrZeBFWHdGiNjk
 ne+XT08/akbzi5IMuj0vnyK9jX7Kr6Wxgu5BiqfGawCEnvYP0bYp4fAFsNFPFBbIFovR
 kJUd9TlACKFpGZqHVE7aYJ0ZPV3n51iqqoP+JsojIfeDarllKmEQzPYrdlgbcGjQNtFH
 46K0R9c2bqPrwqgC6mZt/moNXQxkjucvpbTKRixKWk0c0PUdx5hEU9/n9WBAGzU0nTuQ
 aOWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777884670; x=1778489470;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nuIHJILXdrsG/4XWNWT2rYkkEjSezOhBrqEtjS+rqyI=;
 b=owAMQQNwDmPCxyZQ6QqA9AD3i6m7oiBteX3CaCX58+d0ep0uubUXbG/WwlAzOFKqv9
 stUTfr9qJXhsHvCSYS4r+N13KvNJvMtJZ0eg3z+ic0AF6g3Gr5eeZtCOT7dG7p7MEgc7
 y2T1pHGWrLeBbrsXKz/1bngxalo7ucGdoi0NFCc0G/ICgGDKHz4cvkQWvUM3secPyiKr
 1oFhQi6nIEbxeNmktIkERqeYyOpYE2TWDuQHwKS/0WoAn8FtA6lc0Pac8TGUqrEyBpZe
 oWo0LLWOCuG781n+160rfVJp04SMmevIwMhtT091vWBzkboEm5Drm0zJaDxagJCelguX
 /tPA==
X-Gm-Message-State: AOJu0YwAuMA0QzmH1VmaHJHss66MquHsKz8/e9dzo6XC/u3LoSdJDImj
 bXJzMdz2NhzjyVoSA4G4TsT7iAE5VTTgsSn36W/q8TwXpm9qkKogODco1LbfUQxflrGF6vqWvui
 jEEsDqMylvT52DuJ1IIwUxwrp5I8XL/SHCtV5GPROQq5NO3NTS47AmBI=
X-Gm-Gg: AeBDieu1BXs+HzFxcWBIG9+ssuBxduOVrN3eXWn0gsmP+hqbgSO62I0FqKRbJqHxMOv
 L42pRj5X5x2U9CwHh8Wjhmv8wMe6wPQ8h+CTcUbHZBjyhQOW6w12rPO9ubmq91t//VK0R2MldOW
 8DLTDlJPclSTGD8Rd8zBXno/ck7z6NEye9JJZeTfyJiccdKIxM85nGJtqgQC594Rov4l/NRPCK8
 VZZVQi/PtOBB+TNvn9OFBFebZYMy4PdQz0QgSmMQK62iigEx2FYRK8F8+FAAKDnAXH2mFvloDki
 T7mBryIf4Ww9AkWLfWd+uyLSmuRr3g==
X-Received: by 2002:a05:690e:16a1:b0:65c:308c:a170 with SMTP id
 956f58d0204a3-65c3dafbdb7mr5747735d50.3.1777884669542; Mon, 04 May 2026
 01:51:09 -0700 (PDT)
MIME-Version: 1.0
From: Vito Rallo <me@vitorallo.com>
Date: Mon, 4 May 2026 10:50:58 +0200
X-Gm-Features: AVHnY4KllWKuJdpfQnHtiupqSPqafbOQCB8Un_jOLbAvDfViRjageut4wy5rjX8
Message-ID: <CAE5JuzvQj+fbH1GQ4HxMKWzsPSeVLYzHAWVdJDdjcnxdRHv6jQ@mail.gmail.com>
Subject: security findings in U-Boot network stack, squashfs,
 and fastboot (follow-up)
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Mon, 04 May 2026 17:52:48 +0200
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

Dear security group,

Copying the mailing list, as I read from the "handling security"
instructions, at the link pointed by Tom. I reported a vulnerability,
validated with PoC included, NFS store_block
unbounded write which I preferred to send directly to Tom with all the
confidential info instead of public mailing list.

The vuln research and scan has been performed with an enhanced version of
Foil, an AI security code scanner that runs on local LLM.
http://foil.peachstudio.be. (C/C++ version of the model not publicly
available yet).

Foil uses a trained model to identify security vulns, the original version
uses a model tuned on traditional web/app related vulns. I have been
developing and re-train an additional new model optimised for C code (which
has different vulns than traditional modern languages like TS, JS, Python
and all the frameworks in that jazz).

During the same automated scan of
U-Boot v2026.07-rc1, four additional security issues were identified.
I'm reporting them together for coordinated disclosure.

## Finding 2: squashfs sqfs_read_entry heap over-read (HIGH)

fs/squashfs/sqfs.c, line 238. The sqfs_read_entry() function reads
name_size (u16) from a squashfs directory entry and uses it as a
memcpy length without bounds checking. A crafted squashfs image can
set name_size to 65535, causing a 64KB over-read from an 8KB
metadata buffer.

The vulnerability was introduced in commit c5100613037 (July 30,
2020) when squashfs support was added =E2=80=94 nearly 6 years ago. This is
the same bug class as the Trail of Bits fix in commit e365a269df5
(Feb 2026) for sqfs_frag_lookup(). Trail of Bits found and fixed
that instance via fuzzing but missed sqfs_read_entry() in the same
file, 60 lines away.

PoC confirmed: a crafted squashfs image with name_size=3D0xFFFF
causes a 61KB heap over-read when U-Boot lists the directory.
Tested in QEMU ARM with U-Boot v2026.07-rc1.

Full report will be sent to Tom: vuln-report-squashfs-read-entry.md

## Finding 3: TFTP store_block integer overflow (HIGH)

net/tftp.c, line 161. The block number from TFTP DATA packets is
multiplied by tftp_block_size to compute the write offset. On
32-bit platforms, this multiplication overflows at high block
numbers, wrapping the write address. The lmb_read_check() guard
only fires when CONFIG_IS_ENABLED(LMB), which many embedded
targets don't enable.

Full report will be sent to Tom: vuln-report-tftp-integer-overflow.md

## Finding 4: wget strcpy with network data (MEDIUM)

net/wget.c, line 158. HTTP response headers are copied using
strcpy() instead of strlcpy(). The size is validated before the
copy, but the use of a null-terminated copy function means edge
cases in TCP reassembly could cause the validation and the copy
to diverge.

Full report will be sent to Tom: vuln-report-wget-strcpy.md

## Finding 5: fastboot ucmd unauthenticated command execution (HIGH)

drivers/fastboot/fb_command.c, line 397. The fastboot "oem ucmd"
and "oem acmd" commands pass user-supplied strings directly to
run_command() without authentication, authorization, or input
validation. An attacker with USB access to a device in fastboot
mode can execute arbitrary U-Boot commands, modify the boot
environment, and install a persistent backdoor.

This is a dangerous default configuration rather than a code bug.
Android's fastboot gates OEM commands behind bootloader unlock
state. Looks to me that U-Boot's implementation has no equivalent gating.

Full report will be sent to Tom: vuln-report-fastboot-ucmd.md

## Summary table

| # | Component | Severity | CWE | Type |
|---|-----------|----------|-----|------|
| 1 | NFS store_block (previously reported) | Critical (9.6) | CWE-120 |
Unbounded write |
| 2 | squashfs sqfs_read_entry | High (7.8) | CWE-125 | Heap over-read |
| 3 | TFTP store_block | High (8.1) | CWE-190 | Integer overflow |
| 4 | wget strcpy | Medium (6.5) | CWE-120 | Unbounded copy |
| 5 | fastboot ucmd | High (7.6) | CWE-78 | Unauthenticated cmd exec |

I will file CVE request for 1 and 2. Let me know if you believe the other 3
are good candidates for a CVE too.

## Discovery method

All findings were discovered using foil, an AI-powered security
code scanner, with a fine-tuned 7B parameter model trained on
C/C++ vulnerability patterns. The scan of U-Boot's network stack
(375 functions) took 10 minutes and produced 28 raw findings,
of which 9 were confirmed after manual triage.

I am making the tool freely available, but I am not sharing for now the
C/C++ model and the optimised agent. I don't want it gets weaponised or
used improperly. If you would like to get a copy, let me know, I am ready
to handle one.

## Disclosure timeline

- 2026-04-29: All findings discovered, NFS finding reported
- 2026-04-30: Squashfs PoC confirmed, batch report sent (findings 2-5)
- 2026-07-28: Planned public disclosure (90 days from first report)

I am happy to coordinate on timing for the CVEs.

Best regards,

Vito Rallo
Peach Studio
me@vitorallo.com
https://peachstudio.be
