Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40550CD495D
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 06:44:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 731BB86B34;
	Thu, 21 Sep 2023 08:44:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1695278681;
	bh=simKbbI3MNLZBb459y7Fx9uXlywkzUinsdHjLwcs6DE=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=y5PV4nt6n79SE3QuMEwP8Tq+ugUfAeYs7KsfvnMKTSq9MRwcm0FIB4b6gKqIz6hjI
	 2Ly1Xu0v4aXBso9O0oOqrnZa0m1YSowAbm9s0yt67x064gIg0A/SfxZamv6jxEtNkl
	 +j6N23VDy3m9VJ3pZ6nGIAICnOuOpTHrOPyn0t11sRJyfbGYeAHsDIB7NdIMkpuqfP
	 wxEyFoCkdo5FrHO1eKUj7lXTWH27ylR09QMEOyZmuJuh4I2Q6V94HzEYjZ/6hiIURA
	 E/eGCQNZTDeihG/Qbyep4bPW5f3tlJwz1pYe29m2AfeIEyuXqqLNzOeRuLJa+jJI6+
	 oHp1NSh1VkQRw==
Received: from [192.168.1.107] (87-97-107-112.pool.digikabel.hu
 [87.97.107.112])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 131FE86898;
 Thu, 21 Sep 2023 08:44:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1695278679;
 bh=simKbbI3MNLZBb459y7Fx9uXlywkzUinsdHjLwcs6DE=;
 h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=RByccGT6fhDvKkDKF1QnDl/w8NZHnyyO2fi8fIZ69Qctdopmbxltp3xBEGgNyfa8U
 okNBrmP3tWM6qIn2rq2GRD178C1DONJzuZEIaHqaO9SQ13gebzD4zl5yVWAgNwoFAY
 YnWHJyL0Zal20kqlbUQU/wgtLeoH7XaEUDgmH6Z0Zdgo0ZCurwo6GIO7q06kVwLjj1
 0i4JAFTTIzAnU6HZ0xTOfmgUqeoor21KzcZZANcrZZWGXHCFertdignrjPWLtML4SP
 yHI3A9QXnIzSR3kYpdcQ/IgyArmf7/CRHqKyPDHIDLWwgwqYSsl2ActhGMwXNIGoYn
 sj2JPKND6DgBA==
Subject: Re: [RFC PATCH 0/4] mtd: ubi: Enable accessing RO filesystems in UBI
 vols
To: Sam Edwards <cfsworks@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Kyungmin Park <kmpark@infradead.org>
References: <20230812000606.72319-1-CFSworks@gmail.com>
 <5e986e31-388b-3e48-2a48-04bbd61651f0@denx.de>
 <1e85f9ce-f3df-fb56-9855-59fb7cb70a67@gmail.com>
From: Heiko Schocher <hs@denx.de>
Message-ID: <1efdf69c-f359-7333-6e42-2f1ff6ff9b8e@denx.de>
Date: Thu, 21 Sep 2023 08:44:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1e85f9ce-f3df-fb56-9855-59fb7cb70a67@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Sam,

sorry for the late reply...

On 07.09.23 23:46, Sam Edwards wrote:
> Hi Heiko and Simon,
> 
> Thought I'd follow-up to keep this discussion going. The main thing I would like to decide first (as
> it lets me start relying on it in boot scripts) would be the UBI access syntax:
> 
> => ls ubi 0:rootfs /boot
> => ls ubi 0:2 /boot

Looks perfect for me.

> Do those look good? Should I be trying to mimic the accepted syntax of fs/ubifs/super.c:open_ubi()?
> Perhaps "ubi 0!rootfs" and/or "ubi 0_2"? Not using ':' leaves open the possibility for logical
> volumes (LVM2/UBI) to contain partitions - not that I expect anyone will want that. :)

Good question... You never know... so from my side, yes it would
be good to allow both options ... so "ubi 0:2" and "ubi 0_2",
something like if ":" is in use "ubi 0:2" else try "ubi 0_2"

Please rebase your patchset when 2023.10 is out, thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
