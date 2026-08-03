Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82CF7C55196
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 19:25:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3BC0B40606;
	Mon,  3 Aug 2026 19:25:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ex1P2OwRFurZ; Mon,  3 Aug 2026 19:25:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 70DCE405FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785785158;
	bh=XlcJT7OyFadTvXXiySuF6nEs5Vrzj+GX1UDbq3lnS1k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cE0ojfF2F+h6zf8rQM05SYXkG1VbdBabLevvYKpo2527lOM2lDIIr7lgkE2R3XWB8
	 ncoGHvzqELA843kaFIT0jp0hJppCNm2JCdb3iJcl/6PH7ecLWLdePBaGukMSNf5lKt
	 k0Ffvr/ikolWTLA84aBsfxOPGQsWmAHGDp5zjGAHFAzAMq0lbQytRNNLOsl5N2qImw
	 aQOibme7AjupYp7SEIcarHSvh9WZY3InzeNYrUMKOqXXphpWWqz/J/yV8Xp9lMp4Wo
	 ZNCYZHs3djcXjprUCh5DtV22NvWfCCJzekCLUoRvL5GrrIau3r+vgH3lcHDa7qTk7x
	 h19LZCqTODopQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 70DCE405FB;
	Mon,  3 Aug 2026 19:25:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 48DD236E
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:25:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4702F405FB
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:25:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6rAC4rGN657B for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 19:25:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 55C34405E8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 55C34405E8
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 55C34405E8
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:25:56 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c15d3cd51b2so518307366b.3
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 12:25:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785785154; cv=none;
 d=google.com; s=arc-20260327;
 b=Di+svsaB0HCcl58FzyojlBy9fatR5oyphdpGJxnMS35AoPx+HVorBlpbJB23ipWdkb
 WgAnM73QBF19lIqk6N9Xhd8iW0CQ1Xu4AUwSbyc1GhD0sTunC3Y6vILjSNm4oMkDCrzn
 nuSmEyFs+fdt9aZk/Yc+ilfi5DCcLeCWDUi1jCxB/fWaXAEroo1+46EnuSFZRXOqwdKu
 JHqKSIMoviaVJvuUwPZ7BeuaZZoHDJJbbRFmRGypNM2uEQUprQymrgqZhRUtB6sDObp/
 7kSdtFblcQoOM/1Oie5A+gjx6a7++10zTGOH5n0FwnoNccQh/a7ZBrbYA/x9CPYLoXsI
 LJEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XlcJT7OyFadTvXXiySuF6nEs5Vrzj+GX1UDbq3lnS1k=;
 fh=zTMN/pWAv2I8WujfIjqmZf3BsjBAX2SRPtIMBBgMW20=;
 b=G0FoAWtsvWn3YkXjYxtZ9CdzjkGh6gBBolAeBil8seEvVy8LYss6GvbZf5t9So1PWu
 ka3DMfi3zrckccgKt1juHnCi+6hWp5V0HL/9a3XjIJLWJlD2KmN4r84ogfhWkRPi+6Kh
 U7O+RrJRwk9PkXBEUli1oecM+rmW1MX1Yux0yxRdOstwCjnNI9YziY837oNqXhVm9ql8
 icuFF3Jk6GnAM1nf9nQXi2jc68Jcwnny1DoV6wjZFSkLmIME3n1kjoNLQ/YYiMjXKbe9
 s2hdiSos3IPm/ItCll4TVYAo4tWA0sa2BKcUddgyJQ8Y68bwfXJqV1sZzsipKc1JjmzW
 r1eg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785785154; x=1786389954;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XlcJT7OyFadTvXXiySuF6nEs5Vrzj+GX1UDbq3lnS1k=;
 b=qKxXJEz8kpbBbmWW+RwdwMjzsU9XbX9uudzcbMCyLjB9vj9EFpvF165tq7IWfAiJjp
 RAUwbEi9FgI7mCHSyFSMvtgSVAQBbp/zGYM1dFsQVNAL8bavHzMS12vgsp24kkp91ePo
 n/4NtY1RmWTbTVt0UAO/PM4KhoTDmEaaOWymOh0s8eUZ4mTbeN5xXPKmHJ6pegE0V7wa
 PgFs0iSXMPqOksgEK2nLSF/Nm2EkVgNdDNgyW5SPbX+AY4caqw38f3GxT8jO8VHLd1pw
 aWE8j4dLRI+awT+8Z8TX2BKXajRKi6q4rNp21LkFxbDdhNpa8lX0sOpkLMwjD4O0ZpQv
 ffyA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqxAirbPSdFhMaj/k5/Ll4axEbBCUDSOEMBrJ2ijdfahzSvIFN+zjB0IwfN2JgnfZzUTAOFNQ8=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxrHuNVMXJ2GQWaZSIu6LLnmALQqojQpsnaYEXxRppvqfqWMsE3
 bA3+jL1jzW7GmqpRVW5J4F0mknLeYBPHsl/vDfzPhbvKSq/cjnsYc8w1q6E1kuc4P6XnrlM2jMn
 hUsfe0s/gHucQ5PAhiJbuvOwjFp5SnLUdJVXUFo5S
X-Gm-Gg: AR+sD13oSP+MDGMbWwnzZsC2xpB/OmmWzlsNliWcRUvR1I+k8D6Dm/D98knRHfTWxRD
 19znmLTKUqpT4u96ZXk6WmcoPCoOcmCTGyT2q/j5YdovPXppBXv+cYTTJnw89EdLch/Al/Exo7p
 3Nz33/V0c4I4Wmoksg6dwBX9Cot9Gya6D1RWY5myd1sieylUFklsU9WhLA6SJjimwnlhIny+f7n
 vnqj1NfOLPC2kIMKtcz1dGSz60dEagv4yH2xHIOtTQq9NlnxI9wgsWJ29pb/QpIOG/VjO8MqnXO
 ebB9q12kfaDCk19a95qre+Fd7XGECWtuR2f4KKjyRLktBqH+p+Jj2rI=
X-Received: by 2002:a17:906:9fd1:b0:c19:5a94:411b with SMTP id
 a640c23a62f3a-c1fe7e9f8b5mr1066261466b.6.1785785154374; Mon, 03 Aug 2026
 12:25:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260730-qemu-x86-pflash-v1-0-fb403348e29b@elliotjb.com>
 <20260730-qemu-x86-pflash-v1-3-fb403348e29b@elliotjb.com>
In-Reply-To: <20260730-qemu-x86-pflash-v1-3-fb403348e29b@elliotjb.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 3 Aug 2026 13:25:36 -0600
X-Gm-Features: AUfX_mw_3AYkQTmp6ekT8LMZmeyUElt2ApJOObomPHO7IP6dSvp5g-eh0JIR2h8
Message-ID: <CAFLszThnAfwivMS7ReoXkfrfXsFpmnwT0KGR68kLrQPuw+ENMg@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86: emulation: enable cfi flash drivers
To: elliotjb@elliotjb.com
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785785154; x=1786389954;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XlcJT7OyFadTvXXiySuF6nEs5Vrzj+GX1UDbq3lnS1k=;
 b=fz/k4Nj9UGs+M73IeJV0SHjZZQig03PR6bxJiKeT7/6dX3WCeHOUKfdHNcRhjazZww
 3n9Ho2nCAh9qm6+yq6qZSK0i041EBEmGh2aVPoJAM4IXbayuABfeOyLVgpAnIYvs0dRi
 uL/D++UI0rBF9vwI5oYDdWwpGl2ytDGNdawrc=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=fz/k4Nj9
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

On 2026-07-30T19:37:45, Elliot Berman <elliotjb@elliotjb.com> wrote:
> x86: emulation: enable cfi flash drivers
>
> Enable MTD/CFI so the pflash node just added for qemu-x86/qemu-x86_64
> can be probed, matching the flash config qemu_arm64_defconfig.
>
> Signed-off-by: Elliot Berman <elliotjb@elliotjb.com>
>
> configs/qemu-x86_64_defconfig | 13 +++++++++++++
>  configs/qemu-x86_defconfig    | 13 +++++++++++++
>  2 files changed, 26 insertions(+)

> diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
> @@ -76,6 +79,16 @@ CONFIG_ATAPI=y
>  CONFIG_LBA48=y
>  CONFIG_SYS_64BIT_LBA=y
>  CONFIG_CPU=y
> +CONFIG_DFU_MTD=y
> +CONFIG_DM_MTD=y
> +CONFIG_MTD_NOR_FLASH=y
> +CONFIG_CFI_FLASH=y
> +CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
> +CONFIG_FLASH_CFI_MTD=y
> +CONFIG_SYS_FLASH_CFI=y
> +CONFIG_SYS_MAX_FLASH_SECT=1024
> +CONFIG_SYS_MAX_FLASH_BANKS=2
> +CONFIG_SYS_MAX_FLASH_BANKS_DETECT=y

CONFIG_SYS_FLASH_CFI is only referenced by a handful of legacy m68k
board headers - it has no effect for a DM CFI-flash setup, so please
drop it. qemu_arm64_defconfig doesn't set it either.

> diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
> @@ -76,6 +79,16 @@ CONFIG_ATAPI=y
> +CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y

qemu_arm64_defconfig doesn't enable this and the emulated CFI pflash
handles single-word writes fine. Please drop it too so the two
defconfigs really do match.

> diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
> @@ -48,7 +48,9 @@ CONFIG_CMD_CPU=y
>  CONFIG_CMD_BOOTEFI_SELFTEST=y
>  CONFIG_CMD_NVEDIT_EFY=y
>  CONFIG_CMD_MEM_SEARCH=y
> +CONFIG_CMD_DFU=y
>  CONFIG_CMD_IDE=y
> +CONFIG_CMD_MTD=y

The commit message says this enables MTD/CFI so the pflash node can be
probed, but you are also turning on DFU, MTD and MTDPARTS commands
plus DFU_MTD, which exist to make patch 2's capsule wiring work.
Please either update the commit message to describe the full scope, or
split the DFU/MTDPARTS bits out.

Regards,
Simon
