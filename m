Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD3D5CA6017
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 22:29:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E51E36084F;
	Thu,  8 Oct 2026 22:29:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TI5Cs-eijr4D; Thu,  8 Oct 2026 22:29:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1ECD460832
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791498579;
	b=kTvdHwRGb66k4Znu/fuokV1jn0G233e3N1G00eHplD7RpabZv+iJrkdmzvg2mTbsp/kI
	 tzz97ybuLL5iFs+oMyIyPkGk4cNXIW6QGgeP+zxc1zfVMKdqVutoV7DKU/JUTeuHFtCYj
	 Zyku8tmGUPM1K8hZMtvwRd2qFCRZAO9e/54U9LsgOM+K1IHg1MDcU8sBSKrQWqTncEQQ8
	 6vi4EZdz+VLRfyQIMnn0XLzEhcd22mjIrloo6yzYnrYoqeF4JpalKcj7ae/ES65Y/0DQ0
	 kFLxBZqgFsLJhyZpYODo1f+7K7GfEz2awuFjyKFAC/6PqWNVAcHoTOH44d+9gPFkVjA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791498579;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=D/5KCfdxM8eLNwop5DEWoFuoHz1k+76SV+Agtm0k0HI=;
	b=rsXd6llIkee3v8B+UCZiEmzgjV0DDwSZGvwiMyWAel6P8Yra2oAYXeyUy3xwBtkU720U
	 fo5FSSM0wWWvIReRfBwbTBEHW4II6J5OVHWTEGC0h3Ceq5eeNELUAD8iTRn3J/l0mdadT
	 izHA02bDj0yjxzu9U455udUnySsht1NySTW2qvQK/E0rqIPfi6MdJf3/4rS+AZqWXE886
	 ww7MFu+IgbJphZF2PR/VAuXXgNGJ8gSb+GCoiELqvfTyvFqIY+B0sdMr/oDtkFcifwODX
	 ooYKufIDcD1MpvByYc9pEig+8LIjS6CaZLMf8qqhOQ3/jgvZtsJJ7bcwyc2g1Q8yLxQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=0leil.net;
	dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=EMjEDr7t;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791498579;
	bh=D/5KCfdxM8eLNwop5DEWoFuoHz1k+76SV+Agtm0k0HI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mdQFjg1ECEpf283zhkkZ9Q+PI8A5pEDNbVAERqx6w6fURweNgYbbpzo5vJSiWizjD
	 S6IqSANLAt6oG/2za88lYq5pe+mDLZ170PsEQ0N/AgOLvb/Q0uGuiVhigKJyM4JuIO
	 vhqPQ0GtW1gDBq4Qp3wOk246mPO3Jznpln4/yV5O49UfCCHcpnlmDRpjzXBKf+6e74
	 k9D9AkH7ThU95YpGnqxd1pgw/E4+U3Gqtifgx83OdN12kB1nau7Mye3btw38EFh1V2
	 HPcSgFyyz6yEr43t2awmWJZYEVOIuQGIeS6hlf2f4g/pDzQMGgq9CfiSiVxfp+9wYI
	 e5X0/qEQ1e0TQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1ECD460832;
	Thu,  8 Oct 2026 22:29:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 091E31A6
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:29:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E32F360832
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:29:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WZ-Rypqeo5E2 for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 22:29:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6170B6082C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:38e0::8faa"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791498577;
 b=Y3RXDDYKOVtiQcRVtGTKAjNqUSpbaRkQBe+BL8p8TqzyxSWiF6X5sByZpJnnJWFeMRQ1
 5ntMJpvFPFxJBrLqZwzfzghsM8BLCtGZBETRybhbilZ/K4Q/Pr1T0YW63XO581yrZ77Z3
 09ZFu4PtejfRqP+hQz0iY08PIZ6FKbPXtRtAfX8TlP+0NTNvJxxBOR+Fys+3SHYFEHRN4
 Ne1HuWVPip6Pb7CfT7li3OASa3K7Qq0qtlkoRtWBBPi1Q2/HN0jefTGSqs+qMkAZnmrJw
 suib4pujLWFEfmiv7vsDfrvYYgOyZjcnuxStWtWcsctEKXNCWujnullqO5DGi2tGnQg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791498577;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Infomaniak-Routing;
 bh=D/5KCfdxM8eLNwop5DEWoFuoHz1k+76SV+Agtm0k0HI=;
 b=iqPVS9z+QRJj+/McspRrWl8/kiKVBYrDcK1UJ2gjzWMFS3uR5Mc+YAz8XncZJhsNCow4
 IGGNoSucQmibEFeR/IAAd8axZX92xhwQJIJ/+hWQpnpSU9e7W6sm+IghB5xjsgy9nzWex
 +2wSa+oWH6i7m0idR0WG7+mVz6sGBiXJ31YXDpjrtTiP9V5olj2kCqt1R34J1ljhlTloM
 xM10X66DK94hkjIBATqGk9SsqXfeVVhwz6ZupnUe5Vtd3BuNRQiyJPClTt93aJmILshKm
 gtExvoI01Q1DdeABq0Jown5RAriqd66aT5ozdfH/j/sftU64GeMXyJNx7dSLTnRbR5w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=0leil.net;
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=EMjEDr7t; 
 arc=none smtp.remote-ip="2001:1600:19:38e0::8faa"
X-Greylist: delayed 5656 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 08 Oct 2026 22:29:35 UTC
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=EMjEDr7t
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:38e0::8faa; helo=smtp-8faa.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch
 [IPv6:2001:1600:19:38e0::8faa])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6170B6082C
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:29:35 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246c])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4j14Rd1Y9qztl7;
 Fri,  9 Oct 2026 00:29:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1791498573;
 bh=D/5KCfdxM8eLNwop5DEWoFuoHz1k+76SV+Agtm0k0HI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=EMjEDr7troFFNE2USx/BUC9M+qPYhWK6N1N9oi81JkflF4O7oh+FF3Y9I84R6giKW
 j1BaQ0XIP1syFXysxH+zl4+FMwCEL8khHLyzG08BEr00B/J557mKnUep36eDHNlgTx
 uS2nG5/xp4oeSV6e6zqLmMba91T2jTJmfIt6qW5U8ntnN35dZinNh/rCnlEBiD2qX5
 /Pqsco4mHWLdCC/Rr20mA4QWPXqnxTF+WOvcHaxu7Soe+D03/NwWm3gEmTO6Ge8q5N
 nhBDxe6c1wCGOUSWneJUttYdSkGVC4eiea6Lst6VtZNrthfk2ubxJYZUljfQCm6cNS
 CMsAJ9HZdjEgA==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4j14Rc0Bs7zmH8; Fri,  9 Oct 2026 00:29:31 +0200 (CEST)
Message-ID: <f2a4bf52-8532-4f57-9354-1d2a3e33d875@0leil.net>
Date: Fri, 9 Oct 2026 00:29:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] ram: rockchip: rk3568: Simplify get_info() ops
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
References: <20260804105721.2402406-1-jonas@kwiboo.se>
 <20260804105721.2402406-2-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <20260804105721.2402406-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
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

Hi Jonas,

On 8/4/26 12:57 PM, Jonas Karlman wrote:
> The PMUGRF base address is fixed and known at compile time. However,
> the base address is read from DT at runtime in this driver, delaying
> reading the two HW regs to determine RAM size by several ms.
> 
> Change to use a constant for the PMUGRF base address to speed up reading
> RAM size and simplify the driver by removing use of probe and private
> data. The driver list entry name is also renamed to match the
> compatible, for possible use with OF_PLATDATA.
> 

Questions apply to both rk3568 and rk3588 patches.

There's a lot to unpack here and it doesn't make things easy to review.

1) I would really like to avoid hardcoding stuff. Did you try using 
syscon_regmap_lookup_by_phandle(dev, "rockchip,grf"); after adding a 
rockchip,grf = <&pmugrf>; property to the dmc node? (maybe it'd make 
sense to name the property rockchip,pmugrf but that's a detail). I also 
see benefit in being consistent across all drivers using the GRF when DM 
is enabled. One issue I could foresee is that this typically will be 
part of the TPL once we have an open DRAM init, and then we don't have 
DM in TPL so we won't be able to read the device tree to get GRF via 
that property. Is this your current worry?

2) why rename to match the compatible? What really matters is that they 
are unique across the whole U-Boot code base. I don't see really the 
benefit, but if it scratches an itch, I could see one commit that 
renames all Rockchip DRAM drivers to be consistently named 
rockchip_<soc>_dmc. Not a blocker.

3) What is removing probe+priv_auto helping with? We now need to call 
rockchip_sdram_size for each call to ram_get_info(), which we only have 
one so it's not such a big deal but it's still a bit odd to me when the 
DRAM isn't going to change between calls (so somewhat joining Simon on 
the caching thing that's done here before your patch)

Overall, except issues of the rk3568 and rk3588 syscons still being used 
unlike claimed (a bug) and some slight commit log rewording of the other 
commit logs, this and the next patch's commit log is lacking information 
that should be the answer(s) to 1 and 3 (and please split 2 into a 
separate commit if you really want to).

Cheers,
Quentin
