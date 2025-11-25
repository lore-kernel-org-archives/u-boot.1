Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0444D0E6E3
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 13:46:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D0E18404D;
	Tue, 25 Nov 2025 14:46:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Y4irmSZz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DE9C84035; Tue, 25 Nov 2025 13:47:47 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD58883FFE
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 13:47:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anders.roxell@linaro.org
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-8b15173c4c5so96666185a.2
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 04:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764074864; x=1764679664; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3YE2Gx5Jj/unP8OG3bXoD+LaVpVtF9QE6XlfxNXtnM4=;
 b=Y4irmSZz4ryI1nTL7CXRuNU3SEfDE1JlIJevDedoYfRx0ofQ/2NvxCRiCg6/YRlLMO
 /P8LeIvCbY4qhkEHY8sl0mw1HsteApQNCW5q1PY/s3EAFEqsSLA837shQCCdWNLITKFU
 O++Ls8Kg2RRNAd6/DLUxAF+RDY0U04F3Z7SR+B9iPJtufPxiaG2WVjEsrSnHViYA5GOu
 39iyIFztgxisBFMSu7ivZdo2qjUEWp5fnIA56uWnOXlBT4eY9JpUwup78tnXFuKuaByj
 c3O7Ux1aoX95910meDVtngrceVUujz8yEWPqIMW8t+wFxH13/G4CXixqSwTgAoml8gt2
 5gZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764074864; x=1764679664;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3YE2Gx5Jj/unP8OG3bXoD+LaVpVtF9QE6XlfxNXtnM4=;
 b=SrWAZeoI1TEW/Dyxk2sg6DCRekCy7wmarRiZ645GodAK7l8n7AmVQ+eV++MGkGFa2w
 d6WlltSDBuHbyN4pa+mjRv6HnlmdUWsMoKRCIJLy2Z1lbL4tVcWLpZYRXDkFDMsSzg8T
 NFBqczuEmevu1/VwB+XdOsYaO5tXnJjH9EnoO7540uG2PK8/Ckou+HMp1HRstKg9WsFT
 ZtWrjwaR2W7hIoG+Oqzbuj7dN+G7JOE2SXqhSKPUEOs2OVMpyH9pqJifveU8+7L/CQZm
 XFIOr/O1h8Xg5HUo6RVdIq7lzNKEd6dkt001vYLz4gaMloDfyKTxNxXVzNxICbKFHV0y
 yA7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUm8TdDF+0EhjvpEWjSeuqt+D/zyZTK+B44B1btHAUCYgY9fPWS1+CpYPNtm5AiELcwysufHQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yw2E9jqwzwkGA7fxQJEzbIHXax2/QAsHbkI+6aX4eSxlRB04FVl
 nGJaLHqvn26+z9/+M9GRTfWLlNPG5/p4NREOca8UxQmvndDAdgW1463G2NtkZPICV3cpNHA30Gs
 o6aKj+BmJiM8eG2pFsQRb8fg92iXBcIKZyUre5jtLlw==
X-Gm-Gg: ASbGncuWFJ7Ki7FMTlqOyE4GVUAbyKVu7OFmwTYQcNPnctdZFuz5cOJKQmwdP0GPktT
 MSt/1BzWgXSmiNLUVLXDXYvc/9ghZqCVhcuPVY65OPSiF7wMBFL/kQqnGT4sShQQpGc/lm/pRj2
 E7HhGgsG+FGVu7P/Fy0GYxXVvYKKqDJRlOMGghBNkkCBe8JZDpEcwT257RJjciRbGjitA2+NxDN
 xFw4pEzFG2P+iqmthD2RhOdsU6zfM+YdwWSBWXB0HvAC8XcFLnheVAwEEM3AIixQ4eizhGbIrmu
 Aldu
X-Google-Smtp-Source: AGHT+IHjeoBfdyogPZIQU0RMSwLIu2j0fCGTQZ4JLghZPGhE1DsBDOCNSQxo+0BFxuv+Wrd68NozH3Z2PrZiBBs/wMk=
X-Received: by 2002:a05:6214:2421:b0:880:4585:da69 with SMTP id
 6a1803df08f44-8847c5326f9mr173563046d6.4.1764074863661; Tue, 25 Nov 2025
 04:47:43 -0800 (PST)
MIME-Version: 1.0
References: <20251125102358.1850991-1-anders.roxell@linaro.org>
 <CALeDE9O4KOsRFsxZcnJxOVTzzJkn62k+bT=vgHa-k__qkjO0Yg@mail.gmail.com>
In-Reply-To: <CALeDE9O4KOsRFsxZcnJxOVTzzJkn62k+bT=vgHa-k__qkjO0Yg@mail.gmail.com>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Tue, 25 Nov 2025 13:47:32 +0100
X-Gm-Features: AWmQ_bmieKqVLykePaYPFgAc83qIsQug9eekl8WVKqgAqW_zzmEhYZkXPpAr6yU
Message-ID: <CADYN=9+atsqWkdBa+3jM-EhkNUyV-ZuJdtNqL6bZh6AsnkiSag@mail.gmail.com>
Subject: Re: [RFC][PATCH] rpi: Fix DRAM size reporting to show total RAM
To: Peter Robinson <pbrobinson@gmail.com>
Cc: mbrugger@suse.com, trini@konsulko.com, ilias.apalodimas@linaro.org, 
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 25 Nov 2025 14:46:45 +0100
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

On Tue, 25 Nov 2025 at 13:20, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> On Tue, 25 Nov 2025 at 10:25, Anders Roxell <anders.roxell@linaro.org> wrote:
> >
> > The VideoCore mailbox GET_ARM_MEMORY only reports the size of the
> > first accessible memory region (~947 MiB on RPi4 with 8GB), not the
> > total RAM. This causes U-Boot to display "DRAM: 947 MiB (total 7.9 GiB)"
> > instead of "DRAM: 7.9 GiB".
> >
> > On Raspberry Pi 4 with 8GB RAM, the memory is split across multiple
> > non-contiguous banks. The dram_init() function only sets gd->ram_size
> > to the first bank size reported by the VideoCore firmware, while
> > fdtdec_setup_memory_banksize() correctly populates all memory banks
> > from the device tree.
> >
> > Fix this by updating gd->ram_size after dram_init_banksize() has
> > populated all memory banks, so it reflects the actual total RAM
> > across all banks.
> >
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>
> Please add details as to why this is RFC? What comments are you actually after?

I don't commit to u-boot that much, so I wasn't sure if this was the
right thing to do.

Cheers,
Anders
