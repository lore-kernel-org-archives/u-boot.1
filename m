Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F1C3D6A224
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 18:15:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBE0A8909B;
	Thu, 14 Nov 2024 19:14:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WTwLkpSd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B273388D90; Thu, 14 Nov 2024 19:14:10 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C9F989676
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 19:14:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5cf7567f369so1245514a12.3
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 10:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731608046; x=1732212846; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qLRUj1nCEzgF7FRvEngAo6lz5oKFkcdMnKNpznj1AII=;
 b=WTwLkpSdtQ7UDDW/oUDWhTgnsU+JZdaqo6H1y1T1uhzyPUndFwVja6dRohm4C8vIOv
 PsK/57PnJ/bsnAdjmQWZKUwx5Cn9RoNKxeHUu1atVs2KbzqjSkEBXiPLgUrXwf5vpPwF
 TBbEtaTxr17X2GUENT6fVpUbBpbBo3SzGfcDZL9Y2n7SjAefoEzaq3PtXorwl47CrsYT
 YLT0RSryIuQS7EGrDivGcV095N+zXGNewCQcHVFeFUtQjmP6JHu39A+Fziwya4FBNTfm
 wxAMgkSSMJDsAbs8l13LBSIA5x7hPK5aaxF8+/Lo94iqJzSpdgzVNtRleJ+auh3WSW5h
 YuCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731608046; x=1732212846;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qLRUj1nCEzgF7FRvEngAo6lz5oKFkcdMnKNpznj1AII=;
 b=ZxHBgY6QPMWdsm5wGKBoFWAbO/COqpyrG1YmlNCZKFYn+Vwboxp7T2SsZyPVVQZwzT
 HcyyY3oNrDZhDB1nPpWwbONM21MP/W7bKj16louL3PRfONDgp3cK+Nd+pQeP6WW7zDGj
 bK8iZCHg5XAqSs3W7OTM2igXrl7hO8ldLHHse84OvUaOuG4nmbnDuq48lRmGafFHK0pm
 OpKqTKgVJV95ecDc/Grc3vsnMJcek9g+TYlgrq96OarpX/C0k2VidsAYHRBEopQam5rE
 2PsHdMb/tTu68rwrQS4AK6o24DHY81EnVqVTBUqbZ3ughl1/YCpQH0YlkTt1I8ecPTbR
 Ic6A==
X-Gm-Message-State: AOJu0YyhkH9xzrCyiaAPA82VKm6mQgpTYTCr8uiYod7G4pawHIN13fge
 OVSdCKwT1g/tYSlXMjmUpIYhHb2nKi02hQPsrbqwn1GyFqhKXG2YqCfg4G90SLw=
X-Google-Smtp-Source: AGHT+IGzbgUb4yVZg8FCvB9yJP1ic5qZDICMq8G/gBWPkSSxeN8JoukpTLViw5/YXHH6rDWLdBOw0g==
X-Received: by 2002:a05:6402:270e:b0:5cf:3dc3:7ab3 with SMTP id
 4fb4d7f45d1cf-5cf630a7cf5mr6940527a12.4.1731608046473; 
 Thu, 14 Nov 2024 10:14:06 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cf79c0ad25sm785479a12.61.2024.11.14.10.14.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 10:14:01 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
In-Reply-To: <20241016-topic-sm8x50-drop-phy-qcom-qmp-local-bindings-v1-1-7928f9cbe8f0@linaro.org>
References: <20241016-topic-sm8x50-drop-phy-qcom-qmp-local-bindings-v1-1-7928f9cbe8f0@linaro.org>
Subject: Re: [PATCH] dt-bindings: remove phy/phy-qcom-qmp.h in favor of
 dts/upstream
Message-Id: <173160804117.3344980.138038721044939699.b4-ty@linaro.org>
Date: Thu, 14 Nov 2024 19:14:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev
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


On Wed, 16 Oct 2024 09:37:20 +0200, Neil Armstrong wrote:
> The upstream version has new defines use to build DT, drop
> it in favor of the dts/upstream more recent one.
> 
> 

Applied, thanks!

[1/1] dt-bindings: remove phy/phy-qcom-qmp.h in favor of dts/upstream
      commit: 26ef53e0dc4738b9f86ec31f80b33f748bc85289

Best regards,
-- 
// Caleb (they/them)


