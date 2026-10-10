Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C668CA9EC3
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 13:14:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 85F2460631;
	Sat, 10 Oct 2026 13:14:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fwDXmCgtNInh; Sat, 10 Oct 2026 13:14:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9C1C560603
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791638087;
	b=gml9zArzh4KW0Vn2cJiWvLagPeDw/DJaczwXKUjiWo+3hlZkcTuct8KL4ivlfUl6Jb+y
	 nP7OsXz1u2O09J973WqFk61Fqow4UXYpnztwhnLaLa+25f0BH/f+Dy4FMt6iIRlUP8nDj
	 fEm7FV7aPvjieaNpcnkD6SEZQjG0fhyUa1bIjqoXP8AuWY3niUQZNs4RJlEjpL2gYC4A0
	 sMfbd73uM4QKkcMxHxkQNfgytCqVnlD5x8x+6RMwKxzvYW5nonOaiUiMUyU3wWhnZf+gb
	 DR+EL6XPeQN5zRi66fkmmxldw8VfgiVZY64wy2B5LgLNyJINK+ET4HHO9zL+m8B5rHA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791638087;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:Feedback-ID:
	 X-Pm-Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/wZhSia1fY1tkk6XkxRbV+hMiczPt6ll/6t/wVH0QKo=;
	b=odS31kOrdRXySRrXfJu95f3Dv08rtvaG7Qr2tNqTXn0Zksjx7asvoxiXcTvrqNnqAhSK
	 KSSr/akV4Arh2NtZD1366vpY3DcYqx8rClbSY/pkfN2Zk/RB8TT28W+uMMOhE1lm+znnl
	 tCFrnUtQd3GTjVl9y+mdpU9NmFbX3u/328v42Uj2fK/BqCrpKtkoZA3ZiR+BIdGKjeQjD
	 477siDZ7cfyQOQYD/yhyLGFPQO9q3PXnQDufKtLfCasgvGObhZ79ukGraaz8t2ih7rvnZ
	 FxMoWvoBve6cCm3MYIeq9iEYGqd+bhrBftp3fxbku2LWJa9eK4HE2Mprv5ul+nk5VLQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791638087;
	bh=/wZhSia1fY1tkk6XkxRbV+hMiczPt6ll/6t/wVH0QKo=;
	h=Date:To:From:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RxphxP4UKpEaGr5Ie03i5FAcueTMSie7gOndA12JonVp3S3eRzNYaoPvOfaHHGbME
	 T841Vz9yHBq0Mr7UTZN+XbUUciNCMSw905AD1tbc9YfAV7RolM5YelJP4mX1/oVAsB
	 tzScHnZ6SK1jSjlCXIfkx6ZduM4CLbzrorCY+tzK5xEZlwEaePDAdSw5Z9mVDaz+fV
	 L5rGyXMWa+dE60r+6q6x+fCzP5WzPgylqlvJdsXZA1HOzPIPk74iRox0CiLSapvsaM
	 3dF15WR4XVMeXeLYCXI2NxPZaGXjbMBGc6Hm6V/sD8FmXgZyHNphYN56pBGgWPAvEN
	 kiKZ52ycixxNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9C1C560603;
	Sat, 10 Oct 2026 13:14:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D8B0075
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 09:08:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BC927400CC
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 09:08:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V-4rKkfKslNo for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 09:08:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 955A140004
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=85.9.210.45
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791623284;
 b=EWOc7TIxEiEB+PLspx01M/dpVsOoqN7YrncoL8BxdYX4ADkyhJQA4YV0xhKEikUUGLlo
 tk3TFB7GgSuwPUWB3bz9fJs4Rq1YbJo3vM6ROhlIEApLsvlDKVMuHKS+Gqhk18Bao3Djt
 M/CoJyZsmVCDY6Ko2enDjtb5exnrPYHT74CaDWLiaoDuCVHFjbNfqyI9wKO7AIlP2yCJb
 hnLDVKUZ3AYxLD0JH3kNERjR8HcadeQv5vvQ6f+Zibe5oj0qxsmtr/wrXgXvPS2F3Kwna
 iCHYCPMU20B7GGAi5V5iEyOQghy/AllmeJVnS/MSRlv16FwTwtpnrMReTYTVhAQEedg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791623284;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=/wZhSia1fY1tkk6XkxRbV+hMiczPt6ll/6t/wVH0QKo=;
 b=HcjmBvDzBREGnXmpmv/XEkcjCHbfsAK+ffs1fRAzrSaxLtZg6EqdHDu+/5DEJrfJMnCo
 9jCMhK6A1JsBmP17bhnM6cUkNEdLhTuC1i+pDYtJvUEKoxwnjVCMgozQNUrUjj2Nxx+n/
 MduaHt7/AyjMGCf0mBmWxqH6o+TFSYXhdJy+hU1sEdkbLyCZO33Uq3bFBqW4nY//Tcm7U
 b++YMSnQDwmSRiZDejbKe0FC6sNEHVf9J4ZvvBjaWDMZKRScWnXHy+0ZEqrmCpzGqV/L/
 PsvgLMtAuqUbmCOh68B2DqSQ3EXctNPgY13OTzAKxQMldivf/ku7IMQX9WuyepqYC6g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=pm.me;
 dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256
 header.s=protonmail3 header.b=cTo7vVbP; 
 arc=none smtp.remote-ip=85.9.210.45
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=85.9.210.45;
 helo=mail-06.mail-europe.com; envelope-from=mcpratt@pm.me; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=pm.me header.i=@pm.me header.a=rsa-sha256
 header.s=protonmail3 header.b=cTo7vVbP
Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 955A140004
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 09:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1791623275; x=1791882475;
 bh=/wZhSia1fY1tkk6XkxRbV+hMiczPt6ll/6t/wVH0QKo=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=cTo7vVbPS3qRR9mh0XWEO0plpVwapWRbH0tpgWt5xXPvRicLelXN1wWgXbkEUOqKs
 IkoH5UB99wprpMto+dO1HFB3ee4Vh87oiDx2wchCVNC0XpwbSnEf8k/VJ8O/dWdl/W
 B5drcZTqmlb8JaKI7Q0AQtTbYj/6ivSrREF7z0A8z6gaX5edVL9czZg+4T96+darJu
 Nto4X2BDxP8huUBiO/NJUpyQVxR67zmFXJakC2PNNhId0FLZpovpk61CeUGD4AxmUZ
 VlIgX18hRIvBnZCyi89qLJtK5GvDP+zwZky5GD6wUxbzWlCW67qwM+BTGCMbYGogXZ
 HEBdYxm65Ajyg==
Date: Sat, 10 Oct 2026 09:07:51 +0000
To: u-boot@lists.u-boot-project.org
From: Michael Pratt <mcpratt@pm.me>
Cc: trini@konsulko.com
Subject: Downloads of latest version and RCs are missing from ftp server and
 mirrors
Message-ID: <CLfytip-colyUOPhc3sBqUDEz8ZvN5khfJZr8p_mbfHvbe4fWk4JDYQk6Nj4ZjjD1wDbeFldMUbcI16zcLHK4u_Z6ej6LkT3V8Hq4WIrV7k=@pm.me>
Feedback-ID: 27397442:user:proton
X-Pm-Message-ID: 5170b63f60fc690ac41ec3006c7a6ca49683804a
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 10 Oct 2026 13:14:42 +0000
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

I see where the website directs you for downloads,
but historically we have used the older mirrors.
I'm mentioning this just in case you're unaware.

https://ftp.denx.de/pub/u-boot only goes up to 2026.07
