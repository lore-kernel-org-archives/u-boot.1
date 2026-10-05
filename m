Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69431CA5FF0
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 08:01:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3778780C8F;
	Mon,  5 Oct 2026 08:01:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yE3ruE_dPbLB; Mon,  5 Oct 2026 08:01:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 893A180CB0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791187309;
	b=Ffx5HW7I45IIuYSX7KfWzaMQkym7uJaJ0WMMNHSKVV51OPnk6rc3z7K3Lll7jctexTZt
	 fPAXr1d4Qk8RMIkoUqS8yx6Nxc9OPyMmqbkGE/txpwdM09lxmSh3XiQLfF1i9Vgv6wh/Q
	 9n/ozwD3eciSN89IsAHaxqlvX7OKelVBsJTng81pVhfuS1oeA/tHaXiOhdbEs9f83IVz7
	 5jvcSelZr/DufQ+YUpebdMbEDPZ002oTqyECIJP2cS7uUpF0hUafl3Y7EUi5sPcknelRY
	 WXajWllXcP/dmRxMjHuooCOp5r+fGJpKIA3wYi7CivmwaeMTiH6eI4lMouO1USSD9eQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791187309;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=R5Sqma73s4A74ihj491dheLFEFjoRsu9rVvdRrNiPVo=;
	b=nc1GzKxKisgzUZhCAJPJZRqJaEsHAKy7pGQGL7TJv7wqZ9JXwd/121E7Oh7r5Xd0rrLV
	 cw8CU5wtRl7cenLtrh4xUKo44TAikeKt10Y5xxYhesnpRmbudldi/haBFsr8HYCNL55/d
	 gxBwhaVuWmFhFk0IqpHRb4v/esprQolY/qoM8brgItmQgHUS+LlvigTLdS6LQV6eDYOlr
	 +C/bh/EmPZmoyB+6tjjLp6KEyTDCrx4HHP9Mt/JO2fSZ1/YH76m0KKxREt7b9D7eTZRMc
	 j2uEBvr1HW0hHP89h4XhAEBI3wVNQhy3uqP89UmgupdYMFQyPmnTT/cweEtE+IMosmw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=wDdpQ3Ur;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791187309;
	bh=R5Sqma73s4A74ihj491dheLFEFjoRsu9rVvdRrNiPVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jldfCR/utlIBpL6aGacoKYtJJZnWigapXtKHGA6Y326Q9Sb3E1kg4Al5oYMvENqIv
	 lZ06dlOAU/T17typaqZbqM5GXZITBy85s+d17ngNZ1xpX5cup/UXjoPiQMVyMI/+OX
	 vNlixts1z8UD9o1pqYF6wDs1OQ1wqkg8h6cpSETI4u7tqQmuxTvG7nQQqsWuxSrAYw
	 LS6xl15G71axnSgBc80Rwbq8av+u9T/gO3OwR0wLDrHzx3e6An/LVSdEVqRY3zg5qM
	 5zRZA2hCiuZyz+npevdADv/vzxFRG1FT5cmGMxpmDffn1og3Ycz60m1KDoeSp/hBmq
	 +HBJ9zT8tMZ/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 893A180CB0;
	Mon,  5 Oct 2026 08:01:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D165375
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:58:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B812D80B89
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:58:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TPXtXbC9P1Cp for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 07:58:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C1ACE80B33
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791187103;
 b=HADsoN9K1rceCAez2XMR4N3nfvotVnbb5vUMlC1hWEuai0mRW+182RTPdTF8nU2tRubI
 rBcNDv52iUpUHUMCnvZXDIgG0zIk2H2LNXuiQeie8jzAFEHr7lZNiQDbtoh94uoKqnLar
 GqCxkgSUbk+q/kvXCJn5RaFqtLL+2KFzsszM2zWVTjT/5yEkjb/OA9BXz4kDDYC/FLEST
 GhA8JQvy9+sqEpJAeR4uYzCgnsCrzOcFS7qAZaYn2rgcQpSEPOi7xd0ZqYJelR2kSfgkP
 KURjudJ7y9mouLIel6KG2gm0d0/VrS58FWc9Mt81AjWl6XmHpqCkJvBAwiUij5KC0tQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791187103;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=R5Sqma73s4A74ihj491dheLFEFjoRsu9rVvdRrNiPVo=;
 b=NVPb7PcGyWjQzfq4KoBX6HDMl7uyLir7Js8vOKl5M3S53OUCVm9rZHPAsWEjFz5xbT/A
 OUSmswHZfoVl024bFu2u45A77fVS2EErpcjMt4DqmEBXQdfYkUpgO95zEI0rgMdbdbv7h
 V1g+/GdR6HGbzKRYqFk551E2vtL+YcSL7SqS38Geqt6rt9UmwYaMKDXade/eNpH6ge6/V
 prF1SYOiaLDnPQs7Y8uhjYuaXjmj3Urq4JrJjY2RyBoXtjEGROuZ7BqGAnVoo8yW3lfTm
 L08D+az/9Pd9hkdNo0yPCM8q1/tHOqSnqcys88budo+TXyS+zpxtPSjZjwllXoR6LFg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=wDdpQ3Ur; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org;
 envelope-from=stefan.roese@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=wDdpQ3Ur
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C1ACE80B33
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:58:22 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hysFl3f9gzKp42;
 Mon, 05 Oct 2026 09:58:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1791187099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R5Sqma73s4A74ihj491dheLFEFjoRsu9rVvdRrNiPVo=;
 b=wDdpQ3UrOfCWPWytF0d4pBu/fNbUx3HBUV6HbdeXQCCWP3fQWfrRqOHObdmMfur+54hqPE
 vPCiFisXPKiPXUDzqNRvFgsfTBaNA95qIJqd1Y2iHHYEF/vssZ2iGYsL8rhqyNRuaQHEB8
 Tjgln1EMDTBAUAjMQ1o1j7U1HAo6uG3WqNGISrZe6Rykxu5zAeW1TXtuGyXJbP8GtXgjJB
 SvhZDU2oRTL2BtKnfPM0gQmNKbCYJxILE8xSDX2c68ddA6YNQIaMG1jpjNfWPUhuoasOxn
 MHB/si0FScUVkxzCn1ma5P7lfxKtBvR4EBF0lnBgjdMyfqso7izPE+IHLpIOwA==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Igor Velkov <iav@iav.lv>
Cc: u-boot@lists.u-boot-project.org, Dennis Gilmore <dgilmore@redhat.com>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] arm: mvebu: helios4_defconfig: enable the RTC
Date: Mon,  5 Oct 2026 09:58:08 +0200
Message-ID: <20261005075813.601288-4-stefan.roese@mailbox.org>
In-Reply-To: <20260930-helios4-rtc-v1-1-0e6ea4ce400b@iav.lv>
References: <20260930-helios4-rtc-v1-1-0e6ea4ce400b@iav.lv>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ufsgg4ejewtwf75m5he9dukzfiqcsz98
X-MBO-RS-ID: 6b7aa3d9d596e7ef313
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

On 30.09.26 19:26, Igor Velkov wrote:
> Helios4 has the Armada 38x internal RTC, with a battery on the board.
> Enable its driver so that the date command reads it.
>
> Based on a patch by Aditya Prayoga in Armbian.
>
> Signed-off-by: Igor Velkov <iav@iav.lv>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan
