Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ACB1C369A1
	for <u-boot@archiver.kernel.org>; Sat, 12 Apr 2025 10:20:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8ADA182CCE;
	Sat, 12 Apr 2025 12:20:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="GHcWakC/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AB4282CCF; Sat, 12 Apr 2025 12:20:32 +0200 (CEST)
Received: from mail-10626.protonmail.ch (mail-10626.protonmail.ch
 [79.135.106.26])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 164D782CA6
 for <u-boot@lists.denx.de>; Sat, 12 Apr 2025 12:20:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail; t=1744453228; x=1744712428;
 bh=L4ZOSFvgZunxYEc1YGAfUBtSSZPST71lOmupYcVLHAo=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=GHcWakC/XAVplmzatATqIUz788pEjyiM8R0jM7g/PsNad8jpSvNkXP/4sBVBqIpmw
 DeeyqoUB6zCNC2KvlL9LeEEHV0dXUPNS5l9VncUs7JCyadfY/gNlXfcibMCqI4vd4q
 9+LKbZ0zHQarUqvlYfI6mWTJnl9cfS0W2nTxIplhDLfF9TLKP+1+K7rYeCNUYU2VVD
 OZv5857BkWJ6ei8rX6kucB6asccdyJ3iPlFEPW9i13JA8AYju2PmBZpNEXm6I2ubFm
 oZmXCZJoYFnJ2WwH1HX/F62T0tIuw7A/mlJKm33H9g0JL9siSGVZMdwpPnj4ksJUI+
 uDVwBomkhPDTA==
Date: Sat, 12 Apr 2025 10:20:22 +0000
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>, Marek Vasut <marex@denx.de>
From: Sam Day <me@samcday.com>
Cc: Sumit Garg <sumit.garg@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Jianfeng Zhu <JianfengA.Zhu@sony.com>, Jacky Cao <Jacky.Cao@sony.com>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH 0/6] usb: host: ehci-msm: Clean up and fix crashes
Message-ID: <D94L20M4A8KP.7IGMHUQLCH11@samcday.com>
In-Reply-To: <099f1eb6-1977-4f04-a283-b6b24d4471e0@linaro.org>
References: <20250407-ehci-msm-fixes-v1-0-f8b30eb05d07@linaro.org>
 <099f1eb6-1977-4f04-a283-b6b24d4471e0@linaro.org>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: f8e951d4461dbca42f850fd36e50f1a91eb07b9b
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Wed Apr 9, 2025 at 7:26 PM CEST, Caleb Connolly wrote:
>
>
> On 4/7/25 11:54, Stephan Gerhold wrote:
>> The ehci-msm driver has several subtle issues and stale code. Most of th=
em
>> are minor and do not cause issues during normal usage. The last patch is
>> the most critical, it fixes a reported crash when stopping/re-configurin=
g
>> USB, which has been around for a few months now.
>>
>> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
>
> Acked-by: Caleb Connolly <caleb.connolly@linaro.org>
>
> I'd appreciate a T-b from Sam or some other MSM8916 device, but this all
> looks good to me!

LGTM - tested on db410c and a samsung-grandprimelte

Tested-by: Sam Day <me@samcday.com>

-Sam

>
> Kind regards,> ---
>> Stephan Gerhold (6):
>>        usb: host: ehci-msm: Fix pointer check
>>        usb: host: echi-msm: Drop ulpi definitions
>>        usb: host: ehci-msm: Disable clocks after all register accesses
>>        usb: host: ehci-msm: Use clk bulk helpers
>>        usb: host: ehci-msm: Drop redundant EHCI register writes
>>        usb: host: ehci-msm: Register ULPI PHY through NOP wrapper
>>
>>   drivers/usb/host/ehci-msm.c | 146 ++++++++++++++++++++----------------=
--------
>>   1 file changed, 67 insertions(+), 79 deletions(-)
>> ---
>> base-commit: 0efe8ea57fc7a1a6fc5f64fb3cf6bc4a1a4fc219
>> change-id: 20250121-ehci-msm-fixes-b1ed17a1eaea
>>
>> Best regards,
> --
> Caleb (they/them)


