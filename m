Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C97CCC369D3
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 12:36:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43B41817C4;
	Tue, 22 Apr 2025 14:35:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="BDmr2Ngf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87456810EB; Tue, 22 Apr 2025 09:47:17 +0200 (CEST)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::221])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C5CE8059A
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 09:47:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A4B0143A67;
 Tue, 22 Apr 2025 07:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1745308034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j6ngE45FN5/GhhlRFd0IBtap4Ti5pztrqmUa7X3+Cwk=;
 b=BDmr2NgfZzYvoArxTbS5ge6hKf6Tdxo6mVQ/Fn47dzS+EGoU4eMZsF1xWfPmLuRyjCTKLB
 eN7niWVXOM7W79jyX9pfGMftbG/WVGCXFvS/mjqKuloJuXY8r/w/kM2x1Jl/qBdrEaFtr4
 rReFB7fa6Q/1w01fnqIGU/T8QLtBeS0YMtMYXb4vm38M+vl9vKxisVH7SsN3ux/1+LHifL
 X5zyrBNYQvsUVybrNFROApEw/9U/zZ7QC2IqKDgDyKZyWOsMfzMcjTDa1iLyQJ2Acsh9wW
 0yUIOOYvr8YujNgZ7BFx4/nIRqDHnbZjoPbiP9y1F1yL56203hxb1PyacH9/eQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Lukasz Majewski <lukma@denx.de>,  Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>,  Kever Yang <kever.yang@rock-chips.com>,
 Dang Huynh <danct12@riseup.net>,  u-boot@lists.denx.de
Subject: Re: [PATCH] clk: Fix clk_set_parent() regression
In-Reply-To: <20250419090718.2469756-1-jonas@kwiboo.se> (Jonas Karlman's
 message of "Sat, 19 Apr 2025 09:07:16 +0000")
References: <20250419090718.2469756-1-jonas@kwiboo.se>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 22 Apr 2025 09:47:12 +0200
Message-ID: <87o6woljsv.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeefudejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledvrddukeegrddutdekrdehieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeelvddrudekgedruddtkedrheeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeejpdhrtghpthhtohepjhhonhgrsheskhifihgsohhordhsvgdprhgtphhtthhopehluhhkmhgrseguvghngidruggvpdhrtghpthhtohepshgvrghnghgrvdesghhmrghilhdrtghomhdprhgtphhtthhopehtrhhinhhisehkohhnshhulhhkohdrtghomhdprhgtphhtthhopehkvghvvghrrdihrghnghesrhhotghkqdgthhhiphhsrdgtohhmpdhrtghpthhtohepuggrnhgtthduvdesrhhishgvuhhpr
 dhnvghtpdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggv
X-GND-Sasl: miquel.raynal@bootlin.com
X-Mailman-Approved-At: Tue, 22 Apr 2025 14:35:50 +0200
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

On 19/04/2025 at 09:07:16 GMT, Jonas Karlman <jonas@kwiboo.se> wrote:

> The commit ac30d90f3367 ("clk: Ensure the parent clocks are enabled
> while reparenting") add a call to clk_enable() for the parent clock.
>
> For clock drivers that do not implement the enable() ops, like most
> Rockchip clock drivers, this now cause the set_parent() ops to never
> be called when CLK_CCF=3Dn (default for Rockchip).
>
> clk_enable() typically return -NOSYS when the enable() ops is not
> implemented by the clock driver, with CLK_CCF=3Dy clk_enable() instead
> return 0 when the enable() ops is unimplemented.

I am really not a big fan of this logic to return low-level information
in high-level helpers. I am constantly disagreeing with this approach
because this is exactly the kind of breakage it leads to.

> Change to ignore -NOSYS from the newly introduced clk_enable() call to
> fix this regression and restore the old behavior of set_parent() ops
> being called regardless of if enable() ops is implemented or not.
>
> Fixes: ac30d90f3367 ("clk: Ensure the parent clocks are enabled while rep=
arenting")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Thanks for the fix,

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Miqu=C3=A8l
