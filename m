Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 153CCE7C6F9
	for <u-boot@archiver.kernel.org>; Sun,  1 Feb 2026 01:44:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 619B083B85;
	Sun,  1 Feb 2026 02:44:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="uu0/bwFI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E03AB83B86; Sun,  1 Feb 2026 02:44:20 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C16083B5E
 for <u-boot@lists.denx.de>; Sun,  1 Feb 2026 02:44:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=19be=AF=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1769910256;
 bh=QVq0Yk2zKnfkDuoPs3kqMlxa5S+csqEqvo+O49O6TD4=;
 b=uu0/bwFIeIZjUHNxGfqyONtW6CvSmIGNiekwn0vDcqEYhajxFTjsp8PN6I1FzdFSSfAClRVgW
 2n0FPu/npbbg1r5OKYywsEsdObBtEmyDX/nT4Idz3QNv8zQfxJk2zKnefJkCbA++ruq2dNU+cZe
 6eSAACB49QoUrO2HWm8NgSv2P/IxvJ4d5HUv9NlVQE88mSuqok6LU+4rpuRwORB/IutIqdHLwTe
 QckbEDNw0deaUVJcflXxKUFkvU2OErIiXd950x/g0M0sROJ8lPdNr6KcXdvuUNDfvs6e6Fym4G+
 AM2u1rti/SWJpiasjF6zMrMPYTKSPMBtAmH4jxKholrg==
X-Forward-Email-ID: 697eafef8af2baab38e5ba88
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.5.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <1a702660-0a20-4cfd-ae6d-fc357d824672@kwiboo.se>
Date: Sun, 1 Feb 2026 02:44:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] tools: rkcommon: Add rv1103 support
To: Fabio Estevam <festevam@gmail.com>, Fabio Estevam <festevam@nabladev.com>
Cc: kever.yang@rock-chips.com, trini@konsulko.com, u-boot@lists.denx.de
References: <20260201004456.763107-1-festevam@gmail.com>
 <20260201004456.763107-4-festevam@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260201004456.763107-4-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

Hi Fabio,

On 2/1/2026 1:44 AM, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@nabladev.com>
> 
> Allow rkcommon to generate an image for the RV1103.
> 
> Based on Rockchip U-Boot 2017.09 next-dev branch.

This very closely matches the vendor version [1] and should most likely
keep source From/Signed-off-by tags?

[1] https://github.com/rockchip-linux/u-boot/commit/05a029d3fe9ad682fb6fa13ff81b2cb7a9e6fe34

> Signed-off-by: Fabio Estevam <festevam@nabladev.com>
> ---
>  tools/rkcommon.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/rkcommon.c b/tools/rkcommon.c
> index e7e78ef7e5b7..c680c0144fef 100644
> --- a/tools/rkcommon.c
> +++ b/tools/rkcommon.c
> @@ -148,6 +148,7 @@ static struct spl_info spl_infos[] = {
>  	{ "rk3328", "RK32", 0x8000 - 0x800, false, RK_HEADER_V1 },
>  	{ "rk3368", "RK33", 0x8000 - 0x1000, false, RK_HEADER_V1 },
>  	{ "rk3399", "RK33", 0x30000 - 0x2000, false, RK_HEADER_V1 },
> +	{ "rv1103", "RV11", 0x40000 - 0x1000, false, RK_HEADER_V2 },

This should most likely use rv1103b, and also please keep the vendor
header tag 110E, something I expect matches the maskrom usb pid.

The rv11 line seem to use following usb pid enumeration:

  rv1108 - 0x110a
  rv1126 - 0x110b
  rv1106 - 0x110c
   ???
  rv1103b - 0x110e
  rv1126b - 0x110f

Regards,
Jonas

>  	{ "rv1108", "RK11", 0x1800, false, RK_HEADER_V1 },
>  	{ "rv1126", "110B", 0x10000 - 0x1000, false, RK_HEADER_V1 },
>  	{ "rk3528", "RK35", 0x10000 - 0x1000, false, RK_HEADER_V2 },

