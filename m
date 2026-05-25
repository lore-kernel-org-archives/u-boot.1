Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4EBECD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 22:43:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FB5184942;
	Tue, 26 May 2026 00:43:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="plo7rTSZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B80384881; Tue, 26 May 2026 00:43:26 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B748848C5
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 00:43:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-47c7b282e21so3880802b6e.1
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 15:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779749003; x=1780353803; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2q0GDPB7SIsyqnbamXy74B/TFo1LfLuxA+BC/fy5UyE=;
 b=plo7rTSZ0yrMeDPn9uWyQPSFnoR1V4wUkKlp68WUABHdUqi9T3WhS2NmhMmmX5+HgR
 2qaviMS9VcWsUc3cKF06BTmPaMFsYCwoMt/hAZWhxadP733cxsjbE5/X+MNN0uLtcC03
 NLIK33LTb3mdHg+44aG8yDiJG6y0U/ygrlOfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779749003; x=1780353803;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2q0GDPB7SIsyqnbamXy74B/TFo1LfLuxA+BC/fy5UyE=;
 b=eRhVf9qVpkKoIqdZAfElT818qrrQekp5JCWgP1OyMBnjBzFwpZGJne034wJSOc3tpD
 ovxY29rZ4ImnptgkAeXcJfK9CDCF1uHqjZ15D8Y0BeqeVUOMLMleojhUGkgN6s8hfZSB
 hR/aqwSQBJAoqlgnarA0CK9E6DRQbpFbCj4/zwVLFxVM1CYoFzU5wLr+KGlfb2+y3bAX
 3ERetSu5J27Z8E+2wYRxY1EQF0AxSXdsQ6DJwI8rcieNNdRVd3xRLKr0F6EPdd12Z1rk
 RFWNFSyLMypg+vHatHyEtLOFaUo/fDqDl0ohjolmKNnbPnAqDARaNrXfAWIvKEvCL7oN
 UoPg==
X-Gm-Message-State: AOJu0YzHFZf6BIh7dLrbhCzvSlQ9T6klhHccXsVtcpkyA++3vI4P+/0s
 hUzQNqdpyAGo7E996yWxw1krYk0y3ckM2I/TnWAE4sGTgVdANMNy7N0VP5oo8PWv7l3Af8yaIHJ
 hJbFw7qA=
X-Gm-Gg: Acq92OGU+mwG1jtD0TaTE6AfzFfjdx35PFFBaTWPNnanAQxzjpEmg9VxVNc05g32EBd
 mV+DP6L8u11cTj7KXASJtLg6n24jyWmqXSj5Cm7chg0osTxrEXr40oAAP7Z7duwm9LrYTd8U7WP
 xJq9WmqaFxMfrKbenk7J4pt3GzvGh3u3OF1Za5wTlbzp4Fg5m4+qFzBHXyhX6w0gJepIflSB9We
 DMzhHUb72LfCdbfGgItwWFcbiuYHZcf/mbwTmu4fvnjNU7npGhILV8KcMXe8N6KItUnLVPXsjT2
 tySqnT4aYwMkQzf3I1hGgpvsJYbbGBOZjJnpPNuJael8WBNN5MFYpRxMMTpT3CUVn0nsjMphhJP
 UhcH8GKemQWSn3lDX0bOVQ1ljODWwoUWbQZJXtVZtdMJBNLYrE2h4SZbZkW8z1YMXrLRP2NM3uC
 W4xUIvDT3QJAA/I4RtXDkNvzpcv4v2HVbOCccQs/UVaTb5iaQLioGbj5o8xJPiimsgFIDhLjE17
 BZsj4U04AhY2TOcaSbldxKFrhSIa3OtY191oHAZxabe
X-Received: by 2002:a05:6808:1693:b0:466:f60b:19c5 with SMTP id
 5614622812f47-48549d9010bmr8807407b6e.6.1779749002901; 
 Mon, 25 May 2026 15:43:22 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e606667796sm8076073a34.23.2026.05.25.15.43.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 15:43:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Aristo Chen <aristo.chen@canonical.com>
In-Reply-To: <20260508213217.3807786-1-aristo.chen@canonical.com>
References: <20260508213217.3807786-1-aristo.chen@canonical.com>
Subject: Re: [PATCH v1 0/3] boot/fit: use fdt_for_each_subnode() in image-fit.c
Message-Id: <177974900236.3696278.210071889018515573.b4-ty@konsulko.com>
Date: Mon, 25 May 2026 16:43:22 -0600
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

On Fri, 08 May 2026 21:31:58 +0000, Aristo Chen wrote:

> This series ends with replacing the verbose fdt_next_node() + ndepth
> idiom in boot/image-fit.c with fdt_for_each_subnode(), bringing the
> file in line with boot/image-fit-sig.c. Six of the seven sites in
> image-fit.c predate the macro by 2-6 years; the seventh was
> copy-pasted from a neighbour in 2015 just after the macro landed.
> The old idiom is legacy, not a deliberate technical choice.
> 
> [...]

Applied to u-boot/next, thanks!

[1/3] boot/fit: read default-config property from the configurations node
      commit: 646be6d5cd37dc9f1e79f4c6677b872932605a2b
[2/3] test: fit: regression test for default-config print with reversed node order
      commit: b31f551bfcf05cec628fc79af5d12a601e0a1f48
[3/3] boot/fit: use fdt_for_each_subnode() in image-fit.c
      commit: 2c9b117aa4811d583f2832b37a69f25c761ffc86
-- 
Tom


