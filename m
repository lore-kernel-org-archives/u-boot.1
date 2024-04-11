Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B33A5CD11C2
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 01:45:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8CD587B71;
	Thu, 11 Apr 2024 03:45:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lO4i7Q4G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81B5A8758B; Thu, 11 Apr 2024 03:45:25 +0200 (CEST)
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com
 [IPv6:2607:f8b0:4864:20::e2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 737B987D8E
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 03:45:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-479c96509e1so2354028137.1
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 18:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712799922; x=1713404722; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ht0JsZvmg3NQsdgrsB4D1g/pxyLfkRvaF7fY7ELhTFQ=;
 b=lO4i7Q4GZHsYB0RL5tq96SVHshLtmFiV7FUCGt+VzRKyR8TIUgoWQHwuRZ6NW7yzhG
 Brc7QX1lOFn+/Hgsr0AsBEaC/p5Efs8NGMXXoUL5vjHhPWvavPSUbly/qSJ+Lv27I67Q
 ccBeXq/wc6xjBNE5HifgMY2hyaluM8pLnyoMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712799922; x=1713404722;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ht0JsZvmg3NQsdgrsB4D1g/pxyLfkRvaF7fY7ELhTFQ=;
 b=EIGf+LVH7H35iOJsdc9S1p3gHo623T12/0EWl/UsSO+d0lays5Igak/VGwZ+QngzDS
 /xzVyvO3gzAvGRiFd8f0dFjMbjnsn0Pw3cOswjnSSKwveeRHHtHdAmgKPrHrSsAb95Fd
 ylsEl0nc59bMTbZlgd8oda3cINVywsJnY5PWjQof7yYUZmdDzWO6+T56yNQvsxjNoPVf
 8qJj93oQX/AuCiusWTVepQLXldnowbw2g9wa/5B6gm0qtZqFMjyvj49dMEPZMduMqxM5
 Y2X8kThh8kmi/+odCjPDitEITH1c5n2diJoXZI7XvTeWXM86Q6PVkIfOqCPoHlRMw8Ab
 L2Yg==
X-Gm-Message-State: AOJu0YxGRXnMfl7CK6pqdpBa9blLUqexSWemMYj8RClrSEL1SiYAPbzO
 QA63cdP89yjWkYan1RKgdRnQrbcDxfSjPwqE0KW747hMAC6THBn/FiF9/raGQJIhf1/wiVH+ESA
 UbjzUEA==
X-Google-Smtp-Source: AGHT+IH86hreF9sqvCYUtMZiGIoA0FVtpWplJD0GhNmNW+yX6Z0thoJGHvAVSsLRxBTCpHLhgSRuwQ==
X-Received: by 2002:a05:6102:a53:b0:47a:39d2:5274 with SMTP id
 i19-20020a0561020a5300b0047a39d25274mr62602vss.20.1712799921913; 
 Wed, 10 Apr 2024 18:45:21 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 c15-20020ac853cf000000b00434ec509ce9sm279162qtq.46.2024.04.10.18.45.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Apr 2024 18:45:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Alex Kiernan <alex.kiernan@gmail.com>, 
 Alexey Brodkin <abrodkin@synopsys.com>, 
 Alexey Brodkin <alexey.brodkin@synopsys.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Eddie James <eajames@linux.ibm.com>, Eric Nelson <eric@nelint.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Huan Wang <alison.wang@nxp.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Leo <ycliang@andestech.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Max Filippov <jcmvbkbc@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Peter Hoyes <peter.hoyes@arm.com>, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Rick Chen <rick@andestech.com>, 
 Sean Anderson <sean.anderson@seco.com>, 
 Sean Edmond <seanedmond@microsoft.com>, 
 Shiji Yang <yangshiji66@outlook.com>, Soeren Moch <smoch@web.de>, 
 Thomas Chou <thomas@wytron.com.tw>, 
 Thomas Mittelstaedt <thomas.mittelstaedt@de.bosch.com>, 
 Tobias Waldekranz <tobias@waldekranz.com>, 
 Yu Chien Peter Lin <peterlin@andestech.com>, uboot-snps-arc@synopsys.com
In-Reply-To: <20231215041919.2197788-1-sjg@chromium.org>
References: <20231215041919.2197788-1-sjg@chromium.org>
Subject: Re: [PATCH v2 00/16] pxe: Allow extlinux booting without CMDLINE
 enabled
Message-Id: <171279991820.196936.155872099351797064.b4-ty@konsulko.com>
Date: Wed, 10 Apr 2024 19:45:18 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Mailman-Approved-At: Thu, 11 Apr 2024 03:45:38 +0200
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

On Thu, 14 Dec 2023 21:18:58 -0700, Simon Glass wrote:

> This series is the culmanation of the current line of refactoring
> series. It adjusts pxe to call the booting functionality directly
> rather than going through the command-line interface.
> 
> With this is is possible to boot using the extlinux bootmeth without
> the command line enabled.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


