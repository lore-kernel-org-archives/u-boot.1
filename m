Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FCF2C531FA
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 09:16:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A148060B51;
	Fri, 24 Jul 2026 09:16:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XU4zhFyRrLYK; Fri, 24 Jul 2026 09:16:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AE44E60B07
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784884563;
	bh=8Ic2rPc8uScbn0jj/EBfUV8OoMHpSBmHC89Kvwq88lM=;
	h=To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=j0EbZwQup74MeiHXXiFZPbeGI5kdaYOJ+oQw9jNdtHa1WwWnIlaUYo64URIKpeYAL
	 HIOek1WeSerHxGWopSClsDCYXB8ZcbucRQrhuuBWLBBKPAOMPnz2jTc+IscQ8QnoNS
	 TjtkqmaIuWDVmg1s6ahEKWEfDhrMqSu8485Jr7Nk0EEtamy7r5Xqj1ZubpNRry1CpE
	 jw5U4ydCLKK/vBOdffO+NDIxPupQQh4JY5dH+FM1mUtNYZo+DIoh8Ml4s2RFemM7yY
	 F1fLeLoVMeoEE1Y2n44UqmlqDxnYYceNbqcs2xAMzd09SCZeXrq35tKEjaRoRStnvX
	 IlJm6TYrMtQjg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AE44E60B07;
	Fri, 24 Jul 2026 09:16:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0037F224
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 09:16:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D79F540A3C
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 09:16:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3rLIs5WbHycc for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 09:16:01 +0000 (UTC)
X-Greylist: delayed 481 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 24 Jul 2026 09:16:00 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 6F3724097A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6F3724097A
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=83.166.143.175;
 helo=smtp-8faf.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch
 [83.166.143.175])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6F3724097A
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 09:16:00 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4h62Fm2L3Rz4Bp;
 Fri, 24 Jul 2026 11:07:56 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4h62Fl47vnzTtV; Fri, 24 Jul 2026 11:07:55 +0200 (CEST)
To: Fabio Estevam <festevam@gmail.com>
Cc: trini@konsulko.com, sjg@chromium.org, kever.yang@rock-chips.com, 
 u-boot@lists.u-boot-project.org, Fabio Estevam <festevam@nabladev.com>
In-Reply-To: <20260722184024.1210447-1-festevam@gmail.com>
References: <20260722184024.1210447-1-festevam@gmail.com>
Subject: Re: [PATCH v3] rockchip: rk3588s: Add support for ROC-PC-RK3588S
Message-Id: <178488407555.571705.6522380924183788823.b4-ty@b4>
Date: Fri, 24 Jul 2026 11:07:55 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Infomaniak-Routing: alpha
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0leil.net; s=20231125; t=1784884076;
 bh=8Ic2rPc8uScbn0jj/EBfUV8OoMHpSBmHC89Kvwq88lM=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=VTokNyZexyEJIHFt/j7CRWPSvjQSvufr23Aqy3dnrsZYIHV4/j0X6aAU0JZGmRI2R
 ABG3bMqX7xiTMwNw4V9+WnE7M9Mv8Y0Ae6Ok8340zZeDgI3OUs2IJYGGlSu1Mlakdy
 Lgk8Ze9FVHxqtn+OCfZfk4fQIiHV3Y0UXrJapGe6p8OfH2Vq6wfa+vmveOMM2cYKGn
 ZZtIFnoQ5pbs4F78fkWtraAFudesnIEfvxQHz9B8+OwgcFSjkG+zYUwXqKAxBuJ7AA
 D353HHM+fMAxt3fu1o5yDbZfOQ9imZYICAJkIfPA3N2Z3Icc3mWHcZAEwCrJYV8i7R
 OlriJbjd3z9cA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=0leil.net
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=VTokNyZe
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
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <u-boot@0leil.net>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Wed, 22 Jul 2026 15:40:24 -0300, Fabio Estevam wrote:
> The ROC-PC-RK3588S board is an SBC made by Firefly, based on the RK3588S
> SoC.
> 
> Add support for it.

Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip (main), thanks!

[1/1] rockchip: rk3588s: Add support for ROC-PC-RK3588S
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/15387d5a90af01eb52f0c18cd83e358ba19c0a7d

Best regards,
-- 
Quentin Schulz <u-boot@0leil.net>

