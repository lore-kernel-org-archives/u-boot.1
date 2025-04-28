Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27716C369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 21:34:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57F7F8211F;
	Mon, 28 Apr 2025 23:34:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fti/Zgr8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF7DB822D7; Mon, 28 Apr 2025 23:34:04 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BBF98211F
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 23:34:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-6065251725bso2385672eaf.1
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 14:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745876041; x=1746480841; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=de5I9TfZ3gpN000J4/KFCsUBDG/EzpaBwd/RuwJIQoY=;
 b=fti/Zgr8HicXQSF8e1Z47zuzZEXugQZdIMNQbGS1VDxzUyLuGqkSLLZfR59XmNCZpn
 jhMs7k6/USmw3O+px1DcsUhoNuHrkfz8826xa+KdafG2pbfc+RkS31A+Mo4SMGHZbjd5
 G5wjMF1aOF0pybu+aWdir0mC5BNf/efe79Hx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745876041; x=1746480841;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=de5I9TfZ3gpN000J4/KFCsUBDG/EzpaBwd/RuwJIQoY=;
 b=TzSQaVxYZypJFqQoEi9QfE0zZ6A0n4yFXq4F2+yDk5+dqDnrDZwW0urToD6Tc0qUJH
 qqBzJ1KS0/kiB+hVc3YeqF9+3DW8io3fwLPvH7Jt1MlzwoiXbNqwwyeGPuia3pIL2Be4
 l1sA9axyrx8KefFP2is9WNXOcvq2cPx+ebrtV9Z3F9aycUDvC1K6KenGp0XzmzrvpVsJ
 t6ldI8m1rzo/SarkKbL50Zhn0bcoDVR0DYjRfm6FqPrN+tF/lOtrmEK0xImBf820/l1h
 QAw9UVSzldadY87CJIM/p3Filpd2VGeb+A+rEYxepYCga7rQWqaLm6kBjAeBjacYONkV
 wNoA==
X-Gm-Message-State: AOJu0Yy56fRoNCKlSp4/jyk1NgvXzAXxVHNw8ZeBHLxAA6j897vlNrBW
 mb0/ZpDpMlz+zSXR0ctsPHp9zap1XXsTbjQPbtg6zQksylHOVmM9g6CcB6g5epw=
X-Gm-Gg: ASbGnctR67LJ3IWbCBBgn8dIdVwAEIxq37BEZejpuko048OiXwqh4+p/oUta/WtFtkz
 6K0HEufikZoOdA341kkKZ2wsl7j9CcUyRphsQRjaYVkZ5YdKaFEqEKiTm+UMss+BRuuXCPE3p8u
 yN83eTIz2PpFZ60m/jRsBDoB+chFiDSKp38mbqkJ2Q4mScOnhUzb44N3pLO7+28YsXC4GI+NYAI
 v63E4uO6kT7otW3XbDb+IVZaaYGm6OSLSXJhLyyORJbyqdQ1A1+h1rFMbfZNjPnvLK/GzSDqJNM
 NHbF1xrGUvD5+BhI5qKZsto3FWG5dxPXHlpZaZA3uMCqxhFJME68BAeFHcr21CYJtaTGqxorZHK
 3S+HHnu1sB48=
X-Google-Smtp-Source: AGHT+IFxf0DSnBloz3nHzhGIG78CJeqrnGxg02qtTQ37IiuGUZRSVfC15tidrKi+Vf0KAPlL3EVTOg==
X-Received: by 2002:a05:6870:910b:b0:2a7:d856:94a with SMTP id
 586e51a60fabf-2da3ffe9593mr666308fac.22.1745876041376; 
 Mon, 28 Apr 2025 14:34:01 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7308b139000sm3108a34.40.2025.04.28.14.34.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 14:34:00 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Aristo Chen <jj251510319013@gmail.com>
Cc: aristo.chen@canonical.com, ilias.apalodimas@linaro.org, 
 jerome.forissier@linaro.org, sjg@chromium.org, xypron.glpk@gmx.de, 
 mkorpershoek@kernel.org, michal.simek@amd.com, ibai.erkiaga-elorza@amd.com
In-Reply-To: <20250420081210.292644-1-aristo.chen@canonical.com>
References: <20250420081210.292644-1-aristo.chen@canonical.com>
Subject: Re: [PATCH] cmd: Kconfig: Fix typos
Message-Id: <174587604018.1121500.621008133265577143.b4-ty@konsulko.com>
Date: Mon, 28 Apr 2025 15:34:00 -0600
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

On Sun, 20 Apr 2025 16:12:10 +0800, Aristo Chen wrote:

> fix the following typos
> - from "categorys" to "categories"
> - from "indivdually" to "individually"
> 
> 

Applied to u-boot/master, thanks!

[1/1] cmd: Kconfig: Fix typos
      commit: 1c07d22ebee96ae9c113f5674c3c134a899426ff
-- 
Tom


