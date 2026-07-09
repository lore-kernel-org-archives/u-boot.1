Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D05C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 20:20:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 065C984C15;
	Thu,  9 Jul 2026 22:20:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Sumn3C4e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B72B84C36; Thu,  9 Jul 2026 22:20:56 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCACB84C39
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 22:20:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-698e5859a3cso502762a12.0
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 13:20:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783628452; cv=none;
 d=google.com; s=arc-20260327;
 b=hsNSWH77EnyLwBI7jhQRRq2iWqJW0sLdEWV3NGJ51jskaxx73+5wOOXxjDhE+gu1To
 OBmh8yXwjpeRUEwbcG+Kv/yXuzPJaT4CaNjCfAxIPfDRG0K3242mgStYUkb7LXgBPnAh
 2zp8caZs4rfE3gL/o8iiqEp2q0JJhXI6Ee8CXUZUYSlK5nutM0QsJQquJQYlXMvHlxhF
 tWPflgKcl2zIZF0SJMt65+2V6t+4TqcHDzpE28ULpNhM9UQPBdVgEvt/Y8q/N35jOBw8
 u3HSy/Ze7LQpUnXXx+1UmYfw5ZjjrxF6j/qR7DPH4DSedagps3VhIuTfCQu+RiqwpQXw
 6X3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wriQCmqJnWM02ZV0NPy0J5CdpQFIycHxKvoLw1NzPbA=;
 fh=tan36dRLf1GAD2waOUw16naAL/I31vD3AOVyoUzw7XQ=;
 b=ZZByvslTXYzgZsTbb+nodqj5+c3rUZBRBUjoLAsd6xJDU2YL88GcrK0xWayWiHzfmb
 eNJqyrxzCYfe0pcZPcfqcRJ5qq9HxdSbGjBZDZxGjnW6cUzUIB8K6J2nWhWp4/pLOi7c
 BZybYCo09i5x+IotyA5pGf67GtgFuh3InJZZkoj4QR3TOKjRzSRGKEpihrd1YFbX7anb
 UCausekUHGHRAzcPDW0xPmFENTKQPNuz2cXPPOCnUR6IXVb+Yj4zGEX6AfmOeNHlBZL3
 WO7fXwaBff5phKr7gVicjOzI7ZHHZbi9GfRnpNUdaarIQqlDLvJwx5erWq+v2FIOXsZ2
 ZLPA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783628452; x=1784233252; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wriQCmqJnWM02ZV0NPy0J5CdpQFIycHxKvoLw1NzPbA=;
 b=Sumn3C4ewy1cJ+nipXAN5n/ODg+6KN/VJp4DROqJFKM7Cdl2iEl6er32X97pLZNTsu
 AXJpiRaPmt19sQ0r5sa34NvdYlDvoWRRyl4zLGL+9dnoJcdp4YIhXEozHT50t9adKg5+
 3Z6mBJoaw2Z0gEgfQN4cbqiM6GAVTzUiSC8aM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783628452; x=1784233252;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wriQCmqJnWM02ZV0NPy0J5CdpQFIycHxKvoLw1NzPbA=;
 b=WCNqN0b5DHvsAFBw/B72f3cSKNPRvo2F+5+dsxSd/dCf22iG7q4P7d/zIdjMMzhYt6
 gW5V2M8G/ARUmwhsnSajELg6Wt2BIAB4+95AN2kbnq1grXrqJFZwuqMBwwyNxBxcFUgU
 dIgzG7VXWWZKpe+7nAa+5T+FZ9E/az2LtOh3BHMsPZPR3ZTz13i6IHcwtIUIsJ+pT4At
 aauPjZPznmEvTLLjp/FQRWicWTQkV0YfiC9CXwHO9JHt3SVZyUYLG41sepf8GYGjDHBq
 M9kTeYS/+6zy75wsAv2nIHUthi3rfDtcyyAAEQtWT8mdTq30JZileX9Tom0omQx1Acdo
 hBvA==
X-Gm-Message-State: AOJu0YxLdLSzIYT3scwk3m2gg+vARwB1NXyxZR5+0lHIDpN8TrSwjbak
 3LJiSNaCQHflG9L4zPtAhNvPQ4cmIDUFLekIbn9jnm0YO3xjdICB3tgt7qDI+clSblPqL9WQ/Ao
 VGwPdX53XGhzMNTykAFoobpy8NvJbdOHGSyDz3/6giyFTFqpR9TO8gQ==
X-Gm-Gg: AfdE7ckJ9AFapr42qIGdwE1oTYw6PJ3ufczmx1V5U/R2OBPr4cqlQiCp0Euca11mOM2
 rveKIYI+0HGDN80+NFEeNtM+W7vu9kulgwg0OfZ3jTvdB2AbAazc7ccZP5OSHt48uz93WfEPp48
 JSsYdh5Yrfxb9AbYXdk+F10lHa6NhuOjxsDIvwbmSzkaSIWcDywv1WB18+1pivxQ6a15DTE9+S7
 iqgCFBfOK4ELDSL0OwrMfShHJ1KWsFTxQ6VTddF7TYIJua9qMDe5G7abUU2i/CqzCms56Q=
X-Received: by 2002:a05:6402:5411:b0:698:1504:bb22 with SMTP id
 4fb4d7f45d1cf-69c24f9e59bmr343661a12.15.1783628452188; Thu, 09 Jul 2026
 13:20:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260706-ccaione-upstream-ebbr-v1-0-e742cdd6abe5@baylibre.com>
In-Reply-To: <20260706-ccaione-upstream-ebbr-v1-0-e742cdd6abe5@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 9 Jul 2026 14:20:40 -0600
X-Gm-Features: AUfX_myDXV7u_BHh72LfWSA_1WfVyEdJccqKeMzE6IF0xCSSN5Ym5z3fRBLrheY
Message-ID: <CAFLszTh5R2XQ0nB_a9HphsNcUwPeaC6CObf-Q9+BUxB7XZ1A_A@mail.gmail.com>
Subject: Re: [0/4] bootstd: firmware-owned devicetree for EBBR / SystemReady IR
To: ccaione@baylibre.com
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

Hi Carlo,

On 2026-07-06T15:06:41, Carlo Caione <ccaione@baylibre.com> wrote:

> This series adds a bootstd-level facility for sourcing the
> firmware-owned devicetree from a FIT manifest on a dedicated GPT
> partition

Thanks for working on this - a generic replacement for the vendor
dtbprobe-style commands is very welcome! Herewith a few general
comments.

The "bootstd-level facility" framing doesn't match what the code does.
Nothing plugs into the bootflow iterator: no bootdev, no bootmeth, no
bootflow, and the only consumers are the EFI bootmeth and
efi_bootmgr_run(). Shouldn't this feature be more general than just
EFI?

> the control devicetree points at the source: a 'firmware-fdt-source'
> phandle under /bootstd referencing a 'u-boot,firmware-fdt-block' node
> under the owning media device

I'm a bit nervous about adding this into a media node, but if that is
what your binding ends up as, OK. The other way to do this would be
like VBE, which has a node in bootstd which points to the media
(although it does not include the full path, nor a phandle...

> - both EFI launch paths consume it, the EFI bootmeth (disk and network)
>   and the EFI boot manager, all funneling into efi_install_fdt();

The two consumers (distro_efi_firmware_fdt() in bootmeth_efi.c and
the new block in efi_bootmgr_run()) carry near-identical staging
logic and log strings. Please factor into a single helper alongside
firmware_fdt_load() - e.g. efi_stage_firmware_fdt() - so one place
owns the staging policy (fdt_addr_r, size cap, fail-closed vs
-ENOENT).

> The 'boot_dtb' environment variable may pin an A/B partition number.

boot_dtb seems quite generic - it reads like an address or filename,
How about something like fw_fdt_part so it lines up with
fw_fdt_config. While you're there, both names deserve to appear in
doc/usage/environment.rst

Regards,
Simon
