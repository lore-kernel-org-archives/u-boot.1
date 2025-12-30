Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802D7EE57C2
	for <u-boot@archiver.kernel.org>; Tue, 30 Dec 2025 23:19:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEDD983FA4;
	Wed, 31 Dec 2025 00:19:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Oc715b/W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92C5183FC4; Wed, 31 Dec 2025 00:19:43 +0100 (CET)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A8DC83FC4
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 00:19:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-3f9ebb269c3so3768284fac.3
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 15:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767136779; x=1767741579; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IlgLdh5+GCu1XbVZE3YB9ri+/ztrymGp+u3vtq2WgMU=;
 b=Oc715b/WqHmS44hFkr7JAYHu2fvWrlsZJD+OyQL80YXYy/nnMNkvtYuO5PXPFsPflA
 5QRwz7jbSDddwPagidtzAPACFGcphhjm+XSpFptHwnVsfsiDDxCuvEccbMrCUOEIUBXT
 H+4Zg3ViRw0KLULDwfVfdOHAB0vyFqBnW1NX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767136779; x=1767741579;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IlgLdh5+GCu1XbVZE3YB9ri+/ztrymGp+u3vtq2WgMU=;
 b=gn/3i2xzGLtBT5iAHXIZeXIdb6IMjBOglakWs70bET0FCnfP62gxUonQv2N93G74a0
 H/8WKSWgmm/vCh93GbKGGvvbTeNtFSOsl5e/cqH4r1wP/4TNlzYKuUjXWh9MLLE8/lOx
 2hR35cNUM9WxtkgaVDaInkBR7GMQJ28OCpUJ8OTlhr1ZCUnCFcWNm1FSdvEXNOqVGR02
 kJXemx999fqvG0MNm2/DIgb29Ezn5R8cM8b9KK03QyYxcbLDqua8c0OCzX03+BKgWTJd
 j+A+0T7MveNzTrygpVxn5SVOObMakWhKCyGxSI8h/z/nI+6vOdO6VsB7OvTyCFqzQVsM
 y0KQ==
X-Gm-Message-State: AOJu0YykKnbCbxfT10PKgcHXWPV7zrU01CwJ70U2wmYVKA9HZRzHM6Sk
 3kiSkETfOM5JPxSffahfJx44OtkF5rhUvu4IGd5gfgcI/2BfW+DkfEJH3Mo+j2t/5umy4XzzCoj
 I5uUa1Eo=
X-Gm-Gg: AY/fxX5vJqfF2Sj4n44OeU3vz2KmqF9HY7A1Z/W7HbPz8qXBlpwhQbCQYWMY9XGW4D0
 AMskSd/Ihy0QS22dCMjr4mId/mwafeTfqCH/t2W6AHNEl+kK+p6DtdK1IM0fpZ72XMjlX3T94cP
 Hgut0FyEF2tDQRH118htzTFLqSqkQLAtsfwUEhKwabLdKziEYwiPBk0f0AsvLshi1A0dLKTs0y3
 +vjyj4xARHIu+U3KEWXHwYePkugkbfrdLGXvKUrKyzsJoPaHzSTXB7acypjuYGjh+p0K8rtt8eT
 20hsd/ZjpkLk4Dl+kRMzI5micDeCTwIc5VCbjNqeWnHbhir654bU3VM3HibhbPJ/+6jNxLX5lxf
 4uQWBCoV3M+PLQD4MRj8tREpXMr6LlVzQ7KzzwdqkumN8OlY2vN882fdtdEPZ3DeNNeP4lc1Gj5
 8XEdGReXCzBb8xwDarQWbxCTt1awcaLKhMG0tY5jyOPiV4k3lRniAb/qtgjr5qh1ktZBClDuFQb
 mwHJQ8TwSJocT8BzaXEnE0inh18UJ/8lMJcQw==
X-Google-Smtp-Source: AGHT+IFgI7p6zLF8EGbQZImeXnRCX4OEkh/fffdQKEpEw0Scgt80JA3TBDvz0V0AUY5P9G0jLlk3Ng==
X-Received: by 2002:a05:6870:1690:b0:3e3:6b75:6c14 with SMTP id
 586e51a60fabf-3fda5816477mr15739384fac.29.1767136778870; 
 Tue, 30 Dec 2025 15:19:38 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fdaa8d4521sm21172083fac.4.2025.12.30.15.19.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 15:19:38 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Igor Belwon <igor.belwon@mentallysanemainliners.org>
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>
In-Reply-To: <20251104-sfb-stride-v1-1-698d419a8be1@mentallysanemainliners.org>
References: <20251104-sfb-stride-v1-1-698d419a8be1@mentallysanemainliners.org>
Subject: Re: [PATCH] video: simplefb: Add stride handling
Message-Id: <176713677822.315706.17254490540361594713.b4-ty@konsulko.com>
Date: Tue, 30 Dec 2025 17:19:38 -0600
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

On Tue, 04 Nov 2025 15:50:36 +0100, Igor Belwon wrote:

> Some framebuffers (i.e MediaTek) do not have regular stride - its line
> length is more than the display width by 8 pixels (on MT6878). As such,
> introduce the optional stride property, which fixes these framebuffers.
> 
> 

Applied to u-boot/next, thanks!

[1/1] video: simplefb: Add stride handling
      commit: ac56c61332e6386881f750441e366d029b8dda4f
-- 
Tom


