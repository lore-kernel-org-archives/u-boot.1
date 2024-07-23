Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E063C3DA63
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 21:04:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEEB1841BC;
	Tue, 23 Jul 2024 23:04:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kIqO2kJl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07AB08872F; Tue, 23 Jul 2024 23:04:20 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 406628811C
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 23:04:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5d5846f799dso1141394eaf.3
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 14:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721768654; x=1722373454; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d7RFuHaP3WqNOPe36+cuunH2cGNQOZY4KrPOVF5eaGI=;
 b=kIqO2kJlzGP4RJ64xdms3Ow+aP+HvygLaSd6nBVLVxY7QB6hAxqoGvw3Xcs+wKrDEk
 SAXN5NiJgX/hHI17wO4Mn80KbnfuVK9QYd7iQkc0W72r8c+R2VtgMitwN+Jo/eOMcQzq
 maiPoeY7F8lJ96OBV8kEuQI5POHJabyLcenCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721768654; x=1722373454;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d7RFuHaP3WqNOPe36+cuunH2cGNQOZY4KrPOVF5eaGI=;
 b=fjUU09cfQRDETVV5C86v2GtspASBC516v1FCKsqO6VqP4UYbhfqOOWazqpSOsKZXnK
 h1eFzhjnQJ184OG+tH9qEg+4Bxm4UZsiM5EzKMX1zrZFIVsZ+Wl3EJIncM+5+MMGwyE0
 4q5IzemiJ3s2YQlpgGt9OLBvdYp7GYiLRGC4qa3UNukigdpiHkloPpne1TCg0s3nyams
 77P+mopaYIYiV13DXEct0kTzzdAcxc67mATgkUPl03BUxwH8geoe0nXKAbwsmYixjxFW
 Ix/B2Ae8fl2H9051HXufwiAfUMnl5QLivxWkh7Wmgah3Uj9IU41gXeNvIKQ9B+knNBar
 9FnA==
X-Gm-Message-State: AOJu0YwbMxEUbbrxUKhhP1ih4k+LMR09H5hqaDUas+vVwSMrEZFqOJ6m
 iLSbDerQBx26JTaKH6vMWvb8HHBgdMChVnujo3Bv4tXkrkMyCp3cfyAKRmUCuKE=
X-Google-Smtp-Source: AGHT+IF61VVRCE2PS2shvaFrDBtAVPvV/uPuAiafJGdp2Q/N6GBeJ4fsAJKRbGMqSedD/Bficj2ORA==
X-Received: by 2002:a4a:ee8b:0:b0:5ce:6671:de2f with SMTP id
 006d021491bc7-5d59fe29343mr270806eaf.2.1721768653944; 
 Tue, 23 Jul 2024 14:04:13 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5d59f04938bsm61321eaf.33.2024.07.23.14.04.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 14:04:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anatolij Gustschin <agust@denx.de>
Cc: Simon Glass <sjg@chromium.org>, 
 Aleksandar Gerasimovski <aleksandar.gerasimovski@hitachienergy.com>, 
 Holger Brunck <holger.brunck@hitachienergy.com>, 
 Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
In-Reply-To: <20240719232422.3403700-1-agust@denx.de>
References: <20240719191656.3323947-1-agust@denx.de>
 <20240719232422.3403700-1-agust@denx.de>
Subject: Re: [PATCH v2] board: keymile: convert to CONFIG_DM_I2C
Message-Id: <172176865323.2258489.7384458498839983445.b4-ty@konsulko.com>
Date: Tue, 23 Jul 2024 15:04:13 -0600
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

On Sat, 20 Jul 2024 01:24:22 +0200, Anatolij Gustschin wrote:

> The conversion to DM_I2C is mandatory, rework to remove
> use of legacy I2C API.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


