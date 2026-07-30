Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27099C55160
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 13:33:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D97FE80FAD;
	Thu, 30 Jul 2026 13:33:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5NWB6Nkmwm4E; Thu, 30 Jul 2026 13:33:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7854580F8E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785418434;
	bh=wEodeUzvHuhVvmDKevz9zUWYiuyS998mChYpO06M1fo=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oOuTfu4KnkZPgxw8IVub/I/Z5s2xJTW9UJ+y5vV5cthNQrYSkYaBZFUTOyfvfHkGa
	 s0Vla2kqbX5LdGvmBK+O/fHnpZRZffpb17IhLmLjURCkO9HhAWpM3ArJ8KEf+d3NvB
	 TxIM2nX6dNadFBKZba97Mda1hFQBMFgOmsnCUIISNeYLKWlpjJ9IGATvX12tas9S/Z
	 x54bbuCCYweHHo8u0Ku+qsfjt9cHaWGWSxLhvtwflamsyTrGfruYE4SNvomQmnT6O4
	 N9r8+lD6SrRBqH8IIfkerxVuRXYLKJBkx+JaS2eIYRHPmPQqcTAdeRo6OFd0s8jvWP
	 c6HJNpXYmumTw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7854580F8E;
	Thu, 30 Jul 2026 13:33:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6F399197
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:33:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6CE3A80F8E
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:33:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VMrzTTpDapoW for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 13:33:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8255E80F8D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8255E80F8D
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8255E80F8D
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:33:51 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c15e62c695cso18154666b.1
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 06:33:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785418429; x=1786023229;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wEodeUzvHuhVvmDKevz9zUWYiuyS998mChYpO06M1fo=;
 b=cuDqEi+HioJ9AYrhlMZpgjqeB3xZfhzRtcJSARavknXjOOWtA42xNwF/ymVslThE6q
 7zc5WN/n1bHhidqhdXmaVrUh7GsmYm1bndj/jFR+OJdpFvK1F0ddHgmKU8JA1Sny7viK
 mZFldLGW/wy1r1L+zwSiQwAAXT8BEHkUsUYOGqKVI7bz7DDrrTSFJiEAJiAhysO8HpPO
 bmpnJThMBs7x8O4KffJntB/jF4rdbp075JbUaJ5vH9OEs9OEs1jpWqH/32O7ObUvYtcr
 3rEFycUg1bUmQ25Cpz+hZNVTB4gmJ1kOC5O2ab1/iqo4aMD5lk65/L/yX3IOgTERosjR
 mwKQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrcfAiBU0XoL/MKsSqUvw2npZdZV2KBDYEaurvfhg8vIN95SL3l5zKwqPk30t0VafolyHG7UCU=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxwahfZQuMbZOvwiPX15J08Q2Y0yus29oZrUS+BYLkNfeaCUcWu
 Iedp51mX3LJ00g3geiigdxTacqjBwh4GPXnL9MoyALtpeI87xpdpJNWo
X-Gm-Gg: AR+sD10bZ5PlnUGBblXDnVrgraECvZFOt3b2zSgfwBd8YyDv3yKv7jhh2IHqmwR4oaE
 mXlJc0zep9Qewg0BSJZWX7uDEwHndtHKZSJjCQOjigGUnvhABYa5Vv3okBK2lwo/QwyeAh/ceuL
 l2f00BS0bBMTXsy22oSGfRd99NRSc7TJzZP/mqedpWHYhvxmsrv5qgWjEYI2fftHldk1F22LaAU
 jjhyoGjRQ9E8P3FIvXn2IOWodMy+kyoQf9FoJy/gIdRYXcdvTnCV+zJ+2Vdb0tJboEEahjzgOFH
 8jUxJR0ngvV0QL8pxARklprl+Qw4jEdgTIKdXE8bSFX8mi8YHyZflmsbw6DjiHv1Kz+yEYMwLkd
 RUcJz+tHC3YwAGGnYtlbomj8SyAMnTJ4nxKRo4elowdfTY2L1lI/4fqY4VYksb5rNnPccqi9Sqc
 NIaQU7RBLX3qhvZ9b3pf6UeDqwmQve6gujqVrHfuIvAkqTsmTr9gC+oO7ZGxDz+h5+SWADcyTxL
 CkjSIEKDI2nwT2Ze0FuFTTHsa4=
X-Received: by 2002:a17:907:c78d:b0:beb:967f:1ca8 with SMTP id
 a640c23a62f3a-c1fbcb29076mr29253966b.2.1785418428922; 
 Thu, 30 Jul 2026 06:33:48 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fa8bf2098sm66005166b.60.2026.07.30.06.33.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2026 06:33:48 -0700 (PDT)
Message-ID: <4b8aa963-7d0b-40dc-a266-f14488c15ff0@gmail.com>
Date: Thu, 30 Jul 2026 15:33:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3 04/12] rockchip: doc: remove TODO
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com
References: <5aed2a27-bd7d-4b71-a6c1-0b46b41f3462@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <5aed2a27-bd7d-4b71-a6c1-0b46b41f3462@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785418429; x=1786023229;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wEodeUzvHuhVvmDKevz9zUWYiuyS998mChYpO06M1fo=;
 b=alMfeyE5vUPCN4vq/NUQ/8lt/PDYBTa4DAup0/jxF8+D7d/Cc7nLJdnscGIf5cSsAj
 DgLStCWObKZ/FzBM6rxNYpaZ87t7M5IO753FXl6aqrBm9xwjdS6B99v2mudwLJWLAhhP
 W/HzsUBma0Z9Tz2jIXS/dpyqa+H5HJmJ22C6lAT5oaCkV37Oii1IAfhtTUlIFzuJOlwe
 vqgUR1jk/kx5li0GpU83pPIvabBOs1QbaubGMgKxNjSwq3DFwaJh5age1GhWv5vLHubl
 JNgEbA56MmynI+vK+enppUmVlsqHbcZ2Y91BKD/K5HRwllVfIF0NO831V6IMJ2Op1CCk
 pWuQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=alMfeyE5
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

Don't try to guess the future consensus. And don't add
a TODO if you don't have the intent to send an immediate
follow up. Remove the TODO in a constantly changing document.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 doc/board/rockchip/rockchip.rst | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index fab1af73b22a..04ea191c0e1c 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -554,13 +554,6 @@ config-flash.ini:
         [OUTPUT]
         PATH=RK30xxLoader_uboot.bin

-TODO
-----
-
-- Add Rockchip idbloader image building
-- Add Rockchip TPL image building
-- Document SPI flash boot
-- Add missing SoC's with it boards list

 .. Jagan Teki <jagan@amarulasolutions.com>
 .. Wednesday 28 October 2020 06:47:26 PM IST
--
2.39.5

