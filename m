Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBCA8C83F17
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 22:43:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9CF883796;
	Fri, 11 Jul 2025 00:42:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ShPnkh6l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EA6883796; Fri, 11 Jul 2025 00:42:11 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CD8C836CE
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 00:42:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-73caf1152bdso692470a34.3
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 15:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752187325; x=1752792125; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+gFwR1/WV01m+NWTilSOuZ7CgmA+FC25IlaBNfJIi1E=;
 b=ShPnkh6lzKPnTrSVZLMqTdxIbpeu6XO1ew+CMqhZY+0H88q+L/iPzZ+EHrcPA8c/vQ
 2S1/PryAovBSn/RGinC+d8Gw7vGcDc1FDpoi5D1NxdBKLhn7gbXjI1sMZ0QeCOtWzncD
 YYfflWSXUKnSLVlDKcOGyT6gNIqvQhGf2KaT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752187325; x=1752792125;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+gFwR1/WV01m+NWTilSOuZ7CgmA+FC25IlaBNfJIi1E=;
 b=KQWhaEJOR9Ak+t6RFDNRwb70kvZ2wVpzM8dRgL4MSmOUvzTJuZusICrH5S0PDFSu7F
 Lf1XJhtkpBAfKESQgtxlBWGBipOdX1qpjiqbZaWvEG3jijal4somzPp7cl+65HR+opv4
 5BDI0MkS/N/rauqQ6OVTNbZaxRTQ0tnvIeT2qoFu4Y/TyizzgUVU/3TmefPmw/wxwsW4
 pG7J8r++9ugn06rRBVyr6siXVvkjUnbvGhmlZQ73iooeE+IQLpUsoO92u0Mv4N3XA7G4
 6/lrpaTSohpidfUkCsrw7Dgxzy4tuFDnZeXjXTfJVeANv7yV/r/HLAGP4QC2+DuDD3sk
 Bp7g==
X-Gm-Message-State: AOJu0YwgZIsEYk3CiUGP0ceURwvPBTRRHagdTg9jls+pl9DJYfAPDA2i
 xBsFcmmQOqVYciE0HK8wYQLvgVF7iIBg5f5/VsXWBSqOCiuXkpnANh+WZvtX2kbi+1OYZty4wpB
 iVVUGiLQ=
X-Gm-Gg: ASbGncs+41Qmb1QHxbtiAxM7+C+xpcXuXBxqhygW8xr2Tn844B6N/srRroQMqGBhKji
 9m9NDj6ywYnAdecEvkg8WAf9d+KbLgApWC0k8MvvW3Op/AItcvX0VwpbYrhG2hAvVVG17a9u5G6
 XXCjktmdL/qO619yE916BrPVIgFtCUSwiqKX0f8BOC6GRYvflR7reYAPXMhj/EmNaEImYl23Kic
 8lHZTm8gd/Mhmozj3Aqxk1F5bhGyVpfb59IcdboU2azAYVO+Nq8tzzQR5eodFqc3rrK3C8b2nlC
 SUgQI16CHl8gHOfvgP8T1WshYq8vej1fKlRzoZqpNIy9inm+CfGEH2Tud3x6iAil77ypr/Zejob
 hW4MBl3fUZSbOGYso/VcjYGqT1ySv2ZtFBpc7I7FKPCtWsXLOz5oKrnw=
X-Google-Smtp-Source: AGHT+IFqvpy30i5uYz9fGNITG1L+Q/12Y+A+6ymMjq5njzDMTqXTBwV6pbNTPNO2CT3lusSEwOJvHg==
X-Received: by 2002:a05:6830:7105:b0:72b:8aec:fbd4 with SMTP id
 46e09a7af769-73cfc2b4cacmr27109a34.3.1752187325327; 
 Thu, 10 Jul 2025 15:42:05 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf12b745fsm357354a34.64.2025.07.10.15.42.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 15:42:04 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250702010514.19184-1-trini@konsulko.com>
References: <20250702010514.19184-1-trini@konsulko.com>
Subject: Re: [PATCH] post: Add dependency on ARM || PPC
Message-Id: <175218732455.2073260.3018422979900834510.b4-ty@konsulko.com>
Date: Thu, 10 Jul 2025 16:42:04 -0600
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

On Tue, 01 Jul 2025 19:05:14 -0600, Tom Rini wrote:

> The post framework requires architecture specific implementation
> details. At the moment this is only done for ARM and PowerPC so express
> that requirement in Kconfig as well.
> 
> 

Applied to u-boot/master, thanks!

[1/1] post: Add dependency on ARM || PPC
      commit: 1e8665e5134380168187e7e5487cad44e4e8e3d1
-- 
Tom


