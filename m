Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA695CA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 16:00:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9A54F40665;
	Mon, 12 Oct 2026 16:00:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3hJeQOiQfwAh; Mon, 12 Oct 2026 16:00:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E202E40660
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791820833;
	b=mV6O14yPp7lXkKphMckEqL1yC2wNJLmVCksmowN6epTbfb911DND6aMAW11kXHWN0QOz
	 w8p+m9t9jlmCY+6S53jlE/EoIOud6PgFsdKBfgR8F9+8eLC+5Dwmt7JQPnQnOAFL4GTOr
	 7gsxdlUSlHSJlKrt4Wh0z3QGejlK8Oz6IvJzqvWlVf5mg9G23mBiND1/HAB4DUYrBIoPW
	 u3T9ucnzYOglHKNVf9HAmallWc7UeKMEyvg4lb4fQLiDqs5yzf4gM/hsf76N/5mnxqGfc
	 igdJPkP9SqitaR1fBdasTieiM4LSBoe3uMzJ19NHztGI0HsUiAqMBnP8uHZhEhR0WEg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791820833;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=QP2/M3dHumluXuIsMKLs4l6ci+j+eZMhi9w0dftHFuA=;
	b=p40Xjtimik2AIgEFb80zyxB+4h+pwFL60aG3lW8geSGFlY1j9YOyZ7pP7mubs2cvgTrW
	 CgZPiAA6eHfH6YlagxnHKjyy1IJEaxG+l4QIuj/VQmCHkIVi5dUAt8NfZo28ujLsWPJsm
	 vlolP5zy7nOE7PnofVPicvekzgKgqaX0LKjhqp0AeDGn/zKQX8JpZIgJslwmu0eZXBZD7
	 FKz7ft2l5HzfjDNTtoi1rjpukpE4br9Emi+hg186/4M77DzLWoXkeAspshHHZFib8TV2W
	 SAsKYvkWi7z8VXmQzHvUrOCxJ/w/H19+BgnASBYEBOj9GD0Z7tP3QqymN6JeofWncow==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=0leil.net;
	dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=abBtuO01;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791820833;
	bh=QP2/M3dHumluXuIsMKLs4l6ci+j+eZMhi9w0dftHFuA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zjH+OG621E2JHvRztKFDN0jKxQkA/63ZxEgZQluouqZfrFM6zYHJKbc/jmHNh+xXc
	 +wwFdYTL3nc6Zid9xRuHoKgFEG/5BNtSjcH1llTvEXfDzer7UpdCzEIWDJ/XsTc/Ej
	 X6bFuLs9hYSuMW2FlHVVhoNRQ2YFyBNGIvDQWZ35BmsdHuIqCveqcTN3VSOTB5JVqu
	 6UImew9uAB5L0dOxW/Icfa+5Eh9OCRDl0Atnqi3CYNTTz3vvYTmDL+yj02/R00XoZ9
	 tUfLf/t7U3jdQGFx8H1RmkO/0fUHSGtS9Sn50x8BHEmmkeZCUFRPZGh0IiS2cXOFW/
	 QXKRuR/FN7Qew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E202E40660;
	Mon, 12 Oct 2026 16:00:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 16DD6105
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 16:00:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 080A940660
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 16:00:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6XY2Dviwi3ld for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 16:00:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EBD694065F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:b8b8::42ab"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791820829;
 b=qM0xXifBADRxkX0Wvq1k+BE5zUOVFAkRpXHkZlUEPhfKDCAiVa6M/hib0kxaLe2rOemv
 e6Nxm1IYBAkIC/c/B9UXYuPU9mJ2nMJk3cfiLFROip/XwF30WGNvrdNv45Hz033TtbVVM
 qfvQUbpNstaP4ERCams+XSnjFH9K+650Cv2eyBiWtuE0TzgNwflo4bw0Kpx7hn1nV+7Y+
 FJVZZTiGBho21UQwkcPJ0uOJnZLorr6SYSBuGoCBZtcL1xELYADpyw8UfzItXW3AtGVjG
 kdCz5q/QsR8U4HDuIGLm7yHGyC2Bx8vvwMAOUf5qLcajq3AwLImzbcCtHG2QhchLizw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791820829;
 h=Received-SPF:Received:DKIM-Signature:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Infomaniak-Routing;
 bh=QP2/M3dHumluXuIsMKLs4l6ci+j+eZMhi9w0dftHFuA=;
 b=fL/m8y0bQZMPSHWlkewe4E/ughtFTqri9dB33VVSE/GEqJoEgQVgLL9vJlUJHUs83tp7
 QeRghn0PbmuQWnoMMXqeWeBu5otWdvMQPdWnfg8Oog862sYEl1g+mg018GyzEczVSTf//
 mNWLu/Z2iKHS03iN/9VGeHwo2GlcbJLSOnW/tlVjb6eqEvJRLNUh+u3WFLIXXpWCIWqBD
 NVYvgcwXl+vJRZctvCr4YpHSCGwV8pdGaxNVgXdl3Y5On145zhMyZrWU1WMQHoIjzBTZs
 lYyHENcjuiF285Hn5OUG1M+gC2MhQuy2chLzSj0jMGvGTydc+vFmAHM4m/MRQfQ8/6A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=0leil.net;
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=abBtuO01; 
 arc=none smtp.remote-ip="2001:1600:19:b8b8::42ab"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:b8b8::42ab; helo=smtp-42ab.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=abBtuO01
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch
 [IPv6:2001:1600:19:b8b8::42ab])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EBD694065F
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 16:00:27 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4j3Mcm5wGBzJVD;
 Mon, 12 Oct 2026 18:00:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1791820824;
 bh=QP2/M3dHumluXuIsMKLs4l6ci+j+eZMhi9w0dftHFuA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=abBtuO01w4dBccc/XqexmMHx7j3BQs/REpZ5vh44JCYQ1kEf9n2q/9KYlXWGzS7n7
 WZuH0kYuXrztz0J64NbHvY9/nlHS8SSOOxmUB2XvOFxLhKt9KCsJw+Dau47BPDLlU4
 Nq7bcb6UDDKeGzeWfm1Dr8wFttIcquaMflzKQQoidzSUvvGZiuiza3+s+kugGfo86R
 w8+4AAbJ65EeI+2bZZs9CBRT1Z0CrTAOPuTEtfDcnnxO1TrEWDagyK+i0vngxARgzh
 W0EQazR7Y0cs3ivoJY8xmEh8bXwrfP6qGZnKToLOD8c1RS3VU/JugyDFy32qQipmlH
 Y5Aomd3OmhFPg==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4j3Mcl4F5wzVZr; Mon, 12 Oct 2026 18:00:23 +0200 (CEST)
Message-ID: <dfe79f19-2fa3-42ca-87a0-e80ee086c7e6@0leil.net>
Date: Mon, 12 Oct 2026 18:00:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] clk: rockchip: rk3568: Always initialize clocks in
 SPL
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
References: <20261012111552.1173161-1-jonas@kwiboo.se>
 <20261012111552.1173161-2-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <20261012111552.1173161-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
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

Hi Jonas,

On 10/12/26 1:15 PM, Jonas Karlman wrote:
> The RK3568 clock driver initializes ACLK_BUS to 150 MHz when probed in
> SPL. However, the driver is only probed on demand, so this
> initialization is skipped when no SPL consumer requests a clock, e.g.
> when booting from RAM/USB.
> 
> Prior to the commit c6bba31dbdd4 ("rockchip: spl-boot-order: Defer probe
> of boot device") all boot devices where typically probed, with a side
> effect that clock driver likely also where probed, prior to the
> boot_from_devices() call.
> 
> Flag the clock driver to be probed after bind in SPL to help ensure a
> deterministic probe and clock initialization behavior prior to booting
> from devices.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
> Changes in v2:
> - Update commit message
> - Collect r-b tag
> ---
>   drivers/clk/rockchip/clk_rk3568.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
> index 9f3e9322161e..5a05f1b4de00 100644
> --- a/drivers/clk/rockchip/clk_rk3568.c
> +++ b/drivers/clk/rockchip/clk_rk3568.c
> @@ -2934,6 +2934,10 @@ static int rk3568_clk_bind(struct udevice *dev)
>   	struct udevice *sys_child;
>   	struct sysreset_reg *priv;
>   
> +	/* Ensure clocks are initialized after bind in SPL build */
> +	if (IS_ENABLED(CONFIG_SPL_BUILD))
> +		dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
> +

There's pmucru in this driver as well, shouldn't we also probe it after 
bind? Or how did you decide only the cru driver should be probed after 
bind and not pmucru?

As a general note for the commit log in v2, they are good enough for me. 
It clearly states we go back to what we used to do as a stop-gap measure 
to fix various issues we hadn't when we used to probe all boot devices, 
and hopefully we'll fix this properly once we know better. I don't 
really like it, but I think it's reasonable.

Cheers,
Quentin
