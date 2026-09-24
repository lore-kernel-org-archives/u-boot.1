Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B35C98306
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 05:09:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CF45C81214;
	Fri, 25 Sep 2026 05:09:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l8GCOP4Xi9sb; Fri, 25 Sep 2026 05:09:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 11AE381215
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790312969;
	b=HwXVrH02Cj7S41ZyDsdN6NBTPDNF/nx3nflm332P2XiBgJ/TDBnuy6KDD3GtQviGGy+o
	 sAORs4Btrmc2y7WNBSfQsJ8nTZc7Pp5aUhs6sSXESTV9GPBZAh7/qAH3+5Pdjwy5mXmWE
	 zUXepxfNFLOaNl66KmEUnaddQUJGRoVmllV8E4QWA9lV3tSJt4cBzBI+FhaoMAZYnRLVp
	 pAVKldRxGcmAU4g/kvd0xsXKUBpA1q5HBsgnLxTuFTUbOAPd+xaJFvWJbULPPF/mYAZdM
	 rXNCNb6HvEoy1/Es3Z9sqiWiWGfQE85MgLDA/W0XaxrY2nFqScprzP8j5SiHLP1k10Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790312969;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KZt68cqQEAKdmtpwwzhZkrNmBtqbu+zzNTU2FroFlYA=;
	b=SdmH634tPxZjsYJJ5aA6LpsaGjWDuKcbViScHXDFVDXAXLdqc5nPLlKd6X33VmPujJll
	 5kIzurclNMsq18F63+Ur0kScYLf4c69ReHhrVZUAjXCZ9+PUF+n7iVUQfAROuYy2J7jBx
	 pCIC2+u2lvOMQdRAvNltgfqxQ5XkB04khq1UsX9P+uE2qKU1YW1rMj+qb1Bfb7efwu3QS
	 H0iA3QrC8MybzE9D9rAOoAY0k5Wd1JeaiDdmNUglrQLYCBiTFaMwMYYQ1cCctMb3ERaJ6
	 tfnVSaeDkH99dPy3nFy7H1yVDH1+PNUHVp9bgzBmALziRWCUvk6L+ypPrSSUPpRkjfA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790312969;
	bh=KZt68cqQEAKdmtpwwzhZkrNmBtqbu+zzNTU2FroFlYA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uMVSpHN3WCzrtC/RhD1F7dTm9Nh9Vo/pK3pY5I3GcKK83NVlMEsFD45MVtkJwur1B
	 QCRtkKR9JosEn8eLcgE7PbSqo11hq+Wfkcq02m94ztlPivazWbp9dXycTVE54zVxmx
	 wuFl+n12HT3jQGHtZzOGtxavuOpH9ZonINpGp3rCqPtXK0Gw2TIckCKjBMoMrEh2aI
	 efLnvXAiJujQcVM3UtCF2dzzc9eKMqptK5H3Ye1WIhE+pCUePSh7GosYBI3eGny96R
	 6NQw2nzDdaKCCrLmLfESADZlsWlq9mQlXLSq+UTfzf08s2OcE8KrMQIzikEEA2eC5w
	 euMbUzNPKD7Lw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 11AE381215;
	Fri, 25 Sep 2026 05:09:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id F40E0A33
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 05:09:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E629F404E8
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 05:09:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2k9XR1kzPOA6 for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 05:09:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 02ACB404B1
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790312966;
 b=HuAILraQyEn0WlQdQfMS22Ug0NqD/Wn31RWoh7DkVTu71LhxcGUhXuTdTb2HRk4lRWdi
 CdKMoEhAuonW5UxAYBEJRz2dyc51o42i3UPaP4aPMN7vONxH9g7G0NPRBtIuf4An6iLbQ
 DMIelPXz3NMGsiYPNzATgkOZDhiewOZz/bkbiOuK8EtLp+gwa95NLba+NfktsBXFQexM4
 TVUh8cBw64IOX1wzXvKxTjqIu2htYkKsi5EaBt0/GqXVW9VFOJlrluwEDJCJh78U2u3TF
 HW60aR1Yrz6HNOuuWLOgL1JPNjI+0ytl8qXGIE0l7B9DYe9X5S2+SfvIOgtRRneD7JQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790312966;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=KZt68cqQEAKdmtpwwzhZkrNmBtqbu+zzNTU2FroFlYA=;
 b=YTxvTBXW5Vnn4EjfR2ivQv7Uh8D+P0wEFIyRMdhAPZqdvXcAbV2x8TPhpYtfWL1f1BEA
 oCRiqqFMPYL39rrSa8L7XnqTdZHW4ecT0I1dhYFgeyyTTTtar+liDUPLnqYQETL4ZrDw3
 JjcBk9OObtv9ucgTijbPdDZTkhzHLgjrLEW4nqVcBwI7e2qewAHq7iLt63q/9+6ZKPgof
 dEXQSg6leOfMDU5Tqe6cAjKs3B9QNmBA2KRJaQcLRJ4CmzPX3qJyGvaXUFkdGD1xfsRrb
 eFaZ8ITtERlManEAvLPWoQvABVxDn8Yc5l//HwE+qMLdlxiGHHE1oiJNYK0Gn9WhrQw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=nabladev.com; 
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=FNhNIkBH; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=FNhNIkBH
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 02ACB404B1
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 05:09:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A163B103224; Fri, 25 Sep 2026 07:09:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1790312958;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=KZt68cqQEAKdmtpwwzhZkrNmBtqbu+zzNTU2FroFlYA=;
 b=FNhNIkBHa8XJ6/+c8Z3t0NKraggxtagbtMTCZ4yDIfTOFora9fsAYl+ZrWvNKFPTiTJ4Ew
 ckqRrUuXAN1azc94442fV7zEkjwIHojtJ3BQq26+G4cmcgAo9lZ2CUso3X6V45hYKjo2Tl
 7CxVv5RB8BgJjNCm8+U37kwp+JBS5whPEEwXUfQzZAmr065MNqGxmu2n8MzS08NBsoBmtu
 xvlrzAqDp12ArchlZGmsujAiZkzqCtB1MjjGRpJqqgBtzTqUI6+0GNHQ87l0PSiqNUxdbo
 LS6jwnq8XTlqYKonuJhQiHQ9S4Lq0XYg9aCFOFwXwajzCaJEcrxQY7Auuo6u0Q==
Message-ID: <7c93c6c5-2d94-46d9-a73e-400837be370a@nabladev.com>
Date: Thu, 24 Sep 2026 23:14:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: f_mass_storage: Synchronously tear interface
 down
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
References: <20260903020231.1278473-1-marex@nabladev.com>
 <87o6e9tpm4.fsf@kernel.org>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <87o6e9tpm4.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 9/7/26 10:47 AM, Mattijs Korpershoek wrote:

Hello Mattijs,

> Thank you for the patch.
> 
> On Thu, Sep 03, 2026 at 04:02, Marek Vasut <marex@nabladev.com> wrote:
> 
>> After fsg_unbind() is called on UMS teardown, the fsg_main_thread()
>> which also invokes handle_exception() is unlikely to run afterward.
>> Therefore, any exceptions raised in fsg_unbind(), and also exceptions
>> raised in fsg_common_release() which is called from both fsg_unbind()
>> and fsg_common_init() fail path, will remain unhandled.
>>
>> This leads to a problem where FSG_STATE_TERMINATED/EXIT handling is
>> not performed on UMS exit and the do_set_interface(..., NULL) which
>> shuts down endpoints is also not performed, leaving the endpoints
>> enabled.
>>
>> The CI UDC driver does check for repeated enablement of endpoints and
>> returns -EBUSY if an endpoint is enabled repeatedly. That prevents
>> UMS from being started after it was exited once already. That is,
>> running "ums 0 mmc 0 ; ums 0 mmc 0" on U-Boot command line will lead
>> to one successful and one failed UMS session. The later session ends
>> up triggering fsg_is_set() assertion in fsg_setup() and triggers a
>> panic().
>>
>> Fix this by synchronously invoking the do_set_interface() from both
>> fsg_unbind() and fsg_common_release(). That makes the unbind behave
>> as intended, as if the fsg_main_thread() ran after fsg_unbind() and
>> handled the outstanding raised exceptions.
>>
>> Signed-off-by: Marek Vasut <marex@nabladev.com>
> 
> The change looks fine to me. I hard a hard time understanding why there
> was not an equivalent fix in Linux.
> I think it's because we have cyclic in U-Boot and real threading in the
> kernel.
> 
> In any case:
> 
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Maybe this could be added into 2026.10 release ?
