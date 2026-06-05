Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98DFCD6E6E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 22:08:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4958E84932;
	Sat,  6 Jun 2026 00:08:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="D70xFU0H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6849484946; Sat,  6 Jun 2026 00:08:18 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 560F9848A1
 for <u-boot@lists.denx.de>; Sat,  6 Jun 2026 00:08:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-68bd9fce347so4275605a12.2
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 15:08:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780697296; cv=none;
 d=google.com; s=arc-20240605;
 b=bh+hRCfkn14f98o6wZ3ewePdUWXspDyTAMXPlFr4DQbQz7zparCB0P5WF7I3mUhtMy
 yYOazWPw+jV98lJ5KpFkiYvwsvbLRGyjEd1OEw6o1jSIgywK9sC/3RoUtReWXSJSpc5o
 0Z6cBav3vraKvtE6pcaFC+NliJmi7GC6HPkq28PVZJ1gf9ZzxU8+T/YMc3SRDN64b+at
 aLzkQs5d75hsq8CpMea9LU7nGAE2J5C/b0DqYlKlUh2fj1TlutUyPNPETD17j855Fhbd
 rWEySHszVgpmayVy/6cbEolxkUsktY5yPjdV5Y4U+1IyeRIY6ojDmWgFskdNe/PJI1tL
 PESw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=y+Hz8ZDa6o87QxPjIMedmrxOzR+RXWQxSSlis8GMCxU=;
 fh=Hlhgev5xB0xlM2njeo0mv1AJniEuivCiBjj7I4NN/4E=;
 b=ah2wdSFVpc21wwFrRfg1ww5HhXVrooUFz8J/VzVsfYzskVuFckN3y1Nw08UcgpFFiA
 GGbodATZ4E+CcQeFYXOX23XyqJ7BRxILqSwRCQVzeXvjXJfJq82FY3giSpxDjlt6yOw2
 1X5pRI2rHd2Qq2AiGNPzK5/Tfgi7slYsoncnJ1lZ94GRf79kgbG8x26VFsMaZfvb+AeC
 weyGZ27trDW+HRjbXhIy55mHISqTmu3uZLUFEUyHZL4zkde3SEGtI7Ou/F31V7RFdt47
 +burrIhhRNj28Iz8QPqmsmztPMYlExUAQjPultq3n/zxiqFuRdwaXX53PIzDhyQNXbnj
 3Wbg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780697296; x=1781302096; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=y+Hz8ZDa6o87QxPjIMedmrxOzR+RXWQxSSlis8GMCxU=;
 b=D70xFU0HHtymmVrTuOmXXVY3mS8Z8w5U7lhRjCKzpXKMhmJ5a27Pch854afieGGynS
 3Noal40VVCeQP0DzpoNO5Csu7kVbr5mFWmkMTKwfAOrbACNVlz0ofY1GyIypZgC5KExl
 Iolxdf+KaTgcHb+wfXeipux57ap/G3zr3eSJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780697296; x=1781302096;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y+Hz8ZDa6o87QxPjIMedmrxOzR+RXWQxSSlis8GMCxU=;
 b=sTpTjrnPhqwOqua9YHRO1yalKRiRNTs0pjv2HzHMz9+bZdzAGA8nj7/cjnJ2WbKso/
 xgu0oSbZX4nCx4lCCEzYdMxXTGu9fDTy7tkVvz784e0dCf0B0qvPDZ2m0d+N4RXTU+qI
 YF/E4wPcwrPl5BN88N8nXnkvI5+oL3snb/j0wbSLKEb9IJahWSaurpSXI3rYlChYA5Lu
 uuEYlUEvGXLrsuN+qzrbBYQ1u1tk8vEJi36anE2rj+rvZ6HbITe/EE2NOJc8iCELQfdz
 7qJ0VjtMjGu0+w9GTp+BAvCU9xFE0/aiG3ivTlL1w4Ftp5cL5EgOIE/ExeBfQrX9ID7q
 K3MQ==
X-Gm-Message-State: AOJu0YzVAdKvT5nI5xUaNLoxCQuAzCFGZ1Y9HAZwwgvjirgswI+rVQ/j
 dYDYn/CKUi6DEqOK3jZZGEoLdNsnIrb1KMFwg3IwMTpvggQHhdmWqZ5cd1BHNaWPwB+N89Bs1Tw
 GbKRr3Hr3/+EglL/JUWGDE6vkH6ojCQZe0QqpwPBJ
X-Gm-Gg: Acq92OHp6I3nn60vsrd11w1C6+yu/YM1FlQq6B1NyqlqZ7Y+wdl23PmickOPlBEpQ93
 blHbWoBkQXZhKyM8GfyVM1VN+IK5ty7jHXw48gOI9JS1J+bVZQ0q/OvK6RXq7Fhb4t20vxeFu9H
 OYAqgC1wDL6LlczAgFzBTNKPQPQNYHSWeTzncyqPl+BXoo4aOYJi1asrQZJVYFWKi5HcVXG2i+R
 QmmzFEGDcrERpQjUrD9AaO2Qq/Doe3LBTIShwsT6Mrg5CEt/w3KlnG1ozDPGW22z2x+GO4I5nG+
 Gib0tUjrcjEwPujn
X-Received: by 2002:a05:6402:2345:b0:68c:7812:745a with SMTP id
 4fb4d7f45d1cf-68fa504a485mr3244668a12.18.1780697295706; Fri, 05 Jun 2026
 15:08:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260527111553.82161-1-anton@binarly.io>
 <20260602182752.59282-1-anton@binarly.io>
In-Reply-To: <20260602182752.59282-1-anton@binarly.io>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 5 Jun 2026 16:08:04 -0600
X-Gm-Features: AVVi8CcEX7TWB8Xl3myM9EzAjMlW7sFV_fzfSXLBM3YWv1ohkKid8FX77NVDOuY
Message-ID: <CAFLszTj4Fy_fSHp-BLGDzWpbFJY9_059+ezLNkS+gj0t3VmtgA@mail.gmail.com>
Subject: Re: [PATCH v4] fdt: Check return value of fdt_get_name() calls
To: anton@binarly.io
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com, vr@binarly.io
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

On 2026-06-02T18:27:52, Anton Ivanov <anton@binarly.io> wrote:
> fdt: Check return value of fdt_get_name() calls
>
> fdt_get_name() can return NULL and set len to a negative error code.
> fdt_find_regions() does not check for this, leading to a potential NULL
> pointer dereference and a buffer out-of-bounds write during signature
> verification of an untrusted FIT. fdt_next_region(), fdt_check_full(),
> and display_fdt_by_regions() also lack validation.
>
> Add NULL checks and propagate the error code from fdt_get_name()
> to the caller.
>
> Signed-off-by: Anton Ivanov <anton@binarly.io>
>
> boot/fdt_region.c           | 5 +++++
>  scripts/dtc/libfdt/fdt_ro.c | 3 +++
>  tools/fdtgrep.c             | 3 +++
>  3 files changed, 11 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

(a test would be nice!)
