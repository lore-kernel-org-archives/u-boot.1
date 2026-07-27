Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C474C531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 09:19:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B0E1F80B00;
	Mon, 27 Jul 2026 09:19:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MPznapj2F7yi; Mon, 27 Jul 2026 09:19:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E194680C46
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785143944;
	bh=yNvrNclvDn3hvDtq0Il3kf+4krfri6ql38Nm/ogtaYw=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wPjazsy0LdD9IB3Y5izbK3QXIqvJcsWVPerX/9s6KggtRjDOuU4IIREa596Q3V1id
	 yX1GoBqt8qiaVWMSb/97BMPNh8giNeiVZ0/J3APCtUUdU7yH7ZzrjHROFqxIgRL/K7
	 PyBceSvHP9Wu3MzmvW8qxbNgw5hNzxaKKcixG9puezd+A8B5Sw8HIvPX0/otGafQqU
	 ZBt0JmnP/3I99TlrAG3E766G0NheR9ut+t0EPhVcM0DenK7bXaSCq9IzLNJPKhtv9T
	 LiMQGQQHq4SrjmQTjX1seWBS4r6uFCsnuqVE3jwaBrbK9GwD5ccx5zrSIaiYKvi1yp
	 bJnufLo99SU6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E194680C46;
	Mon, 27 Jul 2026 09:19:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7C632357
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:19:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 79E7880C46
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:19:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OVyU-6-W-8gY for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 09:19:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::129; helo=mail-lf1-x129.google.com;
 envelope-from=nable.maininbox@googlemail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 75C6680B00
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 75C6680B00
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 75C6680B00
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:19:01 +0000 (UTC)
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5b159850b16so2136735e87.3
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 02:19:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785143939; x=1785748739;
 h=content-language:content-transfer-encoding:content-type:in-reply-to
 :mime-version:user-agent:date:message-id:from:references:to:subject
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yNvrNclvDn3hvDtq0Il3kf+4krfri6ql38Nm/ogtaYw=;
 b=aUB7bO0P/noaYDhdnspn7DQL7wwHzW3RewFu3ioJCYOL5NS1iiu1W6b86fjI5aa3/B
 KZSJPa584DxIfvyCgTwL3MbawbsB1cdWKmpixXHHKOeOaxsFLDmmW+/f5rvgmBpnOkbZ
 HLohlx9r8RuUWHngURd+haLaw5Qgk4SY1OvtlSdMNYItVHRqCXwByaXjYjQ4uEt5lQ0n
 ZiubainzIXpU2hLrJSpvAOHGxklb2exf7JIDmPdz2wrJ2nfXSreM9QFOBk7x08MCfnru
 SYfH1wT8DCDg4aq7wRpKQNWeyrR8SS7WsJPSqwPDDqIkTqbbazAIoLhaLLOLBCJI1aOx
 /kMg==
X-Gm-Message-State: AOJu0YwCnzegaOG+X7TWZK8fyph7WF7jGAUIf+uWElYLF3JhhY43Yz0I
 glIRvFQjXefs6BjvCRku6dBQ7EIK0rec4+YjrxD6A7iCVI+A1rwU
X-Gm-Gg: AR+sD13+lOPvXjgPq9/66/W77iy7Yoyb7BbiHgWutPXvA6aUDIFAWEOafE9u+XA4pBS
 UHP5/PfD/s5x0rpkrTWowZUrWqmVaAkUIgxmQD38o7sUYcjqO7c4fhh75Xa+0tI1kheazD/36Yr
 vJUuFCRrV1bPtjjS1vGNguYyH4A4+ZhtNx3NNSA1sCQhgIxPQv9+3X1P/5UAcGEbGRhh1xfOwTl
 nu5P9ytcnqOtR7Ypm6nJU4a+kJKWNWJlwCI8Dvhcgfe3JfKhEvZh1nBmCWzgXViFVaiKl0zeKQ4
 F52OtOZlRuSn5WGupRa8tf03Sn//15AnUs6cSfIPLsGJkQ7GWC4Fw6drt+v/tP3B/X5/E80XQiK
 ZPMtp73fgYW9C1tNOxYr0I8WOFzAdxuAll2YEPpAYB8D3kvjmKwpsK9aUtcI8XsKkv1g+oohol1
 3A1DFham4+ysw=
X-Received: by 2002:a05:6512:2309:b0:5ae:b24c:7723 with SMTP id
 2adb3069b0e04-5b2c1b0d604mr1144902e87.17.1785143938666; 
 Mon, 27 Jul 2026 02:18:58 -0700 (PDT)
Received: from localhost ([93.175.20.167])
 by smtp.googlemail.com with ESMTPSA id
 38308e7fff4ca-39f2224cb4csm12079831fa.33.2026.07.27.02.18.56
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 02:18:56 -0700 (PDT)
Subject: Re: [PATCH 2/2] i2c: mtk_mt8195_i2c_ddc: add new driver
To: u-boot@lists.u-boot-project.org
References: <20260717-mt8188-add-ddc-i2c-driver-v1-0-e89ccd173567@baylibre.com>
 <20260717-mt8188-add-ddc-i2c-driver-v1-2-e89ccd173567@baylibre.com>
 <09824d1e-c2ea-8d66-a670-b57c911e2ed4@nabladev.com>
 <CAEHHSvb4LK+FKQ1JC1KkANbHCG4QOMY-+TAojJ4VYR5NwGzCUQ@mail.gmail.com>
 <c1eaee92-5c92-9fd2-e41a-c19dd16f27a5@nabladev.com>
From: Alex Sadovsky <nable.maininbox@googlemail.com>
Message-ID: <2a0cc9a3-520c-89db-c797-67afe326e5ec@googlemail.com>
Date: Mon, 27 Jul 2026 12:18:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <c1eaee92-5c92-9fd2-e41a-c19dd16f27a5@nabladev.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20251104; t=1785143939; x=1785748739;
 darn=lists.u-boot-project.org; 
 h=content-language:content-transfer-encoding:content-type:in-reply-to
 :mime-version:user-agent:date:message-id:from:references:to:subject
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yNvrNclvDn3hvDtq0Il3kf+4krfri6ql38Nm/ogtaYw=;
 b=nK4DfQ2vee6+ffPc3TGWD93alaDAbM6iD8qhgoqTiBlAsKkO6g15ssn2ZOU6r4iMJ5
 K8HuepJri95KYcmUdWl0t/dN9Z7NESuz4/6V7fS5IIiOa5mTUKRAv+6ZAjFTCoGyHyzk
 DYZxjhmzRZY7tub0xRoVVAjz+M+mi95JgN/acArnH5LasY1fAEn428YjXhdLWSN64lfU
 8gQ/CfgLbLTKTbfFkc+FaCJRRSzW5C+iemQ/LRQXftd8drxrtJTkbyEctF4M9PKV58un
 OM8qqWbZ7ZkWNcWh8bEAISGOaDryZNcZbQWF5ZHULZPTcbOS2yk7h6Q9R29crToSmlD0
 22Gg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=googlemail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=googlemail.com header.i=@googlemail.com
 header.a=rsa-sha256 header.s=20251104 header.b=nK4DfQ2v
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

Hi Heiko and Julien,
>> If you want, I can ask MediaTek to clarify this.
>
> It would be nice to know... so if you get this info it would be cool,
> thanks!

I'm pretty sure "v" is a divider value, yet there's still something interesting missing:
208M / (832 * 4) is exactly 62.5k but 208M / (572 * 4) is closer to 91k than 90k.
Either some nasty details are hidden, or DDC2_CLOCK should be defined as 577 or 578, or comment is slightly imprecise about desired frequency.

> +#define DDC2_CLOCK 572 /* BIM=208M/(v*4) = 90Khz */
> +#define DDC2_CLOCK_EDID 832 /* BIM=208M/(v*4) = 62.5Khz */

Cheers, Alex.
