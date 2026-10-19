Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D4FCCF2D3
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 08:08:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 02AA440707;
	Mon, 19 Oct 2026 08:08:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ccV-YCojCCRa; Mon, 19 Oct 2026 08:08:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0DD63406FB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792397320;
	b=hfI4viXDejemtPNYfLXEjbMbONpexzebRZYS556KBtTfVN/xex9jpoqgmAk2HPRvMzwE
	 Co/LqKEYGw/pzoCwZnvMRldrtZqhx8WXiGWysuj9y6EJ9Q3s0nSYkA8gYCP4NVEwpyjEn
	 ISOyEwUO1EFuGkGAQicSlisDXOC+1WXPEQSSADDMSVyPqFgvriEiK9rE2CIJNpNXZpQwR
	 A3iEovW6mRUSLPVJpMnLiKZOPnSVC0czwPXtlJECU443M/g/dXIfMdaSMRmdddOXgBMgX
	 BM975eZ+mlsbfJ8TzzeAQkj3XIdsx9xwtxRhhQB5Ld9xzA2x5Z9HjdQMMcx/YVsaJCw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792397320;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=BA8lvnyHbrX/wQGD9PCO40NR36rEcAeHYhBqzHs2yQI=;
	b=kafpN/TpBk90WNMFMqEyKXG2N+bpk6CsBpNoFVfmndJNqFwUYVPpafigtarYl5aw4xir
	 9Dzn9X79eZ/YyI3YB+npWOqj6uLCLxRiXHgcbC06uUenObRVnKs7ForPdrZ3EWeubUAN3
	 Y51YD+ce420sXTWmUp5+JfUEFW6bfs9AGaXOgNGEgi7jPuIYrR1zLjeqat21Rtqso+DyH
	 ySZfuCmSmUFG12wRrfnwG06YiOSSLGL+CbXAM+CKwZW6DMclKgy+3WDdbBOQLk9IK/nUi
	 KZme08hc55sdA8MvdJuYUkOKRMDrVlM4m0byCpSoQlM5rYzuaLvG3lVVSUhdO3Hl0xA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792397320;
	bh=BA8lvnyHbrX/wQGD9PCO40NR36rEcAeHYhBqzHs2yQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nyNqW9nHg36d3/WckWhaBdegzmXUT9PGZE6CtV4WXM1x+XbO82+i61vphZavviVt3
	 HCMqWaFQgfVjdOiScCMxOHAajEhE5T8hS7YxJIJi+yd9E7bEjRgLFsUavIE6Zd7Tnp
	 ZxfdwyzgXQJ7pHZ8+3HmDEW8dAY6o8TIvHS8xiWe2OmCcHuaB0BuJ/n3O1gUwZoh97
	 kO79LZnoMTNXfyXtkzN/7gBgI6Fry1oH5XQUm65EwUvYJODxR2aYfccnum/OVbTR+T
	 E6cRfpuayJY3ZZnOYrDb9UvKITWviJXMsTqy74q/OCW7pjZqCnGEX3ekskBqHb+LCi
	 Hnc+41YG6lJTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0DD63406FB;
	Mon, 19 Oct 2026 08:08:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BBC691AB
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:08:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AD2E660612
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:08:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U5CF4VOzjOp8 for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 08:08:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 611D460606
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792397316;
 b=X0onhzk2aSRcYYFgq6ywemTKZRRfd0VSChnfRvJFjeZFcs8dBuWmW17rUJikMmTeflgu
 7NM51HLDkHq+do9VZEil/SUCd38aFFWYX2+wfYojJi/ISpSXrjkMO5EzIZ5Rupv4q3OtV
 xYsHBCHXpWzRGLw8V8T4+mIVp/iT3GyE2kvxmky2ITIIL4SJz5jwYhs6zL7DssSPPC1f8
 FlThElV4FHvWECJ6kfLKmhFeSVXSjuUxKGYO8V/e1G0hMyARrrr6v32ypyLr1XUKEFhcX
 gICf8DEt+Jehjg0nvlJWlsFFDqkPp3rR7Pk8yqJk9CUlzCco5I06FHApL5lMQrvsupw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792397316;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
 bh=BA8lvnyHbrX/wQGD9PCO40NR36rEcAeHYhBqzHs2yQI=;
 b=q/7xZ6qVXWqIaRJkP3yKbcZOsFtl9NUA+QXV43vbpIerUFyxDcBnYc/iLrTaPvx/6O5t
 AGUPkhiSKfq8NFX6ePFRcYIVEvAP+V0oGL1VIACV1qQgQcyYIqKObbNWGOrwAF2N4IFdg
 aeGv3dYNjEwlsIOJqVFivwNoOPpyC0ttbhUnZ7Rg0+rhkhtknPbaWs2EqdaMr1j1CDu5Z
 Dy3XA57mbHWBceXMLPjulU4cjCNBRW9DlmH5djEjjdFbtAFephXJFWO3tqmBNmawW7oQz
 kPVx/ZRiYY2QrLxtY01eEfshhRqqvo0uuu/ChiCY1y0HoAUQdxBKGauixNS0Dwr7Scg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=bLnIBW2g; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=bLnIBW2g
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 611D460606
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:08:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1792397295; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=bJcIkBv/IukCgh6CEXkKFcoe3w9IDivxkLZznMg0RrHjpEsPR2JS/Ojepyl5IRhizOwg9AR8Y+d9sS9DiXmRMBsGjxP4QX9QY0/upzIReyrwlru1OMmB/rfXgHREKFAFPQ3GzcTZZuCMypOXSNs7xz70RYgDEiU6N4bLZbDg/jk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1792397295;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=BA8lvnyHbrX/wQGD9PCO40NR36rEcAeHYhBqzHs2yQI=; 
 b=Bviju/oGsN5MQH5Z9gaBw36gPIC9XBAmZMjN68Yk0GWa/UvZtWV57LwjvgqqnTLrVv3Y1kN3dnsjA7pqTHtNVHER/VjpnE4JTRa7gviJI64U/kqG0O3TCgJ2MGiJzCzZ+XgSv+AVk+vPh1cDwPIuxOzZd9gcypUOj8vD2fKXOgo=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792397295; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=BA8lvnyHbrX/wQGD9PCO40NR36rEcAeHYhBqzHs2yQI=;
 b=bLnIBW2gDkKcJA/xIOvdjLRxAtponAXP72eXYrjyv1iyzRcndQIwEvWwrGY5IjZo
 7ktPEiNqqQUVzOQkz8nN9T1XlPRMV4Jw5JmwoShDXvJ6FQVGZ+O61YVx1pMLI6L6YHa
 B53U6mZYyU0wIynHkw7nPwZHbJ0oEV5lPp6GjVhI=
Received: by smtp.zohomail.com with SMTPS id 1792397293126291.5664212536915;
 Mon, 19 Oct 2026 01:08:13 -0700 (PDT)
Date: Mon, 19 Oct 2026 08:08:00 +0000
From: Yao Zi <me@ziyao.cc>
To: Hiago De Franco <hfranco@baylibre.com>, u-boot@lists.u-boot-project.org,
 Yao Zi <me@ziyao.cc>
Cc: Kongyang Liu <seashell11234455@gmail.com>,
 Tom Rini <trini@konsulko.com>, Zhuxu Ran <zhuxu_ran@zohomail.com>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>
Subject: Re: [PATCH v2 0/3] board: sophgo: milkv_duo: enable standard boot
Message-ID: <atXP4EoaPk6ydwCa@pie>
References: <20261009-milkv-duo-bootstd-v2-0-c4679e726d10@baylibre.com>
 <atPXMIVNYWOKWJPm@hiagonb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atPXMIVNYWOKWJPm@hiagonb>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/292.376.41
X-ZohoMailClient: External
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

On Sat, Oct 17, 2026 at 05:17:11PM -0300, Hiago De Franco wrote:
> Hi Yao Zi,
> 
> On Fri, Oct 09, 2026 at 11:58:21AM -0300, Hiago De Franco wrote:
> > The Milk-V Duo (CV1800B, 64MB) does not enable CONFIG_BOOTSTD_DEFAULTS
> > and has no environment file, so U-Boot has no bootcmd and none of the
> > kernel_addr_r, fdt_addr_r, ramdisk_addr_r, ... variables required by
> > the extlinux bootmeth.
> > 
> > Enable CONFIG_BOOTSTD_DEFAULTS and add a milkv_duo.env with a memory
> > layout that fits into the 64MB of DRAM:
> > 
> >   0x80200000  kernel_addr_r       (16MB)
> >   0x81200000  kernel_comp_addr_r  (16MB, Image.gz decompression)
> >   0x82200000  fdt_addr_r
> >   0x82300000  scriptaddr
> >   0x82400000  pxefile_addr_r
> >   0x82500000  ramdisk_addr_r
> > 
> > Also reduce CONFIG_STACK_SIZE to 1MB. LMB reserves CONFIG_STACK_SIZE
> > below the relocated stack pointer, and the default 16MB left only about
> > 1.4MB between ramdisk_addr_r and the reserved region. With 1MB, about
> > 16MB are available for an initrd.
> > 
> > This series depends on Zhuxu Ran's "riscv: sophgo: Use upstream
> > devicetrees for CV18xx boards" (v5), which sets CONFIG_DEFAULT_DEVICE_TREE
> > to sophgo/<board>, so that fdtfile matches the Linux devicetree install
> > path (sophgo/cv1800b-milkv-duo.dtb and sophgo/sg2002-milkv-duo256m.dtb).
> > 
> > Link: https://lore.kernel.org/all/20260927-milkv-duo-upstream-dts-v5-0-7f64983e59e1@zohomail.com/
> > 
> > Tested on Milk-V Duo, booting Linux through "bootflow scan" and an
> > extlinux.conf on the SD card.
> > 
> > Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
> 
> just a ping about this patch, I do not know if it was picked
> yet or If I should wait and rebase on v2027.01-rc1. Can you help please?

I'm only reviewer of the RISC-V architecture, and don't help with picking
patches etc :)

And I think the series (Zhuxu's one) on which it depends hasn't been merged
yet?

Best regards,
Yao Zi
