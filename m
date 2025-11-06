Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A91F1CCFA03
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 13:10:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5892283BCE;
	Thu,  6 Nov 2025 14:09:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=nathaniel.land
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nathaniel.land header.i=@nathaniel.land header.b="ZIN/FgGk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AB0C83B27; Thu,  6 Nov 2025 05:27:02 +0100 (CET)
Received: from goldencat.email (goldencat.email [45.45.221.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70F6E83A15
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 05:26:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nathaniel.land
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=i@nathaniel.land
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nathaniel.land;
 s=dkim; t=1762403217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Yz1ukubUjRMsx8HVq5HWLVlIDyML/NPE8oGsLSsLw0E=;
 b=ZIN/FgGk2uxaUqqWROFkvmSfL+kWNSgAdaWvP1xaGYAjfPhu/QodH1pOA7TwhXCxJm77/c
 2B8GT9QB2qfdthkM5Of7KELjGmoQjVik2r8rVFBbk7RwYFOejqw4G/fLT5NQISSwhSwjBv
 nfgwpz+rLF7rSCvbwl7j9/bPaqbEtEpsd8+D3TN2Q6hZqN86xjSGvKCLM2jjjPb+1238Ld
 +QTIHGRN0SwKUHUZaJmfbd5w8FIH6maeebLzz2HeX5KduzCaQ7OKQhXL77lScCn74HIn4M
 E0+38rAY6ufacYKxbnVcSuHmjnXILtDDRfmlU5Z5xopuaujFLZfUxORuVYBZ9A==
Authentication-Results: goldencat.email;
 auth=pass smtp.mailfrom=i@nathaniel.land
Date: Wed, 05 Nov 2025 22:26:56 -0600
From: Nathaniel Hourt <i@nathaniel.land>
To: Yao Zi <ziyao@disroot.org>
Cc: UBML <u-boot@lists.denx.de>
Subject: Re: Build for RISC-V with LLVM
In-Reply-To: <534beda9eb77a786945ce647aebf7fa7@nathaniel.land>
References: <aAx9bjXivAAuth-y@pie>
 <EF1C62F4-2780-4DD4-B0FE-355AA66A10C4@getmailspring.com>
 <aA2z6ImdniJZm7fq@pie.lan> <cd30d0ef07796710523ac5d55bb67d0e@nathaniel.land>
 <aBQkbNrT-u6FPm_D@pie.lan> <534beda9eb77a786945ce647aebf7fa7@nathaniel.land>
Message-ID: <9c0038ed1494e9f293bf4faaf5e66ed8@nathaniel.land>
X-Sender: i@nathaniel.land
X-Spamd-Bar: /
X-Mailman-Approved-At: Thu, 06 Nov 2025 14:09:51 +0100
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
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

On 2025-05-01 21:31, Nathaniel Hourt wrote:

> On 2025-05-01 20:48, Yao Zi wrote: On Thu, May 01, 2025 at 03:54:34PM 
> -0500, Nathaniel Hourt wrote: Do you have any further information on 
> the issue of linking with LLD? Is
> anything more known about this problem yet?
> Sadly no, without any serial output it's hard to work on the problem 
> and
> I haven't searched through the mailing list for similar reports.
> Additionally, I don't have enough time to dig further on the issue...
> sorry about it.
> 
> I could revisit the linking problem sometime later if it's still there.
> May you give ld.bfd a try for now?
> 
> [1] https://lists.denx.de/pipermail/u-boot/2025-April/588038.html
> 
> --
> Nathaniel
> Thanks,
> Yao Zi

Oh, it's certainly an option. =)

But it'll be more fun to dig in and see if I can get lucky enough to 
figure out why LLD isn't doing the job correctly. I suppose I'll start 
by trying to figure out from the make system how the SPL image is 
derived and begin analyzing it or the build assets from which it is 
derived to determine what might be going wrong.

Advice and pointers are always welcome!

--
Nathaniel
I have found the problem and ~~fixed~~ worked around it! =)

So let's dig in. The problem is, when we link with LLD, the FDT winds up 
in the wrong place and U-Boot/SPL can't find it.

Now, I'm not completely certain this is the code the SPL runs to find 
the FDT, but I'm betting it's close enough:
lib/fdtdec.c, function fdt_find_separate [1]
```

#ifdef CONFIG_XPL_BUILD
  /* FDT is at end of BSS unless it is in a different memory region */
  if (CONFIG_IS_ENABLED(SEPARATE_BSS))
  fdt_blob = (ulong *)_image_binary_end;
  else
  fdt_blob = (ulong *)__bss_end;
#else
  /* FDT is at end of image */
  fdt_blob = (ulong *)_end;

  if (_DEBUG && !fdtdec_prepare_fdt(fdt_blob)) {
```

So it's looking for the FDT at the end. I do have 
CONFIG_SPL_SEPARATE_BSS=y (default, I think; I haven't touched it) so 
SPL is probably looking for the FDT at _image_binary_end, and main uboot 
at _end. Now, if we make with V=1, we see that both the SPL and main 
uboot have a step like:
`cat u-boot-spl-nodtb.bin u-boot-spl.dtb > u-boot-spl-dtb.bin`
...and this is then used to generate the final images. So the code is 
expecting to load the FDT from the end, and the build is using a simple 
cat to put it there.

If this works as it should, we should find that the base address of the 
SPL/uboot image, plus the size of that -nodtb.bin, will give us the 
address of the _end marker that the code is using to find the FDT. And 
with ld.bfd, indeed it does! But with ld.lld...
The SPL base address is 0x8000000 and _image_binary_end is 0x80248fc, so 
we expect the size of u-boot-spl-nodtb.bin to be exactly 0x248fc bytes; 
however, mine is 0x24a98, which is too large! If we concatenate the FDT, 
it'll wind up 412 bytes beyond where the code looks for it, and the SPL 
will fail.

The main uboot payload will also fail with a mismatch, because although 
the fdt very nearly hits the right spot, it actually lands 3 bytes early 
because u-boot-nofdt.bin is not 8-byte aligned:
$ grep "\b_end" u-boot.map

         402c9cb0         402c9cb0        0     1 _end = .

$ grep "\b_start" u-boot.map

         40200000         40200000        0     1                 _start
$ printf "%x\n" `du -b u-boot-nodtb.bin | cut -f1`

c9cad

(Actually, the main uboot seems to be working on the starfive now, even 
with this misalignment, but it wasn't back in May... Nevertheless, this 
issue does still seem to affect other boards, particularly one I have 
which doesn't use an SPL. Padding those last 3 bytes with nulls fixes 
it.)

Alright, so focusing back on the SPL... Why is the -nofdtb image too 
long? Well, let's look in the vicinity:
$ grep 8024 spl/u-boot-spl.map | tail -n5
          80248fc          80248fc        0     1 _end = .
          80248fc          80248fc        0     1 _image_binary_end = .
          80248fc          80248fc        0     1 __image_copy_end = .
          8024900          8024900      198     8 .got
         8024900          8024900      198     8         
<internal>:(.got)
Hmmm, for some reason, LLD is putting the GOT after the end tag. Should 
the SPL even _have_ a GOT?

So at last, here is my workaround:
diff --git a/arch/riscv/cpu/u-boot-spl.lds 
b/arch/riscv/cpu/u-boot-spl.lds
index 0717833df55..6e30f2f26dc 100644
--- a/arch/riscv/cpu/u-boot-spl.lds
+++ b/arch/riscv/cpu/u-boot-spl.lds
@@ -33,6 +33,14 @@ SECTIONS
         } > .spl_mem
         . = ALIGN(4);

+       .got : {
+               __got_start = .;
+               *(.got.plt) *(.got)
+               __got_end = .;
+       } > .spl_mem
+
+       . = ALIGN(4);
+
         __u_boot_list : {
                 KEEP(*(SORT(__u_boot_list*)));
         } > .spl_mem

Explicitly position the GOT the same place the main uboot image keeps 
it, so it doesn't sneak in somewhere it shouldn't.

Now, I'm sure this is not a proper solution (I note that 
u-boot-nodtb.bin is still wrong), but I have no idea what a proper 
solution would be, nor do I really know exactly what is going wrong here 
at all. But I've found a way to get everything running, and I hope I've 
found enough that someone who _does_ know what they're doing can see the 
real problem and how to fix it. =)

OK, that's all I've got!

-- 
Nathaniel

Links:
------
[1] 
https://source.denx.de/u-boot/u-boot/-/blob/master/lib/fdtdec.c#L1250
