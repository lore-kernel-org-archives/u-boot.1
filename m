Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB40ECCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 13:27:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 811C7810FB;
	Mon, 19 Oct 2026 13:27:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k4HKh6ZbBtRX; Mon, 19 Oct 2026 13:27:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A28E480C25
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792416466;
	b=cCdwo78yLaMfeXSKCzVorQ24pWnO1w0PCh345mDPrbK1XKAPXBIv7xptdFVG6SaChJKy
	 LiyRSTrVDMfETQqVVgdSluFzwCKq/naQr1IamD2GqFAy8grS+KgtI60Ho3Xk/H7O5bBJs
	 maRFte9G0huP9z29jyWZSfj0BN6q6vsuDeTmUrKz7Detn+pPSkKlQajzf653i1HB7dAh6
	 CFWfo7695sS+uzscFdt9YGN7w/MN+AwG3bHo8vgm+AneWLdEVYEbh0TA/pJjeRcfEU+Rc
	 jky/pu3uGLIlUjeNqM8l8XxLlGT7+zWDlUGKCpQq5fhU5y0CVzaH2fsFaekcEj2mLuw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792416466;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Abll8j/JezmrhWBwt+jvRsnCv9x67DSwjy0QuHVXYVw=;
	b=Gwi30liF2L5b3aNmrXjRxoh54II0xuK64eX3Er86AZzlZeCtHMr+xyxLggvI7NfgFvD/
	 HetPA8yHSj42klxc4MnT4qdy7miSA0I5MQsb0A+4CirX+2PiHmknTKhd7C+O7OmtMChOz
	 4dETaSirKHh4C6Km9gRS+Utb3yQNGSEBliH0Cm9+Xz+IdjYrolUSodXSI772+nF88gUoZ
	 Aq3AXG544OCDhU7whOKGm7o1aMzRfGHlwspSCOOWEsNnjq6OShnuOClHeYWXkjjKg7o8c
	 Gf3NRgdCCNrUn7JTDolPWhdEpG4fTRBr7Ni0FJrWqsRyhZMqYVF8mWIqrENRjAThTHw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=YIMvynT7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792416466;
	bh=Abll8j/JezmrhWBwt+jvRsnCv9x67DSwjy0QuHVXYVw=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t8l9huym38pINYz/TJ79RQKfqQKd053AcfIp2LTWvuO/N0RkJUeNheYK57rEX+q3Y
	 Ve8TcNnu1SUp1UVcSivWnl6H7rgFCYNcBa+Caer4nTEbHXHYehcqQiRoa670TzlUFX
	 xwmvM0lmaOVmS3ZOfQSlpknsi6WUjMbZJG1xKzGed0Gpl7SaqxVoIA6MXz1IiEFgnK
	 IGZ4pPuDXuBHATuzSChFD68FFz+AElLDHd/nPL9EHQqPU/ru2s2NqrNiKVYOWvWNLD
	 8eSRu81AiWSooY22F+ACN+Hwgm4uWosFyQ+59INfMe5uSkT5q3i0Cvr4Lu4inBCd51
	 m1qxV82kOYkKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A28E480C25;
	Mon, 19 Oct 2026 13:27:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6A92F1AB
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:27:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 50A1C810ED
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:27:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2eTuVVCJBLgJ for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 13:27:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 509C480C25
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792416464;
 b=Ni+UoWIR6VMW00nDwo6mUlxpnxWGdU/mV9LIIDTcR/UnjMCvhDRE7qkxl/4tiQfaCc+n
 PYqPNSXBguWSlmoYaZjUfX/bfWlpc8o1TVwUTZe4luZ8lINSdCzGjRkySvgnY6xpsqrxA
 yo6DAExbEfszFFi57lkX6kTIJMfj35dW2rkVbgRm5vqRdTPGMPa02ebTuLV5pm2lJMBLg
 swk15+yPzJJouZC0Xvm/0xfYOMLBS8Wto3dpIGKiiWGPKCryhH67w7MO2XAf/rdgtCb/K
 bKIh4SVXmIIOVGnyv4Os7J+fsm5sHUqp7oOT66C6MctVULTn9OkwCfsqCC7LaG1a7TQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792416464;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=Abll8j/JezmrhWBwt+jvRsnCv9x67DSwjy0QuHVXYVw=;
 b=afmv6vnB+U/I8iHszA7Sv0ZKrdbTsgGt3lXb3EbAVIm+f+QvFHXWin9Nvvn29dTZVoYV
 fHM8Cxf+irHvGZZrKfKayrJBizEx6BSA3u9lMSZyWjEwRb++zDTEKkvVmRSdqmTyXUIW5
 8o3HnNImdYbp2g/IxhMNNeh5d0Uat/R7CgtGPyEUNSDtbDBrzy1R7rskuFg7HUhVvpCV0
 s0h80D5qQUMmvdM4f3lxH+g3nH60GoWb12gGg8QtGKz3qpJNpkrVkl9oxxMiIkWd6whzb
 ggItn+GMCHsuYlMeVOJf/5/2ExcVUObrMvu04xlqJAoqyvLdBS4AB0JuphIYrbPeMAw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=YIMvynT7; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=YIMvynT7
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 509C480C25
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:27:44 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa377c61so2459013a12.3
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 06:27:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792416462; cv=none;
 d=google.com; s=arc-20260327;
 b=NCBewIVTqZXEoFtxQZhy3AopJqvl3rOQ+atxXKrSnQhTNafDRjlqwZJ2cWTGcrHFdF
 VAXmLbpbk7fjuRbD3I3HuyDEFFp8udiut8mtYRYuJbsj2iQetkRIxrrACpF73nhfSCbV
 XEFAvO6/br8k3l9kqlkz8ESke1fsO+iEwWWPWQI0JJfV09lwjiyPZ/EODiVceC9qHa+X
 0xy6MLaWttIMGBym7+9SkbSQniBz3JnS0m6UgXNwxJuWU3SkzmaLEn2kPKZL3ED+ICz5
 xsSZ92mVsRsP7PX0PiF6I6ynubT02NElVMZUO7eUpaBMiMdEbJ6PlIqeqeW4Nq+P6+/g
 qI/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=Abll8j/JezmrhWBwt+jvRsnCv9x67DSwjy0QuHVXYVw=;
 fh=CHrVkPmrRB8Et388b7Snsnzsj2akzlLmCuQJL+mKYCU=;
 b=eszdHyQedO7qSh32VgmEQgaLFpSf+JCHLmqL/7XHXRPfcQcJst+EndheQnVs3pTsSv
 +drNMBui89bHfif7jKIpZjTALvfQopa+MLdQQt+I6KUZCE31rm6alL1+yjpkYLB+QzuY
 k+JvnLBqSiiStazpRQ5lSLQZRWWKX2rYBfBCNp4NZCB5saVQI4IG8wpCBWYQn+ZxiiZU
 uBkqian7EpvTRN3LDog/LdcAorLBFjqUuOSuQKU2Dsy5wyfPTM24Pgv4yQ2MjwjNIBTw
 HXIZQvuRNuqN7Q+wQ/lHDWjGlPCxtc9ERCoTrgLkTys7Y8heDcYImzQWMEdWF9GhNVHo
 GvFA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792416462; x=1793021262;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Abll8j/JezmrhWBwt+jvRsnCv9x67DSwjy0QuHVXYVw=;
 b=YIMvynT7CF0eUt/PBiN+iJu8lU0SR64AkHcxTC5ljo7h9mXVq4gTpBMuXR0ZRe1BLX
 JWS2CU8t+z8VZyWAzkMNXMJlMH9nrGus7vf6e9S4sVfG5KtoIRPzQpkMZ6Rq9inFBfVf
 NCE5QJdZ4mak/UF5Bv27Jv+Au1siNg3yCLC60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792416462; x=1793021262;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Abll8j/JezmrhWBwt+jvRsnCv9x67DSwjy0QuHVXYVw=;
 b=Oq8ox5CcuKJvFrKj9QkfcaZIsIeBqGS6Aptdn5fkxPze6T1fNPqVfcjwVIpaRTKiSQ
 iWRO9lZ7fR3dJg5mOEtsKiMa9RlQOckS+rMIiSgNKDLFan+OxzCFOzN4UVLCGEG6lL5S
 B0qRJQwVN6/JcDZ+S2u1mHLaH6C5mZaeXYwkXFDwurkZOz+wOZMcD9cezsuNfroGRhmc
 eDLcjoxZR9UhJ4hduwJg4pbbDk3KGemvzepK377iVbdrBo4yYANcYhDE/YEJJJaC7p/d
 gj26ad4EHQ2nJ9fhjo5rGErc7+ifjxKOzvri3yQOScBsM215uDG+b7lIy7ZqcVOUEZ6R
 L63w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzTNNQg/QeQmsgc5cZujJK/Vf92dPyKnYwDYxF9hRvmsmG7CXcd2KYjE6dz3ozUemNK0kh2f3Q=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKi4g3cL8Js2AdARgvHyH/3G7dAUd0U5ShdnvUJz/6jI0fM/en0
 4AtVfGO6Ob2S9Picu4TYw/DpUwTqGj2ZxojzjWvr4+Mr5YjPX6D50XfY4LNqBLdvjIDO2blHUc9
 zGZmbUq37RRjbg7HeumCfv/sGov5d3VcKAxF+uH/QshHBBovJI17w6Q==
X-Gm-Gg: AYBFou17Bwfvi8S8WQW8jgVOlXsKoze0BTPd54VpTiNaIP29d7oo2gONfEeoqPkwEcm
 ombdhuxcwqFLy0gb12LC7fbxctxZ8YJsB7UGH2wvcuG5NOx0Nkzo75COlnKyF0jNKopmsLspz02
 oYtBcJdw7jK25NN+HG6kG/miKdKH11Sd4WOobQ9vVl3uvmWsTZAaU4fGDCdrCiKxP4UjOJhY8iD
 A2RKHsnXwQZyykvCSgnuj6QhANZnhZY/MBOOGCJxOOx/oyJeA/y7shosAdRyPHq6ZmGcwFe2EXA
 ffAGFNETMSWUbuWR0HdGpCYrstTASpaiHLS0v3er5nmwbNmojQHnwg==
X-Received: by 2002:a05:6402:e10:b0:6b1:ef7f:2847 with SMTP id
 4fb4d7f45d1cf-6b3df98b9e8mr695820a12.24.1792416462141; Mon, 19 Oct 2026
 06:27:42 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 06:27:39 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 14:01:13 +0200
MIME-Version: 1.0
In-Reply-To: <20261016040216.3636305-3-visitorckw@gmail.com>
References: <20261016040216.3636305-1-visitorckw@gmail.com>
 <20261016040216.3636305-3-visitorckw@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 06:27:39 -0700
X-Gm-Features: AclHuK8LRTFA_gqjyTFHOMX0u6N-CybfkxqLJOz0YIhRFq3KDbD_OLDa-832HXI
Message-ID: <CAFLszTj7zprFA34rZfsnqyPFNMUco6udWU=vZcwb4w29cuf0yQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] board: google: Add Google Tensor G5 board support
To: visitorckw@gmail.com
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org, marscheng@google.com, 
 eleanor15x@gmail.com, jserv@ccns.ncku.edu.tw, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Kuan-Wei,

On 2026-10-16T04:02:12, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> board: google: Add Google Tensor G5 board support
>
> Add initial board support for Google Tensor G5 SoC boards. U-Boot
> runs as BL33 loaded at 0xbe000000. Configure the MMU map, DRAM
> bounds, and disable the APC watchdog left running by earlier
> bootloader stages.
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
>
>  MAINTAINERS                  |  2 ++
>  arch/arm/mach-google/Kconfig | 11 ++++++++
>  board/google/lga/Kconfig     | 14 ++++++++++
>  board/google/lga/MAINTAINERS |  5 ++++
>  board/google/lga/Makefile    |  3 ++
>  board/google/lga/lga.c       | 65 ++++++++++++++++++++++++++++++++++++++++++++
>  include/configs/lga.h        |  9 ++++++
>  7 files changed, 109 insertions(+)

> U-Boot 2026.10-00821-g86c1a8698ac2 (Oct 14 2026 - 21:47:47 +0000)

>
> Model: Frankel
> DRAM:  2 GiB
> ERROR: reserving fdt memory region failed (addr=be000000 size=1000000 flags=2): -17

Just to check, is this -EEXIST because the DT already carries a
reserved-memory entry covering the BL33 load region, or something
U-Boot adds itself twice ? Worth tracking down before the series lands
rather than leaving a visible ERROR on every boot.

> diff --git a/board/google/lga/lga.c b/board/google/lga/lga.c
> @@ -0,0 +1,65 @@
> +#define LGA_SDRAM_BASE		0x80000000UL
> +#define LGA_SDRAM_SIZE		0x80000000UL
> +#define LGA_BL33_RAM_TOP	0xc0000000UL

The Kconfig help text lists Frankel, Blazer and Mustang, which ship
with different DRAM sizes (Pixel 10 Pro / Pro XL have well over 2
GiB). Hard-coding 2 GiB means those variants will only ever see the
first bank and the mem_map will not cover the rest. Please can you
pick the base/size up from the device tree
(fdtdec_setup_mem_size_base() or similar) so the same board directory
works for all three.

> diff --git a/board/google/lga/lga.c b/board/google/lga/lga.c
> @@ -0,0 +1,65 @@
> +int board_init(void)
> +{
> +	writel(LGA_WDT_KEY_UNLOCK, LGA_WDT1_BASE + LGA_WDT_KEY);
> +	clrbits_le32(LGA_WDT1_BASE + LGA_WDT_CONTROL, LGA_WDT_CONTROL_ENABLE);
> +	writel(0, LGA_WDT1_BASE + LGA_WDT_KEY);
> +
> +	return 0;
> +}

The APC watchdog is a SoC-level block, so this would sit more
naturally under arch/arm/mach-google/ and be shared by any future lga
board. What do you think?

Regards,
Simon
