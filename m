Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1913C43458
	for <u-boot@archiver.kernel.org>; Sat, 27 Jun 2026 14:21:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A70B83FEE;
	Sat, 27 Jun 2026 16:20:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="GCsc39Bv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D24E841C2; Sat, 27 Jun 2026 16:20:58 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B15CA805D7
 for <u-boot@lists.denx.de>; Sat, 27 Jun 2026 16:20:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D3220107B35; Sat, 27 Jun 2026 16:20:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1782570055;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=ueP2QgbNfvJSRL6eO8C+4yFIkDBBAbjKKpeGncBXWLc=;
 b=GCsc39BvDcR5aYedEOigS1u06C4ZrniHGSWt0NI4K7H5+1LCQ5AvaDYL1zdX03PD56DCGP
 KAAz9KFO6ZLtHyvqDd+WjRnGnmeR4PIP9GgvYYTbqbGn7MW7jEMFvfsmUk6Es6FYogFzVX
 G+IPjCbht5xDHVKwjZ6ZBudlnJzGFi1g8XyZwGmgx4/Exe4mCL5hx4SNqKzaARnzgm5fIA
 VuTlZldtGC2GF7JH55C/Am30iz2RZv0JWvQ6QIeBfsz6pJ3iFgNxlMRz8DCFvwEfjijTrZ
 3iuWc45QPu5TViszdELzra5P/3qWo4F2PKdwHANL9XC8l+I0B8lGMedhcnVu1Q==
Message-ID: <df641e51-4141-4402-a57e-9b6ec5be2861@nabladev.com>
Date: Sat, 27 Jun 2026 16:20:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20260626
To: Fabio Estevam <festevam@gmail.com>
Cc: trini@konsulko.com, u-boot@lists.denx.de, alice.guo@nxp.com,
 ye.li@oss.nxp.com, peng.fan@oss.nxp.com
References: <20260627013852.3002838-1-festevam@gmail.com>
 <20260627013852.3002838-2-festevam@gmail.com>
 <ddacbcce-17de-4ee3-a5d2-fdb5cb4ee777@nabladev.com>
 <CAOMZO5A2NpxMxUbq5M2npFWYbhDfviR0DHYip7ChnpFNyVDJfg@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <CAOMZO5A2NpxMxUbq5M2npFWYbhDfviR0DHYip7ChnpFNyVDJfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 6/27/26 2:26 PM, Fabio Estevam wrote:
> On Sat, Jun 27, 2026 at 9:18 AM Marek Vasut <marex@nabladev.com> wrote:
>>
>> On 6/27/26 3:38 AM, Fabio Estevam wrote:
>>
>> Hello all,
>>
>>>         mx6: ddr: Subtract half a cycle instead of three quarters of a cycle after DQS gating calibration
>> I am not sure whether this one should be really in master, I would like
>> to give people time to really look at it.
> 
> Ok, I'll send another PR wth this one removed.

Thank you !
