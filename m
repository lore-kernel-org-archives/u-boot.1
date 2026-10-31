Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0873D606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 09:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wMmiElaf;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=FOtR+LZ4
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DC750811B5;
	Sat, 31 Oct 2026 09:36:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NaceRN1IQ9MQ; Sat, 31 Oct 2026 09:36:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2E23A8117D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439377;
	b=tTVnV9KCiaPD/5FduK5DYnchM9Ch4mL5Z/jfZ6lUtcY9s9KWmj47X5sDsZL78T71edo5
	 P0lJ8IvVIcY76RFuk6UfDUSySomCTJyMwLhH3XkiemctxDLY3L75+U7cHZavagDWkMwJT
	 xBM57OoHcw72vF+A+up8to+2BDDMetvGUTn15zRbkyHYJs98SuIj8uvKvj1yDgH506rQu
	 O81NV+MBvRjDj/wMjB6CmySZ9cVZjcLyN4VhsbpBm+SX+aJQ8EwsQsxCBLEq4qDvfezR3
	 Nj2sDEkLhS3g3JCUZX1xQlzQAEJxYIC//N1Z67WyRk3YVDdDhi1+MF08jKUKqvCvF7w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793439377;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=T5HxShs6x5euafT3/kRqyM/k2FVSY5Wck/nIalIDidM=;
	b=NoD/ZfSDDsWKO2B1gv1kYlIzywr8FJ563VngqJKbEzuN5MMh0VV8LSu4BvD00b1E2B9J
	 372TdnNezQQAB1Tuwhys6f1OERDaozG03Mcawktq2ATa0gJity5LzfXlUcZFiKLYwMOl9
	 Bahdq+ZVAIV9VTqaWESti7bHl0WDk30/KHK7bGkq/nrK69k8GRUfxFxO0lTm782ZbvQ9k
	 ZDg6XO3BQ6P4MEloQ9oVluIvpv51GKbdRSwnx+8bDXnTLx9OQlc7jxByBgmo9ZPbgTAFi
	 +GpI3sSJ7nJvVF3JqjpZ/Myoaz4jRM6j5fAPPWSGTbNnDQUlPJYnGAFoZETX5xWmsPg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=FOtR+LZ4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793439377;
	bh=T5HxShs6x5euafT3/kRqyM/k2FVSY5Wck/nIalIDidM=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wMmiElaf/cUQ7C8Ti2l2YUGkgFxESeAfKJv8Wq2/GNfGhBjGpnrybTe1XLLLRPEME
	 B4OVJ5zoFYhKrdG2vmZQDZTzt8ONAveFUHkHAvVT7DgB9TtH/57yPYpqmAlXWtyOwO
	 pE3oQGdYHxy/PJxT4u99LojXqX2enYxLRm/bhTEgQ8or1cz0IAe82WdPW14T/ous9F
	 kq0g0LCFF5d+7crVY4gqCcIuDmmuHRGYtPl2TQs3b6EFtpEnpN2ndmWeMrfv6N5qma
	 kaXN+oCMGclrp8WjB/AQTQQ6Ob7Q4xaSypADGZBnV8c5XYsWS8GYMex+OwHeDg7pjJ
	 dfFp1sNxR4yDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2E23A8117D;
	Sat, 31 Oct 2026 09:36:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E3CB529
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:36:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0035D81177
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:36:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8S_7FVshomil for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 09:36:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1C0B381191
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::534"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439361;
 b=Ka97MwuMSZ2QIMAaO5aqV2xaUon2DqOTlYKgUtNnoibMqmKC+DCTpEBETwTYse0I8XRs
 wg62gzOgQ44xnYnWC1YitYCH074HIYlb5/kSLOjWkzOQwQZdha/1y5usZLhQSuf3BwJ1J
 aXNO7fKFLW4y5AN0B5+v+0rJmWBsu97vbng69CuvQ8QUZqWor/JkWEFaLkANrf7Zj299r
 clcO/NX6BRb48bgL8d7YAJK9AZ266Q+eCL1eMU7/Yp13h4MwMzw12yCj9ETlDty43xc0Q
 wThlDG46zZjivLVpKNtu7AJOTEJo0XSx8Chfez3Db6vYTfQ3JbweLDJ4k2c5+J9i9Hw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793439361;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=T5HxShs6x5euafT3/kRqyM/k2FVSY5Wck/nIalIDidM=;
 b=SX+OdMVf6MWnyWeNOdoM+uifOb1x3cduO09+mww1e/NZFWNMjKA/4QmOMsVuc3IznQYH
 RItNggWBhEgTlQWjUDJIASDy/Wt17Dr1gCsXTxg3hUFdfLoORjvdHoQyy3ntzoHYeiv7E
 huOYn+Ali9zbLrgpP5+vZwGuWpaJpH5E29LWUHIpdNsT1QocciyTjj3KjXfazKEKni6eP
 6G6c0dQy3E1Et+uvWIFzOQJgB01i+o9rgd6BAH0AiOSO2lcG+QPm1W/NxOROmbtGXyzzO
 KPjWk32xceVS/GkhY7f/bAht/SVvyDQxfHBWMoOyXsLyRScSxpw5EC7H1kH53ekU31Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=FOtR+LZ4; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::534"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=FOtR+LZ4
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1C0B381191
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:36:00 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6b4bd3d98bfso1705008a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:36:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793439358; cv=none;
 d=google.com; s=arc-20260327;
 b=ElbP4+OxaZx4nomH9MU8lIv6hB/MMpHLRdG6KRGcwnLDJeKUAzPcxM64ytmoXYqAG5
 gQbZ/IpVRoEQXrVOx6tEFMqz3ZQ4c2hYVfRZsWCaBK/HOI4MfazWJRnHrfQqgUU+Gf33
 caFj5Mq/EJzQoIbr7jmCp2ErupFVNAAd/Wo1cqgaeCPtQCRzDQygFxfheTBK2NIVQ+Gw
 ztoXj+tT6PeIW20Zmf5vRdQ1ke7qY2w9o0/NuT+6cvfuxrZGZaL2VFGed3PxOajSi20V
 JQUCd+BqWmXPEVs0FtLLXzNDu6myIDnbZgKZrVy/rP0C66du6nIjqyUu3+gdwsP2TVdA
 hJ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=T5HxShs6x5euafT3/kRqyM/k2FVSY5Wck/nIalIDidM=;
 fh=iKSK4gTmJc7xd1h/743wsz+O4H/jjGLKIR0LwtE36PE=;
 b=TrXFZgk/cf0N/HAk/m/KqZRn+Ri+f5uNezg2DTe4FtygLbcIttRanjaPF6iAI+v8Fy
 cKbQJ4EUIta7sgcWhgtlw3s8BLccq3jew2YITMZUsHeFgS0bxnZsAwNPhGmjpQpbgs1j
 fVP4hoZvxk8nKs/VwiL7Ci4uf9XvCAnqiXWpvcIK1JJiMvX3Z61+YV1oc5X+jmTI6cLs
 KGKxmcot/EEzhFM3FU0CzSImlo1HgLw5/rCE1yI7S90xPBhe4A+512HHDN4FEoZ7bjxg
 BtJtDh6W/k1c3ZbeelzVPHNaELwCwxB3QrbchyZF9fGJzZeFjJ2iTTMBlnVPNnoGkSQQ
 7syw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793439358; x=1794044158;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=T5HxShs6x5euafT3/kRqyM/k2FVSY5Wck/nIalIDidM=;
 b=FOtR+LZ4HVnYyzVXzqZ9D4bpfWkpZ45UTllkZwGof2rjE/tBRNpw+ZG3QksCAHaBSc
 8zRpyDUv7CQE+hohwpxpsaQ1ndV0+2mSJWVnrT+ztgBio1z4NSKFxm7vSlC4/HZMeSgR
 4V/N7dmRprMfqbv0s7JmEt0D+BouULgtvSoGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793439358; x=1794044158;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=T5HxShs6x5euafT3/kRqyM/k2FVSY5Wck/nIalIDidM=;
 b=xppvt8cJEiUrFHqLKhdirhdRo834/PAKmNDnskZ80IPOf3XqPKICQ1XxFkELiw/+26
 b4vUh+X9BRqc7U93LtqwX6e6eXvL2WK4uUpphuiX0Xj+RFmS3gR+OGfmIK4MiVodZYvH
 Ocqfei3zwYaSsaYGBeySuyyEx0xjyWa6fleGHBn3AaLH5c+G16/f1Q8pNg5VoqAxM0Tz
 iJoT21CXp0jps311DKxexEWGmAHn7+6yevLHtDcZIJMWBM0sPnl2f4Lja8LYOjGa2vpt
 MZKzntZ1mmKmMlJH/QxBF1gtpLbdjnE4ReRjt1pkiaOIFuKdZdmF3CeI8tpRyqkdQy7t
 nq7Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwHO57CCtb/nmc5f+bcQweR5smsWRKskmD+rGTe9Q4Dx5BWEhIxkXFK92dCcCXYDCSX4QIr3F0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKfX9PFXH/DPZviGIDXaz1o3qPd6ckT3DATFe+iGvfrUmW2ehz/
 xonXoc3Fv7AWDYdL879G9kbcm2c97MzHFQsNjv3vKO975nEZXEysxgC2fsBzYoMxEDgdrW+iKuF
 hIoFg7Wy9INiqT56FyVZo2f0FTMSOlNHOnJ5YCcIv
X-Gm-Gg: AYBFou0MCBXOhlaiEj1pUTvGG1U2VXKp3mwCRhhfcF0TG2OCI7orUw8wg8YwOW1UJky
 vu1tpl8zHqDOKpnvVyjLUq0y2jUat8hGrwGkHOw+/hfEYBqQKlxnObVljjKg4fHlQ768/h/xjPR
 6eeRd7GFNsC5NW8qtY7EYeSJQrywjpOGIAMbzBP5yG+YT9CKofL2KgS+VKdbFEK0E65l2CkVlxG
 LU/os7b1Km1rUiCkXxodK0W28jSr5AejX4ESbnkQhbVhdffu7MI3XoKBwb/cLK/pJ2feVXkrBDW
 Mj1GzBq+RXP+LMI8+OjHwtwCfXmgk0sIrFu+NYEKGjzYDx6RADZGp3STf54T31ez2tsTrTMln12
 qzxM4uJ1xhyjjAixoVS0wNLdWVlLxG13BaygM7LabcifqyynrUYtYI1Q+woO9sV1OzHUEieTwwu
 f5DtKxEK6/vv2spTQl
X-Received: by 2002:a05:6402:2486:b0:6b3:c44d:64ce with SMTP id
 4fb4d7f45d1cf-6b4d33c5566mr3301736a12.1.1793439358588; Sat, 31 Oct 2026
 02:35:58 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 02:35:56 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 01:09:24 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261011222930.1085075-28-jonas@kwiboo.se>
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-28-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 02:35:56 -0700
X-Gm-Features: AclHuK9Dv3Im7UOuOxmQT-5NV0PL5JaRoLz-GpG7nzO4UWmZoxs9ENBCGGv6AmM
Message-ID: <CAFLszTio0G-PxqJ5aAd-OxgwK4VW3FnBhQmTmYnKQA7-oRbpwg@mail.gmail.com>
Subject: Re: [PATCH v2 27/37] clk: rockchip: rk3576: Rename PPLL register macro
To: jonas@kwiboo.se
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@nabladev.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-11T22:28:36, Jonas Karlman <jonas@kwiboo.se> wrote:
> clk: rockchip: rk3576: Rename PPLL register macro
>
> The PPLL registers belong to the PHP CRU, rather than the PMU CRU.
> Rename the register macro and update the PPLL entry and users to reflect
> this.
>
> Fixes: 3919310b37ec ("clk: rockchip: Add rk3576 clk support")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>
>  arch/arm/include/asm/arch-rockchip/cru_rk3576.h | 2 +-
>  drivers/clk/rockchip/clk_rk3576.c               | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
