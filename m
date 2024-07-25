Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F8EC3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 23:54:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD69D86463;
	Fri, 26 Jul 2024 01:54:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pWdNdGby";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E9838641C; Fri, 26 Jul 2024 01:54:07 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76FEA86463
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 01:54:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2f035ae0fe0so7268591fa.3
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 16:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721951644; x=1722556444; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HdIZaG3jOo3AMIx06+MJPwYcmqTurwqp6b/0azibp18=;
 b=pWdNdGby2OcsNcw/TiD4Lw3LoZJhIOqCxHtjD4dtPQ+e2FWDQ4CYPxIpa7frcEIICo
 c+Xd8XkPZ8oferjQe7xrQzS7dWbsil19uOFNjClMPaoyii06113/d1AvXFqEXAuY4Dm3
 oTHPwWzhFbs5bhJmJiwtmAWdLc7gji1qdB0CJ6zmdgDgC7XE65TQxiMB7q2NCIWVHoqZ
 300Y4tPtLuf2hxHBhfIyzYotjqm0oZx3bqJuLnAOfeG2y02f6SYzpyXW1GAdqdtspuB2
 hJeBJUyjytdNzBMMUt8gfcnTE6CWQcz8MKPPaxLW4CmpCxdUiPEorMBzR7yKPHwBjbSy
 N6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951644; x=1722556444;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HdIZaG3jOo3AMIx06+MJPwYcmqTurwqp6b/0azibp18=;
 b=HVGHRQLBPz6P4RwAzA/Gcz0LCJq/h7fFBRY09rDmsHGigFz4Pb2gyETvI5b6uZT3fg
 CPWOfsBRbLTN9jRzH2MVYeCsNoQkszmKJx88rv29Nj3mGvWS5oRnN8NYXe5L+3K8yo6h
 dS+6/P44QTqUcSUn6YHSMj4BRRr0FjAV8NKPirZZmSiZPdypzyqHXjkbFmTvx8/iiNln
 vCuW+wJx69YUE2glJ0vdNYZH/rwoOtvUKnye7EIS7//PsTEACJkSYJoO2S+9e5ldGbCU
 7wAlLNe2ry0pnHghazQRXVSBktw+KvinZ4aEqG3RWQ+p+Im10Iu0p1mWUvhmZbR+DbQi
 mtaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOpHHTyUmWQ5R9WqvbKg8XKaUT1I79+cUzvb+Js0mNfGZyNk8eCDw3OIaUkhFzSbNOOjqtR+2rpGuDDVno5Jc2HXtuwg==
X-Gm-Message-State: AOJu0YwHrQj9CxWe5aTrC0h+g92Lo6IUBpFPJ7NXInlyt/6hdrnrbZaX
 hlraCkteb06VjKRRM6Vy51eELwZBg1GDVE5jf0OJQfbtHdYAeqTl/qmfyY94zqk=
X-Google-Smtp-Source: AGHT+IGWnoSNvatpHXX1KH0LD5FRe77emtWeRLCu0hQ+90ziabHCa+vwIUua/kjAlplZN8T4hRcI9g==
X-Received: by 2002:a2e:8782:0:b0:2ef:1c03:73e9 with SMTP id
 38308e7fff4ca-2f03dbf2740mr22813171fa.42.1721951643490; 
 Thu, 25 Jul 2024 16:54:03 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac64eb318dsm1284583a12.68.2024.07.25.16.54.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:54:03 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: trini@konsulko.com, neil.armstrong@linaro.org, sumit.garg@linaro.org, 
 lukma@denx.de, seanga2@gmail.com, joe.hershberger@ni.com, 
 rfried.dev@gmail.com, u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Robert Marko <robert.marko@sartura.hr>
Cc: j.beck@linefinity.com
In-Reply-To: <20240603120651.154670-1-robert.marko@sartura.hr>
References: <20240603120651.154670-1-robert.marko@sartura.hr>
Subject: Re: [PATCH v3 1/5] clock: qcom: ipq4019: add ESS clock
Message-Id: <172195164244.2298078.8140858213615387105.b4-ty@linaro.org>
Date: Fri, 26 Jul 2024 01:54:02 +0200
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


On Mon, 03 Jun 2024 14:06:12 +0200, Robert Marko wrote:
> ESS clock is the Ethernet Subsystem clock, so lets add it as its
> already configured by SBL1.
> 
> 

Applied, thanks!

[1/5] clock: qcom: ipq4019: add ESS clock
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/6af8dae8523a
[2/5] dt-bindings: clock: qcom: ipq4019: drop downstream file
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/19ea72e489d4
[3/5] clock: qcom: ipq4019: add missing networking resets
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/13cb918769eb
[4/5] net: add Qualcomm ESS EDMA adapter
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/c4360954ef91
[5/5] arm: dts: add IPQ4019 ESS EDMA U-Boot additions
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/927739c0b700

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

