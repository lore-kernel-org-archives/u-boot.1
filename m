Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E33CCF2C4
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 20:17:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9CF6D4090C;
	Sat, 17 Oct 2026 20:17:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XXz0Z1YWEa58; Sat, 17 Oct 2026 20:17:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A7E40408E4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792268242;
	b=n92222x9pzZOBsnwnJNkVPgadqfiv7P8jGb6KHIOFoGsFoLwolt6lEa9f09WBjVeU4p6
	 5UdZHOJNsOg0wRrunmjmJBgQpqVSEsrCWb6neanvM+VlN5YuQC8T2DG/sI9cbeG5ug9A9
	 17IAcA7Lssh0q/gcLkYJBAZbukD1eL5rNh6v6RX+R75GyoS3OphrFw4t3nW9/5OMJh33k
	 ru4PlI3vwCprrPf0L7VTgBfrGt6164H4gdWILPTI7VwLQ1hiz/klyxmRsb7f0KrzaBWgN
	 9Dgil/U//vEl4lBZJ38IEW8oEeZYMuAEbh6O2wmGbP/Nz4BkuefRFld/T1kKfDOKa2w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792268242;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EJ7SBnmZN3ABF0cLR/6Fk0jv1yg9T6ckUzc3vIHGm+o=;
	b=iFYA16Co0/L3tqbmsvXwXYmOfmr7weGTBzzimmWzx+C0m3cY3NVuO0+mttSK6BktQF9c
	 SMzQETtRnxhdQGvrz24nAqMt9dr6a8KKnAtJJozHrkUWNZsgAbjh0la+Mxx36x1pB4FHL
	 qKIzL6sxmUGZXX1LPu7IurLDLAxqXW4Hw9WRzJ0JrNqlvCJU/GECc09bXNLn2dHlV5as/
	 cOqJz8Z9YqqGBxZ9YkxV9J3BBv9Swib5vi/06JewR5VONVVQvXPDfGI5tcka6LvkfvZ0V
	 osxo9ObFj6L4Z8Hd8TqKaQawKLc2LdfSZ62UoP+rMuM9UAXnx3uvWH2x2rLElzNiLRg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Q3O7R04C;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792268242;
	bh=EJ7SBnmZN3ABF0cLR/6Fk0jv1yg9T6ckUzc3vIHGm+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=msJu8rA/eDzxjYjg4Uy3wgb8Y/5v8ZjkeyZzS5E/dcQgrKwGn434jIBv2zKR1Icyz
	 Eeag9moKjfdOhr9DgpeSamvrBmJArmKFDXdIagqHaVqc5Aq5Kpk6aguruLHfyy+69P
	 TSsBzK844lI4LOZNBZSDzusdhaOKtLj08t+B3qK5y3TwXhQGNBqtN8oXJHEZDN58bm
	 eu0QDD9k7NgQ7cwqeB0e9SY+pwFQOeRxP6yJ8ZbE9+Hnh6g30GshhTC9W5OTlBE23f
	 K071viRsayYkFDU2JAAvua9pz1TBzU5XrI5rnAnBr6tnPcFNWjbDez80l5s8XRYV/C
	 w0mOyR+uBD/IQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A7E40408E4;
	Sat, 17 Oct 2026 20:17:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B63721DE
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 20:17:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A790B408E4
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 20:17:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cmfx6sqYKzB6 for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 20:17:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 17F9E40882
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::e2e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792268240;
 b=rYP6ICKVQV9qDJs73fZv49rOtrBEqImkwIJ/UZs4z0zvFsHpeGECdiaDDCJ+aRAnSBOi
 wD+iwVNFnM25rqmGUuS58BTv+/k7g9TBx29G6bttfpvoJHeF0kg2VmYtg/inq6TKMj5Z7
 V9otrDttEW/bcp7CbHt7SovK3JTJtcaDKULkEu+5NyNFHp33/hVSykQZLEFzLbnBFduPx
 E6H17LEVjw2yn2FvOjVgGDHvoYjy4su6QKfM0teT5DQJE5B+Mci0ImqS+7elWIefWGf8U
 MYJ0VUrVFIZLD9jVN3UPcnxq+bVf9hRiI571gr5W/k911NQTjPA3T+NceFAne3EVgGw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792268240;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=EJ7SBnmZN3ABF0cLR/6Fk0jv1yg9T6ckUzc3vIHGm+o=;
 b=SlD7EuM/HAznVcb52QN1dL3l/9G4iqU7bEhJn4sd5azHQS9v4prsIdfP0rEcdCDQjWsu
 vQN+BYver0KOW/6rSfwQ4WiPrrrE0tDGSR4S2Z7iHdNOBEtpK0nhmor6ZafvwvRYqK6Ub
 VkhBmva9OEO4e7ELXCFpvvyYvvNbmnTFy9MVVZ8Y3xqygEyEJ991JcuHaixeielks/dke
 2evgL7uqxIGprZU2VzGOsQIGi1Vs43f+nXjLmQEB/5wQIh2H2yAUT4PNJ2SjcQuyX25WY
 W6GZijLWlHr6jA8fv0J3NdvFoYVT0pH1XeV3n17o9JLIWpq4+naIqAeSWklAZfeOLcA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Q3O7R04C; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::e2e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e2e; helo=mail-vs1-xe2e.google.com;
 envelope-from=hfranco@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Q3O7R04C
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com
 [IPv6:2607:f8b0:4864:20::e2e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 17F9E40882
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 20:17:19 +0000 (UTC)
Received: by mail-vs1-xe2e.google.com with SMTP id
 ada2fe7eead31-7cc0e865dd1so335887137.1
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 13:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792268238; x=1792873038;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EJ7SBnmZN3ABF0cLR/6Fk0jv1yg9T6ckUzc3vIHGm+o=;
 b=Q3O7R04CmGpBRQWZAI9xI6bXv8vsnOBMfkbKfNQ7lQmGxJk3SsJBIeren5JtIL49lo
 jg7yQ7wYvcwj8TmKYv98piADEpCG1skKrAeFCf/LXXgyHBe1GWR5ZdP+vJq6iMz4JEyZ
 Lom7U8B2MU9IeRahJWKkXbzc/SaFnMTVyzpFcIyFMV8+jqVEUl2uhoYw87j134QL5LaT
 37fKIm3AaZLRbRhHn0qyYL189m0Vu86cnlI/Kg3YsUfDoYiP+Rk4znd/UtM8Wny0kjxV
 hAtw626n131530G9J9Gd8O7g+LoXdsLvt8GPi4KKBCsIBVjY2DKPyV2GpKOeYd95CFxt
 SRog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792268238; x=1792873038;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EJ7SBnmZN3ABF0cLR/6Fk0jv1yg9T6ckUzc3vIHGm+o=;
 b=L3XogM9Qlc80zyWV9gFyoHsy7XOf+YM2I90TC0T4a6xq5pjo8VAlXGL6cYjwKueF92
 PPgCI/qsFGEIeD7DFRqEHHrQMZRiSdsAUzPo4Xo2sCuhpASeSZezLNPmDj+4qiCAZBTm
 TpsFMvSrmmXewE0I9RpPZ+PDFA1ZAlniXi9wFf94hJjBNjq3WWIDwZTU7wHjfvzW32Zo
 ska5fTe1J1arUjyMrg7rwSA8OXW9wFrQl78xMfkYsOd5Si3CVjPWS5DmdYB2Mq7yLWtp
 DzP1u+Ot3ZRXFPgAEAHZfWrFa26doCfwBS8U+DT3NHKqAfRwiuA68EiVBx8ubIreSufu
 6LgQ==
X-Gm-Message-State: AFq9FYLmClps5BLcio4u4fmoX/f0LaQVjgmLWMnKbRdRxSWhAQZ4usTo
 u1DZSajui7Ii/WfvoNNipOV+pev+UResfiwibyHh7y+A7fI225lsT4jznhEG1ASGCWct5lYyH7r
 D6wyppOE=
X-Gm-Gg: AYBFou3ggKw2X7ClQiMg3ExkawAo2xlopme5GP4KzAbteNDx11epoAztWYjzFv0gjdp
 oQMQvpbcaWj8TS5+uuE1Ek3HP7G+1yhb2Ilalvkv15XcyIWYpZ4VDezH3Kh0vdpqhzqpgdo2AB/
 nsfkC0A5mUYRgOXvxzBq3JD5CWqhQxueBgVmP/pt8SbEIdobZ8gh/eJRLeBOndjl47jhse0Ez4I
 JT+dvmeJRi7EW8MX4dgJbv79JZoWKbx9iJLuXRgurtpi01GUyFYKI5aHiyq5OSJhiEEU17pqeaQ
 YGUbRRN0RAMIZdtntgAxNoHS5LLigDg+Apb/0PzEZPUKpiJnR/yXMY1JktBexdEDd0ctYuCpeAW
 V4AlRKjU4jegjJUMH5d7oOFWmk0uXTn03CyN31iGPv8c9JnJTJ6Xsakj5rRSgKLaBvxOBy7wJQN
 4tASCouls9mtWBR/4Gu4wt/yUzNqdf1sEHblF2+rrRVTPfLWwg48KSiy8ep4/GS7R1zDlONeuPg
 Yis7brv9uyXLzQ1n70u32MqXCIKPC0zDafL1wJzwHta19a1wG6UFNbBkUhqgQ==
X-Received: by 2002:a05:6102:162a:b0:7a7:1db6:c769 with SMTP id
 ada2fe7eead31-7cc369ac3efmr828905137.22.1792268238090; 
 Sat, 17 Oct 2026 13:17:18 -0700 (PDT)
Received: from hiagonb ([2804:7f0:9541:c052:e6d1:375d:d62b:8560])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-990835c2180sm4725880241.3.2026.10.17.13.17.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 13:17:17 -0700 (PDT)
Date: Sat, 17 Oct 2026 17:17:11 -0300
From: Hiago De Franco <hfranco@baylibre.com>
To: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>
Cc: Kongyang Liu <seashell11234455@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Zhuxu Ran <zhuxu_ran@zohomail.com>, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>
Subject: Re: [PATCH v2 0/3] board: sophgo: milkv_duo: enable standard boot
Message-ID: <atPXMIVNYWOKWJPm@hiagonb>
References: <20261009-milkv-duo-bootstd-v2-0-c4679e726d10@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009-milkv-duo-bootstd-v2-0-c4679e726d10@baylibre.com>
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

Hi Yao Zi,

On Fri, Oct 09, 2026 at 11:58:21AM -0300, Hiago De Franco wrote:
> The Milk-V Duo (CV1800B, 64MB) does not enable CONFIG_BOOTSTD_DEFAULTS
> and has no environment file, so U-Boot has no bootcmd and none of the
> kernel_addr_r, fdt_addr_r, ramdisk_addr_r, ... variables required by
> the extlinux bootmeth.
> 
> Enable CONFIG_BOOTSTD_DEFAULTS and add a milkv_duo.env with a memory
> layout that fits into the 64MB of DRAM:
> 
>   0x80200000  kernel_addr_r       (16MB)
>   0x81200000  kernel_comp_addr_r  (16MB, Image.gz decompression)
>   0x82200000  fdt_addr_r
>   0x82300000  scriptaddr
>   0x82400000  pxefile_addr_r
>   0x82500000  ramdisk_addr_r
> 
> Also reduce CONFIG_STACK_SIZE to 1MB. LMB reserves CONFIG_STACK_SIZE
> below the relocated stack pointer, and the default 16MB left only about
> 1.4MB between ramdisk_addr_r and the reserved region. With 1MB, about
> 16MB are available for an initrd.
> 
> This series depends on Zhuxu Ran's "riscv: sophgo: Use upstream
> devicetrees for CV18xx boards" (v5), which sets CONFIG_DEFAULT_DEVICE_TREE
> to sophgo/<board>, so that fdtfile matches the Linux devicetree install
> path (sophgo/cv1800b-milkv-duo.dtb and sophgo/sg2002-milkv-duo256m.dtb).
> 
> Link: https://lore.kernel.org/all/20260927-milkv-duo-upstream-dts-v5-0-7f64983e59e1@zohomail.com/
> 
> Tested on Milk-V Duo, booting Linux through "bootflow scan" and an
> extlinux.conf on the SD card.
> 
> Signed-off-by: Hiago De Franco <hfranco@baylibre.com>

just a ping about this patch, I do not know if it was picked
yet or If I should wait and rebase on v2027.01-rc1. Can you help please?

> ---
> Changes in v2:
> - Set CONFIG_BOOTMETH_EFI_BOOTMGR to y, as the default value.
> - Updated the commit description of patch 2.
> - Collected Yao Zi reviewed-by tags. 
> - Link to v1: https://patch.msgid.link/20260929-milkv-duo-bootstd-v1-0-1b75c9ad6483@baylibre.com
> 
> To: u-boot@lists.u-boot-project.org
> Cc: Kongyang Liu <seashell11234455@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Hiago De Franco <hfranco@baylibre.com>
> Cc: Yao Zi <me@ziyao.cc>
> 
> ---
> Hiago De Franco (3):
>       board: sophgo: milkv_duo: add environment for standard boot
>       configs: milkv_duo: enable BOOTSTD_DEFAULTS
>       configs: milkv_duo: reduce CONFIG_STACK_SIZE to 1MB
> 
>  board/sophgo/milkv_duo/milkv_duo.env |  8 ++++++++
>  configs/milkv_duo_defconfig          | 12 +++++-------
>  2 files changed, 13 insertions(+), 7 deletions(-)
> ---
> base-commit: f8eb3469e1a17c79b047b3fd38ae820e8816a115
> change-id: 20260929-milkv-duo-bootstd-14de5e4e03ef
> prerequisite-change-id: 20260702-milkv-duo-upstream-dts-b54aed41fc61:v5
> prerequisite-patch-id: b8e6815314b7881a02de0066232864d522c4a26c
> prerequisite-patch-id: 0df1fa5db1b2bff402b429809796bad99a517483
> prerequisite-patch-id: 49e1e8263cf0a5ba8d63c8b598b6382cde5284b2
> prerequisite-patch-id: 86dd30e784f022f0a7bb6fbf125c9699467176d4
> prerequisite-patch-id: 49070c05ecf58331ec519a57d1b82f8b2b835a89
> prerequisite-patch-id: 6b6881e45cc6de6544aaa4509db21611158f4fa1
> prerequisite-patch-id: 7198127d4602eeb14212087ce9bb694d84e71a4c
> prerequisite-patch-id: 3a58bd8a061707ff27b8538d4897def3b595dc36
> prerequisite-patch-id: 9055ea941b73e35d1e825787d7eca14ffceb8e8b
> prerequisite-patch-id: 554c1487e8d596e0099677ca88eee0021b1ffbae
> 
> Best regards,
> --  
> Hiago
> 

Thanks!
-- 
Hiago
