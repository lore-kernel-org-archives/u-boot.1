Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 371C2C52D6F
	for <u-boot@archiver.kernel.org>; Tue, 20 Aug 2024 00:30:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3B7D88D41;
	Tue, 20 Aug 2024 02:29:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QRrMA/Jw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C25688D57; Tue, 20 Aug 2024 02:29:50 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F411888D44
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 02:29:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2705dd4ba64so984034fac.3
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 17:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724113786; x=1724718586; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nw1DJiknQuYYLGR0ZdTTY9oRvpeUrZVMlpALACIZE7U=;
 b=QRrMA/JwidhLMqi2oA9HRp5ENmceOQ2TK/G5rCb5BBEA1sz2m/SXnD549JgLmsJrRO
 kPxzO5Oz3wi4uxdR6Qn3GVBAB+jBBXJ4K2s54EuXfQQxcF/R917/N9YzlK73XH+MPhqF
 PHHV7ovfnmPUbXFA82yplVE4zN7IDYqZ0erWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724113786; x=1724718586;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nw1DJiknQuYYLGR0ZdTTY9oRvpeUrZVMlpALACIZE7U=;
 b=gIYEsJnx9ZPyLx2qOpAgrqgnOgAXkQC/9OJgO/3TwfiJP7sxGuFzA19oNv5JbsEktq
 A8lDQXURgReFp5f6pZrK/534810JXl2d/SsMDFvqMiQ0kBNrJ+m6quUiW1jZ/ax5W6im
 fNPpEzvo1fRbTZ6TDTpUsdFCsGoUFYKTOzD9Hz5c9P/CXTW1/3GMQ0sN+LDJ7S9TuHgP
 TlZAPYESxzA6yIM2ZmAsCBP59NUpDvlj2o/zmc61DD5rRYo5fpGVwI8N0Hq3umL6uKhz
 gS5OknNkRKmGcXlpiie7wHdWyMmn2r1cSCLwLwZ8sM/dBQBATHv/+BdaogxZMwv3n60g
 yHSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUXMW+jHvUVCjSwlUVVzzvEUMmo2pw0DeZnjtJGAkKiHLGaY92saw8gsLPHHDl2hdnNVmybCOZaGPd+/r5nWifXBeBYA==
X-Gm-Message-State: AOJu0YziBHqHG6W2L8ZNR2JjlHJ9DMNCaUC5Y6Jh+D/H/jCYUYlrHJ4S
 +BIcMHf+g9aDYfxnBPg4YFQkcn+05guFw8gBLGmn+poT+euWOp7hqJNdxhrdAWE=
X-Google-Smtp-Source: AGHT+IEfSihQEk4AKq4TgO2sVVuIMD+AJ1OVNOhNNHuZLde6VYUj6QP+Aq3ElukaznTgAqtfr9/LeQ==
X-Received: by 2002:a05:6870:7026:b0:26c:67fc:2987 with SMTP id
 586e51a60fabf-2701c52275bmr12964305fac.38.1724113786554; 
 Mon, 19 Aug 2024 17:29:46 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-270046a6208sm3319572fac.27.2024.08.19.17.29.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 17:29:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.denx.de, Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <20240803084329.1688-1-ansuelsmth@gmail.com>
References: <20240803084329.1688-1-ansuelsmth@gmail.com>
Subject: Re: [PATCH v2 0/8] clk: mediatek: mt7622: clk migration for
 OF_UPSTREAM
Message-Id: <172411378561.165406.2330615028821264940.b4-ty@konsulko.com>
Date: Mon, 19 Aug 2024 18:29:45 -0600
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

On Sat, 03 Aug 2024 10:43:18 +0200, Christian Marangi wrote:

> These are all the required patches to migrate clk and correctly support
> OF_UPSTREAM. This will align the clk index to upstream to support the same
> clk implementation with downstream and upstream DTS.
> 
> Changes v2:
> - Fix typo in commit description
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


