Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7480AC982E8
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 18:06:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A10A83B97;
	Fri, 16 Jan 2026 19:03:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aMby+Asu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD749839AC; Fri, 16 Jan 2026 19:03:43 +0100 (CET)
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A32F83966
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 19:03:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x543.google.com with SMTP id
 4fb4d7f45d1cf-64bea6c5819so3943903a12.3
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 10:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768586621; x=1769191421; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lb0G2JZfGEPME9Q7XaDUVf3JG+OYVVZxuGeKmV8Uznw=;
 b=aMby+Asu6tyzPEdq1ZcRx02k8U6nCCnlKRbD8IcSIljaMsehb+Zc0A0biALhSrUiNX
 tPIqqipNJmll4DqKRdMxL7wh63e+wFKJFNwabGvWNiF0jzQ/d8Glyc+ECIxScyjq80Qz
 z2xw0Fa5KY3QCPSUWkRww2gjP/sDP9+4I0MJwsj9ScdgT/Gg3QsiNSJYcHGDveFtLcEn
 EKEUm3dT75L4pwHtnN6w2nzqlMuSJ1cX8YvRh4g0iQCY+nBBLnUXVWmxqY+H/imfK5t5
 +lQFDuH126mfPbGzrM26hKHqlbLICuLypymLG8Uxzovk78WWVwBgs+tXC1P/5QkPGaC2
 3UZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768586621; x=1769191421;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lb0G2JZfGEPME9Q7XaDUVf3JG+OYVVZxuGeKmV8Uznw=;
 b=BnKaiUMftgwFKz01YB84uH3y/bM0ImkzWfklEj+zdJ+yZGzbXa++qWc5obaYFuNfQ+
 EYLYs3bl7XQM8CoI2QVo9BFjLC1IAV4pmSE5euYdzXoxrfXsgkGt3xDIqFAVd8LN66Rb
 oI1TvyD1BUcklB5pJMU3bMS7bUuRsfOIc7qmUe1Ea2GOneGuHa9PFeA2SEFqoMtJc76S
 peoafjVmk36EItWuQ0v/DuDmdVsr3u/0c3DgYtb5Ixky2u1T6matyBbwRbCz40L9xQIQ
 D6aqokcFE9X4ImKPAmPj+kEIyQMWCoYXYIwGmF3NlDwNR2GrorRDSdy5Bi+P1Qrjb7k+
 3I+w==
X-Gm-Message-State: AOJu0YzFIY7cfl3FeLMt5/HkrqU/CpxtZrPicost97MAXryY3+1bOUKL
 cqXkPzSgTYf+plkwkKIXrIlDdrvJsNKABr6bUXT1M6CILn3FrF7qUMs6WENty6AJOoo=
X-Gm-Gg: AY/fxX5nsn8Ag4htEkN0NjFiEOwfAzlA8Q1acF5iVgtqY6uF5JszZGZ1EuIW5WI8gu3
 +LHxsT13OnwucxEG89OyiOIAMYgXB+74wNw9WJaoCiaTI5V3spax4RXt3Ze9RNaTReHCgUMGW8u
 LCb5vIr2furyuNGV2R5BClZPIWYl34NwTiYvsjdCvTGzlJw1nRPc4w0phXbPKcuykw/hz2AUP/2
 dnF+CpYJd7BXJfUyDrkigsCNWr8EVL5vnoPX2elQC+6qBIpbGC4Aupuun7bO4JhrRJsQ454zPNx
 hd6f/flse7mxV2SWXpAqx+pQNNpqH6AC/rV30SDhVEGW/mm02IZ5LnIVUGU+ocMuyLdibGSI7tL
 ja79wNXZjLPqZSc3IafdwdMOsEDSuDMr9q1I7JtiL1B7wg9OjYrhPTr+mDf/S7yQzbqfTB4yFmt
 NwhTvf0ekn1TmcVBY0f8a8Jw6dmFivnbxjiR16rjndfnbzpxklHpFiwA==
X-Received: by 2002:a05:6402:2786:b0:649:ce39:3bd0 with SMTP id
 4fb4d7f45d1cf-65452cdafcamr3090166a12.34.1768586621043; 
 Fri, 16 Jan 2026 10:03:41 -0800 (PST)
Received: from lion.localdomain (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-654533cc5e1sm2932712a12.19.2026.01.16.10.03.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 10:03:39 -0800 (PST)
From: Casey Connolly <casey.connolly@linaro.org>
To: u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
In-Reply-To: <20260116-casey-usb-role-switch-v2-1-83a1a6501a11@linaro.org>
References: <20260116-casey-usb-role-switch-v2-1-83a1a6501a11@linaro.org>
Subject: Re: (subset) [PATCH v2 1/2] usb: dwc3-generic: support Qualcomm
 flattened DT
Message-Id: <176858661905.3399278.2711801963645373011.b4-ty@linaro.org>
Date: Fri, 16 Jan 2026 19:03:39 +0100
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


On Fri, 16 Jan 2026 18:09:44 +0100, Casey Connolly wrote:
> Qualcomm devicetrees are moving away from having a glue node with dwc3
> as a subnode and now may just have a single flattened node.
> 
> Rockchip already have a glue_get_ctrl_dev op which returns the node for
> the glue device itself, commonise this and reuse it for the new Qualcomm
> node.
> 
> [...]

Applied, thanks!

[1/2] usb: dwc3-generic: support Qualcomm flattened DT
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/cd8ee4fff827

Best regards,
-- 
// Casey (she/they)


