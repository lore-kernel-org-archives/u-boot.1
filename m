Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A2BD2A532
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 20:29:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF47B8414E;
	Thu,  4 Dec 2025 21:28:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eKFhl2V9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8978E84148; Thu,  4 Dec 2025 21:28:54 +0100 (CET)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BFE48414E
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 21:28:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-450ccefe6ffso841123b6e.1
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 12:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764880131; x=1765484931; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ppFX6LsHrWEEsoIrf7o0LzTit4zlyGroDCmNS1YCjRo=;
 b=eKFhl2V9op4i+V8kh/3DtecYGaiHnky5fU4uYpzVLnwk1HIj2eoD+mDyY5TUSWfk5X
 isMCj6ToD+qWFYODGZCJZCDhrwmGk1+8X2+J9DntYTZrW5vddWo3Z3Eb+E4Scmt6haH7
 USVnVnJNEeasmk1rylqToGvMYn5/Bynlnq5Bg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764880131; x=1765484931;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ppFX6LsHrWEEsoIrf7o0LzTit4zlyGroDCmNS1YCjRo=;
 b=QrX6lxh9ZdiylYRWYXWlCVuo9EInRGBv0mk6I8U4KASlTOuKsEdRQij3Ug3ER/qFE2
 Nd2AIcocJgjiJJospVXSMcKtaAwtEOA/D5Trz9kjwyqP+uRoGC81JenPpZEqCE/jyr2o
 OiC5R5RrZtHMI7ySwlaxnR6fEuo2WVioZsk1goQ6oJKh1TnfspDlFeAQ11LTVdOBzmGC
 RfrgiLa903IRhzttA6LsPSlslXsCd8MMu20jOvnv7nZH/FQPAxmnL2XJTU9yhbrMvkxS
 tjinSQ/QTChxgfka/oXw4vzWhJeiVslXSCWUwTyfJdNcg2g/pJu9Ooe/sjbb0yeJ50jA
 wf+Q==
X-Gm-Message-State: AOJu0YyPLHi7sn53Eecca3G12WYtrRiCSGTipvNTUUvp7ePLl+Y8lZBc
 oPX6Qd3PwcU/3MWBJCllpNT7oDkZIrULtmiqLDBBcQ1n5mTasc4HE1ndRntQ8yNqiNM7e3yEJ5Z
 D1ZP61QY=
X-Gm-Gg: ASbGncvgSJa/bQ8cWIUPGQsOGgux1u/2cG/Ogk4emAOZO6lsybyWDD3aQyjvhKXyMO7
 Nm6/VGX2DpUNGDutgZW5ESNKkZQwLFB8Nn6x8xYoAHAUpHLLlTzJDjg3GVZnSV4LMvwHr9Cq5pn
 aeVStDv1bhWs2GrdwACylquhptvSYXpLA8mCdY4PgEDsDh2E5jhvaIi7N4jd52rf4FVK4Vf68OC
 ApMLPB8nEt14NHPwW/W50tLkjhsOBfgkMA5ERQRshuq+DwTUP1XuNqmBE4WF/apLMXAQDNwrMNH
 aJAK39oEQX2aYmraCC73iF54glUkD9Q65oFV1hjHIcEGZEvpaEauWAYhM0brIrwkPbkudLDZtH4
 ZBD7kw9q7A/niPkpwk/wB7Q59xNPR6pbxEUbrYRKgmiKGC51+JbgbtXkQh5KTgHWxCtewfZLIye
 UOL4VDRJMxR80gkB2nWr/L98Ez6EVMBTtOtXJrcbOyLGfYkGZn
X-Google-Smtp-Source: AGHT+IFfOLyI8bvSuTAzhqWe2hPkB9Nm4EK9ivnUS5+5AAuXvTQTMTTWgzs+sJQimfgcQN2TPbcjww==
X-Received: by 2002:a05:6808:1209:b0:450:5e3a:6f16 with SMTP id
 5614622812f47-45378ee6decmr2927082b6e.27.1764880131132; 
 Thu, 04 Dec 2025 12:28:51 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95a8f8d0bsm2336131a34.5.2025.12.04.12.28.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 12:28:50 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Sean Anderson <seanga2@gmail.com>
Cc: Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
In-Reply-To: <20251203204640.1944971-1-seanga2@gmail.com>
References: <20251203204640.1944971-1-seanga2@gmail.com>
Subject: Re: [PATCH] test: strlcat: Fix SPDX license
Message-Id: <176488013026.2061624.14919211938439861394.b4-ty@konsulko.com>
Date: Thu, 04 Dec 2025 14:28:50 -0600
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

On Wed, 03 Dec 2025 15:46:40 -0500, Sean Anderson wrote:

> When I modified this code I meant to accept the LGPL offer to convert the
> license to GPL. However, while there is an LGPL 2.1, the next version of
> the GPL after 2.0 is 3.0. Fix the license version
> 
> 

Applied to u-boot/master, thanks!

[1/1] test: strlcat: Fix SPDX license
      commit: a0bf98cedbc6c1b8c32b0ce8e984386d3e5aa48f
-- 
Tom


