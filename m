Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F43CA5FA5
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 01:51:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D3FDF81177;
	Wed, 30 Sep 2026 01:51:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s-KF9sl8w07W; Wed, 30 Sep 2026 01:51:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 852BF8116A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790733110;
	b=SlBX2QOPiTqzib/2S+ZDvymnpXgKyotmIJjAkQV4gYQW7sSjqEMeE6cnEW45OM6MAScM
	 RYCm8FeYd/SONycSKlfu+qoHbpmp4S9wU3E97hGKkEK0PkQarLbRr/u28tuA/RlLEmuB7
	 pg45Oh71sDDkGglHfaBDkgT9+AztfFXBq3q3EfZ+Shdjo7wME3id5oSeJ5FZRvvS2x7Lk
	 Obm43TR39mtxMvEFbah+r/Ht/SCrRMIV5S6+618WZDjgFBYtnmh4S8u8EwQYmjcMcxYok
	 Y2fblee9I+KPhpgbVA42jd/eAj+4PmY9rZSnz912RQQrNpopcKvLl9ioxjfrPRX2Nlg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790733110;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ahQtXOMcX/gyaDzQadA8KE9VdrYwDQTEFhQOj+l4aDI=;
	b=bMcdwj32pYGziM9DgyywIsZkVftsdtu98gnYEYhycH8Nclx6AplDyV0ZAvO4qJEIrCfx
	 IAab/E4qDZxZgcf33rquApC687ZT1L7N6e691zuI7bFb8z2LOTWBmqjcjBhW6ShsI+5kS
	 x4QVznn2j44Hsn+h+GlEIkl3DJAJwarggkfXRbOfHrDYTT18g5uT6qcQYXbNNGDozsXAb
	 TYMSC1iDcajDw0jV3Vl7YzUOta0SopoJ9YOfZIVfE76cbTNJiC99EmXUX7QMTXCv0tiQA
	 +Yx1LDUJqgv6D2HfFqH5m+j5WbSLfccKcI3hLMcmX2fbGOBmVTDXpa9joByr91j4RnA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790733110;
	bh=ahQtXOMcX/gyaDzQadA8KE9VdrYwDQTEFhQOj+l4aDI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JXO62sjHQXMM0kIEcuJlprwkxRXpOBWHGG0Gp8MbHhcBWwpoWZ1DXO89v4nBBjbuQ
	 J0+QV3/F4FxLWMxv8Q0hiq113HlCa015/PvxJyAX8cNDN0qJ/E+0R0Q1TJhPI42NJ7
	 SMsIPS7CUUSW29H5PywITEI/BdSSq1vUyI00uM4iKYxR9B1yGAEu0IPGHdOZDsnQp9
	 Q8flNemzpf2S0ousT9ELxc+Wt+vbB1YxVRBvK/zCYZqykLOJEv6b8f1MAttGv2AEu0
	 TAWoMu4raiwOEuAfI6Hhe4nhNtwPSPfvS13Jv2Qdl47tLJHbJa8F7Vl4a9i3ZpdIWB
	 wxxrXpj6QFN9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 852BF8116A;
	Wed, 30 Sep 2026 01:51:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id CDAE3282
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 01:51:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CB5DB40098
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 01:51:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6wktFZlnihKl for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 01:51:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 56086400AE
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790733107;
 b=NrMat1ZmYjeQDGDiBXrFMB0qAvY+G843xVTa9QJxSYc5WQ/ckt6FvNq66k+8dapOYyMt
 4NS9rDZM/pCEpwZQLBC3xU9k1eDoZNDxWgXMNi9SmwIUW7/boVUa0eqxrCWCmjgR/RwNS
 JBD1DTV56fhzLzIFZIGQczBmFuF83aEfgRlt4lmF7SDqXW86mw4VtqkA0ltzAN8vPiour
 QYG7KhJQBQeR23/JWBIMOn4w7i4l6J5XSUdjz1mzf2wumVCSL66ZcIo+Clqg6LQ3DNeWy
 UCwKwPavco/19zCZ2YcdS6xJO0TfeS29UZTgUY1ynUzd+5zo0roIHV8hqo8qxlPVjnw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790733107;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=ahQtXOMcX/gyaDzQadA8KE9VdrYwDQTEFhQOj+l4aDI=;
 b=lqMNNaKZJA1D6M2lOS4zGTm9ggrdLOHR5yKSvfmNdFRaoKLsBkzEkrc75XT2VzBy9uRP
 9o3uUCOjb4oza4qExbwzEgutXp/7+IzDx4iq8eqomSdv3RPYMlmfgMjbOj8l7kq6a0AkF
 IlJgAEra2Om9vXQTgRnzxug2EsXEIxrPTzaXsptH5DjKp9Hgg7NhGP6+kIof9Bbo1mUc4
 dp/i68PlTc4uk+AW36gXfCUFKzEPrN/5ML8UbFslOPpz6fV2GZ2kpejkjQ7od0fIS3q5F
 vWsLmMzDllbbJzbLBlY9BgEOUUcTFKoc6ETjOI+I2c6vP5qz1bGPc3fwJ/l8iSfffUg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=freeshell.de; 
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=jMzIwxYD; 
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=jMzIwxYD
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 56086400AE
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 01:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1790733098;
 bh=ahQtXOMcX/gyaDzQadA8KE9VdrYwDQTEFhQOj+l4aDI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=jMzIwxYDxKO5TGrKl+fY896Xj++qWhFpQqNmr7rP5etvuN3bpSmcD14IibxRgBPHY
 6Be/vfFKhFXZ8II1JrXyk+X7dZN4O9pKmUMrxaiUAadeCnv7tfD/yvQPEr1uUu1XlN
 OtALe82/zL2mkdAkRksD6Llwii2t+G9McAG8d1L1gSD53Mta0+0N5wcQ5QgDROmF9v
 FrJa1qbcJ12UBoXebYrANLxX7apCJc0t/+UNmr/qZjjRKVtt4DbVr5H918aywLUjku
 Hz1jhE9ugvC+fVV0usV2+EKepLEGRi34HYGUYdPRLE93THXxKgZqP5sju29NMA9vHT
 1H3OMH92suDhA==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 5F507B2203BF;
 Wed, 30 Sep 2026 03:51:37 +0200 (CEST)
Message-ID: <8a759e95-866e-460c-9899-d5bb30ff4e04@freeshell.de>
Date: Tue, 29 Sep 2026 18:51:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lmb: Add StarFive JH-7110 SoC as requiring DMA below 4G
To: Marek Vasut <marek.vasut@mailbox.org>, Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Leo Liang
 <leo.liang@sifive.com>, u-boot@lists.u-boot-project.org
References: <20260929230758.616924-1-e@freeshell.de>
 <bdec8558-0408-4efc-8a50-e726c8be9cee@mailbox.org>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <bdec8558-0408-4efc-8a50-e726c8be9cee@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi,

On 9/29/26 17:43, Marek Vasut wrote:
> On 9/30/26 1:07 AM, E Shattow wrote:
>> Platform drivers and hardware for StarFive JH-7110 SoC are not capable of
>> DMA access above 4GB
> 
> 4 GiB

Yes, I agree.

> 
>> . This was previously a problem for MMC access then
>> resolved by a workaround, since reverted in a3075db94d49 ("lmb: Reinstate
>> access to memory above ram_top"). The symptom of this is EFI boot failure
>> of GRUB from EFI System Partition on USB MSC with a starfive_visionfive2
>> board target that has the on-chip Cadence USB, tested with Pine64 Star64.
>>
>> Restore the workaround with a dependency on LMB_LIMIT_DMA_BELOW_RAM_TOP.
>>
>> Signed-off-by: E Shattow <e@freeshell.de>
> 
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Looks good to me as suggested.

Thanks,  -E


