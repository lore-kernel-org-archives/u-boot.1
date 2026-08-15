Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD05C5AD5A
	for <u-boot@archiver.kernel.org>; Sat, 15 Aug 2026 14:44:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9194D6066B;
	Sat, 15 Aug 2026 14:44:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OB_guvdeH7LS; Sat, 15 Aug 2026 14:44:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 71B1C60661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786805041;
	bh=gO2N9EzByxDCtlNgkRAT+G9cVqdfwFieN3vHk8acUlY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hiZbbwxIrZGQQarqrGuISyn0R+fd9kexKbl9UaB5dDPJ1Mbx5g1pcv6QugRI+76oT
	 I6U7InlNtFf6wLv9/R1Bn3CYNpQ/EGJTdBlqg0nz6J7nGZuejj9E2bmfkHxyAIpWHz
	 1jk2m66hm33m5liot5wF8CT4Q3TJrE7DXHTCVES+4mRXWTRot8QAzsBv9pv+3nFKwI
	 agpwUWPnNFc5HHcyplr1OJcDzhAHx9AdZZFwXKG2CZALNW5l9DEny787CYiKAcCMbT
	 jyz/4eZjixIYePxfsHGhAXMIqVu7vJxoSnNhiaq7vX2spG+Ws+c92IATqVLRTC2EKA
	 EJqdF4YpkoruQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 71B1C60661;
	Sat, 15 Aug 2026 14:44:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 951EE4CD
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 14:44:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7B19B4004D
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 14:44:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 62vdKKM7Vg_T for <u-boot@lists.u-boot-project.org>;
 Sat, 15 Aug 2026 14:44:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::335; helo=mail-ot1-x335.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C430A40026
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C430A40026
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=bGoQWEJN
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C430A40026
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 14:43:59 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7eb64371a2aso1317702a34.0
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 07:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786805038; x=1787409838;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gO2N9EzByxDCtlNgkRAT+G9cVqdfwFieN3vHk8acUlY=;
 b=bGoQWEJNoZLLrXs6ZjQJWhR98oBTpzyesD9pre0KDnMxS5vLAgCZrTbR4gdySDrElk
 RoyzjelxV9inPuVEHpYxc7FuYm+rgQ8bUU4vhY0v3aKCFhpLN4wHHEH7VLVj5HsaIviu
 KfDzS4CsXkO+t1eivB5eMBDXbUz0YjlQRj+SE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786805038; x=1787409838;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gO2N9EzByxDCtlNgkRAT+G9cVqdfwFieN3vHk8acUlY=;
 b=Ula9+LAN9fBJ/zXjQIWdJQuT7Eo2qAdCbrmvfJ8FS7zgFaR932QyXluEoI9KAhO3lL
 sRvwALo3a7JOrX6EZDoZQK3qxpUmeo0DaUHNit59guflEdvtnISTEE3CR8TegPcMiIVD
 ZsaAHeYE8d/z/nPKEj64PLJz6YTEziXjw2huksyvUX6KBUGfP7/AMBbQ3lLIah7eIQVC
 wbLLYdFJOq+Wl5iJI1cTSLyvcRUzk16zNEzJHMs2jomCaY/Ht4aFYtBr8nkj6Xp+fOQA
 22uVsmkD7QPX5CRLL85KxhQNcLJ/lfBT4U2nWkYRPG7RnKkd1RYpcv7sDKtaqh2rTaf2
 Q/ow==
X-Gm-Message-State: AOJu0Yyy5H+bg0t21WnlWUJpt9Sv0GgOCGFMwBrMp/lfxwBD9QCRios2
 +Fhau2Bl/qnsexGPWLmdExkjh7x6bc349Efr9iPe9xQIxaI303EU2wI/vvxFWKq0HdHSgh+DLA1
 BX2wryxY=
X-Gm-Gg: AR+sD12cjPkkpGk2uootMbu+zcgO3wPJLGzAPYmqaqKWCe7veSeyEu65NwvNtLOyHJq
 5pKAl1xrWYaoy7eh96eHSVeI2qvsjmQzKaj+xnHREI/YZD9qE9/JajQAUQ1WpVEhwzmw7H2mK6x
 klnw5sciJsTINg6CD8f6rj0UKqmXmQuqEy4j1ABBtKC3cZbfWeiIUVoeHii75hkiXKw5tmjDiPN
 lV88JUR71/GWM9UKfkbd2jQ/5OS7JyZ0qiJDTwzmz/l+Zp/Y35sACklml2lc2PPfelQDnDrQ9e4
 nyz5nstvGGftX1qqSN49Bls5OTjDC7Vg+cB4Kv/h5hgx3zWNqMC3GNXCtWTP62d8OENjU7U7vws
 RQvIpgZdEUv6+HJk2aJslso36pSJddh4ocT9CWJJx8mJ19HeMJlgjLSYG4hDg9xQbPB0u4otowG
 FUkjE1Z4RfNvROb0ks0k7o7EVdRXKS/vC1aBIy9AdhQeMxxj+RW5tqRsWeeWdNPtZy7Fz/Rrf9v
 doGcjcng45Zu87A7LdYkogCNmwMGQxV67u94X0pc7mNs6SYOP+utgOTchJo/KKImdeh/SNurZGY
 2P5qQUsY
X-Received: by 2002:a05:6830:81c5:b0:7e7:9493:dc3e with SMTP id
 46e09a7af769-7f3de33db9dmr14032557a34.3.1786805038539; 
 Sat, 15 Aug 2026 07:43:58 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f3e8664d67sm3837957a34.19.2026.08.15.07.43.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 07:43:57 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.u-boot-project.org, franz.schnyder@toradex.com, 
 frieder.schrempf@kontron.de, mehmet.fide@screeningeagle.com, 
 stefan.eichenberger@toradex.com, S4210155@student.rmit.edu.au
In-Reply-To: <20260814220723.1677460-1-festevam@gmail.com>
References: <20260814220723.1677460-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-next-20260807
Message-Id: <178680503732.4093225.6236055400850087252.b4-ty@konsulko.com>
Date: Sat, 15 Aug 2026 08:43:57 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Fri, 14 Aug 2026 19:07:23 -0300, Fabio Estevam wrote:

> Please pull from u-boot-imx/next, thanks.
> 
> The following changes since commit d3e8597e46b635ec556a057bc42f0b0859654bdf:
> 
>   pytest: fix out of bounds access to bad_pattern_ids (2026-08-13 22:14:05 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


