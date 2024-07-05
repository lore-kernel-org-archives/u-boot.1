Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95EEEC30658
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 12:02:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BF0C88619;
	Fri,  5 Jul 2024 14:02:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RCrz/pHq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E131D8897C; Fri,  5 Jul 2024 14:02:51 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 968A788619
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 14:02:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-424acfff613so13861885e9.0
 for <u-boot@lists.denx.de>; Fri, 05 Jul 2024 05:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720180969; x=1720785769;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cr0nvtU6S0kN8o9Vp7ZkLF1zcK8PAwi7Mgt7K28IGvU=;
 b=RCrz/pHqpmTNHHd1WF1bDGJj+K0goHNGzpqP8urEyhsu/51xKWIHGzZ8fr1wh0DZnC
 WAhkq8bwjQH/CiM+uV7TeUm/5FHs6eHjphVwmC+qsJus3SQivLp1DsUazYaR+RXfODxx
 AEg62a6FBET7ilSuZwPgB474M59V0s0kM+wFU5qWqT6NMlZIF7ZMz4B4EOudd4/HgTnb
 IFBE/UdnLZQt+0eRg8d5nvUSyOb5jBxc9rJM0ML4IBOEwzgoPAapmeXYIX0BFUHqSesY
 qpXduSL/OAnl9XXQQiHdHRy+NO3E5IEMmF516tDzoxiGeThlyUNq7HnC/HorKtW31jAh
 SmCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720180969; x=1720785769;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cr0nvtU6S0kN8o9Vp7ZkLF1zcK8PAwi7Mgt7K28IGvU=;
 b=QF0cqoSbH4mtT6ZoofmcvnHWP6qhsSG+hug9akkcxiBpJznryAh3ROxA7ADVLAyi02
 dUBApjnCbyW7bNnv6vmhpaK3mJDcOrH8inAD1TLnHX0i94YLaw6y8b5pBbwI/NYbQTRM
 kZGXzWx+aJKnyn91zLDYQTWvvcN9lvIwq/39R5dNXz7uv4sjWl5+uj5hUIrYbMIMbQZY
 8gdQmi6oXA4xDjL5oYFdD+fgyn6TET4zm2Ja2CqMmTxY8zpt5eHelox5KGHZR/hIxqhQ
 vIj/NPjjiPMPvvb0HZhFi7yIKDdqCxeTb0VnO+4Mj2wwklDmCwJqc4iSYz4eQ5SgIhpp
 zz4w==
X-Gm-Message-State: AOJu0Yz9cMVTvqMTyO9gkYgWnPAl4EuL4pDNS6pjeBUrhSvUx2TxeVlZ
 fc91EztWe/6dtpNUDlfzJ8Tfs2fjoyqnYIKS0DFdUFJHCNFGETRz//Nu1/FRKOXUG6Ttihffi7R
 9
X-Google-Smtp-Source: AGHT+IFd/3xXaFHIED7o/2DNDdNyFtZCjyF8yMCidpp/oNETQsVX4TNtB4lCBAeVNZLBGKDNiukFWA==
X-Received: by 2002:a05:600c:1c0a:b0:425:88cb:1741 with SMTP id
 5b1f17b1804b1-4264a41601bmr41415125e9.36.1720180968690; 
 Fri, 05 Jul 2024 05:02:48 -0700 (PDT)
Received: from groot.home ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a2fc9besm59323795e9.43.2024.07.05.05.02.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 05:02:48 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
 Felipe Balbi <felipe.balbi@linux.intel.com>, 
 Lukasz Majewski <lukma@denx.de>, Nishanth Menon <nm@ti.com>, 
 Simon Glass <sjg@chromium.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Tom Rini <trini@konsulko.com>
In-Reply-To: <20240609213449.194762-1-marek.vasut+renesas@mailbox.org>
References: <20240609213449.194762-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH 1/6] usb: gadget: g_dnl: Drop
 usb_gadget_controller_number()
Message-Id: <172018096791.2137591.4465345021519964563.b4-ty@baylibre.com>
Date: Fri, 05 Jul 2024 14:02:47 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
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

On Sun, 09 Jun 2024 23:32:14 +0200, Marek Vasut wrote:
> The bcdDevice field is defined as
> |Device release number in binary-coded decimal
> in the USB 2.0 specification. We use this field to distinguish the UDCs
> from each other. In theory this could be used on the host side to apply
> certain quirks if the "special" UDC in combination with this gadget is
> used. This hasn't been done as far as I am aware. In practice it would
> be better to fix the UDC driver before shipping since a later release
> might not need this quirk anymore.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/6] usb: gadget: g_dnl: Drop usb_gadget_controller_number()
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/0fca00114a805ec3c68c6156bc4ae6c4214a6e8a
[2/6] usb: gadget: ether: Drop usb_gadget_controller_number()
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/7f1b062ca4f23ea77541006759c1ec1108bdda74
[3/6] usb: gadget: Drop usb_gadget_controller_number()
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/2cee3bc6abc592c403140b8a7191879ce95be992
[4/6] usb: gadget: Drop all gadget_is_*() functions
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/db62b6a0a016b69cf0e26eea4004c3edbebd4394
[5/6] usb: gadget: Add full ep_matches() check past .match_ep() callback
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/bd7ec7b04f877b8b4a88d4367f100dc3f0af27a3
[6/6] usb: dwc3: gadget: Convert epautoconf workaround to match_ep callback
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/1918b8010c321c939fdedd6e461ccac87e0d3415

--
Mattijs
