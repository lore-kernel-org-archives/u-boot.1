Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2E7C54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 13:33:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69C9082103;
	Mon, 26 May 2025 15:33:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="k45gkeDW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35AAD829E4; Mon, 26 May 2025 15:33:42 +0200 (CEST)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com
 [IPv6:2607:f8b0:4864:20::92c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0BFC81FFC
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 15:33:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-87de47585acso1629602241.3
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 06:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748266418; x=1748871218; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jlnFbhZW1MUDQd2DBb7ghgJ7IEAHq+17ZAq2OQGFthE=;
 b=k45gkeDWxeAPZJ5g+c4QUix8YGkYzQD/cVUZWM+Db35Yhh2M0LRVlnkkO+owFPO9r/
 yf+vXKjmyDmtpsv5hdWJB8oKA68p1lf3PU3/F8TmwfsOOLEFSLJ/9puvF91J09JSvG2a
 Vvgx1Iaf2Koaq0zGIrHDonXW610NBoOOfev1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748266418; x=1748871218;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jlnFbhZW1MUDQd2DBb7ghgJ7IEAHq+17ZAq2OQGFthE=;
 b=NF6hfRUJ+uZ0HMR+uvdRI/wqGr3s8cyGOHMHaj1shLInmA0muUK0mgek7cMGf1wrsz
 erc4VXfUJa7rQHIzC0sK6pb+Xnz4YyYKdbtdL7jc6x0sWeccEF48PzTeEPj9Qid+hfaP
 IvKy5XVpuOfiaseit4K5ulr4QLcR0F67bUSe8Gul3OlkWbAKI0a5TNgBq54pqEDGA3PA
 TLo6sNsQrPoLsIoo9stQrypVsDw61rEpyOufKk9uVQqbhGyb82c2Qs17B21fEgkzrb0m
 4CCbX2sZ8pTFmePbxOn/Dg2zrNrv1UW+jzTELuYc+AVykspFlBGgchBFCG8v57VAkJWW
 EMZw==
X-Gm-Message-State: AOJu0Yzz3KoerdCfRutRoPZmvqe8qahp/LcawSWH/6xhCuYNAge8Hs63
 LDqcJIXY/MnXUCmETfncGyLEsshnGLXxsw/iLj3h8cCxgVv7cEVvrZpG0vdqVVamUmHx8ZTx2nJ
 iCcBQGqY=
X-Gm-Gg: ASbGncvE+C6yFTnMb+i/m/wBYElTgZblnK3/aeGFFQjiGvwh9V6ZOmDsOU5YvKPl2MB
 NTdeXpYXD8q/bsCd0RPkuTOCES6a6YR6MktcbCCdYvU7qr+Pk69FygvOEnlJ6Cx8nCoBZ1g4llD
 FSQLoAAIKtSLvs+L1N2hG78wLXcOWTWXtC2GvYit7smjudXNRczHkpD1kxxVZhvFGsmXlRNQ7lU
 aPOf/U1YfeR8z3hsQOGPD2CVhlKLj/+/3IgHXwyFzQNNFwUbc9MdpbcQQmq/61qImuIAcCD5rJg
 3GKXfgcrzV35VQlz+AQvxeWGlZ3XUx/9tnpMhXsyho6xfv1XkowoeG7ynapCvPpaxq9aqG47pKl
 mwtuLqhNoa7M=
X-Google-Smtp-Source: AGHT+IEFUeh7YGse/HYg6Sh/9Cb19/EpH6s/1I14etDNmzNZQjLm27Y+DgtkFVd1IOzWBGiPkmJz3w==
X-Received: by 2002:a05:6870:d626:b0:29e:2caf:8cc with SMTP id
 586e51a60fabf-2e8620fadebmr4208576fac.37.1748266407880; 
 Mon, 26 May 2025 06:33:27 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e3c0b21cccsm4873361fac.44.2025.05.26.06.33.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 06:33:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>
Cc: Varadarajan Narayanan <quic_varada@quicinc.com>
In-Reply-To: <20250525224949.176427-1-marex@denx.de>
References: <20250525224949.176427-1-marex@denx.de>
Subject: Re: [PULL] u-boot-usb/master
Message-Id: <174826640663.2688859.1573909720869409303.b4-ty@konsulko.com>
Date: Mon, 26 May 2025 07:33:26 -0600
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

On Mon, 26 May 2025 00:49:32 +0200, Marek Vasut wrote:

> The following changes since commit df2ed552f0b05591090369a7fe7ddc92439dea5c:
> 
>   ext4fs: Fix: Read outside partition error (2025-05-23 10:42:49 -0600)
> 
> are available in the Git repository at:
> 
>   git://source.denx.de/u-boot-usb.git master
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


