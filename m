Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF5FAC98304
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 05:41:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 43965819B4;
	Thu, 24 Sep 2026 05:41:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zsB025Q4R5XG; Thu, 24 Sep 2026 05:41:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 55F3581992
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790228485;
	b=pDZmWDWVtkhhV6srxFXoqoOA+qUX+PoiZWkwHnERKp2w5GbRTQThOptNhY0hJwSHm4b+
	 NtrepFlPW3+aWok7SbexJsRe8hzbcCxv0kHuurmV2zsZIxBtDGo1uCeKzD7LnWOZvDnjr
	 k6P/5ynJCvRl80pTrBSC/zzcSGZRsPcMqB/R76af4BIk+NaIQ3YVMBgLj2VXEV5KHiv/z
	 fnCDcoS6N9BoXkbTl5UmH9FO6t9TyPcibU//HxRMNAllJchnfpjk/TkByNfqhqVxjOKuO
	 vXPjpYTFh3rfQoN4bt4ragkKuthL2jDmTi9p+7HmKp7t0EtRouFV4LL2gYqTe8xddHQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790228485;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:DKIM-Signature:Date:MIME-Version:Subject:To:
	 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hPdOjowHTXAzDdRIaqdpYgVKIH4CpVV9ZsD9QiStlD4=;
	b=KqcwsAmOwMBIHhdUaLuqptHNhA4wcANyybX0WYspuJkKCXqG4P3C6HTP3Yq3QBVMQtPO
	 GoWttC9ee+Z9ygc2VoQTFebiv3fpB1nShWvam0WM/MRRDgmb3WCSzdTSt/MWswfpDX3lC
	 d3Jf/4TzRUILEVFieCZ0vv/6JRqPL5F3mcWrOR4YcBOe+opnEF1APsAUDOkYvT5PxOTB2
	 lDOWtw5mT6YCfaNivbSLXvB/RyR51JLrsIIuHsnnG+ZXpLmRYp/yvHcwjalxvoESMS/K0
	 ZP+dqBSySixG/qR7Cr+cz55RQf5BCHkccAcGY1VvJIOVRVeTanxhp7MapPmyA7wWP5A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790228485;
	bh=hPdOjowHTXAzDdRIaqdpYgVKIH4CpVV9ZsD9QiStlD4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lRgo7Y85JA+UQEnu93YnrIrVCb6eQTmKiGdOSnsdVt855ljQ7xrdrCC0roTGlNhrG
	 JZ6o2Pp8I6N9FC8lpDcPYw2BNA3MeI2Qny+5Jsm2vZb0apNKixOlI2Ysj5Pv9HMCfC
	 LMkLrEVaTCCGFFzKsXSR56C8Y0S0NdMCc3NBJkjFsV0Hxjdz3wY0v84wK+PuGpxPBU
	 aAUW1HtAxpjBFYNG711Yoa6pio8/rQkFIOj+uTjqgZHBLbtsxXap0coiTRjkwlQigc
	 hE/dwzKAGYTCpA9Oo13xMjEEqcb27J8tt06hmpbu90+slR/5tvKXHPFX2ASfvBBbr8
	 2xk8w2IizY8lg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 55F3581992;
	Thu, 24 Sep 2026 05:41:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1B583392
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 05:41:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0745940390
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 05:41:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KArvmDBr8MTr for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 05:41:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 0A9A34006B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790228483;
 b=QFAQ1gn4s3d+cmGbsKAYo9t8aeYsisvUIulxQY1zqprdLaxT/LIdU80b5PKQWpecEcF8
 osR+5X/QkVzMGe03Kz0wSDVy0shjjHiPtfQDC8/jfUilu1O3Vl24sl917H0LkI4cWtv6Q
 iUFqzwU9Q/5r++mqdUNSvd2WQUzjpNKaAAhkrxXPpnN2Nr0ZgDHbFmJ0OStAw2ZizrNNz
 e4h+Z7Zf2DEbRfdP6i+6cKa/nekSA3sBq8o8Gncf2F3RjWXsm7qeuPqhRRxa+i12Caoh6
 +BdRXo7OO+dF+3JxuQhduOK51U8VWlMH5Mc6d88M06CpYtE+e18B+zqTWTyWn5SqJag==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790228483;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:DKIM-Signature:Date:
 MIME-Version:Subject:To:Cc:References:Content-Language:From:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:
 X-MBO-RS-META;
 bh=hPdOjowHTXAzDdRIaqdpYgVKIH4CpVV9ZsD9QiStlD4=;
 b=fW2FpOOIvqu6Uu5Br3yNiaVXG/ifGmkdwt61PDWJ0H1N+IyAlaX36tQnMUqcNlsOAH55
 gVpe1LC8Jm4U/3U6typhZhQbXvbfRygcGa2BtDfw4yN8PLLvZUHexI9w3VZmUwhxSbx97
 farmsAgmi3h4wueDP7vdaN1AlYlnxTRfjE7P++hMvbN5gyMOCfPe3LLNJv2D7tct1343q
 JHKU/B5BF88dvSUx1FpAVRwjJLtI4A7a5tAw+dR6og/yF2s9BnkgpcpjWPoCFYmPuLttA
 d2HyFNgQQbOrQvZzwKJeu0SBjSI0iKirAYGggWUpFGDyKwMHThW0VYHwtqlSTzcv4YA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=AWnPTmlT; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=NNKhdPF6; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=AWnPTmlT; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=NNKhdPF6
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0A9A34006B
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 05:41:20 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hr2kj3RFczKn9j;
 Thu, 24 Sep 2026 07:41:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1790228477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hPdOjowHTXAzDdRIaqdpYgVKIH4CpVV9ZsD9QiStlD4=;
 b=AWnPTmlT/LrVn2vXRWFJyc520/mLnH17HZpbo5TEG8Kyxf7E7rsIB4770zRsA6gMz36gQS
 bkmBKzvJSbe4k2/6nhhN7fxmaNTJAoEj4upWRTdgXUhvWtVcHzaOuZNrpFZ7sP03B+1Qbz
 tsDS9lRfmezZ3XsF0eW7G8xhZDhxPjKEMcj2vGyxqSDqb64A6LDhK2J5ZSJXLFYowV0VwZ
 i21fA95vIqcr+CD8qovhJfLm7D35hz4iwibuzGbb15bssJFA5v1YmSYVs7xde6uMPE5vv/
 dTYV9QOEWY57qG5wtDp7EhAU3gIswMng2iL6o1m7VxgcG7qvQhEQLl4y73OB/Q==
Message-ID: <65e822e4-5edd-4d48-8bdd-f7a614925a73@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1790228475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hPdOjowHTXAzDdRIaqdpYgVKIH4CpVV9ZsD9QiStlD4=;
 b=NNKhdPF6Pf6jQVByStDU75wFOS6GASqz7kSG4qf7nicnEQ6Ej8B9sTQTCgvEay2MWedql4
 khThdl55cBSWEGMhfXt11HvfoOZ5D3H5MFsAQWtBv3CTtX7e5Tla79QbOe4YLqMm2sdzoG
 qrGFLb/zYufm29laZpbWmJ2Uwn9gRxjc3tZ9bwbcSOBIDAUNJRvRC13GgLU4540vjnOIJO
 KBW6JDGAqh8ASScQ1ZwAoNXCP3aJq5IFkQhWW8+VU1TXjnxHS19Nrj7Hye+xktmUQTgtPE
 iA0AiWV4qRcGXp7zls6WNTDTi0GkZx7J2pSzPSINAa9O6+YEdiKkUwCnjxIYxw==
Date: Wed, 23 Sep 2026 15:30:44 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] usb: dwc3-generic: fix ref clock lookup indexing wrong
 clk_bulk array
To: Stefan Eichenberger <eichest@gmail.com>, marek.vasut+usb@mailbox.org,
 trini@konsulko.com, mkorpershoek@kernel.org,
 stefan.eichenberger@toradex.com, hayashi.kunihiko@socionext.com,
 Tom.Hsieh@advantech.com
Cc: u-boot@lists.u-boot-project.org
References: <20260922204329.311571-1-eichest@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260922204329.311571-1-eichest@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 1cc7673adee09a9f154
X-MBO-RS-META: 36aradzjoz8o1fazem8b74neof8osw59
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

On 9/22/26 10:42 PM, Stefan Eichenberger wrote:

Hello Stefan,

> +	rc = clk_get_by_name(dev, "ref", &clk);
> +	if (rc)
> +		rc = clk_get_by_name(dev, "ref_clk", &clk);
> +	/*
> +	 * Only fall back to the parent node's clocks if the parent is a
> +	 * dwc3 glue wrapper. When the generic node is a top level node,
> +	 * the parent is not the glue device but a bus or the root device,
> +	 * and its clocks are unrelated to the controller.
> +	 */
> +	if (rc && dev->parent && strstr(dev->parent->driver->name, "dwc3")) {

Could dev->parent->driver be NULL ?

> +		rc = clk_get_by_name(dev->parent, "ref", &clk);
> +		if (rc)
> +			rc = clk_get_by_name(dev->parent, "ref_clk", &clk);
> +	}
> +	if (!rc) {
> +		priv->ref_clk = clk;
> +
> +		rc = clk_enable(&priv->ref_clk);
> +		if (rc && rc != -ENOSYS)
> +			dev_warn(dev, "failed to enable ref clock: %d\n", rc);

Shouldn't the driver fail to probe if clock cannot be enabled ?

[...]
