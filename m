Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7206606A32A
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 21:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vr0yMHK7;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=jdCC4Sp1
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7347C4064C;
	Wed, 18 Nov 2026 21:10:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CQOmW6jPEL3R; Wed, 18 Nov 2026 21:10:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BEA3840606
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795036226;
	b=dxiTjixhEPCjWDUH547/z4fponwvfAJ72nN5wqjNTT+1wlGsXxMt8OhHv9jExre50NrJ
	 F09owSVnzk4y24bi1ngdK/8p9f4lXiHEqutBRJ6X+zZ887jIQ+7EdcYGx+3Z0VkH903q9
	 APCPpP5hNKa1B4OCqWhVQlpqxPE76TICxQcXjhkvVPQA0poziK5GLHRhHNNArcBTAe4cG
	 RPgnqq+HdDOknSoaFRYrHZonujxlQOszFpzS1L3IcmEYF4F+eydUf1jgAqOA6axFxHd4U
	 l3sZfMQteTgxYJxyAmMnT7VIgqrQEF0DbKviQKQnnsTu6lY0GrqZS+dpuFIOHA8T46w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795036226;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Ofwg2K8lx7+UQXSKeTpYafGDBn90wS2da12f9YnAcEM=;
	b=jk9Zk6YmjBfSAi3j0TkTRjuKh838zcm0MlGP5pMKsdIQcbMcUEVVHsUAOi1U+6GK/C/P
	 fksD3bvIXGrKyDwejt/WmR7lF2au85tReJAXfJMHnFFw0d7JxM3NmOR5hdqGd3VEXX/oa
	 aI6tgh8wKFnQCnFGgH0uM2CbbllWwGrcyZu83W0c8f3OCZ0HNTom68uNHY7VaBbciShLI
	 3+mTl6It1SKNZId28nydIanesTRDbfpXLxXyIRYfmJrAcPodaWWY9lMSgaQ7Amvq+UPOb
	 hXLRAiDzbwKHRh30b8rIVBrHvvIOGTL1u8o4/J0wggj9Ds/CTRZxj5tb1nSO1KV6XTw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795036226;
	bh=Ofwg2K8lx7+UQXSKeTpYafGDBn90wS2da12f9YnAcEM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vr0yMHK7IhQ5pBRPIbDTYc4L68vYqLkB+sjeVs5EDv0fmevWKSAkChUFrM+PF6VxI
	 2UJ+/RxySY5yJ2PPj0kqk4Qrbc6uK4W6am5MfgdGPL9wd9ymqJVaKl52D/Qsq6pjV1
	 ZMcLALcnyBWRoI6XIzy2YvekRQ4JqTNgZDBq0+wQhPjkrOBm+yU4SLGblBk/E6Ftbf
	 Ket3NPsxkpOGdZIMMGHLxPddOS/7nw0z0XH3OLrCvaTll0FHMFJXbpl4070uUqberc
	 zIWNVxEpx8t5vvougSiPYYpJg2zdZ6heIJWR3Yx9qTZBrD2A2mEfGbVAa7Q0p435ts
	 4sqpmIZQqJaMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BEA3840606;
	Wed, 18 Nov 2026 21:10:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A577F22B
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 21:10:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 94612404AE
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 21:10:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gOzNKx_DxDGD for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 21:10:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D41DF400C8
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c29"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c29; helo=mail-oo1-xc29.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=jdCC4Sp1
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D41DF400C8
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 21:10:24 +0000 (UTC)
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6ddef424972so1278414eaf.3
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795036223; x=1795641023;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ofwg2K8lx7+UQXSKeTpYafGDBn90wS2da12f9YnAcEM=;
 b=jdCC4Sp1p1z31LhZlg2aTNSB9nxDtjHtsZs9bxRwjvmg9Q8EdxirAKjEWwquz2cg1f
 zFlCPg007kax5o0e82SDptHKEUoLTCs2MD7cAbAjb0X2LP2lmHcbo6LEl9jwYsZKqmjK
 hHwSxhIdojNm+jLUGDSK6u7tXVuUjphTMsRbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795036223; x=1795641023;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ofwg2K8lx7+UQXSKeTpYafGDBn90wS2da12f9YnAcEM=;
 b=afvNWSU4KAq6e26mDOSWYvvNLLdNUA19iZtMuKiXEHNYQC1tCvqDZFGHagHg+sqOGX
 oqwze3AiFagpdjCpIuTAyn8ZwD1kneAEtOcEMxfbxujznt/7aLARYZ4PaaGY57FmBWv/
 AQMsVn4O24hQXuqlILJIQu+m0gXYAh1gO681tnL/165xNlWmTkPFaWgA2Cgd/0usTh5t
 Y+5A587mLH/r/IPA0vmIUliQ9liiUQO14y9XYYSnBAFduPqClE1+fj4nx2oKG049gN1L
 +Ol14o+jlKiswh+w/80ifv8aqXf8orzYfKxHeAYu/M3GDU1jnJIG85Xv1aarYfiYzfal
 VlXg==
X-Gm-Message-State: APuU4Z9f1CBAUVdJkYm5EH4aEAKczBLSn6Iy/T+JKhpT+40upTcHZvX2
 1dRVIXGivOT+5s1nzgt8M/ykexPLaJ46l4lmkhlsiKKj6vTOwVcnGzHN+i+LhOpaAzrzGe8bAN3
 4BtH00jCKaQ==
X-Gm-Gg: AYBFou0NVRfJMeJsJDeHrrgrL0387LyJOXezwxiktjXKDtOz1yDofAkxMnLNc75dAg0
 BFoqgg1E/ptVs21EWap3hyq4eSRB64eu+4VNkZJtQCZqf0rwGl5iXG6TYGb/CT57HBubjxePEeC
 P26QySformzPtBWOSSs0CS5QkLLdSzz3+93NLUCzbjw74aeqslwv886pHtWDCB1xIbHzC5UQy6K
 T+Y3qQUE0cz973gZAFM+U4N8UDH6BCD+v4l3/DVDKpxNqiGPadAoZopwsZbUQ8hj+NMSl4PYpTW
 sUAW+0tEazLWg94FMookUqCfkFZlFuoHiLh4vzwLMJeH3N0SLx9JefJFuq4VrCTFwhjDT/39xT6
 87pD8WGCtp3NEBVc8Ln2NkicS51/hibzxqkPWGPInMmC8jikGOJQ8qHoC7hJPKoWSvdH2bR15lu
 0oLai3WVe5Xb2FtxOtP+ovC485lPCp3cvj5UzGEbG+YiLpBpjl2QpDfn2NUzBB3vb7RGrFPG8kC
 Jb1IJVGijCTkWcrM7Wg0yHctQtk1n82AXPM1j4s9ajXBT6v3Wj/FaiQZZhwVEzA9EcZXSEv8qeg
 zyulUlhSC0k5AKuU8ks+L2qBPLXVzGQhYRa2Gr0EU9PLIOYepCE9Td8YwE/8rb2cYRUdwE4OPBL
 y+833hKxypPH+dgwNb0U4PcHspn2Ggxn+Iji+Z3c6rxyovp8ZRB98nkhAl2v3ad0Peq96O344g7
 8F2+Yegeuc3XCnuKaoHpsw2QiXsJfz2gN3OPGNmuQu+10kbx0iqzQ=
X-Received: by 2002:a05:6820:5601:b0:718:968a:7608 with SMTP id
 006d021491bc7-71b185da496mr1907335eaf.44.1795036223521; 
 Wed, 18 Nov 2026 13:10:23 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-71b1955599asm2953033eaf.12.2026.11.18.13.10.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 13:10:22 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Ryan Brue <ryanbrue.dev@gmail.com>
Cc: Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>
In-Reply-To: <20261028-b4-rbrue-suez-upstreaming-misc-stubs-v1-1-9a88ac233299@gmail.com>
References: <20261028-b4-rbrue-suez-upstreaming-misc-stubs-v1-1-9a88ac233299@gmail.com>
Subject: Re: [PATCH RESEND] misc: Provide stubs when MISC is disabled
Message-Id: <179503622258.3175094.6830140871766673950.b4-ty@b4>
Date: Wed, 18 Nov 2026 15:10:22 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 28 Oct 2026 16:01:55 -0500, Ryan Brue wrote:

> nvmem.c reads and writes cells on UCLASS_MISC devices with misc_read() and
> misc_write(), so a build with NVMEM but without MISC fails to link, even
> when every cell it uses is on an RTC or an I2C EEPROM. The headers of
> those two providers have stubs for this case; give misc.h the same.
> 
> 

Applied to u-boot/next, thanks!

[1/1] misc: Provide stubs when MISC is disabled
      commit: d5aa20e268bd27a8645f939a019b1a0f38e9635f
-- 
Tom


