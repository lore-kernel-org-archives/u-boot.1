Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEC3606A323
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 12:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PY3zvkIM;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=iGA++rq2
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 717648144C;
	Thu, 22 Oct 2026 12:55:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vbKAGvoyGC5j; Thu, 22 Oct 2026 12:55:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 96D4981426
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792673748;
	b=fgfaP/hu0X1F/mqrt+DA1HOsYyDT2+5HMpE0/eDZt+BU1reOqmDvOFSoo75SB7Va6IJn
	 q/yxMx6xGU1RIr+PjVlqH0gziwRTK6Pqml3IrGRlVrnFk1nJvr458ed4UwfBsO8vgwNVM
	 cRilIiN1MN/Y9XSf1FLlukaEEk2E9mHJuAkPXz2BXKT/SmNW2fgNkV/VLs72sVXnYlNGH
	 UKNUD34sDiQeWLmaCKx3M+1rFKHNCkg3JbMtebEJKtSMKPWberALB6qwoZCZNeSVQDIaX
	 tHZPg6bGZBpbFKZmlNh0iNSK9NPvWLzc2JNhT4u+VhMz4AtUJrEdQpl0FkZuMOwSCVA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792673748;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9JoYheVaKoULk9xthqAwqxwjIyzbddEcj9ZRs3+dLjY=;
	b=NHKoBWkm9PMpqAaiNH1rlaI9qgtKQJNalkwIr+UzlwIIHVu+L2b9TltSgLnMdB3ifLIR
	 jSnKqOJ3JMFfmhpM9biY60avsgJWUqSpS2rCyElQx1JN8WdAdGr/NuT40vdGqvFvzGSdX
	 VGdvauymTT8l+H/JQv+CHmc+iI0TgHRR1dwMWnjSjUlNqiKNQTkNQ/RwtgVLb/ejcN6Hg
	 7kuf2ZWrutvJiVu9dwqupMjNECapzgx+1vxL2XT7bpheNk5/WdQhomCL8DhD4F6SN/Om9
	 Ktphk/ItI61OytaAZ955/yQ4yVVZr/SeITvhQuKF+0AAmuIw843xkteZMJrVAVtPWew==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792673748;
	bh=9JoYheVaKoULk9xthqAwqxwjIyzbddEcj9ZRs3+dLjY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PY3zvkIMg3C/Oqyc3jS67BMjuP/07dOShzRpsPytR8AUP29NEiqomnaZbwxNrXfXr
	 QtV9xz7PRbR9gh9BcABg51f4dZk5SP0nl1O2MMh7EoTxCQElSqo0kvV3Wsh1M570li
	 UBZzlfE/IHEyil9C3o+YKrUI3m81if2a3KbjAfoNDFkmf2dhouj2rhV6upF8VDm66N
	 6M6GsRdRNjd4/UF2tpMpHY1N3GF3DF9d/da74oDcnQM9ERl6bu4fvq2nvdr8NYfTyo
	 msVuybbU+XTPFRfQFq6hhazr6qGb9r0KrUaLTX9pOWg/fafGK805iiYqap5iZlrTcb
	 obh+ihWuszl4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 96D4981426;
	Thu, 22 Oct 2026 12:55:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 802E795C
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:55:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6624640427
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:55:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5Dh_L_DyJX5f for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 12:55:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D34DC40421
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::103"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792673744;
 b=dCG7S09xZQfEkQ+RmxdUUmBLVaZYV30NzuBIa7d2Vo5NH3ETv/eEKgEC45Iolazxsbam
 mVJiiUGUvmxuZC4r5FzyOtXB16WpwH769gHigIEBKGOtHUC5guexvou/CsOs8myC9S/tw
 0qhPwJWMs3IXfcTIVlO5jjwYrcwLd7Vw/R3h1b41nRPGJZ47d5Za0QACRBFUPp+hU+6As
 XnWid4b5v9+HcNtggvoNMOIRRAj16AVm2k+isM4FEUDJsj+llHPr62qE8ieuf0J2KM1Uj
 lm+dCeC1MmNL69khhX4xJjOfeflub7Jjwd2g6hqmOcwFG8JZPtiD7+SdZ9tDVtqXeVg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792673744;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
 bh=9JoYheVaKoULk9xthqAwqxwjIyzbddEcj9ZRs3+dLjY=;
 b=iYIVXmoa3djTgIB2HjGyjCdAUOe3J4AkxpikDRj3J603/yRwSmSwohM/2KEPCFf4cii5
 +CfDss2M4CJtxP+S2ANIQxpDnD5+Lb3+i7FNuRfqzveYkcbronAAEpMYowNokid79Xch1
 IbPdpsEhd/7tMi8Wy6qTIW+M7KXiCjfWBZeBVWKyALX6OlTemTm85O9SUMyi4hvIinNSP
 rO7jKqVXNJbkTEL5lDnqlCNLY/7PY5FXiVWG7iEyG995+lc9PeBrSYkJrm6V+pIrhkV2L
 miXYFO+QO1l7B3YFHLXwIcQRKJ8ucoRlrPcUOZMjrqIK0SArC988qSTA1pV4Rr1aVDA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=iGA++rq2; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::103"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::103; helo=mout-p-103.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=iGA++rq2
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D34DC40421
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:55:43 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4j9R301mk1zKntd;
 Thu, 22 Oct 2026 14:55:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1792673740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9JoYheVaKoULk9xthqAwqxwjIyzbddEcj9ZRs3+dLjY=;
 b=iGA++rq2PqXBTteO+fltgcB9R9QCxasTdH0tC4CcIwEU2hWDFUIgKmjRkxG5AGhQ51N3fH
 r2tTJzxhN4Ecgc7bpS20hPuEAxoECEVfqUSk831s///oNcpKb9jvidWg4rdWpvXignJWRC
 0+NUjbOjHusYIQ7+G4rU+mXqyN9lG8AEJFiB5bvv4FeIT7YjaZ3UGKTF4daWn2aE42+JGV
 /qc8TF6Bp4FWszxE3cDF9Ymg4aEmgK9uKH1PodEO1D6WaN2UgtbHRlYl7ksTIk/j1dkSVl
 lH3QKp/MdyWuJ7YoV6Pwu3zO6aunYTNIv8h1VhgDX1lqGr0VRzIPXsj92e4vSw==
Message-ID: <2351231d-5ce6-4ee2-872f-cf4a94aed13a@mailbox.org>
Date: Thu, 22 Oct 2026 10:43:45 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: xhci-dwc3: Add DM_FLAG_OS_PREPARE flag
To: Jacob Procee <sn125164@gmail.com>, Bin Meng <bmeng.cn@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <kettenis@openbsd.org>,
 u-boot@lists.u-boot-project.org
References: <20261022070211.128370-1-sn125164@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261022070211.128370-1-sn125164@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 2b31b0e7bdfe1735c63
X-MBO-RS-META: r5cfzpriq8utp58dgoa66zdgy6qzzpux
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/22/26 9:02 AM, Jacob Procee wrote:
> xhci-dwc3 is not removed before U-Boot hands over to the OS, so the
> controller keeps running after ExitBootServices or bootm. If a device
> was enumerated by "usb start" (for example by the default preboot
> command for USB keyboards), the controller keeps polling it.
> 
> On Apple Silicon machines (tested on a MacBook Pro M1 Pro, J314s), a
> USB device that is connected while U-Boot runs is then not detected by
> Linux until it is unplugged and plugged back in. Running "usb stop"
> before booting avoids this.
> 
> Add DM_FLAG_OS_PREPARE so the controller is removed before the
> handover, as was done for xhci-pci in commit e3bbc1f74e05 ("usb:
> xhci-pci: Add DM_FLAG_OS_PREPARE flag").
> 
> Signed-off-by: Jacob Procee <sn125164@gmail.com>
> ---
>   drivers/usb/host/xhci-dwc3.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci-dwc3.c b/drivers/usb/host/xhci-dwc3.c
> index 3504a7cf4..92b311d42 100644
> --- a/drivers/usb/host/xhci-dwc3.c
> +++ b/drivers/usb/host/xhci-dwc3.c
> @@ -256,6 +256,6 @@ U_BOOT_DRIVER(xhci_dwc3) = {
>   	.ops = &xhci_usb_ops,
>   	.priv_auto	= sizeof(struct xhci_ctrl),
>   	.plat_auto	= sizeof(struct xhci_dwc3_plat),
> -	.flags = DM_FLAG_ALLOC_PRIV_DMA,
> +	.flags = DM_FLAG_OS_PREPARE | DM_FLAG_ALLOC_PRIV_DMA,
Does DM_FLAG_ACTIVE_DMA also fix the problem for you ?
