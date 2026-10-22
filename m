Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A94606A31A
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 14:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uOSwTzsl;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=t6GEeKrN
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B8A7D6063A;
	Thu, 22 Oct 2026 14:19:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yvS6mpJamjfD; Thu, 22 Oct 2026 14:19:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F29476066C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792678772;
	b=lzJbNqasnKNTeAls2a8PCmEMYb/5bKxIytT4A1EJM3AauVH4gi8X3Z/261+KetevqBIj
	 22bvQHXDi/XKUI8hPLHLJTzQb8/+IPgc6eA+O/uByrfMgpZskhoS6HVv9vE6XzJ5ijOkG
	 9bk8BZCvU9ylTr4yfVzGl1L9d5uFWtmZ3GlktabsASyUkjjUiU6jDyyBqJugp37GFlNNn
	 x1MUoY/baAhAU9R0b5Hflc2cr3m8smezAy3suNCTXJjW0eoOX6zm4Ao2RtK7Bnypyz48e
	 m1YRDM55hek9/2Fe81lM76yJqYTjKhul5voNSTtog2Xh8UscwfgRhYm0CmHWPlaAp3g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792678772;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Loy/Sd9nK5m+wuizVqMtIfviSj1OzlEhUJ5usnean3Y=;
	b=c/Rf2U8CJjOuArS2DP+PAkM4AZylZvEsjaiVev2ar8gvZhAovuwRoBV1gUvndzHqr/m7
	 TSCRQodZaPJ8FNqahvqp6ZmQEstBmGUVa7kFKyi+XJz5OIPZGYmglbpClEhQdIeIwgjTS
	 oYbBu8mju+odG287fgACKpPzTQBLLF169Tpqo8LS0cXih8yBczdW59jjzzuYwDmx8Ud9u
	 aN3sQwLJwNrdu6w+wwE/hEu+O/dJobeLkz9WioZe3uS9sViUcRcRIPO0PfMP7yYBhWGhc
	 CgWaknP/aWzQ51U/Klb2ZfNis6Mldb7d39b7zD4xAS4Ft6nzIgGHIhx4Ipr6wDIFKNQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792678772;
	bh=Loy/Sd9nK5m+wuizVqMtIfviSj1OzlEhUJ5usnean3Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uOSwTzslB/ISu3engHuZMgMr9/gFX50kGSHXEYmyfvvUHos35v7ZGBw3MP/viRLBy
	 FgHe8Zm8hz49edg/JadyDDxe9JPZv4HK+9gwkXKIspvZZHGgmgAU1TehkpJtyzEnbr
	 ll88j21S+D3Kge5U5CXw9b/LjOdLmOR1Fmc6qn+vk77EqG5Surc9LFYCe8ldGc+Ind
	 MrCc2TffHzI1CLg0DsfntTRkh51qT67wlG+jlh5U0JS14I6Fy8lAVmR8lRSFSFwWmG
	 C4hIq60xsZ88bMT6cByvqJmAVfdeHP4Rbyn3MQrgtYIHlD7BvEB8GA2NjFOeFOc9cq
	 eA4gDYsexlIQA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F29476066C;
	Thu, 22 Oct 2026 14:19:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 985002A8
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:19:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8A3DA80D9F
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:19:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9M9767THoayN for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 14:19:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DB49E80D5B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792678764;
 b=Td/mJf14nN83Suy4SnJoyfPC9bBNayTEF8CQd4+gmDJNOpU2bhv157iRwi0iUgMG3Jtn
 tg8djiou+scVPpS7mI39xPljm/ypJIf/7oxcKMieVL8sLNfxtFxoqQWyla4+4618hhVAP
 YedfAM2YqxVBfQF9AEa96HHmUR4XllXuT7SRS9WR37sVXdPAMoYvJNpZVHRAVRrtG0rzp
 RaQpio0jynCNNYcz2rVfg5l3CRcXNVP419bgNdIZ4azhXMmazJFi84mHyYHkFJN/SjO0A
 IFiyW+1eExe6m9Qz2gugD4HIHkEgt5yMv3S25vf29QKSbRXDl6PDUXa02BI78Bqbj5w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792678764;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=Loy/Sd9nK5m+wuizVqMtIfviSj1OzlEhUJ5usnean3Y=;
 b=DgXm0pOTv5pqTc9kpBYVHm4qB1IYj5aN6AhrCUkE2vFqFmdwv9Ic1Llc0Z1XDl4KXt9I
 ++hrs2n/kiRfi/mSNQcDmSPvq2B8FdxYHRne7efcgXcMkHbiN+gIPhv7w4fy+cJQPNJIe
 OujSIwVub6XNBHkrrzlD1EAQ5Q2dJGINc48DaKHQ8jMp/7psG8t43ThThrqqQRUZlYApY
 7UWgiVGbZG9iSwAj6kwtiUYmKjwpFlztl0tdmps1IODXIjvBkKpt3SoZo0gEioKVQCkcx
 F8rXkkibv4MksO/061ZnobTo3PMJHP4HLB+MkTNF9HMylgOniZP3FfeOm/UEWZQ006A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=t6GEeKrN; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=t6GEeKrN
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DB49E80D5B
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:19:23 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-82380b0f55dso936965a34.1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792678762; x=1793283562;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Loy/Sd9nK5m+wuizVqMtIfviSj1OzlEhUJ5usnean3Y=;
 b=t6GEeKrNQodlECmsc9zbwet/3sKC6Do6Ht3+KFfH1hSkbPeWDGh6fKbwqk7lR2pUji
 GU5gecy+q8m2ctYFDVu4sk/gVbrTvXRExhjtber1oj9enKHrYYJuOmjLhnJSHu7itmXi
 NycVEjAleclsArSqiM0r8ECeIJP8AGBolrzHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792678762; x=1793283562;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Loy/Sd9nK5m+wuizVqMtIfviSj1OzlEhUJ5usnean3Y=;
 b=Bzav9bwnJnrgtIymXIThuy2/4yeTAgYoEq9jMTTCf8wErkjD93NkTW4BtJkBby45H9
 T05dz9g4CoTrvdeoRLrkxV3fnVB1blh4lZKVz5TII3yUdCX0VvuiOIdnv16rGQAvtQv1
 sHZ0vqsyeg80SUp07cxklIfYS8rCxdAW0CCYqj38vfPzq3ot0e3eXhVfW0IvUXbZ8DGF
 /jesqa4x6aJ7YRAtQ4UNHqaOsGJlsnIEmKBAf0Ekt6Tu0G3ssiCWQqFMHaXJX7vQT2ns
 7tcVwgAgd/RAYnh+3qUZlwQHH5NVPAcNZ+Dn3DbGualSJx+hVAhzrK1TIbkAJIBIFtWb
 8qNg==
X-Gm-Message-State: AFq9FYKMlK5656gE6nywgNdai/MfpbZHOB/I8nNcqIino+Pu34dmReOE
 ZzW1M/8l+9rSM2znMnetxKxjudz0mFvXbzEiJgRz0pwqIf7nET4H9EDnIliL0JD7Y4w=
X-Gm-Gg: AYBFou3vkL1Vq+Ilr+dYQnQwcIjeCr69lgiLQYX4/lIyMX/yhMycAsDLf5KOrj96l5L
 VjChmW/jvgtEhdACWpjFrM7kTTsvZCx8xvAv0XMAjj6Bw22n0trnriJ1N2dZlgp0uvgh2jSnTtU
 StP4znlf1+xXo5YjSuPNdRxFXihFhL+v4knJQeq3jJqzQo6mMFDAcjBEe8EShSLu5nxjpD2OKlq
 JRL9axzzoTIOdky3iOiL6uQevrFK9aUtapCqmgBYt+y4458hVZnXSUwV1EshV2L9bHStnPZODoq
 mtqvRZp8Ee+1hAB0IlDhuDtC87Vc46XrPNxWl4T23bZq7TZ+rcga+juzD+irDbeXMSfXzI9f17I
 zIB23aeRSUIyEn4HcU7FqMuT5zHan4cwZ3tacCeLZnOSvi7uZHbHXoWK9O8ogTOSgFhqF+wsnHM
 Xe0I6tz4hOEP3lxFQSW8GDH7Rx8HQyjnQRWrMPKV6OT1f8RASxcbsrPva7RXMYUM/xSNQTNjpNL
 A7R/UhRrKVoDe6NAvvv7fJLfcOZQffhjUuWBPcN1QwSp7VHHZWqel6z6HIcN0Qyz7l8gI2rdJEz
 zyNZCxj4N69KOYd2cn+0VEmtzqNFHH+TaCJ8WLwuR6amxkUT+vxCfKf926rHItD6bDuhTe4lwPn
 qOQc9vXdToWl+nE4+wIfK
X-Received: by 2002:a05:6830:82fc:b0:816:b03e:f9dc with SMTP id
 46e09a7af769-84d0810ae5fmr4285714a34.5.1792678762560; 
 Thu, 22 Oct 2026 07:19:22 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-84cbd2d2a76sm5506744a34.18.2026.10.22.07.19.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 07:19:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, nacht20-de <nacht@dxdmail.cc>
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Luca Weiss <luca.weiss@fairphone.com>, Aelin Reidel <aelin@mainlining.org>, 
 Sumit Garg <sumit.garg@kernel.org>
In-Reply-To: <20261003222613.501602-1-nacht@dxdmail.cc>
References: <20261003222613.501602-1-nacht@dxdmail.cc>
Subject: Re: [PATCH RESEND] video: simplefb: only use stride after a
 successful read
Message-Id: <179267876180.3588521.7776883002124293369.b4-ty@konsulko.com>
Date: Thu, 22 Oct 2026 08:19:21 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 04 Oct 2026 00:26:13 +0200, nacht20-de wrote:

> The "stride" property is optional: without it, the video uclass works
> out the line length from the width and the pixel format. But the check
> 
> 	ret = ofnode_read_u32(node, "stride", &stride);
> 	if (!ret || stride)
> 
> reads the local stride even when ofnode_read_u32() failed. The property
> is then absent and stride was never set, so any non-zero value left on
> the stack is used as the line length. Clearing the framebuffer and all
> drawing then use that line length, which can reach memory outside the
> framebuffer.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] video: simplefb: only use stride after a successful read
      commit: ac56bf9b03646b95fe6bd99630be518b1e43357a
-- 
Tom


