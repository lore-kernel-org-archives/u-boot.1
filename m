Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D7A606A864
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 20:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=B5rcjjc3;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=DN9OtmA5;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=q/rpC8Fv
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0C82C813BD;
	Wed,  4 Nov 2026 20:38:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V2e7vtZRK3hm; Wed,  4 Nov 2026 20:38:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 50F44813CA
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793824707;
	b=B3mnV7w8fgfItDQt1QznVNIW/bfoOCg+wnvnVLZf2jesntjFm0lZTTtITXISrmd/rpoc
	 xh/P8txiEHu/wUMXpta/ibrlC+3XrZ/KS4Z70pbq3gWIsL+eCXO/vQIpgR5CUdS0mEA2t
	 ZPKix7DAEKJjziFzqLJIu6YMIkrjHSbNeOlCI+U6OV2eZH5IJFPqDtURxHruDBFM6KEz9
	 eAKxJBFW0NCu0qxcoXFHJWJP9pL2wBtJMOyRfaOAPZoyC3DOvG94k1sDABZsOUXvyuvDS
	 gpIp52BOWD9x+TfhX0E+FJWURRpLv6dmDFiVmLZG/sCF83+CTwNQD9VgWtnp0anT4uQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793824707;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
	 In-Reply-To:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=kFT1N6mBu1g0jGfHFB/xJLcxBf/973/vbWZKraPTJgc=;
	b=RFY6rdRBO9s9Et/ELTjJG0Xe9kYx/iglc8zZGwAej2iqh8wcjOJMehpHPvpr+HnlBKV0
	 r9vUS1g8ZPW1jk2cDgLP31VqSaZRa+ZadVlvWA61ba8ZjOm+0k7X0GKCcpUDHipPx5+Eh
	 V4/W48y576pjXxGUgxr9JI2jGYzD51jyOJrSSigBNW7gvvvg6R64lRbukW/8ckMhEJl1/
	 bEWN9Lam4iSneoDnnNYTZiYMtblZyguB6BwJck1ERsuSQTeKvC1hy0GrXnppQqiHh+SUp
	 cUUYQrmypedKRq4eGpibl05cOmMIy1u1oI8JnXPhPnV6PIFrjpilsv+YT+5OKM/HhbQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793824707;
	bh=kFT1N6mBu1g0jGfHFB/xJLcxBf/973/vbWZKraPTJgc=;
	h=Date:From:To:CC:Subject:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=B5rcjjc35GPH9wVTA9I2s7Jnj02ENp8UK4DygiysQXOSjVuSn+w/hl7+FiyXI95FK
	 yheH5m1Eydm8OZiOoaGb3Bleh2syNRFbK/DqlBbVKA3WkvhIl88xzuwuvfGZN5wut/
	 /59bMiB+oL2BoLdcGxeeQTSMk9DyqAG6vK61P5Kgjdq3jbjrqBJuCSGDfvTKgDZdWs
	 2rocYsCgsxddE1sIFY5E5OVCyDdHQAerfvd+jlZo5WtKVmjQfja2uyidoiTUPre/I5
	 ijwT70ObPAGjsrIef9FVnLmwFp1WTUQWR//mnXEFJ64ZJjq7ywkdcL1eB4z3zMQE9J
	 5bGHMyYQymh0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 50F44813CA;
	Wed,  4 Nov 2026 20:38:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 290CFAFC
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 20:38:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0E9C1407F9
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 20:38:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VdyYOiRcZZj1 for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 20:38:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AA88D407E4
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=brads@mainlining.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp4.osuosl.org; spf=fail smtp.mailfrom=mainlining.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mainlining.org
 header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r
 header.b=DN9OtmA5; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=q/rpC8Fv
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AA88D407E4
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 20:38:22 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B5B484828; Wed,  4 Nov 2026 21:38:19 +0100 (CET)
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6F8A83E76
 for <u-boot@lists.denx.de>; Wed,  4 Nov 2026 21:38:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=brads@mainlining.org
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1793824688; bh=kFT1N6mBu1g0jGfHFB/xJLc
 xBf/973/vbWZKraPTJgc=; b=DN9OtmA5V4//rR9RM4sl3jZfwSbMTzyKVP+1qAzOvUUK1OxgeM
 Gzh/yrqaUHalbM3+mB3jfGxWClykPzzLj4gseF9u6leiVHfgZ5wMyu+t45OV90qpFbyeapO+uiX
 pkWPw7ulvIBL5oS1ovAQ0NxoBwCI+EtrlXeR2tl7oLb2dzA8P73ihJuC8UDmXXlDjK3c6z6ankq
 eunjuaGuY9t3rVwzlVWoJ/rAR80hUkbfZlUqbdWQqVSskp2IiQMSJuUan+CHLusVKRPrTOKRK9Z
 HkpTevND3+deoB1boi1i3oq1rAFlUvwgArgCv3K+f0I4qMYtkIkTGgDhqP02v+QQ/sw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1793824688; bh=kFT1N6mBu1g0jGfHFB/xJLc
 xBf/973/vbWZKraPTJgc=; b=q/rpC8FvXbKsEueCIgxvq0Ii4cHgWImcuqK3pVn8MOzh393YJk
 M7YBUYNFhML2f1Yk3dhHaB6n6No3dUehoODQ==;
Date: Wed, 04 Nov 2026 20:38:09 +0000
From: Bradley Morgan <brads@mainlining.org>
To: xjmps7114@qq.com
CC: trini@konsulko.com, u-boot@lists.denx.de
Subject: Re: [PATCH 0/2] SPL FIT software rollback protection
In-Reply-To: <tencent_4D4A63A00ACB3E875F30AD14C1B8961F5D06@qq.com>
Message-ID: <1C30EC2A-0ADC-4711-83DA-390A61399F4C@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 4 November 2026 14:11:15 GMT, eli <xjmps7114@qq.com> wrote:
>A verified FIT is authentic but not necessarily current: replacing the
>next-stage image with an older, still correctly signed image reintroduces
>vulnerabilities fixed in newer firmware. This series adds opt-in software
>rollback protection to the SPL verified FIT flow.
>
>Patch 1 adds CONFIG_SPL_MINIMUM_FIT_VERSION: after signature verification
>succeeds, SPL compares the configuration's "version" property (covered by
>the signature; missing counts as 0) against the minimum and refuses to
>boot a lower version. The default of 0 disables the check, so existing
>boards are unaffected unless they opt in.
>
>Patch 2 documents the mechanism, including its trust-root boundary: the
>minimum version lives in the SPL binary itself, so this is a software
>trust root only.
>
>Related work: "Add anti-rollback validation feature" by Sean Edmond
>(2023, Patchwork series 372657, currently changes-requested) addresses
>anti-rollback at the OS/boot-flow level; this series instead targets the
>SPL FIT configuration-verification step and is complementary to
>monotonic-counter approaches (RPMB/TEE-based).
>
>Validation: the same mechanism was validated on real StarFive
>VisionFive2 (JH7110) hardware against a vendor 2026.07-based tree:
>signed version=2 FITs pass (cold boot x3), a correctly signed version=1
>image is rejected with a dedicated message independently of hash
>verification, and recovery was re-verified. This series was replayed on
>v2026.07 and builds for starfive_visionfive2_defconfig with
>CONFIG_SPL_FIT_SIGNATURE=y / CONFIG_SPL_MINIMUM_FIT_VERSION=2; the SPL
>binary contains both the hash-verification and rollback-check strings.

Hi, not complaining, this idea is awesome! Saves vulns from causing havock.

Well, let's poke and prod. Since this is very very very interesting.

>
>eli (2):
>  spl: fit: add software rollback protection for verified FIT
>    configurations
>  doc: spl: describe SPL FIT anti-rollback usage
>
> boot/Kconfig         | 11 +++++++++++
> common/spl/spl_fit.c | 24 ++++++++++++++++++++++++
> doc/develop/spl.rst  | 43 +++++++++++++++++++++++++++++++++++++++++++
> 3 files changed, 78 insertions(+)
>
>

--- Thanks!
