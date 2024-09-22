Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD6DCF9C6C
	for <u-boot@archiver.kernel.org>; Sun, 22 Sep 2024 15:33:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C941E88C45;
	Sun, 22 Sep 2024 17:33:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727019219;
	bh=zv/yqtka/you1Qkm5jsMTDY35AhLHoELxMa8OFLFtyw=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KmbXQzZR3u72dBmdZtZLzOqDkS04+jd/T3oAwdAQDH48FfKLG2KL7qPBYdk81t/M6
	 ekdS4nNZR3VmCUzlbG+2xf5lMH3ZclfS7ok4oUkold3uyOEIxHf+FuGhPBzDrgc8Jx
	 0yUSsKvPmW/G5NsHhLGloQQMICvA9XIHk0BVfZ9uudPvBwCw/TFSsJWuR4w1hkF0wR
	 xoObWH23x6g7gKHvJvRk73L91tp4Fcpprioi0KQdrfPjy+aHHVylu8Dxy6IoRHScGl
	 WJdmi5LVe9scoTqeAV9M3X44iJwT9cXUhjVKAYVnskSOGEHSiGq6jK8goDp9o71cXX
	 CUnxnzR7Sbiew==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 7F35A88C41;
 Sun, 22 Sep 2024 17:33:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727019218;
 bh=zv/yqtka/you1Qkm5jsMTDY35AhLHoELxMa8OFLFtyw=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=YbIirGHxRyoSabp9VLKJCshYIWZFq5QKhKA+z+DAeBxDAFd6RzUYAnTrbiMc3I4cj
 779DIVdi6JDCxRFbSsA7mmJG/sEGkMUqwm0+1gO3/CMZan9pWoi2AUb1ExEe+vYOl5
 FNUoZaHEDH4a+gcRQUvKPZQK4/5oQ5G5PtP4rPQBUBjDL4HK0GcUmxx5p+/dp5CPx4
 nAYssGSBF4yiHcdpKRkGki8xkjCD/B6XpmzlTZb5sCul496bhFCdhMhZSha7J/RvJI
 a/Dq5mFfSQhJrs9m/BrEgH5GzLv1DqYXzZugTgHX8WWUHL+7BF/ZNCFj39KXFda9oP
 fyiYtuegKoIUg==
Message-ID: <87b42397-6eb5-42a4-81a1-5008142d293b@denx.de>
Date: Sun, 22 Sep 2024 17:26:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] add support for Enclustra Mercury AA1 SoMs
To: Lothar Rubusch <l.rubusch@gmail.com>, u-boot@lists.denx.de,
 trini@konsulko.com, simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com
References: <20240917062157.3181-1-l.rubusch@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240917062157.3181-1-l.rubusch@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 9/17/24 8:21 AM, Lothar Rubusch wrote:
> Introduce the support for three variants of Enclustra's Intel Mercury AA1 (with
> Intel Arria10) SoMs and additional configs. This is supposed to be the first
> step to upstream several of Enclustras SoC FPGA Modules. There are still things
> to be modified. So, this is supposed to start the discussion and also to
> clarify some of my open issues.
> 
> On the DT approach: I can agree that in parallel I may go for upstreaming
> the kernel DT. There is a fundamental difference, still: In order to
> represent the combination of module + baseboard + bootmode for the kernel
> DT we have to use a mechanism like DTO. For u-boot this can be simpler.
> Currently the few adjustments needed will be represented by the DT files as
> are. I propose to keep them, and in case remove them later, which I doubt,
> since the full DT for the kernel will cover more details. In case
> refactoring is needed I can update the DT also in u-boot.
I assume after the LPC discussion, there will be a V3 ?
