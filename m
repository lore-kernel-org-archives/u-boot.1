Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B2CAC3DA7E
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 21:05:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EEC088804;
	Tue, 23 Jul 2024 23:04:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GQ9H3vXZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F915887CD; Tue, 23 Jul 2024 23:04:25 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 314248831F
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 23:04:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5c74f6e5432so2578449eaf.3
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 14:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721768654; x=1722373454; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dGpuuAVozBIqBqNUDH+LW/AfZy9YWJiIyQfTt9k3sOw=;
 b=GQ9H3vXZ+xqfxeSF328Zb5J9XnmC9AVTdQ4A2LQV4lKSEzJeDMkZj0VcaLl4u2t30E
 VY97e2YTR3kNKv6+Hb3YDyBgZP7FQmSgGieVE648jFy5A4+lM8NhtURNhYSoXc1vpiWX
 dQKReTbFIXzEkjAux5QejfE7T9nGW9Bh/bpjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721768654; x=1722373454;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dGpuuAVozBIqBqNUDH+LW/AfZy9YWJiIyQfTt9k3sOw=;
 b=FE4H9X9IzFZlbkgEwMt/f92fuU1hd71Qr7ZFYqv6dOCVHMSAWtwi2k8kMqWlDvyrS2
 XXm4+evppF3dJRxos3KN4LWxrDj3nFH1GtwCkid8hilnbDogtbd5RpROFFkb1noxiJgG
 ok/KXxtyZUOH3WeNpSBJX//LTMIqyWlv4R89n2GjU7FvPXLIw4C9wL5zZHd8o4Mgv20U
 LCFFbz1dll9pHoxj84p4uLsR3zYfIcPLt4BtSczTY5HWwtHVMv9NzXwOfYDU5VAZckfi
 6ukRxTx4G2+8Hr/GyBDPfF3+8SCtSzdMYSJ28OzCJWhxmtGiGrGhL58ImMvEPH0DbuGF
 ph7Q==
X-Gm-Message-State: AOJu0YwfAA5O+BHdeJEs6LwvTWCBgwyN+8PsW3PBsNyMMVDaRNXLyECu
 kho2A5AffzASd+91AaZqLAveC74Ptboz1FO4xVSpj97+FigqXSwnO5XKBVeBlEH7UEabEa0qb7c
 Nehs=
X-Google-Smtp-Source: AGHT+IHRXyb2IiKJPuXU+JiOMGCmMVLnl8H7722JSSGgfUvEsx3cPgFttPMazNAswNW/+zGYMGihbA==
X-Received: by 2002:a05:6820:4b8b:b0:5cc:2800:27e1 with SMTP id
 006d021491bc7-5d59bce20a0mr1482146eaf.0.1721768652628; 
 Tue, 23 Jul 2024 14:04:12 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5d59f04938bsm61321eaf.33.2024.07.23.14.04.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 14:04:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anatolij Gustschin <agust@denx.de>
In-Reply-To: <20240719215123.3358410-1-agust@denx.de>
References: <20240719215123.3358410-1-agust@denx.de>
Subject: Re: [PATCH] board: beagle: convert to CONFIG_DM_I2C
Message-Id: <172176865209.2258489.13195091426100228342.b4-ty@konsulko.com>
Date: Tue, 23 Jul 2024 15:04:12 -0600
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

On Fri, 19 Jul 2024 23:51:23 +0200, Anatolij Gustschin wrote:

> Rework to remove use of legacy I2C API.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


