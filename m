Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C377C54E71
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 19:26:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B66587DE6;
	Fri, 22 Mar 2024 20:26:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="swEmqsoo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62F0E88178; Fri, 22 Mar 2024 20:26:12 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE8A687DE6
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 20:26:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-789dbd9a6f1so185031485a.1
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 12:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1711135568; x=1711740368; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h27+0gQQp4X3S4G/iCkXg1lqrryXwnvvUrqoS3VgL+k=;
 b=swEmqsoo7dl/jkVfP2VmHWM+IOqoE1pxPnq/T0Ac8NQIDMGHWQ3yqIhytrGUWVhf28
 5PIXyo9WsGQQQJp3ZQovtRp08qmB5kccHavJgtoX/YoBTVGzJWvn7kDZ27RT8jmY6fsP
 Jpv0tZxNV/Fqr9B+/HACvGw2njjdjNSV/x2Nw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711135568; x=1711740368;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h27+0gQQp4X3S4G/iCkXg1lqrryXwnvvUrqoS3VgL+k=;
 b=lwqOFNjfhKwXwDYkE7MsAcoiOrFubBsqZawL+BsGqaYJnhkAyaIQDtv1lrZ4D5f3uh
 u4hyEs7/5J7OUwlCzhQwQjTsyqSRnDf6PWgsQNDb0Z/gDTYzSAdDAzY4GApZ+CD4x2Jt
 WIv5O6+eoMV+5resmzPiw9LVRlkEeBDyk8POmi3PVXKutZswrBli3/SoMS6OwDTe3NVz
 YHlSF5AznoyGCvTJvvK36Pkfw/YPsMpqmaxxtoS3yhv+BS0CONooaI1yeWmJTTIA5kWe
 wgkL689soDY7P2Cw8tC8vyZCfABfKyPbhgrV3aSLgK1UX/9a4YwfrWtkRZxKdgSmlBZ/
 66FA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9JW2mXCI6qBItgWyr3T/MWDLR3go3OVRfsQwomykIdgDfbeloNWsOTmgfmcEJ1HQV7t1pOyRTf0AbIrY8iNeYDW7UCw==
X-Gm-Message-State: AOJu0Ywb4qkrsXSaDMHVnEgz31eKClCMHe2hV+wsi9xdV4Xs+29VZ3Go
 QvrBla15NZfm6ZN1ggYLQSA4qww7+mIRxC6D5CSjgxeDxfi94y2ZPjiuhM1tu7o=
X-Google-Smtp-Source: AGHT+IEVWJinHbffP08X3g+P5aMSd0a1Ow11pgVCfKM43YjPc4n2x1dFot81ITXo8THjW9Nc6p23gA==
X-Received: by 2002:a05:6214:3018:b0:696:2489:9dc9 with SMTP id
 ke24-20020a056214301800b0069624899dc9mr407692qvb.37.1711135568709; 
 Fri, 22 Mar 2024 12:26:08 -0700 (PDT)
Received: from [127.0.1.1] (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 jo10-20020a056214500a00b0069102f97e08sm1362309qvb.97.2024.03.22.12.26.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 12:26:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Joao Paulo Goncalves <jpaulo.silvagoncalves@gmail.com>
Cc: Joao Paulo Goncalves <joao.goncalves@toradex.com>, u-boot@lists.denx.de
In-Reply-To: <20240319140427.73721-1-jpaulo.silvagoncalves@gmail.com>
References: <20240319140427.73721-1-jpaulo.silvagoncalves@gmail.com>
Subject: Re: [PATCH] arm: dts: k3-am625-verdin-r5: Change CPU frequency to
 800MHz
Message-Id: <171113556788.2191577.2349016593069254080.b4-ty@konsulko.com>
Date: Fri, 22 Mar 2024 15:26:07 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Tue, 19 Mar 2024 11:04:27 -0300, Joao Paulo Goncalves wrote:

> The lowest speed grade of Toradex AM62 SoMs is K speed, resulting in a
> max value of 800MHz for the CPU operating frequency. A solution with
> runtime selection of the CPU frequency is already planned to avoid these
> kinds of problems in the future.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


