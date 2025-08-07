Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF998C87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 22:34:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2538083C9D;
	Fri,  8 Aug 2025 00:34:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iBSKe0C1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B32F583C93; Fri,  8 Aug 2025 00:34:21 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3073783C2B
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 00:34:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-61b7b54ce40so60982eaf.1
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 15:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754606058; x=1755210858; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vgPQCgjrKpCCnqWAWD+zx4FuTO83N03IkeHlKB5aIK8=;
 b=iBSKe0C1Bmho37TYmRlWa6dB5blBz1iFA9gh2fSi3zQNFTWbMU6p6ZmMc55HLKbOnA
 5SJMCMZLJp/rrnYHGYZGbXH8Ik/WNp3ZG2wq2q8jSSO19PaEQdOoHkOCtsMz8AnRJaqo
 M0VycRd0CJLzCwqFKND8Kc2Pjp01uhK3BhbTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754606058; x=1755210858;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vgPQCgjrKpCCnqWAWD+zx4FuTO83N03IkeHlKB5aIK8=;
 b=LWHgL4YDNQiG3FOCuMwp3zz0ihV1s3gpvXbEzWKRDYWLEV0aUIWxT+LaRwGGb9QeQm
 UydfnTwwg8XL2xU8c1qX7dleZ9hn/elgNk5MG94WW32W09CUL5SqPnqS6TAwRu2QFK2M
 Up63jDTM+JaDiovHuePVG6jvbQN0MenaBI9Js2vS7CC7RgxWT6hJVesUdUmJ4/iHcNh5
 RrgjStypM7m9lGQVKIEw4AhnWK4XddxGNq9BTtgNZVd09QPBUMWug8id7J5Uik/OQP0f
 h/9DF4armHlD/oqpIO/0czHQ7gOCM3H8u//yJou93BV34CY3Gy4a/N1ae77EfPKE+edx
 Fg+g==
X-Gm-Message-State: AOJu0YzfE7GeI84ZrM9DOPCwznLEkwyNkW3ow5ZqrG5m0QsHnQ3FB6hw
 dpo0u+AG1Ne+Or7zEtfJUAFJEWcvp/IlM+GfUu5U0YRwpgP/HE/Au3pvoxFETbn3K3SuMihJMnN
 NhFvfUOY=
X-Gm-Gg: ASbGncvjJDUruP4ZNmwXsuqLO9BqhSBHHbaGVPNL1flwZTZ+rHOiOwkiTap5joSM1nF
 6XXboMSVLmDL+LXsaQkZXnzKe1jS5S4GCNqE5kLbqD5r4Vg6e5Tngc+1OucyhGHFAFalHlfdEfk
 BmdFbSKsmhGl+ZInHmzWuRj9REb+iXiJrx7l7KW5F1wfktbmfW9kkuywg6eHLx3U1Fz0JMFl0tq
 VTe7FU+luxChnqWg0tWzL8aHh5HFUrP2CZh3fR+X/ycLibtmH+YQt3qD6xaR4rO1yNwQeA2sSEw
 ahzaa9zDjoaOdW4YNdhiI/K9lwdUGPzI042Xa+ZTDTdfvS1tmpQuyKAGRiJ+0eXk1SD+LSFl3lo
 Va+JGxjGn8OYuLQPcfEfDc2V0y6uj1XLgixqNVlIz2tkh6DR/RqoDguJBFNhNbFIdPA==
X-Google-Smtp-Source: AGHT+IHejur2aZxnbUcHU4SoU7CIORXUgqThNdraOVhoo0uEHnyZm6so509rZwbtZAHaQylKvEGm8A==
X-Received: by 2002:a05:6820:16a1:b0:619:9530:87e3 with SMTP id
 006d021491bc7-61b7c3a3e5dmr568558eaf.1.1754606057840; 
 Thu, 07 Aug 2025 15:34:17 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61b7c6eaf6csm73309eaf.0.2025.08.07.15.34.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 15:34:17 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Garrett Giordano <ggiordano@phytec.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250729-no-62a-gp-v1-0-1dbdb4469ad3@ti.com>
References: <20250729-no-62a-gp-v1-0-1dbdb4469ad3@ti.com>
Subject: Re: [PATCH 0/2] arm: dts: k3-am62a: remove GP security variant for
 AM62A
Message-Id: <175460605692.3039738.10518965924092749234.b4-ty@konsulko.com>
Date: Thu, 07 Aug 2025 16:34:16 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Tue, 29 Jul 2025 13:36:55 -0500, Bryan Brattlof wrote:

> The AM62Ax was created right when TI was shifting to their high security
> (HS-FS and HS-SE) processes. During this transition a small subset of
> AM62A parts where configured to use the old "GP" security for internal
> and for select groups of partners but never sold for the wider public.
> 
> To help simplify the build and to avoid any confusion of which security
> configurations are supported going forward remove the GP builds for the
> AM62A SoCs.
> 
> [...]

Applied to u-boot/master, thanks!

[1/2] arm: dts: k3-am62a-sk: remove GP tiboot3 builds
      commit: 724a71c13ef9213f8d5e7868419c1910ff2d5b30
[2/2] arm: dts: k3-am62a-phycore: remove GP tiboot3 builds
      commit: 14706485aade6158bb7f21def5787835bc0e7eea
-- 
Tom


