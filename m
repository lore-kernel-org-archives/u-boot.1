Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86C4606A31B
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 12:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yT/3rL2r;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YIragrkF
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 976B280F0C;
	Fri, 23 Oct 2026 12:04:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VphEVWI4V1vy; Fri, 23 Oct 2026 12:04:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8F3C980E7D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792757072;
	b=Y9OU756U01Cn6y/2SlFJwb3rieHz9XH/Cs83KhmiYN7WWr3eCPIV/Fi70Y7hKLFKhten
	 OGoKNuq0rtdrlF9NqSR72VMxXK2ov7jtZyMtxP3xqU851mfEjLJ2/u9CYDOJX/dfJN24K
	 PGOnRvYIMsoDM9WvbFmg2LBAqd3MBvzdaS7n5zD+TPGC3odaSH3X2x1GvWTIgVbbyOQ+Z
	 2mQcTbwLPfWoMjKmdvRUtlWRsY89Vms1+jDwSvKDUAFoSwUvpd08JaO5UZ3hi/2rSK/S/
	 pG8ozRGYy4btL4+xPyyPIn15jR2cGZWbP/MZNZgFxGKMyHbvtmNOM6v97Ukpy0Z4Y3Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792757072;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0+TxvFZVLkFZB+lAkJLEJUygE/tib0zyOdPoMVv1LO4=;
	b=EvSCN26oxANf5PKnSOuny2B3DDHliKLHlql0ofpuMbRt6EfysD4gW+N792F9DsCMlAKf
	 dT4mIbU7eRDZ+gJzKBb+2ejVgbKjL3YE4bCZMdJz9Tc/PxLNon5zSSgwSeSfSKZfLy5Wm
	 xtAgsJzMtOQcckroHG5KI/4RV6jL2PcfQYfMxzik2pG+H1WJUif75i3GfiYh53eIOaV4l
	 sZn8eaRGtSaH1DDENRy7/qJwAPS2l6dIvleUXNS+z0GPCczN9XH9IfIa25vZg3cOjazKe
	 6wFNCYuanyw6Xe1V5UZMJe2P43RAI8YPoJIJSWaS1hL2Df8E4nzHWJRWLw+rtZ/VRtA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792757072;
	bh=0+TxvFZVLkFZB+lAkJLEJUygE/tib0zyOdPoMVv1LO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yT/3rL2rnlS7dI0dIUNWwB3RDGNFybYHXvoAmxMJoh1nl1YAAXdIlmfSvToGfwGaw
	 NReGNJxdecEYuqoEvYBIaLbDTcKj2fBcu25ZB6pwPM28ImDOhPxQ2WbERPBC1dtLij
	 dOR1my/SpN4pC9mYImaEyfN4lFvLWVCftPJ4IezMa51AjtJnHBOmwULQBi1YnHmMPU
	 hvSPUIwcKnkXqFnnj99QVem4/3HgprrgiPtAmkVvgJF1GRr5r9FVpodT1mposGVf+T
	 0XzHORw7gAecNVDytOjVdscFgm/sVFY4nBuMYXAUEq9T08pgg/howLSAcFgU0KcZc/
	 uJHJoUWfc4MbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8F3C980E7D;
	Fri, 23 Oct 2026 12:04:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 099D9380
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 12:04:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EF545400DB
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 12:04:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 64RmgjS_THKK for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 12:04:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 229A040064
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792757071;
 b=lzraXrARFnUclTPwcM0nrLpl8PMX5V1+9Zz7upHYUZH5IpKJl7iCyQGcbVaZhnrlFCSX
 QJK6PVE4SKQVV24eoLtnrHyg/a3+PxixKSWxdAMgsbvHyP5EUJ9LwzJAFMAFDGtWku3oM
 wgowwlTFuXJ/EetWHDUiBvJdMsT3w5an63G8idkpQOXvl9McDtngqTVq9Er9Vj5ZaaP3r
 Nne2BW3qK3xeWWcKLuurDd3CfgqdxbrTY2ZZqZsNKAi6AAF72wHtmAkZyYfqWM6/jQbrT
 yJ959Aa6JPDDiO+J1yN8AkHKlUCRgQxgOS8EFgT1qnfupuz1SS+mycvOfHh8RZLPm8Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792757071;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=0+TxvFZVLkFZB+lAkJLEJUygE/tib0zyOdPoMVv1LO4=;
 b=U0Icql2i3XyEnQoWsHJMHsTV/DdTscGFBnATtR3JyZMD/FcJs4pDQQ1/vIByqpglL/O6
 Ca6N/JTpE2ElAhPWucdHeFxDNe8FxMTeljB6/Yj5e+KHi1HLKiHOjBDWCTqLu4Zuz/p1H
 YQhkTIey7l+JRopkjQJGLy7XDYfUblykBQWfM0vrLDh2nQHuMEtJd+IhkniQIQ4HQi/CI
 xsbr/COsDs77Kp8w2EedjK+fdkR4rSDlH5XtlTsV1ip6QWD4XjDqDOm1kIZLIrz/ppbdL
 irOD/JpsiX5IMf8JIuQjAQeYMoO7f++fgVc6mrivd5RQLBncYwXUSHFFK2/6cjJ3Iug==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=YIragrkF; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=YIragrkF
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 229A040064
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 12:04:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B78F160A60;
 Fri, 23 Oct 2026 12:04:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2221F01825;
 Fri, 23 Oct 2026 12:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792757069;
 bh=0+TxvFZVLkFZB+lAkJLEJUygE/tib0zyOdPoMVv1LO4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=YIragrkFr0rc6ryzuiFNswCw5YSOeQt9Ac+1phCvwXC2fr+3S6Pm69kaatocf6mPE
 VG5qclkJcL6kd3wy4w0ZUL3TZbruMQoBwfbroNh2yiNm4Ex86yl5M8Wbw7IM1LGYZz
 +xSVChLUKLxhzwkrjMbjiVXZJ35ZTlOpkiJGcNikJMyN9PqTqJxPqi/Az6AI1UXeLr
 zhUm2JeJUyIEQ98eKz1sfPGI8bjFvAgrSNsV3TAgH4FyR90WGTgo0S8jevcPEzrQbu
 app+8xC9t4bJoW2i9j5rnF8BoC5TJEumilQBPJR5tduKboBpi/uiMBtfnuxS1WLJzy
 C4kSsDJ+ChuRw==
Date: Fri, 23 Oct 2026 12:04:27 +0000
From: Yixun Lan <dlan@kernel.org>
To: Hung-Chun Tseng <alan.tseng.cs@gmail.com>,
 Zixian Zeng <sycamoremoon376@gmail.com>
Cc: Dave Klotz <DaveWK225@protonmail.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, u-boot@lists.u-boot-project.org,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io,
 Eric Chung <eric.chung@riscstar.com>, Huan Zhou <pericycle.cc@gmail.com>,
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>
Subject: Re: [PATCH v3 0/3] usb: add K1 USB2 PHY and generic DWC3 support
Message-ID: <20261023120427-GKD125937@kernel.org>
References: <cover.1792007916.git.DaveWK225@protonmail.com>
 <20261023105942.3896164-1-alan.tseng.cs@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261023105942.3896164-1-alan.tseng.cs@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi  Hung-Chun,

On 18:59 Fri 23 Oct     , Hung-Chun Tseng wrote:
> Hi Dave,
> 
> I tested v3 on a Milk-V Jupiter, on top of main 903c9578e plus a local
> patch that adds the Jupiter DT to the FIT.
> 
> USB 3 works without your combo PHY series. A SanDisk stick shows up at
> 5 Gb/s, and fatls and a 32 MiB usb read work.
> 
> But it only works after I power the onboard hub by hand. The Jupiter
> ports sit behind a VIA VL817 hub (usb2109,2817 and usb2109,817). Its
> vdd-supply (GPIO123) is not always-on and its reset is GPIO124. U-Boot
> has no onboard hub support for the VL817, so "usb start" finds only the
> root hub. After "gpio set GPIO123; gpio set GPIO124; usb reset" the hub
> and the stick show up. The BPI-F3 DT has the same hub, so it probably
> needs this too.
> 
..
> I don't think this should block the series. 

Right, I've merged this series and sent a PR, see 
https://lore.kernel.org/all/20261023063727-GKA184714@kernel.org/

>I can send a follow-up that
> adds the VL817 to usb_onboard_hub.c and enables USB_ONBOARD_HUB for K1.
> 

Yes, onboard hub is right way to go, should be quite straightforward,
I know Zixian (Cc him) is working on a patch for it which almost ready

Maybe you can co-work with him?

-- 
Yixun Lan (dlan)
