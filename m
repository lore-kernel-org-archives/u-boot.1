Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B4A8D6A224
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 18:14:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C48F389663;
	Thu, 14 Nov 2024 19:13:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MAbvP/yb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71D6E8965A; Thu, 14 Nov 2024 19:13:42 +0100 (CET)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5982A89667
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 19:13:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2fb5fa911aaso16334191fa.2
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 10:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731608019; x=1732212819; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PU+Sl2CmrfGs+yCrJRC1TU60JV2s2M9q5nwUveMU5Jg=;
 b=MAbvP/yb7t7oYsb6LPpSHrRzkXUkd8ZpYm94LFrKpa3J97M0pGzJzcgoGSYm9HVSPO
 Ui5QVaOWZ46dnU37jG8NppUi1Lp1IrW9PTboVA8Ua1yJr+wLnT6Xt/coHGr5AvqNgAQp
 Ia+r/G40swyQqZoLBZcaMHe7EzyJgPe9ITGLK+Rv6yaxmUiaIDG3fQnges3f1JTR5pET
 +yq3d50bGc+PwM/ewfi080QDmhEuZ47lCoi+NKTXJi+DjQIAcuLystKCX5deFZRFtytA
 +qFstZzfvJj2CoxXb5akTFZuP6WM9SwvSUEnJI6kcXM8Fjef+9zda3XlEZVpPxhbQKcD
 npeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731608019; x=1732212819;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PU+Sl2CmrfGs+yCrJRC1TU60JV2s2M9q5nwUveMU5Jg=;
 b=wf8LtSW5lv5aetGBZNuK2aRQsQpkTYOvodJrf50eW7BktfoeTlFCKwn7SHWujeOEuV
 l80UsAN95f2MHA83059aiwp1H63piboHIekG3I1lkI9fG7RDZdCzhSWxq4Ho2w+r7AvE
 peSQmT50ERYQahy84AhHQIuHLk7h1V5SWsf3caTUlGMMX1cN3Ry9hPtVnLUR8eAXZubX
 v/zefgkwhMvfK2dh9VpRcUDLyaMUBAWBYc1kxk2QIxfoqKKCRBqEjKj3CvWP1yuh/BvD
 9DM1c16DZafYUo5vvzwHCusG2jVOBC4OGsErHS0M5eto6rmHdBz+4X0+DPvV5VpQUfKW
 wdAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUh7eMDb8HYZu3DZr9lYHBdTUH+ovsGUKBRDy7DfL9pkwStUhD9GYTL9wt0UlN7I/TFPo40OWk=@lists.denx.de
X-Gm-Message-State: AOJu0YxGCy3ixIJF9PtjIIvk1uu3214+rc779j1FRsTVY+y5YipX40Sp
 ohfJkbEdFozmKIS50L2YsLc22MDt3N4Xf/aEkn44IfwjwriVcszmoxtVGMIoVrkZzj8hxaYnUoe
 p
X-Google-Smtp-Source: AGHT+IEhsFmBB4AVJyjencHl3qgMvZDWspE/CPNQJSbD5wJTA5PiCJDpwfzZw3nM80Tll7nbsW0hxA==
X-Received: by 2002:a2e:a914:0:b0:2f7:7be8:fd89 with SMTP id
 38308e7fff4ca-2ff6061066bmr666511fa.6.1731608018878; 
 Thu, 14 Nov 2024 10:13:38 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20e0860d5sm89590366b.186.2024.11.14.10.13.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 10:13:34 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Julius Lehmann <lehmanju@devpi.de>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20241002-sm8150-qmp-phy-v1-1-719695ad2f1e@devpi.de>
References: <20241002-sm8150-qmp-phy-v1-1-719695ad2f1e@devpi.de>
Subject: Re: [PATCH] phy: qcom: Add SM8150 to QMP UFS PHY driver
Message-Id: <173160801381.3344230.2336501688352553027.b4-ty@linaro.org>
Date: Thu, 14 Nov 2024 19:13:33 +0100
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


On Wed, 02 Oct 2024 20:52:17 +0200, Julius Lehmann wrote:
> Copy PHY tables over from Linux to support SM8150
> 
> 

Applied, thanks!

[1/1] phy: qcom: Add SM8150 to QMP UFS PHY driver
      commit: bea0812f7038c72043d4a86c25c2a967fdceab48

Best regards,
-- 
// Caleb (they/them)


