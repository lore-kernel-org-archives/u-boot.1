Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFEF8C531C9
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 13:42:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 68E2E811D3;
	Fri, 24 Jul 2026 13:42:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZrMO_vx8WtS1; Fri, 24 Jul 2026 13:42:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 85686811C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784900536;
	bh=WCF2DWiTV+/FV8evL4Lr9tGKOmVoFYnApt78JwEa5Gw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Pvp9xFzRfLaCq6f13O5xG9BX3xIziBnGzMBRioNBICopjOVTONbpgC/X4ugcwsCwt
	 4hG71Wn3fNWMeprFUN5vV7ver8rNEUzz274lhdNhEdUQaPO+mxI5TvP/BOzB0/411x
	 xI5jGs0yy814yIUDVvUDcaQPoowQkNlh2LHP1KcPB8tRajHTVwbm/774y/eHuq0FRy
	 R4F60FZz4gEafUKkSmTR3mGYl2nD9wAo55RYJHvzpmpI8ErxFVjhMJIdyOou2yDt0/
	 57A7GnvZYg07gIj0KTRE6NYJSJj6b/X5oGPJk8Bi4esc8l71R0XyNa66tVPJXoNvh2
	 fffLgVrHJdHtw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 85686811C8;
	Fri, 24 Jul 2026 13:42:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5E8C23B1
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 13:42:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4441E811CA
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 13:42:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FURwzNLa-btW for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 13:42:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7A27B811C7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7A27B811C7
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7A27B811C7
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 13:42:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 53776600AA;
 Fri, 24 Jul 2026 13:42:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6256A1F000E9;
 Fri, 24 Jul 2026 13:42:10 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, Mattijs
 Korpershoek <mkorpershoek@kernel.org>, Chris Morgan
 <macromorgan@hotmail.com>, Balaji Selvanathan
 <balaji.selvanathan@oss.qualcomm.com>
Subject: Re: [PATCH] Revert "drivers: usb: dwc3: Add delay after core soft
 reset"
In-Reply-To: <20260724-kodiak_delay-v1-1-57b687e6d67c@oss.qualcomm.com>
References: <20260724-kodiak_delay-v1-1-57b687e6d67c@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 15:42:08 +0200
Message-ID: <87ldb07bdb.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1784900531;
 bh=WCF2DWiTV+/FV8evL4Lr9tGKOmVoFYnApt78JwEa5Gw=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=ZsDupRf4bi6aFe7QoCNzi21UFIa6cBP72ZMCFQkN+Ls1rRAWxYM8Mz1w4SnetxXAA
 R3gqFWRkO6VDSU8lI35ob4KxTAhpNUsGwmUe7JdykN6/PQpACtcMjMfKAkDKf7dEie
 dZzGBQgZDdyPVFbB1Sveu6UW93xf+xBKPJ1zVzpn0N29kZFSc0u1di+h4oL3a3tXIU
 e5jlJzaCtt0P2C8SWmIVWoCmLw2p/RJm8eDKh7uSJpzqRuocBCzLgf6fMjcBLIGgLy
 209L6gh6sJBcKULS+eS9EQK70NBYkfnatu27tNe7EFsyijsRwAtxnb2hrNIcf173mq
 g8OYRsGKawhMA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ZsDupRf4
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

Hi Balaji,

Thank you for the patch.

On Fri, Jul 24, 2026 at 14:58, Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com> wrote:

> This reverts commit 6de333b5caf035c38d7af9fa7596aeffcc49db42.
>
> The delay is unnecessary. Upstream Linux does not add this delay after
> the core soft reset and the USB works fine without it.
>
> Tested in QCS6490 RB3Gen2 Qualcomm board.
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> - This is part of ongoing initiative to reduce boot time across all
>   Qualcomm boards. So we can remove this unnecessary delay.
> - Actually, this delay was removed in the Kodiak v4 series:
>   https://lore.kernel.org/u-boot/20260418-kodiak_ss-v4-0-d381670c9d78@oss.qualcomm.com/
>   but v3 series got picked up: https://lore.kernel.org/u-boot/177745255938.126665.16625119085748603933.b4-ty@b4/
> ---
>  drivers/usb/dwc3/core.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index be198041f08..ae22e1c792d 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -106,8 +106,6 @@ done:
>  	if (DWC3_VER_IS_WITHIN(DWC31, ANY, 180A))
>  		mdelay(50);
>  
> -	mdelay(100);
> -

The dwc3 driver is not only used by qualcomm, but many other SoCs.

That delay indeed does not exist as is in the Linux driver since the
following commit f59dcab17629 ("usb: dwc3: core: improve reset sequence")

However, that commit is more conservative by adding retries and such.

I'd prefer to stick with Linux's approach here.

Also note, there is an ongoing effort of updating the dwc3 driver by
Linaro here:

https://lore.kernel.org/all/20260716134305.614278-1-anders.roxell@linaro.org/

Could you maybe give that a try? It should have the
"usb: dwc3: core: improve reset sequence" patch in there.

>  	return 0;
>  }
>  
>
> ---
> base-commit: d7ef23c07b8e34f65b3e15e3b4e7f58d074923c8
> change-id: 20260724-kodiak_delay-a5f1e8b675cd
>
> Best regards,
> -- 
> Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
