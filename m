Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F0C60A6F60
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 08:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GKYmQ0n2;
	dkim=pass (2048-bit key, unprotected) header.d=monstr-eu.20260707.gappssmtp.com header.i=@monstr-eu.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=F2qyQpsS
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 541A340659;
	Mon, 23 Nov 2026 08:07:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AY8YSXkgoUCU; Mon, 23 Nov 2026 08:07:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 437D640651
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795421250;
	b=RUbV3Atx/8tdQi9B0qGBNXMhpNEQ5hYM61US5G26Rro+JeBxhMqB/7v09DAGusbvAYWX
	 YWGLJDl/wdqxbUnRe94bX+BjmznZWsYayAZ9Ho/XhHBni3LKA+mhbuC2Jkg0d+I6DTqhu
	 +FKZx/RFCAjtHOwQZyLla4rWhtTvWvsAZO5Ov8sefOprG4mapJAscqWIp2s0kN5Iognov
	 mBoIHN/cUqp1mBdI8PSDQgJh5OKh6ycbI2qf/LOzSRxouw8V4n0+JEovjv/uGM4w8ph8o
	 j70XmzOcZ7wXREtBru16s7T10mwALVSztRpZo2w0HM566oSaTYxIBLHpTfwBMCuNosA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795421250;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:Cc:From:Subject:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XhZsuoC6TrJHM0GEhUCUE1uKzx2m0+1tDMo3Pt4CFkY=;
	b=n54Oelm3TnCJ8+osXtrpO6dAej8zRO80SAExE2r4iTJd3S8mJlNK//qP8RyP6jwuOt9u
	 MKegv+3seFYCIBat72we8H1tgzwMkAPV34gDI9aVUWxsqO3vEqKZrEIcKO9SGKGDyBiTY
	 A9v3kboZtjJ4caeO0aemO3nlXPNA9sYGCqTCwT4uPvL+4cNhycRHb3CzbK8bA1/tNSRig
	 0eGHrKhukpAys+gqTj8R9LwkWG9sJeN5Sis3LbkzrSZgUuUNi2plmyl1XqaQpcoxH8Rat
	 IoQEvZTfGiAAaxNEVsuHvFE8z3VB2fZDlKZ9HGPPSMEXCjzEmrs2mi7ndwQkgEXJZjA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795421250;
	bh=XhZsuoC6TrJHM0GEhUCUE1uKzx2m0+1tDMo3Pt4CFkY=;
	h=Date:To:Cc:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=GKYmQ0n2ZkXE5MFcL9ohbCcgjMkEw1Hw8+vgNGGIYFiimMzBofhCFWUhBJTe/OCfk
	 D7JpKG75UOLvLztptAx/KjWI2krIsPnkM939uuDa59b8Z+fl9h7vezu5DCCwNbJ8wW
	 ZDMxb8cc3y/1ZBW1EPm2GX2mTlZfwrx9d+0+FvqFWICajRj1eGFAT7/pdExD+mEA6A
	 Rvn0AHS4N5vG2pnm2ToYLAQq+TodKLc3R48pVA9C6bAQqaukHuXvNjmzoIkUk37Z5B
	 0U7/VwxOFW2c6U2f2OCg8dKeEGW+JOMAhP8PHsxwMkincXQThKL6k9oHMyvtl36aJ4
	 Zq9nfkKu1iIZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 437D640651;
	Mon, 23 Nov 2026 08:07:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E8507D31
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 08:07:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CDD8280DBC
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 08:07:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TJKDWMBf0z6j for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 08:07:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E3DBD80DAF
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::633"
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::633; helo=mail-ej1-x633.google.com;
 envelope-from=monstr@monstr.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=monstr-eu.20260707.gappssmtp.com
 header.i=@monstr-eu.20260707.gappssmtp.com header.a=rsa-sha256
 header.s=20260707 header.b=F2qyQpsS
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E3DBD80DAF
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 08:07:24 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c50a4a2132cso411121266b.3
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 00:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20260707.gappssmtp.com; s=20260707; t=1795421243; x=1796026043;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XhZsuoC6TrJHM0GEhUCUE1uKzx2m0+1tDMo3Pt4CFkY=;
 b=F2qyQpsSyghUvNxCpsTOvrOSA/1I+KMvFogLn1Y7malf6UnnhJzwws/hScl0ERSkXz
 LE9uvu1kgUjulxely/dUI+kVy/ulfSC8e/HP6/kOIoSxC3/1U5XpYRGnqEafNdLfWhsC
 mL9+5evnsf5j5Y0PtxZ4cvqEYBVYyJuRx/aGnokdHvHyNpfG6l5Y77COkrQcKzI2fkqW
 bnQSd2S14CUU7Czpsuk8z/WlcCRpE19Q+Bqv05QNo3nf9XiDQDJfnHgMbhozt1wCX19f
 y+juohRTATTtMjokuVmR7EupCiCHMzeRXa0XkFMcNpgCHraLnsDi1RHbmU57Q/YveFnl
 cWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795421243; x=1796026043;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XhZsuoC6TrJHM0GEhUCUE1uKzx2m0+1tDMo3Pt4CFkY=;
 b=WBjYgq/SqjrG/fzF866w5AdgWa3u7XhtyZSiRUbUJZ/4qWBNbuU1FuuhgF2XhqUrab
 p+d/Lo/qOWoAXWrsgeF5vpXq7jkh+YA1qyoa4nQh9YQvqfpESQx7ekMVdDhy1ZqESAba
 sazOWnnZ725HNlRoKjmpmjhzTH3I4Vp3xZ9m2bMK1IMydWZWmxYyhawumgN4ZKdnh9Ap
 +WOcAwHBE5vSsoTqJTZ1iz+q/HFVBDOmhzds6lk2+cZ/ldOmjP34SFGW+bnu89gL0Erv
 RkagdtO/rA11lNTzofGZ4HfzYoZi8NuA03ZZiwqP+5zTYjymm8y8zdsEQFGRpE2l1OGP
 XblA==
X-Gm-Message-State: APuU4Z94t5ZpvMVBUB7su0Cs4q7RkExOB/3AuT7/T09WJ3/d0dgzW58Y
 BihfzVxsOfT+008pdRRlz1uX1EL+XYr5nbUqKIulgEstY4MyOU4we0X1FIKEBYsqsb7ZhqN91pO
 aiwwu95i6
X-Gm-Gg: AZFdTZe59OUz7F8n3nLD+1dnv49jEktZT38R8LRiKbaec2WapZg5UwLM9pN4TkFteFq
 or0ysRA/qXrNXHz4snZllNFfINEbCk1WWYxg8LVlda/oZIc04+Qiuv/OTCUCCZr2HMuTDQP7+VE
 QIFr5LCY+pbWnA/YsKprMQA//Dwthmpenw3UROI5HNMyUVtm/7bTPKT+KFLLSAp82DwnAJlKPPe
 EB0tfWE3CEeB9DqcwqG275sfCgqbeFVBBmYJARIhiV/rQKTIbmVqcT4YnxTLI42owoyhZnR/JGu
 BQVC1YgUy2GhEbI5uEb+grrabGMrv84YaS/mD3ivi3ZeB0ALtt9ZkxRBLOymR6siADjMgfV4vkG
 GlS+Wm9BTME+iIQs6thDQ1EAICa7kbzSwZghYv2n3QeMdSXVwlawbOXGSjjMBoYCzbUbWdiwUZ8
 5yl4BOqtPgtg917N49NRUQxCXoxc3XPEGA7djj/6hfxBMCwSpYhE/Oo+f3WdoKs5Ad0F/RQ5w33
 6+1UK1KJZbghLb18Mh7SBnCB/sDNlu06wD8bqUsOBmBbsmbkrtDVPEktf4gvuDicpVoN/FYblUB
 9H53+6WUb8lin/tR5Rub6+bZSF0DFvGBt8/HiSQGd9GhDQ9zL9n8tRIp4n44tgSoZtrrw48N0et
 iSIKn/O8h79DlP9tiFH3lLN3Yb0Um4QVDtdxdGw==
X-Received: by 2002:a17:906:911:b0:c40:b477:dfa0 with SMTP id
 a640c23a62f3a-c513aac2ebcmr713804666b.18.1795421242063; 
 Mon, 23 Nov 2026 00:07:22 -0800 (PST)
Received: from [192.168.0.105] (nat-108f.starnet.cz. [109.164.53.108])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513ae8d0dbsm384582366b.31.2026.11.23.00.07.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 00:07:21 -0800 (PST)
Message-ID: <57567e59-f741-498c-aa9f-58499bbfec3b@monstr.eu>
Date: Mon, 23 Nov 2026 09:07:20 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
From: Michal Simek <monstr@monstr.eu>
Subject: [GIT PULL] amd/xilinx/fpga patches for v2027.01-rc3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

please pull these fixes to your tree.

Thanks,
Michal

The following changes since commit 2f83ef8a7dd4a409b534ea68cd13b17b686cc53c:

   disable VBE by default (2026-11-17 11:57:23 -0600)

are available in the Git repository at:

   https://git.u-boot-project.org/u-boot/custodians/u-boot-amd.git 
tags/xilinx-for-v2027.01-rc3

for you to fetch changes up to 90322247a50fb7d91558391901ee6137d145f8e7:

   gpio: delay: configure wrapped GPIO as output on first use (2026-11-18 
14:21:55 +0100)

----------------------------------------------------------------
AMD/Xilinx changes for v2027.01-rc3

net:
- zynq_gem: fix resource leaks and shared MDIO bus teardown

gpio:
- delay: configure wrapped GPIO as output on first use

----------------------------------------------------------------
Graeme Smecher (4):
       net: zynq_gem: don't tear down a shared MDIO bus
       net: zynq_gem: plug resource leaks in .probe error path
       net: zynq_gem: free buffers in .remove
       net: zynq_gem: release the SGMII serdes PHY in .remove

Pranav Sanwal (1):
       gpio: delay: configure wrapped GPIO as output on first use

  drivers/gpio/gpio-delay.c |  4 +-
  drivers/net/zynq_gem.c    | 70 +++++++++++++-------
  2 files changed, 50 insertions(+), 24 deletions(-)

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs

