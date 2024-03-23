Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD610C54E67
	for <u-boot@archiver.kernel.org>; Sat, 23 Mar 2024 05:04:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1252687CDB;
	Sat, 23 Mar 2024 06:04:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711170279;
	bh=YUZ2g5OZn/+MPgWH9iYJU1ofY1qgz+PGJpz1BXRv11g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=aR8HYhqKyhityJCmjAiB9ohQUTEwwrFteLIsP2R36gAmKb5N7L2OLmquZFLMw/59I
	 3WNDz1WAKUE9X7pCSaq+JINVhilqEKmfvn94Go6k+iptUYrjkcNXT+j58o1L4dJ72r
	 uDYpAcDX2HbzS7NK2y1R3QeHbFKLsQDJX570WXrcsCqID70f56MXQHjR2sF3OkMY61
	 cw4ScUdsBfd+fP0mJ4p6t4LvDWhMbzHjaaxQyrxRxb278Hg4NXHB89vkna+8eL5eMp
	 Llt9CBB57FD/5uMeGdR4kQs7bajzrEweDh84BkBeq465mnZvAhvJGD6q3iZFvTvQAQ
	 N0pqpauF+sfvg==
Received: from [192.168.1.107] (82-131-203-241.pool.digikabel.hu
 [82.131.203.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 81A52879CC;
 Sat, 23 Mar 2024 06:04:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711170277;
 bh=YUZ2g5OZn/+MPgWH9iYJU1ofY1qgz+PGJpz1BXRv11g=;
 h=Date:Subject:To:Cc:References:From:Reply-To:In-Reply-To:From;
 b=nNFgwaySVjGoJYvfGfCpze1EnMhivKKdq80lZQ8QiJw4kCkK3krh6IglHoOAy8jyA
 c0pZX4X9rrEq39fH9Zz6hT/AEIWElK3JVoeEM0iofwgCQ1qtnnONq4d6Er2ey8WpqV
 B53BgPv70w9/Cztu2PT/r8dKSGKyqqStMKreXcOpUTDnuGYTez0QXUlULlqzQOe5bN
 K2bZjREsG/gJFNRzYY7okQRB7kgASNWPK3NRd2RXofUiOkztiuv4QcJ45BL153Gvmw
 RahsoV+jtZSVhgoHmJ63U8VFXO5yaR/nCfQz4Lmam8bPrlcOtN8E6OA+3PxFp+Qi//
 xmIIpMmBgrGhA==
Message-ID: <eb4b9e4d-8e71-e19b-cd4f-42d1fe6ce76f@denx.de>
Date: Sat, 23 Mar 2024 06:04:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 4/6] disk: don't try search for partition type if
 already set
Content-Language: en-US
To: Alexey Romanov <avromanov@salutedevices.com>,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 frieder.schrempf@kontron.de, kmpark@infradead.org, joe.hershberger@ni.com,
 dunaev@tecon.ru, sjg@chromium.org, bmeng@tinylab.org, xypron.glpk@gmx.de,
 tobias@waldekranz.com, jpewhacker@gmail.com,
 marek.vasut+renesas@mailbox.org, kever.yang@rock-chips.com,
 jbx6244@gmail.com, abdellatif.elkhlifi@arm.com,
 mikhail.kshevetskiy@iopsys.eu, jagan@amarulasolutions.com
Cc: kernel@salutedevices.com, u-boot@lists.denx.de
References: <20240306134906.1179285-1-avromanov@salutedevices.com>
 <20240306134906.1179285-5-avromanov@salutedevices.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240306134906.1179285-5-avromanov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Alexey,

On 06.03.24 14:49, Alexey Romanov wrote:
> Block devices can already set partition type at initialization
> stage, so, in this case is no point in searching for partition type.
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>   disk/part.c | 7 +++++++
>   1 file changed, 7 insertions(+)

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
