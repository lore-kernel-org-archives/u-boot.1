Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E473CAC597
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 00:12:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAD4783390;
	Fri, 19 Sep 2025 02:12:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fZlioLKQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DD678331F; Fri, 19 Sep 2025 02:12:33 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E5FF8329F
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 02:12:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-74381df387fso840820a34.0
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 17:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758240749; x=1758845549; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q1DHKCbEKLORLWNcO0/110Sf2kDbn2L3qk9/Xxeph/s=;
 b=fZlioLKQhCJq45KlbFhIlGooIH/V2SsB5raZq9BbxOC6uOA9kqWczURhp5wpj3y2F5
 EiDasIAsTSuAtbm89YHtgFm76qmJBaBC2Hxh9oefq8XrA8GWt/1zj0fFDV5u7BwXc5Mp
 q5xxcyYXrGdJXFbl78OHS0Z9A3/Lx784MaCs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758240749; x=1758845549;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q1DHKCbEKLORLWNcO0/110Sf2kDbn2L3qk9/Xxeph/s=;
 b=AVPdU5peLbTIgfPP0+7J6jh1RnNi2Af0e+UdP4nfIgOV8Nwe+sVOwdJP7TDxS+C1SN
 QYLPi1QRrI32yXCW/r6kPIIVvC3Qs5KkjENx8k2BIy9G3loE1lxbhyJX2vFC8X8RQKLc
 J51lL60g8bXmmqD/5Z7p97sCqZjxSv82c9+rClRW0wmjkfPhWpIH5wifuHqOsIQZMzh5
 CBMpK4x2IyXvwvrvCKFFmQUIftsIekz3nZV74dU6fGNOrd9Dn8N6AEG2pg+SIYWEN3rM
 AKj+ePRCHv1jxP1QQoOG4VaRxz35wSklTlA09gpbvTJL5hakuImIHx98jBRwj34TPLtn
 QZqQ==
X-Gm-Message-State: AOJu0YxnVnbj5bGG16M8Uw79XnJs+dcSH2OHpCeKclMkVpNUMdeNNf8A
 V5grVgE/htH6X2aYfLK+TeUH+u8JdYnfkfoBghh6B/aTALIRg4L3jvcvEHF+PP2pdB4=
X-Gm-Gg: ASbGncscVBYGgutRsyvrC1oVmuXvWuf+244ReXWI0Nm0AOYs9hRLM42BhOFspwOG6M5
 B4uUlSNUHW+iHK3oWm9ecMyuJ1Vs3o0BMVwJrmLcCXwv4arlXYB+rtrfsBO5sL1Qo18rqTOs/xU
 32kgtZZFOc12yERIM2ymQTIQ+dsenDcfPgd+U7sVbpbE+IDbKUHLVVt4B090ELIFo5mARcNb0Bz
 hU8kF2u7KKDympiaTXq/x4OAMMVv+h7fwy+We+Dd2b6rW/lDpMBD+GJD6i9C/+CCV058yyrrgDr
 IVHrMgIMxl82L6dDzo/nkYStuqUUGEpmMTHudBvVcEFN00fq5pcZR3kL2x2/1CPIakUGFQazkWO
 I0yTPBegr/AumZR6P5IpwiRG2vbYLoMXYmwh45xgGvgxgP6MBVCbTHWhub4Kin9kD2n4YvjjgR8
 8RXMu53Y/8
X-Google-Smtp-Source: AGHT+IH6TbmiJsmPJFh3XL/oDuaAJczLn8lzO3d8UAC0YyCzp3g/+WFJQuifZJGHDgYQ5b9qKhmMVw==
X-Received: by 2002:a05:6830:82ea:b0:748:3ae3:8d20 with SMTP id
 46e09a7af769-76f7bba8c3emr902261a34.19.1758240748991; 
 Thu, 18 Sep 2025 17:12:28 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7691b0244d7sm1694728a34.15.2025.09.18.17.12.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 17:12:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: JJLIU0@nuvoton.com, Jim Liu <jim.t90615@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250910021617.285527-1-JJLIU0@nuvoton.com>
References: <20250910021617.285527-1-JJLIU0@nuvoton.com>
Subject: Re: [PATCH v1] arm: nuvoton: remove unused parameter
Message-Id: <175824074797.975344.6500072148002296122.b4-ty@konsulko.com>
Date: Thu, 18 Sep 2025 18:12:27 -0600
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

On Wed, 10 Sep 2025 10:16:17 +0800, Jim Liu wrote:

> remove CFG_SYS_BOOTM_LEN parameter
> 
> 

Applied to u-boot/next, thanks!

[1/1] arm: nuvoton: remove unused parameter
      commit: 30fbbde2cdfaebb1db47d7c0d457a32e3c6552c3
-- 
Tom


