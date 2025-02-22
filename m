Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7939CC021B2
	for <u-boot@archiver.kernel.org>; Sat, 22 Feb 2025 18:08:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6575806FE;
	Sat, 22 Feb 2025 19:08:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="KHnIt5Cj";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="fOeC5ifi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E3BF808B6; Sat, 22 Feb 2025 19:08:40 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E5B680540
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 19:08:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Z0ZkG18bCz9t24;
 Sat, 22 Feb 2025 19:08:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740247718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=09TppcU/wdv/ub3SDa+QV67s4/8EXOvxCXOq02DSnVM=;
 b=KHnIt5CjeESSguJOppor26VY8HwadcjOo980U1vmc/HywBs5UOlWsHThPkyG/zqGDvM+kV
 PiZ/N6pkYOC2IsudOnTOcAaXn7PGNrRiSLlG5gSbrIZNyT7h1+iK0ARhS97NlYqi8MGdo3
 G4TrXfdLzZdTOKUjmruveLzN2Ekhv0meVurbjqdNVx5FtgH9T8lh6fTjkN3QjneyoOuNY6
 aQ2ADeH63LY9JB7KeRa7USTIiUVSOrI7w4NKa/HMemahO88xYbkBNQuC3yYs6iIcKy68v2
 NCMRWaF7+sXeUa32xBVpmWm7GLfqhdo2OTLXNbvBvM9tGCsdgWnKIWj8A9dKfQ==
Message-ID: <292d407d-fd62-4df2-872e-a12353649236@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740247716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=09TppcU/wdv/ub3SDa+QV67s4/8EXOvxCXOq02DSnVM=;
 b=fOeC5ifiY7K5h8v7tntVh2Yum26wUMb+9bfqNjAThPoN6yVy6o76G4EEuuCnm7bQfOz34Q
 l4oeOliZdUcSphjZ/4eWXqCdsBeNdyEH4Ew6WsUcyKxBIQqxai3e1tgAsUgECcYoYbkcnO
 1x81ssFvDQWPPdkG9peCZAPMGIydOVX1JWtphh/4Qx2xM4bN/ugOOK9dU1UhNg61KHm+Bn
 /OC7NKisDNdJzodPnH12nhr6e99RU8Inpt+BEG3BU+aQnlzVohBmZt61G/cE5028bjoqOH
 EHfne7eViDxozpZXz02aZwNalR/d1DKUPenLHRmjwLbCQf2TrliDxYaB7rAhFA==
Date: Sat, 22 Feb 2025 18:45:37 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 16/24] net: ravb: Allocate bb_miiphy using
 bb_miiphy_alloc() and fill in callbacks
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, Jim Liu
 <JJLIU0@nuvoton.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Mario Six <mario.six@gdsys.cc>, Michal Simek <michal.simek@amd.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Ramon Fried
 <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20250209120403.5321-1-marek.vasut+renesas@mailbox.org>
 <20250209120403.5321-16-marek.vasut+renesas@mailbox.org>
 <15ac0bfc-e935-418c-9774-7b709d381f63@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <15ac0bfc-e935-418c-9774-7b709d381f63@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 3d6b40219c833c50058
X-MBO-RS-META: t8cyjn8x1n8y6dqkb9mm4akdbu8489h6
X-Rspamd-Queue-Id: 4Z0ZkG18bCz9t24
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

On 2/17/25 12:10 PM, Paul Barker wrote:
> On 09/02/2025 12:01, Marek Vasut wrote:
>> Allocate bb_miiphy using bb_miiphy_alloc() and fill in callbacks
>> currently listed in bb_miiphy_buses[] array. This is a temporary
>> duplication of assignment to avoid breakage, which will be removed
>> in follow up patches. At this point, the bb_miiphy callbacks can
>> reach these accessors by doing container_of() on struct mii_dev.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> 
> [snip]
>   
>> +	/* Copy the bus accessors, name and private data */
>> +	bb_miiphy->mdio_active = ravb_bb_mdio_active;
>> +	bb_miiphy->mdio_tristate = ravb_bb_mdio_tristate;
>> +	bb_miiphy->set_mdio = ravb_bb_set_mdio;
>> +	bb_miiphy->get_mdio = ravb_bb_get_mdio;
>> +	bb_miiphy->set_mdc = ravb_bb_set_mdc;
>> +	bb_miiphy->delay = ravb_bb_delay;
> 
> I would prefer that we have a separate `struct bb_miiphy_ops`, which can
> be defined once (static and const) for each driver to reduce duplication
> of the pointers in memory.
> 
> Something like:
> 
> 	struct bb_miiphy_ops {
> 		int (*mdio_active)(struct bb_miiphy_bus *bus);
> 		int (*mdio_tristate)(struct bb_miiphy_bus *bus);
> 		int (*set_mdio)(struct bb_miiphy_bus *bus, int v);
> 		int (*get_mdio)(struct bb_miiphy_bus *bus, int *v);
> 		int (*set_mdc)(struct bb_miiphy_bus *bus, int v);
> 		int (*delay)(struct bb_miiphy_bus *bus);
> 	};
> 
> 	struct bb_miiphy_bus {
> 		const struct bb_miiphy_ops *ops;
> 		struct mii_dev mii;
> 		void *priv;
> 	};
> 
> We can make this change as a follow-up though as this patch series
> otherwise looks good.
This is definitely a follow up series, this one has grown way too much 
already.

I will be sending V3 now.
