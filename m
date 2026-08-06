Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F173AC5AC67
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 21:11:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B64D3403F1;
	Thu,  6 Aug 2026 21:11:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UIoxhzu3MjEg; Thu,  6 Aug 2026 21:11:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E4687403E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786050696;
	bh=EArt2w3yNtiXkaWwFS6uVZWjLS5UzHVbR9kKIyt+ta0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J+bVoOo6Iy3plm5iZgE3OPdo3fPvkFJdqw1Ipu1CxO2poXGzrfszPgmj+tVPd5ASC
	 ZH0B8Pxt3SmM6+GYjOMUn0ByDJ7dzbbiKlaEVZmwb/NIWdnV6SzIpUbsrDntHuFz8U
	 74giv1bqjz0cCaWJQMvybkO7ydKoBbTkllk5V0WKHI+/VZObg7o0SnWqkYcZsBGlvZ
	 YiJoFYoSI+HvSZwEOgR7z+M46a4XVNudHFDAFkeU84ng/fiHwbHaIV1/kLYjHPrGQk
	 HIRfa8c4fdYhyGVZP/RX2pIhHJRgALwpz/ikj971hA6lHvO8igydYkEvOLNzYa+caK
	 uWFOuidQBv1kA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E4687403E0;
	Thu,  6 Aug 2026 21:11:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 24D0D198
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:11:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2273580F31
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:11:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HzDaBHL-Y-Fd for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 21:11:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 844E980F2C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 844E980F2C
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 844E980F2C
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:11:32 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c15f020a223so413451266b.1
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 14:11:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786050690; cv=none;
 d=google.com; s=arc-20260327;
 b=qBKf0ge+F3bNBDzHbanL7k865BPRE059oZcGRWnLOPt1aY5rykG2mCKRwxEe5A79QU
 3eV/zmP53poC76Yd514f6D82aukU1aEKP5GQ4GfZy9Xb/zroEcYOgO6yb8g/NYxhOrjR
 lxP5srIagQyMJNvR7hqN+NrfVOoXMZC/YhzmSfhHTMsLQ4FA7oZcGSl3BK1wxsFOdsnZ
 QV5AMvq+zhc8iXUI0mnp75xP4T4joW02a8QLutxAcVMyLjjIXTwf2qpWoUKVBnWtKOKY
 Ao/7avDjvabtJWnNXga6CbN6akdjpmfjaeNKhG/ciok7k0dVGx/YfkCz6NNbM40dhnI5
 uRGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EArt2w3yNtiXkaWwFS6uVZWjLS5UzHVbR9kKIyt+ta0=;
 fh=Ye9d8c9UuIgjdEYE5AmpFdHtipkFyQbZju95WIBagdg=;
 b=Uck6nzDAsdyYa2/J1LJ/oMbrw+DFyCyN7wFMsXvlZUqs4zuSQbuL+kruTpQ2y/2kdP
 JYU6175P3di6GJuRXoEqcnbzYct8jHpsM97Zaohlnv+m62v9lp7plo5IaMy3xBCFlu1H
 +hfXMC9UfHIsOCt5XpR9xDvIhENbSh5e7dC7IjqZjupSZrwu7h2aw0drMuB1MweaWnDb
 WygQ4RPnO3GsOo0APLOzwKAcLiVPggbFRvRm3NFVN9y/bPAbm9kwo7zlO4TjNzXWA0QS
 IvNqdQZQRgPRJd+dgljwbhVfHgILj3rUG4C8nxvtr5487Apm6isxSwcjFuh8WNk30NUP
 vhwQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786050690; x=1786655490;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EArt2w3yNtiXkaWwFS6uVZWjLS5UzHVbR9kKIyt+ta0=;
 b=VHLBFB7u9xWNJ4H68PO2sE5OW9+WxuW235CrgwrXdt6z19BTL9V2Z7YIU8D5IbYOXq
 9UBoubStwkUSIW41QzA+tYoJBEAyr2X+lOHi4Pv1EXKCVcHXw3WJ5mdmfHeMEnPKorHD
 s++f8iqJHkyffLpR0Xb5tA8n+Xka8gRDh3SYoH8lRQNESqM38jqKNNBSOJPl4qCX65IR
 xqAD0E8rgWoudkLuPP4PnVgwZmEaNv0HFvogIyHLjHpLzV3q3J+8hF7uzfp9FwY4Nf1A
 cj5bXSWZKYG6PhMmgVLex1toV1Zf5twX5b3yIUcJSdn7D1H4s6SFmDnU78SOABuLN4qs
 k02A==
X-Gm-Message-State: AOJu0YwBXMV1HbWfdbAXBDp21jocZpHug95eGTDb4J/dC6/oqn1qttpg
 HBnMpbNh4GRWDeeP5zBmdx/8NdFZXbOO6+1jvetpcCJ8YUYWI+ddK0zgk17spv+AeQIaOcTny7E
 impv0vDyzB9JVe1Tm3esKdhHt6daSU+6QxwcvKqRn2m1L1bqhL0Q=
X-Gm-Gg: AR+sD12NuMhEQBmfnGrif6zLLtlMBXQsKVldYGA0jGyB0ZNkFhEMY1pZmID9sWO2Ow7
 TmJOwP9GtAEErdAiHXyTupNgssuonJuZ+RBy/1PB2rlCHf5+duury3v3xzLSQrYJPMJ2rwxrn1O
 vi+TG/lGUYfFp5kYMLiJhqDLNc/hknbqE9PJmZQPQiZ/9hShoXpZT876t6af+4WO0ZNQPyNgKUl
 1M257lx76i9uYIAWAS+Aqaj1psPQAVS5VqfcH/l2+zdAtuOWTFh4fYUAjnhT/dw1wiUY/zMINx5
 vqVHkLrWFiL6h8m7SfbmgSbLYQkLx9stY2Sc1TLu/Pc=
X-Received: by 2002:a17:906:a94:b0:c20:53d8:d1c2 with SMTP id
 a640c23a62f3a-c2053d96b46mr503481866b.5.1786050690547; Thu, 06 Aug 2026
 14:11:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260804-am62lx-v4-0-01746157643d@ti.com>
 <20260804-am62lx-v4-8-01746157643d@ti.com>
In-Reply-To: <20260804-am62lx-v4-8-01746157643d@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Aug 2026 15:11:18 -0600
X-Gm-Features: AUfX_mwNzrTbkVXsmfyKEDPK-VJIWC3trJhSbQeHTpadLT9BK70FWiBeTBvnhIY
Message-ID: <CAFLszTj2jqcQG9P4nWWiXjJ-7cHko8WghVqCbBb-FExnH+gUFw@mail.gmail.com>
Subject: Re: [PATCH v4 08/11] configs: am62lx_evm: add initial defconfig
To: bb@ti.com
Cc: u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786050690; x=1786655490;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EArt2w3yNtiXkaWwFS6uVZWjLS5UzHVbR9kKIyt+ta0=;
 b=NJ2lEmyGVBjCtdJ3SJAZkvATGtVeXfau9W5gtObntf6mWh+6ubTNQilf6Gu38zcigL
 f+LkIetPzAhxeSIgoPXSiq2D/xUr6gbMHhCdxSLwQnS5c0t5lyOmPDHocFoPMHlOqfWH
 fPS9Xx2kfmf4qnm/2ONRWrnYr2exBGSvZ8ytY=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=NJ2lEmyG
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
> configs: am62lx_evm: add initial defconfig
>
> Add the initial minimum configuration needed to boot the AM62L3-SK
> reference boards.

The commit message refers to AM62L3-SK but the defconfig is named
am62lx_evm_defconfig and selects CONFIG_TARGET_AM62L3_EVM. Please make
the naming consistent - either the board is an SK or an EVM, not both.

>
> Tested-by: Anshul Dalal <anshuld@ti.com>
> Signed-off-by: Bryan Brattlof <bb@ti.com>
>
> configs/am62lx_evm_defconfig | 138 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 138 insertions(+)

> diff --git a/configs/am62lx_evm_defconfig b/configs/am62lx_evm_defconfig
> @@ -0,0 +1,138 @@
> +CONFIG_SPL_LOAD_FIT_ADDRESS=0x83000000
> +CONFIG_BOOTSTD_FULL=y
> +# CONFIG_BOARD_INIT is not set

Unlike the other AM62x A53 defconfigs there is no CONFIG_BOOTCOMMAND
and no CONFIG_BOARD_LATE_INIT here, and the .env file added in patch 6
also has no bootcmd. Just to check - is this intentional (relying
entirely on the default bootstd behaviour), or an omission?

Regards,
Simon
