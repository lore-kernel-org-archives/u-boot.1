Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF6EC55184
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 14:08:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 16BA160746;
	Tue,  4 Aug 2026 14:08:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LdOW7wydjQAx; Tue,  4 Aug 2026 14:08:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0FEC260633
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785852536;
	bh=lvxNyoqjzzoJsN3GpHzuTG1V7vMLCpS7DJjk9ZqvQ7I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o1OiIice+T0EV/Qabb+nAdbYpKLiIi+wGbI6BmvLhZ7Ca9Xvj7OiKYJWaJjkYnuuN
	 Lk7pf6tmns9RX6I2+QEgtXlSY9tUvUSGAsvPjctbjZTqX0MEdj0KgEqm689YuHtf6w
	 s8Z3oy1FgAQbao0+fEWwAocf5nTXqv6rttsDDd3FwVIkB7w3VMzx3pkCE3z33h6I7e
	 f2+1g5zOiDKCvFkk0CNZUTACe/5vIucn9iVRSzBaSk3Jf94X8cKXwbM7PmnjdldfWC
	 pSulA0tL2bfAAVxrDGBymqYwjXL6N7dkZ/7ZKvq8kG9n5KW7ntG8/E6ujOs3B6FHt2
	 eCyBSUGqRFiQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0FEC260633;
	Tue,  4 Aug 2026 14:08:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C1D4423F
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 14:08:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A2E5280BED
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 14:08:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s5zeWS-BoVAs for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 14:08:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 4FF8680A8A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4FF8680A8A
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4FF8680A8A
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 14:08:52 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6a0a4aa99bdso5609551a12.1
 for <u-boot@lists.u-boot-project.org>; Tue, 04 Aug 2026 07:08:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785852530; cv=none;
 d=google.com; s=arc-20260327;
 b=cvPiyUoBbo2jYb76LuuRDlTD0lH9+cWKQNP9Nmm9NOv34TqDBJeDkp63a91lLmbcPk
 Lzz075pOLhjXTq/A+8vPXtUrCBEEAMEsJr0soBzf/nARnHjGdibZ+TtLY6V0IE6jFAAp
 lUpDYuuSjc8/Pv1p5jyhnxTCX770FglTie2msSv5opb5s0P+gsdZ3d7hurPZMNO4bhBh
 Z0n/EiDiMSbElwpgvsJszBf9ZjHq6UQUffYG34YyjzPe+85BCnFa55iGWmDuDo3MElDj
 v8JwUJ6LCFK/3QCLYVPjsfi7WBl1AUkCqJ4alXH8XKSxWGGI103/4sNvcZdr1fJ1G8EB
 Flvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lvxNyoqjzzoJsN3GpHzuTG1V7vMLCpS7DJjk9ZqvQ7I=;
 fh=plj5UouBMasx0lxBsSP/sc6Ra9ZQgK3Ux6cT6lEa1vw=;
 b=raJyj9FsXDCxMlbmhWG+6vzeR6jhAiv3xjQO55B3LGCw0+j31KG53b4YX5bySvhDtf
 +8FU8Wq0XeYzi6m9EyFH2jIoOn9RlEpjYQi2xr3KTV3LljqziiKY5u61f6gQYY8HN6Ny
 Uaty/0HNLr/jRY8ch+XkMq3wIT+8gsxwJ/wjZ7KWcaEFRduZEMc8EC9DhpuLkcMywRe7
 UOPVUOd+yEuF1WdrEhPmhn9GFEJdN4KHdJZ37Gxn4qajEDBAHqZoh6eOlZytkjNuNs40
 TUs36CMoOoIIeW4Elg+KIG+vuP7wPjLlzrn6wgzwaz2twd8z9LxTI33SuRNv+cttfd2O
 oQAw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785852530; x=1786457330;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lvxNyoqjzzoJsN3GpHzuTG1V7vMLCpS7DJjk9ZqvQ7I=;
 b=aAfDGO/RuDLQnLRx3t9h+vBUAQlgSFcpa2hIEGwEQGmf+OAw6GQvNeZM279eq5TcRw
 xs1jFpPPxSykXjgXjVl4rmqUoFMTQ/6/ZCrmu9tq32Mmn1LzYp0mUW6y9QNNa+93oEtq
 k3GFEdao69vjRomST5UHKlf0d+YPVwaipl/WOrEg6AZ6v+C+6z1HsN6zww03T/YCNbnd
 w73dBo1LBio7+Fd7P6wo/pEbwKfm6uCujuLYR72nr0oECq5vFEemJcU83x60GD5Im8bt
 fm6yPQKOLZA9hcw26ZjvjlqjIEt5uj9J9sHb9P/O7tnEX4TTpwjAgbFWdvQ1wV5Srpyc
 GoJQ==
X-Gm-Message-State: AOJu0YxFwwvFqJeeKJnGPt9Qn7ty9t03BKuaRYKD4oOlrCSaYAvVkHBe
 Yfqvn03X65jZdwoyqU5B4ocuOMlfI1FBjSnejYZT9IyIS57sl7/ya9PzlCluZf5ydNEJBlJySys
 sDJa4kFGemJ+fvx0Cx/rk8V645U8sNHWWO6YJ5TE+NYWpDiLgYzs=
X-Gm-Gg: AR+sD11gRjlpYIUGVmzhA7arSChsoDV4YIY69la2l4Z9MLQSXfiW6EqlZ1v+98kUsfM
 EZ9ZYBVsZKikZcxq0WGs8RH/PvLv5DtYvt9HUYrWYsTs0wgTKISkoWUSRC3lD2EGN6w9kuA/Y3B
 Wa9dJagT+ckhw1ssxH4+pCxXDz91Y+YOQ0RhU/787nBVU6/6fLLJHtqRcreTJej6gaTxiSh/xRw
 cp3e63uhrQtHyM6mvMbC2rRFKrbP4taLulASOjcFNDW38CvJ2Z7FVyteO79h1TAWIblnOWsaQgH
 3xUGAaVwFvFPUOjJ1DZny+GYT/H5as55bM7aKCBZQv4=
X-Received: by 2002:a05:6402:a6c6:10b0:6a1:1be7:c416 with SMTP id
 4fb4d7f45d1cf-6a11be7c4d6mr3684804a12.4.1785852530168; Tue, 04 Aug 2026
 07:08:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260720-casey-ccf-upstream-july-v1-0-8fece1b0333d@linaro.org>
In-Reply-To: <20260720-casey-ccf-upstream-july-v1-0-8fece1b0333d@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 4 Aug 2026 08:08:38 -0600
X-Gm-Features: AUfX_mznwoohn-HSPWNiVZRiRJlSBCsf0PSCryQeAG4-9bkUelH4zFgdSHsm-FE
Message-ID: <CAFLszTgdevF8+SdHcuQ2b_Om312dzxhn4gea00-Czbv-R7C7uw@mail.gmail.com>
Subject: Re: [00/36] clk: port Linux Common Clock Framework to U-Boot
To: casey.connolly@linaro.org
Cc: u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785852530; x=1786457330;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lvxNyoqjzzoJsN3GpHzuTG1V7vMLCpS7DJjk9ZqvQ7I=;
 b=JCmxKn8ux7lx/h2VONITXtN8REqf5HTRY3vtA0sJK/5msZ3CHYQNVTV/cZFiQD6r38
 euvSUgoHlxYBZhw39w44YqHtvWjiycsTFJiNqX2kdYTpfw2kPFdkEVhrnwHur33+bEwU
 f8QRA0rchZwiDZht1tcuQv7XV59bw/2cTsdRg=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=JCmxKn8u
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

Hi Casey,

On 2026-07-20T16:40:27, Casey Connolly <casey.connolly@linaro.org> wrote:

> Casey Connolly (36):
>        ...
>        clk/qcom/ccf: adapt sm8650 clock drivers for U-Boot
>        ufs: qcom: use clk_prepare_enable_bulk()
>        qcom_sm8650_defconfig: enable CCF_FULL
>        ufs: qcom: fix core clk max rate setting

I have had a look through the patches and the concept looks good to
me. But first want to mention a fairly major point:

Please can you reconsider UCLASS_NOP for the clock providers?

Every provider node gets its own device, so this isn't one device for
the tree - on SM8650 it is gcc, dispcc, tcsrcc and rpmh today, plus
every fixed-clock and fixed-factor-clock node, and more clock
controllers as they are ported. They all show up in 'dm tree' as nop.
Ick.

A dedicated uclass (UCLASS_CLK_CCF, say) would give you somewhere to
hang of_clk_add_provider() and the orphan reparenting from post_probe,
so drivers can't forget to do it, along with a home for per-provider
uclass_plat and something meaningful in 'dm tree'.

Where it really pays off is lookup. In patch 11,
of_clk_get_hw_from_clkspec() calls device_get_global_by_ofnode() and
then walks of_clk_providers comparing the same ofnode, so it does two
lookups keyed on the same thing, one of which driver model already
does for you. With the providers in a uclass that becomes a single
uclass_find_device_by_ofnode() and of_clk_providers (and its mutex)
can go. That only works once every provider is in the uclass, though,
which brings me to the next point.

I appreciate the point of UCLASS_NOP is that a PHY or PMIC can provide
clocks without a second driver...fair enough. You may have seen my
series adding uclass adjuncts[1], which lets a device join extra
uclasses without child devices, so a PHY would keep UCLASS_PHY and add
a clock adjunct. That would also let gcc and dispcc drop the reset and
power domain child devices from qcom_cc_bind_pd_reset() entirely.

I'm not sure if that series will ever go in and I'm not asking you to
depend on it - but the uclass change stands on its own and heads in
that direction. In the meantime nothing is lost: a PHY or PMIC can
keep registering its clocks from its own probe exactly as it does now,
it just doesn't need the post_probe hook and the ofnode lookup stays
as it is.

BTW we should not assume that Linux support comes before U-Boot...in
general you need U-Boot running so your can boot Linux! But that is
really just another argument in favour of this series - yes, you must
put in more effort on the U-Boot clock driver, but then you will be
able to use the same code in Linux.

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=496717&state=*
