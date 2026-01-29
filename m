Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E9EED358ED
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 09:38:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 702D783B64;
	Thu, 29 Jan 2026 10:38:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="i9wuIhR8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37AAF83B85; Thu, 29 Jan 2026 10:38:51 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D433483B5E
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 10:38:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 51F5642DE7;
 Thu, 29 Jan 2026 09:38:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D6FC116D0;
 Thu, 29 Jan 2026 09:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769679527;
 bh=kfEBY2T2MgQrIHAlBzAaqzy50W36AoPqRzHiKfvGsn4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=i9wuIhR8ZS+Oj6SvqhLG0tib6MkUGIWtctPTlsDtaZ/QrKjGne6Lk2MRVl5G1mNvb
 Aim64TFGNTWczkH95C67AthFni3ep9MyJYQ2kAa1RBFI7LRLjAPVJS/MdOAIstFHFI
 Qdc0q96bGH3lqs0JhrSZOy4tjeUNAQ4Fpp6I621TSXz5n5wUPIRlGAdlawshbNehmp
 we7sAiZ11B+LlxHqiy8ML2TqmBJi2rc9rrU3hEyNc2PdINbrGI7NrS5rqnIUb1ua6L
 ZlMG1j2BGPHm+/m9ZE8J/cA8QKfU1c7NpecKEl8T4EBfWJj+Qh5JhIdnCF3U/LA8ws
 u6I0RCpLt53/A==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de
Cc: thinhn@synopsys.com, neil.armstrong@linaro.org, quic_varada@quicinc.com,
 felipe.balbi@linux.intel.com, mkorpershoek@kernel.org, lukma@denx.de,
 trini@konsulko.com, marex@denx.de, macromorgan@hotmail.com, Mian Yousaf
 Kaukab <yousaf.kaukab@intel.com>
Subject: Re: [PATCH V2 4/4] usb: dwc3: core: improve reset sequence
In-Reply-To: <20260115230135.183158-5-macroalpha82@gmail.com>
References: <20260115230135.183158-1-macroalpha82@gmail.com>
 <20260115230135.183158-5-macroalpha82@gmail.com>
Date: Thu, 29 Jan 2026 10:38:44 +0100
Message-ID: <87bjicoj17.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Chris,

Thank you for the patch.

On Thu, Jan 15, 2026 at 17:01, Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
>
> According to Synopsys Databook, we shouldn't be
> relying on GCTL.CORESOFTRESET bit as that's only for
> debugging purposes. Instead, let's use DCTL.CSFTRST
> if we're OTG or PERIPHERAL mode.
>
> Host side block will be reset by XHCI driver if
> necessary. Note that this reduces amount of time
> spent on dwc3_probe() by a long margin.
>
> We're still gonna wait for reset to finish for a
> long time (default to 1ms max), but tests show that
> the reset polling loop executed at most 19 times
> (modprobe dwc3 && modprobe -r dwc3 executed 1000
> times in a row).
>
> Note that this patch was submitted to Linux in 2016 [1], however I can
> confirm it is needed to support gadget mode in U-Boot on my device.
> While I am referencing this patch from Linux I am in fact taking the
> full existing dwc3_core_soft_reset() function from Linux as it exists
> in v6.19-rc5, so it may differ slightly from the information in the
> 2016 patch.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/patch/drivers/usb/dwc3?id=f59dcab176293b646e1358144c93c58c3cda2813
>
> Suggested-by: Mian Yousaf Kaukab <yousaf.kaukab@intel.com>
> Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  drivers/usb/dwc3/core.c | 66 ++++++++++++++++++++++++-----------------
>  1 file changed, 39 insertions(+), 27 deletions(-)
>
