Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12CF1CC6B12
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 16:04:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C334C80B49;
	Tue, 13 Oct 2026 16:04:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pzpd8IyWAkOB; Tue, 13 Oct 2026 16:04:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E3CA480BD6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791907467;
	b=Jf+AfgL8vntDFfUGAPvA04ElkS/0u7gNSGnDVn9Kse4dN2khjh10NAhhs3QWbBZVTeRD
	 piCoGU/7Wd0i+C0ou1amG9ONOThSlYKck9f+lqb0Xb5sIy2nkUDIYl+epYTLVaKVZIM+i
	 /I9LmTAQWXrRMSdH986KExrBVBJq6l5mbErboEbr+OmkIz8062Vp78pJ8nqkXi1qmV1uw
	 xSaekz8tX7E0KGjw/J7bWNsehHyf+j0NuuDW2h76w+H1bS4SiZwxSO+RM1pl5cQ8ULn08
	 2rqdT4FuRojP4A0kDtuULU68wEO/zuWKzyQXpxhjKydQF/oLcNHA88mUbxRffhmZkiw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791907467;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=7w5Gtb1jZZS51BRlTocSwECVww5U7J/lPU1RySsGRxo=;
	b=bO4R7PW7nGzx8c5pdwaHzCiyN7M5fcG/cDLyZuKH3LEjdQpaSv3cg4t5QgZNSgg4qYsS
	 FQbrXocA2/4cZXqwOTL7C+D0zz9vQZTDQ5wXvm8o6WF2V2exPxzyHEAOW0WuzyK4VEC55
	 8zsDV3Yxy6ATYHdO3V8ih/pLbuMpOq/se7Q6h5nU1dRqLjO3vgd+0mrysdGOSzx7CEgBv
	 wBVViN2tRxKnd9FGbVVqWTs1uOas85jeIIImfPi641oOxaoPkP4qSz/nYKBsPdB5Tb8rK
	 GdhWxs6P0QWYFDem9XEpik1Jrzq1AeYcdVSzVL/3C1X4mAI8b/JaBw3jRFg2GPH5YtQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791907467;
	bh=7w5Gtb1jZZS51BRlTocSwECVww5U7J/lPU1RySsGRxo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yuZIL7ENcXi8Q8DD5uK6gRBMnmGVYjjRMoU3DudyzggKEyGWTSL2pPOW/0qfF8m1Y
	 5JmEylo6d/pqL1TfdlkKAcBPvbp8K05lRNU6Tkb2abSCzCYybrrZPCYr0kl5OL6TAO
	 XPl39QkkB9+rsGHnHZwbHu8zls62v8UpXGbJ0rRfcWSy2vuwMs7jUAoA2vtMbPG4xI
	 9kr9Map+XVuaB12J91ft5z+GouKLjFz7ezNKSDHYBO4xJ8O237URlAaLHmlkhb/bnq
	 S4Zhj8BL8zk/IDcek+0FZFZITInh7dLUyg5i1WICyFgKjrIBE+JsA7yKNWla5+h9Bu
	 f8AkwmRw1HkWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E3CA480BD6;
	Tue, 13 Oct 2026 16:04:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B902D2E0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 16:04:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9F79840059
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 16:04:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id czHgbgmDY9Cu for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 16:04:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E296F40049
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b12e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791907464;
 b=L/xxg/vNl8c0Kas6aYbHLxTQ2H0m3Qe9yn5GgFS0AfTko4O1rMq80g+TQ8y6zSBCWY8M
 iv/lrTRZakPTJVuLjGZWCg8PLMEpem3vNL0LyrhHC0KpjHDzQrDga9GIKEsuuxNEqF3Uy
 w3OLOFetub9j/v8nowlbkOLoMvmy0jQmSfEpfMpbKfGrHKuC02IiSByQ1oNPZK7pJBkEv
 bOzwsb32CkUcRxKriM4uEfFoRhoNUMpXFWixsjbiN5w5cOtPvj/3qt0oF3m7MxO1YtQPq
 vtEjJiwbkSchYjsbqpLwAghniwwwh7iL5oGh1aAU5THJCGRX5g3MHgaLjJk+2NhIqUg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791907464;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=7w5Gtb1jZZS51BRlTocSwECVww5U7J/lPU1RySsGRxo=;
 b=sE2AzolDPmR/0u/0NAYD4iBJG/N0QKHz2Vu3whdaVJlyJj4aCGPgNHa8ga1e2FclthfV
 Oe+qPHap7BS5P/Tptzf6pS/dN7tHr8BqfETK6IiGI5pJrHikHpZ9zYZrKvXs2emsQCYgu
 OAt7Uszs7+xyK4CY5iRhqRT5h1wSEJatV7P0BFLuDKy0uFnkgB26lj3kGE4K/AbsocjEb
 6M83WRNf68LsPuRtRmAS7c7HuFE3Ci+qNrhWIm/E0VEKJ5FHOjuy56frwaiI3svJrHJVu
 IioOVthFDiGTtDsrCI4WYUkJDHBm1owaMKAvug4sfBVow4WKigkzEBSbF3DPQTJBcLg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.tenstorrent.com;
 dkim=pass header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=Qt2JfETh; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::b12e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12e; helo=mail-yx1-xb12e.google.com;
 envelope-from=asrinivasan@tenstorrent.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.tenstorrent.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=Qt2JfETh
Received: from mail-yx1-xb12e.google.com (mail-yx1-xb12e.google.com
 [IPv6:2607:f8b0:4864:20::b12e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E296F40049
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 16:04:22 +0000 (UTC)
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-6740e7ae219so2425517d50.1
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 09:04:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791907461; cv=none;
 d=google.com; s=arc-20260327;
 b=MTx0FAkwF8XrA26Q1j4fWoQ6AlZ0dJ0SZqZAOq1/TfLWp88uQABP7njHQ5uNpLSfYG
 HZCXJ5vlpfy972hD3R8CPvhl/CGDRoMgVvZ+s65H7BiuB6gaXc9jhhgMACWplPrHcCXu
 fYJt0yoJZfphVADpCY+dV9jEVGrrmAdZbxwvRab97eiZzTKDOwQl852+X7pGefMCf9N+
 iz+ww3NOqlxKgakOar8DdUIzKO7QQAl5jThWRqrLVsFtZxg9vb8X1iybprgh2FxhwESD
 uowJ6sLLk+12+bKm4g/oA/KpzTcK8LRB8uElu66F+ZRfAhfj1+sXz28E7us6LVHB6uQa
 8OWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7w5Gtb1jZZS51BRlTocSwECVww5U7J/lPU1RySsGRxo=;
 fh=oIMmC8iu+RpL9QS0aPIrVHvb7dY/DmDKYgM4/PZle3M=;
 b=mUp2jrhs7CaxinyUrqyKXWZTv6hX40KZgZ5JRgUVnRjjIuBfWcTV5pZbqEbulbv2ar
 ZFNIfB22UTAJSUMtf4biPmJbqrVaTKXpBNyb9K32NRASJyq08tUb6YKI1VZDIEdRv+w7
 Yztt6Ab1HnxNdycGKpcBvxb4C2x6W4zId6A/FCuDnztt2ES58q4WDhQUb33tB7Skdz4I
 YVZbWaOdDWbgUg1xi7w0HCRY11j2VfMC0nzyp8w3X2lHwGxgrY2QVZukXa8vpspTeJfL
 qkavfT51RF6ocxHnlojMcSgpA/LTPZm+9WnacQPo5tQr2v8Va0PLXX+aJOh98Hc+njP4
 doHQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1791907461; x=1792512261;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7w5Gtb1jZZS51BRlTocSwECVww5U7J/lPU1RySsGRxo=;
 b=Qt2JfEThg5oF/mWuz3RXiPk4GNvcWVKkmkLj1sa7lew9wAFsy6PG0pWJKyH9jf1cQN
 ojjL05hjH0ke2t+goqosMcJnbdkEj0r+sDY0sxOFDsmPqucdixzT1zMaWOeJiP7IuQBS
 H4DQDKWnk7zSadeTJlpCPjT0UwkGgenRIk5RhK6KFLvDdt5eBC/pm2wFaliuF+hwsImg
 wxXLaMRzGGfk5JOfeJ5Bw8/nXUER2z6NiuaOwDem2tULk2brYft6X7Oh1rPrq9E9mn4N
 ROKXplF/C9zaZ5ilmpQlBAxKQdVrdhbZVQKNY5O/SsfAodzQq2+deP8+aoBH64+RGmpj
 pIQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791907461; x=1792512261;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7w5Gtb1jZZS51BRlTocSwECVww5U7J/lPU1RySsGRxo=;
 b=2My6gpTqFdSWRu98YkvmEYDzgOeqXfcAaM7ZjutzaNQk8KTXjaghu16II1x/OSqume
 Ij7D4FQWLAw6ushB1FPh9RCQj4zUWgbV3dZxJQjscGf+C341OGxEmh9EBUOAayjjInF6
 gq8HII/fLh0uHJgUdztk+nyFQs37Me1nihyfX2Sw5gO0R8H9G0Ba9eTANha2aIjf7yz0
 SrvOQwlJgj5vNBoWqO+2/nzcZ67H9H+SW0qPGf4hQoH8ehrk6yCkR25ahHk7fab4ieHa
 dyQ0ZT9zuSEQxzVdBFGg1N26gFceXr2ceDwfuWL/BpE9/vCulxYpvEeIFIzu0np7ZBVA
 STbg==
X-Gm-Message-State: AFq9FYJ/jMz8TpxaLxtbAK2axn7aNJJw4bWTEpocRvz6JebWRaUmAMy7
 LgMwviF5sAJP5o2nbVI9FWgsJ0wtWs88T3L2/+oSaIR82xohA5w2LRP8qCmTvrXYhYvMTWMi9WO
 JbBj/U/w5ELLw/p7i0EPy78hdBP133fZmRu67Z2eJlo5CWyb4BOZDO4g=
X-Gm-Gg: AYBFou3gh6KDI/pot+UnQqJOtGIIIuIBmzH0euyxjJE/KZmJL8KGguZIbvLY1n6BAh8
 Zejyyg+dkzEREh4JGjgxr1eauzl2JGcoVTJajFHRaHm7L9KjPAEV4rxezB3cw6B+LeHsi+kRxIn
 8yqgL0o4zra+T0GFg5UPjHjWrVTdql3wr/IBJy+qqxsjnFIQz38zRDFvNsyJjtXM3eev2Eb4TwB
 dT3ov4yaiLUV3AVu6YdqiwmT8fD6+Wtuxqo9UcocL9M2Q1hKqUlg3kBccgfUCUSr3ySaYqMQwkI
 OfPqfkg4yJZV29SwlO+VhHtBQafWfVqjZEob/HWBzwTfis3Zkc/urQ58jnFqyUuZTKyVpyUZ1qG
 3ZWuabnReV5U=
X-Received: by 2002:a05:690e:14c4:b0:667:dfad:8767 with SMTP id
 956f58d0204a3-67935f19037mr4206142d50.9.1791907461339; Tue, 13 Oct 2026
 09:04:21 -0700 (PDT)
MIME-Version: 1.0
References: <20261003-aspeed_vbios_fixes-v2-0-f8e593f024ab@oss.tenstorrent.com>
 <20261003-aspeed_vbios_fixes-v2-2-f8e593f024ab@oss.tenstorrent.com>
 <CAFLszTj3vnH=6Y8zQu57x2UzSvZSbe6DwS4iavVwDLUiCFYv=Q@mail.gmail.com>
In-Reply-To: <CAFLszTj3vnH=6Y8zQu57x2UzSvZSbe6DwS4iavVwDLUiCFYv=Q@mail.gmail.com>
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Tue, 13 Oct 2026 11:04:10 -0500
X-Gm-Features: AclHuK90ogC8qxIEDuMJ87hrFvSPyVxR_mOki_rqGbhdmMQX7M3jMzsabv-H81s
Message-ID: <CAEev2e8yv85vpoZzAedV5c74nusd6MGJYVaFOrQ1AykpJMU+mQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] bios_emulator: don't free a caller-supplied BIOS
 image in biosemu_run
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Simon,

On Tue, Oct 13, 2026 at 5:25=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Anirudh,
>
> On 2026-10-03T20:07:54, Anirudh Srinivasan
> <asrinivasan@oss.tenstorrent.com> wrote:
> > bios_emulator: don't free a caller-supplied BIOS image in biosemu_run
>
> Please say where this is actually hit. pci_run_vga_bios() passes the
> image from pci_rom_load(). On x86 that image is at
> PCI_VGA_RAM_IMAGE_START (0xc0000), so the existing 0xc0000 check
> avoids the problem. On other architectures the image is malloc()ed and
> pci_run_vga_bios() frees it again on exit, which is the double free. A
> Fixes: tag would also help, if you can find the commit that started
> passing the image in.
>
> Whilte you are here: the subject is 69 characters. Please can you
> shorten it, e.g. 'bios_emulator: Don't free a caller's BIOS image'. In
> the body, please write biosemu_run() and PCI_postController() with
> brackets. Also 'i.e' should be 'i.e.'
>
> >
> > biosemu_run can be called with a BIOS image supplied by the caller
> > (argument bios_rom is not NULL), or with no image so that it makes its
> > own copy from the card's ROM (argument bios_rom is NULL).
> >
> > It subsequently calls PCI_postController, where the BIOS image it runs
> > is stored in vga_info->BIOSImage. In the first case that pointer is the
> > caller's buffer; in the second it is a buffer biosemu_run itself
> > allocated.
> >
> > The clean_up path in biosemu_run always frees vga_info->BIOSImage. That
> > is right for the second case, but in the first case it frees memory the
> > caller still owns. This can cause a double free when the caller tries
> > freeing this memory again.
> >
> > Only free vga_info->BIOSImage when biosemu_run made the copy itself (i.=
e
> > bios_rom is NULL)
> >
> > Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
> >
> > drivers/bios_emulator/atibios.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> > diff --git a/drivers/bios_emulator/atibios.c b/drivers/bios_emulator/at=
ibios.c
> > @@ -509,7 +509,7 @@ int biosemu_run(struct udevice *pcidev, uchar *bios=
_rom, int bios_len,
> > -             if (vga_info->BIOSImage &&
> > +             if (!bios_rom && vga_info->BIOSImage &&
> >                   (ulong)(vga_info->BIOSImage) !=3D 0xc0000)
>
> The fix looks right, but with it the other two conditions do nothing.
> When bios_rom is NULL, BIOSImage is always the buffer
> PCI_postController() allocated, so it can never be 0xc0000; that check
> was only a workaround for the caller-supplied case on x86. free(NULL)
> is also fine, although PCI_postController() returns false before it
> sets BIOSImage to NULL anyway. Please can you simplify this to:
>
>     if (!bios_rom)
>         free(vga_info->BIOSImage);
>
> That also makes the ownership rule clear.
>
> BTW, PCI_postController() leaks copy_of_bios and vga_info when it
> fails after the malloc() (e.g. on an invalid ROM signature), but that
> predates this patch and can be fixed separately.

Thanks for the comments, will make the changes to the commit message
and drop the extra conditions checked before freeing the biosimage.

>
> Regards,
> Simon
