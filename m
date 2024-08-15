Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3AD0C52D7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:36:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADB7788C40;
	Thu, 15 Aug 2024 22:33:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SWn3oe9T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83FB388107; Thu, 15 Aug 2024 22:33:52 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD32288C5D
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:33:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3db157d3bb9so793203b6e.2
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723754026; x=1724358826; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hNaaL/Ai9GFrwtOG3eReIha6/yXiLujgVbbzNyeEJlw=;
 b=SWn3oe9TlGDQFFxNQmjo45T8Hr5YU2gj3i0uStss4E+aqvHzCCVIMPb2m+kVHNXfFf
 gpmG6wdnAfMkK88kx7BfS48KWxYFdMeeTJ1rUWYvKdAPBMicQtUy9mTSKOXH1GTyNsa8
 YeBRB3+H6DLDG63IYmPMD7T8WF0RPySh1bLmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723754026; x=1724358826;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hNaaL/Ai9GFrwtOG3eReIha6/yXiLujgVbbzNyeEJlw=;
 b=IeEx0UFThTxC+ZoZwg4QHplE3dIfvziYf8IiKXt2PlGj8lQmJRdFfAv7WyT5/TFfzc
 hOcYLXYD7GwsNscKChx5BHjBcN1fMdvyg6prm86LNCen8cL3ybhga0a9BtA9Mx5Kyd8O
 6CQ4RsO3AIiy6XRd6Gc/RQJANlYRfAt9UAQ0P2EPySDe1RdtC0/y95rBeEwqx0G6jEWA
 b3q9dJxRFg0WcmBHD+rFSp79ksMgIOaCOBq5pcbX5iKjcXcRROW20ta/Hz2QxSIxkaEl
 lIftr6xeRpCZOFQe01eJ+AcOzzf8I8jB6OE8VU4Fa52pQWkY2+J+u3NwYx2U8rpphx+3
 YuSA==
X-Gm-Message-State: AOJu0YzComZ1JjgCuIH4Pe/r1JEnZOWC+kc7y1j2DdtbOf7Q/Q19l7X1
 CLuR+f6weXaQReQWxWebLWyWc4bGApmtRw0iDhmYrrUsDYfRWRnGksRPrDC/XegYr6kcqjhxTkk
 dtvY=
X-Google-Smtp-Source: AGHT+IEZTa/5pJvy6/iFjscVTmBuqCMjD6QeX9T/D0DYVdCqjwhqtLzc2f5+JTnMwaljosxT1o9Rkw==
X-Received: by 2002:a05:6808:114d:b0:3dc:1b09:55c9 with SMTP id
 5614622812f47-3dd3acea183mr834194b6e.12.1723754025794; 
 Thu, 15 Aug 2024 13:33:45 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3dd33ef4338sm400988b6e.48.2024.08.15.13.33.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 13:33:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240809182233.194057-1-heinrich.schuchardt@canonical.com>
References: <20240809182233.194057-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] scripts/decodecode: update from Linux v6.10
Message-Id: <172375402516.3490273.9421408718508480572.b4-ty@konsulko.com>
Date: Thu, 15 Aug 2024 14:33:45 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Fri, 09 Aug 2024 20:22:33 +0200, Heinrich Schuchardt wrote:

> For decoding RISC-V dumps we need to update the script.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


