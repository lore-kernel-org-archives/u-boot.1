Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B88606A31B
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 19:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MwwXNNIe;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=IEAnku9M
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 51EB760794;
	Tue, 20 Oct 2026 19:20:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OtNLqGE9nenH; Tue, 20 Oct 2026 19:20:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3B4F86080B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792524014;
	b=UQpNiVJoxW+HmL87Rc0PvfDXqze0IQxNu+lW8jPJ5SPd+a6K87aVLpxi8znb4jMbUWsh
	 pLchIW4+ea/KxvebSQ0Gp8F2ElERRCxyQ0agxJ3JVmZES+b//yulnfJso1cbvdV+ivH7e
	 Fn+E2bzP1lsapZhY++JsJNq08xmegXHtr/E30KJono6L4RUux4cVNcH0dkCTSLa0QJXwm
	 5OBEQJeJfxhbfeSBTM4DCU+NVrhFmLnupE+vSrHc5hp8TNk/UdHRh3wgHerntS3iUapLP
	 Vq6GTxqwNqQZmfo/5egw/NWEhIOM67T1P260hLBkqyD2JmBmH08q2StxzMHk7tB+meg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792524014;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ZMZ21bddnhk6ZD2fh/fSxLYvNVQ2FBY5Q/pw/v9DYvY=;
	b=b/TCqGSxulQ/LroHSNLNkmMOmu2yh3T02i+WC5A4QqmGwOGkAAp4/ABCU1nS0ThJhlii
	 d6IxK0I84PxDzlR85yeH2JDoVAwBPq8WJvVt7ImqC/o0goGq8N/YjToyptAePfWvPnPZR
	 yU6yWWz+IyQYP7Jnl+C5Wjv5pRWYreUJBaP7cX37PnRKjeTx7YqaxybeHz4e5TqFQILmg
	 8E16keGFcm9jhT+Z+/MGKjfsIFJPxBHokBVa8cpMg1jIiQKSKummJePIBGpLVoJ3F9eP6
	 8oV/urARWvxTuRd9TH1JD4vNKwlBQ8tEHKbKUxL4p5gGfvl2vDigw+3kNHs6UnI1OrQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792524014;
	bh=ZMZ21bddnhk6ZD2fh/fSxLYvNVQ2FBY5Q/pw/v9DYvY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MwwXNNIevkwQF5j2Rsp+tipNQe85K+9QV1l8mwWn9K1Qhv8BbkrZf2AgC4iNt9Ywi
	 KwF7CqzVApYPkkM7qnkY4nwF6eeyO2mwkWewBzdpzKryjKGQMX0WjDNMHy5fyfn7DZ
	 0HO8hD/ktbigY31jKtCeXuVKDz036craQl1jJLLSG+HGl/blvJoYsIi327+dzJWxq6
	 XPcBXNWatY64tGRXjmqQ2iHF+UACpwNsj42gehVIjPBbLJUI+WgXa1aJ16AwH8hiSW
	 q/hIa6unyAhkeKCkP7PFzOTncy/TGcru4xJ77rMKifNQdvp2N102ssDT0nWHJaG1pD
	 4QJ9RZkEv5RJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3B4F86080B;
	Tue, 20 Oct 2026 19:20:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 25D1B255
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 19:20:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 17D94405C2
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 19:20:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XoBp7C-CVmqr for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 19:20:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5A9BA4057E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::334"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792524010;
 b=W+wx2AHMmvWONsk1v8wZK+1yKxk3qdY7oIJT8jloq4Fmp2F7F+l3/hCk3o/A48uHULEO
 GhR8xcPwATmmEJZYFpKuwpBIZistPOs5dp8YTGOnBAaeWoRVw1SlyNf5sg29V3dZ9Wb7g
 9JRApzK23ZgHP1zFVyoUMJJHsnHtvvxwCeAITuoeB54dnyeRwzcrov3y9ePdI+2ZdKiy0
 OlGp8+fX+3CmTT72a6qLiZKX6iGcoLTd0heU4+AE5BkzhGDUOf1XmmGKv0j6dj5Ipjn/L
 jOFelNrvkBi5D1uKAAwYwUnMV3y2S7Hbsrhm0uFps+fBZf+EbVfUtAEiJxQqIfMqnqQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792524010;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=ZMZ21bddnhk6ZD2fh/fSxLYvNVQ2FBY5Q/pw/v9DYvY=;
 b=JIdMdP4EIrylsuqsX9V6t3anbHXTq9kU7BJH95N+le9kU0M6FOM79wx0cPZR5Mg+rJBv
 D8IoOEP1a6dXq6bIgkun3KjUgkjv3XG9FiShslGgvtnrF2PuLphl4NaDzjtIy6HCae4FD
 /g0eVY2bXVJonn7A1Kph9T7gJqTEbBQb/yYNukBInHkauMuFxakyTc5wrBdB9Qr94mWoV
 pzb4+BAC6pcyqHYCcjvzil4wtgdxBD7uhdw8fqdjW9MelI6OvIY7e58VVnzslV63NhaEW
 rFjkTRe/JNTgBDjs79vuzEJNX0CwKmQU30rtaEQy7Qx7xY94FvylTP7khcIfW/aTUWw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=IEAnku9M; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::334; helo=mail-ot1-x334.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=IEAnku9M
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5A9BA4057E
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 19:20:07 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7fccba9c675so1465848a34.0
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 12:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792524006; x=1793128806;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZMZ21bddnhk6ZD2fh/fSxLYvNVQ2FBY5Q/pw/v9DYvY=;
 b=IEAnku9Mh5Q2R3dJYqhssHpwSvqVrqU4rIUIPz929bQwdDZwmfDNQhHHEdAy+BKuSh
 053WlQo+woIS9iCVzU3n0MBefPDXqYcLkKyuor+K9//36g1qH/buZb/skYHZUh+IOPEg
 zHraaUuIDnzybSz1lH008uFv33rSJhjLvl4qk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792524006; x=1793128806;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZMZ21bddnhk6ZD2fh/fSxLYvNVQ2FBY5Q/pw/v9DYvY=;
 b=Szuu/MxP47/Qn1NXpETEAFTPUuOYaIU0TIg1F+edf+CNaweGgMNMK2+lRM/aBMdygH
 6NJuzK5skQR2PSYpnNwUlQ0xnMOpwHm+Z3PhxyvwPC8MiDapNrHMXCzv1SE7fUTv0Wcz
 pGHcmjQiEjF2mSYqBrLBQG6JzYiLK9lKeN+gTplwB3NL9p5hgrBJdynrH1rJ9PFVJVo1
 77GqvSq9EegiTkelSdUXo1pJIAcFSHNKqZKK75JyxJLpGe4/mnnDNnRn/dYCGHo3jvDR
 phvebEKB13vDfcw2rZ2BpNJCv6hTDS1Jm3pSoArHYBxY16DklIaADFP2pbuUpva8+IOW
 iuvw==
X-Gm-Message-State: AFq9FYJfhhVpbAkl/ieY0qtzc2Bqi8GbvrhKGEjcfd6yoN5udWj6dsTY
 flnRQUgMgc30NVfu6mW27w+jtGgb7mZ4alVEUHS9v39vkIXXgqamLiB3DU3/CnFh/Dx1ah+jPWl
 b7pGUOEp0l9hK
X-Gm-Gg: AYBFou06N3p57/CmCzERPu/8J81jLwhmx32BIp4w/MmnxIOmyBKuPQpMg6hOHiyCAQr
 dj5ty5J0PLC0XjEn7Sfi8AMhN1FOm2ER75zRVfGorxxJVXhUITlf8vXDQfC1E8gsYTlktRlnaKv
 /BscoRHxz5SLmwFqUVKdyPffQ14CRIJqcvUeIWa4uMTChgmcBc0z4Sk1Cad0WQNGlfYZNIeeCu/
 1MiNm2AyP2Zyb2fee8RLYRjj6K6wPX0d+1TPwxVVmVC3lLiuC4QOOfa6zpntNwoRGugj9HvRvln
 hgAX1E7wJlJT15pqe3v+zA8cM7wCixBdyJJvvWJUIh0AwCldqVuaHlQ39rEsz+9yBB1n1JkAYXj
 3q38ZbS/zWlKgh6mfNQVyS3PCM0LjcR4EgiiCSSBeGW11W3YgRtiBBKZiGEUXKDfSybIqJ9GlCa
 2+rxrGsoPTH3l5hRe/UROcy3rn72Kj/pc9DRnkglaLpj7Qn5R8C8x128l2j/yK6aFwgPQtiMgLM
 qdyfKJXCiO/QFLxwa6w0TxwSIAgyg3A0eyBzigJbHQCyZ3rbTkAFW6BPXtyHKMB9ikhYyUaj5pv
 MJRKdghuPl4HvD0s6Q==
X-Received: by 2002:a05:6830:81c6:b0:847:db9d:abfe with SMTP id
 46e09a7af769-84b78366e52mr2031344a34.23.1792524006580; 
 Tue, 20 Oct 2026 12:20:06 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-84cba7d4648sm347685a34.1.2026.10.20.12.20.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 12:20:06 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Aristo Chen <aristo.chen@canonical.com>
Cc: sjg@chromium.org, quentin.schulz@cherry.de
In-Reply-To: <20261009085250.331110-1-aristo.chen@canonical.com>
References: <20261008070116.328864-1-aristo.chen@canonical.com>
 <20261009085250.331110-1-aristo.chen@canonical.com>
Subject: Re: [PATCH v2 0/2] fit: use constants for the cipher property
 names
Message-Id: <179252400591.1115934.17057157545533865126.b4-ty@konsulko.com>
Date: Tue, 20 Oct 2026 13:20:05 -0600
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 09 Oct 2026 08:51:13 +0000, Aristo Chen wrote:

> The image-data series [1] added FIT_IV_HINT, FIT_IV_PROP and
> FIT_DATA_SIZE_UNCIPHERED_PROP to include/image.h. It was on the list at
> the same time as the series that converted the remaining FIT property
> literals in mkimage, boot and SPL [2], which was written before these
> constants existed, so the cipher code still spells the three names out.
> This series converts them: patch 1 the iv-name-hint and iv properties,
> patch 2 data-size-unciphered, including the fit_cipher unit test that
> sets it. The two patches touch different files and do not depend on each
> other.
> 
> [...]

Applied to u-boot/main, thanks!

[1/2] fit: use FIT_IV_PROP and FIT_IV_HINT for the iv properties
      commit: 507deb152bdd0d5803fba29579dc8810e1cff4be
[2/2] fit: use FIT_DATA_SIZE_UNCIPHERED_PROP for data-size-unciphered
      commit: dc866ade7516b351f0181663875393b8813aba17
-- 
Tom


