Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82DC6CC6B38
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 13:23:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3685060B35;
	Fri, 16 Oct 2026 13:23:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B2sFH_9f9320; Fri, 16 Oct 2026 13:23:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 49BC160B27
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792156997;
	b=BNvWEEdR/SHkN7EqG11TLz2rbFOmotbYF/FVOl4FL/xXwFiF7t3g3UxXaVpUfIm+iVX+
	 jALeApMefLrTBRlekvB78mjcdh2NW+fDWbVJpa+/iEGXtY2xyuKYOvXV0UWkfENEbolWz
	 rIYb/Rd9sjgFXDhFtDjMBX7iQE+EBH5R3BVPTC7VAk/h/ick2xHx+NiNJQwsMloqhKNTV
	 WFO4cTCfhSkXYprPtTxTaxganIo1urFcy+Me88lOe7y4lZ/0KzGTQl5Mtd7q3BdpNZ5jU
	 KZyj71Lk5a8rpyQfGEL4P2x7Y6iJlMhNi0MFGt7NNQQ6+SVwSMLYv7XTwPLXW8bZ4Sg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792156997;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3DAlPEsgdKXErbdrwAwNpRc/8JPpXzduXyRqU2zjPGA=;
	b=q1/jxZMfhKftnyV8IHfrSCRpvxX2qgIaE48/5jyrTGJcMit2N/YpWjSC4VX90sXGv8Hu
	 YBnDF4L0opICp/cPRcPOYsOQZ7VmyZUB8YluWVb0iiqjbA7BWDc37Lg1mj2AePwJ620k1
	 MVurXMcfnbRpP42hIkaPtU2Ov7g0hcsDo9SHCix1jSIL1dHplsil1KhmVuImeVvnpdjKx
	 Pi6YydZnWeTHUdZVSC68u1zNBu3qg1+ggy13BPwGlxVKhXwlkuLSs9VNuVIcFTUUId0Ds
	 gMbjt01TIN1UOmH6wm4qpb3e+wDGyrODGPl1NeQ04LIquEqR6XCiH4T9PLpHzKwuK1A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792156997;
	bh=3DAlPEsgdKXErbdrwAwNpRc/8JPpXzduXyRqU2zjPGA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lhYgHip7amEMTbtvsHnberBo0UIjA6Qsf0JhMugDUKNYdQpq3CUOblez3/lCZf1R5
	 hWNFc94D4FIqWLs4e6PmA1N6H9sWpjEDh7P83JcFQqiglCrgsjpgeJyRXiH3pTIwhM
	 q4ADOEk9ma4WXWg5Lbxscn2dMFWgC+h3exrc4bvjApHvB+8pZCha3jkAKVdU38+869
	 taDiBSbRwjpm5ARzmclHti8oAEHdlQD0F69qM0MhPIUfGPr4CYc3dR9svQ0HABgkDz
	 E5hHA4pL+JA+QfRUWjGiB10vsOrmTTrHGa03ZPfJgZOWzoXHgJH/OS0x54LkrQnQ8/
	 bLIxzMCaKh5xg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 49BC160B27;
	Fri, 16 Oct 2026 13:23:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 73F1D255
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 13:23:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5A0DA4016B
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 13:23:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wh4alO-LEWJ0 for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 13:23:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 563B640042
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:d548::42ad"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792156993;
 b=BKwblaAeC/r3ElTy0hxW3ktsay995PXn9h2Lbb726O3988KN8UKtjuhA8osC3BKalr60
 RZfcsTw+fa9wnB1AEkyUfmFXSttP+OEeMMMkH5wjVVOqFIKnaE3Dcr5iNa/fUH5DemusN
 EId2+A3Zhd9QVPRnMtFmG8liFcO+kSPsU192O7LXzKZG5GkBavqjILuNJdEdF0HRr79Bs
 7G3ljDd5HmYU7K4Z8//U2uylmQWMy/QMzOb9wdZYZCuxZSPbv0xbMAzmkHODjcLGUCwIR
 8U0Ev62H+7xzq1PvTmbqJa/dDtOL0qnN1biGC51o76lIR4TJfCXyBtxmQs7S6Ig/+BA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792156993;
 h=Received-SPF:Received:DKIM-Signature:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Infomaniak-Routing;
 bh=3DAlPEsgdKXErbdrwAwNpRc/8JPpXzduXyRqU2zjPGA=;
 b=PwRLnOPocjR+SjCNiMOzVFEkrq8JFUnufMsCFQuSiVCPYelTtaCv1YU9nsvDm23DTGKO
 jJ1N7SFIxUoyr8cvjusFI1EKO+gseMYw1g7C/iFxf6YH3WNYRi/E6Bz1Aom/8eo4ti7mn
 V00OBym0i+9v44Udj5amYCzALRFpNEwatjOwFGRgccKu78ZMLbmUvc+9iYgiGsPZkeBlc
 0Xuk22Y90bxGx/eoqN0/3xBZkm+53S6U3xZms0JQya2LsSYJSoQL/aPYUydb1Gvo0afzJ
 PpwaABiV3kqkgZOTmNmoSiF4AFNmTYrw23rinfFlxSF9W74qpGs5Rwg9C4CbcelrOYg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=0leil.net;
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=M4Afrvyh; 
 arc=none smtp.remote-ip="2001:1600:19:d548::42ad"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:d548::42ad; helo=smtp-42ad.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=M4Afrvyh
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch
 [IPv6:2001:1600:19:d548::42ad])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 563B640042
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 13:23:12 +0000 (UTC)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4j5lnQ56HszGqn;
 Fri, 16 Oct 2026 15:16:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1792156570;
 bh=3DAlPEsgdKXErbdrwAwNpRc/8JPpXzduXyRqU2zjPGA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=M4AfrvyhMmSVLiJUZ5oK5K4lrr8ut81DQGpySz8NX/ZaCFS9gbRj1EvSC7bfwrn9Z
 7kOu11vRVmNkJzVu+OUmf2ShLsaC6+57jyvxS/m8GVhLPuJ0IV+ryd+L3u0Y8VGEwC
 MfTHsyGRBogoqrZsSIHr1Z8Dixgf6y5a7gn5Im6Pm2qGguoYYAmzIFrjrUNVj4oEa1
 JAK2KveAcoG0LRLay2uKQyKvC8indd9EGJeHrP3jQhwXsTO3MHz5DRbcu+tMLpEf7j
 b3YGhVj7h3YpD6oWFTwrOEP2oXe9ZAozJ4Ynf77OhN6NfbIhxjiwdZHkn0B4TeO8ND
 vWM7GHI/4cOGQ==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4j5lnN2ZK9z9LB; Fri, 16 Oct 2026 15:16:07 +0200 (CEST)
Message-ID: <69377c9e-b4a1-462a-b82d-66e13b465626@0leil.net>
Date: Fri, 16 Oct 2026 15:16:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm: dts: meson-g12b-odroid-go-ultra-u-boot: set
 vddio_c to 3.3V
To: Shigeaki Asai <y-asai.0816@docomonet.jp>, u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io, neil.armstrong@linaro.org,
 jh80.chung@samsung.com, peng.fan@nxp.com, kever.yang@rock-chips.com,
 sjg@chromium.org, trini@konsulko.com, ilias.apalodimas@linaro.org
References: <20261010013237.2269021-1-y-asai.0816@docomonet.jp>
 <20261010013237.2269021-3-y-asai.0816@docomonet.jp>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <20261010013237.2269021-3-y-asai.0816@docomonet.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
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

Hi Shigeaki Asai,

On 10/10/26 3:32 AM, Shigeaki Asai wrote:
> vddio_c (RK818 LDO9) is the vqmmc supply of the SD card. Linux picks
> 3.0V for it, the lowest value in the allowed 3.0V-3.3V range, and the
> value is kept across a warm reboot. U-Boot then finds the card at
> 3.0V: it initializes, but data reads at 40 MHz fail on some cards (a
> SanDisk Ultra A1 64GB here), so the kernel cannot be loaded and the
> board drops to the U-Boot prompt. A cold boot works since the PMIC
> starts from its 3.3V default.
> 
> Changing the kernel would not help the kernels already in use, so set
> vddio_c to 3.3V when U-Boot probes the regulator, which happens on
> every boot.
> 

I'll let Neil decide since he's the maintainer of that code, but I don't 
think this is necessarily correct? The spec specifically allows 
2.7-3.6V, c.f. https://www.sdcard.org/developers/sd-standard-overview/.

Moreover, RK3399 Puma has 1.8-3.0V only, and it's been working fine for 
years now (though I haven't checked with that SD card specifically).

What happens if you do NOT use the SD in U-Boot at all and boot straight 
to the Linux kernel, is it also broken in the Linux kernel then? If not, 
then your issue is probably not what your tool output and we may have an 
issue elsewhere (possibly in the MMC subsystem for example).

Cheers,
Quentin
