Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8453CDB47E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 12:16:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 105B786E22;
	Thu, 12 Oct 2023 14:16:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="V4IjBAwg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 302D486E3B; Thu, 12 Oct 2023 14:16:51 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E56C86E22
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 14:16:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5a7dd65052aso12556257b3.0
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 05:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697113002; x=1697717802; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c0/3fohrj2hlsAB4QMRZfPRAAt/tQrCe7ZCjR4bXDjA=;
 b=V4IjBAwg6ibAxwOYi2q1zg4zcbi4glnS4apx+mpjryg8/rsdvMpWZ1y6pYcfOuzd23
 0M8LPPOEMLoXY6W/GMqLJg2WcqRzRa+fvBoeyPaSWDWjyajjQ8l6SigKe+5Jd/ktz3T3
 dAwKEQOStaGhimWkrqPRQNCGDGy5eHEcEj51U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697113002; x=1697717802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c0/3fohrj2hlsAB4QMRZfPRAAt/tQrCe7ZCjR4bXDjA=;
 b=OabIfbVflhfEoLXVHudMPqavdSGytedY4y+tq3Ko6HlZ+S4V8tBiVu1BDCBMGuIEVF
 DbgrnlebnBKr2knDiE5dZm7PZs6CM6rXA7VQSUEvPSBNuXCR4VMfWe7Du45HCMQ+8vxS
 +/B/eqVrJkvvY2u1lB7TGjNhClPgmDIS3BTSOLJT6zrgsDVHnxQnr1BcZcGCX5gBZu5D
 lDl/Mo2+R0A/EtUY1Iiq6/VN8wluHxsrq8M8nCv48X8yJ7WxzjteF2kyZtWsLykp7ieR
 o1D5N5J6IC+zmyIj/xtpTDx9l11J69JqSLgRUjGmoj36gT8Tx+h3NfA7i5gMiOEZOrR1
 shlg==
X-Gm-Message-State: AOJu0Yz4eZ/fNoOybT/7yx2YnN2YAGIoR9CBl+uRhRK4zQmBIfa3xroF
 wicveKnD+Hx4YEOr1rnr27+TFMkCKjVgU9C4+aHv6A==
X-Google-Smtp-Source: AGHT+IGQ/WjI2EtDQ17ADY3Wi9fbXdZE9pJF3lB0KRcUmJBS+C7Hbg2Vz5ZRiZcyDF7A1Z3CJOKdzg==
X-Received: by 2002:a81:b661:0:b0:5a7:b9b1:c0bd with SMTP id
 h33-20020a81b661000000b005a7b9b1c0bdmr9112809ywk.11.1697113002713; 
 Thu, 12 Oct 2023 05:16:42 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-2621-cda6-b3e1-0b3d.res6.spectrum.com.
 [2603:6081:7b00:6400:2621:cda6:b3e1:b3d])
 by smtp.gmail.com with ESMTPSA id
 k132-20020a816f8a000000b00598d67585d7sm5898363ywc.117.2023.10.12.05.16.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 05:16:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v2 00/36] expo: Support editing lines of text
Date: Thu, 12 Oct 2023 08:16:41 -0400
Message-Id: <169711294107.3140735.16971689210458564398.b4-ty@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231002011349.461284-1-sjg@chromium.org>
References: <20231002011349.461284-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Sun, 01 Oct 2023 19:13:04 -0600, Simon Glass wrote:

> So far expo only supports menus. These are quite flexible for various
> kinds of settings, but cannot deal with free-form input, such as a
> serial number or a machine name.
> 
> This series adds support for a textline object, which is a single line
> of text. It has a maximum length and its value is stored within the expo
> structure.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom

