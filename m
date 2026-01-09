Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59225D26D89
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 18:24:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1323843B7;
	Fri,  9 Jan 2026 19:24:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YwTnB06P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24C068436C; Fri,  9 Jan 2026 19:24:26 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D430084399
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 19:24:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-4557e6303a5so1481976b6e.3
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 10:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767983062; x=1768587862; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=feieah9j519YghnxPjtiX9zp8FET3b1AtPxQ1EKj+xk=;
 b=YwTnB06Pq04AfJ2j4NAkccSwjxnfaIWhD3byOZ+1TCpI4F/ZIVX1ql46VjV7UDK1NU
 kOzgLBgfsy9KMjjeOCkaxJbsaWdwwkSzKDC7KBzgag9JM7dj/8AlPB/9JceXHqEfgrT6
 4PmOnrmOzQsbc8/boQ+jEUayvWArNSQzVkm/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767983062; x=1768587862;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=feieah9j519YghnxPjtiX9zp8FET3b1AtPxQ1EKj+xk=;
 b=F+XHBOqvy30L+095Ok2mvtx1FS23J9OrK0xapqWLd7SN/mYsDaS9xfLNnQNchWwvhd
 1A8VP+5NSvRf0uXJzfotqX3kZOJYFKDlGv2UUov3g4fXFATbKmRGeyYcA83AGMPNotUJ
 RHNWVdIL77CDJ7kK99bMMpG/AmFu9vddVeYiIkIE9pGeDqz3+inzdFZZxYM8Vb9ivpLF
 F9hCjP+wEMoG8iHJsHnF8U8RkQleiQDMuGBfhwozWgK8I0tl+7y2zMprmz2R93d3tjMw
 cuH0GlFAlDZ+xuEQn4VCBUeWVPpqWlLKCsTsOt8c06/tEhoxN5cwf/h+fIn6/MoohB82
 3Krg==
X-Gm-Message-State: AOJu0YxWmEuGuHW0wDmln7wHftCNaJi7eQXbK03k1jsfhxJGHHpC0WW8
 4ykvCQjaeUIDV7Lj4Cy5jZe4SBnuBie6f7kdqYngXGl7j5hNeIV5bYCtQ7xh06IA7CdNen+ZG/m
 muXX22Dw=
X-Gm-Gg: AY/fxX47U4zP7/rHGZint4Yuk7DHgJc4Rfn5p6mdHRytRodCcj/+u6nYfvsiAOqq3qR
 fQau7XPh3ChuucENgM87SA83WYrTuy7QlmvKQpIsOuZmvBRNFgDRZkZsStfDTstlb5qg/S/hIxV
 OVYCrADoenaI1YDz6pZxEV7PXRuspe3uTjZ9Afai45+ODd8VnnUvmDisXIFUOb1SLD0dA550dTM
 GqRoUmJzr30Cx5c0REtF+hrqUSvB2GP4dJ6/VHGkeScxEYrdWeITdbStZi5oxiYQSbbIWZ4qMnp
 yFBc6n6jL4STGYUZt+8YF/5HA/FXNuuGg4jK8yA4AREYFeDYvcNsqKBuaGEsSt9A+eNY143giTl
 0ymOtfSrWr6k1TQP4tD1v6fzQEbQHCqnm4FBZZOrl6LaQG6Vq40PaF/178rEpi6/9sOLKMuAUZd
 0W+ivvrb+/RGEgQ4ktoPPBjsRKBJAYfDmbtLjIW7SG1Qeb1RXTgJX8SDJgUoXKmiCw5D9OK+5Q5
 og/tSA2QIWRjqr8UT/UBiDhsTP/WmJXjCsO7g==
X-Google-Smtp-Source: AGHT+IGy2UGmVn+5Y4yPm3sz7hU1uguwZD6yZBWnWTkNkf/ZPbabY5Z1F/8R4p4ApwBPyO3lgC58xg==
X-Received: by 2002:a05:6808:10ce:b0:441:cf96:934f with SMTP id
 5614622812f47-45a6be8b641mr4750512b6e.47.1767983062593; 
 Fri, 09 Jan 2026 10:24:22 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ffa507235fsm7687647fac.13.2026.01.09.10.24.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jan 2026 10:24:22 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20251225161431.1224448-1-trini@konsulko.com>
References: <20251225161431.1224448-1-trini@konsulko.com>
Subject: Re: [PATCH] Gitlab CI: Add BeagleBone Black to sage lab
Message-Id: <176798306185.1453020.17046100177842086672.b4-ty@konsulko.com>
Date: Fri, 09 Jan 2026 12:24:21 -0600
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

On Thu, 25 Dec 2025 10:14:31 -0600, Tom Rini wrote:

> This adds support for a BeagleBone Black platform to the sage lab. We
> test with both the legacy network stack and lwIP.
> 
> 

Applied to u-boot/master, thanks!

[1/1] Gitlab CI: Add BeagleBone Black to sage lab
      commit: cf51247c632fe6f1f6c29a6f7754b99915182142
-- 
Tom


