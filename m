Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64895FEC0EA
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 17:34:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C24A083952;
	Tue, 24 Mar 2026 18:34:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lpO/DlcB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E33A083981; Tue, 24 Mar 2026 18:34:38 +0100 (CET)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B05BE807C0
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 18:34:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-4670bcc40d7so1863282b6e.2
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 10:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774373675; x=1774978475;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iT2xmMKpiDgdFsqgEkpu6ZQrjw5OCl73olaULPSNRj4=;
 b=lpO/DlcBASO4c2kegfF4j+/stFkDxyOjxzu+M30k9rRjvk+3RWmSYqAmkOFeUPf1jO
 78knt7JbpGJtNrrkkzSGnmArLgTLxpwXzbNhEy98rLhxtXy7sMJ4ZL1eAehoTT6leE9l
 Ni8S+rq8p8h5Db1EGJg4TzS5CFivdJPTnwSq/g/VJieE6Bc+5tC4iWvd3nNG+KgNIymy
 HAza1XJo73AKlSQBU/PfD5MrbSXqGEArthnVWr0TEPLFs1S8X89mdI3StB1qh70LVmuU
 X4J+6cD/IcH5UwttcMqegY5bZOiZtEZfmPZtFYSnlaHifPkMvw+2SdSLnxe0dW9IoIv4
 sv0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774373675; x=1774978475;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iT2xmMKpiDgdFsqgEkpu6ZQrjw5OCl73olaULPSNRj4=;
 b=p3zqChaEnKNTc7QDwxznQLyoRMAlKDkBSC7WkljNChrzL8e+5yFxm6lwSyFfYYfchy
 ll4mO95wwUXukJuqlE2nXaB578Km3BS/8bE35oHcZynj7BlmyeZsJ3XaEzOfuNkXnXcv
 mHW6IYthcbVHOC8ItNaSrzR5BPhxWa4NDgWeFIl72WLmTdWhznNW2Y7Xk1TB7CMobP2P
 Y8ZtSMnGs2Ic9rA0x/d5+c/Egok+VgcXwoIZbWXvTHuE9mLwuErMxu463XilDk7Fc+uN
 bunHcfLVekexWpGfVgCk4qIsaMewwcToJ4jJur3TFaReL+L4iym/XuY89TYyXc151ZHk
 rgNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8rXIdTNlfBSmY+ZPTZqSA9IN9TelVRYJYcZsumcHtrP/o3rLtc8LsdEKr/Mxqs+GXVIncITk=@lists.denx.de
X-Gm-Message-State: AOJu0YwTMAyjCilxY8XhzWWN69eAwUTR6HV/Obvhtx+iN0xVQ3Ad4cYj
 adM281npMTdo6fp7WsgRswt4khBxdH80357KOsfvdpIQdHwhjrTOl+iR3xtTEhBgdGk=
X-Gm-Gg: ATEYQzxvXrGgtCSvCMlMsdup3wF6YzQcR8zu5Q9Pm/pwKlFaU0L+nd96AzI7XfPqr/t
 GGNp97mMtOWu4XpuYz4feCS9aU2Hspb1cFmT+BmnsheG4BBRXMrCrg0JQzmZ71T/Jnu5r9P6pJH
 ZJnJneeLJT39rxO/otzrh6M/Tu6AxUbDRUiYWUS2Cew9cY3smyhuNEAgSnuFQZJzd+PqDbp/zYf
 gRESJV+stngZi/PyUyACRT5FOGMsYtPM/C+MqV8b1mCTZ96j5/8V/NaF8L19VFEMOPLz+U69m1t
 FYJ+nHqwW8ywKPxNhNG/niSdBJqhNKgd4qQWcU8mhCU3iOFUmfpEgAGXXZGy+8Q/uq39wOYgyvT
 L/j2F6tLeSpwuQZllxUNkpqEp+r/MnEu7nVesCKdra7MWBXiKTahP/+rpMFargjsgFfdeDQ/5h8
 JlS4f71nIinZPbJ1pdhKG31oTMpCA=
X-Received: by 2002:a05:6820:2011:b0:67d:f53c:9ed9 with SMTP id
 006d021491bc7-67dff4f25a9mr424468eaf.25.1774373675379; 
 Tue, 24 Mar 2026 10:34:35 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:8a85:a776:3f75:a1d])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67c253fceddsm8669846eaf.15.2026.03.24.10.34.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 10:34:34 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
In-Reply-To: <20260313-clk-mtk-fix-priv-auto-size-v1-1-bc649e1b301a@baylibre.com>
References: <20260313-clk-mtk-fix-priv-auto-size-v1-1-bc649e1b301a@baylibre.com>
Subject: Re: [PATCH] clk: mediatek: mt7623: fix pericfg priv_auto size
Message-Id: <177437366322.3897241.16979942587766878315.b4-ty@b4>
Date: Tue, 24 Mar 2026 12:34:23 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=328; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=hhi/wWRztC4q50UM0Y3ou9ka9bGywW50VCySfTapsAE=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpwssjdlpa6aHxaI4vhpcSi3Ua1QtaO+ITlZEUQ
 fg2y0W1TseJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCacLLIxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AbC8IAIj3eC+1FY4aAxF/v3PyXk52HoFzuvzjYV2PFwz
 aG5uLSy5Jb2t+5hXk2vxZtFvVgD7I4Dm/q5wtoovmvsMSG7KdZJweGRbaB206wuzV2cxe94Tyjz
 6iBTiGAzsQtow8Yp0BsPkG+yy/X8g7toe5It5YLW6V3/IKECWsnugVtIBpEv6cm4MjuSZDJ0I46
 dYuTfPBmh+Sf3sSGkGd+7+ogoo/gMtqRLRI2GO5MJosS6++94zf2KQYARoLQbi5khSFI1tOj6Do
 8jwoAIcXG/7th9mcOdrIo8Bj2BMpSvMtsV6y1LeEQODN8ke54kjUaoCO5I8MACVW9LnxgpSEhWF
 6gNI=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

On Fri, 13 Mar 2026 09:46:04 -0500, David Lechner wrote:
> clk: mediatek: mt7623: fix pericfg priv_auto size

Applied to mediatek-for-next, thanks!

[1/1] clk: mediatek: mt7623: fix pericfg priv_auto size
      commit: 730958e9b01801fb2be194c1281e886236f4d08d

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

