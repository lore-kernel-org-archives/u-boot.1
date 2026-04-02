Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B602D6AAEC
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 18:46:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B966B840BE;
	Thu,  2 Apr 2026 20:46:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="C5nj1e5p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45EC583F7D; Thu,  2 Apr 2026 20:46:03 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8411E83F7D
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 20:45:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-4670676ba03so462675b6e.1
 for <u-boot@lists.denx.de>; Thu, 02 Apr 2026 11:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775155558; x=1775760358; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MFLwPfE09uOQ2yblcu9hYunZuhGfzr1Z/aNLVENL1b0=;
 b=C5nj1e5p8DJvo2Zjux74QY0n8g5pgNGGcBUpBkCTSDQORtT573owFcQ05RFkHXan7M
 F3iBIdQeTJj/lvUiv3C/oAdTIKxalsnaZsyYpLw1TrmudMYQxN8xL7XPhw+0qEsHHU24
 CUlhMtcQagnEJKTEyg+/roMKxhDOgUCFU6kTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775155558; x=1775760358;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MFLwPfE09uOQ2yblcu9hYunZuhGfzr1Z/aNLVENL1b0=;
 b=pheYK07JVGg1OBbU67g/uNerSa4BENRC289D4lBBQcl+IB+cduBT24ONZn/9UyGUIr
 DIYSCoQxi4eiLHfdz3QF1cBdrtdC/ObTu0SJx4uDA0RBxpDNnrybJjX9mAhX3nxZc2nI
 WG+lgQ1DST7ersqw/+pY2WpwFna37VGzzrkoi53cDXoOQCajp3UXHey8uRm3cZHDBh40
 A/IwvrQF8f6WPXmI2bZhk6oly9JDmkaEgeqQY10iN4wZyo75f57js2/4wX+F529HuX4p
 SenCgRMP86GH2U1/K6iLenjgso9fhe9MzvI0cEKMdBtpZW+Cb9orCZ15BgtmY9W8OZmS
 6/zw==
X-Gm-Message-State: AOJu0YzPDTV8DWLpv5cVOPuOmBvvuXJw0Obmh1jErQGjfdaPMFPaqCIR
 Eau/qybL9H9WFLeVGmCaMfGTtlJs3XMoYFBPABO71iCspYUe3doPEcQryn+8HA/UvrLPJMwnpoi
 oKYTGKNw=
X-Gm-Gg: ATEYQzyNmkk+EkEM8xQGx4OAxLWUio9u9jkWYQGa8htAufrgRK9pB+RUqZNknkGLBM3
 g0vxUvrTGrh/LbpOEohABa5WE+nIVTinOE+N5iuZ1ICOjVXQzq2ZCSV7kaqwINXxhrmyOlImO+I
 UcfxUwNUjwRQwSKokkTAN0VIomyY6pLgnK/F0lzstsbLgXAlPMNBMD0QURjWPUUrPVEpCsOCa/7
 d3A/LbjaOTCbhdajOFD5DAA2mL6Gvxf/BtyxS8H0wanM3Hx4C/FsyRPDMVCbgdp6AV3JzbjGBYP
 YPmN0e7RsB5hn1YOzSVAPvrKu06S4W8YJOGZoH5+uoWML/9YeYxxkljHzIehB1u8g6PnvoL0nPP
 o9ocyIq5IK+VIrVivnjPT2HOMKAYykYrBxtfXge4ckEhZps2h5BkjbX/Wpysvg4WTtcSvI8g8Bw
 eYLdh/0dsiTXxw2E2NVhrBsSu2XT0Dtoii3A4sFjFJuHfkPEEh98yY1U85C6iadTxuiBtBs6GLt
 OyD5DddjEf9LtVhkkHdFCA8vWbWzYCEW5GmTaMsv24x6IeIQvUAgSSDjQ==
X-Received: by 2002:a05:6808:221e:b0:467:455d:a86d with SMTP id
 5614622812f47-46ef57fbea3mr278022b6e.13.1775155558204; 
 Thu, 02 Apr 2026 11:45:58 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46d9044725dsm2085830b6e.8.2026.04.02.11.45.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 11:45:57 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260319163336.1679890-1-trini@konsulko.com>
References: <20260319163336.1679890-1-trini@konsulko.com>
Subject: Re: [PATCH] serial: pl011: Remove legacy serial driver options
Message-Id: <177515555746.1935668.6882882310761307231.b4-ty@konsulko.com>
Date: Thu, 02 Apr 2026 12:45:57 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Thu, 19 Mar 2026 10:33:36 -0600, Tom Rini wrote:

> There are no longer any users of the legacy non-DM pl01x serial driver.
> This lets us remove both CONFIG_PL011_SERIAL as well as
> CONFIG_PL011_SERIAL_RLCR references. We still have SPL users of the
> non-DM portions of the code.
> 
> 

Applied to u-boot/next, thanks!

[1/1] serial: pl011: Remove legacy serial driver options
      commit: 39214eb49b62c161796413f64a64c96e177c3bd8
-- 
Tom


