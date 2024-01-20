Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E015C47DB7
	for <u-boot@archiver.kernel.org>; Sat, 20 Jan 2024 13:40:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 179C587D25;
	Sat, 20 Jan 2024 14:40:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Gc0hAawR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E993587D4C; Sat, 20 Jan 2024 14:40:49 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C057587AEC
 for <u-boot@lists.denx.de>; Sat, 20 Jan 2024 14:40:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5ffb528dc8dso1465247b3.1
 for <u-boot@lists.denx.de>; Sat, 20 Jan 2024 05:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705758046; x=1706362846; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=INj3ekiAExwqZkWVkLE5woDww0P6A6RlRP+PdIZb7Hc=;
 b=Gc0hAawR4+hOVL+Rw+G6WuivXMHTmrV0ShpdKAZ+KGgEGFPiQSAffj0rYMqp6etmIb
 R1x+wBHTo8IJlUjWQIWgUuzQhKiIJS9XyYqpGKDPTHE8XvQspiysONKEkfyQuZxtK3yc
 oz5SPxTuK3ddQylEEhwWjqKEbcTBIDKO5nVmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705758046; x=1706362846;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=INj3ekiAExwqZkWVkLE5woDww0P6A6RlRP+PdIZb7Hc=;
 b=SIGjQydpNkIOgXy6Lcvm9KbUPrkVjUFJgCeqC67auQDWiuak+tmjRnByj786IlJWPA
 rqnwgGve+JlONs+snpeWKpyAsTnWlc3UC1T+/w+DcIZfmiqf8kWag4d/bjiDpK1bSFcA
 emyYyF+ag4M1bIdcc26PKpGmFFm2ws5LjDHU3kKKI/XIrpSMO0vGxkCU2sactvh/yXx+
 6V8PeW9b5R4SN5or1+U89WhtkSbYfSbdacxuuNd9Xbwzg3h4sO0C8cJjcB4j2NC39EyU
 rp3Gr1TnFMnGOgy5CcHbOATpRFgKbt06r3MTAF6x/AQXUgVOgmRlakEE6ottpHHRRBjQ
 myFQ==
X-Gm-Message-State: AOJu0YyF6aGZAa/CS/Y6VOYeodT7B+mHdIxvcbwlgpF7H4vnqqbg+56p
 2zV+SK0AzYtayNHi36LqQ4c2g+Ue+ghWrGYfGeWfLDCJCW97u5bUoaG1KNOAYEEEktQPjt3Vh7F
 o
X-Google-Smtp-Source: AGHT+IF5lb4AOe7MrhjQkSxjEz5dAZFYheAdq/gRWH94TmLLwNINflXE2d2hf6DNU4+h6VnYFjSEog==
X-Received: by 2002:a0d:cac6:0:b0:5ff:828b:c97d with SMTP id
 m189-20020a0dcac6000000b005ff828bc97dmr1067530ywd.11.1705758046273; 
 Sat, 20 Jan 2024 05:40:46 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-3119-0000-0000-0000-1004.res6.spectrum.com.
 [2603:6081:7b00:3119::1004]) by smtp.gmail.com with ESMTPSA id
 h184-20020a0dc5c1000000b005d8ce4ca469sm8201181ywd.99.2024.01.20.05.40.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jan 2024 05:40:45 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Shantur Rathore <i@shantur.com>
Cc: Eddie James <eajames@linux.ibm.com>, Simon Glass <sjg@chromium.org>
In-Reply-To: <20231223065159.580100-1-i@shantur.com>
References: <20231223065159.580100-1-i@shantur.com>
Subject: Re: [PATCH v1] Kconfig: boot: Imply BOOTSTD_DEFAULT when
 BOOTSTD_FULL=y
Message-Id: <170575804551.3568869.10443787000920150255.b4-ty@konsulko.com>
Date: Sat, 20 Jan 2024 08:40:45 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
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

On Sat, 23 Dec 2023 06:51:59 +0000, Shantur Rathore wrote:

> We need BOOTSTD_DEFAULT when BOOTSTD_FULL is selected.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


