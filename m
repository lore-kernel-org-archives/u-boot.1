Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3DC3C25B7E
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 06:32:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B3BC88422;
	Tue,  4 Jun 2024 08:32:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tyapE5Li";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACEAD88418; Tue,  4 Jun 2024 08:32:52 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06C4888422
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 08:32:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2eab0bc74cdso20134131fa.3
 for <u-boot@lists.denx.de>; Mon, 03 Jun 2024 23:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717482768; x=1718087568;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MzDXRp5ncDDXzHGEcVkE6Z8jXVLDnUu++3dY/dQi6W0=;
 b=tyapE5LiTvrorSv8L3+tpPAUXcRcsgQoXEgiPKaD03ryR6z8mfk8WfBsjl2rZhLGVr
 hl1SlQ0YLwf/wB3p8TA90oONMwF5V+KCX7Lk86OUU/7UpZHvq+A4sI+IK3saBP/W4ztp
 0twU2aUl9PR90pTLpCl1LWl0v7w37xDrdEQazcXlUwsTcJEC/oOWh8bGNRODhLrSv9dk
 PZT1xjOr8IVIYvfnomcABjqUWt+K81pZMytaXcOa9ktaUFVuQnj3/j32CFTx6re3b2q8
 RtuAbutOur+j6VVKRkRkHsBgp/RDZYO04mLnkldVhAfNmuXQAt7u3xPQYbD4R1FPAn2v
 Rx2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717482768; x=1718087568;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MzDXRp5ncDDXzHGEcVkE6Z8jXVLDnUu++3dY/dQi6W0=;
 b=TxAmOmy4OsFkEN/BJdq5JODMsdgRbOtksemBiZlaIiKb943kou8moO6N9B4XVtinGj
 eNS2n5jVWh9yFr082CXqkwGoeLRc3OiGJb6X5FH+IV2282i1iJkUbSqKtt4Obgz5Xz5k
 I939YkxRXnOKzlf9R6bnxtq+Wi/KkD0HLp6dBVvb5aWMHMUOtj1WIG47SJJc24vdfpuq
 fFc9xw7w8yRM3BW/o43Bv5iM99Rltj/hYayPukGliDr49aXtBaxvID4KqWZAlLG2e1vj
 mdrY3mymCrNUWHb0maC8iBCgJ5LBwLt58CvaPKVCoFnVmrcpYeDEfrSo5oJp6R60gky6
 y19w==
X-Gm-Message-State: AOJu0YyzUk/N215VyOj7U8iEQqxwEsk+LfSKG2OhnC9MPZN5ALBZtvrX
 Juo7I+eF0Mb62yYzuaWXxtelkzt7ewEKnoypeqAD1z6sggEB2IPB+TyRVC78DUWJTUbehwNoa1S
 5jic=
X-Google-Smtp-Source: AGHT+IF2KrvQEX7dN3sy/OxFLkj5VU+5Qg+ITSjygqQJ2pmPxZ29vrLCJegAbX69mxh2Y4b0qBSvgQ==
X-Received: by 2002:a05:651c:1a28:b0:2e6:ccfd:fae5 with SMTP id
 38308e7fff4ca-2ea950c8a06mr90288471fa.4.1717482768075; 
 Mon, 03 Jun 2024 23:32:48 -0700 (PDT)
Received: from mkorpershoek-xps13.carmes.etincelle-coworking.com
 ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212b838b83sm143194485e9.10.2024.06.03.23.32.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:32:47 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240528-topic-sm8x50-dwc3-gadget-crash-fix-v1-1-58434ab4b3d3@linaro.org>
References: <20240528-topic-sm8x50-dwc3-gadget-crash-fix-v1-1-58434ab4b3d3@linaro.org>
Subject: Re: [PATCH] usb: dwc3: gadget: fix crash in dwc3_gadget_giveback()
Message-Id: <171748276724.15120.14759219531359573564.b4-ty@baylibre.com>
Date: Tue, 04 Jun 2024 08:32:47 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-b6b73
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

On Tue, 28 May 2024 10:35:03 +0200, Neil Armstrong wrote:
> If the ep0 stalls or request are dequeued when gagdet is stopped,
> the request dma may not be mapped yet and dwc3_flush_cache() may be
> called with a NULL pointer.
> 
> Check req->request.dma before calling dwc3_flush_cache() and later
> the usb_gadget_unmap_request() functions since it means that
> usb_gadget_map_request() hasn't been called yet.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] usb: dwc3: gadget: fix crash in dwc3_gadget_giveback()
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/85ced6f4745f529098cae38a5bd3144035a1318c

--
Mattijs
