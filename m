Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 095D1C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 23:55:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8529F8756E;
	Tue, 28 Nov 2023 00:55:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bAo2qGTn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86AA8875A0; Tue, 28 Nov 2023 00:55:16 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 295A88758C
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 00:55:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-db49ab94768so2069142276.2
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 15:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701129312; x=1701734112; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2qZUEmcFSAWlqM2HBhERV8LtZXUi+5jEsQs0wz69HhM=;
 b=bAo2qGTn3D7PPXJNGskTGP6TgZVp8XD9Zvlexx8jBaV/PH0JvIjLKSoM8YyBORVsJu
 fM2WYU9h6QPYO0y+QlWzqjZmDubircnjFXp1gMgy6QY5T7Jvn5eyz3VUDogjRFL2YZUf
 XGqJZX4JsgsWtIwMEqKaYOlyMM8Qnl/2acqYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701129312; x=1701734112;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2qZUEmcFSAWlqM2HBhERV8LtZXUi+5jEsQs0wz69HhM=;
 b=m6QsgFvgdhMvUlsmKor09jyeGQZcnjW8Cp9D1EqvJi5jDnsuJ0+1tNPK6i5fcSXPoq
 9xfpce1UOmSn8gkSWLlcxL5WbRJlhJK9x5w1oUlrKAs0+be+z5HPyNiT1kkeCFnVhz9H
 NYqETYVl+DxEYxQARw10Cq1Uso9qyScLruYQMsvI98LMq4/NcM9rbISehL7cPJVzP5s3
 rUZb0WXRtvPEvxvE8fB9KvTblIO4zPlHF9kbJV5ItXpgrVdh1zpD9dwW/S0GUdlyWlt8
 J5iojhhJB5H5fG1Ck0i2XFIR0dQxKo37U51HML5CkCZZtbI19AfajpXBWmMA539Kq1VR
 m9+w==
X-Gm-Message-State: AOJu0YydrfEvGjozUQ6fL2dxR0OwKVS5I2Oid/3zua/z4udLF5a1KIvF
 fPsJlTYj9HnA/IFWTMVTK9AaOQ==
X-Google-Smtp-Source: AGHT+IFZITYlr2rtMfkd6grDzPmAKtAw0XPKyJAYFfbi26pf54oENp3LJVbYkg2TZ4pSfVVq/zHDlA==
X-Received: by 2002:a5b:d47:0:b0:d81:5d5a:25a3 with SMTP id
 f7-20020a5b0d47000000b00d815d5a25a3mr12946749ybr.43.1701129311852; 
 Mon, 27 Nov 2023 15:55:11 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-6400-4f9d-49d7-ae37-6b11.res6.spectrum.com.
 [2603:6081:7b00:6400:4f9d:49d7:ae37:6b11])
 by smtp.gmail.com with ESMTPSA id
 4-20020a251804000000b00d8679407796sm3340883yby.48.2023.11.27.15.55.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 15:55:11 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Philip Oberfichtner <pro@denx.de>
Cc: hs@denx.de, sjg@chromium.org
In-Reply-To: <20231124140400.32027-1-pro@denx.de>
References: <20231124140400.32027-1-pro@denx.de>
Subject: Re: [PATCH 1/1] i2c: Bugfix in i2c_get_chip_by_phandle()
Message-Id: <170112931087.101474.12484186755916075396.b4-ty@konsulko.com>
Date: Mon, 27 Nov 2023 18:55:10 -0500
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

On Fri, 24 Nov 2023 15:04:01 +0100, Philip Oberfichtner wrote:

> The "i2cbcdev" sneaked in when implementing this function for the
> bootcounter use case. Obviously the intention was to use prop_name
> instead.
> 
> Fixes: b483552773 (i2c: Implement i2c_get_chip_by_phandle())
> 
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


