Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE20EC43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 13:17:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28E0C84AAE;
	Fri, 10 Jul 2026 15:17:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="btBsJC26";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4140A84AA8; Fri, 10 Jul 2026 15:17:37 +0200 (CEST)
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch
 [84.16.66.173])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A818D84A63
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 15:17:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gxXSG1VxKzkHP;
 Fri, 10 Jul 2026 15:17:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1783689453;
 bh=uClTC9dF4dcYzVQQAtdSsTLoHZAV6//gOExQ/Aw00Ig=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=btBsJC26nki6nigPP14uZ5C66EXoj3Ni8KlBNCVfYFikeUjLisiIBTT5BkGoUi4uZ
 xwE/W1BiLw8ABonH50+qfdgtHdMsF72KieUn67rRbcZKH485wOsZFUT23niBelfbIg
 BHiKrEOooJRY3oervguDmuH6n3WiYdOUJSNV8WlleGguz7k0Mo5se0J5R5yobkg73K
 PskUZ81kQE6yIarxOX51iJaQ0WncwcJTNYKRorp9f848qdrY/ZTXZEUaSwO7JcsDe0
 mCFPwe1ihj7/iX6giPETUZ12ikmgeKREGftywRiTRnsgrZiFcyXEO1b8TcM+fDbx22
 QocnHnCSbWqIA==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4gxXSD3xH8zfFW; Fri, 10 Jul 2026 15:17:32 +0200 (CEST)
From: Quentin Schulz <u-boot@0leil.net>
To: u-boot@lists.denx.de, Quentin Schulz <u-boot@0leil.net>
Cc: Heiko Stuebner <heiko@sntech.de>, Jonas Karlman <jonas@kwiboo.se>, 
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>
In-Reply-To: <20260707-rk-custodian-v1-0-dbc9c696e613@0leil.net>
References: <20260707-rk-custodian-v1-0-dbc9c696e613@0leil.net>
Subject: Re: [PATCH 00/12] MAINTAINERS: update entry for ARM ROCKCHIP
Message-Id: <178368945249.879692.7725398213071632813.b4-ty@b4>
Date: Fri, 10 Jul 2026 15:17:32 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Infomaniak-Routing: alpha
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

On Tue, 07 Jul 2026 18:09:14 +0200, Quentin Schulz wrote:
> Simplify the ARM ROCKCHIP entry in MAINTAINERS by making extensive use
> of the N: regex. For some reason, it slightly modifies the list of
> people returned by get_maintainer.pl but I believe the ones reported as
> maintainers are still correct.
> 
> Add more files under the ARM ROCKCHIP umbrella.
> 
> [...]

Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip (u-boot-rockchip-2026.10), thanks!

[01/12] MAINTAINERS: remove redundant entries for ARM ROCKCHIP
        https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/9b619dfaafdd9f12738631f07ae88b99beaef132
[02/12] MAINTAINERS: add rkmux.py to ARM ROCKCHIP
        https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/3dcb974e359f8547284de3590425977a4d653ef4
[03/12] MAINTAINERS: add N: px30 regex to ARM ROCKCHIP
        https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/ff378e804652f700c5121aed7492919679a55f48
[04/12] MAINTAINERS: add N: px5 regex to ARM ROCKCHIP
        https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/7c5ba3733c204b68515f3fe3dbfb68b1de7dca8b
[05/12] MAINTAINERS: add N: rk3 regex to ARM ROCKCHIP
        https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/85aacacfbf443556a139e139e1b4676b345e5114
[06/12] MAINTAINERS: add N: rk8 regex to ARM ROCKCHIP
        https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/a961c8939554e5782cf1d98d8a3a88e407e99a00
[07/12] MAINTAINERS: add N: rv11 regex to ARM ROCKCHIP
        https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/4582dc53b80f54cc694e587a55eaebf7c16e21e0
[08/12] MAINTAINERS: add N: rkmtd regex to ARM ROCKCHIP
        https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/d801fcc7b2443fb2dfd0ba89e8c97decbef2de6b
[09/12] MAINTAINERS: add more Rockchip drivers to ARM ROCKCHIP
        https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/412f8f812a1a7a910aaaa7f61de95b294785fd96
[10/12] MAINTAINERS: add rockusb to ARM ROCKCHIP
        https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/377c363127977012c16638a1588526992ba6ac9b
[11/12] MAINTAINERS: remove Philipp Tomsich from ARM ROCKCHIP maintainers
        https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/9e3e58df50e48c3c2927909faca5c27b8e51be1e
[12/12] MAINTAINERS: add myself as ARM ROCKCHIP maintainer
        https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/275e9e482758a31901d7428e919f0b8bcc49816a

Best regards,
-- 
Quentin Schulz <u-boot@0leil.net>

