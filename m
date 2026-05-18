Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A94CD343F
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 19:33:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9716A84688;
	Mon, 18 May 2026 21:33:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pKR4eM5z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CA8F84688; Mon, 18 May 2026 21:33:43 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55AA384119
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 21:33:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-479d9b155deso772535b6e.3
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 12:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779132820; x=1779737620; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YSVaJVaumEKEdnZZUQxERzbcaWXWITVNZe4wI84cbzU=;
 b=pKR4eM5zCkn6mpiP5UiMLdNdudDjQQm6m7OlSUleZTKGIat6pb5iyOv3OM64NcP/Nr
 K2WE6OvwVXwZAL9SkB0b6SNvl+CuFff/3qHGOCw3Ed1QdasfZqIqno2EpXb07RbJniLu
 R41gYazTLu549Bek6N2F14QUflIPM4vFquOI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779132820; x=1779737620;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YSVaJVaumEKEdnZZUQxERzbcaWXWITVNZe4wI84cbzU=;
 b=nqY21H81U50TYKkVD7BJwHDi4hDrhdbeIy0gZxa8kf+z3qp5D+ljRE0FeuDYLmZPAP
 4u7/jyzeXotLhQS00xouSvdkAk9RRwixR7h9hgdBUgKY64RdvQKLXNeNwSb+8OSCBhN1
 C6i6u6HyBrQUiHh+0MV9WxHLtCvQxifZn9q6LwPb6rXXecnw6u8PICuVoqlMPYzSeVQi
 HuzA2LXFTtFwQll86IV9hrfiVJx5idOs7hV/3+JvX8S8vqWgdBmPcm6Q8D61MDLHlZ/B
 gSp6Hx+hUjOBROQmbTvf8pYKJZVYvs2DdhQUaaS6pxvxzqWawc2FCTv58ASylA/QvBwI
 3RPw==
X-Gm-Message-State: AOJu0Yx9HSWiMeX4uJxHC38O2M7JqrmTp0mD0NdzHBmoyipKrdGhpTu0
 ieY4cCW45YG1I6wEvTdptMbweUGMgdklZF+QpcR1KZVWvI3KDFeRYWWse8zCocgMrZI=
X-Gm-Gg: Acq92OECTmyKBvEhFXoljqe22F74vm/vZI7dOjoYKuZe/4Wo5qWmqhs0bKsQpiyGL79
 4V23oLwfRfYI0EnThEHlAe4MWzvPz75uXYS14lxZSU9Q92Kbdp5b7RWnQD8lLwewkHdBpDEvgia
 PakAgf4ThQZX2BNcVbJ7SVOHgoh/RPH+/g48ikk1tY8+1oYOY1g72G6VZbd00yzmZK9vm86ICU5
 RQIbYzBzKNGulelcXaRoSwu7GgiQRvOQEYHfBRgq2HfdOw9bqAnVfLpnvYWbZTqu9uuRtPw0clS
 vPHLBHzAppz0r/XfXYRHfoVWrgl8eikzTGz+vhNXFIXATd3da4GMhrFbsIscJhYH2g9ksLSb6Qm
 HzHCzP1FhbWmXvCp93JkBvdXPyoe/CHgEtiwWFZlWH+UrcuGvLFgtyEbDJy2X8hoblYFJhLU7mZ
 Zu4+QPgA/VXa3bkUjxa2OfEAZc4yKpPT3ltWzxPQ/s4eptoGTVN8QDYlLdtcE32E0dsVvOtRMIY
 uth5vtDkhKT/5M17kEqFGKzJi9ZJrtaDf7Hfg0UK7eTX7CH7g==
X-Received: by 2002:a05:6808:c1e2:b0:47b:c2a2:1c89 with SMTP id
 5614622812f47-482e5650194mr9874819b6e.21.1779132819910; 
 Mon, 18 May 2026 12:33:39 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b81cc5asm7805603a34.8.2026.05.18.12.33.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 12:33:39 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: Sumit Garg <sumit.garg@kernel.org>, neil.armstrong@linaro.org, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Biswapriyo Nath <nathbappai@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Timple Raj M <quic_timple@quicinc.com>
In-Reply-To: <20260518155457.270420-1-casey.connolly@linaro.org>
References: <20260518155457.270420-1-casey.connolly@linaro.org>
Subject: Re: [PULL] Please pull qcom-next-18May2026
Message-Id: <177913281856.438611.9678527878909805889.b4-ty@konsulko.com>
Date: Mon, 18 May 2026 13:33:38 -0600
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

On Mon, 18 May 2026 17:52:18 +0200, Casey Connolly wrote:

> Here's the initial next PR for qcom.
> 
> * SM6125 gains initial support
> * The qcom clock drivers get better support for configuring UFS clocks
> * ufetch gets some aesthetic improvements
> * A minor bug in the qcm2290 clock driver is fixed
> * A few qcom drivers get static/constified
> * the GENI serial driver has the RX watermark register properly set
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


