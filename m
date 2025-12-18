Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF1FD6E2DC
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 19:52:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 915F98042F;
	Thu, 18 Dec 2025 20:52:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Lul07Uvp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D598800AB; Thu, 18 Dec 2025 20:52:04 +0100 (CET)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B181D83106
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 20:51:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-65b6b69baf8so297848eaf.3
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 11:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766087515; x=1766692315; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YP22DqiqQru5hhRlVRNBLWZ/b/Fj4EWzMbhftq2YyK8=;
 b=Lul07UvpnfDyKvxRypJ/DEzcz6FapSd8UnXjq3hHhZO8witghsr0s/NF4W/kjPzbQ0
 2DuAViI+TR1QbLnC0s8JVKS+AdzwzTZhwXn3ainO1uHmG8/mV3sZ8FUIRpXPpoG+LyNu
 uptP9APQ6L4YciK4/o2xW+FG0F5L0aIGVFnjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766087515; x=1766692315;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YP22DqiqQru5hhRlVRNBLWZ/b/Fj4EWzMbhftq2YyK8=;
 b=PkTaaC+svcjhL6kZ8GZnipAuo85MdX6c318S8CBUDUzsDduZYYz2DHQ0TY4bPSqsRQ
 SAopHRoig4rnWsBWM25qOpuQFkFiOnRPDw/wRkJzdLrekmd+1V8ZCtvJ1gdssiFEPUVW
 MqdK7uRZlGMoFC3HvsoFY+eowEPsFGrp2U3/WjK1MRoN2xnP0OTX620lyhO3m8pVEgtb
 +BlpkiEa3mDopig9LaCxF+NDDCTo8QOPrpkaaEFKj1tdU505q/pYCMxN2/FT51s5o2bn
 tuIAaZLHXvEwUbkCXUMPmyQT2Gb/IzIT1hV9NYvtvs3aHAbpFTJMH1FLjaFFBkyBxym1
 WM5w==
X-Gm-Message-State: AOJu0YwpmEkOZHdJCVo9A5UuBneiqTxgS7iZK18KhKNt6D3TsUIC/3JW
 NGbTlHenlQZOYszgVKV2UBFaSSkbkGXh3sZlVh8TfHhCwBhZH6+04F5Rmixy8VpB6wZ15lRRIPv
 8lLtDFPk=
X-Gm-Gg: AY/fxX7evoRr+vy5W8rmkTCbfQL4D0SgsvxppEuDtuH0qvhqGjP/EW5wxMJAwVW43Q6
 l2WG0nhDIf0bF+aG9DOYgbitj20Z6MiCvFiDaorVD/jyXorC7fOKIFz1FwgCmwFEWDHS/ABoceJ
 lRjj/5WnAhTZkAR6QJkSAne9zkZcK2qQ9iKsc5k9w29nuG3VJS8oeZrz/mf758MrmF4WQlo1CKg
 waGJAvDvxF6T4jiWl54tLJRq6p3WFVBj7Q+5YpIjFPqUHi0ZzceeTs6ShLaUH2jf5CaC8kBF/K0
 ubBW6ke0kHQSgzynyQXz1RFxZV2nf1ZeNpzXsDCg6yz22lcXdmQFr2LQw3oyckL5ptTNtnWXAlz
 ethaTfN9sPAw4ybar3DQ+Zmaj5O75tTsOTt6JPJm5qX9rUY6WusLmpd1zH/Gq3ITZXdedy9RQj1
 5XswxBJSHQ29GY5HPQ89UJDErP8/dCALvINfZqF8ZPhKeSSIkZ
X-Google-Smtp-Source: AGHT+IH34eZup2lso0ldmGV/AtgESwbcylWZ9G/QnWv/EctnceADGCqBgGr1184IpCZI6f9bbb6V/g==
X-Received: by 2002:a05:6820:1501:b0:659:9a49:8e4c with SMTP id
 006d021491bc7-65d0e9bad4emr283694eaf.28.1766087515413; 
 Thu, 18 Dec 2025 11:51:55 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65d0f710763sm181837eaf.16.2025.12.18.11.51.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 11:51:55 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
In-Reply-To: <8fd28ccb-9122-40ad-a434-b18db0f26e1e@linaro.org>
References: <8fd28ccb-9122-40ad-a434-b18db0f26e1e@linaro.org>
Subject: Re: Please pull net-20251218
Message-Id: <176608751478.3734627.10838476577269157275.b4-ty@konsulko.com>
Date: Thu, 18 Dec 2025 13:51:54 -0600
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

On Thu, 18 Dec 2025 17:22:54 +0100, Jerome Forissier wrote:

> The following changes since commit 47b50fb1125c539d80ed3e7f739c02c6486e1b52:
> 
>   cmd: part: Fix part argument description for `part number` (2025-12-16 11:14:53 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-net.git/ tags/net-20251218
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


