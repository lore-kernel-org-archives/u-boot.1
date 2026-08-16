Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6141C5B572
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 00:06:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 662B080DA1;
	Mon, 17 Aug 2026 00:06:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iwtWZ9txlAFl; Mon, 17 Aug 2026 00:06:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8B6EB80D8B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786925196;
	bh=qdXLTj8joERqtIPmgqMa9Z7TI90zDZp/Zx9eysJOSi0=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=0cmkKUU75ylwb6s16lIvmBnEIJX5mVSN8sPFHT+70dKhTfqJX7+y5Tmh0UbaVl8Dv
	 yt2QMr1oxxC6oIpaAZna1787OkBviJn4Gtyc1WKmR2I9TM5ucn6gOB/JxOiZ8IvnHv
	 W2LTl4CMBvHfYbKzFzf/XmR816b84PgRlKNmmkHcCS+OtLzBZWM3ygZHOGxbozSDvD
	 LBVmcMu6P0Xexdo7SF3arnf8oByAGFHHeGu2TO+XuO4w/1roZZnMEW2PsVA7Jl4Q3D
	 vNluCl6xSi6/9VfdLzQvRKxJZ6rhD16TMhHQrv7vEtVSt+FzYgPbpRpuwlv7PcTny3
	 qOZ4oYwx9IhmA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8B6EB80D8B;
	Mon, 17 Aug 2026 00:06:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8BAFB337
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 00:06:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8920280D8D
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 00:06:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I820a9viwG4u for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 00:06:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org C2DEC80D86
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C2DEC80D86
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C2DEC80D86
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 00:06:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A583811A8AC; Mon, 17 Aug 2026 01:58:28 +0200 (CEST)
Message-ID: <c5a9255d-b56d-4c05-bc75-f1a5688b9ad2@nabladev.com>
Date: Mon, 17 Aug 2026 01:56:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: imx: Fix EEPROM address on Data Modul i.MX8M
 Plus eDM SBC
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.u-boot-project.org, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
References: <20260816232404.1223819-1-marex@nabladev.com>
 <CAOMZO5AOmyEbHS7tMdLaWuEoGgkOWSiVUG6Ln54ATPCUqWxCkQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAOMZO5AOmyEbHS7tMdLaWuEoGgkOWSiVUG6Ln54ATPCUqWxCkQ@mail.gmail.com>
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marex@nabladev.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 8/17/26 1:49 AM, Fabio Estevam wrote:

Hello Fabio,

> On Sun, Aug 16, 2026 at 8:24 PM Marek Vasut <marex@nabladev.com> wrote:
>>
>> The Embedded EEPROM address on Data Modul i.MX8M Plus eDM SBC is 0x51
>> on all boards starting with revision 902 and newer, update the EEPROM
>> address to 0x51 to cover all production hardware.
>>
>> Older board revisions had the EEPROM strapped to address 0x50 but the
>> EEPROM was not populated on those boards. A subset of rev. 902 boards
>> also do not have the EEPROM populated. Rev. 903 and newer boards have
>> the EEPROM populated and strapped to address 0x51. Therefore, setting
>> the EEPROM address to 0x51 unconditionally does not break any users.
>>
>> Signed-off-by: Marek Vasut <marex@nabladev.com>
> 
> Does this need to go to main, or can it go to next?

main would be nice, since this is a (long overdue) fix.

> Also, any chance to convert this board to OF_UPSTREAM?

It is on my todo since Peng sent the RFC, along with a bunch of other 
imx boards, I simply didn't get around to doing it and testing the 
result, sorry.
