Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B9ACCF9F8
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 21:35:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDC3F83E70;
	Fri,  7 Nov 2025 22:35:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LrC2/yZ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1B4383E40; Fri,  7 Nov 2025 22:35:04 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF31B83E4C
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 22:35:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-30cce892b7dso600323fac.1
 for <u-boot@lists.denx.de>; Fri, 07 Nov 2025 13:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762551301; x=1763156101; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MAJfAfqGsecIbl/AWvtNa5EmybuEbrotzUwZKqhEl1U=;
 b=LrC2/yZ4E2A/QudHQTXKBgVa0YKIeSQKOvGrWEYG4jbYTu4XLMx8krPmuPMeZbr3FA
 9aD7oqEhddnzfj1DC2UHC1roXgAwHftSahhYpY5UXqJXuqtWKVEw86w6xtlid4uc9zi+
 B02A8BqpPBdApy1NR2bfKJxrQ9/6B8kew7I4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762551301; x=1763156101;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MAJfAfqGsecIbl/AWvtNa5EmybuEbrotzUwZKqhEl1U=;
 b=bmOPpmC0dJbAmWHZKfRikdTvqKe45W3jZpOgv6XQHtHTpj8hsXpVD3enesQ0V4wBgc
 og0uuQDhYNjwHBF0XzZneekY0o70wpXzBo3Va6loAnKa93yBwx72lvKp7CKvniUT1iKf
 yr7YiL5A8kJrlYGTrEkKuy/4niDTcC8nN8eEE+64/631IxHsp65tBjV5jaeYGcrBYanC
 cxma9rgYlEVJFNDt2LaqcyjCvptYJ8TbBuBh0ATrKuTXp70xPx51eiNtF3nJ7LruZf7G
 uL/0dzZYDfZMjshj7aZfR1bZLrbIxZVzAOCmtXpzoKHjVg0Hk5Cho5PXyYGvIMiDQvha
 aYsg==
X-Gm-Message-State: AOJu0YxBcY86Jms/yRISYvDau/wWFBgQER66R8bfnS9VVPZHRhay2iXH
 QrP4IntAZPybdtKUd722M2W1yyO3bdmKIa5v7bwVEYLLSGmccQK1IRxZknWLhdxP3as=
X-Gm-Gg: ASbGncstTX+VpU9rnXUI34gQ3z5n51JJEcf2ENK0rSqX+nEd/8YpXWtG/rHbDzhYAUw
 kH98gos0snRIkkEwInhLm/gzKSQGf2+TgGThNNudH+4YdzNx91egQKzXpYJLuhJJ3cfAeNc6ub+
 QxIiILN2iwFQlo/Xxkkt9mm/u2io6/TzTNO1+/ECxS5qmKQs7wrbE23IJQoNzy0Hu6xEYlGxAQT
 L67jTJaEs9sX/5bu3yCAnguQis5DVlXrouCKC2PvBkbsM9yxTDPesKhDLCP5obMtQh1U7rjK3PA
 1LDttqRGDk6jh6KgNbjTsHP2QA+gx2oTp+pY2rO/XvtUhy+Q2yjBdfWknAWXxuYdPC2FB3Hhz47
 KLFINF75m8MhwstbgLvlJTrOrrzN+X/0vfX4lFKYrJoNmVtihcm+ZucSAE1JmigAKWZqcKkzmyY
 Z3ote3wNG6AHf3JV80TJuskDHTek9lkvr0SayCNQ==
X-Google-Smtp-Source: AGHT+IH+Da4O7Y8flAYvryqCFqSflWYPVYKbLJ9csnEP971L2hgCRgkh66XiXMohUbOHqByzrFlSrA==
X-Received: by 2002:a05:6870:2cc:b0:3d3:5abf:e09e with SMTP id
 586e51a60fabf-3e7c2c1bf29mr656417fac.44.1762551300926; 
 Fri, 07 Nov 2025 13:35:00 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e41ebb0fc6sm2507000fac.2.2025.11.07.13.34.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 13:35:00 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
In-Reply-To: <20251104233915.89413-1-heinrich.schuchardt@canonical.com>
References: <20251104233915.89413-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] virtio: typo complaint
Message-Id: <176255129993.3424353.45743432929096398.b4-ty@konsulko.com>
Date: Fri, 07 Nov 2025 15:34:59 -0600
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

On Wed, 05 Nov 2025 00:39:15 +0100, Heinrich Schuchardt wrote:

> %s/v1.0 complaint/v1.0 compliant/
> 
> 

Applied to u-boot/master, thanks!

[1/1] virtio: typo complaint
      commit: b9af2d08094cbe785dd5d0018c30912ccd6af23e
-- 
Tom


