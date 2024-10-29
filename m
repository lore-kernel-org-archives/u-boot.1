Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81EC4D3A661
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 15:45:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4ECCC88FA8;
	Tue, 29 Oct 2024 16:45:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="f/6Xv5wN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 998F389185; Tue, 29 Oct 2024 16:45:34 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAE5A88D29
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 16:45:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a9a628b68a7so856695866b.2
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 08:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730216732; x=1730821532; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iR/1AggyICQR7aqByw+mR5RgU/HMzDs042ChG4MaWOY=;
 b=f/6Xv5wNEUnhVALL6zlZfqnesm5jFkQx0BQL8eqXSGwVTw0Rdadx5gMAtMpzzjkbGJ
 xzv5Kcym4ZR+LVCWXW2Ia1hdxCGRarApZtkRWlbVFc5UGyGQJmy+Blcpo/Mj9w8mHXGO
 /SDX5w23cVydlbyxZGmIJmlFSrHJNePHzZz14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730216732; x=1730821532;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iR/1AggyICQR7aqByw+mR5RgU/HMzDs042ChG4MaWOY=;
 b=DC6DPe63KdnTefNMVAYNmB16oGeg0cbcSTdFJ+nznN+O1tAdq+M3/jlriz+nxMDHc3
 pEO+yr6DO5sP0K6MdJIG7Y3D5dxRMe39i1STUPV0iv/J89/yS1t6BI0/hYjk+W9mLrJA
 J6+NP60/G9STvF6t/WRcK3scsxBva48+INGjKrvageVey58tQjOULyfcNlYxyRGGJTl/
 PITQFNdbD+3jH2HfIJcJ6U94NeyD7btn7cJEjFguDdbUHvINNX3CEx5Z9DttIcDS5lkx
 l0yrj4+omal7udHRRqGmpB7mwJ6iHpM4wPoqGf+4f0K8lPyU1tsttNx/TnDu19rxD+nF
 Ahww==
X-Gm-Message-State: AOJu0YyuVXEuyMbRUWVf98J+bmn4jBGWhmzmwbxc1PLoc3Kz6UvjSzSA
 Jp4R6Rj5gz33v6crBBthasIrX07TgkeATXKQJOsCQaooNe8+wKjoiO0jFQlVamAXadhQHar7BEB
 Na2eyr6cqInt6w4LlK+WHq6sQdNkpwm695UoR
X-Google-Smtp-Source: AGHT+IGdvQ5gPmFgnUZx1zwNKLLXiDPMXnHz4GtAFCFFo/LmGXEbDu+XVBJUwKRVKIildGOQNH2Q2R+JtmRkrcjsxzk=
X-Received: by 2002:a17:907:7da7:b0:a77:c95e:9b1c with SMTP id
 a640c23a62f3a-a9de5f07cf2mr983554866b.27.1730216732249; Tue, 29 Oct 2024
 08:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAB2y086kRpFK98gWm-8FVfC5me0UePwDMZdouvm+PkstaZkiEw@mail.gmail.com>
In-Reply-To: <CAB2y086kRpFK98gWm-8FVfC5me0UePwDMZdouvm+PkstaZkiEw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 29 Oct 2024 16:45:18 +0100
Message-ID: <CAFLszTjxACbhLMGhVMsCKmA++StC+SMXim221V7Rz4546rDKrg@mail.gmail.com>
Subject: Re: Pincontrol driver
To: "Jayaramudu .D" <jayaramudu.d@gmail.com>
Cc: u-boot@lists.denx.de
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

Hi Jayaramudu,

On Thu, 24 Oct 2024 at 06:58, Jayaramudu .D <jayaramudu.d@gmail.com> wrote:
>
> Hi,
>
> I am working on a board which AMD soc, trying to enable gpio at uboot, but
> I did not see AMD pincontrol driver in U-boot 2024. Could you please
> suggest any info.

I would suggest you could look at the MAINTAINERS file and cc the
people involved. Also it is a good idea to mention which SoC it is.

Regards,
Simon
