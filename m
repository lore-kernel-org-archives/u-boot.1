Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3057DC27C4F
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 16:44:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82D2A887B1;
	Fri, 31 May 2024 18:44:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="bhIStOLw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 144B9887C9; Fri, 31 May 2024 18:44:36 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDA92882F1
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 18:44:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=7f33=ND=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1717173861;
 bh=MCt4jzQjr9JCzN1wGXzdzPdX9qXI6cse28O+HcR8++0=;
 b=bhIStOLwpZRTvgv1LbrLKtC2xq3CoKe9/GKMIyuQs5QyNtsdviyxUeFrR/v/+VXwP3Oaav1pl
 Et9bw0A6qkoFphPRzBV4qpZCVcKiNIBt8TUFYa5Qu8M/0cf/fdLszSuYrcc2GB+3e2PdnGl+XSr
 ebLQ6pWN1BkatkECLFE29IqayEDvmH0L4UAztf+HrGOFTC142QjifCwrllseG1jrvdTL2x0tQlK
 I2Pk08nXABMCbbe/pL0cS6EKsteSZfprA79wZa8/sqQ5fB+xGg/22D8fD8gx6AMeBDlmL41sED2
 0JitwG6gScHcRViph7P0FeUOudc0U6fRTVYBdRfVKbtQ==
Message-ID: <99479aa4-6bdf-4265-b30f-ab571ec3adca@kwiboo.se>
Date: Fri, 31 May 2024 18:44:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 22/23] sysreset: rockchip: use fst reset for ARM64
 SOC
To: Anand Moon <linux.amoon@gmail.com>, Kever Yang <kever.yang@rock-chips.com>
Cc: Anand Moon <anand@edgeble.ai>, Tom Rini <trini@konsulko.com>, Simon
 Glass <sjg@chromium.org>, Jagan Teki <jagan@edgeble.ai>, Quentin Schulz
 <quentin.schulz@cherry.de>, u-boot@lists.denx.de
References: <20240531141837.13189-1-linux.amoon@gmail.com>
 <20240531141837.13189-23-linux.amoon@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240531141837.13189-23-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6659fe6436515b5bc7dd9f87
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

Hi Anand and Kever,

On 2024-05-31 16:18, Anand Moon wrote:
> From: Kever Yang <kever.yang@rock-chips.com>
> 
> Rockchip ARM64 SOC will change cpu entry, only fst reset can reset it.

What is this trying to fix? And what SoCs is affected?

My arm64 RK SoCs seem to reset using warm reset (second global reset).

> 
> Cc: Jagan Teki <jagan@edgeble.ai>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
>  drivers/sysreset/sysreset_rockchip.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/sysreset/sysreset_rockchip.c b/drivers/sysreset/sysreset_rockchip.c
> index f353f9b4c7..17aa191349 100644
> --- a/drivers/sysreset/sysreset_rockchip.c
> +++ b/drivers/sysreset/sysreset_rockchip.c
> @@ -22,7 +22,12 @@ int rockchip_sysreset_request(struct udevice *dev, enum sysreset_t type)
>  
>  	switch (type) {
>  	case SYSRESET_WARM:
> +#ifdef CONFIG_ARM64
> +		/* Rockchip 64bit SOC need fst reset for cpu reset entry */
> +		writel(0xfdb9, cru_base + offset->glb_srst_fst_value);
> +#else
>  		writel(0xeca8, cru_base + offset->glb_srst_snd_value);
> +#endif

If this is needed maybe use something like this and let it fall through
to SYSRESET_COLD?

  if (!IS_ENABLED(CONFIG_ARM64)) {
	writel(0xeca8, cru_base + offset->glb_srst_snd_value);
	break;
  }

Regards,
Jonas

>  		break;
>  	case SYSRESET_COLD:
>  		writel(0xfdb9, cru_base + offset->glb_srst_fst_value);

