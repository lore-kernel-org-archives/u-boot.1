Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23960C0219E
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 07:54:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3156800CF;
	Tue, 11 Feb 2025 08:54:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ypx/JWpN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63D578033D; Tue, 11 Feb 2025 08:54:14 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B5D180079
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 08:54:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43955067383so1283945e9.0
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 23:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739260452; x=1739865252;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CDM1tbtYSvhWJw/5Ienrha+b7FbtYp5kdybQ/GdDzj4=;
 b=Ypx/JWpNuR86OjkOHO2Q5t+pAJ3GLN6tYZ6nn8SSoKjoreJjFv/F3+K4ea1ow+Xn6V
 y83ERY3nYu0zwkraqP81clnGe9ZDlCEPauw1iw/I7QsHTzPVfk8mVrqtwgCoaNqNiAE/
 Dl/i4X1nZB8LRyQTFHio2+nzUDJCy57zRMvQXdFa2NMe08AwXCi/9PnTuHNtDFL/JVAa
 2NRzrbhlN0nJ0WzHl+Saw9k5WQlAfwL5gFH72nTtpyIn7CWVyiI1YwF3AfRi+yLzPSuN
 ZR26ODf8PQS9A4FPzfjK7BOs1Z0Rzas6NQWZADiGSVt4s/o0LIXV/OoVuYWMn2uyxErt
 QXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739260452; x=1739865252;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CDM1tbtYSvhWJw/5Ienrha+b7FbtYp5kdybQ/GdDzj4=;
 b=NgnJ84KICXTCNxccqR2CAUKXs7cW/21cczMEcLgngU1HQJqD472UwvirxUNo9DZhJu
 votPrchv6OHuoQfzfiKy3LpfKTr8tKOeCL8tWLuMWIqkCxXwgyvYNUMQWA4jel3hmdL2
 C6ULpg/za2k/CyQMphiICRfO2Gx2VC99SiS2hX9QKxaBIXgNP6+TMH2zBZhi3m5zbM/8
 cW/83acBFJenEFmksJcfpTU+xXyAGer1nLA2iSXoVehNexxD3tMgxQTroOVKu+cDRZv9
 uS58NFkJz8FBXNnJVDV4diZSyeu/tjM3DszSTGDMtKwV0JEHsHz8Ew3qXgD43BMYHUyw
 zR9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNl1lQxsarceREVpccQ25Rsa+Nskz7Ili2kqotTIzOeXfiakq9DRFrlqTRivnNlK7IP2acqCc=@lists.denx.de
X-Gm-Message-State: AOJu0YwCgQy9yVUDGX0LKWsxP4G2X3+1NRtsPgoH4KRwr1Zz9YWENmbp
 lNaonZ28uIip7iNXI39MLuyL2qAAC4c4F7F3zaeimHbIgyWQ/TFIoq+ZG2rdvsM=
X-Gm-Gg: ASbGncsu72kuS5E0XYjQZh/j51gBBjlux6dK6hZcZ4k2PmOjLriS71B1j7oTIQ7c0ZI
 m49h5hgDD+goP/Q6Z9Mh/mwVwI1rjHm9EUQfeob30IBqORfaqnrduwAfEg/2vCzmL3GrP/+k81y
 ruo2zjWfmhrrWyb5/RFQ6/XSk3xpQlRyrGAjNEEIcPIo4NAlr5zphZE+Jkf/c7i3+YNulK4LQeD
 TDrTI1d8HY6JO8gG+PTprCMEKoxSP2WvRSct2p1f6H83hITHUbWpNGc68D5oNRPgFZw7SFiUBM5
 A3mNBCZL+iQXfyJszVZAi5n5
X-Google-Smtp-Source: AGHT+IHZ1rj3Yu/j9Zl6NAfBazJhcxRMAgIa2qMsUfFucICk7f3ARXiQqqHc22Nawq6/YCjwWAodRw==
X-Received: by 2002:a05:600c:4e8b:b0:436:1b08:4c78 with SMTP id
 5b1f17b1804b1-4394c8693d0mr26991955e9.31.1739260451566; 
 Mon, 10 Feb 2025 23:54:11 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391dfc8897sm165711145e9.31.2025.02.10.23.54.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 23:54:11 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marex@denx.de>, Patrice CHOTARD
 <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Cc: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Lukasz Majewski <lukma@denx.de>, Neil
 Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2] usb: gadget: f_mass_storage: Add schedule() in
 sleep_thread()
In-Reply-To: <f1d2068c-b393-4b90-b923-aa51b0972dc3@denx.de>
References: <20241202074644.5380-1-patrice.chotard@foss.st.com>
 <87zfldnlmw.fsf@baylibre.com>
 <c89e94bf-0ed6-4b3f-9f3b-eee9d30a91df@foss.st.com>
 <f1d2068c-b393-4b90-b923-aa51b0972dc3@denx.de>
Date: Tue, 11 Feb 2025 08:54:10 +0100
Message-ID: <87lduc6hnh.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On lun., f=C3=A9vr. 10, 2025 at 14:42, Marek Vasut <marex@denx.de> wrote:

> On 2/10/25 11:28 AM, Patrice CHOTARD wrote:
>> Hi Marek
>
> Hi,
>
>> Any chance to get this patch merged in next U-Boot tag 2025.04-rc2 ?
> Gadget stuff is on Mattijs desk, please ping me in a few days if he=20
> doesn't pick it up, I'll do so then. Sorry for the delay.

Somehow, this was not assigned to me on patchwork, so I missed this.
Sorry about the delay, will pick up today.
