Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B69ACA0EE4
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 18:49:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0523D83A5C;
	Thu, 14 Aug 2025 20:48:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ws1nDNRH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80E1883A45; Thu, 14 Aug 2025 20:48:38 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6325183A43
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 20:48:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-88432e1af6dso76495339f.2
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 11:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755197315; x=1755802115; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Kf4/srYL155cMf+w9gps1ZTlCDBgYYhTsvN8nb9Rn3o=;
 b=Ws1nDNRHQBmXkUH7Ufh8vJ/JEmn6dxE9ThogvkHRU2Gi4FHUlqyY4pxSDniy468vOK
 6M3tFpcrRofPxI+1TOHn6jh5grMiLTKvZNdYZlitzmsiB2yxMAu1WbWwjdQ8rxQo9+pk
 4KEh2Pw8Rsq8OlcRKYKQXOLaTqS91hUDYdnZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755197315; x=1755802115;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kf4/srYL155cMf+w9gps1ZTlCDBgYYhTsvN8nb9Rn3o=;
 b=YuOyuhRgPPR2BBiNofa40TZAo0U2JmCCHGmZBhLTgcxhM/wd+Es8dFmIexIVjBistQ
 WjXL8AW91VQS9C0rUER/FQa681Px54HG8WBNjEYjo3Kdh0i4Y3QTmdp2BjFZ6rQPORXz
 wgzrWqxZAUHOHjo7kcOATZ9abpOqYyN0EWwK/mBvH4KnSPrG0pPs/5VOLLiHZ730WruL
 IbSTWL7gcI908wPPcXRHTrK9BlCI5MXwdtt/7I57dthtPJ+M5UFj7uLqnLWdMqtc7wsO
 hV+PC1VAVJD377Vb51UbqzB3VZyUH6aWRV4khb+OXKIZmTBPK/PZy4BlLikQFHsn+W13
 dsGw==
X-Gm-Message-State: AOJu0YyZjSw5a78YGTrbOWIoTIz+HI2YPq85pME42CloZzuG2+kDx0rV
 +R+0Um2M4Ybj1IiwVsHI41rUmuy0n4gFXxnIGePEOXLUE5EBSqLUyR+3gp4D1Ea8/zDaXo2s7kh
 tjAjeU94=
X-Gm-Gg: ASbGncu6xCXbzkFqf+N2jkruvjt+4xZZ9tHCMD/fAXHSGdg2ZKA79KKB1xLv318J6JA
 e6NBTEVJBRM938deQJm46v5gwXIhIMUaygoSFZePCc2YRopx70zbOnzT+UTt5/cbMfnKVPY4Rt5
 DlP2AM8ManmBqbYCpm4Qh0OyR3KSiEHOPYat6ywqGvPMNohTuxxoOtaAs+1xwRrEgRDMn5wVunW
 kID62SuCinR3nEKEtzidukuHEkgy7TnyHI/OD5f/UYX88CcBDzcpHzX9PK8eGRb+acLoRIC1l23
 uokYpWarvom2EdsFssm0an2lg3xUEumWUF/e/35DhyiV4vsIQfRcy+QgR+wqdZi+OmPc0IBDYf7
 uyoVZdkiNKgN87p9x9xOJ+je9gXi3DCvTI7C3+JjUhZpx5L+XXwglZVE=
X-Google-Smtp-Source: AGHT+IE+Q7YlbPO3ucIVDN00mQy2vzyH/wztgkWcfNQMdjJ/uhQoRdrVRaQY2ANEXMS8aRMER5wgtg==
X-Received: by 2002:a05:6e02:1fea:b0:3e3:d197:b567 with SMTP id
 e9e14a558f8ab-3e57083ebd6mr79806175ab.9.1755197315185; 
 Thu, 14 Aug 2025 11:48:35 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50b3d6ff137sm1219762173.41.2025.08.14.11.48.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 11:48:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250804215354.1412604-1-trini@konsulko.com>
References: <20250804215354.1412604-1-trini@konsulko.com>
Subject: Re: [PATCH 1/2] pwm: Tighten some pwm driver dependencies
Message-Id: <175519731441.3600102.153709041593096388.b4-ty@konsulko.com>
Date: Thu, 14 Aug 2025 12:48:34 -0600
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

On Mon, 04 Aug 2025 15:53:53 -0600, Tom Rini wrote:

> A few pwm drivers cannot build without access to some platform
> specific header files. Express those requirements in Kconfig as well.
> 
> 

Applied to u-boot/next, thanks!

[1/2] pwm: Tighten some pwm driver dependencies
      commit: 678be99d563199551ed57fd771471eb1d2680e6e
[2/2] pwm: pwm-aspeed: Add missing <linux/log2.h> to pwm-aspeed.c
      commit: 00ad9ed4a775a6908a8654935f61df38e59178df
-- 
Tom


