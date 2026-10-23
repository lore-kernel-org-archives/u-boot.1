Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EEC606A321
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 14:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CRFM7Qyi;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EyPzLey7
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D65E34089A;
	Fri, 23 Oct 2026 14:35:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GGKkdBdUBGZd; Fri, 23 Oct 2026 14:35:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 30C0A409A7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792766139;
	b=YakQjE5VGHAWjYijfwC7b51+f5kNQwlEHd9gCVCGrnhmHnZIq+IYCy80wLMDB7v5VCsE
	 7jGvSrn0qjEMQuqOvp/OcRCJ0Bg58aBYpDaHCOfYS3INLbnhd/6kaDfQWtC85HPd4P8Vg
	 xwbpos50N19r68QaBF6WX4Hl5FgPORatj774J9rDbdwH1ovpBqHJ+iyGn39ZR9MmPWiqq
	 hB4iRGLWeBShmmXzHjfUjox8+G7ZNWEu92zDScRjzB039UH7uxPanf6X7t5vbxBmv33og
	 yxO/0OUFyTOMmkqJ9zIEtmkZyRERu0nRPbQA9+AgpCOzrgyA6CRBuWfWTqmG6kaH24Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792766139;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=n8rRny7pgUkYfMPpgLz6mjq5PZQaorrwBul5kSBbzUg=;
	b=QFiGr4UrctFuJJ0rlECnIEted+8im3bcJTXSFrUvHuz3Kihyz2fOWE0iIfQgQ/c5Ay62
	 dsiAxMeuTqoVu49kAi4vctJhP6iLw0RrAPkZXLx6URv50iCO22DZouj6i0aG3mZDJVAMn
	 tX+iggPf9SRfXeCKRXgejcouVc+5V5XSd4YNodFkoxlLGqh0LSLcBTre1uwzBcNJiuW4s
	 Q9qNjsJGkUAZUlieFzLmYtkbUhZdXfdZNZqSoxVkta3+pWWTqZDx3dXisu/Q3EacNWrva
	 CAiIuTozDHDX1ARdEZiYYrl848h8BvoKepuudDdIK4cLGiFQ9k9/MtpNF9cmKToB7OA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792766139;
	bh=n8rRny7pgUkYfMPpgLz6mjq5PZQaorrwBul5kSBbzUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CRFM7QyiFlwq3TI4KNYNbGyBIqZUAA9owsDZP91gAk37FK6pZiOzSipvjcTPN1MP6
	 Lok6MkhEq9+X/kwGuWTJymskQJT038J9jughP1sB6x5wEHGkc243MnxbNzNsbTgmU4
	 3tzranXTzg4s+FEnZ9DFM/XjpASEerYuKvZ734Bfs5IHCFPxBGQP61j6Qc7KDjKjtX
	 jjAmJ16o14wOGpCzSB4FrpfgnZsOs9Y6XQaZF0z/0DlFgNgQfpYZd0ZzwEMzFk0Anx
	 RiQ3hkzqtkxEveMFfia63VPqSvLsGuAOXYNbbM+a8jKT33xxZnIguiMzCxpaKjJ/ih
	 dBNf1m7VXV9OQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 30C0A409A7;
	Fri, 23 Oct 2026 14:35:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5DEC712C
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 14:35:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9DBB98144C
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 14:35:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gl3wd8krebxS for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 14:35:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C6DB381491
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792766135;
 b=MV0fc+VUb9OQbA5gu8zznDyQdg7UPpuv0aFeIPyoe+Tf42ibdlem7pTTgPmp//j6dUKr
 RRRR200ZN8qFGYBYmMaDOetgGamdfPGq8dUbs3ZaYAnaUlp6cxCBjDhhar0iucwtnqsS1
 DjRs8+7AeJgSwKacbKRerVF7t++PXKjkLSVzv9qkqAtnkWXzc4l43C8Fpqr80vaeEqAKv
 7x3FFPAp5zFdeFFP9fP7uEl2Q/NtHiIqL02E2vc+imKbaoNGCHDj1rJQvCnPD+8YAi3RO
 vRSqq2TTb/8j74ig3MCb/8WqLC+4zR0qbAMxBZ5ct3I/IHWu/oq9cNWL32UTkyVVtWg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792766135;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=n8rRny7pgUkYfMPpgLz6mjq5PZQaorrwBul5kSBbzUg=;
 b=tV153kWRNq/nVw/UhCOna8YFaf82qAaRI0m28sF8wclDcuBxLlmOelHsCy0PtaE4sDeK
 wzskNydp+pphJBBiaKPTuUPdw66Qr/X28s3KLYbYKsdY77Fy34GyuyMMEWZOkVS0aA7wZ
 HdNGNFYBWZErgkrte3zK7Lmqx5altqFBWfkcQE3dllv6TIPKgUwuwshn1hmHPiuI5D6mX
 /w5dsy21ohblbVIOT+TvACBkd33bbtHb6IxX1GaNURVsjJdLxiP6C0moFCYIlR1r4ZMoo
 MmT65wJNjYo4FKeWbDBweunQe1AcWt8eUXqpGrLGKVs63mm4wcR61gLgA8Hu4G5v0FA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=EyPzLey7; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=EyPzLey7
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C6DB381491
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 14:35:34 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a1df146015so6921115e9.0
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 07:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792766132; x=1793370932;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n8rRny7pgUkYfMPpgLz6mjq5PZQaorrwBul5kSBbzUg=;
 b=EyPzLey7adkPpgx9cIuq27fS/tWEzhBpp3hbAiVRlTtFGfOiywhn0bUq5wAVoX92bW
 /7+SiRomBaRz572pgTJhsJlvomRjl+hTiApZJYxK5BESIE2jLm/0sEABXqhnrckO+jfT
 RuUYISNgRUB1+BiDmugZQ8clD3ZulRPlzUh2xwL7FzhhT6TtiIwIYXZjpF4XXgQ30+QG
 7xvoVgccNd/E1GPfBJD+ixn6/Lpo3IIIRwLxCXztX6eCs+ojKmDbooaQzDKC1fzW3KPO
 JE3bKNRG1BEII+DxAE1ZBT38qjnP8D3C5KAyCDukLhZxx95XHluDLoT4koYUIQLJb4aj
 D4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792766132; x=1793370932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=n8rRny7pgUkYfMPpgLz6mjq5PZQaorrwBul5kSBbzUg=;
 b=AqLkz0IazjeVCIci/O4ptZhcNowSvu9uTqYl4OTvLqNIWs7nMPm74aw20aM6KnoAAI
 iR37GrOh+Y1h6/giWOfp7b7uDsB0iEWeBoTUmuUpv6siVGWvk3rfzZGaczrP4yJSfj/A
 iao6r4egm+Yl/8npJW7VrDKg3aqFVJx1sj2qEys5pmLgNYYim7bU3S5Njv926sbZIcWJ
 lc0uiFCLVnDwSRFQuKMurEY1uN7hI9nkyq0732pOlgisuoCOKE4EVsNVT2/ZQPPXJonE
 Qz4a41MfEx2oa2pPqs/7pVTa7GYFOnqiQ0XXGEI3ymqvwlTnOE9mZcGd8kOP134OJPF7
 5VPA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz2+MEqCJgqmukILyrvkf8RMMA0td9QOj70vBugd+uNKZ6xRsDA3PlMs6jn4lVuuwjJC1M0kRU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIu1VVrecIGqukun2bYJfwTO1Ze10pcCHBGd/jQ1kYGHw3Hyp+W
 johjJTFOqG8sGQ+DM9aHMkfUBLl7+oMwPf7K7UN8M0NpbxBXcg0RVB94
X-Gm-Gg: AYBFou2S8AUffdkWXqiqL3CwcFaRHK+Drr5Trh8lMLjzNFqPO4WK+VTzlq59wFb+A4w
 5iQS+76CgyfRShr/6SI9U6/siiCxeJxUVz6tPOY5crPxaPfsfjrqrnxZ7IlHEhYev8Fkq2iQpr6
 XYFxoMZ1uXBiYA1JnF28YomojEo6GvdXb9iUpJw8LhB8GKg4Boh7K5ueI7w9rrS9K8NPoxseKy/
 dZUckeE9KnhTkAAJY7elisVfue9TngYbihBmjgcsw4hr4/GRqk32pF2POoAER60qdhwHi45iGkz
 DbhPWWsHohdWIckWM1pRKJrTk/OE06PeijqxXluJdFtRkQYNs+7gV2rKPoTdZ729KjwBeEptzXH
 +78a1GSkWGj1uBxk0jNjnXLeavqN1Q6Y70A4LnPY49mbIhnvFGLmDtjxXR4EX1tCI2LXRq+w/e9
 CcqcLFF18tGYh3LkJm7iL31EWwAxTvXlFqFt+TcTZTuX0/YUQdIApnfFuVx/6ICzRNTbKoVVhwF
 fFfPTxx99Aus+cspHiW4Sc8SVoB93/GAPBBnZC4MOYuJOQYuH+gyP1mVcZijw==
X-Received: by 2002:a05:600c:a00c:b0:4a1:e6c5:e44c with SMTP id
 5b1f17b1804b1-4a211c8fa8cmr42002215e9.10.1792766132097; 
 Fri, 23 Oct 2026 07:35:32 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a2a92a4444sm8943915e9.5.2026.10.23.07.35.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 07:35:31 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 Stefan Agner <stefan@agner.ch>, Francesco Dolcini <francesco@dolcini.it>,
 u-boot@lists.u-boot-project.org, mehmet.fide@screeningeagle.com
Subject: Re: [PATCH v9 7/9] usb: ehci-vf: take the register bases from the
 device tree
Date: Fri, 23 Oct 2026 16:35:30 +0200
Message-ID: <20261023143530.4120984-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <a89862f4-45bb-4a74-88d8-6a556a15bee9@mailbox.org>
References: 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Marek,

On 10/23/26 4:23 PM, Marek Vasut wrote:
> This is admittedly a bit icky, please at least add a code comment. But I
> think this will get removed in some follow up series ?

Yes, the follow-up with a VF610 clock driver removes this switch and
portnr altogether. If that is fine with you, I would keep v9 as it is.

Thanks,
Mehmet
