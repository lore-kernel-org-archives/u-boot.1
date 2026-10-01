Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD4ACA5FB3
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 09:56:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F231140D7C;
	Thu,  1 Oct 2026 09:56:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qHVXqRUS_yLE; Thu,  1 Oct 2026 09:56:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org DD36140D64
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790848582;
	b=GEdzVb77l4t+dCIicqV2XsJcWJflnM2MGDCcsDwNmjLjBtdFvC0ktk4b02Zbs7n3oMTf
	 bEaaP6TMUl6SwkieDWmemzLdbtk3x120BuJ1YdWD5P3T+EWojJaNpRzJ5GzFMVJcnWmA4
	 ezyiitrh57ybd7syvSFf3HNBG4JTFhmNhlbKOUKfIFwfMAWaO9/i6UlMxGAzpQ6unCcEe
	 KZRwoPGDWJTg61RzQ0/a5olTMZj42wGPzhCZrJ0nAFue1OiCH13wtglbtbmRTqm8KEzvi
	 WNp5eMRp1yQr2ZKqUKAQsLXkqWazOQPfvsW+eBlavwZTzyhC2FBRxIuJKNVP3BjXo7A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790848582;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=T2PCt+TcLrKr7EZQfdNMfYlEGbWyhmT7/UVnS3SlrhM=;
	b=jOdU1gQutbGjMAUU9bs0YLGF3aVCUsea44bsQje5CwFg50Lv8yGNVjGxNmRx0hWVCERa
	 YMaauEJ3TP2HVFUKvNKusk9s+IHgV27aPjFsRLDnVLp0+UZSA8Ji32ayr/XhixkY4ZhO2
	 a1tL25nAoKr5toZTsCjaLIMAKzRtvv9XCIX9mx4WWemEe+BdC1ShcAZ58mglCIMGwLrIL
	 GxZNoxxN//h4uJdaLnL7aj3SczPmOESbCn/u7b5hKb/s3Ym8Hs3ML8gskvTDGi3GqPMtq
	 tUiDG2N7m6APuOJabzSG3QYt+qMc8/R9utEAlkX0ccdUfYM9BpwlaWeF0wJ91AfkzVQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790848582;
	bh=T2PCt+TcLrKr7EZQfdNMfYlEGbWyhmT7/UVnS3SlrhM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OBbgiSIld7ytstUfsOzzYOEYzLIQ1rsSzgQgYlwwt/iAsbMXWj840MZ6pZjQ+yw2G
	 H7qIUszt28EfAfp3I79gRAXrqeBEF5YbN9mNtz+3QBXkjfSEXCXm1CYo591gdGvBSP
	 m+LRQNmeErFdOjZGNm9MSzjJPE1r0t93OpCvenREUgxzUhHRv85GMM8U1ZhG8KAQ7c
	 Xc1EnPW2eMdzO5LmyoUlbSOabg/OL0+6kAO9Bg7mhzEVeqWiWW1LkF36mzIkMI7zxg
	 V4ssdCBRpyfhTH697RSUG1Su1+nY+yuwIhFVkn+XVJz2kstCFKUWvQzaHEQqLXwyB2
	 vfbSORQobRUqg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DD36140D64;
	Thu,  1 Oct 2026 09:56:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1BD2ED22
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 09:56:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 018DF40513
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 09:56:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NN1-XzhuUIJr for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 09:56:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 4AE33404FC
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790848575;
 b=fgQkvHKmvhQL28zZg7XRFCc6IjYYxIESE8VsDHKjSiketR1GhVq2TgC0vIMvBxYXDefT
 X9nQycChknVqeg4IIsSqjvnS5ZADttOeIm3EWjhk1+xJh4dVY94ZK+n2bLpbJscKcvDQ2
 NZcU263Zfp7PLzdPgSR7NpiRxKkQL2KTAZKRpYcl7591UOys3xQUuIknqsrwSJ7BvlCG3
 O+SaWBLVr0WKIJlh1Uhe/0FCLbPMSYpmCXhiQX9Jc0WLyh4Xb1dT9SzuyjWqb+GCms4eL
 OdkvhmyKg7GE6t4JEteEy2j0vcy0TucCm6nlXAc/i9zmUeycTL0H5oLg02y8tLhGbfA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790848575;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=T2PCt+TcLrKr7EZQfdNMfYlEGbWyhmT7/UVnS3SlrhM=;
 b=UhiITduhElEOKR3yB6uCGSjnQAksnYLlmX/N9cwTNqt6Vz9NABptpDupbpT6JYhmVA8g
 eZFvLZTuGzLnBydYhSdv4/0B/6ox0ydZJcLhhfIi1RMiYhjFhOPs3zded6JwQk8wbDUDu
 XlfbsrvCmP1IZX4hp4myIWBhfLjrU4QTOtlqm+hkSZ9/PMCTfgGMbv0Bda+F0jMf5sH4J
 FULWZJRYPHBxTOrJ9f1CTSSJilr1gggOp+OUhZ/GLbnxTG40cczH3zaXAb2ZrvT1syBc4
 ONX4SCGTKbK2e0f/XmQvQHfNAsYdnF4a9pfBFiRZk93BrkwKIBmSAsAKxMN31Cn4CvQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=voArr3si; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=voArr3si
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4AE33404FC
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 09:56:14 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49e66390995so36403695e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 02:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790848572; x=1791453372;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T2PCt+TcLrKr7EZQfdNMfYlEGbWyhmT7/UVnS3SlrhM=;
 b=voArr3siEGe/CEBePPObGa5qZtgArRbPSn9Qsq9PtnUJBO6an0gZdDKvdEU+Xw7M/H
 kcqdAaYLkWvuqea+FRMIhrev1gXrv3hNm9UeuwrIdcrHiHN74h8p0G/ho9KEGA/CqUJ0
 u0f0N8tfYUKKXT3elffF58zL6TBAH+Ci67GXlntoZ2abEMox9xYA1WoQUrlzoKacZnhM
 6Aj6zigM4qfkIzOcVmZiT70jbzPknmvjOAYIQ7WP4jziVtGpt67TWnFRYWz64XdD7AHj
 lesK52vdQk+6NOaxTVdzzKplnMXmQzulObCsOnnSfOLuAo66QCwRH2iv7FCnBLX3sOIm
 yUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790848572; x=1791453372;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T2PCt+TcLrKr7EZQfdNMfYlEGbWyhmT7/UVnS3SlrhM=;
 b=O3nSvi5sNRnPq2Hrd4R4Ca1hoHn0G9KONPaA+RyZrTHRlzL8niVvZyU0aAYhxiJZrz
 1hcWhL4p5rvja9wzYIaMgNE45ziN2cGN3aiQQw1Ws2s5vqpiRCK0w23uYXJkKp00MVcp
 NS6jd4hJOSjiPnPwu/m5HSQys32fGVlqrCWBwN5SQ+TREUhpg+VfgDF428hXZ6K8qRPY
 Sy6z3T0LdQPKkWcN4G6GWdkDkJC6Gu14RkxM2IhADaSKdkcYSX9M/MO07TH49tI5nTx3
 gahrAYqRC8OW8c0+R1JOIuF8fO59rdkpt15Wei+Dqe6TK9cpjpSMILB+BhlQCnwK4aji
 meGg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxGSu9wLVwyMXOPdkjtzn2yrAmiMjAjLaAlnhjbOatoF0KZ8MsrnuRmL70W2Tnj85gtE8GW054=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mZENzVQAXFc81P/ZZ4uQdRiR9R6XINxIt7g+xlxA0cdoWDwKb7
 KMSlvaohZZ/q7eslEarEDhq8InfYoP9V0vmxUCdZnkHIWl/5KEdv1Osgm3awAKfHZSA=
X-Gm-Gg: AYBFou19oT9WegeIkw91R0QQb3PU352rmBDjoR/Hq7dGVlncjx0MPV98B+uwpeLaDr3
 RNq24oendF137e9tqmznFUooGZ7evHS0ceOsdVol5uNoczaVuMfxr7qWmBHo9EsfvRXpejhDwSw
 RztaJuUyob3BiH2lDeeFTp+fBiUE4FoUCBAK6uv1hXS65JfnVU/Uu+iHWvQn00+/ZqQbB1JUUdH
 nTYPA9A0A9heWAR/2mhFjFEaGPUV9JIsUzqMYKmHM+Ho8Oxt5WOE4HMWthNFM89/PElvbysIsiE
 iRfdCWGw3qnsk5c+4t7lE71W6/EYiNCrRljvQ33wMK6NTmljAy1VPw3xYossH3eN+qG5zFd/oeF
 uiy5qda5yicNamVki0sFo3qrHwSgRVR7k34SStwxWnv5GzZTzeWM3ppqxQ4nv/Xj3TYHMz7LZRK
 qm9khRIG5gBq9I0KNhdzIGB5gmM6eLaydGFYL/yaCDPbOctummXi3ooIu7pDIwdo0vDL9rOQhZ9
 +hAqMrrMx9sIvWnnUz2CuMRxaHe5gkFi3NxVcQTpx5oZycpoX4=
X-Received: by 2002:a05:600c:c3cb:20b0:4a0:258a:b25c with SMTP id
 5b1f17b1804b1-4a0258ab281mr1994625e9.29.1790848572277; 
 Thu, 01 Oct 2026 02:56:12 -0700 (PDT)
Received: from toyger.tail248178.ts.net (p5b29ec5a.dip0.t-ipconnect.de.
 [91.41.236.90]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01f922ac4sm54012045e9.6.2026.10.01.02.56.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 02:56:11 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.u-boot-project.org, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Lukasz Majewski <lukma@denx.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Ajit Singh <blfizzyy@gmail.com>
In-Reply-To: <20260820-sc7280-sdcc2-clk-v1-1-ef3227e4e49b@oss.qualcomm.com>
References: <20260820-sc7280-sdcc2-clk-v1-1-ef3227e4e49b@oss.qualcomm.com>
Subject: Re: [PATCH] clk: qcom: sc7280: add SDCC2 apps clock support
Message-Id: <179084857082.7191.14279077668983719888.b4-ty@b4>
Date: Thu, 01 Oct 2026 11:56:10 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


On Thu, 20 Aug 2026 09:59:49 +0530, Balaji Selvanathan wrote:
> Add the SDCC2 apps clock used by the external SD card port on sc7280.
> The frequency table covers the standard SD rates up to 202 MHz.
> 
> The 202 MHz rate sources from GPLL9, which the earlier boot stages
> leave disabled. Vote GPLL9 on before programming the RCG whenever the
> selected frequency uses it, reusing clk_enable_gpll0() with a GPLL9
> vote descriptor.
> 
> [...]

Applied, thanks!

[1/1] clk: qcom: sc7280: add SDCC2 apps clock support
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/e2bdb8b6c68a

Best regards,
-- 
Casey Connolly <casey.connolly@linaro.org>

