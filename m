Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69DB4C369A5
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 18:33:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82A4882B7E;
	Tue,  8 Apr 2025 20:33:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1744137197;
	bh=l+w4nojBIBTq5K1cV9EEqA9D5KqXuIXMBTrkspBwhxQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N1bptX/+ovkkrEnUmZ3tpkuzTko8ZnbIzclGcmaZDm3h4geofHKouWCLGCIe4zXAC
	 lgVjK8WhHTdc+faC24gZSrW/sxB3YQfG6viRxPVEhdG8rx99fPetsh3Hp3vBsUmV1Z
	 kxBOr/1N67iyBiHGocIRX4fCN+Ct/xHRzYg8HlfO3ySajU2w7AMr6cUyn9T3n4LVaO
	 gq9r/KJcw9Gxxqs/Bmipjrymk7BTW7w1Ky37yjoWro558yiH3RFufqnAhw2Jft24tw
	 IY1bDyDkxBpEvUfB2H3/PNesqjcprWLQYpGdtxUBN3UKZL1FMwHtiPMYRUXJSFBKLS
	 MQ5ogM3zEVE8w==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32642831C6; Tue,  8 Apr 2025 20:33:14 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38AF18210D
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 20:33:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="XDusAkyS"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BB39A102EB9FE; 
 Tue,  8 Apr 2025 20:33:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1744137191; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=l+w4nojBIBTq5K1cV9EEqA9D5KqXuIXMBTrkspBwhxQ=;
 b=XDusAkyS+YDrRlsWQd7+S3WZMfjHKp2GuIaMu4yv2cm1E7G7GzvwNSO1x6F7rj7bTVG8Ul
 zOaNsNubc+MTUgozo0wBmCFhScIBJXns2dytmMfG0BHeRjZx5Pokvs8EkofHslG25myw0W
 ZkL/jR3RwqKU5t+M+XSkdoa7hZnOH7csh8cbOtUHsJow9rK9cCI2Q+fzdFwvL9PbhbEBfF
 bmLZkzgojlfw4+y2BQC2KPVtSvZ2T5WTTNEpmQ362mfnNcwUf2AgvhQ3DT9SNrr2LVOEQn
 gk8aI1AT6QI9Wk0czX5trFKhAKwlmKIL6/YgCVVLi/bNQU6sC5klCVgmBcq5hA==
Message-ID: <22188916-aa83-4c1b-a16d-e0c0d208c91e@denx.de>
Date: Tue, 8 Apr 2025 20:32:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] MAINTAINERS: visionfive2: Add match N: starfive pattern
To: Minda Chen <minda.chen@starfivetech.com>, Tom Rini <trini@konsulko.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, Hal Feng <hal.feng@starfivetech.com>
References: <20250403102837.2877-1-minda.chen@starfivetech.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250403102837.2877-1-minda.chen@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 4/3/25 12:28 PM, Minda Chen wrote:
> Add match N:starfive pattern to visionfive2 board. Now
> starfive pattern just related to JH7110 IC.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Marek Vasut <marex@denx.de>

Thanks
