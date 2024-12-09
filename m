Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E185CE7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 23:02:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11761897A4;
	Tue, 10 Dec 2024 00:02:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XaPKn+Am";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C097897A1; Tue, 10 Dec 2024 00:02:46 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AD0B89407
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 00:02:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aa629402b53so688052466b.3
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 15:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733785364; x=1734390164; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xmkMJAZrQd9m8bTUpHczU5sNGEnIpI0tkGuObiyHjqU=;
 b=XaPKn+AmlT7SWUnsSJo1OvYMsgFQd026nXooLG8TYq+DuDH/iiTsZqr1yx6kJGJTi6
 C+z/zdJpL6Z5LolU3U87wjQ4ms3xOZtCsJXHy7ekEZV+ArWNBYzDQlzOB6qqOvo7sHAL
 b7StkpLCcyJS4oJD1mpSIEuu7shycKuUKbmMDTqav9BHkJNptnZHC7K7z/uEiZVK7eTK
 ND3z7ukNx4ldVN4cmHInJNfTrkkdWXibAuCivEmu5mLeASYiN/17Wh5htucLYZ7aErZo
 Ckom5RyBUoXovxMEYV8O28Ko7bhpSwekhkTwSh65wjb4vlSHl9gShFfRprYd2FaGNTKu
 GJYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733785364; x=1734390164;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xmkMJAZrQd9m8bTUpHczU5sNGEnIpI0tkGuObiyHjqU=;
 b=f+0nfaNVKNLDdzlQnLfzswzt1IPiz+oKvRYQE6etd3jplMfBXig3niGZce011tL/IL
 hd386kEkw37p5LACiE1EoLz59HmMzcGUDyvscfvFpU+HUCqkMWp1WqXnVt8WigY0d1dw
 +WJkEo+Y8lcNqlHeAAmghYMeIsrU5WHi3UtI2EjDlHzKzNyfZm0ny2AuTImk3IwRoaiD
 CfwQErvSgSoh2gNn9xSxvSbZweGYEzNJtFEgyJe43bIcQWu5WupFuXRxYH0YKgSWw50H
 oy+17h7L5C8AJqBJAvQbDKDX8nb3C/5ShdR7N0kMPe1eLlVJwebtOmViqWKYXPeQfYQg
 5E2Q==
X-Gm-Message-State: AOJu0YxuJ7QL5kDMhumIhnJpnd/opLYsRa3EBMSDbwhBR6SJjvVmqjh3
 HDIEnwULMOKEgQIdRET6/XWyizfE4cC+j1g1a+lJVUKM39M1SDMZu13SLcXd+iv6zsR6A6sNSZa
 kKD8gcLl27nwxfmYxipcJzO81t1k=
X-Gm-Gg: ASbGncvgRF5QNDaDhVzh/3F+JUIYpC6KkoTjLGHt+OkTH2NQ844u1QE+7QsiDDnnhwG
 b4A3oFxzolMdIuaMHYL9+wFEObgVZaQx9YXI=
X-Google-Smtp-Source: AGHT+IHLx+Z2u1TcCAExqDSYiLLLuTSxfcpiWw5yFodqYA9WtJxzjSHCpPgTLJGB1IDEX25Kko1SN46ZpYjbWIyzuh0=
X-Received: by 2002:a17:907:9555:b0:aa6:86d1:c3fe with SMTP id
 a640c23a62f3a-aa686d1f389mr580188866b.4.1733785363712; Mon, 09 Dec 2024
 15:02:43 -0800 (PST)
MIME-Version: 1.0
References: <20241209195528.730260-1-sjg@chromium.org>
 <20241209195528.730260-2-sjg@chromium.org>
In-Reply-To: <20241209195528.730260-2-sjg@chromium.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 9 Dec 2024 23:02:32 +0000
Message-ID: <CALeDE9O2ZRkeze-SmDO8-_QEt7xUt14y=U7Jt-yXSXKc19tH6Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] rpi: Add myself to the list of maintainers
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Stephen Warren <swarren@wwwdotorg.org>, Stephen Warren <swarren@nvidia.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Robert Marko <robert.marko@sartura.hr>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
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

Simon,

Please don't send multiple versions of patch series back to back.

There's been 3 versions of this patch in less than one working day. You
wonder why we're busy, I can't get to one version of you patch set before
you send another 12 versions.... It's generally considered, at least in the
kernel community, you should only be sending a version of a patch set once
a week to allow all discussion to complete, and then only sending it if all
concerns are resolved.

Peter

On Mon, 9 Dec 2024 at 19:55, Simon Glass <sjg@chromium.org> wrote:

> Add my own name to the list, since existing maintainers are fairly busy.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v2)
>
> Changes in v2:
> - Add new patch to make myself an rpi maintainer
>
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8c6c0c2a4bc..4b9bb9ef3f1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -210,6 +210,7 @@ N:  aspeed
>  ARM BROADCOM BCM283X / BCM27XX
>  M:     Matthias Brugger <mbrugger@suse.com>
>  M:     Peter Robinson <pbrobinson@gmail.com>
> +M:     Simon Glass <sjg@chromium.org>
>  S:     Maintained
>  F:     arch/arm/dts/bcm283*
>  F:     arch/arm/mach-bcm283x/
> --
> 2.34.1
>
>
