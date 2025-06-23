Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25EA6C7115B
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 23:49:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F30582E34;
	Tue, 24 Jun 2025 01:49:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TKYFWpa7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3996E82E25; Tue, 24 Jun 2025 01:49:30 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58E8682E08
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 01:49:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a4e742dc97so3407380f8f.0
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 16:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750722567; x=1751327367; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PdBbsyBB2orH1GRUk2YXVA+LHeLhG4KDUsKu3JQFtys=;
 b=TKYFWpa7wXZfXaQ+k+5fAie4j7uOvlUAftxv+tO/G1S/0WjuJ09Hy7l6l0/VKJs0p5
 zvKrVG01k6LXwpK3FK/aQud4RWq5SwJfkCwBVSAIdERGDY/atAyWpfWl7MIJxtLsFR/b
 +Ck0y9EHAI47WDB+gl6HvsEoWrAPjy4ZKz0dd5g5fyXsM9u5Hko/nhLoEbAAMDVhfKPO
 iPgy3ngQXLuOOay/y76OU0C05Xv4ol0w9gOq9r7iX9trc93hGr7OWmvMVfU4CeMFUrYY
 qieAxuH/RkS5L3Ww5vp3GICncuH+Gy9TIuN5k+FgjguyHuVJnUvd39CojrJUoqsdvcuQ
 KS1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750722567; x=1751327367;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PdBbsyBB2orH1GRUk2YXVA+LHeLhG4KDUsKu3JQFtys=;
 b=B2FQLnegI7CQVQ6uD3UdZSxPuBq/hSB6fgK+IXN3t0wQV98P8MabX4g8rGx97vTK+C
 Frv1Tr6eB+B2nR8SO1JI2cfNH/dTDJlUKJ38ro1juvo9EuiBVrz+Cz5klQHLUQKRz2cc
 bXK8KbsHo6H1VeMeLBs8uj7IHYpHmV7KEza4Z+HnjmRjv9GdOIdfd9fLLntkRXWZbSZV
 Goqjue+kkKzOmb2i/CiO7bfJfLrvQj2J1g2hm7ZTFo/s0+H2fppLPTrVcXzzKhf15YO9
 1xWFEbDMt7fk946xedcYW1G1FXIn7Gs1aq06ksbH2ohSaC111TfWczcudNHdNDywUday
 Q7vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXC/1Mau3geMtGWPLZoOEz7rMvcgQWU1s+CqNDeJVad8mjSOVq2NNzEpBPiG+R4fl+2Q3mJ5kg=@lists.denx.de
X-Gm-Message-State: AOJu0YwiFamwcHtITbKsY5z85zALR3bwSjq4zaCJVdaEZB7kL6iPYiNL
 J+B7gx5jT9ADk5OzdZYWnLQT8U2GSdvVPkmForfxxK9yqqbJbPAcor65B587Vn1jtGg=
X-Gm-Gg: ASbGnct1+i0FDT0AUVVBFdLh1eM55lVFfQ9b4+iSOD6IzKdijLkI8BbPBx0IcvU7x3d
 D8zaxI31MOUgk9CTf+rAg+2xnxEoNiRW0hXjZxClrpMEWC4v0Bxa47hJZwDSoGFoCQlMJQbHYii
 ZGc+D7QyAHTDdByjJpgsykGuQ0WTExEbSY2bKAVNzMm14lmDduuJk3F17Gs7BWHLsnsbuF/6L/d
 vH+E/QcN8HhXMerCfP//p7XqS/uZ0p3m/uovAGBJz95AVYbVKvJzI2C/CEXpArKxzepYnNZihXd
 qatfb3mo7uNl0TH3OStBW9kT65PYJUc8zLxaYtL9HIr0tjBN1oI2QcF+wOkkrcWnyDI7GftXJU1
 jgi9IHh8CfvRpd5wt1BCoFQ==
X-Google-Smtp-Source: AGHT+IFFZqdnqqexh9U/8oo+ywUrvcuZdV94iV5xrNDQY4Y06cL8kIY6EYEl2DUcPb/wBvHsp9a4cg==
X-Received: by 2002:a05:6000:2583:b0:3a4:dfbe:2b14 with SMTP id
 ffacd0b85a97d-3a6e71d4cf3mr890729f8f.16.1750722566642; 
 Mon, 23 Jun 2025 16:49:26 -0700 (PDT)
Received: from toyger.tail248178.ts.net ([213.240.182.16])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e7fb5716sm432284f8f.0.2025.06.23.16.49.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 16:49:25 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: trini@konsulko.com, neil.armstrong@linaro.org, lukma@denx.de, 
 seanga2@gmail.com, Volodymyr_Babchuk@epam.com, lehmanju@devpi.de, 
 sjg@chromium.org, robert.marko@sartura.hr, dmitry.baryshkov@linaro.org, 
 andersson@kernel.org, u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>
In-Reply-To: <20250304110105.2762124-6-quic_varada@quicinc.com>
References: <20250304110105.2762124-1-quic_varada@quicinc.com>
 <20250304110105.2762124-6-quic_varada@quicinc.com>
Subject: Re: [PATCH v1 5/6] pinctrl: qcom: Add ipq5424 pinctrl driver
Message-Id: <175072256418.128390.10922470999303511525.b4-ty@linaro.org>
Date: Tue, 24 Jun 2025 01:49:24 +0200
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


On Tue, 04 Mar 2025 16:31:04 +0530, Varadarajan Narayanan wrote:
> Add pinctrl driver for the TLMM block found in the ipq5424 SoC.
> 
> 

Applied, thanks!

[5/6] pinctrl: qcom: Add ipq5424 pinctrl driver
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/c4aa86c04f59

Best regards,
-- 
Casey Connolly <casey.connolly@linaro.org>

