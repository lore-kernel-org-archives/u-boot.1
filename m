Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 860BCD2CDFA
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 16:27:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5E1F88FA7;
	Tue, 22 Oct 2024 18:27:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KKoFuVjQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8E2C88D91; Tue, 22 Oct 2024 18:27:11 +0200 (CEST)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1901F88D97
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 18:27:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7b13ff3141aso444906185a.1
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 09:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729614428; x=1730219228; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JkQPNXHeJNTU+esfEVs5BzRjismo5Ny92Hcfi+FDDag=;
 b=KKoFuVjQOMt4WI+E4tOZ0CSowtRcfpMSYeODWzf8sxX5SDRBjLcMKisED2ytXf1U4M
 C0leCdMdTiV+hHrW8fL5WYqvBPtGxhZKaQdhiYULQdZsIF92yfzNyBkaUrVSlxYx+Q4t
 n+QAXvMXBb0Zz5M7q5ux7tN5LyIYX0QMVMSIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729614428; x=1730219228;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JkQPNXHeJNTU+esfEVs5BzRjismo5Ny92Hcfi+FDDag=;
 b=tkbECBLWWsAMvqxGr32K+7wgDAONz03onu8acaXqk70YgQMWhXuxAY8Q3ViOjPluHX
 zM61FUfmjFUjDKR3L4j91EQd2+y0A9vl134PQZXyymXPStioII7EErJ7lm4FbF+Me4LY
 pzFi8USXdOKk9DrM9MfoFbiZ/1RN137UYl9c7OLliB03K2U3luVSkD079ON4wzsUu6u9
 84rH3+wS+XokZ7N9QTKTZ+QiUM7lKAwLV2pUyYb1tm2E7M8mdfbNCJ15cQc+NVCfm9fd
 MVmEYS7xmNXC/y3PJ4Luo72709squ+Ma8P6dFQx1D++cNNXi9+AqPKTu0+oxtLwUgEbx
 ErXQ==
X-Gm-Message-State: AOJu0Ywb37uhdq4Veiwyt90NkN5VV19+cdRO1Zw6HyMf7cy/3Vs4gxcC
 kXQnjDkfMVB+m8dYTR7x+XKaNIANoYWCOtQzz8Px7YxBEGO+1rEGRGD8SuFsfPU=
X-Google-Smtp-Source: AGHT+IG+5WVtZlMgpBs3Q52GdiSqzps43Ug/1icX/tp7zVhaJf/1g+QKxNiTWLhcK2UMjMh4aa2a3Q==
X-Received: by 2002:a05:6214:5b06:b0:6cc:22eb:4508 with SMTP id
 6a1803df08f44-6ce2059e8f2mr55121646d6.47.1729614427929; 
 Tue, 22 Oct 2024 09:27:07 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce008b2be4sm30344046d6.2.2024.10.22.09.27.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 09:27:07 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: mkorpershoek@baylibre.com, nm@ti.com, n-francis@ti.com, a-limaye@ti.com, 
 seanga2@gmail.com, sjg@chromium.org, marex@denx.de, john@phrozen.org, 
 ansuelsmth@gmail.com, sumit.garg@linaro.org, neil.armstrong@linaro.org, 
 caleb.connolly@linaro.org, Oliver.Gaskell@analog.com, 
 robert.marko@sartura.hr, semen.protsenko@linaro.org, 
 Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, srk@ti.com
In-Reply-To: <20241014053924.4027491-1-s-vadapalli@ti.com>
References: <20241014053924.4027491-1-s-vadapalli@ti.com>
Subject: Re: [PATCH v3 0/2] Add TI K3 PCIe Controller support for J7200
Message-Id: <172961442551.3127138.6727145250208172426.b4-ty@konsulko.com>
Date: Tue, 22 Oct 2024 10:27:05 -0600
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

On Mon, 14 Oct 2024 11:09:22 +0530, Siddharth Vadapalli wrote:

> This series adds support for the Cadence PCIe controller on TI's K3
> family of SoCs to which the J7200 SoC belongs. The driver is an adaptation
> of the Linux driver (drivers/pci/controller/cadence/pci-j721e.c) and has
> been implemented specifically for Root-Complex mode of operation on the
> J7200 SoC. A minor set of changes will be sufficient to support other K3
> SoCs as well with plans to implement it in the near future.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


