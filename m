Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEFF5CD6E57
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 16:22:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D723848F5;
	Wed,  3 Jun 2026 18:22:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ni87tXQj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A08A8469D; Wed,  3 Jun 2026 18:22:50 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0273E84874
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 18:22:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4903d730b1fso118383145e9.2
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 09:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780503767; x=1781108567; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+FWU3IVR9sythdX6XKX9CH5UYra6yzvxezxD97C1I+g=;
 b=Ni87tXQjNgmPrpD5NdJ74Tx+gSjnBo8QoxOhOjzkLgFTEnPZ5znAbP3wm3feiNBTD2
 UW4iTy3E8xKYy+Dr8ZxGjLIRwaMAX9QXeeodr+cEYiX14F1hFOOlD13EQ74Iiz9ysn/c
 9yLHz+JYZjN+nzvI/tFqtN5C6KoPdV9ZJmVkkTyhWu0ZXAQ4dEzHZIuBunYmEUat6ZaZ
 so4lwmp01g+CglYkcBE9cbVrH3WbUwDU5y5NojGDKUm2BNVOffkgrjr3BajdU92a8kfX
 MKUkFc+fw/MuJk9WHiOU6E7UukVikEOyuiT0lhdp2aWhcCLNhrkGWbunT6OKfJiJ0QWg
 kLOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780503767; x=1781108567;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+FWU3IVR9sythdX6XKX9CH5UYra6yzvxezxD97C1I+g=;
 b=L0nKwntclKjTRqm1KOEtlU9TbHnb8XTJEDKw5hAfSbgnZkHkTBKY+a+CSSf+AUo4+l
 uCdjFXulZjV5/R3noPP7eQups8CU6JGEK9/QevrHgLPLwOTpDW7Wc7GEHbG39Z4a+D5i
 iUQzTeSFUo3fQAmX6MPZ7k0uDL18IGIfc5sABuNxerHPtVEAlfufPUk+P58DGE0aQoNV
 SPbj5L7R51u3cXUArYVqn6EFygXIGP13SVx17IlOO21AU/txZ6ixN7toCNuTKxQjbcZm
 FUKUWaq1viDSZPV3dN0DhASPR1V3ZvOkRGOFtmU3bFCC8sF66/Lw8hqruX6aQRd/ukGs
 9QxA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8B11LewTPP4yKwpnfvuf2oSWKpKR2ehT2b36+eE/68VILfgEv1C0b8OW0klE5XCg+n+kfz3M4=@lists.denx.de
X-Gm-Message-State: AOJu0YwcCa7AbtGrNcD+SjbdJDvsM3Jh2a7SHYwrenJi7Lo4TH71l33Q
 ypUAv13x9eKuaiF6+fEZKgNqmKaMMHE/j9Si5sCCcKcpAOvGFeruyM0rT19LkXnaU3o=
X-Gm-Gg: Acq92OH9LhAefdLQDShDtkIQ2Jya6Lk825mBffG/SjpgWGMhSTITrweQ3eMNvJH5GSg
 gs163AB6JjxrdI0/85D/8WvCph4LCVyLSSh3BWGaFBuFQqUmOQ/glonU8KOuOYa+K+od7CRfsJK
 0Zy239/BKaOv50O5dpoY+kYX/ZSNyVTYrmMwSy9xsDzfieiQLXZEtm5c9C5d7xb1/FBAIUqfjx6
 16lAcpf1810BwEzjexTh9mpJffuGn1UkWegrT8WDtjz2aJZSJZvDh8dsrBm4Q2vyoJo1/UwzoF/
 8p4HwYlwcXG3l5730RfXVW4WLUr78jhCY6zS9PoNfIonay6de3J7STJMGhMbd8ztfJmBYtWyI0a
 jcTp2YErFk4tcNj7WWnrpgkFUI6IlKeZ/RumcqYOh7duze+jhBwjjQBKDXA0z2q0O/xIPU23152
 rsg7oueXJfpiSDG+2cBKm04sK9e4uCn/r4vU5KyUS6Oa/FjoLZM8UDofYQFRLCM5Aiqw==
X-Received: by 2002:a05:600c:3f1b:b0:48f:d1b8:9ab1 with SMTP id
 5b1f17b1804b1-490b5e82dccmr70773425e9.9.1780503767297; 
 Wed, 03 Jun 2026 09:22:47 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490b7d6b990sm33713275e9.2.2026.06.03.09.22.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 09:22:46 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Prashant Kamble <prashant.kamble223@gmail.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
In-Reply-To: <20260524154718.16381-1-prashant.kamble223@gmail.com>
References: <20260524154718.16381-1-prashant.kamble223@gmail.com>
Subject: Re: [PATCH] nvme: avoid deleting uncreated queues
Message-Id: <178050376653.31799.2256869717522214905.b4-ty@b4>
Date: Wed, 03 Jun 2026 18:22:46 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1
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

On Sun, 24 May 2026 21:17:14 +0530, Prashant Kamble wrote:
> nvme_create_queue() may issue Delete CQ or Delete SQ
> commands even when the corresponding queue creation
> failed.
> 
> Avoid sending delete commands for queues that were never
> successfully created.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-ufs (u-boot-nvme-fixes)

[1/1] nvme: avoid deleting uncreated queues
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/61280341e926aee1787d9aedb358a43fad96e787

-- 
Neil

