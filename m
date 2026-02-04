Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56743EA7944
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 21:34:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F3FD8063E;
	Wed,  4 Feb 2026 22:34:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SbXHu46k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF4EE83A36; Wed,  4 Feb 2026 22:34:12 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86B2C800AE
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 22:34:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-4327790c4e9so80485f8f.2
 for <u-boot@lists.denx.de>; Wed, 04 Feb 2026 13:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770240850; x=1770845650; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Fl04VmfHM7CK0FJJkb1eF+DqkAeLifORk03U0T1x0KE=;
 b=SbXHu46kuo22RSnxnH8g5e74EWYIRcAzf7wKf91cd1/j2wIaJnT7kl2cT74RrqiIPf
 XwMiq3REhccgToEMIBTAe+VJk/mXpz41Xpl/dn2bCDqqXydWTZuDRlZiiC0xjxk7esyf
 kDKKWMR9DC9SplK6CkCgJw/Aco4I4AdgJIVM4eJVU5yDW97jLCgONfzbZceeHkIt4++y
 SQU/R93Mqlj7YvqdJrIpR1qA12Q58bj9tLSQvnB3/VozCU86CgqU6BUJbDYGnbY5jMYw
 2DykOt4FEx0082bYydHAZ4sAgBaf2bzkQpc0Gkiew5l/W8Fq20oNQyHDi9m4TDWMgdPf
 ls2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770240850; x=1770845650;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fl04VmfHM7CK0FJJkb1eF+DqkAeLifORk03U0T1x0KE=;
 b=v7ZZzIBCDAWFwV1iBSDLAj8RWajk3fvMAgXkZJKybaLy7WLpEU8zT+gvGn/ZGV9SnP
 pHxd3FKPn0R/GcBkPSiUvOzvG2DzekbqzVjBO+jqDup6FjPKi9TaauNOXEZafmKUuiPh
 T5zF0eqQWwBr6YWaYawsV9Pfr2VU0ITfSM0uN37jEPFabhLcv3eLgqZXB4fwMigOeLkv
 wgp+WPZdZuRFENizKQaEmIaENZsbHvYiQ/4cHmDX/YUE3QZ0prw8mmx3LNRcb53RUSZA
 d2+L7ZlA6LMjeejKMIyjaDIFJnTUSxzXCyy/1ocX4cAo9/QkMM9MDD6qZJZePsOmI6AT
 WHJg==
X-Gm-Message-State: AOJu0YzrPt7mRGHaZK9e1FVhSkbLq91SM0Auuva2QT0ru+fO5C9mifYl
 om7hBGZMZPAdWaq7svkCBpJxynq5XkM8AeEyZJhWNVjKCXC7e/TsLvaCDw9BdRqHL6s7EnECnBC
 ujjk0u+k=
X-Gm-Gg: AZuq6aLj1uaTEMl/+WwwqqBoFcz2WbR4691CDMYbh9NDWAM5xZS1MUYt6C/79EO2NjY
 wiarslrBP30AbBktE3tJKLAZ8o7Rie2SnZG275RM7DNNFiY9vYGZ5rMvkFC44ymOjJhAmgTHS2d
 ciTXXvaURnNnNnLEdFOOBOikfAsxO3P3HBo5HVjLW1eBjo5M3R5Zlzal4RUa+vsXIqg8GG0/Fd5
 nhDWAIAEQmOtujIGpvWXXd9MXE2tETWt3EiuhzyZ5ljquR5TAf7lMzHjOB09KPZomiyP+5k+eTF
 HTfF0+gkRkSO52BllSo5BATyZYekVTUEmX5ChS651pUPMyqIgMMOjvzC7a8UG8OIQMcnl1kWRCP
 W3lLEiPn8wwQmV3BglVcfxCe00EOP6Hgnl20YPZUbIVtnPA9FGaLOdIY2wm7sCm6sjzw0z6Vr5I
 WsN5qkAXYA/E2r1eQe
X-Received: by 2002:a05:6000:196c:b0:436:1970:ebce with SMTP id
 ffacd0b85a97d-4361970f2f0mr4081764f8f.17.1770240849839; 
 Wed, 04 Feb 2026 13:34:09 -0800 (PST)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4361805813asm8681748f8f.27.2026.02.04.13.34.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 13:34:09 -0800 (PST)
Date: Thu, 5 Feb 2026 00:34:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: Using SCMI under OP-TEE (uboot)
Message-ID: <aYO7TjidzQ6w6JB_@stanley.mountain>
References: <aYOwUXOXHgaN1Ak8@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYOwUXOXHgaN1Ak8@stanley.mountain>
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

Sorry, never mind.  I re-ordered my devicetree file to put the tee
device first and that fixes it.

regards,
dan carpenter

