Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 391E4C88E75
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 10:35:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C571E60752;
	Tue, 15 Sep 2026 10:35:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KBL-iEUcNrdj; Tue, 15 Sep 2026 10:35:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 05E0460743
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789468505;
	b=siHW0GGR2RnMXdRp6xQCwCc8JxeH5ja4fjoQ9NqlMKRmQhSEZPkMeYgv4TRbwfs48XMD
	 LVzMkqa2pnsa0HOnBedBF548VlhxA7I2yejv5GmXxiExZ5oFXKtTUzQlWbPMExn7UyA2m
	 RyYRUFHsoXjZ2DkfqTHcGVMrbmX4R97PsBNTdkWDFihAzQQdmSy7/5YKtbX7VSIG0doc1
	 st5CaYfJFOnrwzxXPydST0MUdda/oqGwfDGmn6nSoppTUxv9YtbXoz9snIqwr3vs7rGB3
	 ihkInh0EAw8szfjM2goHAFVUXD1AgRyALw2vim2ANzfFtAxsz9uJ1hN6nyfUQgP4aOA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789468505;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ZRXqQw8JMDjgGEpV9+K0ykyNytAUZKYvgTmPHuIfP2g=;
	b=TnLRlvNIKOnWd+DZ28SiX/TNXir434ufxyrEQjEtekTMx92UWuMgPBHFYcUkKl5iHsi0
	 2/UkNXF6+3eFCvbNddwfwQW23IptQDVZVSMuET7mDt3q57dsoybK5r59l4Jn8b0pCtbdz
	 mZe+PzyYrP7pP9HyokVWdZ/RvY8gFI/ucFSt6whoITR1gOcvIhDMWkmKXgfv+9MicXOGf
	 sTPejrZRzX70OfikNKT8MoYGVgmMWk3+3rHKd37xHp3PGoJFASesnhics7b4SEG0BXXRt
	 Sn5wCSC0m/L3X2JGo3oD0ssF4LDjx/qbPfhoX0DOa7Ec6j42YDcgXiaijXAImoNWDyg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789468505;
	bh=ZRXqQw8JMDjgGEpV9+K0ykyNytAUZKYvgTmPHuIfP2g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N8YnTw9fCpIIPDfLFzDaZEHnY6OfbLeeOmY+fPLGwD/PyWcQZoA8o/mBM+Yg3WmXf
	 vqy/Br9X89cfZZZ2Of+isKm+rzYv07wIjlsqKvsGYxz8Lu73fOOPkHepu5oJ9oZPYY
	 HiOZzrD8OCSlBw4vlMa2hxWeZ6dsworz+0C4UQ1apeQnHZymWthbcK0G+fns14xc3U
	 xR5viURPrdGtGittMJnsq74rbRyPRKrRg01mbZAbf8BruA6beyFv4oGyRh2Oc8hzaS
	 I8tdV1pknsIXNYz7Y0zr6GSCCk27J65c2FCwJlRmqwtZ7P1pjT+F7Cpb8Zgt/zptdw
	 BLi0rg3KVBC+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 05E0460743;
	Tue, 15 Sep 2026 10:35:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 62DED493
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 10:35:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1F23780C94
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 10:35:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ko5Q4aeB4FXT for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 10:35:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org EA25880C7E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=31.31.198.150
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789468501;
 b=V+3xq4NRI1XUdrD7ZX49ER7V6YYVSl4UevC3uLmcFpDuA+6Os+qcYAI2GKMFezJ/4I6s
 Acw1Kze5NEYNTc2YpPTkYKxJQ9bRG3PmStUblLf13A+jDumrEMLrR3jbGisTf20Tgbxrs
 LKoWLXYfl+1WXmS151BYs7HreLDk8MIPCI7E46KuluwPDrQSo8qRWxnDjMuX+vpYM3r3Z
 jU2fZ+5YMxKHHbe2xDFxmyouDS2EAB1etMkp880l3/d9DdEKRtg7T0Yg8Nu2qlyBgHWP2
 I045GRU2KB9jR2Qs6B2EAs9keDuIZDrTva+UtCSyj4mO0fDGtBTi97yGQJoByl57wWQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789468501;
 h=X-Greylist:Received-SPF:DKIM-Signature:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=ZRXqQw8JMDjgGEpV9+K0ykyNytAUZKYvgTmPHuIfP2g=;
 b=rmTeZeujrfAAM6zNSvopIsr84MfzyyiNeu5YmOmeCsyO3s24tOTwCCLsKKO/tQCyBi98
 w7z3Q+pl3BKK+23Rwhb34jqt8GYZS+OsqdbdrCKXzmmMgVWksU2+nwc0KeWEqrho+WYTU
 +EPnYoQd2PhvC0ZWrBdXXOhPtC5DcXLKhN76tnVwSg5xhmgmMNwHYSebGqeWLRF4IJXCI
 tOuB64idcq95pjz/9aAFHh1o/y9IbU7a9vW/RSPbL3I69q1IMQreixBFz1vMf2JtJvJbZ
 koXiCIcrh6BYQFRHo+lY6Jpk1KS/JMST85IBRWmKzKfQ7eotPgSs9nLHiOZ4kqgTtbw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=minlexx.ru; 
 dkim=pass header.d=minlexx.ru header.i=@minlexx.ru header.a=rsa-sha256
 header.s=dkim header.b=o4XSOHFe; 
 arc=none smtp.remote-ip=31.31.198.150
X-Greylist: delayed 2981 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 15 Sep 2026 10:34:59 UTC
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=minlexx.ru
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=minlexx.ru header.i=@minlexx.ru header.a=rsa-sha256
 header.s=dkim header.b=o4XSOHFe
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=31.31.198.150;
 helo=sm24.hosting.reg.ru; envelope-from=alexeymin@minlexx.ru;
 receiver=<UNKNOWN> 
Received: from sm24.hosting.reg.ru (sm24.hosting.reg.ru [31.31.198.150])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EA25880C7E
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 10:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=minlexx.ru; 
 s=dkim;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:
 Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ZRXqQw8JMDjgGEpV9+K0ykyNytAUZKYvgTmPHuIfP2g=; b=o4XSOHFedz51WjWwHdx45xBjFr
 M7Iix4jFd5Vfj9F365StK1ELN+r0pWLl/bU2AH7boRcPgGSXHn8FwRM0N8sj7A1fKrq7pdh7IjUES
 HgB/5I7rZ1BjGOjesnlcRXjbAzXN2cUaLY6ni1qg6Yr/Y7+Afcdd+IDGdhZ9kRr/i0aU=;
Received: by sm24.hosting.reg.ru with esmtpsa (TLS1.3) tls
 TLS_AES_128_GCM_SHA256 (envelope-from <alexeymin@minlexx.ru>)
 id 1x6Piy-00000002U3L-0wdn; Tue, 15 Sep 2026 12:45:13 +0300
Message-ID: <461c7cb9-0e21-464a-9d11-72239ead6e93@minlexx.ru>
Date: Tue, 15 Sep 2026 12:45:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] clk: qcom: Add an option to poll for GDSCR
 GDSC_POWER_ON bit
To: u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Reza Kurniawan <imkyufie@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
References: <20260912072619.244101-2-imkyufie@gmail.com>
 <20260912072619.244101-5-imkyufie@gmail.com>
Content-Language: en-US
From: Alexey Minnekhanov <alexeymin@minlexx.ru>
In-Reply-To: <20260912072619.244101-5-imkyufie@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 12.09.2026 10:23, Reza Kurniawan via groups.io wrote:
> Some SoCs such as MSM8917 poll its GDSC power domains by reading GDSCR
> directly, as opposed to GDSCR + CFG_GDSCR_OFFSET.
> Add a poll_gdscr flag to struct qcom_power_map to facilitate those SoCs.
> 
> Signed-off-by: Reza Kurniawan <imkyufie@gmail.com>
> Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> 
> (no changes since v1)
> 
>   drivers/clk/qcom/clock-qcom.c | 24 +++++++++++++-----------
>   drivers/clk/qcom/clock-qcom.h |  1 +
>   2 files changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
> index 6b46d9db7..754ff4ff4 100644
> --- a/drivers/clk/qcom/clock-qcom.c
> +++ b/drivers/clk/qcom/clock-qcom.c
> @@ -505,9 +505,9 @@ U_BOOT_DRIVER(qcom_reset) = {
>   static int qcom_power_set(struct power_domain *pwr, bool on)
>   {
>   	struct msm_clk_data *data = (struct msm_clk_data *)dev_get_driver_data(pwr->dev);
> -	void __iomem *base = dev_get_priv(pwr->dev);
> +	void __iomem *base = dev_get_priv(pwr->dev), *poll_addr;
>   	const struct qcom_power_map *map;
> -	u32 value;
> +	u32 value, mask;
>   	int ret;
>   
>   	if (pwr->id >= data->num_power_domains)
> @@ -527,19 +527,21 @@ static int qcom_power_set(struct power_domain *pwr, bool on)
>   
>   	writel(value, base + map->reg);
>   
> -	if (on)
> -		ret = readl_poll_timeout(base + map->reg + CFG_GDSCR_OFFSET,
> +	poll_addr = base + map->reg;
> +	if (map->poll_gdscr) {
> +		/* Some SOCs such as MSM8917 poll at GDSCR */
> +		ret = readl_poll_timeout(poll_addr,
>   					 value,
> -					 (value & GDSC_POWER_UP_COMPLETE) ||
> -					 (value & GDSC_PWR_ON_MASK),
> +					 (!!(value & GDSC_PWR_ON_MASK) == on),
>   					 GDSC_STATUS_POLL_TIMEOUT_US);
> -
> -	else
> -		ret = readl_poll_timeout(base + map->reg + CFG_GDSCR_OFFSET,
> +	} else {
> +		mask = on ? GDSC_POWER_UP_COMPLETE : GDSC_POWER_DOWN_COMPLETE;
> +		ret = readl_poll_timeout(poll_addr + CFG_GDSCR_OFFSET,
>   					 value,
> -					 (value & GDSC_POWER_DOWN_COMPLETE) ||
> -					 !(value & GDSC_PWR_ON_MASK),
> +					 (value & mask) ||
> +					 !!(value & GDSC_PWR_ON_MASK) == on,
>   					 GDSC_STATUS_POLL_TIMEOUT_US);
> +	}
>   
>   	if (ret == -ETIMEDOUT)
>   		printf("WARNING: GDSC %lu is stuck during power on/off\n",
> diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
> index 3a4550d85..0b514cc1f 100644
> --- a/drivers/clk/qcom/clock-qcom.h
> +++ b/drivers/clk/qcom/clock-qcom.h
> @@ -76,6 +76,7 @@ struct qcom_reset_map {
>   
>   struct qcom_power_map {
>   	unsigned int reg;
> +	bool poll_gdscr;
>   };
>   
>   struct clk;

Hi,

It's doing the same as the patch that was already posted, right? [1]

Sadly it got no reviews, which kind of demotivates any further
contributions to u-boot/qcom.

[1] 
https://lore.kernel.org/u-boot/20260715-gdsc-flags-v2-4-27704470a24c@fairphone.com/

--
Regards,
Alexey Minnekhanov
