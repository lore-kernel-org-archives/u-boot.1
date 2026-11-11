Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A62606A33C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 13:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Z5SkvCdr;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=PPjSEgcP
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 504C7409F2;
	Wed, 11 Nov 2026 13:05:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 00KyZeYxDwMW; Wed, 11 Nov 2026 13:05:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9BB314097F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794402335;
	b=mCEMdZXitRzyEyu4QPgatHSxEh4vcmK3GUcIYrzzbgXmTTKCvY1nzDhCocTiyzsLgiKL
	 ahwVJdC0G5RYQ8E+1KDzDKzqQZzwfSRLUXCw+tOqBM5kVEt87f2dcwafpCW0dzrd4Wiyv
	 b5Quz3gd9wQ6qe1cdNozn30AeGef+5uiMAMfh1AwZNQ2TLaO18J0SugZ8Yrp152W+0d62
	 DAEXSoL3wsBPUXeG/xCEI5dslLQKo6e7OL74Zm546eD03Hd6r8k0jzUQ4AQtMgr2CwE5m
	 VpBtvYb7w/ehiGFw+pTnPXkfjZDJcnRg1xe228b2/9ZjiRFj2FG3H9qs0AIubQQ5fmQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794402335;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=762NN1EPBCTje2zvLiaBbedbJvYyZGDYOeItavtdi6o=;
	b=LLonHkVMUSa2KPoSvfw1Z7DBFXZsuDDs2Ot3K406uxJ8CyW24itpg1iI71pBHJJox5y3
	 VPhjbJv7/lGsoXOP48clRll6w6vvq339+//rwcVstiY6eQLNWXWK5gP1X99e7HsbzZF5r
	 PGxj7znwDDkEbfKRtT7pGu+nyyZUR4xSaBM3+uBptQOJ6zbhEbARllK+zm2Rk1ELexODt
	 +rf0S077W0Kf+uOEPoogT4qP6j95P5FWOhWWVvlYOEchtHvll8KQVkflDyfJAr1PfRIo8
	 iiNIJ5Z8EBYz6ibjcN422XsK0mJV8LTcRaJSbxVEELaQpAfaGP5SJGYNlbfI9XCpsRQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794402335;
	bh=762NN1EPBCTje2zvLiaBbedbJvYyZGDYOeItavtdi6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z5SkvCdrx8mtzNg9owaJ4p4LXs9RqWPVywPy8qx8AIJk52sRKTOKWBLoI1d+lDLOx
	 Fa8TdnvGInq3IKthmFbsUQJrWmPXfluXOhfiWjST7Zkfi0qOu67G1Ed3OckhT9EYZx
	 Oc86jrwvVuPAZ+KCUfZO+QRvJ3zIrPwUgui7DA6F8NplUHm+AJkMOponffp7XAuWV2
	 ZqXtQiGbKX4khIKJ0mziteWi4t3E+o1UHs5AWC9yk7W0TDFGcfhCTRz1KXerDdCsX5
	 NIzWTbmIt6QSiAhaKB0lAd19+LpGcPHCxOXSNByBiP/oux6QmpJYPbLfW191jXgrOX
	 5LGCMxJYQlVxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9BB314097F;
	Wed, 11 Nov 2026 13:05:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0169331F
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 13:05:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E6573811E8
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 13:05:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9QPWJU35Xuxe for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 13:05:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 109F6811A4
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=PPjSEgcP
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 109F6811A4
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 13:05:32 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a208d93758so33858085e9.3
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 05:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794402330; x=1795007130;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=762NN1EPBCTje2zvLiaBbedbJvYyZGDYOeItavtdi6o=;
 b=PPjSEgcPEsY1bTzuPE/hzErKoHOPrsPjf7UTcni0FYkC2z2AipXisB4CyiNcMRe9jo
 7xM6dsKkB+4CCeA9x7d23XwQpHFboI6Lf2g1wbXycTD0f9vFNLZr4DVa0sDUbcypk545
 zUwbawLim2oVqEdzWKbDcLwB0nqPz0p/Kyqfa+NwLGINQMQCHaBelHRzjNUctjMbddDb
 tvgjL2QLQVO8Ccf0CXeYsBe88vSPgY1F30hQ0IqdO1mcykg4nXSH1f5LBNzCZd9JP1Mm
 tF1fozXMEEpem+qVhcHqyTs3ELUWNnx/FDj/8KN+1X1Wuy7y924y5fmffIyLN1c7Zk4G
 C0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794402330; x=1795007130;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=762NN1EPBCTje2zvLiaBbedbJvYyZGDYOeItavtdi6o=;
 b=pnAzMzrQ1qdh0NqRk/MyeyDSu3BFrIOiK8v/4Ia0VZrAnROTzXHGrLB59NOLRnrceM
 ch6/mDjzjCnzSo5NZ7DGpGD0spv/N4n79W9KSGLVEuEi3UhenPYzxn9BsYMdtHPlQ1Ca
 +P7r1hgRm6rj9PhkOoUyOE5K8pWRFCUWTwj7kJoKaVpoZ4m2SQkYIA9ut2qAdI2P9TZ+
 LsLxyuue2FlfGaEj3XXhlpAjbfFc7Pl3VjYyJ9usKeuUJmxsGi/ESjFh2ZZ4c4DqgYv4
 zYqUZ2SDm1fuCH2RT5sBUpr83IOBen/cUYlMByS4oMJtwaCQJ4onyrbsm2+b1GSoSuuB
 1EsQ==
X-Gm-Message-State: APuU4Z+YXxPGNTq2KA9C8MXtyLluliWFA0W3Oq/8BQjA3/AIC9jvC+mJ
 koN2QqHmEZEpaQ6twCJ1QpboN4ktIu0+8To22FFjV9N1HYoLg1WDuQ3V10SFHsSLIXA=
X-Gm-Gg: AYBFou0atYUH0hZO23EBEGVO0teCZOlgWckd/rU5BLeJkTuvz6BQ6xXQWFJUAl7qZYs
 hW1NJa7MCeUsuTGkbHyAORSLpY5yvwQlYVvMg4EOD/rBth0TwoZRX3jNbzgWSmFKTRB6F0c3G5F
 ip+SyMnJ+crbHIZfQiUfT6n2aF416P0G4IxhHmsaWKOWO8k4k64T90A364QCA3TfSKxIQg84dSD
 rBmX+iczXKRGf4FcKPEia/F+OoYma07g6h8EQx/7I+VY/AoKIH/m251jhupTXO0GMQf7zSuZEEE
 MTmOobk4x7K09g0gGyQ60yaKgxufCWBVyc45v2N4E/D5i7MgNGq9KNOqhpk+SLynSeMN1tHOxIK
 V8XNRwvAIFFzDcQ7A8KcyrgXwKSXDUhIUKGZOYD1rEGRRU+oP4U/d0u3OdohLnd0GHcMKq5edT9
 x5Qo3csDe9lUTzCseRRVHcJpRaxjSgPo3MwVzv3wuJgTlHB6uYAyQbPbthaLpnr8Cd6+VTraSUF
 TZJwG7Y4u6nelHn5ss7dcbj9eA/HG7Lgi/DOKQKjnjtJ7F1Uwsrk/9Py1ihTDyJWvTXz1AtN76a
 TckJRsmyuO2U69lyZ28lwMygw3X1z9hzzvbCx0qIYxf4OlsJh0Ux5qRFkaWw8Hct0xdbkxGZ9WL
 B/EgBvAeGRtnKQBSGHPJlRB+hTPJ8J9m5oMjH
X-Received: by 2002:a05:600c:3e0b:b0:4a4:4d57:8462 with SMTP id
 5b1f17b1804b1-4ba09383e7cmr41639815e9.24.1794402329756; 
 Wed, 11 Nov 2026 05:05:29 -0800 (PST)
Received: from macbook.tail959722.ts.net
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01fe64bcsm134063125e9.8.2026.11.11.05.05.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 05:05:29 -0800 (PST)
Date: Wed, 11 Nov 2026 14:05:28 +0100
From: Carlo Caione <ccaione@baylibre.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jens Wiklander <jenswi@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Simon Glass <sjg@chromium.org>,
 Johan Jonker <jbx6244@gmail.com>, 
 Julien Stephan <jstephan@baylibre.com>, David Lechner <dlechner@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH 3/7] tee: optee: keep UFS RPMB discovery state consistent
Message-ID: <avRaNHH9CTO_-K_e@macbook.homenet.telecomitalia.it>
References: <20261111-genio720-ufs-rpmb-minimal-v1-0-701a62dfa034@baylibre.com>
 <20261111-genio720-ufs-rpmb-minimal-v1-3-701a62dfa034@baylibre.com>
 <CAC_iWj+OikJL7w6ye5U29fyE-h=HU0bEaXqq9w4g+w+OEty1NQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC_iWj+OikJL7w6ye5U29fyE-h=HU0bEaXqq9w4g+w+OEty1NQ@mail.gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 13:44:51 +0100, Ilias Apalodimas wrote:
> Hi Carlo,

Hi Ilias,
 
> On Wed, 11 Nov 2026 at 12:21, Carlo Caione <ccaione@baylibre.com> wrote:
> >
> > Reject frame requests until discovery selects a region, and invalidate
> > that selection on every discovery failure. Keep the cursor on a region
> > whose metadata read failed so a retry does not silently skip it.
> >
> 
> The commit message does not explain why any of the above is needed.

fair enough. It is probably a bit of a defensive hardening but it was
something I stumbled upon that felt wrong, not actually (hopefully?)
seen in normal OP-TEE operations but it is supposed to catch discovery
errors and out-of-order RPC sequences.

If you feel this is a bit excessive, I can drop it from V2.

Thanks,

--
Carlo Caione
