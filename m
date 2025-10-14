Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BACFECCD184
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 15:47:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03E6B8312A;
	Tue, 14 Oct 2025 17:47:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gslCIu9O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C698483303; Tue, 14 Oct 2025 17:47:34 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C3E180107
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 17:47:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-441c44f5536so596495b6e.1
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 08:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760456851; x=1761061651; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bE4N4vggT230o/77+hkAvenX3UN6HTVsM8swqlRm94I=;
 b=gslCIu9O/qEp+xibAzfdG4uSl3rQz22qEwEL4w/PZDmrtDPcZ2MCb0eGZ5/I5LMgVf
 c4cnjADbi+pVpj3WsFs3Zo5Fo8V1k4/SE+kSC+faW5eooOIu+E09OG94NF0UGd4tuWyr
 GYE1NpoKA/etkGzkHdZF4LBWZb2ZndB4NHhW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760456851; x=1761061651;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bE4N4vggT230o/77+hkAvenX3UN6HTVsM8swqlRm94I=;
 b=rmrz+lDm29VTAMZ8cKc8jEfte9aEOAkMCZXTe/WpK6I1mTD74SA/c4cr99LPtEmoye
 7bECK1UOnl7Pe5wgnF8kpaHkgMONimao9KmEjvO0PCnOgMzJq50kSXqOOA2aOSh4al3z
 lZLPx8ErFmpHCM5hXiKXpMjQhmTzdD7H57wPdyzwyuj2OFPjctxfAWPs+meVawCEYAsX
 KGXizd1nCTKFe9773LwbvRc4eHniltKH18fbjK5eyxl2XpoEhuVT//H7n9xvy+b0N8Le
 P2YqGz6CQ+DwIvF+1jBQNjA6cR3li74cwI0wkZNewkWoCuFIHpaBlycA3U744bOwC2jP
 oehw==
X-Gm-Message-State: AOJu0YwOsLc/oRyn0dtd26C/hfA0kyCorCEaVmTZ7EFUEGtz/+GIXITE
 +RrbULzSPAP7Zpsx6rWh0fmXhvgfHMhWrbiqSPSOsT2VK2MazURLzXOYKxcjTk+cmHkWhcjXRfP
 JHUtsM88=
X-Gm-Gg: ASbGnct/cFsmDz2kmh8bDBxB5TAPvxKh9sfSW2MSHrzxBUVpuAiuvv15g7Cc1EIXTs+
 HMaEgDUNaLjWylYm/I9P4i41eDIAgYv8ogghoNILEglUaJB5Au66LP5ln/kkMct/7C3ct9iDQ2u
 i1RNIWFTEwHTEKTV0yEPOxMWq/81Ne50ZQa7gMsan1IpnunnYUNwrG3SeGrKPoFOK6elX/+pbT8
 HOTZT2ZY4G4PIA6lHZKfI2fdvwqaizVo1i1U5IsSEzqJtKEUhMiR/RgYYLbP+pcfgb4OFwhQ4vu
 BxNZ5MLfM910SbqBihHAtGuy57WLwa1mcEx+EXwAgLEdrlqQWp5w4NIJaGCzI7a9AzCu9XwxWGq
 +lq62vB01CUbKAJ2i/Vkqhc47KoQlF4yEntB4+U9ZBfARYVs3cMRwgWF819zWKTVaGDIapJqEmc
 GvmZM=
X-Google-Smtp-Source: AGHT+IHFipQQHgOgQld/Nnt6RbmNkgW6ek97uKEOq/bBPj2D8oXXYodL+Idl52cLfEvNSaKtBXOA0Q==
X-Received: by 2002:a05:6808:5290:b0:43f:1e42:9e89 with SMTP id
 5614622812f47-4417b3e0d64mr11607540b6e.45.1760456851291; 
 Tue, 14 Oct 2025 08:47:31 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-441da0b0544sm1455048b6e.25.2025.10.14.08.47.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 08:47:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <9f898b02-9d85-4e2a-9686-c59b1fcc16ae@mailbox.org>
References: <9f898b02-9d85-4e2a-9686-c59b1fcc16ae@mailbox.org>
Subject: Re: Please pull u-boot-marvell/master
Message-Id: <176045685043.294229.6266071017444179678.b4-ty@konsulko.com>
Date: Tue, 14 Oct 2025 09:47:30 -0600
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

On Tue, 14 Oct 2025 11:01:02 +0200, Stefan Roese wrote:

> please pull this batch of Marvell related patches:
> 
> ----------------------------------------------------------------
> - sata_mv / octeontx_hsmmc: Smatch fixes / patches (Andrew)
> - dts: pxa1908: convert to OF_UPSTREAM (Duje)
> - phy: marvell: Tighten MVEBU_COMPHY_SUPPORT dependencies (Tom)
> - pci: mvebu: Unable to assign mbus windows for 2nd pcie controller (Tony)
> ----------------------------------------------------------------
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


