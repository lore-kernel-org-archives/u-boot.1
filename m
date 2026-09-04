Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 978D5C624DE
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 07:06:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D687040B66;
	Fri,  4 Sep 2026 07:06:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TUdmAnLHhn0L; Fri,  4 Sep 2026 07:06:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1F9BB40B32
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788505607;
	b=kuZXMTc1Z1tjfUO0qn7TRrTzBhLovk/KYu867aq5vhPzDmWTSV7eYz78tHtTCn2gmLdT
	 TbRvCtWM+ySvcESjvixOPxMT3SDbre+UiPBq937nPR6nJE1eWMtf+RRFCX8keH7AnI6ey
	 5FjfWaCdEiUFNKjr5ssLkG7H9Wo0SUPB/x3SSNnVmlONotVqr9XvpnFi/AC4AFgpoaB8m
	 EtIpEuv6lvIb6OJQAqg3OuoQodNecv2xpcEopce5Tl6MLVU4rJP7gXwLs/ilcPv3C+M/k
	 c2SKT4+jIKbho74m2rJHcNNxEITJ+I2SXiek1pnGVjhemT7gFk5JGWKDIa73ra+NB1w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788505607;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=JmnuV/Kvdvfrs5feCfO73ggYeUmtVKR4k1KNNm+wUPU=;
	b=l5WGxNHGDXoyWMD9BcQvyDgsqjJyDF78xOlJcF4Mwd8+wo6sAtdaE7yw8GVA4AyTRaej
	 tDdnI9TyVa16mkYhcXEVteSaK/HOJhN2BrtdGOsIUZ87Cn05WNDcgB5K1TnbPDg1PdaNW
	 6/VgJMneRaUH8O/LCOrAG1nPxCwSPF0PBCwegmdhuXupHNrafk9eSYSfmvyfuTsTxy+gz
	 6mYbZkWWGcQABKs7tCNwM1UX20H7knRKzCJNLvyiijc2B220gML29wzEV6GvyWO+gHRLX
	 aM2RbKQ6Iy/9VyuG/uJgHUU+XDKry7VYRnoVt1TyxqdzQ4L9Uczbkap8OUZtwaI0HoQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788505607;
	bh=JmnuV/Kvdvfrs5feCfO73ggYeUmtVKR4k1KNNm+wUPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZL/S2kJeDD9/a5UK6yJ+G3XBaydA/YfKqBXr1SK7dUpa1+jGoHnL/OxKk7+VpylfA
	 XJ99sRDyV3lZ7CUEeZ7bizvkl5//RFVChG+wAIQ+VJdoYaVrivI3G55nUn6mDfQHIC
	 vDQRaR1KhHW9zdrjWpQMk2e3mM3yaODXq9HKM7pDRpl9dU/CmEWA/41IWneEcDGkni
	 EhZIS1xJltZmY01NHhZS6tYWY+liv1X+vUJ6kUFjQRgHbc5ovF8HkEgLfMyRu1SVte
	 xZHuk/Qu+NDDExrYkS9vkc7sLoVw5o4L2pZnf9yOL6cpD571d87gE1YQQvlY2eAPeP
	 9ouRhfSz50odw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1F9BB40B32;
	Fri,  4 Sep 2026 07:06:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4151DB2C
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 07:06:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 32A706079F
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 07:06:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oRHY7qqq63w6 for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 07:06:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 98B2A60642
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788505605;
 b=CcQjs7zHiEEnw5+xJbnKzxQojGhFtEC/IOeR+X+m/We3VUEVD5yoxD6kMn6qXSwvQyop
 2Wn51n2DCULpbcpxQnBHjkjv0+qFI2lw/4K+Faw2nbr8/v24EsS+gzpqakBZO0Rzrird/
 AfLwYV627YjBjTM9KkoYrRh+stzUK5zEWpw5QMcYK74eh8XAf0T9N7J9OCPYDpv1mvMRZ
 fnY1L4PRehYOmkApdPEA15eYVm2yUUNSclzxHrnujLFTlErHOnVDSFpPv9aI77Pm8/xf4
 om86Bt6dmlT9VrBnl4jcfUiT4NFO/P3JwJ2kYGxcyhdB46DhJZcqKcQwQuXS0+cwN9Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788505605;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=JmnuV/Kvdvfrs5feCfO73ggYeUmtVKR4k1KNNm+wUPU=;
 b=K/23H9agYCOtS332CmiCXBIfKnCMwxjtbBQrB+/C8eo8YJFV0Nib9VUF6bWl1eDAdvSt
 yvtg84S2gByyL1xE+whbMzuU31SzXPjwo5vVfOszxf/UEqhAijVRDPAEmHA3D9GTKeGZN
 l7tvAxAhs0qjlfRq3AVSC5A0twQ28FZ9J96tXkhDqUDWZWAa5SYiSVThwr76LkeSYfbN7
 xC4A76tQz+4csmspmC6kymylyeVr4XfDNtsi5JcKhMS2p3wxJfe2KOiOa/j4iy5YBvJoW
 3FHROOdw9G9orTdbJcN/eMB7KmDeRu42XSH9wDPW/WxYeNGoLm699y7CyNq3oXdqH2Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=DcLmh6XR; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=DcLmh6XR
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 98B2A60642
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 07:06:43 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-499ae1c6471so5402645e9.3
 for <u-boot@lists.u-boot-project.org>; Fri, 04 Sep 2026 00:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788505602; x=1789110402;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JmnuV/Kvdvfrs5feCfO73ggYeUmtVKR4k1KNNm+wUPU=;
 b=DcLmh6XR5EvboLc2sEnl6YbypbANW7ah9AGgSTmmV/cbD/Av+au8U2BtYs8CUcbUeS
 qoXN/tFye9q/KJjnIc7DWWThMxgFi3Yqcr9UFq/lfztB5uJaVH/9dCXcaRJSmCFFKtuH
 AywmImSXSTuTHpsYZ18/b73raSd9xU9TxJkyzY5vkaM9gf17OhcvsPwJABgseHge1Mok
 InKQlvu6tIPjLx3NHxTap57w6G8/2CSQdkLW2qUDHQ0YewiTjrkTNczloSja8fEz+NCn
 /iIqWbZPoUmrRrJPzAbud2xXYbTRmOo0rR4ynTPCezQu3HT78cYE0UXgqw4ySWzmsz/4
 eIJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788505602; x=1789110402;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JmnuV/Kvdvfrs5feCfO73ggYeUmtVKR4k1KNNm+wUPU=;
 b=Ct4eF5UWGKZv/vddcHxfd1Nw8yXsWHXko1An5IrJCG25o2gQ9112RPlRDhei6XMxXm
 7hLfd34IDYWxcreM/aqFOHIVVbWqi2irlQEaPhy/NilOnYNZzJDVF/UnkTj5Gh6Mq5Fh
 W6a7WrPCx9DD+F54tlqMQ3u/iPBzp7gYK7t606dc3D3mSfzYn4s+dtv+f2cl0EQ51YGN
 kGtQwfvWQytE4frBY3z8mccO2UYR8/x+X+iuop7MkDL7OL53JE8WAJyIhBd4hIJX/EYb
 zt5W7iMt0GM0ZgTnLbGxZfbHS+1bSQxJ4x9iM3obmEUMwXQ7wM6VQECzOIx1Q0S4AwsC
 cWNw==
X-Gm-Message-State: AFuF++kzUgHlcQuJjaoNBcvus4YBQ+fcTk2v9UVNx7jCfFlrX8fPrNaU
 l9gPVSnaXpe5q/7aHxlGE2m01J90Jr+1p4Q88mJp80OBv+VQEfjFPCAJ2N7TwiUdtHsKA4M7aso
 +fCBuDco=
X-Gm-Gg: AYBFou3H+TEyaZrAXOjLC9gQXdiT0CzaVzbjoft7MTtGrNKQjDViZOVP//xGnqbZygo
 7omIAMKC8h+iUd8Ooa9ib+0zqk9l/1tbabTbnW9iSHO3l4sqc4x63TIyULfA5uivL4vMNlNSkfq
 2U1/h5Fqkp4AFNCiL0y1alcyL6FPHjyvgmSezlbhmPIvxZmHb2tGVGILVW5Em7Kuh/THTRnnOD5
 7CoWV3b0cgOyZkLtoHmo/rgqX+vlrHAeWiGaTvTaSaHF/8f2/KXNrgvw7K2hL5fSQ/lC6yAJTvv
 updjg8YNlE3rYgbe346vnRTNTlTGcwDxr4otmcPk84A0NjgsNQxavl9tOOkM2qxM1P7dNidBX5X
 hKzwjZ4rUtZbEqFHcryHPk0RzALVllWPl5yPTovzV6oDlrn7p/JEBhZvrwbFPuydkIUclDd1sh4
 YmcJ+g0/RnB6YSUDLT1KPPxkxBAvcqMbqURJ75iPXhBWHVbuHLWsWz1nfG3fXinYCOwcAX/dkLR
 nmxPc1jHffSAXZpVDKMxOqkibx9yHn2+RgFU1o31TNZPDc=
X-Received: by 2002:a05:600d:8487:20b0:49c:cee0:e7c0 with SMTP id
 5b1f17b1804b1-49cf8261bf0mr40241895e9.16.1788505601807; 
 Fri, 04 Sep 2026 00:06:41 -0700 (PDT)
Received: from macbook (host-95-232-147-181.retail.telecomitalia.it.
 [95.232.147.181]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cfbe5b252sm18787765e9.3.2026.09.04.00.06.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 00:06:41 -0700 (PDT)
Date: Fri, 4 Sep 2026 09:06:39 +0200
From: Carlo Caione <ccaione@baylibre.com>
To: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 Macpaul Lin =?utf-8?B?KOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>,
 Pablo Sun =?utf-8?B?KOWtq+avk+e/lCk=?= <pablo.sun@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sam Day <me@samcday.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 David Lechner <dlechner@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Julien Masson <jmasson@baylibre.com>, Alexey Charkov <alchark@gmail.com>, 
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Francois Berder <fberder@outlook.fr>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH v4 0/5] Add fastboot to SPL
Message-ID: <apptlqfQNXrfESch@macbook>
References: <20260820-ccaione-upstream-spl-fastboot-v4-0-57e5ef71c74d@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820-ccaione-upstream-spl-fastboot-v4-0-57e5ef71c74d@baylibre.com>
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

On Thu, Aug 20, 2026 at 20:08:24 +0100, Carlo Caione wrote:
> Some recovery and initial-provisioning flows need a standard host protocol
> before usable firmware is available in persistent storage. U-Boot already
> provides fastboot, but the implementation can currently be started only
> from the U-Boot-proper command line.

Hey Mattijs (and all), could you please take a look at this again?

Cheers,

--
Carlo Caione
 
