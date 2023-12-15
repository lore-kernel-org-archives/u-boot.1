Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B98BC4167B
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 18:37:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE57B87C7B;
	Fri, 15 Dec 2023 19:37:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d9uc+fIr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4F6487C77; Fri, 15 Dec 2023 19:37:30 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF5A087BED
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 19:37:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-77f3b4394fdso58241085a.0
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 10:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702665446; x=1703270246; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qgsd8knm+hH3ZeWLAmXy048lGnf94WOMJVYrP6O/BIo=;
 b=d9uc+fIrFzAI1rbTIFLfb1yGGhfrYK0DliqYZcC7qg8fVAZpd1zWaMmlIGJhv7flpp
 Q4yuiV8+GquSIWQFxuOSMKFpN4LUbFFi27XPnbXDQpYjeyxtWVW6juY74oa8QYSSkqBK
 GxVlfT2lyzdZzoe1uVN9JLXWgJptyxD70aabWtclntEgQ+BtRUXbnpKD8tk5GAz0kxVh
 RIMh7LB+buU9yZ/966eodBkU1+QObfxa33RqEhQ+VziD8mzSpjbcLRfl9EEerHiqMltA
 +WjDJ+4XeKCxZ73nqoShxwFB+nJIDFhm5LR26l3epKWzBwcoDrUP50PnWioe5avgtWSG
 tCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702665446; x=1703270246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qgsd8knm+hH3ZeWLAmXy048lGnf94WOMJVYrP6O/BIo=;
 b=RfDfiB3j7b55GgxUFyNb0+eTd57qg9aBCAr3V9UMHsDyRKR5Wsj/WNNv7JFQ+MfLUU
 XfsYxHY82xBusAx5wHSZFRkaRC0ZUtMr8/b7Bhgo/C1/2guekfy1K3bH108MQq+GNZmE
 Uur48g0dZNqzalHAvbvIb0HdZ2boxBiTI6ZuZ7zQozHJNq3zwoRDaC3Io8XtDBU2L1ed
 M8LfTJx+Yp7oc6wzusKLUnUsGg99lwV2r0+l+VDVTU5G5xaJaK+VfQHN1FJZi7Pb1uSD
 MeyrjRWckx2AwR9GXXsOVyU140VXzqU2A5lECxBL/UHzKnOjH00wLTkMjsXxHWu6zGHr
 o0tw==
X-Gm-Message-State: AOJu0Yzovc39YhS76y9ykpYHy5TNRe3DKvxIId6fiE9Eale8rYYtVqQx
 KaE3CLN6iVnSwXMYLN0KkcfE7X7fK5U=
X-Google-Smtp-Source: AGHT+IHZQCL/uw77VhjXaTvVstdonJ791wn1JDCc32pw39sZ+vzbr1E7S1e1ceexD1oy2O90cGtzyQ==
X-Received: by 2002:a05:620a:19a7:b0:77f:8d69:c50 with SMTP id
 bm39-20020a05620a19a700b0077f8d690c50mr7809527qkb.14.1702665446628; 
 Fri, 15 Dec 2023 10:37:26 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 ov11-20020a05620a628b00b0077f05db2663sm6286713qkn.66.2023.12.15.10.37.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Dec 2023 10:37:26 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: forbidden405@outlook.com, sjg@chromium.org, Lukasz Majewski <lukma@denx.de>
Cc: Sean Anderson <seanga2@gmail.com>,
	u-boot@lists.denx.de
Subject: Re: (subset) [PATCH v2 2/4] clk: get correct ops for clk_enable() and
 clk_disable()
Date: Fri, 15 Dec 2023 13:37:22 -0500
Message-Id: <170266540039.2383564.12063365168849528968.b4-ty@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231111-enable_count-v2-2-20e3728600b5@outlook.com>
References: <20231111-enable_count-v2-0-20e3728600b5@outlook.com>
 <20231111-enable_count-v2-2-20e3728600b5@outlook.com>
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

On Sun, 19 Nov 2023 06:10:06 +0800, Yang Xiwen wrote:
> assign clk_dev_ops(clkp->dev) to ops to ensure correct clk operations
> are called on clocks.
> 
> This fixes the incorrect enable_count issue as described in [1].
> 
> [1]: https://lore.kernel.org/all/SEZPR06MB695927A6DEEEF8489A06897396A7A@SEZPR06MB6959.apcprd06.prod.outlook.com/
> 
> [...]

Applied, thanks!

[2/4] clk: get correct ops for clk_enable() and clk_disable()
      https://source.denx.de/u-boot/custodians/u-boot-clk/-/commit/3fb2d3d6acba

Best regards,
-- 
Sean Anderson <seanga2@gmail.com>
