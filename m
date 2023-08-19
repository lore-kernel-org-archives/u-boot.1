Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3FEBEE49A3
	for <u-boot@archiver.kernel.org>; Sat, 19 Aug 2023 20:44:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A712F86BEA;
	Sat, 19 Aug 2023 22:44:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SC93LrQF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BA7D86C1E; Sat, 19 Aug 2023 22:44:53 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25C9286BD2
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 22:44:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2b9fa64db41so35322201fa.1
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 13:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692477873; x=1693082673;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fyVo3Vxk5k1ii/Z2WxvOYT1I6avMqdOzkJgGc/mvqcM=;
 b=SC93LrQF0xWNVt8SrN8RXNuPtVpL6VrqX8gS3hUi0eWaUp0G8hJGCT2rFiW9YWFRqs
 K9j1FZXcSiIcT/glWhRC1Ao5NznoOveTgZuhTAFdStxn8cFvfomyqsp4O7ID6jGKi4LG
 5pgTFBicvBiNXqt/UedXQo3MoznIMK17V0oD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692477873; x=1693082673;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fyVo3Vxk5k1ii/Z2WxvOYT1I6avMqdOzkJgGc/mvqcM=;
 b=ZUSjz1qRSbs0trJ+xBA7drAmdHN9I5L9W5KZ0HIO23M67/vcFhDo/d9NavrUgXE2Ln
 1ogTQxg8S3kLx6YHlyocetOp8lnbZysJ2FhrlVVH0eBsIEmooDl7bRcbT9GZlSw4WqID
 8Bp/DAEP7h/DonPl1WDAtxYrDKcTzt1bwGgynpd7x+G3y78EVUx+Aowv2h8+HXZvcLff
 n5dXze7r7T3G0oISATqQ1vMh0E0CMxlkyLWfU2rAMrDItl4weeY/5Qm7b8jR9tV+uVi+
 tJNnsaZT7yq+3qDigY6G/EoqBep0eKsZbC9FGrzKafKb+dbuS5ccs2xEmJNdPXHCjvIG
 +xbQ==
X-Gm-Message-State: AOJu0YwwuRl45XQKZvECwz4aaa9mYT0sybpkzHvjm/+pc0lUDNXBqXtJ
 3MtqbJyGfSW84blbwgoTG2y/sMowLEgBOu/L/BGOyw==
X-Google-Smtp-Source: AGHT+IHlSIUQ7muXm58m+4neJYbqCrGzgEiurQ8PT2mESk3SGgW/N1JpA5MhBHqdYnhlgnFzPQaexaUfr7MdwpsxehQ=
X-Received: by 2002:a2e:2c18:0:b0:2bb:a6b0:cf66 with SMTP id
 s24-20020a2e2c18000000b002bba6b0cf66mr1917209ljs.2.1692477873138; Sat, 19 Aug
 2023 13:44:33 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20230818052645epcas2p48c419f6e6318ddadb425749319fbc3b8@epcas2p4.samsung.com>
 <20230818051103.2427590-1-chanho61.park@samsung.com>
 <20230818051103.2427590-2-chanho61.park@samsung.com>
In-Reply-To: <20230818051103.2427590-2-chanho61.park@samsung.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 19 Aug 2023 14:44:21 -0600
Message-ID: <CAPnjgZ1V-VkOOJXDrj0iAq9Bc_pDXFqjgNYW7sYR4_x90ie6ug@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dm: event: add EVT_DM_POST_INIT_R event type
To: Chanho Park <chanho61.park@samsung.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 u-boot@lists.denx.de, Bin Meng <bmeng.cn@gmail.com>
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

On Thu, 17 Aug 2023 at 23:26, Chanho Park <chanho61.park@samsung.com> wrote:
>
> This patch introduces EVT_DM_POST_INIT_R event type for handling hooks
> after relocation.
>
> Fixes: 55171aedda88 ("dm: Emit the arch_cpu_init_dm() even only before relocation")
> Suggested-by: Simon Glass <sjg@chromium.org>
> Cc: Bin Meng <bmeng.cn@gmail.com>
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> ---
>  drivers/core/root.c | 6 ++++--
>  include/event.h     | 1 +
>  2 files changed, 5 insertions(+), 2 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
