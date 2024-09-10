Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF965ECE582
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 08:58:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44DC48891E;
	Tue, 10 Sep 2024 10:58:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="i2HqurcR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27C6588F46; Tue, 10 Sep 2024 10:58:22 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D89D188861
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 10:58:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42cba6cdf32so12675865e9.1
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 01:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725958693; x=1726563493; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oNGPa6G3hlpB0QZYpgGOyP8SlsoJKrcJvviBcQCv21A=;
 b=i2HqurcRGt9FHYUGdFytqOgpyT4A4UNuJr2/digaKYW9wo654JpynNBchllfdRn3BF
 XLW8SHzwEHjIo+BBwzyuMDVNwuhT5IlFlPEP14TIBv0Cxvx2VsW9mSxGEsL9I7hZNerc
 uZiSpklOrEubcft4QHNWImXPVf4pq6Y3g7gDrLn//NA5IEEoW7t84vLzh/CS1LaBdsLe
 ketThPlSJSBzhb+YeJANR6ZPuoDJF9Vh6UexM67NZTwiGmZzoudjEjgEMUyVp7XV8GNE
 gJGsdgap904YZHlPNyvlOMOaFnSlEv1zb9DsV87RWokPXkNd3dnKDe3pR4KOOaJLgqLF
 UfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725958693; x=1726563493;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oNGPa6G3hlpB0QZYpgGOyP8SlsoJKrcJvviBcQCv21A=;
 b=qmsA9Sw6T+J0Re6gCaTEFjX6ZR1wtNCttSCJHZp1BL/ZQvY7ipmO0Eemrvt6+BWK3k
 UdaU87F39i2XmT5aJGwZYLBMUGNOjVYUxueIVSyf6BGWxJzIHIbwNwXsB5BDmUGcz3Zm
 D0SxTV6pndlg+t1gR5EArxTcZB8XD/LwXRf6AZR8bmYVA59HsDw5rdz7g/rsep8z8PPe
 Kw8lgwr1Q2IojVYgpT35k+6u/vLv9MbiA1n7MOlnOjWsRY2YP6oNb7JyfuGMbuf8vsLe
 MOk9wrGiZOLE0kC6zuetRgoeXg2CoOKqRSwX53+IIv/9tEldWOb3zL/i8fXdfUNrxGJZ
 aLNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMFSkUKK5FumNkeeCDdurnVqigyReItTrxf5IJBWvK71Mz4mVZSoGkA7l1wG/3YGxxxSQOYQY=@lists.denx.de
X-Gm-Message-State: AOJu0YyyA55K1q27aGG8diSfRK55VJsVAB8+v+tCD0wsQVLWggscVBfN
 ghNy8lzBT4+m7X0cVfI82nm/HJNmHKpq1kltlt/L9GP0loukSiq0j9xdzbslSWI=
X-Google-Smtp-Source: AGHT+IEZTd7rmL7dQfmQxm63Ie6AB85UaAQOQ6QNOVDFy5Ihn0B8HipRyBtad9co3Ypxv2Oh58FaEA==
X-Received: by 2002:a05:600c:4d95:b0:42c:ae76:6cea with SMTP id
 5b1f17b1804b1-42cae766f99mr67149725e9.9.1725958692606; 
 Tue, 10 Sep 2024 01:58:12 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42cc01d4617sm12905325e9.0.2024.09.10.01.58.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 01:58:12 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/2] qcom: allow msm_gpio to set special pins direction & value
Date: Tue, 10 Sep 2024 10:58:05 +0200
Message-Id: <20240910-topic-sm8x50-msm-gpio-special-pins-sm8250-v1-0-50623a7e4931@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB0K4GYC/x2NywqDMBAAf0X27EJeBe2vFA82bu1CkyxZKYL47
 009DgMzByhVJoV7d0ClLyuX3MD2HcT3nFdCXhqDMy6Y0RrcinBETcN+M5g04SpcUIUizx8Uzvq
 XrskxeG/tMwyeHLSeVHrxfr0e03n+AJnQMRJ7AAAA
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=924;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=CkG8B/6DoN3JnRJHx1p2fmuD+msHch14zEAz+YT4i9o=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm4AoigIXQca0ZMy4hCFXpluYNWh6o9Z5+QOk//p+l
 gAia8CyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZuAKIgAKCRB33NvayMhJ0fL8EA
 CtbxaLGrLPnfdi5ANIS0QT0o6THMdQJ11i4cVdVhM60tc6E26PaeSjkiNufiOAO7j/QJJmAwKorJwQ
 AVvbGyanbeeh+FZKESaMosuwnQCObx00mfAo2zwKFqAqsXcuMe9WO4UrBj/0l00n8kch2K0OvIzK1e
 ywEDBrMB0Qw1ggW4S5+AxiCrPIVl+dl6FKsrbu6gBpoBJrVOfmjcabHmnIfNv4S2UQignBCcr/Cq3v
 JNehSzxRHFimumcpOHMevh2K2QR5PanJGFvx9l30E3GNMdR1dUjvJplzamOAqw1G3ZZGxj/SGhRFI/
 AmuzheXrxolLLvO3YtaTMxYsjh/lxsWoVFDCsw3TyfksPiAQDT4+8aWoqriGG8qPZb+rqdfKbAfKS9
 MdVZRvSxJRzqGoC8cSjVv3r58JbtDVVrBCXjJLDescUiuB8zREgpLLp/RIPhjGPjzR0mZxbTQ8cWbI
 jqhXkHEvDDidMiHL7RN/k4sciAW03vFEomIHo9nwckWBO2L0tZoH8BlxcPKwFvauXfkcqlYfgz9IHI
 cVPf6sQ1xIbtJfW2iD4NRHfM/xbhqmVP5T5LP2/nEOlcev0/214KbKmg6ShZ02+HHRrcTb4mpajTCP
 r+i2KvkzJ7Dvjwo6aNfTENAXhjIUBmbaMVFCXcjPncV/brkHk16ZeCiinj7w==
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

After struct msm_special_pin_data was introduced in [1], use the data
to setup the pin direction and/or value if supported by the pin data.

Add the proper msm_special_pin_data for sm8250 after sm8550 and sm8650.

[1] https://lore.kernel.org/all/20240528-topic-sm8x50-pinctrl-pinconf-v1-0-54d1e9ad7dfa@linaro.org/

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (2):
      gpio: msm: add support for special pins
      pinctr: qcom: sm8250: add special pins pins configuration data

 drivers/gpio/msm_gpio.c               | 97 ++++++++++++++++++++++++++++++++---
 drivers/pinctrl/qcom/pinctrl-sm8250.c | 41 +++++++++++++--
 2 files changed, 127 insertions(+), 11 deletions(-)
---
base-commit: ca55cf8104c0dd78aae45fa66dd8400ef1b3d0ac
change-id: 20240910-topic-sm8x50-msm-gpio-special-pins-sm8250-943311b483e2

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

