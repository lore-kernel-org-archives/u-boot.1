Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 972D1E77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 21:43:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E96C80291;
	Thu, 19 Dec 2024 22:43:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fDblEeXn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 159AA8021D; Thu, 19 Dec 2024 22:43:23 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA5D880196
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 22:43:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6d8f65ef5abso10121966d6.3
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 13:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734644600; x=1735249400; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R5V2rDd7yD7mj/crK0u4H3jiXG6pFx4AHEeyIiIeDvw=;
 b=fDblEeXn/W0dcfxhI3KXB56VxHhCEXl223Alt16YDUBB41tjuih1iZQeC6fDhKbHw+
 i9xNU58Yq/6oYrT/bu6L+4Pcs2wpFBRhmCdiODNjnWUoz0XHZ4HthXH08M50G33nux+/
 TnwqAWsOr/CuDGfwp3aGGXcfctlSF9byXbnV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734644600; x=1735249400;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R5V2rDd7yD7mj/crK0u4H3jiXG6pFx4AHEeyIiIeDvw=;
 b=ANKIE/3k68L1QHJDZ+N9AgNj5UfbGU89jAz4TkOSqR01YId1+mAZcZC/2xWJ3QsBPG
 aCVgXjxWg3li460wvtiylYPYTGidOSieGVHlpThpB1hLrj0PpIQAOll5TZTLpE+kP94e
 OphxmKSDJRuQCLXBpTa916I/KDSCbJlk9NlqpusxAroMb7+y0jyrkLIjpcGU2xwcPEP7
 iXmzpNebONDWVuMPPx4FPBZ9OLxVkLvpwRbaKwt22ouzDI1dEiZJQ5MkYkaVJGwVq4CS
 ju1f785P5CLOLnQECR6Bkfb9/W2KIYrbeIjxbL4pHBSZULunlcwCXF75usbweW9RGsGw
 v6lQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0+NgznttbW8tkvSJwF5mwUYi/N8T8GMZKe6paCDmAJkdZ17Qz8EJVD9+zxGqIdu5wr+FmNss=@lists.denx.de
X-Gm-Message-State: AOJu0YwxJKyRY7YaBiz4tzTLAcv9PqHNY6cYFflrkYUyzWUeD4hkqJQm
 1h3ri3FDjkGWAeyw8gGan+PYzIAqrP/3iuvMgf/d9DoCpGX/opXXjGmslHo9aW0=
X-Gm-Gg: ASbGncsTRqOleHXFfNcx5HVxp3Wh3F6YcDPj5mjMVt1hjLhQRM8K5CWdnhAWvLgKaT7
 cRSD293xlEAEioBaiYH7/885O1YBAVUJGRipAUs3BQGjgfhVrMLu+SHyLjrQeYCQ03K4UcWG0CR
 fEEtfGUn1+L/RNOHRSOJK8UQl1YVrrplNcqR94shSs61Vq6wq3HCCAcfiW1a8aid37m5he+1i0K
 T9C0PPqoEPd2vYgZE/hCNH/AQ3WQv6ttUopeeyf6OD5ADcVvO/MOig=
X-Google-Smtp-Source: AGHT+IHPXwBWcqXbQ3EC86URbcY7LuiZcE1JsiY88sYIPoaSn6SipV3I0ncX/6sK+9kYnG40sz6Jag==
X-Received: by 2002:a05:6214:4302:b0:6d4:215d:91b9 with SMTP id
 6a1803df08f44-6dd23338c83mr9880336d6.11.1734644599765; 
 Thu, 19 Dec 2024 13:43:19 -0800 (PST)
Received: from [127.0.1.1] ([187.144.29.192]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd180ea824sm10410196d6.4.2024.12.19.13.43.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 13:43:17 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
In-Reply-To: <20241205193254.25807-1-heinrich.schuchardt@canonical.com>
References: <20241205193254.25807-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] net: lwip: do not return CMD_RET_USAGE if no interface
Message-Id: <173464459670.3661439.13658406548179011499.b4-ty@konsulko.com>
Date: Thu, 19 Dec 2024 15:43:16 -0600
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

On Thu, 05 Dec 2024 20:32:53 +0100, Heinrich Schuchardt wrote:

> If the dns command cannot find a network interface, we should return
> CMD_RETFAIURE and not -1 (CMD_RET_USAGE).
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


