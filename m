Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 774C6E77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 15:33:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15D7D8036B;
	Tue,  7 Jan 2025 16:33:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nRKjsuqv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A58C8036B; Tue,  7 Jan 2025 16:33:54 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A751D801C3
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 16:33:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2f44353649aso18749804a91.0
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 07:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736264028; x=1736868828; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Gph48iuOLNTWSivHWfgut6vKgyyxx9vYVFTqL3u6g8M=;
 b=nRKjsuqvacqqD7LZz/y/qVce24rzVzWZJvNthTB8vXY3qkFfy8Yf/QJSHwc4IRk1Pd
 BBFGQqbDT06geB+grqMnzJHSbqcOvDH/LqJPiQ7JJDk6/UMUbL2GyDYOE/HHbYDHAPOg
 1UZgrwNlRal7pDwOF3+QpOt0FHEh7da+fbob0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736264028; x=1736868828;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Gph48iuOLNTWSivHWfgut6vKgyyxx9vYVFTqL3u6g8M=;
 b=ne1wKLtJ4RnD39HYI+E1p1dOO4Yhl6qisk9W493ypLubzUGUH8ZMJVghEdgJMjgRUG
 3HM039Hlsrw3/WKM+i3NXLHbDzVhwu5zyX/JPsprThuU4nyfoCUb8UKQ3iQIDmxhvqRg
 zuJf90YJgpuMyfl7UxWgT5BlAt24oCvCRQNCWFBF/gtje/LZ5tqVIAXlZ1Hba9c4KBop
 JURTS2dh3DKfr2j1P2/PZguYFDmf1HOuzhS5mLMmMtO2P35MJTpcjB/KqHFHeKWa9zqp
 v3yme8K63/a+KB9Gce2Cl2FoLPKXdDXc4petCwSCIMr0Us2sMFtd1VbC30ghwEmU7nHN
 mU4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvgxjn+KYgFPq0HmZAnov3HvAwcN37HKV8FLu83uVX1Kak9Yt2lXpyxUcQsdPWmnhEXVP3pnk=@lists.denx.de
X-Gm-Message-State: AOJu0Yz+bAyFL5IqPWUpKnFh8zYAR6qLLkefB9nBEq7ZLsKvmh+CrXwI
 wQFX4hhKPAzHAYUQgUZ4Cx+FOD3dQJDa2+y491D6vdr9bAHTmgwd+RtJhkWBVntyR0icGrp+9Ah
 Onofgl/WbNEttyn+7UgTfMQ/kX1G4IeBnIQG7
X-Gm-Gg: ASbGncu2wB5XM/mwyIALmyrGR+JUCkXeTCDSy3WTK2+feY3sl/OHUQuEtxlF0WRLtxo
 n3ETtqpYSC30JkHcWuAUg0QrSXg+EX8p0ZxBcQfk=
X-Google-Smtp-Source: AGHT+IGYomM3q7C+/wBCOsIBBH7LPW+jqW7n74wWvp0pulU/4n00eTv63cuHgZWp+FkfUE59+/NH6fjDYrog0ociKK8=
X-Received: by 2002:a17:90a:d88d:b0:2ea:5e0c:2847 with SMTP id
 98e67ed59e1d1-2f452e4e81emr80132581a91.22.1736264028301; Tue, 07 Jan 2025
 07:33:48 -0800 (PST)
MIME-Version: 1.0
References: <20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org>
 <20241124-b4-modernise-smem-v1-3-b7852c11b67c@linaro.org>
In-Reply-To: <20241124-b4-modernise-smem-v1-3-b7852c11b67c@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Jan 2025 08:33:18 -0700
X-Gm-Features: AbW1kvaYua53UimzZDwWYPaWe4Ae-fQLq8jnVlsdpjEIRltSxlxyVhI_DYT0Nww
Message-ID: <CAFLszTgEaL6Cb0y9wgGk4wiKXDLkEDPxPQneqv2L=HREPC3bNQ@mail.gmail.com>
Subject: Re: [PATCH 03/15] Revert "test: smem: add basic smem test"
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Mario Six <mario.six@gdsys.cc>, u-boot@lists.denx.de, u-boot-qcom@groups.io
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

On Sun, 24 Nov 2024 at 12:17, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> This reverts commit 20e7705764c4e5ea924f1ea54bb36ebbbeffffe7.
> ---
>  test/dm/Makefile |  1 -
>  test/dm/smem.c   | 26 --------------------------
>  2 files changed, 27 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
