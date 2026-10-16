Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CA2CCA462
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 13:57:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 102D860EE0;
	Fri, 16 Oct 2026 13:57:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LHze8axdss9E; Fri, 16 Oct 2026 13:57:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2A04660ED6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792159030;
	b=Jfg/hjb5u2sfUitlwMzxwNv8yV7MJo81sadUJHW6v5T8Mc9J7ckk0DYgD1fiyJUVz3Oz
	 rl0oYzXib7h3iBtCD5WEUExRSFyAamSUp/kV29GbGxjSCzURJyd1H1AI2sU/NUvDQT6qg
	 dH3z2stSQZuWBB718bsDVDLVP6rHmjr1VYv5k13g5hMLAhWUc4aw0FWrZf65U8i2I1QJp
	 W0BK3vWAiL0EQzHC2MAp+mLzHehkHcFBMu2LO3t7gnflJnySonJ9hHnqpp1GvTQwWePdO
	 mBHb3dlG574IrG/OqWOQzehBda6neJrbMu1l4DOjMCdRoOBKTpeRnxuBU2wrk+k/OsA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792159030;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GHTTr1kI9MhVZmt4/LAIw4a+G+qSUyqXBdbDNm9/dvo=;
	b=UmpAppLNXn/Vymi9WMi3OqstN897kw/GURvbhjd8a5YaRo7HsslKzLrnWXHU6Z2g58/b
	 HbW07gzkMcWqFG5q+640WFw3OBpJ8nXPH0egPldrdq5hJ+5T/tUebuEH1GTho0UkvV36P
	 U9O4lHzC7WHyYCE85r8iJ/XWk6hpWnv2HTEh49aSdKW3N7lsyJ9NglSedRJtVWo6adzw2
	 LduZy3rXExcfUA/UuRSROyDCsC3xixynNQEjhywUNDgs9gstTE5dOgXv8fk36/3e8kk3y
	 4+bZ/dYimmwxoQwVnJUNgufjeZE6bSaSN7ikyxewerpjxUnNNc4Fl0pnqxzrJVJxRqg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792159030;
	bh=GHTTr1kI9MhVZmt4/LAIw4a+G+qSUyqXBdbDNm9/dvo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vFe8OE31Z8YbgpSHTrPIDf6UYLonKxCxp66jLLnfF/+7zveGwFLwi8hDiCC5e1rOb
	 4UOY2qjDYDwYCmOQm2zhWeINM6UUwKewmyfdMlbPU1YBVcbaMjLRFF5/EN/IOdP4Ht
	 pRdlS0kns8L/7QRUkcj9tt90gOAiM4SDDAVXU5s/CaciAK2eTr1tscjZ2+H1OnJCRL
	 K/03W9l1gnE0i6dNKMXfC9FUFIuR3f122hjLZLmOc6WjPKPK735vpdfMpXgoFiWuyB
	 k12MPuJAtBxCYqSO7nroH1wz51QvXKfdDevZiFMrOMzE/QdHAuvHR0ICfo9hF5+TYm
	 H3z4X+GbnL0zw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2A04660ED6;
	Fri, 16 Oct 2026 13:57:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 245B2362
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 13:57:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 222A4409D8
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 13:57:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mc2319RmQ_pv for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 13:57:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4D24A409C9
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792159028;
 b=H6QakpRkunTqKHmHksUC+8bd2K3/x/5Z14DKOOTeesUwIrYiqS3jjh2A+P/kHFfRzt57
 gd2qNzZPgGGUW3FQY6rl5XItld0HHGIUUGS24VYXlj6Y77RlVFGu4YgVaYWW+kP62IZUX
 pnE3RXNp1EcHuv0N0wqtZUzq6KOkKZljdruEaw2lhMQ0PcpXASh/aJJDGLYvViZ5qdlUk
 nm2WyBrDmWAE29wbywnfriJN3sFLoLNkp+JSuK3x5Wjr4ziXXnESzSojjg6cMJFA+NOhe
 B6J8MILTmoIWK3IgFNX8VxI2iFxomYI6SB72JV/r8M91rX5yNbSe3G38uFRfx1JWgAA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792159028;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=GHTTr1kI9MhVZmt4/LAIw4a+G+qSUyqXBdbDNm9/dvo=;
 b=gSHHT+9zFwm/OB7WZzHXc97MgpcGqh12/nzGveQ1PhLzcCD5jK8BWZXfKMM22KAPuMz1
 3Kv3CToaL2SD5NUnXE/ZXumHyVR1SiQDKK5G4tHmFhpwYw43jYMLmm8UEqiz6XvZD+u+r
 z2hAht/Z8datdeJZuJRGWQjDz3vZo28YJ9+dMswFMi40sr8slfUUNK2LFZYgl9GrUZwe0
 kap3w7T4RZ5z6MzJWrNqhJFaLR9W6thzLkR3Adolt7ZZlEYkXcoGKsSEnlG8CLgSqfKoO
 fTH407zgmqJN9Y2DOVz4zivQY6I0u17idULNMh0+i9fFPhx2A2hJuIlINL2m2GuTMLg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ECgyc1xG; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ECgyc1xG
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4D24A409C9
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 13:57:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 41E9D60008;
 Fri, 16 Oct 2026 13:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E3E1F000C4;
 Fri, 16 Oct 2026 13:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792159026;
 bh=GHTTr1kI9MhVZmt4/LAIw4a+G+qSUyqXBdbDNm9/dvo=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=ECgyc1xGkkla7bnOxUiutMqgW1BOlLbhlkXgfjw+lrYY/eZ/8A8blXtZ1Sj7ZS0vr
 568nqNyXarteH0c5KB2R6JIJ/RLwz5tXXUxVjSCYFApcl7+5bs+szB/8OANYioI8C1
 OrthYrQxvMSx/FaOUUdrfJoD0w8f9+o6dDfckU7NehhRSNudSqSF6WwSLcyyglTYN6
 KOsauoZdPi4arAnKovxl2y42uZdU0DhHfDmE+AgtHx12ttllO9B/8IOoJMCl/75zcR
 kZK0S5pzPwAeTBJyweE9EpSgipoRUfvrB+UnO1MQIiLnTTTT2ePMHRc4oJdIyUNHqW
 SmNb3w2349QhA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: nacht20-de <nacht@dxdmail.cc>, u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>, Marek Vasut
 <marek.vasut+usb@mailbox.org>, Loic Poulain <loic.poulain@linaro.org>, Tom
 Rini <trini@konsulko.com>, nacht20-de <nacht@dxdmail.cc>
Subject: Re: [PATCH] usb: gadget: acm: do not requeue failed RX requests
In-Reply-To: <20260927162740.3593237-1-nacht@dxdmail.cc>
References: <20260927162740.3593237-1-nacht@dxdmail.cc>
Date: Fri, 16 Oct 2026 15:57:03 +0200
Message-ID: <xhkdbld7x695c.fsf@mkorpers-koolstof.csb>
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

Hi nacht20-de,

Thank you for the patch.

On Sun, Sep 27, 2026 at 18:27, nacht20-de <nacht@dxdmail.cc> wrote:

> acm_rx_complete() pushes the received data into the RX buffer and
> queues the request again, regardless of its completion status.
>
> When an endpoint is disabled, the UDC gives back its queued requests
> with an error status such as -ESHUTDOWN.  This happens when the ACM
> function is disabled on a bus reset or disconnect, or when the usbacm
> console is stopped.  Requeueing such a request from its completion
> handler puts it back on the endpoint that is being flushed.  With DWC3,
> dwc3_remove_requests() then gives the same request back again and
> again, usb_ep_disable() never returns, and gadget teardown stalls.
>
> Return early for failed completions, as the fastboot and rockusb
> functions already do.  A failed request carries no valid data.  It is
> freed by acm_disable(), and acm_set_alt() queues a new one when the
> data interface is enabled again.  Successful completions are handled
> as before.
>
> Fixes: fc2b399ac03b ("usb: gadget: Add CDC ACM function")
> Signed-off-by: nacht20-de <nacht@dxdmail.cc>

Similarly to the linux contributions
(for example: https://lore.kernel.org/all/asN83ijsjvnbTsmP@squawk/),

this (and the author) need to be your name.

The change looks fine to me, can you re-submit with your name?

Thanks !
Mattijs

> ---
>  drivers/usb/gadget/f_acm.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/usb/gadget/f_acm.c b/drivers/usb/gadget/f_acm.c
> index b6c11d97a62..2ea54dfbe69 100644
> --- a/drivers/usb/gadget/f_acm.c
> +++ b/drivers/usb/gadget/f_acm.c
> @@ -293,6 +293,9 @@ static void acm_rx_complete(struct usb_ep *ep, struct usb_request *req)
>  {
>  	struct f_acm *f_acm = req->context;
>  
> +	if (req->status)
> +		return;
> +
>  	buf_push(&f_acm->rx_buf, req->buf, req->actual);
>  
>  	/* Queue RX req again */
> -- 
> 2.55.0
