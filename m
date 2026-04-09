Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52BB0F364BA
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 20:45:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0A2C84106;
	Thu,  9 Apr 2026 22:45:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="OVmej96Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9370384118; Thu,  9 Apr 2026 22:45:28 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D51E84105
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 22:45:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-40429b1d8baso558720fac.0
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 13:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775767525; x=1776372325;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2CtIR2fH/G2GlcEoYnHharDhZGoPNCXGP2hseVbGGp0=;
 b=OVmej96YCC3gwP87THYlp3uBWe8Kwa+q8iCYnkT9+A1Zp5mPrt2SffEDWJsjt2mvsN
 Dg7cGqWqAyJq+r65vLABhtM2UO8Yosys/IuM3KqO5jj+nhPml/ogkuHgGFqS9KUPHhnT
 bj+C9ZohiXqZ+IX+IesDbO728d0p08qAeZxpcbW8VbuXqL6E2UiaVuMfVdZSHZefb83/
 sSfxQLh3C9SFJtDScZqhtzJfM+IJUUcmh178iVsaIuHuCSIYFvTbJ1pD6usaI95EbM3r
 dQon0yWTAm4hL771nv8mmJCzmBtzFNdt4FAtkg+Dm36TWWrOlOwZcVg7c0ZIShXVUEYM
 vmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775767525; x=1776372325;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2CtIR2fH/G2GlcEoYnHharDhZGoPNCXGP2hseVbGGp0=;
 b=sYA6q4Vm6gVY12KlYEjnwo7IU39nmdAyYTgN0ae//b4SPHx+CQXR4jiz91a4QUJx2A
 hrN+d8pIzM7hNKeACHZA1ZDEppjngnpUv/QxG+fJwX5cOiLgoHEywm9rGVA7MxBT+nu5
 D3UnuSmwv2HkP4LIloJbK465BqRVEQquijmbJAez9OEH+O50pERjuMkAl8l+bJg+lVRD
 9k6+OX7KhWkhKOBcjHo663QyPJMvwYD9GL2PBliyGKZErqDnuzgE62C6f3clFx5MAoaA
 5oxHyKax6nzQ7CitgJhhQD3Rl5NB57jNmkGnwLPcrePJLGYzOk3+3Jj05N5wd/F8/dMc
 zfFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrssQ/Wc32l6OH7AkveoSsku5CG3DU/7ZJRmHPRIuh0dqHEj7Ri8RPVfcTBKy5Dtt4a4bmoJw=@lists.denx.de
X-Gm-Message-State: AOJu0Yw6M6yTHTpikX4C/t1dsrYa7o3RxaceaOCrFcwcn6l5SGvrsDs4
 wAGIvHL9JxKuRggwV5sQXK2XLk+5CwJcC0sNX8v9mEWiCMz8o5Etgt7bOuqKXGlLCaI=
X-Gm-Gg: AeBDiesPqAS6n1vmGADjUmo+NdSLUrPvCWhXPitHzrS8q10z2z7y30oIYoR3cq6jN5F
 hju1LgLI9KfA4+F3X79HL356NNTzM8xcQGEzOTWgQwuNK9o6loW3AqIxlrK6gDyHg+0XhwAppS+
 HdlHPCGe8iiI33puZhtM2mOyVdbWW0uBZyLMdVccC6yBt7a7nd58CHbIkEgWshU7A0uK8NolebJ
 gTDCRUHS5kpMMtefw0/WPbzpuWHn17izMTgXlWGMbM7/8OM0N8xdB0Qiflt2tidKhnBVdz5cJ2w
 gQQFonWXGAey9XLL3u6sOtfAtFc8w4vXj+1my4zw//J6VLTNZqIo6bDxNDHfBj7jEIf7wzFIXDw
 PIzDyrce5iAzKI3JyRMI2xMMIXCQw79tWu1QpHj+je0O5+5LzSje9Q2rE4rdFXIuqM7Uear6bZn
 om0O7nN6Pg7lS99vZj7A0OumWFgYbLppJZxkldcTDCxjEHYNkvIq/sOTZn0jEF15Ej8PCiVApDT
 A==
X-Received: by 2002:a05:6871:ea08:b0:423:4cc7:b1b6 with SMTP id
 586e51a60fabf-423e10b91b0mr320615fac.22.1775767525011; 
 Thu, 09 Apr 2026 13:45:25 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:a548:cf0c:d054:fd01?
 ([2600:8803:e7e4:500:a548:cf0c:d054:fd01])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423dd3960bbsm592812fac.4.2026.04.09.13.45.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Apr 2026 13:45:24 -0700 (PDT)
Message-ID: <142ad282-218c-4502-b8eb-ea303d4de837@baylibre.com>
Date: Thu, 9 Apr 2026 15:45:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] power: pmic: mtk-pwrap: remove interrupt related
 code
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
References: <20260409-mtk-pmic-fixes-v2-0-73e83aa6345b@baylibre.com>
 <20260409-mtk-pmic-fixes-v2-5-73e83aa6345b@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260409-mtk-pmic-fixes-v2-5-73e83aa6345b@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 4/9/26 3:30 PM, David Lechner wrote:
> Remove the interrupt related code in mtk-pwrap driver. This was just
> enabling interrupts without any handler.
> 
Drat, I forgot to remove the PWRAP_CAP_INT1_EN flag.

If nothing else comes up, I can fix that up while applying
the patches.

