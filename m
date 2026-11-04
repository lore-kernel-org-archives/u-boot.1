Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6135606A326
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 08:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=i+ODx1vt;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=Sxn7mSza
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BFE09407F0;
	Wed,  4 Nov 2026 08:52:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3GIWg9cN98PJ; Wed,  4 Nov 2026 08:52:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0491940778
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793782328;
	b=dvH8VrqEN2SWeLev21AGfUIjm5jZqSX9qZ4vO+5fS8VR9NI0Mciu8yxldkRfe99/xZmG
	 70319uwFMQiOR1s2zW5L6ivKQ0CccXuAqEiYxtTjpkbf/rFMAHH57PtvZ0hKfOyw++rSN
	 +zWTJT7AEAIiMZqphgm/pVQUcCvduaGYgelEFILJ3lc2cMp3qBIbRytN8kKJYAyHpQjnM
	 mB5iGw3Fdvhrvs0drqp46Ks3wHAIz3OS7iU5AfYxkdfM6Pi3Zhmgq8ybaTHqwW/S0aALS
	 uVF/BLnAEp1+dKl3RXif77dKEatVTk3xGRS7ueTRdA+cNw+N3PJc+Hmvsm6P1AzzIrg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793782328;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=RtVIATImOvqKbDtl32IREm1HjbjsBEwkypDbdJjK/EU=;
	b=dwxCOpSgPP41dlA/Ue3tkd3OWNpwXrj3P9rWO1e3/oxjHn8sNKisLuQnA7dBe49Xmiwv
	 wk/RXyA7NYWqFrUEFZjcHgG+ik5ejZRELxS3MQp8Hwv5RoQBRW1mocB0V1JSK/luFaosf
	 Dmzicir4XYcEOzJOAW1xhPCmIJS9MBuHrYU3EvZH3S4v8xL/unoJLwVCXH3pyDGfXVHTI
	 HmmdFdfi8zdFMjLpa9KKER+Pr0QFec9+IausZS4zzJqH8nFWow4Cz5DzPw2pQBx+FNVel
	 bb8WQOx/BNlzl4HcDd4QdctMNUtdAgRyaiK+S+AJXu1//I3I7Wh0esOIvqiIwZqaLuw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=Sxn7mSza;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793782328;
	bh=RtVIATImOvqKbDtl32IREm1HjbjsBEwkypDbdJjK/EU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i+ODx1vtWaTUBC5ZtWVfsSkdDkOMsvh07LPKHhgXD6YEdRfuFu5lOdv74tzPA8pHa
	 o/d7/Aft5herh4L2+hIOsGhSE4rEdfiT1EJhA8R1rn39ScEWFLI53Lf80TNbmYmIIq
	 /jS1HcOeHW86u6v5fyCids/cC8lf/gcG+AfDCskPBvECqTPNWSemYiLJfqL+bip+kN
	 M0FB2stLJji0hxf672JZ4ZwjAQf/rG8JPArTZsWW8/LaZyF1tu9oUKcC7XXIklr+eD
	 j41YRc6tplLn0YlL4ZVGVZ+oKMbNuMgnkvsY64ucexf3yVVcFLUOM45coRy2P9HItr
	 1O/mRjFlsKnsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0491940778;
	Wed,  4 Nov 2026 08:52:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4929B2AC
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:52:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 46705406CB
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:52:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id akOXXq4NZukw for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 08:52:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6A79940740
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793782325;
 b=KqeGkkaVkiJ5xW75AuJbnRvMW+ENLN/ch1jpii4xKfkEm/KYbzZu1sLftaeWgWSNH5Of
 vQKWDZC5iWCY9JFbcu7WKBVwUwOBicYSAL0r9zeAc5p29fN0IMX7YX9aXdzJSsKwotujg
 uFzeOUiXFdY+rAmYjkMH7Fh/Ebla8dcaFivPPmxyCtMsCW+8nN3ZikW7N3qo4ElJnsHcx
 KzqqlCDIVbzP3VSJ5HGT/JLKpah1e5BRRcbnDAAgDaYWv0lATI/QLzNZqoy7NbCIXoqlx
 Jx8hkJU/3cqhn/a7PNMtzhPxICTWVJWho7AmZjun+GMoukQjsRSS7k+povcw2xmMnKw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793782325;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=RtVIATImOvqKbDtl32IREm1HjbjsBEwkypDbdJjK/EU=;
 b=eQMK5x0D/z4iRC7fGiwZcwoTx+J9uAfiINLJ/2/TShzop/De2uxjCG9NaWBGR/Br1Xew
 AsGh7EiFnROUpWRRE3T5YtwXu4/B7fxJTWrXnC8JpAkvEPb7UnYVjcJIWQ9qTONMfF1wv
 KvehNqeK5ltst/Vk/1WnAYqUtSH5ndhawvGak8mGvD8PwNmoDZ81VhCINu0lDEqx4u8YZ
 M+JRnMlkeaV2Vj/gJEhZMC4JPAjHWm8FLZydi6X3C7Qpd0VneBkYsCIfT+jpeo1KYI0Ao
 lDyoqXq2qRQ1jmWRT7C6SshZzmCZ7Q5A4JSzDArzuBn3BSXW7rwAqF9tEbbECLnQuqg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=amarulasolutions.com;
 dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=Sxn7mSza; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=Sxn7mSza
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6A79940740
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:52:03 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso3705275e9.3
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 00:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1793782322; x=1794387122;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RtVIATImOvqKbDtl32IREm1HjbjsBEwkypDbdJjK/EU=;
 b=Sxn7mSzaaY2iFwVpJVDxYx7k3W16oBtiy6Aav2tkBSlERshPwP3EQqVAbHtDUJ3CzI
 SUIpE/PdWoUslobPtSL7MC1g7EL/7vnmG4FhZ7aTjw6TBzuiPqrX1lAx9OPPAqVoYS2X
 HlL9BUIT8V1vOEOGeo2XQQVRtpH7mxoTLdENk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793782322; x=1794387122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RtVIATImOvqKbDtl32IREm1HjbjsBEwkypDbdJjK/EU=;
 b=rWRLtQcG91iPUc3nNCh0D6kuuk6ljmXvWVuIKA+qFS1g9fjsVitnfd9hFK3uUs0g7H
 Jf60P010T2zqY67qppRLakYIhre4/5AwTYQ29LpLP+SJq9Ab2H5RvKs/EsULeh8XtMd1
 UlSKSxT3BMQnQ5NtAtlDytTFoe4Uw/dGum08aUuzHfw1pD3sWVFzQOcxdWzvsHi3xl3d
 sdRM3AHhK0IMinloQRXOVzpU9QdX4sU5zC2E3iDrLc3FxUl9LIoVk5KrZJxtZN1UKP9Q
 Kwx318PL9aCbYaLr8Sj1cQg7IUCQ4WCZDVXt3llvK73pnKfi52UsvzSGcmVdTnwvkQEi
 rgdw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxmw19vnan/4KFifdKd02y4qD4s0mKjQMHm4PGDfJSAFRg2+8JjL10kmc/vAG+531cBnVnysDI=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9fHavo+a2uk824O0raTTMTqDiXw4HqozWxW1eSLjplHq2i9uMv
 w6ltRKjDHHzjEO8AKQtAqN2htwI9m5xRfHkZgBRzDjKKpRTzDL3kGTW3J9rjLPYHCjA=
X-Gm-Gg: AYBFou2Xy9sNjfiWzP1hrkikr6NITmCDPq/CFoC5qY8vmmRAswpc/5HjxiB1HohKk42
 BWxuwsh4l2UvLIxt/aEZxl1DWi5OAAfxYXgGT8d1Y6DpG4RnP77HluD5756MkpgLKWL+wyGwX88
 OVDj4rEOlkuCPSPj0pCJNZnKiqXPtdJoM1RdonNpk5LFGHWGpvpmKp3L6UpUNYDWMaG1+Zor0q+
 x63W+I6pnjEWYEWEerc6akyEGzNHAQSwlIRdefJCsZTRqlkIgNN4KFILdX7DVjwFq6u6HDIbcGA
 96V750a5SAb7slzH25EREOcqJKHXMLFK9tlb0J03ARlsufAkdknAm/2C6Whl/FGNtVH5z8aEvyS
 WJ+/XLRzstb73j544e6L3gt5VWqAUynZlqbnzyp9zvyBqjkYMbFC0ZBFaQVgEg+nUMmFSgkyU7h
 yAJR+qcu6YFH2Qb62tRKr56mAu7WKG0Oz2nUJytJjBQ7ylKX/qQjRlE4Igz0C/n+M4JrSXgsAjy
 fDHcFgAHiCJHOxHLkLcdrZ3piXiXEpKLl31rTF0N2s3e//vGhzpreAXyxi0e0Fm2lu/mnsXdqge
 Z9jhLp19BCrv29ndBT2hJ3psgoR9N6Eb98GptFPU83VL8F7ddNVNBGWMGTNXwqnCSn7Z4C15xwy
 cg3gscvyTcRfyu1CQFCaw1jN4Flg=
X-Received: by 2002:a05:600c:4e8c:b0:4a1:dade:f049 with SMTP id
 5b1f17b1804b1-4ac1793ff26mr345945595e9.15.1793782322026; 
 Wed, 04 Nov 2026 00:52:02 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.. ([109.54.139.206])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b413312a4fsm20555915e9.1.2026.11.04.00.51.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 00:52:01 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Tom Rini <trini@konsulko.com>, Yannick Fertre <yannick.fertre@foss.st.com>,
 u-boot@lists.denx.de, u-boot@lists.u-boot-project.org,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 22/33] video: stm32: ltdc: fall back to a panel when no bridge
 is connected
Date: Wed,  4 Nov 2026 09:49:55 +0100
Message-ID: <20261104085036.4012238-23-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
References: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With CONFIG_VIDEO_BRIDGE enabled, only bridges are looked up on the LTDC
endpoints, so a panel directly connected to the LTDC, as the RGB one on
the Engicam MicroGEA-STM32MP257D-RMM board, is never found.

Look up a panel when no bridge is connected to the endpoint. Also, reset
the bridge and the panel when no panel is found behind the bridge, so
that the next endpoint is not affected by the failed lookup.

Fixes: 35be94614733 ("video: stm32: ltdc: properly search the first available panel")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/video/stm32/stm32_ltdc.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/video/stm32/stm32_ltdc.c b/drivers/video/stm32/stm32_ltdc.c
index 267da5debe4e..7bd6724bc2a7 100644
--- a/drivers/video/stm32/stm32_ltdc.c
+++ b/drivers/video/stm32/stm32_ltdc.c
@@ -593,16 +593,21 @@ static int stm32_ltdc_display_init(struct udevice *dev, ofnode *ep_node,
 
 	if (IS_ENABLED(CONFIG_VIDEO_BRIDGE)) {
 		ret = stm32_ltdc_get_remote_device(dev, *ep_node, UCLASS_VIDEO_BRIDGE, bridge);
-		if (ret)
+		if (!ret) {
+			ret = stm32_ltdc_get_panel(*bridge, panel);
+			if (ret) {
+				*bridge = NULL;
+				*panel = NULL;
+			}
+
 			return ret;
+		}
 
-		ret = stm32_ltdc_get_panel(*bridge, panel);
-	} else {
-		/* no bridge, search a panel from display controller node */
-		ret = stm32_ltdc_get_remote_device(dev, *ep_node, UCLASS_PANEL, panel);
+		*bridge = NULL;
 	}
 
-	return ret;
+	/* no bridge, search a panel from display controller node */
+	return stm32_ltdc_get_remote_device(dev, *ep_node, UCLASS_PANEL, panel);
 }
 
 #if IS_ENABLED(CONFIG_TARGET_STM32F469_DISCOVERY)
-- 
2.43.0

