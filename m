Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7BADC54E5D
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 12:39:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EDDA87F3F;
	Tue, 19 Mar 2024 13:39:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BahajZzR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5EB087EF4; Tue, 19 Mar 2024 13:39:22 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AB0187F46
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 13:39:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-41409fd8b6eso29123955e9.2
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 05:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710851958; x=1711456758; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CNVsp4dwt9HuiL8/jb2BHviClgRSlyRhHfIZ+DWWYgk=;
 b=BahajZzRVami1XiVQcDV3ha4wcf1xRLcFcWbBOKe8yM9xFUXllzuA4tVsAwqBv37zR
 hhIsi7K/tt2itjig6djCYjDDhulMRpzIodPY59o6YHbu79rLG27AB/+kBvHW/qv6XTp4
 XzW9hgMKZPRhlwID3DYJ8hBz9tOxvwEe2p3aAAOvkIrMDUYcOrFm+Crh1n9Czn1TE41d
 TnAFH56HefZPNAPEq/+qsXizeuZgSJWIOTnx0G5qGX0AN88xdBzCt5J7GANeohf69qug
 4Y+66IYtTLlrocn3MriRm3kU6C/qnFkMb9+buVpXMQtAy0lK/KyiK0elH4WoStv2AlpO
 UP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710851958; x=1711456758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CNVsp4dwt9HuiL8/jb2BHviClgRSlyRhHfIZ+DWWYgk=;
 b=sG0sJlgzEqShMGk60S8IklWsBT1MmvXW5PY6K7yJ4E9CDoU8pKYyUz1Hkc4Uwrd4bO
 tZhQiEU83QpGcc6DD0SNNb2rEllJce031z3wKVW2z+exaIcWY1Lx+/XIiT9iJPi5qR5a
 dHSB3W88g1mbzPTYnNEw97iIJOwnHTdy+dqERZzafyjFDRrzwUx9MrKmw/5den3s9koE
 DmNi4HEUVJLhNo15/esD9CsgwG5wdqegyAoryNVNy5AoPcpn3H4Sbj1mF1YeU4g7gRv+
 Da9a0WiNOzrD/4BrONl/DeBR+7onX9mRF3+Yi9zZAYZPWIgQ8EjaY4fIqqP9MjnLNWuh
 2wqg==
X-Gm-Message-State: AOJu0YwJo1vBC9ggDKh93D1xHj6i0MI6mm45R6uQvtfPQZNbM+jMQIY5
 hAXQCA3v33G48khzxb1RPriEAbOMMFOe3pqDOD2NiTjtViUBpCgTFBOlfqUL9/TaRaWsXr58rM/
 b
X-Google-Smtp-Source: AGHT+IEiTpGhrPmf7yOI9Z1NyaLbq8kJes0RUC0xbg/+/dpxaj1W4ZVYGsiusDLbkMgka3PvX18lWw==
X-Received: by 2002:a05:600c:45c7:b0:414:5e91:124f with SMTP id
 s7-20020a05600c45c700b004145e91124fmr3627849wmo.23.1710851958313; 
 Tue, 19 Mar 2024 05:39:18 -0700 (PDT)
Received: from lion.caleb.rex.connolly.tech (host-92-17-96-232.as13285.net.
 [92.17.96.232]) by smtp.gmail.com with ESMTPSA id
 t14-20020a05600c450e00b0041409db0349sm9949052wmo.48.2024.03.19.05.39.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 05:39:17 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: u-boot@lists.denx.de,
	Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v3 0/4]
Date: Tue, 19 Mar 2024 12:39:05 +0000
Message-ID: <171085193519.1877791.4332452366400229666.b4-ty@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240311213334.3567389-1-volodymyr_babchuk@epam.com>
References: <20240311213334.3567389-1-volodymyr_babchuk@epam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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


On Mon, 11 Mar 2024 21:33:44 +0000, Volodymyr Babchuk wrote:
> Set of pre-req patches for Qualcomm SA8155P-ADP board support.
> 
> This path series consist of generic qcom changes that may benefit
> different boards. It is the part of the bigger series that adds
> SA8155P-ADP support, but I am posting this limited set because there
> are other developers who depend on those changes and I am not ready to
> post other patches of the bigger series.
> 
> [...]

Applied, thanks!

[1/4] qcom: board: validate fdt before trying to use it
      commit: a1ecfa2371efc68671c66d3e186743f82926a640
[2/4] clk: qcom: clear div mask before assigning a new divider
      commit: 10f402108a9063d5bc4d517e2a1197afcfabc3a4
[3/4] clk: qcom: add support for power domains uclass
      commit: 95d76bf4e9a912ee458726a59b1045ecb2eff0cc
[4/4] pinctrl: qcom: pass pin number to get_function_mux callback
      commit: 018b8ab702ce38f79e7d276186565478513880a6

Best regards,
-- 
// Caleb (they/them)

