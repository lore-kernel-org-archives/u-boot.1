Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87CD3CD5BAF
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 23:28:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6989C84878;
	Fri, 22 May 2026 01:28:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Q+A3zJnH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B5E38488B; Fri, 22 May 2026 01:28:17 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36EF9846CF
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 01:28:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-bcceb394417so847931166b.0
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 16:28:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779406094; cv=none;
 d=google.com; s=arc-20240605;
 b=fMpTSLDcyAc6vOcRPNhXeE0sOUktMzdw8l0y5WWHThQ+Pm8Emt8gdLsx3wTEYDDyso
 jbSdQPO1coPWHqjDrmtW1SQDJ6iFMlVXnX/GcF1m0KF6bmI1k8Vcpo4Bo/2MX/b0ZLk+
 0k1jBmo/xMiWCMoo3xGmREjRfI1gasZ+C8wtys0SQ1zEX7h3e37G8EUVuU8zTeUJSRl8
 mD1pHoM7bS45Yr5QaVRFfhEQLX5/bOvJAmYya5KURZC2NYXXOPMQSxV/TgDY9OyvYfDf
 dt1Eck+AUazTx5dOXUdhVaApsGZfHnNexa7+1W6VP4qr0DnZ114U1SwuNyNnyrNGvGgC
 FPiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hKMZcipiwotkwLUoQa927Wnx5oHwK8/V6LqxKSpMouc=;
 fh=UkYpimHuii4GqZdH6RdYCPYjv6GSF2hCxymjSk0mzuY=;
 b=djsJatEjZtSx+1m7QFdapHh8j1w1xNCfWvCKyvkaOy4PJmFNBGR3FECAQGfN86ggS+
 jqU8BxQjjB6Z9ZeIXiXZUqah9uCpxhOimjQ2PDtO4Q5BKb5hdv0VpawuciAsTPsSkOWU
 +ut+WEIoLPGkuPFNuiEWY5Op8tjUJa9rwNielanFM+G/WiPR4qsO6teOajk4IytRpf71
 8CSstcqJjZpVr+oWBgCsDDuNn80p/UdH9QlKTBMCVHQL9M2wGrXhuOX3/+j0og01q+Rf
 lWtLs0jxinPLvsat7JVQjbzbvm0eCiU3r88BUFRXYG3q5ynYVDucYOip3JOLF6kPC79E
 3yRQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779406094; x=1780010894; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hKMZcipiwotkwLUoQa927Wnx5oHwK8/V6LqxKSpMouc=;
 b=Q+A3zJnHzcbdrERfM/TAUF4kAKqWrHzwxrJQjhT+pOr8jwJ+QutprE02T4FCW4Efb9
 vUnwqiQzXbn45APVwfEIFs405FilyV3RxSFp6EH2155OEs/+W6YF4R2vTDAWs17W8q05
 6CR3FVGXRuMcJdRMkrdGgPVLjiK36gSZa89f4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779406094; x=1780010894;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hKMZcipiwotkwLUoQa927Wnx5oHwK8/V6LqxKSpMouc=;
 b=WP19DOQ/eVjxhnA+zoM7d0EMDl+T/5sKIKAjS2WUR/bz/pVkySYG5iBBQtCzzttd4u
 iAGYWKPVl0E6G63fSPa2I6M/YWTXtr78RDxwUWKVL2SSexOmR2smTIpJIhka+BHfYwJR
 CzYkye9UMjnwN3LxGaTqgUOJ8UHM05cR0cJDui6YhDNfmbWyloRYhC7qWbqACrTwnJ/U
 OdanYao1nY8yxBrQe8QaRcVh6b9TaE9dLMYG9IZv4yScldwsCRPzchrEqY+clduMf/UW
 wQsY2lsHMXdXzlrfcw3ZgpkXERrNLanFwGgUGE9qD3ju+ZkdLHI/7s5DP7Nsd46dbk4l
 A1Bw==
X-Gm-Message-State: AOJu0YwaQ3cEU57s1glto+hsHvchzQjuODzY0rIbnrXDO8iJhbrCkwpD
 zAXnysMdyuK+PGP3/GDYGs5lsikmX/y0Oh0K2IXlfHCpmiIr38TwN1b/4QWX/Bhnhngr1TS9rS4
 zz2LyPT2RHRI0UgwD5vDH7gle8sIXwV05VnTah1UK
X-Gm-Gg: Acq92OHXt8OUVKmPOSzMOhGRKinR5MKyMYTESUNbn2Tpo1QJr/bFk+IpnTHXNhSDjqU
 qfPKxYE/J8CKajmxuc+gEUwEoz54QrXcPUbYvE6giGBfvpyxw7bqZRUy/mtm23PFVSu++pTVTYm
 THFWyGDeYDTtQeIMF8WjEIsW9e3BGb513vl95sFIURTd4r4llxzXoZrMOd/xmQKejY/VFysX2+m
 nOX6Y3ETGTjnILKbnUSx5ZzcWFLYUdwqinRnRk3kncMCoNyt+eJojAbJddXbZC5Z4RHxyfLaShs
 I2TuHeLh4WSf/iFCgQJviuJe1JI=
X-Received: by 2002:a17:907:d0b:b0:ba1:1181:b773 with SMTP id
 a640c23a62f3a-bdd2839b9cdmr68587466b.10.1779406094584; Thu, 21 May 2026
 16:28:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260519152101.716714-1-trini@konsulko.com>
 <20260519152101.716714-5-trini@konsulko.com>
In-Reply-To: <20260519152101.716714-5-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 21 May 2026 17:27:51 -0600
X-Gm-Features: AVHnY4KHC8-mdCCy7ScZNLoQRvalwx10vMe5leajRbrmW6fODSZGNIPUM-HeApY
Message-ID: <CAFLszTj=nPO9ydnHDF8i94opvCz5YBWjYemOhMeCauB6gf+S0g@mail.gmail.com>
Subject: Re: [PATCH 4/5] scsi: Drop empty bootdev_ops structure
To: trini@konsulko.com
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
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

On 2026-05-19T15:18:15, Tom Rini <trini@konsulko.com> wrote:
> scsi: Drop empty bootdev_ops structure
>
> We don't need to provide an empty struct here now that the caller can
> handle this being empty.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
>
> drivers/scsi/scsi_bootdev.c | 4 ----
>  1 file changed, 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
