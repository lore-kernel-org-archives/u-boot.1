Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B89606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 09:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Ox5Jl/iA;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Sf9tOetN
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B611381173;
	Sat, 31 Oct 2026 09:34:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QfR_E-BFwJak; Sat, 31 Oct 2026 09:34:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0626B81134
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439289;
	b=CoTB9GoeoxFvv3WlxUbkX26Wks04hgTo04g6/nMmvBuDSmJFanJIijRqxJr2SeY+q35W
	 MpZRikS6ui2UwNPR6HBBcEHIg9ZylfCtfz55LteyHQsRtgNtjHQVyTaLHIzbsFvuoZr1h
	 kZ6eE/+SnlnZi7HH7n4tOq1XMSY6CwmX8GjMX/mvKp9qQwzy4jrYGAt0Nd11E8KXDYh7h
	 qezUfCDmfNAhc5rsrTfVWNE07/9x8hSHDeNxReox3faozUgWJoW+JIjXEh8aMQMSPww7w
	 rqJ7inaCLujEqJ66sc66hObtrWlBBPkkebM3VZKwlPxJvkmgrCbArxnP1zXpm/mGHTw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793439289;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Zhc1ErPkH8Y21rAnddl6uxf9eK7imfSCOkWGz2iKwfU=;
	b=E/Pi3GFhW7sTMidUW/pqNjnDTwlPjXVYFe92l5sam3GYjn/FW3qWBqam2EUyuQk24GmH
	 PTAMCPcCo61bNE2yXSvqBBxzso8NisPgs91pWwFX1KET+YoD3S2ioflIoqce3sieiA7Sj
	 C6s9ALoRV4um0xBU6YkV7RbQyZvh1x9D2rKLqg+7uAP+txM+QPhxnBWopimkZM6znPzga
	 a9IpfeUVUk1b/tJwo6ZlozuBpTfNM95g6+5nfqSlr/Iqqx70DWhgJ0K5b/nVgBkcdZ7Mt
	 gijL6m+veBqfZnl0M2D+X3OTc4lKH8uH5dlXkOL8m3q7Hk3vKMAxfUQIxZqNQWP6jAw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793439289;
	bh=Zhc1ErPkH8Y21rAnddl6uxf9eK7imfSCOkWGz2iKwfU=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ox5Jl/iAuZf+q4viRv4uTURRutXqQqWbTApV6++y2XWusl1M+EZr8ISbZ7fG4psUV
	 AcLWYjGbdMNEKe0VLw5emu7g7vw6tqiOadV7dXcG/rJd5G7wTaXLfzdMtCOZTKpRCi
	 +xR11NaWFQdFAtHCMKKUd537nsfHQAejOxvsg34R7J7UDBLnLDMJcuivxvaT0q7Pb8
	 F0ff5t+rn/NS7xQ3nVRwqo+EUw1LfwOP3zaWy6Gx/+T0hJotVjsd/YgPs/ZPHbPQ+1
	 5rvUR8KbsuHKFKsxe3Jb8n2fFkFaxGHjAE7croLZTWpbocAMMML8z6Gjc8OVLLjb48
	 q17oBAntxUO0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0626B81134;
	Sat, 31 Oct 2026 09:34:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6C2FB2C7
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:34:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5DDCC40B01
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:34:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LhwQm53GNQdl for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 09:34:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B641640AE5
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::631"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439281;
 b=dltVAXB4N/AoXbxazqqPV3TorWxFgI1vvScLBUM5XG5yfDow1UhqKpZvqpZ7W4yGu6d9
 vlKYVtR39Z8FZFeieEFbKXkJp/AG+90uuIR6uOxwL07gZA9ofG2skFQ7TXQ0pw0gZRg/i
 METAXIyt4TbuSqibuMaOxvi9ETDRwKdOP0V7VbP1ZlGy6ABTXfm3bSHzECpfpttJFdYsq
 +jzv5YXBYI2HPfeksbwYmhlHTHooKWMzRX17MtduKnmmhi3sn85k2Jb5Sks1ul3mECdF3
 MrAK2V66tm7WRS0OZ1iIICNTum44vZ2LYJdwZ9bDubopjUM4K4LqAHGL6iuagPCvbsw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793439281;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=Zhc1ErPkH8Y21rAnddl6uxf9eK7imfSCOkWGz2iKwfU=;
 b=Hdn67nAZFAEKVYHxNZMTeRqhW1mE3kEocJ/g8LOZL81o8QXM8mDm1sKWmTdwyfY18RQ0
 GtyoYpoEAqu8cWlubZsoi8jPkQNW3fo2KP3UjnCSq3Lbz7KWBg0l3uOeMjd7RlwiTyoD0
 ndfyQqk2w+0dThBaR5aQ/7r6F/JIqyKVUnbpFDv9qU8fgQomlMZRbitqYpR48ZzaHMla6
 2PSvtUHu1J/FrIiHNLyvamf+dX1Sp98riOKt0mJnpEoAJ4MqROcQ/Rme4bPBG7RXXuW1M
 XUn7Lsml5hbgwjgIaEWO2snKirjSUGD6cX5dO6ZRPBoG1BleBp8QyUxD970Owuzj/oQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Sf9tOetN; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::631"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=Sf9tOetN
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B641640AE5
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:34:41 +0000 (UTC)
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2e831e86ebfso9053065ad.1
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:34:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793439281; cv=none;
 d=google.com; s=arc-20260327;
 b=iYEKyxPBzosDX974LHMtaELciF1sJB391NmkNmdzl5iEk3ZdxJPt++e0zhrTHB8K53
 KPB+tk60rYQ+9hEUDrTuBuJUrub7bdl9pkoToofLySsYLgl4UBEnWNAUYMMU0tonsuPW
 JI5oHoHjbQkyGpEIWujaSiO/LIAE2QQoW01suPt2EbHqZo94oE/65pRirPOFK1l7z+Zv
 5SdaWifmLOILpuc0ggI8Ijd7EJ6drdlPw9oSDDhvHA5eRgq0TMJRw+xXrBYT8AYP25DR
 rg9/E00f6Y0uiM+A/Y0xkPkYOGTZ30cmZrtbaoXBKOU/d80XpOAqnNta4ebmFsGqMa+s
 A9bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=Zhc1ErPkH8Y21rAnddl6uxf9eK7imfSCOkWGz2iKwfU=;
 fh=0Ox8iaApE7M3YEmGyBvTnkfpEpBUQM3SjnIKkkselC0=;
 b=Qtbp43ykQN0oM/H1qZCZBxwQOwKzWziqo4sczlCp4om+8dA5bk85Zj1r1cecGXxl7x
 VZXsbJj6koYY+NkyNao8KyEaca7KKXWN4PjpTihCRv489hbHQ9hrRpm7FHcFTefW0uxk
 vGnm6dNibsShhe2cIklO1dkqp58WYoGMMufSFOf9qeTt9GPHPagSzaybwvgu4EIxHzrU
 gIdJzMxtL7FYlwV8fAczO/wk3gCrXaGlOd3l2Wwnk/Cj3K2eWJu+00QxYsAJuC6bWANy
 8XTwguf3jOqJuy8DHGMLP9jEALJ7ihckgcOBeNb5C2B9Hjl6M5GU5vkAOJRNqWXzjgLg
 IwKg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793439281; x=1794044081;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Zhc1ErPkH8Y21rAnddl6uxf9eK7imfSCOkWGz2iKwfU=;
 b=Sf9tOetNccTf0uo26n9VQUEncKj3v+RjVzDn6JHx8hmYMU2/4yZT8MNFaXvYiAS+1M
 M7CoiLJt24EjXyZBK2ya8TY60JF/WNNR042usiDN5ArM8Kq86aVNjn6neYFMmK8AXNqv
 fa9zZBeZzPHMaobqREwNq5sUqyA6hckDxOX+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793439281; x=1794044081;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Zhc1ErPkH8Y21rAnddl6uxf9eK7imfSCOkWGz2iKwfU=;
 b=guyGf0hMhxE27xdJrxVpQmgNjqXRzuvGUXzjqnXKx7wMZ3ueUL9Imb8Xz812ALv9Td
 TSSZ2z/7p7Gu3qrOIvUrPsFV4wkcF6jhXOp0OqPCb9NiqhLdA2uHtaS78BI0+LRfKdy7
 SVBOdjF/Q/LoXEmcLn1Jcz7edHYMxjBMWW36LtW/pfD9ZfrWejYYqgLmduZsdLjhO8qA
 8+CktMf6WU/j02W5Li2RzB/P0E6MFIiIZK/LWDaRXR/EkLi+I9QPHwMTiiaV1pwwtDYC
 TVLROgiGblNFeXsqxb0DEUywqIB1m5ig6QWy0jg1daq8ovOBTFF+ag8KxJ3qOGpWPAA3
 pKyA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxwrEa62YHdfnVLi/VxYNEyYDsdrAXHND3ovfS7rpiDMNunsba1Xc8Nei6JK1eEopHOVUboVeY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIdD7cFNcO37bUng1RFynZ3dPLwR8KBOJDduv+2tAfdxc4gc4+b
 d1BUpa/vhPvbepSusvHVY3XM5T/WrPu1BKpiS/41my1HWEhyKFGTwO9dUmqByWBcBEMfdbtuLrP
 cYDOFI+1nlX9kJbn14vj1kOeolxTzUJu3Z4ygyx/R
X-Gm-Gg: AYBFou14KzaLJ3TA3uee7wdy60GuO8njsq5vbmu3aaKHDlHHe8BmmhZLnrYK7Q8aIBo
 W7uFPWmt4zCNPDnrVTkaVetD4pEaYN2lzhuL3g98cGBRmzo3No0dyuofPqqKtfXEORpKKJUgGkX
 TO84IcQMwD2xaJJmul+MDsNLWg0FjiuZBfMVqvsZdTYvkTCPrKETesf6hThXNMLuhY5/bbXhcci
 KTsbiD8klVHI2x1SgE7q86+1UhBfNbuwXgXbWGdFbmPExpahpdSSvwbVIqV9w/1Y5IFwFVBV8FF
 mBRdckKPDmLR/5SgtFfeupsDVrjDqnZcfoP4/AlJVv3kesDZ5346/thLOysaTfhBJ+xTQvjxtuA
 XBA5RPCezVK+AmaEItkLvTBd//OI6YwbADdMtLmYeZ1rm1w5T2f6IHuord73F93LusjPYUp8=
X-Received: by 2002:a17:90b:3c0d:b0:3aa:f4af:1e0b with SMTP id
 98e67ed59e1d1-3ae8957d281mr3546124a91.8.1793439280815; Sat, 31 Oct 2026
 02:34:40 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 02:34:36 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 01:09:11 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261011222930.1085075-15-jonas@kwiboo.se>
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-15-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 02:34:36 -0700
X-Gm-Features: AclHuK9wBhX1adExldZOiJthtiNnom1ElMV_1eelPtqrTJf8112Jb9XgkNHVAio
Message-ID: <CAFLszTg-fmR-5dhmff-khrpAX_Jf8DkDD2L5-G-H8ysoacwDXQ@mail.gmail.com>
Subject: Re: [PATCH v2 14/37] clk: rockchip: rk3588: Set ACLK_BUS_ROOT to 375
 MHz
To: jonas@kwiboo.se
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Eugen Hristev <ehristev@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jonas,

On 2026-10-11T22:28:36, Jonas Karlman <jonas@kwiboo.se> wrote:
> clk: rockchip: rk3588: Set ACLK_BUS_ROOT to 375 MHz
>
> The clock driver always reports ACLK_BUS_ROOT rate as 375 MHz. However,
> the clock is initialized to use GPLL as parent and a target rate of
> 300 MHz, with GPLLs typicall 1.188 GHz rate the clock ends up at 297 MHz.

'typicall' should be 'typical', here and in the next paragraph, and
'GPLLs' and 'CPLLs' should be 'GPLL's' and 'CPLL's'. Please can you
fix these if you send a v3.

The code change looks fine to me. It matches the assigned-clock-rates
value in the SoC DT and the 375 MHz that rk3588_clk_get_rate()
reports.

>
> Change to use CPLL as parent and request a 375 MHz rate, the same rate
> that is already being reported by the driver and what the SoC DT uses in
> assigned-clock-rates. With CPLLs typicall 1.5 GHz rate, this matches the
> parent and rate Linux typically ends up using for this clock.
>
> Fixes: 716ed2a8c0bb ("clk: rockchip: rk3588: add hardcoded assigned clocks values")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>
>  drivers/clk/rockchip/clk_rk3588.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Regards,
Simon
