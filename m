Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B9D606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 14:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=P4VWPNi1;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=uJR9ePn5
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0894340967;
	Fri, 23 Oct 2026 14:23:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RPZjP061HPkM; Fri, 23 Oct 2026 14:23:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 26D98408E4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792765420;
	b=HXtfsWh6yEiIo3nVkBdNZPsvI/seUaXJ7YNzGwsavR334NoGaMeVO5uXYw/lE/GKR5AC
	 Mdb5sehEKaz7L7qmvfqKlEMvSbFLM5fdOP3Alno28JmQsM3QQGP+s5C6chS+rE7hkRgQ2
	 bt96L/Lg/DQqRsqZXCn5QcNIaE8BdaeuhzxXSYOJYVjXN+var+FhUZ1R1BkIu1eBeSoWb
	 T23Uq1AplOIeIEZyKmNZMJDWAZq40EPJoRxL35JKDhZFwgJOGaiFq33guBkkd32wL9MGO
	 qrymW5wUbvjaw3/+uhRKTdlU4NNFpqQ3tFkHoqhfpI6jMlEptyCd9S0W9lJ5w6HTq5g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792765420;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=E8FavnSFUq4wVflF3iETJZHwSDyxk0gWzXcf+wwMbjM=;
	b=kkMs9j1qj2eGKtmZ5qBue9/36GjZTPO2NTSrkiGQ1zTdFHsouQUnuEfihRskjZAuC4eS
	 A/RTBNK+gOZn41aTFJ3uZ60QO5aWzRquJq5hMK2ag7PEzDSULEvNdIIkYTDlcuNTJMuTe
	 REIVF4M9a0ulwRE4w3x0lbrfRdMNDWGAPOzAjWB7EO2zs1HEReJdQ9uFZuVKWc6UILfQo
	 MsO7OVQ0S2j8VgBNX8HN0P41ueb3kt+Pk+CVIHM8klnsiIq5YYSVzVw6QD6j291ENf8IA
	 Iu73CqdhlxGVwOxSrJcf1QVNMEp2Wqnk1ivHLj3J+piyRtMqhxIGYneXtjI8HTXIUMQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792765420;
	bh=E8FavnSFUq4wVflF3iETJZHwSDyxk0gWzXcf+wwMbjM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P4VWPNi1j2GnGAFE205MMSdBg1HMeZgRPRfA+bUjPFew1FGk3AApQLyq69Glg0Y8r
	 yrjeTU6LIi0NUX4qqa38DBKgoyrKAKpjW7rS0+aoXLK2N186Jz4pV56Wltdd8I2jWS
	 tRzebD5dx7rV2FXQS9n46q0Es+Q5qpbc4UDWL24Ibko3YIBKv3lcpw6es6F+FWgrP+
	 xYy87KZCXJxnnGNeDbOI5Urx+1dKczzu5TmRicO3QSk8XIHvpwN047d806UgkreC4a
	 SjO/ps4Czg33rrufERFeUamgfgTCmGe2v602kgUkAmSXSRZBe5IJlDnTnQlKXXhn+B
	 uk9Lc8XQgoOFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 26D98408E4;
	Fri, 23 Oct 2026 14:23:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 57D473C1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 14:23:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3DE1F401CE
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 14:23:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wWNT7UWn1V-4 for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 14:23:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E282B400D0
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::103"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792765418;
 b=ViBeDddt63L3noFnEd3lugfXen8W/LdXgFFGmRJo5l2hi6h/QV18J2N2zInK7BrFigj/
 zildR52iOGTJgaB5N3V+FRPCKoM296Z8SH7vG3papUZdywd+fN88Nf6b2ZB53t+C3mkpg
 wtgyRiO2fW/B3Z1q7kpeJOe7cU7dJtQxjJZ6ukrdEhDvYbpi4Obt6NsgxYDdDbbJzYedC
 VSrILo2SwyRsHu3HQvmEGrX19RSSGPvn3Vx6OcO2cdc5fNRkD0xFw2V8/Z1nLrP+UFl69
 7foSiEjl8YYPAN4WxKzylbvPmnxe3ZVOEKylqtQLwHySsbUh5cBLnWvL/JZR2vuE+eg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792765418;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=E8FavnSFUq4wVflF3iETJZHwSDyxk0gWzXcf+wwMbjM=;
 b=fZmDFG2G9THuQsNEXnRmGFmi0VpM57FPqSGXhPQS3FVYxueTMbD53ri5IJ8MTE+7BQ00
 ujIHKKgHsgNDIC1OyGcbgT/AK7NmDfD2AO5oB5qPNiiXX+HfTd9osuR71HbJN794rgXbO
 OogSC1qVdauhZ0jmCCJgcoM9kfGSH9Te3reCCGmCia0Y3HseFFwkeDcryCMwxXOCGxITn
 ksxdxzH1LJ6/ZGbRrzf4ae5CFTcLlzuKI6F1DpR7yQhhNQLUiRISaQ7bGWCYZhf0cw03v
 psWCH4ViQZeBbFe0VacrwBduutnAIbuLmJq+n2df2ugbqm3T+wmKEp8rv9hL/+g3ybg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=uJR9ePn5; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::103"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::103; helo=mout-p-103.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=uJR9ePn5
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E282B400D0
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 14:23:37 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jB4xy3HmfzKnRq;
 Fri, 23 Oct 2026 16:23:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1792765414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E8FavnSFUq4wVflF3iETJZHwSDyxk0gWzXcf+wwMbjM=;
 b=uJR9ePn5jKqVseGmymsKQj3n52t4tKzX35x3SMrH78B70Zy/d/AuycoATgrZqfgArDVD1g
 XSUBRYtlvCLSLp64RzPzkBSjWQ1Xkjizq8Qwniws5NNCN8hiS3Kgfn14DyIeaFrNrKDbVs
 FJcQYe1BgbsFqPzGcsESwG7x1G1P4OqBbyQgPkt0bYIl1BJ8RgD88LB2JTXX1/t4c0lBuk
 2UD0rqZJCxK3Dnr8ex94GRFw3SEryQjQPhudvnA3KOYUN4H+08QUQGtn0U8doSX0K0I89l
 k1jZ+A8PO+Df3l82QDWpJVta//6X89SaWgP8Jk6Kj9nSzdUqjeCfAkFOwH+LIA==
Message-ID: <a89862f4-45bb-4a74-88d8-6a556a15bee9@mailbox.org>
Date: Fri, 23 Oct 2026 16:23:32 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 7/9] usb: ehci-vf: take the register bases from the
 device tree
To: Mehmet Fide <mehmet.fide@gmail.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>,
 Krzysztof Kozlowski <krzk@kernel.org>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
References: <20261023111559.4081795-1-mehmet.fide@gmail.com>
 <20261023111559.4081795-8-mehmet.fide@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261023111559.4081795-8-mehmet.fide@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: wpg8m7utsu5uksbdqjsk6dnw5a4r3bxc
X-MBO-RS-ID: 33415741a3757969bf7
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/23/26 1:15 PM, Mehmet Fide wrote:

[...]

> +	ret = ofnode_parse_phandle_with_args(phy.node, "clocks", "#clock-cells",
> +					     0, 0, &clk);
> +	if (ret)
> +		return ret;
> +
> +	switch (clk.args[0]) {
> +	case VF610_CLK_USBPHY0:
> +		priv->portnr = 0;
> +		break;
> +	case VF610_CLK_USBPHY1:
> +		priv->portnr = 1;
> +		break;
> +	default:
> +		return -EINVAL;
>   	}

This is admittedly a bit icky, please at least add a code comment. But I 
think this will get removed in some follow up series ?
