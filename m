Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BAC1CCF9F8
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 21:36:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 161F883E76;
	Fri,  7 Nov 2025 22:35:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HCTKFSrx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 435AE83E52; Fri,  7 Nov 2025 22:35:05 +0100 (CET)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40D5083DCA
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 22:35:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-3e2d1477b9cso666943fac.2
 for <u-boot@lists.denx.de>; Fri, 07 Nov 2025 13:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762551302; x=1763156102; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HvnkgvOl5pwjqtiTlHWt0WR4SEfw1QzWy1PPl3hIPEM=;
 b=HCTKFSrxoC02x8xaVsRtnDeo2JAcH7yTYaJ7PtsJzaBLVqQwb5NaZQp6Oz+jidLy/Z
 AUa1NPfgG0ByhBJQ1ftL6bTzE5EA/NygUiIl48PmTzn74Pkpkc2bQESuuUGAtzy6q9/x
 AwsU07HKS4aexgMxGgR71q1wsVSUBcAJcu4p4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762551302; x=1763156102;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HvnkgvOl5pwjqtiTlHWt0WR4SEfw1QzWy1PPl3hIPEM=;
 b=QlmSUtSOpoBdQ+mMvE0Eug9GjGjuNF61H07EoHH6TAa2HjDlEL4Vo5vGTmyCgN6Slg
 YHgZ7oAjN0LA9lvJUHb9K2tgN95l/vL93YVAfsnsa0MDuJUbfS/p4uuGiunL4PJdF0pp
 st0iXh33CVXhdXJKAw2K1kuZ0iyssZtchVJSIUYOeU35Hc482CIY1XKgRW2zvvsONH+Y
 KO6QEqWKNhj45TE5417PiSHZcLNmS67BauTs4iZa6ZZtL+DcMLurF3whIkzr8ZHoSQ7o
 rsCI9c65bKqxqiv2biGftQDzX6/NrlwJD1QA0GFjUpbQOlb98zfJpBdqXDVwdOhAAWy/
 z1cA==
X-Gm-Message-State: AOJu0YypkpUyCeM65aSniWUAB2OZnJP7aJYsrWMqAPFoTWyEPeyUV/lm
 9z5kqZae9hXqY/zXedXL/DgTo9Y8rCtfjcMWqO4uPcYfCbJqPWWHwFPQlYLrKOZkQOc=
X-Gm-Gg: ASbGnctN/yFWNXcVXUXNBLgKbNfztXhKGr43eStPm6yPFOThdL5RowA1C4FljCoZYaW
 d1TF4EiO+OYCqJxomvLyTb/wHLX4JhNJype//w2gbmeQl2uhBEUV1iWoYdIA6K4CTIqGIof7ojW
 6yDAe66GFeIXVYS25ecQKO/kMHZeaCsKuc0TiSbM0HgH6sBIJViAA+KRLE+YzoTDnpW5ofBZhGh
 yPJGXf02LCVY2PwSZmQpPH9PlwckCNJALeNb0Ttk9TpV5r25/A2Ru7VJnHoahICI0vbemo3+I+T
 RY8KmriLKwCTKkPVDrjJhthYZIJSSA28szkPVsLmK0HrOUJLfhTpesOii8UdX17VYLTxYq2legr
 kQ9m9pX32PYDDY2mrkXv/jYKuPMMu6egEMn8WFhVdjVYAoj4WtQAcUmCzpEWfbMQ2SXLpGsGDue
 MAPFN6b31RD7cfv6rO8CqHKiSs7COIHknnpYN9yg==
X-Google-Smtp-Source: AGHT+IFjsNV3gxiSrtRYe4aRF9mtaaCaBQeTcyV23a42tedVU6OKuwJt670kyyzpsmm9fruy3OAzCg==
X-Received: by 2002:a05:6870:594:b0:3d3:10b4:9cc2 with SMTP id
 586e51a60fabf-3e7c2944b25mr630181fac.44.1762551301966; 
 Fri, 07 Nov 2025 13:35:01 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e41ebb0fc6sm2507000fac.2.2025.11.07.13.35.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 13:35:01 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
In-Reply-To: <20251104234231.89796-1-heinrich.schuchardt@canonical.com>
References: <20251104234231.89796-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] virtio: typo 'private date'
Message-Id: <176255130133.3424353.2411512121524983179.b4-ty@konsulko.com>
Date: Fri, 07 Nov 2025 15:35:01 -0600
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

On Wed, 05 Nov 2025 00:42:31 +0100, Heinrich Schuchardt wrote:

> %s/private date/private data/
> 
> 

Applied to u-boot/master, thanks!

[1/1] virtio: typo 'private date'
      commit: 6978d6ae5964c79bd25e0754a65141906e823cca
-- 
Tom


