Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639FE606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 04:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iV/7h5lh;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=U5FCum7o
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E8AFA4065C;
	Mon,  9 Nov 2026 04:39:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mZUB14QstrI3; Mon,  9 Nov 2026 04:39:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2E00F4064C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794199172;
	b=d8bxeA84JR0tOMfXhmejdwolOPJfpqn9TMrDa4i2xbq5B/GgcGB4Kc1bQM6kMD6SLo1o
	 QsGZd/v8IajiEtaxtNKVtvhFdE+LQHmUtCL0xaT2R2+IDKFyyBsIJN+bYtfARuogSctot
	 BroNSijVfmLR9TEyr0zplP+nBvzUB2/+2hGJ5MIXYtMYJtLmGoA3rbvp2kAOHuP0wZ9c5
	 mOyc9H3o47eeiApaKjsXJ5XiHVsOQjSg3xQZV9WkuSyo4ptbMA2TA6yBWJx8xTWKw4tvs
	 UF49X3wD/eOU4Zqew0eoSX4dPBAtow0usref1K0M773Z4f6UC6NdXnrGPyGSVDslluQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794199172;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pVutQOLikyCUYyQZj5mnavUmohFM8R6/Y4tW9NhwHPQ=;
	b=NqOtJ437mqsVaoObSQ36AXUw6XQIrfpgDYvYcUEylt5Q7ulxuI3e55AoZXg7FYDN75Mm
	 SPywyWrcftNFYAcMdHabBlR5tn2SOT8QD2c89CCycUNpJ5ZJUtOnTc9C72sMmgVfNxVXc
	 ElGL9WCEG1BrWj/MLBi6HO7vtYl4/QXVXJM9xbu+5EVDjZjpTjyo19kWtKjgSzIlVPySA
	 gwPG6cs8LHKREiGKQyjDmiXDwLUhfIcv3VSf0cUCw5ASwXbIwla66VtfRHURdh+y6NNAr
	 2G+3sQ1O6lxNQeyJG3LQtwJ7A7kRDMUgtulpMrBT5IfnrWwnDukt0xXyDyL/ue4avhg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794199172;
	bh=pVutQOLikyCUYyQZj5mnavUmohFM8R6/Y4tW9NhwHPQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iV/7h5lhUsU6mHYDVR/9uBsJB7fbNOr41bqa2UJPIRAboNh8NkTZGB5ViMHn99wP4
	 W7j38rU/MYmtSjJWLGlEIOaI5vVuQWeQZKDu4JtQjdrsLI3gUJzIv4O/GNJr8+z9dH
	 b05dQ6iP2TPQNzyJCFGb8P+/Ks+FVL3VmcdILXssVooFF5PH7/Ytvfg4Qb16x1xofn
	 iUao0+8CMaLjVcUEbrWCLvy/0MCCNyHp4AIW0G8pM2KC8B+GDI97Ub/OcCWukhp8JF
	 yTtHp+F1sWp0huzCkfyYwfP/EKwAlnITQTE9dCovaip4qEF2KuFIarZQkgzKY5Asoq
	 lx3qyIZ++zX8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2E00F4064C;
	Mon,  9 Nov 2026 04:39:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D51C61A6
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 04:39:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D241E80E5E
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 04:39:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DWNi1ZJe0-_p for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 04:39:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DEC5180E55
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=U5FCum7o
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DEC5180E55
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 04:39:29 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jNHB61FQ0zMlMf;
 Mon, 09 Nov 2026 05:39:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794199166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pVutQOLikyCUYyQZj5mnavUmohFM8R6/Y4tW9NhwHPQ=;
 b=U5FCum7oPXRadZllg3RBJEljMozB8kpvj4DU4KeX0Nms2poNpkS8FOKryN4djZze/xDlHF
 ERrvbRza50QQQjCgVvv9AFwwT4lJNfrh028IRvxaPzNsUn0X9dtYuUw2HhDcarZWm/Oi+Y
 Uby7yAKOD0SigTnAomVrsaBQ5NgsqHk8x5Zpe4JsTL+6iS8sfZJ7k/IINhVwqymR2Thng7
 AwMFSOnTDHyLIm8D7vscicqp7AfqyGjQGmN8dLh6hxbEHzoKRP4nWO/hy91wgI4rH6/9EV
 3FC0vcxGp1uVew47HewzI52th0FML5hTaeX44cQ8vTyMdXIquqrdU6QP+TSXlQ==
Message-ID: <8b25a735-979e-437d-944e-9711c00f2105@mailbox.org>
Date: Sun, 8 Nov 2026 17:24:03 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 02/30] dm: add helpers needed by the resynced DWC3 code
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org, michal.simek@amd.com,
 lukma@nabladev.com, alchark@flipper.net, jerome.forissier@arm.com,
 dlechner@baylibre.com, anshuld@ti.com, sjg@chromium.org,
 Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org, love.kumar@amd.com,
 quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
References: <20261107072224.3492260-1-anders.roxell@linaro.org>
 <20261107072224.3492260-3-anders.roxell@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261107072224.3492260-3-anders.roxell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: eb730a3f4d478b9c85c
X-MBO-RS-META: jwfgbqy1aby6ebpa5u1x9do6bi6f77kf
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/7/26 8:21 AM, Anders Roxell wrote:

[...]

> +static inline int dev_count_u32(const struct udevice *dev,
> +				const char *name)
> +{
> +	int size;
> +
> +	size = dev_read_size(dev, name);
> +	if (size < 0)
> +		return size;
> +
> +	return size / sizeof(u32);

What does this function do exactly ?

This does need kerneldoc documentation.

> +}
> +
> +/* Linux compatibility */
> +
> +#define device_property_count_u32 dev_count_u32
> +#define device_property_read_u32_array dev_read_u32_array
> +
> +static inline bool device_property_present(const struct udevice *dev,
> +					   const char *propname)
> +{
> +	return (dev_read_size(dev, propname) > 0);

Parenthesis () around the statement are not necessary.

> +}
> +
> +static inline int device_property_count_u8(const struct udevice *dev,
> +					   const char *propname)
> +{
> +	return dev_read_size(dev, propname);
> +}
> +
> +static inline int device_property_read_u8_array(const struct udevice *dev,
> +						const char *propname,
> +						u8 *out, size_t count)
> +{
> +	const u8 *ptr = dev_read_u8_array_ptr(dev, propname, count);
> +
> +	if (!ptr)
> +		return -EINVAL;
> +
> +	memcpy(out, ptr, count);
> +
> +	return 0;
> +}
> +
>   /**
>    * dev_for_each_subnode() - Helper function to iterate through subnodes
>    *
> diff --git a/include/reset.h b/include/reset.h
> index 58574b983f66..e8358beb6ece 100644
> --- a/include/reset.h
> +++ b/include/reset.h
> @@ -519,4 +519,20 @@ static inline bool reset_valid(struct reset_ctl *reset_ctl)
>   	return !!reset_ctl->dev;
>   }
>   
> +static inline int reset_control_assert(struct reset_ctl *rstc)
> +{
> +	if (!rstc)
> +		return 0;

These helpers are not DM, they are reset: helpers, separate patch please.

> +	return reset_assert(rstc);
> +}
> +
> +static inline int reset_control_deassert(struct reset_ctl *rstc)
> +{
> +	if (!rstc)
> +		return 0;

Should those helpers be checking for non-NULL rstc or should this be 
guaranteed by the caller ?

> +	return reset_deassert(rstc);
> +}
> +
>   #endif

[...]
