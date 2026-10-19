Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A24CCF2DB
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 13:28:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 333B580F8B;
	Mon, 19 Oct 2026 13:28:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id so3-mpHy1Yka; Mon, 19 Oct 2026 13:28:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8014180D62
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792416517;
	b=WOXIbL76OgAMxZsaCNN5PwG6fU9B9BN4MvTxzgEOT5CjRZVLMeM5Kk7lVdodAl1PVAp+
	 uVvEl6TB8Cv+DGdbb+/Gj3RqRPndTVxPiH4WQPoMNku947/WzOl7VhcT3BK8NN90CY5Ld
	 siDrg7L5smGVyw6592wRsLJ8ivj4q+CvQBzw3ygaGiCmuhN1flm6mXz3sw05yQ4KjhiD/
	 MpOteqw7IzPZRb0wVgMK51ykFn/vSMnXCv3nS075yAaehJ51+npwytUjrICKfWi6J4kt7
	 uMQfZ4f3tbTqRfsjfPxg5f0UFfT4glfMVvEP32F21b4X6J8pKnkdimtqJWuq/pOZd8w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792416517;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hfgUN5ObmKl0asVRBLoOnkiIedaNplBsJgbSqhYjM1w=;
	b=fBSgtuyVPLZDhZY0RClyVGofB9GDib9xPS4bWLasKiB83GhJVI9QJz9cynS5J6sHREnD
	 cTCDzQ3L3w/0hLVDZG2H9O71pT7RPrB8vwG3izPWE3jLLn41YnrSF/d6yXeiWhZhqtGtH
	 VdUr5cPhbX/Plo6Pxn7/TCZA3wlVsTHy3SgCEP6s+U6w2z1/dB2Px2H4yOG0jzuLqY2dZ
	 92E4K4c0OQkNDNlUn9+EV7ic+7NfWHGDJTndgKExURVIt3IWIqX8rdatN/JYk1iLT7MTK
	 4IRg+lid274ky4e1Jeb3xysUlWpBFv5PQjFC9SGkFTGQ3Te7DOIWQ/p/jboKOMhMMUg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GdF2KIBK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792416517;
	bh=hfgUN5ObmKl0asVRBLoOnkiIedaNplBsJgbSqhYjM1w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WmADLtXmzkm2JdngLPm9yTpPXwAsGngctCxSepk3MvjGYXpz8BEGtpDr6R7DlecYE
	 ZKSMPNA2r2wQBvdYAqHyV5ZI3PCcAPk20Nbs+w6KWW08aG0REbTD9GNtGtajVcoF6l
	 yMOHyaZQqquxDiEVjLi3/HaTknsL0wCk6WhQUSwr3PMRnmgowFo57D9AJjhSGphPKr
	 gLe6YbRGlXn6guiuwxQe8cgegO2B6I+S14YkXEKyJFQG/sxtqIQIZJQ/EJkMoNVE8Q
	 g/sgVl33gyGrqqfQokr4OzrQ4CUWTgj8WWrUcouF2pWQJ7qPdYk8/3VXPRegpC+5iF
	 VI+KUJQfuKI+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8014180D62;
	Mon, 19 Oct 2026 13:28:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 773FC23A
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:28:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 68D0D80D62
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:28:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zpG85j7wx4ZR for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 13:28:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8647D80C25
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792416514;
 b=fCsi4SOAxZ2suYSAgIPVKlhMX9U+lNPUNrkj11Mj0Lge4kMGPTeA22o9rTFEzT0/ylWb
 sci9uOK+g3FByYndvpLea5CfFrPEqOrMTR7qKJeiRq9k0fyyyQ1q2EX2dZJ5pm3Rsqw3z
 WJpqiRF3i7V7w+q8FFt+pqDYDdEY2vvY2f3URSA9/lI1xktYE2bwoT5T3eKQZyo7oS199
 RGJTm6h9exDwgxm0lULWJ6MY4M8EznBnisNGZfUcbvrxRUbWF5guRDyXRyESj1nb5ihcc
 kQkXscdOAtKr26N915LeXdZarqo2VnzUtTROnMoWA0AyMzd423/s08UT2z2e8TBpcSg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792416514;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=hfgUN5ObmKl0asVRBLoOnkiIedaNplBsJgbSqhYjM1w=;
 b=hf67AuR7YL0JOLrihaLy2f6HmqZ5MFkCpVnUJzItSxjdLqRM7T1Xu1h5DjMTcEFrphca
 chrOi0OFMn8JyIKPs9LFlLpGqJ1c0F8WLBUsbqN0vlb7uUNWkuYx5GHZv1cOuPZMoMbjH
 EO0e/w0OMaiW88FUasDzQ3dceASRq6yqWDrTkAyfa+wmirPT5LTnUQZh4unvLMvk7StUE
 ZFuHBxVJp0LtfIiBNgGWEqt+DG1ciN+OTThVtcMSO8Fr0KpJIKI5lK8D4qLGHJFQ+bxOs
 fcwBA//MUi2T7NXccvZ6xrF3Z1y4cYuWqYyxQ263VNWdJb4p3HM5G+kKccGI1i96a1w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=GdF2KIBK; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=GdF2KIBK
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8647D80C25
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:28:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3E62860136;
 Mon, 19 Oct 2026 13:28:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772111F000C4;
 Mon, 19 Oct 2026 13:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792416512;
 bh=hfgUN5ObmKl0asVRBLoOnkiIedaNplBsJgbSqhYjM1w=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=GdF2KIBKurWZ/CXTP9hXqDMiHU/1XaB1mMgGByHb/ZVsmEVN2yRxp6XMpGqTCKZLx
 nQo+np8EndJ7pmkh3K8Tmdw3ZDMNbmZJgGQIv1/dC5USed+IHXKPsLX2a7CBVOXTyu
 v38PvCfwnAtkhuEHk37I/vVSMZP3FFyS+VLxoPzsnnNziFw0Tyr1xlzWhCYtnS/D1f
 BqlulSl+g9lr7M/8vryBYkQGa9qP+Uzx9a7Gt/TLJG9SEdPTbL3BDPO053UxfjvwU9
 Uw9+F+9BOrGBUaxoxvOQmJfkGQGowdf5cpji5kdb/+JVhLDvFhc1Fpr+Q19kUljtdB
 X8CJ6vVg2DxPw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Nizat Mikayilli <nacht@dxdmail.cc>, u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>, Marek Vasut
 <marek.vasut+usb@mailbox.org>, Loic Poulain <loic.poulain@linaro.org>, Tom
 Rini <trini@konsulko.com>, Nizat Mikayilli <nacht@dxdmail.cc>
Subject: Re: [PATCH v2] usb: gadget: acm: do not requeue failed RX requests
In-Reply-To: <20261016203927.6362-1-nacht@dxdmail.cc>
References: <20261016203927.6362-1-nacht@dxdmail.cc>
Date: Mon, 19 Oct 2026 15:28:29 +0200
Message-ID: <xhkdba4o96cqq.fsf@mkorpers-koolstof.csb>
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

Hi Nizat,

Thank you for the patch.

On Fri, Oct 16, 2026 at 22:39, Nizat Mikayilli <nacht@dxdmail.cc> wrote:

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
> Signed-off-by: Nizat Mikayilli <nacht@dxdmail.cc>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
> Changes in v2:
> - Use my real name as author and in Signed-off-by
>
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
> 2.56.0
