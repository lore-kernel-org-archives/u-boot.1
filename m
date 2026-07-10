Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D41C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 13:18:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B430B84AE7;
	Fri, 10 Jul 2026 15:17:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="fSTTl2cw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD10A84A63; Fri, 10 Jul 2026 15:17:42 +0200 (CEST)
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch
 [45.157.188.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93CA684AA8
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 15:17:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gxXSN0gsWzWHN;
 Fri, 10 Jul 2026 15:17:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1783689459;
 bh=3tC+2d8Siz6obT9Wpu240h5ADPj9ea5wxMYX5QeoQzw=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=fSTTl2cwx06VIaNMe3LsQFfFpWOGd8pw1L6wbjN9Qyt63mbJ2Hx56o5/RT5b4TLaq
 1XP/VHvF6vdBexx96DRFybFVUWwMy+tNqZ9x0d+FDOdK/CvD/km69Y7d1leQ2QwjS0
 yed3TlLqJzYnfQGQ3zPCbtesnoy86jpA9Hp2ZcnoCS3MJ1T23oYy5PhjsZFuh23fn7
 Wym65TS8nYQBfs6dwSLufKlmk0r+zjFHRuWbch+lBe8snrpUdkeuMlw4JTV2NdtC67
 NmHOdaAiwgyjFxO2qSlNlUmKSKMXzm2I3hFtgZv052T1jgneoQ+Mm3wzbHqCIOPAZw
 hhGoEHCRQqepA==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4gxXSM0ByBzfL0; Fri, 10 Jul 2026 15:17:38 +0200 (CEST)
From: Quentin Schulz <u-boot@0leil.net>
To: Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Coia Prant <coiaprant@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20260709185101.2149485-1-coiaprant@gmail.com>
References: <20260709185101.2149485-1-coiaprant@gmail.com>
Subject: Re: [PATCH v3] board: rockchip: Add support for 9Tripod X3568 v4
Message-Id: <178368945897.879692.425103895089377770.b4-ty@b4>
Date: Fri, 10 Jul 2026 15:17:38 +0200
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

On Fri, 10 Jul 2026 02:51:01 +0800, Coia Prant wrote:
> The 9Tripod X3568 v4 is an RK3568-based SBC, just like the RK3568-EVB.
> It always uses soldered connections between the X3568CV2/X3568CV3/X3568CV4 core board
> and the X3568bv4 I/O board.
> 
> The differences between the core boards
> - PCB size, layout
> - CPU (RK3568B2/RK3568J)
> - Memory type (DDR4/LPDDR4/LPDDR4X) and size
> - eMMC size
> - DSI/EDP resistor values
> Although the components vary, they maintain full compatibility.
> 
> [...]

Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip (u-boot-rockchip-2026.10), thanks!

[1/1] board: rockchip: Add support for 9Tripod X3568 v4
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/b5deaa71fbe543d11644b6235d466b252587641f

Best regards,
-- 
Quentin Schulz <u-boot@0leil.net>

