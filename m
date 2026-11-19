Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC3E606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 22:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cMpVk1oK;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=bg5xCO6q
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 994BE40E0E;
	Thu, 19 Nov 2026 22:26:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CVts7UH2AkUa; Thu, 19 Nov 2026 22:26:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E0EFF40E08
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795127211;
	b=ZitsDsL2dCmK3+z03krcsMbpVrUHqaWw616KaEjL5rMJx+X4dpNC0VS6rhh5ZgFcRmkb
	 Ai0UdX1TrO7L3cZsNhKT9lT+Y+QUGKVQgR8x5wBrIBoKVW5ifn+Y5fDW7hgxrRPFpbx27
	 2MmI3wGH8kHm6FH/ZxZwNIC4wQnGtNWa41itUaOQvumL983gsalznXLT/07ZiKdqQuIa2
	 McexyKvtMlEX5nzNRj1Q2oq2g4CioW79ZXMIoP0zD9zWJzsSdKuO3EwUvWcR1wlWAshKP
	 qlwxG5qe1zxm4sbM6uZwcvIr8fXsbtIl9M4Ayp6m+x+po5HZzyNFnI4wswCx6T+Rnfg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795127211;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=zlAvi+Ox0Dw13obFopHa9bAoH4DSIVfE8T9KVlOJUtk=;
	b=MCbdUMDNpovmmvUJ1xxRnPiV2MaVoAQrXEHTZtbxSBAg65Z1IQzk2duCB9JfOnVYIW1l
	 2huD3VYXWV6UbyiUThYyTxagb6eFmLFLEAP6BCAiv3UBglbjxcGO18uSrYwY22/wW90fQ
	 XqCq+5RRIEk0XINi2iyCQU5FxP1GXoewlBVJQcdbjLoSJg+PglsOykli+7+MXFWUiNN8b
	 I/SR2lntDCBZ4emv++OVOf4S9iewIZHEDa0oLVIRHfXT+6bry3g7Ngf1nYYxygDFjmdRI
	 g9issloSpOcZBItGWWuE7c+RllEZ+w0Z30/iTVGReMjK51XuZpk7o/FZ5dp/uWQ9AtA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795127211;
	bh=zlAvi+Ox0Dw13obFopHa9bAoH4DSIVfE8T9KVlOJUtk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cMpVk1oKDOaj/nNZTvE5JarisAVvBlJdFLtxVMz+Gx5iwtI9T+ZBXnHv701QDCqok
	 pJdyV0y8Ag32pqs1pgZooOcOmYRvKiC0lOO60zOhElJ/laIqWOQMTMZAzdnCQCqBVR
	 olT1ke6al0xZ60kDFDUmGXly9eMGdmD/KTcW7LB9VUmpUbRWTxbKgRB7qxmM/9YshW
	 JfgFOfhKHM0hcq5yzorqgzCPbA2hE/R7z9lmwO9iIlfE3/e7bYB2b06Zy4wfDvoSbN
	 3AFWPzSgbSBcYgC04zIHP068fK+4eRxUm592B53SUj1+VkMk2vtB4IAKCDshWiUVIV
	 Vf7oSdBhpE+6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E0EFF40E08;
	Thu, 19 Nov 2026 22:26:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 985432F1
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 22:26:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 89C04815C3
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 22:26:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pasOTNuUXX6T for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 22:26:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E4F9A815C1
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::336; helo=mail-ot1-x336.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=bg5xCO6q
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E4F9A815C1
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 22:26:42 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-843b6f8e2c7so230308a34.1
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 14:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795127201; x=1795732001;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zlAvi+Ox0Dw13obFopHa9bAoH4DSIVfE8T9KVlOJUtk=;
 b=bg5xCO6qQ1onxb2VO9Q0SWgUjTLdmbT97L2DOzOg+3AAoilapYbTXZosuBu2X5WqdW
 dZ/pEYH+IznKqoPgpcuRHiwrAxFCuEzsthqYgQYRY9J8ZgcEimKyHKlC4a41IoUGX9F7
 rR7uaTf8uVUA7TIPF/CEmjD1dgyl1YmwxzgHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795127201; x=1795732001;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zlAvi+Ox0Dw13obFopHa9bAoH4DSIVfE8T9KVlOJUtk=;
 b=rGkZvBcfaREMK8PW/WDvcCVUiLeegwWCNEv6Ca9vwhoEJ5yTYb8tpafctSkL6HMOwb
 ODA9rLVIMIdX5Z+25wsS9H9xVDyeIUHj5K409yYEqT8ayXp42jJeYfykzjrzDS3GLUlr
 1TKpV60llqCJkYnY+y1WH4ZxeiG1KHZCW3r2HroOkLids+ijlsF/wLo0lr6WBX77utX8
 Hr1JiJMhbgaVWZQF+3cP8XLW8D3f27OzNLe+Fwcs2NmQY5+vrdoljQE8nvvLKfOz0Cib
 mk46Z7qTzp7qhohgsPGffQ8BsDpwbbnykz0QsrjSQAXywnmYgVNM9H0DZsG6kBK5fERE
 W0/Q==
X-Gm-Message-State: APuU4Z8AcjnOzYnnxSEyp7Tp7x3WPpRHEGJl3E1ifPRUURPJKefSqG4U
 cKlDi7z+TzdW0obxDyewKn8/e4gycMN9hN8gW1QjCvpQLcw4L7xp8khS1E9aGZkipJg=
X-Gm-Gg: AYBFou301Iv5CdB9X3mvZRsmAFqdPLh9DKGpP4wAsCf6iABNxQ/r4uKFjtuLILk+26O
 srTokkJdxJQIIUX4IT5/NIQZQhxhIja1G+FGp/aFxdbFzVewfUJtLbArtiTAYQnye/EDkscxFqH
 BDDPDbX/tmevDmpN7atTquYUVJJTDnp8CuPRB+9xwFX+K+b7ue3nm4AzGH08sow59hlQx4N3Ers
 mBaZH+dMPv8lvrtLZT+nIqrR+iE0up/xxou1pNoo/T+9SdHXlvK2aXThXxTdxoKOw27uwkOIh+r
 lfAuya6/8bBE+87846fDgytZfdaF4LnO0xG4hColo3xwhCgcUzFQWinEIi0gf8Xz7MV+zVeRcDK
 9p7V9XMSqT8w4heKEG1e/JhmmuBMTmt+7y8jFLQ0GlP5uJc0L3GHlharrLPkX/pEqZMIE5CtBNV
 bu5Am307jf6HaUjKcyMM3mx/BydB0Kih0oB+IaWrcF5CLuHVf6WgKOFzLMLr52HvTreKa+g4gOz
 MO2EFdvklUKuvHnyiHG8W7fB8niSJnPKpF+VYJ2RMpTrZV5RFmJuSaoC4MoC1TUDqCtq9z/xcuf
 /rbHfSGIGEXCBYG/PbsvU8IXPxy47rASX+YNNLdvqMS6diIlcNjko+tk+ALFi5kLKzUa0gUDrji
 mEhpMR94V4fi2+1HzyrelCSxqxl5m4Hrg8NeYMo3YlizzYEsmdXhSX/QzKKTQwSODhPK2gFhRG3
 Zv9sesVaukjOFNs6eORv+FaboZf7nQUA==
X-Received: by 2002:a05:6830:3142:b0:85e:f25a:7d26 with SMTP id
 46e09a7af769-8631535d656mr2202177a34.1.1795127201674; 
 Thu, 19 Nov 2026 14:26:41 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-863168c1bc5sm649069a34.6.2026.11.19.14.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 14:26:41 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Tomas Paukrt <tomaspaukrt@email.cz>
Cc: Stefan Bosch <stefan_b@posteo.net>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <x6.ZqL8.6lacd1LQ7Dn.1gxhk0@seznam.cz>
References: <x6.ZqL8.6lacd1LQ7Dn.1gxhk0@seznam.cz>
Subject: Re: [PATCH] Kconfig: Imply MD5 and SHA1 instead of selecting them
Message-Id: <179512720101.764313.6046628933729206337.b4-ty@b4>
Date: Thu, 19 Nov 2026 16:26:41 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
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

On Sat, 07 Nov 2026 06:47:44 +0100, Tomas Paukrt wrote:

> MD5 and SHA1 are no longer considered secure, but they cannot be
> disabled on boards using FIT, image signature helpers or UUIDs,
> because FIT, IMAGE_SIGN_INFO, SPL_IMAGE_SIGN_INFO, VPL_IMAGE_SIGN_INFO
> and LIB_UUID select them. The code behind these options does not
> require them, as the supported algorithms are looked up at runtime
> and unsupported ones are rejected.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] Kconfig: Imply MD5 and SHA1 instead of selecting them
      commit: 71dcc41499b5f2fcd9cbd42a733eac802af8644b
-- 
Tom


