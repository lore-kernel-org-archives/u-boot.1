Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 632C9C83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 16:08:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F039B83852;
	Tue, 22 Jul 2025 18:08:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="recy9/9c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD545833F6; Tue, 22 Jul 2025 18:08:38 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C06E9833F9
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 18:08:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-41bc2668f46so1457638b6e.3
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 09:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753200515; x=1753805315; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HutSUxYchQRCq0iXDhxCG9//75ukIPo5Lgj3bJPimZw=;
 b=recy9/9cl7+1K/bcalo0CZccQxZgj36s2J7zJnPbRI3IXqfUBx48AlkoHAlKMz2afK
 sKk44G05HfbUlUqHNgz38t7CSXWrcx/C7xRD/fkUrKdQ74Z98dvZUOIiuSBRVRCwhQRC
 mN8CFtImrtxbO3UYeMtBRM9Pws8AEP2i8fwEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753200515; x=1753805315;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HutSUxYchQRCq0iXDhxCG9//75ukIPo5Lgj3bJPimZw=;
 b=WXHw659iR8Gx88i88F5nfEbOxqPYxZodhHA/dp1eZetETkCQ0KXtViHnNa044DvTb2
 NUsL37QLIArLuaaH1BT3+mxIw/OtxPuWrRsl+UKaLlMAAnNOGQwoAn3bcgF/UiuX43Q9
 +zpsmnL6MvU5m9xDGXOjkldecvOULnHGPDYghgF0hLVUT8c9Iy7wY1yBo9cIl1jI7C80
 vkYL/uXYnO6WGUibrKXC0xXElFURqVO1sdn4x6BcrJSGt2JWFcwfd9gnxTLRvrTM5XuA
 +G6X+BDVu9Q/yaG+FqAbP9JzwJ6y0CPoCnc8Z4lenogoOp8Brtk3g6w0DGdHYxRT1WHI
 rFTw==
X-Gm-Message-State: AOJu0YxwXHds0wGIWW9m+A9ftcsSVpWtJ6A8wMqNTjZwt67rwMrAPZb4
 nbp58cNGo51jgTqry1RhXVDS8QmIh62Deo1YQhpBRrNB+p8kBDzfz2MF8DhTvnxUv8jItKVGWdx
 +IHwR
X-Gm-Gg: ASbGncsIeP+ZHMxn/7ZcBTxNSe9/9YLD8/0ip6iF90BRGkx+YZt0TtjKBjiG+0Y3dQa
 QL408T6p4CpFafDaJdegN955nLGTrpTKG5r8iFHVRytydkAqlYQpWXrdmOHPArUew51erQQ9JiY
 gkCc0lnk0pMrA/Q7jLBe0yabInoW7AmGAW/20KIdaAG2yRrDUFersis/8LUH2AGf2j0YaO1DVmX
 qtUngn9EVLvhgsL1H9HP9eyWB0ck/R+7JV1PdUwLZfp3g/QOprqyaQQExAc1nMhUkUky1RcB1iM
 0lXdrqFVD/2A2HF05/ElU75kwNF+0ykc4/9Us3EV6Q0k6M8QixxHbr2jaxnN7MtJ+0zLyYKiNtn
 lymVX+8XdDNZbyrSoi+t2wGlp2oc/uFCCCjUjC1WmsDZYalyly4aDFHw=
X-Google-Smtp-Source: AGHT+IFCVbbuAXbEvGXYwn68Rsn54EROKw5baHbYxic+Fa2o1NM7BXSxwCm/SViUhILf+dFLIapOng==
X-Received: by 2002:a05:6808:189c:b0:41d:7d24:e328 with SMTP id
 5614622812f47-41f9718aa47mr13121028b6e.9.1753200515386; 
 Tue, 22 Jul 2025 09:08:35 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-615bc84dcb9sm2120814eaf.0.2025.07.22.09.08.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 09:08:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anatolij Gustschin <ag.dev.uboot@gmail.com>
In-Reply-To: <20250720203558.2278842-1-ag.dev.uboot@gmail.com>
References: <20250720203558.2278842-1-ag.dev.uboot@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update email of Anatolij Gustschin
Message-Id: <175320051464.8418.14127253301828641124.b4-ty@konsulko.com>
Date: Tue, 22 Jul 2025 10:08:34 -0600
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

On Sun, 20 Jul 2025 22:35:58 +0200, Anatolij Gustschin wrote:

> Use new email for community work. Also remove my
> capricorn SoM maintainer entry since I do not
> have access to this hardware anymore.
> 
> 

Applied to u-boot/master, thanks!

[1/1] MAINTAINERS: Update email of Anatolij Gustschin
      commit: f2f451d9d6d3756458d5037e3e5135e5211582d7
-- 
Tom


