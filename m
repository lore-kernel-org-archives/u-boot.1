Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08AE1C83F1A
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 22:42:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 512B483768;
	Fri, 11 Jul 2025 00:42:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="P+5Wlq3E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EC2283738; Fri, 11 Jul 2025 00:42:04 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8042E8362C
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 00:42:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-611b246727cso694421eaf.0
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 15:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752187319; x=1752792119; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JMM7/hP/8EtmWLNqFCoKJqRGunYoe1PQoSHCflWf/PA=;
 b=P+5Wlq3EvnmphxZqG9m+1oITMM+8dwY/WLtrjWO/uMovYCMEfxynsh3V4lU5r+P4N2
 foUaIfvPDz9MskBvkXzkLkBfHtFRGzAEl+4v4DlkUc7RTziOd74CUyf4goN9O66ifBzb
 YQv3QZ1PrEfKAcNVT7nXhX1QfAuEvchvI1mkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752187319; x=1752792119;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JMM7/hP/8EtmWLNqFCoKJqRGunYoe1PQoSHCflWf/PA=;
 b=LhzrCJdEmzruSqBe5FGMdWZWtcseKD/kEgSCi7Mw9dMFLNZAgJRcDqcirihrwk2V4W
 HoC/T+yraH3qKg48XCHYIMDRd1EiZI7WfrVFCtCH7WTxocP7M463IQWJCQ+4oftkGVir
 GQmNQ6Zrd1ITSyHchi2WxSppQWUd9rhYxS2ls97BIS6x7j/xwavEOSFBYRV3YIi34VB1
 ChzlewghevZreHYbsrIhxDJgySYVn2uVeltIrtBbk7H9uJEXn5XZD8Gg+Qa59Sfq3f8O
 lkLP5OLvNFW/ny7CFp6iFnuOp2hwGiOOlF8BEaeEWJD07qv391f/SNlUTMrrdGzwNSmx
 Wnjg==
X-Gm-Message-State: AOJu0YxO6NH29YCTEnU61IGSgoLCsh0JFW3DF3ts31pLRbajG8O4pOiM
 4pKZMQ2U5poOXhUREsozxrJr3ZzpQSU+nXEXERgfch4ZLe0yDhZQwV/tEUSlytJCQBHi9zcuYAS
 Skye31ns=
X-Gm-Gg: ASbGncs4w3jgX9V6CWF8uyPrVmkXrJxBRdjWi0ccJHGdL5R+nAeAp+Il/wp9pxaFWxt
 iAv4vSzeRo3DJ2cnIk+NHcgvBuyrjYc2ND4EocSQddZEIKTO8Vq14vTynq4wP2L7x7s2LZjjwFi
 MmD2IoHh37YN4snJ4NzG0DY9ilRUUYdPgNeun81rdABnxofuh2JGUxhZzVaenY2xcRT2sCyWi1Q
 rSst5vxuM6E5Ap2VXEseU3iRJMTr+4A5BBPr0xIXNnZQX7ac7eLDP5A3m4VVrl7eJq0NkYfd0oJ
 UI+RkazM15SJ+DA+0Uu/NG2U1YZAH4Gh4FKlAvDq8lIz0/1f8nW4uuxu8yQ3j+SXSCihN4mIURC
 LmzfhVsPiBrvTo+hnmZ6eivSLMR0BtlR+oKpiM9plTtTOO56GEX5yLGM=
X-Google-Smtp-Source: AGHT+IGUVx8SZN8eLuDMWyElUWhQ7gb2j9/VqEU/vG60Pq5UoQvo4B+9ryGyQOgv7K1zOhP8RoVCHw==
X-Received: by 2002:a05:6820:2710:b0:613:c9fe:516e with SMTP id
 006d021491bc7-613e5f8f80bmr656103eaf.4.1752187319276; 
 Thu, 10 Jul 2025 15:41:59 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf12b745fsm357354a34.64.2025.07.10.15.41.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 15:41:58 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250702010413.18852-1-trini@konsulko.com>
References: <20250702010413.18852-1-trini@konsulko.com>
Subject: Re: [PATCH] dma: ti: Tighten some dependencies for some ti platforms
Message-Id: <175218731852.2073260.11218828323761257141.b4-ty@konsulko.com>
Date: Thu, 10 Jul 2025 16:41:58 -0600
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

On Tue, 01 Jul 2025 19:04:13 -0600, Tom Rini wrote:

> The TI EDMA3 driver cannot build without platform specific headers being
> available. Express that requirement in Kconfig as well.
> 
> 

Applied to u-boot/master, thanks!

[1/1] dma: ti: Tighten some dependencies for some ti platforms
      commit: 0b4132900352feee38b492df8cf9b970a30f7195
-- 
Tom


