Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6ABFC83F3E
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 18:16:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D233869E9;
	Tue,  5 Sep 2023 20:16:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NWSZbE2J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16185869CC; Tue,  5 Sep 2023 20:16:56 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45826865F4
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 20:16:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-52bcd4db4e6so3998165a12.0
 for <u-boot@lists.denx.de>; Tue, 05 Sep 2023 11:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693937813; x=1694542613; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gNsXkmYdmTHfGuYz+9b5oLdtUdN71f7XWaOA2VlaBk8=;
 b=NWSZbE2Juk+yfkloDlGixVk9Wk9CeH303YCCp1b3dvEPQKwmHbNpHHmvna7L9QE9a3
 w72lzMJczRUanCWVkDp0CJKlQQVasBQU69yedG3gky9RIWovgR1ofvTQJGighrVHcngb
 aMVCONuWpTcIYaq1+1eWcW1wl22OvcO9vxo8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693937813; x=1694542613;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gNsXkmYdmTHfGuYz+9b5oLdtUdN71f7XWaOA2VlaBk8=;
 b=Z3taAGKfUaVgmUpPXE8Od5h5BTwPRQpZipRVhxPdxP7VXBb9gp2431g59dqviHMxXZ
 D8s9aJ4Q9sYN5C/ibV+/sJWq2bMrKINrOH44gi6JMAn0SIb8bqGBwb4jiw6BH5E5+6Ly
 0Va1LARZyT2PkwBUir5Yz9lMXOTaKpmKf3mTPwXEUTdQ7VF2P7g5+l2VpLQio91rDfAF
 36wgjm6iJ4yMvgRAJZZJGAScHRsQdGEKkqbNpLj1qu3keiFZVQ9xEMW38zTPFYMaUQA3
 woDu1QstzAl+ARZueAPshWhzXRA1GbHXlMjHVyDnjaC0c3MjJr2IaxMaVYiPRgybJXdk
 CVHA==
X-Gm-Message-State: AOJu0Yz5FxAe7kkjSzeWGl/MfclcbkK0nndSwWQDllEpzlNkUCyJofM3
 c5qyqUh5G/aeK32CuCtPVe/vK/wpU2y/AyD1aShLRA==
X-Google-Smtp-Source: AGHT+IHuE25UH7d1n7a33jMkIU7fth3LtXfho1jBK1DTaq1/4NbocvxudKpDnlmGxxIgQEFuS2NnmWf5QiCwZoT+KaM=
X-Received: by 2002:a05:6402:1495:b0:523:38f5:c5ad with SMTP id
 e21-20020a056402149500b0052338f5c5admr436131edv.20.1693937812593; Tue, 05 Sep
 2023 11:16:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230905134808.14744-1-marek.vasut+renesas@mailbox.org>
 <20230905134808.14744-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230905134808.14744-2-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 5 Sep 2023 12:16:44 -0600
Message-ID: <CAPnjgZ1QeVhCqgXXvWLaCVOKUgYga3VQBWHh9axkbjVMUKO_iQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] event: Rename rest of EVENT_SPY to EVENT_SPY_FULL or
 EVENT_SPY*
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Chanho Park <chanho61.park@samsung.com>, 
 Leo <ycliang@andestech.com>, Nikita Shubin <n.shubin@yadro.com>, 
 Padmarao Begari <padmarao.begari@microchip.com>, Rick Chen <rick@andestech.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Tue, 5 Sept 2023 at 07:48, Marek Vasut <marek.vasut+renesas@mailbox.org>
wrote:
>
> Fix up remaining occurances of EVENT_SPY with no suffix.
>
> Fixes: 6c4cad7438 ("event: Rename EVENT_SPY to EVENT_SPY_FULL")
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Chanho Park <chanho61.park@samsung.com>
> Cc: Leo <ycliang@andestech.com>
> Cc: Nikita Shubin <n.shubin@yadro.com>
> Cc: Padmarao Begari <padmarao.begari@microchip.com>
> Cc: Rick Chen <rick@andestech.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Yu Chien Peter Lin <peterlin@andestech.com>
> ---
>  common/Kconfig  | 4 ++--
>  include/event.h | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
