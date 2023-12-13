Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C90CC4167B
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 20:42:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85A0B878C5;
	Wed, 13 Dec 2023 21:39:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nCKYuSuH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE3A487880; Wed, 13 Dec 2023 21:39:21 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F014B87872
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 21:39:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a1db99cd1b2so944977266b.2
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702499958; x=1703104758; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FAREx+6V2RtNFYu+BPu6qis8KsDgUHrDr/szdEXgFW8=;
 b=nCKYuSuHOdsCOT2A+s5x/cj04CnhkSehLtkmoSQwn+aAvS3DIz48A3qvCRPwHjEP09
 ebUSLEYDR8HrUMaYuUOpjSDm/ORW0Zn6BrZ1dOf6frUJM5DomR0bPqKiBMOu4hAKY2A9
 0oaM22nSFviICSSNiN0xOCC9rbzBn7/efhRqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702499958; x=1703104758;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FAREx+6V2RtNFYu+BPu6qis8KsDgUHrDr/szdEXgFW8=;
 b=P0/lmuIAG5MOPbkuxdlzMEnvw8Vr0FhHQhoZ1DxR7Ssv6lD5d1G8rM++GJZaaYU4ag
 21+p/fTvUtfZINwms+k8gc18Az1DWVbIJFRuJOBiTA4RuNi30BtSGw9T1Y9dbzsiwuoD
 hovaryvwZApJZ03AzivuPQZ+Au0eI/MMhqH5gwHwMamWmbBV8qlD++7j83KHKwZRzsbw
 0sGsBxb7vjaAyjr6Ww4DlkxSoRGIx3D5NOYerlnDiT5ts6/r0FzJ6s0/TlJ1MruwltQ8
 4F7Csm0WB0UTLkxUdA91yyge0qaJfcSKMV6F+wS/mT3EwWpZUdA7Yg2rpzd4E2uLizVj
 uHGg==
X-Gm-Message-State: AOJu0YwNnh5HhLg0ABFFdMWFYXSAgBwp3MLiks2kETXKhbvGJtz5FjsD
 uYwM3eJ6DYLDNrfZsfVBzC6PxnBmZOcFA78oLS9WLA==
X-Google-Smtp-Source: AGHT+IH+7uQCRGeEL+F8fOTgihc/PZoP/rdldnw3zRQuYvksIXkXUMguL3sKedI7J/mex70pgyOlHhfNGmgzKNjXvKw=
X-Received: by 2002:a17:906:c019:b0:a1b:86e2:a1ab with SMTP id
 e25-20020a170906c01900b00a1b86e2a1abmr2923551ejz.223.1702499958347; Wed, 13
 Dec 2023 12:39:18 -0800 (PST)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Dec 2023 12:39:13 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ01wYe-kKZhfGAhn3NcAEe5nywAAJqQRHnRnxvC+w3Qzg@mail.gmail.com>
References: <CAPnjgZ01wYe-kKZhfGAhn3NcAEe5nywAAJqQRHnRnxvC+w3Qzg@mail.gmail.com>
 <20231118215727.95086-1-heinrich.schuchardt@canonical.com>
 <20231118215727.95086-3-heinrich.schuchardt@canonical.com>
Date: Wed, 13 Dec 2023 12:39:13 -0800
X-Google-Sender-Auth: JJ2gLr3rWlVVRcX5L3g0yQ3MY6Y
Message-ID: <CAPnjgZ2bSNc7HxwjdgTdGQLqT7FfT2Ev8QQanP5C2SmmuXPKsQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] test: unit test for acpi_find_table()
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

On Sat, 18 Nov 2023 at 14:57, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Provide a unit test for acpi_find_table()
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         new patch
> ---
>  test/dm/acpi.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot-dm/next, thanks!
