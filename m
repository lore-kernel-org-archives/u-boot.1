Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE867CAC59A
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 13:47:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26343835FE;
	Wed, 17 Sep 2025 15:47:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="S1tSjwIb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E30E1835A2; Wed, 17 Sep 2025 15:47:41 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD8AA835B9
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 15:47:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-75731ec93bcso1156030a34.1
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 06:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758116858; x=1758721658; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U1Qi+fW56/NOq6Rf17wvJcV22v41H3ZWRRuhR5pFJoM=;
 b=S1tSjwIb/XajCJiOsfOPVRr6sBunoY+Hm0RV5WROhwOgP5ZvP7UfK+2+GMnLAShVc6
 92bS9x37Ml9Nbk7Ip3McwIZzV0MKZzHIkUWRRm1c8aTgYvca4iVXqBEh5Up2cFasHq31
 d2l12JgAYCbuSWzoBQZaH7s75mnG/Qs14q40w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758116858; x=1758721658;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U1Qi+fW56/NOq6Rf17wvJcV22v41H3ZWRRuhR5pFJoM=;
 b=dcZbczI6cDtTzHdskGv6iAVBfCudvd2z1Dy40UzoED1EOLonMrp7MxCRyW/QLbI9p+
 sMZ9ApaEL3374LeZPGdQrWv3ahUWC6aLEosxLBfJy0b9+HNCYsUGa4WbekBVFv+eXhdO
 S9dKDUZscEG2nYtPO3K1RScLoeaDZ6xsyjT2VpEsjxkZPi3qn1VtEDzTpk8i3t3Msdem
 MD6RalDQZMtRnzyqXmHWkfBaWqC+23EOLAohLs+LBWqp0UBL95vFyCyv8qGST+bCnnMN
 6TAEC2SkmvBvSRH01Ou4tyWatncUzu/AjOYG7GDEH6YY2P4NgGogE0hi9vriB/07ZeNa
 fM1Q==
X-Gm-Message-State: AOJu0YzbjlJjhFLrk4BgJ2OJhgON3OV/xBYsyqZN6Ow41UgRa8JPiOUK
 oEfMSPScbwMeF++Uj/qLjKWsXvxWPgpaYxNV9Pw9WSjYoad+hHGpUtggFUjuaD9541Q=
X-Gm-Gg: ASbGnctAkxGjjcY41PRlLcLIbJn0O8fY55Ed8AnEZIEFT7mCWYvCtcCH+FOVixq6rxV
 /BvtqicVq7O9IXN9dGBhDrf/pO46abRN9SpQwftUoSfUgb+Kd5T59OII4TyhUERs90JUYvFuGac
 2UCgi3myDjDT45790RrUxDm43tJZko2Z5uB2MfgBeyLa5z5MGBdGKUUi8JlQ3HbIwNd1HBzXAeY
 RPWiJCl9GEiGHkVTycyjGz6AJ+hEJljJn9BtGKqsKrgHGBM3AC0MsSKR5dOoZAmvxtG4ZBZ2JnW
 zXWDPAYBGeJP4H449dsBNpLU9sUdFIfItOOwInp3cjfWg5/qRkuqLUQT0QHoRU7AModOv9uxmhf
 /rRrEUglGc+QGda/YW2f3mnVGMjE2pD3LbH/DWYEKa6GVu7Ab2eMsWeE=
X-Google-Smtp-Source: AGHT+IED9mmevRPcYWrmzMvVxAjpQtSat5mRUkvGWfY3hqLtKYEwukBtML7yD4IWY4UlYsl9XhNoXw==
X-Received: by 2002:a05:6830:4392:b0:746:f391:9d61 with SMTP id
 46e09a7af769-763124f0987mr1168154a34.10.1758116858516; 
 Wed, 17 Sep 2025 06:47:38 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7538127f35dsm4799937a34.35.2025.09.17.06.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Sep 2025 06:47:38 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250906000102.284396-1-marek.vasut+renesas@mailbox.org>
References: <20250906000102.284396-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] thermal: sandbox: Staticize sandbox_thermal_get_temp()
Message-Id: <175811685770.752169.17120777712581275863.b4-ty@konsulko.com>
Date: Wed, 17 Sep 2025 07:47:37 -0600
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

On Sat, 06 Sep 2025 02:00:53 +0200, Marek Vasut wrote:

> Make sandbox_thermal_get_temp() static, since this is not called
> outside of the driver. No functional change.
> 
> 

Applied to u-boot/next, thanks!

[1/1] thermal: sandbox: Staticize sandbox_thermal_get_temp()
      commit: 27fc6a67a4ca0ab565a1135a30b1e132de3bbed8
-- 
Tom


