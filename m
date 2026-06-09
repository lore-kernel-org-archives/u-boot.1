Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84629CD6E79
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 09:58:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE41283FF5;
	Tue,  9 Jun 2026 11:58:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sigma-star.at header.i=@sigma-star.at header.b="aJScNRFI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 508528466E; Tue,  9 Jun 2026 11:58:17 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5885583FEC
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 11:58:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard@sigma-star.at
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-490aaeabdb4so33457765e9.1
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 02:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sigma-star.at; s=google; t=1780999095; x=1781603895; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+s7TnH/+o1u25ctRxWuK8Yz90zYNkbIr2KHC0ClX2js=;
 b=aJScNRFI3CNZTYuEnpWRHvFfHMq7bj7gqeiy0liiRzBuCjTt0OyRaUjmK3D2W79W7L
 OS43GnM4ywTHSMZyZKr7lMKZJ0E6g4tPrCfVYFm9E1Fr+6T5DIuepNXl23aJIo16Iqvl
 D/cR2wi+XkI+7VIIBuiQ3WR1L1N0LkeQNfunjVerBPwOeW0IzuX5p0Vq5dRUbHLdIDEE
 odL0g4S+WfdPIqshXOYtxjNLKk1GihUfhCTCEbfZoC0hju1wYJVHCpeHVUjpf+ANPNtH
 yc5vFKWg0hKKWV0wW0zp6n1N3xM+Hrwu50JJAXc9UBoh0dnDqE/R1bmawtobJf5Pqtr0
 ibDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780999095; x=1781603895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+s7TnH/+o1u25ctRxWuK8Yz90zYNkbIr2KHC0ClX2js=;
 b=lfXfb9W8ocl9obMg0Cl33ygncGI9/WkEUvgSulb4TAj18bxMHNLMQ45FL785hp3dSU
 I9IxdpsSFtkMgejLwDGiRA7gHCE2DpvEvCGi93+hvAwLg1bCitbdOdtBnth/FqxhEAO7
 AlFhaDNhx3xZT7J14/UOmJDx94SZmopSclsqSsmsL8qVcINwoZpE13y0FuZ5olY/Df4X
 drB99PY5OdD3JjRdCZeVfzdVNd7RsKIuhTdGiGnd+yCIK1GFiWfRT9gYBjA2MLZxacmD
 qkBPmbf9/JVZUUfCiMNWsGL850t7TfE1gfVpjnedASBT1baFQcYzznCgFiNb0RPJ6wWY
 AsKw==
X-Gm-Message-State: AOJu0Yw7tqMcsZXLpZ8xq+yWwW7hYvKupMRV/fI0Y7LGwoqoyCY1PZeE
 HnZsD0mxKN0ZilV6Ja0Nw9yINpl0qYHAD3Z+yuWifIlZafC+8nHSt4LabD7G567f5gM=
X-Gm-Gg: Acq92OFFOBtF0BOqF+fk6DxGjBG43E651h/Pj9PdO0UyKzmc8EqjS8Gr0/mfnXBSN/S
 SlvM0MWdnkg0eRdlGUbiMjal/VgHmYN7IyvDJdzmt7A4WI+cwJJgb6B+a2xRFTomQvLT5ywn/Vs
 wlqlRn8kIXj87UAq/IaMqrqBuyouv3NDJnXQAcIYbwF9K90Xy9bRUiHgb952F0VviB+x/aipa4B
 FzYpkmewijeF5qFScIoJ2FlwBxVAfb14+Tz30gZNdb4JR6l9FW1q8S5XRMszU0JoRmY26F1StCQ
 u8do1la8GODdh3aFL0WYHUXXcHlnYc31ypRS/91/m+1Ycf5uwZa1hNoiwgyWccno8OJfYod/jpG
 9F6fqYurikugCBCl1oewXyi/9oRLn1bhTJBmwzrPQTCa5MdT6aX9HTJnApP410t1rOMMOkiWjST
 u9xHDYZffMEsFVb0kxbt+Hlqa3mc1m/s8fPVsaO+XD4I2AnZ2GwyacqiKFrnEhwrgrma3ieyHLq
 zc=
X-Received: by 2002:a05:600c:34d3:b0:490:bd66:e526 with SMTP id
 5b1f17b1804b1-490c261391fmr328553225e9.32.1780999094713; 
 Tue, 09 Jun 2026 02:58:14 -0700 (PDT)
Received: from somecomputer (85-127-105-26.dsl.dynamic.surfer.at.
 [85.127.105.26]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490c2d52e5esm227077025e9.2.2026.06.09.02.58.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 02:58:14 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: sahil.malhotra@nxp.com, Ye Li <ye.li@oss.nxp.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, alice.guo@nxp.com,
 peng.fan@nxp.com, upstream+uboot@sigma-star.at, ye.li@nxp.com
Subject: Re: TZASC misconfiguration on i.mx8m
Date: Tue, 09 Jun 2026 11:58:13 +0200
Message-ID: <3228430.DofJx8uAJo@nailgun>
In-Reply-To: <6774aac4-5c63-4fd4-a90e-4e8c4f3e2b85@oss.nxp.com>
References: <3208216.Ym5mLc6kNg@nailgun> <4466851.5hrfCrGMcO@nailgun>
 <6774aac4-5c63-4fd4-a90e-4e8c4f3e2b85@oss.nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On Dienstag, 9. Juni 2026 11:56 Ye Li wrote:
> Why can't this optee patch apply to optee upstream? It is optee using=20
> secure memory, then it should be optee's responsibility to configure=20
> trustzone correctly. Optee can't depends on default value of trustzone,=20
> since trustzone is not enabled by optee.

Sorry for the harsh words, but that's *your* job at NXP to sort out.
You seem to ignore upstream.

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT UID/VAT Nr:
ATU 66964118 | FN: 374287y


