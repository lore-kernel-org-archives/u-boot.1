Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F9ED3B9BE
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 17:12:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EB4583C7B;
	Wed, 10 Dec 2025 18:12:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bwpEL5Ao";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E8AC83C7B; Wed, 10 Dec 2025 18:12:52 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCC6483869
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 18:12:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7c7613db390so62358a34.2
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 09:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765386768; x=1765991568; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cIlNMb9i02nongydE1LfTmc78jItu5hkTIn+HrbjTrc=;
 b=bwpEL5Aok5Cy1i17tseX4qW91+PWUwECzPfiaaRAOG8Yuhl0OEII33MjCO5N2FXkh+
 leypreL5wCogVXXQeDt0ckv/iW7RI1gJfo3b6lFFvgqKyBYgXo53SBOlwCIWV/X7nBKB
 1ETdwVeIy+3Y6DpcsOXkv0CFa8Di65iEYNFBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765386768; x=1765991568;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cIlNMb9i02nongydE1LfTmc78jItu5hkTIn+HrbjTrc=;
 b=cu+ieDQCfbuHZzgRA2JWQ9Ru5vfYPqOmA7V2YMNBAsX3eJB+bmvDOM/9zsfBmFDOX8
 x8U8GDN+YIL8CwkICEU9ebAb3AZ/s4Hn09HFrtDmNQOoblqdiMMYCLcRLYeRxx/zdre5
 3GlPTYwaPXKfkkmETharOLZ19r4ayNt+exxTWppJB+Ww0k41WckGia3OX0X2NhRNS6MI
 clxiywZilzt6JGP3U0eiSU84RZtyxuCCMTj9ijV3D17b+xnrsXfRftwzb8cecUaDB4u+
 uXwmw/bDeoQY/3kejT8UC4LBnmno96tZK3RcpJau5v4awfUhalnSRtGYMCW6j1TCa0/p
 RUtw==
X-Gm-Message-State: AOJu0YwSw8WMnQ2AczbB6Wd4Cval1ja5fBcRB9LaKXFeh2Q2KFq02b5L
 eQ0/QwKS99zW2pLNfgxyJhUceI1tWVTXHBVMs+ZPgVKSaDYFnb0Cnj9LwDisl99MGNvJHz2+A6y
 hmVqcUKY=
X-Gm-Gg: ASbGnct4RncCH/yCcqyuf5iZyZuP3O0OH7rU2JucnZcCMSHxsOn4fqEEpvBi8q6ZPPI
 OU25mBaK980BjsPSjRpxIfyzQe63RLxaAZlgvveD5igyO1B2kBLMDzXmejld1j2Icb8Ut87yeER
 ydtRR5O6v6/dE2FYAKNiFCVV0PAA6lRbe7UBAZAvw3QXOnLj34YqZWR4owBOJjKjNOnwF40vyam
 wda9kB2CsfGI9WCNL8kaOtn3mJMeF4wQtJSnpUXwGL5LNkVN5IsR+q6B8MmRTRC80WZ8zJMq9bo
 Pyl4ZL+28Yg6aJNdvRZ/sTN3hedqsvdS0+wXcv9elhEagwFFl7aFxx+8dDQEzqpJims4r4Zh9aG
 cheoTdiF1fcazznstlp9h2Yn0lPHEyQ5Ar9/57+jnm37+T716rdg7Rd/89GBq6bz81BjR/dJBEz
 zz3AObNgD1INhL8/9Al2HHo8jTso1EbZznyZF4wGeZdblnRECI
X-Google-Smtp-Source: AGHT+IHZRbMk34NFqKilujJ/RHOAxiQ5M5h0Z8gnyNQSgspvhk5CF4syq8xRU7jmzN07yLyRjsZiBg==
X-Received: by 2002:a05:6820:4cc1:b0:659:9a49:901e with SMTP id
 006d021491bc7-65b2ada2da2mr2014050eaf.75.1765386768439; 
 Wed, 10 Dec 2025 09:12:48 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65b3480fb94sm34528eaf.11.2025.12.10.09.12.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 09:12:48 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: Marek Vasut <marex@denx.de>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <a8fe7c31-1aff-4625-8717-7dfdcc572fc6@foss.st.com>
References: <a8fe7c31-1aff-4625-8717-7dfdcc572fc6@foss.st.com>
Subject: Re: [PULL] Pull request for u-boot master / v2026.01 =
 u-boot-stm32-20251209
Message-Id: <176538676768.3321367.11635149400015649023.b4-ty@konsulko.com>
Date: Wed, 10 Dec 2025 11:12:47 -0600
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

On Wed, 10 Dec 2025 08:55:35 +0100, Patrice CHOTARD wrote:

> These 4 patches have already been pushed on next, but Marek requested them to be part of master.
> 
> CI status: https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/28704
> 
> Thanks
> Patrice
> 
> The following changes since commit 0e0a198a68be71148f5ec27ef86796174f91436f:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


