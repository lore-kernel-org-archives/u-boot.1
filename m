Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31781CA5FC1
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 04:22:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 271E28124D;
	Sat,  3 Oct 2026 04:22:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZROzmmBhAOQx; Sat,  3 Oct 2026 04:22:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 35B6581231
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791001329;
	b=sOc/RTg4kHL31ramGW306JuCEobrmiQH7IE87vOxEYsUhLAwS5rg9sXSv+7nEbJJ0CWz
	 WRatENDy2u3XOPDKhno2DMq/JIoF7bHk6K7aW/xEfByArllNpmyoJGQ4nxQfe7HfwTF/1
	 UMe57XFSffo2F40SfuZ8Q4mwO3vubvKqJZL19NTEZKagta7ZLKTjf12YOpnrkBZylZKuw
	 M0TzPDzq6QbMhFr5XdRaE3+lxv6zwwNpVsb69JAf2p6sUyhapgvFogfmV1DTefrWcgEGA
	 rSpC631H/fWeW9YiBwtIkRQOAqewlbMz/kq7rcJZNmI9yX8fywkPvRdvZjieEYSm/ZA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791001329;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=UXIIvaPs4NwWIDBjSI2yVo8/vNW8c0i2RLxjAaMZnQo=;
	b=pn1GbfImWhgR02a1jM60iCBHikR4UYtzky/BH/e/4rHaowP4vyYvylaJ6ObEKlNjlKT1
	 fCXzT/+byMxNXLGFcirdIRHQOZRWGsDusyiKdJYZqcSyEBbp7KlgzzyedexZ22RtpJPWr
	 0LYFgAxh9QZxmRVAYWhmBOXIKC7XiZ/wjNkVb28+94ssOwO8vBc0IqGPHBMJwITh4OooK
	 SeZ8M5AtxFc4I5B1LxQHL+KVlPRl+xOo3i/2tVlo/+QuaslZPyfV52lbvDrhTzg/5ZmBN
	 naW+0U5HRFG82Axb8T/QHOubY6KK9wdh1+QEh3sFrC97+aM+u52Jt5n4Pam59LmJdHA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=l9cE1jwW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791001329;
	bh=UXIIvaPs4NwWIDBjSI2yVo8/vNW8c0i2RLxjAaMZnQo=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=1MjwO2YDvvkVJJd8wvqck9qWdHzvQft+AdipPFkuicWjKtWPDkgr5aBaLe7wp6pSK
	 VHS2TKVQSGklmIfJ5Q3IStwYlnfrn1y5B2uv1DTuGOff1NqFjTJk2T9FGfVV1ey+7h
	 sb6iIC31SxcDeJ+eWhC8AA80IT7uVtCs/wdsK50zzcW84jQGg+c46/WMktx7StGZRV
	 Z9s4ACd+olXfscfOQDbj2US6oEDBDHjrnrL2vWMm7jvAj9B4I4vLs/AFoLmPkL4wmh
	 Um5a72xrv4WGRZ7N7MnK0U+I/9GhhynI/1MLihzT0ZEdAFKF/UfpWCKUbdLzQqrFFd
	 hzN7OAr1HKakg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 35B6581231;
	Sat,  3 Oct 2026 04:22:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C992934D
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 04:22:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AECAE81231
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 04:22:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ypLmincXRhGA for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 04:22:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C27CD81089
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1134"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791001327;
 b=njyJA7mFJ1bF1g5aFtaSlZH1ZXuUJjquknW3XesK2D0RwLaOaOAv5B5I0OX2a/bWHSXn
 6IYEqu7B+aKAQU7VPauJBzUm8Ncod9ziwihJRWMvOZnl4tpT8qRFiF70cN0i/y48ebLXo
 9WisXuZ33FifpHt0Df3NtctlOtaO3H3eC8CfAjBLPWyn1DjoeiDUElQeUuQqC7ZcCFEqC
 rRz57CSSiMXXyVSMxA1C73x9mHHghThckwY16t9mbjUHm0GzFmRkP/2FZc5Ui/c9frKYg
 OPEiYxckd1ZoBjO2BYga0of5TuDLOsOitiC5ALiYPafvAZ7fw8auU8p4HLK56WXk5RQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791001327;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=UXIIvaPs4NwWIDBjSI2yVo8/vNW8c0i2RLxjAaMZnQo=;
 b=YMOoxM3f6MJ7TYKT3Uq5Nt1Vf2hWqIQOrezDKm/gJW3lGgN4j4eV2l080MYeKKw9hYO5
 LDMTSegioNtzwGJSv+NKzwJ8+pDSR+h+X/KdKNFi84nZzc8YEkxpFOegmFP+zKCVqhnFp
 VZ0kduMupWKlY0TILFBtVcWZwZbYiOQ0DQZD9AJMnWKkGYCEgQFJF5f318e7ymFOaJXuc
 V+nPDAd3lNMdQiGG7izC7QaF/9+iaWLlRXQFMSRmaV8fLVA0y4DqbFKAJmwlCANi8h078
 aD+o8RkLvckDP5LWO1J5JBg2iywx71KWjiu5l4METdHYs02de6EG87aB/Zsy6lQ6XFQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=l9cE1jwW; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1134"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1134; helo=mail-yw1-x1134.google.com;
 envelope-from=mibodhi@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=l9cE1jwW
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C27CD81089
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 04:22:06 +0000 (UTC)
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-8ae9bc9a2fcso278297b3.1
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 21:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791001325; x=1791606125;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UXIIvaPs4NwWIDBjSI2yVo8/vNW8c0i2RLxjAaMZnQo=;
 b=l9cE1jwWB/LTq3Et1AUvue+HSVPMR0vCXNKWf0z7fWHgxpNVjqVsZzex7jCK2BLcxU
 JeACF1R6hH/qLDECWs/Q/If7v05sdotRW8NsxXFe2Svt+/WedMJGTmJvcg8iEEScjRWt
 xpGRvmL8Ftxh5N+iFuSjfJpVUJ+UxoKc0GtM67Yf9Trkeq/MG7Z2vQWBEZDFdS3T2fN5
 gkUVqx2z1AH+foxFE0y8AQ7IOxSFUg4ICK2aW2PMOBAqeOoSEb34yJkOUrl3l32UyyFO
 l1lXDzTrdCimg4SxI8r47Sy325dKklOsYdiIto0EEtgw5YPP2DQq4tjQA2but9oMrQnK
 20IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791001325; x=1791606125;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=UXIIvaPs4NwWIDBjSI2yVo8/vNW8c0i2RLxjAaMZnQo=;
 b=UqjPEG0M2+GKFY2uvlmfE+KMiZqJpZpRI1ZsrlAp4xms/MtItse164HdUsi9qFoRNr
 JVVZAJFvAY5VY7KR1NL4jfHNZZ0PHSNblHUrah9/1gCoLxULNAgM9rRzeQ673bifzsPs
 t8KmnmNxSTS24r/Pkv85qm7V/AefuS2CLRjYdQQTq4Wf09gEvjDNM1GgckOVK5U+OXBl
 Ld85A/XDvX6Ve3RldJ1K+cIjQdhCnJ2ySd+Rkn36C414jUmoB/kaMkVf/guoHg8csATI
 dqlWG+Jb3zxo81s9UWmZlomk8na6TRVrar2r9slpbsytznfv4WpqyUPGyBvU/i13nY8Z
 y/2g==
X-Gm-Message-State: AFq9FYJVuPFPggOMpKbSWAMt7MDBuPi/iMAkbY4qbMO3pCER0G2Qti0e
 3OoEW7VdZk+w21ZYEPl4u19n+kEC1zJjB4Jgs4e9G1XyE43G+jUKvSVr
X-Gm-Gg: AYBFou3b+U2OjC428tpfQKqHk/p4eAAQJDIuVbdXvWdA5b86riN0g/OGXhMne7+/fIh
 K+chyZJoHXQrlV3fXnP3STGWnW2rABfAeAgICN+ao8HwmYOu9WKHWtZ43v2TCy20F/U3ZZrAEDl
 vH7hdfFODxG/ZsOiIwDkvVbl6DAeJX9USmo8RH0jQURR9ITaJDjevvNorpIn88Vm978JPJcYF8x
 Pb90nsmg1ebIXjhO56f90vcO6Y0fE+Yyhi4PMnBZIwW2f5JYVJz8Rnxqj4uxKsBBa7ozZrfijA8
 SM/f5pjBA1nseMVehm7Ot9X64fD7L+gtiI27goy6qCdHs9E5J91JJWmQylCBGskzQjcGxQdWE2h
 0J5RJzeH5tAcFfYEXXpxp3olraa5LboPoPU8xiOu1W3M6Qm4GiQoSNWR3Nd/+H7zAyn8lOV262y
 w/40/59lmxRJdDBmrehk5atOD78IyoxFpJPODA56A4N3qnAQu/FsQXyv5qO3WT7AmakrnIf51Gs
 n0jrBwENAIm+od9+06NMtqKRyPf8v8kLTqbinXqlprI2SOKF4Nr4iqvsVKN
X-Received: by 2002:a05:690c:dc8:b0:8aa:357d:e43f with SMTP id
 00721157ae682-8acdab6c4d2mr42486547b3.4.1791001325319; 
 Fri, 02 Oct 2026 21:22:05 -0700 (PDT)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8ae32cee991sm16953657b3.24.2026.10.02.21.22.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 21:22:04 -0700 (PDT)
From: Tony Dinh <mibodhi@gmail.com>
Date: Fri, 02 Oct 2026 21:21:48 -0700
Subject: [PATCH v2] MAINTAINERS: Add missing file entries for some boards
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-maintainers_file-v2-1-74a0f9963b19@gmail.com>
X-B4-Tracking: v=1; b=H4sIANuCwGoC/32NzQ6CMBAGX4Xs2ZpuLfJz8j0MMVi2sAaKaZFoC
 O9uwbuHPUwy3+wCgTxTgDJZwNPMgUcXQR0SMF3tWhLcRAYl1VkWmIuhZjfFIx9ulnsSmNmmyNI
 807qGOHt6svzek9fqx+F1f5CZts5mdBym0X/2nzNu3p/8jAKF1ShTabTCU3ppo9MfzThAta7rF
 49yLgnCAAAA
X-Change-ID: 20260918-maintainers_file-17fd9758744a
To: u-boot@lists.u-boot-project.org
Cc: Jason Cooper <u-boot@lakedaemon.net>, Tom Rini <trini@konsulko.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, Tony Dinh <mibodhi@gmail.com>
X-Mailer: b4 0.16.0
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

Add missing *-u-boot.dtsi to MAINTAINERS file list.

Signed-off-by: Tony Dinh <mibodhi@gmail.com>
---
Changes in v2:
- Fixed b4 quirk with Signed-off-by
- No functional change
- Link to v1: https://patch.msgid.link/20260918-maintainers_file-v1-1-f41050c42135@gmail.com
---
 board/Marvell/dreamplug/MAINTAINERS    | 1 +
 board/cloudengines/pogo_v4/MAINTAINERS | 1 +
 board/zyxel/nsa325/MAINTAINERS         | 4 +---
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/board/Marvell/dreamplug/MAINTAINERS b/board/Marvell/dreamplug/MAINTAINERS
index 6bad3ea78b2..b9262043e26 100644
--- a/board/Marvell/dreamplug/MAINTAINERS
+++ b/board/Marvell/dreamplug/MAINTAINERS
@@ -2,6 +2,7 @@ DREAMPLUG BOARD
 M:	Tony Dinh <mibodhi@gmail.com>
 M:	Jason Cooper <u-boot@lakedaemon.net>
 S:	Maintained
+F:	arch/arm/dts/kirkwood-dreamplug-u-boot.dtsi
 F:	board/Marvell/dreamplug/
 F:	include/configs/dreamplug.h
 F:	configs/dreamplug_defconfig
diff --git a/board/cloudengines/pogo_v4/MAINTAINERS b/board/cloudengines/pogo_v4/MAINTAINERS
index 35fd7858b77..460e95f958d 100644
--- a/board/cloudengines/pogo_v4/MAINTAINERS
+++ b/board/cloudengines/pogo_v4/MAINTAINERS
@@ -1,6 +1,7 @@
 POGO_V4 BOARD
 M:	Tony Dinh <mibodhi@gmail.com>
 S:	Maintained
+F:	arch/arm/dts/kirkwood-pogoplug-series-4-u-boot.dtsi
 F:	board/cloudengines/pogo_v4/
 F:	include/configs/pogo_v4.h
 F:	configs/pogo_v4_defconfig
diff --git a/board/zyxel/nsa325/MAINTAINERS b/board/zyxel/nsa325/MAINTAINERS
index 013cb84b99d..a1c97fb4577 100644
--- a/board/zyxel/nsa325/MAINTAINERS
+++ b/board/zyxel/nsa325/MAINTAINERS
@@ -1,9 +1,7 @@
 NSA325 BOARD
 M:	Tony Dinh <mibodhi@gmail.com>
 S:	Maintained
-F:	arch/arm/dts/kirkwood-6282.dtsi
-F:	arch/arm/dts/kirkwood-nsa325.dts
-F:	arch/arm/dts/kirkwood-nsa3x0-common.dtsi
+F:	arch/arm/dts/kirkwood-nsa325-u-boot.dtsi
 F:	board/zyxel/nsa325/
 F:	include/configs/nsa325.h
 F:	configs/nsa325_defconfig

---
base-commit: a6ab6a66146ed0bf1420db0ee858b49005783222
change-id: 20260918-maintainers_file-17fd9758744a

Best regards,
--  
Tony Dinh <mibodhi@gmail.com>

