Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BDE6C4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 23:32:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA18F88432;
	Wed, 17 Apr 2024 01:32:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Z3xq1i91";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 275298842A; Wed, 17 Apr 2024 01:32:55 +0200 (CEST)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E291788422
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 01:32:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1e2232e30f4so37939555ad.2
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 16:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713310370; x=1713915170; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=S77414911nhHe4+p2tU1gUXKsghfppBVwQXrtToGlfU=;
 b=Z3xq1i910gFXMEjxaPdNWrDiKEKUYmECVtw73vI6si0xZziyg4wAK9106qTqUC4up1
 s0DIXl3vO/Ng2hmU+tyZzDKbiczQoREQfgiy1ZQVRFo73sb/NmVAZ37art5zYuHI4j43
 LLefm/jCqTyc2JTkj6fmRPWbY3AEwFC6ZyGUcne3RFttZAnK6OljSoj5mAh+m77PvBTT
 kOQaJF02DBg1aMXxoHMhkG3/Z95CBkk0hLK2wXlh4g1a2mzLqUaYJPNjYxp70UBQZDph
 vZDIDj7hUGXuxCNSQTTjtex1rsHD0BL2FO5aRZWWWaOsqvAaA7rfvcHSBl2IHEuuYv7+
 0DZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713310370; x=1713915170;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S77414911nhHe4+p2tU1gUXKsghfppBVwQXrtToGlfU=;
 b=k0S1WjXNyN15VgsTORXRqcpC4z/FfkEUMPoIXBB26Vc66QV+0lB/dB+SQ1C2CdqDp4
 VP2R7tjkk8LauVhVlZE/UvK1VNpp9nCKBQXQtdEI4eJiM2Q994V0ioyO95JPzXvGCTkm
 dz5oT90YGSyTi48tZpTvQZlf0ZNHgLHg/X/VvDZjFvLf3FaWqBGQlKiTvqwNqKJTgcaQ
 aI7puh2YB8zwn3gtirVBesY7Ri7NcsSVp3OKHDVgvjR+r0xsPWkF+9awClFUNqpV0mQi
 Oz23Om65TtnuCeDgnF4ZolCK6hYKp1Eqof03Prhcaq/Asdj2lDvtSAoRy20PNbjj6cT6
 FmUg==
X-Gm-Message-State: AOJu0YwA4ZK/7LFOhZmMaF7iN7p9hcnyv8RshPcbkCIef1lYrHQAZerV
 ldtbcJ/+MGr+KlkuPLTcwrm5v+3WhBUupGf6y55UHd0kJteK8m8wwlCAJMZbpJ2ZirLy5QiEplB
 cEkZvTp8gzdrxJ6e+tRXUBQrK5qBG1rvTUOhCFpw9nC5tEbLi
X-Google-Smtp-Source: AGHT+IHMwMIWTxnftu6Aj3k9gxnr0uoG4o519UdGEh6ZCJwIa9GZzxl+NWyU5h7SFMaz2yvRTaIMKYeTRyg772Svq2Q=
X-Received: by 2002:a17:902:da87:b0:1e5:556:60e2 with SMTP id
 j7-20020a170902da8700b001e5055660e2mr13645361plx.5.1713310369757; Tue, 16 Apr
 2024 16:32:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240416190019.81016-1-raymond.mao@linaro.org>
 <20240416202617.GY1054907@bill-the-cat>
In-Reply-To: <20240416202617.GY1054907@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Tue, 16 Apr 2024 19:32:38 -0400
Message-ID: <CAEfUkUKiJO1K_aWW+DwAFzYybD3+z5-6useR66dSRqaqhg++gg@mail.gmail.com>
Subject: Re: [PATCH 00/23] [RFC] Integrate MbedTLS v3.6 LTS with U-Boot
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, xypron.glpk@gmx.de
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

Hi Tom,

On Tue, 16 Apr 2024 at 16:26, Tom Rini <trini@konsulko.com> wrote:

> On Tue, Apr 16, 2024 at 11:59:56AM -0700, Raymond Mao wrote:
>
> > Integrate MbedTLS v3.6 LTS (currently v3.6.0-RC1) with U-Boot.
>
> Please look in to:
> https://source.denx.de/u-boot/u-boot/-/jobs/818534

Yes. I am aware of the test failures of capsule UT and stated in the cover
letter.
This will be addressed when we have agreement on the current approach.

Regards,
Raymond
