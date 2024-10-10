Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 471A5D24454
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 21:34:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9B4489286;
	Thu, 10 Oct 2024 23:34:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jLLF82Ts";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 204E6889EF; Thu, 10 Oct 2024 23:34:19 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14F6588ADC
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 23:34:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6cbe68f787dso7644366d6.2
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 14:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728596056; x=1729200856; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ophOOmuj5rkZF3RoFq0gsClc2g0nBWMLc8KidgKK5hE=;
 b=jLLF82TsBgFbyXvqwiLvwmlNUZcYgpZhOzK6kxrurkFi2kK21AQ4l5to6YlquitjsO
 X8EYQfPLyWDqL5S0+QxywUgt02KYaSdZ5UTZPSgVnixWohpSx10kvXVMYSHRFwkSKUwP
 sJuSCayTqJht0dHmk0exK0kzGHdj1kcTeqVWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728596056; x=1729200856;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ophOOmuj5rkZF3RoFq0gsClc2g0nBWMLc8KidgKK5hE=;
 b=sKmEjzUtF1LUriBoKi8AOVWcJnTjs5N8iHKXfNZvKLIYeH+PSW1I4MCNJSn8/cvNHP
 KOvbiRdlpUp/e6reEzOYk3qqpcEOxEGCTytO94HXmfV1+DvVC8F4+2sk65SUOb63mzod
 2QZsDRuudysvKJN5UsW1JY2gREDzHWt5LRZiRtPvxnXDWC9026LTDTK9BUh550hcjNOP
 6PxsfLZeXT2a9lch7XoUXGbRyhiw82hKiwZf62ngIRU8pRRLAssIHX5eSD9qBV6OzN0n
 U2fU60lGn3gKtQASDXTXvAP2md6Varfl7xRmc4rPnAqQ+N5N4jbHMu2ceNDv+1HiEOxY
 tjyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRGUCahJQfNaxL94E83QFmk0b6SX72TIkfREyS/yvfq9tIgKqVOTLKszYiaLWjeGhcCTWwa2k=@lists.denx.de
X-Gm-Message-State: AOJu0Yybw0KVi85LnjMmGEcZ/4O/gsAjMLOvPPyQdy+WNqXg2vs1jTMf
 gXbPK//LjTfZzKWkzGdZG0se0f7oct3oF8VK/BP25TxFpwbReP/OIHxUAEclTXw=
X-Google-Smtp-Source: AGHT+IF3VKCHLPVE+XxlviU89Dz8VtAusXI2SKhoX5XvdpGkLiBHhvMRjJa/gq2nJylfm9iLmm/UqA==
X-Received: by 2002:a05:6214:5912:b0:6cb:7415:4ce1 with SMTP id
 6a1803df08f44-6cbf00444e1mr6947086d6.13.1728596055910; 
 Thu, 10 Oct 2024 14:34:15 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cbe85aa56dsm9096566d6.26.2024.10.10.14.34.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2024 14:34:15 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: festevam@gmail.com, sbabic@denx.de, jh80.chung@samsung.com, 
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de, Joy Zou <joy.zou@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
In-Reply-To: <20240923131133.27546-1-peng.fan@oss.nxp.com>
References: <20240923131133.27546-1-peng.fan@oss.nxp.com>
Subject: Re: [PATCH 1/3] power: regulator: pca9450: Update the BUCK1
 voltage range
Message-Id: <172859605453.435814.2897334517443568438.b4-ty@konsulko.com>
Date: Thu, 10 Oct 2024 15:34:14 -0600
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

On Mon, 23 Sep 2024 21:11:31 +0800, Peng Fan (OSS) wrote:

> The pmic could be trimed with updated BUCK1 range, so update the range
> for trimed pmic. The default value of Toff_Deb is used to distinguish
> the non-trimed and trimed pmic.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


