Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E51606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 20:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DZyuNkUh;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=H/6nlhnf
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 589A680D3F;
	Mon, 16 Nov 2026 20:11:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LDq42ZwyhHQY; Mon, 16 Nov 2026 20:11:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6DA9780C81
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794859894;
	b=bexwLRMEWxzGmqp0N5xhd8yzYW4d6igxgRBq5+er6dEKHGz/I1hU0gP+Ag8SK+zLkmSs
	 usbuDbHimu4PHXoPNT4r6ZNlCw/2zxfP3hO8DM4O75m6Nw/uWq0f6XCJQAQZ6RDIj3H9h
	 ZmBz7lWbTBEo/Ad2KImaKkQ29+zfp/vvJ9/Ke8QSJDbBXThGI0i26Ynb5baLDjS0d7Hjl
	 aVBO502gzk4CL3JXw21mwKiBKysQ1BBFkF/HHnHM/4ZY75vUSezR3+U9M1piRyN29icRT
	 IufyMGb2bpp4rY1MCCc/nwyhB+Gk68mRlZ401/TnP/nov+h/YCCidix3VjnHP8DwTtA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794859894;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+Bg8Nsj5uhQNUj1dw4oqYyrkRtR2TTggoA8NKZFXIxU=;
	b=LQkmX8lSHzCf41FC1YkBI4G658nswZUutg6qtBha4xY2OH5KPnZvk+cHBJw7wZC0N9uD
	 YHaomsOCO1sZKUALZNf3u1AVMps4rpLPIaSZrX/0SuFPUCHVY95nHO1PmWvh+ayfcQz2l
	 aMQrOyr231f97VsFcMH1wE8iHRP13rKpeG6ezYvZi6V2Z+hWO/FnlUnQzYD0nFuSHo6QT
	 sDiCUIpKJHUdvfflwINUKM5oA0qJE2E0YG+uL0YvraLnusHUeBNqYSli20moHPo0pPeFu
	 2bbiO/pQvCYtsNYslNf83RW+f5eylS8FBAWjvnL2lEQB4N39CXiIbum5tCnHzh+MmHQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794859894;
	bh=+Bg8Nsj5uhQNUj1dw4oqYyrkRtR2TTggoA8NKZFXIxU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DZyuNkUhutMrdGISCtY9gWHVr7NV5PI8zrLpo2G7GCgfY7zDVal4z1745oLpU8RNv
	 sd7ecj2argTZBIobfWLiZH9oQ6keLVwXhGBa/PZmifM9Cy5A/QZ9DLmrfghi15AbET
	 c0tzw71bGRJDn2tdvVVDYM7KfN6/qGt7MTYqXFrnWEJkiywT73yFqtbMg+elMOrCaD
	 rddu5WPS0sO8k5kcN91is2mQDpGMnXx0EGXmWrA7vZdmv7KhX9IhpEKjNwgm5VVEkf
	 wJ4zDoYOWchOkX4Zkkx0S7h2AShzERBohP9MZkZ6tmjKC+uCv8hxecxcXidTakmh92
	 ECe8dYpv6V8QQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6DA9780C81;
	Mon, 16 Nov 2026 20:11:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 52F7628C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:11:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 39361402CA
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:11:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WWg2gZ89kKYc for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 20:11:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DE1DF402B5
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=80.241.56.161
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.161;
 helo=mout-p-103.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=H/6nlhnf
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DE1DF402B5
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:11:31 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jSzXJ1SVFzKnTZ;
 Mon, 16 Nov 2026 21:11:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794859888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Bg8Nsj5uhQNUj1dw4oqYyrkRtR2TTggoA8NKZFXIxU=;
 b=H/6nlhnfV8TRE8b0xovK0760dit567rSrsixNatXqeKvFbKCcSX8sKschuhbm6/mPSOmcb
 Vot6TFxx5uSZtMiOad+MWBbX2Z2Red+vCyqoGok7UuGKbUtihjrjPJ6O0NZahavNA2S3JD
 9USbIxpLEoyaHXqf1RaWCD7b7RSjiQ2du1QuKj5piieW+mPCdV/wEKLP3ro82yE80yblQO
 WtkyF/5nasAb0hePYdAZGIW2Omh/l39rieiPNp0NpW6xY0ETb8mDIk5QgYktR+1YdwPNY4
 hJ7l703WfPPm+vEikJm1gkr8MuRON29pop7100P3LJhjoCu6FP3SKagn2kSCMQ==
Message-ID: <8bd76ab3-de28-4acc-90e0-2de45fc948f3@mailbox.org>
Date: Mon, 16 Nov 2026 18:54:05 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: host: ohci/ehci: halt the controller before
 booting an OS
To: Jernej Skrabec <jernej.skrabec@gmail.com>, marek.vasut+usb@mailbox.org
Cc: trini@konsulko.com, u-boot@lists.u-boot-project.org
References: <20261116155320.34570-1-jernej.skrabec@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261116155320.34570-1-jernej.skrabec@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 6iimc5mf3ybtranyrtsi1zf7q6tq1s7q
X-MBO-RS-ID: fcceae1c4bf51f2d461
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/16/26 4:53 PM, Jernej Skrabec wrote:
> Currently, OHCI is not stopped before OS starts booting. This means HCCA
> is still being written into during OS boot. This may cause all sorts of
> random and hard to catch errors, if same area is being used for some
> other needs.
> 
> Mark OHCI and EHCI drivers with DM_FLAG_ACTIVE_DMA so remove hook stops
> both controllers before handing over to the OS, same as xhci-dwc3.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
This just landed in u-boot/main f8ae7682494c ("usb: stop generic OHCI 
and EHCI at OS handoff"), is this implementation any different ? Can you 
please have a look ? Thank you !
