Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E12D2CA6019
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 10:29:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9730D81112;
	Fri,  9 Oct 2026 10:29:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5dRJ1xBAWvU8; Fri,  9 Oct 2026 10:29:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BF8E4810F9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791541786;
	b=qGxrVIrbCOoEfTZXypISm5Kes3P48sMFAqsc9uNz6M8iWrkYi/nDi9qK7UyikuJNdJ5H
	 HgYaU8c7jlhVDIQY0YZSMaGjC71LgFDZqQQ8k9hIJ+vimUqxsu0zE3i0cdWfW80Jl/1KE
	 EjaOGzS9QFqwD1VJmZRiCL2mKDhyvhIHDiyZZq0Qu5OCnRpon2zxPoyF3EoH/IjPu3zrg
	 65S+coA9FPbEX/P5tCn/egu/khXUjzBB1ttrzYdvjMNJ65RqxGs71nMAmCeas3ePo96zK
	 Am7zXhL+M4I30AaPRZ3lxIR0phGn/wKB4PhJyNhxkLJd+Vy/Fsiq7GSpiAFW74946IQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791541786;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:Cc:From:To:Subject:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=joOo9F/voXdiQRhlFJkmJaqwqGlSQdsuHIv+/Q7+hGw=;
	b=gvIidhyaVrGIIEZQg83aXnW25Zi/FBJDudQKL63DJ6q7wwxxjIoLPyfNoqm7Yam+CR7i
	 4Yf8PELiu9I+6X0nPiEy1VuT+bUlv8aTNPYnRYPnHpF7T4m+3qfgat3Gxnx+vPx/6chdB
	 BPpbvjAZfjU8wrDvHxeLHQ1CJUc/35zi5QSn2pwd+ABxPckzVCyYD1h888ICnLzzS4tBX
	 XHUGxVZJBzFAu+vjaipJP25oOJXxKNvLSd0WY1sRd4g+3s2SX+jLApvZSJlw6cxfGoppd
	 XF+fy+fLjPwU0B6sFrAB4UvQdXslSD9VnKDX2d3gIpuxxWdt++aMKER5+E6AyjadbmA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791541786;
	bh=joOo9F/voXdiQRhlFJkmJaqwqGlSQdsuHIv+/Q7+hGw=;
	h=Date:Cc:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PwAUPPDYM968fNP5OLgUaWN1HiLJJFOhes6YaWx9BgSCWwUn4sv32Eb6mBXGrBG15
	 J/2oD11uyiv9MLCkL+pOBcCkACMvHXqMflT/VRKBkAih4FlIHUsc3XsqTOE4EVXEfE
	 pTxbZeMG8+JPvt1nXqyDYI2GVUQRwlrwC7iWUlG5cPlNbxs14bwHrDq1PbSMUJNzCP
	 02yQmUQUynoGw/AD7NpubVH39iDuhDzw6GbcK6R1rNMpaoICDUg7YoDZA84v8rBXzk
	 6to6gkYnqto4T0LxgLZKGiDokYT8rm45YMXfj9S+j8VA44bM/lGIQ84KiUXv/ZjptL
	 8CKLtuRonTXpg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BF8E4810F9;
	Fri,  9 Oct 2026 10:29:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5C41875
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 10:29:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4E0EA40061
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 10:29:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QPnBZ_Xx7AYw for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 10:29:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 61942400B7
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791541784;
 b=XOgKinxJtlI8DxqJAKpJzzRPZvs+got43CIvIWHPSHAqID2PiKY6QcIeBp5s8k+HMjL9
 vswhGuK4gkH4hiT5S2+pJpQbSv5pTUB5SNUD9vDs8kFqvd1Z5pAkfY4q1lKyEj9j+m1AX
 TcKkl5QQmJp/pqLJwPy3YC6z6uJZWro2rEndx5vsn0mcMBJc5MIQOVsDT1sjFPV8QTr0C
 sk7PiVKFdoKjXhwZWYVFUIJQTiX5QqXGGwTUCMSkfYjYiOv8a3+zVqVZ/SqCyqxSSGE71
 72mDepXiDXXVkEsPB2UlXo2AoQ5+pAl+oPeA65XknvZdG+prekrEcrECPK8Ck6ctuMA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791541784;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Content-Language:Cc:From:To:Subject:Content-Type:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=joOo9F/voXdiQRhlFJkmJaqwqGlSQdsuHIv+/Q7+hGw=;
 b=mpWUv4imd84eh2Qnn9mwiZJBwSIFp0WS73KiYO/S/2u8igjj9E1pMe0xUp3LPZ6qvKky
 zoAantb6iJRL2yiAzuEskScU1UUQQcPFDcnnIiCCehf3pm+tgm9pTsK73GNa8862B/8B4
 iqXLCLGo6de7Siy8pSowmvB+8umJuyWbXAcismmqjzBqqptT+tfl8m+xdqg/e+36O/qrD
 JiwTmGZVObsQMKy7ntY9ixfZdj1v6TNk2CfMmGJrQ2NfEC91InLpM3ZzValhMxZt3VhXi
 QDm22I5IsnFJt9E2XZDc4Bdg/46kWM1b2fm5e0L3lk/rzffc+G+IJUe8N8ZAlYalWTw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=VcLlzzw6; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com
 header.a=rsa-sha256 header.s=dkim header.b=VcLlzzw6
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 61942400B7
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 10:29:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 12DB0105BB9; Fri, 09 Oct 2026 12:29:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1791541778;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language;
 bh=joOo9F/voXdiQRhlFJkmJaqwqGlSQdsuHIv+/Q7+hGw=;
 b=VcLlzzw6IQySidhxB4/Xehyd0R9HWDbSayRdVgDtglPi+Aqki9JGdEgj2qqwHYURAnQxXo
 4HkxBK1GULdGw/zLsRFaDff6ibGQcPeUnOlRM7eilQcP96m1lV94GaPGLKr/dWMAYUq+hd
 5Il0jw04c1tRLstFrmZSuRgLInm/oUfQyfDR0kGnWjwnb5U4OWADZQsw1qfqhiQ5Kev1Vr
 KfCfLmvA0Tym91iUcXfWORAlTeAxU6MrmarLteC/aBGOeG/7bFQYvE4IKFx5iyjcYKw5dQ
 758SvxLKT4BZHdINY1+jRaJyeJ5VrwxxgOh4tJTrv65AaOKlul40OWXoDraFvw==
Message-ID: <ad089161-edf5-4439-401f-620830429ab4@nabladev.com>
Date: Fri, 9 Oct 2026 12:28:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Jim Liu <jim.t90615@gmail.com>
From: Heiko Schocher <hs@nabladev.com>
To: Tom Rini <trini@konsulko.com>
Subject: Please pull u-boot-i2c
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Tom,

please pull from u-boot-i2c

The following changes since commit 0a55b098d6f5f6bafa84fc2f18b433dd167bf729:

   Merge patch series "rng: airoha: add support for the Airoha TRNG" (2026-10-08 10:41:43 -0600)

are available in the Git repository at:

   https://git.u-boot-project.org/u-boot/custodians/hs/u-boot-i2c.git 
tags/i2c-updates-for-u-boot-i2c-main-20261009

for you to fetch changes up to c5da315042792c79177981cb62557e2c404df163:

   i2c: npcm: Add deblock callback for bus recovery (2026-10-09 07:47:02 +0200)

----------------------------------------------------------------
i2c updates for u-boot-i2c-main-20261009

- i2c: npcm: Add segment feature for bus select
   from Jim

- i2c: npcm: Add deblock callback for bus recovery
   from Stanley

----------------------------------------------------------------
Jim Liu (1):
       i2c: npcm: Add segment feature for bus select

Stanley Chu (1):
       i2c: npcm: Add deblock callback for bus recovery

  drivers/i2c/npcm_i2c.c | 29 ++++++++++++++++++++++++++---
  1 file changed, 26 insertions(+), 3 deletions(-)

Azure build is fine:
https://dev.azure.com/hs0298/hs/_build/results?buildId=219&view=results

Thanks!

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
