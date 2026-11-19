Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C90D606A320
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 05:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jCEcgSNR;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=Em9+gDvJ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6B8C640DD8;
	Fri, 20 Nov 2026 05:28:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 20YwxPii3s4w; Fri, 20 Nov 2026 05:28:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 60F3D40D6C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795152493;
	b=H3ZJtvGafTrjnFl85uD80FMOu2wP8e09TpD6AaQWoWb8/4f0IdbsUWt1Y/yGEpBG5+68
	 cNwXybwD3FSwHmSQJRmjiqJU7qkXc/8KHNN0TS3FchLiKDpBFXjYKA3WxIbHneGC3dlEt
	 XRNlXrZPClYqYBIbbWm88IYffB31Zhoj85rSY89SDSJBWfKxcXYpzNn4Ro/i3++vpFb9K
	 3/vk+G8naaHrW2njOBIRGTeD9CuKJbSdr1Pjoj62c4wRaWXa/K81qVnrMbKnEoUHQnUGf
	 08se9DwXJw8TGINGj5OiIykhRvn6gqvn/YPsNVRPgzD0V0vA5qupkRYTpzz1o5TK+cg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795152493;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UB4rMKH0bwz72I9UOd8m5sUDIxtg9Xx+u4NAUJoWNH8=;
	b=YFRxyOjnbjxpJhS6E6nDlB323xDpQZA6wOX42FW7HIureuytULNbTsQ/juAIYwtYuTxP
	 vgX0lQahhlicMv23irXZozeZTlEU/CAw4cnSMnF/Qe+j/3F9NPH9i7Uh758jbT49lZUEp
	 Lulz8SSXl1UhokiTIZsIKflPKQcQOxZDh9EaxCbSTgAxmUyCLGlXASgRzueK8O+a9c6PY
	 iD2ACU0QbN+1tJkHREl0oeEJeYdO4dJeCFBnvD/BXuIQj2uUTNenB960O44+iiIqKifng
	 nmE6wmOfvrYC6lk6O40ZLMZY2TDdOxNO2A/m7xqTLYSGdBQyrCmNGgohQ0tW8gUQZAw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795152493;
	bh=UB4rMKH0bwz72I9UOd8m5sUDIxtg9Xx+u4NAUJoWNH8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jCEcgSNR11knBxf5juFU0mewlI9aSlL0JL3sQtNNLGfhQRORChqNJ5pELXZFGPSqI
	 6Ol4ydsVFLVIdnWn5I0rfLHQelLtXNh8nsv6uqhRy5VLdxTPvRpXWF7Y54jfNhzcgN
	 evFCBVgcOYoiWPcWOG7iTRatW7OwkBqITYd9pi0N66nffRTsZnlZoP//uY+I/qIbsf
	 P2bFic9IxKSYJD/JFCoOwWL0fJr472Z60PFuczb6JxVmTPM8G4aDKb0it4KxQguUnH
	 VCke5Xj6a0RUfn92Cb9We7pN7pZPgSMAk2ovev2giXAUAbL1ZE86RpCSZNHPC184Zq
	 ZQOoKbwOIqKyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 60F3D40D6C;
	Fri, 20 Nov 2026 05:28:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 640CC260
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 05:28:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 559E780879
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 05:28:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bfy8RRjNj21F for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 05:28:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BDDF4806E8
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=Em9+gDvJ
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BDDF4806E8
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 05:28:10 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jW3l71CJzzMm0r;
 Fri, 20 Nov 2026 06:28:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1795152483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UB4rMKH0bwz72I9UOd8m5sUDIxtg9Xx+u4NAUJoWNH8=;
 b=Em9+gDvJ0yNkKdV1uLi8Nw5liJu7b+XStk5c/i7UMeIX/9I2xHvjbwyDiBPXYS/M+oY5ln
 ZgYdr/spkYQNX0uygkZLD1HH+U0aCaO7b5DHbUh4zzqTwu2Urj8gagDwoC6+fkiYPs6j9Y
 YiLRiwuy/TpTd9AbsuTHhOGWUjGySXieamjW5D9wNL7PB1TZD00KssTZlJ96WT5ZStGVk4
 l1H6Ksb3KP/Jh1Dxz2ry2jE/MzJNuF6fjhIrdVL6TGBy976BBC7ODTaZWGkBotgD+y5OVu
 82iioJw6tQ8Rcc6Bu93K0tO/Y7Sd+3Fy/5QfxT1t0e7Cvh4e9AT/jOXxg/HA2w==
Message-ID: <6aeb57ac-6b63-4593-ab3f-c927fb3c51f8@mailbox.org>
Date: Thu, 19 Nov 2026 13:14:10 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] usb: onboard-hub: add vdda support for Microchip
 USB2514
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Alexey Charkov <alchark@flipper.net>
References: <20261119-usb-onboard-hub-v1-0-22aa6ef1d9c8@foss.st.com>
 <20261119-usb-onboard-hub-v1-2-22aa6ef1d9c8@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261119-usb-onboard-hub-v1-2-22aa6ef1d9c8@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: f743a196a519e551eb8
X-MBO-RS-META: kqoftmnrakymic6wndw8gi1qsbr74px1
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/19/26 11:59 AM, Fabrice Gasnier wrote:
> This hub is powered by digital and analog 3V3 power rails, so provide
> the possibility to use different regulators for digital (vdd) and analog
> (vdda) power rails.
> This is inspired by the Linux driver [1]
> 
> [1] https://lore.kernel.org/r/20250213094338.1611389-3-catalin.popescu@leica-geosystems.com
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
>   drivers/usb/common/usb_onboard_hub.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/common/usb_onboard_hub.c b/drivers/usb/common/usb_onboard_hub.c
> index 0c84c1fede03..4b96defc2d93 100644
> --- a/drivers/usb/common/usb_onboard_hub.c
> +++ b/drivers/usb/common/usb_onboard_hub.c
> @@ -278,8 +278,8 @@ static const struct onboard_hub_data usb424_data = {
>   static const struct onboard_hub_data usb2514_data = {
>   	.power_on_delay_us = 500,
>   	.reset_us = 1,
> -	.num_supplies = 1,
> -	.supply_names = { "vdd-supply" },
> +	.num_supplies = 2,
> +	.supply_names = { "vdd-supply", "vdda-supply" },
Is this an ABI change and does this break existing users ?
