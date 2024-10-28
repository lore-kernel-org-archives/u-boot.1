Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9183D13590
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 02:53:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AED4A88FD9;
	Mon, 28 Oct 2024 03:53:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Aue/EEd9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3881588F70; Mon, 28 Oct 2024 03:53:19 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A8E488F70
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 03:53:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6cbe8119e21so26489586d6.1
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 19:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730083986; x=1730688786; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=o1a86Kf0+1oK2V+kbgY4VxprlNZMFTHucYVNqJ4WtaI=;
 b=Aue/EEd9Q5CJzZqeT4hlOxWrA08NDgJDEGs35qV1hcHzUy6s7lgXleimyj+sSZlvxw
 JWUm3ZNGe69JV35guzhTljMOWBftAs2k9Yzv5VrjWD/FIIeEFZkY+4NqI5bzgMaGoAQ0
 9BPNbjESCTDxbjOJ1nsiE2+0/xuacw1Rin0tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730083986; x=1730688786;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o1a86Kf0+1oK2V+kbgY4VxprlNZMFTHucYVNqJ4WtaI=;
 b=lWZT6dvYT2KrdjCgAv+iUAsoR0RWfyoFvWZqAJGhag+Xf7tCAX5YiYQCvU1HIGSzUr
 Hsz/tjgnLC2ElanneCK4wKeR99clmn21b7GtJtR1e3RmTXXheXcoGwNrxKz/QmskRudu
 gRNwkvWeB9dtHlEjdaoXQFgwLViBCOzmTKCMCX0aDx3x5yUpbX23/1JIQ//YZ4oS4KoN
 nJB6LTJ/VUb1CDP/0zFBL9V0NYU5hA/8Bx/RKdCVWkyjfz60IXC98r7JKm/gRTTS3Q/J
 TYv+go3OBXVIqLQk5xK1vCeD1JWA0CIsO2RrzCfR+YoekhrydpfHx/cnPM/gyGwA4uu9
 GKfQ==
X-Gm-Message-State: AOJu0YzvrtXrj/c4fLEuaF8wzXGU+9szqSK18lgn37pfolA9NxQg0IsK
 dMiDCSbhCk3BEDAvk0rHORR3p91te57yA2Xogif1uJNoZgUGb5s+NKGcBnW+/I9lPEHK41lv1pi
 8RLk=
X-Google-Smtp-Source: AGHT+IHO7Ix4EvNEDSVriEoOaIRHLaol/Go5ix7JBSo/rEvHegarrPNFfo82W99Bc9grY+KOswux+g==
X-Received: by 2002:a05:6214:3a84:b0:6cd:4972:59b1 with SMTP id
 6a1803df08f44-6d1857030c9mr164487076d6.27.1730083986151; 
 Sun, 27 Oct 2024 19:53:06 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d1799fd4fcsm28497146d6.92.2024.10.27.19.53.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Oct 2024 19:53:05 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Patrick Rudolph <patrick.rudolph@9elements.com>
In-Reply-To: <20241023132116.970117-1-patrick.rudolph@9elements.com>
References: <20241023132116.970117-1-patrick.rudolph@9elements.com>
Subject: Re: [PATCH v10 00/37] Implement ACPI on aarch64
Message-Id: <173008398425.2202883.10639171686337859026.b4-ty@konsulko.com>
Date: Sun, 27 Oct 2024 20:53:04 -0600
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

On Wed, 23 Oct 2024 15:19:43 +0200, Patrick Rudolph wrote:

> Based on the existing work done by Simon Glass this series adds
> support for booting aarch64 devices using ACPI only.
> As first target QEMU SBSA support is added, which relies on ACPI
> only to boot an OS. As secondary target the Raspberry Pi4 was used,
> which is broadly available and allows easy testing of the proposed
> solution.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


