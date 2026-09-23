Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3014CC98304
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 02:56:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C855360865;
	Thu, 24 Sep 2026 02:56:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Uswv5-UFtwCV; Thu, 24 Sep 2026 02:56:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 10FC86086B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790218566;
	b=lVmQ0PnhWNYaMNPLZliN2YQ7qd4s29MAZmmzYnd2OyYE7gKlihfpPnkTgJnaAjHvRUQM
	 4Kb5n6Fh1QlBpRPQYAJ+m5zXP9WxsK9S83zNFtsvvsZOzoGx7ZCX0VhP9iyXMqkxjCvQx
	 fMWsllVsft+nwdlt3hBdPaecwMr8f8l1ciNQMvMbAfNzamxZngQYZvl3+TlP3QNkVBjJ8
	 OUEgIEJWg6n65Fk71IvU4X7PJZPx2ON9hmYAQQi2YWYRF7juw16ItyzKz/9htwGTT0E4c
	 H++3EqlW9s1QFwFiwvybIU+dQ5t88Bb0gegZUddk3gDQCkBaUVj5p5/a19L5Fywnuzw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790218566;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bK0Q3tDzNGQ08rGY+SsdLUwefUiR9uLt9yBgRwgroFA=;
	b=iE6S+bi/o+OINwZdLmDHQ5PyEsFGbSGbnUd9V2fJPeGQ0UqU7hyr082YZH+QGSH9c/WO
	 39QwQkX2W7/FH5VaYI2ON9MzyHmWMuNigd+SqX0HV+VcDP63d4w5c8TnuLcf3Ogyz1yew
	 lLSJo7rMV1Fg841klIIfJwj/uqvpkeP2DiX99VDyH5c8grNLMYRRhcVSeSCnuhdHYx6p0
	 vZjQsNzezCnrSgUXVf4OmSO7mN9tqk86nxF5fFtfwUxw4ZdBugDIfRRmuHtcz2e0RbgM5
	 x6gJeX+3O5JuyuSjsptvAGvjhoOHjGtT60dvcsp8TqMjk1j+yG/+bmmEzgnGXaes2xA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790218566;
	bh=bK0Q3tDzNGQ08rGY+SsdLUwefUiR9uLt9yBgRwgroFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I2SuiJtmmbtEr0rEe85CMGQxokBAvVI2zmyuF7yuZDGnJHTZGvaDsS6FYWdM5CGbN
	 6VO/2M28fcA+UpATWopTmYkiu/Rbp3H2RJf+YMHcNPS8/pRvaDYE5Mu7qAdirMdl5M
	 iNXRS1F1WkGWWYFAqZZgKE4mWf/hfVwCRpMYvaxCfg6iBCjp0tEnLxo2kepx0cKGQR
	 JjsRpSPy1b7P/FfAkwDd6raMMlixGrrQhfHnfdljgCpbtglWxbQScVwnN1C31kAj7b
	 +46MT+C00p6TKHw/tB457AW+ueQIdqe9lirF21K58XE9himj3kllygL2NYl++ATjaH
	 ZgXEeoHdozR3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 10FC86086B;
	Thu, 24 Sep 2026 02:56:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2828B2F5
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 21:40:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 25BA7821C1
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 21:40:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9KI5SK8jLtkN for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 21:40:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3CEEF821BF
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790199646;
 b=QqG/2VbLnbrfHSk72hjb2BeML8c3oAfZSYiR/XJoJVVEdzhn0WoOxbKPXvim2SIG4xgQ
 nR6pS6iQs9YJS9QrmJYoR86Izw9PWPTy/0jCMajMulVJFVcsTK4P9A/0c+iXaGhkmCZt5
 N+fKhm6zJjGW49e0YdAmcBqsO6Zkg/J3h8BjGND5udxZ0cyFyVXx5iYVm9KV6+zUzf8IW
 MS0NEGZzDQ6C/mMQPbWKmPPdoO1HZZ15moysXZTkBobw4HID0Qe9PIbK25kAs5zc3K/PU
 m5VDFPZcBWXnc0u9X9PZYE2fdvbPI/tzjBzQgMLsbNXKxpLQ6zzY9tKdLTphnnYf7HA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790199646;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=bK0Q3tDzNGQ08rGY+SsdLUwefUiR9uLt9yBgRwgroFA=;
 b=mELlrhaioDWQ0hkyUaBCi/uxr0IVac6w8mhADGmtUgHa5hPk+PrcNiXvniXQDikutWcm
 nyLQDQQPVr/YuVVMCyaPEHkdr+Ml2S/0nokAIbP5bGTSL3JbczHNAGCGE4Kd74S6mh+bP
 eTC8jCeFs6pT0B+/eyPR+Tk3DMGyCRVF8btBzmsssI4f4QHXVR4x1Wu/NNfjrI6vbuKdI
 NiS+oxU8klcpPn4dM0bGb6wA9f9QrTZU4E+tvEieZHolKkauK3w1Nv4vHaB4IwV/F+VJS
 SJWJbxBV6ip4o4yNxy6H9C5yWsGLmEY4B5V0879h1a4Exp8jhcrF1KkkmGcf6TC1HXQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=XF7AsKFR; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=joaofl@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=XF7AsKFR
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3CEEF821BF
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 21:40:45 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-4843796e373so976985f8f.1
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 14:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790199643; x=1790804443;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bK0Q3tDzNGQ08rGY+SsdLUwefUiR9uLt9yBgRwgroFA=;
 b=XF7AsKFRHB+AjvLrJ+h+VIX9E1X7lJx14+MhqtsVdMIUaf8vHWWfUXkPAAf5YoO9Vm
 5+wf6diqvQOB0tbZXlGXk+/djxMaus77dGOYvyOY3J/B1VJszpzxcXt6Nio709I3v5JL
 oiEn1YRHcjgwIkcK6ZcRsDHjWdNDP+uL71R6ffze3dZOLaCqPuh5fX2v9N2UIOCYBgRD
 2knJ1odh0uZV559TOlZSkeK5SXTYLMz/AzQGDyLalA7g8CuM6AD7JYr9JmBgcgPvrsRw
 GDYP33DfIorvcJc/wude/63TYv0wAunZHb/MBiwW74Y3bf+PI2rOB4wcfbHElp1icbna
 PyjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790199643; x=1790804443;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bK0Q3tDzNGQ08rGY+SsdLUwefUiR9uLt9yBgRwgroFA=;
 b=fvLhApmpTZY8aOpe7DDyXElhRe1NER5hNFZcWP7XeGllMC5QlxU18MS328X5XBpRyv
 khXV9WUH+p3gmn6h9Wu9PoSFhxSrvGPqFlN2ZhaGOEV0JNObI/pSsdNa4sDOHafB4e+4
 0gOtO2Xm61+HQiQJIOBU3Mq3dGZjcOpkCQJaPuFFdBZir3Lhi06LTL605TuypKF9E8zc
 3hhnE4ACch+Oplj6aiJ3WmYf4qZsv4DgYMExMVT9zn+lZjevgofrZ3s4bxmkOuoZakdY
 v+tS9S9r4a9t56qAb6BpqB833Jmg9eWrYtlaFxNUjDvssRkAGInlIZG5LhPknPe8clSI
 sV5Q==
X-Gm-Message-State: AFuF++ncTQuKA5JYOIoHobVCEnxDGFFDn0UQF+KEAjRaQ21KVO1I57AH
 MOBzh2AaB8zNjLVqTg5S3GM0opopZcDgszx6vZ1cxss7y5hJtFCXteaVTPTCKwIwpeI=
X-Gm-Gg: AYBFou3XzI9HoP2t2lGAmK5c9rI1iSZ2Ffv20+s+8qBX05VS+KGXcrk4MM64sEENubL
 TUlq/awdZoZqex2fOxxL6ddTv7iYLqpPpZmpb4L7VokQCLuccCliX1LBCZJhFy7AOZ2d2aNBmth
 UY9BBXgR7TKzzVf35X3LTC4kpIJiPQTVvfRlT25ANiV7ZvH+OgpH2C5XszLdj6fYFF8z7Y4OngQ
 QBjE9sV4uoGHM5Rifk1m/QvbhQsYYCET8kznUJynX2qUSv9kto413R+R0us+YiJBnC1cXvQBO1O
 g0+bdpX6mPGlR1Yq73104tvtaZZyBLKgxcT2e7CenvsNwv3nNsGVv8MCcR2392ieUL7s63lT6Fn
 fmacV1X1aNnc0qwlD59W3oWnFdwsiC6vmbSsNJ2zR2b+LU+yej1WPk5uMWWAvYjiR/Em/A+d5Z7
 flQozbZ2N8GUKnuCqgklqK3A/L9VUHw+A9l0To1qRWxvGUpDKt46qd/cQpjk9zC2Cp3Qjw5kOM2
 qJh4e/GvaVkRiYgJ/nXOYNg9StrlUMGqe2yk7JyP4yStGGGBGiQwyK9pnNHzNMmviLbrw==
X-Received: by 2002:a05:6000:2906:b0:487:ff1:6274 with SMTP id
 ffacd0b85a97d-488716b290cmr809834f8f.7.1790199643530; 
 Wed, 23 Sep 2026 14:40:43 -0700 (PDT)
Received: from rrouwprlc0373.. ([81.172.79.249])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4886876c119sm10309950f8f.15.2026.09.23.14.40.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 14:40:42 -0700 (PDT)
From: =?UTF-8?q?Jo=C3=A3o=20Loureiro?= <joaofl@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org,
 =?UTF-8?q?Jo=C3=A3o=20Loureiro?= <joaofl@gmail.com>
Subject: [PATCH v6 1/3] test: dm: sf: Get the emulator attached to the flash
 slave
Date: Wed, 23 Sep 2026 23:40:28 +0200
Message-ID: <88953696903a971bc7043628fa2a33a95be794d4.1790198142.git.joaofl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1790198142.git.joaofl@gmail.com>
References: <cover.1790198142.git.joaofl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 24 Sep 2026 02:56:02 +0000
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

dm_test_spi_flash() picks up its SPI emulator with
uclass_first_device_err(UCLASS_SPI_EMUL), which assumes the sandbox SPI
flash emulator is the only device in that uclass. That holds today only
because the flash emulator is bound lazily, on the first transfer.

As soon as a second SPI emulator is described in the device tree it is
bound during the devicetree scan and so comes first in the uclass. The
test then hands a foreign device to sandbox_sf_set_block_protect(),
which casts its private data to struct sandbox_spi_flash and writes
past the end of it, corrupting the heap.

Ask for the emulator attached to this particular slave instead, which
is what the test means, and which stays correct however many SPI
emulators exist.

Signed-off-by: João Loureiro <joaofl@gmail.com>
---
 test/dm/sf.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/test/dm/sf.c b/test/dm/sf.c
index 3684d021709..0ec02ac694b 100644
--- a/test/dm/sf.c
+++ b/test/dm/sf.c
@@ -50,8 +50,13 @@ static int dm_test_spi_flash(struct unit_test_state *uts)
 	ut_assertok(spi_flash_read_dm(dev, 0, size, dst));
 	ut_asserteq_mem(src, dst, size);
 
-	/* Try the write-protect stuff */
-	ut_assertok(uclass_first_device_err(UCLASS_SPI_EMUL, &emul));
+	/*
+	 * Try the write-protect stuff. Ask for the emulator attached to this
+	 * particular slave rather than the first one in the uclass, since
+	 * other SPI emulators may be present.
+	 */
+	ut_assertok(sandbox_spi_get_emul(state_get_current(), dev->parent, dev,
+					 &emul));
 	ut_asserteq(0, spl_flash_get_sw_write_prot(dev));
 	sandbox_sf_set_block_protect(emul, 1);
 	ut_asserteq(1, spl_flash_get_sw_write_prot(dev));
-- 
2.43.0

