Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBAEEC4707B
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 14:05:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C0398796A;
	Thu, 18 Jan 2024 15:05:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Az46sS4E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E887787B9C; Thu, 18 Jan 2024 15:05:18 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAF3A8798D
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 15:05:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-68176e698e3so16069276d6.1
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 06:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705586715; x=1706191515; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nxeVTM8VlArGthh1KcluEDmAD1UGtaDHD5KltV/h07c=;
 b=Az46sS4EInFv7EOosZ8AQf+GmrVN73i2IdMqWZdn6DPighhRDJFuSSHRq2IqXbOfjU
 AZKOQE/uk83ZBAAjXtDFxkVeX7+HadUu05oB5jU54iDQhnQAOb4KpMAvkyihviYogtBZ
 B53X5tRrb0FPOghmA8DPG3WMBvme86mfGHzi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705586715; x=1706191515;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nxeVTM8VlArGthh1KcluEDmAD1UGtaDHD5KltV/h07c=;
 b=vnznGrAKuabTVwG7MKxM86NBFexlR/fq95K3SfNSepixpJInqxYtbYDS0co4PFI1mT
 KwGtXOYuHf9RRsNblQ8zZuPZXHJF8qWHDqNLgxsteSjW15tyAuNu6wyM1+G2vGjKxY6u
 5Y/zN/aoLKprje2wIN4sWTVKII90nDxJ6AZnCorQPG+sTcjHed5Y/Qo+gXRX9eUnTBFo
 BH3CkCOZyzMg3ssV5io796azYXa+/U7B4eb0APUv2YJPabtF2t33zCWmy9RUVoRBIiHh
 oSSJUBe5AXXOdBpCGjqtGEmsLVJP5oQ+Fr4AKnK95NKn5A0DSLWhbWcOIQTEe97NSuyL
 hpMQ==
X-Gm-Message-State: AOJu0YztvG7/YvH//RhQopCgsxxmTslZSy1ETZvXfvIiC7lOF0s8U9V5
 uJdr8W8vwtplPmqRhGZJnXItgpY0Q7tRYvcw2Z+1vcGQqjGA2SZhuGp9bxuCu8HEHJfKGOwVzqP
 B
X-Google-Smtp-Source: AGHT+IGGlZ1C0UEDETkpU85aqBBfvb8lIpdQvUltN6QDkFObedRsogWmQaB1TWTdN4JTy+VmwRP4bw==
X-Received: by 2002:ad4:5761:0:b0:681:35b:fea4 with SMTP id
 r1-20020ad45761000000b00681035bfea4mr838231qvx.41.1705586715236; 
 Thu, 18 Jan 2024 06:05:15 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 mm21-20020a0562145e9500b006817fd532absm1246316qvb.82.2024.01.18.06.05.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 06:05:14 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20240117200450.1880105-1-trini@konsulko.com>
References: <20240117200450.1880105-1-trini@konsulko.com>
Subject: Re: [PATCH] CI: Move to latest Ubuntu "Jammy" tag
Message-Id: <170558671465.2400148.16691988181112646574.b4-ty@konsulko.com>
Date: Thu, 18 Jan 2024 09:05:14 -0500
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

On Wed, 17 Jan 2024 15:04:50 -0500, Tom Rini wrote:

> Move to the latest "Jammy" tag from Ubuntu.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


