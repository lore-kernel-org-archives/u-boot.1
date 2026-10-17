Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 058E0CCA463
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 05:01:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6B585409EA;
	Sat, 17 Oct 2026 05:01:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b72xYjiSuoSX; Sat, 17 Oct 2026 05:01:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 46B51409E5
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792213315;
	b=lOmD/33IaRPZuLXg3JUw8PVmizWyX8Qwb2p6Ayhvor93BWhAyFV/ocT1BDIM2W4k2jvN
	 UP/+cd8NpVDa4GgfpMkFz0jDPcda7QJQRlv/v0x5chQn8tKK7blD2pDls6yLbu8hiN40O
	 2MOvbxHpnVrajlWa3NqrV7rB4qr5nhlJ57/FcGgBd9ZNwEsJcQ7Brq5/Ox2TJxDkIzhwZ
	 t6QyqvRU0w5ECBxpxOmsusojroTgFTBqK7Hfipm5vGU8qMCD2eolUeuP8UwqRt1p77ZWZ
	 /Dx8nCfPiQzEqFHToxchTnO7pv+Has3Mn+Rtb4FQvgZk2AUvnNnwCLTxfEAeFF1Kbqg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792213315;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:Received:Received:From:To:Cc:Subject:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
	 In-Reply-To:References:Message-Id:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=8k0S9PdswjrlzbQi5YqLwkyJtqs14mSm5hwI9VNMsso=;
	b=QO6H0cK8rqZPw1HbbPM6fSt72lyTtmHgkcB7QP09m0IQKhH8p1RbaEhQISL0MMmvyT+W
	 xXRFRgRmiZcpAZMvEJStVa66Gok1ckA5v9mCJEVnzSjH/jYF78yyqjOt+qA/c9kSFXjvo
	 Yu/t/YgG9H9NeOv1W20gEwtB8NHiW0yVPCqHefbAEoTEHj6KJtaVeve7d9lVcQqjIqvJd
	 aqYbMzAiyO1WEbD20y1a8oZcE4cwyeV++YHaFQc3E7+NXVVp+754yelkDFw1Mu1vXvCx/
	 ebpelXs8dM1OtcNBiyOJGZoSDxzRsGzn/qWP1XQyxsWl/T1bz4icjXYT2QpYIWnjfug==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792213315;
	bh=8k0S9PdswjrlzbQi5YqLwkyJtqs14mSm5hwI9VNMsso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bP6RR2q1qytPeho9y52QJL/4k0xwGnwDPkKSF/Hyo6yIaHdhzaCASe05lh/uUTh1J
	 WbIHvBJ8M5VmfoyhXfCBKf5lyYafzpLzm3Rs1PZrtzcIhAGSJc48s6RJj7Ya4JYhcP
	 gngj++jMRw6fX1KavNFw0dtUItvaHhRlCmMjlky6Tx17yHt6HaQThGkP0+jZNpZB/D
	 sXcXmYmdtS3b/rlBSyMJDv9wF+BTGRKnu7uGOhPdp/H8eRlmmS8Hp9RyTv+zsRELKz
	 T/nd/ppVBUf9tsMqUaMLAel/4SvzIcJrecN7n5gQE1MZoHJiBz6SNijb8hceS+LxXm
	 qTkf1jRDtuR0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 46B51409E5;
	Sat, 17 Oct 2026 05:01:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1CC09769
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 05:01:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1A0708149E
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 05:01:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WJWccaslAwvF for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 05:01:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 277458146B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=153.128.190.147
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792213313;
 b=nkNoDUE0FgKKDQLuv2h/1fS4NefANDgKDtyfherB04yUZcs9Uoggvp2G1OEe+Ho3tQXS
 9Y2KJFCMs/nsSlpHlkw6f7xL+6X2hRDiLDs+0un5Kuju2I61HqK1lDHUIKYBFpZkch27H
 zHSyOev5m8cIiKSlucbb8yGN9ywBPyNI1+aBMoWCecS3AfqgjIWN4V4thG0+9lIYSwnNT
 7iN7Cl+nIgLFqmGBQWtYgUgrN8sk8fiuczHw3AorpG8+3sBi2SWv0YNW+8Aer0ouxbJ0U
 bbUQDHzeMmhJ66Ky8trJsIxn7Y0rtzMXyHjFcEo45Fd0s1Ldri2/x16TICsw13iUj8w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792213313;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:Received:
 Received:From:To:Cc:Subject:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer:In-Reply-To:References:Message-Id;
 bh=8k0S9PdswjrlzbQi5YqLwkyJtqs14mSm5hwI9VNMsso=;
 b=h29HQCklteZVwuIBSe15iKAyn0oTwmyiIBUmapTCxNV8M9JYoKnkIQTe5Jb3Lzbg9S1u
 /bDesmW0nTsFCmTmd0xZFZV/nunn9Fv8HColX0UMWr6uR9rcjuyX9cnQtMXfPcMZ0tney
 Cj0Edt41arE4jujOnd+/zaB5dFtm9BQ7cYyYx4GEvYlKDaOB4pfkdDpamGqRYImshIOaz
 h0cWape/ItisDQRkILGGfCNl1DJAJHrObyba29uMmBG5pESi5nNf7ZgshEQVfNqLKl/ZN
 eaShkg71iqXkvS+gy++JzzOJEhaqafQpGUG42zCsv/V7U7xCbtceEAFIJN0+Yd+u/kA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=docomonet.jp;
 dkim=pass header.d=docomonet.jp header.i=@docomonet.jp header.a=rsa-sha256
 header.s=20240125 header.b=j91kzGWj; 
 arc=none smtp.remote-ip=153.128.190.147
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=153.128.190.147;
 helo=ocn-dfr-mts-121c2.ocn.ad.jp; envelope-from=y-asai.0816@docomonet.jp;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=docomonet.jp
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=docomonet.jp header.i=@docomonet.jp header.a=rsa-sha256
 header.s=20240125 header.b=j91kzGWj
Received: from ocn-dfr-mts-121c2.ocn.ad.jp (ocn-dfr-mts-121c2.ocn.ad.jp
 [153.128.190.147])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 277458146B
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 05:01:50 +0000 (UTC)
Received: from ocn-ckd-mts-118c31.ocn.ad.jp (ocn-ckd-mts-118c31.ocn.ad.jp
 [122.28.129.96])
 by ocn-dfr-mts-121c2.ocn.ad.jp (Postfix) with ESMTP id 2DDF91C00022B
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 14:01:49 +0900 (JST)
Received: from ocn-spm-mts-107c1.ocn.ad.jp (ocn-spm-mts-107c1.ocn.ad.jp
 [153.128.190.238])
 by ocn-ckd-mts-118c31.ocn.ad.jp (Postfix) with ESMTP id DC1154C0067E2;
 Sat, 17 Oct 2026 14:01:42 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=docomonet.jp;
 s=20240125; t=1792213302;
 bh=BjAA/43We5TqdIijW3xSxA/znQy2v21D5Zxp2DlvnAk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=j91kzGWj5wH1q9lL5RCxyI6OibiWYqqdkt0bH+JhXK/TXsA/BHB7Xtra8ZIwhyor7
 vfsgY0NKfHCdti+TVR1zqRAwcWJG/aGlamuJ9kDuoTpVjvGiKTmsbBAVAX0cEIuAxZ
 gBVl8oXtxWBdAAeIyPCjjcaQDX50icIx2gsW7MQM=
Received: from ocn-vc-mts-109c1.ocn.ad.jp ([153.149.236.232])
 by ocn-spm-mts-107c1 with ngmta
 id 03dcc95e-18df3880dc5eccbc; Sat, 17 Oct 2026 14:01:42 +0900
Received: from ocn-sdpx-mts-109c1.ocn.ad.jp ([153.128.117.199])
 by ocn-vc-mts-109c1 with ngmta
 id 2b9e6cd3-18df3880a7f4fd29; Sat, 17 Oct 2026 14:01:42 +0900
Received: from docomonet.jp (p3688129-ipoe.ipoe.ocn.ne.jp [153.238.101.128])
 by ocn-sdpx-mts-109c1.ocn.ad.jp (Postfix) with ESMTPA;
 Sat, 17 Oct 2026 14:01:41 +0900 (JST)
From: "Asai, Shigeaki" <y-asai.0816@docomonet.jp>
To: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io, neil.armstrong@linaro.org,
 jh80.chung@samsung.com, peng.fan@nxp.com, kever.yang@rock-chips.com,
 sjg@chromium.org, trini@konsulko.com, ilias.apalodimas@linaro.org
Subject: Re: [PATCH 1/2] power: regulator: rk8xx: add RK818 LDO9 support
Date: Sat, 17 Oct 2026 14:01:41 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailer: HidemaruMail 7.42 (WinNT,A00)
In-Reply-To: <b4abae45-635e-421d-bb8d-e4699b0f05b2@cherry.de>
References: <20261010013237.2269021-1-y-asai.0816@docomonet.jp>
 <20261010013237.2269021-2-y-asai.0816@docomonet.jp>
 <b4abae45-635e-421d-bb8d-e4699b0f05b2@cherry.de>
Message-Id: <CDD5DF499196292F3006A@docomonet.jp>
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


Hi Quentin,

Thank you for the review.

On 10/16/26, Quentin Schulz wrote:
> On 10/10/26 3:32 AM, Shigeaki Asai wrote:
>> +	{ 1800000, 100000, REG_BOOST_LDO9_ON_VSEL, REG_BOOST_LDO9_SLP_VSEL, NA,
>> +	  RK818_LDO_VSEL_MASK, },
>
> Please stay consistent with the rest of the file where we have
> everything on the same line.

OK, I will put it on one line in v2.

>> +		if (priv->variant == RK818_ID && ldo == 8) {
>> +			mask = RK818_LDO9_EN_MASK;
>> +			ret = pmic_reg_read(pmic, REG_DCDC_EN);
>> +		} else {
>> +			mask = 1 << ldo;
>> +			ret = pmic_reg_read(pmic, REG_LDO_EN);
>> +		}
>
> This is not great, I would prefer to have some additional configuration
> in rk8xx_reg_info instead, but since we do it for many other cases
> already, nothing for you to do on this issue in this patch.

I understand, thank you.

> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thank you. I will keep your Reviewed-by in v2.

I will drop patch 2/2 (see my reply there), so I plan to send v2 of
this patch alone, after waiting a few days for other comments.

Best regards,
Shigeaki Asai

(This reply was written with the help of Claude.)
