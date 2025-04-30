Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1444C369DC
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 13:55:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE4DF82887;
	Wed, 30 Apr 2025 15:54:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EeBGhLZi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D793582845; Wed, 30 Apr 2025 15:54:56 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3292F82B9D
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 15:54:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ac2af2f15d1so918388766b.1
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 06:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746021293; x=1746626093; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=y5pWsEnxMXL5A5+H/NMUrddjtjEQJ1qX+ftA/d19ZRc=;
 b=EeBGhLZi9V4GUem5667lwNpiVuIFKHHr0qB6AlHwlVMcscgWd/IjfSQWscX5TZWVLJ
 SUau1TmWtLe+s9sI1UBuWlOC17RKVdTQbOGSunAlc7E/wzlqUeWBKKO9z6FZPmqotbzE
 Ru4IxeYGPmEPzJ0dND6f0ybNXAx+g/5fZF+o4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746021293; x=1746626093;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y5pWsEnxMXL5A5+H/NMUrddjtjEQJ1qX+ftA/d19ZRc=;
 b=HrgVjjy7GoOR8NO2grPf0o5v3+hgh+Af9K9lW7w6xGnfJ4CLUBCznDPrX9qtN+6a9h
 0LjNPnF92kzazX10FXbfqBxMPFllsaXtqGoeOf6NZgKvYhSgoTqyldT35Wr4mtG07PAF
 lMC2JEx3ClOUw5XuoFJ2Fk4+IA7VyJcJtls06NbSMhcqNm6siROZqdoC4/UbHv+xrnt2
 Clb+VRmWhNy98PcXM7lkm8NTdiAkaVbUIAYRWDdkHLHIocW9oXiEqEBmCRZ9t2k1Hrqc
 dmrF1F6v/CcVPv6bb3ZqDL2wJ3X4XMbCosbDtd/+WZ9jnw016mTskzy2w5SszMTXdDNS
 YkIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/NY/kKGkdt7wr/z5QJjh0Zm9T0WAvkuMMm9/+Eu+ZvxRqmZC+SwP8VCYw1TF2y5R1DTS3p+g=@lists.denx.de
X-Gm-Message-State: AOJu0Yz1w4bhocty4VqGmEur4SlKuwrdHmeo0lxIdx1OiEDZMnT1MwFj
 obL/fXoCMgOvCAAdwObQ+/wAGsqSB/XUYv/RrwF7qDqjEL/rHR7FZL1iTsJAUsfMZ10qtoz9HpE
 FA/Br3No6enVUu2oIV/B1D5xj4EZ8P2byEeUZ
X-Gm-Gg: ASbGncs9crzYR+KsMBAO3Mqr3tu5KIMh+WMSeuKGxCSQNffK/dbbgV7XtcN0O8p0ZX3
 ERtjKrfjnvVittFq6B96dHF+SArnd5VU5ZFfE2hSDG9iukPfXI0SCKjlIJE2zPXMp4dTq7f9llm
 GHON3rJ892LLB4+DeMQDZ37qw=
X-Google-Smtp-Source: AGHT+IED218BS0rrm7MJMr0CCZkx8YCdfpZ+BmGBGY6VLMsuCZgkF/fGPFBQzKOHwWXMD9n79ZUqg/BwGYDV6OTsjqc=
X-Received: by 2002:a17:907:7b8e:b0:ace:4ed6:2690 with SMTP id
 a640c23a62f3a-acedc615b6bmr336392566b.28.1746021292722; Wed, 30 Apr 2025
 06:54:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250430073405.14396-1-heinrich.schuchardt@canonical.com>
 <b1eefdec-6d0c-41d0-b895-ec14e8bfdc2f@canonical.com>
In-Reply-To: <b1eefdec-6d0c-41d0-b895-ec14e8bfdc2f@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 30 Apr 2025 07:54:38 -0600
X-Gm-Features: ATxdqUFa1j3xwPDdiJPmHoslcKniRwmzy9Ahab1-JNkHlveFc9-Kt55PutLZvvo
Message-ID: <CAFLszTgvTN06XwDf2qBPDw+K4On_Y_UMRnHsjw9CT+8WGfvxKQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] boot: let BOOTSTAGE_RECORD_COUNT default to 50
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
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

On Wed, 30 Apr 2025 at 02:32, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 30.04.25 09:34, Heinrich Schuchardt wrote:
> > BOOTSTAGE_RECORD_COUNT=30 is too small to record booting a FIT image
> > with EFI kernel, initrd, dtb as seen on the StarFive VisionFive 2
> > board.
> >
> > Increase the default for BOOTSTAGE_RECORD_COUNT to 50.
> >
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> >   boot/Kconfig | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >

Reviewed-by: Simon Glass <sjg@chromium.org>

There is some opportunity to reduce the size of struct
bootstage_record on 64-bit machines if you like, but we don't lack for
memory these days, only code space.

Regards,
Simon
