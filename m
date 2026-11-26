Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE70606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 13:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=t+McxiTm;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tPR66Nbv
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3F9FE40935;
	Thu, 26 Nov 2026 13:33:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xSEfqlIg-s9q; Thu, 26 Nov 2026 13:33:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9A0F8409A2
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795699999;
	b=Ab1uA+IcrcBUK0bCkmDVfvNgryBLR7fWiaw+hCXKIwGA5YYPNtpTdjdV8nZmzG+MKbyr
	 GFDJn3TJoxQfxFbuq7+Dt8G3MBn7zUVnVk+azhtk+UlI0tFO2JzV0c0INqnXJZJ4XnBv9
	 atw0IsJMANLSrBaNcpzUxkt5uJuWGPStyQl3grDqPPscQZSHih0dh4kqAHq7mStrwdUaZ
	 Yprz0eKL7CBXqGihDmr8c51Ry2rUbuaKE/G38D6srR47+0Vt1xsTZWqkuEi2TugPOW31E
	 uCJhzvp3UCWJwP5eaQgHqP2p7jbKxzUMxahFN7lYxNS735IkGRSeg6G3jdzrUrrALzg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795699999;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=mX7cQaJdQ3Z8GzuWZM+Tv7znYIvTndE2qCggNaFUZmE=;
	b=mLzeivMGzIX8ua7J+SliF+ZFV4WlTe6rZus5gDE534UQkkM6oh2GEW6ZXULGskF2h0SH
	 P/BO8GpCd8qlDtv7K33DDMQ0dMOGx+1wf98I3rJ8Xz0XULTP5a8JQ9xwMYLP7vwgQqLH1
	 hAyXL+uglg+hsYVFGHt4kYs1AAt3rSwqO7SRMAl/Pm/MMWM2tI6rRoxHtDWJqT0y3KODM
	 R4p0q+njUkg3EIQkvy3/5BoBBQ7L1uwkqlyTpQUzDMuUKetJQVrr6T1DUPuJmiCcDEF4Y
	 mnyIv8SvVTHCv6//xvybr5Lb1DHPqcrUXJG1eQHrTru1729o56yda2f27DIzRw7pNMw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	spf=fail smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tPR66Nbv;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795699999;
	bh=mX7cQaJdQ3Z8GzuWZM+Tv7znYIvTndE2qCggNaFUZmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t+McxiTm430xxbEvlmTyqB9/MDgaHSG1/f43A6D5vEIWH48KhRdyd+X8Lvb0mtU89
	 NDyq8D7z/FWEhYAMrtxQOAaEQNkd338Hf3X/ICq4QhZ4IbLCTCf8bNe5j2LVIaCt7O
	 FkWqg+9vlZqeEUhxeeoAySL+Pimb1cCIRdt8/f8qBPFVUerg7EcpEUY/Oe5DPC7RLa
	 wM+ddli4r+Skw2zDEOzBJrpuN1cz5Rkij7eQeX4zK7zVaRy6IqAPMYNymSks6qoyUa
	 lsea73rqMvtsLB2mfLqGbg5axCHnFLa/mg7T8kCzXokp2TdUBMKu3Evh7VfpplJrBj
	 kBdzSgTFy443w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9A0F8409A2;
	Thu, 26 Nov 2026 13:33:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1554426D
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:39:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F1FD6404C0
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:39:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iwF7T-48cRZE for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 06:39:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D39434048D
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=leeonion.muyu@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; spf=fail smtp.mailfrom=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=tPR66Nbv
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D39434048D
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:39:33 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9E6F847DF; Thu, 26 Nov 2026 07:39:29 +0100 (CET)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6A1983108
 for <u-boot@lists.denx.de>; Thu, 26 Nov 2026 07:39:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=leeonion.muyu@gmail.com
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-8b5c3288e6cso2752861b3a.3
 for <u-boot@lists.denx.de>; Wed, 25 Nov 2026 22:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795675161; x=1796279961; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mX7cQaJdQ3Z8GzuWZM+Tv7znYIvTndE2qCggNaFUZmE=;
 b=tPR66Nbv6BUGaVNHkuDuw2E7onpqT/AgrY7qctau96REcRAs1dvR3EgW0ELwL5PWRi
 Isu70Iy6LOXzr4R5/csHWgVUwgYV3xHhNKzJgo6TCdzWJ3b5hR/FVgAGvbQOOxzBLmDh
 SHeFxwb3i8cPtu7TlywD9ZM+hRA6HtwUGnkoVoRmbzr6mUxRGZP7f+dlxd5jcZxUnFKM
 LvX0RtzQyvo8Z3tyMUCHVlVLsU+9dAgmow1MM9D+yY+R7MwHe2YN3FuRE3WEIybqTvsy
 ExKBso6re6QAz9nTrtpDjt3WNCBHsWsSNSZ34OIT57iTpa2P+YFS1X3pUTc0kv1ih+AK
 xNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795675161; x=1796279961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mX7cQaJdQ3Z8GzuWZM+Tv7znYIvTndE2qCggNaFUZmE=;
 b=IO32y9mP/L/u2vFIF9Q3AqdyUKnngvpgvFAKK+vbj81Fn5Xqg63efTWdDb/gLi901h
 YkACs8EvEClixPqyCYI/Jchqqi2vqU3HPPNa33qc6Q8QVEZdhYG6J/9CZ0J/LshODm21
 8yJ5mqlKeDwNdgX2GJizve7Wo2ntOlx99JOHP180Ghxk45SbacbokX9DSuxyo/AYjkw2
 7c4ERSXtxT/K3WtJ43MbG/iMiehjgcn5yuTvyjfzpKlqJB4LEkvXbUsunMwfV2wqvAnR
 /5/iybByhU156x8VVJXHX0tLH3gOFQ9RRKNxqGIBe3Hqi+lqEdfzjZeK3EwXXA3iPxNK
 YkWQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGgFcVNOIFDS8pK6gYWTud2bPin8cQTvExkGF7xJjH8OaDg6Bmjk23oJP9YK/NHQbW1Gp5xHYU=@lists.denx.de
X-Gm-Message-State: APuU4Z8LR2qPIW6yAUZWC6NDmBva75MFT6lAGarT7jUG6Ru4il7kzagP
 gqvVZjCITPo/ukNSxO9Hh4W4sidv21oyFFmVwnBofdKX2H78zfEzpShh
X-Gm-Gg: AZFdTZdpDiCltz9MmcJRj2C3moRwKRC0GpmN7oTxeUsI9IdH3bcy0n7BVgJftbo5Ydp
 4/s1RAF8supZknTRbai483STAndTxQmP0rGhbQ1KXQ81XEmvv2Mi8SWL9oL6GLn0g+6lAHfkbT6
 LD9SFmrBIZiBsvuPNssGdgkPOD3+1z1OiCT9+nvOQHLsXzNFJhIOHWeTaKdCgvaLXfSbHB9KM95
 0gJVmicT1NXyv78B37+VybXDlLlW2OREnPWcCF9m0e7JHTPvpvBDNeHeOcmSW1gc+jgcu+enXru
 gGkdFWSDuHT8LOhz4oX2vSra90Qfp76+pembLqfQelYSzsmbbARrUFmVoEi1Pzwh7V7TJ3CEe3P
 M1hgI0cAVMqYZXJFpprJb86A0503nD4emke6zO1LmG9Orw9vhwMUz9enT02YtvBieG+/a3xkVhm
 mi1/iYRWZyrgkBR3SP+9englU/l+zLT9qWDQmgFf6pjtikU1QygQIRH0badmdNusOUP50WEj/9K
 jO1+a0iy/glDqF1NiPGuaYO/AMaWY0ffOi2MaXhVh02sPB296CGPainoTffMhGVOT6ze8upYrHp
 OcZpPc/pbnDhTZFcKgWGwDAYFotkEjQBiJaS/vH3lgHT6sVs3NhZzJo=
X-Received: by 2002:a05:6a00:1802:b0:893:12e5:c07c with SMTP id
 d2e1a72fcca58-8c87c389ae0mr18623299b3a.27.1795675161015; 
 Wed, 25 Nov 2026 22:39:21 -0800 (PST)
Received: from server225.. ([39.170.101.209]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c87077a058sm10297575b3a.8.2026.11.25.22.39.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:39:20 -0800 (PST)
From: Ping Li <leeonion.muyu@gmail.com>
To: cyan@meta.com
Cc: leeonion.muyu@gmail.com, catalin.marinas@arm.com, will@kernel.org,
 palmer@dabbelt.com, pjw@kernel.org, mark.rutland@arm.com, alex@ghiti.fr,
 emil.renner.berthing@canonical.com, masahiroy@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, u-boot@lists.denx.de
Subject: Re: [PATCH v2 0/2] arm64,
 riscv: boot: emit standard LZ4 frame for Image.lz4
Date: Thu, 26 Nov 2026 14:39:14 +0800
Message-Id: <20261126063914.3237108-1-leeonion.muyu@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261126030233.2546274-1-leeonion.muyu@gmail.com>
References: <20261126030233.2546274-1-leeonion.muyu@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 26 Nov 2026 13:33:17 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_FAIL,SPF_HELO_NONE,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thanks a lot for testing across three lz4 versions, Yann -
especially 1.11.1, which I hadn't covered locally.

Ping
