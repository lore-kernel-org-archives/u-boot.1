Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288A9606A31B
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 13:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rXRWJOik;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ZRj8n6t1
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DAA8560769;
	Tue, 27 Oct 2026 13:07:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id beruYGVf0fqP; Tue, 27 Oct 2026 13:07:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3B7BB60725
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793106470;
	b=AqGYRdLzSWRUObTFenlwcsUBWNTn8/7b8C7dwWaBqzdX3447LhIsW5W5jEtOXlCWK5yR
	 iNUU7uvuaPEZDUiGKqQ6DDt2IILhoozku7o/awJxR2++g/fbfmIrZ8bovUS3wirz+dkXE
	 WMU5NgtxPlow/xnRu7UhoeYqmFsyh9Lfpri2t5FDk4w6g+n/Y7b5cj0zYZmwS1icp8i/k
	 eWjs8TDtkYoEA4VJVliL0oyk8AlwE1zMkhh6E3aF8gVj3ZNT2DaQsPb/RrIoEcB9orrnI
	 AOmUhMSa9j/ggIDp7cUdYLoaAF7/OUmAKcBC0flnaTGRI53qUlipD8GCQaxCXslHx5w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793106470;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=B7RAxKbZaz6SjCm/shf5W3P8evwqzL/lsvZftu78jnE=;
	b=qCFYgnxFSrTuIg4W+n8gCQmOfmbYR3GC1bsNlYaAU/JNQW04e851Te028ZCTJ2umewGB
	 nswCM/qoDfDRpdf/jUqC2PXXsGeVWwxKr6S1rjB+JbeuIIgfobEXX5NFHobGPbPUd4bZ2
	 d1H6Hp93UkEeYRPre78VjkKUw0DCQYVx+otY7JTiCjPD9OPGv3NSIoNXp+s60pFNFHq6g
	 pFynhpvTHzhy4wdfhQcHa3VJiZyWVQmab9ymevx2WhW3zW6/Saygb1kNvYZtzqf6c+pgM
	 DNimjvkDLnImeMSi/HXt8oAsE6FmzshQ2miT/yqKsZbsQjrYFNgBpipHgtUz28xpCLQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793106470;
	bh=B7RAxKbZaz6SjCm/shf5W3P8evwqzL/lsvZftu78jnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rXRWJOikOqnXcdHedCWJhW1czCvGY/jhl3M9FMDYbTDKLSZ4WNxorSVCR62jU5jlR
	 R2T75qq7EpJC8syN9L/jjhXWwN+ZgSsjyzhVM0LYfJS4PcqpibP0CXvTpi7RAUM5Mc
	 g6XnEggpIIVBpTTLjm94Vxxa4PFwodvZCNApaCFV8AkMUqYs3x6lMK5KqtU9/dH9Na
	 Rjho5LfFVfZT6pLnlh2nahxReeHxXMwjk2MYpH4yjOyNT/oXljD3OshNHR+yf0X3B5
	 NseoLYJuzFmRPV6nHcdcit7bdygQxAGrxUf3zrumIGAaXkbZuwUBRqWIF+46gT0RXJ
	 t/XV4EgPKOVNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3B7BB60725;
	Tue, 27 Oct 2026 13:07:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A39F2235
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:39:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9564840536
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:39:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fzPkUZdDVZys for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 12:39:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 958EE40534
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::634"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793104754;
 b=rVMx7cwiPIyNVUD1Gxt3jgU/LjkJ7dL0GZo+s8sLXFujqyJ4GzYdsJCHrsyjWwRKJJF6
 +rRxLJfd5qCBHslha+iZX5wY4jVSufehIbU/HxupbsB2/iI8+Nlrgr29kCt1ogFKGGgsD
 Z+xFKKqrSQ2uKKejvuXyZHdBL9Vly2/XYtYJnxIveR3EPZ4BAVEQ9ZccMQZj94Q3iNEr4
 2ezVJ3NoopYqslb13AH9zorLwx7NYwwzF8Hky6Mwp7n6H9qNdYpNz88e4wUGF3h7UGud9
 rUJoI+wuAChlf0mquxmcalX6Bz6PlYLB9a8q1XQQDEejoOzNwW3DQ0tebtd+EfoCy9A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793104754;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=B7RAxKbZaz6SjCm/shf5W3P8evwqzL/lsvZftu78jnE=;
 b=jEs0KUGtq/NZ0i+VhFBoXEn2d1MNYTLSSAL21c+40UOveFQFWZC9wfOV5BhAFVErXyBd
 Gz07JHJxsopO+xEczbvJr4HPB7VKbtG/5Wsmp4ODug+ylytjjv71Faw4LsTncMaUUu1Jf
 V1V3/fzN0V0afkrKK1v+Uwg6lv1fIjm8k8Wp/Z1HYf6in6p2I98ZBmE1OnY9K+KGcsU7M
 rNESI8cszq/FWKFm9NQqP8xGmAABPYBKlmCB7SJOyDpWlnZ0MWR5yIibRTAI3JOKA34ei
 OVxwYQ+j+3IB0wchL46p23aX5XRhRtICwsB36dF32RdSUAK8Npyyre4OQkpnUf3fInQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=ZRj8n6t1; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::634"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=ZRj8n6t1
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 958EE40534
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:39:13 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c499e0e43a9so22851666b.3
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 05:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793104751; x=1793709551;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=B7RAxKbZaz6SjCm/shf5W3P8evwqzL/lsvZftu78jnE=;
 b=ZRj8n6t1bHb1TxXI0l5Q2meUADqqwSR77oPK6mRiP0VYKCPNDinwcgKrz7i7EZ3gcV
 oQcFReccPttGIaXjjAKf/Wb53WzaWoHTNGB8ywOfKQ4cZQFPXemyPC1lLXujceIfoiU6
 wpWh1IDlIs61mOpR3RP3cbG6H6NU8hZSx0Y8HSCWBh5u7NY6/my6IQcERrRU4QHKe+4M
 rjY6GivUV0Sr99/DRXb243OSvrq4YVmdl9TUWlO9rSnHvmUYZFTLi3UGR9HP5pwnGFAy
 iI5GypKTxiKa+Ni7SKigAolj7sYKqxVzFRIYN4dDn2OaUwSS8eSrHx+gFKFSITULvqSa
 q4qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793104751; x=1793709551;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=B7RAxKbZaz6SjCm/shf5W3P8evwqzL/lsvZftu78jnE=;
 b=GAY+WHUYsokB/KmL4mp5SH0nxdZmVNU2a9hU/qVeZSbD63Q9p+9p5qXj3mVm7BQfBI
 4ngSq91nS1QWmv7PixaWaCUQGYL4NWOTeJfcAd4UVwFTouWgyT+ik9ukTvfWciD47CWE
 kirdhquzncSxJGBKhs3KIF9E6hOBEnmMTwcn1rCYqj9G+hnwL0+O65ZNGReB7bg+pQjE
 l76GHOtastQGpUA3os0RoKX9X/ZtECDwteqPTf0qC8szYh1HVk30zx+CBK9nt+CmbxpM
 9gpeFzmsObj1AB3nvehIXaOs2Py+MHZhf2oWUezZpTyWTukJqqT6PubMxYWU8hNDCFGc
 Vt9A==
X-Gm-Message-State: AFq9FYKJxJxQqAxsLWxVW7//p+8v7lvKMmVXnKOPw/5sMLvz4THrsb7P
 Q7Mc8nKCjrU+RCq0EJPSHS6iqOFBLFzzTO1dI9cN6ohQvRFsKICQRbGc9OpxhYzD+GA=
X-Gm-Gg: AYBFou0Efm7HUaaRrWy+anruwe+N+v7X4p4VQEz6VNH7fdzq8Rh3ynsXFBI1KUevGJW
 YZ85DmZHdLIK/EJchr4Yb+/2XiX9lsIZqb2TBj3aBiI2IA5MArA517jXcoYMGTHNrR7fYim1Mjm
 zUFfJSN9pgLtUTip9dkUQdR+stkCrA3ZdOP5XFw7K1MImV4vT7R5/IGqFGDMjzz62FOV43oDjF3
 xhncdXSn2qJbPVwFewFC71Iyg6IFMe2PcU7xC5MXgIYAG/XGCuQ6URiwD8AvL/FleqOEndblZSD
 fiCX/QQXZ9oRoWgbxRtDWCHWEq6WlL0BSjWQiFl4/X7FCqwALH+T+rXde6OmmtAC8Peao2L0neY
 mcSjN9mB53gDYw8O49u9O3/jJq2jciJLqEQjnTOeFlRuzu0pyUdZ4R6yEk6BbDYVOPjnqFX+RVt
 GZz0VyUQ1q+4SNQdvjaHKHhiQ+NqElXbwuz6tOe+/MCeD3py+g+3KaiUb5vyN58bM5RWXC6t8Wp
 +jk38g+Ks9RJyf5nSCPYLGJNgJ+4gLZIHXoc45S7kbiMBHZ9eK9JyDqSZB4qK3W/OLbxoT1+fj+
 E5J8z0egu1coY8LPh0+0LrMY2uh6KdbSKUhcBUW3Hfp0rPDgz0DlnOrFEc1gvg==
X-Received: by 2002:a17:906:2886:b0:c46:b5a7:5b29 with SMTP id
 a640c23a62f3a-c46bddd029fmr1019329666b.2.1793104751089; 
 Tue, 27 Oct 2026 05:39:11 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd34f874sm450522366b.9.2026.10.27.05.39.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 05:39:10 -0700 (PDT)
Date: Tue, 27 Oct 2026 13:39:08 +0100
From: Anders Roxell <anders.roxell@linaro.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com,
 ilias.apalodimas@linaro.org, michal.simek@amd.com, lukma@denx.de,
 alchark@flipper.net, jerome.forissier@arm.com,
 dlechner@baylibre.com, anshuld@ti.com, sjg@chromium.org,
 Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: [PATCH v9 03/26] usb: phy: add the usb_phy helpers needed by the
 resynced DWC3 code
Message-ID: <auCbbFtw8ld5wBjh@monster>
References: <20260916123826.517181-1-anders.roxell@linaro.org>
 <20260916123826.517181-4-anders.roxell@linaro.org>
 <283d1b1c-16de-4ff0-a57e-a54b4239b118@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <283d1b1c-16de-4ff0-a57e-a54b4239b118@mailbox.org>
X-Mailman-Approved-At: Tue, 27 Oct 2026 13:07:47 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-17 13:40, Marek Vasut wrote:
> On 9/16/26 2:38 PM, Anders Roxell wrote:
> 
> [...]
> 
> > +static inline int
> > +usb_phy_init(struct usb_phy *x)
> > +{
> 
> Please call the phy variable a phy, not x .

Thanks, done in v10.

Cheers,
Anders
