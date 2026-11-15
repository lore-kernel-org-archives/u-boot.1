Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37477606A31F
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 21:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=m1D7Zyd1
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D8CE280E00;
	Sun, 15 Nov 2026 21:39:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hoqNntpF1x6g; Sun, 15 Nov 2026 21:39:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9F56280DF0
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794778775;
	b=a4fV7iP/ZIIcPe+fxdoNofLSPhYffbDtvXO+xTF1kDkDhzjJVwe6lKaNwbyUnEi1LXiF
	 uuGasVZclvpnynpCQVqWKazV3un7sVYadwp1CWqgegPmmpJI6bqMSk9VsFWQe62XM+X+a
	 lWe4FqHot6rCCk2Gtk9FrhPBIRH0li4mHBjDk47NWn0Du7IZGhzFy/UuJKohuRN92F3+M
	 fFWPotH+8+kh6DPYPbU4KGjhuWs/dp2RSzYgDKdLGF0wikUaOO6m85KqVVOLHG3/CMjqU
	 mAGR3A/iJ+okS2Mznjl52Bby4alTnfdyMKQdjDk6M5KNQeNbEP0xhTEXb5n3YAwgP0g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794778775;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/gMFn840UpCzuO0DkxQVP8lT4cL5+2pTUb7cB8KA9Hk=;
	b=I/VsBX572TaqkQGy+ZoeukEi81EYHQxWPIJTmDRlCd/K1T+dLbqfpDZatnDilWftX1gk
	 WQtx5FC1xsbcWix6Oj9BecpamgjSgwTdm0uopmBBaTqFY210PFyIu0D9aAcsZ8NK2om4L
	 TBbbcOMYafhixv7t6wp87RmUybNxn0ah1fCPceKSTgZkvJoO3/z8zucyzVryqJWWmf97Q
	 mBQptu3JZb+Lx0YLLu9KHqFCN4WkTBoo4eLI5JG1546lZhSUbx/l19SkDnxp6U37khbUV
	 JfRDA8wonyGKCsdrgPgBciyLtCZ2PDqsb4ftiHI90+8Uw3RHaumpgjmKaaPadjYvTzQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794778775;
	bh=/gMFn840UpCzuO0DkxQVP8lT4cL5+2pTUb7cB8KA9Hk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m1D7Zyd1Lm17lL+tj4Wfs+JVRrvwxjTHXbx9YJisCakG4dtzIPqAaS083rJh7n2dm
	 Ppwhr4RmBAW+qRdtBxEtW4J9fPqf6ga5unkCQt2BYhY9BzOuK3SXuPEfvYMZOxJIAB
	 Mz9rdivcwwkTzxAIm8Hz/TmMdnU15m32Tiesiq62KWTZx6AUyqJejBN3ijzdzrTWOO
	 oxok9Alctz3449spnC2nliHDZo2fnQ6gYa2llGaDAkUkD9Cn6RgoCuL3KXx52YqJdj
	 DcupKYjeAfmNNCa7pVf1f7rKvjn8uz+tfeSdsK5v3wwTwxXe/B5J18z5MAkb40U9GW
	 5k3JvXDbmbkeg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9F56280DF0;
	Sun, 15 Nov 2026 21:39:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 76CCD70B
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 21:39:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 558AB4053A
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 21:39:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id inMyfIiJ81ix for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 21:39:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4DEC74052F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4DEC74052F
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 21:39:28 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xShwX-000000004eM-2huQ;
 Sun, 15 Nov 2026 21:39:22 +0000
Date: Sun, 15 Nov 2026 21:39:04 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Aristo Chen <aristo.chen@canonical.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Alexey Charkov <alchark@flipper.net>, Johan Jonker <jbx6244@gmail.com>
Subject: Re: [PATCH v1 1/2] boot: fit: bound the external data size on the
 imagemap storage path
Message-ID: <20261115205059.62cd55fdb132@makrotopia.org>
References: <20261115143134.25791-1-aristo.chen@canonical.com>
 <20261115143134.25791-2-aristo.chen@canonical.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261115143134.25791-2-aristo.chen@canonical.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Aristo,

On Sun, Nov 15, 2026 at 02:31:13PM +0000, Aristo Chen wrote:
> fit_image_load_storage() loads an external-data sub-image by reading it
> from the storage device with a transfer sized from the FIT data-size
> property. That property is listed in exc_prop[] in boot/image-fit-sig.c,
> so it is excluded from the configuration signature and stays under the
> control of anyone able to modify the boot medium even when FIT_SIGNATURE
> is enabled. The read happens before fit_image_select() checks the image
> hash, and for an uncompressed image it goes straight to the load address,
> so an inflated data-size overruns the destination before the corruption
> can be detected.

Agreed, that is a real hole in the zero-copy path and it makes sense
to close it.

> Reject an image whose data-size exceeds CONFIG_SYS_BOOTM_LEN before the
> read is issued, the same bound load_simple_fit() applies on the SPL path
> in commit 8f71d7170f5c ("spl: fit: bound the external data size before
> reading it"), and print a message that names the option so that a real
> image which trips the limit can be diagnosed.

I would rather not use CONFIG_SYS_BOOTM_LEN here, for two reasons.

First, only the imagemap_map_to() branch can overrun anything. In the
other branch, imagemap_map() allocates the buffer from LMB at the
requested size and reads into that, so an inflated data-size simply
fails the allocation. Without your patch, a ramdisk without a load
address and with a data-size of 1 GiB gives

  imagemap: LMB alloc failed (0x40000000 bytes)

and -ENOMEM, and the reader is never called. On that branch the check
adds a size limit but no protection.

Second, the limit has nothing to do with the destination. On most
32-bit ARM and on MIPS, SYS_BOOTM_LEN defaults to 8 MiB, so a ramdisk
or loadable larger than that could no longer be loaded through imagemap
there, while on arm64 an inflated size of up to 128 MiB is still written
before the hash check.

What the direct read needs is to stay within the free memory at the
load address, and LMB already knows where that ends. IMAGEMAP depends
on LMB, so something like this in the direct-read branch would do it:

	if (img_comp == IH_COMP_NONE && load_op != FIT_LOAD_IGNORED &&
	    !fit_image_get_load(fit, noffset, &img_load)) {
		if (data_sz > lmb_get_free_size(img_load)) {
			printf("FIT external data (%u bytes) does not fit at 0x%08lx\n",
			       data_sz, img_load);
			return -EFBIG;
		}
		dst = map_sysmem(img_load, data_sz);
		...

lmb_get_free_size() returns the number of free bytes from an address up
to the next reserved region or the end of RAM. That keeps the write away
from U-Boot itself (code, stack, heap and the relocated FDT), from
memreserve and reserved-memory regions, and from anything imagemap_map()
has already put in LMB, such as the kernel. It does not limit how large
an image may be, and the Kconfig change is no longer needed. I tried it
on sandbox: 2/2 passes unmodified, as do the rest of the imagemap and
bootm suites, and a valid ramdisk with a load address is still read
straight to its destination.

Like your version, it is not a complete fix: free memory past the real
end of the image can still be written before the hash check. If we want
complete protection two more things would need a look:

 - Destinations written by imagemap_map_to() are not reserved in LMB,
   so a sub-image read directly earlier (an FDT, say) is not protected
   from a later one. Reserving the range after a successful read would
   cover that.

 - We need to be sure that a legitimate load address cannot already be
   reserved at that point, for instance after an earlier boot attempt
   failed.

Separately from this patch, imagemap_map() should not depend on a check
in image-fit.c: on 32-bit, a data-size close to 4 GiB makes its size
arithmetic wrap, which your check currently happens to prevent. I will
send a fix for that in imagemap_map() itself. If Coverity still flags
the imagemap_map() branch once the direct read is bounded, I would
rather deal with it there.

> CONFIG_SYS_BOOTM_LEN is only offered when a boot command or a legacy
> image format is enabled, none of which IMAGEMAP selects, so make it
> depend on IMAGEMAP as well. Without that an IMAGEMAP build that enables
> none of them would reference an undefined macro here.

True, but with a bound from LMB this hunk can go.


Cheers


Daniel
