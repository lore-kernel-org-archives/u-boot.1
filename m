Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12FB1E7718A
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 23:26:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4663980304;
	Thu, 19 Dec 2024 00:26:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="H2x1Gws3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4ABE080295; Thu, 19 Dec 2024 00:26:13 +0100 (CET)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F9928021D
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 00:26:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-467725245a2so1032011cf.3
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 15:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734564370; x=1735169170; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6SH1YMMmLri+S/Rr8etOeJ6RTtxihIaAsrh3R49V00o=;
 b=H2x1Gws3RE0RMDnxuJxUtVyPj1aPL2FFxqgLaLIUbiwOU7ftOOmUccxdl5glLO3FT1
 r20W2DuE5JsEN+dwQOYLk05AYV4u6og2suITSx05jwmuqKGH0X5T4OWGPE5rRuyq937o
 rUIhbDE3FOyb4Y4ZVtrUm68fW3k8giZ5TvPH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734564370; x=1735169170;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6SH1YMMmLri+S/Rr8etOeJ6RTtxihIaAsrh3R49V00o=;
 b=L2nAbvSDMRsZ6CWioc1RIVIhteXTNZr1ljmXw110rBwA+afivQaQkqFmoWKZbVqlbU
 HKhUwwBtCGix1W8s6F+HXKb4S1TSZj1P8uxt7NGGWkBjsOlpumKFj1XzqQ5FpeLm02ca
 mGE/XRDpiKKgoGNeq0vs2ZB8x1KbAgyVJpd1YDjh4soUOfPpXea5ZOu5f2zodtUBKjvU
 d1HtNZhwJpvzHG/Yoyw4GWGJAypg2qGdn6tZ3CRV9pPbk+xQ4aZy+aWdvBTnREZiQ+Ng
 pNOYbkrQvTSoYd2dEWEyruiiIoPj8iAmIqbIJ8FLwbMOulA8456v4q9yx8Mzn0s8V/Qk
 RlFQ==
X-Gm-Message-State: AOJu0Ywd35xmxYg5DvBbDJ506kqNQ1m38PWnC7cECgDzpZjdh/ZHZA9C
 Kk8A8/qv6EhpkVKwkK2W1HqVwpKLC4KWENGM9nhrRyZ9WhP+2i9K6GrMn9Xc4x7X3hins07/vZ8
 q
X-Gm-Gg: ASbGncsuDWtJRq09O0T6Si71WGQ0/k3DIpZ7pBD/6niNLoRSEk7g/5s/fGjBXY4rVvZ
 04xtDcPteXxabFGd2rvmKn0dtAfojMw/GesAnSPd/ln8+gQNHdEvYOd1a2yH37XwQXsSoMXUdUf
 MkkdyQVig/VL7XvrRuTOkzs0goDbGcepfqh1XobAbGebNUlopADVOtUE3BJAg0tnqxJ/mjB5OFa
 DzgvkurNh2y7RUDpDaIXr0d0NXHbYhWvZ6lBgTIEfkM2h0cgkdhsyA=
X-Google-Smtp-Source: AGHT+IFs/sY0WUnKXsXL6qsepPMoAw4J77eFO2x0DQwDiQ6t4ovKrr2JoqO1xJqDSXnGK6vdXdgSuw==
X-Received: by 2002:ac8:7f4e:0:b0:466:a3bf:41a7 with SMTP id
 d75a77b69052e-46908eb4d67mr73240711cf.51.1734564370010; 
 Wed, 18 Dec 2024 15:26:10 -0800 (PST)
Received: from [127.0.1.1] ([187.144.29.192]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3e653f52sm270821cf.16.2024.12.18.15.26.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 15:26:09 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Matthias Brugger <mbrugger@suse.com>, Jerry Van Baren <vanbaren@cideas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241102174944.412088-1-sjg@chromium.org>
References: <20241102174944.412088-1-sjg@chromium.org>
Subject: Re: [PATCH v2 1/2] fdt: Correct condition for receiving bloblist
Message-Id: <173456436871.3535347.15453462431542802806.b4-ty@konsulko.com>
Date: Wed, 18 Dec 2024 17:26:08 -0600
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

On Sat, 02 Nov 2024 11:49:41 -0600, Simon Glass wrote:

> The condition for receiving a bloblist from TPL is reversed. This was
> only noticed are the other fixes landed. Fix it.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


