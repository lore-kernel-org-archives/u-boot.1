Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACDE1C44529
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 05:54:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4672680C50;
	Tue, 21 Jul 2026 05:54:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RQteNVIM_1hA; Tue, 21 Jul 2026 05:54:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7A03180C67
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784613252;
	bh=z4Kj0qFbE+IZb/i1lxL/SbkpHpA1vCNszq8VsUJ9/QE=;
	h=Date:Subject:Cc:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=F/MH43JOSlfn+0aNjnEGgZLIKUcSPU6aVIp3Umo94sEm0qpCHlNOdyyCDWUrIw8Nr
	 oQYmkEpCi0dxMHtF5kXRf2WFBdh8LvrzRwUpTrqMKytYrrbmwFvbjUlxV/UJ+naLbP
	 8y/jBTBQR8woc0VDcqstjfjEV4e66JsCVGsj9/KgrhOSWXcWKIb0WuDRZCsHDSEyFp
	 0alAghDhD23TFfz51PPW47XNDar6/GTehA3Zb60MYwWGA4LWwKCRdwbg5Jl2X3gna/
	 QwGw6Uc5VebMDuKCQ+xWNQ8zxllbfa+BChfwMe+jHveLzdlrj4GP1NpZF/6DkSiGtQ
	 XjexoCZSgud1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A03180C67;
	Tue, 21 Jul 2026 05:54:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 90EEB109C
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 05:54:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6CDB180C50
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 05:54:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T7c-b-VAcZA6 for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 05:54:09 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 4B6DE80C67
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4B6DE80C67
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4B6DE80C67
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 05:54:07 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D61C844F6; Tue, 21 Jul 2026 07:54:05 +0200 (CEST)
Received: from mail-wm2-x0a.google.com (mail-wm2-x0a.google.com
 [IPv6:2a00:1450:4864:31::a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 134CF803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 07:54:03 +0200 (CEST)
Received: by mail-wm2-x0a.google.com with SMTP id
 5b1f17b1804b1-495459712d2so12259735e9.1
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 22:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784613242; x=1785218042;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=z4Kj0qFbE+IZb/i1lxL/SbkpHpA1vCNszq8VsUJ9/QE=;
 b=NODr5e5bkX8DxK93ZhNBjDSDSaEsM51xm70hcoGELzu6zJ8NkEGxQpvtVnB5Fp6yyL
 C0TbzVpwQvH8WTkA9LnCIOj+SBAQRnTsSRtqRo3lCI5EoXB1KkM17+RtXJaTJHhQQxeA
 r2o3auFVQKp1xQbOWIo10ncqJ6bwX8+I+PMkT32RAXfxlDb0UDhMI+8POvZjkmbPy4AO
 kHxzeACCr5BVHGhDigpTYZJmussjz1xQMrbXGFZs+1Q6ovPvzFhSDiXx4B1XZmRVwpco
 mIiV83CGl2HRCXcpKZSi/NZqEfPNqd2/+Cnl0JZvVD7C+MMhMxT/IlRdqiYWgyEOHKN3
 bKKg==
X-Forwarded-Encrypted: i=1;
 AHgh+RospgimOHAlwdqDUq6MnOCg3P5ZUWy0r5ooVp3kdzq3/ari15ynaZrVy2vh6Qgi2RJicBhpbto=@lists.denx.de
X-Gm-Message-State: AOJu0YxrS4RD28PwPFUofrpeP4dE3dkr1wqt3PL8xXPhQEdBvRqUHdP5
 r9Qg52j4d95HLnuhtFhBPYCd0IXk/buZmkZmLaEs5tBnImBfPEkZe8nLkbcydeGDQEs=
X-Gm-Gg: AfdE7ckcM1z6ETQoHUlGVKxAIwcNbg2QiRBunHKXc1el3ydmBZE5b+1CAbhLt5JeCVl
 auQS233vCgKdxonO5N7q6LKRwyA1Yl6NdUKmuEQTbQPz7ewGMJeM8U6U4TfXVyMAj4APgeXMCFG
 PJ83s8/ZtKqbH09IHMbfcL5Psi3AodnvMZxyNBI3X+iZb+7NqtIs2/D1iLCMK1BiVG/GLs8I5l/
 e8mil73XThRHeSNlYI5DbpC3HMBuwE3e4YDnbVGb2X6NrhQGE50m9dcMIg9KXzN02MBTMNDUl3o
 b2k8nUWAaWbetARLwp7zRDVH11rs4+TN42cTfq0FDyXii9PAlSdAvwCuAHDx/twoBlE1ffN2QoZ
 hlhrXBvi7KQfNUlmHpG4X6D9KiYSvgHb8072Iy1ZWwHFCqqEvAcD34+4p49Wz/YsXdU/KwDkoNG
 3UgQToDCrtRabKLDkU1z7K+3cxjPba2+5dhhLqJQKzljtTvOrLuE64rZ/immFcOMT/uFU=
X-Received: by 2002:a05:600c:c8c:b0:495:6457:b547 with SMTP id
 5b1f17b1804b1-49565116dd9mr25010455e9.37.1784613242269; 
 Mon, 20 Jul 2026 22:54:02 -0700 (PDT)
Received: from localhost (host-87-0-90-136.retail.telecomitalia.it.
 [87.0.90.136]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49565482c5asm62088925e9.10.2026.07.20.22.54.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 22:54:01 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Jul 2026 07:54:00 +0200
Message-Id: <DK40LGRTA1WW.28B2WO5LFV69Z@baylibre.com>
Subject: Re: [PATCH v2] usb: mtu3: wait for TX FIFO to drain before disconnect
Cc: "Ryder Lee" <ryder.lee@mediatek.com>, "Weijie Gao"
 <weijie.gao@mediatek.com>, "Igor Belwon"
 <igor.belwon@mentallysanemainliners.org>, "David Lechner"
 <dlechner@baylibre.com>, "Julien Stephan" <jstephan@baylibre.com>, "Marek
 Vasut" <marex@denx.de>, "Tom Rini" <trini@konsulko.com>, "Lukasz Majewski"
 <lukma@denx.de>, "Mattijs Korpershoek" <mkorpershoek@kernel.org>, "Vitor
 Sato Eschholz" <vsatoes@baylibre.com>
To: "Marek Vasut" <marek.vasut@mailbox.org>, "Carlo Caione"
 <ccaione@baylibre.com>, "GSS_MTK_Uboot_upstream"
 <GSS_MTK_Uboot_upstream@mediatek.com>, "Bin Meng" <bmeng.cn@gmail.com>,
 "Chunfeng Yun" <chunfeng.yun@mediatek.com>, <u-boot@lists.denx.de>
X-Mailer: aerc 0.21.0
References: <20260718-ccaione-upstream-mtu3-tx-fifo-drain-v2-1-837345048224@baylibre.com>
 <6f37728a-901b-4f39-9923-3852cbe95061@mailbox.org>
 <DK382N861VQO.19D7SQAQ19GEW@baylibre.com>
 <3acd7279-8baa-47b5-b384-425bde8a9d1f@mailbox.org>
In-Reply-To: <3acd7279-8baa-47b5-b384-425bde8a9d1f@mailbox.org>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784613242; x=1785218042; darn=lists.denx.de;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=z4Kj0qFbE+IZb/i1lxL/SbkpHpA1vCNszq8VsUJ9/QE=;
 b=dWGQ44XtWACRnR12+Sx2hgQvGT7vmOXhnA28KSSllA21yf4hfhiydUKLRKV/JG2RNt
 Xw5i9qhqAX5kDcfXnmb7lQzXCrMbMtGvuATl6eqhxQG83MTbq7ssQRtuu71mKTSAH2XT
 BMJaFVZp8LCxzUQZLhhboRjHoeksbhUY0/tbXdO0SgqtI94bgjNAiePCnYLVLoa4oS8P
 1ocQWm9mM5zYESWoqy2+KgojYqa5Wwu62dRB0xoVPJmFPFoT70XjAIhYusjFfDhU+RO7
 SclohJAPz2PM5hSSb+4cwCOEmLz6qk+l88ZgxC27YtdffllRFhEazgeTiL67YzcfUiXM
 F5AA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=dWGQ44Xt
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=ccaione@baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=baylibre.com header.i=@baylibre.com header.b="dWGQ44Xt"; 
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
From: Carlo Caione via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Carlo Caione <ccaione@baylibre.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Mon Jul 20, 2026 at 2:20 PM CEST, Marek Vasut wrote:
> On 7/20/26 9:32 AM, Carlo Caione wrote:
>
> Hello Carlo,
>
>>>> @@ -261,8 +290,14 @@ void mtu3_ep_stall_set(struct mtu3_ep *mep, bool =
set)
>>>>    		set ? "SEND STALL" : "CLEAR STALL, with EP RESET");
>>>>    }
>>>>   =20
>>>> -void mtu3_dev_on_off(struct mtu3 *mtu, int is_on)
>>>> +int mtu3_dev_on_off(struct mtu3 *mtu, int is_on)
>>>>    {
>>>> +	int ret =3D 0;
>>>> +
>>>> +	/* QMU completion may precede transmission from the TX FIFO. */
>>>> +	if (!is_on)
>>>> +		ret =3D mtu3_wait_for_tx_fifo_empty(mtu);
>>>
>>> Shouldn't this bail early on ret !=3D 0 ?
>>=20
>> No, disconnect must still be forced after resetting a timed-out endpoint
>> (we still want to disconnect it, even forcefully)
> Can you please include a code comment that clarifies this ?

Done in V3 already: https://lore.kernel.org/all/20260720-ccaione-upstream-m=
tu3-tx-fifo-drain-v3-1-45c0e072b64a@baylibre.com/

thanks,

--
Carlo Caione
