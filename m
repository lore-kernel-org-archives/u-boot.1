Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CE0606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 13:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mUWozCGU;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=ViEFQFK1
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 37197405B1;
	Mon,  2 Nov 2026 13:44:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N6OZeIeW3Qw4; Mon,  2 Nov 2026 13:44:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5146540435
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793627044;
	b=GU+zTZcPC/uYLWVgLblaagpZbRdujTo0Elcpqlq1AmyJQZ311gltCRJ/988v3YeT9CgZ
	 BfrX6PSXib6MpDjSEXE+GZDu/IwwfLD5LFyftlvE26eUs2UvwcgpmlOvo71MSj6J/1cjB
	 YMcIWSuyv8eeEsRQbKyb3cvdo3NM6e1uXaV3RCZU9YjrMKA9doXKafEIcg0CAsWAnebtT
	 SxzgLrWwXAVzny5s7l9sYpJnBftFpvycVCGekisN4h8l7hP72vy9yX8/egThILtIMSOWV
	 YJ1DLnMzGJ38+ImPh976onrSiH1CY9/VtO1HKrPl9TeruJLlDZ/+qFj48Hvh7QJU5+w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793627044;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ZlNVmMezUi0IM9PKP9DUQptN5Lu9ct6Xvybaw46pxDA=;
	b=qL//H5VjJ+67iRVrQH7DtFMeZT1+dmdPerTpAUIBsIQkUnbKF5t38LUNoNgWlqlXzY1S
	 xagwJIr10h7gZVtJpG3b4sxKrbOzARqspK2qNSfVBIXu5yVtO4sUNoJSwHu1AV7/sVicS
	 awNzTU75HYNiopHZSNQDQwa39xeB5rzpQu7u6fxYebkGkWeCXrPVJwST1o+r1hs0mD7+l
	 ZworkD1Rqiv66WH9bAp+t4uOHLTSYgHOYrTMOYwYmhwGjtaakDJJuocwwjJbcTgN8ctHP
	 I00yUNxAHSUs0z27si8tmb/bg6jb6j8pgBWZ13JyqBURvTMhPrLe4VkHs47PBPbmYVg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793627044;
	bh=ZlNVmMezUi0IM9PKP9DUQptN5Lu9ct6Xvybaw46pxDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mUWozCGUAbrQtZdh77M6n1VEVWQuP1/Y4MD5tJ4jGr4kKBTzZRZReN2f2rBf2S2n5
	 McVwUmcX7yHAoysufDaiRflWB/BY/HNMYmO96XZedAthPvF0DLkdWfh1w93ZbRfxoZ
	 CxXzHJY7iAK+8Wg1eLTEAioIvWL5DWicA7vaT6HNlAThJxiUWoCIGAhRCClJqcr1xb
	 p8f8Hz/lKCTl+vcyaPrtQP4uuYIvVKbGYrqjO1u5sliMu2U+YCU0A+g7KlVFM6JzX3
	 SnWxSVSunbAIWd0x65yvBt72awBSM77EaUs14zBbR3TKSrRZ1VYPs+/A5OTywUgcj7
	 f7oyGeYt5Nwig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5146540435;
	Mon,  2 Nov 2026 13:44:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A4F45411
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 13:44:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9675880C3D
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 13:44:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i9guw0qEYNXx for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 13:44:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 931B280BD7
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::534"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793627042;
 b=SxLjgzEDpUrAZF7rgp6OUSw8k6s0m7afk5AM8uks+CfAPGHoeQM74akn2Q1ecHPp3Kja
 jRyU1xRgqf32ki65pnJmU4T9bIImUqXBwM2ZxBA4ZovfgtDdrQqFwiSkbOzGS4XYHkk4N
 3dNBj8B/S9HHUsxMWPwhJy/ChczXHtGYzMxKhoP+OAH5i/YF4bUQLuInQCCf+LcV8tEFy
 bpL8HFhoc6+9jMC2/aEU4fns89xn9yIBSXjydxvazgbGL13gDfIDi94lLD8YXHlAIJ3j4
 Tcalu2e1k95z6iGxSXVpYkBjX+2ZfAI/pndGRLEAh8NRuilTM3FVuKaEurUz1ajRDLQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793627042;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=ZlNVmMezUi0IM9PKP9DUQptN5Lu9ct6Xvybaw46pxDA=;
 b=Wxx9ejLK3/SaUef8Cn+xfMVfzWD0mqxFhyDXM1gG1u7PL0dQzLmk7AzPnK3spz2EhW/a
 rxqFkMlgVnOI+XSs7NMIPAvIv6yLgvKEJDEytOrsACho3ybReNT2uTmfLqomU9c0zjklV
 f2LzaJVwKrmqenZsrEwRcpDjrAyGY4PLwSQZ2dgp+o8bsXwIbKnJBx1m8desXe2DLohbX
 /LxN5Xj/pMdaCc911lzXgIPf+NXRcTlc+XGqNQ/hVH1hnQA3f+yaxr21ulQ5HNgDDXw7r
 ffhecEpqaCiTU8X+LWvPb8nbi2rh35u+IgQUIvOs1vsPaSz+51GxIvAyemA7hlUYotQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=sifive.com;
 dkim=pass header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=ViEFQFK1; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::534"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com;
 envelope-from=leo.liang@sifive.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=ViEFQFK1
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 931B280BD7
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 13:44:02 +0000 (UTC)
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-cc502d509c0so1127954a12.2
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 05:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1793627041; x=1794231841;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZlNVmMezUi0IM9PKP9DUQptN5Lu9ct6Xvybaw46pxDA=;
 b=ViEFQFK1wTPdwrgQn0DIuOYEncvcmDOoQ+h3AynmbqKJyVxGvrRcXmkD0n8efmzGe5
 SqPwFqIy+QY3EEKkwqMrn2okAac1qU9MP/OCHPoxbwH/WZfE18D0L1cIwRqTGZkQTnlA
 BgD5vqdHMwxIv9UFe11Qzv4Jb9YOwZgu16zAfuuK//0HHLhB3XprJ9IdZu92NVrlOLud
 j1nFCg+3g8XjULbZhU6sRJm/yUzVnkmDbUeGnO6oHKr4Cqy1j4ZW0TRXvmogcwZy6TK7
 dYwQw/DgmK/5rMcvr2Vf0EKUP+EtZoe0P8dma2rHAHCYp7vpd3N73mGbnpOrLnpZVNMs
 7FZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793627041; x=1794231841;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZlNVmMezUi0IM9PKP9DUQptN5Lu9ct6Xvybaw46pxDA=;
 b=tMHZ2keTNu3u45Ic0lpb7uqM4HcddzKYI4Co+HKIfcKSME1IsdlPrVsWMcsyUbB64H
 yKXBc49ucbdzZRtgAY21m5FPsxgJhH3xCtbgUbJSz0xZBvB6mYZ9jsGq8MfiduUl/IBD
 b91n0E0WdC6KC8d/0b4ajGxUV9YkjmEA245tA0yfH5ZWMmAvJefoFjAPWHvCSZXNCk7l
 zcigwarTct1PxP0t79oF7E5zlwB1XkadZRsF/PnySyN685Iq/IYZtBDULGCogdLHK0Mq
 jIN4CNvDhymhdqWyRttiqF/NYU47OAlMIcShQdls5ZfGCo8BMh5G0tH1IQjyaHiTbWFq
 dGAA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx4e9zvw4x9MgWel5hNZMn+juJ4WQL7NbsVwvHkxf35ntUJzFO+QYXVUP+W6SPWbzD1JLI35+M=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z84RCc1Z4SuB61YGFlaGzpq8zySq2UMXcSwm7BM02lTDt6WnXI4
 YAwPaoRtXQSkyk37dE4pL67/EqV5Am9EM7UMCsK06ZJOXSV1lSpbnJYmLXIEF1haJmY=
X-Gm-Gg: AYBFou2/2Q9xWgkLGJ3H2XItQuFXOHQ9znRdwGBIMue0Ck8Fw++ptFcnBS4/W91+Su2
 ERTh4a26bF/yChT6CGAeOjiVvsPkpry56xU8M3e0gqDIApVPJF9Amt6jkzd03UlnzzRWHu8KkKU
 zknNplX+hX4E0VQxTnrM/Ms/bnmzS7J7yxL8TSy9zxwsJQXD6abNLldtPXP7kX+VUrSV3FJLXXN
 /AdRSD4FX1wA4fBKVj3k/Z7xq66zb2utzh1Cu1fVttOTgW8nB5Rxu7+w+ZVsDn3qeVyssYtqtP6
 DpC2kn11EABefm79lTh3w2rrYyudezbDjAiM26ld/HXWTjoOnavrwIa+wFbmH87rJhNVkW7dkr7
 zc5fD32Jqc8qW8Nc3Zll8N9YGrmqUDb7Nytdy3NDnHcOV6anv4kLRWe3INsPEd6yNF6v7hDp/FC
 7++fMs3WHNuPXTXWhUXruFsDXONnuULwz/gimW3q25xw083oyfnVUAIGFAyOlK6OzjsxsPVY2Yl
 4YkrmPiHgqsQPOKEP6chWyZ5AjrsNZ0ZVFLzIl2DFkN32dmTWAUAeEuv668cYY3Z6RVifM7HyZz
 nhc1ra2M8SWvwk+iFxGTBL4B823wQ185fgSagYQmfpBC
X-Received: by 2002:a17:903:2c06:b0:2dd:ad74:ac32 with SMTP id
 d9443c01a7336-2eb3643d22amr98611445ad.27.1793627041468; 
 Mon, 02 Nov 2026 05:44:01 -0800 (PST)
Received: from lliang-1876.localdomain ([136.226.240.173])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eb3922f5c2sm29528205ad.20.2026.11.02.05.43.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:44:01 -0800 (PST)
Date: Mon, 2 Nov 2026 21:43:58 +0800
From: Leo Liang <leo.liang@sifive.com>
To: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: Yixun Lan <dlan@kernel.org>, Huan Zhou <pericycle.cc@gmail.com>,
 Eric Chung <eric.chung@riscstar.com>, Tom Rini <trini@konsulko.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Guodong Xu <docular.xu@gmail.com>, u-boot-spacemit@groups.io,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] spacemit: k1: drop the CS1 DRAM map on single-rank boards
Message-ID: <auiTntm-_IzPBUd0@lliang-1876.localdomain>
References: <20261031122721.3240434-1-alan.tseng.cs@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261031122721.3240434-1-alan.tseng.cs@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Oct 31, 2026 at 08:27:21PM +0800, Hung-Chun Tseng wrote:
> The DDR firmware marks the CS1 address map valid even when it trained
> one chip select, and dram_init() adds up every valid map. A 4 GiB
> Milk-V Jupiter (cs_num 1 in its EEPROM) is reported as 8 GiB, so
> U-Boot reserves memory past the end of DRAM and passes 8 GiB to Linux.
> 
> Clear the CS1 map valid bit after DDR init when the EEPROM says there
> is one chip select, which matches what the vendor U-Boot does by only
> counting CS1 when ddr_cs_num > 1.
> 
> Fixes: 3691fbccfc89 ("riscv: spacemit: k1: probe dram size during boot phase.")
> Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
> ---
> This depends on "spacemit: k1: initialise the EEPROM index in
> read_ddr_info()" [1]; without it the EEPROM read can fail, cs_num stays
> at the default of 2 and this change does nothing.
> 
> Tested on a 4 GiB Milk-V Jupiter booting from SD: the SPL reads
> cs_num=1, U-Boot reports "DRAM: 4 GiB" and the second bank is
> 0x100000000 + 2 GiB (it was 6 GiB).
> 
> [1] https://lore.kernel.org/u-boot/20261027154347.1392094-3-alan.tseng.cs@gmail.com/
> 
>  board/spacemit/k1/spl.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Reviewed-by: Leo Yu-Chi Liang <leo.liang@sifive.com>
