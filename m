Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C76CCF6D2C
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 14:52:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DCF788D27;
	Wed,  2 Oct 2024 16:52:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OjEJeL12";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE2A0890FE; Wed,  2 Oct 2024 16:52:45 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87E9688BBE
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 16:52:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5398d171fa2so4620164e87.0
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 07:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727880762; x=1728485562; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pJPFppISZUDkfxvLdOUb23skREMvdpwL9bE0dcZ+iVs=;
 b=OjEJeL12wmxnMeps+wnHCqwYax+k4cTV6+wnblhkMjSzVUCQdj1IJyPdrhdpGq1T75
 gnzjrAxibcvdisb4Ii3r/tyESmgoFhrrPsMhqGnsZJeHXnlgLHHNOnQudSxZTo/Hnm9F
 eQozqEl3rwVyHAA60qBiiSH15a9oLwU7YepgGKi7KVhJS5d3Krccas+HBSHjG45TFtfy
 iLQ1Ik5z+ioKoRZsccxyvQJH5yS4yX15VfrvxiTR2DDMUTiAp4vZWBJvDplq6PFJbP2D
 dCCcntqOWfk3qX/Dc2xg5zDyvbxZcA3QgD1KoJ6cNSi8KSVzAU62JZo4gVZfH+uQ977W
 M6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727880762; x=1728485562;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pJPFppISZUDkfxvLdOUb23skREMvdpwL9bE0dcZ+iVs=;
 b=dtUCZTIAB9nELUCs1f5ILU6oSwPs+co/g79mg9r4AV2wVvX8UUBvFkvLbXVWP3cvlg
 MbyKz6jNAnqB88EhZqyEyrwhQjhlrwkhkUYFwtvwuQkLNIkjIYSScEirMfrlcLmLESkW
 2TBTKaqOyM/DS2AEoTCZg4jujRQq08r4+7JfHA4aw2EETzpQkXBZk7wvl8Aj5Zknfa79
 sH/1ClpmpKLObrx5WhhmD0KtkMgIr0zgPBEKHa4v5GAGhDF7BvhZsb/rW9aKz9BDw4zg
 TsceodW3gqYZpsqa6nZoasVeDrPL4GrMZLSzjGjnB7ZlWykfB5EELMHOfqyObvqcrrVp
 o4Yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvG+SdatoRZwRwiOY/+8FMb0AXMrny6fj+R0UlySx8xSLsN7fjdP3DH3mGn0/czHRXXcfS8os=@lists.denx.de
X-Gm-Message-State: AOJu0YxkwyrxelUtrTQ0oILb5Nd6SvNAv1fvyzWzmwzOyp2KcGVHmBA2
 XqmRhBmukASmyHmUyqmnpwDQalfkcjhfNatmw/qtobjf5UsNdZ+NKYS8U/s5/f7m2UEtqINUXF/
 E
X-Google-Smtp-Source: AGHT+IFA7IPNeIo/RFm5bvxRDFAYzRJ7XBm4AMV/koVSDeCl/Iq6McLR9mmVgdsC8pQB7z7UprNlww==
X-Received: by 2002:a05:6512:1192:b0:52e:91ff:4709 with SMTP id
 2adb3069b0e04-539a06656c3mr1969060e87.21.1727880758215; 
 Wed, 02 Oct 2024 07:52:38 -0700 (PDT)
Received: from [192.168.195.50] ([95.90.247.28])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93c297be12sm889785666b.179.2024.10.02.07.52.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 07:52:37 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20240831-qcom-phones-v1-0-08614edd8e35@linaro.org>
References: <20240831-qcom-phones-v1-0-08614edd8e35@linaro.org>
Subject: Re: [PATCH 0/4] Qualcomm smartphone support
Message-Id: <172788075725.935801.3270533991443988203.b4-ty@linaro.org>
Date: Wed, 02 Oct 2024 16:52:37 +0200
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


On Sat, 31 Aug 2024 17:48:50 +0100, Caleb Connolly wrote:
> Improve support for running U-Boot on Qualcomm smartphones, with:
> 
> * A boot menu which can be entered by holding power during boot
> * Hang on panic (so errors can be read on the display)
> * Serial gadget which can be enabled by holding volume down or via
>   boot menu
> 
> [...]

Applied, thanks!

[1/4] board/qualcomm: introduce phone config
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/bcb278fbc218
[2/4] cli_hush: run bootmenu on retry
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/963c141c3195
[3/4] bootretry: check for bootretry variable changes
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/c2147f6b396f
[4/4] doc: board/qualcomm: describe phone support and bringup
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/12901f5bff70

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

