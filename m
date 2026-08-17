Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0766DC5B572
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 18:05:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8F6FF8105C;
	Mon, 17 Aug 2026 18:05:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3ssDp8JOfzuO; Mon, 17 Aug 2026 18:05:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C6B888102F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786989941;
	bh=ycyBQ2DACcIf5Yn6zq6ToqB4m5rzOu8E0ieDcrdVXrw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p1fa+2WD67YAeiST5g1EPDcUF01KDP7Kc6pU9i7Ao/35nijcZqKOjudJ0DCoJ5UnQ
	 Ic2b5wB6y29/nq0Y38y5HxSMeo7RAU3YuyX6oktHsXWLVnQZlrRrMlYTiOQPHbYvN1
	 i2x7NkV0V/Lc+6mfWM63AG0eg07w/apx7BgU+6Ih0aeR12bQbVQCHuTAXrN2GTMpYx
	 VP5LsCgVovrVlyXPFEl2JhvvIbRdCtcWxQHEG0EFUawkHq/Kc6xIgMCX7r3iD9qWC+
	 AgtPMlOkAkA5u7Pi4PP9c7HmXyYoHk3JxiCPsGpZhgXmS86ibgVYW4RYjdHom8vrDH
	 a1rD+JTo+cxfA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C6B888102F;
	Mon, 17 Aug 2026 18:05:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 234FF337
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 18:05:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 09C7E8102F
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 18:05:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c6mcb3yWoPl2 for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 18:05:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.15;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org BB2EE80F0E
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BB2EE80F0E
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmx.de header.i=xypron.glpk@gmx.de
 header.a=rsa-sha256 header.s=s31663417 header.b=U8fCCDcA
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BB2EE80F0E
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 18:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1786989933; x=1787594733; i=xypron.glpk@gmx.de;
 bh=ycyBQ2DACcIf5Yn6zq6ToqB4m5rzOu8E0ieDcrdVXrw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=U8fCCDcAS5vkcv3YLIqr2xfAcKKWLPlAT3qAvM9OdkOj1rn5tMZS3Z1uCG1xe9qL
 5Kpf2vwVEh5YfBDmavLM5SHAUU+D7Crj+jiaFIpNK+zcIKbYV6VsILcEHkjH+3h2G
 V5fpbYH+56OhW7B8k6dh84mMqU65qiPPUvgvhaH4llX0m43JJsJRyc8Giss64Hi7r
 0lP8cghdEWM2T+HxhKaYMoFNwQe1GMSFEdE+oaiamynpfO9tZSEOAbTVAOCGIQ/c2
 Sszu8Cay1nzFu2lV08hwknAcadDOURrLEWDDF/8ct+McjoAFjptzm/ETlEkrzwP9O
 EnQitcN2IKx3t943ug==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1My32L-1wlNQ231CB-00s97M; Mon, 17
 Aug 2026 20:05:33 +0200
Message-ID: <cf0dc62c-6914-45cb-91de-7bfc9b592d05@gmx.de>
Date: Mon, 17 Aug 2026 20:05:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [security] Report of possible heap overflow in U-Boot EFI TCG2
 boot loader (ANT-2026-CBSBSFG8)
To: Arthur Chan <arthur.chan@adalogics.com>
Cc: David Korczynski <david@adalogics.com>,
 Adam Korczynski <adam@adalogics.com>,
 "security-cvd@anthropic.com" <security-cvd@anthropic.com>,
 ilias.apalodimas@linaro.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org
References: <5b32c403-e7fd-45d2-8f8d-af7e889e385e@adalogics.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <5b32c403-e7fd-45d2-8f8d-af7e889e385e@adalogics.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TKQY3hrWXj/kWqwJECso/4DOctbBuvBNW5gdb5yoWEDGAZ2khR1
 xWh7v698cD/gXm8tVz6Yy1JjZE4QP+u82rvI45qkKLC2beNqYUzIWc+LtjskwIJ/Q00hc72
 voQiONmjUC9lc92o4vDzplE72t/UgVQOccAjsfxWb8Odli4lvvuA0N/LtRHBASJhKhFsd0v
 keJZn/bnbB8NBrJvEWDrg==
UI-OutboundReport: notjunk:1;M01:P0:dSzJtE9id24=;2RQXENQEIBOHkDwF8gY1nay1jKz
 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
 +lTc04L/jjCcx5J7Afw=
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

On 8/6/26 14:18, Arthur Chan wrote:
> Hello U-Boot maintainers,
>=20
> I'd like to report a High-severity security issue in=C2=A0 U-Boot (https=
://=20
> github.com/u-boot/u-boot / https://git.u-boot-project.org/u-boot/u-boot)=
=20
> related to possible heap overflow in U-Boot EFI TCG2 boot loader.
>=20
> I have attached 3 files with this email as described below.
> 1) report.md: A full description of the vulnerability and how to=20
> reproduce it, together with suggested fix of the issue.
> 2) Dockerfile: A Dockerfile for demonstrating the issue.
> 3) driver.c: Work with the Dockerfile to demonstrate the issue.

@Ilias

alloc_read_gpt_entries() on 32bit systems seems to have the same issue.

I guess we should correct the code in disk/part_efi.c first and then=20
reuse it for the TCG2 protocol driver.

Best regards

Heinrich

>=20
> Attribution
> *-----------*
> Please attribute Claude and Ada Logics. This issue was found by=20
> Anthropic from using agents to study security of open source projects,=
=20
> and I am from Ada Logics helping validate the found issues and creating=
=20
> the report manually and notify the maintainers.
>=20
> Disclosure
> *----------*
> This report follows a 90-day coordinated disclosure deadline. I'm happy=
=20
> to coordinate on the exact timing and to provide any further detail you=
=20
> need.
>=20
> Kind regards,
> Arthur Chan
>=20
>=20
>=20
> ADA Logics Ltd is registered in England. No: 11624074.
> Registered office: 266 Banbury Road, Post Box 292,
> OX2 7DL, Oxford, Oxfordshire , United Kingdom

