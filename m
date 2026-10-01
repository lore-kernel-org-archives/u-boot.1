Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E43CA5FCB
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 11:19:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EC8F840D3E;
	Thu,  1 Oct 2026 11:19:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h2Ex59Aw302L; Thu,  1 Oct 2026 11:19:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E073A40C04
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790853552;
	b=cIpipauRXlMMLtkWCA/6JY48a1TcegPad+P9FSq7mKX4jWsS9DyUVuslbG7RhA6NB0lW
	 +/y9oTUqd68STABccgKUCPkJQicGbY46MhWQlBPkYGgN7jAX05f2rrIapNdSOMhJv/4Yw
	 5jyUY6hMFfb3UVmmBA9KnPIfuvGeNd1bDSCw+qKpLvLwSqYhTxQzcMXzR9nKYG3h1qso+
	 skH7Cd5fZ8ffXlG+PV+hH6bTXoRs/0iPOG0dTkrwcyZ1HzttihwVd+ZdqArgh3mtuOh3C
	 EJEAIW891dWp0YsHsNJboU3g8tdCqcVgJ3wMN3Ah7xkkGVRDUNDRx47wrn+W1/EW7yQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790853552;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XP1E7c/0SFc3wu4KCWkohJX6c/IZsR3eDwm6CWxUeXs=;
	b=LKGEcf87r+lNfEnrhXSJ74+krUaJduJOtEB4kWJk3buIP2FzO7n2rq6a278fJ/SMl/X7
	 J68frsWNwrvBqG6KKWv5lMLnWDwz6ENhWaNmqaeu5+xYb+oWRWbH8ijbLV8m2CND+f/Mz
	 wzr9ou/+B//7iV977XXe+aYSB5KX12l02aMSsSCunAICBA4ivHqSEgbHb7yv39x8YIpAL
	 x0CIPldlwj5mhfspnqepizmCrhmR/ZBmIZB3uuk8DpSNDnSFaDRNNX0zL38wBvVMckEEv
	 ZsO4hWt+O8o8vrPogYOwgdisBXbbKHUoSzg5klCcmQNTtsxsYJTuUC6y0pKOYd4rXyg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790853552;
	bh=XP1E7c/0SFc3wu4KCWkohJX6c/IZsR3eDwm6CWxUeXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H/n1SFDQwDyFI6+JLmrOeFW34IxxstigVivSsS04PK8gUJwrzjUTtSTdmTAX/gq5o
	 g0++Uk3AtnvBjEOn+3sag7P08N3ZlGwBXFtUIU6ntNpFq6dnzhqs+orrUtUcFSk14b
	 8W8AbgbPh+cNv1ZNV3MkcJSkj3AcXZvBmGiQG9gv4orDyLnZA5RgE5A7tQKMdgqt6Z
	 H2n7TMreWh30kG3vPpxyyERGM7lUM0qq5QLrjTDHM3Crx/krhpwscXgcAA20fzNuhV
	 hxU3EqCcBnlQyyAQgioRqZlTayQi/UrpLMbASE7QEvu0Tg/FrF7oMDuCIfNmENsFHs
	 SSMNl+q7AGofw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E073A40C04;
	Thu,  1 Oct 2026 11:19:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2E80432A
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 11:19:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 20518404FC
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 11:19:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zvNitVa30Vlu for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 11:19:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 360CB404F8
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790853549;
 b=QHW7Srm6HONEzjVzqdEKuH74sJgOQgyqb5TgaPlAbknoYFfjQKTDOKoMqh6rJGeI0f++
 0aLbgtbBALzxZc4e5VChp1GHHOh2CA8/yi2j+ZKt/MZ8bFrbQrpAznfBdsYHBGvn5qisY
 i2Bfo+yFTDiwuulHKyvzbAlFBhM8X7R4Z0jYlUd/BXUBPECJ7YDtKWT6XFz/sI8bpY6sS
 BjvoaGb+J07cDKdBZ770kxM146MwCeMACThbekTmYsTW7w2SghnrmHne+eVyLoVKxZFDA
 HYZSf01c3gp3glqWSzuhGLWmQnpsuwTwY6PhOICqC0arWgL+EZtSWVGh5jBcspleeiA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790853549;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=XP1E7c/0SFc3wu4KCWkohJX6c/IZsR3eDwm6CWxUeXs=;
 b=sOpxXJMXK56O+CnX4r1Gykf0eUT2zBvR7ktJ1q+cGYVGjSWmmS5VkuOpcIt7AmxWWVvA
 xVKOvcQtjInkZ8tF3i373xkqItRUlW6X62mOxfoRo+1nH3cdlv4I38lDGWbgzS0CQ0XaS
 ZPS48tE1Evy65HigvLJXg5WrLMtuoLN7qPEQjZ2ooRb2AQMrW5o4xttZLKiuFaW4I7Bw0
 0wJo1s1StfZNn3zJBiUSKIU0z3Z8QLIdTljrR5Zq2nmNBA0UbnoL97rBrnrlCjGrAY68a
 fGaCxEtiuzbkt88NeYojrQeaIPYKT9D3jWY1mzduPTG4hr1520u7yaLLvOvhmbNDi5g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=NXgAZEQq; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=NXgAZEQq
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 360CB404F8
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 11:19:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BFEBE601E4;
 Thu,  1 Oct 2026 11:19:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D8E1F000FF;
 Thu,  1 Oct 2026 11:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790853546;
 bh=XP1E7c/0SFc3wu4KCWkohJX6c/IZsR3eDwm6CWxUeXs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=NXgAZEQqpm69ciwqx8IO37G8y7z30/rfRfjqpN84GDx7qmM+THtqEiWWvH8gg/xbh
 cUVAXSyO9MUFZtUJhyiQwnFb1FZya6ZGiyXWKbROHOSt9zuYfTqe6PPE8CR48TPCvg
 YvKt1Htb6QnN573y0uMIJ5T8YxqqGesFKTsD/fSWPUBKDl63dzHRECEgL7wXUB32+n
 hdlxCBB8PEpY1MQJpI0fRHHY031wnR9UhNGnp7ggMcfdFKMRh6Ra4DT+K1Q+dUCV4z
 ibEdEHOGaPDe/DQgCkIyNQxw2xNYDw11St/WmGXqgpLnO5R833Yr/HdBdKCMrv4N0B
 8CbOnZ8JInPcg==
Date: Thu, 1 Oct 2026 11:19:04 +0000
From: Yixun Lan <dlan@kernel.org>
To: E Shattow <e@freeshell.de>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Hiago De Franco <hfranco@baylibre.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: Re: [PATCH 0/4] riscv: spacemit: Add support for K3 Pico-ITX board
Message-ID: <20261001111904-GKA51329@kernel.org>
References: <20260923-00-basic-spacemit-k3-v1-0-fa1015f2cd1b@kernel.org>
 <b9150c66-37f2-4348-98c4-92e5764e74bc@freeshell.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b9150c66-37f2-4348-98c4-92e5764e74bc@freeshell.de>
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

Hi E Shattow, 

On 22:26 Thu 24 Sep     , E Shattow wrote:
> Hi Yixun,  Add CC: Aurelien (per our chat about DMI on K3 and Debian d-i
> you may find this interesting)
> 
> I have included my report of testing this series with step-by-step build
> instructions, after the reply-quote. I was not successful to boot Debian
> daily netinst debian-installer ramdisk. However, as an aside, I did
> produce build instructions that result in the vendor u-boot v2022.10
> fork with additional fixes that is successful when flashed to SPI NOR to
I've not tested with SPI NOR, just using fastboot

> run netinst debian-installer and that success is measured as my baseline
> for comparison. I omit my T-by tag for this series until it goes through
> a few revisions and I understand better what your goals are if it should
> be successful to boot and run debian-installer for example. -E
> 
My current goal here is getting a basically functional mainline U-Boot
(with the network/ethernet support), as for booting mainline opensbi + kernel,
a few patches[1] still needed, e.g for opensbi, and the address overlap issue
also need to be fixed..

FYI, I've put all patches together and push a branch here[2], for people
who interested to test, some patches are just a quick hack and need to
improve later..

[1] https://patch.msgid.link/20260729-k3-mimsic-fix-v1-1-368c0aec04b9@pigmoral.tech
https://patch.msgid.link/20260918-k3-aclint-v3-6-cf4fd4050e14@pigmoral.tech
https://patch.msgid.link/20260817033038.2286436-1-guoren@kernel.org

[2] https://github.com/spacemit-com/u-boot/commits/k3/for-next

-- 
Yixun Lan (dlan)
