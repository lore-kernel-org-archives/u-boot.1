Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E29C77B7F
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 23:49:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB49A82C4C;
	Tue, 24 Jun 2025 01:49:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="g/8YJYfE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A340682E20; Tue, 24 Jun 2025 01:49:27 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D87DE8210D
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 01:49:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a4ef2c2ef3so3672784f8f.2
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 16:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750722564; x=1751327364; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=APPEjlvNHE29z44YloELYD+UCWB4VIPKYcwLJiVHbj0=;
 b=g/8YJYfEV3a0M+tD0FG0UFiEDFeYWM4VMJVNPuEJTZCYZPVQ1ANTbWHSaYoCulozZP
 EoTsaWrYrV93ivhMpnsZhD/60i01qVoAaxdAMeW4BDANwEvYWc2L+G/nkUFvB+p5lvK4
 27CM55YJmhxCjGgheH+WejXipffyC+rrYjVDehhO9IuIJSgtJmtI4UIMPa+F/yaB660x
 Y0F3e9VKbzFl7/d2Qz+lI54bzOPMFtzVoP+AhasZkw43Rw1//n3RiUYc8ApaivVXayM4
 G5ExV59QCj2GK69PiaKvXStx77wE4W0YPFD5k9GsVVx6/eBNfARzAmyUBRXk8D0GjhJV
 8eQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750722564; x=1751327364;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=APPEjlvNHE29z44YloELYD+UCWB4VIPKYcwLJiVHbj0=;
 b=Oh68z5gn7j+aUCZalPq69Eyf1gMgSpkLL2LXY6Mvt12ZvDbw7kbfs++BDjJw4Oj89Q
 5+9zf89MZknO1voEt13wQNWVfJVNc7mahifQr6UzMfvRsu/+dPfZp62kvQlwhvJ41NPj
 r4vNiFV9oBt/Jq3mCH/k7iXiQgD9QaypJs0W3GvVinBN4labnjnB82dSLsHhBQgPbS6n
 XeAFvtSHTqvPgOgYUJv1+1COlOifpgCN1PWsIR0+U0fp8In2rXZx9PhPp6sNrqiTzT3r
 YUPFVf2vd06PW+fC0pVzLX774kPrhPLeJorBOX/6l79OyO+XW2W86TC42TGPrDUpGyrr
 j1Vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOk4cnvabPAVFzkRAp7krZFfP1+dw7Q+7W2q0KqcmTfTEk7w73NjnAR0z7AlsLMW2QdDAsKVc=@lists.denx.de
X-Gm-Message-State: AOJu0Yxse3Rr7dhGcbLfmKFMw7NymZoDuDEKJID6VW8CEREXtY23DFUg
 6mkqS4dZHtKOMd4hjDFHXaLXKetDpPRz9FW7LYP/fC1L0Eb7M0K5dkZOhCeLz08oHGY=
X-Gm-Gg: ASbGnctsD3IhyZ7OuGFJTgTJMHOVFZgbiLlf0vrn6qpWkIO1G2S+xNPHVD81dKqHvfZ
 u+ZWwe4gkAPgVEtRLO625cH40j62zjkp6hPiWrIx4M3ogGo/AiNyPlC9owq3EFSzkXhngIqKLWJ
 8FvcCQYaz5jAWY30JLsTiOiw2WdY8t5rZMHBDNs1PcbjHi7KosumxSey+WqpR/54ajW1y7AiHjD
 uM//B1In5vhyioWiYEeGmXlnRKpDBa4zG2kaO80VspjQID/k2jNN4Yr5PgyEhgGuLgPZOaAYsty
 11iQDl8ke5sT//bXZi+/8RkebvOhz8Y1JfhJRORsE/aXHqzsRwRuQ1IQFwQet98dPf93MooPv22
 +dZVFadOjUco=
X-Google-Smtp-Source: AGHT+IGAxNKkpOuVCHnILVauGYn/kAZzaDIs5ujFgDTT0OTBf0avniD8vnodfagkQR0J5WTSW9Z7lg==
X-Received: by 2002:a05:6000:4212:b0:3a6:e2d5:f14c with SMTP id
 ffacd0b85a97d-3a6e2d5f777mr3526918f8f.30.1750722564065; 
 Mon, 23 Jun 2025 16:49:24 -0700 (PDT)
Received: from toyger.tail248178.ts.net ([213.240.182.16])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e7fb5716sm432284f8f.0.2025.06.23.16.49.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 16:49:22 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: trini@konsulko.com, neil.armstrong@linaro.org, lukma@denx.de, 
 seanga2@gmail.com, Volodymyr_Babchuk@epam.com, lehmanju@devpi.de, 
 sjg@chromium.org, robert.marko@sartura.hr, dmitry.baryshkov@linaro.org, 
 andersson@kernel.org, u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>
In-Reply-To: <20250304110105.2762124-5-quic_varada@quicinc.com>
References: <20250304110105.2762124-1-quic_varada@quicinc.com>
 <20250304110105.2762124-5-quic_varada@quicinc.com>
Subject: Re: [PATCH v1 4/6] clk/qcom: add initial clock driver for ipq5424
Message-Id: <175072256150.128390.573759732733398317.b4-ty@linaro.org>
Date: Tue, 24 Jun 2025 01:49:21 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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


On Tue, 04 Mar 2025 16:31:03 +0530, Varadarajan Narayanan wrote:
> Add initial set of clocks and resets for enabling U-Boot on ipq5424
> based RDP platforms.
> 
> 

Applied, thanks!

[4/6] clk/qcom: add initial clock driver for ipq5424
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/d7fb15c17d37

Best regards,
-- 
Casey Connolly <casey.connolly@linaro.org>

