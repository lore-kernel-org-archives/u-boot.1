Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5399C25B74
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 05:57:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D80E0883F9;
	Tue,  4 Jun 2024 07:57:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="e2yX3WuI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C12F288422; Tue,  4 Jun 2024 07:57:50 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86EEB883DB
 for <U-Boot@lists.denx.de>; Tue,  4 Jun 2024 07:57:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1717480660; x=1718085460; i=xypron.glpk@gmx.de;
 bh=fgL6LL5K3MFXkxpzUasmk6VCLYzjHzg8qnMwiJaBM3I=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=e2yX3WuI5AUTohkLTEExGopUDiIivyU5vhHT8cqULjHv+PHpWIznlwlo0t+LZLHo
 AkkV6rS8onTaTqssRdbjk/gm9Y9dRfnGZI1TfG9owCT1cGE7DbTjdf3gaieBSlDAi
 jV28Wb3pe9+kCiQlrgUViOfA2hsTR3slwZDDkIuae8RW5+ywOeR8a7gdN2amDWQ4d
 xkONX7yuRjlD4RO7LVY63RM/P2TcTskPdQrtbrEkmgRpDrhWmBBxV31OsMt+1vuCg
 rrw+F58cLjPqDQgP1Dh8Dg6tRRTP6qRCLG0mXsD+rTUOXnSZqTkh0MqzKnwcGsWn2
 vinY6HBIacPlfwVK2w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.107] ([109.43.115.118]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZkpb-1rzqhX0pi3-00Woe5; Tue, 04
 Jun 2024 07:57:40 +0200
Message-ID: <9a189d18-c748-4fe5-a3ce-9f0f7a5225ee@gmx.de>
Date: Tue, 4 Jun 2024 07:57:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] Added arm64 assembly for examples/api crt0
To: "Brunham, Kalen" <kalen.brunham@intel.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "U-Boot@lists.denx.de" <U-Boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
References: <20240521162543.GU2568172@bill-the-cat>
 <DM4PR11MB529670F5CFDA6B4EDA7B7206E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521164659.GZ2568172@bill-the-cat>
 <DM4PR11MB529668DA50F05F26AAD229F0E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521181534.GD2568172@bill-the-cat>
 <d5887c6d-fc80-4f89-be51-db9b8da3863f@app.fastmail.com>
 <20240527160708.GJ2568172@bill-the-cat>
 <DM4PR11MB52966C57EFE2BE722B9E8DC1E3F32@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240531160258.GN3714513@bill-the-cat>
 <DM4PR11MB5296624D138053E9457054B8E3FE2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240603172322.GA68077@bill-the-cat>
 <DM4PR11MB5296E1D83E3AC318389107E3E3F82@DM4PR11MB5296.namprd11.prod.outlook.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <DM4PR11MB5296E1D83E3AC318389107E3E3F82@DM4PR11MB5296.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rRHvwqQ4TgBylsv7yatY/65LZ8q6kAeC5czdqEtXzvjJqYdnMfi
 hA02yMTHkxYRWWiM0j6c1KtHsEFki3j/ikDVyX1W8b5ks6hn3m5QiBr3cpVvB2xgxxpaGzJ
 ZqsqbbuLGVUEbs1rY/RqUZu6SG1SBk3+UX8UEKdneMj5oHdgWexCggui5E2Pn9+g92YrS8R
 3IhifWud+oaQO5uIdNgYw==
UI-OutboundReport: notjunk:1;M01:P0:B66kn9/hcf0=;EVvMJCF6YpbfF0ETTa2s71eVyG6
 iIyvjiW4ji0auP5mu31I9Uvyj+s3tH+kHPy7gF2Od8fW4va3d3upv+DPtzryDx1WuxYPzFlE1
 LS+cUNY2rxny+DanP514lQv4C1nOTMdXMTxak9yCuXgODXaolgou8bbxdTGjQ8Yxnmbnc6S25
 JBxR5xnxoygIogZvtYPOVoRSusV6kmtYzx5mHcQ0yBZLASxgd0HFNCOvcYuw8Z1yMqlpv5TUz
 HofJgzIhJl3vShp2WbjdTQUqaM4H/k2BGE/qUdesn0l4Lxzv5PSZeeP6xKizmCpTJlE4GQUW3
 U/aDOyxo8E3UKU9o8123PRzGnlc3JE5KDJzD3g1q9YuMpEtlTMXf4kYws3knq0Hkk06mstSNq
 dJs+jxiTM67vBEbM6G1jNk3DB6g2FRNwZ3q3yleCl0jmP8zMUO9ee7Bg3rtAdtgnCPAHimXl7
 GE6kx5fmLWcb6gQKdSNY/mbfaHzIJznKdv9bZBXuMYktaNRrPgBtDMs3KGbTvfbrEIkSqfTV/
 j9OSy/flctZSs+PWbstIob9BgWG34dHifUm9LUXV3JDCLILe8yEik2IXLagGU02W/K+lbOPG1
 i1yNRouJhRuSly+3FFShHIH18Xl4noCWTPkkGgiiU3Hai6KRJD+Ihc/yX8JGunkinSVHOvILx
 LVh9bOGTrwptMi0LwCqs0pUpzFR+YvuBUCAR0gJkIPwj/5bACHR1tZHHNcWFPKfF7A+8f1zZK
 MCwMNMST0a2U/UqArUJjJP74222uH/2fCihhqLcecRpcO/UiuakHVAnb4Hk5zekrmolF0fz9c
 VyIM35WtI5G8oj610UmxUMOZJk50DFCtSyYJ2EibnR6Nw=
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

On 6/4/24 05:34, Brunham, Kalen wrote:
> Hi Tom/Heinrich,
>
> I have https://github.com/u-boot/u-boot/pull/574 that has a proposed cha=
nge. It is currently failing clang sandbox, which looks a little strange a=
nd I'm looking into it. Please let me know if you have any feedback on the=
 general strategy.
>
> Thanks,
> -Kalen
>
> -----Original Message-----
> From: Tom Rini <trini@konsulko.com>
> Sent: Monday, June 3, 2024 1:23 PM
> To: Brunham, Kalen <kalen.brunham@intel.com>
> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>; Heinrich Schuchardt <xypron.g=
lpk@gmx.de>; Ilias Apalodimas <ilias.apalodimas@linaro.org>; U-Boot@lists.=
denx.de
> Subject: Re: [PATCH 1/1] Added arm64 assembly for examples/api crt0
>
> On Sun, Jun 02, 2024 at 12:16:38AM +0000, Brunham, Kalen wrote:
>> Thanks Tom.
>>
>> Can you suggest who is the existing owner of this code I could work wit=
h?
>
> You should CC Heinrich for sure once you have things working.
>
>>
>> -----Original Message-----
>> From: Tom Rini <trini@konsulko.com>
>> Sent: Friday, May 31, 2024 12:03 PM
>> To: Brunham, Kalen <kalen.brunham@intel.com>
>> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>; Heinrich Schuchardt <xypron.=
glpk@gmx.de>; Ilias Apalodimas <ilias.apalodimas@linaro.org>; U-Boot@lists=
.denx.de
>> Subject: Re: [PATCH 1/1] Added arm64 assembly for examples/api crt0
>>
>> On Thu, May 30, 2024 at 02:53:17PM +0000, Brunham, Kalen wrote:
>>
>>> Hi Tom,
>>>
>>> What are next steps on this change?
>>>
>>> I'm committed to the idea of EFI apps opposed to examples/standalone.
>>> EFI currently requires block devices which is not enabled when only us=
ing flash.
>>>
>>> Should config BLK be updated to include DM_SPI_FLASH?

The UEFI implementation should not depend on DM_SPI_FLASH.

You could make BLK manually selectable again instead:

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 6ad18889f61..1f0e1010f0e 100644
=2D-- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -1,5 +1,5 @@
  config BLK
-       bool # "Support block devices"
+       bool "Support block devices"

Cf. 0417b8523c47 ("blk: Hide the BLK and SPL_LEGACY_BLOCK options")

Best regards

Heinrich

>>> Should we explore how to remove BLK as a dependency for EFI_LOADER?
>>
>> Yes, someone needs to explore how to cleanly make BLK optional for EFI_=
LOADER.
>>
>> --
>> Tom
>

