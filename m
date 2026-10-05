Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB20DCA5FFE
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 17:57:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 857A760730;
	Mon,  5 Oct 2026 17:57:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F96EVZV5wpvr; Mon,  5 Oct 2026 17:57:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D4EA560718
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791223023;
	b=QNhdk2CAj/0McTy7aRwSe0ifcLM9I9+Vx1nsHRL82BAPDXLPN5giKkgHZo9+Rgne/K7L
	 Yrm7mLKVFtptMvlCXr4huAFgVNIU8+YeC3D/bD1yKEnA3HUrwMu9LdhkuCe4fELhYPWtH
	 vrgjU7Kve1E7kbiSrxNeXI5/uqU2EzVSxJ9xwL2CY+UD2qzuhtwZEpPLhDGB8mlAojaYw
	 +ToNUxbVkEiIFyRTxMG9U5rKzWmjOSy9keBwS/ln+d4GKtb1HJ3BS+VuliHv/Q2OC4FbW
	 GNEaDehYK1HRszZ3Tv1gK5mXrNqCWNFu8oTvAemt6P2WQBeTC9NiTOPeDMa3rKAzFPQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791223023;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=aKODKPasRh9MYBhiaES3AqHcGzaSXS+7R0jhW+zO7ls=;
	b=oMnGwOsSa9pHg/LpI36TG5uJjd6BFlmayZojrKa+IIPpoXd8Lj4mS8E/3dHKoTVvH8p0
	 QcSCG14pxCaZBRhRz+NwakXyhkN3EleZcqTprtUVte5xQvDQoKyonFhRxkUbNGwL1AYvV
	 O8ZJa1pFQ70O1dIxluPSU/uRQG3ignCQDn6vs7Cx1R/B7ZB+j8dnLa4/xMYJ+NqPTa9Vd
	 ztELfCQfuO2MpD2dWL6C3EOgSruINrK/vSMfXj+kWdtJNNrpuinKl5TYmLdi6OCtmTPWl
	 gR1BPuOxWTitCwUUR+syNFZuN34y7Xiie+vn7AP7Hu3RY9ALGTL6bMn0/rO7WKK1rBA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791223023;
	bh=aKODKPasRh9MYBhiaES3AqHcGzaSXS+7R0jhW+zO7ls=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nGoixI4/zPg3HiGLmnivpEnY77/DxNmKPpEHQnW6ki4QGdCabdj/N32NTlZC2Ndt7
	 /tXJXf/tyFkPaCauBkNCEcdTyCo5V1iJh9J+Pu/vidqZXU6MTOtrVYKWizIAQ0KylN
	 shKl/SsvQEI+IDlebcBatcoZUHGPFLfwYt6JbjLCQVyqXQCh+SDiV8ClzzhPLdegT3
	 UGByMBHs8NffzrPBNAzgT85n3EMKG8oIv29IZ6EOsu41Rb1mIN0p/GcFHUEqP9/5fb
	 7X3CuHLdKCViQblucn2+XUnfTZn4529iiHEdWqFF+9ebaOsZuhKkEDychhyA55V422
	 tvnjquY17fNYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D4EA560718;
	Mon,  5 Oct 2026 17:57:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 242F9338
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 17:46:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1321F40694
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 17:46:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E9jXC4HQqgNH for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 17:46:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2D7D540670
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=185.70.43.101
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791222380;
 b=LegRPDxicFE7zI8d76PspFuJfmJwQ3UY7t+p7ReCzsGolRITrTmjLycTCOfClAN9XYCa
 dWTrpedW3PMKGOx7m3e9Z0H+Q+diVF0yS+GhH2kZUn2UQMV+blYV4tVJ74Gpuvm1muxOq
 kj5YD43wQ0m+IujLf2ey3yi6qMOyv3QnyZVnxH8LSoy7wKFsWXT39L6buCfaG7wvdhqOJ
 GzEZtFBBYkmbp/fLPn1kM1MLA5PyNdFySB89G3UEF9tR7XABnVlCoBaStoY65oyEpMnBz
 ox1PPl056tGlwl8b9lW0A2StBDAwWzpJAmgrYTMf8vNKElupsHBksUuBxHTEsuNeidg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791222380;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=aKODKPasRh9MYBhiaES3AqHcGzaSXS+7R0jhW+zO7ls=;
 b=TWi/mrayEbMewSwWgC+Hm4qqrHMQPN9Knxjg5iKa6owm9Jb4yk6Ipxm91CDa95LTzOO1
 xMSAScdJk5bVS195hFwKfDnDozX5fMaG3YAAZhdrpvUqRkDOtM0Ef+W0QuXbfvWA3Xpj7
 4SWGUSjngvplFCZytBXQIKiNE/7x8UwLWy/Chg2Ge4erzZRhv9yyzAS1cORmsdchRDOyF
 8L+Btv3B/lXaLxSoZAjobTu3WhNK1oDmoHFUQ/U8JEcYt8PVs4K/BOlcBYT2OUaIkbccw
 1tEl+g5aAAou9+scZRdRjYglAQabxnPexbc2yyE05uHlE7pbxJrcE/ZkEKzqkPUuQXg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=hLrwmBvF; 
 arc=none smtp.remote-ip=185.70.43.101
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.70.43.101;
 helo=mail-43101.protonmail.ch; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=hLrwmBvF
Received: from mail-43101.protonmail.ch (mail-43101.protonmail.ch
 [185.70.43.101])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2D7D540670
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 17:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1791222377; x=1791481577;
 bh=aKODKPasRh9MYBhiaES3AqHcGzaSXS+7R0jhW+zO7ls=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=hLrwmBvFiswkMl4rc919Se+/wVdRfTy8r/NR7uyz1F5hbPP3UyiysDJy4tZmYw4cf
 tXSMAiKNpwFpzsZL/S6VYA8BtftXx6TRPcIKZUtTNIF+ITBGLegIhSQGG5ApdToSKQ
 Otxz9c2CDZOjkftPIEyu5nYMazunB74VYFcel3xJONZ6TGjyi2CrM2tKgyv/YAorBs
 KmnFwFOu2a+9TNy8NTz/1iFXNucrNWMH7nDvyh7aOwcnt5LGzlzVh4u8FchoNGkDnI
 nJfHF4sL4xf8EJ89IjlomSbShJu1+ByEYXvEkLeSHym18TXIvHj+CrrVok17e1Pxz+
 uF03dBFPPOInw==
Date: Mon, 05 Oct 2026 17:46:12 +0000
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: Yixun Lan <dlan@kernel.org>, Eric Chung <eric.chung@riscstar.com>,
 Peng Fan <peng.fan@nxp.com>, u-boot@lists.u-boot-project.org,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 1/3] mmc: k1: handle a missing max-frequency and
 clk_set_rate()'s return value
Message-ID: <20261005T134246-0400.mmc-review-reply.DaveWK225@protonmail.com>
In-Reply-To: <25699478-9599-4bab-aa27-1b8533d1585f@altera.com>
References: <cover.1790975596.git.DaveWK225@protonmail.com>
 <ef56cc2cf2361bea7bdb478b253f9cf3a1cb6ea3.1790975596.git.DaveWK225@protonmail.com>
 <25699478-9599-4bab-aa27-1b8533d1585f@altera.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: 04c158d7f0d1bf3af3e7fe6a27641c11785f1f98
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hi Tanmay,

Thanks for the review. I've updated v2 patch 1/3 to keep the clock API
return values in ulong and test IS_ERR_VALUE(). The missing-max-frequency
path now checks clk_get_rate() before assigning it to cfg.f_max, rejects
a zero rate, and preserves the clock API's error code.

I've retained your Reviewed-by on patches 2/3 and 3/3. Patch 2/3 now
explains the intentional reversal of the driver's v9 single-block SPL
policy and the MMC core's CMD12 path; its code is unchanged from v1.

The revised three-patch stack replays cleanly on its exact base and
passes checkpatch. Both R2S and RV2 configurations build successfully.
With the separate DDR firmware overlap fix included, the combined
firmware passed DDR initialization, FIT verification and automatic
EFI/FreeBSD boot on the 2 GiB R2S and the 4 GiB RV2.

These are combined-firmware warm-boot results, not isolated tests of
this series. Cold boot of the corrected firmware, alternate cards,
missing-frequency/error paths and error recovery remain untested.

Thanks,
Dave

