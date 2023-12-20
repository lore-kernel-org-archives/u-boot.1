Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F37EC46CD3
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 03:31:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAA0B86E65;
	Wed, 20 Dec 2023 04:31:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="O8DhhivN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A98E86FF4; Wed, 20 Dec 2023 04:31:46 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4381B86D2B
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 04:31:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1703043103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xmZe9WTkoPXGqC96rHaE3B8rE/pbtyCvJbGHXN22xPU=;
 b=O8DhhivNQsn20EjObbVDYnbIa17q1KucZQTr4bqNtVp3eJxIbHredto92K4eOxFy/kCCbA
 dCjtATZLz83eNreFgKf3YgNDqyXwPWXNdjwJkirjUf7KcX3ca6MVhr2cauaJDF755cBKL1
 JGbafHNm+68OCpBxFl3AxYdazi1tIY63zFL/6A681a7KdprlprmTeFrE6IRsqHb1W6vfne
 h/kyj61rRFZNoj7eMuGKZt3DRpAo0hXFqQO+R3pwG7wF6p1rECou0qXno1wo1JwSv30IAB
 ULNtE1iLEdK9Y4dq5fImg6Ub464bWYqPu2jvvrkDpHZC86F4+zowZ/Q3lrCYTQ==
Date: Wed, 20 Dec 2023 04:31:43 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: =?UTF-8?Q?Cs=C3=B3k=C3=A1s_Bence?= <Csokas.Bence@prolan.hu>,
 u-boot@lists.denx.de
Subject: Re: Passing boot logs to Linux?
In-Reply-To: <ZYH-K_UGat0yWMVH@makrotopia.org>
References: <6fd0dd4c-4bce-47cf-a669-7d093b9a1f10@prolan.hu>
 <ZYH-K_UGat0yWMVH@makrotopia.org>
Message-ID: <f3c640e859b542c287ad2b66e0e04b74@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

On 2023-12-19 21:33, Daniel Golle wrote:
> On Tue, Dec 19, 2023 at 08:08:48PM +0000, Csókás Bence wrote:
>> Is passing the U-Boot boot log to Linux supported yet? We are working
>> with a third-party solution, which works, but is a bit hacky, so I was
>> wondering if an official solution has been merged yet.
>> 
>> I saw that there was an option CONFIG_CONSOLE_RECORD that saves
>> everything to a membuff, but I don't know if that can be exported to
>> Linux yet. And if not in the tree yet, would such a patch be welcome?
> 
> To me this sounds very useful and definitely something we'd like to
> have in OpenWrt. So I'd volunteer to review and test your patches once
> they are ready.

I'd also support having this feature.  It would be very, very useful.

> What comes to mind is that CONFIG_CONSOLE_RECORD also captures ANSI
> sequences during menu or count-down before boot, so we'd have to either
> introduce a dedicated log_printf() call and use that when ever we want
> the output to also become part of the log buffer or we could somehow
> filter the recorded console, eliminating all terminal control 
> sequences.

Hmm, that's one of the associated challenges.  Perhaps those 
intermediate messages, such as the countdowns and menus, shouldn't be 
recorded into the memory buffer at all, but just the final outcomes, 
simply because that's the useful part.
