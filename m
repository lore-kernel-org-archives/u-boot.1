Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E67C79FB9
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 14:43:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 96D9B810A2;
	Thu, 10 Sep 2026 14:43:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LbYhc4ga65Hd; Thu, 10 Sep 2026 14:43:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C91B180EF8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789051401;
	b=j2VEwIUZ3ZpjJHlJLmnule6RNiWJ1a4ClY5Yw9SNhI247/DzXQLatYpLRUyNRL2hixES
	 BUheWjAYjtint2riJ/zflo9Ven8UJhT9cdHSL7vvw9kx8uS4oWYDligwaCskqd1jwLm6c
	 osQ2yWjBaAU8zBPN69ya5PmK/h5v3EQ8lSo/FpYBXCRSYEBJwx2rbYczuD8+b3ynHtUuE
	 lccygR1PcZ9rgV3IP6/fnQczXHs7Pyd32HM/5W3NZz1LCCtKXSJ9S3mlUUJ0CQmeykjI3
	 69Y886eKnRt77qOVQ21JMlggtuUNY9UAVswWVX9ZoF/O5eDUNK+Awqsr4n7peNLt5Yw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789051401;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xj+ZGb7iRXbsNaum0g0bmjcNlAa3OOpeJV7PCtsQnoQ=;
	b=GB29h/WLhv9j9kcz+vjs7Lap9X6m+XxFeIDkNEOaZyVSREvKK1NN7D8MRo+mFnwxmbdr
	 RDEZpzEA4DUfFvB7vz4YnFzkPFGeNY4Y1gh0MWpAJX9ELvRU9Q5ItWsXD1pIzPnWhfyqw
	 kCyU4jZUik9UiykexbnQOjv9imyU2XXXGgBggZhBLgzBsjyJ+f8aZmru4ogf8yzjMBTRi
	 j/pVhtoU5aEh0jl1VgYfS6UpsUB/cxZiw7WyI0PYucPyW9BDf5R4yUtpOUCXp/kjewa1Q
	 G7md7rBWi9U4vbaMXXUrfq2YYFEdg3KUh4l0hXOIHKZuSbt2Qn5QLSDPIofUPTN8d1Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=lWJHbzSC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789051400;
	bh=xj+ZGb7iRXbsNaum0g0bmjcNlAa3OOpeJV7PCtsQnoQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OzJfwzov9ogV6lga4m39aThNBMKZWcUO743vSy5TB1RnAD0THI3H1h9B6iyYBIOZt
	 ClL9NwTglng0qRWGFQsbq54UNC+rmqAVOYyAmYdz8SP+s/jtooZuXZjn0gU2VeyV7p
	 i14/U0GvKE1GOr8EhAMcoQs0aHAWNq/f45lhxgSsDavYoxANEwE27boazdxfMzX0M8
	 gZs+67npRnvV3uGfkRKu/E7P0FOB5doBVp+Nheaa/ZdLpVHDAAdgB70Hw6y+wFxAD4
	 YquBSsK+CCUzbannFHLSZ41UBEwOiAoz8sNEZMJtrqUqKJ/gzsM9+6wNLev3nCnE1d
	 RWZey4FjfHByg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C91B180EF8;
	Thu, 10 Sep 2026 14:43:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C7FA1268
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:43:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AD8E080EF8
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:43:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OW8yVdRZYkLu for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 14:43:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 56C0680DE9
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=80.241.56.171
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789051397;
 b=F9dsCFdkJ/+8hA0Kth/st6Fp0pa7drNoiWNLLoFTzy4AmtMI+kvdCEAB2GLddVpLoxsi
 xWpp8LW9FI3A5HduHVtJlvmS0eOvAZ3Gm357sbDR8Ev5b2LqYyKx8ZmYvsAjxk2z6GE1P
 TD1AIwzdrGQVwkjJqH4YvG5dWmSpf6VCnT4mQx30rzdPA5OeIWHTylDquxI0circEjzBR
 A9CxW0moLWvlpLGBr0YxmvjhxXuKevRhTnFBfDU3qYDXVtf36/dbM0wkCcDpe6TE4hk23
 PkvwrB6gdG7zcJipKbwnxL1sUpwpW1ZSDTgV4z4kqkWQMBeSifJcBrqAny04kRB2A9g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789051397;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=xj+ZGb7iRXbsNaum0g0bmjcNlAa3OOpeJV7PCtsQnoQ=;
 b=dI93Ww7bj6GqPzlpLLV/kGqoIfikixetBZ0zx/LGbQ4+RYKJIBXXLAKbXte2flnsrl0c
 GPIruoE1h5RVEjhMsSSCCxFbm9KmTv4R2TqK16Lw4YkvwLSfZ3yMX8W+UR0U9OQfvm/OH
 C4LMveREydIXLn7orMAaiEDXW5GlecxOTyBvuP9Z4Ee1SsMyUFUspIaKpVpjNlgtL2P55
 zLIRdhXQ60bjkHZXoJmAD6DRowWOdrVHVd6OitclqKWHXoL9hqLWaFNo+MdhLJV1zjIiN
 umds5NJaX0vqauWz3yn0C9ryd+aak11wS9SUPR4x6s9l3XZMkXg+50huffj4GvmerWg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=lWJHbzSC; 
 arc=none smtp.remote-ip=80.241.56.171
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.171;
 helo=mout-p-201.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=lWJHbzSC
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 56C0680DE9
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:43:16 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hggQT5bgGzMlBr;
 Thu, 10 Sep 2026 16:43:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1789051393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xj+ZGb7iRXbsNaum0g0bmjcNlAa3OOpeJV7PCtsQnoQ=;
 b=lWJHbzSCvM9KKMXSZRT8hE0aCc0W+o5sE15BB3PcdIdaX+gUiCcCHxH3ArK+wpDQBrD9ME
 aXfAU6t1ZwXwZKAnNWXF2xe0GcEjjFhk6mommJrEK/pbjST4NDf8JSbUUo6McppvjF07lN
 Jr3WkVL+IBve+cNV1ZctLqhjLaGgprSu5z6bGV5Sglr2E0Y3HUXumtBIdDlccwymjuAI8b
 ut4VvWuHmRL7VtXxOQpzeVrN7D5WOJ3oh54bn6s/fztmwVVlR+T0zAD6FQg4biCATAhiJg
 tPdtf72kKpoq+VX3M+dZs7rzP7WF8WeIJ2WWKTo9WyURfpTZUUWsyxjRj1S1WA==
Message-ID: <48c7cd0a-c9d5-4bab-98e3-69e0945bfa32@mailbox.org>
Date: Thu, 10 Sep 2026 16:43:12 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] pci: Iterate over busses using uclass_foreach_dev_probe
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Neil Armstrong <neil.armstrong@linaro.org>
References: <20260809013229.444123-1-marek.vasut+renesas@mailbox.org>
 <b851170d-7541-4e0b-b98a-a92803f6bc98@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <b851170d-7541-4e0b-b98a-a92803f6bc98@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: npkkbw7wc4xrt1kk77aygt14t7qt6zxb
X-MBO-RS-ID: 53edd86175d404ebf0e
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

On 9/10/26 2:52 PM, Neil Armstrong wrote:
> On 8/9/26 03:31, Marek Vasut wrote:
>> Iterate over busses using uclass_foreach_dev_probe() instead of ad-hoc
>> loop. The uclass_get_device_by_seq(UCLASS_PCI, busnum, &bus) == 0 in
>> the ad-hoc loop would break on first controller that does not link up
>> in its .probe() function, which is undesired, as it prevents listing
>> of PCIe devices on other controllers. Using uclass_get_device_by_seq()
>> mitigates that problem, and, at the same time, simplifies the code.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: Neil Armstrong <neil.armstrong@linaro.org>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@lists.u-boot-project.org
>> ---
>>   cmd/pci.c | 8 ++------
>>   1 file changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/cmd/pci.c b/cmd/pci.c
>> index 3c0aed50cae..d2a10aec41a 100644
>> --- a/cmd/pci.c
>> +++ b/cmd/pci.c
>> @@ -550,14 +550,10 @@ static int do_pci(struct cmd_tbl *cmdtp, int 
>> flag, int argc, char *const argv[])
>>           }
>>           if (busnum == -1) {
>>               if (cmd != 'r') {
>> -                for (busnum = 0;
>> -                     uclass_get_device_by_seq(UCLASS_PCI, busnum, 
>> &bus) == 0;
>> -                     busnum++)
>> +                uclass_foreach_dev_probe(UCLASS_PCI, bus)
>>                       pciinfo(bus, value, true);
>>               } else {
>> -                for (busnum = 0;
>> -                     uclass_get_device_by_seq(UCLASS_PCI, busnum, 
>> &bus) == 0;
>> -                     busnum++) {
>> +                uclass_foreach_dev_probe(UCLASS_PCI, bus) {
>>                       /* Regions are controller specific so skip non- 
>> root buses */
>>                       if (device_is_on_pci_bus(bus))
>>                           continue;
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Tom, could you please add this into next?

Thank you both.
