Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D576BD3C53F
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 01:57:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96BB18916B;
	Fri, 18 Oct 2024 03:57:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aoDxqE75";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0254589167; Fri, 18 Oct 2024 03:57:44 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D793788EE5
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 03:57:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6cbd550b648so12053626d6.0
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 18:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729216661; x=1729821461; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XfDQhY2BD8HsJPkf6vylZlu8B2gtUSCfADz0Y/ozls4=;
 b=aoDxqE758N/sZX7VtXjhdJ57+MjFg8ktQP8xt1w8Vz3DxI3EcBsvKPY6eprc1QJSQx
 J6J6LjMfRHtvdvsn0UaKGZ0eWUs1pcbsBu+5DiqgLv6e6zWMDalFBND7O3NGxMCi91ym
 sq1bU8zSvAWIC5vjpHl1UMTE6BohClVCrOXmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729216661; x=1729821461;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XfDQhY2BD8HsJPkf6vylZlu8B2gtUSCfADz0Y/ozls4=;
 b=vPKG0hno1xOGVxB++kQC2RYXk7i6weKqQMaEK/X0B6qfdwdfNafTg5jdBYiXEvYM6R
 lUWrBMLYqVkzQ9yDmTPJ6A45OTFYKYeaVQgue+AO91rMtxKvjzxXTKGgctndATymK681
 GBbOHdqeMWLEcSUEQMBFRZOSTlts+p6w/MWuYJUR+v8O4OXsWETnqdxtfsaJeFxsu2x1
 Ud3vkgkLlZw95zkSWkmXP/voYIPJvGfYrmf9Kti53gi3nIq/K99CcyXVlVsP4vaq3EMe
 1OYMo6KuO2eR+MQB0rfjxWc+rrTiIWukoH1QaPhJdjVpzjp+wtSLmjW/pCb3sQR/RZSl
 t9wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUao0VmqEoxfss9LqgOPjuy/xeBt7K5kjs8AX+l9/R1V/bf1+6AYCIcQLHI5VV2QqQpjfL2lH0=@lists.denx.de
X-Gm-Message-State: AOJu0Yy5nyduW5PJWiEpoE6IrKegqOs/rPBDmT2ILQAlmSKtio783Db9
 1PNJtIYfkrheCs7L3wlT8wVVIZQIxt0Ds+bYVPQRFi69ZIUf3knAXSn0Yp/Dkpc=
X-Google-Smtp-Source: AGHT+IGInKQt3LzXjCM1eiR0mXMxWZxx03XD4jTtnYaudWZkXidDPbpsLXwj+HCaHT0qLug2xzXlyw==
X-Received: by 2002:a05:6214:319c:b0:6cc:3da0:d07d with SMTP id
 6a1803df08f44-6cde14c0662mr12554216d6.4.1729216660794; 
 Thu, 17 Oct 2024 18:57:40 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cde1366ac3sm2332156d6.113.2024.10.17.18.57.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 18:57:39 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Prabhakar <prabhakar.csengg@gmail.com>
Cc: Raymond Mao <raymond.mao@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20241001095647.180840-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20241001095647.180840-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] lib: fdtdec: Parse the gzip/lzo headers only when
 dependencies have met
Message-Id: <172921665867.1016776.2610650452685364064.b4-ty@konsulko.com>
Date: Thu, 17 Oct 2024 19:57:38 -0600
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

On Tue, 01 Oct 2024 10:56:47 +0100, Prabhakar wrote:

> It might happen that CONFIG_GZIP and CONFIG_LZO are enabled but we might
> have CONFIG_MULTI_DTB_FIT_LZO enabled in this case in the code path of
> uncompress_blob() we parse the gzip headers first which results in
> `Error: Bad gzipped data` being printed. To avoid this parse the gzip/lzo
> headers only when dependencies have met.
> 
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


