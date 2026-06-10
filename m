Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FCC5CD8CB9
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 04:00:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93293846D3;
	Wed, 10 Jun 2026 06:00:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="oMFmD9VZ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="u81ZPBCi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08F8584825; Wed, 10 Jun 2026 06:00:48 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32FB98005D
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 06:00:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gZsWd6x2dz9v8S;
 Wed, 10 Jun 2026 06:00:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781064046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r5ZQ9vGrb7nELhmkog0IsE5+kll34qko0YRQVfeN648=;
 b=oMFmD9VZ1BDlPsf/iTRPFoCn1uahlk6VRaJZnqM1XMjJ/NiiWvCXXWMFsH3Sn0t7C0eAfn
 S6GPEHid+M0cnO0TRHZGEv3r09R5TYqm+/8BcoXtrmKzjrltTcDVKieLQ+32DGplw2ktVk
 2wQiIKrmFpY1epPnfz53EoVdW0OuC+4QNOGAnz5g6yiTLCyzZvRogspN41KFBX3P7qBy/j
 AT845i6RIv4dMXq/FyykBfznU45GkmRi8CIRXKRiQJ5i+Oow1PGrqaV5RoDTaYgKOi0xN+
 QcO9sz2du/Bbx1XxKRlbLy163jUh4CCFfYYeRWs6Tg4pGLryeK3Iq9oakVoW2g==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=u81ZPBCi;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <58bcccf5-2cd4-4004-a39e-845892bf0ac2@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781064044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r5ZQ9vGrb7nELhmkog0IsE5+kll34qko0YRQVfeN648=;
 b=u81ZPBCiC80fHsL28midRmVy0Iy3agqczEwlgLijEY6CPlZ7OtzNcFWN0qLZxXHRKd6koy
 7FLcqIc6jQIm3PARUkdNeyHliopReCALOjFE7A3URo3Ew9RqUgp1kL6/DxcMlrO40BKEZQ
 YKFg2MgMeGG29WGaAr3haxj57y9ni6y17z7/MMVTj84v/7XsW6a9S++sHEnV+Vi359eBWv
 ssXKERql6kvd/9RL48OkUPd77Wtj8+jR4T4V24Dgt6I9WWJQfBMWcX0ax1v2mKtIpebONZ
 5VA7OuonWd3ZaMFfWQGMnro6K4yP2uOrBM0qRkMOuW9H0jwTJ8o8Byfe7Cm6eg==
Date: Wed, 10 Jun 2026 02:14:25 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v5 1/7] treewide: move bi_dram[] from bd to gd
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: trini@konsulko.com, marek.vasut+renesas@mailbox.org, jonas@kwiboo.se,
 anshuld@ti.com, sjg@chromium.org, Michal Simek <michal.simek@amd.com>,
 u-boot@lists.denx.de
References: <20260604073719.48723-1-ilias.apalodimas@linaro.org>
 <20260604073719.48723-2-ilias.apalodimas@linaro.org>
 <89b2f624-796b-48b9-92b9-4739cc64a497@mailbox.org>
 <CAC_iWjKthnMcmaG00yOBvJ+kpYqL+yB7uppYvs2z+XDpMWEUdg@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAC_iWjKthnMcmaG00yOBvJ+kpYqL+yB7uppYvs2z+XDpMWEUdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 06009a805538ee08a4e
X-MBO-RS-META: 6y43pap1ir1t6uyhf6t5swgc5cxtcwpb
X-Rspamd-Queue-Id: 4gZsWd6x2dz9v8S
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

On 6/5/26 7:20 AM, Ilias Apalodimas wrote:

Hello Ilias,

>>    8  * NOTE: This header file defines an interface to U-Boot. Including
>>    9  * this (unmodified) header file in another file is considered normal
>> 10  * use of U-Boot, and does *not* fall under the heading of "derived
>> 11  * work".
>>
>> Are we certain we are not breaking ABI here ?
> 
> That's a good point and I did look at U-Boot briefly when I changed
> the location. However, I didn't look at the kernel...
> 
> Unfortunately, I don't have a platform I can test. Let's see if Tom's CC helps.

I think it is largely legacy and likely already broken, but at least now 
we know why GD/BD split existed in the first place. And it would indeed 
be good to find out whether it is still necessary.

-- 
Best regards,
Marek Vasut
