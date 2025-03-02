Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E3FC19F32
	for <u-boot@archiver.kernel.org>; Sun,  2 Mar 2025 13:49:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CBD380540;
	Sun,  2 Mar 2025 14:49:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fAorxyVH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50435806FC; Sun,  2 Mar 2025 14:49:06 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CCE180050
 for <u-boot@lists.denx.de>; Sun,  2 Mar 2025 14:49:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-6fd47dfe76cso24100177b3.3
 for <u-boot@lists.denx.de>; Sun, 02 Mar 2025 05:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740923342; x=1741528142; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w1IhLZ3BcO5sCv934bORznbf4Di0dr3QY8BQ4me29PI=;
 b=fAorxyVHcIVFNAj8bwaE28BqJkULpHfIKiUpdx2xKqBDmpGYeeV9jVjxw5cKzmst3o
 TCO6/BDY0KaOvmDl8zYrTPlPHGvQBIb2oLaVJDaQMZF3/qphpNRvAnwi9lMoEAB7Xese
 110GrxopWFvrRj0/IXI1grEtukpFjnM2xHNsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740923342; x=1741528142;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w1IhLZ3BcO5sCv934bORznbf4Di0dr3QY8BQ4me29PI=;
 b=BrninuLtvcSt1gVrakZbVhhFKMlrCT7uWGtTla8EjddlZl9lomroMSR5q+8Q9OILEf
 iWwQlR+sf+8HA+GmvaOkNi8z8qSbC36iaA47l9HLmtpU8ozQ/CRHsWl1H7BM36/QIvgF
 sOXABrbNDSbi7E3FGDGfW6duiefNfow4QIH4uW39+cSK5LBgsIHzpXHimj4GnmegOpUA
 kxkzKMRaOesIJ44aNL6eHje+OU6Osat1iDD/K7rSkZGY8Mx9IKat/Av+f0MSyiVvELJt
 t9YvClIgnj+m57Mw8caxqCXKqyEaC8x9DwgxVOXNQJTKX7FkpgUgukriG2zhIKVPBlg+
 6gLQ==
X-Gm-Message-State: AOJu0YwO1Qu7B8vegLFS0HvzXdTRJkYQPVTkyH0+xRrKo/Ur00WBVark
 D1cjyzII0acaBdh/XYzSP0idoKE+knaeJZD1UoskVS3RPJmdvPcwh/G+QJD77vsua38f3gJ1rqU
 kfGI=
X-Gm-Gg: ASbGncsK0GZ4RIycMPT/m7txqxBajN4uO1tQePJXqzdEIYc82nVMerDqmv5xH/FEHU/
 tdIIFKSsVF5C7v7TSLQcqSoEcHffcnedoMNoOmNFwvjEu2uAxhlRDO0aEYaH1PIcdPm9rsORhHF
 Mwf+h4kKv57gqSU25D19E1Cz8tj6r3Q43Yg1xx0lrkHfz9sO6OcmYk0TlGyA+JcE3AoDvcUn+xP
 5v3vDQHMOfrunuvCDzJHqQzwWQLW3EX06Yi/jP8LetHLkhH5F39Mmk4nRQpUhbmdRcnf6SQK3R7
 r8uh43VpAtgbnM6V0Fgkwk800gs/h+V0NvftUbwoZQ==
X-Google-Smtp-Source: AGHT+IGIsYty4TV7he1T3n5+wf9kul2QSIKDG6jl0ortdoAayQ1VDcj4urv96VohD7KuBgYckLjiuA==
X-Received: by 2002:a05:690c:4441:b0:6fb:9663:a5f with SMTP id
 00721157ae682-6fd4a15d15emr132936577b3.38.1740923342270; 
 Sun, 02 Mar 2025 05:49:02 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6fd3cb7e155sm15606867b3.85.2025.03.02.05.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Mar 2025 05:49:01 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250301134738.2429349-1-kever.yang@rock-chips.com>
References: <20250301134738.2429349-1-kever.yang@rock-chips.com>
Subject: Re: Pull request: u-boot-rockchip-20250301
Message-Id: <174092334043.1368588.5093364258700757370.b4-ty@konsulko.com>
Date: Sun, 02 Mar 2025 07:49:00 -0600
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

On Sat, 01 Mar 2025 21:47:38 +0800, Kever Yang wrote:

> Please pull the fixes for rockchip platform:
> - Fix SD-Card boot on rk3308-rock-s0 v1.1;
> - Fix crash on nanopi-r4s seconde usb port;
> - Disable undeeded PCI config for nanopi-r3s-rk3566
> - Correct usage of IS_ENABLED()
> 
> CI:
> https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/24898
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


