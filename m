Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5D0606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 05:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Tobrpjpo;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=UmQZxp2R
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D4C806070C;
	Tue,  3 Nov 2026 05:10:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rbPgnDXuuX37; Tue,  3 Nov 2026 05:10:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1B172606E9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793682631;
	b=Zglzc2Rq4l410wEyCxqI45p5kGbVEl0REPaLghVrFIoOs58OsgvINnzflplG30ZyHg+h
	 vr81h6XNUPVZx2hf+tNkv747Bo+PYrnAjxchT4t1K+xoXf/uT1D9Whf/3nNXNVMnc+gHX
	 oqSoZS+DzzBpVhAjoaxMr6LyQESTrKJGqhpdj0IXVbIxEoJqDaEZWw/INysMSNYEOB3P5
	 iGQfRV9LYU04Qd8HFlSDma5Vl0vACN+DP799BCcSuqR0M8pMjsBnBtIIIZC3gO0fEISPG
	 /QT3Ub4wcSZZbPLCRUlSz9leYTIR39sXPYynWNEAv1VMbC+ILgFy49+Te3gfSCF0y+g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793682631;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=cyBmWKhbFp8z+RSE/XgPRtJXTGqQTmF/f39hEYPposo=;
	b=kARUfzV6ybD6k/rZuMl3oUsenX+EB0Zwji4Q2amIzBnkeiGbqkQFDwNPYXhsPlLIY3qi
	 pWj82d+ooA9Xi2iGLMZqsd2wYWS63tKgVQhf5c4eAlryOibWKZk7gYykTFJS6Vd6Yjarp
	 3ku7dGQVt1h6Xt6VHd7S+qvgjIxcQICGZwkOoevsdoGH9z5E87di/yuboAhzAYLPnAKcv
	 +eZ1RTPTb7XVbvkjQKkHuS7R2T2aXqNd9m/wRT0UKnQMjEVKOHXrV5kiR9zJvFqJVWpBb
	 ZFRCi4w4wreusxK5uwbghb4dGyQSecbDAWDDYeCZrpOYQeMerOPH9iserokXfxSHRRQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793682631;
	bh=cyBmWKhbFp8z+RSE/XgPRtJXTGqQTmF/f39hEYPposo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TobrpjpoTm3QWLGYYAAgLrj2Oj6/GlAapvu4rB+HKT68OEGqjC/0Zkzs0fxSXtLPb
	 pvJjfXZTer6wG0B8gCqQCnr1MLWtNjAB2SzedJTpOPuNKBHCMu6bcSBfonZL7YhYkk
	 Uq4TwMUe81HBnQ1KVX6CBPHEhjfkSEyXMrXk7yJGpqX6NhSArEZXmLAXy287ae2RUk
	 UpWGa6IEYB3d3+hqdlUZ5+4d1pVt+G+5y8czcShjfQqRGnrzXP9Wx/xDmBrX9gE3BP
	 4ofJhcC/a1eYaCW5XzGYVgygi1Lt6ly7RNJUlqYkoeDhUIeR7NCcOKzdYfDJsQbQZR
	 UzjdnXAr0TO4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1B172606E9;
	Tue,  3 Nov 2026 05:10:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2FD524BC
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 05:10:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 159C440575
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 05:10:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zmvgef3o5nCS for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 05:10:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 20D2340517
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793682628;
 b=M3YS6qBYLPv1pELCDD0Yt4ZoyKCKtvRcpD610wd6tXL2cpHAAr8rc1efcVZ+N5GdOqPF
 43ThAdDTkSPOiV5aWKOuWm+S24wqS6CbKqj1GRXaFskHXhPoDcovdyOilOYKX6VXU6uT4
 fO+dcxaHwqboJ/p0/2c3UH7DmxsqHcnhF9ZAJvDnnDF+n/Og5d5XidUSkp2IheNc2Lwkt
 6qk/sSopSv5vonfGr72s0St6WuEFewRcJ9GpZZX/4rdUdT7MR6Ltig5hCxZN2PAPOsSuI
 nsWEURfB702XtqxGet/V8RigkI6CYsOY24CpqFCGe5InAkGPDjJJi/L/9R/zmhOhRyw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793682628;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=cyBmWKhbFp8z+RSE/XgPRtJXTGqQTmF/f39hEYPposo=;
 b=eMiRnZ44n5zTecgi4+yb4zqVk4E1Ozq1oM3Z3xiyPI4h5Lm4tIVH1R5czeQR3zB/imOJ
 TCZWSEmWJkb9VFcEROPK95U4smp5sY59TZaFY+XmLT+A92w/GXybyyWd1hKRgNXJiITVW
 DOixHJx/JApAAUIARpZsM+ZgPo+yESiD1rJKgvCMgRCMx/ZDr4zkLTnDokZ77NGMhE3A1
 Zx4xO0yr4P2BvJDPgzyffS99rQbyt+IRzBVKEVncCQV171zBBYij4c7NPdfh+BGq6pw6b
 ZSfayNUcEMwoTBOTAeEygBg7Yk03/M8FKn3soI1B4/GB+Xls52vDtKPRuoN2E5ZDmNQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=UmQZxp2R; 
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=UmQZxp2R
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 20D2340517
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 05:10:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CA9FD10C39E; Tue, 03 Nov 2026 06:10:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1793682621;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=cyBmWKhbFp8z+RSE/XgPRtJXTGqQTmF/f39hEYPposo=;
 b=UmQZxp2RGFwqL1uyg+g8ONdPiL3WzspqBr4WiY/PBEFVAJSp3MGIGKDDQPUL4932tuBEyQ
 UsZ+Gj+9L02HTvV2VhkbgrnxRWHkTdvPhyeh0+n8ruEKMEmaaXSm8jCfQfP6NCUyYfMdDn
 8q7jEcqBs3hvei+WqsneDPgVuJ/wqH4E1I4zzXDyLa8KGG4xV+kByBEl/1atHzN2f3unO0
 NGt8dQrcwzj7WZEeUB1rrcCjdbBJwygtytp/Gzz4agUpo7gS4xoDk5Z3WfejbdmwFv31Jd
 w6IP7hwO+gKD7EAZibO7960AEArxgsHxnUo/hhjJDSlSrUW1TNeTuGF6b+sUnQ==
Message-ID: <b2f93d59-093d-4a9b-97fd-414f94794e14@nabladev.com>
Date: Mon, 2 Nov 2026 17:18:22 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/16] usb: ehci-mx6: unconditionally run usb_oc_config()
To: Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Mehmet Fide <mehmet.fide@gmail.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.u-boot-project.org, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 mehmet.fide@screeningeagle.com
References: <20261029113657.2303346-1-mehmet.fide@gmail.com>
 <3e9e6ed967dfd1634fe001531bc63f52df823381.camel@ew.tq-group.com>
 <4c7e7a9a-dbeb-4fc0-a43f-60562aa22249@nabladev.com>
 <d1df69aaffcf8d0d61009018f63370d7724e2773.camel@ew.tq-group.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <d1df69aaffcf8d0d61009018f63370d7724e2773.camel@ew.tq-group.com>
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
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/26 10:50 AM, Nora Schiffer wrote:

Hello Nora,

>>> I can propose a patch to drop the !DM_USB code, but out of these the
>>> imx8mn_ddr4_evk is the only one I have here for testing.
>> I have 7 of those. Keep in mind that MX8MP is DWC3 controller and is not
>> affected, MX8M{Q,M,N} is the chipidea EHCI.
> 
> Ah, right - I only checked which configs enable CONFIG_USB_EHCI_MX[67], not if
> it actually makes sense for the configs to enable it...
> 
> What would SPL USB support even be used for on the 8NM boards? These SoCs don't
> support USB Host boot, and SDP is handled via BOOTROM, so what should I test if
> I try SPL with DM_USB? On 6Q/DL and 7D where SDP is handled by U-Boot itself, I
> could at least test that with some of our TQ-Systems boards.

That is a good point, the 8MN is BootROM "v2" which I think can be 
invoked again from SPL to do more loading via SDPS.

> Unlike 8MN, 8MM defconfigs enable CONFIG_SPL_USB_SDP_SUPPORT instead of
> CONFIG_SPL_BOOTROM_SUPPORT too, but I don't know if this has historical reasons
> or the 8MN and 8MM actually differ here (but in any case, none of the 8MM
> defconfigs build a !DM_USB SPL, so nothing that is working at the moment should
> break on those).

MX8MM are BootROM "v1" did need USB peripheral driver in SPL to do SDP 
loading.

> We can scratch the IMXRT platforms from the list - those don't even enable USB
> in the SPL.
Good!
