Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32529C5B572
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 15:57:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CA52360AF6;
	Thu, 13 Aug 2026 15:57:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z0o60w2bj6KU; Thu, 13 Aug 2026 15:57:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C9ED760B0B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786636629;
	bh=1x1SkgMeU1aKeO8KRRYDPtsVyrRbTUWp2WZhXhA1MAI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T8P0EEBtldTzodVlAz7ZC8PCy0GUUzkgLGnwHNwQ2cqJbLHP766Wp6EJTROq4Bn9B
	 hPbNwYlZ0oPobNn9Jl5WFZqHEOxCp3/ovPgJy/jphHLjCzy+4Dm3ovfDjg3nwHKBTE
	 QtaqaJWC+62mdE6+yRbSYQGYCnr2wfcZA8RwC4O2UVgblliMCPbaELaV9oZlE5OLjK
	 8fBmCTGkTnajDwM83793AvUaxnTjRU00cblF74hoZ0rlMc0aqXukMTbcKAeBZG2/Ld
	 Lefc+iZVCYGsGm3K7HzHWruVCLwBKmlfS0/1Qunn7t1/1TvbS1luYT1SIm1y3/K4nB
	 Uo/6wylzldJuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C9ED760B0B;
	Thu, 13 Aug 2026 15:57:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4BE411B8
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:42:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3DF2181289
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:42:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jpkZy_83LVLf for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 15:42:32 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org F134A81285
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F134A81285
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F134A81285
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:42:31 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49553515a8bso1195185e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 08:42:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786635750; x=1787240550;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1x1SkgMeU1aKeO8KRRYDPtsVyrRbTUWp2WZhXhA1MAI=;
 b=KS/B8v69eslqjPynSE41dsiY0f6sGRwZI8/9mjkYhIPaMl/Id03YF6LqQkoi+bk76K
 gD2+WB63393M0UeNBQtI+L8olLl2GfSZfYKqjFpT4auDbgaln0CoYSHgjvkzDfJWb5zH
 /L6LwHzfN/JjXF+Qah6VPNFZm67B7Xx1D4VKVZWCom5mQITQ4RHngrNEuSmQDYXA5XkU
 TSpRbCEk7EIxUjlPcl4pXwZ8WlbHYySzgLfeHS9PD73+txvr2YSTcA8OgeMb+QTRkpSs
 7X9YIdlVK35yCxILHUAI31Xzk9GXWXOyWn5d8/RMPCHJ+eE2SuADlTAKo1EFZ125DhuH
 TApQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq9gCnsb2qY3irK4hyLZoYSscsizMDc6hiKJF0mbQBCqiUJq92q3TuQFxyo3JF9PlH7mfD262g=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzQ/SeCQnDOuNpbz0/d4FAfd7sTN4roB6FkMXroNRMKacJPgymQ
 pg30vsW0H/A0JG3k0R87USaPJLGUCgfS8ekDx9XnHCOgJovMJ2A5XVzBc8GpBMsflO4=
X-Gm-Gg: AR+sD13ohsC4CBQVgoTnGYeLl6Zw2Efa6mEGNKzZNI6MpJQHb8IR3hYCGcoEfp3F7pH
 6tizD4Qa5VYcBOlHzrTVhWisG6WXIKTwrGukKATxLG2Sn1REipOf9FJhOFhwbdG+XMShJJsS3EV
 IWw5Is7PhAzGtWonXiTiBQpmya5juJ1dWG+TSgi1m8OYUbhHAFb8dBcjtaTzCEPLFV2oQgz6HbF
 mEJjIUzPIeX4AXt2f30FBcTQlLHCMf2z2bmRFIO/cra3rTCph5pnQGoU4bCvs2UqKUw+7lS32KH
 3nIw0zOX3GDDOi4+DaHKleRS1CULrKaM1rBm/9qri2fQJ7p2qARJjUVMksJbqZtIdwCOZ6PB9Ij
 6zLwtsawdpbUpYXj41TMSwjkbnK/O446S4WS9qdBts/6JMjiD348jUAZHO5Ny6HmvYhdZ50g6rL
 pi/rbHTt4MXSG9iiutNPHaVibTp7KZUt1h+xbYBtepXCVEShMYMoWUSSuYdoDVZjLwQSGAR7h8W
 PdULAQ3DoQKmiw1zIMer2C8FXCPUWK9fpiVx/6uyunk6tn+zxpF6SqlQAOOtLTbxRekJcAQPU9j
 Ip/6DlwDHWzA9HkS4oHZdZeE0JKsJHrOgPQDGZsXFttEbevnVxhEeTs=
X-Received: by 2002:a05:600c:1993:b0:490:c6c2:52 with SMTP id
 5b1f17b1804b1-49982187725mr70446605e9.3.1786635749466; 
 Thu, 13 Aug 2026 08:42:29 -0700 (PDT)
Received: from ?IPV6:2003:ff:f03:8f00:b111:828d:2817:5c05?
 (p200300ff0f038f00b111828d28175c05.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:b111:828d:2817:5c05])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981b03d07sm82828795e9.2.2026.08.13.08.42.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2026 08:42:28 -0700 (PDT)
Message-ID: <f70400e0-9444-4ee4-b7ff-dea8f32d6c86@byteray.co.uk>
Date: Thu, 13 Aug 2026 17:42:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] test: dm: nfs: add a regression test for an oversized
 NFS read length
To: Jerome Forissier <jerome.forissier@arm.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Sebastian Josue Alba Vives <sebasjosue84@gmail.com>,
 Argus <argus@byteray.co.uk>, nd <nd@arm.com>
References: <20260811-nfs-oob-fix-v1-0-5444d86d28d7@byteray.co.uk>
 <20260811-nfs-oob-fix-v1-2-5444d86d28d7@byteray.co.uk>
 <ce8b5c8e-d62e-4e28-bab8-dab2d26a70aa@arm.com>
Content-Language: en-US
From: shj <shahriyar@byteray.co.uk>
In-Reply-To: <ce8b5c8e-d62e-4e28-bab8-dab2d26a70aa@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 13 Aug 2026 15:57:08 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1786635750; x=1787240550;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1x1SkgMeU1aKeO8KRRYDPtsVyrRbTUWp2WZhXhA1MAI=;
 b=IgVeJ6a6XX5lYX6XHOwtjIB2ZN2quThhFHj+NcK9HOUzfxhDejFpJ/TzkC6SULtXf/
 hswr6/DX5cWPeyYCb995+owsvhwB+VTHwgPwryD/kTtvPaZDd9qMZL3mfx4NCPEC449A
 rARWGMgJL6AUgoKiAByA6UCGQ3CPW4PGcHv/RdXU19KaGfS16GIpmjb7yq9GW7NRA7um
 +kEQv5xg4oSwAgJoNh416wAL8QzvuCxNJmzlfQgQAAq63yYWl9CjfdwZrhnEJXhU7dlF
 HXYEB2OdSuGcute6v0BoUtwdeDhtXJpCj4EMMVtU3LLYObOescCORk1VlOs5f1zfFAbq
 3fwA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=IgVeJ6a6
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Jerome,

On 12.08.26 17:06, Jerome Forissier wrote:
>> With the series applied to for-main I got a CI error, see:
>> https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/jobs/68484

I applied both NFS patches on top of current for-main and ran the 
sandbox tests (I forgot to enable CONFIG_CMD_NFS in the sandbox config 
in the previous nfs patch, and the nfs test is skipped, exactly as in 
your job, sending v2). But overall I can't reproduce a failure, the 
failing test in that job, dm_test_dhcp6_serverid_reject, isn't on 
for-main. I applied the serverid series (fix + test) verbatim on current 
for-main (b752e441790) and t_dm_dm_test_dhcp6_serverid_reject passed.

Could you tell me which tree/commit you saw this on (the job checked out 
for-main at 37f4c339, which I can't find on for-main now), or point me 
at your merged test/dm/eth.c? I'll reproduce against exactly that.

Thanks,
Shah

