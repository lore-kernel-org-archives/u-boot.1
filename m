Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBEEDC35FF3
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 08:35:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8144A8058A;
	Mon, 17 Mar 2025 09:34:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="lZAy1dYO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E57A81B42; Mon, 17 Mar 2025 09:34:51 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E3CC8198F
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 09:34:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DE50D3F1F3
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 08:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1742200488;
 bh=jJ4PWfVJ6csHp42GMQw4WcRmm5dJt3S9jMwdkG0Fk98=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=lZAy1dYO2w1g+U+zIUsxxnj8mechVpRpLkq9+K5qj3PCd7eYbOO/otyVXHohiwj+g
 46vBYdCa+kyHEY1T+TR4grYqp5XsqyDAokju8O+kU/v389FUNW4v3HZHyRtFrHmEz4
 8XOURc69BpXwkq0nOlPS/iBkfE8BP2HZCf+piMsKcYm9Yg3yvIQY5eVRb1d4PlLFHr
 jfMjkEZYL0ucHcwllxpY3gmevmKfFMPZcngLhkXRz7lVsbdpO0Iv2tIxK2W6/07F++
 n0NrIdGAMYrq8JGqxuw1OkQDKr0SxIvfeAXEYdniPIdCKFu2iEimIg7nNWXVa165qv
 dZ6636E6QED4w==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43d025a52c2so12976195e9.0
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 01:34:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742200488; x=1742805288;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jJ4PWfVJ6csHp42GMQw4WcRmm5dJt3S9jMwdkG0Fk98=;
 b=EB2/0QQb64XNR4JdwJBdOUBfcyjRLIdyi+GEKMEEEFqZmcTJ0iDTJfrRWEcZgg+iPp
 T8ng/0OrfZ9bw3/LnDZP0bPhsA0QxrQ6G/3+gyQqGvTYajuTZvD/Iz9z0/hHbJK8puP+
 xmXEXyRvX3niMmJKUoqcU7SICcgbaxDa7lqybdisSEiAzbDk83lwr0TjOmA+r2vP1U5A
 3TMY4TEzqfPdtyfOEoFfBF88zzeC/mou9Mzf4hIKUGntNFGPvMt0LJbdUdrDs5nS972i
 X7778a0KSHP7YHP3+WhaNKbW+3SnoadsYND9blsWgnX76M3pvAK+Iw9kBua4EHvKYCJG
 mCKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrXZ7kiNNvVrchf+Jcmvby6oDzAyfcx5Taa78crin0cVM60H0xTFwo6k88oxYVdtKIMyr9jWs=@lists.denx.de
X-Gm-Message-State: AOJu0YxPXZH+f7yyWt8JI5ZdyF0DXtIFMAxj4eBPTh97UFwynBVu3kqJ
 6G59pxf8tj3iz7/ToIcq/HyLnFLir81uePvEK+KsOwJM0ukR70siPCDIaeZz5ookQRc4QleCuaj
 tbzWdivzayJZRjPM2/5rSrgV0auHhhdkj4y+ftw20XuqyCvD+GkNB/KB/8m9g79YqS28=
X-Gm-Gg: ASbGncuT8k2/5493xVSZymdmFWbbM4GPQurZTwhs7JgHmuv850QJ0S+ovdi+CiJMeVJ
 5/bzaiezavL19aB4OCzM8Pco/5ZM1yn5TM5cmhCcAnnyO1K8KVB+9gcbnmAAbrezliQey/+WWpF
 UL3f7ntNykXzYMJf08ODfm1AFplymdeLM24dER5sNAlDmnOKeGEwtySv8ebBLUknPXIgpEg+n1L
 73KIKYCGRpCmX4wflEA4z2uyNdnQL4AzgMtQ8+IK82WBMFV6rPyIEMhFVmF/+8qehuWFP/ajz6V
 /weyKOCZuFMRVO738QvnOwfu6GLsI++OyrbZ1XBrjfkoKBrpgFY6W1geH/ovSu5ftK2FI0f9jcB
 TH/cVvA==
X-Received: by 2002:a5d:6da3:0:b0:38d:dd52:1b5d with SMTP id
 ffacd0b85a97d-3971d03eeb0mr10068148f8f.4.1742200488510; 
 Mon, 17 Mar 2025 01:34:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGS2n5aW7fSPFP0Igxe21IuKzRgiN8r3S45YWTvPdir5hq5UYI8IoW2d2ZJvJV3ws5kougPQ==
X-Received: by 2002:a5d:6da3:0:b0:38d:dd52:1b5d with SMTP id
 ffacd0b85a97d-3971d03eeb0mr10068125f8f.4.1742200488183; 
 Mon, 17 Mar 2025 01:34:48 -0700 (PDT)
Received: from ?IPV6:2a02:3035:6e0:e0d6:c240:5c59:d1d3:8b07?
 ([2a02:3035:6e0:e0d6:c240:5c59:d1d3:8b07])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c888152dsm14013982f8f.48.2025.03.17.01.34.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 01:34:47 -0700 (PDT)
Message-ID: <ce544fe6-73bb-46fc-a584-72a24fef96f8@canonical.com>
Date: Mon, 17 Mar 2025 09:34:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/15] efi_loader: Move .dynamic out of .text in EFI
To: Sam Edwards <cfsworks@gmail.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
References: <20250315221813.1265193-1-CFSworks@gmail.com>
 <20250315221813.1265193-13-CFSworks@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20250315221813.1265193-13-CFSworks@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 3/15/25 23:18, Sam Edwards wrote:
> EFI applications need to be relocatable. Ordinarily, this is achieved
> through a PE-format .reloc section, but since that requires toolchain
> tricks to achieve, U-Boot's EFI applications instead embed ELF-flavored
> relocation information and use it for self-relocation; thus, the
> .dynamic section needs to be preserved.
> 
> Before this patch, it was tacked on to the end of .text, but this was
> not proper: A .text section is SHT_PROGBITS, while the .dynamic section
> is SHT_DYNAMIC. Attempting to combine them like this creates a section
> type mismatch. While GNU ld doesn't seem to complain, LLVM's lld
> considers this a fatal linking error.
> 
> This patch moves .dynamic out to its own section, so that the output ELF
> has the correct types. (They're all mashed together when converting to
> binary anyway, so this patch causes no change in the final .efi output.)
> 
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

> ---
>   lib/efi_loader/elf_efi.ldsi | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/efi_loader/elf_efi.ldsi b/lib/efi_loader/elf_efi.ldsi
> index 190a88fb69e..4fa5ca43872 100644
> --- a/lib/efi_loader/elf_efi.ldsi
> +++ b/lib/efi_loader/elf_efi.ldsi
> @@ -21,10 +21,10 @@ SECTIONS
>   		*(.gnu.linkonce.t.*)
>   		*(.srodata)
>   		*(.rodata*)
> -		. = ALIGN(16);
> -		*(.dynamic);
> -		. = ALIGN(512);
>   	}
> +	. = ALIGN(16);
> +	.dynamic : { *(.dynamic) }
> +	. = ALIGN(512);
>   	.rela.dyn : { *(.rela.dyn) }
>   	.rela.plt : { *(.rela.plt) }
>   	.rela.got : { *(.rela.got) }

