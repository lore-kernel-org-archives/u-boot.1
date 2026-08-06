Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B887C5AC67
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 21:15:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 156D240877;
	Thu,  6 Aug 2026 21:15:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BFnSUxdDGRDZ; Thu,  6 Aug 2026 21:15:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2AC2640536
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786050936;
	bh=4PI7cp/7lOJ5TpdgkNkT+H5brGY3zlRJ3Eo3WKO2y5U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ww+v9spL+7j3YPprjjWWoSo/2LE59IACvyzAlexyVYTBM0XNR7Mu3d7txqtc2gWgk
	 /vP0Zw2B2KsJyrWzEfeNXPEZROdDKsvoCTDwlilV45+bmBwtGXYslGKDIed2/ws5Jm
	 PMlu1Ivo1x8qK1/Fqz/mpTk5KI8OKCbA6YdnXTan/PYDkm5b2/t9ptThzbb9CSwocb
	 yhf+K0BJlGVuFuQCjQyZQ+KM2S2vt7ZQ6va/mH2zjSwBe5JP72YstAEBVM73S6TY6t
	 Nkh/4tlGS691Qqtf7p7gpj0ni2e1y5TcgU92IMAUdQ3MEDqUixxmxePWHSmG7oXOWI
	 PAusamZMmCg9w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2AC2640536;
	Thu,  6 Aug 2026 21:15:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 567A5218
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:15:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3C5EE40536
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:15:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ks-m7ucFw8xj for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 21:15:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 361304080E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 361304080E
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 361304080E
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:15:32 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6a18e24ad25so2000258a12.1
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 14:15:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786050931; cv=none;
 d=google.com; s=arc-20260327;
 b=bjaofxyVXFev//wRGdIa/HjmSdDiGoo9CTfinbFDBfLTt1nfEk68+tdCSZFSDIvyif
 VCrNEv4UfrFSxmt/lbGovOjPZ8/KV1GATChlAez7/qWFJ2F5y4xYzOsDqWD21/Fc0zFh
 amy7g4Z3fJpmGX/MzOYzshgBae06Nyn71XNZEy/JaXS4V9ewp5/9gtVxAghc81Irtjag
 8Jd8bkMV+UMFuxnb9Gm81NMvO2m4/Sam/0neUGdfD4IecCH8nZaFxQRY96lfXCUpkQer
 1Mh7XDaAQURARESuTU74TSGpJ+YzTwfNEbixWbfo7d//n/gZsW9O+t+MFzRk/FakUafD
 gonQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4PI7cp/7lOJ5TpdgkNkT+H5brGY3zlRJ3Eo3WKO2y5U=;
 fh=Ye9d8c9UuIgjdEYE5AmpFdHtipkFyQbZju95WIBagdg=;
 b=F8ulIKdp+WORJl32bU6EwQnY18kfEPZp/JG/rF3H1RKtpzaALpforf0TONAZw+A3fx
 NMC4Gmi3S1CU4bVraZfXPYkew07aZB4p3sV+DB2/xaFCzIdKOM8XXJmCXXruKx1cc+Jo
 bfireNMQ7BuqeuBkgKXNqOKRYT4gh46sfvOh2LBDj7uCLe1f6VNN3Vpr+6jZ7krAC6Ju
 yLmyeKWzvvRzB+srcVc8JQxhZG21jr8HvlUd67tJUVAagjExIYVI41lWGzb74ORaBj2m
 F5Voj9BUHAIf7cRFns+bZHScMKJm9BL/Sb7mxQPDSMghxz+ZSKS/balrP4uUopkcowqD
 rlTQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786050931; x=1786655731;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4PI7cp/7lOJ5TpdgkNkT+H5brGY3zlRJ3Eo3WKO2y5U=;
 b=arWL0NO++5197lpu3mtbS0E0ecQWdQZ/NrD8qLHOjB7cSebOzD6ZZme4PNuhIdCKKN
 YW1j4Qb51GTaO2A4GbQHjaG2YOOMXPIenJz06+CX0hx4AX4pkUFcQ39fDTjvLojfRJIl
 JV+eQFYZyq+OAZpMUTnBusXoRZg8NqiFi8pvODFl1FhsEMYUjEqE98VESqRAjeL4TkP1
 SJxW3liDocbei8Zi7Vfkawt79xkN+AdRyloejZUi9yCszL2IllM2Pka6oA4MIkcX1uvl
 QVt4er1e54dSIZuFOiwOcYTwwYCQ0sULP8GXtU7ghItdPOSePvaWixSUQbJR+nj0+VLf
 geGA==
X-Gm-Message-State: AOJu0Yx467nxm9fJrvVqLYCBs+lAVQVJnxltxQDHatGofY6gbmX5RzEb
 CEGEWTxLlHJfefPosTnMRLZZSYa9WQBoRZwB0KorDl1iCb4XCSHkwBZeBYU3v+lK0TKQViV1udc
 QOwQiBB5Fw2+hvErGIJJ7OyqJgcSO+BqMrWOJok8piGYFp0ExW6E=
X-Gm-Gg: AR+sD12Jh/Txm6t+uvh3LqxGi1jBnFVUTLaRbnXM2QHpWdqACw/0DSOOMswwwJKcY3C
 lQq+wccOpWWneNaht2NiDf7Sj9NmjiU4Lf8ztZU/tAvFJAj0Wme4jxetqdD9pRd+rbdkUISwJ0b
 KofYxgoHZQ1u38k4/Y8I1ecYIrAao/Lxi+ofEIMDCqV2D9u0bd4BC8q0yPt3e6nz9w5pQ7AFsEW
 ANzgI0ENGKt+A7NBDm0K8rsNJ+8pDriAMCEMg3xX9Lxfq8GoxT4jheuws9sUgvqSP9uhg3/ANQQ
 uiK7BnGjakIkqSlb+/2mRGcv/lC0damhB3BKicQ6oO8=
X-Received: by 2002:a05:6402:50ca:b0:698:3469:fa99 with SMTP id
 4fb4d7f45d1cf-6a14effe17bmr9327725a12.0.1786050931099; Thu, 06 Aug 2026
 14:15:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260804-am62lx-v4-0-01746157643d@ti.com>
 <20260804-am62lx-v4-11-01746157643d@ti.com>
In-Reply-To: <20260804-am62lx-v4-11-01746157643d@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Aug 2026 15:15:19 -0600
X-Gm-Features: AUfX_myNxDkxL0waqWFpq8r66eR6DJw2eWfqyTyQCykRXosYXWnohP205quAeuk
Message-ID: <CAFLszTjsUWpVb7Ra7_Bf5O-pG9F=Pj-L=gyhqWArZaO+YJ2LtA@mail.gmail.com>
Subject: Re: [PATCH v4 11/11] doc: board: ti: am62lx_evm: add initial docs for
 the AM62L-EVM
To: bb@ti.com
Cc: u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786050931; x=1786655731;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4PI7cp/7lOJ5TpdgkNkT+H5brGY3zlRJ3Eo3WKO2y5U=;
 b=ERcJEEe179qJeDOlVuLLSG77eIu5K5SMN08SGfPdWkjhdhyC0ta843pRhKykaJv4zj
 mb9G7ugDHi9P6Nld4tGVaxDGPlDJlrsanLFcXoxd7w9uA+GjWvmH8YYTDaOSd7SUlo61
 SQYVm0wYtEaxVxw8ROLoNV8OJUhnVRnxaonag=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=ERcJEEe1
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

Hi Bryan,

On 2026-08-04T21:55:02, Bryan Brattlof <bb@ti.com> wrote:
> doc: board: ti: am62lx_evm: add initial docs for the AM62L-EVM
>
> Add the initial documentation on the bootflow, build, and deubgging
> procedures along with the relevant links to more information about the
> AM62Lx processor and the reference board.
>
> Tested-by: Anshul Dalal <anshuld@ti.com>
> Reviewed-by: Anshul Dalal <anshuld@ti.com>
> Signed-off-by: Bryan Brattlof <bb@ti.com>
>
> doc/board/ti/am62lx_evm.rst                     | 222 ++++++++++
>  doc/board/ti/img/am62lx_boot_diagram_phase1.svg | 450 ++++++++++++++++++++
>  doc/board/ti/img/am62lx_boot_diagram_phase2.svg | 525 ++++++++++++++++++++++++
>  doc/board/ti/img/am62lx_tiboot3.bin.svg         | 170 ++++++++
>  doc/board/ti/img/am62lx_tispl.bin.svg           | 222 ++++++++++
>  doc/board/ti/img/am62lx_u-boot.img.svg          | 143 +++++++
>  doc/board/ti/k3.rst                             |   1 +
>  7 files changed, 1733 insertions(+)

> diff --git a/doc/board/ti/am62lx_evm.rst b/doc/board/ti/am62lx_evm.rst
> @@ -0,0 +1,222 @@
> +The AM62L is a general purpose processor, however some of the
> +applications well suited for it include: Human Machine Interfaces (HMI),
> +Medical patient monitoring , Building automation, Smart secure gateways,

Stray space before the comma after 'monitoring'.

> diff --git a/doc/board/ti/am62lx_evm.rst b/doc/board/ti/am62lx_evm.rst
> @@ -0,0 +1,222 @@
> +However because the lack of any MCU cores the boot ROM is located on one
> +of the A53 cores which is responsible for loading TI's root-of-trust
> +firmware (TIFS) along with a BL1 image generated from the
> +ARM-Trusted-Firmware repository. The BL1 image is responsible for
> +initializing the debug console, the DDR controller, and speeding up the
> +A53 to it's maximum allowable.

'However because the lack of' should be 'However, because of the lack
of'. And 'it's' should be 'its' - plus 'maximum allowable' is missing
a noun (frequency?).

> diff --git a/doc/board/ti/am62lx_evm.rst b/doc/board/ti/am62lx_evm.rst
> @@ -0,0 +1,222 @@
> +For the second boot phase, with DDR active ROM can now load the larger

Please add a comma after 'active' - as written it reads as 'DDR active ROM'.

Regards,
Simon
