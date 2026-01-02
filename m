Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA1EFA374F
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 15:12:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32D2C83A2B;
	Fri,  2 Jan 2026 16:12:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=forissier.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=forissier.org header.i=@forissier.org header.b="AnppJblf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FA1683A3D; Fri,  2 Jan 2026 16:12:45 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 535938399B
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 16:12:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=forissier.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome@forissier.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-42fb0fc5aa9so4986651f8f.1
 for <u-boot@lists.denx.de>; Fri, 02 Jan 2026 07:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=forissier.org; s=google; t=1767366763; x=1767971563; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RtxWkqbKc+fHoZt1W6zaC67cPyFCcGLyNrruO31BTt4=;
 b=AnppJblfDZGTKESVIh1zcavprJBAN1FCAauVxl6B/gsXLNgR0xlcT6pQrifMAEQvRV
 3riTEsvREKnqij23ZeG3sA3va4ODH1t3CLN2EYtjo/AnzrvPGUdUA9fwop4/Gqcm98zj
 IBT6HGdJKTWI0YZT2K8c2sZCxoWDLxG2iblG3V6nuUm+JoRoWSeYwOH09koiYizAIqqN
 m2ubPy/bB6ro9oIVhS/hMGPZKXbePCqRHgzKJrym5YDN8hMJnXLJ6Wyec8xNCOtxEs7H
 m7YJ9IzWpcT/3fylytDebOHdtF8EmXfeDIYLNTIfihpAy9TLaQOX+tNioMFjrSo9SYex
 RdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767366763; x=1767971563;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RtxWkqbKc+fHoZt1W6zaC67cPyFCcGLyNrruO31BTt4=;
 b=gDDjeq5R9uCtX7+IvDm1S6Gwqwxeq8s+IhBVorlwh37gcSMO0Ur4XWxIgyKcFmVd71
 y5Y11NOs4BzL8wpA7SlWeAYxiO66+yFYN050XnL2RRHLMADyhOnCDgvCdr0jfNskCFRd
 p5wjyWekOWN6ZwIksEmo6iB4h83ovmygLs6FB0Nf/R55zSQI/ueEUxriloksuXritOj/
 4wUHBKrRH4PUdc3yV4KxsQnGnfVHqIFyjC8dZIOPNoyDAn/ZrODYg6ttL6ZizbydjWgk
 qibApdBcL3GqwPmFgBbdX/blZ5h1TpDTfTIVRFB6oqNEsRFwcU6tbYInrtOsAF4wWpD4
 IFeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6MAomczf/sQB6XEsiB4hFLheid6m9+bVLjs9j4PYcUXz0FxauzmfLE5ICB4OquXDGsPRaGRc=@lists.denx.de
X-Gm-Message-State: AOJu0Yxw2BBz3pb62p4PF8NEImdPoFNA9UfTlieoSLeeDJcRj8S41sXi
 ylMer44nAlXQ2mVHgV6HJk7FG8+cy8Sr5/U43Qy2QORVelocIXyhkM1wiHQ5BqB070TwrNGXPKI
 6jbWulMM=
X-Gm-Gg: AY/fxX4o9v+OkZ0qCdurhFEH9OI7cq4EvExMrVrSulbsoNw5YJO/ISRS1ZLJlEMOQzp
 dqX85VahfTUP8o3sG8K6ppih+uixT9SVo8r/Cz+ExFOjB6ixgL7Lgw4Z7wP9Rdsq+vqFKGoHdeO
 8IrwEWT2wY02rkv0O/E8KSpYz5eQID9WhMbFvYnymiHR6CO8pOZTxz/BJnEWnlhGr3pXwWvv0g8
 8s9K6gpASGuvXm8nmhRT3+QknioMWScIpoEcQqEndg9Zh2maSw9fpFn6HpM+gcJb02AviHpAnog
 jkOVBj/tGczDiipjo/d/fmiieHDHx4ENiEDQFCDZsqIiZExr4IBLzfLSgR6TC7lPsVixbnFfZmw
 Y0SFIh6e2xR8qyFk1iPl2+B5zaZ8Dwv5SVmAMbKP4v4owysdU8RbpTD1bjEL2R0zAa0p3Rb8Koa
 8dYOR9chvoYQzMFa3D+TP0AB8KbCcgkOvcvVMsMtkTywc/04d8e6S4pshTs+ulsBmktlY=
X-Google-Smtp-Source: AGHT+IE7LqLf1DabWqhlcLwOx+3o/4skD1DLNTIPnwJ4TZ1qNbQzVrbzoTa2p6RcTevvzXHVITNVQA==
X-Received: by 2002:a5d:64e8:0:b0:42f:f627:3aa7 with SMTP id
 ffacd0b85a97d-4324e4cbc6emr44882332f8f.16.1767366762765; 
 Fri, 02 Jan 2026 07:12:42 -0800 (PST)
Received: from ?IPV6:2a01:e0a:98d:5340:ea5e:8e1b:d9b6:2093?
 ([2a01:e0a:98d:5340:ea5e:8e1b:d9b6:2093])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea830fesm86108785f8f.20.2026.01.02.07.12.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jan 2026 07:12:42 -0800 (PST)
Message-ID: <47b1c881-07c0-4b8a-a344-6ed09ecd926a@forissier.org>
Date: Fri, 2 Jan 2026 16:12:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: tftpput: Rework to exclude code from xPL phases
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20251225153721.1217202-1-trini@konsulko.com>
Content-Language: en-US
From: Jerome Forissier <jerome@forissier.org>
In-Reply-To: <20251225153721.1217202-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Tom,

On 12/25/25 16:37, Tom Rini wrote:
> Given how the support for CONFIG_CMD_TFTPPUT is woven through the
> support for the tftp protocol we currently end up including "put"
> support in xPL phases, if enabled. This in turn can lead to size
> overflow on those platforms as xPL tends to be constrained. To resolve
> this, use "CMD_TFTPPUT" in the code to check for both CONFIG_CMD_TFTPPUT
> being true and not being in an xPL build phase.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Jerome Forissier <jerome.forissier@arm.com>

From now on, and pending discussions with my new employer, I'd rather use
my personal email (jerome@forissier.org) for open source contributions.
I've sent a patch to update MAINTAINERS and .mailmap [1].

[1] https://lists.denx.de/pipermail/u-boot/2026-January/606610.html

> ---
>  net/tftp.c | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)

Reviewed-by: Jerome Forissier <jerome@forissier.org>

Thanks,
-- 
Jerome
