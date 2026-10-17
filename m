Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C15ACCF2C4
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 17:33:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 51AD160638;
	Sat, 17 Oct 2026 17:33:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rv3QBM5Jzfbu; Sat, 17 Oct 2026 17:33:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5AE97605FF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792258434;
	b=UKh/MaSm10TAobTXes34y+rD8zLYXUDOcHF6lC1JjF+Hx0hGht/STkMWAkDmnDfiat+G
	 77AASc1LDc7k9tas8ELuS4sF+9GgfQ24HAzjsZzokM5TMm/4qPc/2xlwopHtnxwZFlbJW
	 hvz5uv8acJFRX7QqOvMq2YzxKIOM9wFgHihWl3ATnvjnb0iwgwZUcw+SgioUNCOdvaB2i
	 zfHdOAUXmmqlGIEy1HFagonhb+tcaPa6ww3NGNb5prF7++hh+Oe78Ax3acai/MPWvjHoY
	 akl/3vC8S+u6ElZCWMfzTyo+bKVjak2UCv0w9WT5t9c+LYX80yGXnHGSgs0vkGB+Dig==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792258434;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PgJ/kJkHyxSgn7EdQ0g2zXTJYlqCzlpkx5jWHUMpx9M=;
	b=AwEX3c4BB/zuFx96mORvDwfcLXj7Vq5I9FhiyLkwNWWWk4ganWcrCnlFe1cbw0X3vQuE
	 KFQhEnegUJQNcJXXldP52PuvHmm5S4SsYbc6ulYCNHTE6XvHFFZ0lcVpzy7V6rTD5eT64
	 iVcobtmX54PB56jz45vAsOXs2/rH5jvQ6gQO89+qHBFGAhaSqoGq0kxcsnAqs6adGjjF3
	 08xG9NyKDD/5IX4TRnCJJEfcKHdwv0fuNjJ0v/3An66uNERlKhXMrvPwF7NfYoNd/arPr
	 L/w1UQLvarsPOXSPL+jJLEGPHz4LOdaBm8OaUEfKZJdjRInL31w+HGo76TUdByTAqow==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792258434;
	bh=PgJ/kJkHyxSgn7EdQ0g2zXTJYlqCzlpkx5jWHUMpx9M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c6uQIz+RyJ9VrDvh29b8pJNNhiAl6m8lHjz7zcuUdPPuTdOU2wy+UrRjmnyrimo2G
	 79PRSGYnm/8bfCw9giz2uKXL20h+o3E9Z3xjD1IPUIN/mXzQ7TBSOr9CQN+L1pJYUD
	 QRqmo096ORyqjP/qzwlqqLpIgw+TQKQ2pxbrt6YkIkM85H1udWhVdSXp2r7wsJFRy0
	 tgkdKJt9H4m4//dzswRmVOIZ/hPVH8fSgPLLZXlhDI7Ja5f5/Sqmn6pSIbQAql8E88
	 IZ/zRHzPlk6Qo7gPSszz4wLsMXDVb8nmLPLRY+vGUCHF6RQXwtkS0brTZ8wjG1uOeR
	 1d2QgfNmHBMnQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5AE97605FF;
	Sat, 17 Oct 2026 17:33:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id AB5502A8
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 17:33:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A779780D0B
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 17:33:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NBjbx5cYiTE4 for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 17:33:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org ABF2680CF0
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792258432;
 b=QdNVHDTNxFSi4yX7Uv2no2FX/UJwtOCC7vPPEneHFEBkj0iIfLvQ4zgIASf2ds8UJT7C
 ZxCUaXaLOxtJzVejCTlhONaiHHS/VnmM7AGeDf/Cc8PM+L0d+cl96ouHeY0BKDcap564/
 tXgzZ94aSAVyfS5HrT7zD2UNVbl5l81PFffYnltIZmgG0o05BRVtYpyCSJ+3oFRn9zJam
 QuDj9UyCPJW4YfqRWRNuqSqqlaT4rpmzbTriSkO4emAXL+Ve34uqFUjT55+AIjvQyzgnz
 i0iVec62rqwo17zBDi4DJG383aoYIj4CtidYJx1YxLE5S0NgTYPcRh9rVm+zcr1tT1g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792258432;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
 bh=PgJ/kJkHyxSgn7EdQ0g2zXTJYlqCzlpkx5jWHUMpx9M=;
 b=GhBnLTZOWxDG+kC0qO4tZVLsrnlUIe97C1AUdBB1JLmcBCULFZ1VJirnlnxUsSxXSU2Q
 jglM3wgvSrYOD+YmNXPjCX0L7wbo+I6hxnV8ErYRW8dcAdjeJcEDcGqH4z6vEpBQe2ipL
 ZZ8yP/XHY2CxMa4o2bskNqqCasLq+mDzLWjHa5Kyt9bPa1M8QL84xFoMmygtAld5IosVJ
 bqtcnkFsVvUfQ/oldYfJPchhc0hDTJaUWlsOuDBeYtTQLdw0ge44ysTXIJh8CWUGvHJHq
 zK+cziBvk6nE3Jea4EQsGEQXi/mhM43fRKDvU2xfKaHeoLQK2DELSm6SvNt4s12xaTQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=ZocJa16k; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=ZocJa16k
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ABF2680CF0
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 17:33:52 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4j6TSD0DzdzKp57;
 Sat, 17 Oct 2026 19:33:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1792258428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PgJ/kJkHyxSgn7EdQ0g2zXTJYlqCzlpkx5jWHUMpx9M=;
 b=ZocJa16kr7Qa7TA/BaUHy/n7bUaDRjFYZFk+eUzP6VUDaHuViJ6nOWbG/9Lsv4zhWLL1CQ
 Stc8qEZsqCFoQbJ8PaOGGYandQB0ALwjWMQoHFrkn4Lgsact1HCNy+Z3S9GEIJSez8lZcf
 +vsVZ5fWyxTyyXSBpfNRNUmZ7EXXOX9lxV+cGkRR4/ntpBcE6uc/MEs3P5l/4tsULWjcgJ
 fHpSGmxmjKa6089BOF8aDwyU+t8MzBPELxmlf3PQbhQYZKuLW6BIRW3kKXOyrdcVmWs1u3
 OfMvm6u6ORpvFAJvdMOpOlpEQS33Np+y34PRhdDFD0Oupas0kHVwJHCvbphI/w==
Message-ID: <50db221f-8e06-4519-a44f-5ee36b8f3df3@mailbox.org>
Date: Sat, 17 Oct 2026 16:29:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/26] usb: dwc3: part 2, make the resynced code work
To: Anders Roxell <anders.roxell@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com,
 ilias.apalodimas@linaro.org, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Nishanth Menon <nm@ti.com>, Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Casey Connolly <casey.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Peng Fan <peng.fan@nxp.com>, Mark Kettenis <kettenis@openbsd.org>,
 Janne Grunau <j@jannau.net>, Chin-Liang See <clsee@altera.com>,
 "Chee, Tien Fong" <tien.fong.chee@intel.com>,
 "dinguyen@kernel.org" <dinguyen@kernel.org>
References: <20260916123826.517181-1-anders.roxell@linaro.org>
 <80e9e892-24de-4cba-b84a-35bdcb6a903c@cherry.de> <as4r8p_70JTOl068@monster>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <as4r8p_70JTOl068@monster>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: e0823ba2cbb00b3a48b
X-MBO-RS-META: q8citiowe4eh95yy91aag11zem1pd4cs
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

On 10/13/26 3:02 PM, Anders Roxell wrote:

Hello everyone,

[...]

>> Total of 4096 double word(s) were the same
>>
>> I also have two SanDisk Corp. Ultra Flair that are USB3 but they are
>> consistently detected as USB2 in U-Boot for some reason.
> 
> Same without my patches?
> 
> No rush, I know you are away for a month.

I would like to move this series forward, so let me get input on the 
status. Below are the vendors which use DWC3 core that I could find in 
tree, can I get a go/no-go on this series from each of you ? I hope the 
CC is complete, if not, please add the missing people.

allwinner
altera
amlogic
apple
broadcom
exynos
freescale
microchip
qcom
rockchip
socionext
st
ti
xilinx

The current state of the patchset is at [1] in case you would like to 
re-test.

Thank you !

[1] 
https://git.u-boot-project.org/u-boot/custodians/u-boot-usb/-/commits/test-dwc3

-- 
Best regards,
Marek Vasut
