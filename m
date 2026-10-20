Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB094606A319
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 05:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bZBaMNxZ;
	dkim=pass (2048-bit key, unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=zWFh8Sd6
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6FD1C60802;
	Tue, 20 Oct 2026 05:31:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rf23WCesvdnM; Tue, 20 Oct 2026 05:31:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org ACC9F607FA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792474280;
	b=ZygJuw8jHADvO6ncj/qlpm86Rg0YLJEI1cQKgbT7fWWpkWc0c1LyPBP1HmSWQEFCwqXJ
	 JI1QEFgG+QKQ7ttAIiST5zvRb4V+BRZ+NYfkZ46gqP+rjBm7XinXKHx/NQo8QMib+AoPY
	 tRlZiDjT7ZUQBl5E6XZ6dQaBr58Psa41nUnygYR1HWUeS+Len6SeVImjwiuiaBDuNqf9w
	 bStIGTOd0x5d0HJopOhxEaVWvedLIi+PedK1YXM00XJe1dpOU7GjxSSWIx1MRy1nLVOI3
	 Meh6QCgXiJepYN+SRyf3f3tsqG/yu81CST6AfMAYWD/wkDjCPHExLEQmVulASkszN7A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792474280;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/lCUbliZuf1gLrOTXl2Ivqdifim3S0TL1d7x5KLQsBs=;
	b=oU3oUBdPExcJaI9lSNWLEDz+e7N0Iy4oQdPNY2mt+mnFS36aJvMijWesRIiYTz/wOCEL
	 897b65KK2AM/vaSsp8yoTWTOUGkysv3h0vfG1wCNbNhnKuLZlNgxy62KldygC0IjcyuZb
	 DF+fliOYkyRXuoyLgJCA0z5LM8GVMW5NX9VOZKnVeeL4K9RP0LFOfEnFdfjXbmcbv3SGG
	 +p9ZBhHAc3wtzdvk5mNO3ULjnQkaSWS2uDQMfh2AfJIbBr5t2hCeHdBtha9X4EjaiGlJR
	 QYkjTfs+47ibYGaZM9WEfQ1pk0tojG8OLCCHOjzEoqN7Dy7O8siWo4RjgEC7c1LOH6g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=dolcini.it;
	dkim=pass header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=zWFh8Sd6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792474280;
	bh=/lCUbliZuf1gLrOTXl2Ivqdifim3S0TL1d7x5KLQsBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bZBaMNxZreV8bBj7Uj6vIL8ZGyMXXjdTk3nnj+8Q2PqGj+QeHGVkloV4jGX7qhZR7
	 bOVeFiRLwerWAs9io64+rpx1vN2Pju9ZAba8GkoOwL65yX9hCvSRLcVD3Sdj403awt
	 MZT9EvHZk2+FsIuEaZg/dgoTst65h37beVK7qy/TgGPwqgCvW5DuyubFPrnu9eWrTe
	 mpjsHIUN0vDO7xF2je/FvqJoQfJ3IVneD+4FQ2aL3YcGi5ZOP/5Fsl1Ihp1K4IFIS2
	 LtiFyn4WwXa1B1JmuWS28WMTfchDrQgpZbTesvMCxpXVzhS9gZSrmDIk0D40eezynD
	 2rduXPfkjsUog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id ACC9F607FA;
	Tue, 20 Oct 2026 05:31:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5DD5423A
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 05:31:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4F7C3607FA
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 05:31:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wtQs41FSHvNU for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 05:31:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8893E607F6
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=217.194.8.81
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792474278;
 b=hZHIo9QGj79OEZ9YLjC6uBwJN1/dy7mhALqTpYpduQ3FMJ4FmMYlRb4vtXav+9Bv4uqo
 2A1GegIrZxAjdvKwMKsa9cMJtiygqpw5NypmV5ERS2LF7OrsN5jijK8h6OxnAR2MVW3rV
 AHt9UqUuAc6lUQ1F5D3YKjBVEJIFX6JZCjC71LBym68SWdfYBYPprcMS2EO0B1hln861y
 GbzRmm/4jJWUW3YSkp6rXKNiwEzwej8jXaq0mpiz6IlStyx5FA8HFlAdnD4tiL3AUKZI+
 y4WX3BvhP/ZnjCrgxJUYVt2Q6FIdT/GpbE6Qse1uSBRF1wUc3sEhSK6MxFvgxFycOyg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792474278;
 h=Received-SPF:Received:DKIM-Signature:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To;
 bh=/lCUbliZuf1gLrOTXl2Ivqdifim3S0TL1d7x5KLQsBs=;
 b=E+jTlj3LQ5gDtISLDbRqqDb6CAyFTNnxu2fRjq5YiGe/IP+riGvGZwfbBqmuIGuMjqMW
 JEh4J0eZsuimibqTt1SW5HizAa+FolzsNH13lHahIttQLgsYyValJTdo5crUAbc0vWVKP
 +wVKNnmkwqv0IWQXSTjRk8Z/HYJilP25yhwjVZDkUVJk6ZOPxC505CqQaM7CCnzMZCp+H
 Po2Ffy0V6IwH7NpjybgImfZ+497LRt1ioC3ee5hF1BguD+AM2Mwjqe6NvHOUSgK7854IX
 rx4o0T5FRhgw6Mq+BQhO9xbM0i4x/r7QpngEkPqIq49tY5KZGw90tHZ42HeknGFY4PQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=dolcini.it;
 dkim=pass header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256
 header.s=default header.b=zWFh8Sd6; 
 arc=none smtp.remote-ip=217.194.8.81
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.194.8.81;
 helo=mail11.truemail.it; envelope-from=francesco@dolcini.it;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256
 header.s=default header.b=zWFh8Sd6
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8893E607F6
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 05:31:14 +0000 (UTC)
Received: from francesco-nb (93-33-91-197.ip43.fastwebnet.it [93.33.91.197])
 by mail11.truemail.it (Postfix) with ESMTPA id 914BD206FB;
 Tue, 20 Oct 2026 07:31:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1792474271;
 bh=/lCUbliZuf1gLrOTXl2Ivqdifim3S0TL1d7x5KLQsBs=; h=From:To:Subject;
 b=zWFh8Sd6x2cHoGG6PDdDe42P8ssnQRLd4ppnxfZ2Yfqfk6awbDUMeyzHXwpD/Rky9
 F5x574rAuGF8m7X8/m63Czs5/vJqdRgtc99R+DRqwah2Haole9dFzKGHpjKtL9WJv5
 /2IjWWumN50Bfgo9Us7YzdqTmn2VeaKfCbp+01S3tfMS9/mnLWK9wVJ/ietI+rnrtg
 AbnukySLIVVGB2bFnMGLTV82ExKr4JFTqWK3ceNRS3pTV14d4bQKfqni2AxM43LOU0
 QTDtYAkheJr7Q5Jr9JmlROpnJ1ZdfuZRuVjObokRd7yK0StDPZK57bk4Casza9G7ZT
 u9nccXcoVfWLg==
Date: Tue, 20 Oct 2026 07:31:06 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org, sbabic@nabladev.com,
 festevam@gmail.com, uboot-imx@nxp.com,
 stefan.eichenberger@toradex.com, francesco.dolcini@toradex.com,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v1 1/2] imx: mach: imx8: fdt: return libfdt errors from
 helpers
Message-ID: <20261020053106.GA6592@francesco-nb>
References: <20261019125930.111608-1-eichest@gmail.com>
 <20261019125930.111608-2-eichest@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019125930.111608-2-eichest@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 02:58:52PM +0200, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> delete_node() and change_property() replaced the libfdt error codes with
> -ENXIO and -EINVAL, but the callers pass the result to fdt_strerror(),
> which expects a libfdt error code. In addition,
> update_fdt_gpu_industrial_frequencies() compared the result against the
> positive ENXIO, so a missing node was reported as an error instead of
> being ignored.
> 
> On an industrial i.MX 8 booted with a device tree that lacks the GPU1
> nodes (e.g. mainline Linux), a misleading error is printed on every boot
> because -ENXIO is interpreted by fdt_strerror() as a libfdt error code,
> e.g.:
> 
>     Failed to set assigned-clock-rates for GPU1: FDT_ERR_BADPHANDLE
> 
> Return the libfdt error codes unchanged and ignore -FDT_ERR_NOTFOUND,
> which fdt_path_offset() returns if the node does not exist.
> 
> Fixes: e9cf7f515a19 ("imx: mach: imx8: fdt: set correct frequencies for the industrial SoC")
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

