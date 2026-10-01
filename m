Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A3ACA5FD4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 06:39:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1DAE840BFA;
	Fri,  2 Oct 2026 06:39:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yZynAad5Flx2; Fri,  2 Oct 2026 06:39:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0002740BDB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790923178;
	b=fxQAvin3mizkHMKRmlhChPkmXrikzvphhztHMqTaH3nW+Dj4JP9Di1Pkt1qNhNoiZoZd
	 WkJxPkJ0NHQHdev8jiCeGuB0Syp0DpJBP7rPT9AkRnGdmpHGBs6xuqmy1rjJDxoyFBw5J
	 omBmDLLumUboJL0pNsjzoIEYeo73N0nK/OITk/xwVgG7TO94ztVbLEydUSjuh6VGRIfXH
	 Z6lBAhHBMUMDDzaBtWVywlDkb2tZwvT07MIkZtRf7amJoluItj8uQakgpaOpkovNZv+Aj
	 QtwGBe36oyvCuwimLrc+xeSKJQybNSHdj7B+9QDdG73D51rYZNPs8UiM2GlJ3j19pwg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790923178;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:DKIM-Signature:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vsnxXj1ASvDny2jj6JhqoYUszzxLzHap/+NoHA1Sh3M=;
	b=UYFJIspfMGn/MU8UQoPKuEmJsufjEROHnA9PWVJEOhHtaaXaKD0VDdkuNWwZqu/1QVy+
	 ifuBCvFoA05TKHX0WSoKsaXWJxxrgrrlrU2Ai5GODeMmKnJcm3mK0Q4hGjTo0n5VTKGzQ
	 t6zsAH+vCR3bOrM3xKtk0SZ/sbmQI5Co5huX9M97mJcxBh/eut335X9I0z9/RBwR19VR6
	 TMKKPaihiwi77+yCVurumWIJvYBcKqhFCMFRO7e2RGmWqjW/JLaWJ8mF0TUWoWAGCLOtc
	 mEwvy8eX+h6NqYOBUtTIAUtGjkZhrNQ68aeOx6LG1rD7vd4uWORjCflVPUWLSpVTILg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790923178;
	bh=vsnxXj1ASvDny2jj6JhqoYUszzxLzHap/+NoHA1Sh3M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vDgMxpO+YGIDJTUcy9UQE8zqfRf7tKC08V9vjiLc+4VKu1SSa8uM27d7Fqt3m9nQ6
	 y3xIa4FfXq5mrcZqiXtXYafcHp8xXz/9qTBRsa6LPK2Qrg26uU7waNP8lsBDHjHFrm
	 davfcg/nDAtlWWC+LiO7aSgF8FGv2Y+rHAeN1wcjGsDD+IpjfW/Wl0UFmYBTwl30cJ
	 GdD3XLIhlpnEkKIDnBytElIhDI7OZ/3iuebVkSXKqcJL7f/Nc5n5zIUqWLepH7ySpK
	 hgqmzXoMalW7y1X/lcQe8i83gUNwFmDn26MPtA8jtz8yNv3LVs43E8CMRtd8WGSeQi
	 wDkmkisNVamCQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0002740BDB;
	Fri,  2 Oct 2026 06:39:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 732734D9F
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 06:39:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 64C38607FF
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 06:39:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3max4ZAiTLMJ for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 06:39:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2F504607F2
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790923174;
 b=S95jepTyXFfu34kG264rxW9sh+yk3mm/Dg1D1ITTl8klrYuEtu8EOXml7pn+nwlp+neU
 Mo/RK+j6pjVYEVBwPggy0jBJIQFoNFwCVlqbwjCEafpJpyeyxO9rUAJxG2TylCGaI6ZWL
 O/rQpY/+ciUGPZyITS2Ms+TDlsvyGSciyuzUTxJGPq+uZoRoJlcheiG6xrYFAgFo4cCbj
 /F6SyRm3AHaLyeqd5N4JuXxI7p7IdbLkBoN9PXc7KmMXgkOHAOiNYpxL1Z0sssAq3y4aj
 po19hDe7U3Y1VjVMf1KHieMOiM5LDwjuirV2xVvqIjdSWVJshel9ulU3NOwgMRtryhw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790923174;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:DKIM-Signature:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:
 X-MBO-RS-ID;
 bh=vsnxXj1ASvDny2jj6JhqoYUszzxLzHap/+NoHA1Sh3M=;
 b=oskvBUumEeMkYPSDNAYuUPm4jHn61Jk3STc20hFbG9IFZVR6AW0RbK8Mku0Jtyapfz12
 AJ4S2oqADQ9RdYObQHOcWdwoogHGJtMzrb+86Lx/5uhI0V6dK5lStuwvlZl5UvX1eXedE
 cDQvEYHuLkJFic5OdgtTz7Wl6pGg+ijOkot+mSsDd2YrfrhLQAuyP9MwzqjrwFVfkxTZr
 uoCQU+FKYLCg2zgkHkj2y7J7cLcp0aPmDqNPSzfVWnkHmTT3q7rAEofEnf+M0IgHekf/Y
 J2J3uFtNBe84xssKDRgKzrjyxiMJpnIaeRqIEV93fBOp/bRqjKG2ceOHctUgblaLfvg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=eZlTE1Ks; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=jtCRHndJ; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=eZlTE1Ks; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=jtCRHndJ
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2F504607F2
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 06:39:33 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hwzfC6CkhzMlLb;
 Fri, 02 Oct 2026 08:39:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1790923171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vsnxXj1ASvDny2jj6JhqoYUszzxLzHap/+NoHA1Sh3M=;
 b=eZlTE1Ks8TkZW86XHj6lV64x9idb8nlAscTR65jp9dCB9DjIiT92OcHUfFfQhbL5TuP2oL
 d8MliBToBQMC1maaypGhhcK/f6SDETgJz/v8vjle5i1RigXr4aSLQtrMPYhDpsKWDOjUgo
 mPTgOC7PF+tf6dbXCZ7InXy7gUh8NTRJWMy8kdU6sFmPXUSKVFr1r9gLdJ/DvXUcMWgfmD
 H0XLh6kRX5JjwT0q5DlQVE2eJjI/G/N4K+oXnP7r37NHNlDvQ9ulilIz9ZbrzjlUQgMTo0
 JIarPq58BJfoHIdBphpCwTt3q6zuYSFnxzkfBRU2bTQTKGjwRO4Yh+/W3ttBfw==
Message-ID: <b4d13e5e-c7af-4249-bc83-b5e604a52df5@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1790923170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vsnxXj1ASvDny2jj6JhqoYUszzxLzHap/+NoHA1Sh3M=;
 b=jtCRHndJMFzNFZJMdnOou6IMgnQQxeq8JDcq76sd5cQNBMwFdqOzSheroai56Jar8Zt4LX
 OM2fgR9stnbC/zsETklV/XqhwmXdE8uixyvApqJ1TGNC6v6/PnG69FBEEd+TfMZuGS/k1c
 L+sY9ud3gJqWgpFjGOPBKaIrgdRXN4iNVajTwJTx55bRd+2Ed0iVIfE66tTPkgaJe3WoOI
 q/CuP5jBmA0it1rBh+wQj3Hji9ZAy6Ohhs7r3/VXDYUAKBADXCSc9OkTlhtlqRrq/l2Dno
 vcc1x20yZK7ePkWiFspXq1sVbqlDgPtdBGbmeQalc4HPRM0SqO9bdD2mw1HLyw==
Date: Thu, 1 Oct 2026 23:44:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] usb: gadget: f_acm: zero-initialize stdio_dev
To: Qing Li <lqing2013@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Tom Rini <trini@konsulko.com>
References: <cover.1790887323.git.lqing2013@gmail.com>
 <07344b8be2c8caf85ed0b1beefcde311495a2ed6.1790887323.git.lqing2013@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <07344b8be2c8caf85ed0b1beefcde311495a2ed6.1790887323.git.lqing2013@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: iy95rjj8kmsip5oeswyr963yoa8yku4x
X-MBO-RS-ID: 0f537eb561b1d4ef119
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

On 10/1/26 10:44 PM, Qing Li wrote:
> drv_usbacm_init() fills a local struct stdio_dev and registers it
> without clearing the fields it does not set.

Which fields are those ?

> With
> CONFIG_CONSOLE_FLUSH_SUPPORT=y, console_flush() checks sdev->flush for
> non-NULL and then calls it; on Xiaomi crux the uninitialized field held
> a leftover pointer, so the first 'go <addr>' command jumped into the
> splash image and crashed in console_flush().
> 
> Zero-initialize the structure so unused callbacks stay NULL.
> 
> Signed-off-by: Qing Li <lqing2013@gmail.com>
> ---
>   drivers/usb/gadget/f_acm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/f_acm.c b/drivers/usb/gadget/f_acm.c
> index cf16ca83c12..f756aa087ae 100644
> --- a/drivers/usb/gadget/f_acm.c
> +++ b/drivers/usb/gadget/f_acm.c
> @@ -675,7 +675,7 @@ static int acm_stdio_stop(struct stdio_dev *dev)
>   
>   int drv_usbacm_init(void)
>   {
> -	struct stdio_dev stdio;
> +	struct stdio_dev stdio = {0};
>   
>   	strcpy(stdio.name, "usbacm");
>   	stdio.flags = DEV_FLAGS_INPUT | DEV_FLAGS_OUTPUT;

[...]
