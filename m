Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 818C7C25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 06:40:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0B9987ED1;
	Thu, 16 May 2024 08:40:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DX4cCWCH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0456687F65; Thu, 16 May 2024 08:40:06 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A123C87ED1
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 08:40:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-34dc129accaso5622804f8f.0
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 23:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715841603; x=1716446403;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bRt36BZgMuuJI3gcGGg4M04K2sXAntfGnMJKZ/7mxOU=;
 b=DX4cCWCHamX0jdlrsuDyCJwAbpNhknein3Iro2+3f5Le8Du8KEgo9867WCBsYNSoj8
 neTdkdcVdHNHb+JhhKDq6gAd2yVsif40m9mVF2XTVyENvypUKkHAc1Fl1rpaar4qqkXh
 N3faQQHb3jlWrYuFluObm0C+0t2igKoBJA7Z0Wa8NFpWwfVKTQ/sl6oDk58xAnx/ikos
 L7w6VF3jNh5Z9yOLhp1wIffTVzS4jh067uEsKWHssWPmtJHfCFHhjotQ3S3O1SE1olaV
 TRmDFCo9YXuQsw30fuam9Aa+cQAEx0cvOUS48RegP04cZP14Z5Hmg+8L7dViHDdR+VGQ
 8BsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715841603; x=1716446403;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bRt36BZgMuuJI3gcGGg4M04K2sXAntfGnMJKZ/7mxOU=;
 b=gYId0QEiJ23l7q0As+CLmVQ8TtNC343Lr8eSQvLvHNvCf3c0nAx/dDFc9LMQBrEoHs
 jP98aQT9jDZNg/PKZukFlcpfOccdG5jV/uBYVUeUpOqmzdW4ob99BS3oYxEv30cMT+cD
 g32w5DU+wnpjmyyghUR8O/3kYUnm2+mr+hKx5x6RyIXoYAiOHDgWazxTZUv2GIfNWIBW
 yAdBeYlIYBxZCmRwswGK9sYHWFu10sCr3uwta19YuGIi3HIo0OGoGM9rDFTMnF6h00Ol
 njKim1kKztaazqs2IL7WK9Vtq8DEB7nEzoqJnRkA+KAWcrX0PpvpABzMXB+zxpkmzVGq
 aW6w==
X-Gm-Message-State: AOJu0YyrHamYVJQWmIHljP+oLP5/fc/1GiPWQuexVM/TypUYJo7Jyoh/
 oGdrBPVxXrn6EGIS7T7DYF8s8ZlKtNbSW/SQqMRzPpYtYlMI0ScjoFpEjbCj2Yw=
X-Google-Smtp-Source: AGHT+IEF6ej+8nf7rHDvz2I3dv8XXbxR59hfeY7o//CXekjS/s4xN/9mOsMqu1PdGrnvQspM4spYVw==
X-Received: by 2002:a05:6000:18af:b0:351:b4af:c84b with SMTP id
 ffacd0b85a97d-351b4afc92emr13070882f8f.51.1715841602903; 
 Wed, 15 May 2024 23:40:02 -0700 (PDT)
Received: from mkorpershoek-xps13.carmes.etincelle-coworking.com
 ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbc4b41sm18087722f8f.113.2024.05.15.23.40.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 23:40:01 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: u-boot@lists.denx.de, "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: Marek Vasut <marex@denx.de>, Felipe Balbi <felipe.balbi@linux.intel.com>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Nishanth Menon <nm@ti.com>, 
 Sjoerd Simons <sjoerd@collabora.com>
In-Reply-To: <20240412202611.3565052-1-alexander.sverdlin@siemens.com>
References: <20240412202611.3565052-1-alexander.sverdlin@siemens.com>
Subject: Re: [PATCH 0/6] usb: dwc3: gadget: avoid EP command timeout
Message-Id: <171584160086.8529.11179405967993150086.b4-ty@baylibre.com>
Date: Thu, 16 May 2024 08:40:00 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
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

Hi,

On Fri, 12 Apr 2024 22:26:00 +0200, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> While there are happy users who successfully have been using DFU on TI
> AM62x [1][2], there are also others who were not so lucky up to now [3].
> 
> I felt into latter category and was wondering why I observe this:
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/6] usb: dwc3: gadget: combine return points into a single one
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/13395507ca1f48de25e70f4d27f709b1a4fa0a82
[2/6] usb: dwc3: gadget: clear SUSPHY bit before ep cmds
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/967b31c3ccdc09284a4447ebc4577bb7ef06d500
[3/6] usb: dwc3: gadget: only resume USB2 PHY in <=HIGHSPEED
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/d107a5319e20d5e5be3bd8fa298aeca9ef4990a0
[4/6] usb: dwc3: gadget: Check ENBLSLPM before sending ep command
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/db11351a887e20ff86e3a4c1f466d3d8dd42754a
[5/6] usb: dwc3: gadget: properly check ep cmd
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/95b4d655a44626f888bf823a0561a175d456d33a
[6/6] usb: dwc3: gadget: Disable GUSB2PHYCFG.SUSPHY for End Transfer
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/30f39de786ff3a87006461903e41a48c811ee764

--
Mattijs
