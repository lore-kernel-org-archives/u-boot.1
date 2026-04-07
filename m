Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15256FF5135
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 19:51:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90DD2841E6;
	Tue,  7 Apr 2026 21:50:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Pm+85CvB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADC1A84144; Tue,  7 Apr 2026 21:50:20 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C53684105
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 21:50:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-40f1a1f77a6so3517965fac.2
 for <u-boot@lists.denx.de>; Tue, 07 Apr 2026 12:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775591417; x=1776196217; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4KCZLhum4f6g+C7d3jUZw/s6RWaVa4M0PD+5YOABujU=;
 b=Pm+85CvB0Wjv2pEik8oz+uqL/UVPO8sFn5/6iq54ZvpgtYvUEQzYi/3FLKNNa1JMDD
 g6Egwg5az0I0zBIBQQDoWWy5XxM4Mzpwx2Et/2OKvaSx1dzWrbTRQPCvcuA9a1QVlAKP
 7jQ1MTIXII1G6SzOOCQUKaLGLX3S+XMnlb3i4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775591417; x=1776196217;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4KCZLhum4f6g+C7d3jUZw/s6RWaVa4M0PD+5YOABujU=;
 b=GKsvbjKpL1MzSQPq8vw+T+zHZXRJTGC6wN9buGIfq7P6WOrM+tNm/6h1Ii2Kd2UkK8
 FvZ+xBP+rI96pb7EKtg/m/A7VRBkqqueIQZrbfzANLi0vx1wVQWt+a86Yxe278Qo0gHr
 waNfyX6rfeJQMDanjoZu1RYD7qvO3juEez2Y+ROWhXDDhPfoWtEaM5iNctB/FDt3BrX9
 1G/+bNpRXZaAzzlRR8PsWvmypR2LSLeutbVXXT1UQ0Qf7IBPVM8XUX+voYH1MCXLAi2i
 uuXv/aBgtb1hCG1Uz04J5mIFv6DcOJx3WAXMgc8lQG6ZhopDL7qEIvcrLQLArA10mi1u
 2Zkw==
X-Gm-Message-State: AOJu0YxHcxQqfyFl/e32gLtwXnZAU/24nC3d5zZTlPxpv3S19rwPNymD
 YeQ5RvdSrcXcaoNOBkboIQb0UbI5kMnhUxeAhbflp4POSKHZQGphfTUqgZC/Ue8zwqC37pAPxX0
 SzBr5mHU=
X-Gm-Gg: AeBDietnucfN3rX1reahFpGjrxIG8x6VEOziiNSNkx/+ew06pw/XMqIrCzUubwnsozg
 HpMlI4FMTMf+V4ltVIWxRZ9x7LjkyW/Zm7lIFchUZ/29lENYCdRzu5NmkzA8mNWaDutiJw7BKN1
 9GVlWdnXLRl2boIaty8mtfX53TIqkopVS8aL8435K/8DRPHWDlYByXCv5Ew1h3QXRMXEyLHryRB
 edeeqXLVQmQ8JfO4X+pffutf7xRJNKM3czQQriFXfWIMfrjcUocRZzGhlEzhpK+YKPhEbdEqGWQ
 ESxQiCFJt+15K54fE6U2ZK0kPdoVNQNgWcU4CU6VXMQkc/t78yQW2hT+8fney+iVRFwbVvysg6I
 PMx8SW+KKP33ggUPhvLZMbZ9MrFFHST/0XTtvujz0e63V18xEi1+fKqQkhmj9epL6gXGtn3NklX
 9NmwqlplkwVruxg4JHCi9JWlgg/i5LunI9BIbCXqHN2UUu/m9wMenfDA8vooL7mPn0T5wgyplPM
 CkqfQWrTQoPYbOKgbUNqp+jMq0aLZSE/UGHmfBEloSCaKQ=
X-Received: by 2002:a05:6871:c95c:b0:417:c116:ea79 with SMTP id
 586e51a60fabf-4230fd199b7mr10549646fac.12.1775591417321; 
 Tue, 07 Apr 2026 12:50:17 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42324017960sm9988782fac.7.2026.04.07.12.50.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 12:50:16 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260323195306.2363609-1-trini@konsulko.com>
References: <20260323195306.2363609-1-trini@konsulko.com>
Subject: Re: [PATCH] serial: omap: Fix "unused" warnings with
 SERIAL_PRESENT=n and OF_REAL=y
Message-Id: <177559141672.2108693.11662104456970362764.b4-ty@konsulko.com>
Date: Tue, 07 Apr 2026 13:50:16 -0600
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

On Mon, 23 Mar 2026 13:53:06 -0600, Tom Rini wrote:

> The definition of our ID table (and of_to_plat function) is guarded with
> OF_REAL however the U_BOOT_DRIVER that would in turn use the table is
> guarded with SERIAL_PRESENT. To avoid a potential warning we must also
> guard both with SERIAL_PRESENT.
> 
> 

Applied to u-boot/master, thanks!

[1/1] serial: omap: Fix "unused" warnings with SERIAL_PRESENT=n and OF_REAL=y
      commit: 3fe899fbeae62b8408c1e70532fe58cdab959dd0
-- 
Tom


