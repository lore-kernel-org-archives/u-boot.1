Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3340D3CC9F
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 08:25:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 751C480077;
	Thu, 15 Jan 2026 09:25:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="n2Dpq1L6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8372880325; Thu, 15 Jan 2026 09:25:50 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EF5C8003E
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 09:25:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8F2154023D;
 Thu, 15 Jan 2026 08:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E87C116D0;
 Thu, 15 Jan 2026 08:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768465546;
 bh=kFJyNeouyMCtUgPyfqMT1BSWuBNjQKW/fl+pzy+ATNM=;
 h=From:To:In-Reply-To:References:Subject:Date:From;
 b=n2Dpq1L6uV6NwRjxH4+lDLkwglF1ByvTuSjaAiuUbUlv96/QeirsHk4ZNFpY/gTmL
 9huIYMU2oBUULTink++HzOfyJx7BmnNXza8bSSSEJgmI3GoXer1bpli8n37iP7H5Wo
 2Yy/9Xq39o7NPLlhNH/mGQl3vYgJgFIWU9KihFGzhnZaM5O8GErWmfTS13boSK2tUL
 iy1ZOgb1gVtRbMat5itzpllDG471MJP/BV5nCbyoUdqcLlI1mKrIpnyxpy1Td5+ev0
 pryFXKT6syG2gzrmGFfO5xBBSSFp2t1L7jgbLMKUjS1VkQxzPQf4yvr26/XZorRsni
 fARfRfzg/swAA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Lukasz Majewski <lukma@denx.de>, u-boot@lists.denx.de, 
 Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20260106222212.744823-1-sean.anderson@linux.dev>
References: <20260106222212.744823-1-sean.anderson@linux.dev>
Subject: Re: [PATCH] dfu: Report error codes
Message-Id: <176846554375.658317.3352583589802910593.b4-ty@kernel.org>
Date: Thu, 15 Jan 2026 09:25:43 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Tue, 06 Jan 2026 17:22:11 -0500, Sean Anderson wrote:
> A lot of things can go wrong while parsing dfu_alt_info. Make sure to
> pass the real error codes all the way up instead of replacing them with
> an unhelpful -1.
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] dfu: Report error codes
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/3f9765672ce424300b6d9fb95d8b01313df9dff7

--
Mattijs
