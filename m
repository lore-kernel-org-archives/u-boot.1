Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC6FC982E4
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 18:03:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A43E083980;
	Fri, 16 Jan 2026 19:03:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="V7W90l7O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94D70838A5; Fri, 16 Jan 2026 19:03:10 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CA7E838A5
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 19:03:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b8010b8f078so384285566b.0
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 10:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768586587; x=1769191387; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VFSBX29HiXOhjcL8VWQHcu3xUGt9CyjP6z/aQewHl94=;
 b=V7W90l7Ok+sVQqpwubwqJXk9r11EXkeJQ1ymVhOtIfqHyDqKRTRCk9mD5/JdHOhqsG
 XhMWQmZ1r6At/vVWwePdE3CbiKdoGn+uyLgH1p8gVav0de6b+i7Mw7+mcyIpdPF9WilE
 6cWJrd8R0Nhrk+CzW2K7OCWzEI6KtVclpZzQP3ztQE+LnDfTx5Z7FPykimRtecluvzL/
 w3kfvgqREkXhchrjQuTzOBDxYJirs2vTBdqhO35YQUczPe5OLaa3S6CHi6P19xPPRlF6
 cDiDNJc7y0p8gtyShmGrbeKUjI8X2z6O/wrDmVUNp/C2/lCD9GdlI8Q8jFJrR6m/+VdO
 m1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768586587; x=1769191387;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VFSBX29HiXOhjcL8VWQHcu3xUGt9CyjP6z/aQewHl94=;
 b=jbpMjRSKhidqqLCYS6QE8qYH2K1SWczfxSu7XOMytdJm9IjIIfkQAbpL16b2oNptm2
 XqkQkqOHSFLa/lIXZGFQPgb5Lp/N+6oBVcvjuoal1rHnMc7aayRbIeJEyTGYxkf7qPEB
 Kglrg5y/L1uAbJwfXHy1qg2Pt8pF6c27hX8mS3XmBnVaWrOr+AWA3rmqxQ6m9GVWAlhx
 uDkga28n8czPBvC8ONaZLfy6lvsyc8LicseT//Uwc3NRXHJWSPS1GT6sdcU/FjfV6Dft
 ibb6m279CfN4txA7K9MQk5kFioVyCUzPl+XFVDlJ9KLFWVSJt4KSNrh50Ndqm2mngHsR
 +maw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSeUHheLFCYqAXPh6892zISdIDSsLbxrnA84+VnevD0P0tWw4zyUQuVatZhrDru7i0lrfbkyQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwdCFnINJke0fK9Lj+mre5Ax08AS7pRYAbbOgF5mSvEe/P/bA5p
 FIiF/uTnZbeJiWdqmDQpqzyew/4g1g5oSyXeR7IXOM1RTWKgic/Yq2qRa41tLgZiwds=
X-Gm-Gg: AY/fxX5uXBwPsxCkH876fjWyXiU9JmWUFJOkqw8qFtXMhI2Rk3OCtrXq/4UQ278QWIr
 k0fbphtJSkzixaewo/bapMzo3r+2Wt7judRwkRgruIW6ICtzbRvvU7Ys+YI2KX3p1DYGMf5+KgN
 cFVboEfzdV8W6SJxNP0tM3u5Ot2znagqIarhY2Xgq+rMSr6/ny/kHfoWelg+adJqxMrqPZXZpVZ
 CUFiaD58NiB3yw61M0I2WP3fo76KrgTO74jFug2/ZP0Z2Br43IbsVeKNyQG0eUddpzInL3wzr2X
 7nRyYoZywoAB6qGttoVs9cll2MpNJ0QKOvgmj17MZ3toxxbJ3eaKM2TIKkAMo8QP0jcN0B3BCAV
 xV7FoHVxEM+rasZ02CpSBHDFxN65Le5k8t0nxH3CxTnjgivimU/LymaUU9FAR0bmIANxe8YeXcu
 dgXC/uXvtRpnbrHJRFhmkkypBlOP80aIojZMZqBFe+lyW7A3VIPRk40GCtQOweJlg4
X-Received: by 2002:a17:907:60d5:b0:b87:253a:dd2c with SMTP id
 a640c23a62f3a-b87968e2f71mr252786066b.24.1768586587288; 
 Fri, 16 Jan 2026 10:03:07 -0800 (PST)
Received: from lion.localdomain (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-654533cc5e1sm2932712a12.19.2026.01.16.10.03.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 10:03:06 -0800 (PST)
From: Casey Connolly <casey.connolly@linaro.org>
To: neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com, 
 quic_varada@quicinc.com, u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20250630070040.734486-2-balaji.selvanathan@oss.qualcomm.com>
References: <20250630070040.734486-2-balaji.selvanathan@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v1 1/2] configs: Rename qcs9100_defconfig to
 qcom_qcs9100_defconfig
Message-Id: <176858658576.3399278.9758930708800766642.b4-ty@linaro.org>
Date: Fri, 16 Jan 2026 19:03:05 +0100
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


On Mon, 30 Jun 2025 12:30:39 +0530, Balaji Selvanathan wrote:
> To align with the naming convention used for Qualcomm platforms in
> U-Boot, renamed the defconfig file from qcs9100_defconfig to
> qcom_qcs9100_defconfig.
> 
> 

Applied, thanks!

[1/2] configs: Rename qcs9100_defconfig to qcom_qcs9100_defconfig
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/83d9b5a7403b

Best regards,
-- 
// Casey (she/they)


