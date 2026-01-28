Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F86D340BF
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 14:02:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48B1E83E57;
	Wed, 28 Jan 2026 15:02:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="h9zNhptN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D59783CEA; Wed, 28 Jan 2026 15:02:33 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6569D83E61
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 15:02:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-45f194e9a98so44723b6e.3
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 06:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769608950; x=1770213750; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3+RUD6ceExbxgASoYBQXOLDo5F+ozBsCKJXKJVw+Qf0=;
 b=h9zNhptNs3iUFDfN3X283x0hNx29n0lTs3dTr9G76idM64lbXprg8iwll7x8su4D1y
 WoCliJDTNJoJd6sekKJ8K5/cIzYgNHPIFwwIhyoQWBzBvD+VCUyaG1lGaXLxjU3hYjua
 vSONvEumfHYDxCeTvXEsTrKCS+biqmLoHa9GI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769608950; x=1770213750;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3+RUD6ceExbxgASoYBQXOLDo5F+ozBsCKJXKJVw+Qf0=;
 b=CC+OHX+5N0pzafwHcjUIGz+AfpGOKk2PP10OEJnN5h0+egPZ9wx6zl9Tkp9ChAXlMh
 99ZIiTNw58QsS4f+e37Cy0wBuMj8d4bv2AoQMYVmFuZAism2KzqcpI+uBRWPUquxTVr0
 yBHhEomGzirLDxcpUzh6zw8WtD9uhidFbpRDijAmEPk8sui07yh+nXZXHYNZXcJ8dcxi
 /wzlNnju4lP67wqCRLbW4PsIftbVyFzimBn9kZeZWtOh5unBUpMLwYLENQyj8MJT6Saw
 YhUid1UYTJun5GsjYoeEuLGAMkA5LK773O8UeEh7j6Y+mSlzP/JxCNa0q2/h5PhltrWN
 eK+w==
X-Gm-Message-State: AOJu0YyeAt+cGUIUayT9pUVVbV/daUJCrnRCSIWQSQWHr7kcoYjZa7ur
 hdFQzkNjCqamuuj0TJrFlygl6Wh/NpzmlI81QkG4xtWjMnU2M7sqy1Z1kAO+KoGBXzE=
X-Gm-Gg: AZuq6aK+QfE0trApVQzjZLJ6D3W2Dhjnk2wqwo7Ae5AZNnZxPHu9/qNZAsfItJ3GZTt
 HECq1UKmuc/RBG80VA2R4V36Vnsaba4m6G52zzZ0PLHtyLyQOHlP2rrOepLPO8jQx8ZnbDEf/b3
 3EwaxcmELSWNanbV7RHn13vd2nsX6UzqkpKyXG8CCFCKqhnEoDNt9qP7UTegUBjPPTj+QYaB5Jd
 q3gx+6xmAvpHBY3A2oCReNqIjPO04V8COKEjied1LL2cBwq7W07USmwQnsuoF/NRqdqmuI4t4NE
 wyLFbqmXoCNTUs8CGJBuAgxATjoSw3x6H4CYed19eSHMe8IQnnDvpLsxLOkykM//Hc+dY87fa3v
 zNPprvDhTmUi3pEqobNvLRHOCb32CAxx0X8EegXYctuicRy6A2BRhnj2Nd1+hgmN/LVNYrRu143
 PmWJ5g7AW7wDihv8eytwm2ovj2KpxzJPM52tuiiRVurD/mX6oHQZb8NuUfuY3yWWacWMNY8lR2f
 s+54WwZ9eLDLtZQ4V8bDfuzva3xDrXYSMmzGk8TtMDfpvFF
X-Received: by 2002:a05:6820:1622:b0:662:c415:6b5d with SMTP id
 006d021491bc7-662f20df6fcmr3256056eaf.64.1769608949917; 
 Wed, 28 Jan 2026 06:02:29 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4095749f332sm1751438fac.11.2026.01.28.06.02.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 06:02:28 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>
Cc: Andrew Davis <afd@ti.com>, Judith Mendez <jm@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>, Hrushikesh Salunke <h-salunke@ti.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Vignesh R <vigneshr@ti.com>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>
In-Reply-To: <20260120-am65_dfu_fix-v4-1-36b2dfab3a64@ti.com>
References: <20260120-am65_dfu_fix-v4-1-36b2dfab3a64@ti.com>
Subject: Re: [PATCH master v4] Kconfig: select
 SPL_USE_TINY_PRINTF_POINTER_SUPPORT for K3
Message-Id: <176960894804.1640006.17905503914893006726.b4-ty@konsulko.com>
Date: Wed, 28 Jan 2026 08:02:28 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Tue, 20 Jan 2026 10:04:28 +0530, Anshul Dalal wrote:

> Since the commit 1e24e84db41a ("tiny-printf: Handle formatting of %p
> with an extra Kconfig"), SPL_USE_TINY_PRINTF_POINTER_SUPPORT has been
> made mandatory in order to use %p which would earlier have defaulted to
> a 'long' print.
> 
> Without this config symbol, k3_sysfw_dfu_download fails to set the
> correct value for the DFU string with:
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] Kconfig: select SPL_USE_TINY_PRINTF_POINTER_SUPPORT for K3
      commit: cfce859b16ffc43c6eb0afb6c49c95e1ec25f5f1
-- 
Tom


