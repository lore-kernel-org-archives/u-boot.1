Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01860606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 10:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NMwBn3ru;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b=srU+T3Wa
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CD8AC607DD;
	Tue, 24 Nov 2026 10:52:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XI7usOfWWTxt; Tue, 24 Nov 2026 10:52:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 660A060606
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795517560;
	b=J7hAiOoHfz4k6J2nbqFlQdeFIBGbroQ3zLWAbdyfq7dw6fxm+/ocMNMEjs8aYKRgechb
	 ASBwLERZNdl6Rkl0AbguJP5v9Ek4o209+CR4gKvUnGwv0oIXXO9HyRj4rhWv7VY/eA0R6
	 +4Rq+vKH5zXei9Sr9BEYY+VgXvbOjTravbW8LsaF++8KerC5KO1WlXpQ9l70GFcw+YjeP
	 MjBYUa/yjvsjAhdpzZLCw/+q2yT3vfXfUpKGjf9bnorx0tqkgGqwa5BW8LF90KNi/8Fmw
	 GoIhPc9lepo3J6lVhq2Wzi5Yd5GetWoxxIwrPsYE/3hktEI/tmmnM7m7U9Sk6ETWnDw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795517560;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 X-KPN-MessageId:Received:DKIM-Signature:X-KPN-MID:
	 X-KPN-VerifiedSender:X-CMASSUN:X-Originating-IP:Received:Date:
	 Message-Id:From:To:Cc:In-Reply-To:Subject:References:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8PnrdA9CkQmagf+bj49jlPq/UIvZlOkQcoS9Tv3eHpo=;
	b=IW+5B/t/Dd0f1rLZqiNXgw8GtEZbNbMP4wj9aRLfulcCe7G0XhUFin8nf7FbjlKDt0o8
	 VsAMZFL2h/zfmc5zbU2tCHBWRKg40yuei2aeUh0AI4vaaFPTuNuuGKofk+kzSCCez1YdI
	 9aPazONNhYgRvdrUjfZCKwiaOKUf0jeQr6UxtgYn90fTvPn0ZAnZbRDprsvAvnssBwQBD
	 lQTRehcu4DTWH0ckZlCN9uzm9TcV6SKgk077DPOc6nEsxaGxWNhPynkTGg22+jSOBKW/L
	 bV8QStVAhUvWE2UGTfpon6QIcgLef3riKTJyiWMNHrON4U7XcEukICla4s/e1+iEaMg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795517560;
	bh=8PnrdA9CkQmagf+bj49jlPq/UIvZlOkQcoS9Tv3eHpo=;
	h=Date:From:To:Cc:In-Reply-To:Subject:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NMwBn3ru6PsdXKzbIKyAr3nywmY1/B3QhL0NqRBlmz77fv3IOON+DGSy+k8UTwrgQ
	 F+pM2mavCEcKO+Y3vN2XVj57+pgEl57ytaPIYvk1TlRsYU766aUvTcMiY7g6CyA/UU
	 vNLjGccscK9OhfO4kBeIyZZTTtC9fUX5bVf5zenyIH97T0pSybidD7JBvQM05rPsvl
	 1/ITwBWunN55v61sMNPtV+Rc+Iw0kIjMdr8Pc+l360fcF5CcMzfgjnfDO2o1kY/275
	 dQjvcLp3Z7I9YKArQtKOXq9AK0eV9YOvgF6HLHsMfhkoWq1Cvxu8J2gAPxvEUtBsH4
	 ffkaZiC6TPLEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 660A060606;
	Tue, 24 Nov 2026 10:52:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id EAE943A8
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 10:52:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D147840243
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 10:52:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YrwuGD7TOy18 for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 10:52:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B39D240198
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=195.121.94.167
X-Greylist: delayed 63 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 24 Nov 2026 10:52:36 UTC
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256
 header.s=xs4all01 header.b=srU+T3Wa
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.121.94.167;
 helo=ewsoutbound.kpnmail.nl; envelope-from=mark.kettenis@xs4all.nl;
 receiver=<UNKNOWN> 
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B39D240198
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 10:52:35 +0000 (UTC)
X-KPN-MessageId: 00ed7dd2-e7f5-11f1-a695-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 00ed7dd2-e7f5-11f1-a695-005056abbe64;
 Tue, 24 Nov 2026 11:51:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=8PnrdA9CkQmagf+bj49jlPq/UIvZlOkQcoS9Tv3eHpo=;
 b=srU+T3WaxwX9Obf7H0yVNWP9wuf9FEtz2aZylIk3equVqU265x5cc3Cc5c1OuJei5kZAOqeK+a2S8
 6TBLIPWdsS3oxCzwjVvYeBvrpXLAxR8dYVjLCoQ+7J2hfcUk62LZGdQSUyfTWDu4njkoMLvTKPKVgo
 b3OuMUlgiQqEae2UPazoYGB2wK6SltC/TE252SN5VJYDzC9UfdNNOCXbAL5kKMgsT9md7x8ErfTHW0
 rA5WlRE5p1+6fFm6ZilibmoEMr7g3p+veMCMb3AZPkdi7C/gFW8CEhZUBqY7rXa/iPuKjS9GpUJaIl
 MHSpyllPuCMzGkRc2qCVJE8yEtPw5iQ==
X-KPN-MID: 33|LOsFBmHg4UW++MH8vVFCtTZlgT3Fopg7c8IES4Toyg09xn1srapxKpRPSQjvYLH
 YI1mxa6dGX0LRS+3g5i+fiLNNMIQ0skh0VMsq7Cm+zLE=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|YkhUKRsf3b5/lJUIh5lJ28hzjSnTKl60PRHLOaLAB94Ng5sIKyOjTJh9ehb7uIO
 EsNXl/A/PduolADcZXRYNqg==
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 007310ee-e7f5-11f1-87ba-005056ab7447;
 Tue, 24 Nov 2026 11:51:29 +0100 (CET)
Date: Tue, 24 Nov 2026 11:51:28 +0100
Message-Id: <87h5h6wlhr.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Janne Grunau <j@jannau.net>
Cc: u-boot@lists.u-boot-project.org, kettenis@openbsd.org,
 trini@konsulko.com, ilias.apalodimas@linaro.org,
 sjg@chromium.org, asahi@lists.linux.dev, anshuld@ti.com, j@jannau.net
In-Reply-To: <20261120-apple-t603x-support-v2-0-606b4f5fadc5@jannau.net>
 (message from Janne Grunau on Fri, 20 Nov 2026 19:53:06 +0100)
Subject: Re: [PATCH v2 0/4] Apple M3 Pro, Max and Ultra support
References: <20261120-apple-t603x-support-v2-0-606b4f5fadc5@jannau.net>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

> From: Janne Grunau <j@jannau.net>
> Date: Fri, 20 Nov 2026 19:53:06 +0100
> 
> Hej,
> 
> this series adds memory maps of M3 Pro (T6030), M3 Max (T6032 and T6034)
> and M3 Ultra (T6032) and lists the SoCs as supported. As proposed in v1
> and supported by Mark move the memory maps to their own file
> 
> Add the missing documentation of M3 (T8122) support.
> 
> based on v2026.10 but applies without conflicts on next.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>

For the entire series:

Acked-by: Mark Kettenis <kettenis@openbsd.org>

> ---
> Changes in v2:
> - fixed t8112 vs. t8122 typo in documentation
> - moved mem maps to separate header files in arch/arm/mach-apple/memmap
> - added Mark's Acked-by
> - Link to v1: https://patch.msgid.link/20261010-apple-t603x-support-v1-0-ca529f301a62@jannau.net
> 
> ---
> Janne Grunau (4):
>       doc: apple: Add Apple M3 as supported SoC
>       arm: apple: Move memory maps to separate files
>       arm: apple: Add Apple M3 Pro and Max (t603[014]) support
>       arm: apple: Add Apple M3 Ultra (t6032) support
> 
>  arch/arm/mach-apple/board.c        | 747 +------------------------------------
>  arch/arm/mach-apple/memmap/t6000.h | 104 ++++++
>  arch/arm/mach-apple/memmap/t6002.h | 177 +++++++++
>  arch/arm/mach-apple/memmap/t6020.h | 128 +++++++
>  arch/arm/mach-apple/memmap/t6022.h | 225 +++++++++++
>  arch/arm/mach-apple/memmap/t6030.h | 104 ++++++
>  arch/arm/mach-apple/memmap/t6032.h | 136 +++++++
>  arch/arm/mach-apple/memmap/t8103.h |  80 ++++
>  arch/arm/mach-apple/memmap/t8122.h |  88 +++++
>  doc/board/apple/m1.rst             |  14 +-
>  10 files changed, 1068 insertions(+), 735 deletions(-)
> ---
> base-commit: 5508406582f6f7120dce0c4b3059819a41788db2
> change-id: 20260907-apple-t603x-support-9e77ba0bf855
> 
> Best regards,
> -- 
> Janne Grunau <j@jannau.net>
> 
> 
