Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB4C5CDB479
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 10:56:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5966A847C8;
	Thu, 25 Jun 2026 12:56:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bZtpkcrU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E71A1847C8; Thu, 25 Jun 2026 12:56:19 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDB768460E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 12:56:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c07c67ad9f2so197242366b.0
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 03:56:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782384977; cv=none;
 d=google.com; s=arc-20260327;
 b=piWNbrdeVXd9MIESYNFYhSk2SGw2V/KXxjbud0ry3+Spf2eAUVe1KwH4uyn9Ycrl/Z
 UMl9mFf8GOc/Rp9nTWGF6MB5DTnpGTehbgQSPz4OojJhMixo6dDCDrqeBumm7/i9ligz
 FWw33A1jsZcWeTv2WfuAnVKnnk1S74qyDiHhecx0uvkzuTh2B4A3T1OjxuqMYgeJ1GO3
 qbeVWxvwJnqXols3W62g1lpXrlatvtzN/ECD4hcaU9sUU4qEtHEbRfw3j0MAXDc7Ht6J
 TZ4Q2c3HMSODx7CSeqi7gvAirr12d1vaxnEOrVVW0phM/gck0dASPVzJKk7uZkCx50tn
 XkjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zYOaSYsUqNffsBKo4JdtQo7G1WkUHpEzDpmsGmbx6SA=;
 fh=hl+4EPCgakLOnk7XW3qrLoLdx2BF565tvPN7+O4zasE=;
 b=egpdw7YyOVn8W1QsE6QnLZo+dxvUyi9TFGN1p7i7d2TwlSnUCYiUlFXwaf0Il8IOfG
 SySmeUM/tCXFDX06HiEMRgQ9jVTGB+fiBVP66Aj5Jig9RZx75d9P1oZIspHLRZXgpuLx
 NYTh0FH4HGKnrK+8nwfvvItPB6y8Zy6Ao2ltt77VhXeSetLbKwC7AV73dzYKj9lpds6X
 1qvTecCmr8uSpf0xZLxA1XaxKyA/bJpBTjU+/xxgeY+/mcrdDs9vMnA3XvFefwCWnnj2
 YxUE8E7bsrCu8RnxiFSu34+SzAMrF0s3K8SVDDKnlaz6JIghkK+sd1Z6h6+v/30UsgiA
 dXqw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782384977; x=1782989777; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zYOaSYsUqNffsBKo4JdtQo7G1WkUHpEzDpmsGmbx6SA=;
 b=bZtpkcrUmXMUuxmO82bDPQJDWjHHDGxiS9VQQMAG7fcB+ru5dCvee81Z8r2bjE5n/x
 lj/wRzevX8fOG4E7zjLGogq024NYdDNi8wpaUzG6lWXOaZVbv0AyYjmWJb+34Ju0sRqx
 JNtiKVTzg33p3hWPP88y4yndaAlk3zWtxXcvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782384977; x=1782989777;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zYOaSYsUqNffsBKo4JdtQo7G1WkUHpEzDpmsGmbx6SA=;
 b=HBk1YX1B0MR5oPBqCDmeEvRBW5D98Bc2nEaBZuWTsA5fpdgVhtf9+OwSx6G8BLhqjs
 XgQCzty3Nh9tdzrV2gChM5c+hooERwLE6JwWpDX6gh88YlLP4tGdbxYePEsldGbkM1b1
 kUCYxXwGNOm0+UzfnG9zdyU+YLw1roOn4MHxy/bf/WNN4bHAFaTvAF4CMRgTctER5l1z
 3rKhV4v/DqOLCE/WPc6z9Z0IhgtLC41nRAVhAYqPOUda+bzPpXOeQXW/EVCTg293yUAC
 7kFjFWolI+VwQ2j9+A1gOhPqIHUk+BPPfWnl+5UbhT53NOQz9G1+VBLjgPCR3ysXf/64
 ibyw==
X-Gm-Message-State: AOJu0YyrRVFgdyhwp/cZyJVc/Rwccv42MtZ2s112TqgrYR/og7Ea8G6D
 pCLaqi6VBU6+Apf+QSlwSULRC+0X+BQDMcNh7mFaWdwQdZTRD/xfPaZuuIm/0TJopYDgUxCwA6g
 n/Gv9hTOFaTino+ObwqQI08DaEgDTfAJDqKPqISeszWwgCI7EcdkT/A==
X-Gm-Gg: AfdE7cl/cq310AH3YV/cmYR4KM08ukmiysZntm8FgX6a5EGlNwLrZbjakMAQ4iY/MW7
 /AqZo2r6CN936WBAUmSK+Ik2jIit10e/uNkM0VSjNAAfLTX2xpQbwy+TCakwAvFv79VAcF3gRZg
 jqQLBqVoMo9nj3fysLUPSl9ehi74dSOam5TrxmvJYqzJsVuhsNSXQ3xP7BZ8j4CV57DHJVcWDAA
 73X3c+70kjIN/PjE0EcB5zHOCxdC3k6AR7X4lvvZS3NFZejuPrEWyf13e7B3l6QXkF5JLYFiA==
X-Received: by 2002:a17:907:6c10:b0:c11:5a8d:74e6 with SMTP id
 a640c23a62f3a-c115a8d7715mr422742466b.6.1782384977362; Thu, 25 Jun 2026
 03:56:17 -0700 (PDT)
MIME-Version: 1.0
References: <3b2cd566-a043-4e8e-96e8-914d50b70133@proton.me>
In-Reply-To: <3b2cd566-a043-4e8e-96e8-914d50b70133@proton.me>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jun 2026 11:56:03 +0100
X-Gm-Features: AVVi8CdfB30N8gBj9zZfCNV1LG48BvFFOQcW0nMZCnQ5RqXo1FfgzN_FOb_YPho
Message-ID: <CAFLszThWcLd0_84CmHLmr8tyTO5-yRRnWO9KLN+GQpqt_NtTDw@mail.gmail.com>
Subject: Re: cmd: bootelf: executing ELF files requires variable autostart
To: Johannes Krottmayer <krotti83@proton.me>
Cc: u-boot@lists.denx.de
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

Hi Johannes,

On Sun, 14 Jun 2026 at 19:50, Johannes Krottmayer <krotti83@proton.me> wrote:
>
> Hello U-Boot list members!
>
> I have a question about the 'bootelf' command. Use U-Boot
> as loader for my bare-metal projects, but noticed maybe an
> issue when trying to execute an ELF binary.
>
> I'm not really sure whether this is intentional or this is
> an issue. Wasted a lot of time for trying to run a simple
> 'Hello World" program on RISC-V (both QEMU and real
> hardware). Then I looked into the source code from
> the command and noticed that currently the environment
> variable 'autostart' must be set, if not the command
> simple returns without any error or warning message:
>
> Source: lib/elf.c:bootelf():
>
> ---
> if (!flags.autostart)
>      return 0;
> ---
>
> Please can somebody clarify why 'autostart' must
> be set to successful use the command 'bootelf'?
>
> Thanks in advance!

Hmm, yes. The real defects are that it's silent and returns success
when it declines to run. It's also undocumented in bootelf.rst

I think it should run if 'autoboot' is unset - that's how bootm works
with ELF files.

Would you like to create a patch?

Regards,
Simon
