Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F2CC83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 16:06:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3913833E8;
	Tue, 22 Jul 2025 18:06:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CNe7b4qV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C63C1833F1; Tue, 22 Jul 2025 17:50:13 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52A82833E8
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 17:50:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eballetbo@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 6095DA56277
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 15:50:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132ACC4CEF1
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 15:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1753199410;
 bh=xLz7WCNBqTTGgIhq8b1WnpJF7NNFo1q1gCBiEdtXtOA=;
 h=From:Date:Subject:To:Cc:From;
 b=CNe7b4qVPZTPxMT08WPhaMOVNxwLhw1kFomckYd8zNp8Wk9Siuy/UzhVyxcbhczCZ
 zkSj6fX/6YXVlvu7oIs9U5M7gzlmmWen3HL6W7pIZqJDaVdf9noqJl4jnxDjXapoPd
 ud0SsXJBvnpjswsjxnHffecMb6O8jKYVtcgdsh3Co2ZAPCTSTjEUsqbaKPsCphKSvq
 j7rcYl1z0PgXKDZhnYP8u5it50d4a95gMAdwZmY797mM6xeGC4HMUOTLQ/YiXgIPam
 qeOxq4MZF28dJnRPnLHONmoGW4O/uRXRA9OMDasz9ApnLeNxYLVz3qcLMNpEMt7Xpn
 wGxmoZV/hNH1Q==
Received: by mail-oa1-f52.google.com with SMTP id
 586e51a60fabf-302db17fa08so378615fac.2
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 08:50:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUr0JaiVyEct2PiYFgfSJBfOLdP9LUAj2IzeZyUAXJEMf0SLlWosugu554Kr6AWwZvbMwtKgPw=@lists.denx.de
X-Gm-Message-State: AOJu0YzYxwWdpFFIp2zYKhPkWYPQOrp1yDth+AYYAJiyioChYbv+gE4E
 kMoQ/k4SCbiyjvQJzaPZycNeEUbi43WTUK0hfwWa4royf8KOoUyco5o4/UVbcb4ovYwsqHB+Dxm
 7ngN09SqO7hJfJ+YjOKqkWxXvocoonleER46AP4cX5w==
X-Google-Smtp-Source: AGHT+IG7L8ApYzB5/oOzwUfuGk2jmMYryZ6EbJUZrBGqFA3ddyHqv/sy+nkir08ItkVEZDZCHJBwf6CZbVv/Xsjtzoo=
X-Received: by 2002:a05:6870:f705:b0:2ff:8956:fd38 with SMTP id
 586e51a60fabf-2ffaf24b5b3mr7450444fac.2.1753199409249; Tue, 22 Jul 2025
 08:50:09 -0700 (PDT)
MIME-Version: 1.0
From: Enric Balletbo i Serra <eballetbo@kernel.org>
Date: Tue, 22 Jul 2025 17:48:43 +0200
X-Gmail-Original-Message-ID: <CALE0LRuihERtJ-ghH9OXnFz8Y+JV28g5=nSmnw_LdboWV60=aQ@mail.gmail.com>
X-Gm-Features: Ac12FXx9L8aGcb8yIx3uhhinrBAYAkfvpP-V-QqPYnvQLFgxX_ddzfh2zMlBNYk
Message-ID: <CALE0LRuihERtJ-ghH9OXnFz8Y+JV28g5=nSmnw_LdboWV60=aQ@mail.gmail.com>
Subject: [RFC] Plan to Migrate U-Boot from OpenSSL Engines to Providers
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Eddie Kovsky <ekovsky@redhat.com>, Loic Poulain <loic.poulain@linaro.org>, 
 Tobias Olausson <tobias@eub.se>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 22 Jul 2025 18:06:36 +0200
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

Hi all,

As many of you may be aware, recent Linux distributions (such as
Fedora) are removing support for OpenSSL engines, following the
deprecation of the ENGINE API in OpenSSL 3.x. This is already
impacting the ability to build U-Boot with hardware-backed signing on
these systems, and the situation is likely to become more widespread
as other distros follow suit.

To address this, we would like to propose the following plan for U-Boot:

* Introduce a new config option OPENSSL_NO_DEPRECATED.
This option will allow building U-Boot without any ENGINE support.
When enabled, hardware-backed signing (PKCS#11, etc.) will not be
available, but U-Boot will be buildable on distributions that have
removed ENGINE support from OpenSSL.

* Add support for OpenSSL Providers
Migrate the relevant signing and key-loading code to use the OpenSSL
Provider API, which is the officially supported mechanism in OpenSSL
3.x and beyond. Providers are the modern way to access both software
and hardware cryptography, including PKCS#11, and are supported in all
current OpenSSL releases.

Arguments for this change:

* Future-proofing: The ENGINE API is deprecated and will eventually be
removed from OpenSSL. Providers are the supported path forward.
* Compatibility: Many distributions are already disabling or removing
ENGINE support, making it impossible to build U-Boot with signing
support out-of-the-box.
* Security: The Provider API receives active maintenance and security
updates, while ENGINE is legacy code.
* Flexibility: Providers can support both software and hardware
cryptography, and are more flexible for future enhancements.


Impact:

Users who require hardware-backed signing will need to ensure their
provider (e.g., PKCS#11 provider) is available and configured.

The transition will be gradual: ENGINE support can be kept as an
option for a while, but the default and recommended path will be
providers.


Questions for the community:

* Do we need to maintain ENGINE compatibility for a transition period,
or can we remove ENGINE support entirely and move fully to providers?

* Are there users or workflows that still depend on ENGINE-based
hardware signing that cannot be migrated to providers?

* Any other concerns or suggestions regarding this migration?


Next Steps:

* Add the OPENSSL_NO_DEPRECATED config and update documentation.
* Begin refactoring the signing code to use providers by default.


Note that we feel comfortable with adding the OPENSSL_NO_DEPRECATED
config option and can proceed with that change. However, we are not
very familiar with the details of migrating from OpenSSL Engines to
Providers. Any help, guidance, or code contributions from community
members experienced with the OpenSSL provider API would be greatly
appreciated.

Please let us know your thoughts, concerns, or if you are interested
in helping or you are already working with this migration.

Best regards,

  Eddie and Enric
