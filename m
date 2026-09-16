Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F0F9C88E72
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 04:47:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BCCB2403FF;
	Thu, 17 Sep 2026 04:47:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8FH-E0ss4CBt; Thu, 17 Sep 2026 04:47:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1C4D8406FC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789620443;
	b=ORo8zvcrmk35FpicfHvn+fsqjAhTXmeGM0ExvZbDrE0yOe4z3zMlF03M7RevXUqjY8AT
	 G5r6Rbe6H03yhkKw/rvThBTRhIauGu621Gh9I3YS/TnRn9WCey2AJKPs0ObWlEjahRP9k
	 FBytQ9Ga4D5nfhEaXoecZtTu6frOpef5mhPgoSSMVOUr/QmQaOE+4xIQl6jV5oPYGDFVN
	 GreavyGwi3w8zM/n6MGwBUqFEK0pyUnFxxV2WlOnd+r7ZpmoIQyagAqTahjliu27jnJOH
	 CSVOS2tWGtHAqEq8LZdTZDVA3NeS+GykH0ovV+IRoUSRVIIYbOai5X9xAEeITbw5gRg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789620443;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:DKIM-Signature:Date:MIME-Version:Subject:To:
	 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-Rspamd-Queue-Id:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=eqxwM8X6W871mcBv4+sxiDZQyKIHqBHboDknIjingys=;
	b=WP6nil4xsMl0YxVbQeJrSCslbcq8PlRBVecqfFGBdj89TNMjDEsDHGtOZkWYD25qzxHJ
	 9o5sjANJzklGhDwSR3PkhmQOpFwAtVtc/dtMHnOY2kj/Br7kQE7xSrZ20OCB5qpZ4Suqu
	 m1axMxOPGHIvUfuTKExBsdpDAU5Qek62WyFYtOdZiEHPxwHcfPgJ/lfdX4RSz5b1aBhXd
	 ZO9mHqSmTiYVQeczM+fK3zg6i8LHbU88N4YCZcZzifjCmsyfqyN3c+72DLrO0UYdvJw2M
	 NoVN3d8mZA4zaewMpuyC5XxXYMX8HyKfTLEMW4d33zzZiOjt5dzCb65QJd50T9gG/mA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789620443;
	bh=eqxwM8X6W871mcBv4+sxiDZQyKIHqBHboDknIjingys=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jEXqqs42BcktEVEHi+98BsnA+Yb82tV05uOo9aOY5rcpzM053PWABqGb/HUEMcrLe
	 m39Fs4gpBS0xkU9fgF9oXF3gCs4FkU5Qg578PMbyYHx9doP8cdbUehpZ8uYdl/EoaC
	 bX1djvrhEGD6oQSzPJXEGdzLRxYJcjFG78K35wflPa7Dx9Sq5AFDAQKpjAWK8NP1Uc
	 69kmJDPeLQcCE11SoGkr+BsD45v+rv6aAU4OMtFIS5XKQSBI7wL7pQr3mX4AYt4XUV
	 vttxp7pFUpfFsajnxbjd7+69IBTRinTkyzX0rLIe7UKEqMmw8Ql7rpiQwnEI0amnwy
	 JjfTQQbvUNh8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1C4D8406FC;
	Thu, 17 Sep 2026 04:47:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9C1222EB
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 04:47:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 99E4F40077
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 04:47:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xln4HINd2CnU for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 04:47:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 76B9F4005F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::103"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789620439;
 b=Qi3Fq/BOrFnq4Bi4lC4fhNeW1pPArHh4n85HW2PV0gJWneLtDxKgfEPqMNvOWH5hqX1M
 69JZAiGaIJsWIT2Y+ic48Ls/ed8yUQfg4fklTzzaWRT2MquG6ptaBL5gVWjPYC3Ptk7SU
 tBdCzC3Rs/0hTUqbLlG361oL3XaYWIgb/bumeFLOH5mKNnXsFt2AF+fqTiWRW5Op497tc
 rXJpCwO8yMRfTaAe7PtlRM4C8Q3Mp2goJFsmgeLQL0wn/6XmjezJnsUQsX6MyzOj8i56N
 KrmSwf5L04FAgRIw5p/mM8g16r+Ujv4YODS4fDVS9Swl67HN51VYCJnsQxxKtRKesqg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789620439;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:DKIM-Signature:Date:
 MIME-Version:Subject:To:Cc:References:Content-Language:From:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:
 X-MBO-RS-ID:X-Rspamd-Queue-Id;
 bh=eqxwM8X6W871mcBv4+sxiDZQyKIHqBHboDknIjingys=;
 b=OhlciJDLwVd1fr3CknQX1GvjHQ+QL5lUujlnw6ZMgfwNSl23qnObsf21xDgBJERkKysr
 ZrVVCDUP7FGmox3Gwklqo6iWLI1qkH1RGwOHidRyBe0NQTC/SgGrMjCylwmZ3cooSBbWG
 sLieL5N/+IrdjuIIutVAki0v3LlCocmFzIEz8KG9iOpNmq3gQkHw+Kp8WrrMmM3jGSANs
 MiLLYDjALRs9fU1L5V7JHPlnuFUYugr6eVYa3rUFpMT5h9tYQFwAEJ22/snfAV/Fyypwj
 5bq2LPyB4P4pQChPpk7/ng9F/3X1+3dxSv7Z+IKGiSpSo9hdc8JCSnq+ko0c2Swc2ig==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=m2ic8KSi; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=G3oGmGDu; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::103"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::103; helo=mout-p-103.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=m2ic8KSi; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=G3oGmGDu
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 76B9F4005F
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 04:47:19 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hljsd2S7VzKmcW;
 Thu, 17 Sep 2026 06:47:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1789620437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eqxwM8X6W871mcBv4+sxiDZQyKIHqBHboDknIjingys=;
 b=m2ic8KSi/HJPejMlGkUI4sWZ0NBTUo+gWK4+9/un7xH19TSeMEPuGSHtR99l9h5vbZrb63
 AqjbOE7Afd/h/4X4mKcAWa7cqYVDgRM2J0KhIfzZocbWWsl49HB/GfLaTuC5JSrI3QWge7
 43tDnvMTbtoYei3Pfg5Cei83v1VUPQt3Mkp+m/LVL8qeJwcAt09CGqZ/z3sHeJAen/SL99
 hkFjOqYfod5Se7D9wcF+ZxlzZ8BWSzc2uSSi8R7mebUDVKaXZm9kfCFRPNMIwdC43GG94M
 BJntCImZZU9PaHkoRnQohAATLrm5vxYOcXpet5t6sH1HMOEerR+wmbwv22jxwg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=G3oGmGDu;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <a9392e75-ee7b-4662-bb5b-94626a490a36@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1789620436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eqxwM8X6W871mcBv4+sxiDZQyKIHqBHboDknIjingys=;
 b=G3oGmGDu2yatBpD5J9c2XlsIlAa7rl2pey3I1IsGrFSWdGG/Hqe9NEm6MR2LomWTl3gZQr
 GlQ2RFYfKh1Vwo6dAfb4RBiF94kmSudVwVkpQsKa7qBZi2S4ehAo1t2FgGQOycxMIwfgF+
 7IIZn8emUIDnHjfGSxARTn2trE8qbBNNSbE0HqiiNMrjycTKKG+ZL+ax0stAv7Gm/ywIF8
 PrmtIKKrg8cm0+NIl1AmLWlAyomN2NgpxX/jK45T1/6SUpQAPBQyKlO+qFKUCMxHfkqQv8
 2wqm1ZNBqJmLG7NNCrDfSaUVRkmhzOcgdVZvkeIQSfvH9IQ5agnXoBJDcjoVbQ==
Date: Wed, 16 Sep 2026 22:43:50 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v1] usb: dwc3-generic: fix ref clock lookup indexing wrong
 clk_bulk array
To: Stefan Eichenberger <eichest@gmail.com>, marek.vasut+usb@mailbox.org,
 trini@konsulko.com, stefan.eichenberger@toradex.com,
 hayashi.kunihiko@socionext.com
Cc: u-boot@lists.u-boot-project.org
References: <20260916182012.151031-1-eichest@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260916182012.151031-1-eichest@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: om3wqcamb1uxjk6ac3otwrkdsknow4bg
X-MBO-RS-ID: cbfb9d3bbc97d5902ca
X-Rspamd-Queue-Id: 4hljsd2S7VzKmcW
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

On 9/16/26 8:16 PM, Stefan Eichenberger wrote:

Hello Stefan,

> +	rc = clk_get_by_name(dev, "ref", &clk);
> +	if (rc)
> +		rc = clk_get_by_name(dev, "ref_clk", &clk);
> +	if (rc)
> +		rc = clk_get_by_name(dev->parent, "ref", &clk);

One small nitpick -- would it make sense to validate whether the parent 
node has "dwc3" or "snps" in its compatible string, so this wouldn't 
accidentally attempt to grab clock of some completely unrelated bus node ?

> +	if (rc)
> +		rc = clk_get_by_name(dev->parent, "ref_clk", &clk);
> +	if (!rc) {
> +		priv->ref_clk = clk;
> +
> +		rc = clk_enable(&priv->ref_clk);
> +		if (rc && rc != -ENOSYS)
> +			dev_warn(dev, "failed to enable ref clock: %d\n", rc);
> +
> +		dwc3->ref_clk = &priv->ref_clk;
>   	}
> -	if (index >= 0)
> -		dwc3->ref_clk = &glue->clks.clks[index];
>   #endif
The rest is good, thank you !
