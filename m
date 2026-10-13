Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4987CA9ED2
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 11:36:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6ADD540522;
	Tue, 13 Oct 2026 11:36:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MvV-4HYUDJxw; Tue, 13 Oct 2026 11:36:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4B10340517
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791891371;
	b=mdMdVPDT8j/egC87K6xd+GuCRMXWt7Y2iPCC5mMvrMqxRQ+oN0yYyJxTCeYcG+PwBF1P
	 sHe9qWjMonBWLM2iGxrUOpvGoeuqi1qiYmGXg3kXcDIY+qsOpPsh7jSsKlvuN/00iPRW/
	 GJIaQ1w6UIqjVzCEbHMlru1WNKXzBAz4jPr7oBOS5bRr6k6lBpOdESc3n67WPgMdnCE59
	 rfdzLwVdmEkneSc1Tq5yPHNTHENgC4/X7cOWFnLsb6XBkeywBibvTG4Clvnt6blRicVF6
	 2GVRNH6xvQpaT0wEkSp+qWivsERYnGnRQ+fXIJKKAR4G9rzHycX8a/MLOD1xBCOx6VQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791891371;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:From:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=zvY+3YyBnscbBJt4r0+AOlRLTOo/HFA62u5MRt8+wyU=;
	b=A9QnKextwpjb5HkkgAOwF/CPjZzpLjLI1w1yvaSRqRVjN3SApjUScwfM2KrTzN85onxT
	 vcAtffEDkgBgRhdYpVZLfK5CfbhPTHS8pXqFjw4tZeIcHNuhNXQzsR3UghxkV+/WrLYg2
	 pl0yNRXJ7PGWLDI6OBtgKt8KY7NFjg0ZHd80HiP/L+ZhX4A74WI/5FNjUAEKLpFoo/MIb
	 19Tg+zBcikH30011XiNi+MJ9vSGj8/pEHSy7nE0rPMu0e3ROrO7U2VhqeVi6VMwl0t0X5
	 5TuJ5BiHCicSeg6PyAOhXg744O/sx8lQhvru3hiPnFMMnNcKk6p2zqBGmsv31GW2OQQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=none header.from=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=bX1syWR3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791891371;
	bh=zvY+3YyBnscbBJt4r0+AOlRLTOo/HFA62u5MRt8+wyU=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N8e4QbjKDd+mptIQbIXj8KqUJ+Ddx1vldCRLZ5xFl97mcPHQLC7wmZNqSTJF32kYM
	 QOfelL6gyEivgzHqBiE3qg5QIcP7ynldxEIvrkTh9UzpcCPysmuTAOGX+rH8/iRm57
	 48I89fqPNkXDRN/sEa7leJPn/RmGy4CNSAcWDoqFyKEM67ggz4f/Dj7LhAKpkWn5M6
	 +8RHJfWHZIcCyrg93SsPyQMB0egBawhe1g73OAA8wooKNUobuDKX/XiYB7yuoyvHew
	 fgMsAJt/8Ff7uZsiJmKBR6hcIdGzwTrLRi/c6/iaDw2JZoZgSa1vHKO2GV+8Xrc8L8
	 BwYtV1iYAhE/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4B10340517;
	Tue, 13 Oct 2026 11:36:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id AEB59A58
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 11:36:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9DFCE40515
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 11:36:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZHrZJiuKlnd8 for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 11:36:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6D8B24050A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a0a:edc0:0:b01:1d::107"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791891367;
 b=KRIQE90F0gljv/3NUGjkPzMz40xyD7eWarrX6D63WK3zgzak72QUC3fH1DwMlCDtIZ0B
 R50P/o3sN7AyQV0NQVIF1RllJVq2gpsQO3HeTr9J5xS9WoMfqixn4nMw7DcCFBn6hu0A3
 tW/XaSTKpP0W3K9C7KFWuf+2NeQOBUcvM8Gv5KGY2wgoEeboLFAZXKuapRFbXid3uNBuM
 s8ZbTplrVvl+MVsis7S2e3vQaLPszgrOkRaZuFY36Y7uY+3WCYhuoPEKXLU93oHGYhL/+
 Ne8Z1Yljb/Pcoi7OyrnPG49q4lxYd9J9eZGtg1N/o9OPtT2WgyUl2eILP17hawYg2dQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791891367;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:Message-ID:Date:
 MIME-Version:User-Agent:From:Subject:To:Cc:References:
 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=zvY+3YyBnscbBJt4r0+AOlRLTOo/HFA62u5MRt8+wyU=;
 b=T5wXtSgj1qqYcjHwwB782XzifM8/7PFJvCXO199UaLzLBbsI2KAgjACpvCMXt0nMe60k
 TldWCA5W3//7st5IuDD4P13UoydJH3seoayfnFk7J1Izb7pfoRu/X7y+2oiGAALMxMk3t
 CqIHdNAsFld0+NSskfKgXrKsYvU9hXKtQ4ssz5cR8WClU9pZUO+ZH1E+YEljr3Re6E0Jr
 ZNivHrBR404PNJDtDfjjBwoJTif1Fs7jyRDZJRnjI0NjaZKqG53ViXBNKfZmcr2sk93CI
 xHYmOSvtzyDRruQrYL3zP3zu8aTRensYd6dHQkmqfEoxuF6NV65ApFi+XFkNVpep6bA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=none header.from=pengutronix.de;
 dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256
 header.s=20260414 header.b=bX1syWR3; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a0a:edc0:0:b01:1d::107"
X-Greylist: delayed 560 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 13 Oct 2026 11:36:05 UTC
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none)
 header.from=pengutronix.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=pengutronix.de header.i=@pengutronix.de
 header.a=rsa-sha256 header.s=20260414 header.b=bX1syWR3
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a0a:edc0:0:b01:1d::107; helo=mx1.white.stw.pengutronix.de;
 envelope-from=a.fatoum@pengutronix.de; receiver=<UNKNOWN> 
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de
 [IPv6:2a0a:edc0:0:b01:1d::107])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6D8B24050A
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 11:36:04 +0000 (UTC)
Received: from [0.0.0.0] (ptz.office.stw.pengutronix.de
 [IPv6:2a0a:edc0:0:900:1d::77])
 (Authenticated sender: afa@pengutronix.de)
 by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id B3A42201CD6;
 Tue, 13 Oct 2026 13:26:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
 s=20260414; t=1791890803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zvY+3YyBnscbBJt4r0+AOlRLTOo/HFA62u5MRt8+wyU=;
 b=bX1syWR32BoQeh+gqqqV3GzFA78+o6nTmP3GWQR6mPXNx3jiA+hrancKoBcSaUkORhM+Np
 m8C74cdWZR1NANlgSvFfKlrIwRyKRctO/mjpRuW9qkQxFSAf7lY/JTQp+Y1lB7qg2klNxd
 SnV+jVs0yPZo0Nk+AzaCURqFxMP6kCZpU7f7h/k2r5LqI4uys7tX/iJvt7xfb3IemOVERr
 JVxml8UW+oAjkHr4+nEtdHLiiP5DdawOZ7E03wz5kaFfHaZfhmJzzbX4VbRR3de/dYBlvX
 2cb3jcEDrKZDPrHfimJne8TYwxV+P0FRuEEXo6rpVz0rjnbNoaDjWgmid9midQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791890803; a=rsa-sha256;
 cv=none;
 b=N5hRS6RL6yhGNkXjYQNskfLNitdhcrdUI+Up4DQyXGvtUl6sjnquBtJ69g5MTG2yX6RXx9
 o21VdvZrYNpd3y5D/vvRP96UqKin7/MtIh+ji3AaEpe3sOg39q0St5EQgGM5J39BVNupaP
 uy0VlpamOaifhnNtXbkVYfvgssRv9wRlRu0LDRbXzv906bSHpKqWJ0zqLKa0utdGASZbrM
 JmqcDwhpNQrvsRtkWJd0db5t3g4kfMImMmpoiWryCqnsO4+7ZlPDFlwXTRzc2mUTnuGlWH
 9hWCB/Oonw/AFGltAzKippAoHZCiOWYMN0AjVV0a06nbpNIBo6DVfOY2II4K/w==
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=afa@pengutronix.de smtp.mailfrom=a.fatoum@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de; 
 s=20260414; t=1791890803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zvY+3YyBnscbBJt4r0+AOlRLTOo/HFA62u5MRt8+wyU=;
 b=KC0hkpMbsG1DQPRkyUNVBSFJ20JYXi8XKZqLkuJEmbmO7/g6DpUdsDOadE/Q3JorZDh+xy
 kUUv3qB5pzWOhcrxYmXzYFXyfnKNoCZL+gI8yR6Kd8DvjfRR8jvGUcRTl9OaYzRZs8PjK2
 tv2J30UEunhLP0GYI9Yqzj4Q8Tj5/uCbRBmVViiRLl11BTyYjtIXEMVdWSOxXBjVBZfw/U
 OW6eZQmieqEH6mlaNjgwIzpFUMzmh0hUaP8+kJ+/7IDtcFDBfyKcSLuxmWxLK1oeRfBoLf
 rBOZsNfp3Ssumd8ZxWUPNnJ31crSzxkYcdn63/ixosroWg7L/BNgD5JG051MKg==
Message-ID: <d83d0112-fbd5-42fb-b392-b46e60bcb2fe@pengutronix.de>
Date: Tue, 13 Oct 2026 13:26:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Re: [PATCH] rsa: load a pkcs11 token key through OSSL_STORE in the
 provider path
To: Johannes Schneider <johannes.schneider@leica-geosystems.com>,
 U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: ekovsky@redhat.com, Bastian Krause <bst@pengutronix.de>
References: <20261011082714.1071089-1-johannes.schneider@leica-geosystems.com>
Content-Language: en-US
In-Reply-To: <20261011082714.1071089-1-johannes.schneider@leica-geosystems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Johannes,

please use the new list address:

<u-boot@lists.u-boot-project.org>

FWIW, the PKCS#11 provider additionally has optional support for
"extracting" private keys from PKCS#11 URIs by generating a PEM file
with an ASN.1 encoded PKCS#11 URI which can be used as input again to
the PKCS#11 provider.

We (or rather Bastian, Cc'd) have been using that approach, but direct
support in mkimage certainly makes for better user experience.

Cheers,
Ahmad

On 10/11/26 10:27, Johannes Schneider wrote:
> The OpenSSL Provider API support routes FIT signing-key loading through
> OSSL_STORE on OpenSSL >= 3 (USE_PKCS11_PROVIDER), but only for key files:
> rsa_pem_get_priv_key() fopen()s the path before OSSL_STORE_open(), so a pkcs11:
> token URI fails with -ENOENT. The legacy engine path that handled tokens is
> compiled out on OpenSSL >= 3, so FIT signing with a token key silently produces
> an unsigned FIT (a configuration signature node with no value or
> hashed-strings).
> 
> Load a pkcs11: key URI in the provider path directly through OSSL_STORE and the
> pkcs11 provider: skip the fopen, append ";type=private" if absent. The PIN
> travels in the URI (pin-value=); MKIMAGE_SIGN_PIN is unaffected.
> 
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Johannes Schneider <johannes.schneider@leica-geosystems.com>
> ---
> Follow-up to Eddie Kovsky's "rsa: Add support for OpenSSL Provider API"
> (https://lore.kernel.org/u-boot/20260429180247.83091-1-ekovsky@redhat.com).
> 
> How we use it: our build signs production FIT images with an RSA key kept on a
> PKCS#11 token, so the private key never lands on the build host or in CI
> artifacts. mkimage gets the key as a "pkcs11:...;type=private" URI; the
> provider path today handles file keys only, so with the engine gone on
> OpenSSL >= 3 a token-backed FIT silently comes out unsigned -- this closes that
> gap.
> 
> --- a/lib/rsa/rsa-sign.c
> +++ b/lib/rsa/rsa-sign.c
> @@ -237,6 +237,49 @@
>  		return -EINVAL;
>  
>  	*evpp = NULL;
> +
> +#ifdef USE_PKCS11_PROVIDER
> +	/* A pkcs11: token URI is not a file: load it via OSSL_STORE + the pkcs11 provider instead of fopen (PIN in the URI, pin-value=). */
> +	if (keydir && !strncmp(keydir, "pkcs11:", 7)) {
> +		char uri[1200];
> +		OSSL_STORE_CTX *p11_store;
> +		EVP_PKEY *p11_key = NULL;
> +
> +		if (strstr(keydir, "type="))
> +			snprintf(uri, sizeof(uri), "%s", keydir);
> +		else
> +			snprintf(uri, sizeof(uri), "%s;type=private", keydir);
> +
> +		if (!OSSL_PROVIDER_try_load(NULL, "default", true))
> +			ERR(1, "OSSL_PROVIDER_try_load(default)");
> +		if (!OSSL_PROVIDER_try_load(NULL, "pkcs11", true))
> +			ERR(1, "OSSL_PROVIDER_try_load(pkcs11)");
> +
> +		p11_store = OSSL_STORE_open(uri, NULL, NULL, NULL, NULL);
> +		ERR(!p11_store, "OSSL_STORE_open(%s)", uri);
> +		while (!OSSL_STORE_eof(p11_store)) {
> +			OSSL_STORE_INFO *info = OSSL_STORE_load(p11_store);
> +
> +			if (!info) {
> +				if (OSSL_STORE_error(p11_store))
> +					break;
> +				continue;
> +			}
> +			if (OSSL_STORE_INFO_get_type(info) == OSSL_STORE_INFO_PKEY)
> +				p11_key = OSSL_STORE_INFO_get1_PKEY(info);
> +			OSSL_STORE_INFO_free(info);
> +			if (p11_key)
> +				break;
> +		}
> +		OSSL_STORE_close(p11_store);
> +		if (!p11_key) {
> +			fprintf(stderr, "No private key found at '%s'\n", uri);
> +			return -EPROTO;
> +		}
> +		*evpp = p11_key;
> +		return 0;
> +	}
> +#endif
>  	if (keydir && name)
>  		snprintf(path, sizeof(path), "%s/%s.key", keydir, name);
>  	else if (keyfile)


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
