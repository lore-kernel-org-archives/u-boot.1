Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E9FC79F9E
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 09:07:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 20D1E405A6;
	Mon,  7 Sep 2026 09:07:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cAe27MIQsklH; Mon,  7 Sep 2026 09:07:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6C3ED40402
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788772033;
	b=XiBW0reKbU95jDE++6SdGmEmZkAHrYccQzmatPgQjTAu+YLovw6l6J/kPhGpylLl7j+N
	 auOaHvxJ0n8MEadttW60N5ifdUWtRWJaGgE03yReu0A2tqGowDoTfuUJcvgkbd4ujBQtr
	 KTZ+PQyRLsxtCzbCGbJqcesk9hA1KfNpgTfaw6+4qi6aluRtIbRrPuFRukjutEpwAK1Q1
	 Dl27yMA+gSJBx1Wcpzu2TkqH6v++rWceelZLoX24T+MQFSU4mb8mVLzmSGJGMgbO2jEFU
	 c03bee1sJXua80UzE+t+lopDkDb3O2MbJWKyAjWuHSkherBK+NdrDBdGWB/8G1EVOvQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788772033;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=sPrUQe/aOTroJvOtYVfCP8il9hC9JUs2WYYrYBlShPI=;
	b=Nw0x4ma9SBjXXHcrb79f+STfJyYeqAvVMIJ2sQ2bDbracMfuXwFungb7dXDjHavCjZ70
	 4H/oT+Bna89g/LrFSLrcftvOG76HAQ1sAJgt0ofT5xOPlip/i3KAvpfStM0BGExJJntcs
	 fRWrFdeBXCklnFtj7db8eUfe0ci6Op/0Z1/Cn1XFirl1Tzn4IL4g4V59YmEOVzd6YJumA
	 4BZMSCa2lsxWyQJFJb+HqlVCfanyp6JYKQvfizGeXs252bSnRXgcsVw+VXlsorSCIZ3lr
	 sIc7trpfeBmZ2HhsCH7NGqRVhVI9VUgKPRhW/kyMNZnarcH1S5PeNbQ9mnZ2oxTnLcw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788772033;
	bh=sPrUQe/aOTroJvOtYVfCP8il9hC9JUs2WYYrYBlShPI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uFu42xSoOHTRs/Qu5N4SwVn3pYflZ63rs3Qt+ggpfEm8pv5zPZ5nDLBwysvPGKKDm
	 yOUtBDNLwY1RyQ8+HQT5GWO35pyuh6fP4RNZpqfXG+mNSH0OD7MJSpwkPnn3IjEnTp
	 wKNKodzt0p13UHEmPLGgRa/gok8yjORK9eV8ycad9i2CT8lElUol+gg0cgxQdT6IOd
	 JXfD7OgKZx7DdvIEqGVszGR1Qvw8g3Zl1KFLRf4+DOdlJB0PCwZKYk9/UKkdizMjQj
	 AhpO6Z7Zs+MH88u0gunagOHY+VTau7nVND5SerXL5xcXRkxIy/DeMNi755x2bV8ImS
	 ZbbYRp6BwoPzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6C3ED40402;
	Mon,  7 Sep 2026 09:07:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B9013A48
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 09:07:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9EF93605D4
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 09:07:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vCGcOt5fEfiJ for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 09:07:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E858F605CF
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788772031;
 b=cxtt/+RX9hQ68mmhXd8ni3EBJdyOnF5ipNc3aez/WLlGZWWWJLBcR7WiJ/AYanXKeF3+
 O0oQGtL0GyyFbTrpnuHaiOBaT6Bf83Tic38B1+MN68ZImyE2GAOx6lTsajL5eID3hv5T8
 8gqkN5OCAsb1U18Bjx6i2WpRvaWsdEYUj4xfyfzTXJHxV7ICBttirhDmhASPnnOmmQ3SW
 uIOwOS6ol2X1Xsu7S0yI64pbAuITUizOzGeurSNaVZKZfU142qxIWh4NDyGfF7xhfs7Lh
 TaOc26GKQ+IgtH9hGbW6o8yj1lJxfyWlM3ETZRooE5wjHax/nBv5grTdTYTWryygh7g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788772031;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=sPrUQe/aOTroJvOtYVfCP8il9hC9JUs2WYYrYBlShPI=;
 b=TqnLpBbA/dKLMJMn9L3zI6/vGPWUO66N4fOIr4dih8e1LY1IM4DXsLt3yoOI1HPbjKeb
 /h+biax5pPAYHC7UjTXjM5XD0K3P8/cD2nf3mhozrUcMJk4VEIeyQ4YN8a2UEZ4rzcL+4
 UnziLaY04l7Yh3j8hLfmrxuS8w5utPPMe6mW43id7vDzJ7cwdAKqO9f7pEdTjb2TgFfIM
 JUJprX32car80olhfu8WDqtixYRKRYTb/c4eUx+7t42NGOXl/bnrSfDRVG69xWyVHsR2h
 eHQZ662ooBqeDJMYld2lfAcrinqz/FwF6t10oIgzP3qIeb0IZdLU99sVXKRtnKEnRFQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=QyqNNNeH; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=QyqNNNeH
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E858F605CF
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 09:07:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 01E0060052;
 Mon,  7 Sep 2026 09:07:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E3A1F00A3A;
 Mon,  7 Sep 2026 09:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788772027;
 bh=sPrUQe/aOTroJvOtYVfCP8il9hC9JUs2WYYrYBlShPI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=QyqNNNeHZPCH71YM69C1REUSffMYG5PsTbe0eAD+KkY9KnMZfBXDkJbL8Db/2DcFE
 ArLqG+rkhlSAEcD/27FknMXf5Pk6sb/WH2VDLhNzq5EaqXCP5ZxR4kTOjxWqJIhkWe
 UyH1M25W7ArzVGgtg17062JL3tteIu+zjVmsRqA8BeGm29tI6vCqJjCX5EqGzz9RQB
 J7uVGXgzfnRw+rCcwdE2BJIcGcaB21EgdVE52T91XGAcOHC8/fdzlIvlt51n6z9hAG
 2MlS3Xj9xbqs3Sn9s7sd0KM76bBIiAMqWtaPQpHXq9qMsy00sJqrmNNDSbJF95rApH
 8+IZb1m/VtiaA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>, Marek Vasut
 <marek.vasut+usb@mailbox.org>, Tom
 Rini <trini@konsulko.com>, Patrice Chotard <patrice.chotard@foss.st.com>
Subject: Re: [PATCH 2/2] usb: gadget: f_mass_storage: Optimize schedule() call
In-Reply-To: <20260817-move_schedule_inside_sleep_thread-v1-2-0023194e8c47@foss.st.com>
References: <20260817-move_schedule_inside_sleep_thread-v1-0-0023194e8c47@foss.st.com>
 <20260817-move_schedule_inside_sleep_thread-v1-2-0023194e8c47@foss.st.com>
Date: Mon, 07 Sep 2026 11:07:04 +0200
Message-ID: <87fqzltop3.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Patrice,

Thank you for the patch and sorry for the review delays.

On Mon, Aug 17, 2026 at 17:41, Patrice Chotard <patrice.chotard@foss.st.com> wrote:

> schedule was added in sleep_thread() by commit 4b6a3e860878
> ("usb: gadget: f_mass_storage: Add schedule() in sleep_thread()").
> to ensure that watchdog is still reset periodically even on platform
> that doesn't implement g_dnl_board_usb_cable_connected() and in case USB
> cable is not connected.
>
> Instead of calling schedule() for each for() loop iteration, call
> schedule() only in case g_dnl_board_usb_cable_connected() is not
> overloaded, in this particular case, g_dnl_board_usb_cable_connected()'s
> return value is -EOPNOTSUPP.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>  drivers/usb/gadget/f_mass_storage.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_mass_storage.c
> index 621852080e2..f467693d2cb 100644
> --- a/drivers/usb/gadget/f_mass_storage.c
> +++ b/drivers/usb/gadget/f_mass_storage.c
> @@ -651,6 +651,7 @@ static void busy_indicator(void)
>  static int sleep_thread(struct fsg_common *common)
>  {
>  	int i = 0, k = 0;
> +	int ret;
>  
>  	/* Wait until a signal arrives or we are woken up */
>  	for (;;) {
> @@ -673,13 +674,15 @@ static int sleep_thread(struct fsg_common *common)
>  				return -EPIPE;
>  
>  			/* Check cable connection */
> -			if (!g_dnl_board_usb_cable_connected())
> +			ret = g_dnl_board_usb_cable_connected();
> +			if (!ret)
>  				return -EIO;
> +			if (ret == -EOPNOTSUPP)
> +				schedule();

What happens on boards that override g_dnl_board_usb_cable_connected()
that return a positive value?

Per my understanding, schedule() will never be called, and the watchdog
will be triggered at some point, no?

>  
>  			k = 0;
>  		}
>  
> -		schedule();
>  		dm_usb_gadget_handle_interrupts(udcdev);
>  	}
>  	common->thread_wakeup_needed = 0;
>
> -- 
> 2.43.0
