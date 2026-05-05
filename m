Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0CB4CD3427
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 17:57:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75427848B8;
	Tue,  5 May 2026 19:57:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="R2rPnWv7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EE57849B1; Tue,  5 May 2026 19:57:35 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A946848BB
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 19:57:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6967080e6beso1698364eaf.2
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 10:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778003851; x=1778608651; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AhZ6z9UxrycoNfOUTljOFNPhx6M4cZHAV2pLQYOiUSU=;
 b=R2rPnWv74051SzgZOUiY2hoWh9SmhJM6bvvH7Hho7WI829A4tCH7SDYgNM8fdW+Xiw
 IxQtzvpOM037cg0xTFpERucbkfNs6Ev0YxStUQR0HrciU1qZk3zMTl1kc7+BM4t4S0+V
 o83J+XiIPrCnzVYJLB4J/Z9W7YX8WqKv809lk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778003851; x=1778608651;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AhZ6z9UxrycoNfOUTljOFNPhx6M4cZHAV2pLQYOiUSU=;
 b=GQ1wJtrG9RYcVm2GlpLUgn0cQT241XQjNuM7USE5bBLJmrm7r8s97M2sAQ7kE1pqTO
 cH/8/gCTNOjU6pte6QmnfyU1JR+7ivtAkPp08Oza+APc5cskEnc29sIBB9cdEYFx/ie7
 hfha2yW0AhRGx0dj7FXIf9LVgCepussPG00lDoTIoRG+QSOZ8GwbGzL86H/cYtveBw8t
 GLH/mG11TnIvZ6gG3rmKFAtSnFRx4RIWx2YEI+b7KPz6L102bZeUzSKmGjgwcwawrjQ7
 ilkz6B53gnZh27k9xud3ZGCWtjLP6R3DlOnmo64L9/CnVLdCDpf0yE9hoNu1t8fuVWXd
 b6Uw==
X-Gm-Message-State: AOJu0YyH8YK2qitY2LzmFzfYxxh9IvFfc0I1OfoEnkQkd1eywmglDwGU
 ffG0CilXSqMylRfhIFWSdPB2nm7xLMI6eYIlfl7InP0W5plkwNmNF3IuBVwM/D5kmiA=
X-Gm-Gg: AeBDiet+pH8Po0wMWG7c/Jbuxi09Bx58hrkTQ1JUfPe5RpEvxr3aM/gqrkoEyeZeaG3
 1BrwwO18Bdn1lFaUrIgmzYKh2malIaq04V140Ek33vdJCoZQTvZmc3mys/QD4AhUIHYJiBDqzf5
 wzg9QeEYJeeW3PjWbB9gepbksSu7Nj0HM2wcOWK3kFlmMT8QVYkUH7YKeBBeI8fj9iGDrcdvA6H
 mxrAT2jQ/UWdzbjI/id7u1caTYRJMwIFdxYkEaiVl/2wmkoBepsYqXTMe9oDwgNwoc4xndT9AaN
 6sYfjGgd5zWZmzZSRtjNpUSelXJc4S4X5viEcAnCLyWMHVR+Ll3ksl48/XHzvAj87QQ5yJoRgfm
 Q+Afhq9u8d/bSN+BrHxVTDFCWO9vO4rPCB0XenWWDyrx+SohWM3PTepGagXv68q+cZE254ot6d6
 TF1Q2ZohCyJ6DkUWh5EP1b5oLolgL9j9c2TeR216tcqnZMbdQL+cS5wrBnl/8nfHSfUOg42SW+S
 C/fG38MBjEAn1T54QSAgU4M4XtWR9DYe9bp/Tf3nYdUlGEoe3caI85MPU+X
X-Received: by 2002:a05:6820:1628:b0:68b:7825:e68f with SMTP id
 006d021491bc7-69697dc877cmr7579456eaf.49.1778003851015; 
 Tue, 05 May 2026 10:57:31 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43454d324e2sm13561561fac.13.2026.05.05.10.57.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 10:57:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Francesco Dolcini <francesco@dolcini.it>
Cc: u-boot@lists.denx.de
In-Reply-To: <20260424104213.303752-1-francesco@dolcini.it>
References: <20260424104213.303752-1-francesco@dolcini.it>
Subject: Re: [PATCH v1 00/10] configs: toradex: Enable EFI
Message-Id: <177800384966.2525131.11678374465120149030.b4-ty@konsulko.com>
Date: Tue, 05 May 2026 11:57:29 -0600
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

On Fri, 24 Apr 2026 12:42:02 +0200, Francesco Dolcini wrote:

> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Enable standard EFI support for all the arm64 Toradex boards, as required
> for booting standard aarch64 Linux distribution, following the ARM
> recommendations for SystemReady compliance [1].
> 
> The RTC used on these boards is not currently supported by U-Boot,
> therefore it is not enabled at the moment.
> 
> [...]

Applied to u-boot/master, thanks!

[01/10] configs: apalis-imx8: Enable EFI
        commit: 2c34e32b9b684b77b7799ac9962b22d10f271ec3
[02/10] configs: aquila-am69: Enable EFI related options
        commit: 6912d6190912fa09765202fd8f45db560090a9eb
[03/10] configs: colibri-imx8x: Enable EFI
        commit: 398fca82ae37c3e627b6839c9dd2e9cf06ee7d29
[04/10] configs: toradex-smarc-imx8mp: Enable EFI related options
        commit: 1bd90ebe2ce1e600c7cf35ff9879ada3ea639843
[05/10] configs: toradex-smarc-imx95: Enable EFI related options
        commit: 1dda05fe997f8dfeaf3c602eb2873eb835236cc3
[06/10] configs: verdin-am62: Enable EFI related options
        commit: 3a304e7347aa7dc8ebcd957da9cde65b8e7a098c
[07/10] configs: verdin-am62p: Enable EFI related options
        commit: 1327724ffdba25e6b9c0c16226cf96c1de11eebd
[08/10] configs: verdin-imx8mm: Enable EFI related options
        commit: 9f5c862eccaaa5d88901279ec66da738361c942e
[09/10] configs: verdin-imx8mp: Enable EFI related options
        commit: d52f67197bb9e0fcda30f9309c9c873e21f7c643
[10/10] configs: verdin-imx95: Enable EFI related options
        commit: a97668cd8bb8394609765ab209da000f410a563d
-- 
Tom


