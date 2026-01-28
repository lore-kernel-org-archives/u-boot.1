Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C04D3F064
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 14:03:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94B5C83F61;
	Wed, 28 Jan 2026 15:02:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="S7HYAHhy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2339983F36; Wed, 28 Jan 2026 15:02:37 +0100 (CET)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87BCB83EC9
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 15:02:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-409470ad5bbso573329fac.0
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 06:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769608953; x=1770213753; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nGuVvowVhfbrLk+VVh0gB9H7Q1C3elR91W+tiwtBdLc=;
 b=S7HYAHhyv/W2864tgRq0pmh3PyLEJf0NrGWUkM2hcJEgtWG3Hk/JgejdWcKV9nt5uc
 gGTNASib19MX+qg6LUf9yZkCVfDdGTc4ph6oFlBEkkyJ0Nzf5EXTR793+aypsnMBQHFp
 40n0RNA2wwhzz1pdwKj6MBScIyxSyFULT90HY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769608953; x=1770213753;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nGuVvowVhfbrLk+VVh0gB9H7Q1C3elR91W+tiwtBdLc=;
 b=PjdvbmFhqM3OGYtem5+DjLgFeUN3Ykrq6DfE2NxxW3C7+pCmDYjcAStUWkvlFQDAuo
 sDafdusPYdwB5Bg2C/AoaUV732O81qbC5Qf0QR8LhqG6PBtQB+XkfjYp/kTNlBhsDLyu
 ObRcFYOAiWVruQtBtuTbTfFtnnrJMj8GwNpRlrXzpDkAO8ynp+KguWI3soRI6wzdV6H8
 QeAmUX/mhAZgRWXzUvr9ZoUsiq7v07opzSHCDlWUFBtHU1kRQ9bP0BBuE3fkqmXNHi4n
 emCYDSdbTqxXyBScYF8i9siPft80WNgAmqWdkLDr6+rY9cnEVKieLZJMMziU5puaouGo
 qMQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/2lLIqPOsxbQrmjk5hH3HI7nhB08aSNdwa2uZGAGiZww1mtS6Zj3F6vWxMIpvfLuSXhbqjJY=@lists.denx.de
X-Gm-Message-State: AOJu0YwAZOTH9Qojymp6xYLosZSFewm80X5bzRuCqZXbPtvY8rsru6As
 bKlkAex+SrO7p6LmUkbdqh5R+N5MYRnBuB80QKKZIVVzp0gVIPHY+vipx4hl/mxsf6Y=
X-Gm-Gg: AZuq6aLcSxHbdyG0mnxSt1PhDIjjvRab2LnTItfiTFltTGmzDhxokErapvCNDswScAt
 KMNNP89wqpuigR2mQt9QoAZv2Hv+BGKwvFt/ZLpE5+UeSU36mb/mZzkrOPCiDb2o/xknU4p4yU5
 iPSyMPyhcvULsDAox+Pdn87nbQw6o4cHCeZAgNOlWNEieU909FYxOCcjpa1hMsbVZJ5MKSknQZH
 YkRbA4TRu8k7Fgr+IFDI6ZRkh/XPNyC03D8nYcrVxm8mo52HfUcZ732Y5TfLJ3Iij2W+gTv5Lee
 hwAy9eCA1UnNsBeibvm5MdsU+vZwkRZVe3Q5nhNlkLV9T3VaG6XqgxoeLWjB2VOtpM8X8RwoYFP
 QutvTQs/rxoDUI1b07fHRRcjsBMTA4ijYClJOba4yECF9EcmNaTHHAgVzVQ9wSg/OqhFOegHpFz
 bxV0dOOEfgNvBbwBgvAcUwuileJIiFQEHAdi1+PfkAfRIZQHp3qY92Dy6Gt5c7CXRSBTUxTTVKH
 ksRkRfBrgyzVmo8Vle81PVG37LKsWdcenmKhw==
X-Received: by 2002:a05:6870:8649:b0:403:f8ca:3fb2 with SMTP id
 586e51a60fabf-4093fce1a18mr3477103fac.17.1769608951598; 
 Wed, 28 Jan 2026 06:02:31 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4095749f332sm1751438fac.11.2026.01.28.06.02.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 06:02:31 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>, 
 Simon Glass <sjg@chromium.org>, Frank Wunderlich <linux@fw-web.de>
Cc: Frank Wunderlich <frank-w@public-files.de>, u-boot@lists.denx.de
In-Reply-To: <20260116182903.20652-1-linux@fw-web.de>
References: <20260116182903.20652-1-linux@fw-web.de>
Subject: Re: [PATCH v2] boot/fit: print name of config node not found
Message-Id: <176960895088.1640006.17553497455099655541.b4-ty@konsulko.com>
Date: Wed, 28 Jan 2026 08:02:30 -0600
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

On Fri, 16 Jan 2026 19:29:02 +0100, Frank Wunderlich wrote:

> Show name of configuration node which was not found.
> 
> current state gives no hint if fit image is wrong or the requested name.
> 
> Could not find configuration node
> load of <NULL> failed
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] boot/fit: print name of config node not found
      commit: 09cc6788683172a5588eca2cb7536a20a600faa9
-- 
Tom


