Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9869ACA5FED
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 06:28:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2D7C381191;
	Fri,  9 Oct 2026 06:28:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 92EaQAEn13md; Fri,  9 Oct 2026 06:28:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8ECAC811E3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791527295;
	b=Ky/K/SIqgrPND1QHPUeIXnPVpWmBfh26a1gyf8tdnUfKvsYT1f/dzpMFqj0mbjAtyqt3
	 OgLtXbh7ZjlVpSVr8ksa+KCuwU0MU0ukkpUVxfGqX9Zi5QWHigAqO9Cj9J9lUmUVMjPmn
	 1relHoAur8y4Spn1IGKAPY3q+0D9grYT+y+nz3o4pyPnimUAYe19bSc8PauBzQes0zZNa
	 BdhQOKqIllxSca3x75SF+gWJEH+IkWeP4N+k1T+uhlUxYkOqhwXB+jm1uwQzj0dAZhTRL
	 oeA1yYyv1X0iCC51+0iw5zIfOkeVlGYVgca780ipnmZO8nRg31UG+070jHOPThR1uTw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791527295;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qqok5LXvPWK+3ywzS3oNRINNPmT58YVTUNtJoKyBasA=;
	b=nb4LRJ0MFl+r8I/+RWByexNeMdmKFQNmMCk1qCHFzTaUoWsSx+L7WJ4LAfOtohnBVoMe
	 xtRY2h5GqU3NpXR8ziC4FGAJNk8bcbVGWbWgcuPKWNP9JzJ8gFwekvZQCz2JeehmKIw8A
	 ZpbmdTKp1k2N7l6eB+ovDQ5qLeRD1dm62PRtk8Sk0jBQ3v3uLwVS39zD5anAAxGTAIeGv
	 2gvRAYZ16n101M+li7Gnn90cy2E7LzGZVPePecMMNOrg4c1CA9HLAg1bawmRQo6BKVsho
	 eN8fFFTeWp0gdBPi/4+LDImAN9ral45dO2EKImLiEOPZc8J7ce/dUfYvLiGiN0xckPA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791527295;
	bh=qqok5LXvPWK+3ywzS3oNRINNPmT58YVTUNtJoKyBasA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BPlSTdk4gvuOzewlkz/23nvvR98bvAc/FSwLWM42zF5Q3BuYRGklH8RmawMl0VD5p
	 cNt3rFNkICTPm1f/iF14k8bL4OMTodm+X67dbi9LWIGWw3241cTaEcKdoEzHj/HCdn
	 7EihQDcrqcpaw6iKz3atUa35YMbpARXKd4AMDciFXeGHROCmSIoZw71uFvZX18IhSb
	 ls6HsBiT6qasUinDViHsV0NOlgGkk/U0Yk+QsZ6YCf+nMQh/Xo+0gnGlcta//xBTRN
	 fUWcWKBcONR+vQEBjqyF3RDVsYPYta3muz+oXoF1mEQT9KfHoDckg8kDwaL0Zavy5s
	 zXlN4nFBpDJZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8ECAC811E3;
	Fri,  9 Oct 2026 06:28:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 961532E0
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 06:28:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7C72A400B0
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 06:28:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DoSd9M6iOJ-2 for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 06:28:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E5BAB4009C
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791527293;
 b=Mcai59hbl+YX17Phm9ZRfb0mJzxgbORDHCw2PR+0+TJzcl7MYeu45DvvNLlRuI/j7YIf
 1iLGXXOwl9Gs6/iybKMSM8qS0PhA9F/spb2lSwV7oG1yj6SMuDscouuUL8ScPpVbHH+Oi
 nR13Hp4hpiYshxlNEhgr2vGB7FiUzhBqXDs1HtjxpDTZVr6Cyo2yJGBUzftl5uWgqFB3U
 Eyh4+9ZF/hBMkJ8/qlryWtxU5mW9Z+3WnXt5V7WOI9lYqb/n2X4aVMxQRsJL69FecFabN
 sq72//CUVjqWWNG69BhRVrzclfB+Ylnyi6Sx2LMVRkigZ/HmQrDhvXC7rne1yttl+7A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791527293;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=qqok5LXvPWK+3ywzS3oNRINNPmT58YVTUNtJoKyBasA=;
 b=V70ILStfILgaW2dxKiWFdqczQiJIE6Xuwx2CXraU3r5aYj/QlehX5FSb+jvd51//Bql3
 wuGWArUqSQ9WEKb4+6okxccABpblMGJ29ZPED9qopdeL1UWPzVYxcP3pQMC9C1kZBLNNv
 lRLlxEHKgW0FY4zEhaGVsneWAEWHBEsUMnAjSXJbkxOiEi364E4PQW85R+DAs9AVv0g+h
 oEF696iVYJ4UWCGXWonPk625tLjzj31empGvrujg/uLbM0NVnqTqatBeP5zdxq1NeUpFZ
 yGgKqVaFxk3VQzYZL2PYW8sikkMVd/OALe7OeueePe3HvdivCID/2fvc9so7bRKh0tA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=niZOWNOv; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=niZOWNOv
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E5BAB4009C
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 06:28:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2813643B6C;
 Fri,  9 Oct 2026 06:28:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EAB71F000FF;
 Fri,  9 Oct 2026 06:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791527292;
 bh=qqok5LXvPWK+3ywzS3oNRINNPmT58YVTUNtJoKyBasA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=niZOWNOv1ANBjsNNmdAmsIAoRQSbRDaTAbOg1ccOgog8lzwxcnzl+ImF3Z3znd4Li
 LcvLy+gX06ynKJW+7X11Nmxxdbu+CrS2PDlfQMVDXBeJFxj8DyzYPqlgMW/Xpnft1g
 AmTj30GcIxIisCOVG10UPn2dBMIkWDis2jhVXAOCbiJRv2D3IVKHyZ3sAm0JPIYjXJ
 jFEmsu68nnjTTRXD6vWHgYKyKEfgZqfPJhTieKD9K8dAvISI7uG3y0VMRvvjKWos7O
 vhy0hZewIlQvzkEEUK1cCJ/eWOCIl0t93PvFza35PJAzR4Htc7PdpafF0AoTdyOAgr
 UekCPo2qUxA2g==
Date: Fri, 9 Oct 2026 06:28:09 +0000
From: Yixun Lan <dlan@kernel.org>
To: E Shattow <e@freeshell.de>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Hiago De Franco <hfranco@baylibre.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>
Subject: Re: [PATCH v4 3/4] configs: spacemit: Add K3 default configuration
Message-ID: <20261009062809-GKE2005@kernel.org>
References: <20261007-00-basic-spacemit-k3-v4-0-c44d09937088@kernel.org>
 <20261007-00-basic-spacemit-k3-v4-3-c44d09937088@kernel.org>
 <8c5a2602-f68d-4104-81c6-0bf1418d7ec2@freeshell.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8c5a2602-f68d-4104-81c6-0bf1418d7ec2@freeshell.de>
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

Hi E Shatto,

On 02:51 Wed 07 Oct     , E Shattow wrote:
> On 10/6/26 22:11, Yixun Lan wrote:
> > Add the default configuration for SpacemiT K3 boards, using the
> > Pico-ITX device tree as the default.
> > 
> > Configure U-Boot to run in RISC-V supervisor mode and enable the
> > platform clock, reset, GPIO, pinctrl, I2C, PMIC and regulator drivers.
> > Also configure the memory layout, debug UART and basic filesystem
> > commands required to boot on the platform.
> > 
> > Reviewed-by: E Shattow <e@freeshell.de>
> > Signed-off-by: Yixun Lan <dlan@kernel.org>
> > ---
> >  configs/spacemit_k3_defconfig | 51 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> > 
...

> 
> On condition of patch dependencies applied as outlined in the cover
> letter to provide PINCTRL_SPACEMIT_K1 SPACEMIT_GPIO (implied
> RESET_SPACEMIT_K3) CLK_SPACEMIT_K3 ; With that,
>
Yes, I've checked, it's all correct, no worry
 
> Reviewed-by: E Shattow <e@freeshell.de>

-- 
Yixun Lan (dlan)
