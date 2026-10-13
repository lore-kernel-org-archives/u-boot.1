Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA269CC6B09
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 05:47:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CF35B404A1;
	Tue, 13 Oct 2026 05:47:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zkZ5Vp80jTCX; Tue, 13 Oct 2026 05:47:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D5E2040467
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791870463;
	b=J9JQ8SDgsdJQuX3dNpzKs5gW/R5ytVrotldhGCCJapf3WQW9+wZx+H3Nx+wi1es9HgeU
	 EHZ9AkRYr18KtnOYtIoHTi/3omGdQTi0Ha65yUtesS5ewtsFiatbvCGVNnzVHkTsoT/Kr
	 okJYQWSyKsB5gya/AdM/oEuqXrp8tGPyx9gMoibhpAfQMQRdsOJu2aKKrqaSgJicgeadA
	 89LoLLYzf590Z2YZj/06e+t4XNi7l6KjyIwaHo+YlX9SNJv1iM0+9nEh2SpkBXcNRowMF
	 t52t8KCJ2UqrvvQXVYc+5sIuAUZM2yrVZw1MiJkN+gT3+zYS+drtTYtWX2kgxn/LFLA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791870463;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fUa3I7AsppcZM5kfqx3s516DsOTbVvQwIPJ6H/LZhdM=;
	b=C3+vqk0zgTjfnK8Yg9KzcjeF3dQbPkGJ1uZAaIg3snNyxYjloNTGDpotX9tlZSz29CM7
	 YWtjrnKqg+IghtmzduuXeXuYgK5msyE3WUz+T8Q4kp8jZExUwI3sst+MF182EGj6xuCxR
	 2dAN4DtOvtiaFozCQlMiwcTwERheoq5A8f3dBgELPBVZ56V+VzQnEJA7KuxyUNX910sJO
	 b1iWj4E1VtE9x9JXUOvQbFadPnTZksHStk+xDbIZjGSJmeZ5wg0Ut8ICBWZuqmsU6yMt7
	 Qu8L7iOM3ZDFwxvhfkLH8fZhEMElY/s9gQTzNJFs3SSpQXNGWbu/VDob1Hl+Jqs1Npg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791870463;
	bh=fUa3I7AsppcZM5kfqx3s516DsOTbVvQwIPJ6H/LZhdM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LCSK7dozAaHLexW8v1udWAZqTGqgfSgqPc/AaSOO9OUUyhHRxRl0YlI5NMLMGif/R
	 UzNde95GoeCeCHuR//YBWMkVn7FxLf2U6bSHStTd6Px/SdEGD08OpONI5lCGvS/kqq
	 56ec/ltf9BTi3Ug3TnstyKlJjh6nhCyVNS/aHUigSTw6kV23Sbqnp04YaURkGHZdJ/
	 BhQloKTZcF52je/zGrv9BdiLkrnj+EX4Jpr5lr14uyvO74Nx9hwA6ycKK6S74EiJ2u
	 s3M3szWDg4ocx26BgWhNHcqipG2Z6wIUt9bYAkUfZPAzeY2z07+IKg2SyEOcQJ3I5a
	 +SOkH2oKcwHTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D5E2040467;
	Tue, 13 Oct 2026 05:47:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5A25B4DD
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:45:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3FE0F60660
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:45:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XHjfWmv5g72D for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 01:45:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7C9F56060E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=150.107.74.76
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791855944;
 b=aCgyEdh6OsqSwRXqNeX4YrWjJJ5hc2oniDIUpYyzbsR2OycRoY0A15MDUGxWqCQh7Kg5
 c6ao5BA5OgKcIABrucG9XkqGoQyShVnH2rt0Q7Hy4Us194PnJsedrU5zRp9A7d0QSMvbQ
 n5KIWt3lQdR5xZqWfUabgCcyXcI3eZ2WfcDVAUNvHOCtOFAsaZm9qqhM4Yz+tMhs+IJV6
 8MlF5JV0Q2j3V/pepNJxR1s7J4DKZLBftYRronGZaWrnLWXVHjIusQ3n1ihdPzN9vTN7E
 163ZrTTejPEuHfZ+4ReTA5dbF8VWOaNYhPfRvwfg+6leRAguz7rnCr17LI1unxe36oQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791855944;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
 User-Agent:MIME-Version;
 bh=fUa3I7AsppcZM5kfqx3s516DsOTbVvQwIPJ6H/LZhdM=;
 b=oBGL+oBZKTJ2ZFDsdObTpMozR5lUJrnc0I2BHIEM2eVbqYtUJagpCqeS7XV9yCLgMuA2
 jtH+CMkhJF3PlBUCJ30/4Eak1GhJmF+Y3BkAzXpzhOui8YDNlKCaVioDOW0cxCoZs8x8B
 8kjvirv00GtRb5Jv8ROFwCBcZhRq0cmqxibNA0AGUQkjhx76p0zqITOZ8Ml6xmpG02bFb
 +PKLmone/fYoU2Qc5KUtYOvaQki9bg8HAom5qGipTgqo/nr1dBdfdEh/bNT0mvD39RnmK
 EQZGVghFGPskELnPJJu27nX967YwM+WEfKvhqLQqAPtW0OIPvPUHKD5GBPJCx2I5OpA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=ozlabs.org;
 dkim=pass header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256
 header.s=201707 header.b="R+i/CEK7"; 
 arc=none smtp.remote-ip=150.107.74.76
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=150.107.74.76;
 helo=mail.ozlabs.org; envelope-from=jk@ozlabs.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256
 header.s=201707 header.b=R+i/CEK7
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7C9F56060E
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
 s=201707; t=1791855932;
 bh=fUa3I7AsppcZM5kfqx3s516DsOTbVvQwIPJ6H/LZhdM=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=R+i/CEK7PHoANirRWCIV6kUI68uau0pAgBjzsI3IZnhSRDM62RmIBr32IsnC7BDnk
 AZNIgxBg6GvM/ZTuHt91SYXEgq3S1Pe86AY/KuYmsMqOhEXQPJdU5qlnPaMRbTGy4a
 k/3ohdDGxRmXcYxLhev2S57/AIrxLIzVHCJnyXu7DbfIYbB9ATN99wKJyjWGhvfJmF
 R5FLlsIigvHXjidCrH6GZRTxsGhoWuRZJHGSQuYmK/1rGWEgpMSkcEb5Zr2Thfc0Vh
 /aoU1rQju0UQZiVDkQlLGvjLNBA/MtJK0lSVne5d8R7n8YM0iUmCvrT+IHmZOr70aD
 SQvB8s2LcivEw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4j3cbv1mLbz4wC6;
 Tue, 13 Oct 2026 12:45:31 +1100 (AEDT)
Message-ID: <70015ae721f4d748215cfc8c6a3d1d14f53f77d0.camel@ozlabs.org>
Subject: Re: patchwork.ozlabs.org: slow responses and timeouts
From: Jeremy Kerr <jk@ozlabs.org>
To: Franciszek Stachura <fbstachura@gmail.com>, Mehmet Fide
 <mehmet.fide@gmail.com>
Cc: patchwork@lists.ozlabs.org, mehmet.fide@screeningeagle.com, 
 u-boot@lists.u-boot-project.org, trini@konsulko.com
Date: Tue, 13 Oct 2026 09:45:27 +0800
In-Reply-To: <DM2SNLYM1TQ3.2SV5RUIU69EYI@gmail.com>
References: <20261007115918.2553308-1-mehmet.fide@gmail.com>
 <1f5fb33c5e9009ee4cb521ca3ac6168301841da3.camel@ozlabs.org>
 <DM2SNLYM1TQ3.2SV5RUIU69EYI@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 13 Oct 2026 05:47:40 +0000
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

Hi Franek,

> In August I posted a series of patches meant to optimize queries
> generated when someone browses the list of patches.
> See:
> https://lists.ozlabs.org/pipermail/patchwork/2026-August/007520.html
> While it won't solve the problem entirely (anubis is necessary),
> maybe it could help reduce load on the servers?

The load from queries is not substantial - it's more that we're getting
large amounts of connections, in bursts, hitting httpd connection
limits:

  Scoreboard: RRRRRRRRRRRRR_RW_RRRRRRRRRRRRRRRRRRRRRRRRRRRR_RRRRRRRRRRRRRRR=
RRRR
  _RRRRRRRRRRRRRRRRRWRRRRRRRRR_RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR_RRRRRRRRRR=
RRRR
  RRRRRRRR_RRRRRRRRRRRRRRRR_RRRRRRRRRRRRRRRRRRRR_RRRRRRRRRRRRRRRRRRRRRRRRRR=
RRRR
  RRR_RRRRRRRRR_RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR_R_RRWRRRRRRRRRR_R=
RRRR
  R_RRRRRRRRRRRRRR_RRRRRRRRRRRRRRRR_RRRRRR_RRRR_RRRRRRRRRR_R_RRRRRRRRRRRRRR=
RRRR
  RRRRRRRRRRRRRRRRRRRRRRRRRRR

Just now, we had a burst of ~680 TCP connections from a tencent range, that
only resulted in three valid requests.

So I'm looking at front-end config at the moment, rather than patchwork
changes.

Thanks for the options though! I will eventually get the patchwork version
updated, once we have the load issues sorted.

Cheers,


Jeremy
