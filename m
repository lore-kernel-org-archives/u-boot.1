Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EFAAC982C1
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 04:47:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BAF03808C9;
	Thu, 17 Sep 2026 04:47:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wogpfwJK2IY8; Thu, 17 Sep 2026 04:47:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1B103808BD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789620440;
	b=RjuZjS1AvYmLiQxSv8iSR0kz04r9aH1rWpveqo/An6PTSz5rOrCWJ/giojBvAHe7MpjJ
	 r2kyoX2c0B8hT4hL9miel1jbSIl69y109I36iR3HxrBOm6xBp7s7BsqOgGAeDo1N+skYH
	 C+3Qn3gB54uHKWyNbb0nSgz3GxcPzhznYTuyPAUjb8uLHiM8xM21MvByJ50pdAsod6B/o
	 ts0v1NZqzbHuqno2kX509oe92RiYm7jqqI7eKkpFiac/7TJgvF1TF5D7RFkRnPqZS6g9I
	 CVRs+BBKaSTQTxZ2TVxNoVLFs1lMK0G1zc0quzUVo0zPj/39rT9ux8OQ8CkDR9ZwPKA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789620440;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YxPwgtzPCDbY/w2PhD7+NgUO1moUBa4NZ2dB9D7r6UI=;
	b=H3Cf7ZE94n1nyWNY+XIHWKBmCzefHIlZYHWmLVNiJ9tt8gbkEX+0ogd29I9A/y9NaxzI
	 ULX1nbY34CtatxJjCxz1E3xE6FIrjU5MrSt3nmJyAHhsxIzz8wT/12VVrLAcc/I2nPeFS
	 NQBNn+KxHKJb7PArxnoQu5dopdTDxqSe/IgT/gnl7EnGDMlL77j3cXah9ZjPT4CF6e/ho
	 tLgDS6a4mAzy1A95vkr5GdvJA0IRiYfr8f1+ZoWmR6fzhh+jp1J00fH4AHwOSfofdJ3We
	 P3nyXhrXC1bxuSUbR9G4Rpg9LOnuXjT2B6A0X1BoGny5qxtP8azObfaADvPwS5u79lg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789620440;
	bh=YxPwgtzPCDbY/w2PhD7+NgUO1moUBa4NZ2dB9D7r6UI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dwbTwuaNxavgsK6QDmJiLsQzNO7wzsT+vZ0nbnwm5RmZ9qRYZCG3yNVdY3EkXNqlf
	 OqE6R5TEjruSyMVD1LsE4xWUEVE41CmC/bXAtEm7KKcXnAdYAYwhrUg84nRY6Re134
	 g8lsD3HF2SKhdHSskNRrpaFYfdII8PAKHf2ph+Nk/JHKhYeWo9brU7UoEMyrHjfuT7
	 NxdXQOHnBvADmUdjN/nxmNr1p6ewUyZho4hlR3EU4/6UzFqApb5F0vH60VzwKSsuKp
	 gmGmz3xXLmAJb7u0gfGbfJU6qfximna4PFFijhw62ZXoQ4zJmkN9DOMM1PTbBGHMgR
	 kRKjpu0Pl/fWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1B103808BD;
	Thu, 17 Sep 2026 04:47:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6048743A
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 04:47:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 46999605E6
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 04:47:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yc-r0ftR_YAy for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 04:47:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 67B6A605D3
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=80.241.56.171
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789620437;
 b=GBq2T+53l4OA4j8+I/C3jvKzoJb4baTNC3t360LW+ii8zlnQ8KD+y8wBQooQUvuJQByH
 kxslvuBxpIgH1Ukyx5rOGYt5M2BvJmhTeqXNv0rI30RoBqIvUpRisRf7slxkYz4vkJFm/
 i3gMDXyLpMPlgjjFDObSUM0zIPqO2H9oAnGIXEs7ZKxKMGNQgB4ztw+m6X0UKDLZEzPMg
 883f3hdskXi1naIB/7APiZqbjUlT3aBmVD+NrlV05WM+h0wCzU9ln3j/9vx47rFq4oGhJ
 kXcVztk6IPC5Us++85P4q0bczoIhCF0F+M9kVxyloC7JS2gotNn+AfE78P2YSvPsZ9w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789620437;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=YxPwgtzPCDbY/w2PhD7+NgUO1moUBa4NZ2dB9D7r6UI=;
 b=EJahZFRg5q2pk8cUJ2YziwZunnGqdA327f/Q9JOOEQlUTt8+R8TDsak6xZ0oO7E01310
 1bGvmSNpswNfT47wM4J2jupbVAccxCaGCDR7tyx0TiEuD8qpeMsjH1Ci5XpPLYzRGaBMW
 WXj1/NBap6qa8nq/ejPQeCO/OLVp0y88hvAvPI375PLAwTRrak/rrdItKZvuo9G/UrGUe
 9ELrUzQKLjeS4ia5nffBB7vNvDYi3t+pFspN0mNUcAil95IXpVgvBUnXg/h5owQQQpZqu
 1XaOas7zWR3XL7WGU0mdmxppQfhYZ3aVcSkJSGYa1/DYslI220GgRGzGFeJHvRVT+Vg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b="K8U/xHRB"; 
 arc=none smtp.remote-ip=80.241.56.171
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.171;
 helo=mout-p-201.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=K8U/xHRB
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 67B6A605D3
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 04:47:16 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hljsY70b4zMlGV;
 Thu, 17 Sep 2026 06:47:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1789620434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YxPwgtzPCDbY/w2PhD7+NgUO1moUBa4NZ2dB9D7r6UI=;
 b=K8U/xHRBqOAJVyDsdaxuJxXYHALUfiOWUjpYdL4tfnsDzNMWAAnPi7KbMZi9ZAz1XPti01
 KS+OiWyWFFEb25XQI00e+idjXXEtwsz3bsa9REN18yb38+aZYKZ8uWnBL53krxXtTYvheg
 u2VYiFGaxPRs4ZuGk477CLp7Hd6lXaNSCxjf5oLtdqwFIXPKRepDLKaPDJccVx+Fs4T0iZ
 K7MoKcPWUN9bej5EugvOh05LtiikKVRfwqoFYd8MvmgdW+EwS7QgSUQp8Q3EsdegrxT2z9
 yV4sXI311+DZ3TluYnB0vrcWwaEDee0OsekWktQQHOCtWB7c5kXyRakOuep9dQ==
Message-ID: <6c15d243-812c-4674-bee2-7d3fb5671beb@mailbox.org>
Date: Wed, 16 Sep 2026 22:07:05 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] usb: xhci-dwc3: Add DM_FLAG_OS_PREPARE flag
To: Romain Beauxis <romain.beauxis@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 Mark Kettenis <kettenis@openbsd.org>
References: <20260911203229.25414-1-romain.beauxis@gmail.com>
 <2b012875-7ac6-4c74-841e-b5da14391e3d@mailbox.org>
 <CABWZ6OQ8xqFUQDt8FyODZPzDC=SFOcxr7bDe0eAF5K0OpwTy4g@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CABWZ6OQ8xqFUQDt8FyODZPzDC=SFOcxr7bDe0eAF5K0OpwTy4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: yo8bw41z7yet6qu3cwn567w98ttiwteh
X-MBO-RS-ID: 56ba0e1e9681246f69d
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

On 9/16/26 9:24 PM, Romain Beauxis wrote:
> Le sam. 12 sept. 2026 à 22:04, Marek Vasut <marek.vasut@mailbox.org> a
> écrit :
>>
>> On 9/11/26 10:32 PM, Romain Beauxis wrote:
>>> Neither bootm nor EFI ExitBootServices() stops USB controllers
>>> explicitly. Both only remove devices whose driver sets
>>> DM_FLAG_ACTIVE_DMA or DM_FLAG_OS_PREPARE. xhci-dwc3 sets neither, so a
>>> controller brought up by "usb start", e.g. from preboot for a USB
>>> keyboard, is handed to the OS still running.
>>>
>>> Set DM_FLAG_OS_PREPARE so that xhci_dwc3_remove() runs at handoff. This
>>> is the path "usb stop" already takes: the xHCI is reset, its PHYs are
>>> shut down and its clocks and resets are released. Child devices such as
>>> hubs, storage and keyboards are removed first, and a controller already
>>> stopped by "usb stop" is skipped. xhci-pci has done the same since
>>> commit e3bbc1f74e05 ("usb: xhci-pci: Add DM_FLAG_OS_PREPARE flag"), as
>>> have ohci-da8xx and the cdns3 wrappers.
>>>
>>> On Apple silicon machines the running controller is user visible: Linux
>>> does not enumerate a USB device attached to a Type-C port at boot until
>>> it is unplugged and plugged back in.
>>
>> boot/bootm.c bootm_final() does call dm_remove_devices_active() , is
>> that not sufficient to tear the controllers down before booting Linux ?
> 
> Any idea how to test this?

Add a printf() into the controller and uclass .remove/.unbind callbacks ? :)

> I can confirm that normal boot does not work without the patch and works
> with it, that's about as far as I've been
> 
> Also tested passing an explicit usb stop without the patch and it also
> works.

