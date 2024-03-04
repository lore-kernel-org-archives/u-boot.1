Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC7F5C5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 13:35:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C84587D07;
	Mon,  4 Mar 2024 14:35:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gerhold.net header.i=@gerhold.net header.b="qbq7cBr9";
	dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="zfTxNT5P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BE4587F6F; Mon,  4 Mar 2024 14:35:20 +0100 (CET)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de
 [81.169.146.165])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAC7186F1E
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 14:35:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=stephan@gerhold.net
ARC-Seal: i=1; a=rsa-sha256; t=1709559290; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=KhkAuCYzgCfvnkqazOS4Q3rH8/Zosg/yRYHIs71vWuBBd1Z7X6Y8hEs2yzCkIdHBS6
 QJ4rfAw2tgmoOUM41ytSLbQFtlP4KrTzOU6+sFl9sD+ZaOt0VfQvGGphYrNGq5VVTJGL
 ZSPMqPqfcIMDB3lKtcq3rUniHjqadKEZ1+hpzx3ZwTKyf4IDzG9iasTGFKMKIZC0TZA/
 qRLuCLYTXfdhkcUQCrKzEJ+glaQdbATIT9D9TpBukPhNZ6dUKDa8g1g0H8qXAX7icAHX
 84pIb8GYSuMWPrHryF1KnUU61I+za06O+XwdEZ/d4MjrTNgiaE+7liNKFRfnPXmVpe2h
 2y3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1709559290;
 s=strato-dkim-0002; d=strato.com;
 h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=4DQVzBxz5TytJ7soZFbPEm9RQNEhKPVSfQifm8IOsYA=;
 b=rR3XP28nrL+jzlDjRB+UDNcJ+PcxCgGEmiY2Gv9C54znpBt9Og6g7Cq/f31qHSbHbL
 9z3m1xzc1xeA3Y0kvT8gCv7hS/rO9npHxGKAKBmAMBKJECWgCJWqfrrhMPZxdMTfSp0f
 OntVGpwkUtzi8jU2GbkZyXtn/RcA+pTlguQhEo0RQ8Rx6hFbgFTUgHzYdLWSHm16ub9M
 KoPN1w+vMahTUPz04m5CkyNocyHtURmlomvfmNS8UeB4O474C4LTfTGIKV7/T1LI5d73
 xvKlxOb7UHH99sicO3+dqCCZ4ozzng73qagWUm93Mv7DY8pfuz1+eoHHdoFOvi/0N/PQ
 KRJA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1709559290;
 s=strato-dkim-0002; d=gerhold.net;
 h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=4DQVzBxz5TytJ7soZFbPEm9RQNEhKPVSfQifm8IOsYA=;
 b=qbq7cBr9YOOzJb7odPW89Er2gVfUKtLc7ylQsMt8Q2iJo/39Q7pDsUcF3iUWf0aU1j
 oQgcLqmkCBLrwrL7f1sRu4JqaUm4pLKSb45F1g7zlUhhg2+pd+c8ZLJRErB7J+rURXvz
 v5c4KG2Is1esxRVjCgqCvtgEL3vzuxeWRN0HPFQeMMxW3V0zTl/XcrmZx+Nd/ugPfSLW
 mBJMKwG93maJtYSj7YcBCJC0rWMtOx8gnQTbGQngAJlW5l8f8EyxP7qFvH8mCNP6NQxZ
 jeLXwbLyy5tcKl+fKZpvp1h+qEV4O94KngleluiwrZCp3yJ9QUjJ27FikHEsjbFrqQbN
 HlFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1709559290;
 s=strato-dkim-0003; d=gerhold.net;
 h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=4DQVzBxz5TytJ7soZFbPEm9RQNEhKPVSfQifm8IOsYA=;
 b=zfTxNT5PIcLc7sJnOJ4D35hv6xOwTFexOXjxqJaCDIDLxAjWmrfc0mDciijgnyQHcA
 uE9PRWO0wlYX9JbQG5Cg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8Z2L1A=="
Received: from gerhold.net by smtp.strato.de (RZmta 50.2.0 DYNA|AUTH)
 with ESMTPSA id ufb408024DYmEaH
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Mon, 4 Mar 2024 14:34:48 +0100 (CET)
Date: Mon, 4 Mar 2024 14:34:43 +0100
From: Stephan Gerhold <stephan@gerhold.net>
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Elmar Psilog <epsi@gmx.de>,
 Joe Hershberger <joe.hershberger@ni.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Ley Foon Tan <leyfoon.tan@starfivetech.com>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Yanhong Wang <yanhong.wang@starfivetech.com>
Subject: Re: [PATCH 0/8] Add support for Qualcomm SA8155-ADP board
Message-ID: <ZeXN7EZHU89qS5PF@gerhold.net>
References: <20240229142043.1263690-1-volodymyr_babchuk@epam.com>
 <dc97490e-4029-41e2-bbbd-b1351f5cf9eb@linaro.org>
 <87bk7x6c88.fsf@epam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bk7x6c88.fsf@epam.com>
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

On Fri, Mar 01, 2024 at 06:25:39PM +0000, Volodymyr Babchuk wrote:
> Caleb Connolly <caleb.connolly@linaro.org> writes:
> > On 29/02/2024 14:21, Volodymyr Babchuk wrote:
> >> This patch series adds support for Qualcomm SA8155-ADP development
> >> board. Main motivation for this series is to allow running
> >> virtualization software on this board and U-Boot is a good way to
> >> break Qualcomm's boot chain at EL2 with more convenient ways for
> >> uploading and running the code. With this patches applied it is
> >> possible to upload and run Xen on this board. KVM probably should work
> >> too.
> >
> > This is really cool! I've experimented with this on SDM845 and SM8250
> > but never really did anything with it... I'd love to take a look at your
> > Xen branch?
> 
> Honestly, there is nothing to look at right now. I just implemented
> early printk serial driver for the qcom, made hacks to the device tree
> and trying to boot Dom0. I already expecting issues with the GPU,
> because it has own SMMU without virtualization support and Xen already
> complains about it. So I had to remove it from the DTS for a time being.
> 

Did you enable all the clocks/power domains/etc for the GPU SMMU? If I
remember correctly it is off by default and all registers read as
zeroes. The SMMU driver could easily get confused about the capabilities
of the SMMU (e.g. the stage 2/virtualization support) if all the ID
registers read as zeroes.

Thanks,
Stephan
