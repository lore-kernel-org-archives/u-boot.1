Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D3BC5ACD1
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 21:24:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 172E16085F;
	Fri,  7 Aug 2026 21:24:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PVgtcTJf9ugG; Fri,  7 Aug 2026 21:24:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DCED860806
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786137849;
	bh=FHjxwFm8udi5si6zihceP7trDodKUYNyPYvrOXxPPmU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XTckVpHvwJQ+ouaqCO1JoP2X8+bG/fa3GhE1kpWohdYnOb/sG9V09El/mkaiyXuGK
	 yo8LaDYvuP9XofauHS+hd9qiWsYzniSfxRDIaOGeUmO1RdnksIt0mY0+JCqYo9lhg5
	 0epYso03scv98NHBdmhYdK8sgBF2jmPgIJ8XlXIWFrQLA5StbaVB3AgY+9rdn/VBwv
	 zQeK8g4KS4UQUr84yZv7K8FDL/9VQlq5EiQZjXKZxlr46tmQLccJCTinELSsns4svJ
	 /qbHQrJD9rw212lzChCjihKmgbiSL+yDDXfN/yRF2ZUCKsCJTefZDL2L2KflpHzhs6
	 4hfIN8OTSAiVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DCED860806;
	Fri,  7 Aug 2026 21:24:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 30D602F5
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 21:24:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 17380607C6
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 21:24:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SV_I6QSDOlUa for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 21:24:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 477FD607CB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 477FD607CB
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 477FD607CB
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 21:24:06 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6a1542cdb53so3736036a12.2
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 14:24:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786137844; cv=none;
 d=google.com; s=arc-20260327;
 b=lwaGHTsmu6912b+bkob3ysnrBZFzSARfE7Eb4khucM+Duqtkn3vnDtMeCW9O8XYt8r
 rIATznxLBcxXoweLYCnY2XkiNScTIhxHsfa1Pvxmd09vgC0xPa15LjGynczMGvZs7GIq
 gim0EL2fnNL+KMMao/B7/al3exc79hkZ6OzYD9by4L1A3u9H3OdfEMXtj6wmnUONm0Mm
 Vo0lLefh4Z6GklrQ8d6/Ikf6Oz7yMJONlmWaIZ9uprGDk5zJNLM67LGvsocUHZeJwX7Z
 Ym2cbSsQM87xSewlat3n01JJ/5p+ZV4o5ihv3Aq3EFTTdusAvh6EAcC4zLl7oSg4kgfU
 lmZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FHjxwFm8udi5si6zihceP7trDodKUYNyPYvrOXxPPmU=;
 fh=ifHDF0qJYDepSS9oiYfTS9LBtTALVQAi2gjsfr4WdFA=;
 b=DYLzhCKC8v1K06UIcVXRZt4wJHL0qiybUP6MRT2CsnIW2lmk9/o/JmVGNXQHFSYExG
 agW/L8zDzLk+1+pARzJJlqKgrvDtZmS67fcJzTI1bi86En/l92kSK95cc5ZH2zCMUpUG
 g6Od+8OK3SkmLA4D+yGr24C8tHkjrcrGSfHMp39o6fvlHLZ2YgqXMMlpjykDnybcUh/O
 +W4blsALQkbFYz4JUrvo/f4u4tm/XRLXJousUAgLqpkJIBiuX5dRcTxbN3xM8fPfUuzC
 ZVQK0ldeiuUBfSfQPrzSatGoWIct7qu4RTHqqj7bT+NBaYR57VGpI4g/itqGnbG5d1/R
 ++MA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786137844; x=1786742644;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FHjxwFm8udi5si6zihceP7trDodKUYNyPYvrOXxPPmU=;
 b=a6JAV9R0FY0O4aCsHcN+y4hLXKaXJv0JqedpT7o3T3MyB4pfQJ7lPwyk15K3xDEUQV
 o4wVI1L/JaozEV47gsSPUTYdNWb8o9zr5GXawxS+4piROiz5XrlCKIEsFodHyqnyRGh0
 WEKOWvPatLUwK4GTlRNxujvDN0gf5yFYTODqZlGWG/xbK8HvVB5sU5xfAADKRo6FzvWD
 qSir3MfV5IU3l/TRnAWsy/fK+7ViYaBzV33Sn7B/OWH7WUne2y5EA0UnUT6ZJhkoJrKq
 A86SXYv0vYc8KrsLGRzxA3KphLUFlTd0onFKlXIfdyfHizs9ztRRwRzMkTP5HbguQoem
 mfww==
X-Forwarded-Encrypted: i=1;
 AHgh+RrihH+DTnZGfepExzQf/8EuaKFQIisyiCLLSBLkA54lWKyDIv/+mY5L/sn0aryDQmxV21Z5f4w=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzlXK6dBH09gxD9aieK7g6BUCd3XJra5ctpK7VcWw6cI2RpclPJ
 PFwMYJXoGb4pY4Tb1VEoT7aTdQmraQ50UGnHJd/KjF/50PDRB+pBoH3NbUhLRMByd3SIjDMnzbd
 Up9hn5N/u0RjIQLOuISC8FRvGbSxrD85iq/pLo72e
X-Gm-Gg: AR+sD11x7WmT82cDReIwdIOYWW72JqCFFGi4nkBYkz57xofZ97RjiDYNJwkEezOvtdI
 auvGxeoQKovgHIpatjhHVT4c5CqGxRlWYcq7KeUSPv9vXjtyxlmIjxjwqOYqivRvZVSOjuqQ7wn
 P9qArcn4X2xJMJVb/h1GLaH66oOv/IpkzOkJJXTKEDnoXhE+z34zNAus9tp5xXVdhgEVDe6Pt4w
 eWome6rao61Spv3hv8OtxZYg5SRENhFyBDiUWld6UeUJbg5YKgq+wVK0+tVhp3t8ZqkcTGaNkDe
 dzhrRhB+6v4q9MDA3MmpJkchSOegfM/ttgU2WBCVST4=
X-Received: by 2002:a17:907:7b91:b0:c12:764e:326 with SMTP id
 a640c23a62f3a-c2039d10eb3mr1046118866b.27.1786137844312; Fri, 07 Aug 2026
 14:24:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260807-qemu-x86-pflash-v2-0-f3896316eb66@elliotjb.com>
 <20260807-qemu-x86-pflash-v2-4-f3896316eb66@elliotjb.com>
In-Reply-To: <20260807-qemu-x86-pflash-v2-4-f3896316eb66@elliotjb.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 7 Aug 2026 15:23:52 -0600
X-Gm-Features: AUfX_mz9xoM_GmgNeH4o_G5VJOnHy8DehcZP183zU7W7OYiI2YkePxv_w-pZ7NQ
Message-ID: <CAFLszTis3580-r0-P8LaF=YR=vufBSRjEttsmb1JGnV5RCK5mw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] x86: Add qemu documentation for running as flash
 binary
To: elliotjb@elliotjb.com
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786137844; x=1786742644;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FHjxwFm8udi5si6zihceP7trDodKUYNyPYvrOXxPPmU=;
 b=O41XcfzsCm+ghdDd5SgStLMQdArPb4qTYHGaFmJyYeLUPT5fqlDSD1mfdVpHUnnTJL
 Tkmga7gv2TaMk71/i2E0zCnzg/IYqbMkdCuXR4x298AcSZGvFvnWeDB/ovZPyJqVi3Zo
 oQfI94Rz8dgQjVAxAjAEdg02XeqmAIRPOV1gc=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=O41Xcfzs
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Elliot,

On 2026-08-07T18:07:09, Elliot Berman <elliotjb@elliotjb.com> wrote:
> x86: Add qemu documentation for running as flash binary
>
> Provide guidance for testing capsule updates on x86/x86_64.
>
> Signed-off-by: Elliot Berman <elliotjb@elliotjb.com>
>
> doc/board/emulation/qemu-x86.rst | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

>     Provide guidance for testing capsule updates on x86/x86_64.

The section stops after launching QEMU, so it does not show how to
test a capsule update. Please can you add the remaining steps -
generating a capsule with mkeficapsule using the GUIDs from patch 2
and applying it via capsule-on-disk - or at least reference the
capsule-update section in doc/develop/uefi/uefi.rst?

> diff --git a/doc/board/emulation/qemu-x86.rst b/doc/board/emulation/qemu-x86.rst
> @@ -113,6 +113,23 @@ sure the specified CPU supports 64-bit like '-cpu core2duo'. Conversely
> +Invoke QEMU with:
> +
> +.. code-block:: bash
> +
> +   qemu-system-x86_64 -drive if=pflash,format=raw,file=path/to/u-boot.rom,readonly=off

The rest of this file uses plain '::' literal blocks with a '$ '
prefix for commands - do you want to match that style? It would also
help to say that -drive if=pflash replaces the -bios option used
elsewhere in the document, since that is the key difference here, and
that qemu-system-i386 is used for the 32-bit build, matching the
earlier examples.

> diff --git a/doc/board/emulation/qemu-x86.rst b/doc/board/emulation/qemu-x86.rst
> @@ -113,6 +113,23 @@ sure the specified CPU supports 64-bit like '-cpu core2duo'. Conversely
> +To create a U-Boot binary that can accept capsule updates, build
> +qemu-x86_64_defconfig or qemu-x86_defconfig with::

Just to check, is CONFIG_EFI_RUNTIME_UPDATE_CAPSULE actually needed?
Capsule-on-disk works without the runtime UpdateCapsule() service, so
if the intent is just the on-disk flow it could be dropped. If it is
needed, a brief note on why would help the reader.

Regards,
Simon
