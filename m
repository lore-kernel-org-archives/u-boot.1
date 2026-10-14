Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1902CC6B1D
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 13:00:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 61FEB6083A;
	Wed, 14 Oct 2026 13:00:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r5YlTD17Fxrk; Wed, 14 Oct 2026 13:00:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 41A4860818
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791982854;
	b=ZGCV3y+6RkJBUq9ZtN/tLuxT0aUAdY8vH7oWpoUBKao8Mu1PDOXAzfkewMkd6sdhOtQb
	 wEL0blHsPy+hUOyUu4yJchznVWt5gtSQU3dCvsXPaqoDnVc+IMm+Schej3Y8EmJnArq/T
	 nNUhJf88QtlJTgfmGcuzyYkUhVnI1Jw8lz2sAcpbgCdiYG+9wf5lTVuNWMknc4BTBwRiU
	 87FMUEvuTnClf1aMLhJHrWgfNbdeRov4xfBmM6o4DK9YWeeSq7J4V27s2iP7529cmf3xb
	 AYTk0qjScHsazbhROX0KIu7sodauJovPcKrLqAnPjaUKRMNAmr/sd4CSghTgb4NJgxg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791982854;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=afCgs29GireRfHwCGnrlv0xaht0XOhwDp2+ZvecNVN0=;
	b=tJbOipY5Tt6mHGX6eoSTNq4fyHQ5NxmL1VR/GL33351HQ1HgCJyFj+8b/HR601Vv7fxC
	 OLetzVMJuw3CAKJPK+nrfAUry1rcMzy1UK964KvjC1lKz2W4Y9hmeDEN+6c6HRktfjCYV
	 sWeep4t/eHMK7lePpKj5bWspsUJ3lWZ44XPDiNvmcC9EH5sFzmzAjbP/6jcpJquxPiXkn
	 QLMgrprrCSdeM9FVRmXN12gRnp1fXa37gTWCl3BUXRR85qAc0lvFFPHtJs264pAo/QHrO
	 ZfpWBM4ojPFbsIQiVvRuWASRmpKSQC6kH2SF5Bqgmy9KH87mg2V4Dj3NreJDjCIWRzQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791982854;
	bh=afCgs29GireRfHwCGnrlv0xaht0XOhwDp2+ZvecNVN0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RT6HZzj3nJPxxmQO/Nizcf4eOD0ZrjktU3dbSkmbepvsikv5lu8PUFwAmZC7s8wMG
	 bz7ju9qkkEWFTu4tUVhtvyBJXh7TT4hpqIBROki5j/fSPvfv+BkawMYC5ijQzgNLqw
	 49Fx0OmwpAD1s1LVjB2aGRlcz3RMM9Bybz4aVmEs8Xy+cKuMv0XpRabRgWGbaU4zyA
	 N6vjY948bIOQVX4JvSv0uwhg+Z99EBd+DHiJ3uAIQZCsREfR5/iZrZ77RzbShuWStL
	 Mjzl7TgEq4g8wsmDV9PrklD1hAmDFxSHAKvjNk4bSSW2JJvFyMFUvMFKo7GIdy/45k
	 J1+TSJCMAK8eg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 41A4860818;
	Wed, 14 Oct 2026 13:00:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B0BC11DE
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:15:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 96C57405E3
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:15:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ayqiKbIXP4_e for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 12:15:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C9D10405DE
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::52f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791980121;
 b=VrB3o0k44j6ZzVyDPQaJslLXgpV+xA3aaJpXOtQlaeQqdV3x2jc6lZfUVWu0nqFkBJLV
 5C0SpDG7sr7pOQpMQL6eKqGf3FlwBCOwsBV/+ctmgX1JTGHJknf7bUwb/U/PRkJHgueCi
 T28xzQvJSZFziDyto12geg2znAqKpSgMtMEQPMK17actX8il7JCrZFHNzlqtHAe4RxvCY
 pSCE/MXx51X2bE55Tb84tMLf0q9nFFX0td0V+hbiL5cc39xmeeD3oCXAIwqFMR+YJibNS
 TzkIbTs617JLfXHS2fG1Pm31H9qigTdqmkeBxNarpKVVnRsT2Of40DEeL8cYEs4eH0w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791980121;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=afCgs29GireRfHwCGnrlv0xaht0XOhwDp2+ZvecNVN0=;
 b=T4JCkQ/9YKBPnNTonfJglfbzp74VFNaJPZP71/faRjZbtojJnWEFMFRqOY6vDMqobj3i
 SfxVO49+YWG03OqqzZf4LhVSTK6RoYOmlG5XUmFz8HweAff4m7Dero9vmWbaPAAkXax9A
 N3YLc6UiT7x/Y/IkgQG9pbyPAlzp1zovjtXFyFLMVVS4cc76xiOHbT6seZtkOnjp3AKu7
 q1elG23Ku3RAXAL3FJqfNSUPFfIBJ8Fj1Z8ezldRaJkDmcbgpuuxMWs3COhSZdjmO9ryV
 z2ROsHAqWcXx+MNUctKVqTu/rgUhU4NRPsJRVz0DNCx8sZinsUjIlV+8tUUs5xFSpCg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=J01mkgoU; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::52f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com;
 envelope-from=tanmay.kathpalia@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=J01mkgoU
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C9D10405DE
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:15:20 +0000 (UTC)
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-cc4c02ddd62so442635a12.0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 05:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791980120; x=1792584920;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=afCgs29GireRfHwCGnrlv0xaht0XOhwDp2+ZvecNVN0=;
 b=J01mkgoU1x07kboxkSwl9mIMTeJH3jnfkfNb4jHeoJAaWOZkR8gIEl+eMuhwJSDe72
 m4k4HcDOXfUGZTg+6HWnfZjC8/VODWyDwGjMAPHPmpCaEOgvyK8PLxiYxugrXmfFQarp
 E6MrqUcFC12CjFUDKkg6Je+oGDORLNPEvKWuIHLk69bv4zKdt/sH4364vtEsQlxOx+Ei
 A7y99UBXknRBu7PUi7a17TwF9LvWvZUUfkgENEiFxQFfmohaQZl1cg4oKO4NPv0CXd7o
 7yQAm5dTLZzgF1I/Dzet8R637NYvN+we9tXeQe78MCYdnwcb9MPdhdQHFJb1MSrRpEAJ
 ql/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791980120; x=1792584920;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=afCgs29GireRfHwCGnrlv0xaht0XOhwDp2+ZvecNVN0=;
 b=UwxxEuZoLGvPongxgPZeLIdvd3oZqinL6vzHrpf0CauLZDyiJrmJie51dIYKB3/KxX
 hUxC+KcUpYp3vVjYcl/Okq4tZbrFS5hdidkYny8ZFrvA2jtoheAC4O4BYlfUlm7sndhN
 MxdIM2qRU68AGg0yHmdTLPgUfObrWmiLIaScNXomtzDxPV97Wd4Tm4VS3RD6fMooRXVU
 G4TYxq+Nnva5bUVpa9jTFSu6vCD3SrV6UcrKMepvAqAkRqGUdV2leaSYYwU6NVUKB1X3
 lNDhOiclPRy0JE/s8x4jg4rc/kWsI0O25rmBK+H0NyerV4HNW7B59WNuBa4eQxzSMExt
 qjpw==
X-Forwarded-Encrypted: i=1;
 AKwUvByHB5/yfGb8JnDBXdBQtuuS4d4HFGXSD/wkFSQhGumF1k14qLeWPnMJX6sD8Z8VGhFl96p6fyQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLYZuordx+6S8WHWmVQoG1YwXKky8TZpgX0fxPahptBkbQn3g8k
 TTj3FSHHi3F16b2yzx1oXrQw4tGy7OOwDfWmoYD15kEQjvmKNXP76GN1
X-Gm-Gg: AYBFou3g6mk2ArUCNZt+3x8+PYUrblJevtlOu0oiSy1JC9jk/nHVK2ZKGNr5StL7DFQ
 pqmOlSQfSev4IPbidwThJn07kXiu4Et1kLkimqWVnDa2EerzS5boY5XroqxL2Jday6sefW0+wkH
 m7Az6lgtFG1jjby9zGfOl2z6Dq0S+pTizJnMreGe2JU49a0/FD3XUYBnTB7/ZVTG7bnOilOxr9a
 cGf6TmOahu+nS1dUkUhPWVENGnG4ZU4HPkWX6QiUvQXx+zaAYKn/N2IjsRcI4arPMxiOuOKRviy
 /Hcq34BdJhAHRNvKOnbdjtmDmme1g0WA0Mnb13GyB7GaDwdpadbV7MluS04aUCsVmNZJSujYaNO
 lNHDQDosW78Mho6zJbdFg5I1pmWZqDyO53N5iFA3alV4A8oBmtnWUBqONWuaXKcKIlCH1iIbl+1
 FdTQaf9ZDPxBhYSlFSymDC6NmNqeQiCRV26t9o1+koUWhj8JZin25Ceos7oWeBFS8z93ToahroY
 jolMZ/kh/VSBQ==
X-Received: by 2002:a17:90b:48c7:b0:3a7:cdf9:8fdc with SMTP id
 98e67ed59e1d1-3ab3a32f57amr14235944a91.3.1791980119676; 
 Wed, 14 Oct 2026 05:15:19 -0700 (PDT)
Received: from [192.168.1.230] ([122.161.50.152])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac6302ef99sm1973895a91.0.2026.10.14.05.15.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 05:15:18 -0700 (PDT)
Message-ID: <4a255e39-4f71-4b58-a101-02c7cd095758@gmail.com>
Date: Wed, 14 Oct 2026 17:45:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] mmc: k1: use the io clock rate when max-frequency
 is absent
To: Hung-Chun Tseng <alan.tseng.cs@gmail.com>, Yixun Lan <dlan@kernel.org>,
 Eric Chung <eric.chung@riscstar.com>, Huan Zhou <pericycle.cc@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: E Shattow <e@freeshell.de>, Guodong Xu <guodong@riscstar.com>,
 Raymond Mao <raymond.mao@riscstar.com>, u-boot-spacemit@groups.io,
 u-boot@lists.u-boot-project.org, DaveWK225@protonmail.com
References: <20261013084448.433298-1-alan.tseng.cs@gmail.com>
 <20261013084448.433298-2-alan.tseng.cs@gmail.com>
Content-Language: en-US
From: Tanmay Kathpalia <tanmay.kathpalia@gmail.com>
In-Reply-To: <20261013084448.433298-2-alan.tseng.cs@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 14 Oct 2026 13:00:51 +0000
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


On 10/13/26 14:14, Hung-Chun Tseng wrote:
> The driver sets the io clock to cfg.f_max, which mmc_of_parse() only
> fills in from the "max-frequency" property. The compatible has no
> driver data, so without that property f_max is 0 and probe asks the
> clock framework for a rate of 0. Every K1 board therefore needs a
> max-frequency override in its -u-boot.dtsi, and the property cannot go
> into the upstream device tree because the Linux driver does not need
> it: sdhci-of-k1.c reports clk_get_rate() of the io clock as the
> maximum.
>
> Do the same here. Keep setting the rate when max-frequency is present,
> and otherwise use the rate the io clock already runs at.
>
> Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>

Similar changes are already under review in Dave's patch. I'd suggest
taking a look at it before proceeding:
https://patchwork.ozlabs.org/project/uboot/patch/20261005T135220-0400.mmc-v2-0001.DaveWK225@protonmail.com/

