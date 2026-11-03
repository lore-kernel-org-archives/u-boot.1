Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FDD606A31B
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 21:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zOIH8lQy;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Ycp7rcl7
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 20FC78060C;
	Tue,  3 Nov 2026 21:08:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HVMKU2p4zmYC; Tue,  3 Nov 2026 21:08:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 58C91806F6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793740113;
	b=AChHZDasN8f/4FRG0JtLu/89qGEDfo2uUmLm5E7zR11rOBjA1I9s/sEjj3OFz9huJbRu
	 cBGg6cI1d/7TCvSRNOb038Ia2P8X8U2MTD3U3UYxEJ8BEhqUDq24hDyxOY6chP6sVxw1C
	 0THqUHunQxzxcZWQTKmSJjT8qCwQqezD+HOALKC5rUl3HpJa4/tdlIRzm6hWmvpUth1Hq
	 tIAvG+e632Gtzu6tEVxXqucCT8IUStVpQUkklWHEeis5jonAXX6l5VnvQOTfwhRCBdjbF
	 uXmUEhskeO03qgMtL7NH8PPBM/DPmGCRq88AF389FiQboD+VtIT+j7dob5PI7QciUhA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793740113;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=GuU3mi53NiBdiXOpWXfEtNSuWcDZbPPbOw2D1Z18PsY=;
	b=d/WkQf91LcDPDB9kpRkk5xUc0hmZGjLaQo60qtSQqNCdHFfr8I+IkBbRsLFFlqkw+P1B
	 q7hU4hhcwchfLgA4Qd5GRbkTB3FQERZ5xLQ67Cp6iaaU55+0V9hT29CRnwxHj3ln1EVFA
	 CaLktFQ+rxZoxoWkrTCyPHGOnuTBpKKs5mf4BCRN9zWzbXC5itkNwVXQWVVTBXmz2S5KB
	 oKH79ndu3JxnS8FiDN//MgqmLjuK9EGCMyyIAH5pY0WQtufHRBYn+3K8ErTQBdCD8Zmzn
	 phQKxkjqN9/9hRpbhYrT49x/2Vxjmw+v4LNKSn9yRw9zPxevHeeAYUOgI64Qp/ZkUcA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793740113;
	bh=GuU3mi53NiBdiXOpWXfEtNSuWcDZbPPbOw2D1Z18PsY=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zOIH8lQyLjvPy5PJDYjXJJBf8f5xpz5wQTXAu5z027M3wmegDmkUnf7TnT8/ivYQI
	 PN7j58xKVyVzFH6w07GVXwlvm+BIKB2pzP3KECztPjZn5vH6Wrr/ey25z9pEGlxa0S
	 4xEPjAZzJHWAcPE9e0VwfUFXK5NaUdAjNKEW5x/JKXKn4+NcEbfELhQ0tEwCUzI6DS
	 +coGqIMhFG6SKbL9aou2NkHYzlAQaqkwa/UsvPYL53UWhKyUZ2XiUD+k6Aerq0DXul
	 MrPF7yOLbALBQgCZfhMyokFGu0JJyKDIeLJyn9pxSDP9AQeyy5NWyqeKd4osA/3lXM
	 Hn6W6Iq070HPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 58C91806F6;
	Tue,  3 Nov 2026 21:08:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D23D7235
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 21:08:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B81EC40048
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 21:08:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3FxFvpGnRRoR for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 21:08:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 66E4C4008A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793740111;
 b=B4DKfzhU19ZTMPWZMPXNRy9yOAoEfjZrgNwXGYyvhXQ/c0to2EOPceRTE+CtzLW0cB+p
 Pkw6RKMqoH0WvLsLLeabZCUD8uSQ4u2qVjW5s04gHb2hVD16lPyMKXGw0eBxR4IuDIG2+
 qAT+oSXSPpTQAhivn/EL1RjD/ST4mCeRcSG2JtjV5MqirIlSvkdHzldkumC1bVfaj1arb
 T5mpn4bECTZnpJ2zNzWA/huTtBX+09O0BY1ucoAaGEYDgTvySczHMaerkiNEGs+xnFX34
 PVTt9iPXeD0TUx9hFCCO5gufd5iqOpXVyx79CM0vHm0x3ZkJCmESXfw0PADKREZFB2g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793740111;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=GuU3mi53NiBdiXOpWXfEtNSuWcDZbPPbOw2D1Z18PsY=;
 b=BRBlCpO7qHPempzyKuVDaRdPSWcq3OK5BgOrYmTW+YxYzFG3X7dcsBB1JFm6Cszm30hw
 x4ngrn55TKTX+f6rrxxCwPRjOOzbT4qJUuQU1XfUeaA19vAyxIkCapdy3hJ6+gMjHzcFJ
 nSKPM3J9l5qSKLe81wYAY3jPWGrgZ3wmcn/sgrErUggKaCz/RGLZoiYqULQKf7S1EFLxp
 ahsiFzT/t5NrBbF0x1uzcVhdd8HjGcMtD0hsy+g6qQq+4BeQB5IkCbfFFcL0Ub3dHC6bd
 z7XdPxQpw5DBOwaCPMfOHIiPq8U9XfgBXV8/2r7nWQKcaK9dUVvOyUNPvIJrSB9OtSQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Ycp7rcl7; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Ycp7rcl7
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 66E4C4008A
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 21:08:29 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48b060ec084so24808f8f.0
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 13:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793740107; x=1794344907;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=GuU3mi53NiBdiXOpWXfEtNSuWcDZbPPbOw2D1Z18PsY=;
 b=Ycp7rcl7sN2AaWvkrosv2qgFnE1a4C1I2pxr0Q/ksaJhUyzowgN/jA7fcvctrb7/TD
 NicAjwPv442an4hN8IfoFmhv2nlZwDdrHL6RRsTBdPGjX66np5PqdoL5dERNDaPgS58p
 M7AOPXiD1qA7HY2nr8hCOu0Hghm5I4mOZA2NIHxs1PCuAv15P9kSR4kNtNawmJjehlBr
 KiBvRYtpaKyJaQ/4NEZ5ZQff6L+vj85+P419zLhsh6YAnL9D5g3zt4jxJxNS1SaueAgW
 G/FxKDp3kBgasceGy+8h4CjzRdvFxg7ipBzKH4+biK5IcSF1WaJaudOqUyFQFEwEm2gJ
 9oZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793740107; x=1794344907;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GuU3mi53NiBdiXOpWXfEtNSuWcDZbPPbOw2D1Z18PsY=;
 b=PDoirUrWo1HzRNzc9SCuhq2zCaEELhUKEfk/c559RYwYnZZ6vI4m8rUJPy8dRSL/cB
 rr4zHCItVJRDTGjm0JLZQdA9xVCeR3tNJ+gbgN3FdbPzbFDKKTxfHCiOH0Ru04u0lEr4
 4QPc6oTYQqdbsKeEl1hZ8kf5aXrc+147AMO6sXNHY5LMtVszYHy8HctQL6apIuvqD12L
 BTf+bCi98q1r7bcj6/DToAgvarxsHehyLK3m0Z9YojX7MSe5JsuLaCDKufhgWj0KSUo6
 5aifqSfvHzmJLJr5caDcj0OLz5X9jNU0jqj33vbVSKKYh+xryauTR4Aft2qviNcqh+I2
 MNgA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxz46liKiGDI89aFipl9E3XDnzKmhhCW1NFGRd56wfwhLwhl2VZ7NTUelvDaqoxoDEbrVJWCwc=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9HSX7r/XynG1C2y73zfm/fpOlz2EnELHQLjCGtrU0ugQLQ6Hxz
 VThJAk5sUQtmn3gLQ8RRsE77n5YUzY9YCmaeF581lWDefDLWbDLTiNiBZOg6CH0gZuB0ig7/bSb
 rdVP+
X-Gm-Gg: AYBFou0Uu9X7yO5yUI5/oBzlvvUor5Si5HAnasiIUd9ZDS7NtAPOD3tOh5BN04WR3Jl
 4hBEoyS3NPJivQJOyHmAq4VX+hfX/4Cvz+xRo7s0qu9OhznVD+tmOzkTw3DakgVHhPMx+j7k9+K
 nyk6S//zC7inZn3xqmMYbzixkGJvjiac1pUUhgSeE6CHssCtnSlI87POK6nnEGHyQRB4cUiGvdk
 OkHMSn5Zmjjh2E2ERbGOGczOImXZC1KpKtZuwLGZdW5bdGG7wDOPPeOhUCvFvqWvvZQXuY9XfxN
 XVpEmHAQJ+IFFJxEFmPMnvaXUgRiRLs1HI71eeX6+bHnX9T9HsWFSUigdAtKCYYkvP16RAbza1u
 yx+d0CoPubH54rTMO0l8FLiQXiPNn4N2wK32SMCPTrPq7dlgPRbTn9anSaaqiXtGFTBWWf+7kP2
 fsSb+ZCJDnAGyxtwY/puht+3Fe9oVRMA2rhTHcx1dgUBTofCks97teiQu15cK6gVBK7ehaDKMtR
 50ULWuxp0yOx45iEyT5N2Pg+bW3wP7YtwNjhS+h+tFukZM3S5ubseNSxD8k43D5+tpnQyNLVJLU
 ilTMG3B2sS7bzSLf1+KQOF2lXc7u2PjCM93P8kGrWB07J8fn9g+TClYTBpt3l1c/wJl7IFyO
X-Received: by 2002:a05:6000:4616:b0:48e:6c3c:c836 with SMTP id
 ffacd0b85a97d-48fbd1f7766mr3174852f8f.38.1793740107605; 
 Tue, 03 Nov 2026 13:08:27 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fecac2772sm64603f8f.18.2026.11.03.13.08.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 13:08:27 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/2] libavb: resync with AOSP 1.4.0 on U-Boot's SHA library
From: Guillaume La Roque <glaroque@baylibre.com>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Vincent Jardin <vjardin@free.fr>, Petr Hodina <petr.hodina@protonmail.com>, 
 Bruno Banelli <bbanelli@gmail.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Jan Kehren <jan.kehren@emteria.com>
In-Reply-To: <20261023-upstream-libavb_b4-v1-0-97ed25b09ed3@oss.qualcomm.com>
References: <20261023-upstream-libavb_b4-v1-0-97ed25b09ed3@oss.qualcomm.com>
Date: Tue, 03 Nov 2026 22:08:24 +0100
Message-Id: <179374010424.3704535.10591741002927480507.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793740106; l=646;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=jpuKvFUrBBONRjdligleSOw89GJEBr3p00B3muuJo3M=;
 b=mRuX7xczwREimEM1TGlvmW8GbyGNzGeCJ4Vg4mqGJkhIJ7C42AW8KKuPzF6IIygjlwmH4EdVg
 V+KNQDggXKQAqyWcDjGZ42W+gXHKat1/RH+CVBp744zwID1/i7WWiJ4
X-Developer-Key: i=glaroque@baylibre.com; a=ed25519;
 pk=nMpSg4NT6M6q143E089emouMc+MXpHO9CWmnEUfjhjI=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 23 Oct 2026 21:50:44 +0200, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com> wrote:
> libavb: resync with AOSP 1.4.0 on U-Boot's SHA library
> 
> lib/libavb is a copy of AOSP external/avb's libavb from 2023 (1.3.0)
> with U-Boot glue. Upstream has since fixed a verification bypass in
> chained vbmeta partitions, a silent failure of RSA verification on
> allocation errors and out-of-bounds reads in the key parsers, and
> added the vbmeta digest command line properties that newer Android
> releases expect.
> 
> [...]

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>

-- 
Guillaume La Roque <glaroque@baylibre.com>
