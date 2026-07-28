Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B8E7C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 21:56:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E2DD160A5C;
	Tue, 28 Jul 2026 21:56:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NDXHbAq1u6Eq; Tue, 28 Jul 2026 21:56:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 188E460A4C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785275805;
	bh=/QiEGx2jsKXmktbQtp/bUhSjQ7v9UXQNa/XunA2j9EY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MJGsjfypXUxfMXcyWFskIsvqBVMY/tk6r+bZAn1UyTYZvtJ1hif9IpLDpVBijDXne
	 AFfq0+oniWqJySoVB0Kc8rlQrtJCZRdU4hRkMNsK+m3o57271KZtPhCSfjNFUvQuKO
	 cJWG4+VZ5Wg794SAeoHnYZaQjnJKmDPtUogOXKzXXlyH1liLJvQsLFqExGdDUqp5FK
	 nfArIx9bNFSxZJhsf41HeG50FOzalyxXzxihZDT82Q3X3oxW7jyPcqkTaC8LMywrai
	 4JLTHoy+0gn61f1FVF0UPNeQbgZSyeMQWu8A2JWr9DgckoI83pBAz46yz1az/nElU+
	 ZQPC6AEEz/dVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 188E460A4C;
	Tue, 28 Jul 2026 21:56:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2362F350
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 21:56:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 14BA9401E3
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 21:56:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1WTO4EzOOKSs for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 21:56:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::331; helo=mail-ot1-x331.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5BBC540051
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5BBC540051
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5BBC540051
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 21:56:42 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7eb68bdf53aso174931a34.3
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 14:56:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785275801; x=1785880601;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/QiEGx2jsKXmktbQtp/bUhSjQ7v9UXQNa/XunA2j9EY=;
 b=W6UxNt0LnDNKGsz9YtdBzNFaRgLeHli+Ul0LJyzm/sqUl2d1ymUq4aVwdAPyipD+Ky
 q2AtZflQrW9pvYL42U79lh+ulMpYRNp8JqGPgv3TxWpdB1RktTcxI6EXZ/sTP9vVzEiK
 OgIFBdRzWFiCf4c6wj7c421G7OqyGQwgFLypKmJy8npooiop0C6qnHX59oM9EgQlzUUO
 6DbfuBE9juD0TEZdTfUQLTCUWOnjEuNhV4Q8GWGRzJysULkqGrTiBqOGdQM8+OSYTLaL
 DuTEivlfHgmS/2AaNohIr1Qgm9w6VdTs7Aj7j8lYREqeEgI3zNizMR99PmIew0lL9TwW
 0SuQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqhABU+Si3ZIpNCOk6q+OBFkFLPGPyejOOQ6XX3DJKcP8hGjgVw4A4qGXS24aTnOtvYYIBxonU=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwfPjoSsfVU1HuCbR70aGSX5dFSp4Ik+N09UonH80QwjIAAQguM
 pjac+0kuV5PtnkEWjoeKqY+tPMoZQucjdeLlnvFiIfT+UGwlhoBoD6hgC0Gc6x4ZUC0=
X-Gm-Gg: AR+sD12+uggJY2WLjx0mms2UY4gNr9Eh7yc5y8VXXD2sqelAm163POBp4S4iA/IZbwN
 1QNMtSARlbtzh5ndxzO2I4xIy4ADN2muXqHGpgQnImJfH8MFa1x6MS6crhiMWVhVvu9CHN+m/tP
 38SCD0ErGQCUJ2u9WRD3WnljOZO5lwQhwThYuDRx3DHj6ZBtut2ByTcg4Ib0/7iiOfbtJQK+ZTV
 udGAxgm/Z+4yuRAZt8De9MEP/EozbxW1EArKNc3OHBuojOFvvvFFx/kl69vhPcIKpok3+3cQMFK
 2CX50u9XmXfLyV6PeTUBlwJ6BSQ+g4grkrLTSLak4sXHHS+zuMJallG6x1OCTxhSV+dZARSt70K
 0zlbUgUivtE8OFVLy1VlKgN2m/xfc5m/L8qSShiGFeMztGwG2xXlKGgUhS8MN1gnU/4kTJlYNvI
 YTYAXfgjYLfb5S9S8dUQ8la5okrxN7IfUtSTMQBHk0lJTP7aWLR1rOd6DI0Th+MmkUEDmzNM7wX
 yGJeVvYt1iHr37AbUfaaoI67d04ubdYubc2nAzehJvI7Ohzhw1XE1UOH4H+NwVKeHkE18zV1aJW
 QRTTN7/jyRZAT4MmeuE=
X-Received: by 2002:a05:6830:4414:b0:7e9:f0e6:fd55 with SMTP id
 46e09a7af769-7efff2f3efdmr2565397a34.30.1785275801164; 
 Tue, 28 Jul 2026 14:56:41 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f00d2d8112sm780106a34.0.2026.07.28.14.56.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 14:56:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, u-boot@lists.u-boot-project.org
In-Reply-To: <4f847166-b282-44c2-81a7-b3878f3a9480@linaro.org>
References: <4f847166-b282-44c2-81a7-b3878f3a9480@linaro.org>
Subject: Re: [GIT PULL] Please pull u-boot-ufs-fixes-20260728
Message-Id: <178527580041.1742553.6745438013763186146.b4-ty@konsulko.com>
Date: Tue, 28 Jul 2026 15:56:40 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785275801; x=1785880601;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/QiEGx2jsKXmktbQtp/bUhSjQ7v9UXQNa/XunA2j9EY=;
 b=EAopk/bjzg761/XvPWMflCvWzE6NWX0ZAXCl6v8orVkN6w9gnIEoLs4Dyq69nnzfnz
 LX7Pm1rQY1zkspCWH1RSfl2xfUXIAmC2ZjDj5KktZWZGrbl1vwR9KPx5tjxHrf3vuG5Q
 mwEtM/AGHAEp79uJ/iGf8ycXVuzk18yP/K3LA=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=EAopk/bj
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Tue, 28 Jul 2026 17:17:02 +0200, Neil Armstrong wrote:

> This is small cache fix for UFS reported by Jorge Ramirez-Ortiz.
> 
> Thanks,
> Neil
> 
> The following changes since commit 042e45e026c77227319a426940577856ffe62e7b:
> 
>    global: Switch from source.denx.de to git.u-boot-project.org (2026-07-20 11:13:21 -0600)
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


