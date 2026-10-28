Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAED0606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 16:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sjI744gW;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zfrgMpjy
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9DCF281177;
	Wed, 28 Oct 2026 16:01:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uojXt8YplDZB; Wed, 28 Oct 2026 16:01:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2FFB78111D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793203317;
	b=ssxqiddz93/YjhQ/RejtCH3W7za9MJyLvtPVd9UrpVH4no+csJPik8/+9QXUXgMeQ2h0
	 +YtwWPjBO9a+7wmhdIFXqRMj9zAbTyTX5Pi/DLj/XNeQQeWR0PzsnOhEQzEtPNzjdZBfc
	 4fvFxoOnbIHPCnnwdp28Uv7TDpEQvtdLLBcy8G9euEHShpQwnBVgW4E1I2CqtEQ6qRf+I
	 hF/oK/2l7oNLhZ9eBx7jkf4DzF1dBdNMFmKhfhSfWVqIkCJ2LBklUvPVuKyHgR50lJkkj
	 xC+s7hQvhqD82NzytJSBUl84lBd3uOmT6inCe3Ihi2bHrvn94VQAngbnysW7UWIcVAQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793203317;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=wjCdF3kIreRG1W43rh8vEHDnzDQ1Vz0JS/rnUD/K8v0=;
	b=OJKiiLukOzjKiP7XXZcnb3ZWcd0+6/6apaK4m3DkNwsUGa9NNpE1fOONxPu6ho0abfnR
	 HkecH65+JPK0aXMLB1tmgZEgOymBbmCZTEmxVLs9m45K8FO9ys+SJWbHVOt/r8I9u7yDo
	 UHjvGR6N0jEUDvK2MRisjCgYU5+bVz97xssHacRIwLs1mM8frmekoTfqIuel08nGe2+xn
	 BIVT79bIN6qfeoxBHgwGzPIzfxEYB/pJH+JMAFI7NL06sp4kyvhPJZxYi888Z6ZTw7ctK
	 hoqV8+zA4Xlzpnx7Yw3dYu9dSsXOtEDwbQ37u3D6qNRNgJh1CCzt0ivbTGOtjFudfUw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793203317;
	bh=wjCdF3kIreRG1W43rh8vEHDnzDQ1Vz0JS/rnUD/K8v0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sjI744gWaVqzQ8XLV9hZnp+fHXcn7n8byFLiQtlVCQeq39HukLKkVHcKtuE/pZkEY
	 Mhy9XMD7Bcl/wXicpZMJUQuNsjzMcJcSLoUxs2W+IUIggLDZ6dQJWKi/ztEPWDd3Bw
	 bKHVT+ccUKpho6bhxhg8G9Jac/ZgCGCVYO6zsIdSDwErJDBoAdgTij80UdeZTa3OG5
	 EtBKZvZ05SPtbpe2852fhzd88IdabE7msQZI5esyukYvQF/H+EErjKP1OGUf3oe2Dt
	 3iknXRB5UUpxShllxkDSEQnUlipNgmofQL8QxRzxlTiHW72x8IRhdc50ZK0EESUvUG
	 R9SGc9FOowsEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2FFB78111D;
	Wed, 28 Oct 2026 16:01:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 58D52D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 16:01:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4B3DF40071
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 16:01:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A3bGTQj-ZzaM for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 16:01:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4A33E400AD
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793203309;
 b=Q/Z6zGzuynygLGcITwCoxW/QqoH60zLvr8XKP5gqLYFx6GtBicd1VqC3mD+/FdKIfVPO
 IxXelbPqCbXvLZxLu0AQ6b072xn8Uhn8xyk0rJMndJmUstF8P/PRDYltxfCQPfEscnOFW
 Po7XJ339rnc4YWJAbfIxr0DlnHDMnJbFU/tXFa38WHJjP9mY+iOHs/8UE0pRGQ7DjlSAK
 v0IxW+3PL1e9AjE+N7svTtJZ0AFcSqpAxyeCwNu9OAcJekT+S/vMuyPOaPMh0m6HEmcSr
 KTaoiHLoGVP2wa07brXoN/G9FkTHIVzZRLHDoDu+Ozze6m1nqWdx4QrVhWWLuPw82OQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793203309;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=wjCdF3kIreRG1W43rh8vEHDnzDQ1Vz0JS/rnUD/K8v0=;
 b=kw0JAyhDNN/KfQ5sb7FJwTZ9MyLD+63kI8t0qYQuY7jblB34Qc2bfcU+I+NJ7Cz16z7d
 78/9DjnoT+R+v23Hk1Ryju2wdHkIhbyqXZ/EwmTRYk3uaKe4X/CbW3DRuykiDvw8oNpl3
 DcEjBcbcuIhA9Y5Dc8sph0CoxYm5dp3ETWzNIZn0EBQBWJZa1KGozW8ZRe8LQ7d/KJgiN
 Y2A6KFLb4YtnK5Tug76XCQafMyMmV7pzxd1V0OkQcDkVWtAPhAdcrQ4u5MVMdjsgvX0Gp
 et+ltzGoukAcSLBu3bGNRS4qjO9rrREjr6akXqvLWKdoEjnt/gzKkIvCbHij6G/3VaA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=zfrgMpjy; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=zfrgMpjy
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4A33E400AD
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 16:01:46 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a2167bd087so11679045e9.3
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 09:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793203305; x=1793808105;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wjCdF3kIreRG1W43rh8vEHDnzDQ1Vz0JS/rnUD/K8v0=;
 b=zfrgMpjyHJbScWDJBtmBkM5XK8zt7gYX3qJZup2E15BDpeVoAEIOji+TyY9ocL+PC8
 cpy2qivxyWCjkbdhkMZ0oaAQb/6NR3tvmBDaz/tdSPWfIjPOdxtREKiD4wlZrvHf9xFe
 o795R43BizzvFUnNjkwaoj9Y+JArtQjXkYlkBzGRXvBv6bhWnb2+AqkqKiuDnJZ4nl58
 fAh7f/gCDmSxwCxfZplMs8usSiR+woc9YPXckRXHeCChAbwZNq71R/tgYoKO9kh8z/mj
 ToWCCA/b/hXmGC3o/sgPurCqt6PgIhZZF/ybspPpEW+BQsKzQj/D+p9MbqCwKPBLLrcP
 2AMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793203305; x=1793808105;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wjCdF3kIreRG1W43rh8vEHDnzDQ1Vz0JS/rnUD/K8v0=;
 b=ZqlpSpcqLfIncTFn8nCisDXdHPRN6yWDVMFjYCeW4ehwD3746aBMvw5EyqzXbBVkri
 tjDEkXFkRTWWHxACjXGs31qPPZO6FX758zYjhjGI2YWfMtee6qbWWAkk4+x7iix1q4hS
 r2vVWIzg2HnPGTV+UnaNqeGnGV/rBHsaQ1SwVrAAukQLMVgaFhUgRrZmEk0f1DwyxQGt
 ydkagFpdnFZOi+E5G97dFJeZE5gj/jXg95t7rqRHiKSfoOL3uVuRlPs6VqTLy7GpwPh2
 wz0ZGRn9NfH/g2oIt/INanfM5vtDWAmh4Pq6EWHfphpxW3+feWhFW0o1h6PYTl1HBrzh
 KMgA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzMRZz0KmL90BxIgPd65vzgtbMzAb69CRvHwFF4nZTcZhWgG1qL7+UVMMPgBE07/qyqnIje8Xc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK5IuYuY6NgoGB5T66447QH7D01JzzmlllYA6+Xbt23xklvEhH8
 U8ei9dNHA9BGfrU3PyEgEd5w5+7H/0t/ARWxMny2OEgEwLOhXEb+1tJQaWbLUh/SXiI=
X-Gm-Gg: AYBFou0PgXlgna7yx9LZIjr1x+iDAmNP6wQTWZWXyZQHvyVOlOLjx90NpAzobjDogCU
 bobQC1BvwmZgt6g46Ax+P5sAo0ZQcsq9IeLyphV/X9rFtDdV8iJMMqjFrhlZ+fVJIvA/Dr6RAXD
 k4pTKpYMI54POoYlR9Ew+OYFpgx/xP6vq7YazHzOopB+mXvews8ttfnyJ3w+xd28gFTFw64hbbr
 ofxr4KA2VcespHG45SV4mf1ft8vlhpuktpGQy+4rxSEILcNtblZ0SmQiW+0vlzQTfrRyDH7ExI3
 mwXK0yx7/nqCuhKg0hlXPxQeudeIRTpshDidD/NfAsTng2Aqxsq4AXUdDsqRIaRbyrycs5XmO+s
 pp7Nh06WDZVs/GOWduGLcztgVK4LxBjD7462ofu0+v7ziJkFnlZOkQ85QjX6R/IrNQ3whhWIj0u
 V0N9HqTkxS/YAUiPSFKYeqdne4KDzWxPGEZX3BEiKfC9qGfskS/lkHuKZUNCUDPkIkR2ApMnR9G
 sDUyVYQrG8rJJi6e/GaLMua5BtHL+ZvceX7PihRZMxT5yMqB5zOuwVAwvoduGZOR2APx5I6wM/v
 zocUSh1R8OpD2lQHZePnjE1R0Mmdf1xWvX/MdYtqJFf30L76wIvvSr5Eq6vA1Mdbq2iuRMY=
X-Received: by 2002:a05:600c:1f93:b0:4a1:6517:ccf1 with SMTP id
 5b1f17b1804b1-4a9663997dfmr56417315e9.9.1793203305055; 
 Wed, 28 Oct 2026 09:01:45 -0700 (PDT)
Received: from lion.localdomain (p5b29ef1e.dip0.t-ipconnect.de. [91.41.239.30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80286fc6sm1686155e9.15.2026.10.28.09.01.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 09:01:44 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.u-boot-project.org, 
 Varadarajan Narayanan via U-Boot <u-boot@lists.u-boot-project.org>
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Johan Jonker <jbx6244@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Mateus Lima Alves <mateuslima.ti@gmail.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Anshul Dalal <anshuld@ti.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
In-Reply-To: <20260721-minicore-v3-1-172e5f28138b@oss.qualcomm.com>
References: <20260721-minicore-v3-1-172e5f28138b@oss.qualcomm.com>
Subject: Re: [PATCH v3] misc: qcom_geni: Add minicore support
Message-Id: <179320330331.1454330.1482683382302256486.b4-ty@b4>
Date: Wed, 28 Oct 2026 17:01:43 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Tue, 21 Jul 2026 11:23:34 +0530, Varadarajan Narayanan via U-Boot wrote:
> The qcom_geni driver reads an ELF from storage and configures a set of
> registers and programs the firmware to the GENI Serial Engine (GENI-SE)
> wrapper device for the expected functionality.
> 
> Unlike the GENI-SE wrapper found in MSM SoCs, the IPQ5210's GENI-SE
> wrapper is pre-configured for one of the functions defined in 'enum
> geni_se_protocol_type'. Hence, the firmware download is not needed.
> Only the register configuration part is needed.
> 
> [...]

Applied, thanks!

[1/1] misc: qcom_geni: Add minicore support
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/b0c875658e9a

Best regards,
-- 
// Casey (she/they)


