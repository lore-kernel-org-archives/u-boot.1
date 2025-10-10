Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942FBCCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 19:24:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1435283FA7;
	Fri, 10 Oct 2025 21:23:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="I2FWbokk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 087588425A; Fri, 10 Oct 2025 21:23:27 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11E0E8426E
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 21:23:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-35ba7c71bfdso1255877fac.3
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 12:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760124204; x=1760729004; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nkd3VkSjxnAtVw1M7B4RN8rFRcSWzJG3wlMg/I6figM=;
 b=I2FWbokkja9DY+5X0dkSMxGATBoiMfktksc/It46ud6y6EbCm+yXnUglValZwT10eQ
 +qPSOHM4Zkg/k1qU379H6XsYiC9LInU2EJt600Y9tl6OOGy1sUdwphMc9p8yIbMij40i
 IlA7bDyPDrVaH0TcSq/gEEMLOgIfzcLqeaQ1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760124204; x=1760729004;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nkd3VkSjxnAtVw1M7B4RN8rFRcSWzJG3wlMg/I6figM=;
 b=m+j2snWtjuTnOwgjuzhQMa4aBPNVSJFBRETRHpGB3jgGW4Rsvzr1Y2ry6WUNw7anRZ
 aba1233Fu4GKKp6kyFJDJdc55SfMHrl1FKgX4l5XrzSjNch7DAv2qznLFbbTTPQoSbQn
 rnTyJ1QuAQyiQs2jChbfoS4hIh6IxPfOvhUTVv8LmJXlFw5Wh15KBTS/oofmaPsIWGTr
 qGyd6m2N0pToJhhAxefmA98fXE8G/xlzextoq95Eht4M8hwf0Qvy3QyN+SnuGECWchBD
 l6ossFtpyJDD4lqPjmHDfckGN7Y0UZGNC3yeRqnNqaJmKmcGXro3VFjIfYb23YWi5ffz
 tfbg==
X-Gm-Message-State: AOJu0YwuXIOaFOfU7nq8wnfDV8R53/gZ7en0X1VdtO8nO+nbEy7Rt5oq
 ev22DCabx8IPCC85G4KoRSAobHRhelfadyK1gG+ESufLdWNpqUwVSDajuOnDwnVN05P+vzC+brg
 vPZCEi2o=
X-Gm-Gg: ASbGnctU8bzqM7qkdcC9dDQWHtqUyYkUMtAldKy4OdPBDMWlPrVVFNil7Jb0webTsT/
 zsY4VpWo+amyNbfIpYcgAr0DDB9Xcpfsz9PD/Mv1HXZg1Dqgu1cnlCfmzk1Nn+RnjXBfacB+shW
 9k6J2WXg/lgIt8XYmWpYq/InSOHzUCpRhJQJ4+KvsfPBFqerBDeIeR6E11feaU99m4aS09zjeQs
 6dkpT5lwrxZoTlbQYhLf5XUsMm8r7geWkxSgJWOsV3twzr3sKJPFJdq9cv5LNBk/5BmHAdtjvmy
 M7zhu6P1KHvSsDNDr5XYk+KixaVrMEe0NmQh1v6SThVLSN08wBbaM74gChywgwy7QaqgOks8jjq
 WTJX5/GyHayO2EeQWraka59cQ5dW0TW94Z4xL4RzgPbEZbTFcJQRFDq/aGO+ALBj9mAdrcIWawU
 ZHyVQ=
X-Google-Smtp-Source: AGHT+IHYjEpjxZxCVW9/TiqAvMKplok6pWc4wq/Yr2XnnlgPREdcKf/cfNY3R8Y+aDHjkJGosF7JSg==
X-Received: by 2002:a05:6870:f618:b0:377:77cb:e091 with SMTP id
 586e51a60fabf-3c0f66ec625mr6030158fac.14.1760124203706; 
 Fri, 10 Oct 2025 12:23:23 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c8c8f581ecsm1155832fac.25.2025.10.10.12.23.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 12:23:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20251001203055.2828514-1-trini@konsulko.com>
References: <20251001203055.2828514-1-trini@konsulko.com>
Subject: Re: [PATCH] spl: spl_sata: Add __maybe_unused decorator
Message-Id: <176012420280.1180358.8081180111830574764.b4-ty@konsulko.com>
Date: Fri, 10 Oct 2025 13:23:22 -0600
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

On Wed, 01 Oct 2025 14:30:55 -0600, Tom Rini wrote:

> It is possible that we will not have enabled the options to call
> spl_sata_load_image_raw so use the __maybe_unused decorator to silence
> the compiler warning.
> 
> 

Applied to u-boot/master, thanks!

[1/1] spl: spl_sata: Add __maybe_unused decorator
      commit: a574f8a3e504bed1baaef00c6ba1ac395e43be43
-- 
Tom


