Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F981CA0FE6
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 06:10:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 126CD86205;
	Fri,  1 Sep 2023 08:10:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.b="KpESSjeg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A54A863DD; Fri,  1 Sep 2023 08:10:49 +0200 (CEST)
Received: from s.wrqvtzvf.outbound-mail.sendgrid.net
 (s.wrqvtzvf.outbound-mail.sendgrid.net [149.72.126.143])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE02B8619A
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 08:10:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bounces+31435339-7456-u-boot=lists.denx.de@em2124.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=mime-version:subject:references:from:in-reply-to:to:cc:content-type:
 content-transfer-encoding:cc:content-type:from:subject:to;
 s=s1; bh=C2mO9Wrs2XjgTV+v/6ki8oQLpXZ5bhcyjNurIEOFy78=;
 b=KpESSjegqXrThCFlqN2sSoe5dGdlL0vZ2XhGrJT8hDNLCtFGv1QHPAd4Bp1xb+fpB138
 yDy3ECTPPwwEUy91Vt+XuyQ4quTP9gmwstmm2xuibtq3sKUoNWWczPHMtI6FI0vaPVHrVI
 ff44+s8qkpHGGpPvuLKUa0zl6jB4PlUc5fcdLjvyKW+1eg1GqcF7BD8JRxWtmcrhVeHTnJ
 L1pKbzFppuCTX49LhpoBCLTmOryWI4OmAxdJoIB7hdp/E4cGbF7u8v4foMy//LH1hGC7/Q
 DuOdRYXJ5hn2x4Fqia1KdGbSQV7yFtP5k9gkCb8ZllczeYrdYAVTFsyWa7byc8Vw==
Received: by filterdrecv-77869f68cc-gp8f7 with SMTP id
 filterdrecv-77869f68cc-gp8f7-1-64F18064-4
 2023-09-01 06:10:44.202540202 +0000 UTC m=+9786874.975784142
Received: from [192.168.1.50] (unknown) by geopod-ismtpd-7 (SG) with ESMTP
 id z2j8Mg2xQ5OoyeSp6cnD7Q Fri, 01 Sep 2023 06:10:43.872 +0000 (UTC)
Message-ID: <7d72dcde-e4af-1364-724a-dad7a1ceafb6@kwiboo.se>
Date: Fri, 01 Sep 2023 06:10:44 +0000 (UTC)
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH RESEND 1/2] arm: dts: rockchip: rk3588, rk3588s: sync with
 Linux
References: <20230901045846.50365-1-naoki@radxa.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20230901045846.50365-1-naoki@radxa.com>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h5emdhB52epcuFJnn?=
 =?us-ascii?Q?nYmdvP=2FBrfcOljJJs7JPa6qJ8SYv=2FvQ2+xIvGe3?=
 =?us-ascii?Q?FKIF4YhJSTeAx+1klNqFTu9wOMyDebBlm7fLWbQ?=
 =?us-ascii?Q?nRa8kw7w3zse1e67mroAE134SQyrobBRnornlhB?=
 =?us-ascii?Q?IUOWTRq30Fn52YJbGkO9I30WRMDwT17XQVe5j6?=
To: FUKAUMI Naoki <naoki@radxa.com>, Jagan Teki <jagan@edgeble.ai>
Cc: eugen.hristev@collabora.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, u-boot@lists.denx.de
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Type: text/plain; charset=us-ascii
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Naoki,

On 2023-09-01 06:58, FUKAUMI Naoki wrote:
> Sync the devicetree with linux-next tag: next-20230831

With the soc-dt-6.6 tag now merged into torvalds/linux tree [1] we can
probably call this a sync from v6.6-rc1.

However, this patch misses some things:

- It does not remove synced pcie and usb nodes from the related
  u-boot.dtsi files.

- It is only a partial sync from next-20230831, see following diff:

 arch/arm/dts/rk3588-edgeble-neu6a.dtsi   |   1 -
 arch/arm/dts/rk3588-edgeble-neu6b-io.dts |  66 +++
 arch/arm/dts/rk3588-edgeble-neu6b.dtsi   | 359 ++++++++++++++-
 arch/arm/dts/rk3588-evb1-v10.dts         | 720 ++++++++++++++++++++++++++++++-
 arch/arm/dts/rk3588-rock-5b.dts          | 448 ++++++++++++++++++-
 arch/arm/dts/rk3588s-rock-5a.dts         | 665 +++++++++++++++++++++++++++-
 6 files changed, 2244 insertions(+), 15 deletions(-)

- There is a similar patch [2] from Jagan Teki where a rebase was requested.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0e72db77672ff4758a31fb5259c754a7bb229751
[2] https://patchwork.ozlabs.org/project/uboot/patch/20230719081745.3546727-1-jagan@edgeble.ai/

Regards,
Jonas

> 
> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
> ---
>  arch/arm/dts/rk3588.dtsi       | 215 +++++++++++++++++++
>  arch/arm/dts/rk3588s.dtsi      | 367 +++++++++++++++++++++++++++++++++
>  include/dt-bindings/ata/ahci.h |  20 ++
>  3 files changed, 602 insertions(+)
>  create mode 100644 include/dt-bindings/ata/ahci.h

[...]
