Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D128C982EE
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 19:14:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EAE48407C3;
	Mon, 21 Sep 2026 19:14:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AEZYGUZr6pBe; Mon, 21 Sep 2026 19:14:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 431FA407C6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790018057;
	b=OVH73rFAM7nm7IpLp6EnY6Jsq82ebYEVhLzcHzGds6muqJB4quk295lpgoKbm+yf6clm
	 aQLaXNZUw5czi/0SbxxA/46O8i7y0Ii1kdgNCUdIplE46rrUsURSOb7fc7ZuPddIdB+UU
	 Gzgj1cbzm6Nj/vmHV5T3YoJW2dXpfz38gDrl+3XUZrXPKjRnk3TeneqKQc3ZW7LkJUKCJ
	 eG5alFrwDxgYNScSPsAS6aN1iHgekGaPFgf3IeZrIfDFRCri53qe4dT+dSZbfb8lP8Y+Y
	 XirpLlvXYqFkudQSgWhr5X64WmXazKh7ZGM7yUbDsKZ85bXMmwhFYHTB7G5EsT1OsoQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790018057;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=hdKwGXHSC4Wi6qQ0wP+AgpRwq4IO1eBiw/6XEctj5Qo=;
	b=ORkpuPGa17Dx8egXnDd7Sy5c3peH+o0oxvFacb4oWyZ2nfI0pqi6BBOKuK+7H2bf2j7n
	 xPow24fleEOL0DJ2nJyOadRMdAFVd8pOioi3VGjIhWAuywQixaDF7vS2wnTPj9lEqwJPv
	 R9wn38dV+FMRspesPCu0VI/RgejUg8GnBUs/3Zf1RtgAdpCBO57NuqoDAaINq8gavR7y+
	 LRoKKgKY4A5aQ+6NaF2DlldWvQfcgyioZ0GIkOENUy/EYTLqJi4kTsJMdRo+LXA+kxLdO
	 Xit26d38CQHOH8/FSi4AdxTYUJurHbGgJI+edC/sCeyN+4or+LCOgssvVB+Ncnj4b4Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790018057;
	bh=hdKwGXHSC4Wi6qQ0wP+AgpRwq4IO1eBiw/6XEctj5Qo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DNBtf1EtGIqI67NWyotl0TnqiVEpWIk4L+5xVB2k/kJ/hc1LrbSdnngQsv87W990m
	 gIJ6lMv0U10v6IEyy9Pc5EI8VO0f88EBidHKySDDy+AobSYFormnqaWRkOrn6hHmFq
	 xPJ0uJkFB4tKkGsTCW+gCrgEwyr+ZvQGUPsO8QdeGl0zTypjEQU13PtRgWxUxVdzA7
	 Ipp0f8YrEFjFTTWmQ4MIi5Ekz+8bi5du3AQI+BLXn+cjpCkXNiwYW3ca7/mHwnN1rN
	 LjEJd4rF06Z9fL2VEtl975dVZQSHeTdtrj5gnqZIMrshtiz9vpSOoVXQY+hKZozucu
	 KagmkKADjo+tg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 431FA407C6;
	Mon, 21 Sep 2026 19:14:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 83C4591C
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 19:14:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6A07B80D91
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 19:14:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GCde70RQ1PfD for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 19:14:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8060880D84
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790018055;
 b=o04iFXTGhHjozWVTN/gI75pDq5GHD+HaA7KCzc0+N/nmgoXXKuqAkDc7w93oLjB4aHID
 3IWHopeMnqkyxgcREPeuvTNXi7bYDBdBdH8IKoP721TE5KAzPhVarXBPu4xz1o1deuILY
 pWCpxKYEd/7uotbZ1vStL3d14R442/5UScU+Q4VRBje2MrwkcdbHSwd7CwIMTyrwOZs0/
 dbtHHy3W++Sku3Dwfxl4myv932tA3WbqCYeLNYGRTrGC/SLKrZuPoPQMKiU7fYQtSRSK+
 BJKiHbfZlRBPzhsD/J4c1C2Cp+dmkQVZ3QZWsXNM7hFeyZaU4MOCrTwj99hRrwtMCYQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790018055;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=hdKwGXHSC4Wi6qQ0wP+AgpRwq4IO1eBiw/6XEctj5Qo=;
 b=evYATMp7W91k2OD4RTHx4y4lcTkzlrZpNYQCEAiYXSye/ZYDNvGF95vDI/n15wAg3ic3
 +uAO+u8YqjG2F0vvyGnjEAmIPbFqES+/RQyeXOeXfGbFdgQOik/CkhUhqyg9IgtjqRGnO
 cU6W1G6g2aRqXip4CnoYKllDkao8oRWLLEtrjlffe5g85C+7K8LMjcGj2BLMCPGOybqRs
 3aCVhh9eeM68RH7RDrOnbNNEJviPP2D5lpblM/BuB1MX6DXcL9A+lYOzWi/fDw5CX89qh
 +yNKfMjqNSlWb5GRnh7nKeKOzkeCFtCJl4xsYVeatfP/+/hcOl4Dq5mNUsOQPKzFk6w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=lex.la; 
 dkim=pass header.d=lex.la header.i=@lex.la header.a=rsa-sha256 header.s=google
 header.b=BmfTkE8y; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=f@lex.la; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=lex.la header.i=@lex.la header.a=rsa-sha256
 header.s=google header.b=BmfTkE8y
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8060880D84
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 19:14:13 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e83a388f8so20340805e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 12:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lex.la; s=google; t=1790018052; x=1790622852; darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hdKwGXHSC4Wi6qQ0wP+AgpRwq4IO1eBiw/6XEctj5Qo=;
 b=BmfTkE8yW+Q9eZc9fX7UO2pmeGheuV8OZVXCTI1EzZ9uYdIsrau5p8RU2VEyKygwnJ
 J1Q1s2ZmYDa/HOIPpDdQlmDHOCH9U6H33ANOMsiCN5kJ/FDpSmoXWiebjlyrWVDmSDaX
 1S3iIYrJmefq6tV432xuwrivT976fnmNu0YP55IUDbkFtSHVcX+qsuLWHI9085VhLAq4
 /teuf3cg45Z6X2T0wrTgStUlTpyPPtjBo7f7dYsBvOLXU74Nz3q0CbLL+Op7vilAfGgc
 WB8Div3kokhiuZeHcXDmKDPe1v4S8eBYwjhAT1ZOgGeSKYgTnxYghJ2r3lH5iujCB2TW
 X3FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790018052; x=1790622852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hdKwGXHSC4Wi6qQ0wP+AgpRwq4IO1eBiw/6XEctj5Qo=;
 b=AgGhS+9cEyoDcdyjAUoEN+w3LcBqi8wOOn9gbuHMxI8BKYJhyXYWSE77Ft4eFxKIqg
 hCgn1Zgg9bDHj8avdy78T/vMq+JDcDuMVqq5t8Q4wd30FXSuBRuYjyPCHtBX2etQbIHd
 JhyMuIblHVUnXsx6XAGa+dbBgjo6IAxxpmueMXiVh1NnfUjqUpg8Yiey9DFynkWO7JRc
 YwsGnleX9W3YC2W0IX1dOpk8h/1okLx9/vy6TbVM2GGqhqdyEvCmVO5pK63MS9Of2I8l
 yFG57aXqQ0B7zaNIWIbymZf4PiDVQhHlAibTjsLLxs78xygA4JYxjNFtRqX8DKxyqTEg
 iXAQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz1+KlJ14QkwX7w0AYy0pd9AR8PcPH/rWEWJ1GzertG1QpG9R9vSXjbDduXhSjDTb5RHGaJZY0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++ndgbuqsHcl6DOai+21RKSw1np3vYJc06s9DdPAtW9Fw1hmH6oZ
 +m0ajak2ZEdkueblrQVxEZPcKN+wYEjNe2H2R5s0MpeWzJl9e0T4Wq+ktdgON+wosQ/Us6C/4G8
 VPvqPtrQp/T14
X-Gm-Gg: AYBFou1VwOQ1zZUGDFWABDLc2YlDMtGB/GoFwL6xEcKcwxJd3iOZ6l7Euji1PPVKLSJ
 rrmjb5WB+st0bPg4VQ9nw7CbS/KliUe5nx+PR0zPmc2yhxt5ylWofjvz5s1Tbv4p5bRqjLsheug
 IkYVmySgSI4VWEzNZ/1GG/JCSgkv0nLe+b6FDen7a+aSOHlFC211BSAQX/gX0lXSOltZcGSQxLR
 AOLXD7jmMC3RCgSjMJDnS7l03I2/o5h+mHaKlxX8F6dysLjQzULKYAHoBbq0qRZPWgDqzOMEcTy
 7rNIVxFLIY1BqyvbAe9RYZ6EDmUzGS8YowsGy2GcwsXuvLGJ5KQcTEryzy5V7KLXoBHJhyGT457
 cI2DmbAa+uonVRiEeqJJkvHZRJvTzxiTz7lqgb6f062NGxMG45mmpmqLAD+/FaCHaIaV4E0k3Ic
 Yq+JIa9kq9LBP/1RhjxoswI2Fjc5WqfgsdJt0yOt8BxOjjvROmCg==
X-Received: by 2002:a05:600c:354c:b0:49d:1cc7:5ec3 with SMTP id
 5b1f17b1804b1-49fc568f76dmr164353425e9.9.1790018051783; 
 Mon, 21 Sep 2026 12:14:11 -0700 (PDT)
Received: from remote-01 ([84.17.55.230]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fd8cb75f6sm12477235e9.15.2026.09.21.12.14.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 12:14:11 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Tom Rini <trini@konsulko.com>
Cc: Aleksei Sviridkin <f@lex.la>, u-boot@lists.u-boot-project.org,
 Weijie Gao <weijie.gao@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 1/2] arm: let a defconfig ask for the Linux kernel image
 header
Date: Mon, 21 Sep 2026 22:14:06 +0300
Message-ID: <20260921191406.3028860-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921155055.GZ858934@bill-the-cat>
References: <20260920151512.401899-1-f@lex.la>
 <20260921155055.GZ858934@bill-the-cat>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Dropping 1/2.

The board keeping me from the select is downstream: an MT7981 router
whose U-Boot support lives in OpenWrt as a defconfig and a device
tree, with no board directory here. I will carry a MediaTek-local
pair of symbols there instead, one selecting the header and one
holding the offset base, and leave the generic ones alone.

Does 2/2 still stand on its own? It gives mach-mediatek the same
default TEXT_BASE for LNX_KRNL_IMG_TEXT_OFFSET_BASE that mach-mmp,
mach-rockchip and mach-apple carry, so a MediaTek board that selects
the header links without supplying its own. If you would rather every
board spell out the value, I will drop that one too.
