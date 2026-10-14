Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF781CC6B2D
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 21:32:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ADE1C407F3;
	Wed, 14 Oct 2026 21:32:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IIlogXr0Lscc; Wed, 14 Oct 2026 21:32:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5E60E4077B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792013523;
	b=cO15gxte97ptPZ5EOaG6Wza6EYLNHEznOqL8j7xI2nNvZ7GTZjkw6/1jwvSt/cGd1Wr+
	 u+qhVRLpJkb8cKg6AK8/3igLTSjTa96z/soKNZPszmyReuWINMTSQGgqoHmH2LNLjz+2V
	 FiNjKnrkNXRBiov0dqIYqVoH7JYVTkOY+Xhpp/Ks0jP3hS6e7J+MIWrkMHUPzZNK7o7H5
	 vrxCbWHpz+u/vegIq2x4H5COuDIgrxPZ/RyYS7CwfZ25l7Sj7scvDsBWoGzy+feDyBsOs
	 vXbyJqCD7mVNx51+0iAzxdjMeVG4hVb53z8EwYGJnbZSUQrfmaFXL9Qy9a3KijMDttw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792013523;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Q41OXcukKYuIAA4tfvtkk2UhbuPeB9G2DzbSO0CSvYU=;
	b=Lm41+bbgLR0hE0Im14SyYYHL/wyODj2x3qD1xkoTbyoGjT/ApS3phyuolouVtOGFcIlw
	 SSvLccWq2WzVZoTIyLSgecQ0+BX7DE0+muE8LexbSROz5f6gRKUIjQ6HimyTQUOKp4QK8
	 ZLRC7yuO+2TxiHg4SiqpYpelMoCL+y17uArTUdWylKJQTnT9z4xf1rcvI/Cpe69zJjdLw
	 IkWmXEeh2d+LbdjkOJDQRBhsKrY/Y8mYqZ6OQRylmKuxMo1q1K9GMhdfTD9MyDeNsu28G
	 gVebDRJdzk9tkLxTXl6bCejv0BeudemkVyAcFNZy/7DdLyRO45MYdG6Q0ygdEBhZGNA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792013523;
	bh=Q41OXcukKYuIAA4tfvtkk2UhbuPeB9G2DzbSO0CSvYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MmE20r65uHd/8k/MarmBcnIHVJzA8R8Fkyg31X6JoVvXx9qiD1rm+jL2d9303vomG
	 /8+q0SVEJxXt1ItbgKN+jarj6zL05QFUBMDP+8DpJpzKctxDP0V/m5PpXnkZ/i3TmP
	 tkwApbY8z6KU3t7JW/wJjewAVlnzPN4FCbaN3bfsaetpNr67u8nPjDeZ7MDI6Uirr6
	 Q97GbWMDuwhWTcEDvo0NmHHnuVrQhS4Viu924R0iZNrHKWzl+IS8/syhhVlU1ObmIk
	 TlclDmApRJk7/62mM98lH/AFQfBwJ3tiUqRjBaY+P2qHfs1FWaC1g4zeAQkjDJqHsJ
	 BBrYXo6LoZVHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5E60E4077B;
	Wed, 14 Oct 2026 21:32:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7F06A1DE
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 21:32:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6583C608BA
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 21:32:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HToi5NS-aCQR for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 21:32:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DE0CC608B6
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792013521;
 b=PPIKLCXEePlXqFdvBe2zNd3kuGe/z5dgZNh6m63XqfUft6saemgUQk/d3BPEj8nXDQ+R
 HKCL7yqlzd2NZ/N79+9zqMvykjXiGM51pIKOH2S1Fc/m/rPJJrPg/lzhemzGJVIay/tfg
 QphzKZslNmNonUtsn43DhHE+GWQs4wLRwPdk1Y5ghi5ulM7XKFEJ6vyLPIx6y2CieLDVA
 zlVpnbOUVHd10KNMNx1znE+YssyFZite2+htPXvMqXwvgFx3CmFf4tutoAGP4qqazyNDg
 zdyzlQWVrj/WfYYg5dlemFV924378AC0LYL5OIAfZR7LmR8LKrSVDm5TgQ//jAvfUPA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792013521;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=Q41OXcukKYuIAA4tfvtkk2UhbuPeB9G2DzbSO0CSvYU=;
 b=fb1yHSte8wJJhx44GdteleD1igb6ReVaAj+pz5Z9WMI+3udNVmHXyhkxrr/MpqWrQ9N0
 L0+NUFP1ooYk4w0xKtTp+frNfLSvpgXp4lFJxt+b8+9JU5MHwsHgnJyw/UhByPu2Domry
 MRpJZzPmwrE0qOK5u749M0Gks3qP275qfg0hYnh7/2GY6lGbF52fLmqXnN9BQf5UkskPy
 AcAFUWYpUS6K3EHRD59J8QbSBnrdUOcU3dCGx8W255ORlkE/TES5PcB4LyAIule5KrhQ7
 mOVPmKallFC7zGWog+onkM1Klf2vBaV1YwdDZk4istzI0P7EoyVJwmgg5Q2fYp941sQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Oj9yekGa; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Oj9yekGa
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DE0CC608B6
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 21:31:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 095494479E;
 Wed, 14 Oct 2026 21:31:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D371F000C4;
 Wed, 14 Oct 2026 21:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792013517;
 bh=Q41OXcukKYuIAA4tfvtkk2UhbuPeB9G2DzbSO0CSvYU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Oj9yekGanBeH02Kf9sY0TMG8FSrEuOrjyKbtrMcVvxnp/XD35husCoKu09Rz2hKc6
 4Z6/4b8JhiXr7S9AqsKRHzYnAnUJ2ZUt47g0Fw1jxyKFOfH4nDcJr6OO5gy3Hu7bfA
 TjMW3DV4R+0k2OFKPrRcoxkXAxa5p5p4ITUBOiMsc+o5tGneamDPvDjpDXWLDc1xGS
 TheEgDdUVldcC+StGNohbn/kYoEwyLldV5Dm6guVOn+p0KU0ZNFFnho+edg/h7/ebh
 Jnt31zlhkKa/7eCfz0CEXhQiiE/a5W32o1Qr+0uizGUIGonHddnRCbXYVO51UIewkS
 whU+sQWa6J2ew==
Date: Wed, 14 Oct 2026 21:31:55 +0000
From: Yixun Lan <dlan@kernel.org>
To: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
Cc: Dave Klotz <DaveWK225@protonmail.com>,
 Zixian Zeng <sycamoremoon376@gmail.com>,
 Eric Chung <eric.chung@riscstar.com>, Peng Fan <peng.fan@nxp.com>,
 u-boot@lists.u-boot-project.org, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io,
 Anand Moon <linux.amoon@gmail.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>,
 Tanmay Kathpalia <tanmay.kathpalia@gmail.com>
Subject: Re: [PATCH v2 2/3] mmc: k1: let the SPL read SD cards more than one
 block at a time
Message-ID: <20261014213155-GKB65630@kernel.org>
References: <20261005T135733-0400.mmc-v2-0002.DaveWK225@protonmail.com>
 <a57e47d3-fe8c-44dc-8afe-2c256ed49d71@gmail.com>
 <2ef42a4d-ee32-4650-819b-ea6d042bdad5@altera.com>
 <c02f3812-e549-4f4a-9fc8-77da7ed6b883@altera.com>
 <8a263ad7-5cf5-46f4-87a1-43e898a1d15a@gmail.com>
 <6f00fd89-d418-4d64-a066-c893dff89994@altera.com>
 <1f734cd0-cd75-4b0e-93ec-490ecfbb1ab0@gmail.com>
 <b34530c2-2a90-4cca-94ae-207e503188ee@altera.com>
 <20261014T154006-0400.uboot-k1-mmc-v2-handoff.DaveWK225@protonmail.com>
 <5cf65034-e7b9-4d0b-9a72-5d771e1d0e80@altera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5cf65034-e7b9-4d0b-9a72-5d771e1d0e80@altera.com>
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

Hi Kathpalia.

On 02:04 Thu 15 Oct     , Kathpalia, Tanmay wrote:
> 
> 
> Hi Dave,
> 
> No problem; that is understandable, as we all have other priorities.
> 
> I am open to taking over and respinning the series. Since I do not
> have a Banana Pi F3, I would appreciate Zixian's help with testing
> the new version before it is merged.
Thanks for taking over this series and working on it,
I can also help testing on Banana Pi F3..

> 
> As the author, I would prefer to retain your Signed-off-by tag, while
> adding my own Signed-off-by for the changes I make.
That's good, and a proper way

> 
> I am also happy to contribute as a co-developer if Zixian, Hung-Chun,
> or someone else would prefer to own and post the next version.
> 
> Thanks for the work and for summarizing the remaining items.
> 
> Regards,
> Tanmay

-- 
Yixun Lan (dlan)
