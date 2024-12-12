Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 745E7E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 19:18:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87F0780212;
	Thu, 12 Dec 2024 20:18:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="a0mTSznt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C56A80141; Thu, 12 Dec 2024 20:18:12 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D317801BE
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 20:18:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6dae1690c3cso7891936d6.2
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 11:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734031089; x=1734635889; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZboH4diSQzLRtPbCo33aCZn1AAXIUX1F6KzwLyxuyDk=;
 b=a0mTSzntO/POAgfuRBl3yoo3TBie9gtCkrwKxkStAS4+lLXITIRMErwkRbXTyPl1Fb
 IIg/LJjBJEBAwBSkHDN9rdkH7gH7WFpJydFLNlZAwHQKY4K5NZuqnf2FUorGM2kKqds8
 ZQ01adqALDGvpPUtKk732kxJJFlPaBGQkDt5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734031089; x=1734635889;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZboH4diSQzLRtPbCo33aCZn1AAXIUX1F6KzwLyxuyDk=;
 b=nAYBGwefX9swAaDpsDSCZNI5nsRhq9Xt638FyOajymSDX0X83ki+wr3BTd1IWmrtCc
 ImHBB3W6UPZQZTgreXec2xmrO9FUFqmNrO7bUfZTTXOj3ZDOLVYF/uv7XmCvW6bMxXrk
 bR0VqZ2AX0BTLPqHEUG2EFM7iBbUMDdXYu//LZdh/zsrSgyWP5LQrfWfUp+2km07Y9g5
 u5bGH1wFHL1UrX4noEM2vhAVVqKDSalJsyEsKXmYmRRO4m8YbVat4o9CsL38efTJVbUD
 Trqkx3gB92koGOIan/uLnDjECm4Be/fADwqnPxCsqhhQyKmhLLIclGuAoEwSpFDkIDZh
 dUaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+klONqi6YRDUfi76HDTijR1e8EA2QpunxqGm1yw1wLKXH4crbEe/a3LlSVcjkZVfUCOql0ME=@lists.denx.de
X-Gm-Message-State: AOJu0YzH6mlDXDj2WoCqUAx1criLCBYB9ae7VJY1UqCjR88QEbqCe68f
 eVJdonZR1yU5pKG/yrfyJiZtHZyOi/YZyWLCRc1EkYw2NUjdDifJ8W3NgHb4wNg=
X-Gm-Gg: ASbGnctGFww3QS+R4nNBAyg5H2vhx9cwVk4+RPMNuSd9qBvs8d+wfoG516AQnx5lbD2
 xXdppimGfWR7czXb5/Chfq1RkT3jpWDTLyi9anngBS4AHzJWFTqbocz/D053N8VJyZxJR8jaI+W
 58IE+y69sfCXpjCOlg0mRAud0E3hCCeto86EqOKTdD8RPvKa1HB+Kp8t4eW9CROZWtKhBmqlGy5
 PDx0X2yb5qPxBpJhCFsbJH9N217sMxXliHpWi115kV2GvKN3LICVT8=
X-Google-Smtp-Source: AGHT+IHVNuF13BY+6QPIYbqvZgQM0QDuEKErKWHQrHiYB7LgwzJBTkTcEW1uqbxpFFFh+5SGAlyZsA==
X-Received: by 2002:a05:6214:c28:b0:6d8:7a7d:1e6b with SMTP id
 6a1803df08f44-6db0f6f5810mr24857216d6.10.1734031089114; 
 Thu, 12 Dec 2024 11:18:09 -0800 (PST)
Received: from [127.0.1.1] ([187.144.29.192]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da6968b1sm84705546d6.39.2024.12.12.11.18.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 11:18:08 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
In-Reply-To: <20241211021703.2333-1-semen.protsenko@linaro.org>
References: <20241211021703.2333-1-semen.protsenko@linaro.org>
Subject: Re: [PATCH v2 0/2] lmb: Fix reserving the same region multiple times
Message-Id: <173403108750.1608151.9640420621091912803.b4-ty@konsulko.com>
Date: Thu, 12 Dec 2024 13:18:07 -0600
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

On Tue, 10 Dec 2024 20:17:00 -0600, Sam Protsenko wrote:

> This series is intended to be picked up for the v2025.01 release.
> 
> Since commit 1d9aa4a283da ("lmb: Fix the allocation of overlapping
> memory areas with !LMB_NONE") the lmb_add_region_flags() returns -1 when
> the caller tries to add the already existing region with !LMB_NONE
> flags (it was returning 0 before that patch). That causes
> boot_fdt_reserve_region() function to print erroneous error messages
> when it's called consequently more than one time.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


