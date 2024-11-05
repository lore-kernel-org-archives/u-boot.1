Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E40D1CA13
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 01:07:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC53588F83;
	Tue,  5 Nov 2024 02:07:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EGhYBqyL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F272189021; Tue,  5 Nov 2024 02:07:12 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2500288FCB
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 02:07:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6cbf0769512so32009016d6.3
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 17:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730768829; x=1731373629; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=x9b6maQoNQI4r+2IovVsb+1g5VTAE89iap3LyntQ5h4=;
 b=EGhYBqyLIGhbqK8VPb+V1n3cMcOoXAjd2nDWwLiJnt8JF1PoO4SuvSUS036jDyjXFZ
 6Yf+nzuEhcmH2LDPK+BgZe2nfLpFuzVTdtey7IWH5uZBh2/jGTwvh/NRG3EH/OIOh30/
 +96/W95nMldvG0XgeGw61zHKrRfP0Uapx8ALY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730768829; x=1731373629;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x9b6maQoNQI4r+2IovVsb+1g5VTAE89iap3LyntQ5h4=;
 b=Gdo32toRTSU3ZrVWQD4g1MoFL9JrEu5TnkaKxmbO2w70I142SfMXmRZmxNGSs6hsXQ
 PueR5zSue69kZ6M5ZABsdoxR6LhvxDi5MK+P0kpCmTClX9+N1dPZCCunK5o9JbhAfh7F
 mXSULHVg/TyhBwwTFcLx/g6b53iCrLZ6E1gew+ywvXEloj3UDOjtRBdlo6xwsDmDy5H5
 iteJQqRayP88YuUFuLJR3C/nN75Ba/MojrLbVo4X2L00DFdOCaQlr7V9laAMnE5xS0sh
 YawnHTAyNYHQRJv4pJ++4K8gBVceFPPfnWwGE+Pq3l9Ciqz5fqOj7W0A5cmDOe12YoiI
 TJ8w==
X-Gm-Message-State: AOJu0YztmLg3SjDKCo7KbS0m9ViOXuSli1OC77l4erMeVYXfBnxf3H0B
 V4zMckNiNOPGk6nxA4AFunxR8WYcK9fXHZNKp2yqz+czVc+MsxAq7EUoREALKvmd8t0mzvmXnOY
 53j8=
X-Google-Smtp-Source: AGHT+IGjhtDQpoHu4snr3cPg6+erfJ04x3JkouJpt5386W50QXgFK5C+uZn7fYGImC2r3d4lVH0Uww==
X-Received: by 2002:a05:6214:4b09:b0:6d1:7438:7b94 with SMTP id
 6a1803df08f44-6d351b07b4amr270249886d6.47.1730768828975; 
 Mon, 04 Nov 2024 17:07:08 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d353fcc777sm54436686d6.56.2024.11.04.17.07.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 17:07:08 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Yuri Zaporozhets <yuriz@vodafonemail.de>
In-Reply-To: <ZyIuA1Ieq4ff7iqV@qrv-systems.net>
References: <ZyIuA1Ieq4ff7iqV@qrv-systems.net>
Subject: Re: [PATCH] bios_emulator: define the comment symbol for RISC-V
 assembler too
Message-Id: <173076882762.3917422.16172455412540927965.b4-ty@konsulko.com>
Date: Mon, 04 Nov 2024 19:07:07 -0600
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

On Wed, 30 Oct 2024 14:00:51 +0100, Yuri Zaporozhets wrote:

> The bios_emulator driver cannot be compiled for RISC-V because the x86emu.h
> header file doesn't define the comment symbol ("#") for the assembler.
> With this patch, use the same symbol as for e.g. x86.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


