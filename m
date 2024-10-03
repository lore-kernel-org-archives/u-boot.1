Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D3F3CF8554
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 08:02:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D163889E2;
	Thu,  3 Oct 2024 10:02:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yJGnG3Fi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 793B28870D; Thu,  3 Oct 2024 10:02:34 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37B65889E2
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 10:02:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-37ccdc0d7f6so423209f8f.0
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 01:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727942550; x=1728547350;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iEEFHyoRloPiWvlo6Z+8rGV+aY8Q4YnUs2L6a9uEeVE=;
 b=yJGnG3Figih4AMurozxRd22yvgzmsd/V1LcD10taWqfFJcKBnC9FIRm9HSnAgcQbTw
 Me9jI24ywR5iViG4otsEqxWgtqzEmGpXtd2+YbxeaVBy9At3CYkJO01SsNn2TcE1QKGo
 kAlP9lBhOOlov5qGrH1Dc0QppNb0r3WYhHVxwSXVfgFnXs/yeWUXC7Guo8s5wh48ttSd
 2LS10FAHNURfrg3eTs/Z36udex3BL6zAGEorIS6IEs9KYqCO0FyA5C/id2OkiOTQqgdD
 QvCfFUTyMe4ohN/lJbfAYz9fAEU91rAg9uapxm4KnpEt0Njx9xFBMqm+etN2bs1vi7D9
 /GRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727942550; x=1728547350;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iEEFHyoRloPiWvlo6Z+8rGV+aY8Q4YnUs2L6a9uEeVE=;
 b=BImMullONz61pMAGU0Wquz6BFh1pEQ+AGWAHpxUrNmz68TcjMZt5fwz452LUjxQFjS
 MWqekyUZkVFjozzOH7OxWtQoJUn/JZ246sextpbWSzHw+78FE2Wh7ko4kIBgVSEnXhxA
 FFSQFfApAgrOU9sj1NbFKcvBq/XWzBvL4dHhZNde1Gf5MzqDWhLU1XAylx+IZ8hqNqij
 o5f84tsqaXRDnPlY1coMBUR8x37BhIYyQlsOwUn8zyAzqvOiNqksd+MSKy3SJs8wRF4U
 mgynEqSrqM7mSAVaHBOWsiUQHaCYPZvfbtyXPkIXFHm0kdc2dcr3u+kOD+AL4Ag/hMCR
 048w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgrZ/Dm0a1VJRV3LPz7vW/YuQwRAPxQHdnSSfGElaPnzGRlSxkhhzgTKhgCCQvMSW3M+jZClQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yz93qxRFcqWvZRCnCvzD/tAdalNzjm0/7z0dCQY/ou+5BEGgWar
 5tPeQEtEtWGIBLqTZv0kKpaTUiIetpwS4norCL3Llp6ypU55mCCAiNLKB/DO+fA=
X-Google-Smtp-Source: AGHT+IGE5ySefiYvgabjdOymXDHqSnLeKKh5Bi/JffTfGQWHp5cW2cd3A167oYeXVz0UmjKnjvvfHg==
X-Received: by 2002:a05:6000:156b:b0:37c:cd71:2b96 with SMTP id
 ffacd0b85a97d-37cfba045c0mr4205871f8f.36.1727942550626; 
 Thu, 03 Oct 2024 01:02:30 -0700 (PDT)
Received: from mkorpershoek-xps13.carmes.etincelle-coworking.com
 ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d082a6b75sm683967f8f.81.2024.10.03.01.02.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 01:02:30 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de
In-Reply-To: <20240921092050.9260-1-heinrich.schuchardt@canonical.com>
References: <20240921092050.9260-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] cmd: simplify CONFIG_CMD_USB_MASS_STORAGE dependencies
Message-Id: <172794254992.98842.876898139690556720.b4-ty@baylibre.com>
Date: Thu, 03 Oct 2024 10:02:29 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
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

On Sat, 21 Sep 2024 11:20:50 +0200, Heinrich Schuchardt wrote:
> CONFIG_USB_GADGET_DOWNLOAD depends on CONFIG_USB_GADGET.
> It is sufficient to depend on the prior.
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)

[1/1] cmd: simplify CONFIG_CMD_USB_MASS_STORAGE dependencies
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/c74758ccc091402b558b9aa7eaf1c50171d2f49f

--
Mattijs
