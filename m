Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD184C531D0
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 01:02:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9119940B0E;
	Fri, 24 Jul 2026 01:02:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lyYWW1hNerr0; Fri, 24 Jul 2026 01:02:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 993C540B01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784854942;
	bh=PbVENa2L1R5Dxj7uW+Ufo1pNhON80tDX0WptxmWuREw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rEOAWXO8bffjilChiCFAwZlFVlpiJ0Ep//7cidBH5hsu3yPe6dXiYUnod1uXq0ky5
	 om8QvT4d0bMV6NfN/sLyywGL2WW9qFskA7NjQjq4GgIJaHR4Yd7FTXVhHUpAi1/kXX
	 H5MsU1/FP+hUmvLzIt80Mq7nEW4uMsRC2zjPL7K6hapd/Cg2tad7OM9Dts+oqWKnJZ
	 l2TQKHjdb6xNSiNRLVmlqb5VefGkZucZNk9Ynl5s4+Y1CdqVkHstpIsTGLDH9HiO4J
	 sgae6CDd+a/Hq9j3K6ddPWJiaLRvC9pCY64gvMuU5VcBUefE+PVa6qpJAIk/Q9xSbz
	 gz5cBhjZMlTSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 993C540B01;
	Fri, 24 Jul 2026 01:02:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6934C2E5
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 01:02:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4F18F40072
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 01:02:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wLaAa9bke54i for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 01:02:12 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 06CE74017A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 06CE74017A
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 06CE74017A
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 01:02:11 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 273C983E76; Fri, 24 Jul 2026 03:02:10 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13FB6800AE
 for <u-boot@lists.denx.de>; Fri, 24 Jul 2026 03:02:08 +0200 (CEST)
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-4a451915d8aso725801b6e.2
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 18:02:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784854927; x=1785459727;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PbVENa2L1R5Dxj7uW+Ufo1pNhON80tDX0WptxmWuREw=;
 b=QQLnZALbrESWLBT6fqrjO3kQ0DGrxDXlr7FRrbp0/LAXT54MfPmc1/O87AUOcl/Ame
 S68Hd82v67VGrgTeaxgX1kxBSuNhtkOA9zn1b+AaxG82NeC30R9GvHxY1zVLIX8whZb4
 ljR5Y3Y3TiR83Tt5Dp/EtTCZAioEcfvLGoe5Q2Udqf8dXwyEOcSlE1+Q01FPszqdhfqA
 toW/Xim58wBi/42kkQgMPwlBS0tqPeowcoQKdzBK6oQ7zd76t3JSY2HU4NTL0cFYXHsb
 0lZ878W53qOmomSbTKVu7+E/wYgFIk+pPa4cwTuckCiy/bhuU5+lQwssPxXTgNaN6yNI
 Vh4Q==
X-Gm-Message-State: AOJu0Ywbuf8eIrTupmOoTPpNxfBFnnN1sDbWFDOfDoFH0Umpdh+x9qBe
 L/FUGOB6tJbywisWYdugTn1A8kbBVcjTjmCRj0q8qasnTrGnuqEnd8KWzD0RH7qOiSozditxEXr
 qlojX7fo=
X-Gm-Gg: AR+sD10paSCvHNi1Vy3lhek2/pEFOSAk6URBpLJ0WANDzpff7FLhkH8KWoeChJglu3q
 7xeMB0QkHoKJv0bPAEmWXB+htphD/nlr3uAN8IdSEu+NeDeC+c+/pNDngm0vZP97stE84ytpGP6
 ldL9z0806rxDf1p8FpedfI/Fz/cbBThdyy6sCqV9Pn/vsnmD4931ixsjJWPKRF3S1PIdkSDA0F2
 nRBe0HextApnhKi9MWZ4IElYT6FawZC5WMWejwbQ0MU4aaGZYuLZ8zPLt6tyVlvhGCeRTcbcM/N
 ferqAhIg98wI3HYKK1pymRxuEh7f6RbQePdr/JH1FdveDXsHVUQDp7NGwF9xoN2lTt4VUkeYUxK
 B0GcWz+UXtves9B1UOZcxXUrR9J3Bz/HB8cQOq7Jj8pDcE0O6w5e3lXpH8UWI2wmq3msxdnaJOb
 jgrkjNKQ4711TQgzsiA6NwyGEXtvOktZmg9rqhLpbQ/XeL+x2XwXY9aeMsQYkQzr8BudVKwdWYA
 fKwUIUcU+Ko8p3InmFyzfn7Fg==
X-Received: by 2002:a05:6808:1b1e:b0:497:8b9:bdc7 with SMTP id
 5614622812f47-4ab352e7e4amr2795399b6e.15.1784854926698; 
 Thu, 23 Jul 2026 18:02:06 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ab0c7a01bbsm4196177b6e.1.2026.07.23.18.02.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 18:02:06 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, hehongbo918@gmail.com
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Johan Jonker <jbx6244@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Luca Weiss <luca.weiss@fairphone.com>, Daniel Palmer <daniel@0x0f.com>, 
 Yao Zi <me@ziyao.cc>, Angelo Dureghello <angelo@kernel-space.org>
In-Reply-To: <20260708125425.70745-1-hehongbo918@gmail.com>
References: <20260708125425.70745-1-hehongbo918@gmail.com>
Subject: Re: [PATCH v3] serial: esp32: add driver for esp32 series chips
Message-Id: <178485492497.3246206.6521945793606423380.b4-ty@konsulko.com>
Date: Thu, 23 Jul 2026 19:02:04 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784854927; x=1785459727; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PbVENa2L1R5Dxj7uW+Ufo1pNhON80tDX0WptxmWuREw=;
 b=fxCENKUQdwCxvJlmKccLJvV6Ok7MRZajdYaQsLCwVKMwVWyYVAFkeOhE8z1pQ1o4+/
 P5G1UN3DcXPUIYXYKEMJ9jIJVF41dNxaEVBKy7mhY5FTAGNmzOrsYCU+jdMAud/B5fq0
 8kmrUXx+Wh4KxJamqoRLjWiKqh9Fek1wfhp8E=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=fxCENKUQ
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=trini@konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fxCENKUQ";
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Wed, 08 Jul 2026 20:54:06 +0800, hehongbo918@gmail.com wrote:

> Add a driver model serial driver for Espressif ESP32 UART
> controllers. The driver supports ESP32, ESP32-S3 and ESP32-S31 UART
> register variants, including baud-rate setup, FIFO access and basic
> port initialization.
> 
> Signed-off-by: Honbo He <hehongbo918@gmail.com>
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] serial: esp32: add driver for esp32 series chips
      commit: 64ce0f86ab9ce931013195b68276770d8e02b40f
-- 
Tom


