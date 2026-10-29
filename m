Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A740D606A31C
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 16:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=urp3EfoH;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vcfIycBe
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 03F4A6071F;
	Thu, 29 Oct 2026 16:47:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YeEcgWACtDez; Thu, 29 Oct 2026 16:47:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4945A606C4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793292438;
	b=eYpKyPmXJGiC190adQpx5L2FR09w00UVE7IjoIK0l7YjfGDA3GbJMBdzX0xaX4TU75NO
	 bg2B11DUoO6gEfKI8pE2pUNQwQdAVKrIM7IW6AycsBaqaI7jovEESw2kUssz9N0Aj5hwI
	 NiP0QnvwpMkmAg5U2hnCkHlWdWNZg1oaOEpVzBJ4bfihP/HglH3LCtGY1Q2SxhZthWkJt
	 vp5QBg+9U1EAH2gmfaoTU6lV6afTTzltvZrY6CaFi4+CEKCqIdAsftgPRB44Feo3Z2F24
	 OxvLd6yHwN1yS4NA2UccV2v9HEMsNdpmofqra3+j/jKXdHY3MYAidtpvI2/6GovAHmA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793292438;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=MMbDmwWl9q37nHDXLznT+OcnZyVDy6Payzatjfy5Gw8=;
	b=qxZF12Q87XKKh2uQMLIo10s3wXMHuVUA4VwcGyuHro6hyGomiena+EzbMFmvnBn1im0B
	 H8ewLyFja4eFoRFjZJWrLn9UJCN7hyUF44jL/AwesQv0rjhOMYaARj4wg3/DZgK8URtyD
	 WLiXpuU3PZ+pifT9tW1Y3VVq5YrqCn/9sgmSd3RgVTsykpvw2sEdU1mvxVsOeAewxsWD1
	 7nf0XjxHN+KWPgvW28Hu78jIO35SNOvSbjS2APbHlO41bSpsyqTUR3aadC+jKGxvrixaM
	 jp5nyZ5IfFPXvck6Oh+I/H2UuvBqTNsTUFTJeF81DJMO3eS7qAReBdjdq2IRcte3Kxg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vcfIycBe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793292438;
	bh=MMbDmwWl9q37nHDXLznT+OcnZyVDy6Payzatjfy5Gw8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=urp3EfoHJh2NHfBFjT7kHtMPlkUEhmPSDAv5HvUin6OPODtWSyNnaYYgrskS8DS3R
	 LCGcRSxDkbQ1wsY15dEgtEDDBVprQ58Bd/iIPlnC/xiXeyAFq2tz9NYOaKVbJRjAKD
	 51naRI/2gCCKXGZz60ybO+IpuTvLUT+Pfm2OUSRsTQJ/hAYBPTp9rs07QgLHIPM+gd
	 R1S4GYdBFK90AmT+ITTz3OwLofqNBZfUkNFwsiKpLroGBTwIufVwaAf5LJW2FoHYFn
	 MXEn0B9wDq3PhqnRwc2io9sVDiMMAdMzI/rP5HLWAiraXEFknXfQxYv7l9nM2xX4bY
	 LWQMc+F+m8cKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4945A606C4;
	Thu, 29 Oct 2026 16:47:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C86F7380
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:47:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AE36C606C4
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:47:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oUmWjLldAZuX for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 16:47:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D3239606BB
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793292435;
 b=h+NKSsHjM+4UhrW9thwYXlQR3qGiirYkmaXLhG9MKbly306E7UW6zhC1aAZUkRCteWLo
 QBdFjV9FmMtCeoo+AOh2OiolpdAaCsVYmjiYVsU20wY+TOBaWbYxd4LWfsI/O82yDIzIN
 QlODZs12/Wh5OG3n+ss9EcNX+lbxNxaQOYdqOdKyn5BsdwTiKr0e4vT7JIWsiyZkw6uEm
 tmskGqBA/nRgFSMBqepLK37w1XSxGzgkiEflqT/j+pRD2dOhM/AqrZJOfzdH4D0BERS2L
 QWqB3tkAm553RJPsErkKPQsB44Zfjw2U7zUFF8F7g2JarcTyFnEGKd3f8aWqWtlBCMw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793292435;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=MMbDmwWl9q37nHDXLznT+OcnZyVDy6Payzatjfy5Gw8=;
 b=WASLBOFGELh4WPehoyVeawQH0Hrp1QV46fKDilcA5HpDwfiUF9OAAXv28X/ge6Rtu4QT
 0DWtqQvTfKb8Aspr1s5SJ6LvXMZBEOduavKp1lF7BJqPF3egJ+8VqGUgMjhbNwXgaNSIz
 /c5gLPDa6Ptp0ZxLntCI8nytsZgAmpbY7gwHsOe+hCTqbBjdgcIA7Wd4KL3/Gy89F7Vf0
 5GggsUL83oelgoR9on4eu9kH1cIjNhNnk6DOY/cQ9wX68TlKWBYK36YLoPFTeR8yQUoQh
 3S4I7ydInAX1jyqomdo/FKspEUqTlKY5r30abkK3oSNYgWBxDMBhvznEPBQbs9Zel9Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=vcfIycBe; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com;
 envelope-from=ghidoliemanuele@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=vcfIycBe
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D3239606BB
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:47:13 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-48c4d99c32bso1906116f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 09:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793292431; x=1793897231;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MMbDmwWl9q37nHDXLznT+OcnZyVDy6Payzatjfy5Gw8=;
 b=vcfIycBeSECTWD5A6qbw/OoIUv3XtEvZPozo1BgS04zSv9QIeoXN0lTKNnYECuwNCd
 bEPiZzwo27V7hhacv/wTnT3AeHfOIR0tKtic4iR/sJWjdCcZOJ5VRbmypRMOZFHdNpcC
 KWXqH9R07HgRbKafsTkQqtwC2uc7rS/YPMg/X84WbYl5D+airWId3Yo69O0tfB+Mxj1k
 nXVMDsd4PAudH744Nl2Dn00gEk/r5SUEQKWPd51KVmnkL7abrHhWyanSFsroUKHd9bWM
 Kl0KOsYML0gSrB+e2Q3KioDZwBi2fNUu++I601jctmhkd87iBaogDINN7kv8Dyfes2S6
 RgjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793292431; x=1793897231;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MMbDmwWl9q37nHDXLznT+OcnZyVDy6Payzatjfy5Gw8=;
 b=x5nW9icXdM529fS9tQ1VCpO9Zp3PygBI3kbJwLTNb4qRGkxmsxmlK2NUngsaChCphF
 pHpeIpqX9mkHBKmR+GO9LEQq/I8lkgzL/xnj3v46TfEK1z/8KIA02rng51jyY+C8mb0t
 NQ1jpyLT9c+gZxdavADW7paGHm8SMduioGTfkyIZsWVR973QDLeN5rEuoKXHMlin7S9j
 hG4nZ+dJ/2sWrL00ZuZIRP0UV9GnHDMxm2xZZ9SpVYCMRE+wLLaKhXyQ0AwzjsOK08NV
 eDPW7/LB83BVdtveHy4KvISK3WgwrpEChjmn4PKkkzzFzrS7UvMHKH6ZoHwlRgu7rIzu
 MKsg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxNx/hTqHNhaRDSc6NVDP4bKyp2jRgr6Ta/IDn/axvbCvk2UDPcOSeBqYbgbbWLp/h7+SA165c=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKtm8YFlbH4Hen8wQaai0K3nkpw4bXA4mW/dfU+ewSEcRqLALz6
 YiV2FVeyeUOZPT79o+gyH9irReVFhaYSqpbdMk0T9NwBBcJgeJv8xLY4
X-Gm-Gg: AYBFou2NN5y9BDyUqDqf/4wwRGWFPiKOZKXXtWUygQYHQcxqMt3Kdwl5fiM4e5DwKyw
 dissIDLCQN9q/agid7dGA8FiAz6nr36gZpt1Su0WCirBZO3RvmNf+wHTsnlIaP8ZmkXUdas88J4
 Go4Kkiofqb2qt9DfPwlBOHo5ZklDGx8tml/YpfigJ0gHkdd66jzvbY4Wd1lIcvlcPpfUxYF16KR
 k9kC0aLfsq6+aluSTmslwuadB05KQ4K9PpC6cFjCQDWkxI1Ouk9LKovmXno1amBk/S9fQLbOwJ4
 dsv6w/oloNpxdqbyOyFt7HHsQQvGkIbHHFGMy1wXc0I5XqVPaeL+lGhpgqgRv2TxoNFOOmFASp8
 wooCYecuK/HdonYulAAVnmILK56RzdBfk63T9BXz4rpHbl6RWp3iZy4XJELrqJwcVyohfCNJ5MS
 bVeRej84QPTwtoM4zppebOfHSjEzWMUeESgKqgV4NrMEgsQFYwTG3n3lng+6SKWY5I9tmJRfR0U
 ygBJlaLIVJzi5tzlJSeT1t2WCeCTA8NOD5EhnzASX3BbBNTZCNqbcllue+VuC9+6WGCPXMfomGg
 6/nSxa96yWrdYUqOBiKSlyjJwoJfLchMye+z6FSIFFxG5R9HYOHhhPU55mHIKlvytjRMLjNkcSG
 Aop0KEPcL7w==
X-Received: by 2002:a05:6000:420d:b0:48e:2948:6fe3 with SMTP id
 ffacd0b85a97d-48e5d2f9907mr15783953f8f.39.1793292431373; 
 Thu, 29 Oct 2026 09:47:11 -0700 (PDT)
Received: from [192.168.68.70] (host-87-10-175-32.retail.telecomitalia.it.
 [87.10.175.32]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e6dfaa2acsm276449f8f.40.2026.10.29.09.47.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 09:47:11 -0700 (PDT)
Message-ID: <0f57df3e-52ed-46c2-a98d-3aa6f5beabb5@gmail.com>
Date: Thu, 29 Oct 2026 17:47:10 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ddr: imx: keep ddrmix_initialized out of .bss
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, u-boot@lists.denx.de
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Fabio Estevam <festevam@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
References: <20261029160513.666555-1-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
In-Reply-To: <20261029160513.666555-1-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/29/26 17:05, Dario Binacchi wrote:
> ddr_init() is called from board_init_f(), before .bss is cleared, so
> ddrmix_initialized may already be non-zero on the first call. The DDRMIX
> cold reset is then run on a DDRMIX that has never been initialized and
> the SPL hangs (with DEBUG enabled in ddr_init.c):
> 
>   DDRINFO: start DRAM init
>   DDRINFO: cold reset the DDRMIX
> 
> Move ddrmix_initialized to .data, so that it is zero on the first call.
> 
> Fixes: ae03528affd3 ("ddr: imx: Recreate the power-on state before repeating ddr_init()")
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> 

[...]

3 out of 6 Verdin iMX8M Plus and the SMARC iMX8M Plus SoMs in our CI farm were
hanging in SPL, this patch fixes it.

Thanks!

Emanuele

Reviewed-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Tested-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
