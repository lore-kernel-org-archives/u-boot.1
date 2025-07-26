Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42304C83F17
	for <u-boot@archiver.kernel.org>; Sat, 26 Jul 2025 16:49:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75C34830A0;
	Sat, 26 Jul 2025 18:49:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="dGqi2Q45";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BC7B830E4; Sat, 26 Jul 2025 18:49:17 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CD1882F8F
 for <u-boot@lists.denx.de>; Sat, 26 Jul 2025 18:49:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 846fc771-6a40-11f0-8592-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 846fc771-6a40-11f0-8592-00505699b430;
 Sat, 26 Jul 2025 18:49:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=xgfQatuZ+Iqz3WCmb0WMkCs0JtN8acwqnKVSIqWOG0I=;
 b=dGqi2Q458YZkCbNF0Jj1bzUEfeGWmPP7GIqAQfJoLifZ6pnagm+FsOvm8DgeJpCrHZQPqtk+6TvsS
 bdH6oeeb55gjXc1CDbjPLPi8vCQbSngHbyHKhb3uYXWx2AaooGfwmQK3NCH0qv9KxG73WY5IxbS+i4
 bWZOTrRJDo37PUmsP66RVTaBQDCO/2Kh/qaRlOCHGQFfK368o4+vTURvSAWZbNGtIxrFYdRjmH/gsv
 Z/8vFEnt0NRcEy59M/Ma1IdPfQQsrIyHyPZtd5kPxOsPKSJ5+gaAShmWueuoWLSwDqZI1noIj5TCwW
 EiGnsv0BULPgqKsG0EDcPfAl0fGvJdQ==
X-KPN-MID: 33|IPjkZTLIKoidJtrZI1p1ziFzMPqazC7vDwm8IRRQun1/TOpM8IdtDrAZPTIS0bZ
 ofsuka36HuS6880ypHpqZcoVbAw2qHSqP+jwJe9Wmwzk=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|HyFzSZHkP+WgA4jcT7HZeudzn/ImENNJvSzKdcV6H7kSa8ML1Qqx1SlV4gZMD6N
 Hepur0iOOxiae2QVAblRMgA==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 75d5d00a-6a40-11f0-8887-00505699d6e5;
 Sat, 26 Jul 2025 18:49:14 +0200 (CEST)
Date: Sat, 26 Jul 2025 18:49:13 +0200
Message-Id: <87ecu2aody.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Enric Balletbo i Serra <eballetbo@kernel.org>
Cc: trini@konsulko.com, u-boot@lists.denx.de, ekovsky@redhat.com,
 loic.poulain@linaro.org, tobias@eub.se
In-Reply-To: <CALE0LRuihERtJ-ghH9OXnFz8Y+JV28g5=nSmnw_LdboWV60=aQ@mail.gmail.com>
 (message from Enric Balletbo i Serra on Tue, 22 Jul 2025 17:48:43
 +0200)
Subject: Re: [RFC] Plan to Migrate U-Boot from OpenSSL Engines to Providers
References: <CALE0LRuihERtJ-ghH9OXnFz8Y+JV28g5=nSmnw_LdboWV60=aQ@mail.gmail.com>
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

> From: Enric Balletbo i Serra <eballetbo@kernel.org>
> Date: Tue, 22 Jul 2025 17:48:43 +0200

Hi Eddie and Enric,

> Hi all,
> 
> As many of you may be aware, recent Linux distributions (such as
> Fedora) are removing support for OpenSSL engines, following the
> deprecation of the ENGINE API in OpenSSL 3.x. This is already
> impacting the ability to build U-Boot with hardware-backed signing on
> these systems, and the situation is likely to become more widespread
> as other distros follow suit.
> 
> To address this, we would like to propose the following plan for U-Boot:
> 
> * Introduce a new config option OPENSSL_NO_DEPRECATED.
> This option will allow building U-Boot without any ENGINE support.
> When enabled, hardware-backed signing (PKCS#11, etc.) will not be
> available, but U-Boot will be buildable on distributions that have
> removed ENGINE support from OpenSSL.
> 
> * Add support for OpenSSL Providers
> Migrate the relevant signing and key-loading code to use the OpenSSL
> Provider API, which is the officially supported mechanism in OpenSSL
> 3.x and beyond. Providers are the modern way to access both software
> and hardware cryptography, including PKCS#11, and are supported in all
> current OpenSSL releases.
> 
> Arguments for this change:
> 
> * Future-proofing: The ENGINE API is deprecated and will eventually be
> removed from OpenSSL. Providers are the supported path forward.
> * Compatibility: Many distributions are already disabling or removing
> ENGINE support, making it impossible to build U-Boot with signing
> support out-of-the-box.
> * Security: The Provider API receives active maintenance and security
> updates, while ENGINE is legacy code.
> * Flexibility: Providers can support both software and hardware
> cryptography, and are more flexible for future enhancements.
> 
> 
> Impact:
> 
> Users who require hardware-backed signing will need to ensure their
> provider (e.g., PKCS#11 provider) is available and configured.
> 
> The transition will be gradual: ENGINE support can be kept as an
> option for a while, but the default and recommended path will be
> providers.
> 
> 
> Questions for the community:
> 
> * Do we need to maintain ENGINE compatibility for a transition period,
> or can we remove ENGINE support entirely and move fully to providers?
> 
> * Are there users or workflows that still depend on ENGINE-based
> hardware signing that cannot be migrated to providers?
> 
> * Any other concerns or suggestions regarding this migration?

Please make sure that it remains possible to build U-Boot with
LibreSSL.

It is my understanding that the LibreSSL developers have no plans to
add the OpenSSL Provider API, so I think that means making that code
optional and only enabling it if the libcrypto includes the OpenSSL
Provider API.

Note that LibreSSL already neutered ENGINE support.  So the existing
code that uses the ENGINE API will fail at runtime.  That hasn't
caused me any issues, probably because hardware-backed signing is
somewhat of a niche use-case.

> Next Steps:
> 
> * Add the OPENSSL_NO_DEPRECATED config and update documentation.
> * Begin refactoring the signing code to use providers by default.
> 
> 
> Note that we feel comfortable with adding the OPENSSL_NO_DEPRECATED
> config option and can proceed with that change. However, we are not
> very familiar with the details of migrating from OpenSSL Engines to
> Providers. Any help, guidance, or code contributions from community
> members experienced with the OpenSSL provider API would be greatly
> appreciated.
> 
> Please let us know your thoughts, concerns, or if you are interested
> in helping or you are already working with this migration.
> 
> Best regards,
> 
>   Eddie and Enric
> 
