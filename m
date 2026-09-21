Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2CABC982FD
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 02:44:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9253F80D92;
	Tue, 22 Sep 2026 02:44:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KF5nX8S4ETQ1; Tue, 22 Sep 2026 02:44:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C8E6280DCC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790045091;
	b=slzRh4v6PRPSXN0ePZJ+O2AnOT3Flo3RUU016LBHpqspFOrLx+aTZuMdAwIgRHY/r4MM
	 TcMwmtHvxDWrJMcG99PvdwPWU8SbGOaEzKYyeCAAvXwbMC3uiDdCmR3wP/2T3PLnOZCjq
	 9kOLSuqV2PSBKKcJmpCliihTnvFAuY6BegfQavTXf8IVV7MOD+03iNHsPyROmSWUFsIbs
	 KhXcgpSYtEr296JX/M3JgrbLaDdy1wCb9qnHQWu3c7VeWL0gcdbSIbYzkCwmDOihDIHia
	 pZkLtahmnsLwSJt7ebWuTrHH25y1jW+bWpej1tnd4BAMSI/yxk2e1iNKXpt38fhmnQA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790045091;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Xzlsvds/4dK8lcZbr4uT8nlx9aucdTIAJOyVf0awE8w=;
	b=U2TF0jFD5oA7PXzJAsIjne/0u0tVmuvu5fJo205H2uvFLNjIXDUz0uVPdgaKvcI5Oq0m
	 0kgXXAKxar7ldYl91nsYV9ViFtWmqtwpBmuWkG3sUSgaOzMosodz5aOfqRGoBYZgQkBt2
	 hORFFniYYnq2xXC/c957J4xHbzxz2qux0g+XyrwJ7TCceL9z3x2cDEW+7X59sTPIUvP7O
	 A25UwOdruUwP/zKgGNaFnQVpFCeQh4fUP/iZof+DLFYQzfZjXBqCX05i5B8UceldXSAB9
	 7kh9/GKbdTfaT7D1V3hO9rEHHsMe92Y7BqFNoSSYZiCBopqV/UWmGTz8qbsBxCGYUDw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790045090;
	bh=Xzlsvds/4dK8lcZbr4uT8nlx9aucdTIAJOyVf0awE8w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mEKUPbBgFXluvZwUINIeC/hr7RkaqlO13rngY6IbUs6qDcErbmo3F1KwoByQRmyLk
	 8aVTys9eUpiVKwhvMEIc/C04aX1FOthBR3VQE38a1T0sD2wZ9I+lFaL6+xQqEa1T9c
	 MmeT+wfc+u4TldawhaQ/LwrI8cxa4Ptwd2ixdF9Wb5Nb3O1CSbdgY5lYDFfD+m1qo1
	 h5pPQpfigzm0ksdnQjwaOhCIeF0PeaL+h/bAECkzbC5HbwJCrc2U5QO8/sYtpjNf9z
	 v3ITd4VOf/UwU+/MfUlCozP+js/XbcuC/4DlnUz0v7vmP63azn7Idm13k7KF3bgEYk
	 dm2g60hczElHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C8E6280DCC;
	Tue, 22 Sep 2026 02:44:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 362709D1
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 02:44:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2840160685
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 02:44:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MmrUh_A406Oo for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 02:44:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3CAEB60677
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=80.241.56.151
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790045088;
 b=EeYnQB0q2yVvusn6HVWLmfQ9F1aTIzHtXPa4W3paCq7SXzkHo+/Wq8kC8PviBDcGuf/e
 LjclLk+W+5nvYkIci7c9YePXl6nIYMIeUqF0OdS1l7pmmNYwoCcywVJDYfr67ylj8lxW5
 CBSisMC3s/s68PNUbfzTsygWYaI68mpeHaWN9oLEA4ymwW9HhnmqWDa9Y/wB6kzxQJFrU
 zLjQGJ2LPotwo6p/0TKgAy9NnfMS81t744/iw53p5X7mUtUeqTDnyE8rJflRGMTO8NnzU
 AtqcrmTJ5PBm1nroLswnzC8ntLAQS4haD4S0W26dN9cDqr4ySQij2xTpkmFm5bM4gVA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790045088;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=Xzlsvds/4dK8lcZbr4uT8nlx9aucdTIAJOyVf0awE8w=;
 b=YqA+mX33EUcJnT1e8pmjBR75sD7RpkSa4ARokQUe5IrSYREW3RSim8um2pd0OfEZY8lh
 zAB8HbZ4hyaiW63tPi6BhLTgU81N+XzglrYo1VGGRjZ2OMd2pNV3VHGRGe0tNIQfS+gP2
 oCuVRbypKmi23WxEhsssaqXnw1yUQpx6BuqeQU/7jszKih663onaNzM2kZhe10nXnKCiZ
 pIRbMF4TKcq4sQd5V2LBwAqlMpUUX+QFKMFSfmV3ToTwc4/6nOg+BDfbm0hgFwRBOwei2
 QP6biFLv+1HWU/pWyK93Ser8dSybscufe29/UxlUkbZRIdyWApGfqbRoXSwEb0d7jjA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b="omEye/cB"; 
 arc=none smtp.remote-ip=80.241.56.151
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.151;
 helo=mout-p-101.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=omEye/cB
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3CAEB60677
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 02:44:47 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hpkvw0gXjz8v1l;
 Tue, 22 Sep 2026 04:44:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1790045084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xzlsvds/4dK8lcZbr4uT8nlx9aucdTIAJOyVf0awE8w=;
 b=omEye/cBgyyGxnkVCugUZG+SO778FP36PbYsBQenFNh97fwmwBhH6ywGiTn75fABFwyi1H
 63ZQH2qWGLp8ma7zE+AwZ2o0BQ79wpvKn1ISRe97PbGQrfZTEl0rffuACtuj0Kp8v82UgU
 Emw3TcByB1dv5EglG93abOLzuEHJ3nEGtdC2Ln3NKU2LXErZof+3A3G4Tya6YBxnxdxiE+
 Yp26J9Ckl9REKCz0X9rm01wPoxqkCvhMIf8+gN2O6lcLKWqjMdeYQgRHJRIZ75+bDJu6Jl
 CfGC/zf2kO1Uy/H5e273F8rG9xkjGAEHcOgESAWNnj+/U6Q4KcPQR79ZLzJh1Q==
Message-ID: <238ceafc-beef-4594-b626-99bb37a13692@mailbox.org>
Date: Tue, 22 Sep 2026 00:01:22 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] usb: gadget: rockusb: terminate full-speed descriptors
To: Quentin Schulz <quentin.schulz@cherry.de>, stevenjoezhang@gmail.com,
 Simon Glass <sjg@chromium.org>, Eddie Cai <eddie.cai.linux@gmail.com>,
 u-boot@lists.u-boot-project.org, =?UTF-8?Q?=C5=81ukasz_Majewski?=
 <lukma@nabladev.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>
References: <20260918-rockusb-fs-descriptor-terminator-v1-1-144ffc0f3d33@gmail.com>
 <180d8edd-2743-47ad-9904-866d76bdceef@cherry.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <180d8edd-2743-47ad-9904-866d76bdceef@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: h3qh8aix1yqpw1fim9iad4kjjgjw7z7i
X-MBO-RS-ID: c11aee0f994b908299c
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

On 9/18/26 3:50 PM, Quentin Schulz wrote:
> Hi Shuqiao Zhang,
> 
> On 9/18/26 12:11 PM, Shuqiao Zhang via B4 Relay wrote:
>> From: Shuqiao Zhang <stevenjoezhang@gmail.com>
>>
>> usb_descriptor_fillbuf() expects descriptor arrays to end with NULL.
>> The high-speed RockUSB array does, but the full-speed array does not.
>> Full-speed enumeration therefore reads beyond the array and treats
>> adjacent data as another descriptor pointer.
>>
>> On a Luckfox Lyra Ultra (RK3506B), the adjacent interface descriptor
>> started with bytes 09 04 00 00. They were interpreted as pointer
>> 0x00000409, causing a data abort in usb_descriptor_fillbuf().
>>
>> Add the missing NULL terminator, matching the high-speed descriptor
>> array. After this change, RockUSB enumerates at full speed and
>> upgrade_tool can successfully read the eMMC.
>>
> 
> usb_descriptor_fillbuf() iterates over the array, but so does 
> set_config() in drivers/usb/gadget/composite.c.
> 
> I've quickly checked other drivers and it seems they all NULL-terminate 
> also (either explicitly, or in the case of drivers/usb/gadget/ether.c by 
> having an array of static size with fewer elements than the array can 
> contain (and thus they are NULL)), so they should be fine hopefully.
> 
> Acked-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> At the organizational level, who's willing to take it through their tree 
> once reviewed? I don't mind but I'll be waiting review from Lukasz, 
> Mattijs and/or Marek before doing that.
Wait for Mattijs please .
