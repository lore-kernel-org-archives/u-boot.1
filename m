Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C8BBC3DA7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:34:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA5BF88C07;
	Thu, 15 Aug 2024 22:33:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Gscm/SGT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE2B888C31; Thu, 15 Aug 2024 22:33:19 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B12C088BBC
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:33:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5d5eec95a74so811718eaf.1
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723753988; x=1724358788; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jj3g+FboZ3ybXq/ibxn+QqILLBpCubNkJZce1cA1ccY=;
 b=Gscm/SGT13cczJReYQ3COA29tMgK39Y1t/zwVWUhvFNLABuOBzGei8mp5gveePhcew
 O5AxUAazUtXWlPd3+/GOcZtXm05+zD2JfCwFYjO6IzUpqhhbwLf4B+onjPC4qKCidUFC
 Lbee3aVaeANjAH2lB+x828WfhJJN4elOx4vn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753988; x=1724358788;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jj3g+FboZ3ybXq/ibxn+QqILLBpCubNkJZce1cA1ccY=;
 b=W5qD+T4cqhyDv9+3zCVszhl74XVjfNnANUaEPMGReZf3jDix+Kw2o8cJOVIeACkbhB
 MXCR1lDVpVsduBLBbrXV68hmZ6rzHP5Erus1cakPBHw2sR7I+/Y+taHvYP5OETwSjKSu
 dtIpQY5xb6KAuKNuVQdg9ZdXae7Qp9DpKd+ZtwNewnoxTdajqTcRnFXHupF7YjawLrNp
 vht1Tz34FhgtQMEcquiNH6jzMbbxKAxBDCPmv5vTBXsYGUuK8iNO58ueRjJLvOeloTeu
 J0MzzLDbwdkJiRLtg89zwDBNwshROIyNMAjAktOecwYXQ4/kJFEjNgJSfHaL/P1lGQ5A
 mktQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdGfw5/dqIMojtJVL7ohX3gyeTHhIlSBRdNKo6+CQiEKbriyKPHPRgyLQewnRFkwbgLgp+4nk=@lists.denx.de
X-Gm-Message-State: AOJu0YzHBrzZVZAlNCLx/yaR6qSsbH7cfiEqrsmbAAvfrGdchptDqIHn
 DWkbZNBUVfSTwYm+Y1RTTv8AaPgk2GuCopgvUA7OtYE8OBm5DqT6M12OmNbl1R+dE/1dQjdbwwx
 0fhg=
X-Google-Smtp-Source: AGHT+IF97ZMk8cB/7wzToTCa2LiUOmTsPgsuF2MQwaSf2OG9WqvximSGromSJ4X/Zvg36HDKSU9Gvg==
X-Received: by 2002:a05:6820:6187:b0:5da:9b98:e208 with SMTP id
 006d021491bc7-5da9b98e4b2mr33851eaf.5.1723753988701; 
 Thu, 15 Aug 2024 13:33:08 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5da8cdd9dedsm402006eaf.21.2024.08.15.13.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 13:33:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
 Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20240810135937.4041797-1-seanga2@gmail.com>
References: <20240810135937.4041797-1-seanga2@gmail.com>
Subject: Re: [PATCH] pinmux: generic: Use ENOENT instead of ENOSYS
Message-Id: <172375398802.3490037.5222729105947831065.b4-ty@konsulko.com>
Date: Thu, 15 Aug 2024 14:33:08 -0600
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

On Sat, 10 Aug 2024 09:59:37 -0400, Sean Anderson wrote:

> ENOSYS should only be used when a subsystem is completely absent.
> Convert its use in pinctrl-generic to ENOENT, which better reflects the
> error condition (that a function/group/pin is missing).
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


