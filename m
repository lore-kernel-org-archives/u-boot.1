Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C3F6CD4F3C
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 16:47:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D442584688;
	Mon, 18 May 2026 18:47:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PGLW7w0z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3903483EF9; Mon, 18 May 2026 18:47:34 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2799784119
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 18:47:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-439b2aad735so943299fac.0
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 09:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779122851; x=1779727651; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BZY1ZwWdsrurtgvDDoIewio+GlwSlJZ4LrRwkSXCbfw=;
 b=PGLW7w0zvatp/LOq75C1fNKw7xZCT5FGvsniElCNLEe8LF5K++7yuPgk0TbehvKz0p
 m3YqY0JHmEBoD3SgEE9Pi1JcFL5rdeyXVOUNO6hw4JkSRShRt3xN+upGZ4rCuseay/nX
 B8gmjgYVsBTBlOUti/PCZtDEHp94hcb9/Cdj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779122851; x=1779727651;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BZY1ZwWdsrurtgvDDoIewio+GlwSlJZ4LrRwkSXCbfw=;
 b=UfxU6g7K9xdPnkXXmGyWWcFyugydfDuJjABhCqrV1J9LZyxx59cy+JbSMJDfGle7GZ
 wdSqEKww/53MOFhPu2r+5vzGj55Nli9f0lRMBU2+vN/mO5P5wGuvyc1h1CdW6mZUXASS
 KuhxW7jO6ykX44U1CyMPU9nhcfGzX8v8Huk8YXhOzu3vW9O+wvNds6iCe36qPE5DjG6d
 0e+kODYqrV+QyzCDW6H+F1w0VhkCxERliup0UfEoeoFVh6ohl+ePeQ1Nun+9rtLMbNc0
 iiLDNWVsZ+F7feTNH/g1vKGuGTInD1xSmb9DcDwtAP4F7fOndLVSlMLdDODgFsSozijZ
 s1Og==
X-Gm-Message-State: AOJu0YwlF8sa1kcXj/lFSll0fePDPKhlCqSMtaaLKlyRw/ylyQcEkjRa
 dEUFD65q20yjzg7wSTYFjIf2v1ayd1CMzRnMjdi+iYzYFzJ1yOkfwxJMQ1xfGtXCcoTVYIWL0g2
 vwDx2MMNui4l7
X-Gm-Gg: Acq92OGVdh4ZUtc2ljjUq9dxiJP6QdHmycKulHTT235F93bWF/DEpESD9NL+Tn0ggCX
 QDjAbx6Nu/C6gAnKpSoz1Kpyx7Ig9wDov2dBVR7K5XRjitGSShlK7s26PuGx29W5aTjeZV2Pq6e
 6ttJFwaKVeDveqrCfD+ReOR5wvR4Jws/59954kc6mlO9S0y/H9/U+IfQpK6soELykKO/GWr6vFY
 28B2spov5Ci0F233lR0bAExULNdut7Iu3HNXsFBOJzIP6jfx/hZsfr9kbai85V2IVVDZyWi2nxw
 YXhzaOL7EC2ecmjqcOasxIN1FlBohp2UST0pd64QuZ3eGLPPje0aDUamePPVJVlg0IxummAn2q8
 ewa4cMH8bZRcL0f75Sk0VTh9RyNIcRpSg3rtTSeyIdabpafay8aW+f9cVEcl5atnOI/gDgCLvhn
 DN53kQzYnY3V6fN7olUp0GnM8NN1KemrcTvfsGuSZx9E+75toDuUEeAahu0D2n+coMRv/xdrxrQ
 42uW1fg6vjfyYyXmjbyClDQa7uuRgOews67nySIBYwURfpT2VopAdJ4KPxJ
X-Received: by 2002:a05:6870:21e4:b0:42c:d92:1c68 with SMTP id
 586e51a60fabf-43a2dd74a39mr10722327fac.21.1779122850820; 
 Mon, 18 May 2026 09:47:30 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a957639b2sm4517106fac.14.2026.05.18.09.47.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 09:47:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@nabladev.com>
Cc: u-boot@lists.denx.de, Peter Collingbourne <peter@pcc.me.uk>
In-Reply-To: <cb6e2933-4910-340c-898b-c25be4d87bb1@nabladev.com>
References: <cb6e2933-4910-340c-898b-c25be4d87bb1@nabladev.com>
Subject: Re: Please pull u-boot-ubi
Message-Id: <177912285019.389050.6949274943548009991.b4-ty@konsulko.com>
Date: Mon, 18 May 2026 10:47:30 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Mon, 18 May 2026 15:43:01 +0200, Heiko Schocher wrote:

> Please pull
> 
> The following changes since commit 215496fec59b3fa09256b4fb62f92af46e2ec7f9:
> 
>    smbios: Do not fall back on devicetree without valid mapping (2026-05-15 08:18:11 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


