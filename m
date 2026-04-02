Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32B7D6AAF0
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 16:35:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DADC83F7D;
	Thu,  2 Apr 2026 18:35:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KTCY8jy8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB22183F7D; Thu,  2 Apr 2026 18:35:31 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB29A83CF5
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 18:35:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b9b1ffbb9f5so125486966b.2
 for <u-boot@lists.denx.de>; Thu, 02 Apr 2026 09:35:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775147729; cv=none;
 d=google.com; s=arc-20240605;
 b=cSv5Dp4Sobs1ccZGwzgsVvwgl+TWtYn8S3j3UJnK/HH+a4t3eWN3WXGtD3DcS3IYJK
 pwpT59mYTTM7FDvrdkSAW8CqPqjNlFr2iQDak3URDLBJXD+Vt0svsaf/uY5quBo9+SmK
 IL5nWuGYPqxqAfNxnh0r5qWr7YDjS9YhwETLzTbxX8j3gWKkwG8sxKzppW6Cxhm1FVr6
 Oe94kNj/Lo52qt+Vl5qDaobdU2wwaa+f0LI1QKxKPOjcCdvTOCwND17e+aIkH5hMMlw8
 scfkuSJnPZbR+DdXusXbvKZ0QCgfE69QQT8d9kFXidpMYP0Jl0o3IsU+0FOH5vJmKH/e
 hAfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=3ewH0rV0NlXGvz0+3iSSPIwWkUKUqKoO82RzgoU86Jw=;
 fh=VIfaBiW5eXM/edC4VfIjOUOvVeYqKLo+EGOB9mnDypQ=;
 b=E7hKEOyC0fVtbojnWvNqDkj392EJ7vKxxJsjsJp+KcTT8mn1Vy8P2oP4PWX6bRqJ6y
 Pnb/K0IKuVPLzEX/ZvrkEvoNWp2zZ5ZCr/jMuObPimxgQihsu9U/S2vmJQ8R1EJ7/zg7
 L8LobdX+0ze8tV+4eoLaijfEiBhu342ctsm0wvOrgAjpzP0EAhei/EIkgrYBKhFlLunW
 2SmQD7rnAQ3wjHMjmF+LJ6pNDSd9MhiA8aVNR7c0xPNVAj0Y4iksS1h+iOYX79DCUv3U
 sv5zxEWvoevVZkvG1qT+a7XPH6nYaKcDBk5R4Lf44qlovQo9jfQwMojZfO+Yv2RAWqi6
 hHjg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775147729; x=1775752529; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=3ewH0rV0NlXGvz0+3iSSPIwWkUKUqKoO82RzgoU86Jw=;
 b=KTCY8jy8BdMj2c2JImX4JrpJcfmYqf4VU0ZJOmukbpupO29lDRsMVBuYte6H5680gO
 Wqy1u8qriKaCRULz2yQJBbvqJnM9/RORLX+k8dDIIrC5q4ZnqyhrCFftkAIqszCV5k2e
 01Xj2nwLDi59TZMxndGOYZ7wCVO0nManMWrFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775147729; x=1775752529;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3ewH0rV0NlXGvz0+3iSSPIwWkUKUqKoO82RzgoU86Jw=;
 b=hhNsWeh4gsBVnYWVotqoVAENiD+mYerYgj00/l5G826AZ+351EgEKrnXqMooyRRXW+
 CQjS33BqwZyw8k+w3glBpEVXkfj3QOhYfMBW3/6DGmAARDPkmolT1KEmwIWruCn7w/di
 RYm7Cm02yAEAohp17sEUNKv9039c4A3KL5FcPWI0o7t1E1fR373BDdUD80mXYTFl4gZ5
 vdSlObOYzOl5vXgYJHUq5nZ3V4AckYz1Bp42MVkXR9ROv21CR9x+40hE/cu9cJOvbj3Q
 mnY8LXTyqsEZFe2c2b5pxANpWxttiHkkqtPNDrQSA+RpTQ5pdaIZVcdrW/knsUlSjHJr
 wyDw==
X-Gm-Message-State: AOJu0YwX1kIJfo1mDE88P/i8iGdPK0WwTs3Y7UAIvFtRMVU2iZS93hky
 rcQQzlfeZAcwOcIksXrZ14EtK69TF/sQ5i7DUdzN/Gm0I9rdEnlYbykcvc5tUpJPkJiAizIAsxM
 u9zUEaYr6qZ5l1HRujGpz3uwN/sG9/kJ58+/LMbvsRpCe16j3KtQ=
X-Gm-Gg: ATEYQzwiJ0otreSDQ/mvmSK9C5R8ovZpd707+SgHmSIARJQ+d/P8jKrjWUOIQ13PUPP
 15VjG682LPA36163Xe+r2iCcc/cObULzearYIlRsvOcpgNms3rPITev5BSa4LnF6dBkcFmTE4N7
 RrJA2A56L6xC1gJEsGs9/0xiZc59y47VsYTz/BCmW0ckGRoa4tlZQvNEXN88Ko9N0o5CmL5rX6o
 AGetgi0c/PkhC+sStq71o+Bx8PzOpTGmauWodOzhyVHVgpHs087DBbCVAzzR5f5/4T1kcUi7IAy
 of/4Wg==
X-Received: by 2002:a17:907:e112:b0:b97:a9ac:5e05 with SMTP id
 a640c23a62f3a-b9c3f195df6mr140958466b.35.1775147729224; Thu, 02 Apr 2026
 09:35:29 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Apr 2026 10:35:17 -0600
X-Gm-Features: AQROBzCELz-50mnt8SErafx3BghxX1uDrkkiXRZovi4RIda_nbNZ0yJgkI1QHZM
Message-ID: <CAFLszTgv0mG-Hybw-TosHrtwX=T=mb=RabFFwR38t1wtTAkSjQ@mail.gmail.com>
Subject: Re: [0/4] fit: dm-verity support
To: Daniel Golle <daniel@makrotopia.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Daniel,

On 2026-04-02T03:08:27, Daniel Golle <daniel@makrotopia.org> wrote:
> Only the three user-provided properties (algo, data-block-size,
> hash-block-size) are included; mkimage computes and fills in digest,
> salt, num-data-blocks, and hash-start-block automatically

The .its example contradicts this statement -- it includes all six
dm-verity properties, not just the three user-provided ones. Please
can you either trim the example to show only the minimal user input
(which would be more useful as a template) or just update the text
here.

> 9 files changed, 1215 insertions(+)

The series adds a sizeable new feature to both mkimage and the boot
path so it should have tests.

See test/py/tests/test_fit*.py - for example test_fit_hashes.py
exercises hash computation.

Since you are adding Merkle-tree generation and cmdline construction,
a pytest that builds an ITS with a dm-verity node, runs mkimage, and
checks the resulting properties would give reasonable coverage.

A runtime test is harder without a real fitblk driver, but even a unit
test verifying fit_verity_build_cmdline() output against known
metadata would help.

Regards,
Simon
