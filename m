Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C7B0C5CFEB
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 15:07:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F40C360B25;
	Thu, 13 Aug 2026 15:07:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TI9U5g-_FMKl; Thu, 13 Aug 2026 15:07:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B7A95608FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786633672;
	bh=GBZVj7D+chDvecBcTnRw6e9dqJy6RpBmuDLxvu6aeT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CMdjRw1aMlca11xo8vOrTKohStCwmEsdOUD13HfIA2V0uYGa9qb6k0YPFtStcEgOY
	 NL6hMNNWziROBCB3NWE8R9aTgkAFayRSx6ThAX4/xqrMSLqoG0jPhOBSq5fwHl1f+A
	 pjmvMAC5ocBl/AhsN+r+Akr5+FZsqBq7CmUE4YfW5OGZvp7fZzI+jo7Ipu995wIJKL
	 shAm3WoZrsoAtnn4h6XNCK4hvdBz66OiUdMP2a98J2kC+0feaHXA2zj1uIKNtcz29U
	 kjJsH6+85+d64FXCLjFMSiswxj9AdiJfocwzZ3wp52F8JlKYj9GzxCHkFBDGrtPReq
	 uSNsbDDZOAVQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B7A95608FA;
	Thu, 13 Aug 2026 15:07:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 06BC0392
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:07:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0412981180
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:07:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MfMTScKc4iu3 for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 15:07:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 0A1BE8117B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0A1BE8117B
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0A1BE8117B
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:07:50 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-47f6609c657so1097852f8f.2
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 08:07:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786633669; x=1787238469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GBZVj7D+chDvecBcTnRw6e9dqJy6RpBmuDLxvu6aeT4=;
 b=nw32qZg9ezBu7vHuMBQymcre89qEjdF6G2NJV01hr8MNfP2jhZz66Ml5gx6HF3vyax
 zUo+PZoiXHC6TaRVU8+zN4PS2ROn51k/cvYOYERf41YNYKaZ6o/M8+Me8pxJTvaTy0O/
 oB5CC9nu4icy3gfBO7FpqnhUox/mQIYfhKd6gumaw/lYTz8W3xXqzw8E2zv1XcWWy7pX
 5DK7bYPUXcEXZqunrjs0TX9KdW/WXmVlu0vHazxIZNoMdf7zhZAVhfw92qCRZ6o/vOpc
 uOcnuiwA1w+yv9oP8BDDhrxFEV5174Ac9Ua3La7fMGZY8nmXCBb8gB8ODCXOUEmeeXv2
 BtoQ==
X-Gm-Message-State: AOJu0YwlyUjnL6Tz6+TZWmbqbz/qEZ3LkapYj+P0fV5FkpTIB/k9bE7n
 xb7Jj1sVJ/zv7VfuwKbGQx3uXeKYt6o3a47Frr66Ednktw7msZ2ZKJWR
X-Gm-Gg: AR+sD11lMPNIUgDG9dW2b4M5e0+nQh5bGoEX35V64kB/gkHOueq6KvQZ0k0emRCgx2n
 Ajr/F2n3xuXK3pkr+74ja9QSq+heVDGVShiqSsvJ5JbSgM/9/0UXqJ32haKBsFAqqNzNI88CU0p
 YzUtu+1RYIx3gKFoykI+y4LURl37mtKccyyRjP+UneJhSIIHsgpcVV4FZqoa0G7MVJBkUZzbAYT
 XX96HIkP3VYvb1aU32r/7L5Z4an8IsZh6ODKZG7d669ImsT6vOgGj8GBLruetnvdA7IiZiWNq+Y
 KK0q8c0x5WMwFUr5dVv6sxdGagsEKK2KrJmEbC46o1Ja9QfHlILW8jiVji4+k+RFR3roYYMI5HB
 hHegQx0G4QGbfQEJy44YSPrwFecqJ9In8HX/tOIqyVZH/u5DyhQk45j3cAqn8OWGh1bep8Iuh8u
 763e2dM9Uf3LkrMYdwHy7ug6ncMoB8R6DGPxOwSPu+UTsOMMkrUqghcBGWUKIa021EuXAcXA52N
 rkY
X-Received: by 2002:a05:600c:4ed2:b0:496:c9cd:e7ab with SMTP id
 5b1f17b1804b1-499821616c1mr66857295e9.5.1786633668559; 
 Thu, 13 Aug 2026 08:07:48 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981d9613fsm176754735e9.0.2026.08.13.08.07.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 08:07:48 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Franz Schnyder <franz.schnyder@toradex.com>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: Re: colibri_vf: CONFIG_TEXT_BASE and the Toradex eBoot flashing path
Date: Thu, 13 Aug 2026 17:07:47 +0200
Message-ID: <20260813150747.2184702-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260812084753.GA93864@francesco-nb>
References: <20260806124816.262259-1-mehmet.fide@gmail.com>
 <20260812084753.GA93864@francesco-nb>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786633669; x=1787238469;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GBZVj7D+chDvecBcTnRw6e9dqJy6RpBmuDLxvu6aeT4=;
 b=FH7xegWnFPOauztAjyQzrGKVgeCUp5etTpPU1kvNp5S7gDwBBZW+wDW4DdXI+Jxh4Z
 S158OltgB7+jJgMCyHMdPWhghBlOHUdE3wBrdRku4tFEr7z7tgGof2lpyc1M54G4FP2A
 oyUDXkPdPRS60+vXVxCdKyj1i3HWsvpLg9j8QUuVgJWgF3DQfigPJBMcukiEjBmT0g+e
 gtXkcOlcvfhTnB8Dqm73Jt8fe2bidONJgy6uUA3iU7yh5iTs8o7KAj26pTHqCRYiZptz
 qpszEchBDfKoAJI9Zwe3r69eJrTHlWp6qi8CpVlKmPTxP2uE2BLzDditrodWgCozGXMY
 FvCg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=FH7xegWn
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

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

Hello Francesco,

On Wed, Aug 12, 2026 at 10:47:53AM +0200, Francesco Dolcini wrote:
> what if you powercycle the board, instead of doing a reboot?

Measured today, and it turned out not to be an eBoot problem at all. I
wrote the current-defconfig image (CONFIG_TEXT_BASE=0x3f401000) into
NAND from a running U-Boot and power cycled: the BootROM does not start
it either. The module drops into the serial downloader, verified by the
0x23454523 UART association pattern echoing back on the console UART.
Writing back an image linked at 0x3f408000 through the same procedure,
the module cold boots normally.

So the eBoot observation from my report was just another face of the
same thing: nothing starts an image linked at the bottom of the gfxRAM
area, the low 28 KiB are not usable as a load address. It has been this
way since commit c0f432c37780 ("configs: vf610: increase maximum size
and enforce correct limit") in 2017; the vendor fork never took that
change, which is presumably why it went unnoticed.

> I would not focus on whatever you are getting pre-programmed on the
> board, apart maybe some note in the documentation.

Agreed on the standalone flashing. I have sent a two patch series: the
first restores 0x3f408000 in colibri_vf_defconfig with the measurements
above, the second adds the missing doc/board/toradex page for the
Colibri VF50/VF61 with the build, flashing and recovery mode steps.

Thanks,
Mehmet
