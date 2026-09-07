Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29CD9C79F9E
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 08:47:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EA59A4050E;
	Mon,  7 Sep 2026 08:47:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hArGJqfr9L2n; Mon,  7 Sep 2026 08:47:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 39FDB4055A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788770842;
	b=hDXj2WFKrYipYrgoEQQaWD5fLKQR4TeKDIwB6Jb9EcmGT4ksSK5+6Fft9nTkwcardegj
	 4xR+VADW9RqKcxr0Ny1qRyQCE/tU34rpIZqfQ4DysLNtsKHOVY9FqOXXfamLgxfQ5RkVY
	 3Ew9bQWehp0MxDXfN8u6aCied8V7BAMHHTNd4QrScwEmX6fA5TOiT2WNStd8+1zqnJl9f
	 NdNIsozvWzhyQuIMVe79dky0529EKkIJQagMeNOQCQshH1y9HROwe9HysTI4GchkxnD4A
	 r3KXezuIaX5Qg1FYK8N5JL+B6Ch8clGEXEEo5TK+qVB6csNQTjWpy4E/O1bFWuC4/QA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788770842;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=rAd5lYlddeYjM9wUxS3u6Tnv4U6ATxCI54whh5cIkMk=;
	b=pXi5d2E0PfqgSGwgLiERhY/lHnzxLzuN79WHRkgXGA75hjIN2fKQeMcuFn7Rydhi/+Zc
	 jDIemnZ0hTRoMJgY7UObJzoKXJ92+Km5uGsYfENJTMSBPAgZzD74D9sjzoypKb4fi7QUX
	 QhQiXjnVwg3/R2zKUDFokiZ7FlB8U8EkzrzSm0kao+6lpy2mUK/n8V0jXv3p48XOh9kKq
	 AxJNuCJrcpJ2t16VX3YX3tfr3i5h107OYWJUGeRgWHXwIwNtzUTzrRUbAiwxbyenIPxOs
	 XpOYiL9R+vAum7AhZujFtVyytm7TxQ9zlgXpf/4qZRGnUd7yqcCNp5W3xPWOX2mmOug==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788770842;
	bh=rAd5lYlddeYjM9wUxS3u6Tnv4U6ATxCI54whh5cIkMk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sg3GvhZyujbns7bWGV9oiiSdf/8lQOqAlsoDWXAveNlYi6jYQZHG7RHNvJmJUeqt+
	 Lo/uzXfrdUtMYFj+QDlUJaAJ4DDHdPmI5CJSCpptx3jpoiczvAJ3Pex3YPifTfvsCO
	 O6a2V1qYpu+KBgxrcubU72VctOySVHwc59Cfx8oEyHWZcdUxwPOF/moSkeGjnrlugJ
	 ESrBFVJFKX65/dVaEKVVq5UFcqXpZdLCKhyAH9NPRx7zVvkyTaQSrUo1G6djBrA6V8
	 BbDLALhoF9hSbKE9/qhI2rDvUrWzUD8iHcl2ZMUP5p/wsjrf9geMSNRj60JZod8X+5
	 vEuHENTs08s+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 39FDB4055A;
	Mon,  7 Sep 2026 08:47:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 48E4A2FC
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:47:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 460D480BBD
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:47:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gljxYqZpk4s9 for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 08:47:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 56C0D80A75
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788770839;
 b=g4wTfrybrG/v77RGGrVqzS4zV+JjK3T/YluTP5p/TEOAIh8Q4/DPbrHnBK/oDoPg1fIX
 LBzuZh8p9V7JZXChk11sy7fcFJpHHbUYeonPTrhz+zMY9ATg6pQQD6nxEA28EcXCR9oVP
 T0ttacxC1PcpCt+x1hDtsSSF9IsmxbrrVOHH2EpuDtWQZ3kJ3ImH3bQAFgz1mbqHauQfF
 yR+GOdfxptqb6Ej1Frg0lVapJs+TbspmenOXSUPUAYPrmSEQCYSCchs8fchzptTuJcysC
 vX+wJxJImCkTOYbU//aRUqGxSNeSxmy/5Jei0o5nOrxDf+Yee3vQ9NUTTFFxjX64sdg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788770839;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=rAd5lYlddeYjM9wUxS3u6Tnv4U6ATxCI54whh5cIkMk=;
 b=myd5v9Zu71xk7c4yEjX68k+y7QOMS/IJywD1KPBKnhsgKfR9I8CSIb9DeFBtGK/igxJO
 0u1D9W9GdQ6Y7NPSceUCWpkgJf4oLVUt9EQzXqiMsCuWBbBUaJ2wmhCLDaeWVqjxBk4C1
 5j8zs6GTvgTT1VNK6kZbiFakhIU0/myKLdcww1iMnt57i1pQkYWBMGAUfc2cVmkKmdiZr
 wt0VcixaM5pynT/12AQv5Fjs5vhXqUmPQ31n47v/mIzqcit4FWuiRLh9VfFLFSJwvvunK
 LmVdpAQHpRJ8pR1UW31cyQSC7gngNaRZFxgVagfhsV1J/0InWHnEC2eD7Fe14U/zKig==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=FcHc2WCC; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=FcHc2WCC
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 56C0D80A75
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:47:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7004740109;
 Mon,  7 Sep 2026 08:47:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56781F00A3A;
 Mon,  7 Sep 2026 08:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788770838;
 bh=rAd5lYlddeYjM9wUxS3u6Tnv4U6ATxCI54whh5cIkMk=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=FcHc2WCC6NO+vZsRf+R9x3Fqvv6On9MRjhbFGC7tCBxtR/lzqgNlG7OStGh9D2Ai1
 cg4MPbnqrUvPKFBfEoccyS3BYsvyeNamryCC52Kvar9wMSFYn5EKzncw5mhj01/emZ
 8qYX8+KsqxEFKbB8pSQFiruiEt1UrgHPJf2obP5zo7Ye9KGNl8VMRurqnxN8Oj6bX6
 fOA/WpdYbHTvy7QRCJ1B5dnDLsCvRhwDgjzjKXFZrG5XFjh2tCC2moSwY9Y3xA1TLB
 XR0vLxIbR/U55Yhdv43e7tveqZSzoKcYt0eSE4BFkA9CZNzTHmM6DymozWgB+9UQli
 SlSRhwaRwpLdA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Marek Vasut <marex@nabladev.com>, u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marex@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] usb: gadget: f_mass_storage: Synchronously tear
 interface down
In-Reply-To: <20260903020231.1278473-1-marex@nabladev.com>
References: <20260903020231.1278473-1-marex@nabladev.com>
Date: Mon, 07 Sep 2026 10:47:15 +0200
Message-ID: <87o6e9tpm4.fsf@kernel.org>
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

Hi Marek,

Thank you for the patch.

On Thu, Sep 03, 2026 at 04:02, Marek Vasut <marex@nabladev.com> wrote:

> After fsg_unbind() is called on UMS teardown, the fsg_main_thread()
> which also invokes handle_exception() is unlikely to run afterward.
> Therefore, any exceptions raised in fsg_unbind(), and also exceptions
> raised in fsg_common_release() which is called from both fsg_unbind()
> and fsg_common_init() fail path, will remain unhandled.
>
> This leads to a problem where FSG_STATE_TERMINATED/EXIT handling is
> not performed on UMS exit and the do_set_interface(..., NULL) which
> shuts down endpoints is also not performed, leaving the endpoints
> enabled.
>
> The CI UDC driver does check for repeated enablement of endpoints and
> returns -EBUSY if an endpoint is enabled repeatedly. That prevents
> UMS from being started after it was exited once already. That is,
> running "ums 0 mmc 0 ; ums 0 mmc 0" on U-Boot command line will lead
> to one successful and one failed UMS session. The later session ends
> up triggering fsg_is_set() assertion in fsg_setup() and triggers a
> panic().
>
> Fix this by synchronously invoking the do_set_interface() from both
> fsg_unbind() and fsg_common_release(). That makes the unbind behave
> as intended, as if the fsg_main_thread() ran after fsg_unbind() and
> handled the outstanding raised exceptions.
>
> Signed-off-by: Marek Vasut <marex@nabladev.com>

The change looks fine to me. I hard a hard time understanding why there
was not an equivalent fix in Linux.
I think it's because we have cyclic in U-Boot and real threading in the
kernel.

In any case:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
> Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.u-boot-project.org
> ---
>  drivers/usb/gadget/f_mass_storage.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_mass_storage.c
> index 7eb667c130d..76ee08dc5e8 100644
> --- a/drivers/usb/gadget/f_mass_storage.c
> +++ b/drivers/usb/gadget/f_mass_storage.c
> @@ -2565,8 +2565,8 @@ static void fsg_common_release(struct fsg_common *common)
>  {
>  	/* If the thread isn't already dead, tell it to exit now */
>  	if (common->state != FSG_STATE_TERMINATED) {
> -		raise_exception(common, FSG_STATE_EXIT);
> -		wait_for_completion(&common->thread_notifier);
> +		do_set_interface(common, NULL);
> +		common->state = FSG_STATE_EXIT;
>  	}
>  
>  	if (likely(common->luns)) {
> @@ -2647,8 +2647,8 @@ static void fsg_unbind(struct usb_configuration *c, struct usb_function *f)
>  
>  	DBG(fsg, "unbind\n");
>  	if (fsg->common->fsg == fsg) {
> -		fsg->common->new_fsg = NULL;
> -		raise_exception(fsg->common, FSG_STATE_CONFIG_CHANGE);
> +		do_set_interface(fsg->common, NULL);
> +		fsg->common->state = FSG_STATE_CONFIG_CHANGE;
>  	}
>  
>  	fsg_common_release(fsg->common);
> -- 
> 2.53.0
