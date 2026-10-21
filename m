Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D72606A326
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 02:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QZgVLjZb;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=YjCo81TZ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 018EC607E7;
	Wed, 21 Oct 2026 02:21:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VmUSR3u2v4TX; Wed, 21 Oct 2026 02:21:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 456AC60763
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792549311;
	b=cS9qsDrGFC4MSGzGrFT1lv8PFQKpHCnE5wYVMRukGxCckEeTXQ+wm84Kx5IKbZgpfcHa
	 A2GOn2bDMBkZPXIl27OI/1+I28oYzD+N8NFnTq8qloVAoLIg2ezK6K5o53WOuy4E6lsq6
	 sz9K2iyzT9bzYth63YOGsWkjRaemepGI5p38o9/v31p4mB/ZRFMCxgz7FumxMGgg+PAkn
	 HMeOMfM1NXLYjCjuQuD7TQ6IMli5UAFyTIsT2MopKHeSrf2YaitQDSItgTHjTeFzhbvrn
	 2ds0gXmji+Nq9gJvW8uLruWJ4mSxyNalYYQ8sbJc9DZmdVKcLncJeX5f3WBEsd7VeWA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792549311;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2FJR9zcOJUpCrRTlWK6VYTbFAqHHRvRGxmmgXjQ/ZsE=;
	b=eQCQXUmuoAOILhv8c5N4upea1O5LeelFx2Nbb7VvaOdtGKjrrwwSMAV9YVWdkhONj+96
	 X2cZRjA/qdb9Yu7669qJxV2mgNuR/gm/hfqmQpV+XAC+nJnlY+hgOKBYtnT6YSBa+c6sf
	 NXpI4Sq15H2pTFAS/Jfm/8V+k0/+sexWt0JQV3Y8MwJI4DM1n8sm1IwiRlDP6eZJ2kx++
	 NJ7FuN/7fw2O1QGPXdAPkdkRMR0syiSuZLs1k8HhPWDkJVH3P4w35TqXteBldtICrBLpz
	 hmBGLKBCuMalWnbGoAJHSWLARM5HBrHL37hg0casLa85JSNOhZNlRUd0/xr/v8cpruA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792549311;
	bh=2FJR9zcOJUpCrRTlWK6VYTbFAqHHRvRGxmmgXjQ/ZsE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QZgVLjZbHE0zuGmUVC3M+/kGpKXmrdZIs1FJrCaQ+8IzruIw8cIJFZhpaUy4sq+WQ
	 J39/b8Rm9oVKIhvpdwrsTf9PfMkQD92Xj7YWxwuko/2JUt/bLUOG2knLP0khiqqePn
	 PuXmPr2zIEVU6QRSiEOI5IwK/j9R6kG5A8UVOloGFtjXiOZhkvu1o3/ID4ell+vQl/
	 KrdXoaom+hsyBBXwPkSz00WHj866lNMMaTVcnojTf2cyYpHPgq7DEyND61pJMjkzWZ
	 W5HPYW8rvyGzjKicJN5y6meNiBIV8nBiGEt/7Y0LUJDtAUT04qJH5zaptYs6QCj1p6
	 hS1hvF0LfhZmw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 456AC60763;
	Wed, 21 Oct 2026 02:21:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 52E79995
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:21:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 397C481086
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:21:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B0SFrWIplHsU for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 02:21:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4A2F580F90
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=80.241.56.171
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792549308;
 b=jkc0uRbg3/NTE596f0s3/Sw64fcyc4BB//YWypDFY5OpVFdRMIlCWvXmK3fBIXavHy1I
 1HVTWtTjylqbm5r0I4obYTXpSrQj0cMCK6xYHHktqBbeee2brARdPSA/bS1ofcIC2A3Kb
 Ih808t4CxgrDoZNiaGHog2q2HxkhOGaN/bd/zfs/xG9uQMBptqDZgonL6x/ZN6rM1VkAQ
 2V86Ae2nsYTFjW1GGgcOwK/1OheiyOtQS8KeWSwPqkrnEvz8y4QipVCqHh5gp6v9BSar0
 OPkqEjT6DxRGIW+7w2rA9D4nYLHD1Me47xEXspY2RzJ2Ub+QIMgNevZvTDXMHvh+vXA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792549308;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
 bh=2FJR9zcOJUpCrRTlWK6VYTbFAqHHRvRGxmmgXjQ/ZsE=;
 b=Z8ZYFEiDiHBERjcHZ5xbawMYbXiGkCti3z9LwprXyDuL5EqtjlG8cyUKSNEB3WG3Ts3D
 2zX2AHwNuZqZ6tpWJB7PRRBluG2kkDuoHf4PSlefYSqfhXDSuH22OKYW7mACO7m5LbZJL
 2wfLlpu7w8geawC1olmJUV/DgymJ80GP0pgegSZBcze0g9NyIGaA1Hmoq5T5OHe4yf5v+
 bH1QVDet55DhaS77bnBV/U+4Up4IKmceZdalMrIRFcMoAEumRv4ML5scMsgeU2x6nzCXu
 c9FVOmU5gWdaf61XB5gGJykIuY4xumm+kZSYiDxdexQgNsiR0iGm2bKfVGbZfKuY1Yg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=YjCo81TZ; 
 arc=none smtp.remote-ip=80.241.56.171
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.171;
 helo=mout-p-201.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=YjCo81TZ
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4A2F580F90
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:21:47 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4j8Y202w6xzMl2k;
 Wed, 21 Oct 2026 04:21:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1792549304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2FJR9zcOJUpCrRTlWK6VYTbFAqHHRvRGxmmgXjQ/ZsE=;
 b=YjCo81TZY3PuRjwWhmN82R1o1HGHPsKcO+c3FijVPUX9oU62tkWBPx+uBEy9k92aYOSgZF
 VenwXHbeVjWRB/Yaonap17HQS0X+NO9bWdwQU8ZydGLc1mQVzP8mAUiKcHC3qXmInp+pQe
 7AAiDecnFvAGr3nVbhbfvzrTZvZMmaLxOI/ZtNCmci3FU5TMQwHsSdfZ0KhQEKmUz6Gmsj
 PliSCaAU5r0BUEun8dsuQgsduFMVWoAa30BgcpRCV1nOSrLO8FOPYr0qFmG7Y0AAoetb9V
 7k9Mqapo2cUyDbcehqT07JGDWXL4vuB6+poCU6spYNrgeDJpLPLhHB52NjnyIw==
Message-ID: <e26932ad-c808-44ee-b5d3-c3f159acffe6@mailbox.org>
Date: Wed, 21 Oct 2026 02:09:18 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 6/9] usb: ehci-vf: use usb_get_dr_mode()
To: Mehmet Fide <mehmet.fide@gmail.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
References: <20261020101608.2818265-1-mehmet.fide@gmail.com>
 <20261020101608.2818265-7-mehmet.fide@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261020101608.2818265-7-mehmet.fide@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 33dbc6cfe01c9c3a634
X-MBO-RS-META: ba3mu67w1na59nqppibfmuxwjed9wufe
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/26 12:16 PM, Mehmet Fide wrote:

[...]

> @@ -192,16 +182,16 @@ static int vf_usb_of_to_plat(struct udevice *dev)
>   	priv->portnr = i;
>   
>   	priv->ehci = dev_read_addr_ptr(dev);
> -	mode = fdt_getprop(dt_blob, node, "dr_mode", NULL);
> -	if (mode) {
> -		if (0 == strcmp(mode, "host")) {
> -			priv->dr_mode = DR_MODE_HOST;
> +	if (ofnode_read_string(dev_ofnode(dev), "dr_mode")) {
> +		priv->dr_mode = usb_get_dr_mode(dev_ofnode(dev));

usb_get_dr_mode(dev_ofnode(dev))

> +		switch (priv->dr_mode) {
> +		case USB_DR_MODE_HOST:
>   			priv->init_type = USB_INIT_HOST;
> -		} else if (0 == strcmp(mode, "peripheral")) {
> -			priv->dr_mode = DR_MODE_DEVICE;
> +			break;
> +		case USB_DR_MODE_PERIPHERAL:
[...]
