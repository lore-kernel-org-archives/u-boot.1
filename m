Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F27CD98E4
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 14:16:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB58A848C5;
	Wed, 17 Jun 2026 16:16:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ImNe6/bt";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="iIkI6vCR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9ED1E848E2; Wed, 17 Jun 2026 16:16:02 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E209084833
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 16:15:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ggQrF3b5Nz9tnq;
 Wed, 17 Jun 2026 16:15:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781705757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LZdsSwp8XmKeF3O1PCzcKgrsTUvFGbyY7+7oebFJyFE=;
 b=ImNe6/btYFnaJ2hJutKyGyz9NYotGqE7FmrTrP/A1d8Z9QsP6XNcdKAwhYR58t6Pfxr3n4
 Lh6R2ZvpNO6xBKxIPhRX0eO8yYAfrpp1GLpQNSj9Pi3866KwlnBxpM6bkNcj8MpgmVUT4m
 BSGuWq8vxzX76KwvobqJ7g5VYD1INOq34YnEqL7T+HXE80M6i5yI66VoqDhr6qtJQITAfs
 56gQvoPDtWUcb5F3m0WXJ0QScUbMOeMy8ROtB0jmya3yjedcpXsyCG+PuWoRHq6F/R/lzf
 YkImq/dTmn5g+4CyVr/ZOWFfuK3LQipNMHX+Me54ALo6lCpQX0JO1sqOnV1Jeg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=iIkI6vCR;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <bf2ab861-b9d2-424b-a839-58abf074a449@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781705754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LZdsSwp8XmKeF3O1PCzcKgrsTUvFGbyY7+7oebFJyFE=;
 b=iIkI6vCRdHnwaplnkz0aShJaa6Ni8i5LtFmMT3JU9kdYd4P2wo1HMs7mj5RC1UxuvL1DfP
 owhKhKsJcNWwvzxErN1cwfBbWak8agkFljb1qQRzv0JEahBjwD9DfNYFe9Tmcc0/cpzuFd
 KbLN7SQquebV1BKL/+zMn3sG9eRmZ4Q874K5XLlcHItMpM/yC38EBnKqjAAtYOY3hH4YvT
 Sce2huFlwZHpoDiCN6/SvAr6kouFGR0LPXUz2lOAUi/DG5Wenfr/LI1nv6ekefdIsaA1Fh
 DLenQwdqSn5CSEVl+ogPZF/iIOI1V+s/ukwVjCj8quu3WLCNZk0bXnNG11d05w==
Date: Wed, 17 Jun 2026 13:15:14 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 01/11] usb: tcpm: fix inverted poll condition in
 tcpm_pd_transmit()
To: Neil Armstrong <neil.armstrong@linaro.org>,
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, u-boot@lists.denx.de,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Wang Jie <dave.wang@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Casey Connolly <casey.connolly@linaro.org>, Ye Li <ye.li@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Alice Guo
 <alice.guo@nxp.com>, Balaji Selvanathan
 <balaji.selvanathan@oss.qualcomm.com>, Peng Fan <peng.fan@nxp.com>
References: <20260617-tcpci-dwc3-v1-0-b824fe1e9299@nxp.com>
 <20260617-tcpci-dwc3-v1-1-b824fe1e9299@nxp.com>
 <3ed2c692-28cb-4ae0-910f-d022d9b7e73d@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <3ed2c692-28cb-4ae0-910f-d022d9b7e73d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: tqh1k7whzdo8j1431q7nmj3kepfmxrao
X-MBO-RS-ID: 57b4122bd0736d5a124
X-Rspamd-Queue-Id: 4ggQrF3b5Nz9tnq
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

On 6/17/26 9:41 AM, Neil Armstrong wrote:
> On 6/17/26 10:23, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> The read_poll_timeout() macro breaks out of its loop when the condition
>> evaluates to true. The current code uses "!tx_complete" as the
>> condition, which means it exits immediately when tx_complete is false
>> (i.e., transmission has NOT completed yet), rather than waiting for
>> completion.
>>
>> Fix the condition to "tx_complete" so that the poll loop waits until
>> the TCPC signals transmission success/failure/discard before
>> proceeding.
>>
>> Without this fix, tcpm_pd_transmit() returns before the TCPC has
>> finished transmitting, causing the PD state machine to proceed with
>> stale tx_status values.
>>
>> Fixes: 1db4c0ac77e3 ("usb: tcpm: add core framework")
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>   drivers/usb/tcpm/tcpm.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/tcpm/tcpm.c b/drivers/usb/tcpm/tcpm.c
>> index 3061b466d7c..d6c0be82333 100644
>> --- a/drivers/usb/tcpm/tcpm.c
>> +++ b/drivers/usb/tcpm/tcpm.c
>> @@ -207,7 +207,7 @@ static int tcpm_pd_transmit(struct udevice *dev,
>>        */
>>       timeout_us *= 5;
>>       ret = read_poll_timeout(tcpm_transmit_helper, tx_complete,
>> -                !tx_complete, false, timeout_us, dev);
>> +                tx_complete, false, timeout_us, dev);
>>       if (ret < 0) {
>>           dev_err(dev, "TCPM: PD transmit data failed: %d\n", ret);
>>           return ret;
>>
> 
> I just figured out the similar patch sent last year was never applied:
> https://lore.kernel.org/all/20250526-topic-tcpm-tx-poll-cond- 
> v1-1-38a81560ffff@linaro.org/
> 
> Whichever patch is applied it fine for me:
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Is this a fix for current release ? Can you send it separately ?
