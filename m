Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42432CD98ED
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 01:08:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 564CA847C3;
	Thu, 18 Jun 2026 03:08:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="L3Ni1R2c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA12184908; Thu, 18 Jun 2026 03:08:24 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43942846B0
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 03:08:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7e6b571750bso352301a34.1
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 18:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781744900; x=1782349700; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pckSQrGGYalKUkw6zi8sj79t7x7TshL1TlBVB8pMAXI=;
 b=L3Ni1R2cbrnQeJJhVQ6Jo91nCVePWil9Hiwzq6zayHAnDlQER4jPr0Hia+t1vHnBcK
 xOyCTspjSqy3oShIglwu6k4tTQgn1Tzc5QcRUOeY8DvJ3Y6nx+PsnW/yD24fr0/KLkK5
 foY/vmKAepYX1t8pbtuGOWKuWUv9QLKObgpUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781744900; x=1782349700;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pckSQrGGYalKUkw6zi8sj79t7x7TshL1TlBVB8pMAXI=;
 b=A58hRb/5CmnGsG9c8GnEkvB7wbHeCFXTSxbAEb10/mduwiS8XgENe3xfizXs4rZy7v
 spRUras+++SwRmlINoSRW04eUxbCWMpXipkxb77inxytbfV/jh0WZ46rYFZ4S7nYlu+1
 kivn7W+qmm7BJNDsEBqGCxF2RAsCXJYN0DWCPfRZn6OM0Pmq0bD/ZcIrJ2qWbXVQFYos
 vwC7H6v8QKxKDCCFjGZHWCUG/7v2EO4mG/JKmQsMR+iFnNd1Q7UIlajioExkqoK9s8Wo
 5argc5vQo4BvZBdMUjfjB7VzWI+xMCgfEGN8uXaa+ylTyfm9qwQr82/0sfHNU3wOn+0k
 gymw==
X-Gm-Message-State: AOJu0YxAXu1y3B5Llq5921FCVXtzgImckxCtlLAs7k0lNROdOH68N6CX
 7n0JDWcBiG7/KWZIya0Dn51WAvHvgwJa2qQIrnFKq2ktIa+ZuaXDTB7TR+SsMlHuV3EfI6IAOco
 vjJb7ZZw=
X-Gm-Gg: Acq92OHu9Ntsh3ojPNJ3x6hA5EhFySPaBNoCRhk9R91L6NfDsqPmpPlQytOxTKAxtVZ
 hos1GOA4z4OMO6yf1eWsdJMXnP0wHlCI/4vla2nC3TMdf11hUMndxDrrvEz5h+UFVqVLetSZaY+
 Y8IHQ8d7KiCN6rgh7UrImACOUBlH2QJXSttz3a1J0toWlKrL6qpK/hgF4gmAfzMCXpNfZRucYFE
 sJKgHuSxs/AKWCnkM700zyT+BM5MV40q/psF7bL/tLTpeJj7xCdtgk/A8ZOAFXd8NqSk3Ts45oW
 2alKaEFxqG9A8QD08QE8wHTJ0z38FBbvA+DmVaondRCtLv+/9DmrV9wOREQW+cP3GYSUJabxkTi
 NvJ0x5L8lghKdOZeRSRLshWi8NQ2KQX/np/9y9C4Ava0uJejsi8L71HgcnTbj1DIsrvp6gRIwDU
 Yd+kcJzFlw7kBH7464CHBjEiEjDCSjvHghJB20CELhPNWYrFlhiIHdP1NpuOT6wEmsCKhnwsWaH
 Pc2yvJX5ply+pqIhijp9sJe3cwNcE/NTochctw=
X-Received: by 2002:a05:6830:927:b0:7e5:68d0:462d with SMTP id
 46e09a7af769-7e92072ed5cmr261428a34.19.1781744899979; 
 Wed, 17 Jun 2026 18:08:19 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-197-245.totalplay.net.
 [187.190.197.245]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e79f6f9f48sm10464553a34.25.2026.06.17.18.08.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 18:08:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Anton Ivanov <anton@binarly.io>
In-Reply-To: <20260526202218.4004070-1-trini@konsulko.com>
References: <20260526202218.4004070-1-trini@konsulko.com>
Subject: Re: [PATCH 0/2] dtc: Resync fdt_check_full function
Message-Id: <178174489928.2512035.5578705912927416612.b4-ty@konsulko.com>
Date: Wed, 17 Jun 2026 19:08:19 -0600
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

On Tue, 26 May 2026 14:19:26 -0600, Tom Rini wrote:

> Hey all,
> 
> As part of the resync to dtc version v1.7.2-35-g52f07dcca47c from the
> Linux Kernel, we missed updating the fdt_check_full function because it
> exists in its own file in upstream dtc and the kernel doesn't import it,
> as reported by Anton Ivanov. This short series brings in the upstream
> fdt_check.c file and then implements our size-saving option, but in the
> modern way.
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] dtc: Resync fdt_check_full() with upstream version v1.7.2-35-g52f07dcca47c
      commit: 37fef5ab88d1134fd6b8b53090e0bfa442732e24
[2/2] dtc: libfdt: Introduce a can_assume check in fdt_check_full
      commit: 487994d65cf305e943e4fd4efb56283f214f0611
-- 
Tom


