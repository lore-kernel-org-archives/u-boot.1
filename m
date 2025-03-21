Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56467C28B30
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 03:11:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9D0E80756;
	Fri, 21 Mar 2025 04:11:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742526670;
	bh=BqmLU/shFVbGg0wx8pN1nv1wKn7C6+0fM9GksflV6YE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nEE3L6NGfJn1YTZVAEW141ZIPQhZJ5JE50RwVV4xgH7LvTRJjEzwsnXyhRg3TdWtU
	 WO+hdgGtzWt64NdpB5lfDEl2E9NaJ0Tmw2HkBPRYv2syAelJnvDJBXxJgZ7v+XntuL
	 mkHrTfU1uHiKJNRSzxx8aLAyqkUw2wTBmzeCJXkp9v/QWI/9ko6ohmkGGDSRfaAhJ1
	 nsutRKXvDEOTmfOu5McCf4hw463kxJosywnmAvM6YXQMA6lJX0IM1tvNWwiDQv+81Y
	 k0Pta8KjjDIQIjO2v7SeQD9MGNiaMxgEvsA+UVeynyRyoAITlpAGIelWUJ/gBbozVM
	 tusJe/Fph2IDA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEB79807D7; Fri, 21 Mar 2025 04:11:08 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82821803CC
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 04:11:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="eHA9a8QS"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8F60D101E9152; Fri, 21 Mar 2025 04:11:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742526663; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=BqmLU/shFVbGg0wx8pN1nv1wKn7C6+0fM9GksflV6YE=;
 b=eHA9a8QSWedq1YUn6sxFVr2t85WdqXRdgidIPT4nKQDX+tjb62Anxdj7rTw2UkaagNfhTU
 /YTLGr2kK36cqR+Jjkotq8B+SmbK8NWW2cTT02XOEt987Ug7kT3j5zfFcFNd6ZV4PwrrBO
 NToNuqkB4HC07PupcSioE4cbb2srlQoCluDT9FLS6YO6aLrVlYke1pjTNOYFWNS+7Z2MHS
 noex/E07X3M2Vfqc1tXPNp87oSJ1IFXkNIRQ0gPmmFGLfWgjhoMwk6D3yJ7LOQUWo6dXQo
 4P2FrRYSH5NMiNCD1y9LiwmAGcHG+D0TNOyJ4OmnhEd0lpvvS4aN0bb2zBz4jw==
Message-ID: <8076a375-4779-4822-9ebf-9a865e6ea257@denx.de>
Date: Fri, 21 Mar 2025 04:11:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] tiny-printf: Improve %X formatting
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Benedikt Spranger <b.spranger@linutronix.de>, Simon Glass
 <sjg@chromium.org>, John Ogness <john.ogness@linutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "u-boot@dh-electronics.com" <u-boot@dh-electronics.com>
References: <20250320190147.1050427-1-cniedermaier@dh-electronics.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250320190147.1050427-1-cniedermaier@dh-electronics.com>
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

On 3/20/25 8:01 PM, Christoph Niedermaier wrote:
> If tiny printf is used with 0x%08X (upper case X) the output is
> always 0x00000000. It could be confusing if upper case instead
> of lower case is used intentionally or accidentally because the
> actual value is not output. To avoid this confusion, treat output
> of %X as %x. As a compromise for tiny printf, the hex value is
> then output correctly, but in lower case. This is done to keep it
> tiny printf small.
> 
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Reviewed-by: Marek Vasut <marex@denx.de>
