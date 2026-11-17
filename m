Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF15606A330
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 13:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mO00akNV;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=T0/1Kwxv
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B7BEC80F92;
	Tue, 17 Nov 2026 13:18:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1rsADMOVRWtu; Tue, 17 Nov 2026 13:18:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 93A1F80B80
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794921499;
	b=Cii63cxTfNE6/sM0fwHsrnTRLn2+Oi5zBKN6nTBNiNhxnlfVNKQtfW8OHzH3NkfcABHn
	 RezK0BJBA3TMn+MUO1iVUvBN0pf7yozdfhZEy5LdxsKGz7+9cgfNN5ROY+qpJwZ2ePoma
	 oJ8D4FVuIRW5EuJxM1x4HJEG97/2ymOOYyKAhZ06ePlMX1+DusGNASDEIk7vLwoFeU994
	 SmcXh8kW2PS/RrZxhRTDmSRta0+4hbJg6h0mNd06VSAuc8S0Gg5ONjusmQJCFAG87j+fR
	 wqBtpUdO66JvO8F2RMsEW86GJLJb/EScA5Iajga/XRNY5t6jhjaVjhSpq4fX6ceQH0Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794921499;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jMsMmaQrUoQDm6KqnLKfcyrD0tErYhdgdgcJSFXu3Kc=;
	b=Ft0UOHnLGkgicpOzk9qh7k+hxcBLqQAj3aKjpQ1JjSTIE2fDbkyN+wmfuf019v9/I5/N
	 7IXFDtXoS4SkmS19m/1omFMgGt4rNbu2tG4mY6xXDHpm75TUCRlix+nV9L2RF5wpKcN+H
	 YqVPLpagw2bQyz3Ic42woNlkvI0aEeAp3DjqeFRNUPxZI1QMR+HJEQpUwfUxMiE5ZWUwb
	 eCzYPqClEwf2hoWVdJ0vX17KP9b7y4xhpddQya/xVgV0mmjLhykaWVOVbpxd9FDwSFvHy
	 Yl3OzrPf80B+kabCXDXJhJ8LllhWoq7pZyGQ9xThrjN94I/KE/e4nFYIE8YQtN2+smQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794921499;
	bh=jMsMmaQrUoQDm6KqnLKfcyrD0tErYhdgdgcJSFXu3Kc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mO00akNVnNXNIU+QvBhOgJfMAv3Dc/Y3/wdmHScV4N0MUYCHR2VqSPeZqpEUQft4w
	 8hcWwf/q8iXXOw6iFWtR/eNBqqDnCIL6RT1ziDdeKRTZ1RAmVxWTEg09GikCBkSwPX
	 ksj207bUpzni8Jo/QIfaI7fRCx3S3uptdoKON5BaRYx4+kow45Lz5XYq+UdWq9XeWV
	 rcbV/tX9kkPiW6JKj8NseDDeIEhtDTZ3oY9yIt2clA5XGZkQujhyjaISeM0egMKWDx
	 g4yVvC7vMTvOKy99g/zujqLSkadw2dzoMQtDIrootq7EWpaU+3SthzbJdMgJJS17MH
	 pPz4c9xIEEomA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 93A1F80B80;
	Tue, 17 Nov 2026 13:18:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6239E49B
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:53:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 48513400BC
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:53:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zqWMduZE_CD1 for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 09:53:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8939C4008E
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=T0/1Kwxv
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8939C4008E
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:53:26 +0000 (UTC)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6E5F33F8AE
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1794909204;
 bh=jMsMmaQrUoQDm6KqnLKfcyrD0tErYhdgdgcJSFXu3Kc=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=T0/1KwxvYSRimqfaEEE3sJLa62e5ooZGXnGsFzFekkQErWheD3kb3zkaWAql43+Wp
 eQM5hYxXdOioWVgj6EAl4i7135XC/I186iOVKQNh1MdPOHSrtADQtUKD7FCKX4cIIH
 7mdgBe8CbAkTLoQw9aavBQ+ik2NTOIpwqM7N2fvxblpoWqm/ZSl6pzGxwP/Fw7yB5c
 fezVXI+y7k8tlHPvoIwPA1dcQnM2ASRGnEvXw9d8v8qEWyFquZvvdvobdkAdOcon2X
 kEyQzQ8ylQphhp5AWkMR2S5zlhZYYfSbAbOXEotBCaIzfiSuoWcfSYrokpdgVq/KNV
 k6zm/Dm8NKOGG2ICLfJnBtqd7W3LgnWPrv27AGUR/dzT/VFDCvgDMXg4qwQCHxoKW5
 OQfayXvSmeUmjS/eTfDemFTMIcOd5OPOmDYSE80RyL7jd1khXmd4YsdPdfR/pvCQxG
 Gl+1U19Zd6BseFGdmqFSjMJDJeGI8Y5KHhxNWl9tPcZ3SGOz6T+3N397JLfD+UeGa+
 uMkpDHY6lyhQQ3HDuKcEh7Gs66XErIKo2qFIN6MpcXApQnAE8i7heeG6H32Rbw+f0L
 ULdppBQvVsgmlt6Sf6HNpkHBok9FvXil/OGKMBXkZu2fnVKMQUzwF4cKqHRS1dVPDr
 qlBAF0KwltaWD+NSxs5hvVgM=
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-6b57668479aso4756748a12.0
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 01:53:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794909204; x=1795514004;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jMsMmaQrUoQDm6KqnLKfcyrD0tErYhdgdgcJSFXu3Kc=;
 b=fEyB5td6wM+CKqY4Nm+9ob3I62Y185MNAwUpOXFI/LmpzS6muuewahPjiXpCBRaQga
 Iv3iWoF28x3M67TTsHaB+pHyktjxBdSxPColP/8q9n7JVosSmDYYuBDaQIZTYCPML3PO
 0n9hhGgDutCr3VtRKaE8VMWFRnT+terwZq797z8jM/qYCGPtkoRzeQwlpED33RuuyUIA
 GkK1lowSyqTpf0EMcK1OqTEh9ECG+emJKmomwqHdb/X1S47aq4AH8JF8NVWY0hqPB7Ej
 GS3W81r5nqurP/Zi2jxknWpeDiy9FHjajY2RkBlqKGMpson+CJegrYhF5WGqB4FSz3By
 4AcA==
X-Gm-Message-State: APuU4Z+QxXQleb0YzYtPMtRRV/nBbkNwbtORv+UqhnNkV9tLnq0LNm0L
 rIl0qyjf6V9TY7UO9wJjcoLL4d0IBJU6AdenoA1ObSX8GAKcbp5Y+JzXMxzzVrFjBPds4w/zCSP
 LfDgXfDQssfwNWUrW6zvsWZweCzlD5zr/y6JhmAAiSky0phBIgtAm6/O6+GDtmAWHINczX13+n8
 Mi1PZGLi4aBJxmJ9QKj0BqfMK6V7UVXvfGx5w/c9WLPg8NxS0I1N6vS3wYA854UxLRzpdO7Xk=
X-Gm-Gg: AYBFou01l0ZiPPfYwdpNDUahIjLY4hJEqqObeAWU8sGhr+83rH2M4Ixd3c/ujV9hh45
 BM/XlDc6uPTfDtzvttzlLFr6bho9GqGlosmYhW9CmxOyh6CEYaTXuz+HqgbACbKJWweL2eDLDmJ
 2oy1e/jGI8rgy2SWJs3311W89fwmdlNGd49RaengP+z6IBxuEWJ5sk1GDDlg==
X-Received: by 2002:a05:6402:c50c:10b0:6b7:1618:98e6 with SMTP id
 4fb4d7f45d1cf-6b7c095813bmr7030740a12.14.1794909203842; 
 Tue, 17 Nov 2026 01:53:23 -0800 (PST)
X-Received: by 2002:a05:6402:c50c:10b0:6b7:1618:98e6 with SMTP id
 4fb4d7f45d1cf-6b7c095813bmr7030718a12.14.1794909203373; Tue, 17 Nov 2026
 01:53:23 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261115143134.25791-1-aristo.chen@canonical.com>
 <20261115143134.25791-2-aristo.chen@canonical.com>
 <20261115205059.62cd55fdb132@makrotopia.org>
In-Reply-To: <20261115205059.62cd55fdb132@makrotopia.org>
From: Aristo Chen <aristo.chen@canonical.com>
Date: Tue, 17 Nov 2026 17:53:11 +0800
X-Gm-Features: AclHuK9xRUEEHFdcyTDPsXEHvgoFsEHFxt2anox-wVs3C15a_JldGu3mhp-Iqoo
Message-ID: <CAA=k7=keU0TbGea8vV7Ht9ziL50YZ=tufUrnXDcQOYahJ7tV3Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] boot: fit: bound the external data size on the
 imagemap storage path
To: Daniel Golle <daniel@makrotopia.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Frieder Schrempf <frieder.schrempf@kontron.de>,
 Alexey Charkov <alchark@flipper.net>, Johan Jonker <jbx6244@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 17 Nov 2026 13:18:13 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Daniel,

On Mon, Nov 16, 2026 at 5:39=E2=80=AFAM Daniel Golle <daniel@makrotopia.org=
> wrote:
>
> Hi Aristo,
>
> On Sun, Nov 15, 2026 at 02:31:13PM +0000, Aristo Chen wrote:
> > fit_image_load_storage() loads an external-data sub-image by reading it
> > from the storage device with a transfer sized from the FIT data-size
> > property. That property is listed in exc_prop[] in boot/image-fit-sig.c=
,
> > so it is excluded from the configuration signature and stays under the
> > control of anyone able to modify the boot medium even when FIT_SIGNATUR=
E
> > is enabled. The read happens before fit_image_select() checks the image
> > hash, and for an uncompressed image it goes straight to the load addres=
s,
> > so an inflated data-size overruns the destination before the corruption
> > can be detected.
>
> Agreed, that is a real hole in the zero-copy path and it makes sense
> to close it.
>
> > Reject an image whose data-size exceeds CONFIG_SYS_BOOTM_LEN before the
> > read is issued, the same bound load_simple_fit() applies on the SPL pat=
h
> > in commit 8f71d7170f5c ("spl: fit: bound the external data size before
> > reading it"), and print a message that names the option so that a real
> > image which trips the limit can be diagnosed.
>
> I would rather not use CONFIG_SYS_BOOTM_LEN here, for two reasons.
>
> First, only the imagemap_map_to() branch can overrun anything. In the
> other branch, imagemap_map() allocates the buffer from LMB at the
> requested size and reads into that, so an inflated data-size simply
> fails the allocation. Without your patch, a ramdisk without a load
> address and with a data-size of 1 GiB gives
>
>   imagemap: LMB alloc failed (0x40000000 bytes)
>
> and -ENOMEM, and the reader is never called. On that branch the check
> adds a size limit but no protection.
>
> Second, the limit has nothing to do with the destination. On most
> 32-bit ARM and on MIPS, SYS_BOOTM_LEN defaults to 8 MiB, so a ramdisk
> or loadable larger than that could no longer be loaded through imagemap
> there, while on arm64 an inflated size of up to 128 MiB is still written
> before the hash check.
>
> What the direct read needs is to stay within the free memory at the
> load address, and LMB already knows where that ends. IMAGEMAP depends
> on LMB, so something like this in the direct-read branch would do it:
>
>         if (img_comp =3D=3D IH_COMP_NONE && load_op !=3D FIT_LOAD_IGNORED=
 &&
>             !fit_image_get_load(fit, noffset, &img_load)) {
>                 if (data_sz > lmb_get_free_size(img_load)) {

Thanks for the review. Agreed on both points: a bound taken from the
destination is the better one, and only the direct read needs it.

I tried your check on sandbox: 2/2 passes unmodified, the imagemap and
bootm suites pass, and a valid ramdisk is still read straight to its
load address. It also stops a case that the v1 ceiling lets through:
8 KiB whose end lies inside a no-overwrite LMB reservation is far below
CONFIG_SYS_BOOTM_LEN.

So v2 will have your check in the direct-read branch, no Kconfig change,
and your Suggested-by unless you object. It stays partial hardening, as
you say: free memory behind the real payload can still be written before
the hash check, and direct-read destinations are still not reserved. The
commit message will say so. I would also add a test that a ramdisk with
a load address is still read straight to it, since the check can refuse
a valid image.

While testing I found three limits of lmb_get_free_size(). I would
document them in the commit message rather than solve them in v2.
Would you prefer a different scope for v2?

>                         printf("FIT external data (%u bytes) does not fit=
 at 0x%08lx\n",
>                                data_sz, img_load);
>                         return -EFBIG;
>                 }
>                 dst =3D map_sysmem(img_load, data_sz);
>                 ...
>
> lmb_get_free_size() returns the number of free bytes from an address up
> to the next reserved region or the end of RAM. That keeps the write away
> from U-Boot itself (code, stack, heap and the relocated FDT), from
> memreserve and reserved-memory regions, and from anything imagemap_map()
> has already put in LMB, such as the kernel. It does not limit how large
> an image may be, and the Kconfig change is no longer needed. I tried it
> on sandbox: 2/2 passes unmodified, as do the rest of the imagemap and
> bootm suites, and a valid ramdisk with a load address is still read
> straight to its destination.
>
> Like your version, it is not a complete fix: free memory past the real
> end of the image can still be written before the hash check. If we want
> complete protection two more things would need a look:
>
>  - Destinations written by imagemap_map_to() are not reserved in LMB,
>    so a sub-image read directly earlier (an FDT, say) is not protected
>    from a later one. Reserving the range after a successful read would
>    cover that.
>
>  - We need to be sure that a legitimate load address cannot already be
>    reserved at that point, for instance after an earlier boot attempt
>    failed.

1. Reused addresses.
The helper stops at every used region, LMB_NONE ones included, and
returns 0 from inside one (item 3 below is the exception).
fs_read_lmb_check() ("load"), lmb_read_check() (tftp, wget, "sf read")
and bootm (in-place ramdisk, in-place FDT, the OS region) all create
such regions, and there is no general rollback when an attempt fails.
So a valid FIT is refused when the load address of a sub-image was used
by an earlier load in the same session, successful or not. For example,
with in-place initrd, an attempt that gets as far as reserving a
directly loaded ramdisk and then fails leaves that address unavailable
to the next attempt. On sandbox, a valid 64-byte ramdisk whose load
address lies inside an LMB_NONE reservation, made with the call
fs_read_lmb_check() uses, gets -EFBIG.

tftp and wget stopped using the helper for this reason, in
commit af45c84871e4 ("tftp: rework the logic to validate the load
address") and commit 51ebd514ec78 ("wget: rework the logic to validate
the load address"): "This call fails if the same region of memory has
been used earlier." Only its unit test calls it today. It also means
that reserving direct-read destinations, your first point, needs
lifetime handling: a reservation that is not cleared makes the next
check refuse that destination.

2. More than one RAM bank. The span it returns can run across the hole
   to the next bank: with two banks of 256 MiB at 0x40000000 and
   0x60000000 and nothing reserved, it returns 0x28000000 for
   0x48000000.

3. With a 32-bit phys_addr_t, a reservation that ends at 4 GiB is not
   seen from inside it: with RAM from 0xc0000000 to 4 GiB and the last
   16 MiB reserved, it returns 0x800000 for 0xff800000. From below the
   reservation the result is correct, so this only matters for a load
   address that is itself reserved.

I looked at lmb_read_check() as a replacement, since tftp and wget use
it now. It accepts a reused address and keeps the range inside one bank.
But on sandbox_defconfig, where phys_addr_t is 32 bits, it accepts
0xff000000 bytes at 0x02000000 because the end address wraps; it lets a
direct read overlap LMB_NONE regions such as the scratch buffers of
imagemap_map(); and it leaves a reservation behind. So I would stay with
your comparison.

>
> Separately from this patch, imagemap_map() should not depend on a check
> in image-fit.c: on 32-bit, a data-size close to 4 GiB makes its size
> arithmetic wrap, which your check currently happens to prevent. I will
> send a fix for that in imagemap_map() itself. If Coverity still flags
> the imagemap_map() branch once the direct read is bounded, I would
> rather deal with it there.
>
> > CONFIG_SYS_BOOTM_LEN is only offered when a boot command or a legacy
> > image format is enabled, none of which IMAGEMAP selects, so make it
> > depend on IMAGEMAP as well. Without that an IMAGEMAP build that enables
> > none of them would reference an undefined macro here.
>
> True, but with a bound from LMB this hunk can go.

I will drop that hunk in v2.

>
>
> Cheers
>
>
> Daniel
