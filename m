Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE9EC3DA64
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 14:21:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D80388B40;
	Thu,  1 Aug 2024 16:21:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="J+T/7tNN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 388D288B0A; Thu,  1 Aug 2024 16:21:41 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2435B8874D
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 16:21:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-25e3d8d9f70so4250903fac.2
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 07:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722522098; x=1723126898; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PPpjtUKnuclWk5dBW/IrkvItmp7hce6RekRKRdwx1Dc=;
 b=J+T/7tNN9tbN2d2zkiO1a2WQjkOtyeNKz6D6jBi8cOs2VQqlubJc2u9f6QWqzNCEfK
 ry0I1GrrnH8kTulJImLi5LjrvZXwJMm1fJGiuec4yGc4kRoaPx8ETyGSD7l8wP5tFmv/
 p+5l9qoW5wMuy7nzgbLaTV6SmR+doAowZRN1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722522098; x=1723126898;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PPpjtUKnuclWk5dBW/IrkvItmp7hce6RekRKRdwx1Dc=;
 b=ug3VOgR2LKYX2WH8b7QVHtvbCO5q0ucwrYz6ZPZGdRSAgWyJJ9Me2G7x2G7JU8Ictv
 puB0b0/Oz6UZTaDMK0Tro76cqd9ow9zuxznWq6t+AGZpWUDLM545oXMrNA2eVLH2/fc/
 7WjWWGa/Iiq+l+rINdK+9Wm2ISf829HQDMoFV522Na3zynDr93eZgp8IDn+FdtSbFs2j
 gZrsTdvnqWo1MbwTVLZ2vpX2cRYZIRo5M62cRopoHOzZb6UOkrPw7Q7Cqsi0WqKh5Nma
 DKsBVhpb0VAfIusojba02oglmjUJd21LC9kC0qXPqUD0erGEY7IU7Vnh0ZLB5Gynmo6d
 ENhA==
X-Gm-Message-State: AOJu0Yya9LyCRF5zvpY78G/whoF9Q9sXVzoq9RrrXgLoXk7ktlYDzygk
 r8UddWYnpdDVIC70k8oE7uAv+n+TCD7lW+Geilg0zoXmIwL8tCh4ufz4YqN/BLQ=
X-Google-Smtp-Source: AGHT+IFRtb6rxtW4qmgBjNPRq6wqLL0V/IjSEwE8zQ/1BFPWaa2sn7NK/9ZWwz+ODiphNIfGtUhw3A==
X-Received: by 2002:a05:6871:3422:b0:250:70bb:1a97 with SMTP id
 586e51a60fabf-26891d3c9fdmr346968fac.24.1722522097750; 
 Thu, 01 Aug 2024 07:21:37 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-190.totalplay.net.
 [189.203.103.190]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2653e63f463sm3087486fac.18.2024.08.01.07.21.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 07:21:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Philip Oberfichtner <pro@denx.de>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, caleb.connolly@linaro.org, 
 neil.armstrong@linaro.org, sumit.garg@linaro.org, sjg@chromium.org, 
 philipp.tomsich@vrull.eu, kever.yang@rock-chips.com, 
 patrick.delaunay@foss.st.com, patrice.chotard@foss.st.com, jonas@kwiboo.se, 
 marex@denx.de, leyfoon.tan@starfivetech.com, epsi@gmx.de, 
 xypron.glpk@gmx.de, seanga2@gmail.com, sebastien.szymanski@armadeus.com, 
 festevam@gmail.com, sebastian.reichel@collabora.com, 
 yanhong.wang@starfivetech.com, christophe.roullier@st.com
In-Reply-To: <20240507094237.168238-1-pro@denx.de>
References: <20240507094237.168238-1-pro@denx.de>
Subject: Re: [PATCH v2 1/1] net: dwc_eth_qos: mdio: Implement clause 45
Message-Id: <172252209513.4049041.1050059758384510792.b4-ty@konsulko.com>
Date: Thu, 01 Aug 2024 08:21:35 -0600
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

On Tue, 07 May 2024 11:42:37 +0200, Philip Oberfichtner wrote:

> Bevor this commit, only clause 22 access was possible. After this commit,
> clause 45 direct access will available as well.
> 
> Note that there is a slight change of behavior: Before this commit, the
> C45E bit was set to whatever value was left in the register from the
> previous access. After this commit, we adopt the common practice of
> discerning C45 from C22 using the devad argument.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


