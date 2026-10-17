Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB3CCCF2C1
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 17:33:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5D3D0813AB;
	Sat, 17 Oct 2026 17:33:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ysbXiBO8Wafp; Sat, 17 Oct 2026 17:33:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AF2CB81387
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792258404;
	b=LSWJj1AK9P/SI92HHTn6JPYIvIQO3umGzM44iYRP7k/p56xJNXGOgralFr9dOVqFkj1q
	 TUEpUZfhrPSUc5f/6MQK8dX8zYgx4JIFs8ZydxHfVFzPBFAC8vACnkHbELVso9pC1RcLL
	 D4/koIwCMjG4+E3t+e2OMEPUUMAQ3u+jJ2eHrZI7RnqIXGz/C344PN+/EJeS0zVM1wX/n
	 M23jD40UWPSjWE5MEvkoX1M3zcfwg3KnGmdlymFf36XoxAmfiZM9DuHlJyvXEgn2GORuD
	 +MJpTdmgrPsuy7xepTCKkKp4pmUiK6ts/f5FOOMrYoE04RODv5yRfvs4977OgEEjRQQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792258404;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ygpnjXMmFN0zJ4KZQswLXCZnMQKmlSxLHBBYIuRa8tE=;
	b=VyBKko3ho+aG1sT0nCeiQOzcCY80QS8U2TYHH2kOrZ3JWKUNvFkXVMaKTPZFO+fYccIo
	 iHxEwg8l9ZHQg3VFNo5doKUkF66oYdKuAG1gd+mRZxAUwR+LXO+JVIBz9NMSfW5q5ad89
	 ATcic6G8aMdf/6+AqrqhgmkEIfP3VDcoUcEgyOFW4SH91c7blBJBECgZdDM62nSXDj61C
	 bBbn5kk4XAOSTEEGr7O+Awh28ViSDitDUqZ+k6Pkdz6dm+NfcdmBRE7T0GpC2FTQaD1HO
	 TPePpC20TyZTiNDrPbqqfouDgvp2ITC8yXprHxP7TKgzBJW/yPOEx2roeUdiUjurGBw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792258404;
	bh=ygpnjXMmFN0zJ4KZQswLXCZnMQKmlSxLHBBYIuRa8tE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M+zlmiveFYIPvT0kf4P57qOWXpcQ0XYSFhnXL7fEXmLj6bJwvwYFoDQ6QdssN21bP
	 Ku0dYz2jL/XqHJ/mTbZQC1QSWx5hGMQLrY6ok85vT8gywmJ8eW4jTkkb5u7OngCi72
	 2AHhfwPhW8GSz4WS9MpOnamMoC2dHZT+8rNPjoHVZcqH1INem4114cEXoXS6eXhock
	 y+HG9s/ORUhfvqnhO7sxBQTyar8NACHtqEDiO54M8ubS6vleX1xIbliEm9LSNniQXt
	 vWps2a8KAZtHeZiGumeL4Hjmr79m5dTphCga/WMbRhqyDGMo2z0WDsJaFr/gTWrD3k
	 0FJ2zFwF4XNYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF2CB81387;
	Sat, 17 Oct 2026 17:33:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 926CA465
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 17:33:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7801640845
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 17:33:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kvsmzq1YT5Wl for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 17:33:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C6D60408F9
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=80.241.56.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792258399;
 b=cdRhBoJCM6ZjqKeTe+WLRJOrm1ldPSJvl+o5V7+O7GTibz3M+tQTh7LxvynPp2Eat+sJ
 JbXdbMG6/NEH5P8TBDq/ab1P0ZMWu4dE20BZyno+L03WfW7+XFx/v96mEm0/dgA53tiWn
 Uod8X1w7KmuvIAogjI+XK73+7iZ2YBI101bR1SZDaJ24lHETB2SJfCoZIj30CdwloMAb6
 h/nnaM0YoL+OobHglovHtDj+OPEJfMAEQPCtj0oNsB423TJI2CAyWvfcJR8GyKGwNshJE
 ueTsuat76t74JoCLTxIqsmtrYROOlTiNlUICBzqxUu71H9Fq6dMUP7UUoYdxsmkdZow==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792258399;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
 bh=ygpnjXMmFN0zJ4KZQswLXCZnMQKmlSxLHBBYIuRa8tE=;
 b=D8C+CIaVZA/7K+DgVd0+32lZrwCnLKXCdXeu07GzODrFoBvaC7G8uSZLldQEzeIhhwk5
 fxACpaWmFzm310kXokyrBRY5fudaPa8ltE3DHnu2NRuTnPi5uszOJGdRTyM+cWm0BXDOv
 yxO54bboG5Y2d+trYIRtFidfSshZqXs9p089bf3BYkyga4wMoygHgRhLbVeux+GphZR7k
 YRz8qiVHQQ/4C+KUkZ0xOCPEjHIGQZMYpUgNLIpC9yzfXqG9BRAnqU2AKS0dUKjXxVTZJ
 nGdmfUzL3zAsbiUNpaOhTzH4c6ZFJpbkz9jYkH9VUegS4AmWMIN5Ivlj7yy8Q+xiRuQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=slOagypm; 
 arc=none smtp.remote-ip=80.241.56.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.172;
 helo=mout-p-202.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=slOagypm
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C6D60408F9
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 17:33:18 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4j6TRY6L6XzMlTW;
 Sat, 17 Oct 2026 19:33:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1792258393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ygpnjXMmFN0zJ4KZQswLXCZnMQKmlSxLHBBYIuRa8tE=;
 b=slOagypmkM5CXXYB5KCthkxDqKp7H5HmT8BoC+4HY/ClhWwgywRqHwq9v3xH5o37rYVMRX
 wQZ8/hqfVDsurATfh+um3BVoul9pdtegGc+oWbuh6bDuHjQGagvd3Gwp/RrBsaUcrX6Tdl
 Y8BSB4n7CEw0ILJ1XhgS7z521yTkZdOe3iD8q0u3lwTKutXKoGed8FJhqvIfnUPF8vo37V
 iO0COCkrlM/gRHbTezye7GGHC6ABA0Cj94FZ4HiIIBYi8S7+ykuIiWORY79hEZJ05HPAxu
 CkN6CNAptaifuy5sSVA44YA79ay6LcT9Q8lPNzCwp/i+ecj5yHMTl/l21DO0hg==
Message-ID: <2e09b64a-6055-431e-b0a1-1fb647c83096@mailbox.org>
Date: Sat, 17 Oct 2026 14:41:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: xhci-mvebu: use regulator_set_enable_if_allowed()
To: Stefan Roese <stefan.roese@mailbox.org>, Bruno Banelli <bbanelli@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
References: <20260822092053.63884-1-bbanelli@gmail.com>
 <be41cf36-9142-47a3-828c-c54e4c669de7@mailbox.org>
 <20261005074440.589817-1-stefan.roese@mailbox.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261005074440.589817-1-stefan.roese@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 1510b1dab7759c52252
X-MBO-RS-META: jq4pebywoweczsp3n5twbj3h6iy38zfz
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

On 10/5/26 9:44 AM, Stefan Roese wrote:
> Hi Marek,
> 
> On 23.08.26 11:40, Marek Vasut wrote:
> 
> [...]
> 
>> Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>
> 
> Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>
> 
> This one and "usb: xhci-mvebu: use dev_err() instead of printf()" were
> delegated to me in patchwork, which is probably why they are still
> sitting there. Both only touch drivers/usb/host/, so I've moved them
> over to you. Could you please pick them up via the usb tree?
Applied to usb/main, thanks !
