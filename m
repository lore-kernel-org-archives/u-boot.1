Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CD7606B458
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 18:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tFMjfS1F;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=B/+u09qe
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3A37260EED;
	Fri, 20 Nov 2026 18:13:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Isf5PXoHrvqB; Fri, 20 Nov 2026 18:13:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 85F8760ECF
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795198427;
	b=c6qZp9iLu+/k5DT7RUbBtcqIb2uYVjYz5jf3TN8H2VeaNlauXaRviyklGEQ6cJY1qUq9
	 6AfX/XeMeX3gjO8mJrz4Ubb+yZPD0ru78Qtb/VS/jaeCg+xsQqaOmIJWCOrD4hA2qbeig
	 wilWKfRCOlrr/bg38zfxI8O6O8moUoXdKgQYSo+6vd8lexn8DRXxVkFCYv/r/86aalBx6
	 DqHxDupFVCa3m+ngUsnRowEWUQP6mROAMvM0wNvQCqrDj3Q1GNsIHKdLOuAFLevXheOi2
	 yKX2B0GBRZAcpgTYIUxmkgUdGhvAaNiY72gFMXF9A8oBG5KTkJVDzQAA46prTOzhalg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795198427;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5w0yP2RPOzk7t1u53DlisqrPLBm4z7P9QKNn0N970wU=;
	b=USLfv1m9XhWRRSHillt+hzSJrh1tp58g8l0bH5Z2O021FEhLmZIhxQTLeixNpV35QCmF
	 iBlvc/RaYsAI+sg3LgUlXz7W1d+8H/YKFZJHbGjn6vjbLvN6JW134M8NL5YqtesDx38dh
	 wdNHwXii/vh/bxZq+lUhDE6vkIXCLBgHv7xuyACm7GWbKzECZS4Ts4wa7XS9xuEQb4seg
	 CpZ4nufTgRO3CBlai8ZnEUfzJ3XUCRRqqO9xB124ThcLH9KJML998a4ee/a5FmA7u9LdJ
	 aq9rjNiklZ6W13rKT2Ptm/zljQNPcfb4ZQ3MJFWr3LPlebe52BeyTefs4tetiRuBeMQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795198427;
	bh=5w0yP2RPOzk7t1u53DlisqrPLBm4z7P9QKNn0N970wU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tFMjfS1FtANatHjee9hahJ6yBN+tqWmv2ZGjRNUK2uYHdryunKwY3/YlDIbmplKvA
	 KpBvKmyL3XOwOww7K5mXdZ4RbLyc5yNISgosBv3Ct6fP/6vOdllxOUf2gtynjLpjF2
	 nj2llDjAe3Kb8qS9YR2n+sFObjutkRZHcf+sU4R7rAdntD7BsB1BdRjFLIwYvQw3aS
	 u1l2GyqjRQf41A5codCIql7ai1jpJaPx7ULl36HJEF24d0WlHNE1c5ftCIQ6iGZssK
	 c7Fgu2l1ySUywDo4awbhzd3Aeu2RgQ8c96kaTyqYQtiU7Lu+PoC0sJUpdJ4FJJLJHq
	 +9+tT5QxgE3mg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 85F8760ECF;
	Fri, 20 Nov 2026 18:13:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E5F07A08
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 18:13:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D38F64022E
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 18:13:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ziddQt7VEi21 for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 18:13:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0A7FA400A2
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c35"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c35; helo=mail-oo1-xc35.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=B/+u09qe
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0A7FA400A2
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 18:13:43 +0000 (UTC)
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-71ad099391dso601580eaf.3
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 10:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795198423; x=1795803223;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5w0yP2RPOzk7t1u53DlisqrPLBm4z7P9QKNn0N970wU=;
 b=B/+u09qezHIcjjGt/NotO3f+ZBo3u3h0VVMJ8WRaxKvFhiQEmO/rs4ISiAqa0XAHLh
 gY3wmtXgS7RrsivMeQH7x/x9u5W4OH6Jm2nZP4ay7I5dk3FNJlw01P2pcM6maAzRivUz
 fA3fk4BsEOg6n28YTLkdmsEqui8U69Q4nj6/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795198423; x=1795803223;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5w0yP2RPOzk7t1u53DlisqrPLBm4z7P9QKNn0N970wU=;
 b=FAHBrnGaf0BuVqfOo0Zdl4pmE/3rDs1AUhhGkHcg4knW55vxHOnD98z18mfNEvAilp
 xholFqwNvK8qTSVo7azLguln+XE/NnqjVo/nVS4w5a/E+Q0pqrfppcHhpSQPH0fh+UMF
 Qo+TxHTgbw2s+pI+S7liyYlOWpQpHpkMetQOeRkSV/VvO9yPKCxl5XnxgEKWsfcbIlQr
 cHCEJ119zHVm/kPJ3GG4TiwxJTyCXpoSvc2bi1DyJhD+YW0XdoIEYkH3X3kqHKSYNRGM
 L13zrUOcUwMYBVAl9yRLe9dPPoQVbvwl4PGOEHzaWmgP1ljT1dR6xhzUVmgb99dxobye
 JvmA==
X-Forwarded-Encrypted: i=1;
 AL+hErFhNj8lsv/CkTpufWxVn0S5cRHft8I/3QYB8dWaLtuLnS9TybpGJtMHz+ZU3KTEUeHt2WkO+IU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+O3dsX6eb6BitXnbW6a11QiyyzlKIntCrie0IGWZjV1shSkDib
 mbTOsRZUfHo2vhx8KSo6g2ui3IWCuAKMcQoiXhWy58XRcMOW4/uRuGQNB+9X9SQRipY=
X-Gm-Gg: AYBFou1dk8y352aZkIhcRL8mkucx+SQ7CmmHB8Ka4KT1jjLv/U1yWvYuFV5YYipJhcc
 s2XNyU5N0OIDFN8NdMkv4cUE2Ap6wS4Tpj14/clEHuhLyAHORes0ua3l1eEnDyOnJ5CStZTrmOM
 w1A7MgmqmIBRJ2Mpg+6i2juvi0w0wcbq7wyr4Grh6Xm23H1Q6xtpO62lv29LvI9ZQAqLXpJ1j5T
 Rok6arA2UaHo5937EBvYK8p2tdUQ4rA4F1yii2RPG0bRZdHj4lRDJoiMqWgoYETL2sxtKdgCe5l
 Sw5yEKcK5/bEhgH6SNJ4mMbHhfaZidNNsH3R4skOAAgitAs68QcGP07vN2x4zofJlQUYo0kqN5m
 /iPC1e8AD1oG8FGQtFdp5xHh8LFaHJCXtTh5jP6m+azKCCqF9sZeRptpEDLE9utXIkPvXLniyLD
 kC5a4B7JwTdKE5c9aUIzmyXyYlJ0VxbqYAR68N6SGpAXGpj1zOL6dYdsPkxThV8NFLqdD9MrDwP
 AJcaOLStw6aAtKtRUXHVMKRJb5Ty5gZT0ZV2MScYu/TXDwv5t5Sd5xsG4u3yBwdCnXFSvbmaXbr
 K02HxmdRMG5jzcJH3kkCAZQFHJSbAKtaa1qH+gxYvnL+plu7C2BCQXWPHIl22cEQzEqACUHNXCr
 cA4vH1kfwidUOTFAG4AllN0AGxZrD08PbudmIe65HZ3ProGyiw8MS1t5la18YlFkr8bAcQxk23u
 5oOq0gX6Oc/Bo21Zir860SsVs0UqQUoFkOyzdk2z1FiWP8c85rrL8=
X-Received: by 2002:a05:6820:709b:20b0:71a:f209:f038 with SMTP id
 006d021491bc7-71b3957b875mr2198919eaf.74.1795198422656; 
 Fri, 20 Nov 2026 10:13:42 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bc5f7ae7dcsm3283842fac.8.2026.11.20.10.13.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 10:13:41 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Julius Werner <jwerner@chromium.org>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 u-boot@lists.u-boot-project.org, Carlo Caione <ccaione@baylibre.com>
Cc: Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Randolph Sapp <rs@ti.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Johan Jonker <jbx6244@gmail.com>, Alexey Charkov <alchark@flipper.net>, 
 Vincent Jardin <vjardin@free.fr>
In-Reply-To: <20261109-ccaione-upstream-fdt-fit-v4-0-5323cbfcc9f3@baylibre.com>
References: <20261109-ccaione-upstream-fdt-fit-v4-0-5323cbfcc9f3@baylibre.com>
Subject: Re: [PATCH v4 0/7] Prepare devicetrees from FIT configurations
 with fdt fit
Message-Id: <179519842087.1013065.15487049391429222038.b4-ty@b4>
Date: Fri, 20 Nov 2026 12:13:40 -0600
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

On Mon, 09 Nov 2026 22:48:17 +0100, Carlo Caione wrote:

> Some boards keep a base devicetree and its overlays in a FIT, while the
> kernel or EFI application comes from another source. Boot scripts need
> a way to verify and assemble that tree without booting an OS from the FIT.
> 
> This series adds:
> 
>     fdt fit <addr>[#<conf>] <dest> [<len>]
> 
> [...]

Applied to u-boot/next, thanks!

[1/7] boot: fit: check allocations for decompression and alignment
      commit: 0f6a75f56d5c22dca058b83f982e7a49cd4c366c
[2/7] boot: fit: free temporary image buffers on load errors
      commit: aa4d6811cc88d1b6e506a7f6fd17cfe5f099292c
[3/7] boot: fit: tell callers when a devicetree buffer must be freed
      commit: 210fd33addadde797af099e3458589808b6510c0
[4/7] boot: fit: reject configurations with missing or invalid overlays
      commit: 7d3bc6dcf49efad200b08e8c64032ed55f1ed55f
[5/7] boot: fit: let callers choose where to place the devicetree
      commit: 19fb71a051a2f0fbd270be5f0b1fad5273060dda
[6/7] cmd: fdt: add 'fdt fit' to prepare a devicetree for other boot commands
      commit: 8c1bbb38c6efbaa6053981603dbdb5dfaa9fd7fa
[7/7] test: py: cover fdt fit preparation and failure handling
      commit: 9321cc8959c2b4b06daef03b3ec7aad812738cdd
-- 
Tom


