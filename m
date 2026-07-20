Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F234C44515
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 23:22:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 904E3405A6;
	Mon, 20 Jul 2026 23:22:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 32MuVUbpgf3X; Mon, 20 Jul 2026 23:22:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EAEC140575
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784589745;
	bh=uWidZ2Z/AqVWK9nYVePfs8akhllEcmeCLZJvGjHxCQ8=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=cTWPueGyUPuV0AeDz6IfqCzbV2nGXlfs9/W9tt6avJMCN3e2abr1XPxeXx+lyA1rs
	 wAy6qMEkfnl3Ipn9fnw5xIH18BWZx8ivh1jFqOc9rCDBhF2kJCZYFaiMUvrzBYzNGF
	 zbfn1lS5S+dI4DvTjYA9VJ3jq7AHV8WEcO/g2oipCpGdh5XORWeQtnx6XCFTOCDKhL
	 2ioxujF0ZZrA6eOsfqErFPUbW4YXTZi1spDhNz/k3JpK9zNoEt7wrwMRX0mOkcbKD4
	 DZDOIE6Bu7jz5Lom7U4Nwfl/m8VT3nCyVlyJAydpZky64I741duf5FTwNaFNtXnoUk
	 PMcNRaUMaMmwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EAEC140575;
	Mon, 20 Jul 2026 23:22:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6D2D9313
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 23:22:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4AA3960777
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 23:22:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KC_oya81F0u5 for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 23:22:22 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E631D60771
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E631D60771
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E631D60771
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 23:22:19 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15CFC844F6; Tue, 21 Jul 2026 01:22:18 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3F0D82991
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 01:22:15 +0200 (CEST)
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7eb4d532e65so4092618a34.0
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 16:22:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784589734; x=1785194534;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uWidZ2Z/AqVWK9nYVePfs8akhllEcmeCLZJvGjHxCQ8=;
 b=eo569dn4EeoVICeWj3EKCw0D8Mf5HLuaKgUtHImu/jr8PyAfBgSbShO2Yg5yXkXRfb
 Nsnt8l6HX7t0Bt2sNrhK517YDr917i31kklFvuYa18op8vNYaDkf6dm2OnxSmFwRNAU/
 MZaMd5kJlUcVcAHgphM8JOwKce4myFT5xNealJGzk5B1q1HDrKDGePyLnRB6FxF/iU8h
 qCvQ1DuW9wQ89TNd8yvnUettTcCFJ1jDzcqinFJJVxjRAw24awh1lnwG3SO5wP8F8uM7
 Wi+tBurKoX0DnvmNb/vgZ53H9viTRD1VsE0UkkDk8T07J4NYN4nw4S5IcjVgp57vJ3zt
 z51w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp7i1F49D9rXnPX0wrrocsm7nAKRuLUq8FO8w0lR3LK0T4tfZu+kjva1Q4+h7RDjc651WHf+C8=@lists.denx.de
X-Gm-Message-State: AOJu0YxuCV8dA8vLnkBPeOO6XcYq2lBHD5hFGyZGxmgA7cCgar0tIo67
 M179xTVhVW7wxvz833I5J1V01FgLijN0uUAEHcD+j9trhYtu2fH3/DfhsdQEOmEwn2U=
X-Gm-Gg: AfdE7clZrGcjd7hLz7sA6AAOEQwzP7EIS4JTUROAd1CaYQSz4oZjIDNuFeM2UUKDuIJ
 fN4XD/mznLNAuxy08tpO8eKVPl369dnRRQQNwsS4gVJmzhI1kfo+W3riVDRdT6UdrPHVBKXEk9m
 3b16kZFxSyt0mQ/+N+ZcSiShRAP4eT9TaKpJ3s7KtudGn2ColUNpvMUWCDxHi/3q/BGRV+BvV4G
 DXmmvefDKBczjgP18//Cymr5V8bAO5o63LTlFfkpOKpq1QY1a4nSjmrNBdEYc8QzhshyeUV9yCN
 wwhjiJxvJ6IkWvwaRPSd1KUUn5o3eacNaL7QU/rMLKhmCUlIcZ9waa7KiiygEJ5dZNlzj7r+DUc
 TtOlBVt9srMYBoV/oxz99RxtZB91Ts/FUAP3H40bizHd0UmClDSmyJkuB52k17aZ9pStNH7X6hq
 JTXEFEm3io7LAKWKtUP0WvsgYZfUwcMVnh3Uq+TktrAkymFmJ0HD1w
X-Received: by 2002:a05:6830:2a08:b0:7e6:ee1f:96f1 with SMTP id
 46e09a7af769-7eda06fa431mr8120260a34.5.1784589734478; 
 Mon, 20 Jul 2026 16:22:14 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:8ce6:b98e:1126:f7f0?
 ([2600:8803:e7e4:500:8ce6:b98e:1126:f7f0])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7edaf9f1076sm9405631a34.26.2026.07.20.16.22.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 16:22:13 -0700 (PDT)
Message-ID: <8e485f97-850b-4934-8a50-4d0fd0766abf@baylibre.com>
Date: Mon, 20 Jul 2026 18:22:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 74/75] usb: fix up musb-new and mtu3 after the resync
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com, 
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-75-anders.roxell@linaro.org>
Content-Language: en-US
In-Reply-To: <20260716134305.614278-75-anders.roxell@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784589734; x=1785194534; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uWidZ2Z/AqVWK9nYVePfs8akhllEcmeCLZJvGjHxCQ8=;
 b=jhIGYnoa4omfqMX8O9UZOhfRqcrvpAO7enf9f93Gojtin7rgicv7ROx5Ji9RPf/Tp5
 rw2oX7pQ9RHZQyOIMcFECyhH1kPWVolHkxsnrlvgSme/jtkNWrblbA/TJOPhfmNNfZFh
 olVv8d/ZOXausFLAr60tre9redyY8cs0vekxT/Nhyoxlx+mTw2FExOPu92tfO2zEeJYU
 HJLQYnxtQrx8qHXvlUxV12dbvU989UVM8Iy0zBOatntIrFw7X4CDrgA9gINZZuV0NLfC
 bVS/N2lE1G+JgjKeY7nCeO2+Ko6SgOXPjQM1L1hNdhL+/qZtF4ir4rqZVrKCvnDIfLlQ
 Dflg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=jhIGYnoa
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dlechner@baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=baylibre.com header.i=@baylibre.com header.b="jhIGYnoa"; 
 dkim-atps=neutral
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
From: David Lechner via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: David Lechner <dlechner@baylibre.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/16/26 8:42 AM, Anders Roxell wrote:
> Adapt the musb-new and mtu3 gadget code to the new gadget API.
> 
> Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  drivers/usb/mtu3/mtu3_gadget_ep0.c     | 16 +++++------
>  drivers/usb/musb-new/musb_gadget_ep0.c | 24 ++++++----------
>  drivers/usb/musb-new/musb_uboot.c      | 39 --------------------------
>  3 files changed, 16 insertions(+), 63 deletions(-)
> 
Why are two different controllers changed in the same patch?
