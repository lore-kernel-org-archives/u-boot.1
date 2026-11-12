Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1454A606A31C
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 06:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=W1XdNGJc;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=KRbBEczh
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 98373608C7;
	Thu, 12 Nov 2026 06:16:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A-HJbLlmA4yt; Thu, 12 Nov 2026 06:16:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E45E360897
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794464175;
	b=jBLU97P7XUlLCuYYPSB6h8q55WDQIVwJf+7GQ9jvlgdM9duWBa/Yp+dJ1GgbfmWsNxQf
	 KdI4qywre5outbFDTikI3mnMzuU2rYXO50mgr8GzwkWgUKC1dC/xp4sN6W9CQ2EO1aPYw
	 z3EftbRnBYqdaGZdA2Q7YVKILdOEG9G0VjldXYyVS6eXPxnllx5dLMKv/5tyQ/+ORThKO
	 cC5ocUwAhCWESOyp51YOysj7ZdA7wz8gr5jxX93Vo6ycBbaXXMqrTfOC9dP68SovRxp/v
	 P26dwaszl3z28Kg4OO9K1ySiV7gwJax9VTE4ZrAq2yIx8IPQ8yYY97U3V0BCm6MHvNA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794464175;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=u+5s4y+4M4zU1A1RMu5h4cD8Ij4WuvTPd7PuYWSTbVk=;
	b=MMIWza0r/9ti0BslQAtp61KidIkMakk6wj654z/n9n8UdIg/Dcy2FFasxuebckKB7ZVf
	 l3n98+czqRUFs47+rhEMWfnJpEkxswJAAKcl+INKE/5zvoLNOYR1cjiNI6i7gE4H4mcHJ
	 Qz4t8xS4xtKzbGabswSX19QrGmBX7ZzBiugE2diWWzHndYNOXUhxmP2laNVHP8LIOGjLs
	 MI2dP1gplQamaG36fEXPoQ7+d8Vxok5YDwPKnU5g/9/IqWlQZ+V0WPBveMgPt5to/o9z1
	 x4+UX8QVOpIxDzkphE+ZX1JLKjILGuNTdCp/Zg+3fIJCWRv52GMfvfhjYh9hDGpgoIg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794464175;
	bh=u+5s4y+4M4zU1A1RMu5h4cD8Ij4WuvTPd7PuYWSTbVk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W1XdNGJc+mVRCniFI5ZTSQG3qGSB/aEBSC+wu5fI2nCZyUt8pJCOEPOjGGCQVQJjM
	 Pkg5vxUMpBLDUFMs1N+AHZcQ4OHCYUxP6tAkTlcAXF127ujy7moboJllf+wnVG4ybD
	 x/jrYXCmDQJsVjGVNKzbgHOLl46hqFAH5trAOHf4kE2+IvOEiuMwQW68ry7HS4Pb3N
	 zDiy2MJInYNmPAGlPIwyrMlx1vxII95CfAnohzYv1bg7VwZmLqC6ESEYsGOrATcIak
	 gNrsm47yIzKVr2SOvBXXbQaYtRzfsLH1+llxICshnrCEWAhAwpIPs6aTYq/Ryy1DqK
	 RE7lgQ77Mr37g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E45E360897;
	Thu, 12 Nov 2026 06:16:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E6E9A70B
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 06:16:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D85D6815DF
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 06:16:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3ek7inXEI8Pb for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 06:16:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 138D381404
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com
 header.a=rsa-sha256 header.s=dkim header.b=KRbBEczh
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 138D381404
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 06:16:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B726110E053; Thu, 12 Nov 2026 07:16:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1794464166;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=u+5s4y+4M4zU1A1RMu5h4cD8Ij4WuvTPd7PuYWSTbVk=;
 b=KRbBEczhL9cqT4ifRxL1SEvEOR+Ve6YXqxGgAneiPtK+3WAd53ST9+NIvVtzS+wOYb4Ho+
 A/mFX501lYiDHgtvfQ+AaO5kVm6VZbMT7m1g3B49NT1gJptWvWmXk6++gnQOOJ0KQNil0R
 paiAosHT6OGEKaVOQRRn1X9hdlfIacaflhADh+Kn+Lks/GjiayfONgwXKK4QH9+AqBHHXL
 eRvFAvq3WthL02AmfaI6JvWDgHzc+hmc/q2AzS/11ogm7wXXGq8RHX2oQGIgjCXuYgIWLV
 4YfYng90JvTBLaQPQEd698wKrIWI90kwM+gHI4qEavS01IVWfgVltPSDw1VV+g==
Message-ID: <8f8c6cb3-4069-2165-d799-afbdb3228fa4@nabladev.com>
Date: Thu, 12 Nov 2026 07:16:04 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] i2c: at91: Probe with an SMBus quick command
Content-Language: en-US
To: Robert Marko <robert.marko@sartura.hr>, ehristev@kernel.org,
 trini@konsulko.com, u-boot@lists.u-boot-project.org
Cc: luka.perkov@sartura.hr
References: <20261106132031.966174-1-robert.marko@sartura.hr>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20261106132031.966174-1-robert.marko@sartura.hr>
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Robert,

On 06.11.26 14:20, Robert Marko wrote:
> Zero-length transfers currently return success without accessing the
> bus. This makes every address appear present to i2c probe.
> 
> Issue the controller's SMBus quick command and wait for completion so
> NACKs are reported to callers.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>   drivers/i2c/at91_i2c.c | 9 ++++++---
>   drivers/i2c/at91_i2c.h | 1 +
>   2 files changed, 7 insertions(+), 3 deletions(-)

Do you have some hardware on which you have tested it?

Reviewed-by: Heiko Schocher <hs@nabladev.com>

bye,
Heiko

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
