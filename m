Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17251C54E71
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 20:34:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CD3E82C87;
	Tue, 20 May 2025 22:34:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=benjarobin.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=benjarobin.fr header.i=@benjarobin.fr header.b="D/9XzbzY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BC4982CB8; Tue, 20 May 2025 22:34:57 +0200 (CEST)
Received: from 6.mo574.mail-out.ovh.net (6.mo574.mail-out.ovh.net
 [46.105.59.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 085E282C2F
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 22:34:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=benjarobin.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dev@benjarobin.fr
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net [79.137.60.36])
 by mo574.mail-out.ovh.net (Postfix) with ESMTPS id 4b25rt309dz15m4;
 Tue, 20 May 2025 20:34:54 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net. [127.0.0.1])
 by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <sjg@chromium.org>; Tue, 20 May 2025 20:34:54 +0000 (UTC)
Received: from mta7.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.108.9.13])
 by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4b25rt1hCHz1xwB;
 Tue, 20 May 2025 20:34:54 +0000 (UTC)
Received: from benjarobin.fr (unknown [10.1.6.7])
 by mta7.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id BFF90C3B63; 
 Tue, 20 May 2025 20:34:53 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R006c68034b9-9aef-4d75-aba4-d566d20e55a5,
 EAD86587B2B6C3DD8ADE427FB1C91837DFE7FEC9) smtp.auth=dev@benjarobin.fr
X-OVh-ClientIp: 86.194.82.154
Date: Tue, 20 May 2025 22:34:52 +0200
From: Benjamin ROBIN <dev@benjarobin.fr>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org
Subject: Re: [PATCH] bootm: Fix bootz, bmi->images pointer was uninitialized
Message-ID: <bggr22cgymvz4msmaslznvo2vpihvsrottkyh2epccurpftdnf@sorlltxjfso7>
References: <20250519194800.5550-1-dev@benjarobin.fr>
 <20250519210608.GU100073@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250519210608.GU100073@bill-the-cat>
X-Ovh-Tracer-Id: 16676266472877276073
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdduudelucdltddurdegfedvrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkefstddttddunecuhfhrohhmpeeuvghnjhgrmhhinhcutffquefkpfcuoeguvghvsegsvghnjhgrrhhosghinhdrfhhrqeenucggtffrrghtthgvrhhnpeekvefhgfejffffhefhhedvueekteekjeehhedugeefhefgudevleetffevkedtffenucfkphepuddvjedrtddrtddruddpkeeirdduleegrdekvddrudehgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepuggvvhessggvnhhjrghrohgsihhnrdhfrhdpnhgspghrtghpthhtohepfedprhgtphhtthhopehsjhhgsegthhhrohhmihhumhdrohhrghdprhgtphhtthhopehtrhhinhhisehkohhnshhulhhkohdrtghomhdprhgtphhtthhopehuqdgsohhotheslhhishhtshdruggvnhigrdguvgdpoffvtefjohhsthepmhhoheejgegmpdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=02BprZ7IYlRUkH/GdDLcfzfEkYuHcLVZ0b4mMgEG9q4=; 
 c=relaxed/relaxed; d=benjarobin.fr; h=From;
 s=ovhmo1728415-selector1; t=1747773294; v=1;
 b=D/9XzbzYNblx5q9ofguQp3o/rByKLuHTVPr0fvjk9YuM5PNLhoXJGFDme3Ko1L1z3zkF2OzP
 QykTve3wyIyF/Z329turJYLgQNGmupNwLOyczkm7scgR7acPxUr4dVVcqk9wA1vAd5z3DPbR0cl
 KhfIvcGMa8kjrxqm2Lov2XT1SHttgK4u2zpPMS1rkwZVn/BWSPNxiB1jda3Dm7yNCVPuAhCJByZ
 bx0/luBHbfEEQFr7E/amuda4U2rZBnpuoJU9cgv3I1ZDoqk5b369AJL3htKcWLzzXbS7LVMWkjK
 Ebg9PWddeBeN6AFIXTM8Sa16/DIPs9IWY8sXHMU/6WwhQ==
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

Le Mon, May 19, 2025 at 03:06:08PM -0600, Tom Rini a écrit :
> Good catch. This should also get a:
> Fixes: c2211ff65136 ("bootm: Add more fields to bootm_info")

Thank you for the review.
I am preparing a v2 of this patch.

> And after reading the code and grepping around more, I think we should
> be doing the assignment unconditionally in the function. It's what we
> practically do today as only colibri_vf disables CMD_BOOTM but then also
> enables any other OS boot command.
> -- 
> Tom

I did a bit more analysis, I put my discoveries into the commit message of the 
second version of this patch. And yes, you are right, the assignment should be 
done unconditionally (as I understand it).

Benjamin
