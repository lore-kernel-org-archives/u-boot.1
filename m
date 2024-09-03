Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F154CD37AA
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 19:43:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 914FF88B4B;
	Tue,  3 Sep 2024 21:43:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FMORrtRl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F37787C69; Tue,  3 Sep 2024 21:43:24 +0200 (CEST)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E99188C19
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 21:43:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-456768fb0a6so32918631cf.1
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 12:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725392600; x=1725997400; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuJrZRNNkRj4V0aWoAWmhcbmCvs6JavLNWRf6QfFJac=;
 b=FMORrtRl4UbVUyr5qJ90X6S7979BCzawv0ZIqejAX8yRDo5EoH/ZAB82VoNeaMuLSy
 HzJ/paUkVU/EiphZHK2XTs63nCCqoy5d03atT7Brad/tYyPEW8ldUbvkzB+79l6TiCAz
 SLmNaUc1pqJx+cNv0e6dJI/t778J7gm0NKEhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725392600; x=1725997400;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kuJrZRNNkRj4V0aWoAWmhcbmCvs6JavLNWRf6QfFJac=;
 b=fOEHGhTutqCHz1V0tS0eiVEz3gZO2YlzQGVJ1RBtsmMcTs2lTo+ooQJlBY5h5jC1A+
 5xdEAO5esWeWhx/8iDnhxMWKIyDzAJwBhgxlCKms4hRELtZgX6CEYPHsFPUIvUn+mhyH
 k8BnI6QZlzlZlqLXHM92iBPrij93+GFNJjy0CTr8AWFDz94+NtBCxWiQ4zMjIIcH1b3P
 1zpc8PqxMp1V4Q/74RzkTYD9DcK2+XA4kyXvCjnipj40IcqueXXMUe97hvH44LsYh/hU
 VpdxThWFpt4C1hb9S0NL/KRZ+OhdTk5KeUlmvaCNEp0ZwXG5Qox8SraQLJ8TBKPVzFJ0
 57/g==
X-Gm-Message-State: AOJu0YyzQKSbPViqEE223y4v0jpdLv4FF4qYftq6vyeb0CFVZR3/dPHk
 SN64GK5DRoOwBZMezU6fR8J1DLaiw80dKYVg47IzPNWfmE/jfnLyAtItVl8Vnf8=
X-Google-Smtp-Source: AGHT+IEN+o0yzBSeV6fO0rqXKR9MA3YdEBUxDAMFi932WNVsz/Xq09G8ZyG/d5/9qwICLaEVFyMzHQ==
X-Received: by 2002:a05:622a:1b03:b0:456:8575:c5cd with SMTP id
 d75a77b69052e-457e2dd1e96mr42001971cf.36.1725392600244; 
 Tue, 03 Sep 2024 12:43:20 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45682cd112dsm52942121cf.43.2024.09.03.12.43.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 12:43:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Philip Oberfichtner <pro@denx.de>
Cc: bmeng.cn@gmail.com, caleb.connolly@linaro.org, 
 christophe.roullier@foss.st.com, epsi@gmx.de, eugen.hristev@collabora.com, 
 festevam@gmail.com, forbidden405@outlook.com, ivprusov@salutedevices.com, 
 joe.hershberger@ni.com, jonas@kwiboo.se, kever.yang@rock-chips.com, 
 leyfoon.tan@starfivetech.com, marek.vasut+renesas@mailbox.org, 
 marjolaine.amate@odyssee-systemes.fr, neil.armstrong@linaro.org, 
 n-francis@ti.com, patrice.chotard@foss.st.com, patrick.delaunay@foss.st.com, 
 philipp.tomsich@vrull.eu, rfried.dev@gmail.com, seanga2@gmail.com, 
 sebastian.reichel@collabora.com, sebastien.szymanski@armadeus.com, 
 sjg@chromium.org, sumit.garg@linaro.org, xypron.glpk@gmx.de, marex@denx.de
In-Reply-To: <20240802092539.162892-1-pro@denx.de>
References: <20240802092539.162892-1-pro@denx.de>
Subject: Re: [PATCH v4 0/5] net: dwc_eth_qos: Add glue driver for Intel MAC
Message-Id: <172539259711.1596488.16115769818735670415.b4-ty@konsulko.com>
Date: Tue, 03 Sep 2024 13:43:17 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Fri, 02 Aug 2024 11:25:34 +0200, Philip Oberfichtner wrote:

> This patch series implements the dwc_eth_qos glue driver for Intel SOCs.
> Before doing that, a few general adaptions to the dwc_eth_qos.c main
> driver are required. Most notably, the preparation for PCI based driver
> instances, which do not necessarily use a device tree.
> 
> Changes in V4:
> 	- Fix printf format string
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


