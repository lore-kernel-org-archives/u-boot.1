Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E03C982E8
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 18:06:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3023783AAB;
	Fri, 16 Jan 2026 19:03:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kvFxk9U3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93A9E83B7F; Fri, 16 Jan 2026 19:03:36 +0100 (CET)
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com
 [IPv6:2a00:1450:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DC92839AC
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 19:03:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x541.google.com with SMTP id
 4fb4d7f45d1cf-64b58553449so4033860a12.1
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 10:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768586614; x=1769191414; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1epf7kpMpJViFc6woFivgNcGYCHBSS9ALzX/dc5RKOU=;
 b=kvFxk9U3VdDOjRl2TRLec8ZafXaUfJqgTqqY9XmFx/HyVj6Mbl47V30/dDZrp++snJ
 oUPWyJKEq9EotfpjgqZNr6ZJJW8dCIiA4daMMnc6aqGtwQzDfu7YLNl49IHwUE+9RqGv
 AlP8SwKJCvDQCRX6W3iRO621oYQ08vqIvS4PKPMshHLWNO94ib2WMiiztWrZBTiVZZb8
 zV3y1P/f2TU6gETVehC7wCH2ReXAkbqRYoEeNDu/JMQ1B9Yz7TJqCxULDTv9pDTGVsHf
 3txyuqmHyyY8H8DHjwC54LAPsXkjyUMc+sCLs5JdBUGORn0LWaDz2DYfxNCGjv1R37dr
 MNtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768586614; x=1769191414;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1epf7kpMpJViFc6woFivgNcGYCHBSS9ALzX/dc5RKOU=;
 b=ng1etxjwTnONhzDhcVjDy/otni2EidhNV9KuGH5MvUeu/FM2rVocdarBlZ0Z+mQC2b
 yOR8vJW1hjKkVUyhIwFkEVeLJ79zkmM45UTXr/pM2KryBEgh1AmehPK+AqEXJnr4FNql
 Ej9eY1TMash+2zhFW6n6Q+p7Ow+8rQ0NwcMgauR3Hs8mhaS5txIXAY+o2oifsOcpSbtu
 aWIMdjD8TzcM2fAb2RpKe6ZtqwpsSQAghZDYvZBGcPpg2r3w/EOKWMUSEnM9k9B8TQlu
 n6VHoPkJ2izDeakOvw7qVUebJz5u09oOZ0gVw/zK9vg2g8vR4xj8uDQ4Fg1ydSD9c8KN
 MWGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoGcSDb+fk7p3ipqATewX4ync2ozNoDn7akEf1MYKaH2lZiDoG4DZOENG0OKRh+x+bFgo5jEA=@lists.denx.de
X-Gm-Message-State: AOJu0Yz4TltqhOXGkyfMHRDhdLUKPk3Lnby8f8CSw2qvSlNUzedY6h21
 2oB+sDBOH8RW9DlesP04TFcFwm37c7DynmY7Aa8M0mYReCcUxIBOHzl03uMiP23bxW4=
X-Gm-Gg: AY/fxX5HX40vpH5c/8W11IqNIGzoLQWmIWBuqmjdPlhLFB/TTX/sdv/DMoqhCb+shVd
 RfnZS54ttH8GIMOfMIZ6FBqy6BoAyk5ZVPtYQ0WqlUlNhKVn8DFNlCWIKJyks2gH2CaQ3EV/EMv
 WJolw6RssxQC1h6WfElcPtKrDfcPGbs+PF/0bvEIB1E3uXtneMZ9mBT4SPA1cW3ODTyBkIritUN
 g8fIEOD2JSFUvO2J2EJ8+hwZnf/uJFiFilKt7nyBACAAcDA9lF3YsoeAQUjHMcf5lJr5WB7AuTm
 0TIGQvIfnZn5wK+L6Vv1yHBGeNtHgoBV7LcSytyOg2JA9CRcfUsrBSlsxNeqxoxrFmpCjFZAA3V
 qKp9LIKqYlIAEyAvnFmxaiBhuVZ+Rs4Lc0GgNL2P2IKObEKPUQ1OGmkiYRR7F2ik1MCBoGwC/aP
 0iH+wvge269Mw8EE49l+rhVn0XbF1Kl/k5BdFYqbQqLvmPtXgzXExaYIQZTF310Ylm
X-Received: by 2002:a05:6402:27cd:b0:64b:83cb:d93e with SMTP id
 4fb4d7f45d1cf-65452acb45dmr2778200a12.20.1768586613689; 
 Fri, 16 Jan 2026 10:03:33 -0800 (PST)
Received: from lion.localdomain (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-654533cc5e1sm2932712a12.19.2026.01.16.10.03.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 10:03:32 -0800 (PST)
From: Casey Connolly <casey.connolly@linaro.org>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Peng Fan <peng.fan@nxp.com>, Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Luca Weiss <luca.weiss@fairphone.com>
In-Reply-To: <20260108-rpmh-regulator-fixes-v1-0-d1b5b300b665@linaro.org>
References: <20260108-rpmh-regulator-fixes-v1-0-d1b5b300b665@linaro.org>
Subject: Re: [PATCH 0/6] qcom: rpmh read support and regulator fixes
Message-Id: <176858661248.3399278.15065647382784480016.b4-ty@linaro.org>
Date: Fri, 16 Jan 2026 19:03:32 +0100
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


On Thu, 08 Jan 2026 21:28:42 +0100, Casey Connolly wrote:
> Fix some significant issues where we leave the rpmh core in a broken
> state and don't correctly poll resulting in bugs and Linux crashes,
> implement support for RPMh read and use it to populate the regulator
> driver state.
> 
> Lastly, fix an oversight in the regulator driver that resulted in PMIC
> modes being set completely incorrectly.
> 
> [...]

Applied, thanks!

[1/6] soc: qcom: rpmh-rsc: reclaim the TCS to avoid spurious irq in Linux
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/83dd2675d04f
[2/6] soc/qcom: rpmh: document rsc registers
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/16889f764bdc
[3/6] soc/qcom: rpmh: correctly wait for TCS flush
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/5942ad0ddb54
[4/6] soc/qcom: rpmh: add RPMh read
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/dc1cd6ed4b36
[5/6] power: regulator: qcom-rpmh: read votes from rpmh
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/3afd2b9f97db
[6/6] power: regulator: qcom-rpmh: correctly map pmic mode
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/deb2b9c4033b

Best regards,
-- 
// Casey (she/they)


