Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E88C7EE2A
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 16:49:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9ED686E8F;
	Fri, 18 Aug 2023 18:49:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="giLMesIw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E08B86E92; Fri, 18 Aug 2023 18:49:43 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5413A86E3B
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 18:49:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-584034c706dso10962427b3.1
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 09:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692377379; x=1692982179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HnMh7cpb/ULtL7Wmwx5Qs56kqf6Er5L/MI0BZhrE0qs=;
 b=giLMesIwrzoYcpkfRxuHShJ56PI3XlQY8RvTGl7uf/U2mioXqW1zGlGqIWZmytG/FT
 CT/wArbJ/gRzI5IrY25OfistWNKB+OVf0GwdGPifEE4/icrQWb/Ahu1iBQ6Sn7GIVriU
 vY9whZ1lZcLYtT/4auwRWF1GhS31oJ3j/wq1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692377379; x=1692982179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HnMh7cpb/ULtL7Wmwx5Qs56kqf6Er5L/MI0BZhrE0qs=;
 b=Fu0IIIQHyRjbEd4XCAW/cdo05VivZMRtgSC6yDEMDBIMYaT1pXKovFnOYE2Te6X23b
 BIbjmixSs/43cVyB/h4bkQUjOKF2NM6Vzr0KYqgwKOYT77TrvwAhYu6kMIP7cnxhq/5q
 CLvP2YqaN6o94ztth6nzfMbAxpkuFVcXSn7QTsMhwygn26ubF1H5zXO4zGtT8oTMOWnR
 BxVxdEc4lQCvvme6Yma4MysIM/G7ULIWTubFp4n/eQrcAVy0VPu/kgOJGeY1abSMXkfX
 9EAc27ZbbKvxjJYZ4qeOqVOzNvQAMwQyVC70ZjkFZizqmdvoM5AitTjrKFJK6CXYTT5K
 uuEQ==
X-Gm-Message-State: AOJu0YwlJxJoKkgya6CDJe2AzR5mxtHK2CUHkAJM0ME+J9thslSI0Bjo
 RSga5WFi56Y5tCsuJn8Cx+4W2uo/O4cQjPqQkSMo1A==
X-Google-Smtp-Source: AGHT+IE4/LGvO/5cTjcRLWcvMlTtPRplMp0hHmX4qOo4sTzIsyoKbApQmGep+3Jr8RMFQLPy20iBgA==
X-Received: by 2002:a81:9202:0:b0:589:d560:adaa with SMTP id
 j2-20020a819202000000b00589d560adaamr3567569ywg.7.1692377378831; 
 Fri, 18 Aug 2023 09:49:38 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-38f7-b1b8-9b5e-5709.res6.spectrum.com.
 [2603:6081:7b00:6400:38f7:b1b8:9b5e:5709])
 by smtp.gmail.com with ESMTPSA id
 s3-20020a0de903000000b00589c103d00asm594766ywe.79.2023.08.18.09.49.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 09:49:38 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Chris Morgan <macromorgan@hotmail.com>, Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH] rockchip: rk3566-anbernic-rgxx3: Rename defconfig to
 include SoC name
Date: Fri, 18 Aug 2023 12:49:37 -0400
Message-Id: <169237736137.4053142.13856428081529399921.b4-ty@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817215245.692612-1-jonas@kwiboo.se>
References: <20230817215245.692612-1-jonas@kwiboo.se>
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

On Thu, 17 Aug 2023 21:52:48 +0000, Jonas Karlman wrote:

> Rename defconfig to include SoC name, use similar pattern as other
> RK356x boards: <soc>-<name>.dts -> <name>-<soc>_defconfig
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom

