Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF68BC61D92
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 14:52:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0ABE2875E8;
	Tue, 21 Nov 2023 15:52:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="egQQlS49";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6145F875C5; Tue, 21 Nov 2023 15:52:20 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99A94875CA
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 15:52:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40b2979a74eso5431725e9.0
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 06:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1700578337; x=1701183137;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3GQNthP3vryrYuN4qrI4YqrKf31dhENnw1bI+E/DEGs=;
 b=egQQlS49Y8Hn1jtuFL4xZt49Mr7iB/LLpf87c/yXNh47ZREqdzbOtFlmx/2CT9EDkt
 fcQozrh8LD578CQNdjx2QJi0GM694FAlA8APTiQR/CvMsgESMD68n/fdAPE+fuy8KuCx
 jPLLg2D5zNdeQkK5+0Hz8gPIz6z5nI+q/4mSM6pxWzJFkmpkoibTh7PQ4dhcElzQl96/
 jkv43KeCa/dX389wqgy+T5AvDl3htKICqyZqlafZR0WnA1VzVhyQL10ra3Y+wSXoTKbZ
 EOVONOl1okKcK1VHqWtbMzbHrACH15xgRURIlDyZWYeMkPB+3KD7DJhYXWGmtcRVtBMd
 zYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700578337; x=1701183137;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3GQNthP3vryrYuN4qrI4YqrKf31dhENnw1bI+E/DEGs=;
 b=c3Hv4n25BnhomR1xGiQWxRH+isxYmdYYASCnbZfZpSXMwdZfBP+pVFB5tpu+QdetKH
 QbXjYc3W4F/F0DIquiRPn7hTDEpL6n7KvuPSmLplpZDlZ8by5AVTW1Hq6Kq1uHUUKVpf
 ifBnSQrvmBsh6BF/WROuWRiZkyxB3D2YHaohdIeK7w5VRFE33kz8PoUUiUlx05wR+odr
 6qrpbk/zvOOTGwqobTf8sVgepqxE/hIZIngMwFcWPzer6GDvdagW/bNvkxGxz7LST5qo
 2F1zX7AWR33NH+nGfFFg8fWfT2XzUklqyaYGVpCatvvwWQnFF5ztWT7GwdUOPfUYgbl5
 Fm9w==
X-Gm-Message-State: AOJu0YyPrQ4/xZlByCMV1XU1HV753Xl8EQcK/oDbyoSHYPAN1oRKZkW+
 nlQTfnH75Ma7CBC6KPmR7rNX+A==
X-Google-Smtp-Source: AGHT+IHtl7YI6QHvzxV0o/I54NSWloy4Ir2CcWoqbnSQTO+0KUxZFWP5DPqz0hBXtT5MYOHyBxIRPw==
X-Received: by 2002:a05:600c:19cc:b0:406:f832:6513 with SMTP id
 u12-20020a05600c19cc00b00406f8326513mr8104282wmq.3.1700578336938; 
 Tue, 21 Nov 2023 06:52:16 -0800 (PST)
Received: from [192.168.2.81] ([82.66.159.240])
 by smtp.gmail.com with ESMTPSA id
 n21-20020a7bc5d5000000b003fbe4cecc3bsm21171198wmk.16.2023.11.21.06.52.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 06:52:16 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
In-Reply-To: <20231010090304.49335-1-miquel.raynal@bootlin.com>
References: <20231010090304.49335-1-miquel.raynal@bootlin.com>
Subject: Re: [PATCH v3 0/3] Improve the experience with USB gadgets
Message-Id: <170057833581.578527.714532291433405024.b4-ty@baylibre.com>
Date: Tue, 21 Nov 2023 15:52:15 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4-dev-6aa5d
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

Hi,

On Tue, 10 Oct 2023 11:03:01 +0200, Miquel Raynal wrote:
> Try to ease the use of USB gadgets for people not fully aware of all the
> terms and constraints. With more helpful error messages a little bit of
> guidance anyone should be able to adapt to the bind/unbind game that is
> now necessary with USB gadgets.
> 
> The idea is to eventually get proper USB composite gadget support, but
> that is a longer term goal.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)

[1/3] cmd: Change the dependencies between CMD_BIND and USB_GADGET
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/9b63fcaec664780545318d923063bedd898a629c
[2/3] cmd: bind: Try to improve the (un)bind help
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/249a75d8e82b422639beedca3d7d945cd78869ba
[3/3] usb: udc: Try to clarify an error message
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/8a0d07807abb5370fe879321c7f1d22fdda3255f

--
Mattijs
