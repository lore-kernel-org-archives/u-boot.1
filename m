Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D372606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 21:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jieFbfGH;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Y4CVvsgc
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 53E124061A;
	Sun,  1 Nov 2026 21:26:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iyMOOLYAjnua; Sun,  1 Nov 2026 21:26:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7C4734060F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793568396;
	b=KlMmG4uAEOh6a/5Xdd1lMgtLdtSeMty4zwX6tBqOVECnNfDlWCEavbBsZmcfvp10YXo9
	 Te5V9AO2owupUr+Q7d5UnLcJOfeWkC1uuWet6Lk5LMa4Xi9L09kzMe1zRgj73ouKSSBVF
	 WgkxP6hv3xRNZcd6hebVyJzcag2fkoPQ/8TZWUATJxZkMfHVd48bhXLtaHpel1Oht/THY
	 L/9RvYWw9LSEzaWQ7CFO5r5zOh2SpAjHLuARi3I40AmvO95czbwoSyvUdymFZzyRv8k7A
	 gtfH+GBSNZPslud/z9+zNTBzEQxvxzbXDK7xvdb+5lrTDu1SMqO79AJDO6MBwa9L+zg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793568396;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=7o2Koxw2qNyoVTJ5sWM54qKtLiMsPP5CEsY4zv8axJs=;
	b=pRVDiiu9VlNqm51taFR57tp5SBMao4Nss1VZWmw4fU+LZLdIJ49j6a9lkcgOd+d3E7Tp
	 SjljKwHHbejpFMC9TIm27hmEn7VGOyNJGO3zWPTzrD0BrOV/+LT+jqkZL7IoaIfDEYyVG
	 HB5Zy89UT5mGScn5Kvf1kAeDx25ol1fnSMayKtZvlN9iIhoc/1dfHNocp7xC8YnWPGD6m
	 z6VMkrkaohV/ztNpPRJrzb17euBHVyWWH93lg2li0iknDInIeOGXlica35ssroz5EsQVO
	 Jf+39YE6mMOyrAs1VzDJvf+spifuaGskMcPxUmeC/7yTa9ujwPDJus+CYZOpbuJnzQw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Y4CVvsgc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793568396;
	bh=7o2Koxw2qNyoVTJ5sWM54qKtLiMsPP5CEsY4zv8axJs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jieFbfGHq8LOVbek0PVgVezbpyf5d+NaopMccfadloQ2UoukvxYFNe3qVfrVAFdQt
	 GbmkqgHr4SiN3RnpFDtwGYmbXYVkVBBu1MfsFiUxgikmURaJ5LQngXjMxErt5hQDZX
	 Rt+jdZkFIjIhcGXwJw5MCL6fkSlGLVanR5x1ylRNA1mJ9hVQv2CDDEJ3Uchnt+Ch2A
	 YTOuTyODgqH/HPTQiDuD9AoNSCPoTgaD+Ozzr/m9BZqAV+2mgxYwg8esEy9iyWweNA
	 OVFSYKlZ1DNkOdgnUrMnx450j6LMC6gTDB6/RsOTiJbYKYl6UMs7uj3KBY+6nHFpRD
	 b0+wBSSCQtZNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7C4734060F;
	Sun,  1 Nov 2026 21:26:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 20C372AC
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:26:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F3058405D9
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:26:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cwyi2RPhcumn for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 21:26:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2BF08405BF
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793568391;
 b=sFUUgmx4jhUJ/qzrB92gRLTZsiRqELEc9deICQy16xbezk/Y1srKFJERkPevbw/kIyWD
 ld0nWl4458VsB9gBR0XRFWIWqaUJ/8vPQgIZNr12+Fs0MYd7O9UdUohbMLS5PAi4YLBfl
 TuNsMwFpcOGnvesEf/LoQTRxPHaQ72Mr2l29a7Xa94QNjnmarYF/UrF3VJCkxOxjd5c+N
 HNyQwoSOaA91VnFaOS80lKzAUpsMkGJ7xE7wCeY3bJ8TBxpKdm14OPxb1SmObPyvJ7Sjp
 slAY4H8FTNo5xdCWEgXEFUAsNbQk80itV+IunmKIiqsqkr1J6y2BnJ3JpS+JKCzYUGA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793568391;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=7o2Koxw2qNyoVTJ5sWM54qKtLiMsPP5CEsY4zv8axJs=;
 b=I4qbsr0+ryUytWrSJszKNtB6M8TWYjhI2uyHUr3Xq9drndqS1iXnGLbead9CaP/SyjOC
 Pc5pv/T50h1Jypaa5DLAe5Q8ohZano3Jvzm06pBL1bnImnN9//OR2hysNY+P7F7TUNIpd
 77tUhfhiHqYXI5fTN8b+By7hItAK+g8IufajUKVxDsJVOJDu19aj/RLADnqpFj+5CYnfE
 6oemZJdVdCCL2kG3SSgUJvcHb/NXsCUncb0OIpLZuF8l4NDa+cvKdZAtLJCrwk2z05O3g
 Gx025/o8UABjJdNabJWGdofglXKqDWnBHj8e7wMRdeRvwIZqXnVEd2wfi5RJ5gDvWrQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Y4CVvsgc; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Y4CVvsgc
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2BF08405BF
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:26:30 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-846566246e8so2423473a34.1
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 13:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793568390; x=1794173190;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7o2Koxw2qNyoVTJ5sWM54qKtLiMsPP5CEsY4zv8axJs=;
 b=Y4CVvsgcE72riAHkhJsTw+wFgpY+63aKLBvcMSCodZcLM1fy5MOhYX+HgTWXNYbPWU
 TeaaCHtyLSrpQnxBkdKfsPnBna0avCCyrReNRsvwBItS5fH3L9xso3QY+TmvuiQNvXKv
 F88dAjPdWdz4NuxrPuFvmZH/BQl2QGFIYLe3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793568390; x=1794173190;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7o2Koxw2qNyoVTJ5sWM54qKtLiMsPP5CEsY4zv8axJs=;
 b=rvU5Nju5PmbvB3T8fmsteZIh4J1/Esszfd7suddQ7OVjD5/bujEfDptj8hh/hGbjVs
 59Y5VAtwiN569rVzN1L1Mt23Z4wqNt0qa8RYqM23GtEYsugC83d6DOifOTKRAp2nEYyi
 OBKK/82M91+cf05d02FAqUUeWsgLb8X3yUWAqSLL5QhCIO8wwMrJzokbGTSTMyn463AK
 VlSlQD68abv8L6XpDyL296hJwqQrIiT1nAFGCEmENDU6yfzghoQiYy6p8lso+nlyyx7M
 E9AcHPXqcg8VDSDuTj/IoPEqp+jtl4aK37Ov+a3Pm3Nko27RBb9oErRVlOY6/iZJEHjm
 Ez2g==
X-Gm-Message-State: AFq9FYJZd3Pu1gygyUkINUH/I9XzcZybeAzOKoIc0mMARpY2AvvgZYDY
 VQgMRxu+h4cCix4kZX8F8w8vkC+5Jjnf3ISHCaD16uC2QOavgT6yq5M6ZJ1V0z7mfZc=
X-Gm-Gg: AYBFou2YBnqTC22Mq2Oj1jHJNoC6hljQfMXUCpoUQETHIAuGrVOfSMX/a52fGqsUgUU
 bhum8SqEw9CCMopyFlLHuO2XeTAd44tl9Ysc71hAZvBzcfcV1TVZ58r7EPYWEAIMuoGmmtJWKTo
 LGqNGydASHJgyPBySArs2aVRRXlTulR7kGJGSehk3/A0qU6Js4HHs7Hocm3L2TjloE6DLAM0/hT
 +VeHANl7jjxtmOR1a7G7wmu7i6+6s7vz6PmMz9CZ3aJPFrYKFptjJqniVKOhQyO3AmPQDS2YZt5
 9LpGGHET9JOV2uZRXme6RWLhiL4JKaypL37pOXSKhbQkqHf7j+VDd7yKKdIxmEuON/lER/rBRZz
 rcSaryvAG6pw7slDru1NGdMyx19SvL5wnD+Fv2rricDUaoHL6VQ2FXxngwc8/uQ1PNAp0HitaZ2
 1Sd9IqY8lCG3qkMpAuWoDy75ma1zasFvZaPkgXA/nJHBQuvaFdzS8sUGKEZk+UnUJD/28Bcrsil
 12cCKT2Qy+qco5q5JPKqdQU6Ez5T44P+ATeRxC3gS5YBxktEgDkS1JFQZPnBNC03q1lkUptEKmX
 6otz3IxbBKRVLCt3XPZb2SzzHs3wHh9Ud6Bzu+b3LAoAh6V+FQJnNuuUZrqyVH8eHN/iYuTih/6
 77gP6JaFSXzOtsZ1q6KecxSxKSGE6ZYwqT5KjFFOhgPmVsnQON/KgWSy8rM1GP8GYDelTAzmFsl
 3HFNtIH3pcJNPf4c9kCkEof8y+RDrQog==
X-Received: by 2002:a05:6830:43aa:b0:845:7bd0:f58d with SMTP id
 46e09a7af769-85c211a5e40mr6858549a34.15.1793568389803; 
 Sun, 01 Nov 2026 13:26:29 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d3545bfebsm7405744a34.4.2026.11.01.13.26.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 13:26:29 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Marc Zyngier <maz@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
In-Reply-To: <20261022-upstream-sha512_ce_b4-v3-1-26b3ec2e9eba@oss.qualcomm.com>
References: <20261022-upstream-sha512_ce_b4-v3-1-26b3ec2e9eba@oss.qualcomm.com>
Subject: Re: [PATCH v3] arm64: add SHA-512 acceleration with the ARMv8.2
 Crypto Extensions
Message-Id: <179356838842.224230.15779479317387340140.b4-ty@konsulko.com>
Date: Sun, 01 Nov 2026 15:26:28 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Thu, 22 Oct 2026 12:40:54 +0200, Igor Opaniuk wrote:

> Add the SHA-512 (and SHA-384) block function on the SHA512H, SHA512H2,
> SHA512SU0 and SHA512SU1 instructions of the ARMv8.2 Crypto Extensions,
> next to the existing SHA-1 and SHA-256 ones. Hashing is the dominant cost
> of verifying large images (FIT, AVB hash descriptors over 64 MiB boot
> images), and SHA-512 is the algorithm of choice for new signing keys.
> 
> These instructions are optional: ID_AA64ISAR0_EL1.SHA2 is 0b0010 when
> they are implemented and 0b0001 for SHA-256 only (Cortex-A55/A76/A78 and
> Neoverse N1 have only SHA-256; Cortex-A710/X2, Neoverse V1/N2 and newer
> have both). The glue therefore reads the register and falls back to the
> generic C implementation, which is exported as sha512_block_fn_generic()
> with sha512_block_fn() as its weak alias. The same binary thus runs on
> any ARMv8 CPU, including VMs whose capabilities vary, so the option
> defaults to y like ARMV8_CE_SHA256. The assembler is given
> ".arch armv8.2-a+sha3" and emits the instructions natively (binutils >=
> 2.29); no .inst encodings are needed.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] arm64: add SHA-512 acceleration with the ARMv8.2 Crypto Extensions
      commit: 19446d649cf576211b1282ebc86e9cd171b5fae4
-- 
Tom


