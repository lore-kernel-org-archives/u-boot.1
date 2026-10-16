Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A0FCCA462
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 13:33:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 86D51814AB;
	Fri, 16 Oct 2026 13:33:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tSscGCv_jBNk; Fri, 16 Oct 2026 13:33:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CF0318144C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792157615;
	b=ZG0NYPxzVY8F33RfaNalV6FfbbRmCnA6fPAWwCdRPmYY5I1+2QdHwBqvY4z2TCAI5euW
	 OV6yKqNDV1rQfeN1lqIg/JSJbIdbFLWL0wDn0vfeYWpEtHuPjoKMNmN3rhEC3YNjGnIdX
	 SGH/gvhgp+3Y5I3h8TOqJR5o+FtxUQqcNn7gMgkq6LhWP6wkHZoyUy2ouKNernV4JKuim
	 HO4MmsOgyM2HZpQZ6Fr7rASC9KTGZ1vEr+fjo3bMoGLedxXXwwMhj7oy25TJIc1ECc/fy
	 q9RbFgR0TrbIc5z46CXcbje174iUhzN0vYxbKCtr+RAKznrAFGSO+xak+9k+C4LOE1Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792157615;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mpskHAkWB9dqdaG3LFSUhVvIE212QZ6JPmgz+d4uWO0=;
	b=lCpX2JBF71Ubp31YRi95OF98+L+vSZ55mtt+r+RkwIkB5lrCKfUQbZmYUgxAa1xDXX7m
	 V9e3MVgo8LiupIfOvFfWm5IKg/WDBeTsdUKPkdN2ve8gpM0z4HHnwMAz3War/B4dwAc1C
	 xgJ+zWNN830c7GB9Jd+3GsBfy+NjBa1TYENxLHcWvO77yqI1WK7gRQMpM75Yt5emMM75p
	 D5dc55ql+ydni6S7Ta2WwQvUmrD6CROhoJe6MiO7OupAhVGdf/vHwkinwH9nC7wdo3DlU
	 KasL2roKUEns5KDtLyHRkNKRzvWAahmISxuf2S+Dxrvogg7ZaOdrwAYeAL53FHB4HDw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792157615;
	bh=mpskHAkWB9dqdaG3LFSUhVvIE212QZ6JPmgz+d4uWO0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xWY2xspujhmNkTNT5AOTijp5dF6IQB1J9pV9sM2vAAcSG8hyf424+eaHrQ7TU6xpv
	 MTZUCfE7PjuCUyo33wNniK0SQM2YUdHJP0ZlCDVgEocuBgIA6Ra82X16YkpVC5nwai
	 4JHvWsMu9XqJwcuejrly054OXQr0eFsCstcclrqJAhAUlZk3uQeJ9FKu7S8IDzc10h
	 9rPm/bsLtwqsJM0lDn+brViMt1ef61U2QXZqTChustRgWuVODUrenxukFKn8aMEkzj
	 7qgYSjyFppaXx1iAxa0xx3L3t8UZy5O1VTq+0KyQXQUu7+jXwr5rtvFI7ECs/iK+WO
	 ohPyYhvcFktrw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CF0318144C;
	Fri, 16 Oct 2026 13:33:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3C876105
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 13:33:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 22F96409F3
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 13:33:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VQvU8m7rZ1Wv for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 13:33:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4F16F409EC
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792157612;
 b=mO7WRfSnklnUY4R5BN0aCnFShpHg3EiPg9cTUe2T6FvbQHN2oEfOR578vcltfaVq/Kf+
 8m+PdlKrAfGZUdOV4arAJO88OOg9svPLTn7nd/uQFyhpfJ84GKOkV0g+0fiQCViPjizj3
 oN/SS5H9gM4wVyzdjq/AnqvOtB5IbsyKoFhzqoRRMOiuPPMO5LpN6Bk5PGzkPuGxCYqwZ
 dnsNxrx71+aCiRHXpDnBS7zgwM0xlTlTaEiNdvUUL+M9nvJKgIRDK6uag/X7bVdYRUJR4
 2aXbEiXFMJjiT1QO7tHJ8+29P68pkLDCmKphWQ7IYoM28u0c/i0WZqrKtN/PyN5oL6Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792157612;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=mpskHAkWB9dqdaG3LFSUhVvIE212QZ6JPmgz+d4uWO0=;
 b=tD7OR6O94G4Z+qQltpty04Kt+DtEhrrfL4Bq2QgTs7LXXycWtJ0x0XUZfJ/jSWIXoVa7
 pYZ8NaPj9KsF6KbSqxjvOcv4BHvCD8kZqYntTpXLlE7tSGrSbUYPB9lICguV6tDdbWuNo
 yauyhL4maFSLm2DiipO8UyhbX8gT0TQndbNG5DTkMqJqX5HE3uyvDeZesg94R8JdO82fq
 a8IEhDfxHVUuFVq7NWJdIkAyxPTSW1IQd8zsQ3Ei9Q5vfyMLf1V8SRJMQONkZwfWckoHb
 R3hv/aIQi5tZu/WB+gtjYVipBJ5cAVG7z+Q2PeIsF+C+xEFpzI5/88OFy15TSiAQfqQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=bJnDS8Co; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=bJnDS8Co
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4F16F409EC
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 13:33:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5F88240BC7;
 Fri, 16 Oct 2026 13:33:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D001F000C4;
 Fri, 16 Oct 2026 13:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792157609;
 bh=mpskHAkWB9dqdaG3LFSUhVvIE212QZ6JPmgz+d4uWO0=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=bJnDS8CoNsDqaPWCDxxTEAB6B6lI58MlRXoD/uGYdvxEEy5LiPjewktdsxAAv4TJ4
 ry4uZK3hNiG+pjFSjiPb3JAWEfpqb8le6W2GaBhOlJ49wamfsG39s1Uuvjovr5vSbQ
 hqZz89SFdzV1w2oILQP1Vfx8IA4nCq75+OgWibFHFHJd5XyhRyjBwaS5vhvA93VjJM
 H9ROkSzFHgYyYJFjB9Cbiw7mXXwuVg0PS6UhD62rxt2MUh0K23awmPdRLbxQEydzoB
 YCmyTqLfjWmbSlVhR0R6m3ZjuQ9Fiv1dMftRTs7AK9SZ4oeLxle9uvvZkf4+jfS1ii
 yrntc5D61TkLw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>, Marek Vasut
 <marek.vasut+usb@mailbox.org>, Tom
 Rini <trini@konsulko.com>, Patrice Chotard <patrice.chotard@foss.st.com>
Subject: Re: [PATCH v2] usb: gadget: f_mass_storage: Optimize CTRL-C
 responsiveness
In-Reply-To: <20260929-ums_increase_ctrl-c_responsiveness-v2-1-ec4220786c81@foss.st.com>
References: <20260929-ums_increase_ctrl-c_responsiveness-v2-1-ec4220786c81@foss.st.com>
Date: Fri, 16 Oct 2026 15:33:26 +0200
Message-ID: <xhkdbo6ct6a8p.fsf@mkorpers-koolstof.csb>
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

Thank you for the patch.
Sorry for the delay in reviewing this.

On Tue, Sep 29, 2026 at 15:33, Patrice Chotard <patrice.chotard@foss.st.com> wrote:

> On STM32MP157C-DK2, when aborting the command "ums" using CTRL-C
> it may take a while to get the control back on the console,
> sometimes around 1 second.
>
> By removing the if (k == 10) test, it increases the CTRL+C responsiveness
> (around 28 ms between 2 ctrl_c() calls) and UMS throughthput is not
> impacted.
>
> Tested on STM32MP157C-DK board
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>

This looks good to me. The change is quite simple (we check for exit
conditions in the for loop more frequently)

Since you tested this and posted some numbers in v1, I'm happy with this

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
> Changes in v2:
> - Decrease ctrl_c() call frequency to restore ums throughput
> - Link to v1: https://patch.msgid.link/20260917-ums_increase_ctrl-c_responsiveness-v1-1-95305f044ec2@foss.st.com
>
> To: u-boot@lists.u-boot-project.org
> Cc: Lukasz Majewski <lukma@denx.de>
> Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Cc: Marek Vasut <marek.vasut+usb@mailbox.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>  drivers/usb/gadget/f_mass_storage.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_mass_storage.c
> index 7eb667c130d..96581792031 100644
> --- a/drivers/usb/gadget/f_mass_storage.c
> +++ b/drivers/usb/gadget/f_mass_storage.c
> @@ -651,7 +651,7 @@ static void busy_indicator(void)
>  static int sleep_thread(struct fsg_common *common)
>  {
>  	int	rc = 0;
> -	int i = 0, k = 0;
> +	int i = 0;
>  
>  	/* Wait until a signal arrives or we are woken up */
>  	for (;;) {
> @@ -661,10 +661,7 @@ static int sleep_thread(struct fsg_common *common)
>  		if (++i == 20000) {
>  			busy_indicator();
>  			i = 0;
> -			k++;
> -		}
>  
> -		if (k == 10) {
>  			/* Handle START-STOP UNIT */
>  			if (common->eject)
>  				return -EPIPE;
> @@ -676,8 +673,6 @@ static int sleep_thread(struct fsg_common *common)
>  			/* Check cable connection */
>  			if (!g_dnl_board_usb_cable_connected())
>  				return -EIO;
> -
> -			k = 0;
>  		}
>  
>  		schedule();
>
> ---
> base-commit: b4ac71db13a33c4e6532c60a781ddf34b7f4375a
> change-id: 20260917-ums_increase_ctrl-c_responsiveness-0824bf3ede7b
>
> Best regards,
> --  
> Patrice Chotard <patrice.chotard@foss.st.com>
