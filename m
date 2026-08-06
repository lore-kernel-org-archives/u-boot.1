Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B76C5AC7A
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 13:05:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F197405E7;
	Thu,  6 Aug 2026 13:05:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FPOqokFnInbO; Thu,  6 Aug 2026 13:05:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AB6DA4076E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786021514;
	bh=1lV3DEim4tEU+e9WMTE0SKAT3hrqCvejMXiRdmRgmSE=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Be8QFxNEjJx+i4vJrkGuNmVH9CQWHL4ZR/t1zewsFEpg7eDPdVJ8qMbOnUvfJTohp
	 bXZcvCUinwNw+kXuWScdrD0nYIFaXOYuGCn4/eMF/08wt7un2OCAoRTHgoSWSjSPih
	 6SskEBSzWOF/wwCXRSj2rqIoOZ9Yn9UQcdtOi4Avf65cZQbKy4VnZd3tgsLDi5s3JQ
	 Bz/f2v2lH1uysTE2Pty06mCBcoS+CyAErs5+7xRHWrNT063TL893D6pCijdeAp/B3b
	 GmD1MJa1ghk4NwuYC0sezfRD1CJ7dTEfnpJLQsJdUnv+mHRSk65LuEy7qMvGR+lekG
	 y+JHGvEKAyZtA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AB6DA4076E;
	Thu,  6 Aug 2026 13:05:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A57B9397
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:46:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 96FD16072E
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:46:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PpzaYntLYZLz for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 12:46:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.92;
 helo=sender4-pp-o92.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E67E560624
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E67E560624
Received: from sender4-pp-o92.zoho.com (sender4-pp-o92.zoho.com
 [136.143.188.92])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E67E560624
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:46:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786020370; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ksX4vjYeh2OKufbi4thPVkVjVWO8z4sv2Yp7wUK8oE13OFIhe3s8Cm/UOJ7s780OX+67VCIpxQ3zEuyw4BPIh5yeX4cdIHxQAw5GYR439lJ+Iqd0COUPmJamZQ9aSkgQJzA24bdUbQxcgpMkK6B5ReKnyorTR0TQNSYYKsU+GVE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786020370;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=1lV3DEim4tEU+e9WMTE0SKAT3hrqCvejMXiRdmRgmSE=; 
 b=QfSSdhHGvkgjXjwo9SQuToE7E8LQrCI8N+UvPZxTR3YAj30V7IaRveN7RJEFtOdCFQ2i9xM1YusH8ypmHYoO3CBN/rrsR/YpHhoOSo7w8iQxERYndvNh3x/OMzVddYXwvsYm42QsGrW0EZzlwbfwkecIZm1d8lU3rINIG9IfkaQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
Received: by mx.zohomail.com with SMTPS id 1786020367366834.9241631930331;
 Thu, 6 Aug 2026 05:46:07 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Aug 2026 20:45:50 +0800
Message-Id: <DKHVDI32ID6V.20VKLNC25BX88@zohomail.com>
Subject: Re: [PATCH v3 4/7] riscv: milkv_duo: Use upstream devicetree
To: "Zhuxu Ran" <zhuxu_ran@zohomail.com>, <u-boot@lists.u-boot-project.org>,
 "Yao Zi" <me@ziyao.cc>
Cc: "Lukasz Majewski" <lukma@denx.de>, "Tom Rini" <trini@konsulko.com>,
 "Peng Fan" <peng.fan@nxp.com>, "Jaehoon Chung" <jh80.chung@samsung.com>,
 "Stefan Roese" <stefan.roese@mailbox.org>, "Hiago De Franco"
 <hfranco@baylibre.com>, "Thomas Bonnefille"
 <thomas.bonnefille@bootlin.com>, "Kongyang Liu"
 <seashell11234455@gmail.com>, "Tim Ouyang" <tim609@andestech.com>, "Leo
 Liang" <leo.liang@sifive.com>, "Guodong Xu" <guodong@riscstar.com>,
 "Andreas Schwab" <schwab@suse.de>, "Junhui Liu" <junhui.liu@pigmoral.tech>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260806-milkv-duo-upstream-dts-v3-0-917cf70a2337@zohomail.com>
 <20260806-milkv-duo-upstream-dts-v3-4-917cf70a2337@zohomail.com>
In-Reply-To: <20260806-milkv-duo-upstream-dts-v3-4-917cf70a2337@zohomail.com>
Feedback-ID: zu08011227fddd90216f9a2b735981a4480000f232fbb7ffad33b18a5204a03536372383eeea908c40f3c64b:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Thu, 06 Aug 2026 13:05:01 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; t=1786020370; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Date:Message-Id:Message-Id:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:Feedback-ID:Reply-To;
 bh=1lV3DEim4tEU+e9WMTE0SKAT3hrqCvejMXiRdmRgmSE=;
 b=ff9P88DdGHdpxvAm8jPncRQARv9RbqvmrCaTl5c5DvuOq5szHCg5HBlpczjRuO3n
 SdU50VFqxGbf9U6WkYMyDtFLw15vw56FgAZGvuefIzrzyYAOZj8XNYCZWSEUvClMlCB
 DhDuQvkhzQNv+sEvPA0vIn/1iwv3ltuVmUb1CwxQ=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=ff9P88Dd
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
From: Zhuxu Ran via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Zhuxu Ran <zhuxu_ran@zohomail.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Apologies for the oversight. The following tag from v1 was
inadvertently omitted after addressing the SPIF concern:

Reviewed-by: Leo Yu-Chi Liang <leo.liang@sifive.com>

--=20
Best regards,
Zhuxu Ran
