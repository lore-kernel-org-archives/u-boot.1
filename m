Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C03606A31B
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 09:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=T2DF0051;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=QZag2gxT;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=wpp3rXoj
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C3C0580DDC;
	Mon, 26 Oct 2026 09:25:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zdm-iSULSr4a; Mon, 26 Oct 2026 09:25:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D952980DB2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793006733;
	b=XKqHNpNw7qcV/i9sHVJM/4KMvPufmukX7hRZYkBkA1Ontk/Z+o08qWtQQ5h49u+ZgEr4
	 rIYGNDZhUWxtw5EiVb6RYV6V55Jn6QV/kXhoEY/b7BozfIqnHnlzr0ijf1ZHUnRdmYe6i
	 AsiJgR9EShHIv1CAHPKgNiKnnqMWRnLXJZmH3dHT5AHSn9NhOSFQfhkTcLPdETsPyvApD
	 o1p3u26dkmkKCPg40ZGNbWVa8JIrh1m632VJjXoL6RPXxHbSpdRB5yq4+riu4zQBw/pL/
	 nwwdv/tDNoANdr6/CLtERgY/xFouxJ4uCs9ELdZOCK8mCZ+s9riNZJM4cC+ByA10mVQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793006733;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=oSr9BVTQt5Wi06J/b812U1L1PhmntDLTWbGQ9FPqeGc=;
	b=A2w/SWHI06ok1f8KEUkKPyDWl8ZtKfSGZxSvxO4JEbjBQG9B6dFlcCVnoUXP0Ycspq8c
	 WYFrcWR8gxVAUsxXm7TE9wS5ag0ejxjZ+7zGCBSTraMa4newLwdMrQvoS2t0if8hyvQTe
	 +CLUF5bA10P8rzMlBJtdb1UYDMqyXVsQ8cnT1X2SToeumLuDoOfe9s0Mmhua3LQz1ZDXQ
	 tuzP6VfjTttl/Yd5sUnDlWJSlWpteptb0ie8bCsRug31Bf9QnnWuodeY//JkbIuoX7Z9p
	 EB7QmRXs07aeJYasEtKVuIP+3YczydLArjC6Kj81who70NjAKfRoOOmBfK9BgkXzlqw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793006733;
	bh=oSr9BVTQt5Wi06J/b812U1L1PhmntDLTWbGQ9FPqeGc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T2DF0051ZRycPJy1F+safyiAP5oMJ/MslCRMpXfnVRvREmlq/Qx3yeUcwl3tkQ7YS
	 32AecXc8fYo4b1iqPJtNtLhKN9f7+VajDNiXgua+7DuZ5gaDKJU6tgPgW7kPGeTPpu
	 NXUj0Thjw++P1bvmA4u7FSKGyvZ1JjNIFB9siFEQDmXke+Q+6WVyU+VgXDUlYYiOvi
	 aBSn/w2b/i6T89V6G4YpNmFQg3OS37WO6GiOJRRShDuhMSr8N6jclJqxDXjWPDPim+
	 1Z6Lfn/L9WAIFqtkhwUC6O8gDeeXg+1mDywQZfzRW+WvQnOSOz3C8i0mAPWcRRJ/XY
	 A8+rjzQ10Efug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D952980DB2;
	Mon, 26 Oct 2026 09:25:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C246D356
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:25:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A8328405EE
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:25:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dy0myn_Tzp9z for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 09:25:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 51CB9405CF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793006731;
 b=fRMuqZE7E+hP+/Bf2LIXFzGwH40cVcj3pAQQMIlpOtLF5ALRQwx3NjexgHfhK8mDCnmO
 cg/l3q3qYwb3lfFH774zuCJ1n4GheR61RadtbBH36Iv7x8QfJ/BR2gnpKKQUOh+8DsnzM
 DKMY/YGbniD4BcT4DqPRo/mIQ4dELD3P31kl8c/4YziPwq55HYZAmfkcVlhpfEk71mQ0f
 Rw6mpSS6IcvJZSKRBDSXGXoGSMrpBnpM04Q7FAuOiSzakML3w6xAoETBzSIXiW/Of4raI
 JL9eFVNI0WZiy7/YTnG7X8u4r/9kFhzV84P+Yp3ZbvG/3L1HB8JGC96RcyNvGbMWkNg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793006731;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
 In-Reply-To:References:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=oSr9BVTQt5Wi06J/b812U1L1PhmntDLTWbGQ9FPqeGc=;
 b=KK87+RAbzln1g2bOzjNXJsj7zWsKjYsHSXmkCKzCfI1JIzCTVWo7nQJY0ZvJqGfPtmSu
 XqUvPwvCN4/6VzlVN8fq7h0vuGlFwjdGFbSyGoQuyDEmCnyTzA5qLGLpPFSsycWtR0JJO
 Twg5/LWSjxD1yyZOqii1400ZmMJ3Pebg99zvCwI3Qr+AQWVmjSH/kHVqtbMVSQ26bBV01
 EoPKNqDtK3qUsUrABzyoGJ/NNAqls+Uv9qCnnA7+PyR28R3vCei0rZSgvhVZrL82zSck0
 vNtbRauAK/YnWttvrebz/1oq+UC168aIHHeqFeIGpeM539AG0Zb3A6gRWN4ZDjGJAkg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=QZag2gxT; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=wpp3rXoj; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mainlining.org
 header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r
 header.b=QZag2gxT; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=wpp3rXoj
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 51CB9405CF
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1793006724; bh=oSr9BVTQt5Wi06J/b812U1L
 1PhmntDLTWbGQ9FPqeGc=; b=QZag2gxTsGFY76S7mZIQ14unPhKSCCd2078Hu/kiPff29GL/DS
 dSY//c8O12x7ZZxVVeGl+z9tIl+plk/GS5crfL1wpB3JfZnFMKi4Nxrg3B0UW4NeUcoBPYQVagU
 sk/jOf+Lsyho0YVQPbu03zdVVnVuKdpzAZojSephYVKhxrsUiQzCXARo3zxXPxNR/5u+b0lzJIO
 PDaymG6LP5WSYb1pbk0hZ1m8QTJqsikjY0tcvhD4Rf/cRZ1lCKLhAbpAD/3JEipxYp00y8TcHcZ
 RIzjVL4gYPU4f+9AgE/dwql3BBkO8zhunOQBX9YntitOteglCSc21EmJvUjtTO/cA+A==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1793006724; bh=oSr9BVTQt5Wi06J/b812U1L
 1PhmntDLTWbGQ9FPqeGc=; b=wpp3rXoj3+Aa23TCzzzwPzRGzNdg9UoQUvhBS7d8nz7I+SaUm9
 tlg3Zef12TTTKA2wRbIgHspvtb/u33HHtTAQ==;
Date: Mon, 26 Oct 2026 09:25:25 +0000
From: Bradley Morgan <brads@mainlining.org>
To: Vincent Jardin <vjardin@free.fr>, Peng Fan <peng.fan@oss.nxp.com>
CC: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Sinan Akman <sinan@writeme.com>, Bryan Brattlof <bb@ti.com>,
 Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
Subject: Re: [GIT PULL] Please pull fsl-qoriq-for-2027-01-rc1
In-Reply-To: <at8StA3lzLMDbcrR@L30177.local>
References: <atm8jabAOY-wLeaB@nxa18884-linux-1.ap.freescale.net>
 <C7012F65-D275-4D2D-AE1A-9340A5171FB9@mainlining.org>
 <at8StA3lzLMDbcrR@L30177.local>
Message-ID: <6C364E68-4927-470F-BEEE-1F9AFF3FDCD0@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 26 October 2026 08:43:32 GMT, Vincent Jardin <vjardin@free.fr> wrote:
>Hi Peng,
>
>Thank you for applying the the lx2160a series and the other patches.
>
>If the powerpc removals need more time after Sinan's remark and Tom's
>request to wait for the board maintainers:
>  https://lore.kernel.org/u-boot/20261022014554.GN3275858@bill-the-cat/
>would a pull limited to the first 20 commits be an option for rc1 ?
>They are below Bradley's series, up to the commit
>e7fbf8d2233 ("board: nbxv3: apply sd1 hwconfig before MC starts")
>so the SCMI, fsl_espi, pmbus, ICID and SerDes patches would not change.

Tom reckoned that today would be his merge day on IRC, but things could
change, I feel these board maintainers are deliberately not responding
tho.:(

>
>Whatever you prefer is fine with me, I only want to make sure the
>question is asked before rc1 and we do not miss the merge window.
>
>Thank you,
>  Vincent

--- Thanks!
