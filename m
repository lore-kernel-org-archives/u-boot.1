Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71BE5CD37A9
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 16:13:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 948F18806C;
	Tue,  3 Sep 2024 18:13:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lisCimSe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B143388B59; Tue,  3 Sep 2024 18:13:36 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E1AC87705
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 18:13:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-367990aaef3so3279238f8f.0
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 09:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725380014; x=1725984814; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1dV2siLIpW0XYxcz3YHoUgQJj3gtd+9lCoRd7FEhem4=;
 b=lisCimSeX8LrlKmfK1RvfqBMIk8USYk0FO8Pl7eOTeZ5izVy70t5lx5ySK64nub10E
 2tiUlP92bX+wSxGkCDmonKYS/90PUbuvPIKvL5yAYlRM47CnjTwsrqq+jR8Ptu8yMgVI
 +q+c2lHWmMG1mVXDlFwOhy0o3KPqyJddwHopVitjQNPaCnAdUKS8TkqmJ61jswztCqys
 qBY/QbSX3kO7ld4Z6AwVZxFEwi9t+/DklafVj38nA6/7WfDNa4ep5znxcVEkM3XGDpDA
 3pR2qkyeCes03I6Ql2SgsqvwM6/v0r+7PfdxNlP+iMcECIkZabt8REH7XyTHj1tBKn9u
 Hhzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725380014; x=1725984814;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1dV2siLIpW0XYxcz3YHoUgQJj3gtd+9lCoRd7FEhem4=;
 b=mrkcbZddoaNLSiWbSYTiw5uDt3TuWDZ9dVkkvpZNxoJMgyuYUF9Tk0nYbRIQSe7LYx
 AAP4HahV488S4oAjhJaGBahUwSwO6+L7GPbjYssmMRfw93bazxzzhe15rpLVnA478Y1t
 UwPusDz5LALmnzXbn2XVsQRWu97Goos7T3rZxiMzfwHpT0ax1TGypA/L77stJlVOPsLu
 30a2Vg9VZCYLep9xrFRnX+8YwLniXzUTHIB72iHnsx7vVCSoVcBlmDiUZmWCzFvEKfmD
 5sJqxktyBIyx63B3zDoZQLR8+san+IppqzUtfQwesuC1MkkVDeYKIVg5qv/G4M5FEISS
 NYuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6AKQZziLahdbqlVd4waovZF/i5MbnCrkY+aTzFBqbI8S4VfNI/FMdMMzifr9KdbmcLZlxCqk=@lists.denx.de
X-Gm-Message-State: AOJu0YzzDgb9P3A36HnKRdKYEYB7GRIuwZ3KW4/rQ0D0rJp5TT2sFCEF
 CQDDzWcbJ7/tTlkAQ359jL4iUVPH7/gzQbdFaR5IPhzClPHo5V4rnpBQUTuqoUY=
X-Google-Smtp-Source: AGHT+IERDwb3xBrUwQh15UYA/90aGrHBapieplzo1vjogRZfcmMXub8b51XDQE2FOix3K24pU+NrJA==
X-Received: by 2002:adf:ab18:0:b0:374:b69f:8 with SMTP id
 ffacd0b85a97d-376dd71aademr1052783f8f.33.1725380013357; 
 Tue, 03 Sep 2024 09:13:33 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3767dc16f83sm1807517f8f.60.2024.09.03.09.13.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 09:13:32 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/2] regulators: qcom-rpmh: support SM8550 and SM8650 platforms
Date: Tue, 03 Sep 2024 18:13:29 +0200
Message-Id: <20240903-topic-sm8x50-regulators-support-v1-0-0857185bddc0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKk112YC/x3NQQqDMBBA0avIrB1IYkobryJdqB3tQDVhJhZBv
 LvB5dv8f4CSMCm01QFCf1aOa4GtKxi//ToT8qcYnHHeBNNgjolH1OW1PwwKzduvz1EUdUspSsb
 B+jA5b58uBCiVJDTxfh+693leRk24DnEAAAA=
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=691;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=9DTjdj+V6Qp+4xLgTEqzdEYfoHOzQs14d6Erj01mW+8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm1zWru3DLymzeX9ujW1tzy94bNXNv7r6SSkLyuw1K
 QxizJWyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZtc1qwAKCRB33NvayMhJ0Xl5EA
 CRY/xptL8J6/IomE5y34IM6Bae1wQynyJhQ7rJnRQlwLgpWn1HyOp+g2PeU8bJQh8SIU3eNnmi7BZu
 iWgMt5Nwgr7FhUXM6LPNsQSeo0AsMTQaKWbDxKEmn1HI5rcXEvRVBqGuXgw1IZaergTuVggk/9c3jj
 7Ez2mMlPGGHi5F/3KJfDE5ucqlI1ELp6lGBaF8SodUPJuelRV3H7fPWQoKLmu1J9UZEjNq7niCB448
 G/LH/HS6YZ5zsKQ0J2V3f3O+Etcr15/vg+DiUZRli4DzjxTXy5Gee7msQjnJzFvfyyp9fDPJlILlRF
 gjO1HDdX3+ZDavYuitB7p67RAzIkT8i1oTQFuUwKxNdUZpxIg4AzZWjN/qf5/58XJu/ylfjb8nokDE
 wt6V8c13S1sC6WuJIVbtrQvB3b/EZBXS/4rmWzmVZUOOELb3lba+1gcFAw6poq0C8CRjYJU1lYhYB2
 5yVs1Pu52oimQqkuQawd9NduafnxPJDxD+/7TKjJP66zsOn4M9xnx7xJgULSAtNBnfH9z5rW8P8Soh
 p07E+8sbEqNmdOaiECwQHrmzc25a4wWKmt3vOJGmvS2iUr7MO4oTMRblamMUl2D1igQ9izYuYTACgZ
 sITvjYOkSt/eVh893Y1jmAduRteJNXLuVC19yBBWVVPXQvwEFcOwMcxV39IQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Fix the RSC and add the tables for the PM8550 and related regulators.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (2):
      soc: qcom: rpmh-rsc: add back __tcs_set_trigger() for SM8550/SM8650
      regulator: qcom-rpmh-regulator: add support for PM8550 & related regulators

 drivers/power/regulator/qcom-rpmh-regulator.c | 136 ++++++++++++++++++++++++++
 drivers/soc/qcom/rpmh-rsc.c                   |  43 ++++++++
 2 files changed, 179 insertions(+)
---
base-commit: bb403c895887eb5b29652f916646f886b34c6309
change-id: 20240903-topic-sm8x50-regulators-support-b149f2417299

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

