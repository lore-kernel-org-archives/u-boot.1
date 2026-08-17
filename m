Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB45FC5B572
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 04:01:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 28ED24069F;
	Mon, 17 Aug 2026 04:01:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1SxVINVriDFT; Mon, 17 Aug 2026 04:01:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D84A24050D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786939295;
	bh=uH6d6GZ+jWiG5bw8gxNpsYpBXun7ANdSqWGObCZ9fsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i9cXxezaRxnAadNbVzoZnh0tcACxah3IQW/pRys2dgkx7hTgyCoWrn9AP6oyJs8+S
	 SYXT2LJQO/PpXWIOPhpRqV6AjFVCsZzvnawAvp0j+Zq89QW5aQCsbSSJxDxynYYxJI
	 UL4VaMP5nM02HTglqrtRgkc3beCA3Bw1THP2yWwbegwIMrtJi7IUXZfigMbSOKbBV0
	 zXf7sNf7PzqjjrAI7BWZCxszRjXRgIecsfKs6yFEXSNMScMmpSD+Y+w5DtaDOPftQ4
	 08fcOCemnAujqgwmgkkOWJ8T+GNy4FRFMMUf9RSOBhHHziYQ+A68aqVbmma+D/vMBG
	 o11Pmk9OTDpZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D84A24050D;
	Mon, 17 Aug 2026 04:01:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 488922B2
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 02:48:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 39FDF605E9
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 02:48:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7W5k5rWqdKLk for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 02:48:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 32E53605E3
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 32E53605E3
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=QvQaQQQR
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 32E53605E3
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 02:48:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E432B6013A;
 Mon, 17 Aug 2026 02:48:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FBB61F000E9;
 Mon, 17 Aug 2026 02:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786934889;
 bh=uH6d6GZ+jWiG5bw8gxNpsYpBXun7ANdSqWGObCZ9fsc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=QvQaQQQRJjdVST3jZxtsRq4xwoNvGFKJElb+wxbtFn8p55Qg9wC/3fL+NO3tGwUTy
 uQzuiaPS4ixs+NRU08akfTimzVCN7YNh56IikfqRRkqdEPAeaaN7zETpgI9kMAQb9p
 J4CzmtO+W1XWPz4aeISNT/sc2fOPXKpEQY1oTL9L1MhfI2JzzeGNGTBFzdgTEo425X
 L7L7qu2tbmLuz1oY4F3cXIMLTtOiu9/BffFBK7HoAmceLCOVA3RQAk9Tbd+uObQaJF
 ERCluu5swzs2U56hfXjW0cpE/eS0pga0738NKNkXhFfDC7BYSZEhViQ8m0q9h82Jpv
 faKTPxItD6K7w==
Date: Mon, 17 Aug 2026 02:48:07 +0000
From: Yixun Lan <dlan@kernel.org>
To: Eric Chung <eric.chung@riscstar.com>
Cc: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org,
 Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Peng Fan <peng.fan@nxp.com>,
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Han Xu <han.xu@nxp.com>, Yanir Levin <yanir.levin@tandemg.com>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>,
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Guodong Xu <guodong@riscstar.com>, Yao Zi <me@ziyao.cc>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>
Subject: Re: [PATCH v8 04/11] pinctrl: k1: add IO power domain configuration
 support
Message-ID: <20260817024807-GKC566872@kernel.org>
References: <20260802-m4-v8-0-e916643205f3@riscstar.com>
 <20260802-m4-v8-4-e916643205f3@riscstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260802-m4-v8-4-e916643205f3@riscstar.com>
X-Mailman-Approved-At: Mon, 17 Aug 2026 04:01:30 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Eric,

On 00:40 Sun 02 Aug     , Eric Chung wrote:
> Dual-voltage GPIO banks default to 3.3V, but when externally supplied
> with 1.8V the internal logic must be explicitly reconfigured to match.
> 
> Add the ability to program IO power domain control registers through the
> APBC block. These registers require unlocking the AIB Secure Access
> Register (ASAR) before every read/write, since configuring a 1.8V domain
> while 3.3V is externally supplied can cause back-powering and pin damage.
> 
> Signed-off-by: Eric Chung <eric.chung@riscstar.com>
> Reviewed-by: Yao Zi <me@ziyao.cc>
> 
Looks good, please
Reviewed-by: Yixun Lan <dlan@kernel.org>

> ---
> v7:
> - Remove the dependency on SYSCON.
> v6:
> - Use dev_read_phandle_with_args() to fetch "spacemit,apbc" instead.
> v5:
> - Use tabs for macro definition alignment.
> - Fix the missing power source argument.
> v3:
> - Add SYSCON dependency in Kconfig.
> - Fix not sorted issue in the driver.

-- 
Yixun Lan (dlan)
