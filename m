Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F1DCD4F54
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 17:16:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9378884837;
	Wed, 27 May 2026 19:16:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="KNMla5YE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B50D84837; Wed, 27 May 2026 19:16:18 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 991F684704
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 19:16:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josh2@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 56E32270D0;
 Wed, 27 May 2026 19:16:15 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yFN-EbtdLCSr; Wed, 27 May 2026 19:16:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1779902174; bh=s3e6RXwxwmCZ7StDtNCBeM8pWRdw19i/l7RxqyrxIQM=;
 h=Date:From:To:CC:Subject:In-Reply-To:References;
 b=KNMla5YEdwFtrbKp9gaz17h3S46rrsuj2W+1aKa22dyRM8wDym4dpGVYjlCyPxFN9
 WryZB+d6/slierd2p5H9rCESMkg32WosFmY2twDiEpHu/rz/y+hVw1pS6jMP1T/6lL
 u0yRa0Lmo8rrSqc55kLo42rNCJFWJrU86IBQWuCXnWhNGvASIv+Y8Lsc0E7eeiP6mH
 PjtJX7d3x+gsr+KO0joNFvCTwvwCAKZ9N9LPGnshEbVCLVBepqdJbYo6vcgRDH6kBx
 4Hb6suEK69NvVlL2DLbkgHfE4a06gu6S3wpujqyEJ2LPJ0s3mvVAgTuTKjVROFcGuY
 SqrJFzyfFhLFw==
Date: Wed, 27 May 2026 18:16:12 +0100
From: Josh Law <josh2@disroot.org>
To: u-boot@lists.denx.de, "Lee, Brian J" <hibrian827@gatech.edu>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "Kim, Youngjoon" <ykim3186@gatech.edu>
Subject: Re: U-Boot TFTP OACK option parser reads past unterminated values
In-Reply-To: <DM6PR07MB43775463F18267C7C1AE8981F6082@DM6PR07MB4377.namprd07.prod.outlook.com>
References: <DM6PR07MB43775463F18267C7C1AE8981F6082@DM6PR07MB4377.namprd07.prod.outlook.com>
Message-ID: <8C6CF5D6-B9A5-4837-8D4C-86E151C7A617@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
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

On May 27, 2026 5:17:43 PM GMT+01:00, "Lee, Brian J"
<hibrian827@gatech.edu> wrote:
>Hello U-Boot Security Team,
>
>My name is Brian Lee, and I am a PhD Security Researcher in SSLab at
>Georgia Tech. I'd like to privately report a potential denial-of-service
>issue due to insufficient scan termination in OACK option parser in TFTP.
>A remote unauthenticated TFTP server selected by the U-Boot client, or an
>attacker able to spoof the expected server's first OACK to the client's
>TFTP source port, can send a single malformed OACK during an ordinary TFTP
>get, boot, or update flow.
>
>Target:
>
>  *
>Project: u-boot
>  *
>Repo: https://github.com/u-boot/u-boot
>  *
>Pinned ref: 215496fec59b3fa09256b4fb62f92af46e2ec7f9
>
>Threat model:
>
>U-Boot documents TFTP boot/download commands and optional automatic TFTP
>update; a selected or spoofed TFTP server can send the first OACK without
>authentication. The required packet is a single malformed OACK during an
>ordinary TFTP RRQ flow, with no credentials or multi-step race beyond
>being the selected/spoofed server response.
>
>Attached:
>
>  *
>README.md : full writeup.
>  *
>poc/run.sh :  allocates an exact-length TFTP packet containing opcode
>0x0006 (OACK), option name blksize, a NUL after the option name, and one
>value byte (5) without the required value-terminating NUL. It then calls
>the modeled tftp_handler() as the first server response to a client RRQ,
>with destination port 1069 and source port 69, matching the guard state
>that accepts an initial OACK before the remote port is pinned.
>  *
>poc/inputs: the relevant files for running poc
>
>I would like to get help from your expertise to clarify whether this is a
>valid security threat or not. Thank you.
>
>Best Regards,
>Brian Lee
>
>

Hey Brian,

These bugs look plausible to me.

If maintainers want fixes tags, 

For OACK: 
Fixes: 53a5c424bf86 ("multicast tftp: RFC2090")


For short ack:
Fixes: 1fb7cd498e6a ("net: tftpput: implement tftp logic")

I don't think the error case needs a fixes tag, it came up on the very
first commit.


I tried testing on my arm box using your script:

AddressSanitizer: CHECK failed: sanitizer_allocator_primary64.h:131
  "((kSpaceBeg)) == ((address_range.Init(TotalSpaceSize,
  PrimaryAllocatorName, kSpaceBeg)))"
  (0x500000000000, 0xfffffffffffffff4) (tid=3186)
      <empty stack>



it seems to be a "my host" issue

 

Note: I reproed under valgrind:


josh@armbox:~$ valgrind --quiet --error-exitcode=99 /tmp/brian-u-boot-pocs/
  oack_vg; echo "exit=$?"
  ==3366== Invalid read of size 1
  ==3366==    at 0x108A08: dectoul (harness.c:33)
  ==3366==    by 0x108B93: tftp_handler (harness.c:119)
  ==3366==    by 0x108E8F: main (harness.c:182)
  ==3366==  Address 0x4a8f04b is 0 bytes after a block of size 11 alloc'd
  ==3366==    at 0x488545C: malloc (vg_replace_malloc.c:446)
  ==3366==    by 0x108E4B: main (harness.c:176)

  ==3366== Invalid read of size 1
  ==3366==    at 0x488E7A4: __GI_strlen (vg_replace_strmem.c:506)
  ==3366==    by 0x491CC87: printf (printf.c:33)
  ==3366==    by 0x108BCF: tftp_handler (harness.c:120)

  Blocksize oack: 5, 5
  exit=99

  josh@armbox:~$ valgrind --quiet --error-exitcode=99 /tmp/brian-u-boot-pocs/
  ack_vg; echo "exit=$?"
  ==3367== Invalid read of size 2
  ==3367==    at 0x108A1C: tftp_handler (uboot_tftp_ack_harness.c:67)
  ==3367==    by 0x108BEB: main (uboot_tftp_ack_harness.c:111)
  ==3367==  Address 0x4a8f042 is 0 bytes after a block of size 2 alloc'd
  ==3367==    at 0x488545C: malloc (vg_replace_malloc.c:446)
  ==3367==    by 0x108BA3: main (uboot_tftp_ack_harness.c:104)

  exit=99

  josh@armbox:~$ valgrind --quiet --error-exitcode=99 /tmp/brian-u-boot-pocs/
  error_vg; echo "exit=$?"
  ==3368== Invalid read of size 2
  ==3368==    at 0x108A78: tftp_handler (uboot_tftp_error_harness.c:58)

  ==3368== Invalid read of size 1
  ==3368==    at 0x488E788: __GI_strlen (vg_replace_strmem.c:506)
  ==3368==    by 0x491CC87: printf (printf.c:33)
  ==3368==    by 0x108A97: tftp_handler (uboot_tftp_error_harness.c:57)

  ==3368== Invalid read of size 2
  ==3368==    at 0x108A9C: tftp_handler (uboot_tftp_error_harness.c:60)

  TFTP error: '' (0)
  Starting again

  exit=99

Thanks!
