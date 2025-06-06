Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC89C61CE7
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 16:47:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79A9C82B0E;
	Fri,  6 Jun 2025 18:47:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sgJZe9Cl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52AEB807B1; Fri,  6 Jun 2025 18:47:02 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B24C807B1
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 18:47:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-4067ac8f6cdso1867102b6e.2
 for <u-boot@lists.denx.de>; Fri, 06 Jun 2025 09:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749228419; x=1749833219; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hglWJq4gTXmpJpD9ZO22yty0NqN02I+/eOZslhgl7yQ=;
 b=sgJZe9ClU3fHQsYm4PCNmHsMeIYdPevpKDc6lkp2brtLwvM1ePi89cAUJ3SnzRoFY/
 9h69IkZZH3v64qlS45cbhfX/pLmFrx7rJVnO+KSNXKiu+UOP+E6czcp3WHy/kdEk7EdD
 WkOmCJ5dl65fEGEoXZzLyeLJiaRk+xfcvMWO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749228419; x=1749833219;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hglWJq4gTXmpJpD9ZO22yty0NqN02I+/eOZslhgl7yQ=;
 b=SqCTU1iEjKcX/JN7jIZ3sUhM86BVoyKI2gbQPC32YS9HevFOXzgSG5eLcaB1LpeefF
 C+8ZyThdsyLBwalNqAnJamqJ/nmgZkpPeHTNbTqJquqZtBxWVKjfMTjHBrVTI2vjBHym
 Df5pVesKRyxbRyHKwyymLcQiwUbiD5ZE9W7erIze6AF5urtr1rwVI6vNIjq4G5nTLgw6
 Hnvr13/8c04i9Bt+xk9ukwli2AS8gAYKaiy/sk3w0WCNjvWyfov1evv0f2b+3oIV2bg0
 sc7Zdw1/FtaZAQh26U79bVZYNQ3+dhQGtaVmwOmmcdf322o9c3ORn+R0Rz2X7sRGyx8I
 djAg==
X-Gm-Message-State: AOJu0YzbYZOTSMa8atupcqrZwDnkYr2r8LNidCcRbqjQRD/EI6XO5JMH
 zglKK613tfATSBZNtPrslSF1HmMOBbxdvZ3eYkgVh05xppHTVh9rnxE9rY2HjZGme3Ub/QfKx6a
 0AJZnon0=
X-Gm-Gg: ASbGncuYbClZ5t/O2I/TInWapK+57RX9ThvhaiT1v7ICnsl9WgYgD2sQCb6FNY9XLXe
 3bBshlm4hQWSRuEhuLOVudylBFi4HVsJ5lB/WlQSktm3JJJR7YccZFo0Z3qRtT4Ske0+WefT1Sb
 8o2ub4PecpahHnNtQLMV+StwmkF9QHBf4F1VVfYhVVEpYCC/mnAimGRPADMWNzpc29IDT3pbHv3
 5UfeebVGRvigoicbrusHiFfDN/BqI6GFJCsV6kNIrkNvy85zTqiRRTgo6Q7SZm2ks/FRrhs9VL1
 MxRMFVYdHKThW6J+obsuIUIncxM84CDWPGOTgJuChkOBToWF1DnxPoZ6ZeWKMslroDWmhJsYhu1
 QgOKmzSZ+s/Y=
X-Google-Smtp-Source: AGHT+IFbRVQdODY10/Uzqb5xYnOB8jaCK8GT/cVT+P+YX4P8JhLSOkXk2sku+O9lystYvnq2/gtPWw==
X-Received: by 2002:a05:6808:3c49:b0:408:ee26:fa65 with SMTP id
 5614622812f47-409051cdd1amr2818198b6e.17.1749228418987; 
 Fri, 06 Jun 2025 09:46:58 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-409069418a9sm377808b6e.11.2025.06.06.09.46.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 09:46:58 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <20250526133510.2689220-1-trini@konsulko.com>
References: <20250526133510.2689220-1-trini@konsulko.com>
Subject: Re: [PATCH] scripts/setlocalversion: sync with linux v6.15
Message-Id: <174922841817.3195369.8182883483249141857.b4-ty@konsulko.com>
Date: Fri, 06 Jun 2025 10:46:58 -0600
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

On Mon, 26 May 2025 07:35:10 -0600, Tom Rini wrote:

> The changes upstream since the last sync at commit 5c02350fa03d
> ("scripts/setlocalversion: sync with linux v6.9") are
> 
> e2ff1219a554 setlocalversion: add -e option
> 523f3dbc187a setlocalversion: work around "git describe" performance
> 
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] scripts/setlocalversion: sync with linux v6.15
      commit: ef0eec3fa91840ab8147dbb1c44b859879cb306b
-- 
Tom


