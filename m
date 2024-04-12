Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 291ACC4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 11:43:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8255487D64;
	Fri, 12 Apr 2024 13:43:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6394E8701E; Fri, 12 Apr 2024 13:43:20 +0200 (CEST)
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 849A487D64
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 13:43:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=michael@walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4340:6430:4685:ff:fe12:5967])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.3ffe.de (Postfix) with ESMTPSA id 85126109;
 Fri, 12 Apr 2024 13:43:17 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Apr 2024 13:43:17 +0200
Message-Id: <D0I48Q1DL8NJ.1CJ7FGR8K2JW@kernel.org>
Subject: Re: [PATCH 3/4] arm: dts: k3-*-binman.dtsi: Clean up and templatize
 boot binaries
Cc: <u-boot@lists.denx.de>, <trini@konsulko.com>, <sjg@chromium.org>,
 <alpernebiyasak@gmail.com>, <bb@ti.com>, <nm@ti.com>,
 <sumit.garg@linaro.org>, <michal.simek@amd.com>, <marex@denx.de>,
 <neil.armstrong@linaro.org>, <afd@ti.com>, <vigneshr@ti.com>,
 <kamlesh@ti.com>, <u-kumar1@ti.com>
From: "Michael Walle" <mwalle@kernel.org>
To: "Neha Malcom Francis" <n-francis@ti.com>, "Matthias Schiffer"
 <matthias.schiffer@ew.tq-group.com>, "Manorit Chawdhry" <m-chawdhry@ti.com>
X-Mailer: aerc 0.16.0
References: <20240322131011.1029620-1-n-francis@ti.com>
 <20240322131011.1029620-4-n-francis@ti.com>
 <D03Q9AGO5ND9.1TJM3KSNA71WG@kernel.org>
 <83c6532a-e994-4bcd-bc48-9e22ecdec644@ti.com>
 <D04LUAJJ6LC7.1JVGVTJ0UCMVR@kernel.org>
 <062f7c42-7088-4813-a2d6-ecb7ab22b4ba@ti.com>
 <D05D4N00QDKO.2PJ7VW4BNGQ11@kernel.org>
 <2e817727-524e-47e5-9f5e-2ee13d99a9bb@ti.com>
 <20240403103458.mn2xkemiyymidipo@uda0497581>
 <D0ALVJNAVD8U.3UYSZULLZ6YG5@kernel.org>
 <d23bdaec46343155c752fcfb5287d9b39ac44918.camel@ew.tq-group.com>
 <f4059b33-e36c-41d0-8205-9f8b1b665843@ti.com>
 <D0C0QR6BEJ2K.32AR9PQA0BM9E@kernel.org>
 <4b346a1e-e979-4438-ae50-f2a74b29ab44@ti.com>
In-Reply-To: <4b346a1e-e979-4438-ae50-f2a74b29ab44@ti.com>
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

Hi,

On Fri Apr 12, 2024 at 5:03 AM CEST, Neha Malcom Francis wrote:
> On 05/04/24 13:12, Michael Walle wrote:
> > On Thu Apr 4, 2024 at 11:10 AM CEST, Neha Malcom Francis wrote:
> >> But again in the interest of time... this would mean this cleaning up =
effort be
> >> kept on hold. If we can agree to move to using the generator later as =
the final
> >> solution, can we pick up this series for now?
> >=20
> > Agreed. I just saw the new RFC for the j722s support. It should also
> > make use of this cleanup then, btw.
> >=20
>
> Right, I'll sync with J722S efforts as well.
>
> So is this series good to go?

If the ultimate goal is to support the generator, sure.

-michael
