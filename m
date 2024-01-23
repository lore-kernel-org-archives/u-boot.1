Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C62B6C47258
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 08:16:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0CFF876D0;
	Tue, 23 Jan 2024 09:16:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=essensium.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=essensium.com header.i=@essensium.com header.b="aCV9/sIS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEB53879B3; Tue, 23 Jan 2024 09:16:13 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC5AF876A7
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 09:16:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=essensium.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hugo.cornelis@essensium.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40e9101b5f9so45314705e9.3
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 00:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=essensium.com; s=google; t=1705997771; x=1706602571; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IB5Xn01lJvmnYjl16bdsIZCSHjBM2Dzc/UeVa4iFqZk=;
 b=aCV9/sISaNob+9Fl9JoJQypS6V68r8s0HHvtTZY0zG2pQfklyaLxLebvrs/AZZxU0r
 umQB3VzMSSPZiPwP7g406t9VIqnw8rQ9zteInAgRaxYjZN6SWZOKYZBdh2TqaFfct1+/
 tl+Rq1DRv1OcOV4TyMVeeTKRTl4QcZXBJymKS+R1KfqDYCUpTk3KYH0AVPgOtR1hFkDI
 vo/iX/sePXRbOXvji6C6Vr2D8gEJHPTLn9bBm/Z5NItNyFeeikp3jOLkCopKNm78ggXS
 DAfGSC+PQU4E7+ThFWoDJQlP+dDs+trHx/aVd2QXXHFwoEHhIecmuSXOs3EHUDnpq9kD
 f0Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705997771; x=1706602571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IB5Xn01lJvmnYjl16bdsIZCSHjBM2Dzc/UeVa4iFqZk=;
 b=anKJrU6VL0jSaTWpu6/k0onn/CHP5HcBPdFW5kKJKfbMdBptAtI6h7Ew+R23CQyBN8
 CBWN330ctIuLHS//VeD46l5s82Ryx+Zh9XzSdv3x5fGYGWX84HZmWL1TwpQa0MFqibWw
 Cc/bNGKjHTQ+V8DSpjRvff0fLeBFh9Yz6Lh7F+xn2PeyKKf0E3jBJx8MWBybH3WDpGkB
 VhGoxoYZTRWC3/+uNJ8/iI80vXuFqKJRvRR3uvtHguJ7sWM+5WW+noofS6x2eobKr8vl
 q97WUb1QklPTLXkPHeVIvgw1EB3AXPL1VCpfCZpEPDJ6l+nKajs4vIojsWT6fgLyFlPA
 hvEw==
X-Gm-Message-State: AOJu0Yx9QUD+LBF0gKzBMy9O/zryGj9U0sFJZU4cJbWJ1pLW7ur2zCSe
 1wuCxrXB1cXpMev037iU48D1vKc/1A74LCZsNvTu9/poVCyTERlVKzT+eJYoohpQuUOFox5eSmK
 o
X-Google-Smtp-Source: AGHT+IGO8IWHVDEKagRAIeFd2xHMSNXWwlLF4tGvjN40WBIQsiDP19HOdfIQzXJbfq2WAUiJ98gbRw==
X-Received: by 2002:a1c:7410:0:b0:40e:62aa:88dc with SMTP id
 p16-20020a1c7410000000b0040e62aa88dcmr291644wmc.127.1705997770867; 
 Tue, 23 Jan 2024 00:16:10 -0800 (PST)
Received: from hugo-IdeaPad-3-15ALC6.c.hoisthospitality.com ([84.199.249.162])
 by smtp.gmail.com with ESMTPSA id
 b5-20020a5d4d85000000b00337d5aa55cdsm12614205wru.53.2024.01.23.00.16.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 00:16:10 -0800 (PST)
From: Hugo Cornelis <hugo.cornelis@essensium.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Hugo Cornelis <hugo.cornelis@essensium.com>
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Date: Tue, 23 Jan 2024 09:15:55 +0100
Message-Id: <20240123081556.418900-1-hugo.cornelis@essensium.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122233057.GR3652023@bill-the-cat>
References: <20240122233057.GR3652023@bill-the-cat>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Tom, sorry about that.  Please find attached a patch.

Can you please review?

Thanks, Hugo

