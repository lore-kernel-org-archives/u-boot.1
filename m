Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06767C88E72
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 23:29:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B53E740A83;
	Thu, 17 Sep 2026 23:29:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g6PZ2QYoBA-f; Thu, 17 Sep 2026 23:29:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 02FD440A73
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789687797;
	b=UOakJgU92JTrzMWG5Xtx2wQAOrigLgQ72QMKf47IRcBMPPHpmUAwilY/vXq6thR2Bayg
	 C3KVW+E7cZUEELWZX7vcrk9tmI5FQCM9qCUkv45z/bXIVqdt3VgbdIC7Q1gTudwvm4qgc
	 blT/NC0miuWKdJprVRAnsHhJq/xh0v6YHKwl3Df7YWARDt9h5WuI09txWKvezdCHC9blO
	 WOIe1y2rFF6VgR1PEgeG1GUZgIvJKlUBXe966WY339p8C85+wV5TwvlXgbIn5LShGsHyn
	 NiuS119YYe8QNeja3PAIL2LwBBVXA7y2KbMApwEDiKThKDfBup30d+eTmF6qZRNw9Ew==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789687797;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1Oi/YRSelpAJhw++viKDTeqOXLXK/oE1j1nqe1rn7Nc=;
	b=bO+MyQupCgLqb7leXiowdtI0+wgmdeRURCIO3qBSnJ3LDrhlnxjgSceeydgqOvcnPuyJ
	 psdb5PMt+hCARcz/0Zfv/jYmkuNWDy+XMgA1JCWd7PSEaJznutBaGsRMRAPMzQ9c0sUrH
	 1Io+dB0kuS3yt5qyq3IofyYg2+GubAL4NRKZmDasVXM2o45ST+TK37b0GXN1sehbg+feX
	 D3MpBVahQnPtPldTiEGbkHl9tSKZRHZk94rgbFS+Bm0Zc1CI6JxxSpMyTfGHDf6LLnEYm
	 Ka/ykJNggVeKLPaYDDgmOwMsLFsFP0dpnuOpbZGUk3ru3KGoU7DsP9YbB70BtKuoV9A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789687797;
	bh=1Oi/YRSelpAJhw++viKDTeqOXLXK/oE1j1nqe1rn7Nc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lKPoZa8/QcXX2lEzkPhFDh5OxyUPGUgX4SGWTKc+PB4SDj+gUjHOn1F/mESKpIL8y
	 WZDiPq9Lm3wD0H0oc7iugpLYXueqibHDUzZreByIy4YrEDE1WmZFQA4GTKSjau8igy
	 AftZI0OQZ6cVoXSvvmoLvMgEfkVLKBSBUVerrkG8oz+gPqgU+ET/c52fVVKolpHpf9
	 ziUswqFe6UkzKM9XrEH7hUotM/qrOTx2wsnVy8ppD3uziJ6z7C+Zz3IGpTr7X/xNgy
	 6ww1nUS0ksYXAN4iM8HG0W1ZtaAIMKspLqYMfCekA/blfj5Epx0T0sGM02La1wUd4V
	 f7WfJZVxCY3Uw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 02FD440A73;
	Thu, 17 Sep 2026 23:29:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A10BE362
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 23:29:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8731D81100
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 23:29:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2UWA9gN-imwM for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 23:29:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A60D0810A5
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789687794;
 b=ZhXt7WJtXXDWwyN9w4bpWtNW49ABUDvylOhdf8wDzWZOKWyhZCLDpOcvpRPUbTiXmLJV
 4e/sCGOKQkgYc9uFWEnDcE1cuQQ1oA8CLWDe4Cv2qrO5EWZh/Z6Yr3omCL/R5llgQUjhO
 9Dt2sdTHNB3xg+tHXjn7B0vngNCFMf+pM6dGQHv8/JH4NVxNB8z0Dlpcrul5wulyeb1jn
 HIW8wkJsILa/kGaCPfsOHlI6jgvRAkuwe3PI0NjlskABkQEAFc+6u5mmLPgBpT/J+HCFI
 Pd1K5QNiM10/m52T8GAoi3JT2INbhLNyw6NxmtYW4cXoYhmdVh8Q872iaCE6yu90dKA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789687794;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
 bh=1Oi/YRSelpAJhw++viKDTeqOXLXK/oE1j1nqe1rn7Nc=;
 b=OlN2ik66QYcyBFUfWUD3fMEL875GK/Yhu1ns73f/ZbwQUHSyyoyn8jP5WEBj8Xz9GOYx
 VWNuVne/tOpxIIaNcgMvbvjzrkKWxPpwkfZ26QH2zOzwqj6BoLbVhC9g8bVaZjYeX/lUB
 KJMeTs0lDcCC622ODWkxyN7FtAJcscusSAK+aUtti8CXAM/iAzNHZRSKOduamz6uC52p2
 wkr2oJyqNN1vC1XUpz9R80pditMNfcN3ATTpWbF69Jkb3McHtCErCFRu91pqCmVj5VSxR
 5I50V2uy1hCEm7sXDRmkGkRA4KXBLWVpgFRViTT/5cpqPYKvnDiJ/3zkv7GY5xl6i4w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=snS+6ZXJ; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=snS+6ZXJ
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A60D0810A5
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 23:29:54 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hmBmt4Qq6zMlKM;
 Fri, 18 Sep 2026 01:29:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1789687790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1Oi/YRSelpAJhw++viKDTeqOXLXK/oE1j1nqe1rn7Nc=;
 b=snS+6ZXJCTvVC7evb+sr8BBcOI+BXSXKKQkHtEZTXx/vw/HMndIZtPULZJyqM1OjlpXSSV
 QancqkT8Es/RUOEwE5VWGsBdKPykWBJWPkhnG8IGH0C6DmvuRhu4oVGb15v0YqO4wQcoAl
 uh374ikPSLDrULLZtIjpHK4Kc/ElW/MT3fiGTw40cplX9eYt0cIWRfgrB63Twrf7hDyKHv
 muIGXX2afV7RveLRtCAdpM7kcnn3Cq43a9Xma57rkAPw9C/6gVvXbXhGSm7u9w3tSFT3ev
 gi+hQroTlv/HoB6xxtfXXrzl96R8CYLilZPjPzUIx8PpK95VEqVPzLiKupkCEQ==
Message-ID: <eab9d4af-6f01-4963-8fea-49a53abea2e9@mailbox.org>
Date: Thu, 17 Sep 2026 23:55:46 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v1] usb: dwc3-generic: fix ref clock lookup indexing wrong
 clk_bulk array
To: Stefan Eichenberger <eichest@gmail.com>
Cc: trini@konsulko.com, stefan.eichenberger@toradex.com,
 hayashi.kunihiko@socionext.com, u-boot@lists.u-boot-project.org
References: <20260916182012.151031-1-eichest@gmail.com>
 <a9392e75-ee7b-4662-bb5b-94626a490a36@mailbox.org>
 <aqv4E71pN0Mihiu7@eichest-laptop>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <aqv4E71pN0Mihiu7@eichest-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: bce7eb0b4ab3c3225f2
X-MBO-RS-META: tb3jjpr7jza9iawq7jxtbbpz69opaied
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

On 9/17/26 4:24 PM, Stefan Eichenberger wrote:

Hello Stefan,

> On Wed, Sep 16, 2026 at 10:43:50PM +0200, Marek Vasut wrote:
>> On 9/16/26 8:16 PM, Stefan Eichenberger wrote:
>>
>> Hello Stefan,
>>
>>> +	rc = clk_get_by_name(dev, "ref", &clk);
>>> +	if (rc)
>>> +		rc = clk_get_by_name(dev, "ref_clk", &clk);
>>> +	if (rc)
>>> +		rc = clk_get_by_name(dev->parent, "ref", &clk);
>>
>> One small nitpick -- would it make sense to validate whether the parent node
>> has "dwc3" or "snps" in its compatible string, so this wouldn't accidentally
>> attempt to grab clock of some completely unrelated bus node ?
>>
> 
> I'm not sure if this is necessary

Necessary, I would argue yes, because if we don't do that, we might pick 
up clock from some sort of unrelated device and that is simply a failure 
to validate input.

> , or indeed if it would make things
> worse. For example, ti,am62-usb would not match even if it relied on the
> fallback for the ref clock. The same applies to samsung,exynos990.dtsi,
> which uses "samsung,exynos850-dwusb3". This would mean we would have to
> list all the possible compatible strings, which would be difficult to
> maintain.

Isn't that what Linux does as well ?

-- 
Best regards,
Marek Vasut
