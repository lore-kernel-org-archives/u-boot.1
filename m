Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 651FCCCD184
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 14:20:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F82784550;
	Thu,  9 Oct 2025 16:19:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="s2fxHXJj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1D9184562; Thu,  9 Oct 2025 16:19:02 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6C87842E7
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 16:19:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7a9a2b27c44so851746a34.0
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 07:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760019539; x=1760624339; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oArpgLkPMcl3EhuZiMGQkd39/t6HFvGkisJqmQyU7Zs=;
 b=s2fxHXJjJwZdBab7Dm4f2r5KylFPSx4U5dGp4PnMMT8+Ls82uuWDIbKwhiovlRl+CF
 cR2Bds0Xzvtr4WuhJxLlzzoxeLGjZ2lyxdlpSuOnRkHbhS+tdLVzT5cYQZz88mIV1Xow
 zcwYCsx9G2EouW6ZIHbU+5pSd6xpUJYGDnQkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760019539; x=1760624339;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oArpgLkPMcl3EhuZiMGQkd39/t6HFvGkisJqmQyU7Zs=;
 b=Qg7mc6UwI0kAE0F9IhBaNyfIe94P6rS7dYvHt8naaHd6zfAOi380AeLvngD3tmub6e
 IOF+cBD/gi22kI4wa6Y2fZce4aELYo9P4LuJy2o3LClAJisoK6wa5OX+I/IddRHfIf68
 E3NOb/msCu6IefMQcR0Ugd4ivf5ftWL0b/bHovsdKTpr8grXjxbFbEGdkquWiNsc6jA9
 h0E40K3R1hJ2E5SXBZtOmTdAPjMAeo2T6ML3jV/y+Sr3AvtQSW+d60yhtqEgzXptOpBO
 ARCibyO6CibwKFbX84LqMl9Bqw1yHPUG3gLH+6GPMRfuQw/66W1xUjMtfTTlOBIcXM7p
 X2MA==
X-Gm-Message-State: AOJu0YwcH6Y4wLzpuBVDPNZDn7NgKdM3CdapY3WcSxDONzXRZvjK5WAx
 A2AkznKqDhzkpW4sGFk9ZfpQE9nJdTtnwAn9uj9d600NtseMRcqhRJ3gkzmnhaFQllHOLaUGZvy
 M1qCW3Ic=
X-Gm-Gg: ASbGncsfLmzSO4teg6dCIiVTlcxlqPOT4nCp8V0m6Z/E5EuYsxUma+w39ZZPpqmFHIK
 e4YQPPs5ywFSj19Dt5xeImAXPxDoVOotAJVKt7R6OmlrAfi0doFb0q3NDA7gLcFjQjHDKExadrz
 0CAsOTZHyxZAAVrBCW+S1oLBNeG0Aq2ideGC9ntO4xxGKy5A8KnU4nCvzXBTq58aXjYbLcU2NTc
 UDjEPXopGfANxqKosdxZf16Y2r76L6DetpF/vq9oVGT23w4tpjRtLwYkKQP83wjNzAeHm2TVBIt
 I11+LO1pPz4cs4NY0WSqClMw94+rahERv4otqqieevShPaaTVoKOdtzZrXYyixWvkhUrjPBRvhb
 oixbHs7mV2+uTTKY4Hqe5qsCRQn8q1IhfsSL5GdIBuztKHey+AjPCNBT3W4LqzUJYahp5IxaUKv
 sHGuY7EUkxHaBJ78ortL8=
X-Google-Smtp-Source: AGHT+IHr1AHkXDcdJaHOIQEFlDw/jbPuUvUear6K6cycyAa48V4b7lOq6ZpSA8dQ3VCy4RdRaW+zSg==
X-Received: by 2002:a05:6830:838c:b0:760:719e:8e21 with SMTP id
 46e09a7af769-7c0dfeefa93mr3884406a34.10.1760019539440; 
 Thu, 09 Oct 2025 07:18:59 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c0e333b875sm1221258a34.17.2025.10.09.07.18.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 07:18:59 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250926153134.3680852-1-trini@konsulko.com>
References: <20250926153134.3680852-1-trini@konsulko.com>
Subject: Re: [PATCH] led: Mark LED_STATUS as depending on LED being
 disabled
Message-Id: <176001953861.3159859.17515649272158969466.b4-ty@konsulko.com>
Date: Thu, 09 Oct 2025 08:18:58 -0600
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

On Fri, 26 Sep 2025 09:31:34 -0600, Tom Rini wrote:

> The LED_STATUS functionality is part of the legacy LED framework. This
> cannot be enabled at the same time as the new LED API is. Make the text
> prompt be clear this is legacy and add a dependency on LED being
> disabled.
> 
> 

Applied to u-boot/master, thanks!

[1/1] led: Mark LED_STATUS as depending on LED being disabled
      commit: f34a86c1ef0e93e9724c44b8ecb5e523c891c825
-- 
Tom


