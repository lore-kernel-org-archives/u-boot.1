Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2AABD3398D
	for <u-boot@archiver.kernel.org>; Fri,  5 Dec 2025 16:27:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E7BF84220;
	Fri,  5 Dec 2025 17:27:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Tr7y16j9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F72D84212; Fri,  5 Dec 2025 17:27:05 +0100 (CET)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EF4B8404A
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 17:27:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6597b072cffso732797eaf.1
 for <u-boot@lists.denx.de>; Fri, 05 Dec 2025 08:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764952021; x=1765556821; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wPNW1qF7YXUd+vw1NSVIBtSdhndvcXtzqMVPD961EYM=;
 b=Tr7y16j9LqY693f2FrgfHeWD3T28nFlYfTSyA452h9yKzMIOpG5k03i8M9yNg3TQsz
 CEyOVnwgWcGIFJaP5OMtdkrzCpGBrvl5k1UlvYTGRIQxcEidStLp0jnGHft6AvNxANd4
 GotpU5qAQN2buGQRAmDTLpAWOY62nuOZvEijE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764952021; x=1765556821;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wPNW1qF7YXUd+vw1NSVIBtSdhndvcXtzqMVPD961EYM=;
 b=OGU2FudT5CA20rfe3e47BIq8oMNBlev+w49hCHtfCK1Olqfsh/epvUcS/vDdv8Lr47
 EANIBKzXC3D4utT+Am5oVTU2YZ5F2yRt4PEbQZjLAgaLGaWjlDMPMzXEeTBCWVsFE8P5
 qKaEXj3OWIlChTJ/6CBoODLZ+4HlCu1oPNrMA1hWLtslHa3pkHfY3fztCRSZjMFo+2VU
 0wVqEgAyILXDM5pNEVskRrXtKfi12Jql4jGuUA49fudH0NNxzSgw7OhgwX2Orf2itYh2
 f8pjrpbzXLkfVuvyNtPBxUjyVNTgw0tPoEnBOuakfclKE5PylVfxiN7hLmBZrWhBopkZ
 MGPA==
X-Gm-Message-State: AOJu0Yz8sVqJB00KuzfS/2/NjoywQkRrwCzFHmJHgCn/7vGyiBHYzAof
 +eExqA++Aa+Vn2OiOcmdCSyQUpL+bdmPgPZMIzQvFxv1vYopQzxLf2HWEmPg+0EOaNA=
X-Gm-Gg: ASbGncv4T3IRdEIK6uYdALViOER7xWNorCK+RTOI8traqYgDfLN0Vyqr8TNWjYxvJuN
 6A+LWU6U08Kdt8+M594jEBtH0AgReoGkjZK/nvLOc3mYvnDZAGHR+xL4h2OaUEg+rPocmDCwBsj
 MEqwmfL+6AXMZC4pM4g6yRKFbA0v3BnANlkSZ1khqNECOgAQqCXgktNlw0vfP47i8nAhs1j/XF6
 vqWHcT50fSj1qHMz+4jLkw5MWYKBIQ8pUCR/YapK/qpoPShKZ3loowE1lztScv8jXvijTRn/+Yn
 txSm8EZ0VAjn1CgRnzpK588PSoSeEc9ZdRovoHf2b/nft/ED2IKUc4JRJVCgLXTx2TMrwXnkq1N
 w/TkF4jelW7wx1I+DgRNUtmE9x23pOSTSCXK/6fTHjjVjDU6NbwFoWqBMSoXeIadnW2Vez1Qu84
 VoS/9jYj21SZfqhyhrs+N70ODpXYZEeq4oczXFGqBJKhM0GfZT
X-Google-Smtp-Source: AGHT+IG6hXTE7oCSnbtb0vYj0b6R0augStqlCEdnkM9f9gG3vBp1K41w0qOZ0eurDG6qzLqIMXCKwQ==
X-Received: by 2002:a05:6808:6d8f:b0:450:3ff9:f4dd with SMTP id
 5614622812f47-4536e44d19fmr5932125b6e.24.1764952021411; 
 Fri, 05 Dec 2025 08:27:01 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f50aaa0fdasm3636773fac.9.2025.12.05.08.27.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 08:27:00 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>
In-Reply-To: <24fc65d7-befb-4e8a-9bd6-46edbf87cfa0@foss.st.com>
References: <24fc65d7-befb-4e8a-9bd6-46edbf87cfa0@foss.st.com>
Subject: Re: [PULL] Pull request for u-boot next / v2026.04 =
 u-boot-stm32-20251205
Message-Id: <176495202058.2280840.2288024739708712499.b4-ty@konsulko.com>
Date: Fri, 05 Dec 2025 10:27:00 -0600
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

On Fri, 05 Dec 2025 14:24:22 +0100, Patrice CHOTARD wrote:

> Please pull the STM32 related patches for u-boot/next, v2026.04 = u-boot-stm32-20251205
> 
> CI status: https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/28641
> 
> Thanks
> Patrice
> 
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


