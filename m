Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60FF2E63FE8
	for <u-boot@archiver.kernel.org>; Sun,  5 Apr 2026 12:02:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6F9F8352B;
	Sun,  5 Apr 2026 14:02:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FRcbHKp5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A3898394E; Sun,  5 Apr 2026 14:02:40 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 175EE8341A
 for <u-boot@lists.denx.de>; Sun,  5 Apr 2026 14:02:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b980785a0bfso398449766b.3
 for <u-boot@lists.denx.de>; Sun, 05 Apr 2026 05:02:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775390557; cv=none;
 d=google.com; s=arc-20240605;
 b=KMv34+K5Pz8I6VGY9jU/1e3VhZVX6eh/Pjd/gfoN4DqOWbBy6hj81lJiYkFwZn1kUJ
 H3RHBDeDhF40W2mCJUQVgn8duDu7ZOI+eznGWHxWnRTfKGdj/B3lP50fyNAmgKgEgOda
 6n19CSMKXiILkQz99YRRGfqJmL3LA1zZZPh5OeH68emhKlqvgb0pQfV9rbFlZFXR/PXv
 lOSNawdn6aJFxC2gYLTYiFh0cXNzynPSNKGp7Q5a9vpdLWT9fegLWhSsfqCmMPkq1arz
 Nd+smpoWb9uypc7wbg5THJuYGSjqOu306eIRqNtE0PwLauh+y5ies9Y0LnArwif6q6zu
 2Rpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CdYkTbRD9uP1oFykSEca344H3nhGE8/y2IqBzpkGhL4=;
 fh=pFMYuUCQS2Qz6N1SFX5dob5zji0yi5jFd5G7HT/pODk=;
 b=AR3aiWT6CmEZpuQIm6iu+145nFNvH2aTN2QjJ/LI5cn0eQ/H9HhOH1UvRNy7nEwIbt
 Rp8n5PX0yWC0rwOrwGBkt/f1/lISJTy1FzZYbzcY+e3NCwfgVWuloUL1Qh2n2F13SLRZ
 DXwCPRldf48b8bSJ7O/GunY3Latz8sJg7Y2PsHVnoaJmSbRNw0YaYxz1IhxJC3HgKczu
 1x/FFpVKuxtybWHpxd5/xMmdjcULakwhX9M8o2U88e8w+JmXvx2Y99s09kUfLO6MNgw4
 TqcpOa05fsQym3R9sldkBAtfKlhp03wzZFv4RQCq05rfdcd7xxV77bBMJree3HB8kQ39
 pcIQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775390557; x=1775995357; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CdYkTbRD9uP1oFykSEca344H3nhGE8/y2IqBzpkGhL4=;
 b=FRcbHKp5e3y7D4MFqfL+tHtEt4EkWILJCtUyluo1lh0dKyQlcQXhhdOJnM+qqh7qip
 d9psFiG5DHU2jdYx1s0Dz3X3zJAGBgHElByB1bxywSoh8w8Mr+WOGERdaD0tXKbCUFCb
 Ist/zFSmk7NBX/8Zr7wgLi0Xjv8eAlfVQvCLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775390557; x=1775995357;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CdYkTbRD9uP1oFykSEca344H3nhGE8/y2IqBzpkGhL4=;
 b=JIQ1EIECfF66iMNtOvlJ6voaC6J7GqcVZA/jlE3Z9L9uFl5FCSBkuYBXXfC+ueEGUk
 NPJBxPlv1Fa6635drXHca6zTL1ga7tWnVNOXDZ1e442QJmr3c6VcNj4lVIBLPeAzIZnm
 HNIe28LDvNkPtvU+YNc3l8hCE4UCQx9/0X3lOEzpY8IB7iTEh0h+hT5NenikWYfAu69r
 1vvnC8lxcAP0dNpllhUBEUPPw6bddTWi8QDNB1pSQQL3JbQpvKNvNxb27KZxr9Adfal7
 yC1Mbh60ySO61XWwvnXfr99tIsvyaeMEf0IsB3frabLjxz4RBYv9goOooLb3GaoXABLv
 QVMQ==
X-Gm-Message-State: AOJu0Yw/OoPsgtlLG9ZTT6RFypBQ2oro0NmxoCmOkzfI9VkrUoKR4bGU
 3S69EUi/w+5ATnODJ94VbWct082+dSuPCHA0ZTZJYbPXKvgThbVTVBxRzQS9lD6xuopDdXPZyZG
 62QsUSCu7Vxg4XDeah3m93O6SWge02e4AM7Gp+xLh
X-Gm-Gg: AeBDietBU6EKarUympNmlC582AXB1L+ItWl1CMFTdBK9BM+sCt05AX5PG5hj3DoFa+N
 X/0AzRGFH9xOEXcXS7e/8FPyND9eI7H69KvtwrsaSPU8UHX8v6zfsNciLJsKNPR6yKbkJC5p8oz
 FfjLGp3vVcl134DcBegGUga/eNDgzIhrBCjaA2jLV3wKZeLPlu/alH7WHEJreUI7TcVbcpdIG8i
 FdMDwIGsTmTayxTyfEcEpXJlpT1jRD8VPZKXKiaQIkDTbeVpkjAzT6LctWcDujpOiYN9F6q8eKw
 HSte9yIWDmrnUMpG
X-Received: by 2002:a17:907:3f21:b0:b9c:cb04:9fe6 with SMTP id
 a640c23a62f3a-b9ccb04a3dfmr22808966b.14.1775390557430; Sun, 05 Apr 2026
 05:02:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260403090109.3564638-1-ilias.apalodimas@linaro.org>
In-Reply-To: <20260403090109.3564638-1-ilias.apalodimas@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 5 Apr 2026 06:02:25 -0600
X-Gm-Features: AQROBzC7EUOELBEKBVf1TPxplTfYU1wl8WFjp8S8eUMKLXiZMZYQlvB1wQj-ZxI
Message-ID: <CAFLszThj+RqF2RKpYqqsd+_30iOaDt8Wd=S--bpQKST2fipCmA@mail.gmail.com>
Subject: Re: [v1,0/4] Relocate U-Boot in the last bank
To: ilias.apalodimas@linaro.org
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

Hi Ilias,

On 2026-04-03T09:01:02, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> This is a different and cleaner approach for [1].

BTW I had a bit of trouble applying this - if you use patman it will
show the base commit in the cover letter.

>
> The main difference with the previous patches is that instead or retrofitting
> the relocation code with the existing codebase, it's much easier to implement
> if we just move the bi_dram[] from bd to gd.

I agree moving bi_dram[] to gd is cleaner.

> Patch #4 - Adds the Kconfig option and code to allow us to relocate in top
>            memory banks

When RELOC_ADDR_TOP is enabled, board_get_usable_ram_top() is skipped.
Many boards use this to enforce platform-specific constraints, such as
keeping relocation below 4 GiB for DMA-limited hardware. Bypassing it
could break those platforms.

I suspect we need to call board_get_usable_ram_top() in both paths, or
provide a way for boards to constrain the top address when
RELOC_ADDR_TOP is enabled. What do you think?

> +config RELOC_ADDR_TOP
> +     bool "Relocate to the topmost memory address"
> +     help

The help text should mention the 32-bit DMA caveat so users understand
this may break platforms with DMA-limited devices.

Regards,
Simon
