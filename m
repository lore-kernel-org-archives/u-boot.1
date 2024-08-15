Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C257DC52D7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:35:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3767D88C42;
	Thu, 15 Aug 2024 22:33:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gUD5SN9c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B2CD88BBC; Thu, 15 Aug 2024 22:33:25 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0B6788C33
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:33:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2d3c071d276so974582a91.1
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723754001; x=1724358801; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=10kSlKYVp5uW0HnNbFMSi6OxTTdAOfT4k0sWWX4guok=;
 b=gUD5SN9cECd0WHGV64k+eZUbYkWagFl3fZT+p7zUKeznzG5nBxUY0/i3A6FJ5GQiga
 /mrOM3/Lv6wxf2Uo2mWvrYsqYRB1hpadRFANpQcn0+O7tR62Zqbc4oJmrTGzugUKYWCN
 bspSB4FNLa6OLvr73u8nDVCmorBIrdl6xsE1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723754001; x=1724358801;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=10kSlKYVp5uW0HnNbFMSi6OxTTdAOfT4k0sWWX4guok=;
 b=vi3/sr0DXn1PCM+USnfPWK/pEbtehdWyuanVtEiLFA4cqlSkFBDxZgSoJrMGwtcvoX
 ds3k93Lgs6Kjm7mcni6vivD+D8q+L+zmb77puIEqCTx5+HiVl3P7LLG6NwcuiMyg1rK8
 zhGsIvrLzKsU7GVP+ER5zQ/SW2ux9C6PnuisK9evvYg+aokjtrWoxJb4UsDpyknd6jYS
 1IUEH81XYMULYx9tQlWCd12WrekKxtAfuXhmgQUnNCz9tuFYMPhuPnxvX+aTCCGmKjub
 Ev0ZAv/aOSa4uG2CKjW6/h3ioeMH2on+l1LkgnkA2ODDr/qhDlqE6pn6ybnVTn1N484A
 xX8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjS9hsq+4h5o5vpWv1qzdgYf7QOnKFkyJtk0yBF7Bl8EvagAiN53N2V269mwpCV6GiEmoSpCcmmAOQmWLIn/i39FXP9w==
X-Gm-Message-State: AOJu0YxUVTuqRBJzA42BzEiWsnPF9eYQPtfrg3bWoCNg/mKkHoFQVHBT
 IuQ0ylJfdNK+DYdbmaJ+EqL3knq13UEWR6YTdsC3gomUuBYcc1o2J59hbD2ZsVGQNs75ajd7Bjf
 EAD0WDKYorU4fgPVntR1SQpqRLLzPAjQFHear
X-Google-Smtp-Source: AGHT+IEN6MzTMSUPj79IS4RHhYy84F+HXm+ZzGMDhAAVJfP0n0rt/u2m9mZWrFXRxreEySHG2d4nBMyOAhFUHBL3PnA=
X-Received: by 2002:a17:90b:238d:b0:2c8:da73:af82 with SMTP id
 98e67ed59e1d1-2d3dfc6b665mr1018649a91.10.1723754000771; Thu, 15 Aug 2024
 13:33:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240814124108.2885-1-yasuharu.shibata@gmail.com>
 <20240814124108.2885-2-yasuharu.shibata@gmail.com>
In-Reply-To: <20240814124108.2885-2-yasuharu.shibata@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 15 Aug 2024 21:33:08 +0100
Message-ID: <CAFLszTgOf1J-siq3er6jFjc0dNcOT54zZYDBtO8sVyZRfBRaxA@mail.gmail.com>
Subject: Re: [PATCH 2/2] sandbox: fix wget test failure after fixing wget issue
To: Yasuharu Shibata <yasuharu.shibata@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Yasuharu,

On Wed, 14 Aug 2024 at 06:48, Yasuharu Shibata
<yasuharu.shibata@gmail.com> wrote:
>
> After applying the following patch, wget test on sandbox failed[1].
>
>   Commit: cab7867cff ("net: wget: Support retransmission a dropped packet")
>
> Here are two reasons why the test is failed and how to fix it:
>
> 1. tcp_ack is calculated by the wrong value.
>    tcp_ack needs to be calculated by the received TCP payload size.
> 2. wget command may have a problem that HTTP response from server
>    must be divided into more than two packets.
>    In this commit, HTTP response is divided into two packets.
>
> In addition, I fixed the HTTP response returned at the correct timing.
>
> [1] https://lore.kernel.org/u-boot/CAFLszThEbk2Jr8OZ6Hj21wPSnJjgJhaDe037RqwHvwt1KjB3_A@mail.gmail.com/
>
> Signed-off-by: Yasuharu Shibata <yasuharu.shibata@gmail.com>
> Reported-by: Simon Glass <sjg@chromium.org>
> ---
>  test/cmd/wget.c | 40 +++++++++++++++++++++++++++++++---------
>  1 file changed, 31 insertions(+), 9 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
Tested-by: Simon Glass <sjg@chromium.org>  # sandbox

Thanks for sorting this out.

Regards,
Simon
