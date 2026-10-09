Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2954FCA6019
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 14:31:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CA029809B0;
	Fri,  9 Oct 2026 14:31:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ga5B0sYaUoIb; Fri,  9 Oct 2026 14:31:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1A905813B0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791556293;
	b=F72hahfjn083FJLs7/9rDnH0nQAWj05/CQYNwetOhv4S3/sxAb4mUDr5jKEQgYX5gMZX
	 cJSjnJqyqJpRcOuzrByqlux6s4I4NxzFaICHcL6wXyZhqWOiswJscY5Hoe0hfbwPMSN/J
	 6dj7aJ4/iY+8KE68/6rYRvIcmNsWk7nVu6Qnb4rP/DR7dMRbS8B/GLwpJzjNM2TWleOxR
	 Wn9zz3LEB9GN7IeyBfWpwK66d9xgLI4/e2l4T4+SWYLuTSA+NLXCl/GbPECVfnwraNnio
	 nFOBXN5eHPgDwz2xd6M+64YuFG8xmlbQneelZCmqZi/xNlZZAZ8anH6Yh0BaiwpTUrA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791556293;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=FP8KQEwruwWB0w1RXQNGCIrQqlLamBdb5tbSGNyoDU4=;
	b=ffJ3MyKfU6BM1OYQbPMAwCgHlmfxP3h6BME7eoO7LiTRL4/2kHSt64o0qPvul/dftYG4
	 H6EwHWJVFI3WFJ5ycsMeqsBq7CoB7wAKig1vpz4+trTa2+kt6NI/slrvPHCjENbHNC5fb
	 rhi82R3ePIimNL82MlP16keHs+mgaMWfIIqNt08w4RFhoAA5GMMpixAsUtlgWnN6+xBuK
	 qHPQcJ/IlEuB5OaYYxoJHiWJhsx1fJ3VcOKKuzy+zMyRzybfx9w3ZNX4typnCJDUCA1zr
	 IL70SBWP4O2M4cWDdQeJ0JqHPBC+lAO846Ly9kjhVnDdWWP7R9PW3vccC8WQucu8lJA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791556293;
	bh=FP8KQEwruwWB0w1RXQNGCIrQqlLamBdb5tbSGNyoDU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qv7kGcClMClsBLo6yprcpMpNMvAHT7Hlxi12n5ndz85rHJZl0yiO8vg+2t0J1nwZy
	 SOFwPjJq1HkIMZsfyXzjXFOaJxrgN6mp0jA8R8jGi5JNo4lAhWgzoJ9uuMb4Rc3Veo
	 Szea9m2xcHBifZu4X+cJWdfukelHS4oOSA0x1bKF3UBd9mUkBMvJcIGx8zFVgIdiKP
	 K6LPMe6dvYP6ZFWIh3+9yrGJlB7Y9MvZZLpMd7NPd1Pk+w+yfSod8niDfSsPsbNVs1
	 JUUsSIwn8xfgltD5qYPC9+b7u5YE8Kg+/BYtdU6IybmxQFDs/rTa/yWEY49fTdPZQV
	 VRPZs0y9PY4kw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1A905813B0;
	Fri,  9 Oct 2026 14:31:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A4167356
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 14:31:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8A050408CA
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 14:31:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id koyLA84iKJSe for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 14:31:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C3DF7408AC
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a2b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791556290;
 b=F8+JGbQuZFZzcBWmfvVhrvIL0ZqzAMmgrmpEFvPT5BD5qGpGKHxBfeOS+m0FrEbGbSaG
 hmYsbY+Kyx8bGDZe4JNMnRNJfQz1UogQIql7T6LRIHFRym+fKxjRjHh10eLUSGMxLlOBY
 9gNzKvM9yJWCANxqVEPsJ/nsQAEql3vwSCiWKxJNCMTn6H37AsTuV1d3YXEdQNZ7hQqON
 R73/vwIXjDXiYhWNlU5niWxi6etx//5h2J3HTXwz4d7oMn99FJtydD7dhjANK65xvXtBJ
 SCpXB0r6Vw049OyU86BTB3onPoLf2jTdcbu8J83Ma6iV6K7bRhnnhXAckU4NDda50NQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791556290;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=FP8KQEwruwWB0w1RXQNGCIrQqlLamBdb5tbSGNyoDU4=;
 b=q2+Wv1FmhLr7TL5Fj0T6keKvJ2W+61u0hu1urVd17VU9TAhuB1CJRoXAdlLUUeqllGdE
 6zPH5BFcY2mnZTVke44j3j+KF81Y/8SdzAOlhkPyO/hAM5IjH8Yn0PRuYT+38reIdNqJ5
 MnJhD4uXH0FOfV7sL3xsyNRGO2cEuxl12OgUMhcMVl3a1tFrUZ+/MTSnhdU/wa/FyTKkD
 VKdP7g46z2/0Sgdqq+T5KHB0cHnsgD3pcLiF8Rm9KXuy+IN4WRx1j5dRdiqDFOCBXTFMO
 ZwueNl8In8Q+jbOhvUzPOTQKEAtihAyPld8rAgyXsSTH40ZxNzkGN2kQKdexrLUYemw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=ZOTQl5sG; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a2b; helo=mail-vk1-xa2b.google.com;
 envelope-from=hfranco@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=ZOTQl5sG
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com
 [IPv6:2607:f8b0:4864:20::a2b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C3DF7408AC
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 14:31:27 +0000 (UTC)
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-5e9239c772cso413987e0c.2
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 07:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791556287; x=1792161087;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FP8KQEwruwWB0w1RXQNGCIrQqlLamBdb5tbSGNyoDU4=;
 b=ZOTQl5sGTsACeYZZ5LLEEtsB/Pao3e3yUW2wa+M8mP2ykdDy9fnFh4V8VN5VmUJ6Cq
 vbzlmgZwyXi6lY6L6gqfAe1Si0i6gcxHKDOnEjqxaC65/5sKeD6D+60XZZA8xQb33pd1
 uKM8HX5RqLzqsk72XisNNMv/hA5AJw36qID1hD0lapD+vU8WHjibxn+xZPzwONJ109Vw
 I5iSA9yXHXRdESEvxWtCvu2gynA+3YTaSXIw3TOChbXMYg04IVrSG5S3oqQlCPKWe5I4
 norFWvPp+CHmkBsNCL76DbGJ2/jUr88jTCkfWNMp4mdhylbbKa7NxTbO1Z97Wsu4oNfN
 OJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791556287; x=1792161087;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FP8KQEwruwWB0w1RXQNGCIrQqlLamBdb5tbSGNyoDU4=;
 b=tTWjR7LhO7CctyxqGmqk2K6RVYeduN4fp1g3bTEVxVfBbBDMNsWv27BmjTKfDzHmui
 yYh54gi3vV/tIgxkb24B1zXXipvk9VcTpnyRMl1uqjQhMe5/Iqa2E8s6289modCPhoV3
 T+k8pdtnMS3bahEz/vrHAODFGh4jsmmu/J0jKbWi30/hMqhNEkRAoaKdJmfUPW/oTmeT
 NRhjC2Fv0B3mMYZqTS9iipJisbjR0vlEHCy2qT7Bgie2VaqMcqTcml1zCE+zz7OOaOw/
 uvFFN53N7ZO1te5TL2JWjbwcDGYJjfNeLHNBDDKCllBCPZdCfxpVgvsQyXMZnahuOxkB
 YRhA==
X-Forwarded-Encrypted: i=1;
 AKwUvByRCJu2MPR/fr+Xp/Hb/yO106OyGE4ttag9yHUVLmtF1e42lZkOYyeyCeXF+oDv/DbOJwcYcII=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ7qWNJdmOnwhbO824cTIiLZdNTm7EkQaiqq3HPgfdHaXLolK3l
 GralzDBFHZaJqw/kHkdk/pogxV3Zstb5VI7PoNFpG2j8y985CGMLA9HbHZJBGydMx+4bN1TbDAb
 l4Jwv
X-Gm-Gg: AYBFou3VAc3hhzaWEXN1F+bGUHKxBMReTv8DS/LxWxWDk+Aze+TPvkI4Zzbt7xoxaEu
 rz9a0WpAlr2g8OQaPJl0X5xsVYHZkbqTTKoWXOItYo/jJFLinWFK93dEdAGI4/sWclECEZ9BDCc
 pxlo/pu2R1X//PNJV62TuhIUrWpx813am5ngJe1AeR6A2kfevTt3z8RvNN11gl+MFU+e5Drn+bz
 400xEDXMPdfVrGUSFFEoV1rgMB5eMPNhDbjSU681VdIqMm0QPdEfGE8Ozut8Dlu8j3xtfVgvbvj
 81Sd8aVCh0uoJvvpJzQ8BJ6XkeaXF7MIMCKfgT59gs3md3IG6/OoBJbCJNMrvhLGrio/JYe5Xoj
 drchmX/XUAKH3vo5VTT8l0hBmEal8F9orFM61R6rrFzPRD0TgddS4YUEUbl1BEzmNDK5E+63m9u
 y9EehrBxw/6RzB+WNCsd5edDYmDuYo+LTE1UqpZRe7tFB77WG5joYIoVWNLGCJqbTMDWL1jnORP
 ju70ZV2UNbDkoo9OMZTyRFi7dCoi3Rk
X-Received: by 2002:a05:6122:181e:b0:5de:655e:404e with SMTP id
 71dfb90a1353d-5e91f4d2596mr742131e0c.15.1791556286689; 
 Fri, 09 Oct 2026 07:31:26 -0700 (PDT)
Received: from hiagonb ([2804:14c:4c5:8bf0::ffae])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-99003d37009sm1743371241.2.2026.10.09.07.31.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 07:31:25 -0700 (PDT)
Date: Fri, 9 Oct 2026 11:31:21 -0300
From: Hiago De Franco <hfranco@baylibre.com>
To: Yao Zi <me@ziyao.cc>
Cc: Leo Yu-Chi Liang <leo.liang@sifive.com>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Tim Ouyang <tim609@andestech.com>, 
 Zhuxu Ran <zhuxu_ran@zohomail.com>, Kongyang Liu <seashell11234455@gmail.com>
Subject: Re: [PATCH 0/2] riscv: cv1800b: Milk-V Duo boot fixes
Message-ID: <asj6OaDxcTTEUvm6@hiagonb>
References: <20260930-256m-fixes-v1-0-69546876ff28@baylibre.com>
 <asa-S7LCji4uX4af@pie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asa-S7LCji4uX4af@pie>
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

Hello,

On Wed, Oct 07, 2026 at 09:48:59PM +0000, Yao Zi wrote:
> On Wed, Sep 30, 2026 at 09:17:48AM -0300, Hiago De Franco wrote:
> > This series fixes two problems on the Sophgo CV1800B/SG2002 Milk-V Duo
> > boards.
> > 
> > Patch 1 fixes the fdtfile environment variable of the Milk-V Duo 256M.
> > CONFIG_DEFAULT_DEVICE_TREE is a quoted string, so the quotes ended up
> > in the environment.
> > 
> > Patch 2 keeps U-Boot out of the memory reserved for the coprocessor
> > firmware. The upstream devicetrees reserve the end of DRAM as a no-map
> > region, but U-Boot relocates to ram_top, which is the end of DRAM, so
> > it lands inside that region.
> 
> I think the issue solved by PATCH 2 is introduced during switching to
> upstream devicetree? Could you please cooperate with Zhuxu so nothing
> is broken at the first place? Thanks.

Thanks for the review, you are right. The issue only shows up once the
boards switch to the upstream devicetrees from Zhuxu's series, and
Andrei's patches that drop the coprocessor reserved-memory nodes are
already in the Sophgo tree for linux-next:

  6645398c4621 ("riscv: dts: sophgo: cv1800b-milkv-duo: drop reserved memory node")
  60e4cafd3090 ("riscv: dts: sophgo: sg2002-milkv-duo256m: drop reserved memory node")

I tested Zhuxu's v5 plus these two commits applied to dts/upstream,
without my patch 2, on both Milk-V Duo 64M and 256M. The reserved memory
error is gone and U-Boot relocates to the top of DRAM as before:

  Duo 64M:  relocaddr = 0x83f79000
  Duo 256M: relocaddr = 0x8ff6e000

So I will drop patch 2 and send a v2 with only the fdtfile fix.

Zhuxu (Cc'd), to avoid breaking these boards in between, could you carry
those two devicetree changes in your series, or should we wait for the
next dts/upstream sync that includes them before your series is merged?

> 
> Regards,
> Yao Zi
> 
> > This was tested on both Milk-V Duo 64M and 256M (CV1800B and SG2002).
> > 
> > Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
> > ---
> > Hiago De Franco (2):
> >       board: sophgo: milkv_duo_256m: fix fdtfile quoting
> >       riscv: cpu: cv1800b: keep U-Boot out of reserved memory

Best regards,
-- 
Hiago
