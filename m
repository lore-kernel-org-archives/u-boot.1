Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9659EC25B75
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 12:48:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 026F58874D;
	Tue, 21 May 2024 14:48:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1716295735;
	bh=8Hi4bmZNJDbcicgVa7Cr/O3RcQxWQdbJDHcqiNUKKJI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K33WYRSiSiAeTtbbzH80ZvgMfbcPB1wJthsAp2cZbSo28ksME0aPC5kZkCghsIEc4
	 srJguJOBxscjiMj4bmsVMy2qU2Eqegu7CjScA9/kSVgaAnFMNVYlltLi0W+7dK6k23
	 L0opTyEk0Ho78/rvar7FcYrecpExtDWAv10BKKKLauSqUZEpt9qcoxqoO8TOQpP8Fb
	 GWmvLugwQSw6Yv04tD5VghOFq3Gfks0Z+5dhEBfQxKh5zNYAF1l8AF+g0TO0CvooO6
	 /KZoChNEPIGVIWVB59SjocREhxZhtL/hXe/3lA+giOTxfwJt9qzy4y1r7UfUjqflQ4
	 dIAFd81c0jrOA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C8C68875E; Tue, 21 May 2024 14:48:53 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E648F87F7D
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 14:48:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4VkDl633Z5z9sdF;
 Tue, 21 May 2024 14:48:50 +0200 (CEST)
Message-ID: <8032eee7-8041-454d-a255-11502194c5c3@denx.de>
Date: Tue, 21 May 2024 14:48:47 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v4 0/3] cyclic/watchdog patches
Content-Language: en-US
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20240521084652.1726460-1-rasmus.villemoes@prevas.dk>
 <ce12ad50-bd54-499e-965c-5693355a4e84@prevas.dk>
 <97ec64c3-7323-4886-9623-77b4bc28dfff@denx.de>
 <835fa989-fede-4339-af95-0f1053d5e405@prevas.dk>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <835fa989-fede-4339-af95-0f1053d5e405@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4VkDl633Z5z9sdF
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 5/21/24 14:45, Rasmus Villemoes wrote:
> On 21/05/2024 13.54, Stefan Roese wrote:
>> On 5/21/24 11:47, Rasmus Villemoes wrote:
>>> On 21/05/2024 10.46, Rasmus Villemoes wrote:
>>>> A bit of a mixed bag. I've been wanting to submit something like 3/3
>>>> for a while. So when I stumbled on Marek's patch
>>>> https://lore.kernel.org/u-boot/20240316201416.211480-1-marek.vasut+renesas@mailbox.org/
>>>> , I got reminded of that plan, and I think that patch could be more
>>>> readable if we adopt this model.
>>>>
>>>> While actually doing those mostly mechanical changes, I stumbled on
>>>> two separate issues that probably want fixing regardless of the fate
>>>> of 3/3.
>>>>
>>>> Mostly just compile-tested, and now also checked that at least the
>>>> sandbox test runs succesfully, and that it builds both with and
>>>> without CONFIG_CYCLIC.
>>>
>>> So I managed to trigger an azure test by pushing to github and creating
>>> a dummy PR: https://github.com/u-boot/u-boot/pull/542
>>>
>>> That fails, and while it involves the cyclic framework, I'm pretty sure
>>> these patches are not to blame, since the same error also exists in
>>> other pipelines. It's an "expect" failure, because some watchdog
>>> callback apparently sometimes takes more than 1ms, so the default 1000us
>>> threshold is exceeded, and that prints a warning which breaks the
>>> "expect".
>>>
>>> An example is
>>>
>>> https://dev.azure.com/u-boot/u-boot/_build/results?buildId=8459&view=logs&j=a1270dec-081b-5c65-5cd5-5e915a842596&t=69f6cf72-86f3-551a-807d-f28f62a1426f&l=1055
>>> .
>>>
>>> I don't know why it only/mostly seems to happen in clang builds, but I
>>> think the fact that these happen quite frequently warrants either
>>> bumping the threshold used in the CI builds quite a lot, or adding a
>>> config option to suppress that warning/limit altogether for CI builds.
>>
>> I've also seen CI build issues from time to time and restarting the
>> build magically solved these issues. I'm all for making this CI
>> build more stable, perhaps Tom has some ideas?
> 
> Well, the problem seems to be inherent in the warning from the cyclic
> framework; maybe more so when the build server is overloaded (as
> sometimes those callbacks are reported to have taken 5+ ms). So when
> running sandbox, or under qemu, I think that warning should be disabled.

Agreed.

>> Regarding this cyclic patch:
>>
>> Still some problems, MIPS64 related at least, octeon_nic23 target:
>>
>> https://dev.azure.com/sr0718/0cded7c3-6e6a-4b57-8d0f-65c99496c42f/_apis/build/builds/357/logs/415
> 
> Oh my, this is starting to be really embarrassing. The fix is trivial
> (as the callback doesn't even use any context):
> 
> -static void octeon_board_restore_pf(void *ctx)
> +static void octeon_board_restore_pf(struct cyclic_info *c)
> 
> Should I resend yet again?

No need. I'll apply this and squash it here. If CI build works, I'll
send the pull request. Otherwise this needs to wait for the next
merge window I'm afraid.

Thanks,
Stefan
