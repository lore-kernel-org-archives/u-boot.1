Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E99B2C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 20:14:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0D8283DEB;
	Thu, 10 Apr 2025 22:14:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OE/6H2B1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8028B83A8E; Thu, 10 Apr 2025 22:14:24 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B1E883A8E
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 22:14:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-72c27166ab3so706826a34.1
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 13:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744316061; x=1744920861; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ejp69Ch8XxHNKMr5FlqMNsbwP8SQ6W5BrOWfzQVLWP4=;
 b=OE/6H2B10pBAgZ3+n+AODCbkZLH/Ifx5iLGMWENZfVeO2fH3YhC6yUeikEieWwW9YW
 Ff64FI/Xd+oPxpwc5tjNOqwAvAHei/E7Nf+rq8GFIi2Sn5HY32I94cNjo+ICgW6GNche
 RMyaBNznbD4R0hxIPPU/YxchjSrRgvbFQcJBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744316061; x=1744920861;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ejp69Ch8XxHNKMr5FlqMNsbwP8SQ6W5BrOWfzQVLWP4=;
 b=fWRKGy9SvdhQxoDmY3M7HaD1BlMpgPQ3aApg386X+l+P1HzX1cpAXG3ckDBBGBe9nM
 lCqcNYGZ+5MAIRRfQzgnWKDPotv7bGKDpxdV8AWsCL3ijLTh5NmU5tzy3Y+ROB9dYHPy
 sHB0/mC6v90I4gyE9HlZh43ClNqohR5o66+uFrrX6+5aA9OJbXSpggP4pEhtHbz1grZ6
 sxD3aRZAxH+wXyBEqfbd97YLCwT9iQJcUvzBPhq/QRYhQA8c+0mmy0s+zFi0BqROqdMG
 2E/YRxE8F85iFLuulnehaFT2fek3QmGwhPUMJkw9Ez+Os/mZJv4BSS7ZpiCYwiF/dYi9
 rq5w==
X-Gm-Message-State: AOJu0YxdC4G9UfAVf2gHumMgOpjhihghVk1EPbZNVq28lOPlLbIXbQ3d
 tSsIWRwuxcpzjgVSYJQHDxUXI6AAdyBpyGpVVGc34zG2hstrA2CWL3L04Z2o3oU=
X-Gm-Gg: ASbGncsZjZMDrvvxXK6CG6yLNmai1N+32f5pjQjgIP++zIXYCEtpAtypA32tszUKQ7l
 QlSzbzslIvvW365cluJ64fYlsOZDQIZC/99+z4BJwdO/vYLDC36OEISYPAzfEoaYbrAwEXJ0SWu
 IG7wzDqr/ez3P6aiivT2yebBN7Fr3ANpXyzZdEiI2fxIn90qWDLkAcfuINtVQikM+ETbXF4AKGp
 JOl0YajhE/QJJhESwdDfxQ21PwMZpgp2zidI/2Tan3Pi4yh+nIZJw7luBE9pMrHGWckNtyQyDWf
 Cgka4OteotohJ9SuM3F7o8V6WjnWVPsIDhpwKFbHMwkhsoiY4qLZniY7FPqqUkXmk2Lz4Q3kNJ6
 j
X-Google-Smtp-Source: AGHT+IF48LWoUp3gaBlUHJXyzRN56ggEQoe69CM/HExIzveEzhA+FrFJcNuoO6cUtov4DW8fNTA5bg==
X-Received: by 2002:a05:6830:6817:b0:72b:a175:2f0d with SMTP id
 46e09a7af769-72e86161bbemr234702a34.0.1744316061228; 
 Thu, 10 Apr 2025 13:14:21 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72e73d8fcaasm685741a34.38.2025.04.10.13.14.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 13:14:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Raymond Mao <raymond.mao@linaro.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ravi Minnikanti <rminnikanti@marvell.com>, 
 Matthias Brugger <mbrugger@suse.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <20250327231045.2713024-1-raymond.mao@linaro.org>
References: <20250327231045.2713024-1-raymond.mao@linaro.org>
Subject: Re: [PATCH] tools: add pkg-config for preload_check_sign
Message-Id: <174431605975.2981499.16700740878918497020.b4-ty@konsulko.com>
Date: Thu, 10 Apr 2025 14:14:19 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Thu, 27 Mar 2025 16:10:44 -0700, Raymond Mao wrote:

> The cflags and ldflags of preload_check_sign depend on the openssl
> package thus pkg-config is needed to get the location where openssl
> is installed.
> This fix a potential build failure when openssl is not from the
> distro and installed in a varied place.
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] tools: add pkg-config for preload_check_sign
      commit: dc54d1e48052fe8712f68a8fcbe324602c7935e8
-- 
Tom


