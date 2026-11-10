Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E868A60A2606
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 10:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tlO2BF6/;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RJOXf/Ap
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9BFF960837;
	Tue, 10 Nov 2026 10:55:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i7dB3qtLBBEX; Tue, 10 Nov 2026 10:55:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D31D36080B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794308155;
	b=iCanyTMmD87WsuMBQrTtCZjLxGiTyVQxD8UAT0VOvrvkWIaTimoHGXjrxMMVpYtikGui
	 PdDdAJHHRdJn865JIxsANqK0mQy5Z6SMk6Ia1iJlsb6vz/5lqU3HDoSt03C3Wh4Dhoed4
	 pNoB9cv3P+evKFlDbyWZ5oHYHIh3EEhnpGyIOfVWywmelSmseP//wYXjLQ9UMmvGrXX5Q
	 ph3m/MqUs7S+XkSpZpzF9RLF9AsCsw+DTJDD2WQf+RUuoTvBNOw0WduiuW7SVAWQzc2t4
	 nH83slPRRmJkSAs5+cV07ZKhGKa2c/ddCdpU4HAmYAvxRZiQXFwlM6xHEmFB0Xg0gMQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794308155;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Qz47OTrcby1/+J3ahQ9+chw9hlIggaQL8rlWVhvZiJQ=;
	b=SXyJmm600khtEcO4gENilhyDMmKSx3XNSKB0YF4ugm64LJtoaoh/KS0RyBo/I79muHns
	 24mJtpoX1SE871eZxca71JjUTNlYaCqsCxxHR6bum1hCDfjEatQSCbk+NhGg1qDIHLp72
	 OhrFYHOghT0HUrCdmkE321BJElkKtYNj5ZyFFKmcSWJC3V4urEQ1CL48shnM6A4UP38a2
	 Z29TW4h7x/yD1RRV9dmZmQPGuheHsulK19foLp0VpiUl1tVJmR4KRRehbTJ+aCrisiOPk
	 O4wi8zzDfguthhdEvKNE9BGFPDR8bPtVY57trzjzC9+GPIVlreCGh57RDN5N7Ogiahg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="RJOXf/Ap";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794308155;
	bh=Qz47OTrcby1/+J3ahQ9+chw9hlIggaQL8rlWVhvZiJQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tlO2BF6/ssxg8C8kdSZFO4HFM2Ii39/BUrK3pntrQn3/wBMP1pRX8KCZoTYN+wJV9
	 76kYX1G2/fgnMtQbSFX+HyJAUaDt2PHVGfMRsuJUyk1c/6Rk6PwDM4JH6WXMVJoZDX
	 uW0XzqjrQkUOq5UdN8bhxUPOZYkj0nPJpyfPgwErTt5RnHRwrYt0y3gBGWj56APhU4
	 jQrH1Xa3moKzkSRtds2IQ/wdBfPX05hJzBjgju/xny6mcBWRtCQcoTK85PX9WxHdu/
	 wzG/LTRz86WC9VnMd/oq6NZxZroey/482TZU88/t1p/MEVwv29za8767Nb+VLb6h+g
	 habBIpU8fBsYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D31D36080B;
	Tue, 10 Nov 2026 10:55:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A155C731
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 10:55:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 92C766080B
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 10:55:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d06Ke8aVQr1s for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 10:55:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CB43860768
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=RJOXf/Ap
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CB43860768
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 10:55:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 43546411C9;
 Tue, 10 Nov 2026 10:55:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A63511F0089F;
 Tue, 10 Nov 2026 10:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794308150;
 bh=Qz47OTrcby1/+J3ahQ9+chw9hlIggaQL8rlWVhvZiJQ=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=RJOXf/ApKKcQcjhI0v8MdFnXM8JN7+ZEtDv8Lv95slroFSAMppfIZN9fvrgtqqqj3
 GwR7AOEbAvip0UMwPpoD3LAlc6umb1MFC1aM4T4NzavjIFa8BNXIa3+PgM/lt4cdlj
 vY1j7SM9diEJgDf6VQyhHepl3ZXPUlpSMgetNQ3hHKLlpVLN32AxETe+653BkN86n4
 o9TcFSyBtn2PHK/LzULFjxMoQ6QqmYWcKeHZhobX8/2g9UkhEMVUdNlnXcAY5RJZBD
 Gfk6/eI+qXKa7UBj2UyBjG7xVMsx27x68Cfat5CKu0Cmfga/HllV5fp9N1b+65oWCY
 ydFd474vZwoLw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Ana Bobillo <anabobillo3@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@nabladev.com>, Marek Vasut
 <marek.vasut+usb@mailbox.org>, Stefano Babic <sbabic@nabladev.com>, Fabio
 Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>, "NXP i.MX
 U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>, Ye Li
 <ye.li@nxp.com>, Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH 6/6] usb: gadget: f_sdp: refuse unauthenticated loads on
 a closed part
In-Reply-To: <CAJnxHshhuZozN=UmrhQmWHeMndqVtbKgf6fRvh3-HQNMmFqWOQ@mail.gmail.com>
References: <4bdba9dc-0c21-4e33-8f20-2c0a7ebba0d6@gmail.com>
 <3369ea11-628e-4e70-82b1-9a42afd54598@gmail.com>
 <CAJnxHshhuZozN=UmrhQmWHeMndqVtbKgf6fRvh3-HQNMmFqWOQ@mail.gmail.com>
Date: Tue, 10 Nov 2026 11:55:47 +0100
Message-ID: <xhkdba4nhvtu4.fsf@mkorpers-koolstof.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ana,

On Mon, Nov 09, 2026 at 15:14, Ana Bobillo <anabobillo3@gmail.com> wrote:

> Hi,
>
> On my video series, Tom noted that a Fixes tag isn't appropriate for
> populating newly added fields, and asked me to check my other series
> as well:
> https://lists.u-boot-project.org/pipermail/u-boot/2026-November/639710.html
>
> This patch acts only through sdp_is_closed(), the hook that 5/6 adds,
> so its two Fixes tags should go. Could they be dropped when the series
> is applied? If a v2 is needed, I will drop them there. Patches 1/6 to

If I don't have any other review comments, I can take care of dropping
the tags when applying.

Thanks
Mattijs

> 3/6 keep theirs, as they fix the named commits' own code.
>
> Thanks,
> Ana
