Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9B7CCF9EA
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 23:57:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4FA982E34;
	Wed, 29 Oct 2025 00:57:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q6855RlD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FDC183710; Wed, 29 Oct 2025 00:57:34 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D9DF836C8
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 00:57:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7c532d70cfaso2746771a34.1
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 16:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761695851; x=1762300651; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wIe10d2zsZExAmufMfSPKbjGxHhYbRWnnV5PYfiEIXg=;
 b=Q6855RlDefTvXH5dT0QUX27VwXqHe/NfpmF32/dm/e9gXNrvPRpYpkequmMbrAqYg/
 BTPegTdAFEKT0thJLC+LXNcLw8KSFhAAcd60mI7Q0/UIhisYZo+eaAkFkRtO5bNS3hcw
 3dHvOR33lWsyJnlk0M4/t3uljybLMek5qtp+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761695851; x=1762300651;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wIe10d2zsZExAmufMfSPKbjGxHhYbRWnnV5PYfiEIXg=;
 b=JCn8wXSXmIY+6DhLIMBWKnZxwEh+qSWQpOaiF/SvmvCnVceYs+9Et4FUbW94bKDVc1
 m2ZFaGPvFMpd9XOhd0KDQbx5ZmLfuB4F5OnVg3qc8+Cx12iq9IQ5Tdhu9J2X3MyubHRr
 gHIuFylT9EXuNdJPIB/5IxCfG2LHn8lFPy4tMZSBXkNKwVAOivqE4JHE79KCZg+OtCLV
 0AeYp1W+WD8n0kiYB2MqTqCZm5xHQC4UP/g0qLtxDaczQ+1mfTKF6RUuFMEM66lsEO6T
 hxGbvpIca7poHV5kIfSk4na9yK1ie0eMTbG0rd7a6oGBn4+fBB+GGG9mti8JqXGnLFuF
 xe+w==
X-Gm-Message-State: AOJu0YzFBCBy+VTSmYWpGnsZKSv74qEkdDBYFoIudCLcMOce6ktTxDyl
 CG0VbL0fR90GYvYrGJrlPpKywkVINzjEUK4iIxDRcq66yFW/fvDyYVjibZwPOkLwETbin8VVLat
 bzLTT+lSt0w==
X-Gm-Gg: ASbGncspV3MsKCzVtMutJmLi5soevF2m/GYZ18I/ZNLcAq0V49F58KtyKQarkWP7t3/
 sYi6/rE1iH7s5gP6/9oIxsaWxLlaxH0rBYYCCCf7n9+BMm+4l1mOUaERFFfNiBFpCQZDiIrplhd
 KmlBxBkM/jplR2j7if/fVWD0zzAc1ecz/8AQOOnom4tfwh2E4rQGisdRmyq0DRhPQtHWWibia80
 ypJxBvwRJ3jywxPJTVFi1HtV83FZKsvXT8YZadazxrlIrp5+Y8xUYPS/hQdRR2n9uZSjv2+FjQ5
 N9Khb6byQaQWwiVARqDbJS4lknKfOrVi0g1WQkgnowwYhQVeOT0vaGzzSwj3pcTFGXl8nsMgCug
 hgOLFeSAOXBi/X+cbv3HY7LO3BQV/lVkUsN1uhcHoZRhNTOy0nvoe1zMWb9AVGnH78gkJl0esSN
 RwMKNEMlGNQzsm0UDK353ltq8RP/EH++s5T/NqTQ==
X-Google-Smtp-Source: AGHT+IFAN4J4MrkUQ1ZkS69++pNmHxaVoitlgPhCIjKr9+QJvCSWrqoODli7Ltr6Azt/8QIyeafGnA==
X-Received: by 2002:a05:6830:314e:b0:741:a5f0:bc82 with SMTP id
 46e09a7af769-7c68314b156mr657583a34.17.1761695850958; 
 Tue, 28 Oct 2025 16:57:30 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c5302068a6sm3646234a34.25.2025.10.28.16.57.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 16:57:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250702010535.19250-1-trini@konsulko.com>
References: <20250702010535.19250-1-trini@konsulko.com>
Subject: Re: (subset) [PATCH 1/3] clk: Add missing <dm/device.h> to
 include/clk.h
Message-Id: <176169585001.2287207.7827395101516621215.b4-ty@konsulko.com>
Date: Tue, 28 Oct 2025 17:57:30 -0600
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

On Tue, 01 Jul 2025 19:05:33 -0600, Tom Rini wrote:

> In this header we make direct references to some dm/device.h functions
> while not including the header directly. Add the missing include.
> 
> 

Applied to u-boot/master, thanks!

[1/3] clk: Add missing <dm/device.h> to include/clk.h
      commit: e15dd01422efda76dcb5346b37e9781af5fcb67c
-- 
Tom


