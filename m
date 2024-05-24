Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBDCC25B74
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 12:29:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09D3888683;
	Fri, 24 May 2024 14:28:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ajFSC3mK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EBFC83339; Fri, 24 May 2024 11:34:18 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBD6586DBD
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 11:34:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-352129e3c8eso6032411f8f.2
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 02:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716543255; x=1717148055; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e+6KKyoWlb/ZzIiC54y5A2i2n3P6o13RRY8EqwgJVyg=;
 b=ajFSC3mKESegIfXV40VMjfK0q1OTlE58a9zElypHJf9myowt/7/CZzp2TZczP/W75W
 DcE4ZJY59RaKAzPrN1nZPeJYFxkPvY3PxOdaTg+We82ApGDjhMDDUVMOWgtr7mGeNROP
 s2ZwumB+Zulq14jGE1nRgEMl643toc9rTFAVG0GPFRakWtbpIHPVVOPVmEODc42o8XZv
 8WOsM1uLvFmLxIbpvfD+pI08r/tE+OZOzhLR5+8hp2m2/jSFgrg7L0hQs3iOn10Am7ms
 +D6pLrMWzN3WfE6qS5+PJI0olAPRprgsgqx++owb+IeAZtanLPuJjRmw69UDOPlWOGrn
 Labw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716543255; x=1717148055;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e+6KKyoWlb/ZzIiC54y5A2i2n3P6o13RRY8EqwgJVyg=;
 b=gX7C60Wj4TcnOE7i39JRhvnV5z+n/iRvo4Z/lWYctjlbbT6LJwXZJRPUwGYHi4eM7h
 spPP1+HUgFFC5VIzFWk9z6zxoHW+MtIYxKPOONNdWevoow3WU0YgPCQMjpohLMwFKfB5
 e94FuHGFcM/w5yEabFIufjgwcwwP7yBAXkPPYKmR1XW32nykQSR3shucDxFpQz4Df3kz
 KI2HKJNxxvArahuIOEOazxr+1kR3+IntClJIejz9QqDwhS6JA2RxHLjZE7wnwC9RWaYP
 LVanaYNyyIBN1HZiNmt+I/kOnN2vq5jzwQD/QpfxM0HldYC3rpM+Y+ObwTo2WPrIP2qE
 Huug==
X-Gm-Message-State: AOJu0YymZApweDe8cmmOYu6tCt5lyxW35RckRqujUXMvUEe5FLRB2hNP
 Kf5/GxrKAxJSUxGdI6JXD9mheON/1imKQYy+PVMnlFg8TXYZ9VX+QYGnszA8fxc=
X-Google-Smtp-Source: AGHT+IGPSf3XCgOKTrnQvnW9yCUuH8xGHbT0zgc0mn28pbXLoIueDyUWLVoeYdQ4t822h3uJcHNBGg==
X-Received: by 2002:a5d:448e:0:b0:354:eb62:3654 with SMTP id
 ffacd0b85a97d-35526c6b21cmr1056107f8f.31.1716543255084; 
 Fri, 24 May 2024 02:34:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:4db2:46ef:25c5:9c4c?
 ([2a01:e0a:3cb:7bb0:4db2:46ef:25c5:9c4c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557dcf0740sm1169442f8f.107.2024.05.24.02.34.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 May 2024 02:34:14 -0700 (PDT)
Message-ID: <752413f2-2211-42ed-a13f-22da707fcd97@linaro.org>
Date: Fri, 24 May 2024 11:34:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/15] net-lwip: add DHCP support and dhcp commmand
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Andrew Davis <afd@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Bryan Brattlof <bb@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Eddie James <eajames@linux.ibm.com>, Shantur Rathore <i@shantur.com>,
 Bin Meng <bmeng.cn@gmail.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Artur Rojek <artur@conclusive.pl>, Shiji Yang <yangshiji66@outlook.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Yanhong Wang <yanhong.wang@starfivetech.com>, Jonas Karlman
 <jonas@kwiboo.se>, Eugen Hristev <eugen.hristev@collabora.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Sean Anderson <sean.anderson@seco.com>
References: <cover.1716393035.git.jerome.forissier@linaro.org>
 <3a25276d4ca12b29c3ad9e7132d9a3960fffeb52.1716393035.git.jerome.forissier@linaro.org>
 <20240523150227.GM2568172@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20240523150227.GM2568172@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 24 May 2024 14:28:51 +0200
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



On 5/23/24 17:02, Tom Rini wrote:
> On Wed, May 22, 2024 at 06:00:03PM +0200, Jerome Forissier wrote:
> 
>> Add what it takes to enable CONFIG_NETDEVICES with CONFIG_NET_LWIP and
>> enable DHCP as well as the dhcp command (CONFIG_CMD_DHCP_LWIP).
>> - net-lwip/net-lwip.c is mostly empty for now. It will provide functions
>> similar to net/net.c except based on the lwIP stack
>> - include/net-lwip.h is a replacement for include/net.h which is unused
>> when CONFIG_NET_LWIP is enabled. Declarations from the latter will be
>> transferred to the former as needed when new network commands are ported
>> on top of lwIP.
>> - CONFIG_CMD_TFTPBOOT_LWIP is introduced due to CONFIG_BOOTMETH_EFI having
>> an implicit dependency on do_tftpb().
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> 
> I don't like a new symbol for re-implementing each command. To me, the
> user should pick lwIP or traditional stack, and CMD_DHCP gives the DHCP
> command and so forth, and so the Makefile gets reworked as needed.

Done for v2, thanks.

-- 
Jerome
