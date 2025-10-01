Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19DC2CCA470
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 11:16:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 460FA80107;
	Wed,  1 Oct 2025 13:16:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="h//Iltan";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 829BC81D6A; Wed,  1 Oct 2025 13:16:41 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 692FD800B1
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 13:16:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4ccC6s2HXDz9v4H;
 Wed,  1 Oct 2025 13:16:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1759317397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PQwyG+oFHv81gGodMPpxmV127k2017eZfsOvNhm9NGU=;
 b=h//IltanqNbxViTz6y1S55YvHtnfOXSUxQxIigmvQ8qaefUgUob/uqykxcPmJJN5AksWng
 8/Lxj1GtYPj3Heg4CvA9wURInrF5T1By/RYImIGJcDSGxY/1c5dwlgaygKN7i1UIgJro9m
 uvP9h0bh4wLwdQMUUWDXefHmzmywwZIQ5CbWOb9fVJtRUiwcJYe6buI1UwKx5XbVq6jiNE
 9by0D0lw7Lix0Bj7Y6PbDLqvypcJi8iOjbPL4Qt4M6kTf8AmKn/YSGruTJGe3WV5g4DQYy
 mq22u6WH06PyER+hXOEKlvh8SfiE4YGltpBGL3ExKvxDIlJtXfR1/zDn6oZvUw==
Message-ID: <d3fc747a-fa52-4370-919d-8a0a4df6f80f@mailbox.org>
Date: Wed, 1 Oct 2025 13:16:33 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3] usb: onboard-hub: Make i2c-bus option
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@amd.com,
 fabrice.gasnier@foss.st.com, Marek Vasut <marex@denx.de>
Cc: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <8d5ce6f2bf23e1bed12f4929745b0189df8e2f3c.1759299606.git.michal.simek@amd.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <8d5ce6f2bf23e1bed12f4929745b0189df8e2f3c.1759299606.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: b60f6bb639cb6b2252d
X-MBO-RS-META: f9z58cs7h1izzrxgfcm1kcwqy7kr3fez
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

On 10/1/25 8:20 AM, Michal Simek wrote:
> DT binding doesn't mandate i2c-bus as required property because hub itself
> doesn't need to have i2c connected.
> It can be in standalone mode that only power regulator and reset should be
> handled.
> Or hub should be configured via spi interface.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>
> ---
usb: onboard-hub: Make i2c-bus option

... optional ? I can fix while applying ?
