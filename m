Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C19D59D77
	for <u-boot@archiver.kernel.org>; Fri, 12 Dec 2025 17:44:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C85DD835B3;
	Fri, 12 Dec 2025 18:44:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Wor6zf86";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23D41835FD; Fri, 12 Dec 2025 18:44:27 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58CA78334F
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 18:44:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7c78d30649aso1044514a34.2
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 09:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765561458; x=1766166258; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jzrQOpfQ9mvG/5YphBY7GOihMoIDYrc6iByFF994oQs=;
 b=Wor6zf86U/Hd9A0Zz8+Bnx5GpbSOf2mLaOo2Yeh02DnCls6kIXhr3nYwYR3HKFemK5
 EVL3/Y2sUDCHyyrlHb0Va8yZpCfCA8ZtEk1vbwB151dpvM+x3p9M2cm5xvI6U596gSlA
 joo5ntgSihY2hNJu58tk4OyUKf8l16GeU+Mx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765561458; x=1766166258;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jzrQOpfQ9mvG/5YphBY7GOihMoIDYrc6iByFF994oQs=;
 b=f+0ETo9q+bjFxkukAJhdLlXZ+ZFnspOCv0JeoY1M0TcvX/nVVzQtABMpzdw/DGcKVD
 +WHhxPxLDEc7sIc2H6BdhDgewwsBKBm5Ro7CZp00Bq3ofc9+rEhz0LFwxEx1B1OIm9Jg
 QdxJY9/rvTPEtAAhr8XLVUC/XMOqzQYUrWhizL5pp1Fi0Rcs6fG7wynuMl9PDd+sXEb/
 37pgjl03WuecHAx2JACMDnoASbiNWZoPCqIKaDI90UdQFp+WobeXZVVzj3HYWZRIedvO
 CQrzEcwse8ao5PZAR72JTOKieD2ZPL7+OkVmMHfkNAHSj7USNNFrTTrJCe+dfdXhcwV5
 kwoA==
X-Gm-Message-State: AOJu0YxxsIRwf/M7oxaIkQVPCnsaQhIqtYODBXy2rryNql1jklzqrO49
 bkz27j+NVuPRJXRWlgThlIyjWdizCCP2FC0hoWhPBx0itRmXGdzE6Y463X54PNpD9RQas7sWx71
 YCF5MPRI=
X-Gm-Gg: AY/fxX61T0jqBiTXSs/RUIwsGkiQ1xbf/X/hPnEQzNwBv8JXwNgomsWrn0wqTgyRt3J
 /mGwsOELzSN8X252i0sXNyOceDRq8HjxdI0KZRF73iIdvnMRjdQ7mCfHIXtCTb9d6Mw3n4HT6tJ
 6z6B4AbETBKrMksHZ9iI39wtcfDJV6irmIz3IbSWtO+FStsVwSMaiZl9ikoCaOXdnVJ1y+cifDg
 q1qIS6LtJFWwAC6MgkXrPZeGI0oZB4r+2Rvk9vb3nTW+/QMN+lGnAvRb/rp9l7Vsr2kd1jiDxYW
 eqJN8RDews0XPdYinuTnvV6YwMBPdgYX1a89m+9Rnv9k6rStUVlAvnc8WnslHNdaNeTxIFl7w87
 qmHNDW4ll1G1kPBlUOPCBlqxklPZnJID8bK0P0ZTaL5miCho3bkvYLFpmXrRoGrrlMpNRM1PM1I
 BnaUO7rWRV7hDocFjOgX3Dm1UaWRcC1Pe5l5KZyUp/1jrh4BUX
X-Google-Smtp-Source: AGHT+IGu2CsVnJkJmLU3oGsMuMthjsrqrim/lDzNcYX0X6wPRTX/RTd4pfNDxcO+wYldSM2cKZ3zCQ==
X-Received: by 2002:a05:6830:4502:b0:7c7:6cf2:b72 with SMTP id
 46e09a7af769-7cae82e1d0amr1093868a34.10.1765561458040; 
 Fri, 12 Dec 2025 09:44:18 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cadb345977sm3775688a34.29.2025.12.12.09.44.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 09:44:17 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20251209212301.2924760-1-trini@konsulko.com>
References: <20251209212301.2924760-1-trini@konsulko.com>
Subject: Re: [PATCH] fs: fat: Perform sanity checks on getsize in get_fatent()
Message-Id: <176556145741.1046979.17047744781305427704.b4-ty@konsulko.com>
Date: Fri, 12 Dec 2025 11:44:17 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Tue, 09 Dec 2025 15:23:01 -0600, Tom Rini wrote:

> We do not perform a check on the value of getsize in get_fatent to
> ensure that it will fit within the allocated buffer. For safety sake,
> add a check now and if the value exceeds FATBUFBLOCKS use that value
> instead. While not currently actively exploitable, it was in the past so
> adding this check is worthwhile.
> 
> This addresses CVE-2025-24857 and was originally reported by Harvey
> Phillips of Amazon Element55
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] fs: fat: Perform sanity checks on getsize in get_fatent()
      commit: 87d85139a96a39429120cca838e739408ef971a2
-- 
Tom


