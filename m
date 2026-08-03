Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38DEFC55196
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 19:12:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2148A80BEA;
	Mon,  3 Aug 2026 19:12:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8gCxKnnAPgI5; Mon,  3 Aug 2026 19:12:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8938F80B40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785784338;
	bh=WvTuZyZISut7sdd60+LG1tOHt0zI7Kf+SMfZuznLEJ8=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iEtgdffmKexG1lRTxEmdw3L7WVQm2nKiSIYHPCww6ECmVwcucrlXPs9COToGYwfn9
	 2t/Y7O9Q8c85jacusC7fBltuqz3AhRSiKo3VQaxdCHEsTHCtRYXII1mS2M/G01Mbg2
	 TTV1mueFiYRH+lgSDTB+WacAbBt2HY7s8lYvE9IO4VVJ7umyiFHpLgpQQSBfdXLVfc
	 A9rgsSlg4JYP7MbWKRDx1CoVOE3UzHfL9w9HDcLFvbsdQgGZ7vwiC1YYoJZfvEbJPh
	 caq3ruLxqSC1mDcOl/d0fRV9kdfn9eY7d4mESBsJCgL997eVJdNIkxKMxmhwEuHy/L
	 /eqqyWe7o0BrA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8938F80B40;
	Mon,  3 Aug 2026 19:12:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 20051194
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:12:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 066FD405C4
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:12:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JfMU3wDmmC9d for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 19:12:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 38AC7405BF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 38AC7405BF
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 38AC7405BF
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:12:16 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c166ec26696so39304366b.0
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 12:12:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785784334; x=1786389134;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WvTuZyZISut7sdd60+LG1tOHt0zI7Kf+SMfZuznLEJ8=;
 b=YMrtNDt47nq5DWBlYrUgStuG9DWLdiQ2Qg/nTACqefwhucGQRHV4v6XZEfNhEx+nll
 LdU6P2cnkqWwf+oBwr595Kec3o3OHv9wED1OtPdjnrbeWkR6gTrjcPtYaMMasic1BcaN
 wVgYt3CWqruO1JgwnCgwN9SlaoR32DlADCnHEP1a9uTxQHmjzm9fqcmYEYO+atumNdBf
 SRRQITgMjkgMcuZc3jmM3g6f3zoaLsSixLiw5KXDQxkFEeP0Qsnc5mv3NMfVyW35YCdF
 RmH9g3ziqvhEObCUH/uloSvebLa/UlYrrQHjrpT4VReM8/X/d1I6ydujpe7UunLt90Vf
 740w==
X-Forwarded-Encrypted: i=1;
 AHgh+RoQTsT3xdK4I+88YoghlueuUm924EDHNFdozzCtHM1xAJqwSDPWTDpTnixJTwMUNwPDGi7dpss=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzZ3qF/R82eKEpHR5GzvlmX4iGsAKQeloYVVqW7ca6qdZmTV41a
 dn3vHYNR/Vuh5ocG+agk+F5yM1WOCF7LY+MwXKV8bDayBJKFwXG/smYE
X-Gm-Gg: AR+sD11cFcSii7Ikc7pqPw5zSPlf6SOqP6vYtK8R95vS1tR7Wa16juMDGUyF4BjdekX
 e2Qto+oHUwUMn/0ZuPs8Kjaret4lwD4r1X1QrVlvjZlbXUv19Ol4ApQDwOZrWsEtG8S6cB0BH8v
 MoUOb0En47eva4kBC4+PcA72BgHsMTJRvWyhpXsKLB4aP9EmAHvtHAh8pAjZp2FL16jgVhDTGFv
 lXFmM+ksoQNLDe8rp3QOXfgmMtbqLFY90x4O5FraVMOHldGGZ0moAuwlXv5Rp1XIs6y+lnkjtiR
 6xK4GuU5q20li6rEKxePV7pwx/Pzm1JQumRbEJQy+ikeM+9hxAtoDWVsxn0APFd0SPFgII0PbNY
 fL3KmbyqCFwLNsyeF1ZPOo8lMW8M40i2adifH9FMSv8IT2qc2kgFug/9VlxwQQl2vmXXg4dMt0y
 2khlbzvfHMWjUEsKFWlv/N2o1cvoEtEYWiKh/ndVdkS0uZ8Oxu6YMhzsBIlOD2AUd+pvxYj46n2
 niJhpqQgaPEjERPQ5soBEkT9GxRR638HKZj9A==
X-Received: by 2002:a17:906:9f8a:b0:c12:927d:a288 with SMTP id
 a640c23a62f3a-c1fe7ecd6c0mr548292866b.1.1785784334035; 
 Mon, 03 Aug 2026 12:12:14 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fd3c5b8c7sm607557066b.9.2026.08.03.12.12.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2026 12:12:13 -0700 (PDT)
Message-ID: <2ca8d54b-16ab-400f-9e05-a8d2111f663a@gmail.com>
Date: Mon, 3 Aug 2026 21:12:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v4 3/9] rockchip: doc: remove TODO
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com
References: <d15555b5-e57b-4567-ab70-56d48fd4b878@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <d15555b5-e57b-4567-ab70-56d48fd4b878@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785784334; x=1786389134;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WvTuZyZISut7sdd60+LG1tOHt0zI7Kf+SMfZuznLEJ8=;
 b=HH0ygj+FK6ujMZTokbTPdhiF8BbeGBChtogICc92wQ9MnvDNNL4s4DdIaszz24zZ28
 TI7nGR8mo5kD0kpNOBg6XOS/ZPB67hFARhZUhOGabEraELAc4ZgvWyNGrXLY5jwSiW28
 0MQup5hugCbrNe6BzIaiDPJySkZR3K24orgLe/0Q6HzzVlALDI8gPAPBvY5OFn0IBnv0
 AecrALudg9+RUJDfPoeWOg9rDGkDaVg/EH4xQBrBdy6Q6klXSdBeNsYhXxQPwwIBTk48
 xWtHnSjTF4NZbNR+/TnKajtCMVnwCyjTf2bEbz20sdKcOLpttJtE/e12sxJV5cFQCUGu
 cMiQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=HH0ygj+F
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
index d31b6d182c5e..eb8772c5132a 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -560,13 +560,6 @@ config-flash.ini:
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

