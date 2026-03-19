Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE9CD1093163
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 00:59:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2BD583F8A;
	Fri, 20 Mar 2026 01:59:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="ksNpiCAE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D04DE83E36; Fri, 20 Mar 2026 00:56:40 +0100 (CET)
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5363E83CEA
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 00:56:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kcxt@postmarketos.org
Message-ID: <bb3d0a9a-d1d6-4dc7-a583-205602181572@postmarketos.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1773964596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BqjhBH3U/EXxaqZCrXxg9ZMHS1AxQaJ5i1Fd5a39+ZY=;
 b=ksNpiCAEL1qW7u8NhQorp5J3e249fcz7QDfsLaW4AfC0eNi1Q9Y3WH7p44xMgQNKG5abOM
 bYPkQXMexGozjQpJYZbae7OvW2TI5XUfrmFVq41RQktE9XrGaVIGPKJ0ljnsqGbcM6tK71
 HZgVFIawtX1BdrgumMGrLboaGBn62jyYGjOrq33Rax9cyYYrIk30PYq2o2eNN0nplCNcc7
 JD075cxppuFI0bXEXHQwEy1NFlyLbl0dWikRnNq7y5g6gX8VMZab6Wc4423k5Q1mnUAqBQ
 cW3Wmh8Mw7bqb3AWcVUXCv6CfqbvjFptLM6R/tVMnXyFlCY2ONQwVznyNNDy3Q==
Date: Fri, 20 Mar 2026 00:56:33 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/3] fwu: Call EFI stack initialization after preboot
Content-Language: en-US
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@amd.com,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org
Cc: Kory Maincent <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Yao Zi <me@ziyao.cc>
References: <cover.1773840306.git.michal.simek@amd.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Casey Connolly <kcxt@postmarketos.org>
In-Reply-To: <cover.1773840306.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Fri, 20 Mar 2026 01:58:58 +0100
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

Hi Michal,

On 18/03/2026 14:25, Michal Simek wrote:
> Hi,
> 
> the whole series is trying to address issues we have on platforms where usb
> and ufs init are not done before efi initialization. This is happenin on
> platforms where A/B update is enabled. FWU code is called early and do EFI
> initialization before usb and ufs started that's why they are not visible.

I guess I'm missing something here (but I'd very much appreciate an
explanation!) but isn't it actually necessary to set up the EFI
subsystem /before/ register block devices?

Since EFI sets up an event listener to react to new UCLASS_BLK devices
and create EFI device handles to represent them, it doesn't create
device handles for block devices that existed before the EFI subsystem
is up.

I ran into this issue when I wrote this patch:
https://gitlab.com/LinaroLtd/qcom-eco/u-boot/-/commit/e3616009a441358bf96bd2885d77fd46df710a9a

Kind regards,

> 
> We are workarounding it by starting usb/ufs from board file but this should
> be more generic approach.
> 
> Thanks,
> Michal
> 
> Changes in v2:
> - new patch in series
> - check return value
> 
> Michal Simek (3):
>   event: Check return value from event_notify_null()
>   event: Introduce EVT_POST_PREBOOT event
>   fwu: Move boottime checks to EVT_POST_PREBOOT
> 
>  common/board_r.c      | 6 +++++-
>  common/main.c         | 4 ++++
>  include/event.h       | 9 +++++++++
>  lib/fwu_updates/fwu.c | 2 +-
>  test/dm/fwu_mdata.c   | 4 ++--
>  5 files changed, 21 insertions(+), 4 deletions(-)
> 

-- 
// Casey (she/her)

