Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292CF606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 02:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oTTlCAwQ;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mKFbyqeS
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F239F60612;
	Sun,  1 Nov 2026 02:19:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b04su2IzA9LN; Sun,  1 Nov 2026 02:19:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4BC7660608
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793499561;
	b=W9qyWigVH/RUKzh06grSmBreQ4N74504ORrySjfwQuObwDELDVhsg13+ymNskdbDwBA6
	 5fORPKmGN84G1vmf7XwBVfJBvhxJ758zpQKroxptkJHsr+QxoIk7q2F41bbl2e35250F4
	 Q9Sb8nwjWmFMoc3dWY0rzU3PCZOI760xKMLJrd8iuqy1Fx8CFF70DKhnmmgSyTlJ6kdLn
	 D9gaIGq5x+BoPWOlf3tyJj/4/+ful0rX4u3bSA9xPHDYW69yq+NUqu/NEqBizlzTgUJeh
	 KUPBYO/r5Q8GWbpISZhAqiyaoJfdEyc1BGU/d+HLHJGcK/D7SjY8LMvNH5XrkdcgBFQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793499561;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 From:In-Reply-To:References:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=2pQrQ37mK7NYNmBPU8n98tBcdje/8xrNLuRh6oSdWgw=;
	b=ou85ZpygU9RYxSmBcV70dy/0h3o2BhRSwJWkM7ljRCo9O4z5+dh9GiUaD5BxGOhnbC5T
	 NKBkUAme66DIbPVE1TRw6zqAxePTfJuOLi4mVTbIbSYrs1DCuacqLfcqNiAhJhedj05lj
	 2RIG0OiKXR5+qccI0pXIIbBvvoOKAM8FoNOwVyTRXcj7QdqI2aCPPmhNrLeMUF9wxkZFn
	 F1KYf0AcBk9YB0m8u8oRpH/sxEKIdIIc8vW0WT6V+Z+43bkeigSZ8D0nAWNfxAMMgcTdt
	 pMC3f7RjTrS5dm1/TlPdDb9/s5j8XhbPQGndz+IG2GLVdw/cnj1+yfB16dJtLv2SwPA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793499561;
	bh=2pQrQ37mK7NYNmBPU8n98tBcdje/8xrNLuRh6oSdWgw=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oTTlCAwQ9JyHBpdQg0EQVH1L/smFqiZJfmrSkobQZyzA/EuPAQn0P1UedvCBWIsj3
	 4aa0n8TAT+kDdHNw72sVeJ2wjDG+3K45hwHlYTBvQWgx4AgI3nR6JAoUBsuHaiYhu+
	 gd5Afe/r7Ui0fM+/6AMqlfhAfp3DRWr6iB1HfpNPE1eDqDcPud2upaLba881IhuZV4
	 /fVdr9hkwprnI0Y//PNL0p/3A7E5zJGFOV+rP+NP80hoHonn5+rBg8V0UQ0O5GXAvt
	 W6SHW6al3oYNHWLEDYs+nq61Mw5RVTsjOrJP4ycnGUJn3zZa59hvvrjyMqxUidecHg
	 jfiekfKJLvtxQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4BC7660608;
	Sun,  1 Nov 2026 02:19:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9E4CD380
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 02:19:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8454580DB1
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 02:19:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FEmIxNdPSOea for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 02:19:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D5C2180D89
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::132f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793499559;
 b=TzCby/KFktFEYPzPZg6T7Vz8Ed2vkYxkl+QsQGZ1OsImrTwCCISJaW4GKxTzLXeJ+ZZ5
 5xLmQmRu5ftiyz7lG/6s8/LSP9IiFamIiTlEXZNNjlZSNb7ed2+b68gr3e/lXu5LZdZ6X
 WDlYDHAH9qkSMbHfWrMxbKtlnAcg2lCUwShMGcuT3HeDHIEPl3RAq+zExUGtPcc7YgLRl
 2F/Twy7bPWs9GNfzPqkcAMySNKXYAnxVRZy9l4JmF3ZJ/xW5n7EZ+u9U1UmCSK4/pg2Tv
 NwJKdTBg1oWFEf8zvjWTwQADIQfTrqEnqSRi+gYnfoWjYW7+JqsoCwUM3Ewu9Z37Lwg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793499559;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:From:In-Reply-To:References:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=2pQrQ37mK7NYNmBPU8n98tBcdje/8xrNLuRh6oSdWgw=;
 b=MT/7JQV1rv06Jd5whBvYEEQ0Czo0X2HP72eY1B4WaCj/BOXauF/0tOGvkkX/rxVCZ4P9
 8QOTEla04+wgkap+ztP4BNJOqlluP2lE/ttdiWrFuieie/qvsXK/nbBOURxits6csWlQY
 lcu0SMrg4wuNyw/a3HgkQ2xQrGvovwLvP/6+3jLbayipY71Bk+yYrR6+wZnUizq6Rsc8I
 SqspRadW7rsW3cYQ5pVwt6vqkzYjyyizQXflh9CH69VRsU4K2AkOuRKeSh1hXd9jXVPR8
 LtouWfw2pRo2UWWWSBIw1C0dNfoNZ3v7ipNyZnWEgHbdCdhzLk92XFE9WP01VzDkDrQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=mKFbyqeS; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::132f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::132f; helo=mail-dy1-x132f.google.com;
 envelope-from=kforce@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=mKFbyqeS
Received: from mail-dy1-x132f.google.com (mail-dy1-x132f.google.com
 [IPv6:2607:f8b0:4864:20::132f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D5C2180D89
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 02:19:18 +0000 (UTC)
Received: by mail-dy1-x132f.google.com with SMTP id
 5a478bee46e88-36a0f27c9f4so3453278eec.1
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 19:19:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793499557; cv=none;
 d=google.com; s=arc-20260327;
 b=NRzCykefgEp2SEt1TyqQXz2JcTUdkwWdPjCrUhuPrb7DNVfG5t+Uhv3bD9DaAWAbcD
 E/jwRD3yFuES80siYYj1a/81EJ7MLqiEkcLG0K9f0zWpGyLc72JJQcORqac/dPvljXcf
 8uBpv02Rcnvpv3rSu6PSdecIVA483CbvJxciE8wy5f5QZD6oLgbX0ygN6K9nPA3453mx
 pEaz+qad/5gAx1b1BoErxJPNG5Gl2V0OGp0S4XBb5rAFndgpUzxh5UWS9m1Y5EKofnaO
 fWvnwK8e1oNMWK2c+haS+5G1sH/KvwneZE00FcR+G0lakRDDfrXc1EeMHVIKTlIqpQdd
 tiyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:references:in-reply-to:from
 :mime-version:dkim-signature;
 bh=2pQrQ37mK7NYNmBPU8n98tBcdje/8xrNLuRh6oSdWgw=;
 fh=6WnwVw6WHUrn6oiyk+DTwnfVjcKS/CpILdaJTrReuVw=;
 b=fLbgg3NWruwDZLtaVQRjEFGk1ApDBlNVgPRcqElAQ5B1Y7nHN9mJVpITQFXzjvSnx/
 PbZv91vB7O6HHaNp9+L9zdT8eO6iX9z1lHG03lAFWeysmxB9tDfekA7M93cEzv61asss
 NccuzbGtCsXwxK5Buc5jPeIp2AJlPDhHmCyPNDtQkiZrXo4UGejvDSYSrIGOWEvGbSbx
 E1EHVs0CS7+sizY0446umll+NLtuko/dvrGvXmmhz0YKpABXJ6bWBvHVAobEnZ0M027y
 sD6I8MSBRAkQ5xUTnlPs+VzTUgLgENy8+dsBFruJmctSMZeEdrIaFIl+wl4knpaHIHdt
 /QfQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793499557; x=1794104357;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :from:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2pQrQ37mK7NYNmBPU8n98tBcdje/8xrNLuRh6oSdWgw=;
 b=mKFbyqeSHi2qGXhDOZDd0OJWml1NffkufLDJ6v+g2XPKRQZZAqlcm9vGVv24EFAUJp
 3G9FTj25N/G9bPvh3n0X/+SpkCv5znTbcNgLzMwGmoKZYrP4ZDwKUzDiiUraqsxZP75s
 6c7Cut7mJb6stehcuYMhrS6e2WiPPWZV4vEMxt/uh2uljASgjxIt8iOUNxvSUtswqvH1
 TbDdOhx/3y9YWs6xnbdFPt+Bzp3CoyUW840spk3vmiVrLXIMmI8Dr/PimOglCcVrYIyh
 T99ylK8w7FxoANhx1AjynylXa8UQmZ98xcLAxdoOo/bXLBVHqaz2byHVa2uHPVpkQCpw
 ybdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793499557; x=1794104357;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2pQrQ37mK7NYNmBPU8n98tBcdje/8xrNLuRh6oSdWgw=;
 b=FSSJvGs6WakHM4KFCBiatKl28PswXhtf9bBaIx5f8+g7kz2WpGHq9sML5G+is6MEBX
 wkf4MI2C4fJmK71OLGnvvxtUApWtgNdfuDaTMkkPxq5LXUQl6Pa1x0G904EH61+fPaGZ
 pJY+CE5xA9B8+nEjiknNLinwYsh9FnL67JKPGuWbN8YW+PEqKhMUMDduexmWuvDIzBnk
 lkDYZ6bnm1LLyC+FnB/3x4m/mngaM4M2VlK777Laas6i+euFLvOqtj3cxHwlepXqN2yI
 qpqazFa/ZKuaVHBo6JvNysp9aW5GVfn8fiQRpmSnBwmCYe6nAeFbyR4qHahzfag2b+2A
 JKKg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwp7lEpdcGeMYJRwnUTivPGx9uhEHk3UvgUoXCSD3AvIPX/038VlmEseQq/LmjwqD+HnSZn0UQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLaLJRXOn216yWU7QdMe7hk/iuFXeF04BP4jLU9UfuFzFFhGfc/
 aAwrRHFvIu/QA1xUMpSnepTsuZSYBNwZ5ExXA31votvgvNSsn7dzHOIGblR627X7vcCU1MA6NGL
 jj9nHnFnGcMrzcgTcm+XkDYUx6lq2Vp2HR8hP
X-Gm-Gg: AYBFou3KAT7ExEEhV1nN3/kgNMbq0C9FoUsGgs6E98aKR6pOd51n5dXDPHbfu1NPj1q
 rwYPadOuAeqyPksQfwfnvBbrQi7+vuBsBOv5CDutiDQx0XsTAkk2A1fcVgNapd54eaytlm93j/6
 vAawCj/0M+V9M8lpLu0pO6oWS06rsNKla3MNag0hYYHBHQsbEAmAvlReJDJ6Vly4nyAX0KWvM3l
 HHyvjoUZ2V7OF4+jM6gRrL8BjFYDZjiqTOpwMCFHFtmxqms/e2WGJf27ER4pwQeaajHbaXz4fLg
 UaRMNpejQyCwExk2WNZ6AE5FNG4opuRCPMjNfSvk/19kQB4VSZwXykZkXiR4Sdw4fQ1fRJqxrio
 UmA5rIJ12l5rKZf1owU1BeTR3Ku4n198JTNteFxlAzjzo0ajVbDcxdYAvU6FeO0R+OHn2UeODuR
 zxbKldqgA7J8QZ8irxj19yfSNP8vg1zHY8X6pn4g==
X-Received: by 2002:a05:693c:69cf:b0:369:daea:812a with SMTP id
 5a478bee46e88-36a423fae73mr9239243eec.30.1793499557245; Sat, 31 Oct 2026
 19:19:17 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Sat, 31 Oct 2026 22:19:16 -0400
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Sat, 31 Oct 2026 22:19:16 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: khaliforce <kforce@gmail.com>
In-Reply-To: <320cdae7-6f59-48a8-9821-575a2825a777@nabladev.com>
References: <179128521948.5.12131679420803093421.uboot-usb@gmail.com>
 <3ae0a18e-0fa5-477d-bf5e-89072b9634ba@linaro.org>
 <20261006155833.68374-1-kforce@gmail.com>
 <179339930697.12710.14888890033364215367.uboot-usb-v2-ping@gmail.com>
 <320cdae7-6f59-48a8-9821-575a2825a777@nabladev.com>
Date: Sat, 31 Oct 2026 22:19:16 -0400
X-Gm-Features: AclHuK9kufL1v7swUP-Y664ISJdQgoSivVbqjJZ9JUMyLUVPH_v8DmUqizboSnE
Message-ID: <CADskdwnoa7r3VX-YZY4k6=i-phJadaqQnSA6u-0JnX+nZg7vMQ@mail.gmail.com>
Subject: Re: [PATCH v2] usb: stop generic OHCI and EHCI at OS handoff
To: Marek Vasut <marex@nabladev.com>, u-boot@lists.u-boot-project.org, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
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
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Marek,

For privacy reasons, I prefer to keep using my established
pseudonym, khaliforce.

The v2 patch code remains unchanged.
Could you apply v2 with the existing authorship and Signed-off-by,
without a v3 resend?

Thanks,
khaliforce


On Sat, 31 Oct 2026 03:57:48 +0100, Marek Vasut <marex@nabladev.com> wrote:
> On 10/30/26 11:28 PM, khaliforce wrote:
> > Hi Marek, Tom,
> >
> > A gentle ping on this v2 patch.
> The plan is to land this in 2027.01 release.
>
> Can you please send a V3 and use your full name in the patch authorship ?
>
> Thank you
