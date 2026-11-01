Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64362606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 05:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=U1YGPS0a;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=bMWTZVI4
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 38EAF8107C;
	Sun,  1 Nov 2026 05:51:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l_3GkqVS9yHw; Sun,  1 Nov 2026 05:51:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6D0C3810D1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793512301;
	b=XFptd4IPWGCvuXPL0qPDMI9mmv/lMoBb7gfYvzLKee3q3suKDLAkGwarnkClrZzity5k
	 gaa0a9WpjKkzLKSTsS+UfthApVGnl6DJr7nsrbXn8pgw3v2Y84Kbq8NC7LIWeAPCAj7U6
	 Q6fJ553CaOiUKy6ZXxIBYCKd99qJBSH+dHQnxvBYZdLJ0LhFrVPwxcY858U8RuBJIHQJ6
	 e//QI4r1SgWr/Ju4cl+aYd97C5h1DnHTsO439CNZrbfgaI4jouS0tbRj6J5MWGdvDZ6PU
	 ie9wZjUeyWG2Ejz+Dh87zaghk+rq6TpwdOVTXyMxil6TgCw3jm5cEr+FK1Tj75P+x0A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793512301;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UIo9IlR8qZXHDO3qN0YGNStakkKpzAr+R/yL9ONlDt0=;
	b=d2Xxt68wGJjLSxV4ACXo0kI1rCWkzFVurkBCiSeThzfXMbzicUoZjPRV+iGVZCuZ0BFH
	 5HnDnmt5+pdELta8kzikKAk2N/RSqRU/ngTv46LH2xledMhsbLeXkOZMgx3S/rAwFM1U/
	 c9aqHDXlcQfZEql6gIjAjFpow0ogik/NNA/DnWa0G7SA+EMVRzfA95OGl25uOZ/0yNF0y
	 BjPozy0bcF13gV43O/R6IpaGIWpX1mxYdu3vced2JDtPHQk4ztSufXm5gLD0CSrmJ87sD
	 HdZcfmulkS5VQtAoFmmQXKiZCn7if5huuGNhDlm/oVrkT0U9348s3swyA9sicmNOsNQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793512301;
	bh=UIo9IlR8qZXHDO3qN0YGNStakkKpzAr+R/yL9ONlDt0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U1YGPS0aD91Wc2Z3Dy81TXEM7cReWrSiICpwaPo9hX79JUX9QzMIRkhV3dhy4OFZ5
	 2S3R2oYO9a3mO2tXLln2zotj2NJ1Ixm1s1hJbI8iYuOgxP1smvnsAJi6XYo52KL6mz
	 aH+xm1aEsDwjDHXkZy6I6YvqPkIfGSjLIdH7vTpvgJiWhOIML7uETjwqbAwiHqCL1m
	 +Cemhi8m6mXdOGPTcxmtwfF6RmMU9WSVCPTiTCWXjp7RjMmJwi3h62vHgoF7PJA0Wb
	 SxjLszpND7GRWcdY6VSWhaOS71rTjndmRItV/IYLcE2yw4WHnLe4ax0aZiq2KYzygv
	 UO62VJopv6BOQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6D0C3810D1;
	Sun,  1 Nov 2026 05:51:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id CB91CD3A
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 05:39:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BCCB9607A1
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 05:39:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LCEx5cgmpkqN for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 05:39:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8C82460793
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793511584;
 b=FGcEBlbEq2pnBIDxHFb+NlpKxE8ay8E7AzcqimtRu8/17xohPOIQydBD+gAFyE/LFIrS
 rXG0rEn50wjUl+ImbMYO8fNdR4JjTNdTmbZx20SDRtLt+yK22l4F7/WdfwlOZat3IpBr7
 wmsmv5qn3bkHjWpLZfSYI70RdLHqCMQ33JWD5OHdMXBRZGVQTRgbm0epMx/vJi0mxju3N
 a+PWRELlJCoeWFD+gvz3F+LYdgnvW/4QWVz0z1As9BwIsCG4Hi8poBpEe9YgBmoC4TUuP
 tfRBBMVcAKt9XQziTVrVsD+SGZgKqREIhtqFRZzcjVOtkKSkrOYV8Mo9nKClIgM2UkQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793511584;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=UIo9IlR8qZXHDO3qN0YGNStakkKpzAr+R/yL9ONlDt0=;
 b=N6w6j9Tj3L/rFaKU2qOVCp0oZeJVfea5RSDRexICM64mEGn43zxKCKX/y1doM2vkH1Zc
 avsBl0F5Qfx0o0kXozEwN+eerSi9h7oxVl1kTngxtWRS/NHA8774LwpdUx/Ty5ROXeRtZ
 uCgIhxuLS2nUAHH/uDq+X8d4nF7ZB+gnwnPxye7JAHdFwOUZmFXIDt4fVOsgKptne2GJ3
 nU4Hhy6fmSmxl4bihBUmgmnHilgT/63myd7jPKcrTkdtE7lcZtPzswPlRf+cw8tAApQ1S
 D1ho/+VX4KVsYltp24AGVNCQWZQw9lv+8aFSsFJaDyyiv7Kul2xzP8VWFIzV2NKds4w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=bMWTZVI4; 
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=bMWTZVI4
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8C82460793
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 05:39:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A52E710C04C; Sun, 01 Nov 2026 06:39:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1793511576;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=UIo9IlR8qZXHDO3qN0YGNStakkKpzAr+R/yL9ONlDt0=;
 b=bMWTZVI4lAPU4R/OG8FLfO2A8tD667sfY3vOVDgbyIiGUwsqdbtDa5w2lqJy8cupVLPZyw
 YMRNCQ61D0D4ZLPaDMcwTwYmsM76dJ9NO7cNOgBKzRkvvgyG1ZeOG7m5wWXyJoiGRX5jpD
 j83/WQ9CglKuSnWRBXxETLaW05uDfQgmwwXvfmBfuQZBXuHKoTyScbkXY4S+9gg/aOF0ce
 sYs7Mgovmc/7lM5hnoio6SynPz2TvqbJeBJpfbDYnfMGjZs+/hjFZbXTaAKvvdawBH2j2K
 TFE4MPRK7WIMC7E+xplih3Yjcfw1fT80+8xx1U8Jo4JcKyHh/QDXPz1scwmxQg==
Message-ID: <8aa0e829-93b8-45c3-9d3c-5d794a4aa845@nabladev.com>
Date: Sun, 1 Nov 2026 05:18:08 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: stop generic OHCI and EHCI at OS handoff
To: khaliforce <kforce@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: Romain Beauxis <romain.beauxis@gmail.com>,
 u-boot@lists.u-boot-project.org, Neil Armstrong <neil.armstrong@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
References: <179128521948.5.12131679420803093421.uboot-usb@gmail.com>
 <3ae0a18e-0fa5-477d-bf5e-89072b9634ba@linaro.org>
 <20261006155833.68374-1-kforce@gmail.com>
 <20261006161015.GB1356209@bill-the-cat>
 <e4661500-74e4-4bed-b09a-a54d24eb6062@nabladev.com>
 <20261011220316.GJ769217@bill-the-cat>
 <489e6811-cb25-4085-8077-427100154182@nabladev.com>
 <20261011223137.GK769217@bill-the-cat>
 <c532672f-8ff7-4e80-8f78-0140bdcbd434@nabladev.com>
 <20261016000442.GG259661@bill-the-cat>
 <adb76f1c-cac1-4cee-9428-563e67c50d5c@nabladev.com>
 <CADskdwnLQymCXCvOAop_9uPO0_nWQH-dTcJa77uU+s+0sLctTQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <CADskdwnLQymCXCvOAop_9uPO0_nWQH-dTcJa77uU+s+0sLctTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/1/26 3:09 AM, khaliforce wrote:
> Hi Marek, Tom,
> 
> I retested v2 on MangoPi MQ Pro using the downstream D1 port
> based on U-Boot v2026.10.
> 
> The boot path was U-Boot -> GRUB EFI -> Linux 7.3.1.
> 
> Two USB hubs were cascaded, with one flash drive on each hub:
> - Near: 64GB Samsung Flash Drive FIT, attached to the first hub.
> - Far: 8GB USB Flash Disk, attached to the second hub.
> 
> I added temporary port-path and device-identity traces.
> I matched the serial numbers against Linux to confirm each drive.
> No manual "usb stop" command was used.
> 
> Relevant excerpts follow, with intermediate lines omitted:
> 
> USBTRACE identity path=usb@4200000/0/1/2/3 vid=090c pid=1000
> serial=5610050000154305 product="USB Flash Disk"
> USBTRACE done path=usb@4200000/0/1/2/3 driver=usb_mass_storage
> flags=4000 active=0
> USBTRACE done path=usb@4200000/0/1/2 driver=usb_hub flags=4000 active=0
> USBTRACE identity path=usb@4200000/0/1/3 vid=090c pid=1000
> serial=0352315070000417 product="Flash Drive FIT"
> USBTRACE done path=usb@4200000/0/1/3 driver=usb_mass_storage flags=4000 active=0
> USBTRACE done path=usb@4200000/0/1 driver=usb_hub flags=4000 active=0
> USBTRACE done path=usb@4200000/0 driver=usb_hub flags=4000 active=0
> USBTRACE ehci_deregister dev=usb@4200000 ret=0
> USBTRACE done path=usb@4200000 driver=ehci_generic flags=4600 active=0
> USBTRACE ohci_deregister dev=usb@4200400 ret=0
> 
> The farther drive was removed before the nearer drive.
> Children were removed before their parent hubs and the EHCI controller.
> 
> Linux booted successfully, detected both drives, and reported
> no failed services.
> 
> Both drives used EHCI. OHCI had no external devices.
> I lack suitable hardware to test downstream device removal through OHCI.
That resolves my concern. Thank you for testing.
