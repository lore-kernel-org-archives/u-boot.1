Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFC1606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 08:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=AQ0i/bNF;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=mQcVKM5G
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 22016407A3;
	Thu, 22 Oct 2026 08:25:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QbRtkxW7n-18; Thu, 22 Oct 2026 08:25:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7480E407A4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792657539;
	b=swi0wyApEPgRTaG1zCBB9e/kN4UKRSqhRuvtlRM6BoytWdlFjkGrxeSi09YAL06tf9Qt
	 n/AiguXFartNQAerYFV/CIuJGcRrTD0K1T3Gm2O7vrQda6hJ+HT1+i/rdF8emDVMW0iyU
	 n0kF6av3QQwI/Ch1JmWlO5flNOXFieO6KAJqwytBVHWrxOKtu3pyaoFWuFwCtabEb7MS5
	 HEUxG+ebl7CgVmVU2GIr/3l0n7fc8k/tJYlP1QA71f3ISUNJ8TGNursWb53PnW3eB9zWD
	 Dssc7eOsSCRz/gl4Ky3TM8rukSKLWcwEtWaVv3uPS0KCwyZAFhK6pLkUeouEidPqYqA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792657539;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=mlM4WbZaV5NTESJumfkqd+fOjTJ2/hgkEMoh6JQHKCc=;
	b=eKgAkrV4ipOYwfSu0kNGEzj59nPNUfdOikTzhLUz8ELD32pMr4xRRYcd9F8uOVUrG076
	 Egte3VKLfuu4BaF9FkVune1e+ee/7ET3UuRla5cpzsBLDQJRL3o3MQZe2++yOv0pmquuI
	 Hn3nJqQ0EVgMG7fal/2LPIvg8w3zJhSfkQx9MvG6JnzR1o9D9Aeu5hFbEqed4j8hIOZvW
	 GIjh4HCVU9bKod9j4pCxGb25wN7x3xR6zw7ma+OoflK59U7MWrtBZTFHzKWtACozHMTHY
	 p7aSx1cUvZDWnMVI7M98g0HYWzzTBkf4iKbGZzYUFHymalXZILApDH89GxK0DQ6DEaA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792657539;
	bh=mlM4WbZaV5NTESJumfkqd+fOjTJ2/hgkEMoh6JQHKCc=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AQ0i/bNFu5e0jHTma7VxreZVIBoeZ/7SIAMLVC/2QuKAfZ7/P3+Qa5Dl+F0tqmgtC
	 jK6BGXaphcge0GqRFSvZGp4+iIx+BLOVrmsY2rTDxwt3fNcHe8mXGcu9bU8L210kdm
	 eZ84ovbk4kqT+94RqCzjNdZ3aTiycqPyBopVQmqCm5qIeH5ACSS1erZ5+O6MinbwqH
	 hpX97HWQAO2xAngNGu/OViBPYqYenhTvm1ZOTTV2s3Nj09aQVzAqXtWnIC91V6PiTV
	 KisCSowOS48PGhxnE7y4Lbsqt7+ZPpaK1WscVBr8c/dytMFbT8hyOul+b6ZkMG5Sfm
	 f41Jk16QK5wrg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7480E407A4;
	Thu, 22 Oct 2026 08:25:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1395C769
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 08:25:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 05A13811E5
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 08:25:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1aLr2nOgzw3u for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 08:25:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 155CF811E3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792657537;
 b=FXcdb60mdFOHTOroEWxG0qTeimFVNXQTBjBvmRqTN9LbulW/mj67937nh2VXJZB3pT1M
 6tsm875IzktfEgjpdjBhQj2XVeXLZuKIPfz4CjQBG82x19Vq8r5/xg5OdTE1OE2OWDA0t
 gN71UCi+7XnOxCbzd/cpXW/pt9LNGMND15hOm9N2xn4nF6n6Bmi1s+NwoOpgK80M2kywS
 B1p16stUY4qy2Ujf//G7YGTNKog7chKXgkd5oBYgVlmerX34Up8VkIEf2kXa3Gcj42owk
 JabX1ZRAF+FgqdeiUYmaPXroED7CDBhExJ1nKzkeJxDi9zrMijl6RMndtLBqEEVRRZQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792657537;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=mlM4WbZaV5NTESJumfkqd+fOjTJ2/hgkEMoh6JQHKCc=;
 b=hC7HIbZgBkbufIL1mKEbNt6A+rEuVdQRGFBpqj5GVbU5dQKF/2IAUIjAl6OOLDOV7pTP
 e0YoDwZR5e+aMsSs3L+TDVfmkYse/JfeEXMwNpWxTL0TItqY3v5YsVepKU687eDDgByVE
 kXVM4PpT59zfbxlr5XKdkn+K6pJrvX7eRvPvfmdr1b1vPRrMru7gR4gOKNyDdC66rOerF
 Jpoc3Kre9jz3LDs5OBte2U5B2k+RZlMG3a7ZrkkObGOkcqUi9UnZa62ryLU84i0YsouAb
 jX8EomTJ6B6XdIYwSQ5isV0iprNc24meQX44DNTVfEwuy3COw4ZlBHHOyC1QItbG1Nw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=mQcVKM5G; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=mQcVKM5G
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 155CF811E3
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 08:25:36 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6b1afcd2d23so2219211a12.1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 01:25:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792657534; cv=none;
 d=google.com; s=arc-20260327;
 b=jyPvHdFdPRe7fX+DKfgCv4exHybBk2gn4RgDgWHeYN6CXbQs/HiH7DVdFJXyumTgCB
 6bH5KqUzbjw/U8aMrGYbnNvT4NcaBKiuvWIo66UvZZ+6crffdxrYhjHoKUP3kpTYgFKx
 db5S1yFIyE4YHB1fFC4KDMwSrTc8hKRcyANCit4q7l0BSZYYHJKELkHPPxpokmuQSTpf
 3Hh1WrG3DUE3DMd6Mrm0OolBygRQ3+WAcWfaOUgi9tscCSVqBZ3KwkzJPPhfM79jQ4JR
 595Wt0GzRZf2Us5H0x7M5k3jXepoqT5zGyEU5KCrwBXup2XnCZpTDPfZ5fpHFjx7sneU
 eELA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=mlM4WbZaV5NTESJumfkqd+fOjTJ2/hgkEMoh6JQHKCc=;
 fh=5vOEPIJ2AIIxFkhv46FugdQHQ4oNy9P4C5ZHI60JHbo=;
 b=BFR6Tpe/x4fFEHSNOKwlyzXHGJzraWg7jUOWENTgmMaqDxQqnkdKlh8EuNP/XOLeS/
 Ar6YClgW8PrZIDMXMIJiYAaNG0iSdhVJ0qA/q2OtvxZmQymXZ6zJQHzDT6kMeMlHVR29
 AB8ipg094VF+g6muFCMWCU8G0zhRQTFcXBvMDyNIs8gNVjcIgymQXfLLXS1321GIpr/L
 U0OWjV9FO20G3HrjdB4goaQoXwijPfoksH788Rbnp+C5hIOrPazZYF9wYNeLRalLwtA6
 P60FTogdBehuR/pvjAMwhG1K155fG7BKCnO5GRM029ECBoQt0hf5gzwCz+W3Mfn2aM4v
 R6TA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792657534; x=1793262334;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mlM4WbZaV5NTESJumfkqd+fOjTJ2/hgkEMoh6JQHKCc=;
 b=mQcVKM5GUKUy+grbFtuBsG3hOYdqnUiMPh3No/Ezj4Xjwj+9wTveAc/X3LVkDQTZE0
 hRzaKBYCJuxtAAGiHyhdeyPHOoFdkizCvXiN5Mk+6TVVSsKwSz/3ZpT+QWxo1nSyLxSG
 oeJa9+EvmuviKTG3kQbIcfI3x61ltymG+VJ8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792657534; x=1793262334;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mlM4WbZaV5NTESJumfkqd+fOjTJ2/hgkEMoh6JQHKCc=;
 b=0okDfc+NWBwkDyolWWCUuKb0J67X/Kzo8bOucLcDy/vTxJWydHA7JKN64iS83+8fdz
 MBKSfZoYBWjuUVTIbFIIz8931RVIgsmfHzvrxdxz4y/6NlZZc1ROKYpjwH/HVfkV8TBJ
 futk9niMQH2Nac1zyQGPIWcdM9OHqgIByiVqhmNDZr6IhTrL5fMH2Zv00OrhnsLbJ5ek
 SoMURmBTC9beNpQ0sgS+frvdoqehL2W4rouXWkHZv+ysYs7kk9PFFHLeO1Rm3vG4QkBL
 SPeutWiT2bnGssu+7F8LyCXej53o+oupIOR57y5CnpQtu2gWBSzGgwjxTJ03WPNHMw//
 Eojw==
X-Forwarded-Encrypted: i=1;
 AKwUvByzbdY8UMxV5N/3UKL2VBmP/kL8x35H7zVapfESihHEd4QCrDeNhWJIfEdnQKNSu05KoV39xfI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ9y7/IbEgBbrjOmSNpasXsojmDlfkWoa12iqO1JQzj4s6zNFnQ
 2hC6QtgTOWIMtflqoT2/qzjBHy4c/WHC3+L4lMfPTZ9nIUiuBulVYoT9kL1E0ejOM2txbmtrb4q
 QkTWAccM2gCtikH4/sl95VtlR/DVMDcDQKavFphJw
X-Gm-Gg: AYBFou1IH940UCig6/SQIYYeQdcDGmWgQ8GwdgUCUN3/rXz/WV6bNm5cJxcF51bT25Y
 AS+lY55yDrvpEBft1LLtmlsHILWpPH1YgKHYGm517qB/+vgDIQwAK4SnIccPEnzGh5gk/TJ99Mp
 y2Q+7cVqfmTAxc6vCWapV+byy958JI3sM9oOHQgY4lboyb8Buf/AvyvZRCyyAvzm8ztvim4RsFh
 xRpm7E0AvP02E4tBOpSVe1fpkV2weRWVAyyh2yX/g3zhKPIuelLG2FH9w9+vYtDffmwCj2vp2lZ
 9qvrA+APD/umi2pKM7EPBTmWJqFhB+JrJ7zw/tyYTnKqv56SBZgLSreGer5swa0O9PLtXsezNUa
 o2uWrP7nhB2j4n6sboum6cOXixPbFUBnnmWNdvpT+WkJt6JNJ3rrawW2g
X-Received: by 2002:a05:6402:2b88:b0:6b3:c320:8858 with SMTP id
 4fb4d7f45d1cf-6b408eaefa4mr3802423a12.24.1792657534348; Thu, 22 Oct 2026
 01:25:34 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 01:25:33 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 14:09:02 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261020-test-avb-fixes-v2-1-997f8f04fd3f@kernel.org>
References: <20261020-test-avb-fixes-v2-0-997f8f04fd3f@kernel.org>
 <20261020-test-avb-fixes-v2-1-997f8f04fd3f@kernel.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 22 Oct 2026 01:25:32 -0700
X-Gm-Features: AclHuK858uxOLXkS90YtbxODJIkJDtvyHjhgB1KJr5pwgCqtxmMOEL7TdzJWW4k
Message-ID: <CAFLszThEc41D=kB0TE-vT3aXGA=2YDUU-+mYsWcYGFRJg3q2qA@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] avb: Use map_to_sysmem() for flush_cache()
 address
To: mkorpershoek@kernel.org
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org, 
 Jan Kehren <jan.kehren@emteria.com>, Guillaume La Roque <glaroque@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-20T09:25:49, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:
> avb: Use map_to_sysmem() for flush_cache() address
>
> flush_cache() expects a U-Boot physical address, but avb_verify's
> mmc_read_and_flush() passes a raw pointer cast to ulong.
> On sandbox, host heap pointers (e.g. 0x1a27ee70) can be outside the
> emulated SDRAM region (0x0 to gd->ram_size), causing map_sysmem()
> inside flush_cache() to crash:
>
>   phys_to_virt: Cannot map sandbox address 1a27ee70
>     (SDRAM from 0 to 10000000)
>
> Fix the crash by using map_to_sysmem() to convert the buffer
> pointer to a proper U-Boot address.
>
> Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
> Reviewed-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> Tested-by: Guillaume La Roque <glaroque@baylibre.com>
> Tested-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
>
>  common/avb_verify.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
