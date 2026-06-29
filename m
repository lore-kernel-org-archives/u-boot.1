Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF7CC43327
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 14:51:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C497B849A3;
	Mon, 29 Jun 2026 16:51:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TXvYVYoK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58AA5849F0; Mon, 29 Jun 2026 16:51:04 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39F3B84942
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 16:51:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7e94b0aeaa1so1656773a34.0
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 07:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782744660; x=1783349460; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fuB7SjjH/es3aQmSphw1nXmqxrsiz8eEVyBaQgBq/oM=;
 b=TXvYVYoKDLp0RJLYP4WwC9LbYz1hXGVy0lEFpufrMymC5IA2IOEYlbIQxZRS6DV4wG
 xm3THJlMBbnwhqRbovm8K+Bfl6Z69ugF8RHCH7fOMsPdk9NK6g5Kthki7pTO+LLW5LNz
 HZpnv5uZxewa2+frB2QlUYZApezBQ2wt6we8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782744660; x=1783349460;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fuB7SjjH/es3aQmSphw1nXmqxrsiz8eEVyBaQgBq/oM=;
 b=Iq6diph5RjkGvBDoWtDmxqB1L3kVJYu/Cwj4zs2JKpqq5HrHKhapozxp2jKv7ev/lP
 1LGIS4tg4zdDJonveXrCNqBGzmhvIH0XAxvGC2U96uNHMeWAtgg+0iVZsz7unjddhH5j
 Dxoh0PgVJYokCOAQcV9FXc+eBOdBggvaFn8LFnWvdqtrcPkikIc6UAehaASwD3hFlnlq
 8GWmW5xTGm/KhW9zmTgBXely8R4F92SHuCrxI41AgUy4WSZa9evndKbPc4Nk+RHPMMYq
 N6hPo3jl1AxqtWdhr0kPUoGAi60EIz8i1pIonNOjenIlq6QkeFe6qafjfePaUi3M4nZB
 majw==
X-Gm-Message-State: AOJu0YzaBXNQcrxWH8QZ+bbBOfeOCizEw2rBM/TZtRo3kExCQvo+mRLE
 lACl5tX+skyfG9X8s4gT6SeQBY1WG/2PLAjKz7V0rd3q54GkFBmvfZ9atBMYkOFRtlM=
X-Gm-Gg: AfdE7cm6OtjfSmHIxSUtATTy62khrZBx3XZZBceGpcpC047LU6Y24ZFlCWMzPVZ/zL0
 B7fXuAPWOGCWR4CRgEGXFLP/UuyLnARkwFGt5PpeppRRbrHBxbgVXYw2cONgYOfgS8f+LaC0YkC
 bHNnROIcoU+BLcesrK63ceZdgTKEhuWr83C7mdzzFT3o+lwh/zd7TPXWFMEg18rWWLg9XumKNtM
 bSS9a3mPMhhEMS0UbdOpwe7Hecdk3oFzmZ7ljeSYL+HyaeGImEOmqFv5urm3YxxxyfypLzBY/Gr
 8QSAtOxfEGn5+KZC/Wt6QzGiXIvCc2B+tOCmJxBfiCrhKZbGzUn5uVh8y7C99bmRmc+Sjx0738C
 ziCe8jopUoSLYQvKB0Yyz7ymxOHcloK3KWorayQ3mMmyO9bpBP7/N8IbFi5xlH398lkDkM1U1iT
 L3y1OF6muETn2tP041nl6wKf9fp/AfNhAI78op11golUCrp2B8whfk69cEq85TyD3VQQPW4qm6T
 Hwaw+AVWsH/yZXbLbOpY07EHNSXj+5EzpHEOW8=
X-Received: by 2002:a05:6830:2306:b0:7e9:df1f:6a19 with SMTP id
 46e09a7af769-7e9df1f6b5amr2039979a34.7.1782744659785; 
 Mon, 29 Jun 2026 07:50:59 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-245.totalplay.net.
 [189.203.103.245]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e9ebf89176sm96a34.1.2026.06.29.07.50.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 07:50:59 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, aristo.chen@canonical.com, 
 brian.ruley@gehealthcare.com, franz.schnyder@toradex.com, 
 frieder.schrempf@kontron.de, krzysztof@kd-solutions.pl, 
 mathieu.dubois-briand@bootlin.com, marex@nabladev.com, peng.fan@oss.nxp.com, 
 ye.li@oss.nxp.com
In-Reply-To: <20260627183038.3071171-1-festevam@gmail.com>
References: <20260627183038.3071171-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-next-20260627
Message-Id: <178274465874.720894.4943175857366646142.b4-ty@konsulko.com>
Date: Mon, 29 Jun 2026 08:50:58 -0600
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

On Sat, 27 Jun 2026 15:30:37 -0300, Fabio Estevam wrote:

> Please pull from u-boot-imx/next, thanks.
> 
> The following changes since commit 63f6cc8ba618396cb9c0161bb5c6d217604ae1d0:
> 
>   Merge patch series "Kconfig restyle part 2" (2026-06-25 15:01:03 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


