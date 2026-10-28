Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559A5606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 05:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JfOXvvoM;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=Xs0XFNOw
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C2AF3606A0;
	Thu, 29 Oct 2026 05:40:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XDWJwMySSvxv; Thu, 29 Oct 2026 05:40:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0CFE76068D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793252446;
	b=ch55XDVejQ4RL2/V9iifsJc3VuSz8DJZeSyIPVqpvfUrN8hQFBT/11n5Yx9DaMYKABFb
	 7G1AyldB78TgHQzc2R8LW29Ww4ynHGmdoHL+GKWvDSmn+FKxrj0SuJZHzPuft1g4s6Efg
	 fcOricTpLtWStKGHrtsXYqBlvO7T2EW0sMY/GU3slCfFHncGXzVR0nTgskbk2nV2NsWwU
	 KnYtWc+JO1uhtPLYQmW+1zn75yXhFGUJplBiSYVfNN7CKC6IZ+yyBSWEpX6onG4qAY+Oj
	 mlpaZDpSnbVitDoimAHNjabetcOZQrYI4h3IqkFOpgUc+KRTIz8dZFmjcifBzp3u3aQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793252446;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=rUfuqj4Pq8MdbITJ8A7RNja5ghRNfZyeuI1340YyKOE=;
	b=ihOj3dbPcBw6MrDyZHKPmh3HziYGKbRVAbvPS+65LdiaCbeogC+GxTXUkVNP5QBBXUts
	 qqRlWN+RWJpegS9MhX5aA3IxFoL5LE6i586zKbbU5ETjCFQawYQM2qosMnanfaz3wWycH
	 tMTw1p4KI8htyDcv9wzgadudbUbxmQ1dz7xLKDuABVsyKuNMrpl5a8QsJCwl37fGq4T2G
	 HFO0RmkHwm4GZM3V5+LUTXzZ3LwV5/WLwGLsKt/1ysiB/b6KM0Y+TOhioeJxad7bG/yMl
	 cZi1PJDsylOvDGUdQoNWFwV0DecZ8hYNn8ZiY9WLpJ0acWqL+6TLLhHRiEapumDP/cw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793252446;
	bh=rUfuqj4Pq8MdbITJ8A7RNja5ghRNfZyeuI1340YyKOE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JfOXvvoMXKcINJ4t8WaqCbl38zm3ycvj6o5myyzgQDKourgmQopRDsKFzL8qmJhyd
	 345E3xUni/e4iYvbEGzoQ5aobewitwdjbwubAuSdBPND33vwLgkeXxspZ7graGTpHe
	 NrgxgtZWT5wI5VN2EjEmUvLyJTDsjMLoPlmOU4ueEgR1+YY59mBk2VKcddX3pQEVJf
	 PY5jRkU8mE1+goHSRPClmaMlmGa7gtCr+tSXE3p+hsyaEr1NZnWoMRxMWwWgM2kYfJ
	 2QxeH6weYwJa1cqHMpoHUuMQ61fJO+CIo5IS/IcIhvun2KKka7U31sluXom47/zF5u
	 bQR3afHuMgrhA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0CFE76068D;
	Thu, 29 Oct 2026 05:40:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E2C481DE
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:40:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C8E7880F47
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:40:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LPcvPvY9i3aB for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 05:40:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0B41680DFA
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793252444;
 b=OYO3GsPs+/xHzBwkQVQBPuklmXTHM1SvJwqa4wDU7dqTAEUGeUMfEEkTd/6gRrJHHGKB
 xH8YwnyWPp2LqOqCn80VC6QQAuDsrCPnRv3ZB1ww+w45ZAHFc74fdDp2qPzzZumoUJJdf
 vZmm/QYYDBBIZRYDCPicII/EXdiZ++4iurxoFiYkIjCb/rzoJhpqoKZVGpX+FjaOwo6T8
 Ae17PY5iVWu+sdpFEf6L4CL3BDtpvssmpUSr9mpoCEjOgI9XOABu1QbO+rTxI8Dn7h6Ic
 /I/t1+/kPCkdJYRLdubYkYKaVIVZ8WboD/w6+vo+hwu7nHsOI8hYWAj/XY+tU9ZNScw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793252444;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=rUfuqj4Pq8MdbITJ8A7RNja5ghRNfZyeuI1340YyKOE=;
 b=K+1Tk80BY6P22XfSJ9Zoowd99e7YaBC96RMeDeKAEtzIA7ymPVHOzFOiIZ56QDOU/WT8
 DSsKWDMirM7mYfCzLZeNHn2ERwchxIkgpWgrgdTYZD8exZTb3LBeIvdY2eoXoK6EEnt+e
 G2/Ie5F1CW67tN9ZL65uB1GEGEZFWgZJ47LviNpRCeQaM29D/V7b2U55au84KGyOdudQz
 z4VHJ5rUmFSsM7Q5nwKoO1wHTSOTNzW+5XcCQIfqqNQ4Q0IUyKbgWKyAyvfkgsFhVNnDg
 Btjm+kzYVwntKyTbRdM4a+rv5a4AKN4DeoVbZVGcFDoj4cYFci4tIaagWP7h2fdHPXw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=Xs0XFNOw; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=Xs0XFNOw
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0B41680DFA
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:40:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6D21210BD2B; Thu, 29 Oct 2026 06:40:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1793252442;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=rUfuqj4Pq8MdbITJ8A7RNja5ghRNfZyeuI1340YyKOE=;
 b=Xs0XFNOwfGoRF7pjKXOx0LrqbMMN1v/Ll6NIAlY+hwCbAYX0cvy63fh/sOVj8lCNlvtCkf
 Zy7dthhiPzLb5xu9hu/KQ/HxGfLfhV12AsXeszVls6KQ9C1XRCYvTycU/0aBdCDVBtcJwc
 MBvjAJ08Dp3rj9V0ZlNTdhqBTFKz3WhrjfZJ2ZXoDEwggzoAEllh6zrnmsodj+wL7lzg0w
 CngzdkFPrgBrxgqsCbl1R0eHMXfMbzx8r+0i/jxdQe81TCTh8aKFxrfaYki2KpdB9XovHu
 WHpCcdkmmEVmRjB6JEaOVD8bJGtqMIDiYx1HuU+XkdYAPo75765QXvoY6aZNdA==
Message-ID: <54c3356a-5e19-4664-b189-904cc84b11e5@nabladev.com>
Date: Wed, 28 Oct 2026 16:17:36 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/16] usb: ehci-mx6: unconditionally run usb_oc_config()
To: Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Mehmet Fide <mehmet.fide@gmail.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.u-boot-project.org, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
References: <cover.1793091394.git.nora.schiffer@ew.tq-group.com>
 <9a416f0664c8594c0af0573b5385dc4cef7e2dcf.1793091394.git.nora.schiffer@ew.tq-group.com>
 <523b0b3b-f260-41bf-8455-b58acca52b03@nabladev.com>
 <79648af2133070a0f6fd9273b7b5870c79fdf2b6.camel@ew.tq-group.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <79648af2133070a0f6fd9273b7b5870c79fdf2b6.camel@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 10/28/26 3:54 PM, Nora Schiffer wrote:
> On Tue, 2026-10-27 at 18:25 +0100, Marek Vasut wrote:
>> On 10/27/26 10:39 AM, Nora Schiffer wrote:
>>> On i.MX6/7, VBUS enable and OC polarity is configured in the usbmisc;
>>> there is no PHY driver handling this. Always run usb_oc_config() when a
>>> fsl,usbmisc exists.
>> Would it make sense to add usbmisc PHY driver ?
> 
> Having a separate driver would make sense, as the usbmisc is a separate OF node
> with its own compatible. Thinking about this again, maybe not a PHY driver
> however, but a UCLASS_MISC - on Linux usbmisc_imx is a (subsystem-less) platform
> driver too and it doesn't really implement any features that would fit the PHY
> subsystem.
I assume that usbmisc driver could also be reused by VF610 , paging 
Mehmet on this topic.
