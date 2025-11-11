Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F7ADCCFA1A
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 15:26:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDCDC83B87;
	Tue, 11 Nov 2025 16:26:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="MYn6AlX6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C2FF83B8F; Tue, 11 Nov 2025 16:26:40 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44A7783966
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 16:26:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4d5VkQ5pdgz9tYp;
 Tue, 11 Nov 2025 16:26:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762874798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fGTSDQvA5JzO6WsCmWew5/2jH3ZoosiB8OqaE6zw0s8=;
 b=MYn6AlX65p7BjvRyPdKvQVV7l4Ka7SPj8sQwqd7XSwp1JJ1kqNstZq+20RRSlfzzdoassx
 62AsVplLoiyhxKa6cdSvUYDuvbPXFs4UY4NJ9Hl1wv99RZ1CcpRxOxEdPEFceazYZKJ99I
 pfVdgd2Ds/WsZRPFc3JTNYMXqa6dPBchIsWb8qAPgJtTvm+mBMs5LQ7M9uN+cz4GBu2hAL
 ffzATUuIcZP9/JV46jmkpULi9epfaFQKhhzmrjv+REyG+vWQi9JJeOraAQXU6MV4jdG7+i
 lFLrEVSrYUfbaAoOsAJ5HqSETS6DeBmq8JnnwmoyaxibocGO9Jeco6Uguhex7w==
Message-ID: <f1f10508-4767-4943-8411-8eb4bb0618aa@mailbox.org>
Date: Tue, 11 Nov 2025 14:50:30 +0100
MIME-Version: 1.0
Subject: Re: [RFC][PATCH] kbuild: Produce diff between base DT and U-Boot
 augmented DT if DEVICE_TREE_DEBUG=1
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Sam Edwards <cfsworks@gmail.com>,
 u-boot@lists.denx.de
References: <20251106210826.371672-1-marek.vasut+renesas@mailbox.org>
 <417e1b1a-0346-4297-9a72-7befc5b94311@gmx.de>
 <537299e3-05a1-4ff4-b594-9c73ed41a0cc@mailbox.org>
 <20251107155650.GE6688@bill-the-cat>
 <4b14ce54-6ba0-4e35-abad-6787b2d994fb@mailbox.org>
 <CAFLszTjjhOj8g63vs_hprykYrWvEM=YuwT4ZNDnuppuJ-8aXZw@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAFLszTjjhOj8g63vs_hprykYrWvEM=YuwT4ZNDnuppuJ-8aXZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 1be22e79ae3aa86c59a
X-MBO-RS-META: guc98hfgqg14wp3xj1mu4jrputf3fq8d
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

On 11/11/25 1:38 PM, Simon Glass wrote:

Hello Simon,

>>> Maybe we put it in the u-boot-extras repo for now as a standalone
>>> script, so people can be asked to run it and look at the output?
>> I'd say no, because the output is full of noise unless the phandle
>> non-resolution gets somehow improved.
> 
> Another idea would be to create an fdtdiff tool which does this. We
> already have fdtgrep[1]

A new tool is not needed, up to date DTC retains the phandles across dtc 
-I dts -O dts and the result can be diff'd using regular diff.

-- 
Best regards,
Marek Vasut
