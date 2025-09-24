Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD6D0CAC5AE
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 18:16:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 414F5835D8;
	Wed, 24 Sep 2025 20:16:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YKnLyzf0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D544F835D8; Wed, 24 Sep 2025 20:16:37 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BECFD80819
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 20:16:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-8a936b682b3so10192639f.3
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 11:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758737794; x=1759342594; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KEi4jPxHQLpZGLJMVu9Hs7uRr7xLAEYsPjlalTV5QS8=;
 b=YKnLyzf0TNCprok2pOd25M6BaDMECjPNab61P+Rs59auxhwfS72imtHuD7KBEe0zwB
 eDK+7luG8tezu330FFy4McwRFTmGyfE4ozhmnACU6JHm37mfVp1HWpeEyateC7fCS8TM
 I5hs9ivUQ1zLvCCsz/rdMWsICXBnZroWzLd+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758737794; x=1759342594;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KEi4jPxHQLpZGLJMVu9Hs7uRr7xLAEYsPjlalTV5QS8=;
 b=Dw8qCogEKpMhtqiErhbIR6zNHb7wS20RTIaLejJXPhM2fzlcXbEidaumKI48XFikdE
 tUKL3uprgMM7ysijtigRA+f1Fb/glXJrlVVqi3/WpBdHK6BDpRqJna6Q6YHeHvcxWQFt
 rYuRVwldqfYE+LVrmk8Xj9LB9VDRJgzr8OP5dI3QyDNBzPR/l7k64xS/FWzEgxj2K2yv
 NzdzbhR2+MdBod1yZmrq3nUFfOLWRpUZTlFLKlrVEXEo0GPctPkrZ1Q8QlTwzuhN0GF0
 vxDN051FrkV50sR6IQdCbnhnJ/H9ZLvw81lIv0uCy1y4AriNU68o0ogaEDT/4j2oAImf
 fbHA==
X-Gm-Message-State: AOJu0YwoX82EubwPcKoSFt3MXN/i47sq3q3xRKO0vFrLFaRna79G5Fzf
 ZkBBpSQEJ4kN4xRZUzSzKjk6rMsQh+ZMl/RuyBj6YFh8TlmnlzymmHkOSOWM/r6aiFU=
X-Gm-Gg: ASbGnctWVpIeLqlnkP2DNNAHDBzcsGJw8sOmVuB4cPvlvtiOmWPf72cFoBC80NpcGpM
 3UykXyKbmDPdz+Tq9yk+yIC9GHMGBQfsfbXpKGuv9c/b2KKGwHYHfOVTFyhEbNE4SdANPQOO1Wn
 D7drNVat7bF0ILwot3hjoLbNQRYKwWIgvIpElqF1IcaZfknNEAsN2hCGnAX6l9fU7lNI/sW48Pz
 MC4uJcxMm1X7gPPS6J9+uuhKSDHJTK+i7wAK4pozs1RKm/+uUpBaHTDR+SFWg7Sn93EMeUFDj3E
 USwiECbPvjP6qZcaLBHsQLRW/iEtP6djCxnaK/PsOakt0amQ68TBeCetnvB6OAap5MrIxjQujDN
 RQZ7LWCCkkcXkACiZpMvI0raK+0ZgzNYxf0Lh84WdWR7vE+DJ/oJHsf8=
X-Google-Smtp-Source: AGHT+IHUawS+KJdcjWPbbHAWBDpgKdv0O7InntmcCwyhpUezQtvAiyexFb9y25E2E7jpetOoGomiWw==
X-Received: by 2002:a05:6e02:1a28:b0:424:d16:e49f with SMTP id
 e9e14a558f8ab-4259566110dmr9288845ab.29.1758737794458; 
 Wed, 24 Sep 2025 11:16:34 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-4244a493b40sm84122645ab.12.2025.09.24.11.16.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 11:16:33 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Safae Ouajih <souajih@baylibre.com>, 
 Guillaume Ranquet <ranquet.guillaume@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250911-android_header_fix-v1-1-af036221d3f0@gmail.com>
References: <20250911-android_header_fix-v1-1-af036221d3f0@gmail.com>
Subject: Re: [PATCH] android: boot: fix wrong end of header in v3/v4
 parsing
Message-Id: <175873779345.361751.3963116130989722756.b4-ty@konsulko.com>
Date: Wed, 24 Sep 2025 12:16:33 -0600
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

On Thu, 11 Sep 2025 15:50:26 +0200, Guillaume Ranquet wrote:

> The android boot header is page aligned but the current code made the
> assumption that the header was always smaller than the current header
> format.
> 
> When the page_size is defined as 2048, as this is the case with the
> cuttlefish target, the current code sets the end of the header in the
> middle of it as the v3 and v4 headers are respectively 2112 and 2128
> bytes long.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] android: boot: fix wrong end of header in v3/v4 parsing
      commit: 5289b6e5540e571afd81482305e5623e9124ea66
-- 
Tom


