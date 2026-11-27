Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E34C606A31E
	for <u-boot@archiver.kernel.org>; Sat, 28 Nov 2026 00:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LsPU44C4;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=CkSd7Z1A
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0BB54608A2;
	Sat, 28 Nov 2026 00:03:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9y5a-BH5s3ar; Sat, 28 Nov 2026 00:03:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9D59560666
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795824230;
	b=Zq3TNun34XrGvuJaFR34b8hRa3SQeGQF/bDBxe1FtwaRRPT2iJnxF8OGNYRtTPBNrSVg
	 UB32sgYCw2wr2J27o3Xtrw014kg0aG8cyX2HTwiaAc8O87IdVHeNujkvuoSskBUhPQiWe
	 kGQ2JNXMbl2Dqkgn+tA+6FLKoZ5IZliD+O2l24ptabIMKy5TcB7PswJKYkrhRddqkXvyT
	 vtQAE2WEZr8tsnI3fjQ0O0H6ANq1xvP4ZwR82HN+GoJH/dunydCmwrWG2yO8INANvlFOg
	 jGKP1ClYRzz7g0gHyLZdGXkh0Sku7vLnUrOajGLk/+sgIk53BNwT5uGpfZVMkW/HrTQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795824230;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=MUq6otuTN0MLdc+cn1f93o94Co5vrZ26QcN6oaHSRmU=;
	b=Cmcfq6iupXxNFX7+kYcHvcli0Qm7rpAiSuBG3xTxVRL4nZgjYYEJX+XjgbociCwznIIR
	 Qm9uM4kHnRupgENifpwUipfk/9rQFD/hiuv+9adAfJ2sx+6WCRUc5+Cd9EkFn2UigD3NP
	 rmQyjN7YJJsxUVD0gTafQvvDREKHKXDQQx6FmymDDAMdBlAAOf8WWn/vsYaQ75oxAxgLZ
	 QhLjuXQ8sZ7LBvcwa8rdbKLuz7TnEmHaVeOU981OhZJMi4vriI1XLHIHBRuUAp4AClYp/
	 66Qh88JUWkfTepYx9y4TcKPRXphPrc+/xCK0UzLhTKICRfzMtdH4QWXLY07TVL8kp1g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795824230;
	bh=MUq6otuTN0MLdc+cn1f93o94Co5vrZ26QcN6oaHSRmU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LsPU44C4IVI4pyxUDhNaXxBU3Az+p3cC7DDpW6AjN9BoJOn/YtQca+7oj9wCpaLFl
	 L4ne6pUjn7wblBM7V3C43vFAWGwTO+O8tQLLbmyy3sp+dJBmuKXh82SvyxKRzSK97Z
	 uGje3vZPLP9KlzM+ZM8dMyvBFf3mLivHHkYUDXtefEobCu2Jj7oa7wPMvHkbT7+MGL
	 9i0nAB6rhAVGxIVS4UQqkBM3tJpfYPkrihS1/fiM1jxrmz8NWzPahabIhcO7HkhSr8
	 XJ+Y1EAOMz+f/ap+ZEdcXkQfUCiDyLh0WJ0hP5kX1Mk1xZwipI+W4Plu7K8zix33o2
	 IifbKxinjxumw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9D59560666;
	Sat, 28 Nov 2026 00:03:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C3C55472
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 00:03:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A9D3681158
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 00:03:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xjF6plWuJ4OS for <u-boot@lists.u-boot-project.org>;
 Sat, 28 Nov 2026 00:03:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8D69A8108F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=CkSd7Z1A
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8D69A8108F
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 00:03:46 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jbr9C3DP6zMm0j;
 Sat, 28 Nov 2026 01:03:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1795824223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MUq6otuTN0MLdc+cn1f93o94Co5vrZ26QcN6oaHSRmU=;
 b=CkSd7Z1A1ZeDVyeIqoD7FXSaD14mxSK6kYJLX8uMSmam2U4xCyn33sOrExD58+4cLzOvue
 x/rUnd0UU+cFYZG0QpiIoVtYxCZNM70cEjMiTVnjFCk3BHnX4IoWVMOU3+MkrlFbVPQjRN
 lv6DdISpK5nhy6gAbzRbCi9m5sD1UP+geq5pMsITit+TjfI1Oo+rsDBv1BfGIGpgeg4Itv
 j2OBum7P8REy7iuOPoiDIPlrVX+2GS5O9jnxgWz9nS4iLFO+LGl4Avp2KWQGDvtfi5szM5
 WxIiZQi12q7NrXKFSv3MAP1p3lFYlsfPIkES3tdYN6vPr5tA+UdreXvApO7KIg==
Message-ID: <5bfa7417-ead1-4d3c-a0ec-0e5126b9f1f4@mailbox.org>
Date: Fri, 27 Nov 2026 22:42:59 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] usb: ehci-vf: enable the PHY clock through the clock
 driver
To: Mehmet Fide <mehmet.fide@gmail.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Fabio Estevam <festevam@gmail.com>
Cc: Lukasz Majewski <lukma@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, mehmet.fide@screeningeagle.com
References: <20261127182905.2836449-1-mehmet.fide@gmail.com>
 <20261127182905.2836449-6-mehmet.fide@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261127182905.2836449-6-mehmet.fide@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ti5n1ume84s659dqguw5yyu1rrn5tfzo
X-MBO-RS-ID: d0a7529d6b8962c2cb6
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/27/26 7:29 PM, Mehmet Fide wrote:

[...]

> @@ -159,16 +134,11 @@ static int vf_parse_dt_addrs(struct udevice *dev)
>   	if (ret)
>   		return ret;
>   
> -	anatop_node = ofnode_parse_phandle(phy.node, "fsl,anatop", 0);
> -	if (!ofnode_valid(anatop_node))
> -		return -EINVAL;
> -
> -	ret = ofnode_parse_phandle_with_args(phy.node, "clocks", "#clock-cells",
> -					     0, 0, &clk);
> +	ret = clk_get_by_index_nodev(phy.node, 0, &priv->phy_clk);
Can we avoid the _nodev function here ?
