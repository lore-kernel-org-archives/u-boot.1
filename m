Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F1FC54E49
	for <u-boot@archiver.kernel.org>; Thu, 29 Feb 2024 17:26:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95A4F880E9;
	Thu, 29 Feb 2024 18:26:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="L0I2qpY6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B934C880E9; Thu, 29 Feb 2024 18:26:05 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACE4687DC2
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 18:26:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-607e54b6cf5so8564087b3.0
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 09:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709227562; x=1709832362; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZuhK0OWsyoUF5n5J9XAKnW12hORbmwPNdTeiZs+YTm8=;
 b=L0I2qpY6I61Pddv94kT+ODaLzpcabWAmQku912LYLYd2z/HiMquEsV/9+Ab3Iahvs2
 h2RpQKuIRqFt2plEdh4s/md/DpgRLSSngOoAhe6SUBv3zwOL4p2eVY2Zp97LhhYBzmCC
 W9PbRTtBPcJtVleXzKy/fvTDV/o0OACmu60rw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709227562; x=1709832362;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZuhK0OWsyoUF5n5J9XAKnW12hORbmwPNdTeiZs+YTm8=;
 b=GF5rAfnY6c3nhvUnkQOyTCk7sXTjtC+AQipovih0+gmY6W5CyUcH9H83AoxZxUpoVa
 DBSvrIxc+0KSaepi5wADmsIzM9wiQTY0n6AYlAujHEXG1bgHHuNypFceGWzu0QzWSnH5
 TDm832nKK9NAnQH1spBPmodZxA5+VfJznIRG+V+I39FSd3V3q6M5ha8BIbxExzYHAb+g
 BwR9GbPSsVFxt3z8ly2faRigDT8bnmpn7PdvltyH1By557QDYOFX19dsQWol7z/QUxMF
 QtGQ++fdXe/zXPpLO37KYJ3MKI4uREn1tCTVS6p/th4rXKuBmwqMM6i56dF39x0ZrdxV
 B9fA==
X-Gm-Message-State: AOJu0YwA2CKQ0AJq02Yt6S+We/td4Eyn8j/HQytDFKyga322pN1rRx4Q
 0S1LHWv9XIl+f5g0KACi+Hh02KNGDYMDL83Ayb7zNtn6OnRz9LIuBHUpqOkyg6g=
X-Google-Smtp-Source: AGHT+IG/TFovA3BCS5d6+PjWi6LGGybVu7cANC7evzqnAXj0sw2cwuYCfugC7g/PURCl1UdvRAvvsg==
X-Received: by 2002:a81:83ce:0:b0:609:6338:2c6a with SMTP id
 t197-20020a8183ce000000b0060963382c6amr2069386ywf.7.1709227562366; 
 Thu, 29 Feb 2024 09:26:02 -0800 (PST)
Received: from [127.0.1.1] (065-184-194-195.res.spectrum.com. [65.184.194.195])
 by smtp.gmail.com with ESMTPSA id
 d10-20020a81e90a000000b006095684c480sm510469ywm.30.2024.02.29.09.26.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 09:26:01 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Raymond Mao <raymond.mao@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Kevin Chen <kevin_chen@aspeedtech.com>, 
 Sean Anderson <sean.anderson@seco.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Nikhil M Jain <n-jain1@ti.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Shiji Yang <yangshiji66@outlook.com>, Michal Simek <michal.simek@amd.com>, 
 Stefan Roese <sr@denx.de>, Qu Wenruo <wqu@suse.com>
In-Reply-To: <20240203163631.177508-1-raymond.mao@linaro.org>
References: <20240203163631.177508-1-raymond.mao@linaro.org>
Subject: Re: [PATCH v8 0/8] Handoff bloblist from previous boot stage
Message-Id: <170922756122.3874330.6522939540605415810.b4-ty@konsulko.com>
Date: Thu, 29 Feb 2024 12:26:01 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
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

On Sat, 03 Feb 2024 08:36:19 -0800, Raymond Mao wrote:

> This patch set adds/adapts a few bloblist APIs and implements Arm arch
> custom function to retrieve the bloblist (aka. Transfer List) from
> previous loader via boot arguments when BLOBLIST option is enabled and
> all boot arguments are compliant to the register conventions defined
> in the Firmware Handoff spec v0.9.
> 
> If an arch wishes to have different behaviors for loading bloblist
> from the previous boot stage, it is required to implement the custom
> function xferlist_from_boot_arg().
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


