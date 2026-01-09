Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0868D26D9B
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 21:54:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CF8E843AD;
	Fri,  9 Jan 2026 22:54:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KsbG6AYZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B01F9843D4; Fri,  9 Jan 2026 22:01:00 +0100 (CET)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB9A3843AD
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 22:00:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=petr.vorel@gmail.com
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-47bdbc90dcaso34150055e9.1
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 13:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767992458; x=1768597258; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O2sLV7eTrr/RI9Ayewqo491c6WkHumteSOiKMD+gvzQ=;
 b=KsbG6AYZZW3qDMSpO6J1/kSTrZAtWNTNrwxZy7dNhOJ53aOgdVKCw3tma4EyFPASza
 LmnKp3vpQN/YBJWuVt1+oMQ39v3CU3mSBYvTiAEgx/ILEPVaZ0IeR8hT7pIrptUMbjkB
 1s3nfl4D7jw/P7H7tvc6pnO7NMrDs/EEL7HNGLR398p70d2bdK8iY37rq6Q/4sgnQKgB
 2Rciiso/NtguWM0oMeEZ5b3jHTIohruqcHr9fXETUnkPb7VdeWKRl2Hpt6VtQvQ7eLyw
 m6bu9maXH9V8Xw6fKJeA3yzL7XZPw393TrkFxpUyLY/RzFJJYyXpCZp1Yz0O7b+FYnW/
 rbwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767992458; x=1768597258;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O2sLV7eTrr/RI9Ayewqo491c6WkHumteSOiKMD+gvzQ=;
 b=DAvAv/pBc1pBH9EDT19HUYel9eLzjBhfkbWXU/TNs6k/bS8EdUGdZerfnFZ2EV5cwI
 XkLOc/dhjtzIdzDxiF1ujoNAUp1LSCtkLw3veMeyuBDUoSL2NnmaXmCX9/HGkru6W5sc
 C1LgI3eOUQjoerqoZ8LodkkYuYodn1WgSgvsL+XGM4Oha2ORnSrhzlqFtCaCy5P7KMya
 XKULr0+MwiGIVd/3WnwkaTcEKsvNVPcH9IBezl7MO4rJUQkOuyqp05Oo5HYK3IlXTY1E
 YoFKLmCCAeq05cz8ZyBAkcKd/85sxhaYkyDfOQZ1Lx3ARxxFFT3S/bgSt9QWAmSFoYt0
 z6cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyzVjhriNr8LCUdgxFu6EX2I2Suqqmwrcg2E22IWVDt+94JFk8UJ9oj8i5h3mSPL60PoJlZSQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxVUqVXzWG67zbWNmkwc69Bzp6zGPdHdkSw5PDxX/ns8T0XfXx6
 6O/o94HuXXDF1Qck75MhhTxMyZ+abdNmeGQZPA5BdNfYwrDyjnM7VMNc
X-Gm-Gg: AY/fxX7GkznbsBJy8DJpCdwcpe4Mv+ks2cB3KFshBb7qqVJTyEdc/Y9vZCVoBmqaa78
 Lg4RRgONp3prs1lSXJJCtMUP0/tAxbsJjczFIevDAqmKM729ZxhSmkK61pxBhClMbw/sc28W4Pd
 haEYR9M/tom8mVGeUePf2s5Znn9sUd4Ju+gH5YSayNFc++G5AgZHfL2ZPglmRwnwADKyk95rfmW
 RN0AdzLA11PqmL9ERaCKmQbI7Kzia/I5jF7FbAaxQ7MIwo8jmOFmhrEFnz8Pc9dPiwq9VtTTNbS
 HMHjBNmAN8rfOSPsGi2OmlvxYilEjW+jalgjbqXRzCSBpmwW28c4hP6XvT6QnetLZo+PfnTVLFe
 0oSqGb/onDHI4AgXe90jt8M4oMp7NoHqnO+sDpiElGQcNMq0w+d+G4lBj180Z2TYng1iOr2baXS
 vraH6bYoECjpYTJ6407bRpKNlt6m3TF6JvrXKnnTVeDQFp1A6eUrXOTWIup/8=
X-Google-Smtp-Source: AGHT+IGHy41VxlRGAuZXH3hnp8V07u3s1R1wo3tGv2LD+zHQ/INTIBK3oBkHW+TRKWjWDPCXXbq0Kg==
X-Received: by 2002:a05:600c:1e1c:b0:471:14af:c715 with SMTP id
 5b1f17b1804b1-47d84b0a8eamr110263865e9.3.1767992458045; 
 Fri, 09 Jan 2026 13:00:58 -0800 (PST)
Received: from pevik (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e175csm24012329f8f.14.2026.01.09.13.00.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jan 2026 13:00:57 -0800 (PST)
Date: Fri, 9 Jan 2026 22:00:54 +0100
From: Petr Vorel <petr.vorel@gmail.com>
To: david@ixit.cz
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Luca Weiss <luca.weiss@fairphone.com>, Simon Glass <sjg@chromium.org>,
 Petr Hodina <petr.hodina@protonmail.com>,
 Matthew Croughan <matt@croughan.sh>, phone-devel@vger.kernel.org,
 Simon Glass <simon.glass@canonical.com>
Subject: Re: [PATCH v4 1/2] doc: board: qualcomm: document Pixel 3 / 3 XL
 support
Message-ID: <20260109210054.GA140231@pevik>
References: <20260108-pixel-config-v4-0-76a2212b69a5@ixit.cz>
 <20260108-pixel-config-v4-1-76a2212b69a5@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108-pixel-config-v4-1-76a2212b69a5@ixit.cz>
X-Mailman-Approved-At: Fri, 09 Jan 2026 22:54:16 +0100
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
Reply-To: Petr Vorel <petr.vorel@gmail.com>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi all,

Reviewed-by: Petr Vorel <petr.vorel@gmail.com>

Hopefully we add other Pixels in the future.

Kind regards,
Petr
