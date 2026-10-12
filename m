Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5492CA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 22:28:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A3E694058A;
	Mon, 12 Oct 2026 22:28:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IXd4SV2r8mvp; Mon, 12 Oct 2026 22:28:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EAFDD40586
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791844087;
	b=cOITsGzzL8GONNHx7O1Zx+jsx3NwPzdhDIk8+6NzVhtZlOpwFKs+sYN/GSY/hBQQURkr
	 lfqq9YKfzIjZtggOAS0eflAcwrqL2rvYWPC4tlL+Ca7Qv4zK3RKw4HEVewAQDYkrgC+jp
	 Cw1W0C33NvNfrn0+u32dL+2KBkglnpjV7EzLfhYLlebebtDo8x/p6ihjhMMOcq5Yb0y+/
	 ml9PXU8IhE/0c/1QJ6bsnZ7KwT9nmor05+IPyZ0QQlaUkklfAB38Q3+34M5U4AddQgCug
	 iBKFHz+Gb8aDjGdt0ZNkV9/75vD+u0mU7hWNQb7IjaleukEYev+znKFsck5YLnEFd+A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791844087;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=d48HKKCFoKyKIwky8xFG9dPXQDbB8WZboCKcM6GJHRc=;
	b=Q6dM7Sn+mp6dWnEwG1qXbff+/6ftu1Sdkmmh8MD4E/rRtHCG1DoT4ePKdmw0mKKbBsvp
	 iIGx7c2VY7/QhbSiklb6yDZpHF0pVRC+i6J10xsFKGJI56Yts/IHXaYJAM8RbZlGNgawu
	 ZVZnaO+6zDzekPBKdfytxryPMgerUgM5xzra4K7omjqeMTt2UK9j+D1aR6NiIMLNkW8mb
	 SygtWc7YD5q1imcSkrwqeVlh5KrzM2dtBblGHIrdl/ETW+Tk05dZ72y0C8O2sbjI2dZ9f
	 h7sWtsvb0LD1egPLlLjw/r8Bb0Bwlujp1uC4lz/Qkd6xegYs4yA5JDfaZANv7PqA0gQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791844087;
	bh=d48HKKCFoKyKIwky8xFG9dPXQDbB8WZboCKcM6GJHRc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TsFhK+QotZ/Hnglu3Y4c+4syUS0Cpf52VtQTuPOkSin6bQvxaSGemb8PxmBtNDnXF
	 w27iX+v7Wcaqr1k6TTxCa/El6mwmXlrkV0rd7EDjLNM5a1IxT27d0+WqD629fuj0Gn
	 DWfP2gAyPHuwyjiDmiTNgNVdfyJ2FLJhZYmSPXP6iIj/JFviCPjj0ioyWqOIiWISYO
	 FcfW3XsiR57RhkKOV+BXcp9z7sr4vh7qWeC7x7V3rA9PikY+/O3XzS8nQxwYby+MeG
	 wEM/hQ9UvJV1fEDALeFsQW2hxbxWfSRYCNJCDixKY95ZOY8aa1ZhjXHkNoarcm7CCQ
	 tmXFuWNY/vAlg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EAFDD40586;
	Mon, 12 Oct 2026 22:28:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 328824DD
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:28:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1876880B88
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:28:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wZ2IeJKx9Fcm for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 22:28:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5C6A280AFB
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791844083;
 b=HbkzXqMb5OEsZuDargy5JTkD3bL/J93qe9quWIT0vi+XgzGHhRhYVIqnYUqjDtVWMNIU
 JPbwfksrfKI16TUhrDZ0i/WZ0XvmSR8bAILF8TbhiHi8OAvXj4CTwUECYhIYWDVg1vfsl
 rNKeLrrA9QqBJo5pKBcHxufUOV9eThvCMvaQ/M7X2CFMOVIBEuXF35i4o3ocTBviYO1gO
 zXzulqgxcmKIY3IWc0C1XvTl6T80g7bNWUqnDL0VosLxoDgWmE3t3eofG6K9Igb0gjJly
 Hy4HuBbceyRBA340Vs3yTyoD0tQDKdYu4cNURFQ7xnowtBCOiLNiy39KVhnXjrOkUkw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791844083;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=d48HKKCFoKyKIwky8xFG9dPXQDbB8WZboCKcM6GJHRc=;
 b=HUpe/GT9wf7yHwhKvMjZyKr8FFyBYYtqnryXwxx5hYhUh6crijjfVzoYbSqakzuQigK/
 nATDzFHPuQc9EHNoLWfCY9zSXLSdKw5QdqwiZT03qTjkbgIujhGf22mO4oTFpPKLuTBwu
 bN+GyKQj9aGevbAizq/SfaenEnklF2SqiDj/i2gagHWf0HNvN/JIxvw3iCi8PKPkXpKAe
 /QJs/okaTL4MidNMT7qMRBj9+B4M8vNQecSpVhFD/dlh/FG+guiL/j4LLNiWnJUQ1DVZ3
 /52UOvs03Cm+XlrXpx2Q0PsnO+yGo++u9cKU4UEOgADMmsSJGE0jzXtSKfTpApCKe4Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=RfWCQhKA; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32c; helo=mail-ot1-x32c.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=RfWCQhKA
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5C6A280AFB
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:28:02 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-825572e6701so1308832a34.2
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791844082; x=1792448882;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d48HKKCFoKyKIwky8xFG9dPXQDbB8WZboCKcM6GJHRc=;
 b=RfWCQhKA2lZ2P4k3klSvX7E3E6g06eUvzeTBRnFknyhj5HmpPffiKzWyWjsUkIs9MG
 NK0eldI4yP47FPclOx9lMx6hhqaVhuhIZzOi/XelgdixDbtQXtMmzZhsFywFVkSshPWD
 /75Ymqq0y2yU0AjIorma9Q9aEqh3CpedDDC5rwAT0gBiXr/CdrxsMtrcmFFe9+O2iYqa
 nlmikO/BBFKeXc44cXRl+IwT+qEuyRvmQm3q9U1DDAZ1a9QWTxLZV7kO3cjf6RCp8pm/
 LeP4idicdLZxsiiMuFbmGr+tHxPfqqH9XzQqMT8VpeSb4DDdPsmlzMkwArzkBuJRrvi8
 LTdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791844082; x=1792448882;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=d48HKKCFoKyKIwky8xFG9dPXQDbB8WZboCKcM6GJHRc=;
 b=ozuqws1R/spsYKg/YwfBCjr8waIdJZIMmoEuQHinr2jfU2YKa53wlzywUVGIVOdLuU
 2TLagCcGrsG7PB9YuQKQ6X/VAGy96b2+pmhxA6TOzAVHpxdHiI9R2ZuW36D0WxuFb47Z
 DoZRlt6tRSFFKrLRZiUJ5JDHGIvQknMKdNk0LuPCktiewEOBitReHLRMfk11PnSTSbVr
 ZaRuubbaU6sPP+Id6skDM3zalebb2mEcQiNtL+eFYXUfUoUm7eAGgauO4YXyKY02rUDq
 7K1Yy3KFdmNbOuy6iFdjQ+getU2JHsrL9XNSTRHnDC9Dm6pyoIksOlDhYTqyRcfvpJwX
 32Zg==
X-Gm-Message-State: AFq9FYLIMY+KI79LyuFXyKTvgsk+cIUhPgNLwtS9y8nYZ4n1AwBx/lvl
 TmzaDKUDuftp3Sbk0reX718vcT09UCMelNsNqZQR+0YeQPuqoPZw+ehEnpKciA==
X-Gm-Gg: AYBFou0OQ9bL54WWE8+uLS0xDRfAHtmj2tzYBZE3OT2l+zRwVu1m4wihVMxcDOnoyoN
 qqxXcdjYS2yIJeUsmyNcFtFYP6l5zWMKNbeqRJT/56T4OOYHWIgDMPKX1IwQ+/mWWKMGCZasusN
 PWN1vbh75mg5iqj6O+WDcTwAHB1cQXEsPCmuUOZ2sbnru1HH7T7U3hobMk3AmOZOZ5Kdjo6yK2M
 +xOBEudP+Xgx7uPHmgSpMUzdP0vC1yypWwcpN5KcYYJsDpxT5lZ85NbbCKm0T5px/IF5DV/OUJq
 clmxjldPd0R3JIkyFJMyQaf8IcvX0nU9h6xIosaHyS4XL7UkbrJwUUxNw+7CpYyH8Z501vV+5JC
 pEZP01VECBeFKA3HRFMaT70e8SMxFwGVFIOX6Gd7k/ZOpToS3bFB1X4Y4bpwdTUCGVaX2EgB7Gf
 9fCFYfqL3dENgITYFLdmRbae+MPttWLPlySOnO3aZrCIKWXJGJfeCxbdqLRBeDtfdx8xZIh8x8L
 9eWsbQ+L2E+f+yIP4keN+ZFbuTC8m1E02p4ImK0fjhRPh6iNMKHxyza1jWlAebQZL5YaDW0yEuH
 KVm/P3iZckDF6dYS+zmG4Glvy//5l4zSWSWNqzCwGG7gfBlcXkGHOh7zzjN//zfGmUgvv10wKWt
 RgmMmViSM0YNsFtc9+k4czZPNjfzBktV1
X-Received: by 2002:a4a:e848:0:b0:6d9:4c33:6504 with SMTP id
 006d021491bc7-6ef125fdb27mr8583801eaf.68.1791844081828; 
 Mon, 12 Oct 2026 15:28:01 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a2a8582a95sm10402859fac.11.2026.10.12.15.28.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 15:28:01 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 12 Oct 2026 16:27:57 -0600
Subject: [PATCH v2 2/8] net: fm: return -EAGAIN for empty receives
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-submit-cpsw-rx-eagain-v1-v2-2-c6a20425c15d@gmail.com>
References: <20261012-submit-cpsw-rx-eagain-v1-v2-0-c6a20425c15d@gmail.com>
In-Reply-To: <20261012-submit-cpsw-rx-eagain-v1-v2-0-c6a20425c15d@gmail.com>
To: u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>
Cc: Tom Rini <trini@konsulko.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>, 
 Anshul Dalal <anshuld@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Pranav Tilak <pranav.vinaytilak@amd.com>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
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

fm_eth_recv() returns -1 if the first receive descriptor is empty.
net_lwip_rx() only treats -EAGAIN as a non-fatal empty receive, so DHCP
can abort on an idle poll now that it checks net_lwip_poll().

Initialize the return value to -EAGAIN instead. Leave received-frame
handling and the zero return after discarding erroneous frames unchanged.

Fixes: 53a0ca3757fe ("net: lwip: finish DHCP before starting autoload")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/fm/eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/fm/eth.c b/drivers/net/fm/eth.c
index f0e7c0eca42..8b44a8ffae8 100644
--- a/drivers/net/fm/eth.c
+++ b/drivers/net/fm/eth.c
@@ -618,7 +618,7 @@ static int fm_eth_recv(struct udevice *dev, int flags, uchar **packetp)
 	struct fm_port_bd *rxbd;
 	u32 buf_lo, buf_hi;
 	u16 status, len;
-	int ret = -1;
+	int ret = -EAGAIN;
 	u8 *data;
 
 	fm_eth = dev_get_priv(dev);

-- 
2.53.0

