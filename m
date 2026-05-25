Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B17BCD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 14:32:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A22F84862;
	Mon, 25 May 2026 16:32:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G3RWoMZQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28E7A8487C; Mon, 25 May 2026 16:32:15 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C00C84841
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 16:32:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-bd8f6ef4ba6so1422059966b.3
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 07:32:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779719532; cv=none;
 d=google.com; s=arc-20240605;
 b=ZD/ohr034gfwlApuSnDo+s4ih0bjO3K7ex7JmTxfddiJLeZRqDXEjNqKPFsTHZvlNR
 dPsAer8wQPgxNCwBNjjv4j15GmYQfaZpDql4K17B48w7rSKBdBj+nhTd8JKbHP9FFmRu
 aOdKNSxVWA1CjPPpghZnv6NEU+7/zRqL5KdyKN4+yoUEF3w95EIObIsov+P2nXpX+0oH
 R/gVn3FPg8OeG4uynOCXI7GXv5j1Lmra5+4H6DH1IzFXg2Ja0n1IqJ0JgFUS0WRyNvYc
 LFKznA3AuYlMWrIL3wJIqVhoulxCrluj5pEGAxZ+slLY/y079SQMaDVr71wm0k6XWX4F
 QD3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Lel8HfAsYU5qjJ6qmp2oizJNethoBHt53jbndFpCqUE=;
 fh=uEwfVtgWmQ+BpqL3MMm4A4agCJ5OLHBunogpqm9TwOU=;
 b=lkCbFSwDaepld8tTNkz+fIQEJkL102Ep4NME9rxFVH5WXX9wWZUs6R8RpRMG/NRm0K
 B0HY2g3lkHYpfRD7BN2CoRMAO1cgOQc0Ve8znBWkmUlhxe9IOPeaMgy2QrtU3Rm6TO+R
 FAob3NN3bJ+9Et+aTn3jSFS+NGTUxCNvrsMScuDVN77eV6PAnsf028thdWRVLkJvwP7h
 wn2MEqd7q6/po+PbsWx+iFmWKYNHAupLY/9+iU6DCLI6PSibrB0ndoPRoNmGHFN/3pFL
 mMs1goT0oaiHIJ69nCD3OWSB7kvaBW8r4tXWQJax+1GlOfPrSx1LEzkJgA+8uKAZG/mn
 TKiA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779719532; x=1780324332; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Lel8HfAsYU5qjJ6qmp2oizJNethoBHt53jbndFpCqUE=;
 b=G3RWoMZQwB0dwsaZ6lxKSa8lOWmJjPHAt1b0XSwpNIrXpHuTu5XFQD6xnej7vF8VBk
 AflcKupi4E+mFcSZy+rk3Skq8PBy6jFXLC8TOdnX7iYplfgkgFQpkA6AJgS3ShKMjH2L
 qSFdMQQe4mmHBOMwrLEPegJ5l1lyosSqUW1D0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779719532; x=1780324332;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lel8HfAsYU5qjJ6qmp2oizJNethoBHt53jbndFpCqUE=;
 b=QGOUFpWl80y5klfAeIJtG+k31UAi26uW9RGb5u1iXf+nBYbO4yi7kSyJKMgWuLgzay
 ERUfzTW4NZZPRSQ5w85Eaa8yPVEaGWoGmUM6ukiuhlQu2LVb6sFCf29Xw1rEM6bnKqn0
 FbtZcSbQudrlkr3v41VIsY2fETZslA5016swNXtOuY2nolJsr8oPHG4ndzIr+xtUIJ/1
 Eyi8Z97rjcEDpgIt79YzG3BvzP53h/4NJ96GBBWwsTgwSScSrFKFWxPqLQNuDWO7Xh8W
 TaO54GdE5U3NDRWvytBTkI5VEjiUoOsSb+URuI7rgoxQZx8bQU3c5JF4s3XJV+IapW5R
 WErQ==
X-Gm-Message-State: AOJu0Yyz9kZu0o0xtckhBGxs63P1S4DpquiScf2+ZIJtRaml9lV45Lxr
 6u0XDPskkHb7VRZ41M/mS/5ZSov++eHLOl+b/nhj9QOHvKATNdfGJjU+1KABuaxW8HOJkVZeehi
 NPCH+OF5qSz5te9YamGDjEMiGoa0h1F1b9KeeobjC
X-Gm-Gg: Acq92OG2BlVnqrIHA9R7jjW26WBez0PmPaClRebsW/8Dj+TqbtdSYZfYJBZL2WNNoR/
 RNC2otJyjet0/cvq4x8YDJEHfOT/O9grtK5IOIvBrqruIpf3GcuMwEdbpwcg2Ed4VmbtC8xTAJV
 kE4ThnOfU3HiqqvmWRbZyJgPxyARRKlURQu5wV5uIDugUt/vebBb9w65cpaD6CUjnxh/GBy9LmF
 7CmDZu2CLi8Q7cJ6XiG0g+A5Fqx904f6tkVF2XmHQRtxv3e4RRVM1l5IS+2jve3IKbCP55nbRU2
 bdNoTb6YbpXJdUza
X-Received: by 2002:a17:907:b14:b0:bd8:1c88:cfef with SMTP id
 a640c23a62f3a-bdd2293182amr621153066b.5.1779719532523; Mon, 25 May 2026
 07:32:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260522212756.3169222-1-ravi@prevas.dk>
 <20260522212756.3169222-4-ravi@prevas.dk>
In-Reply-To: <20260522212756.3169222-4-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 May 2026 08:31:56 -0600
X-Gm-Features: AVHnY4KTFSYhdtkMr0wWjMyvmF2hQBx-PIxyBoRjf1d6_KktCiwmXysCnazFGao
Message-ID: <CAFLszTiHX+_0AQi1OH4_d0jtw3nOhV56=b3VSV4Sx7YDnYfn2g@mail.gmail.com>
Subject: Re: [RFC PATCH 3/9] event: Remove obsolete comment and __used
 attributes
To: ravi@prevas.dk
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

On 2026-05-22T21:27:48, Rasmus Villemoes <ravi@prevas.dk> wrote:
> event: Remove obsolete comment and __used attributes
>
> Now that we have both resolved the problem on sandbox that lead to a comment
> about linker list entries being omitted as well as made linker lists
> never list themselves as unused, we can update the event header file.
> Remove the now obsolete comment and '__used' attribute marker.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
>
> include/event.h | 35 ++---------------------------------
>  1 file changed, 2 insertions(+), 33 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
