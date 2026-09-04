Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F4A2C624DB
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 02:44:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2371860BC4;
	Fri,  4 Sep 2026 02:44:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PWhpR566-Jpy; Fri,  4 Sep 2026 02:44:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org DDC4460B43
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788489847;
	b=pm2FRmw+F51thEWs/LDY+Lh3YMRVUtc+A2Wv6RITlYA2fd43RuCG+0FfRfGAIorEs9ui
	 pLWRBIamthdZxKDehSBbphoeLwc0LuqBw0nAl8Y7QSLlXZlu9ERcUGa2NOTHJ5CIJNIv1
	 rNf4Da+waBqFzk++6vbHcsbCEevk9CLvYkVmOv8oeyf+fbiXRkT/4eJ0tr9vFt8iUmsSf
	 XvwwNhnxIoobI1AEcICEK/6eopex/D7cpxycnOBKutLSqlEFMxZoQsDiTLGKW+luGQ2nV
	 3mpBI9XR9icKaylyCOaUn2BwZbstaTVPVUILKzkfmmr2h/0OK9FaA1HZoTU+NVuRyoA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788489847;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TrCcj7FsxgB6TDlatCGRkEVEB1mxwDP3q+1f9A+tp40=;
	b=nEVWDYYSdVqLABwNABr+hKRldX9b7BcCSbzpwY0mGqMgl2B2BQkpNtfVo0UmrdgxP3qs
	 5SyxemhRyQi/TqVhWZmEwpeMcZRyx1qtmO0UG+1Uv+kQSQxMj1C6wXpOXd/vlWNzZeWeN
	 0InNA+s7e8zKrS48hEunNI50brjA9J6RwKJ4B5Mb0Qsx+AIYFRRDe+4CNOAv2GI64/g/o
	 9MbQTw05Pc94W2vaIUtLKUVTnsePdAG9/rCE7BNa8RzZmgCwYuqJjrPwGia5xJUBjPPR5
	 YuUGzzek2qVn9en1IMzEvCHxV8ytEyGM8Lyll1y/OBrSlviLjf74R5AGyfYmH2puB3Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788489847;
	bh=TrCcj7FsxgB6TDlatCGRkEVEB1mxwDP3q+1f9A+tp40=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MROxje3tw2X8B0ClF97LagcvZg0/6CkJWuBD1BUe/UPY6XSSAPL69O5fnLjdhSYmL
	 GS5y4RfS1uNVCe95sQZrRogolnEDfqTjs/k2UrdntpOi0w9kryTAWhhnbBCZ7Qlz0o
	 k9PgY4tL2LELbuNntWB7GaAkhGYq3uNEJYlaxyZZ643djt4/OEp5uSo4SE4oluqk7f
	 LCx4RyFVE0osh4qL2YHHt1klBuNdpy03pHpAEyRZJY+WJjw8j8DMAkuT2MVXA3sUnG
	 wVfVPTUwL1EXchPADqzMVfge7aKxX59yIt4/gwuKRQIftG+N9q1hVGqL+/kuFr/Xvq
	 mj83dOlcn314Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DDC4460B43;
	Fri,  4 Sep 2026 02:44:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B2D32FD
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 02:44:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1D0D480EEF
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 02:44:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9ii8SgxUtcMb for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 02:44:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8357880EC7
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788489844;
 b=Yb8/vW0Ys0k6NasJYzF9SXBQEdrZUxH2q9ZzpxfLmCi8B+V/3T7+zY5wwTMfxLSPBZtT
 bUH51wBqAWqoJvTvTNVDWzNaKZl3a7eYRUgUbjUOeSb8YX/NxbfNxZ53VLS6ioETO4Mjz
 2clPG+NmjIjmuIMxXNc6gjzjxrStqWaf6iH2vpjfmBWn9U37KqgWryPSDQwTV4bOKN2+7
 7XNum/88btPmzaI5fZeIQl0XZ8Rl9PQAlWvCUgUa9wIJLwVm364Q3A4ICrfQGliWBUJ74
 7naq+E81mWVihzzGGWwG3mILKx/XINahhzEIFSKGST1DCTmJfrMGw64H+l4RBgE9+HQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788489844;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=TrCcj7FsxgB6TDlatCGRkEVEB1mxwDP3q+1f9A+tp40=;
 b=BuQUBYgldPdTiu12FVotLMQ3llLzifszJwazTjpzQmomMoz3zc5Hqx3oiyUYQYupuQPF
 EVCOrgpctmoreDTZ+nOQYbgZ96B9AFhj2V7vResEPWAr9VQDzfdv89jn0lJeLP+O2crv3
 R2eQ7CGJ13DaaNsFHngIibXq7mw0Ho4oaiIohulqFYqBFkIw9yPfy2z3pDyB9taOJtyWD
 wqKQ1ReUSzvVwusnX5v4zSgSqTlYEz0n7Om44qJ0YUxnNnouzAR/rRqcEMF+dECqKfdoq
 gXcOhKPf4cjI60NPHVGoECTKeXNtba4ipzGEivRNBtnu5JjkXXwRzxiGqVaEJEM0+UQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=g5J3Ulv7; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=g5J3Ulv7
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8357880EC7
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 02:44:03 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hbglM4k8HzMlKC;
 Fri, 04 Sep 2026 04:43:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1788489839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TrCcj7FsxgB6TDlatCGRkEVEB1mxwDP3q+1f9A+tp40=;
 b=g5J3Ulv7b+EjRDhSqfVX7fGzSUFp/LqIjAHc2IhrPOj9bd7ysaKp3/ycFADFythBB0aBOa
 BBRZQ8uEBy0NffZpdNDWDIuWIBeS2RY6obYgoFUe3RIkeehnMpcVfMHprKJaEUmHbkKBlq
 9Ptuqg9TcSOXvKW5XicOlHlF2LkIXQaXjHISPKS66lxA+nadDGQqhJg6SQHvjAU0LwyEw3
 MN/MzHAxgiFj2Eri9pDGYXdS5k2FxX5uLa737Pjf9AYGIGrB9zMBH0+06dJi5aEie3dnkY
 X9cECXsp8/AzWop6ZzrQ1yGAwH0/o9ElH0ScGmGyu1iw5up6BSDjRGJaUZuafg==
Message-ID: <8d741110-05eb-4861-94b9-19ef27c9ce2b@mailbox.org>
Date: Fri, 4 Sep 2026 04:43:56 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/2] usb: gadget: mass_storage: add SuperSpeed
 descriptor support
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Tejas Narendra Joglekar <Tejas.Joglekar@synopsys.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Tom Rini
 <trini@konsulko.com>, =?UTF-8?Q?=C5=81ukasz_Majewski?= <lukma@nabladev.com>,
 Dan Tran <Dan.Tran1@synopsys.com>
References: <cover.1788488867.git.Thinh.Nguyen@synopsys.com>
 <0103125b2e7e1a942202eea2c7222ab00d6857ff.1788488867.git.Thinh.Nguyen@synopsys.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <0103125b2e7e1a942202eea2c7222ab00d6857ff.1788488867.git.Thinh.Nguyen@synopsys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 9qm3m4a8367689xbn45e5hoxxsigazrs
X-MBO-RS-ID: 34ed2579298f2f237d1
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

On 9/4/26 4:29 AM, Thinh Nguyen wrote:

Hello Thinh,

> @@ -2709,6 +2712,27 @@ static int fsg_bind(struct usb_configuration *c, struct usb_function *f)
>   			return -ENOMEM;
>   		}
>   	}
> +
> +	if (gadget_is_superspeed(gadget)) {

Nitpick -- you could invert the conditional here and reduce indent:

if (!gadget_is_superspeed(gadget))
	return 0;

...

> +		unsigned int max_burst;
> +
> +		/* Calculate bMaxBurst, we know packet size is 1024 */
> +		max_burst = min_t(unsigned int, FSG_BUFLEN / 1024, 15);
> +
> +		fsg_ss_bulk_in_desc.bEndpointAddress =
> +			fsg_fs_bulk_in_desc.bEndpointAddress;
> +		fsg_ss_bulk_in_comp_desc.bMaxBurst = max_burst;
> +		fsg_ss_bulk_out_desc.bEndpointAddress =
> +			fsg_fs_bulk_out_desc.bEndpointAddress;
> +		fsg_ss_bulk_out_comp_desc.bMaxBurst = max_burst;
> +		f->ss_descriptors = usb_copy_descriptors(fsg_ss_function);
> +		if (unlikely(!f->ss_descriptors)) {
> +			free(f->hs_descriptors);
> +			free(f->descriptors);
> +			return -ENOMEM;
> +		}
> +	}
> +
>   	return 0;

The series looks good to me otherwise, I'd like to give Mattijs a chance 
to look at it and pick it.

Thank you !
