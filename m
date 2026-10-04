Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB3F9CA5FDD
	for <u-boot@archiver.kernel.org>; Sun,  4 Oct 2026 02:18:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5D6B340A3C;
	Sun,  4 Oct 2026 02:18:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5udnMuhS09uw; Sun,  4 Oct 2026 02:18:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5DF6F40A5B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791080317;
	b=qpI1OtwC3iyMJFf9zSiETbooLBomdzosXeFxO+tjV+M77oZuJq/qDucmxw1bDv+ARZ+y
	 uA7RJofssDWc/wagEaVM/34yXtZ+0ETH842v0mBOOrGM1+DQia9CQkbxk1ox3I21k7xbX
	 CsnzNIJgSmIpFZE3TdZIyS5Bt+oMCu8d0784tBhXcujQZlznhbep4pGrIVygncUylBZk1
	 5nBcYkk1gueam76tgAe6FeTPCkX8oX+TjuCOTVIEKt3Tmtv43jbxV6XCVImFnqIsnqYwr
	 4wS9UBHHS71arjCuNfoolzmoHWsPid3euc5xz4uxB+ykoq8MUPV6A0D46eosIupk9IQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791080317;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/wCrpswsjjU5nsYZOSJPUgSew53Mbn17zxYEDJjNrZ8=;
	b=mVpLBq93ZGC19GwDQH9MdnSj6UdAooRX05bFQdw42vCzrqBitxB/BFweNmbL/p73ycXE
	 9Jrz0biTNKPNCI+KUcfwtHh988bU+Q94ZDW+aZIWI8iG5VVWX3g5gr4UIWMpJNG9tSgVP
	 DE9NF+XdCuOVTKCinwHo+aPJMLr29r6KIPKh+dSHcI0OIu8/CENsvKk7x0bdH8IhxUa5x
	 7f4mpEI2XY+smisLA+7/GNVCqokDaZ1Uh5SFTKmnU4caSMrcm3WVDuYSKobcIvREBKgpQ
	 a4G7eOoVUGDJmW+AJk1bvTUCQWNJQEPYgwpXuSoZmkQmFs0+19j/x36JFlVPYWjDYQg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791080317;
	bh=/wCrpswsjjU5nsYZOSJPUgSew53Mbn17zxYEDJjNrZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iT8AX5DOToKM8gEdkkmLF3rkz6x2Sc5sUo6SPSZlo2xDCxZrtr9KYlptu6yqsR+lw
	 zgk2qqm2ssuf1Fqz7AIF0rGN8v32Zy275UPakn1JcTj5cTNNHIGs3/IuD2RW4J2aWp
	 WrkFtJDQ7f55dStT+oUZ0AKuDEbcdqhv8DXxqPR6tdIysQvpQsp3oz48keZnZiW+Qn
	 YhRAOgNHl0xKxgfroljoRyBDf+jBcMqJpQfBRRdSnt/5heBFYjevDq30jwlSvkD509
	 FsawdYMtRAjc8kuN6ioN66ZpYGzMXCa6FKDvcAe1MVMTooDBPCYbGANq/eQoPVmWEX
	 GYHinZ2PXko0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5DF6F40A5B;
	Sun,  4 Oct 2026 02:18:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CE966435
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 02:18:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C050260624
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 02:18:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UT3pkJaR6ZlL for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 02:18:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9655F6061D
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791080314;
 b=SbmCSL8MjKiU5LWuX53VM5IsO2cuRVEdhifzbyfxgmnJXykRVc+Kfm3exDe0mZpueJUu
 WaWuryiRGnrz5S+iRM/SHoI5ocKjqmQ0gbKXAknfQ56jQBay5uQ53J+PuUZ+4uRY60iip
 JBoxQkpJs/56+6bcOG3057wwf+lFXZeM6dIici99vMKXe8/hOPvq0bqLJEi06LkffL1IX
 cas/G/9afeUoHIcvhdCiNYIu6UGyvZDCV4WDRJtDxb452vMAzh+3oJyc5ETI97KlqJ4w3
 wP3UjpchpYsVfzfdj9a/llCx/XMLc9f0eJgI9ntBp9Q1HHmJ9XK1HRa1eRn3/7kNVmw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791080314;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=/wCrpswsjjU5nsYZOSJPUgSew53Mbn17zxYEDJjNrZ8=;
 b=G0ZtqWO0UduBv++aE674FlvrsFVPwcxeA39qhYMu8JbNAlzBjFWNRb23Vn18KoRMqjZ1
 85PMJ+ObaSS9V4n1N5pIpWk+f+Gp84IfB30NyUsleh2E8+RXY0D08Zp3kiRTxVGWO+aH+
 2QFbwA3w6ccMquIFZFCsRfR+JL1mJwRlFCTOMJwZBQng9ZVUUZ0gJdI+qGZuhGg8xggJY
 T/YpcdfKAud5yN4en60b595Pi5SxLgcW2kOBnjW8tSQslzJMbdZiQFxlqFT7tDawzpFOz
 uMoGKAKppb5qmXVRj8prgzyYpaefucYhGNU2AUyyUX+aRmLwujQ+ECxVDwetjeW/XIg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ePusMDIC; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ePusMDIC
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9655F6061D
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 02:18:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4A44560052;
 Sun,  4 Oct 2026 02:18:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF8E1F0089B;
 Sun,  4 Oct 2026 02:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791080312;
 bh=/wCrpswsjjU5nsYZOSJPUgSew53Mbn17zxYEDJjNrZ8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ePusMDICy2MwrAKnELeLvplrH08ugJ8HhaRsIYc0U8SIgj9/f9M45XWQrW8+c14iy
 ifYdI1yCYWSAAKQNFgRigUxBKgR9UWoxT+Auilyt3Jq5d3m+THEaGCTTOxX6SpjxAS
 c64BtBUONamEMf5ITbJQdOk8GNwpOimwsErKaNcvN0Nx+4vz4FxfwpjWdbAf+/wp/K
 MTC0m3ZqN5svW4uZVkf+IZIpDzwcXihawpLuX8cjdCt/nFyQGbXsueP+N2tg4RDEca
 6Acf/+uz2iQmQBtWy0BjIb75Uakjr/4zYVJoFa1SGirvPFVzz/QcvG5/DEC9vWLyoY
 M2yKX8Nw7j9QA==
Date: Sun, 4 Oct 2026 02:18:30 +0000
From: Yixun Lan <dlan@kernel.org>
To: Dave Klotz <DaveWK225@protonmail.com>
Cc: u-boot@lists.u-boot-project.org, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>, Junhui Liu <junhui.liu@pigmoral.tech>
Subject: Re: [PATCH v2] clk: spacemit: program the mux when setting a mix
 clock's rate
Message-ID: <20261004021830-GKD68132@kernel.org>
References: <5aa2337bcb969568749c4728354164d5a6c88f27.1790975596.git.DaveWK225@protonmail.com>
 <25a05161c25d59a153acde52f798e5fcf570bd41.1790993264.git.DaveWK225@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <25a05161c25d59a153acde52f798e5fcf570bd41.1790993264.git.DaveWK225@protonmail.com>
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

Hi Dave,

On 02:39 Sat 03 Oct     , Dave Klotz wrote:
> ccu_mix_set_rate() picks the best parent and divider but writes only
> the divider. U-Boot's CCF has no determine_rate step that would reparent
> the clock first, so the clock keeps running from whatever source the
> mux selects, at a rate the caller never asked for. Worse, when the
> hardware mux selects a source that this build's parent list does not
> contain (the K1 SPL lists only pll1_d6_409p6 for the SDH clocks), init
> registers the clock under parents[0] and the clock framework's idea of
> the parent no longer matches the hardware.
> 
> Reparent the clock to the chosen parent with clk_set_parent() before
> programming the divider, as the clock core does in Linux. Do so also
> when the framework already has that parent but the mux selects another
> source. Nothing is written when the mux and divider already match, so a
> clock left running at the requested rate by an earlier stage is not
> disturbed.
> 
> Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
> ---
> Changes in v2:
> - Reparent through clk_set_parent() before programming the divider, as
>   suggested by Yixun Lan. CCF enables the new parent only when the clock
>   itself is enabled.
> - Reparent also when only the hardware mux disagrees with the chosen
>   parent, including the SPL's single-parent clock registration case.
> - Share parent-index lookup with ccu_mux_set_parent(). Keep the no-write
>   case when the mux and divider already match.
> 
> v1: https://lists.u-boot-project.org/pipermail/u-boot/2026-October/633805.html
> 
> The parent/divider selection algorithm is unchanged from v1. This
> revision changes how the selected parent is applied.
> 
> Retested on 2026-10-02, with the integrated board-support lane on next
> bd2f5794b7e2, OpenSBI v1.9, and "clk: spacemit: ccu_mix: fix inverted
> condition in ccu_mix_trigger_fc()" from Yixun's k3/for-next tree:
> - OrangePi R2S: eMMC SPL boot, SDH2 I/O clock 204.8 MHz instead of the
>   BootROM's 409.6 MHz; U-Boot HS200 at 200 MHz/8-bit, normal EFI and
>   FreeBSD boot, and a final unattended reboot.
> - OrangePi RV2: microSD SPL boot, U-Boot SD High Speed at 50 MHz, EFI and
>   FreeBSD boot with root on NVMe; two boots checked.
> 
> Both CPU clusters remain at 1600 MHz on both boards, with SSH working
> following boot. The R2S, RV2, generic K1 and RV2 SPI configurations build
> SPL and U-Boot proper without compiler warnings; checkpatch passes.
> Generic K1 and RV2 SPI are BUILD-ONLY for this revision. No before/after
> performance benchmarks were run.
> 
>  drivers/clk/spacemit/clk_mix.c | 79 ++++++++++++++++++++++++----------
>  1 file changed, 56 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/clk/spacemit/clk_mix.c b/drivers/clk/spacemit/clk_mix.c
> index a1158512a9..fc8e0fd41d 100644
> --- a/drivers/clk/spacemit/clk_mix.c
> +++ b/drivers/clk/spacemit/clk_mix.c
> @@ -136,14 +136,63 @@ ccu_mix_calc_best_rate(struct clk *clk, unsigned long rate,
>  	return best_rate;
>  }
>  
..
> +static u8 ccu_mux_get_parent(struct clk *clk)
This problem isn't introduced in this patch, but while review it..

I have difficulty to understand the function name with what it exactly do
here.. I think it trys to retrieve current parent index where the hardware
programmed to, so I think it would be better to rename as
ccu_mux_current_parent_index() or ccu_mux_get_parent_index()

> +{
> +	struct ccu_mix *mix = clk_to_ccu_mix(clk);
> +	struct ccu_mux_config *mux = &mix->mux;
..
> +	u8 parent;
I'd like to simply name it as 'index' instead of 'parent', we already have
"struct clk *parent" which will brings confusion..
> +
> +	parent = ccu_read(&mix->common, ctrl) >> mux->shift;
> +	parent &= (1 << mux->width) - 1;
> +
> +	return parent;
> +}
> +
> +static int ccu_mux_parent_index(struct ccu_common *common, struct clk *parent)
same reasone, how about ccu_mux_wanted_parent_index()? it's a parent index that
expected to program to the hardware..
> +{
> +	int i;
> +
> +	for (i = 0; i < common->num_parents; i++)
> +		if (!strcmp(parent->dev->name, common->parents[i]))
> +			return i;
> +
> +	return -EINVAL;
> +}
> +

The patch looks good to me, so with or without changes

Reviewed-by: Yixun Lan <dlan@kernel.org>

--
Yixun Lan (dlan)
