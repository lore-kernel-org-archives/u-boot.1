Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB7FFC982E6
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 18:05:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E388683AC5;
	Fri, 16 Jan 2026 19:03:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZJxdOp1u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44BB483B27; Fri, 16 Jan 2026 19:03:29 +0100 (CET)
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F9D183AC5
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 19:03:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x543.google.com with SMTP id
 4fb4d7f45d1cf-655ae329d6bso1756341a12.0
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 10:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768586606; x=1769191406; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DflIv+AfJZUE02U8ZN1BJ1ty+SSRSoQNJ+Cd6EXPwFs=;
 b=ZJxdOp1uVKbttdcty+xY0MUuij3p9tuk0JMavL8/4+ydzWI4M/Zpw6WbCX4XPII1m0
 Di9ICkwHmLCY4Az9OW/M1JJOjkz47LVH21UDFQzmHwNz3W448v9sWADWuEyetlI12dfs
 w42ZYW1IBHd7zqCkTy4XK+qhcQ9H4ZB2anCAQBgHMIVMr+e6uBFcRqDiZhU84Gx6Cul/
 BIeFa1Aq2BlWAtVTmtE9UOc80vHyrRj92guaIUqPHZRkgsUtvHQHWSzsrYmAjn4p26z4
 fWuO7AyOB1msDfEuovrIWZZMnHiLe6eAqVdY11fPBoPgzpl0vKz9TaXID/NjCye/D1bn
 44pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768586606; x=1769191406;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DflIv+AfJZUE02U8ZN1BJ1ty+SSRSoQNJ+Cd6EXPwFs=;
 b=qDIuaWOMaOmJ4pgDjfmFKmXED+WAn96jcAnbC0Z1fgdaPOVUbKzNz2BhVVKoHykX0h
 LJwsYHxw096RBSYjTswujOIANQM6DyYWuNpK74oeN1FRqMUoebUnYxVii1ehlw0CLqIE
 HUGDl+iW91lECmJskdtr4csoxDRrzvOjdJ3MJ48l/jY/mM5hRaM3N+DwfyHae2beFCOt
 QlqaMPQ22XzLGkMlf/bklxxHvjAkaYMp+YPPekflsDFi8N5OCIRAZS9R8fePrTPBuERg
 36ND+UOn+5VmlAdutyLBmXCi+UbrIdzvnLCGALIVP66/F0KG3a0SGRgQRAXRJdqh28BW
 ZFPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXPrxSBsm88spCLwZ8A604fuIMgNwmdZmiCf+67Vge+bptbQy9+CB6NlFfK1fvtPYiI1ICBvM=@lists.denx.de
X-Gm-Message-State: AOJu0YzW3RN+FSGUkIz/6ZcCsLk1vnCamwhga2LCSTxvWvJZSvxVW0sm
 k41aT+6LpPmzPGHCcMNplrqatfqJ1s0EMPZLl9pj6gpSESb/d1+RDaiOzBet3+Gscz8=
X-Gm-Gg: AY/fxX4c4Hdq3ZkAnLu0uHifTHhx1m9TTa4lXAMoDvoZ7QIdp30dR2BDtr5Q9FVZQpd
 bzCtOh56MlpVTFFtFqTy3BKOPXXobGCqR+hJRU0D93Irs1uBK8CkdZx3nwYHaw4yI9R1vJzRTjY
 6NupoAOeQcNXEbof6mb95Wtvki8KKe+PcsB5nKxcOmrpCe3uSMG+rz6hOZNcO17K96R7WyV23Fj
 ztwBbPYMpUd7iVnRYwIHk+CrFMrxie9XQzb+a/xSq+i+L2w0R3IjJAB7mD23p9h9RrMS63ua0Zs
 iovXRQ2nrNTe/10D4QO6qqkJtUinwwBZW1lFoNnJQK4XyWMNnxUNT2uJLWmhiGwFEp9jFES7v5S
 tz7x9Chpj0XlM5RdTNDEdUh53uNMi6DLG9c6ArlHqLBZ/cbGmnioiQwCSzOB5oRtY7/bKh8cP6w
 yu1vsb7SGMz02lWUhVx4CdlFuazCa8mldwnJjWuwBSz8U9ZUqN6yN7xMSGW81PyJfr
X-Received: by 2002:a05:6402:510a:b0:649:9251:1115 with SMTP id
 4fb4d7f45d1cf-654bb522a93mr2270642a12.29.1768586606578; 
 Fri, 16 Jan 2026 10:03:26 -0800 (PST)
Received: from lion.localdomain (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-654533cc5e1sm2932712a12.19.2026.01.16.10.03.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 10:03:25 -0800 (PST)
From: Casey Connolly <casey.connolly@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Rui Miguel Silva <rui.silva@linaro.org>, Sumit Garg <sumit.garg@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot-qcom@groups.io, Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 u-boot@lists.denx.de
In-Reply-To: <20260114135739.1546815-1-casey.connolly@linaro.org>
References: <20260114135739.1546815-1-casey.connolly@linaro.org>
Subject: Re: [PATCH] mach-snapdragon: of_fixup: support new flat dwc3 node
Message-Id: <176858660507.3399278.10005576385688681709.b4-ty@linaro.org>
Date: Fri, 16 Jan 2026 19:03:25 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773
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


On Wed, 14 Jan 2026 14:57:32 +0100, Casey Connolly wrote:
> Qualcomm DTs are being updated to use a new format where the dwc3 glue
> node and controller are combined into a single DT node. Update the fixup
> code to handle this case.
> 
> 

Applied, thanks!

[1/1] mach-snapdragon: of_fixup: support new flat dwc3 node
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/9be4f2f5f4d0

Best regards,
-- 
// Casey (she/they)


