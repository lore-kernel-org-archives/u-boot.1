Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2795B606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 11:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ygPHcIjr;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PoqfC++o
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A7B99405C2;
	Fri, 30 Oct 2026 11:09:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CV8opmSr2mqw; Fri, 30 Oct 2026 11:09:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D2320405DE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793358541;
	b=P9HVj+t9MMGT4wbxDpsh8PjJVd3LtH0abAnzClFzg3/LIXxSb06tLG1LFYtzoQ++82Co
	 p5G5hQkTslMhH5FIugbO4Kuc6U76cVKGrvzstNgsUrBUiObUkgOVJyIv7F5MYa9Nl3OE3
	 qfQ6GDLTvUZF8lpCHV29nNq+9DNs+tkLdw2+sV9hI3lTwpoJMINjXuFNH8v/nFinn3jXq
	 bkG5aXCxS/Ad/OSzmbe3vW8yY2AIz3x8oahel/j3DPG2dKM8mHGf0415e5WEW8ssQvckB
	 qI3HmxXOuI+IyqSU5z/xSSzOOGHMydowW1WUIqapQJF0aVtJOEAh9MVS5u4U8y5YvhQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793358541;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=FEaJkG989fFMm7IX/q8MendMyxblAEsMjvpOnotPZK0=;
	b=rAho3Gxd/xwMpsWL/W9rHfTiLAs2xPx+wvVIPt38Mv4lD1nNeIxo25mMHBPxYIO4Qrmr
	 0YXA7bDGFm8MTUZqdyecKOYgZ0O1vkumx7A+F5IkjgV0hmntap4wS1j3fhdkTafp/KNgH
	 ir53DY906NozabwSApMYtHZRvXTcVd1La4q4NhlV/cxSQ+FJLd8yoDEw7eEc+zhyqx7xk
	 iktNCLAbYjsB4Zka7hGPpBtwiLIIKCiUMxXdSqCoZNebMymoEBPWmLGTzSfevlZuluLV0
	 xaPFQ/dJpqZfntcM7o/22WDUtZxmAmM0qhQtudzCJpwQj11vakHUteBUfO3+hy32ZqA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793358541;
	bh=FEaJkG989fFMm7IX/q8MendMyxblAEsMjvpOnotPZK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ygPHcIjrjSZothrFU+1iIyv4irYKCl4MCQp6NBB5vIDAn5JpHZwVqf9d9iv9uDa+Q
	 fZaf/k0MWvCN/+q4W0p55WGtLfA3UkxPPlFOweP4NNa4kOnZk6qQy0TP+PlAKznRyW
	 kq9S9fPAZDbQ+YCQ55dr3+7CV5Z4qwcnOTZPxjQXfYKda/xf0Cp/JCRNnTYbAu7k/h
	 qJTruRy9Jd3CNSBHEV6i2NpA4Y8eKWbEH6R52RoDSAYApNxnk1NlgUBUc/GOKh1xqc
	 9i8lfW/pE+EqO15IrI021lpIKE3ctuuYHy85KmhwVmxZjuAdk0q6K0mFBZ38spBkQM
	 3XS/p0RBm/9Og==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D2320405DE;
	Fri, 30 Oct 2026 11:09:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 512A22AC
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 11:08:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 430E160679
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 11:08:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sbf4DouiMAwU for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 11:08:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6528C6062C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a34"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793358538;
 b=Aoaeu6lajMHAErMOjYg9fOw0TthoFBeiGvEB0X6H+NIjUVre227kkYJPr4kuuLZCaEZ6
 KVmX5W/XsafHJrNTwNALsj3hEJ5pNzhzhtlIeQm/B6L8CPfIM+yBE5tj+CJ/RgbT9uii/
 9o4xGLcK7NXDJeDCynLKIsb6kypRxJ3RbeqlpfCd3zh46OgV4bhXfrUj04pcfJdjyUNdo
 Di/EgP8QHW9I2lExeWFQ/Vn6fTsl6vflXXhjnu+/01TviaKQwKCXuuaWxAYNzOo6GBk3w
 sbepCpxev5k8uF2TKTn9fgaJttAomxd7tGZ9nsAl4WgoHOtqKpN7tQ8P7X4vfqbmI3g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793358538;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=FEaJkG989fFMm7IX/q8MendMyxblAEsMjvpOnotPZK0=;
 b=ofhRRSRqOMgDcHehu/n2K8KM5R9efeCDVxxM263FeNSSblyH6ypYtzPq4yslibhvPAAZ
 3laVB/WQmaoVdXL67yTSuYlcfCWVmY8dxNlawBtqd7E5cz5nRvyLFWbqCE40IhA/1VNCx
 DGmUs5iPHdFzWXMOB2hQRy0UaiPrgJ5VICt6jkAmOXnNP/CyzIOQAUsjM1LPJIdmdoeLf
 ypPPply2yisU2BhWIZJOSI8SxppzAdNvuqmXgm2FoMV/QqPCSzDQvls+wI9k2XPN8O41/
 UBQliWdCP8XYyZ6kK2stsQWwtmIL/duz7Syyl7TFLxuuuFiddrUyHNdEcEFp/8go5tw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=PoqfC++o; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a34"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a34; helo=mail-vk1-xa34.google.com;
 envelope-from=vinicius.eduardo.pedrosa@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=PoqfC++o
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com
 [IPv6:2607:f8b0:4864:20::a34])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6528C6062C
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 11:08:57 +0000 (UTC)
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-5eadf48fb2dso218259e0c.1
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 04:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793358536; x=1793963336;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FEaJkG989fFMm7IX/q8MendMyxblAEsMjvpOnotPZK0=;
 b=PoqfC++ortN/hq3zLwN1CflfzCBx5HItDSbna7ZhioQXxZLjY/KfM68ty9W5rPzadh
 8rppT4b8PL+IBQx7oa3vQeJjPwTU8tYuLqfTxv/wUuqDaZKAZ2UOPtysCLOKrncdrIDB
 Zc6uesM4Ag97OIWkhP0RspWc4QtSKIMoOH14De/B4mbNrz0pcHQD5b5XI38A7G2ArU8u
 9TTXL78BCct12iJ371oRJ9p2SkW/mjSGNOXjwUIk+fGl1yan5dYVPkTcESHqzY8HQeZk
 759NAaZYPtGnKZtK/xly5JD8l9UMXQh4bWI4XgqQwSRXjNbzgW/ZjhK7Ce6ieOkugnB5
 RmJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793358536; x=1793963336;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FEaJkG989fFMm7IX/q8MendMyxblAEsMjvpOnotPZK0=;
 b=m5n5Lurb5B6RS7qCLh8lh/aUZfgXE58oCuBxT4o/CZyWaaRM4caBGruNBcWWj2ZF+9
 jHvDErdXbBYAeeQdzqTLTbB3kRFULsSVsenFEBrX7Mdb8ocOmyUKYjEOdP/T6K+CrxNm
 zXGVPUPTwoqYEDAEcXniPEbShgrs44heHOlA4epZ8WsCcIB6Tx+SsjcuJxEHZF5QpEbg
 OkdqYEO/WucRIH3ysWY5qwVcLZWUzEqKlJGEOFJj4R9WkiZtJA7d4lyqr/2Rp2HMlfVM
 rO8KdrJ4NzGqBLhqjxhENCUY9uU6/KL43wB9mu2LMJEqs2TdD8nvvKvCaF4Ffhlm4TvC
 Aehw==
X-Forwarded-Encrypted: i=1;
 AKwUvByu4eIfeCOVNHQGn9zFWK5se47aol3fLQJDfocWKfJo7M8kDW9tN2iJ/1rVvysXQWeemlWxXw4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJWhajUVLhTpw/q347PQf8qoBXTu5IrZvspDtLJppWABnZflsHu
 iWUvzqGP/yVUWcFmH4Jrh9eH2oaodeYGNTtwA9eVbng4RSODxeQQpWX5
X-Gm-Gg: AYBFou2J8VcG126iVJHLIzHme1qpDpE93x5/95bcG+y3QVyE1rmahMREyGx+Qco8tDu
 fAJn7A3nyB5rR3BsO7Lse9WDA/fg/BM6Kc0HW/OU2IEQlgNhaNb/gtrQSZtaT2r03AThb6SMlpe
 ngIDCAxJbLuQ0YhjZwblBWFS7wFVLI5Zz/gXvh6G/efzVJxPuXcXJuDBBppUEVAuhvRWI5YVowz
 r+rUyPQjz4f3z5rHNEDfbRij7RCM+o5zPwv37aubEZnerly3MhWMhxAR51PwMiFBeqegELRDKaw
 zLU6QiW8hD18Oqmi4xcWOJ8rDeCIzbTprqL1OeqpkvTq+ByRfNbm4z6qUItJDeuG6IehIx34MKw
 7wQiDlPSmebB8fbBK30rfMiYysYxbUedbBMKY7VnaSQj9P6Abp5ip4MkXxzg72u3wNSVor+jOau
 j5CHUbtlIEblaOLyH/ggcVFwaugqdGpaWoWu2WbdeTKCxGhBlHAPgfOmAh5wiXafa81hy2QiH+O
 kpMDqClfp2IN6kxzrTHvAlsH9WR6NIzPCUA/2yENfJM3KqvLPQmmJAsIp80jDqTfj2J1Elv8Daa
 U9XTYTqairofgPJ30GMxTX7xhq2GIi3lqXmurhghTICXm62kf5t8Cz6bImiaqWM/lSTAj0uvTWi
 J22EWlcEwZQcnTThuCKHsXhbf2QlQ1vu2RRXI
X-Received: by 2002:a05:6102:418f:b0:7c3:9059:49c2 with SMTP id
 ada2fe7eead31-7d0726056cdmr710246137.22.1793358536554; 
 Fri, 30 Oct 2026 04:08:56 -0700 (PDT)
Received: from MaquinaLab.. ([179.179.238.247])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7d07768d366sm1752844137.10.2026.10.30.04.08.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 04:08:55 -0700 (PDT)
From: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
To: Alastair D'Silva <alastair@d-silva.org>
Cc: Andre Przywara <andre.przywara@arm.com>, Yixun Lan <dlan@gentoo.org>,
 u-boot@lists.u-boot-project.org, linux-sunxi@lists.linux.dev,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Paul Kocialkowski <contact@paulk.fr>, Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v3 0/9] sunxi: Add support for A733 SoC
Date: Fri, 30 Oct 2026 08:08:46 -0300
Message-ID: <20261030110846.74922-1-vinicius.eduardo.pedrosa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <277fbb28e539eb61d492b3d1c79db12d5eba6078.camel@d-silva.org>
References: <20260113-01-a733-soc-support-v3-0-f19dcd098f60@gentoo.org>
 <20261009120356.194364-1-vinicius.eduardo.pedrosa@gmail.com>
 <3f57db40-a604-4800-b15f-2d159a3a5ca7@arm.com>
 <277fbb28e539eb61d492b3d1c79db12d5eba6078.camel@d-silva.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Alastair,

I checked gpio_init() in arch/arm/mach-sunxi/board.c on your A733 branch
(5887f2b) and ran it on my Cubie A7Z from cold FEL, stopping right after
it.

The common code copies PIO+0x348 to PIO+0x340 using the H6 power-mode
offsets. On the A733 those are PF_EINT_CFG2 and PF_EINT_CFG0, while the
power-mode registers are at 0x48/0x40. So the copy writes PF's interrupt
configuration instead.

Both EINT registers were zero in that test, so nothing changed, but the
addresses are still wrong for what the code intends.

The A733-specific code also clears bit 5 at PIO+0x40 to force PF to
3.3V. That bit belongs to PC's field; PF is bits 11:10. I tried clearing
it after an SD boot and saw no difference on the A7Z, where the PC pins
aren't connected.

With my mainline setup, PF in 00, 10 and AUTO (01) all worked at 3.3V
and 25 MHz. I can't test SDR104 there yet. An earlier, limited test with
the vendor kernel timed out with PF fixed at 3.3V and worked in AUTO.

I didn't run your full SPL, since its PMIC setup doesn't match this
board. Only gpio_init() was exercised.

Thanks,
Vinicius
