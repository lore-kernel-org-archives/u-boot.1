Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B66F4CDB466
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 08:03:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E31A84704;
	Thu, 25 Jun 2026 10:03:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NLHg+Cxo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7638484704; Thu, 25 Jun 2026 10:03:51 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 740A38493A
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 10:03:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c07ea058c1aso253523266b.2
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 01:03:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782374629; cv=none;
 d=google.com; s=arc-20260327;
 b=LDj600e+KFjoCWfLO1LdEhcyNYaNiiUP79XU8C+03lKXI5X3T1CqtHHBDWx4PV5Y1G
 746wtnGbFJB8d/cCxC6rHmPWcaUgMHTaRfn2rMziQk4kgO8zrFY1Jk1PsAm46SXaEZC2
 CMMbHZpMuD/CQZ/myEMLy9phFaHBi7fP62FWWKEjjT1hyOpGDwknIz3PVCc+oeLsULU3
 lsEY1q1DXwu2LREKy+VyN/30xm5XADA4RMhTowg9hOj7j75SG/8Hbfgs9JWSifHkwSvh
 YUDui0pAJbWjaHNNruQS/nDVG/UoXYGbGSpDD4AezWNDYfoNO3VYL/6J5wd1zzzIuIou
 oarg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=S1DGDKIu8m/bPLQCnMIt7B9RknqkFKR0Uc6etSH4vJg=;
 fh=ZKENcj3LLg7FvwzPCU8kb3oWCO29ckMXLdn+MUd0Y7U=;
 b=qaKjJSXgKhC8bCb4r9hk+5LE1utJZDsjSDpzrqb5fDm9VO12tKRidhQ5EbZGMdsySX
 J+TTgVSKL0yK/848at+X/yKhQ1zoCoAqQuyLXbbLhJot6mYVRERNsS2YqxvEhAefGQEW
 0ZeGrs+khCL171zF3mGfSopLOKrv+qXi5EdJWGPmB+rcKMycAC2+Hx9kB5yNIOEM0MR7
 UkqYw4mT7oWOXgODeiL6A//LBpTOh5XZY6FY21LA15RRI7fIAf90mcMVFl52U0Magqfz
 vExwJhVI1C8uusqfH9UDIWGKuvzIKkZdfXhm5L//et2vHC//p293tVjs2CIAwrGR3xyT
 Tjjg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782374629; x=1782979429; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=S1DGDKIu8m/bPLQCnMIt7B9RknqkFKR0Uc6etSH4vJg=;
 b=NLHg+CxowJjQ++o+gJLUDykPxI3cTXa0QHFPho8i2jHcKsDcEln1dgKYS5fVuUiq2D
 50KwGleK8ryhmYdv4XmuHxQjf1/Lk6CACGxthfDcAKMMurFDtRfVeHY2Rh4Y9SoCerFx
 VLn4RX29DLjeV7Sn8XtWbh2p3jlgGNIM/aHqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782374629; x=1782979429;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S1DGDKIu8m/bPLQCnMIt7B9RknqkFKR0Uc6etSH4vJg=;
 b=Ga3hJeKjtsuRDCsCuur1w4/e9+iGYLa2EIsOcQo3YjuZK2HjPJCoP+gdGFuElcOsh2
 uuhthkyuiBSMKQ4zkzIY8RE3ARpEG+DDd9bLYz/jCiF3NtJmuqGUVSleDcXl6wrm8aJ5
 sMH0LHH62ba1FMMhqPElf433tvLUiBi8uXTfT8bA1tOmbPvvJhqqCgWgBiDjEeh80iIB
 0EI2Fzc7Amxpk571SJHGBf7KujlZcczw2E79qBFte2XxTfDajqzIWErfU6n1F5GrEMMB
 o7bUGKa4DVCNa0rfqf155Xok4Lzpf1diYgtowVqYzKcf8oM1AC/cajXMP/aE1VnoisQ1
 XM/w==
X-Gm-Message-State: AOJu0YxxVShz4x12hjq+tRSVX0EDfhmuYQXnTGQppPyCcEbG1qpx2Fid
 B6/hadr2X1BgZUtQEay2OA6FCANMPBgTMWKMQGDGYE/3eGdQ3fgu6+K/sipI0atEbjKaAw87ZOV
 0yYJauq6zCTP9MjbYDY76nbC7d6JZk9xtBA8aZ3cn
X-Gm-Gg: AfdE7cmSnVaeaJiCLovpxiN0m2NwdLDRx+aIRu4xW1y5AyyGBFYKHmoli7YoHrztcfz
 Bgt7pk5m/Gi5PbqIqyJBFK1S0JSNhMerxL0eap+pRFaxTTQ0UvwN2ejJvQrlULdm1OyII76jLAN
 PkjTq83dfcfGBSgbyd9SjJ4tjQ+GLRbJIK2CfW06A/Rj8LL1sXu8QEKrtPfyHvXYjYmgdNpLt9S
 cdDAXmWSM9xj47tlbh4dKuMlo+0e1ehvMSeCA4mgBx/Ror0RO9BOULkKDthMChIdV30mgKB+bT6
 8AiUNxMP
X-Received: by 2002:a17:906:7304:b0:c0f:bebb:8fc4 with SMTP id
 a640c23a62f3a-c1205d8f440mr88658966b.4.1782374628443; Thu, 25 Jun 2026
 01:03:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260621143938.2863-1-aristo.chen@canonical.com>
 <20260621143938.2863-3-aristo.chen@canonical.com>
In-Reply-To: <20260621143938.2863-3-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jun 2026 09:03:36 +0100
X-Gm-Features: AVVi8CfwhlhGFcqGLGAKEvBAU2VC1qY71FNVcggMXbX5mVXEnquT-K_MAl3hpPc
Message-ID: <CAFLszTgvwfZ3fE2QmTBda3iS4rW6Dc8daPujDw+fG5uSBGOSTA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] vbe: bound FIT external-data offset and size
 before blk_read
To: aristo.chen@canonical.com
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

On 2026-06-21T14:39:32, Aristo Chen <aristo.chen@canonical.com> wrote:
> vbe: bound FIT external-data offset and size before blk_read
>
> vbe_read_fit() loads a firmware-phase FIT from the trusted firmware area
> and then issues a blk_read() to pull in the image, and optionally an
> FDT, referenced by the FIT image node. The source offset on the device
> and the read length both come from the FIT's data-position or data-offset
> property and its data-size property, which live on mutable boot media
> and can be controlled by an attacker with prior write access to the
> firmware area.
>
> Without a range check the resulting blk_read() can read past the
> firmware area on the device and, on the non-SPL path, write an
> attacker-chosen number of blocks past the malloc(aligned_size) FIT
> buffer into adjacent memory. Only the SPL branch routes through
> spl_load_simple_fit(), which hashes the data. The external-data block
> reached from TPL or VPL, and from the bootflow path via
> abrec_read_bootflow_fw() and vbe_simple_read_bootflow_fw(), runs before
> any signature or hash check on the loaded phase.
>
> Confine the FIT-supplied [load_addr, load_addr + len) window to
> [addr, addr + area_size] before computing block numbers and lengths,
> and apply the same constraint to fdt_load_addr and fdt_size. The checks
> are written in subtraction-only form against the trusted area_size so
> the comparison itself cannot overflow.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> boot/vbe_common.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
