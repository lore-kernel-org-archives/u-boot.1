Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD694C282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 22:18:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 926DC8168B;
	Mon, 17 Mar 2025 23:17:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OtVc6GmA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E04080F4C; Mon, 17 Mar 2025 20:58:18 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BB13800B3
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 20:58:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=konstantin@linuxfoundation.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id C6A6DA48D1E;
 Mon, 17 Mar 2025 19:52:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAAC9C4CEE3;
 Mon, 17 Mar 2025 19:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1742241494;
 bh=AlxtlVYy/C+LnO4okOT+mp6ozZVAD16hsF5Tx1yv31s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OtVc6GmA6i6kJeYFWZ2YIiZyDKR4qwz9zKgCHt/5uNX7xxQJMx9bTvV4Q9FoixLBe
 zSHLVf6ZatdzuMAyVtoGEfoVJqa16TFvMy4tPrdU9k9v/uzDNnNW8Qg4Fi4XX2daQC
 anTKbKYsJl7JGuagSC3xbPUSyoIewVGTKVnXhuY0=
Date: Mon, 17 Mar 2025 15:58:10 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Sam Day <me@samcday.com>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Subject: Re: [PATCH 0/6] MSM8916: Bring secondary cores online with spin-table
Message-ID: <20250317-natural-tody-of-mathematics-acf56f@lemur>
References: <20250128-msm8916-smp-support-v1-0-39587f18cf0c@samcday.com>
 <b72d521f-6df5-4ab1-a00d-65ab7dc14ac6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b72d521f-6df5-4ab1-a00d-65ab7dc14ac6@linaro.org>
X-Mailman-Approved-At: Mon, 17 Mar 2025 23:17:43 +0100
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

On Mon, Mar 17, 2025 at 01:13:22PM +0000, Caleb Connolly wrote:
> Hi Sam,
> 
> Can you re-send this without all the prerequisite-patch-id tags? b4 is
> desperately trying to apply ~140 patches from some old next branch to my
> tree and tbh im not sure how to make it stop.

FYI, this only gets triggered on "shazam" so if you want to avoid this
situation, you can just use "b4 am" and then follow by "git am" on top of the
tree you like.

-K
