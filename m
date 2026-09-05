Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD7D6C624D6
	for <u-boot@archiver.kernel.org>; Sat,  5 Sep 2026 11:36:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3314440B62;
	Sat,  5 Sep 2026 11:36:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d9Bi-BjB3TdN; Sat,  5 Sep 2026 11:36:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 57E2840B54
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788608187;
	b=YatBwF5kMTt2/0E+t1ccno8JMBxYrUSkNbz2tBwcbO45cqIURMiB+ErWNVruE6NEf2Hh
	 V8vSeuNXbYmCsVLUISVgcB43NTqEjHLWLeNYPMrby4nRD7OgfzIZOjufR+udFkNLg9VWA
	 Eagu+QL2qQK26skv85VTHkd4yrvAhQpmtTWyWS6IzMGsCv6CfxuWfvAVbhnP2xsTcEXzV
	 Oq2wfG2Ln5reg3TABUQMyYVGUgIbSuHntUyhdAerH/JWTkTmghwmx/2TCwiJLBwwVjGoU
	 jVFycqTmXUaQ50296erFzC70T0ELbuG2zP+37/9Y7adCtKwrukJ48sV2HyWO4cvkNwg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788608187;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2nueBMzOf/Nsl7CTp3ftF7XpIrK7QwW3dfyvbkep40s=;
	b=Z3/9OlUVV6HfpUlwvBtcOWXazV0wNVk0A5dDDkqKGWgRYCTL1yjENvEij5MZkBBQlD45
	 iSPXxGgMkQttr81r62besfzKwXxikKyiODsdWz7L3ZVJadXsj/TMDG2ugrpJLQjhoOhru
	 +hym8IN3mHU8o3J0bM8Y6Y6IJxFfp5eZylJpINF5s+eZLg1dVKkWmtAUmpn7/XF3+xZFT
	 WSk/KZe9wlMh0JkcT/tJdM/LFTbT6ehf/HUYtBoeOEOfbFJizo2KOETSzbVbni9HQiqmV
	 /vcyfXYCWEHYLiqo8exrynlpmBv4Rspm0lIMzUlK2IductaxwQyw/NEAM9ymud5b6xg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788608187;
	bh=2nueBMzOf/Nsl7CTp3ftF7XpIrK7QwW3dfyvbkep40s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CTQgVoCwN7E8tARXbSXmbG5gQuuQQXj+7fX2EjT/iZUeWhbri6RdcjBveYLdxmJrA
	 RkGg+shi5rKsiFW1o03PpPbFAuD7mhWu5MyqLGzIB81AgFJy0Y7TaC66R35Xd7haaq
	 BNjazN6MYNsxw49AH5vDxQfCc/qt+zI3zZgRoB7ZI+Nc8cyNGtvW87mEgwbNNpw0RB
	 MTctcyGDK6bJbxPZE+gSiz/Jz7u1pYKiITesAMwZh8rJjtED1tR/4Ae1YKOXdJIrne
	 DWi0ulzlhxhcTUs6H8/UaO8f9ycmMjtfZrkqw2bpQ6AaPd7vr7eaQAJK+TXmiWSHJR
	 plNHdR5xChOZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 57E2840B54;
	Sat,  5 Sep 2026 11:36:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 68C1CB88
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 11:36:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4F1324009A
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 11:36:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bHIMEu1FNQeG for <u-boot@lists.u-boot-project.org>;
 Sat,  5 Sep 2026 11:36:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 6B83840067
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788608184;
 b=E+9TTbckR9VbqhJSKwFPYsLiIATaq55LTVQTaZIJILlWr+9ptWCj5QFhRAcPZiFxrDGN
 Q5hW2RJWh39rjTKGNE4D9WqDPQrkdloLJUFNjH5AguXQQECz3eOIq91PZkVDwCsAXPagA
 t0WYI1MucGCdiz8FUS8ZcMPiqClMqXBc/XuFD6EQMFRtn8adjUO6m8ADLzVfG4tAa8ESS
 UTzcK/qxyQ51pK/gGZ0lfDB8hyXy9tperhjw+fpLKs4wA5ZE/s38vdOvzVpbJ4waUYKnk
 AaQPTuirGf8JYK31AD0o6VmhIO62erh99ltC7F9JyBt0F+FCK4IP4J1EoaHpaMfd7kA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788608184;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=2nueBMzOf/Nsl7CTp3ftF7XpIrK7QwW3dfyvbkep40s=;
 b=ZRtZFRG4CsRpmpDVCYBHqhfe/4xbV19mhVhDUiwexYeNpi7IQfQMSY9r/g+skGqwhNcv
 plieQwXTQwf/LsXSgGBNfBCvhua/5lcfizFwZZ4QmHazF4RvTboknv3n8DA9DNmkNHqnq
 PfsH0/nJY0Tp8KfREdALgTRtV8Fms3onqh6drlwn3RfkSBGQUn3/6nbxXqrIf7jlfAdA0
 w+MMuWVcuWSm9GMFKUUgRkLgrcfM3Vw7ScQmTt7fAXT4kuT3kxarkP/k2NWPfpHFg7P2l
 fIMgb6hDxF7OgD9oJH5ZK2swq66Lk6PVG2NISAkAYJcjFXS7qRq65+GOa2x420cUbIA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ShuE5mGt; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ShuE5mGt
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6B83840067
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 11:36:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E31F5600E2;
 Sat,  5 Sep 2026 11:36:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD291F00A3D;
 Sat,  5 Sep 2026 11:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788608180;
 bh=2nueBMzOf/Nsl7CTp3ftF7XpIrK7QwW3dfyvbkep40s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ShuE5mGtf+bk8Bs7q437cKkcwWdfQ+ZOogJN1XoN7qnEPmzhgpNmIUpRzs8dDl607
 KWCywQSK9YRC9ArUrxcxYd5DZlSYzXrJ0+/fJlpQvh311mwhd1arLP4Z7G3oaqWq9c
 kWngDHj4w/N/Y6j1X2Z3vCzucH2t1AWIubWoWvHGNb9Em0Wy2M5e9pQv+iSmBJV9cQ
 0WwrSnd0xTY4gr8ns3YiUKHFMqumZudzIBtXzFcz5FZEZn4JKgExSYbMRmTPF6yQLQ
 UDPjyy3PyLvy29OcMjcYRn5kUTaWMJVoVR6nH3KBajK2wqc9VduJP4yj8uNZYcinaK
 O0SIEp1fi8AGw==
Date: Sat, 5 Sep 2026 11:36:17 +0000
From: Yixun Lan <dlan@kernel.org>
To: Eric Chung <eric.chung@riscstar.com>
Cc: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Yao Zi <me@ziyao.cc>, Huan Zhou <pericycle.cc@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Raymond Mao <raymond.mao@riscstar.com>, Yixun Lan <dlan@kenrel.org>
Subject: Re: [PATCH 0/2] pinctrl: fix on Spacemit K1 SoC
Message-ID: <20260905113617-GKC84986@kernel.org>
References: <20260824-pinctrl-v1-0-e02ed7e9309f@riscstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260824-pinctrl-v1-0-e02ed7e9309f@riscstar.com>
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

Hi Eric,

On 16:13 Mon 24 Aug     , Eric Chung wrote:
> - Add IO power domain control register programming via APBC block with
>   ASAR unlocking for dual-voltage GPIO banks (3.3V/1.8V switching)
> - Fix drive strength configuration: use FIELD_PREP(), preserve io_type,
>   return correct pin number, and remove redundant initialization
> 
You should mention this is split from previous mmc series

I previous have some comments for patch 1 which you missed?
also you lost my review tags, or should explain if not applying the tags

https://lore.kernel.org/all/20260817021216-GKB566872@kernel.org/
https://lore.kernel.org/all/20260817024807-GKC566872@kernel.org/

> Signed-off-by: Eric Chung <eric.chung@riscstar.com>
> 
> ---
> Eric Chung (2):
>       pinctrl: k1: fix drive strength configuration
>       pinctrl: k1: add IO power domain configuration support
> 
>  drivers/pinctrl/spacemit/pinctrl-k1.c | 107 +++++++++++++++++++++++++++++++---
>  1 file changed, 100 insertions(+), 7 deletions(-)
> ---
> base-commit: 6073c36b2c8d39afe3ecc789b281667a3ddebc70
> change-id: 20260824-pinctrl-718fe50eb9f8
> 
> Best regards,
> --  
> Eric Chung <eric.chung@riscstar.com>
> 

-- 
Yixun Lan (dlan)
