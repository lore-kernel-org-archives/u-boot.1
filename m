Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11CDCC55162
	for <u-boot@archiver.kernel.org>; Sun,  2 Aug 2026 06:58:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A53DF406AE;
	Sun,  2 Aug 2026 06:58:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pmffIhpFAovf; Sun,  2 Aug 2026 06:58:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CAD13405A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785653881;
	bh=DAR4asj4MHcJPoLk5GYa7FDYamuGu9ucCOOL1YUDSvk=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p2SeNREtGuoN0m3OlyxEIb2L3Gnu6z57bLcDiINk5D0S/itl0J9usxX3iyBo8382z
	 xS4RmW58zpxKpGaF9dUdJE0pPtUnCy6hMs1nAbeCg7se9WBxUAiG6SikkKyIqNkeUy
	 cvMUBEFMCmi/9YWuI6w7DyEMpqrJgNyR+8krb6agRYxcRkxV6y1MWaN07Z1o/X1ES3
	 h9kJ+YNneyO85CjX/3DUgbLozRCTP7KRmXIUuwgk9DttPnJpJ6Oo2jU9toZCAjmyHG
	 43v6zUgNK9kM8yXUhFnsKn0pBITdSD1UTMiOhRzPtF3DIc1ZSL5U2TIqdpSn51q8pb
	 frgHDgo0Qfb8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CAD13405A7;
	Sun,  2 Aug 2026 06:58:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DD5FD23F
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 06:57:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C3DE6405A7
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 06:57:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MiHChP0088Vf for <u-boot@lists.u-boot-project.org>;
 Sun,  2 Aug 2026 06:57:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 32666405A3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 32666405A3
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 32666405A3
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 06:57:57 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1209844F6; Sun,  2 Aug 2026 08:57:54 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C502280117
 for <u-boot@lists.denx.de>; Sun,  2 Aug 2026 08:57:52 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49553515a8bso17647305e9.1
 for <u-boot@lists.denx.de>; Sat, 01 Aug 2026 23:57:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785653872; x=1786258672;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DAR4asj4MHcJPoLk5GYa7FDYamuGu9ucCOOL1YUDSvk=;
 b=l+fAK8KqQ90YLmQAuFrzCIY62cDjw3W0ZG+xZNUfKrYhoLblTb/DBORXZ77tJEBnIG
 mb3V+iYQNt8jXC6pB/7Ck2UVT+JomxHtvk3J00cS069AFI0+JRWgivSvLoIxZTJIl1mG
 9GqJ/yno/A7f06XN5z3cD/7/ymF22nwxhni6LjfLI9J4VaUkTkarcP5hFQJeJbMpnSnx
 KhzOHk4rP0vPcnD6Sx5q3JZ0PmcgEYGZ+hTgMfxvYDXp2uZC6OrTBwnsdYeFo6PunXBs
 A9XNNGvRZup+UTDFG567H65eSbmaudJ7PH6Qy/WK72OyZKapHLDfN/7P1wW+rDV37R36
 ko+w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrBNmkA4a+PqDjSoTQNq4NRKKtwh+58RXk1SSkXkclLt9fItpsKEsEAXHCjwEU2e7vwvPNFRRs=@lists.denx.de
X-Gm-Message-State: AOJu0YzQ2KyzyFPuQengpB72qbq/rUoLykWb1sRkNk1srXiD/scAT1/O
 E3h64mzHTMzagFUsIuIpnuZwEQBYyM8YrYrNjoqdBaDNUFxw613/izlqPa29/Oa86s64tV0bZrP
 Akpba4X0=
X-Gm-Gg: AR+sD13Pkw7ClMvedNBIgrCKS14eFlgmwSUshH9c3awEGDE5QGfPJvfD67U/cymb2Mz
 JOZc7FO1JfBBV0xoYcHhJNMRBVWCLwOatb5TOKZMRlyeoqO2gfnlywnFuu3KMZEXXYRbyaN9HLp
 brWUdFO1WiFA/oBTy2wM9elajbqgSsKlgEbrxV7NGKInaDLwmqxs47hkhWb+/cty9cHoyHDLKNu
 iBr4tVrSOe1dCs8CnayL8U+yJVnxo1r8KdaZEjRChWRYO6fzqAlkWAdH3xD/QSwdNBL9f2Djy7g
 76wai5+5NIWSCes69U2R7ScSmsJtIDSw1n8PidfPKdEsl+GL6LAkVAk3Y0V9VLdfcgql64195l+
 bY7K3s14+GLvsrZE1dLDIB1d6LMt5Vg0dDR0xag52Y+9El7gvAj2UUmx+1SsWkkU0CQ56zJn26s
 CBViFm7z51yaWmYNOLTYMIO+BkYC0F4M5Nc+ZE/SDTiYXeyAyCd+VTmSQCFxh8fAAZc3oSnFQAs
 4tmrCit6KiPQTjGWYBkqtcRwy/Ey3EK5pewB/4yWcANrFCpNpU=
X-Received: by 2002:a05:600c:46c6:b0:495:4a22:d684 with SMTP id
 5b1f17b1804b1-4980c674700mr97881455e9.10.1785653872165; 
 Sat, 01 Aug 2026 23:57:52 -0700 (PDT)
Received: from localhost (host-212-171-227-71.retail.telecomitalia.it.
 [212.171.227.71]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd456262bsm20294785f8f.17.2026.08.01.23.57.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Aug 2026 23:57:51 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 02 Aug 2026 08:57:50 +0200
Message-Id: <DKE9GVL7TX0W.2VF1JM6SOE2I1@baylibre.com>
Subject: Re: [PATCH v3] usb: mtu3: wait for TX FIFO to drain before disconnect
Cc: "Ryder Lee" <ryder.lee@mediatek.com>, "Weijie Gao"
 <weijie.gao@mediatek.com>, "Igor Belwon"
 <igor.belwon@mentallysanemainliners.org>, "David Lechner"
 <dlechner@baylibre.com>, "Julien Stephan" <jstephan@baylibre.com>, "Tom
 Rini" <trini@konsulko.com>, "Lukasz Majewski" <lukma@denx.de>, "Mattijs
 Korpershoek" <mkorpershoek@kernel.org>, "Vitor Sato Eschholz"
 <vsatoes@baylibre.com>
To: "Marek Vasut" <marek.vasut@mailbox.org>, "Carlo Caione"
 <ccaione@baylibre.com>, "GSS_MTK_Uboot_upstream"
 <GSS_MTK_Uboot_upstream@mediatek.com>, "Bin Meng" <bmeng.cn@gmail.com>,
 "Chunfeng Yun" <chunfeng.yun@mediatek.com>, <u-boot@lists.denx.de>
From: "Carlo Caione" <ccaione@baylibre.com>
X-Mailer: aerc 0.21.0
References: <20260720-ccaione-upstream-mtu3-tx-fifo-drain-v3-1-45c0e072b64a@baylibre.com>
 <DKDEITT18XJS.18WZM0Q9PGROO@baylibre.com>
 <4de93606-a4c1-4b69-bfc9-328c2aa29c4b@mailbox.org>
In-Reply-To: <4de93606-a4c1-4b69-bfc9-328c2aa29c4b@mailbox.org>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785653872; x=1786258672; darn=lists.denx.de;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DAR4asj4MHcJPoLk5GYa7FDYamuGu9ucCOOL1YUDSvk=;
 b=Hr2wDaHwxFpcGTuCcJ4n9UWF5GnYxg1TwulFA+OGuGLFF2XRuh46VbnBgP1Yy/EM07
 kZmMKSHt5NtgogDbS2PNRP/xmXmyL6/6OVoDoG3snLQhX4+6Lyd+1TSCTH5xQgncAP9u
 3kgUqzF3AZf6qGcGNNxWKqRg+FbW6Lpfaji/S4JjGuclXoeJZfsc+Hm5xnie3vFHR6BO
 uYfKQUXSd4/VbfwCo0Wj0R5wf0nklZT1QN1E2ETVSlOJrGwi3NUcVw8MCFjXHdw1tJLr
 GkSOH3oUbMbTXcXOkLCWTkNYqM9ATOsuCUzvYxy+0da4O+YgN3OUS+/kWhZLUkqOGODk
 SAzQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Hr2wDaHw
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=ccaione@baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=baylibre.com header.i=@baylibre.com header.b="Hr2wDaHw"; 
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Sat Aug 1, 2026 at 11:52 AM CEST, Marek Vasut wrote:
> On 8/1/26 8:42 AM, Carlo Caione wrote:

>> Hi Marek,
>> can you PTAL? Thanks,
>
> What does this mean ?

Please Take A Look? :)

Cheers,

--
Carlo Caione
